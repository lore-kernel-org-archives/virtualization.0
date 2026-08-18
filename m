Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9C3246ED
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087759; cv=none; b=bKHMTxEQywBXHdgPYkTG7C0h1Nf7p31q6aQD90kE9TYF+b/pVaDjz+dAcG/GgWNoLg/x4/qSDGgqntsFOtKiLaLkDA1tOLUITl69Zkie758gn3ReZEje5h62XYA8NfS5jPZinKjFgrWh0Vt71a6Pn2+Wjl/+AQBCGVIkphWgXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087759; c=relaxed/simple;
	bh=jVcH6Wsupn5DBIilMkTCHDkuUSNpxfqRh7PNdJYWbbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUftCslyoB0VIjvFaS5GMsJjYyCCCfQ1DXk22f1Nt1H6vxMNnY691guJ3PO6x3xsfg2iO/vTfL4IPLtdrdx5WBzF+crvQozqzb1ZpwZCiemx8Be1EQz4/EdiPXBAhQsku7ryK7OsqPimm2PZiW9I1rBUMmgH6A4DUifN6D36yoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ptwVQovK; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ptwVQovK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787087757; x=1818623757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SMl964+VuEdQ+kdMmQdr+L+1tQWG1cOYnzIddgp1mbA=;
  b=ptwVQovKKHyXkQTixbn1f/jdX3C5E83dfXcCXOG0uTJ3zJ2wXTFw024J
   hjqsYPR8sR/ikgA32Q2MZlqq4PXdY83VNf3UWqhfqTRQegSy8J8ozIOOW
   Rkmaw6UTHG30ty5UQ/ecLYoDWHRiHF+5fpsCTKdU0lMg+HPsS1CR5hcQw
   jpGm4i6f/hzMoTGsKPrMRBAnEqmG3BcXs2mzYzkQeJfvuAnmZKyj8Ld1q
   Z07R2L/dBkHXR4cT3TrWHK5nrkEGyjmJdTFfMIWeBjwy7ViNWCOs5xNf7
   9r5UxrTMLMycIDBwVTSXmaQADm6xtPwI5nSRC9GHSwu/RvEzvbPqtjlXG
   Q==;
X-CSE-ConnectionGUID: itHiuH+kQCmdwRj+/diMYA==
X-CSE-MsgGUID: PBJwH3oIQxWRKKdQkl7QeQ==
X-IronPort-AV: E=Sophos;i="6.25,230,1779148800"; 
   d="scan'208";a="26072096"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 21:15:54 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:13090]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.84:2525] with esmtp (Farcaster)
 id 38a876b2-e40f-47ae-bf0d-091448d0ff76; Tue, 18 Aug 2026 21:15:54 +0000 (UTC)
X-Farcaster-Flow-ID: 38a876b2-e40f-47ae-bf0d-091448d0ff76
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:15:54 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:15:52 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: <nh-open-source@amazon.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 10/12] virtio: treat VIRTIO_F_DMB as implying VIRTIO_F_ACCESS_PLATFORM
Date: Tue, 18 Aug 2026 21:14:23 +0000
Message-ID: <20260818211425.91009-11-graf@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In preparation to support VIRTIO_F_DMB, read the platform DMA bypass
quirk from either feature. The data DMA of a device that negotiates DMB
is routed through the IOMMU in front of the region it owns, so the
driver has to map every address it publishes through virtio_map_ops.
VIRTIO_F_ACCESS_PLATFORM asks a driver for the same thing, and
virtio_has_dma_quirk() looks only at it.

virtio_features_ok() demands VIRTIO_F_ACCESS_PLATFORM of a device under
restricted memory access, so accept VIRTIO_F_DMB there too.

Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virtio/virtio.c       | 10 ++++++++--
 include/linux/virtio_config.h | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 6f112593566c..3f9d4a3b5930 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -216,9 +216,15 @@ static int virtio_features_ok(struct virtio_device *dev)
 			return -ENODEV;
 		}
 
-		if (!virtio_has_feature(dev, VIRTIO_F_ACCESS_PLATFORM)) {
+		/*
+		 * VIRTIO_F_ACCESS_PLATFORM and VIRTIO_F_DMB both ensure that
+		 * the device does not access guest memory directly, bypassing
+		 * the platform DMA topology.
+		 */
+		if (!virtio_has_feature(dev, VIRTIO_F_ACCESS_PLATFORM) &&
+		    !virtio_has_feature(dev, VIRTIO_F_DMB)) {
 			dev_warn(&dev->dev,
-				 "device must provide VIRTIO_F_ACCESS_PLATFORM\n");
+				 "device must provide VIRTIO_F_ACCESS_PLATFORM or VIRTIO_F_DMB\n");
 			return -ENODEV;
 		}
 	}
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index a10d7c27a2aa..a30eb708046a 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -273,8 +273,19 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
 	/*
 	 * Note the reverse polarity of the quirk feature (compared to most
 	 * other features), this is for compatibility with legacy systems.
+	 *
+	 * VIRTIO_F_ACCESS_PLATFORM says that the device is subject to the
+	 * platform DMA topology and the driver maps every address it
+	 * publishes through that topology.  The device performs no direct
+	 * guest memory access, so the quirk does not apply.
+	 *
+	 * VIRTIO_F_DMB says that the device holds the virtqueues and the
+	 * buffers they reference in a region it owns, and routes its data
+	 * DMA through the IOMMU in front of that region.  The driver maps
+	 * through that IOMMU, so the quirk does not apply either.
 	 */
-	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
+	return !(virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM) ||
+		 virtio_has_feature(vdev, VIRTIO_F_DMB));
 }
 
 static inline
