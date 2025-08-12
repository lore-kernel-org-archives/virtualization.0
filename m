Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50E248865
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755040832; cv=none; b=VVht1EBlDjzzOAOI1dJsxLIQ1JuzLoBZlkl8kIwCc47nZ7XaJ8Zwq7qcM21a1QI+VnXFhUP0B5GDPNjq5WFCyfDH5IwO6sjptwZ9cjx8bP+f4VPXIOLg35CNwB/kTly3k95SNhyfQzUCYl4OTBaMbQaaXYXkCKifFOqFTkra2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755040832; c=relaxed/simple;
	bh=wle9r2gsnhO7JaaLb1bCPkD7qWWf9Zu+D8DM/DNZTjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=NRHcIb8kZ3kl2yzRidkRGonGn/Vp3YQV9F4I/Wg5VvOVhJ3ep9BR33TqxIlH9c6FHaJM7MgKQNjZj92EzSy0q3Icyp/is6/SjXsKoL0Bdv6MCEkc4C5bk5LrmSBH38JKlbbDCftHDftORra/RAoi6IGcFDuqP0ZZqlgz7c4gFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mJ6NWbR4; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mJ6NWbR4"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250812232025epoutp04ab9fad932be67dad5c3e508758990065~bKFUflnkZ0502605026epoutp04D
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 23:20:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250812232025epoutp04ab9fad932be67dad5c3e508758990065~bKFUflnkZ0502605026epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755040825;
	bh=eLnMXqyfqg1qktU4SrlD9F/Y1gqGVc8jfzRmVy/nmCI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=mJ6NWbR4xW/U2R+s6Bm5+nLKokzqV2QSbhXzQ3mPfyMLFkWFypuFCALoqQUEFhoJ+
	 RbR1s1PMwnY7pnKcMoCOACQ0/kFtgywyNBRe208RuEvxAYO+jqgxHIFlmVmpOrN2H0
	 EEx7y0S6JS5csMWhxkcPHCR+qDeknC4li70ePqD0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250812232025epcas5p14d7f42eedf5b2403536eae76232f848d~bKFTxM57n0474904749epcas5p1D;
	Tue, 12 Aug 2025 23:20:25 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.92]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c1nY42bxGz6B9mF; Tue, 12 Aug
	2025 23:20:24 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250812095108epcas5p3aebdbf9e790cd259173d54611652a97b~a-CuL4_aG1911819118epcas5p3b;
	Tue, 12 Aug 2025 09:51:08 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250812095107epsmtip14a9258f84c8573280a6948e6f6ea6767~a-Cs27tkY0384203842epsmtip1B;
	Tue, 12 Aug 2025 09:51:07 +0000 (GMT)
From: Ying Gao <ying01.gao@samsung.com>
To: kraxel@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	ying123.xu@samsung.com, lei19.wang@samsung.com, liping.qi@samsung.com,
	junnan01.wu@samsung.com, Ying Gao <ying01.gao@samsung.com>
Subject: [PATCH] virtio_input: Improve freeze handling
Date: Tue, 12 Aug 2025 17:51:18 +0800
Message-Id: <20250812095118.3622717-1-ying01.gao@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250812095108epcas5p3aebdbf9e790cd259173d54611652a97b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250812095108epcas5p3aebdbf9e790cd259173d54611652a97b
References: <CGME20250812095108epcas5p3aebdbf9e790cd259173d54611652a97b@epcas5p3.samsung.com>

When executing suspend to ram, if lacking the operations
to reset device and free unused buffers before deleting
a vq, resource leaks and inconsistent device status will
appear.

According to chapter "3.3.1 Driver Requirements: Device Cleanup:"
of virtio-specification:
  Driver MUST ensure a virtqueue isn’t live
  (by device reset) before removing exposed
  buffers.

Therefore, modify the virtinput_freeze function to reset the
device and delete the unused buffers before deleting the
virtqueue, just like virtinput_remove does.

Co-developed-by: Ying Xu <ying123.xu@samsung.com>
Signed-off-by: Ying Xu <ying123.xu@samsung.com>
Co-developed-by: Junnan Wu <junnan01.wu@samsung.com>
Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
Signed-off-by: Ying Gao <ying01.gao@samsung.com>
---
 drivers/virtio/virtio_input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index a5d63269f20b..d0728285b6ce 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -360,11 +360,15 @@ static int virtinput_freeze(struct virtio_device *vdev)
 {
 	struct virtio_input *vi = vdev->priv;
 	unsigned long flags;
+	void *buf;
 
 	spin_lock_irqsave(&vi->lock, flags);
 	vi->ready = false;
 	spin_unlock_irqrestore(&vi->lock, flags);
 
+	virtio_reset_device(vdev);
+	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
+		kfree(buf);
 	vdev->config->del_vqs(vdev);
 	return 0;
 }
-- 
2.34.1

