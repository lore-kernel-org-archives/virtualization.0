From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2] mm/balloon_compaction: Informative allocation warnings
Date: Wed, 21 Aug 2019 02:41:59 -0700
Message-ID: <20190821094159.40795-1-namit__9375.22689798556$1566406985$gmane$org@vmware.com>
Reply-To: Nadav Amit <namit@vmware.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

There is no reason to print generic warnings when balloon memory
allocation fails, as failures are expected and can be handled
gracefully. Since VMware balloon now uses balloon-compaction
infrastructure, and suppressed these warnings before, it is also
beneficial to suppress these warnings to keep the same behavior that the
balloon had before.

Since such warnings can still be useful to indicate that the balloon is
over-inflated, print more informative and less frightening warning if
allocation fails instead.

Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>

---

v1->v2:
  * Print informative warnings instead suppressing [David]
---
 mm/balloon_compaction.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 798275a51887..0c1d1f7689f0 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -124,7 +124,12 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 struct page *balloon_page_alloc(void)
 {
 	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY);
+				       __GFP_NOMEMALLOC | __GFP_NORETRY |
+				       __GFP_NOWARN);
+
+	if (!page)
+		pr_warn_ratelimited("memory balloon: memory allocation failed");
+
 	return page;
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
-- 
2.17.1
