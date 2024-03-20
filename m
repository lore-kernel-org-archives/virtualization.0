Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772C3FBA3
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929962; cv=none; b=puLl6PtMUVyYoZSVZuTtOPBYOKuQRq1cwKEhoTjgqN4Lxrl+OnozxegyXkj+Az16J+3YHBJHQwnN/Qkh7fZvk8ENN9NMJI3sySBVM52DoGnuv4DrF1gtqkS+zJKW/MyWRP1RTXqI0jLAOeQ1hLdjC3LvkYryfLkWNF1dqszA5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929962; c=relaxed/simple;
	bh=xIi+cW4w2WN3sLl/pWDZi4mIfB8RX4auWJofB6sJ99c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vAow8Uh+Zw50/yQE/ZiyPJg1hyCzqr2FGG8xg+aI9A6u1dLYw8LpDWT1t+iiD0wXb02crnXz9417lBcBMaBeO9RME1omIZUya2FsR7TfuhXbq6zPaFXx2dRKqfSaqiKuCCpLxuvpg7fZEovBsqpxsfoc/sHn2A/50wM9NL7rtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ortV1WbK; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ortV1WbK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1oeuD
	vFn2YDBckFkO47Q7YRsJ8OZ8rJl2dHg14vkSuw=; b=ortV1WbKJzj6lpEmSXyvL
	h2kbUcPWGRGzjC/OzoXLMd2R/kn/a3AECnO54dT5Gq5+sHqK9C55X1p6IrN79kuD
	SH3Bm3bQ1FnuFM7BFtMCtCQk2JjuLKXunHn3WNmamQZ3xhRDni5/ZMi9BQjcrEPy
	5YYJ3UwTBQ+DRSamx0eAHs=
Received: from localhost.localdomain (unknown [39.144.124.65])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wDnL5ciuPpliawpBA--.38680S2;
	Wed, 20 Mar 2024 18:19:15 +0800 (CST)
From: Wang Rong <w_angrong@163.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rong Wang <w_angrong@163.com>
Subject: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for software-managed MSI
Date: Wed, 20 Mar 2024 18:19:12 +0800
Message-Id: <20240320101912.28210-1-w_angrong@163.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL5ciuPpliawpBA--.38680S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrWkGF4ftw1DJF45Jr18Xwb_yoWrXry7pF
	ZrCFy5Gr4UJw4xWrsxAF4DZFnYk3s2y3y8Caya9anakr1Utr90kaykGa4jyF15AFWrJF17
	XF42kr18uw4UJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEb18DUUUUU=
X-CM-SenderInfo: xzbd0wpurqwqqrwthudrp/1tbiNgSniGXAkngAPAAAsu

From: Rong Wang <w_angrong@163.com>

Once enable iommu domain for one device, the MSI
translation tables have to be there for software-managed MSI.
Otherwise, platform with software-managed MSI without an
irq bypass function, can not get a correct memory write event
from pcie, will not get irqs.
The solution is to obtain the MSI phy base address from
iommu reserved region, and set it to iommu MSI cookie,
then translation tables will be created while request irq.

Change log
----------

v1->v2:
- add resv iotlb to avoid overlap mapping.
v2->v3:
- there is no need to export the iommu symbol anymore.

Signed-off-by: Rong Wang <w_angrong@163.com>
---
 drivers/vhost/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ba52d128aeb7..28b56b10372b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -49,6 +49,7 @@ struct vhost_vdpa {
 	struct completion completion;
 	struct vdpa_device *vdpa;
 	struct hlist_head as[VHOST_VDPA_IOTLB_BUCKETS];
+	struct vhost_iotlb resv_iotlb;
 	struct device dev;
 	struct cdev cdev;
 	atomic_t opened;
@@ -247,6 +248,7 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
 static int vhost_vdpa_reset(struct vhost_vdpa *v)
 {
 	v->in_batch = 0;
+	vhost_iotlb_reset(&v->resv_iotlb);
 	return _compat_vdpa_reset(v);
 }
 
@@ -1219,10 +1221,15 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	    msg->iova + msg->size - 1 > v->range.last)
 		return -EINVAL;
 
+	if (vhost_iotlb_itree_first(&v->resv_iotlb, msg->iova,
+					msg->iova + msg->size - 1))
+		return -EINVAL;
+
 	if (vhost_iotlb_itree_first(iotlb, msg->iova,
 				    msg->iova + msg->size - 1))
 		return -EEXIST;
 
+
 	if (vdpa->use_va)
 		return vhost_vdpa_va_map(v, iotlb, msg->iova, msg->size,
 					 msg->uaddr, msg->perm);
@@ -1307,6 +1314,45 @@ static ssize_t vhost_vdpa_chr_write_iter(struct kiocb *iocb,
 	return vhost_chr_write_iter(dev, from);
 }
 
+static int vhost_vdpa_resv_iommu_region(struct iommu_domain *domain, struct device *dma_dev,
+	struct vhost_iotlb *resv_iotlb)
+{
+	struct list_head dev_resv_regions;
+	phys_addr_t resv_msi_base = 0;
+	struct iommu_resv_region *region;
+	int ret = 0;
+	bool with_sw_msi = false;
+	bool with_hw_msi = false;
+
+	INIT_LIST_HEAD(&dev_resv_regions);
+	iommu_get_resv_regions(dma_dev, &dev_resv_regions);
+
+	list_for_each_entry(region, &dev_resv_regions, list) {
+		ret = vhost_iotlb_add_range_ctx(resv_iotlb, region->start,
+				region->start + region->length - 1,
+				0, 0, NULL);
+		if (ret) {
+			vhost_iotlb_reset(resv_iotlb);
+			break;
+		}
+
+		if (region->type == IOMMU_RESV_MSI)
+			with_hw_msi = true;
+
+		if (region->type == IOMMU_RESV_SW_MSI) {
+			resv_msi_base = region->start;
+			with_sw_msi = true;
+		}
+	}
+
+	if (!ret && !with_hw_msi && with_sw_msi)
+		ret = iommu_get_msi_cookie(domain, resv_msi_base);
+
+	iommu_put_resv_regions(dma_dev, &dev_resv_regions);
+
+	return ret;
+}
+
 static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
@@ -1335,11 +1381,16 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 
 	ret = iommu_attach_device(v->domain, dma_dev);
 	if (ret)
-		goto err_attach;
+		goto err_alloc_domain;
 
-	return 0;
+	ret = vhost_vdpa_resv_iommu_region(v->domain, dma_dev, &v->resv_iotlb);
+	if (ret)
+		goto err_attach_device;
 
-err_attach:
+	return 0;
+err_attach_device:
+	iommu_detach_device(v->domain, dma_dev);
+err_alloc_domain:
 	iommu_domain_free(v->domain);
 	v->domain = NULL;
 	return ret;
@@ -1595,6 +1646,8 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 		goto err;
 	}
 
+	vhost_iotlb_init(&v->resv_iotlb, 0, 0);
+
 	r = dev_set_name(&v->dev, "vhost-vdpa-%u", minor);
 	if (r)
 		goto err;
-- 
2.27.0

