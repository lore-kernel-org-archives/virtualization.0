From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 03/12] i386 head.S: Always run the full set of paging state
Date: Mon, 30 Apr 2007 09:51:13 -0600
Message-ID: <m1zm4p509a.fsf_-___10.1538528271661$1177948526$gmane$org@ebiederm.dsl.xmission.com>
References: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com>
	<m18xc96eyq.fsf@ebiederm.dsl.xmission.com>
	<m14pmx6ewk.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m14pmx6ewk.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Mon, 30 Apr 2007 09:49:31 -0600")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


I am preparing to convert the boot time page table to the kernels
native format.  To achieve that I need to enable PAE. Enabling PSE
and the no execute bit would not hurt.  So this patch modifies
the boot cpu path to execute all of the kernels enable code
if and only if we have the proper bits set in mmu_cr4_features.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/head.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
index aa9e28e..248d44c 100644
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -181,6 +181,8 @@ ENTRY(startup_32_smp)
 	movl %eax,%es
 	movl %eax,%fs
 	movl %eax,%gs
+#endif /* CONFIG_SMP */
+3:
 
 /*
  *	New page tables may be in 4Mbyte page mode and may
@@ -227,8 +229,6 @@ ENTRY(startup_32_smp)
 	wrmsr
 
 6:
-#endif /* CONFIG_SMP */
-3:
 
 /*
  * Enable paging
-- 
1.5.1.1.181.g2de0
