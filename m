From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH v1 20/27] x86/ftrace: Adapt function tracing for PIE support
Date: Wed, 11 Oct 2017 13:30:20 -0700
Message-ID: <20171011203027.11248-21-thgarnie__28356.5782396638$1509080321$gmane$org@google.com>
References: <20171011203027.11248-1-thgarnie@google.com>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171011203027.11248-1-thgarnie@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Garnier <thgarnie@google.com>, Kees Cook <keescook@chromium.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Matthias Kaehlcke <mka@chromium.org>, Tom Lendacky <thomas.lendacky@amd.com>, Andy Lutomirski <luto@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Juergen Gross <jgross@suse.com>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Tejun Heo <tj@kernel.>
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sparse@vger.kernel.org, linux-crypto@vger.kernel.org, kernel-hardening@lists.openwall.com, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

When using -fPIE/PIC with function tracing, the compiler generates a
call through the GOT (call *__fentry__@GOTPCREL). This instruction
takes 6 bytes instead of 5 on the usual relative call.

If PIE is enabled, replace the 6th byte of the GOT call by a 1-byte nop
so ftrace can handle the previous 5-bytes as before.

Position Independent Executable (PIE) support will allow to extended the
KASLR randomization range below the -2G memory limit.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/ftrace.h   |  6 ++++--
 arch/x86/include/asm/sections.h |  4 ++++
 arch/x86/kernel/ftrace.c        | 42 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index eccd0ac6bc38..183990157a5e 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -24,9 +24,11 @@ extern void __fentry__(void);
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	/*
-	 * addr is the address of the mcount call instruction.
-	 * recordmcount does the necessary offset calculation.
+	 * addr is the address of the mcount call instruction. PIE has always a
+	 * byte added to the start of the function.
 	 */
+	if (IS_ENABLED(CONFIG_X86_PIE))
+		addr -= 1;
 	return addr;
 }
 
diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 2f75f30cb2f6..6b2d496cf1aa 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -11,4 +11,8 @@ extern struct exception_table_entry __stop___ex_table[];
 extern char __end_rodata_hpage_align[];
 #endif
 
+#if defined(CONFIG_X86_PIE)
+extern char __start_got[], __end_got[];
+#endif
+
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 9bef1bbeba63..a253601e783b 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -101,7 +101,7 @@ static const unsigned char *ftrace_nop_replace(void)
 
 static int
 ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
-		   unsigned const char *new_code)
+			  unsigned const char *new_code)
 {
 	unsigned char replaced[MCOUNT_INSN_SIZE];
 
@@ -134,6 +134,44 @@ ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
 	return 0;
 }
 
+/* Bytes before call GOT offset */
+const unsigned char got_call_preinsn[] = { 0xff, 0x15 };
+
+static int
+ftrace_modify_initial_code(unsigned long ip, unsigned const char *old_code,
+			   unsigned const char *new_code)
+{
+	unsigned char replaced[MCOUNT_INSN_SIZE + 1];
+
+	ftrace_expected = old_code;
+
+	/*
+	 * If PIE is not enabled or no GOT call was found, default to the
+	 * original approach to code modification.
+	 */
+	if (!IS_ENABLED(CONFIG_X86_PIE)
+	    || probe_kernel_read(replaced, (void *)ip, sizeof(replaced))
+	    || memcmp(replaced, got_call_preinsn, sizeof(got_call_preinsn)))
+		return ftrace_modify_code_direct(ip, old_code, new_code);
+
+	/*
+	 * Build a nop slide with a 5-byte nop and 1-byte nop to keep the ftrace
+	 * hooking algorithm working with the expected 5 bytes instruction.
+	 */
+	memcpy(replaced, new_code, MCOUNT_INSN_SIZE);
+	replaced[MCOUNT_INSN_SIZE] = ideal_nops[1][0];
+
+	ip = text_ip_addr(ip);
+
+	if (probe_kernel_write((void *)ip, replaced, sizeof(replaced)))
+		return -EPERM;
+
+	sync_core();
+
+	return 0;
+
+}
+
 int ftrace_make_nop(struct module *mod,
 		    struct dyn_ftrace *rec, unsigned long addr)
 {
@@ -152,7 +190,7 @@ int ftrace_make_nop(struct module *mod,
 	 * just modify the code directly.
 	 */
 	if (addr == MCOUNT_ADDR)
-		return ftrace_modify_code_direct(rec->ip, old, new);
+		return ftrace_modify_initial_code(rec->ip, old, new);
 
 	ftrace_expected = NULL;
 
-- 
2.15.0.rc0.271.g36b669edcc-goog
