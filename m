From: Thomas Garnier <thgarnie@chromium.org>
Subject: [PATCH v11 10/11] x86/paravirt: Adapt assembly for PIE support
Date: Thu, 27 Feb 2020 16:00:55 -0800
Message-ID: <20200228000105.165012-11-thgarnie@chromium.org>
References: <20200228000105.165012-1-thgarnie@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228000105.165012-1-thgarnie@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-hardening@lists.openwall.com
Cc: kristen@linux.intel.com, keescook@chromium.org, Thomas Garnier <thgarnie@chromium.org>, Juergen Gross <jgross@suse.com>, Thomas Hellstrom <thellstrom@vmware.com>, "VMware, Inc." <pv-drivers@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

If PIE is enabled, switch the paravirt assembly constraints to be
compatible. The %c/i constrains generate smaller code so is kept by
default.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Acked-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h | 32 +++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 84812964d3dd..82f7ca22e0ae 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -336,9 +336,32 @@ extern struct paravirt_patch_template pv_ops;
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
 
+#ifdef CONFIG_X86_PIE
+#define paravirt_opptr_call "a"
+#define paravirt_opptr_type "p"
+
+/*
+ * Alternative patching requires a maximum of 7 bytes but the relative call is
+ * only 6 bytes. If PIE is enabled, add an additional nop to the call
+ * instruction to ensure patching is possible.
+ *
+ * Without PIE, the call is reg/mem64:
+ * ff 14 25 68 37 02 82    callq  *0xffffffff82023768
+ *
+ * With PIE, it is relative to %rip and take 1-less byte:
+ * ff 15 fa d9 ff 00       callq  *0xffd9fa(%rip) # <pv_ops+0x30>
+ *
+ */
+#define PARAVIRT_CALL_POST  "nop;"
+#else
+#define paravirt_opptr_call "c"
+#define paravirt_opptr_type "i"
+#define PARAVIRT_CALL_POST  ""
+#endif
+
 #define paravirt_type(op)				\
 	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
-	[paravirt_opptr] "i" (&(pv_ops.op))
+	[paravirt_opptr] paravirt_opptr_type (&(pv_ops.op))
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
@@ -377,9 +400,10 @@ int paravirt_disable_iospace(void);
  * offset into the paravirt_patch_template structure, and can therefore be
  * freely converted back into a structure offset.
  */
-#define PARAVIRT_CALL					\
-	ANNOTATE_RETPOLINE_SAFE				\
-	"call *%c[paravirt_opptr];"
+#define PARAVIRT_CALL						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%" paravirt_opptr_call "[paravirt_opptr];"	\
+	PARAVIRT_CALL_POST
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
-- 
2.25.1.481.gfbce0eb801-goog
