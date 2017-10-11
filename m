From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH v1 10/27] x86/boot/64: Adapt assembly for PIE support
Date: Wed, 11 Oct 2017 13:30:10 -0700
Message-ID: <20171011203027.11248-11-thgarnie__46196.7828371145$1509080211$gmane$org@google.com>
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

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Early at boot, the kernel is mapped at a temporary address while preparing
the page table. To know the changes needed for the page table with KASLR,
the boot code calculate the difference between the expected address of the
kernel and the one chosen by KASLR. It does not work with PIE because all
symbols in code are relatives. Instead of getting the future relocated
virtual address, you will get the current temporary mapping. The solution
is using global variables that will be relocated as expected.

Position Independent Executable (PIE) support will allow to extended the
KASLR randomization range below the -2G memory limit.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/kernel/head_64.S | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 42e32c2e51bb..32d1899f48df 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -86,8 +86,21 @@ startup_64:
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(early_top_pgt - __START_KERNEL_map), %rax
+	addq    _early_top_pgt_offset(%rip), %rax
 	jmp 1f
+
+	/*
+	 * Position Independent Code takes only relative references in code
+	 * meaning a global variable address is relative to RIP and not its
+	 * future virtual address. Global variables can be used instead as they
+	 * are still relocated on the expected kernel mapping address.
+	 */
+	.align 8
+_early_top_pgt_offset:
+	.quad early_top_pgt - __START_KERNEL_map
+_init_top_offset:
+	.quad init_top_pgt - __START_KERNEL_map
+
 ENTRY(secondary_startup_64)
 	UNWIND_HINT_EMPTY
 	/*
@@ -116,7 +129,7 @@ ENTRY(secondary_startup_64)
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(init_top_pgt - __START_KERNEL_map), %rax
+	addq    _init_top_offset(%rip), %rax
 1:
 
 	/* Enable PAE mode, PGE and LA57 */
@@ -131,7 +144,7 @@ ENTRY(secondary_startup_64)
 	movq	%rax, %cr3
 
 	/* Ensure I am executing from virtual addresses */
-	movq	$1f, %rax
+	movabs  $1f, %rax
 	jmp	*%rax
 1:
 	UNWIND_HINT_EMPTY
@@ -230,11 +243,12 @@ ENTRY(secondary_startup_64)
 	 *	REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
 	 *		address given in m16:64.
 	 */
-	pushq	$.Lafter_lret	# put return address on stack for unwinder
+	leaq	.Lafter_lret(%rip), %rax
+	pushq	%rax		# put return address on stack for unwinder
 	xorq	%rbp, %rbp	# clear frame pointer
-	movq	initial_code(%rip), %rax
+	leaq	initial_code(%rip), %rax
 	pushq	$__KERNEL_CS	# set correct cs
-	pushq	%rax		# target address in negative space
+	pushq	(%rax)		# target address in negative space
 	lretq
 .Lafter_lret:
 END(secondary_startup_64)
-- 
2.15.0.rc0.271.g36b669edcc-goog
