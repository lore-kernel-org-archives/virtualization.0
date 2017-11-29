From: weiping zhang <zwp10758@gmail.com>
Subject: [PATCH] virtio: release virtio index when fail to device_register
Date: Wed, 29 Nov 2017 09:23:01 +0800
Message-ID: <20171129012301.GA6637@localhost.didichuxing.com>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

index can be reused by other virtio device.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 drivers/virtio/virtio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 48230a5..bf7ff39 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -333,6 +333,8 @@ int register_virtio_device(struct virtio_device *dev)
 	/* device_register() causes the bus infrastructure to look for a
 	 * matching driver. */
 	err = device_register(&dev->dev);
+	if (err)
+		ida_simple_remove(&virtio_index_ida, dev->index);
 out:
 	if (err)
 		virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
-- 
2.9.4
