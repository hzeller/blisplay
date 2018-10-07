// (c) H. Zeller <h.zeller@acm.org> 2018
// Kicad Coil generator script.
#include <stdio.h>
#include <time.h>
#include <math.h>

static constexpr char kHeaderFmt[] = R"(
(module "%s" (layer F.Cu) (tedit %X)
  (fp_text reference I*** (at 0 0) (layer F.SilkS) hide
    (effects (font (thickness 0.3)))
  )
  (fp_text value "%s" (at 0 -2.54) (layer F.SilkS) hide
    (effects (font (thickness 0.3)))
  )
)";

static double total_len = 0;
static double sq(double x) { return x*x;}

static void Line(double x1, double y1, double x2, double y2,
                 const char *layer, double width) {
    printf("  (fp_line (start %.3f %.3f) (end %.3f %.3f) (layer %s) (width %.3f))\n",
           x1, y1, x2, y2, layer, width);
    total_len += sqrt(sq(x2-x1) + sq(y2-y1));
}

static void Via(double x, double y, double size) {
    printf("  (pad \"\" thru_hole circle (at %.3f %.3f) (size %.3f %.3f) (drill 0.4) (layers *.Cu) (zone_connect 2))\n",
           x, y, size, size);
}
static void SmdPad(double x, double y, double w, double h, int label, const char *layer) {
    printf("  (pad %d smd rect (at %.3f %.3f) (size %.3f %.3f) (layers %s))\n",
           label, x, y, w, h, layer);
}

static void Loop(double w, double h, const char *layer, double width, double space) {
    double dx = w/2;
    double dy = h/2;
    double c = width;
    Line(dx, 0, dx, dy-c, layer, width);    // down
    Line(dx, dy-c, dx-c, dy, layer, width);

    Line(dx-c, dy, -dx+c, dy, layer, width);
    Line(-dx+c, dy, -dx, dy-c, layer, width);
    Line(-dx, dy-c, -dx, -dy+c, layer, width);
    Line(-dx, -dy+c, -dx+c, -dy, layer, width);
    Line(-dx+c, -dy, dx-space-c, -dy, layer, width);

    Line(dx-space-c, -dy, dx-space, -dy+c, layer, width);

    Line(dx-space, -dy+c, dx-space, 0, layer, width);
}

int main() {
    const char *name = "Coil";
    printf(kHeaderFmt, name, (unsigned) time(NULL), name);

    int N = 18;
    double w = 19;
    double h = 18;
    double trace_w = 0.2;
    double space = trace_w + 0.2;
    double via_dia = 0.8;
    double pad_dia = 0.4;

    SmdPad(w/2+pad_dia/2-trace_w/2, 1-trace_w, pad_dia, 2.0, 1, "F.Cu");
    SmdPad(w/2+pad_dia/2-trace_w/2, -1+trace_w, pad_dia, 2.0, 2, "B.Cu");

    for (int i = 0; i < N; ++i) {    // Front copper
        Loop(w, h, "F.Cu", trace_w, space);
        w -= 2*space;
        h -= 2*space;
    }

    Line(w/2, 0, w/2-via_dia/2, 0, "F.Cu", trace_w);
    Via(w/2-via_dia/2+trace_w/2, 0, via_dia);
    Line(w/2-via_dia/2, 0, w/2, 0, "B.Cu", trace_w);

    for (int i = 0; i < N; ++i) {    // Bottom copper
        Loop(w, h, "B.Cu", trace_w, -space);
        w += 2*space;
        h += 2*space;
    }

    printf(")\n");
    fprintf(stderr, "Coil body = %d * %.3fmm = %.3fmm; "
            "average coil-width: %.2fmm; total len: %.3f\n",
            N, space, N * space, w - N/2*space, total_len);
}
