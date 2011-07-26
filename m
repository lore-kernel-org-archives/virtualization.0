From: ruslanpisarev@gmail.com
Subject: [PATCH 3/7] Xen: fix braces coding style issue in gntdev.c and
	grant-table.c
Date: Tue, 26 Jul 2011 14:16:26 +0300
Message-ID: <1311678986-16601-1-git-send-email-ruslan@rpisarev.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jeremy.fitzhardinge@citrix.com
Cc: Ruslan Pisarev <ruslan@rpisarev.org.ua>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

From: Ruslan Pisarev <ruslan@rpisarev.org.ua>

This is a patch to the gntdev.c and grant-table.c files that fixed up
braces errors found by the checkpatch.pl tools.

Signed-off-by: Ruslan Pisarev <ruslan@rpisarev.org.ua>
---
 drivers/xen/gntdev.c      |    3 +--
 drivers/xen/grant-table.c |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index f914b26..772a5b8 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -188,9 +188,8 @@ static void gntdev_put_map(struct grant_map *map)
 
 	atomic_sub(map->count, &pages_mapped);
 
-	if (map->notify.flags & UNMAP_NOTIFY_SEND_EVENT) {
+	if (map->notify.flags & UNMAP_NOTIFY_SEND_EVENT)
 		notify_remote_via_evtchn(map->notify.event);
-	}
 
 	if (map->pages) {
 		if (!use_ptemod)
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index fd725cd..3a3dceb 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -193,7 +193,7 @@ int gnttab_query_foreign_access(grant_ref_t ref)
 
 	nflags = shared[ref].flags;
 
-	return (nflags & (GTF_reading|GTF_writing));
+	return nflags & (GTF_reading|GTF_writing);
 }
 EXPORT_SYMBOL_GPL(gnttab_query_foreign_access);
 
-- 
1.7.4.1
