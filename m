From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] vdpa: Signedness bugs in vdpasim_work()
Date: Mon, 6 Apr 2020 17:45:09 +0300
Message-ID: <20200406144509.GE68494@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The "read" and "write" variables need to be signed for the error
handling to work.

Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6e8a0cf2fdeb..b3c800653056 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -132,7 +132,8 @@ static void vdpasim_work(struct work_struct *work)
 						 vdpasim, work);
 	struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
 	struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
-	size_t read, write, total_write;
+	ssize_t read, write;
+	size_t total_write;
 	int err;
 	int pkts = 0;
 
-- 
2.25.1
