Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F356D1AEFCF
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103604; cv=none; b=pMI90lipz/RVrIloi+AUAtQIMSHkyh4Q++mHOfoCo9GcTKJxFECzPnHH3bvEbrzfAK7L6T6nuSQHVOl7JGWJCwsvD9ASK4LQM3FTzV8i5UMmUpJ+lhnmZ18LGfA//fBpr1KJxZaglOwwd2betStSmyc/u2MxbuWGpEy77H26/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103604; c=relaxed/simple;
	bh=7XOPLSoeUCMBrLUDBatTfCcj6RIpLM8/52ujc7LXvHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2x/v1ToHpZViOjk8nCgKS31aE+0RsAkpxcCOghr+mKfOVBrZDg9w6/cxXpMIfrnDDhRj2GKBWet2kHPEeeUbYsntP1ZfXZKgyCWYu2S8mPGXLtwHNDTU193/Fb+NAKiL+xR6aA4xA0WBhUyIYPXlDxs/TV5ieZtveOxVOdofWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MzceAufe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MzceAufe"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36796d2e5a9so492116f8f.3
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103599; x=1720708399; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjvVaTKB+IhNdleV7FiBAC7Q7evTCKPLyyvmEihGxoQ=;
        b=MzceAufe4AeU0+djZWw+BdWY/CP98Utt2Cu2ApzTWGWkSIlPxVkfj05jerMAGoXadD
         ol4xiOCn3gPkjP7cCWlbEh9wspijzCXfbWIgpDLBT8j3OKm2zw53xUounnEiVxR0Nj4k
         C/0w9I1yy81hWumXfl32e2ihXHtYW67yO6X/wB3Hds8gKAsnKPUQ196/V+8D3r1gPryr
         uLpMF5+GfgjpRQXVTus5HdlqI/BqEWNW1TOBT7i0QlQPXIsp6ZB7KigwCjCLxe4m5CMa
         FvSAtKf2ON4yDIG/MmERU6QD+65GYx9z0D/yWD3zpXdqDJ7gKEDjmjLFj/b9voXPxycY
         jI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103599; x=1720708399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjvVaTKB+IhNdleV7FiBAC7Q7evTCKPLyyvmEihGxoQ=;
        b=qVNK0vaJs0FbEHJulOfq8ontnCaYwqYYJYjToesY8j6NFVT/OJqAAf483YbzzN69bY
         BSd6oMkzQyKoMqPn2We+5mWr5UN/zwkLWD41kMGJ9uav/xpy8qWfD3IhPkA+bFMFVsGi
         P1C3ohqO33+HFJfR1zU8DhDYxap/onKwsQn3NROZV9mDRrJ2JjAgtXz7zlfsbnMzgVyk
         +PaK85/jwD1pNv75dsOP9QatKLWAI2WxPDvJ3YLMKc1EVqEmzqqvTZ7abcgMFgx4JQVi
         +1JRu1Lx93N6P5Td8qlMYQSMVl50aBuBGTMptHU09ZJJ12dlw4AlRk7r2HKsezONNzwv
         12YA==
X-Gm-Message-State: AOJu0Yz87rYMY1zSpxcpVrI11xAaMgARjitbtbtzL+J7MFX8lJzoYRnD
	cqitU4Gj9PVwoiU06kFSchKx7tmtvGrzUWXgw7GXQlbYZ9P4MO3mjcjM9K6TslvwrmrsONt/efq
	eXvA=
X-Google-Smtp-Source: AGHT+IGbyA77oEc/6d8r6Bgw0JTP4AFEqpQDftwbRGNRvE1h3Bg8QQvAjf0BMh1+8tmcpHpe0xmTQA==
X-Received: by 2002:a5d:60cc:0:b0:366:ef16:2694 with SMTP id ffacd0b85a97d-3679dd67c7fmr1406333f8f.48.1720103599087;
        Thu, 04 Jul 2024 07:33:19 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367892a4817sm7016465f8f.10.2024.07.04.07.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:33:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 01/19] caif_virtio: use virtio_find_single_vq() for single virtqueue finding
Date: Thu,  4 Jul 2024 16:32:49 +0200
Message-ID: <20240704143307.1212454-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704143307.1212454-1-jiri@resnulli.us>
References: <20240704143307.1212454-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Since caif uses only one queue, convert to virtio_find_single_vq()
helper which is made for this purpose.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/caif/caif_virtio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 99d984851fef..7fea00c7ca8a 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -646,9 +646,7 @@ static inline void debugfs_init(struct cfv_info *cfv)
 /* Setup CAIF for the a virtio device */
 static int cfv_probe(struct virtio_device *vdev)
 {
-	vq_callback_t *vq_cbs = cfv_release_cb;
 	vrh_callback_t *vrh_cbs = cfv_recv;
-	const char *names =  "output";
 	const char *cfv_netdev_name = "cfvrt";
 	struct net_device *netdev;
 	struct cfv_info *cfv;
@@ -675,9 +673,11 @@ static int cfv_probe(struct virtio_device *vdev)
 		goto err;
 
 	/* Get the TX virtio ring. This is a "guest side vring". */
-	err = virtio_find_vqs(vdev, 1, &cfv->vq_tx, &vq_cbs, &names, NULL);
-	if (err)
+	cfv->vq_tx = virtio_find_single_vq(vdev, cfv_release_cb, "output");
+	if (IS_ERR(cfv->vq_tx)) {
+		err = PTR_ERR(cfv->vq_tx);
 		goto err;
+	}
 
 	/* Get the CAIF configuration from virtio config space, if available */
 	if (vdev->config->get) {
-- 
2.45.2

