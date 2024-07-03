Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4417625D
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010395; cv=none; b=EPer88abQDsclHi0FBJK7t2MqRKkPRtanerunLDGJqINt2kKZIWaNP5H9rsAA+1CbMqYRd4TYPaAUKcPPcWEaqKgT7tPWx39ChKPP7a+o+VhmYaoVoqtFjBN8Qp9x4P+rpSlQXXL46IZRvWAWHApqXUDL0TfpDL1lCgRU1vGKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010395; c=relaxed/simple;
	bh=ARad+eEPURdzVLoiZea+eI/GTUQ2C6N9Rq4H8TR4gEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyRVZI4iP+yvx07fsArpSGhMxxNVnymwCYGO90ASZQRLFYPcIvn/XvEeiCrhYpgMimdUb3zWhFncxuzzEVpMsZtHPcX16Xg8YwVOPB4L6xS31saJxQcXkIugTcnmxnn0jUlMRuK1aFi4OONGlyHtQaGH25delLjaKFs8zBI2A38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Cek1il8Y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Cek1il8Y"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4256aee6d4fso32715625e9.3
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010393; x=1720615193; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pCScZI30N5GHlLAZv0lF/7rp9rgC1bzDe5Mo7PiwH4=;
        b=Cek1il8Yt9XtW5F+y18/3VCDhlrQ93pevGfQvzpt/1+c/PHa1wLCZ5a1Dq/4apcBVy
         /HapitP3xVfp0USSBmZR5jbhV0Kluxi22QT5Jyy6M/rDasSrqmjyQbsqlzha+uWYkvFt
         wn9rH2Vq0wSh7svohLq04fBrULlFk6NfU8TGc09aqyDFN4n/RFwG/h6odCN55CHuQz7O
         YKMmYjSbBK4t2wOSdgrT0mxzgxVXisxmDf6/QEAR527X+rwkqAs/5N8raos+0aOipnAG
         vwLWP8S3PuV2AtZb/0Ne75U4eCa1g2d9OnMT2OC81wXN5HXEZ0+cuHAtYFpC8PNBtOAE
         IaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010393; x=1720615193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pCScZI30N5GHlLAZv0lF/7rp9rgC1bzDe5Mo7PiwH4=;
        b=GQN8UG7jUCzKkwk2apcWuEXGd9jEZlG2vlSB7Lge4hCDJ7otMx7VravZd/wpz1CHaf
         BRxNB730KwjnHxf8uy68dOW5R4q0iNpnB5TGh0Qs49iqv1jX9Ug2Z+uEvY4VWkCvs5tO
         GcAUY++tEbG8i8hCQ+ipC4KETzSMdMfnjerXOHnGPjUSzkLNVI6VqeMM/8MJ6tnFv679
         BnOLrUG4ePvY7pI48urA1HoB33q4r+yerDaT5uFechtTWcVLpsTuXFXO4jMgBUs9xI6Z
         uW4UcsfVHnGUn2Zg6TwaA/ltiaFvvPTtCGSDJHOkyiIrbtQcMO7z99yCTqGCW8HwWfvH
         fxww==
X-Gm-Message-State: AOJu0YzV3t3k/Kp3QvHLJ9FXgpaVrJQ3ziT7doACcqNj2YJxUGClGE9P
	Dn5CbLfSHf6ntG968CpdBeNiwzlQfF9MpOd68FE1jjmXpYCyCmrvulUg7nT1SJmIjE7FePcMxrb
	i
X-Google-Smtp-Source: AGHT+IGUDbFpl36LaF+/H9ES+hoyqAYMcYFAvLJ/jPNQs7sz9T3GoBf7ncjszCPceDu1HNYN3+BZWg==
X-Received: by 2002:a05:600c:35c6:b0:425:6b77:f5e0 with SMTP id 5b1f17b1804b1-4257a04febbmr85745325e9.31.1720010393001;
        Wed, 03 Jul 2024 05:39:53 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55e61sm235234205e9.20.2024.07.03.05.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:52 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 13/19] virtio_net: convert to use virtio_find_vqs_info()
Date: Wed,  3 Jul 2024 14:39:07 +0200
Message-ID: <20240703123913.969202-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703123913.969202-1-jiri@resnulli.us>
References: <20240703123913.969202-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of passing separate names and callbacks arrays
to virtio_find_vqs_ctx(), allocate one of virtual_queue_info structs
and pass it to virtio_find_vqs_info().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 283b34d50296..3e367c7b88a0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4351,9 +4351,8 @@ static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqu
 
 static int virtnet_find_vqs(struct virtnet_info *vi)
 {
-	vq_callback_t **callbacks;
+	struct virtio_queue_info *vqs_info;
 	struct virtqueue **vqs;
-	const char **names;
 	int ret = -ENOMEM;
 	int total_vqs;
 	bool *ctx;
@@ -4370,12 +4369,9 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	vqs = kcalloc(total_vqs, sizeof(*vqs), GFP_KERNEL);
 	if (!vqs)
 		goto err_vq;
-	callbacks = kmalloc_array(total_vqs, sizeof(*callbacks), GFP_KERNEL);
-	if (!callbacks)
-		goto err_callback;
-	names = kmalloc_array(total_vqs, sizeof(*names), GFP_KERNEL);
-	if (!names)
-		goto err_names;
+	vqs_info = kcalloc(total_vqs, sizeof(*vqs_info), GFP_KERNEL);
+	if (!vqs_info)
+		goto err_vqs_info;
 	if (!vi->big_packets || vi->mergeable_rx_bufs) {
 		ctx = kcalloc(total_vqs, sizeof(*ctx), GFP_KERNEL);
 		if (!ctx)
@@ -4386,24 +4382,22 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 	/* Parameters for control virtqueue, if any */
 	if (vi->has_cvq) {
-		callbacks[total_vqs - 1] = NULL;
-		names[total_vqs - 1] = "control";
+		vqs_info[total_vqs - 1].name = "control";
 	}
 
 	/* Allocate/initialize parameters for send/receive virtqueues */
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		callbacks[rxq2vq(i)] = skb_recv_done;
-		callbacks[txq2vq(i)] = skb_xmit_done;
+		vqs_info[rxq2vq(i)].callback = skb_recv_done;
+		vqs_info[txq2vq(i)].callback = skb_xmit_done;
 		sprintf(vi->rq[i].name, "input.%u", i);
 		sprintf(vi->sq[i].name, "output.%u", i);
-		names[rxq2vq(i)] = vi->rq[i].name;
-		names[txq2vq(i)] = vi->sq[i].name;
+		vqs_info[rxq2vq(i)].name = vi->rq[i].name;
+		vqs_info[txq2vq(i)].name = vi->sq[i].name;
 		if (ctx)
-			ctx[rxq2vq(i)] = true;
+			vqs_info[rxq2vq(i)].ctx = true;
 	}
 
-	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
-				  names, ctx, NULL);
+	ret = virtio_find_vqs_info(vi->vdev, total_vqs, vqs, vqs_info, NULL);
 	if (ret)
 		goto err_find;
 
@@ -4425,10 +4419,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 err_find:
 	kfree(ctx);
 err_ctx:
-	kfree(names);
-err_names:
-	kfree(callbacks);
-err_callback:
+	kfree(vqs_info);
+err_vqs_info:
 	kfree(vqs);
 err_vq:
 	return ret;
-- 
2.45.2

