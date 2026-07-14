Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613B9309DB1;
	Tue, 14 Jul 2026 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997430; cv=none; b=q+H7AHrjniSd5ftr7Wz77cxCbVxOxOrAWePpYhGWBTbdvHaX9y1qfehuG7AqRpnD2UXAis+PRMfe6OndPLSLFuPHNy6OPUopZdQQko8QFUAgRAgt6sRU/Ty7MZcvQNWpsuGU5TI8LY4qJ3NrMpFCO2I1gOBi55VCtYHoZaIWwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997430; c=relaxed/simple;
	bh=ya/eCWkRFhoEVs1Rvnde76R0Tdx+naOW1iFvHff1a2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meN6y+XQbedjcK6u84UOWuadCdueb9VTsUJhi6ZNq6J5fyzyuvzrM84MpD4fjwRuKrBoSGybYfnElyhkKSGeAirdMziRZG5CkK5hl9UM2lLNME2ZC7dsebaDVp0+FyxSC0Oqb0ordLyLc1UXQEr5TI3geoJgFeno92R6LKnw9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hVlp7HNF; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hVlp7HNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qc
	nLT+eEmwVk5tjFJsgW+fJ2wvhyEu0DistlKj3OBsQ=; b=hVlp7HNFjF+dGXn88k
	IehBxKCo5lt83mJXnvUMBBOA0oiB1FP1p7W65ZLP32/CJErUdVn/Vm+XmH8aHouX
	SLh8pZ75mEa5MNjApCMxZgfakleJGExJUTVkT/OmOA8DGXyUugjwKZCEw9RBZcnn
	HPUofy9pL3QEBmkcKXHwo1SeA=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCXNQLNo1VqB9jsJA--.61058S3;
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
Subject: [PATCH v1 1/2] iommu/virtio: Avoid use-after-put in viommu_get_by_fwnode
Date: Tue, 14 Jul 2026 10:49:48 +0800
Message-ID: <20260714024949.190014-2-15927021679@163.com>
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
X-CM-TRANSID:_____wCXNQLNo1VqB9jsJA--.61058S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW5Xr4UGFWUZFyxGF17Wrg_yoW8Jw18pr
	y5Ga4DKrWUGF1xK3WxJw43uF1Yvan2yayfAFWFq39Ygrn5K34UtFyYyFyjqw1fArWkGr1a
	qw18Xa4vkrs8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5HUDUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8xcOlmpVo9ffiAAA3g

From: Xiong Weimin <xiongweimin@kylinos.cn>

bus_find_device() returns a device reference that must be released with
put_device(). viommu_get_by_fwnode() currently drops that reference
before dereferencing the device to fetch the virtio-IOMMU private data.

Fetch the private data while the reference is still held, then release
the device reference before returning.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/virtio-iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc1319..342785c76 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1009,12 +1009,16 @@ static int viommu_match_node(struct device *dev, const void *data)
 
 static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
 {
+	struct viommu_dev *viommu = NULL;
 	struct device *dev = bus_find_device(virtio_bus_type, NULL, fwnode,
 					     viommu_match_node);
 
-	put_device(dev);
+	if (dev) {
+		viommu = dev_to_virtio(dev)->priv;
+		put_device(dev);
+	}
 
-	return dev ? dev_to_virtio(dev)->priv : NULL;
+	return viommu;
 }
 
 static struct iommu_device *viommu_probe_device(struct device *dev)
-- 
2.43.0

