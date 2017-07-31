From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH] mm: don't zero ballooned pages
Date: Mon, 31 Jul 2017 12:13:33 +0800
Message-ID: <1501474413-21580-1-git-send-email-wei.w.wang__34177.349592983$1501475038$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, mst@redhat.com, mawilcox@microsoft.com, mhocko@suse.com, dave.hansen@intel.com, akpm@linux-foundation.org, wei.w.wang@intel.com
Cc: zhenwei.pi@youruncloud.com
List-Id: virtualization@lists.linuxfoundation.org

Ballooned pages will be marked as MADV_DONTNEED by the hypervisor and
shouldn't be given to the host ksmd to scan. Therefore, it is not
necessary to zero ballooned pages, which is very time consuming when
the page amount is large. The ongoing fast balloon tests show that the
time to balloon 7G pages is increased from ~491ms to 2.8 seconds with
__GFP_ZERO added. So, this patch removes the flag.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 mm/balloon_compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 9075aa5..b06d9fe 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -24,7 +24,7 @@ struct page *balloon_page_enqueue(struct balloon_dev_info *b_dev_info)
 {
 	unsigned long flags;
 	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_ZERO);
+				       __GFP_NOMEMALLOC | __GFP_NORETRY);
 	if (!page)
 		return NULL;
 
-- 
2.7.4
