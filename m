From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_blk: make serial attribute static
Date: Thu, 23 Oct 2014 16:09:55 +0300
Message-ID: <1414069787-17287-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

It's never declared so no need to make it extern.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 93e23a7..a68f4c6 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -332,7 +332,8 @@ static ssize_t virtblk_serial_show(struct device *dev,
 
 	return err;
 }
-DEVICE_ATTR(serial, S_IRUGO, virtblk_serial_show, NULL);
+
+static DEVICE_ATTR(serial, S_IRUGO, virtblk_serial_show, NULL);
 
 static void virtblk_config_changed_work(struct work_struct *work)
 {
-- 
MST
