From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] vdpa: Fix pointer math bug in vdpasim_get_config()
Date: Mon, 6 Apr 2020 17:45:52 +0300
Message-ID: <20200406144552.GF68494@mwanda>
References: <20200406144509.GE68494@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200406144509.GE68494@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

If "offset" is non-zero then we end up copying from beyond the end of
the config because of pointer math.  We can fix this by casting the
struct to a u8 pointer.

Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Is it really worth letting people specify the offset?

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b3c800653056..e03c25765513 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -509,7 +509,7 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	if (offset + len < sizeof(struct virtio_net_config))
-		memcpy(buf, &vdpasim->config + offset, len);
+		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
 }
 
 static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
-- 
2.25.1
