From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 5/25] [PATCH] native versions for system.h functions
Date: Wed,  8 Aug 2007 01:18:52 -0300
Message-ID: <11865467741753-git-send-email-gcosta__32091.3165728145$1186557494$gmane$org@redhat.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865467592921-git-send-email-gcosta@redhat.com>
	<1186546763582-git-send-email-gcosta@redhat.com>
	<11865467662182-git-send-email-gcosta@redhat.com>
	<11865467702103-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11865467702103-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This patch adds the native hook for the functions in system.h
They are the read/write_crX, clts and wbinvd. The later, also
gets its call sites patched.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86_64/kernel/tce.c  |    2 +-
 arch/x86_64/mm/pageattr.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/tce.c b/arch/x86_64/kernel/tce.c
index e3f2569..587f0c2 100644
--- a/arch/x86_64/kernel/tce.c
+++ b/arch/x86_64/kernel/tce.c
@@ -42,7 +42,7 @@ static inline void flush_tce(void* tceaddr)
 	if (cpu_has_clflush)
 		asm volatile("clflush (%0)" :: "r" (tceaddr));
 	else
-		asm volatile("wbinvd":::"memory");
+		wbinvd();
 }
 
 void tce_build(struct iommu_table *tbl, unsigned long index,
diff --git a/arch/x86_64/mm/pageattr.c b/arch/x86_64/mm/pageattr.c
index 7e161c6..b497afd 100644
--- a/arch/x86_64/mm/pageattr.c
+++ b/arch/x86_64/mm/pageattr.c
@@ -76,7 +76,7 @@ static void flush_kernel_map(void *arg)
 	/* When clflush is available always use it because it is
 	   much cheaper than WBINVD. */
 	if (!cpu_has_clflush)
-		asm volatile("wbinvd" ::: "memory");
+		wbinvd();
 	else list_for_each_entry(pg, l, lru) {
 		void *adr = page_address(pg);
 		cache_flush_page(adr);
-- 
1.4.4.2
