From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] drivers: virtio: Make out_del_vqs dependent on BALLOON_COMPACTION
Date: Fri,  6 Mar 2020 10:55:28 +0000
Message-ID: <20200306105528.5272-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

out_del_vqs label is currently used only when BALLOON_COMPACTION
configuration option is enabled. Having it disabled triggers the
following warning at compile time:

drivers/virtio/virtio_balloon.c: In function ‘virtballoon_probe’:
drivers/virtio/virtio_balloon.c:963:1: warning: label ‘out_del_vqs’
defined but not used [-Wunused-label]
  963 | out_del_vqs:
      | ^~~~~~~~~~~

Make out_del_vqs dependent on BALLOON_COMPACTION to address the
issue.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7bfe365d9372..341458fd95ca 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -959,8 +959,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	iput(vb->vb_dev_info.inode);
 out_kern_unmount:
 	kern_unmount(balloon_mnt);
-#endif
 out_del_vqs:
+#endif
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	kfree(vb);
-- 
2.25.1
