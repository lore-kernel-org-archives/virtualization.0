From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 25/75] x86/fpu: Move xgetbv()/xsetbv() into separate header
Date: Tue, 14 Jul 2020 14:08:27 +0200
Message-ID: <20200714120917.11253-26-joro@8bytes.org>
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

The xgetbv() function is needed in pre-decompression boot code, but
asm/fpu/internal.h can't be included there directly. Doing so opens
the door to include-hell due to various include-magic in
boot/compressed/misc.h.

Avoid that by moving xgetbv()/xsetbv() to a separate header file and
include this instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/fpu/internal.h | 33 +------------------------
 arch/x86/include/asm/fpu/xcr.h      | 37 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 32 deletions(-)
 create mode 100644 arch/x86/include/asm/fpu/xcr.h

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 845e7481ab77..1c724bbace04 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -19,6 +19,7 @@
 #include <asm/user.h>
 #include <asm/fpu/api.h>
 #include <asm/fpu/xstate.h>
+#include <asm/fpu/xcr.h>
 #include <asm/cpufeature.h>
 #include <asm/trace/fpu.h>
 
@@ -619,36 +620,4 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
 	__write_pkru(pkru_val);
 }
 
-/*
- * MXCSR and XCR definitions:
- */
-
-static inline void ldmxcsr(u32 mxcsr)
-{
-	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
-}
-
-extern unsigned int mxcsr_feature_mask;
-
-#define XCR_XFEATURE_ENABLED_MASK	0x00000000
-
-static inline u64 xgetbv(u32 index)
-{
-	u32 eax, edx;
-
-	asm volatile(".byte 0x0f,0x01,0xd0" /* xgetbv */
-		     : "=a" (eax), "=d" (edx)
-		     : "c" (index));
-	return eax + ((u64)edx << 32);
-}
-
-static inline void xsetbv(u32 index, u64 value)
-{
-	u32 eax = value;
-	u32 edx = value >> 32;
-
-	asm volatile(".byte 0x0f,0x01,0xd1" /* xsetbv */
-		     : : "a" (eax), "d" (edx), "c" (index));
-}
-
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/include/asm/fpu/xcr.h b/arch/x86/include/asm/fpu/xcr.h
new file mode 100644
index 000000000000..d8e8fafebfdc
--- /dev/null
+++ b/arch/x86/include/asm/fpu/xcr.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_FPU_XCR_H
+#define _ASM_X86_FPU_XCR_H
+
+/*
+ * MXCSR and XCR definitions:
+ */
+
+static inline void ldmxcsr(u32 mxcsr)
+{
+	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
+}
+
+extern unsigned int mxcsr_feature_mask;
+
+#define XCR_XFEATURE_ENABLED_MASK	0x00000000
+
+static inline u64 xgetbv(u32 index)
+{
+	u32 eax, edx;
+
+	asm volatile(".byte 0x0f,0x01,0xd0" /* xgetbv */
+		     : "=a" (eax), "=d" (edx)
+		     : "c" (index));
+	return eax + ((u64)edx << 32);
+}
+
+static inline void xsetbv(u32 index, u64 value)
+{
+	u32 eax = value;
+	u32 edx = value >> 32;
+
+	asm volatile(".byte 0x0f,0x01,0xd1" /* xsetbv */
+		     : : "a" (eax), "d" (edx), "c" (index));
+}
+
+#endif /* _ASM_X86_FPU_XCR_H */
-- 
2.27.0
