From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 27/62] x86/head/64: Load segment registers earlier
Date: Tue, 11 Feb 2020 14:52:21 +0100
Message-ID: <20200211135256.24617-28-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
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
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Joerg Roedel <jroedel@suse.de>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Make sure segments are properly set up before setting up an IDT and
doing anything that might cause a #VC exception. This is later needed
for early exception handling.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/head_64.S | 52 +++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index a3a9383e8dd6..36f2f30ad200 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -162,6 +162,32 @@ SYM_CODE_START(secondary_startup_64)
 	movq	%rax, boot_gdt_base(%rip)
 	lgdt	boot_gdt_descr(%rip)
 
+	/* set up data segments */
+	xorl %eax,%eax
+	movl %eax,%ds
+	movl %eax,%ss
+	movl %eax,%es
+
+	/*
+	 * We don't really need to load %fs or %gs, but load them anyway
+	 * to kill any stale realmode selectors.  This allows execution
+	 * under VT hardware.
+	 */
+	movl %eax,%fs
+	movl %eax,%gs
+
+	/* Set up %gs.
+	 *
+	 * The base of %gs always points to fixed_percpu_data. If the
+	 * stack protector canary is enabled, it is located at %gs:40.
+	 * Note that, on SMP, the boot cpu uses init data section until
+	 * the per cpu areas are set up.
+	 */
+	movl	$MSR_GS_BASE,%ecx
+	movl	initial_gs(%rip),%eax
+	movl	initial_gs+4(%rip),%edx
+	wrmsr
+
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
 	cpuid
@@ -197,32 +223,6 @@ SYM_CODE_START(secondary_startup_64)
 	 */
 	lgdt	early_gdt_descr(%rip)
 
-	/* set up data segments */
-	xorl %eax,%eax
-	movl %eax,%ds
-	movl %eax,%ss
-	movl %eax,%es
-
-	/*
-	 * We don't really need to load %fs or %gs, but load them anyway
-	 * to kill any stale realmode selectors.  This allows execution
-	 * under VT hardware.
-	 */
-	movl %eax,%fs
-	movl %eax,%gs
-
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data. If the
-	 * stack protector canary is enabled, it is located at %gs:40.
-	 * Note that, on SMP, the boot cpu uses init data section until
-	 * the per cpu areas are set up.
-	 */
-	movl	$MSR_GS_BASE,%ecx
-	movl	initial_gs(%rip),%eax
-	movl	initial_gs+4(%rip),%edx
-	wrmsr
-
 	/* rsi is pointer to real mode structure with interesting info.
 	   pass it to C */
 	movq	%rsi, %rdi
-- 
2.17.1
