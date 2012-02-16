From: Andrew Jones <drjones@redhat.com>
Subject: [PATCH] blkfront: don't change to closing if we're busy
Date: Thu, 16 Feb 2012 13:17:09 +0100
Message-ID: <1329394629-10299-1-git-send-email-drjones@redhat.com>
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

We just reported to xenbus that we can't close yet, because
blkfront is still in use. So we shouldn't then immediately
state that we are closing.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 drivers/block/xen-blkfront.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 5d45688..b53cae4 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1134,7 +1134,6 @@ blkfront_closing(struct blkfront_info *info)
 	if (bdev->bd_openers) {
 		xenbus_dev_error(xbdev, -EBUSY,
 				 "Device in use; refusing to close");
-		xenbus_switch_state(xbdev, XenbusStateClosing);
 	} else {
 		xlvbd_release_gendisk(info);
 		xenbus_frontend_closed(xbdev);
-- 
1.7.7.5
