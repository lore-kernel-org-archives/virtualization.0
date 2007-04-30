From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 01/12] x86_64: Allow fixmaps to be used with the initial
	page table.
Date: Mon, 30 Apr 2007 09:48:13 -0600
Message-ID: <m18xc96eyq.fsf__32874.5068786249$1177948293$gmane$org@ebiederm.dsl.xmission.com>
References: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Mon, 30 Apr 2007 09:46:17 -0600")
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


This patch preallocates the intermediate page table entries so that
all that is needed to setup a fixmap is to fill in the appropriate
pte.

By doing this modern hardware that uses memory mapped access can be
talked to early in boot through a fixmap. 

Allowing USB debugging and the like.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/head.S |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/kernel/head.S b/arch/x86_64/kernel/head.S
index 1fab487..1b704c4 100644
--- a/arch/x86_64/kernel/head.S
+++ b/arch/x86_64/kernel/head.S
@@ -74,6 +74,9 @@ startup_64:
 
 	addq	%rbp, level3_ident_pgt + 0(%rip)
 	addq	%rbp, level3_kernel_pgt + (510*8)(%rip)
+	addq	%rbp, level3_kernel_pgt + (511*8)(%rip)
+
+	addq	%rbp, level2_fixmap_pgt + (506*8)(%rip)
 
 	/* Add an Identity mapping if I am above 1G */
 	leaq	_text(%rip), %rdi
@@ -314,7 +317,16 @@ NEXT_PAGE(level3_kernel_pgt)
 	.fill	510,8,0
 	/* (2^48-(2*1024*1024*1024)-((2^39)*511))/(2^30) = 510 */
 	.quad	level2_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE
-	.fill	1,8,0
+	.quad	level2_fixmap_pgt - __START_KERNEL_map + _KERNPG_TABLE + _PAGE_USER
+
+NEXT_PAGE(level2_fixmap_pgt)
+	.fill	506,8,0
+	.quad	level1_fixmap_pgt - __START_KERNEL_map + _KERNPG_TABLE + _PAGE_USER
+	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
+	.fill	5,8,0
+
+NEXT_PAGE(level1_fixmap_pgt)
+	.fill	512,8,0
 
 NEXT_PAGE(level2_ident_pgt)
 	/* Since I easily can, map the first 1G.
-- 
1.5.1.1.181.g2de0
