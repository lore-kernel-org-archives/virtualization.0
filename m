From: Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1] drm/bochs: fix an issue of ioremap() leak
Date: Wed, 22 Apr 2020 00:45:43 +0800
Message-ID: <20200421164543.16605-1-zhengdejin5@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kraxel@redhat.com, airlied@linux.ie, daniel@ffwll.ch, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

It forgot to call bochs_hw_fini() to release related resources when
bochs_pci_probe() fail. eg: io virtual address get by ioremap().

Fixes: 81da8c3b8d3df6 ("drm/bochs: add drm_driver.release callback.")
CC: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index addb0568c1af..210a60135c8a 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -138,6 +138,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
 	return ret;
 
 err_unload:
+	bochs_hw_fini(dev);
 	bochs_unload(dev);
 err_free_dev:
 	drm_dev_put(dev);
-- 
2.25.0
