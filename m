Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B737BE89
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087754; cv=none; b=qdSClbVDfHYQJMy0xJdGc4ZD3asdXyNMm2M9TUAxLHVODCDgNqyKj+h7jsH0QHzg7vipiqVLYxL2XANnf4KOZ3F6ElpjiVIETgSFBZLkRsnkD23NbYjFJ7o2wnzTkQ22mJZAEw4MQhQBgEiBETmjK1BHxyaPjjphQP5E3MmWW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087754; c=relaxed/simple;
	bh=hFhfo1qmJczk77D48uqPHmvc3DZR6fmR0eCZaaTfSp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnyYSA9Zpq98O07IL/YwUekUCWv6S7Qw0yR8LVvzKs5IuvfCzaxzI0VwKIXjzwCiag71n4C00LGOdxkK7F8FvhRYwRARyQbXLk7ejZLYfcB24cSeQSd6EJ2ndgfR3SHko6dMTCZHWoleUyT758Z/9ksXfnr+CWXjjDpCWp/KI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Re0uMMtD; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Re0uMMtD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787087753; x=1818623753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rms5GYZfN8tDG5yknKVSI6Ej0W0ziO7S6G3V2Bq9RLU=;
  b=Re0uMMtDmc3jxkQItA3j+XV4zB5iP19pGYoDi33G2zHZgrsMCsLSNOh4
   NH9CTvnG0kr4v2fYJHk3gqDGa7U+V0WskqL9GQJQjasAsKYlX5RU3G0IG
   +Q/jlq6czO5Sp+BXFKVeA8IRGllm0rpBEEwI2zTMpoaF1bN92eSfd9e15
   k8f4InDSCvq4hOpiaBV4xY9QP9CeOJdaJUpJMO7J/8ouTeNrK7gQ2CgXI
   tRT2PJReXx1Iv+doIG45xuac7Y36H/56rs1yw+OuHw/nUKzn0n0OSlmZ+
   f5+Vd1rowFWGT40c6g7kyO7g3pRl8JpsbVYDNx6jjG8LPkVmITcmczJ1R
   Q==;
X-CSE-ConnectionGUID: hVAajqChTamnJIWaZ9bG6Q==
X-CSE-MsgGUID: bCo++juMSeKjgkNJscjPEg==
X-IronPort-AV: E=Sophos;i="6.25,230,1779148800"; 
   d="scan'208";a="26314453"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 21:15:53 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:23872]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.125:2525] with esmtp (Farcaster)
 id 163e9c7c-5df3-4f63-9cd1-eaeda854a33d; Tue, 18 Aug 2026 21:15:52 +0000 (UTC)
X-Farcaster-Flow-ID: 163e9c7c-5df3-4f63-9cd1-eaeda854a33d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:15:52 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:15:50 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: <nh-open-source@amazon.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 09/12] virtio: locate the device memory buffer after feature negotiation
Date: Tue, 18 Aug 2026 21:14:22 +0000
Message-ID: <20260818211425.91009-10-graf@amazon.com>
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

In preparation to support VIRTIO_F_DMB, locate a device's Device Memory
Buffer once feature negotiation is complete. The shared memory id that
locates the region may only be read after the device has confirmed
FEATURES_OK, and finalize_features() runs before that.

virtio_features_ok() is the one place in the core that has just read
FEATURES_OK back, so locate the region from there, and release it from
virtio_dev_remove() and from the error paths of probe and restore.
Restore and reset completion reach it too, where virtio_dmb_init() keeps
the state of a device reporting the region it had, rebuilds it for a
device reporting a different one, and refuses a device that moves its
region while its driver has virtqueues.

Suspend and reset need no handling of their own. Neither
virtio_device_freeze() nor virtio_reset_device() deletes a virtqueue,
and a live virtqueue holds addresses inside the region, so we keep it
across both.

Link: https://lore.kernel.org/virtio-comment/20260818060255.6853-1-graf@amazon.com/
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
 
