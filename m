From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [RFC v3 04/27] x86: Add macro to get symbol address for PIE support
Date: Wed,  4 Oct 2017 14:19:40 -0700
Message-ID: <20171004212003.28296-5-thgarnie__16460.2935933091$1509079767$gmane$org@google.com>
References: <20171004212003.28296-1-thgarnie@google.com>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171004212003.28296-1-thgarnie@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Garnier <thgarnie@google.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Tom Lendacky <thomas.lendacky@amd.com>, Andy Lutomirski <luto@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Juergen Gross <jgross@suse.com>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>Bor
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sparse@vger.kernel.org, linux-crypto@vger.kernel.org, kernel-hardening@lists.openwall.com, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

Add a new _ASM_GET_PTR macro to fetch a symbol address. It will be used
to replace "_ASM_MOV $<symbol>, %dst" code construct that are not compatible
with PIE.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/asm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index c1eadbaf1115..dddcb8a3b777 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -55,6 +55,19 @@
 # define CC_OUT(c) [_cc_ ## c] "=qm"
 #endif
 
+/* Macros to get a global variable address with PIE support on 64-bit */
+#ifdef CONFIG_X86_32
+#define __ASM_GET_PTR_PRE(_src) __ASM_FORM_COMMA(movl $##_src)
+#else
+#ifdef __ASSEMBLY__
+#define __ASM_GET_PTR_PRE(_src) __ASM_FORM_COMMA(leaq (_src)(%rip))
+#else
+#define __ASM_GET_PTR_PRE(_src) __ASM_FORM_COMMA(leaq (_src)(%%rip))
+#endif
+#endif
+#define _ASM_GET_PTR(_src, _dst) \
+		__ASM_GET_PTR_PRE(_src) __ASM_FORM(_dst)
+
 /* Exception table entry */
 #ifdef __ASSEMBLY__
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
-- 
2.14.2.920.gcf0c67979c-goog
