From: Gioh Kim <gioh.kim@lge.com>
Subject: [PATCH 4/4] mm: remove direct calling of migration
Date: Mon, 13 Jul 2015 17:35:19 +0900
Message-ID: <1436776519-17337-5-git-send-email-gioh.kim__15036.5004585639$1436776536$gmane$org@lge.com>
References: <1436776519-17337-1-git-send-email-gioh.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1436776519-17337-1-git-send-email-gioh.kim@lge.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jlayton@poochiereds.net, bfields@fieldses.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com, viro@zeniv.linux.org.uk, mst@redhat.com, koct9i@gmail.com, minchan@kernel.org, aquini@redhat.com, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, Gioh Kim <gurugio@hanmail.net>, dri-devel@lists.freedesktop.org, Gioh Kim <gioh.kim@lge.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Gioh Kim <gurugio@hanmail.net>

Migration is completely generalized so that migrating mobile page
is processed with lru-pages in move_to_new_page.

Signed-off-by: Gioh Kim <gioh.kim@lge.com>
Acked-by: Rafael Aquini <aquini@redhat.com>
---
 mm/migrate.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 53f0081d..e6644ac 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -844,21 +844,6 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		}
 	}
 
-	if (unlikely(mobile_page(page))) {
-		/*
-		 * A mobile page does not need any special attention from
-		 * physical to virtual reverse mapping procedures.
-		 * Skip any attempt to unmap PTEs or to remap swap cache,
-		 * in order to avoid burning cycles at rmap level, and perform
-		 * the page migration right away (proteced by page lock).
-		 */
-		lock_page(newpage);
-		rc = page->mapping->a_ops->migratepage(page->mapping,
-						       newpage, page, mode);
-		unlock_page(newpage);
-		goto out_unlock;
-	}
-
 	/*
 	 * Corner case handling:
 	 * 1. When a new swap-cache page is read into, it is added to the LRU
-- 
2.1.4
