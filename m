From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 02/12] i386 head.S: Remove unnecessary use of %ebx as the
	boot cpu flag
Date: Mon, 30 Apr 2007 09:49:31 -0600
Message-ID: <m14pmx6ewk.fsf_-___4772.38902026347$1177948456$gmane$org@ebiederm.dsl.xmission.com>
References: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com>
	<m18xc96eyq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m18xc96eyq.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Mon, 30 Apr 2007 09:48:13 -0600")
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


Currently in head.S there are two ways we test to see if we
are the boot cpu.  By looking at %ebx and by looking at the
static variable ready.  When changing things around I have
found that it gets tricky to preserve %ebx.  So this
patch just switches head.S over to the more reliable
test of always using ready.

Hopefully later we can kill these tests entirely.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/head.S |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
index 9b10af6..aa9e28e 100644
--- a/arch/i386/kernel/head.S
+++ b/arch/i386/kernel/head.S
@@ -157,7 +157,6 @@ page_pde_offset = (__PAGE_OFFSET >> 20);
 	jb 10b
 	movl %edi,(init_pg_tables_end - __PAGE_OFFSET)
 
-	xorl %ebx,%ebx				/* This is the boot CPU (BSP) */
 	jmp 3f
 /*
  * Non-boot CPU entry point; entered from trampoline.S
@@ -228,10 +227,6 @@ ENTRY(startup_32_smp)
 	wrmsr
 
 6:
-	/* This is a secondary processor (AP) */
-	xorl %ebx,%ebx
-	incl %ebx
-
 #endif /* CONFIG_SMP */
 3:
 
@@ -257,7 +252,7 @@ ENTRY(startup_32_smp)
 	popfl
 
 #ifdef CONFIG_SMP
-	andl %ebx,%ebx
+	cmpb $0, ready
 	jz  1f				/* Initial CPU cleans BSS */
 	jmp checkCPUtype
 1:
-- 
1.5.1.1.181.g2de0
