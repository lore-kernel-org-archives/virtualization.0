From: Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] virtio: silence a -Wunused-label warning
Date: Sat,  7 Mar 2020 11:43:50 +0800
Message-ID: <1583552630-20799-1-git-send-email-hqjagain@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

The label 'out_del_vqs:' is only used by CONFIG_BALLOON_COMPACTION,
so move it to the region.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7bfe365..341458f 100644
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
1.8.3.1
