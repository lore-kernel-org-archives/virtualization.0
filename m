From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 04/28] deflate stack usage in lib/inflate.c
Date: Sat, 14 Apr 2007 13:41:58 -0700
Message-ID: <20070414204923.672434775@goop.org>
References: <20070414204154.871250608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=deflate-stack-usage-in-lib_inflate_c.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Matt Mackall <mpm@selenic.com>, Ian Molton <spyro@f2s.com>, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, Tim Yamin <plasmaroo@gentoo.org>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

inflate_fixed and huft_build together use around 2.7k of stack.  When
using 4k stacks, I saw stack overflows from interrupts arriving while
unpacking the root initrd:

do_IRQ: stack overflow: 384
 [<c0106b64>] show_trace_log_lvl+0x1a/0x30
 [<c01075e6>] show_trace+0x12/0x14
 [<c010763f>] dump_stack+0x16/0x18
 [<c0107ca4>] do_IRQ+0x6d/0xd9
 [<c010202b>] xen_evtchn_do_upcall+0x6e/0xa2
 [<c0106781>] xen_hypervisor_callback+0x25/0x2c
 [<c010116c>] xen_restore_fl+0x27/0x29
 [<c0330f63>] _spin_unlock_irqrestore+0x4a/0x50
 [<c0117aab>] change_page_attr+0x577/0x584
 [<c0117b45>] kernel_map_pages+0x8d/0xb4
 [<c016a314>] cache_alloc_refill+0x53f/0x632
 [<c016a6c2>] __kmalloc+0xc1/0x10d
 [<c0463d34>] malloc+0x10/0x12
 [<c04641c1>] huft_build+0x2a7/0x5fa
 [<c04645a5>] inflate_fixed+0x91/0x136
 [<c04657e2>] unpack_to_rootfs+0x5f2/0x8c1
 [<c0465acf>] populate_rootfs+0x1e/0xe4

(This was under Xen, but there's no reason it couldn't happen on bare
  hardware.)

This patch mallocs the local variables, thereby reducing the stack
usage to sane levels.

Also, up the heap size for the kernel decompressor to deal with the
extra allocation.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Tim Yamin <plasmaroo@gentoo.org>
Cc: Andi Kleen <ak@suse.de>
Cc: Matt Mackall <mpm@selenic.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Ian Molton <spyro@f2s.com>

---
 arch/alpha/boot/misc.c             |    2 -
 arch/arm/boot/compressed/misc.c    |    2 -
 arch/arm26/boot/compressed/misc.c  |    2 -
 arch/i386/boot/compressed/misc.c   |    2 -
 arch/x86_64/boot/compressed/misc.c |    2 -
 lib/inflate.c                      |   66 ++++++++++++++++++++++++++------=
----
 6 files changed, 54 insertions(+), 22 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/alpha/boot/misc.c
+++ b/arch/alpha/boot/misc.c
@@ -98,7 +98,7 @@ static ulg free_mem_ptr;
 static ulg free_mem_ptr;
 static ulg free_mem_ptr_end;
 =

-#define HEAP_SIZE 0x2000
+#define HEAP_SIZE 0x3000
 =

 #include "../../../lib/inflate.c"
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -239,7 +239,7 @@ static ulg free_mem_ptr;
 static ulg free_mem_ptr;
 static ulg free_mem_ptr_end;
 =

-#define HEAP_SIZE 0x2000
+#define HEAP_SIZE 0x3000
 =

 #include "../../../../lib/inflate.c"
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/arm26/boot/compressed/misc.c
+++ b/arch/arm26/boot/compressed/misc.c
@@ -182,7 +182,7 @@ static ulg free_mem_ptr;
 static ulg free_mem_ptr;
 static ulg free_mem_ptr_end;
 =

-#define HEAP_SIZE 0x2000
+#define HEAP_SIZE 0x3000
 =

 #include "../../../../lib/inflate.c"
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/boot/compressed/misc.c
+++ b/arch/i386/boot/compressed/misc.c
@@ -189,7 +189,7 @@ static unsigned long free_mem_ptr;
 static unsigned long free_mem_ptr;
 static unsigned long free_mem_end_ptr;
 =

-#define HEAP_SIZE             0x3000
+#define HEAP_SIZE             0x4000
 =

 static char *vidmem =3D (char *)0xb8000;
 static int vidport;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/x86_64/boot/compressed/misc.c
+++ b/arch/x86_64/boot/compressed/misc.c
@@ -189,7 +189,7 @@ static long free_mem_ptr;
 static long free_mem_ptr;
 static long free_mem_end_ptr;
 =

-#define HEAP_SIZE             0x6000
+#define HEAP_SIZE             0x7000
 =

 static char *vidmem =3D (char *)0xb8000;
 static int vidport;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/lib/inflate.c
+++ b/lib/inflate.c
@@ -292,7 +292,6 @@ STATIC int INIT huft_build(
    oversubscribed set of lengths), and three if not enough memory. */
 {
   unsigned a;                   /* counter for codes of length k */
-  unsigned c[BMAX+1];           /* bit length count table */
   unsigned f;                   /* i repeats in table every f entries */
   int g;                        /* maximum code length */
   int h;                        /* table level */
@@ -303,18 +302,33 @@ STATIC int INIT huft_build(
   register unsigned *p;         /* pointer into c[], b[], or v[] */
   register struct huft *q;      /* points to current table */
   struct huft r;                /* table entry for structure assignment */
-  struct huft *u[BMAX];         /* table stack */
-  unsigned v[N_MAX];            /* values in order of bit length */
   register int w;               /* bits before this table =3D=3D (l * h) */
-  unsigned x[BMAX+1];           /* bit offsets, then code stack */
   unsigned *xp;                 /* pointer into x */
   int y;                        /* number of dummy codes added */
   unsigned z;                   /* number of entries in current table */
+  struct {
+    unsigned c[BMAX+1];           /* bit length count table */
+    struct huft *u[BMAX];         /* table stack */
+    unsigned v[N_MAX];            /* values in order of bit length */
+    unsigned x[BMAX+1];           /* bit offsets, then code stack */
+  } *stk;
+  unsigned *c, *v, *x;
+  struct huft **u;
+  int ret;
 =

 DEBG("huft1 ");
 =

+  stk =3D malloc(sizeof(*stk));
+  if (stk =3D=3D NULL)
+    return 3;			/* out of memory */
+
+  c =3D stk->c;
+  v =3D stk->v;
+  x =3D stk->x;
+  u =3D stk->u;
+
   /* Generate counts for each bit length */
-  memzero(c, sizeof(c));
+  memzero(stk->c, sizeof(stk->c));
   p =3D b;  i =3D n;
   do {
     Tracecv(*p, (stderr, (n-i >=3D ' ' && n-i <=3D '~' ? "%c %d\n" : "0x%x=
 %d\n"), =

@@ -326,7 +340,8 @@ DEBG("huft1 ");
   {
     *t =3D (struct huft *)NULL;
     *m =3D 0;
-    return 2;
+    ret =3D 2;
+    goto out;
   }
 =

 DEBG("huft2 ");
@@ -351,10 +366,14 @@ DEBG("huft3 ");
 =

   /* Adjust last length count to fill out codes, if needed */
   for (y =3D 1 << j; j < i; j++, y <<=3D 1)
-    if ((y -=3D c[j]) < 0)
-      return 2;                 /* bad input: more codes than bits */
-  if ((y -=3D c[i]) < 0)
-    return 2;
+    if ((y -=3D c[j]) < 0) {
+      ret =3D 2;                 /* bad input: more codes than bits */
+      goto out;
+    }
+  if ((y -=3D c[i]) < 0) {
+    ret =3D 2;
+    goto out;
+  }
   c[i] +=3D y;
 =

 DEBG("huft4 ");
@@ -428,7 +447,8 @@ DEBG1("3 ");
         {
           if (h)
             huft_free(u[0]);
-          return 3;             /* not enough memory */
+          ret =3D 3;             /* not enough memory */
+	  goto out;
         }
 DEBG1("4 ");
         hufts +=3D z + 1;         /* track memory usage */
@@ -492,7 +512,11 @@ DEBG("huft7 ");
 DEBG("huft7 ");
 =

   /* Return true (1) if we were given an incomplete table */
-  return y !=3D 0 && g !=3D 1;
+  ret =3D y !=3D 0 && g !=3D 1;
+
+  out:
+  free(stk);
+  return ret;
 }
 =

 =

@@ -705,9 +729,13 @@ STATIC int noinline INIT inflate_fixed(v
   struct huft *td;      /* distance code table */
   int bl;               /* lookup bits for tl */
   int bd;               /* lookup bits for td */
-  unsigned l[288];      /* length list for huft_build */
+  unsigned *l;          /* length list for huft_build */
 =

 DEBG("<fix");
+
+  l =3D malloc(sizeof(*l) * 288);
+  if (l =3D=3D NULL)
+    return 3;			/* out of memory */
 =

   /* set up literal table */
   for (i =3D 0; i < 144; i++)
@@ -719,9 +747,10 @@ DEBG("<fix");
   for (; i < 288; i++)          /* make a complete, but wrong code set */
     l[i] =3D 8;
   bl =3D 7;
-  if ((i =3D huft_build(l, 288, 257, cplens, cplext, &tl, &bl)) !=3D 0)
+  if ((i =3D huft_build(l, 288, 257, cplens, cplext, &tl, &bl)) !=3D 0) {
+    free(l);
     return i;
-
+  }
 =

   /* set up distance table */
   for (i =3D 0; i < 30; i++)      /* make an incomplete code set */
@@ -730,6 +759,7 @@ DEBG("<fix");
   if ((i =3D huft_build(l, 30, 0, cpdist, cpdext, &td, &bd)) > 1)
   {
     huft_free(tl);
+    free(l);
 =

     DEBG(">");
     return i;
@@ -737,11 +767,13 @@ DEBG("<fix");
 =

 =

   /* decompress until an end-of-block code */
-  if (inflate_codes(tl, td, bl, bd))
+  if (inflate_codes(tl, td, bl, bd)) {
+    free(l);
     return 1;
-
+  }
 =

   /* free the decoding tables, return */
+  free(l);
   huft_free(tl);
   huft_free(td);
   return 0;

-- =
