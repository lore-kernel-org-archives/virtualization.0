From: Andy Lutomirski <luto@mit.edu>
Subject: [PATCH v2 2/6] x86-64: Move the "user" vsyscall segment out of the
	data segment.
Date: Wed,  3 Aug 2011 09:31:50 -0400
Message-ID: <f0716870c297242a841b949953d80c0d87bf3d3f.1312378163.git.luto__38518.9565750354$1312378567$gmane$org@mit.edu>
References: <cover.1312378163.git.luto@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1312378163.git.luto@mit.edu>
In-Reply-To: <cover.1312378163.git.luto@mit.edu>
References: <cover.1312378163.git.luto@mit.edu>
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

The kernel's loader doesn't seem to care, but gold complains.

Signed-off-by: Andy Lutomirski <luto@mit.edu>
Reported-by: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
---
 arch/x86/kernel/vmlinux.lds.S |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4aa9c54..e79fb39 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -154,6 +154,24 @@ SECTIONS
 
 #ifdef CONFIG_X86_64
 
+	. = ALIGN(PAGE_SIZE);
+	__vvar_page = .;
+
+	.vvar : AT(ADDR(.vvar) - LOAD_OFFSET) {
+
+	      /* Place all vvars at the offsets in asm/vvar.h. */
+#define EMIT_VVAR(name, offset) 		\
+		. = offset;		\
+		*(.vvar_ ## name)
+#define __VVAR_KERNEL_LDS
+#include <asm/vvar.h>
+#undef __VVAR_KERNEL_LDS
+#undef EMIT_VVAR
+
+	} :data
+
+       . = ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
+
 #define VSYSCALL_ADDR (-10*1024*1024)
 
 #define VLOAD_OFFSET (VSYSCALL_ADDR - __vsyscall_0 + LOAD_OFFSET)
@@ -162,7 +180,6 @@ SECTIONS
 #define VVIRT_OFFSET (VSYSCALL_ADDR - __vsyscall_0)
 #define VVIRT(x) (ADDR(x) - VVIRT_OFFSET)
 
-	. = ALIGN(4096);
 	__vsyscall_0 = .;
 
 	. = VSYSCALL_ADDR;
@@ -185,23 +202,6 @@ SECTIONS
 #undef VVIRT_OFFSET
 #undef VVIRT
 
-	__vvar_page = .;
-
-	.vvar : AT(ADDR(.vvar) - LOAD_OFFSET) {
-
-	      /* Place all vvars at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset) 		\
-		. = offset;		\
-		*(.vvar_ ## name)
-#define __VVAR_KERNEL_LDS
-#include <asm/vvar.h>
-#undef __VVAR_KERNEL_LDS
-#undef EMIT_VVAR
-
-	} :data
-
-       . = ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
-
 #endif /* CONFIG_X86_64 */
 
 	/* Init code and data - will be freed after init */
-- 
1.7.6
