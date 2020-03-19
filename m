From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 32/70] x86/head/64: Switch to initial stack earlier
Date: Thu, 19 Mar 2020 10:13:29 +0100
Message-ID: <20200319091407.1481-33-joro@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200319091407.1481-1-joro@8bytes.org>
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

Make sure there is a stack once the kernel runs from virual addresses.
At this stage any secondary CPU which boots will have lost its stack
because the kernel switched to a new page-table which does not map the
real-mode stack anymore.

This is also needed for handling early #VC exceptions caused by
instructions like CPUID.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/head_64.S | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 1be178be1566..b8ba72f31be9 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -194,6 +194,12 @@ SYM_CODE_START(secondary_startup_64)
 	movl	initial_gs+4(%rip),%edx
 	wrmsr
 
+	/*
+	 * Setup a boot time stack - Any secondary CPU will have lost its stack
+	 * by now because the cr3-switch above unmaps the real-mode stack
+	 */
+	movq initial_stack(%rip), %rsp
+
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
 	cpuid
@@ -214,9 +220,6 @@ SYM_CODE_START(secondary_startup_64)
 	/* Make changes effective */
 	movq	%rax, %cr0
 
-	/* Setup a boot time stack */
-	movq initial_stack(%rip), %rsp
-
 	/* zero EFLAGS after setting rsp */
 	pushq $0
 	popfq
-- 
2.17.1
