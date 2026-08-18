Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D633246ED
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087729; cv=none; b=Up0gJUJR2mQd9QQePqFcu5lZgOx4SqOGOyeJUtZwJV1QE0u8dF2beSmWNJzr0fkjLcCGry/sPS42EhMKyXCo4OYxgjxBILf8EZ1XscLE/7g8nw1PgjH3OzJ1vPDhQ1KJet2MKpGPW7HGn8KdxdJ7gWizp1iuN3P780G6NBqeEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087729; c=relaxed/simple;
	bh=UpSklniRYvM1jOwXC9qKeQR408LhTPkVknKi5vZdDBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/UzfCU/fjkebFNF3MYpPYsVDLQyEeH2BOoRZX7tUqMwJd9UKdMg4ORueTAcXLly4D1lH110d87gXV/EOO/rC+JEU6lrIUniANFHrJOJN1S4YhPRFDFoaoDtmn26TUomGEL8zP+8twL+MJi3yxO2078lpfPv1FfYpVy3cl8I1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XUviivi/; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XUviivi/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787087728; x=1818623728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o47xSUAJjSkI+7xfGGQqd+W9hTYM04zaBrXdkO5FaB4=;
  b=XUviivi/KHejIMU1vUEaASiMkH8E/3eEjLoRK5Yw/iOpKA+QwW6l128u
   sOZQ1//bUrM+CUO5DwOO87mOg/qc1PyOHnlOa1/6MzZpW7vju1A52pCj6
   ExUt5UnaPNrKH77NiqCdEMm3JO99ORLkVXAO1AKNvQ64D0sCqEl9z1jJz
   KiUK9vOLrs9Pp1mmWaiLSV0AgDAXczvgRN5iLRxrMXY9mZk8kca2OjGz9
   UUdPoaysymbxTkQbh3lFgnvHAe6LiflneYRF+dayUUl//K1VI6/UI2oLs
   lgPf55CdJUmZ1ppaoURKb1OSOd2RHs/7SEGgCLZq65s2Xa1jpcyMCiXg6
   w==;
X-CSE-ConnectionGUID: PKClyeekQ0OIf4ZIUrvyIw==
X-CSE-MsgGUID: OkK49BPsQeONpNwhvoEmhA==
X-IronPort-AV: E=Sophos;i="6.25,230,1779148800"; 
   d="scan'208";a="25815678"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 21:15:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:14469]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.125:2525] with esmtp (Farcaster)
 id 48d7a6b4-befd-4e9e-b850-31022b552380; Tue, 18 Aug 2026 21:15:27 +0000 (UTC)
X-Farcaster-Flow-ID: 48d7a6b4-befd-4e9e-b850-31022b552380
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:15:27 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:15:25 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: <nh-open-source@amazon.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 07/12] virtio_pci: create virtqueues with the device's mapping token
Date: Tue, 18 Aug 2026 21:14:20 +0000
Message-ID: <20260818211425.91009-8-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260818211425.91009-1-graf@amazon.com>
References: <20260818211425.91009-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In preparation to support VIRTIO_F_DMB, create the modern PCI
transport's virtqueues with the mapping token held on the
virtio_device. Every mapping call for a virtqueue is handed a union
virtio_map token, and vring_create_virtqueue() derives that token as
{.dma_dev = vdev->dev.parent} without letting its callers choose.

Set vdev->vmap.dma_dev in virtio_pci_modern_probe() and create the
virtqueues through vring_create_virtqueue_map() instead. That covers
both the virtqueues from vp_modern_find_vqs() and the admin virtqueue,
which go through the same setup_vq(). virtio_pci_probe() assigns
vdev->dev.parent first, so the token holds the pointer
vring_create_virtqueue() would have derived.

The legacy transport keeps its own vring_create_virtqueue() call:
vp_legacy_get_features() reads 32 feature bits, so VIRTIO_F_DMB cannot
reach it.

Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virtio/virtio_pci_modern.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..565d37b630b3 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -715,10 +715,11 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	info->msix_vector = msix_vec;
 
 	/* create the vring */
-	vq = vring_create_virtqueue(index, num,
-				    SMP_CACHE_BYTES, &vp_dev->vdev,
-				    true, true, ctx,
-				    notify, callback, name);
+	vq = vring_create_virtqueue_map(index, num,
+					SMP_CACHE_BYTES, &vp_dev->vdev,
+					true, true, ctx,
+					notify, callback, name,
+					vp_dev->vdev.vmap);
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
@@ -1289,6 +1290,14 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	vp_dev->isr = mdev->isr;
 	vp_dev->vdev.id = mdev->id;
 
+	/*
+	 * The mapping token every virtqueue of this device is created with.
+	 * This is the same value vring_create_virtqueue() would derive from
+	 * vdev->dev.parent, kept here so that a transport feature can replace
+	 * it in one place.
+	 */
+	vp_dev->vdev.vmap.dma_dev = &pci_dev->dev;
+
 	spin_lock_init(&vp_dev->admin_vq.lock);
 	return 0;
 }
