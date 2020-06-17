From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 3/4] vdpa: get_iova_range() is mandatory for device specific
 DMA translation
Date: Wed, 17 Jun 2020 11:29:46 +0800
Message-ID: <20200617032947.6371-4-jasowang@redhat.com>
References: <20200617032947.6371-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200617032947.6371-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com, mhabets@solarflare.com, vmireyno@marvell.com, gdawar@xilinx.com, eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn, eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

In order to let userspace work correctly, get_iova_range() is a must
for the device that has its own DMA translation logic.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index de211ef3738c..ab7af978ef70 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -82,6 +82,10 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	if (!!config->dma_map != !!config->dma_unmap)
 		goto err;
 
+	if ((config->dma_map || config->set_map) &&
+	    !config->get_iova_range)
+		goto err;
+
 	err = -ENOMEM;
 	vdev = kzalloc(size, GFP_KERNEL);
 	if (!vdev)
-- 
2.20.1
