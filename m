From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] xen/blkfront: beyond ARRAY_SIZE of info->shadow
Date: Thu, 21 May 2009 20:43:30 +0200
Message-ID: <4A15A0D2.7090209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: jeremy@xensource.com
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Do not go beyond ARRAY_SIZE of info->shadow

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index a6cbf7b..d395986 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -122,7 +122,7 @@ static DEFINE_SPINLOCK(blkif_io_lock);
 static int get_id_from_freelist(struct blkfront_info *info)
 {
 	unsigned long free = info->shadow_free;
-	BUG_ON(free > BLK_RING_SIZE);
+	BUG_ON(free >= BLK_RING_SIZE);
 	info->shadow_free = info->shadow[free].req.id;
 	info->shadow[free].req.id = 0x0fffffee; /* debug */
 	return free;
