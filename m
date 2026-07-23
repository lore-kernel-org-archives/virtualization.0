Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD830F92E;
	Thu, 23 Jul 2026 01:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771679; cv=none; b=mTLaPubrbsp1dJ+WATuoet74iBP10anIN5TGLXHbSqRTouKnBWpTOU2FGnbIy4mfoybQDdny80fuIKAl1noixpDevislHrNvCa8iofpNDnNhk6Se/aZQwP2Pdzy/rvCSAQs0maoh3jp5ma/pKf7Ph/Df2oEk1NroTP4tNSxO2Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771679; c=relaxed/simple;
	bh=Arm3wd8LFqNU2S99lG9Ecg+frEPY2JgD/pIDonS5n+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFjr+m0Wue0chYW0a8AhzuqNhh1R7f8Y1Fqmtwiuwy9B+pmfBvUbUyx81lg4yXjEOY1eAMOb/g0LfFqqUxneEMoM8MwWJrzgx4bsfAT/sWqaP53kiLH/4ep9ZPw9qtAeYGlg+tCoXKjJrj3JvwC9MQPuZ2ZeRkYUtVdOAfWvK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p0UCEvKs; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p0UCEvKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=suIXwDrKQmjkQ6oxDkwb7CNft73Zt7kk5DNZLSKrg28=;
	b=p0UCEvKs1OfREhH5fFmW8lG9IVygahFC9CDnWB94kpmLn57lOnVaV8TVyC64Ds
	6YdGq9Q4/QzrHDTwUCsUgnFxU9ffjnxAjeKBXCiSfdV0+NnrXeXmIgmKO76IuzzD
	Y3cyYVPp2H2RqRGm9R15dvqGo2iL6c0bIJsMMOFusPWqI=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3Xy5BdGFqQfyBIg--.17302S4;
	Thu, 23 Jul 2026 09:54:11 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Xiong Weimin <xiongweimin@kylinos.cn>,
	Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iommu/virtio: Handle iommu_device_register() failures
Date: Thu, 23 Jul 2026 09:54:08 +0800
Message-ID: <20260723095102.1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716012157.88769-2-xiongwm2026@163.com>
References: <20260716012157.88769-2-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3Xy5BdGFqQfyBIg--.17302S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyfGw4DuFyDZFykGw1kGrg_yoW8WFyDpw
	1DCa4kGrWjqFyfGayUJay5ZFyYvan2qayrXFWFqw4kWr1UCryqyF4ayFyUtw17ArWkG3Wa
	q3WkXa1xCrZxuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jZl1PUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7wMgr2phdEPODgAA3f

From: Xiong Weimin <xiongweimin@kylinos.cn>

From: Xiong Weimin <xiongweimin@kylinos.cn>

iommu_device_register() returns an error when the IOMMU core fails to
register the hardware instance or probe the buses. viommu_probe()
currently ignores that error and continues as if the device was
registered successfully.

Propagate the failure and unwind the sysfs entry and virtqueues that
were set up earlier. Clear the driver data on the error path as well,
since it is set before registration so bus probing can find the
virtio-IOMMU instance.

Reviewed-by: Will Deacon <will@kernel.org>
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/virtio-iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc1319..fb19d0bf4 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1234,9 +1234,11 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
-	vdev->priv = viommu;
-
-	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	ret = iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	if (ret)
+		goto err_free_sysfs;
 
 	dev_info(dev, "input address: %u bits\n",
 		 order_base_2(viommu->geometry.aperture_end));
@@ -1244,8 +1246,12 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
+err_free_sysfs:
+	iommu_device_sysfs_remove(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
+err_clear_priv:
+	vdev->priv = NULL;
 
 	return ret;
 }
-- 
2.43.0

