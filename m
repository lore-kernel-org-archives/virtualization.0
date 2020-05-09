From: Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] vdpasim: Fix some coccinelle warnings
Date: Sat, 9 May 2020 10:20:02 +0800
Message-ID: <1588990802-28451-1-git-send-email-zou_wei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Samuel Zou <zou_wei@huawei.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix below warnings reported by coccicheck:

drivers/vdpa/vdpa_sim/vdpa_sim.c:104:1-10: WARNING: Assignment of 0/1 to bool variable
drivers/vdpa/vdpa_sim/vdpa_sim.c:164:7-11: WARNING: Unsigned expression compared with zero: read <= 0
drivers/vdpa/vdpa_sim/vdpa_sim.c:169:7-12: WARNING: Unsigned expression compared with zero: write <= 0

1. The 'ready' variable in vdpasim_virtqueue struct is bool type.
   It is better to initialize vq->ready to false

2. Modify 'read' and 'write' variables type from size_t to ssize_t.
   And preserve the reverse christmas tree ordering of local variables.

Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 01c456f..c7334cc 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -101,7 +101,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 
 static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
 {
-	vq->ready = 0;
+	vq->ready = false;
 	vq->desc_addr = 0;
 	vq->driver_addr = 0;
 	vq->device_addr = 0;
@@ -131,9 +131,10 @@ static void vdpasim_work(struct work_struct *work)
 						 vdpasim, work);
 	struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
 	struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
-	size_t read, write, total_write;
-	int err;
+	ssize_t read, write;
+	size_t total_write;
 	int pkts = 0;
+	int err;
 
 	spin_lock(&vdpasim->lock);
 
-- 
2.6.2
