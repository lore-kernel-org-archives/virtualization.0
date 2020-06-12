From: Wang Qing <wangqing@vivo.com>
Subject: [PATCH] drivers\block: Use kobj_to_dev() API
Date: Fri, 12 Jun 2020 15:10:56 +0800
Message-ID: <1591945856-14749-1-git-send-email-wangqing@vivo.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wang Qing <wangqing@vivo.com>
List-Id: virtualization@lists.linuxfoundation.org

Use kobj_to_dev() API instead of container_of().

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 drivers/block/virtio_blk.c

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9d21bf0..c808405
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -630,7 +630,7 @@ static struct attribute *virtblk_attrs[] = {
 static umode_t virtblk_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct gendisk *disk = dev_to_disk(dev);
 	struct virtio_blk *vblk = disk->private_data;
 	struct virtio_device *vdev = vblk->vdev;
-- 
2.7.4
