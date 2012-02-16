From: Andrew Jones <drjones@redhat.com>
Subject: [PATCH] blkfront: don't put bdev right after getting it
Date: Thu, 16 Feb 2012 13:16:25 +0100
Message-ID: <1329394585-10129-1-git-send-email-drjones@redhat.com>
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
To: xen-devel@lists.xensource.com
Cc: jeremy@goop.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

We should hang onto bdev until we're done with it.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 drivers/block/xen-blkfront.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 2f22874..5d45688 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1410,7 +1410,6 @@ static int blkif_release(struct gendisk *disk, fmode_t mode)
 	mutex_lock(&blkfront_mutex);
 
 	bdev = bdget_disk(disk, 0);
-	bdput(bdev);
 
 	if (bdev->bd_openers)
 		goto out;
@@ -1441,6 +1440,7 @@ static int blkif_release(struct gendisk *disk, fmode_t mode)
 	}
 
 out:
+	bdput(bdev);
 	mutex_unlock(&blkfront_mutex);
 	return 0;
 }
-- 
1.7.7.5
