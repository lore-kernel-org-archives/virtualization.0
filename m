From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 11/15] iommu/renesas: Use accessor functions for iommu private
 data
Date: Tue, 10 Mar 2020 10:12:25 +0100
Message-ID: <20200310091229.29830-12-joro@8bytes.org>
References: <20200310091229.29830-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20200310091229.29830-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Make use of dev_iommu_priv_set/get() functions.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ecb3f9464dd5..310cf09feea3 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -89,9 +89,7 @@ static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
 
 static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	return fwspec ? fwspec->iommu_priv : NULL;
+	return dev_iommu_priv_get(dev);
 }
 
 #define TLB_LOOP_TIMEOUT		100	/* 100us */
@@ -727,14 +725,13 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 static int ipmmu_init_platform_device(struct device *dev,
 				      struct of_phandle_args *args)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct platform_device *ipmmu_pdev;
 
 	ipmmu_pdev = of_find_device_by_node(args->np);
 	if (!ipmmu_pdev)
 		return -ENODEV;
 
-	fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
+	dev_iommu_priv_set(dev, platform_get_drvdata(ipmmu_pdev));
 
 	return 0;
 }
-- 
2.17.1
