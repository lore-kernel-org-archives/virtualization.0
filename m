From: Andy Lutomirski <luto@mit.edu>
Subject: [PATCH 3/5] x86-64: Work around gold bug 13023
Date: Tue, 26 Jul 2011 23:20:37 -0400
Message-ID: <754803d081d19d257f44c5f4eee309e353ef4d4c.1311736366.git.luto__49148.7394473099$1311739970$gmane$org@mit.edu>
References: <cover.1311736366.git.luto@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1311736366.git.luto@mit.edu>
In-Reply-To: <cover.1311736366.git.luto@mit.edu>
References: <cover.1311736366.git.luto@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com, Andy Lutomirski <luto@mit.edu>
List-Id: virtualization@lists.linuxfoundation.org

Gold has trouble assigning numbers to the location counter inside of
an output section description.  The bug was triggered by
9fd67b4ed0714ab718f1f9bd14c344af336a6df7, which consolidated all of
the vsyscall sections into a single section.  The workaround is IMO
still nicer than the old way of doing it.

This produces an apparently valid kernel image and passes my vdso
tests on both GNU ld version 2.21.51.0.6-2.fc15 20110118 and GNU
gold (version 2.21.51.0.6-2.fc15 20110118) 1.10 as distributed by
Fedora 15.

Signed-off-by: Andy Lutomirski <luto@mit.edu>
Reported-by: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
---
 arch/x86/kernel/vmlinux.lds.S |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e79fb39..8f3a265 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -158,10 +158,12 @@ SECTIONS
 	__vvar_page = .;
 
 	.vvar : AT(ADDR(.vvar) - LOAD_OFFSET) {
+		/* work around gold bug 13023 */
+		__vvar_beginning_hack = .;
 
-	      /* Place all vvars at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset) 		\
-		. = offset;		\
+		/* Place all vvars at the offsets in asm/vvar.h. */
+#define EMIT_VVAR(name, offset) 			\
+		. = __vvar_beginning_hack + offset;	\
 		*(.vvar_ ## name)
 #define __VVAR_KERNEL_LDS
 #include <asm/vvar.h>
@@ -184,15 +186,17 @@ SECTIONS
 
 	. = VSYSCALL_ADDR;
 	.vsyscall : AT(VLOAD(.vsyscall)) {
+		/* work around gold bug 13023 */
+		__vsyscall_beginning_hack = .;
 		*(.vsyscall_0)
 
-		. = 1024;
+		. = __vsyscall_beginning_hack + 1024;
 		*(.vsyscall_1)
 
-		. = 2048;
+		. = __vsyscall_beginning_hack + 2048;
 		*(.vsyscall_2)
 
-		. = 4096;  /* Pad the whole page. */
+		. = __vsyscall_beginning_hack + 4096;  /* Pad the whole page. */
 	} :user =0xcc
 	. = ALIGN(__vsyscall_0 + PAGE_SIZE, PAGE_SIZE);
 
-- 
1.7.6
