Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBD37C0E2
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299650; cv=none; b=gwFnLGoyydnjEg3fXChSSXDLIdboIq7aC+dNppt2/ji3/QfrO5PGXYMh6m9raT/iPkbPEOfQLaFy2bNLc4H847tAGjARkMPAvbeWqfgyCth+LY9YLyy3hPuJ6S1Jw2CbxP7WjZ2aE47qV5yC1BpVIb6beGt4BNBbR9IyYcT0DlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299650; c=relaxed/simple;
	bh=UpSklniRYvM1jOwXC9qKeQR408LhTPkVknKi5vZdDBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pE8b9xGblhmgAN/zsgUFnnJButOk5qKMUJUcWUEu0zCurYdh1MMQiiQDtyIR5cLggL89TrrBjxko3DwGea15FQRbedhXjWDpSTUc/OP68z7VbiYmrUuzKla4N+lUdvdQHAMZv/glOyahB0ZZphnZBelNL/kEWH8QM84LnxFmhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=OI8HKH09; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="OI8HKH09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786299648; x=1817835648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o47xSUAJjSkI+7xfGGQqd+W9hTYM04zaBrXdkO5FaB4=;
  b=OI8HKH09E8gnKhpXlokfJ1ktvvUl7NHnrNfHufJy9/ImsYeS3dLX737M
   TfIdb7LeLrIcw5XlDthGRjDeFRYEx3M0UzJTxQaspDKZnSMZoBAMWUWWK
   wywx8DnTusr/ByICvGZ49oa26uF+EzYbnJ7xFNyp0NbGBQi4KG7CH2qjK
   U8R+FLIZGwhlyJASTbcOJEbXHbGbU/oKipXHp34F3o4khOHTB0ya8WGt9
   LA2kqYpF9zO6EUgL3lDPCPTffE1hskx/ftFrbvbOiKhuZR87N5Qq+W7nq
   u1vEjZygkYRr74iBRYrrlXAvS0ckyxNFoHFM0pm6TH4yVo1oclYoKOkgr
   Q==;
X-CSE-ConnectionGUID: KfApvsFoTF2O23nk8nFfag==
X-CSE-MsgGUID: Y3OG7g5RTJGC1nVjhhq4ug==
X-IronPort-AV: E=Sophos;i="6.25,214,1779148800"; 
   d="scan'208";a="25415435"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 18:20:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:25043]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.103:2525] with esmtp (Farcaster)
 id 69ba2a84-8ff1-4856-af59-f9de74bbe5fd; Sun, 9 Aug 2026 18:20:46 +0000 (UTC)
X-Farcaster-Flow-ID: 69ba2a84-8ff1-4856-af59-f9de74bbe5fd
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:20:46 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:20:44 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 05/12] virtio_pci: create virtqueues with the device's mapping token
Date: Sun, 9 Aug 2026 18:20:03 +0000
Message-ID: <20260809182010.32931-6-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260809182010.32931-1-graf@amazon.com>
References: <20260809182010.32931-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
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
