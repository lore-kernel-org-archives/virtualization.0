From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 1/5] vhost-vdpa: refine ioctl pre-processing
Date: Wed,  1 Jul 2020 17:08:35 +0800
Message-ID: <20200701090839.12994-2-jasowang@redhat.com>
References: <20200701090839.12994-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200701090839.12994-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, eli@mellanox.com, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Switch to use 'switch' to make the codes more easier to be extended.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 77a0c9fb6cc3..db4c9cb44c61 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -353,15 +353,16 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	idx = array_index_nospec(idx, v->nvqs);
 	vq = &v->vqs[idx];
 
-	if (cmd == VHOST_VDPA_SET_VRING_ENABLE) {
+	switch (cmd) {
+	case VHOST_VDPA_SET_VRING_ENABLE:
 		if (copy_from_user(&s, argp, sizeof(s)))
 			return -EFAULT;
 		ops->set_vq_ready(vdpa, idx, s.num);
 		return 0;
-	}
-
-	if (cmd == VHOST_GET_VRING_BASE)
+	case VHOST_GET_VRING_BASE:
 		vq->last_avail_idx = ops->get_vq_state(v->vdpa, idx);
+		break;
+	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
 	if (r)
-- 
2.20.1
