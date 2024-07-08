Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93A3A1DC
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424917; cv=none; b=uHfOkz8HNBTUxCODo1Sah61O5BeACStgP9r6TmqFUn/EkyKLfcggEoSQIi3Q4s96NdKWrpESj9WGCdUWkSmMFLcMGTHC/ItMoJ7zgZGUeTzvloWGj/WVGnEmEDytQngk8ES0EZr1Rg9/ihs0ykp5i/Z7vi37Q0N9+Lwr5DH1u9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424917; c=relaxed/simple;
	bh=LoTagj27334PEVm2uZnnPAKRI46dp8/+UIOr8P9j1DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGi3T3tM5SemzetBAEUD9EQitxq2rGv1sytJy/51NyDrfz68lfIBmfo4nfEvw2SztP7jfTPYQHhjI7gin5AhoxQp8VWaRf/bcLlmyImKNkkN3GeDmB8xEQQw1gJ24yvLXokBuuNZ9Fsc3VvDRIMPranL70hp8Bugyeio0mJAhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hymF7pWB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hymF7pWB"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea952ce70so1772668e87.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424914; x=1721029714; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGLbDU2Wxnhi5/g0YKI0ZvQpGjuefDEKag9AESbm88A=;
        b=hymF7pWBEmGv34PvaxYr0HP8mfIUR/pQPz1FXIMu+uxPitI886++6S45AiLFZZUIQ4
         gfHhng1yDYAQ8Ght8YXHEcepSeau66Rqtg0xwOsgOYozt7zkdtJkbVB1hkobngfPdRuj
         C5xO0lSmxOZOnKYtL22uHFixLWBCYwrTchCUcmk1rlEMG55tUnVQ0/5+mTLf83Jk9WyQ
         HCMUNj67MkTWWXcu/SIFZrYEBn5BxWTpTKFiuz3/OFD7vjSKKoKJJz3D8Oo+GlscvKbg
         Z2IhmpJZClzWpFCUInn6Ec9Rh7fAtRUX4p5ItWWu52tljvRfoeGTjMMBhAz48eO89Zvo
         zejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424914; x=1721029714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGLbDU2Wxnhi5/g0YKI0ZvQpGjuefDEKag9AESbm88A=;
        b=KtfjYh3Vnz1UqU+ciBdRPL4SkOpuIich3VVeTgcn7yhHpf66vrY/NlJqw4SOKa4Ztf
         TQf+6t6jQomy3zckAhyfTFMpXBwMEesdS3gn5SF04JQtWsmEX027hC3+NVcR96TGv6aj
         mpn7/dSZwxMHfBgvKOsIl9KxhmauIIUTjMMCh/FeD5K6+fYqr41m19m71mAcLTFO+yIQ
         F3U9kvMObiMNI3dcEg77fg3ppGiHGQV98Ta5r4Qlkbf8Ua1Nz+YIfQYxZVB9vvzgOTEM
         49SR6/F66aZcfOO9nl7Wm71Zm3MEZv0R/QqKU8YIpWGXRq7Pe+I+a9JYhRJKGnR7yBIb
         2W1A==
X-Gm-Message-State: AOJu0YwVon1x92FRsRWx9WjV7iwOz0k7d5yVVlYPKtq3STsTXkZ7V8es
	TcG1n0ITDFm6vS/V2MhAKG3s/AQ1cTfRfb8YzbjJiLqL2scGLH2tqHADX68cRb2xiI3U+XBSpbE
	SBSg=
X-Google-Smtp-Source: AGHT+IFvUmRIiOOg2GlecD98ulFvqWDFLoEg3f0ek0OkfGoeFI2kgUhw2J4AatdU5Z+/ncuLs/HwGA==
X-Received: by 2002:ac2:4989:0:b0:52c:d56f:b2cc with SMTP id 2adb3069b0e04-52ea06d30d0mr7391305e87.58.1720424914192;
        Mon, 08 Jul 2024 00:48:34 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a28d3dasm154973645e9.46.2024.07.08.00.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:33 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 10/19] virtio_blk: convert to use virtio_find_vqs_info()
Date: Mon,  8 Jul 2024 09:48:05 +0200
Message-ID: <20240708074814.1739223-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708074814.1739223-1-jiri@resnulli.us>
References: <20240708074814.1739223-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of passing separate names and callbacks arrays
to virtio_find_vqs(), allocate one of virtual_queue_info structs and
pass it to virtio_find_vqs_info().

Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 drivers/block/virtio_blk.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2351f411fa46..ca3446503e82 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -964,8 +964,7 @@ static int init_vq(struct virtio_blk *vblk)
 {
 	int err;
 	unsigned short i;
-	vq_callback_t **callbacks;
-	const char **names;
+	struct virtqueue_info *vqs_info;
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
 	unsigned short num_poll_vqs;
@@ -1002,28 +1001,26 @@ static int init_vq(struct virtio_blk *vblk)
 	if (!vblk->vqs)
 		return -ENOMEM;
 
-	names = kmalloc_array(num_vqs, sizeof(*names), GFP_KERNEL);
-	callbacks = kmalloc_array(num_vqs, sizeof(*callbacks), GFP_KERNEL);
+	vqs_info = kcalloc(num_vqs, sizeof(*vqs_info), GFP_KERNEL);
 	vqs = kmalloc_array(num_vqs, sizeof(*vqs), GFP_KERNEL);
-	if (!names || !callbacks || !vqs) {
+	if (!vqs_info || !vqs) {
 		err = -ENOMEM;
 		goto out;
 	}
 
 	for (i = 0; i < num_vqs - num_poll_vqs; i++) {
-		callbacks[i] = virtblk_done;
+		vqs_info[i].callback = virtblk_done;
 		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%u", i);
-		names[i] = vblk->vqs[i].name;
+		vqs_info[i].name = vblk->vqs[i].name;
 	}
 
 	for (; i < num_vqs; i++) {
-		callbacks[i] = NULL;
 		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%u", i);
-		names[i] = vblk->vqs[i].name;
+		vqs_info[i].name = vblk->vqs[i].name;
 	}
 
 	/* Discover virtqueues and write information to configuration.  */
-	err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, &desc);
+	err = virtio_find_vqs_info(vdev, num_vqs, vqs, vqs_info, &desc);
 	if (err)
 		goto out;
 
@@ -1035,8 +1032,7 @@ static int init_vq(struct virtio_blk *vblk)
 
 out:
 	kfree(vqs);
-	kfree(callbacks);
-	kfree(names);
+	kfree(vqs_info);
 	if (err)
 		kfree(vblk->vqs);
 	return err;
-- 
2.45.2

