Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8EF23ED60
	for <virtualization@lists.linux.dev>; Fri, 26 Jun 2026 02:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782439568; cv=none; b=ETh8mxVK3xNMWwcVsJafhX87/oHtCR8pXdroq2FA3OnI4G6eShuRUz3U5+PekmtXaBwecqNcLh/Di4kcVCWTWq70xZqFJnwt+9ACK0+mne+b/d6Z5ZFBr6oX1XpuSKSK2VadIpXJZiSoKyMLVZ8fiUBmdOZ4O5BT+RzQ1LYa61w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782439568; c=relaxed/simple;
	bh=4FXp5PQVJ76PQWdQb9EUxvO1upRB+jeYLoezL3xQtFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6n83EnZRe6xOMNO4xh0PbNWKAtNMamaM83gtFNSBxg02njBOqsb+u30/bXcUqgOCSxD1X6rVeeKAU5Xx2JNZMTxuaW3kXNtXg8YvnymA3So6hjXHqX8ErZY+WEGjzpjrXhPLGbXR3788qx+Rqcde6n7kDnt33im91E4hkl5dyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mUlO9m/l; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mUlO9m/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cH
	7aFmRWGYY6CfpfEv2VdnHPQeojmPM4ZBgcF3Q7Xgk=; b=mUlO9m/lOvAwJ8r7w4
	wNYCMmUDGDTNcc6Ccw3BMco5L8dFMzOdr0pWCbwAmR9f080rKTln06lIO2jZzTKZ
	7M249aSNZ7qNOwwokSaGTj84tNdY/u6/lg51EJ8zG1OVd+yHdZyJVvP12QGw/r/S
	0jV+lNiu8q3rBFzKfcGoChIy4=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBn4SB83j1qWhWLEA--.17305S4;
	Fri, 26 Jun 2026 10:05:55 +0800 (CST)
From: Xiong Weimin <15927021679@163.com>
To: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH 2/2] vdpa_sim: hold iommu_lock across dma_unmap passthrough transition
Date: Fri, 26 Jun 2026 10:05:45 +0800
Message-ID: <20260626020545.607600-3-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626020545.607600-1-15927021679@163.com>
References: <20260626020545.607600-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBn4SB83j1qWhWLEA--.17305S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy7Kw1fur4xKw13Xw1UKFg_yoW8Gw1Upr
	WjgFZ8K3WIqw48XFnrGw45ZF1vgwnYgF4FqF98tasrCrn8Jr1DXa93KasxXr1YyrWfAF13
	Z3WkJ398uFW7WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzUDJUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0QPBSmo93oNoDgAA31

From: Xiong Weimin <xiongweimin@kylinos.cn>

vdpasim_dma_map() updates the IOTLB and the passthrough (iommu_pt)
state under iommu_lock.  vdpasim_dma_unmap() clears iommu_pt and
resets the IOTLB before taking iommu_lock, then deletes the mapping
while holding the lock.

A concurrent dma_map(), dma_unmap(), or reset path that also touches
the same address space can therefore observe or modify the IOTLB and
iommu_pt state without consistent locking.

Perform the passthrough transition and range deletion under the same
iommu_lock scope, matching dma_map().

Tested-on: openEuler VM (6.16.8, /usr/src/linux-6.16.8)
Tested-by: Xiong Weimin <xiongweimin@kylinos.cn>

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -736,12 +736,11 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
 	if (asid >= vdpasim->dev_attr.nas)
 		return -EINVAL;
 
+	spin_lock(&vdpasim->iommu_lock);
 	if (vdpasim->iommu_pt[asid]) {
 		vhost_iotlb_reset(&vdpasim->iommu[asid]);
 		vdpasim->iommu_pt[asid] = false;
 	}
-
-	spin_lock(&vdpasim->iommu_lock);
 	vhost_iotlb_del_range(&vdpasim->iommu[asid], iova, iova + size - 1);
 	spin_unlock(&vdpasim->iommu_lock);
 
-- 
2.43.0

