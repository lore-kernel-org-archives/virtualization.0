From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: [PATCH] mm/balloon_compaction: suppress allocation warnings
Date: Tue, 20 Aug 2019 02:16:46 -0700
Message-ID: <20190820091646.29642-1-namit__46230.0912289479$1566319063$gmane$org@vmware.com>
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
Cc: linux-mm@kvack.org, Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

There is no reason to print warnings when balloon page allocation fails,
as they are expected and can be handled gracefully.  Since VMware
balloon now uses balloon-compaction infrastructure, and suppressed these
warnings before, it is also beneficial to suppress these warnings to
keep the same behavior that the balloon had before.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/balloon_compaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 798275a51887..26de020aae7b 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -124,7 +124,8 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 struct page *balloon_page_alloc(void)
 {
 	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY);
+				       __GFP_NOMEMALLOC | __GFP_NORETRY |
+				       __GFP_NOWARN);
 	return page;
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
-- 
2.19.1
