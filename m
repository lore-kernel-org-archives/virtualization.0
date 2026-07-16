Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C6314D0D;
	Thu, 16 Jul 2026 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784164953; cv=none; b=OetprRxVemtbDN/tKN+DnK5O9Dm143DhNGLySaLMptJTGDQcD26fA7OKsx2/frm0Ddrdz7paeL5E3atWF50NFVF+3QqYKlQ7ZBUNjRhTHxqckczQflTjFSheQuoPKixJtr0X40L0VGRHT3Zavri9WryrgGHjav+32BCdr+j5KwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784164953; c=relaxed/simple;
	bh=PPbWPqbERNmgVmFvetStuEHyCIJfJiDYRMOJ6tHsL34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eo93wNVZ1YJUKcTrhwJsdDgBIi7vnhnm37TZGbdcqtCA2V/9gVy9NVrz34f5KPGsG5+wkIWXgO9T0VNKxTGMBEZUZtXReeiGUA8fI3sICEUUxdBgGNUiwHsKfayoxS00DfZ5rsVDa77ztjdkRFsGIrO7fyu9nLb5ghmglA5/RGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jmC4/7h5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jmC4/7h5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=C2
	/isRvdigohVTJa3M3a4dCirxli6CzG+eHKu4bm9Tw=; b=jmC4/7h5q6LebQ2Z3o
	weV43usFnzsNF0/Cjq4yByzCxa8zwKgcsWhw7H0OG+iZ9hkp5qBEH7NNFL82q6Y2
	+T0vePVzSc9zgxjWtYcsIDNZUbiuO3+HphmlgCsIkQxbqlbW47HdlVrJbEETuKvo
	RcZ1kdeeTtagBa4eInXmklbms=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHriIxMlhqnYbvHQ--.48099S3;
	Thu, 16 Jul 2026 09:21:55 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: iommu@lists.linux.dev,
	jpb@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/virtio: Handle iommu_device_register() failures
Date: Thu, 16 Jul 2026 09:21:57 +0800
Message-ID: <20260716012157.88769-2-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716012157.88769-1-xiongwm2026@163.com>
References: <20260716012157.88769-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCHriIxMlhqnYbvHQ--.48099S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zry8tw43GFy5Gr4xtr17GFg_yoW8XF4Upa
	4DCa95GrWUtFyfGay7Aay5ZF9Yvan2qay8XFWrX3ykWr15Gryjyr1ayFyUtw1fArWkGF42
	qw1vqa1xuFZ8uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jLpnQUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC8BNJ2GpYMjPg6AAA3J

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

