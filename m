From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] virtio_balloon: Fix build error seen with CONFIG_BALLOON_COMPACTION=n
Date: Wed, 19 Feb 2020 18:31:56 -0800
Message-ID: <20200220023156.20636-1-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, David Hildenbrand <david@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

0day reports:

drivers//virtio/virtio_balloon.c: In function 'virtballoon_probe':
drivers//virtio/virtio_balloon.c:960:1: error:
	label 'out_del_vqs' defined but not used [-Werror=unused-label]

This is seen with CONFIG_BALLOON_COMPACTION=n.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 1ad6f58ea936 ("virtio_balloon: Fix memory leaks on errors in virtballoon_probe()")
Cc: David Hildenbrand <david@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
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
2.17.1
