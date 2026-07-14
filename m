Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64BB2DCF61;
	Tue, 14 Jul 2026 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997427; cv=none; b=XeMCnuCS4PIVVdXsUesNbcNKfrsdqM37j53BB/1vW0JpAaLoufIYvyfY+i2JPe1huW8qSTW4vT5ekBGKnIHFgaU+qYl/e8ppf+EfP+L06sBoFWVlvyyOc1+KN+7wEmOGob/5vftJvJQAU0NYm9B8uKhrzDJzEta3ELVtmjMMfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997427; c=relaxed/simple;
	bh=PPbWPqbERNmgVmFvetStuEHyCIJfJiDYRMOJ6tHsL34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+lhbVsfXI9QYxsN6babj84lx+yZjPWJWamAa2D+nWLjAOl/STjUvqEzv7s1APJxdfY9nUypo3mJIuZLWjIagK83OTr1Hd+wIxV6y9IKnrMW2+en/ZhPNMdOhW/Sh0bZWEHBQCYf5NravpH8p2xThJ/RMU7seg+AfDg0/wW2mNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HFqpd/Fh; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HFqpd/Fh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=C2
	/isRvdigohVTJa3M3a4dCirxli6CzG+eHKu4bm9Tw=; b=HFqpd/FhEfW7H6oDbh
	00UpLddjVJi7p/rcjT/L9waj91MWaf9SdKKcGG0UgYboJKvEgfl6b06/+SM9cLUR
	zq4Hg3UwJvDj6/kyI+gUZhZTatJDSIm8iGubnzPqwN7CJYL8Ro6RARiUQGh2iPSe
	XMP1POZF+gqthdDThm2kWpyOE=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCXNQLNo1VqB9jsJA--.61058S4;
	Tue, 14 Jul 2026 10:49:59 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH v1 2/2] iommu/virtio: Handle iommu_device_register() failures
Date: Tue, 14 Jul 2026 10:49:49 +0800
Message-ID: <20260714024949.190014-3-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714024949.190014-1-15927021679@163.com>
References: <20260714024949.190014-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXNQLNo1VqB9jsJA--.61058S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry8tw43GFy5Gr4xtr17GFg_yoW8XF4Upa
	4DCa95GrWUtFyfGay7Aay5ZF9Yvan2qay8XFWrX3ykWr15Gryjyr1ayFyUtw1fArWkGF42
	qw1vqa1xuFZ8uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYD73UUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0RcOlmpVo9dc9AAA39

From: Xiong Weimin <xiongweimin@kylinos.cn>

iommu_device_register() returns an error when the IOMMU core fails to
register the hardware instance or probe the buses. viommu_probe()
currently ignores that error and continues as if the device was
registered successfully.

Propagate the failure and unwind the sysfs entry and virtqueues that
were set up earlier. Clear the driver data on the error path as well,
since it is set before registration so bus probing can find the
virtio-IOMMU instance.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/virtio-iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 342785c76..9118377d7 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1240,7 +1240,9 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	vdev->priv = viommu;
 
-	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	ret = iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	if (ret)
+		goto err_remove_sysfs;
 
 	dev_info(dev, "input address: %u bits\n",
 		 order_base_2(viommu->geometry.aperture_end));
@@ -1248,8 +1250,11 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
+err_remove_sysfs:
+	iommu_device_sysfs_remove(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
+	vdev->priv = NULL;
 
 	return ret;
 }
-- 
2.43.0

