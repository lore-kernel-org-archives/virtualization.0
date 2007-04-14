From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 10/28] i386: map enough initial memory to create lowmem
	mappings
Date: Sat, 14 Apr 2007 13:42:04 -0700
Message-ID: <20070414204924.125386443@goop.org>
References: <20070414204154.871250608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=x86-map-enough-initial-memory.patch
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
Cc: virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, Chris Wright <chrisw@sous-sol.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

head.S creates the very initial pagetable for the kernel.  This just
maps enough space for the kernel itself, and an allocation bitmap.
The amount of mapped memory is rounded up to 4Mbytes, and so this
typically ends up mapping 8Mbytes of memory.

When booting, pagetable_init() needs to create mappings for all
lowmem, and the pagetables for these mappings are allocated from the
free pages around the kernel in low memory.  If the number of
pagetable pages + kernel size exceeds head.S's initial mapping, it
will end up faulting on an unmapped page.  This will only happen with
specific combinations of kernel size and memory size.

This patch makes sure that head.S also maps enough space to fit the
kernel pagetables as well as the kernel itself.  It ends up using an
additional two pages of unreclaimable memory.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Acked-by: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@suse.de>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,

---
 arch/i386/kernel/asm-offsets.c |    6 ++++++
 arch/i386/kernel/head.S        |   25 ++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/asm-offsets.c
+++ b/arch/i386/kernel/asm-offsets.c
@@ -11,6 +11,7 @@
 #include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include "sigframe.h"
+#include <asm/pgtable.h>
 #include <asm/fixmap.h>
 #include <asm/processor.h>
 #include <asm/thread_info.h>
@@ -96,6 +97,11 @@ void foo(void)
 		 sizeof(struct tss_struct));
 =

 	DEFINE(PAGE_SIZE_asm, PAGE_SIZE);
+	DEFINE(PAGE_SHIFT_asm, PAGE_SHIFT);
+	DEFINE(PTRS_PER_PTE, PTRS_PER_PTE);
+	DEFINE(PTRS_PER_PMD, PTRS_PER_PMD);
+	DEFINE(PTRS_PER_PGD, PTRS_PER_PGD);
+
 	DEFINE(VDSO_PRELINK_asm, VDSO_PRELINK);
 =

 	OFFSET(crypto_tfm_ctx_offset, crypto_tfm, __crt_ctx);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -34,17 +34,32 @@
 =

 /*
  * This is how much memory *in addition to the memory covered up to
- * and including _end* we need mapped initially.  We need one bit for
- * each possible page, but only in low memory, which means
- * 2^32/4096/8 =3D 128K worst case (4G/4G split.)
+ * and including _end* we need mapped initially.
+ * We need:
+ *  - one bit for each possible page, but only in low memory, which means
+ *     2^32/4096/8 =3D 128K worst case (4G/4G split.)
+ *  - enough space to map all low memory, which means
+ *     (2^32/4096) / 1024 pages (worst case, non PAE)
+ *     (2^32/4096) / 512 + 4 pages (worst case for PAE)
+ *  - a few pages for allocator use before the kernel pagetable has
+ *     been set up
  *
  * Modulo rounding, each megabyte assigned here requires a kilobyte of
  * memory, which is currently unreclaimed.
  *
  * This should be a multiple of a page.
  */
-#define INIT_MAP_BEYOND_END	(128*1024)
-
+LOW_PAGES =3D 1<<(32-PAGE_SHIFT_asm)
+
+#if PTRS_PER_PMD > 1
+PAGE_TABLE_SIZE =3D (LOW_PAGES / PTRS_PER_PMD) + PTRS_PER_PGD
+#else
+PAGE_TABLE_SIZE =3D (LOW_PAGES / PTRS_PER_PGD)
+#endif
+BOOTBITMAP_SIZE =3D LOW_PAGES / 8
+ALLOCATOR_SLOP =3D 4
+
+INIT_MAP_BEYOND_END =3D BOOTBITMAP_SIZE + (PAGE_TABLE_SIZE + ALLOCATOR_SLO=
P)*PAGE_SIZE_asm
 =

 /*
  * 32-bit kernel entrypoint; only used by the boot CPU.  On entry,

-- =
