From: Jason Yan <yanaijie@huawei.com>
Subject: [PATCH -next] vhost: remove set but not used variable 'status'
Date: Thu, 2 Apr 2020 14:51:06 +0800
Message-ID: <20200402065106.20108-1-yanaijie@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: tiwei.bie@intel.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix the following gcc warning:
drivers/vhost/vdpa.c:299:5: warning: variable 'status' set but not used [-Wunused-but-set-variable]
  u8 status;
     ^~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/vhost/vdpa.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 421f02a8530a..a645b1db606d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -296,7 +296,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	struct vdpa_callback cb;
 	struct vhost_virtqueue *vq;
 	struct vhost_vring_state s;
-	u8 status;
 	u32 idx;
 	long r;
 
@@ -310,8 +309,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	idx = array_index_nospec(idx, v->nvqs);
 	vq = &v->vqs[idx];
 
-	status = ops->get_status(vdpa);
-
 	if (cmd == VHOST_VDPA_SET_VRING_ENABLE) {
 		if (copy_from_user(&s, argp, sizeof(s)))
 			return -EFAULT;
-- 
2.17.2
