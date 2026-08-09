Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B34C36EA98
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299675; cv=none; b=jAEPIYC6J3G21XMfc3o1x8oCi9OQsnkdWN9wp+WyZqVQmwbpVJaNup1CEA2Hd9hBT+MybJNgoyqeiXgm6u8WVq8OTTMYeZt2VkglM4BUElhcxmMpTG1h2CBEE0ZvjveIoVwbGOyewt+7BYaZn7Gt2Bkd81eKNd806M+wBAdxaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299675; c=relaxed/simple;
	bh=DwdVTtlzCwZuXZ5o0jAjWpgCQVfr1NQNncmvuqraSiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTW6MBh8k6CWdV5qcadGh1U1udkQ86e1BmLllxMxDVX+q3mhv4s+403K+s9/FkmYL9uSEsPnd0JIKObVKlFWwt8712QbUGhwbk6w5M4kjEDtk1ZCRFVFIwxnyWMLCy9XDFmCpYG5vY3Gind42BdE1CNEbcz3NNKZveE5mtL6rZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=oWkF6xv5; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="oWkF6xv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786299674; x=1817835674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bpQw20GqOuyWGdONApxpPST+oYpdx2tqLi8GETl/AjY=;
  b=oWkF6xv5QS5IlrZcINdW9anrezFMTLfUOlr7qCF23MIakjsNixuBZ5ZR
   s00rNB0jswCSxBLEMzB0rMWqCDOGyaajBa0Mua0f7nZ2fWcZdIEVE+9it
   yX5GGGr3xjY8QP6bIEXZTO5INMCkf8zeFK0yJO+akiYb2wB0oInwgJEJ2
   mYqUbWlVSeo7CnhxECbWziSyyO1+tkrgXgchjPhdKQbXKDcl8whT9yd8q
   QOkHrRl5ON82eVG5hT+gAaihqi7uM5p0qdY0uQt/R+tisgzXZD9EAetnH
   0k3zOP0/sblSrRZ3K1JuwGxMX8F4++b0H+cJTl3GevDqCuWruJqgKxt8v
   w==;
X-CSE-ConnectionGUID: BEW7+jOIS+ifnG2NDroeVg==
X-CSE-MsgGUID: fWZ+dlnpQsyaFJ8h2NSJHQ==
X-IronPort-AV: E=Sophos;i="6.25,214,1779148800"; 
   d="scan'208";a="25521004"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 18:21:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:28835]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.32:2525] with esmtp (Farcaster)
 id 6cd55a81-4f58-4ea8-a5da-8c84cfc45e04; Sun, 9 Aug 2026 18:21:11 +0000 (UTC)
X-Farcaster-Flow-ID: 6cd55a81-4f58-4ea8-a5da-8c84cfc45e04
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:21:11 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:21:09 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 07/12] virtio: locate the device memory buffer after feature negotiation
Date: Sun, 9 Aug 2026 18:20:05 +0000
Message-ID: <20260809182010.32931-8-graf@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In preparation to support VIRTIO_F_DMB, locate a device's Device Memory
Buffer once feature negotiation is complete. The shared memory id that
locates the region may only be read after the device has confirmed
FEATURES_OK, and finalize_features() runs before that.

virtio_features_ok() is the one place in the core that has just read
FEATURES_OK back, so locate the region from there, and release it from
virtio_dev_remove() and from the error paths of probe and restore.
Restore and reset completion reach it too, where virtio_dmb_init() keeps
the state of a device reporting the region it had.

Suspend and reset need no handling of their own. Neither
virtio_device_freeze() nor virtio_reset_device() deletes a virtqueue,
and a live virtqueue holds addresses inside the region, so we keep it
across both.

Link: https://lore.kernel.org/virtio-comment/20260804161202.38619-1-graf@amazon.com/
Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virtio/virtio.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 299fa83be1d5..6f112593566c 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -8,6 +8,8 @@
 #include <linux/of.h>
 #include <uapi/linux/virtio_ids.h>
 
+#include "virtio_dmb.h"
+
 /* Unique numbering for virtio devices. */
 static DEFINE_IDA(virtio_index_ida);
 
@@ -231,7 +233,14 @@ static int virtio_features_ok(struct virtio_device *dev)
 			status);
 		return -ENODEV;
 	}
-	return 0;
+
+	/*
+	 * Negotiation is complete, so a Device Memory Buffer may now be
+	 * located.  Reached from probe, from resume and from reset
+	 * completion, all of which have to end with the state matching what
+	 * the device reports now.
+	 */
+	return virtio_dmb_init(dev);
 }
 
 /**
@@ -361,6 +370,7 @@ static int virtio_dev_probe(struct device *_d)
 
 err:
 	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	virtio_dmb_destroy(dev);
 	return err;
 
 }
@@ -377,6 +387,8 @@ static void virtio_dev_remove(struct device *_d)
 	/* Driver should have reset device. */
 	WARN_ON_ONCE(dev->config->get_status(dev));
 
+	virtio_dmb_destroy(dev);
+
 	/* Acknowledge the device's existence again. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 
@@ -650,6 +662,7 @@ static int virtio_device_restore_priv(struct virtio_device *dev, bool restore)
 
 err:
 	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	virtio_dmb_destroy(dev);
 	return ret;
 }
 
