From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] vdpa: remove unused variables 'ifcvf' and 'ifcvf_lm'
Date: Thu, 2 Apr 2020 10:46:26 +0800
Message-ID: <20200402024626.32944-1-yuehaibing@huawei.com>
References: <20200331080259.33056-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200331080259.33056-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, lingshan.zhu@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com, yuehaibing@huawei.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

drivers/vdpa/ifcvf/ifcvf_main.c:34:24:
 warning: variable ‘ifcvf’ set but not used [-Wunused-but-set-variable]
drivers/vdpa/ifcvf/ifcvf_base.c:304:31:
 warning: variable ‘ifcvf_lm’ set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
v2: rework based on commit a4be40cbcedb ("vdpa: move to drivers/vdpa")
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 2 --
 drivers/vdpa/ifcvf/ifcvf_main.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index b61b06ea26d3..e24371d644b5 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -301,12 +301,10 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u64 num)
 
 static int ifcvf_hw_enable(struct ifcvf_hw *hw)
 {
-	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
 	struct virtio_pci_common_cfg __iomem *cfg;
 	struct ifcvf_adapter *ifcvf;
 	u32 i;
 
-	ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
 	ifcvf = vf_to_adapter(hw);
 	cfg = hw->common_cfg;
 	ifc_iowrite16(IFCVF_MSI_CONFIG_OFF, &cfg->msix_config);
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 8d54dc5b08d2..28d9e5de5675 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -31,11 +31,9 @@ static irqreturn_t ifcvf_intr_handler(int irq, void *arg)
 static int ifcvf_start_datapath(void *private)
 {
 	struct ifcvf_hw *vf = ifcvf_private_to_vf(private);
-	struct ifcvf_adapter *ifcvf;
 	u8 status;
 	int ret;
 
-	ifcvf = vf_to_adapter(vf);
 	vf->nr_vring = IFCVF_MAX_QUEUE_PAIRS * 2;
 	ret = ifcvf_start_hw(vf);
 	if (ret < 0) {
-- 
2.17.1
