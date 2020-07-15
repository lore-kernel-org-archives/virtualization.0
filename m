From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v2 7/8] mm/balloon_compaction: Fix trivial spelling
Date: Wed, 15 Jul 2020 13:48:38 +0100
Message-ID: <20200715124839.252822-8-kieran.bingham+renesas@ideasonboard.com>
References: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, David Hildenbrand <david@redhat.com>, Souptick Joarder <jrdr.linux@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "open list:VIRTIO BALLOON" <virtualization@lists.linux-foundation.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

The word 'descriptor' is misspelled throughout the tree.

Fix it up accordingly:
    decriptor -> descriptor

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
v2:
 - Fix commit message to reflect actual word replaced
---
 mm/balloon_compaction.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 26de020aae7b..907fefde2572 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
 /**
  * balloon_page_list_dequeue() - removes pages from balloon's page list and
  *				 returns a list of the pages.
- * @b_dev_info: balloon device decriptor where we will grab a page from.
+ * @b_dev_info: balloon device descriptor where we will grab a page from.
  * @pages: pointer to the list of pages that would be returned to the caller.
  * @n_req_pages: number of requested pages.
  *
@@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 /*
  * balloon_page_dequeue - removes a page from balloon's page list and returns
  *			  its address to allow the driver to release the page.
- * @b_dev_info: balloon device decriptor where we will grab a page from.
+ * @b_dev_info: balloon device descriptor where we will grab a page from.
  *
  * Driver must call this function to properly dequeue a previously enqueued page
  * before definitively releasing it back to the guest system.
-- 
2.25.1
