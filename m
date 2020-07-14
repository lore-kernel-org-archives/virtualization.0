From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 05/75] x86/traps: Move pf error codes to <asm/trap_pf.h>
Date: Tue, 14 Jul 2020 14:08:07 +0200
Message-ID: <20200714120917.11253-6-joro@8bytes.org>
References: <20200714120917.11253-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200714120917.11253-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>, virtualization@lists.linux-foundation.org, Martin Radev <martin.b.radev@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Move the definition of the x86 page-fault error code bits to the new
header file asm/trap_pf.h. This makes it easier to include them into
pre-decompression boot code. No functional changes.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/trap_pf.h | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/traps.h   | 19 +------------------
 2 files changed, 25 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/include/asm/trap_pf.h

diff --git a/arch/x86/include/asm/trap_pf.h b/arch/x86/include/asm/trap_pf.h
new file mode 100644
index 000000000000..305bc1214aef
--- /dev/null
+++ b/arch/x86/include/asm/trap_pf.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_TRAP_PF_H
+#define _ASM_X86_TRAP_PF_H
+
+/*
+ * Page fault error code bits:
+ *
+ *   bit 0 ==	 0: no page found	1: protection fault
+ *   bit 1 ==	 0: read access		1: write access
+ *   bit 2 ==	 0: kernel-mode access	1: user-mode access
+ *   bit 3 ==				1: use of reserved bit detected
+ *   bit 4 ==				1: fault was an instruction fetch
+ *   bit 5 ==				1: protection keys block access
+ */
+enum x86_pf_error_code {
+	X86_PF_PROT	=		1 << 0,
+	X86_PF_WRITE	=		1 << 1,
+	X86_PF_USER	=		1 << 2,
+	X86_PF_RSVD	=		1 << 3,
+	X86_PF_INSTR	=		1 << 4,
+	X86_PF_PK	=		1 << 5,
+};
+
+#endif /* _ASM_X86_TRAP_PF_H */
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 714b1a30e7b0..6a308355ea29 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -8,6 +8,7 @@
 #include <asm/debugreg.h>
 #include <asm/idtentry.h>
 #include <asm/siginfo.h>			/* TRAP_TRACE, ... */
+#include <asm/trap_pf.h>
 
 #ifdef CONFIG_X86_64
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
@@ -41,22 +42,4 @@ void __noreturn handle_stack_overflow(const char *message,
 				      unsigned long fault_address);
 #endif
 
-/*
- * Page fault error code bits:
- *
- *   bit 0 ==	 0: no page found	1: protection fault
- *   bit 1 ==	 0: read access		1: write access
- *   bit 2 ==	 0: kernel-mode access	1: user-mode access
- *   bit 3 ==				1: use of reserved bit detected
- *   bit 4 ==				1: fault was an instruction fetch
- *   bit 5 ==				1: protection keys block access
- */
-enum x86_pf_error_code {
-	X86_PF_PROT	=		1 << 0,
-	X86_PF_WRITE	=		1 << 1,
-	X86_PF_USER	=		1 << 2,
-	X86_PF_RSVD	=		1 << 3,
-	X86_PF_INSTR	=		1 << 4,
-	X86_PF_PK	=		1 << 5,
-};
 #endif /* _ASM_X86_TRAPS_H */
-- 
2.27.0
