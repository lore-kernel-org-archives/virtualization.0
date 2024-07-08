Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0DF3A8D8
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424922; cv=none; b=ucGFeTKrEzZ4gcXetdCYqyONdfFXVzcYsQMxkRx3OACM1rkLr60Iu4Ts1rej2dpkZ3hf/ssWb1AXt7n/OOE/92iHhPPWFCVaHchpKCL5xiK1PYHrDUZ9F/g9fhUqBa3uvKOektbZqi7f1Gg4dgWtpqPI4RUA1JGw2vBvoIHcynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424922; c=relaxed/simple;
	bh=tMxO5pVMwcYlBVu0CQ6USUmJ7SMtuU4dwwSltV94N+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYU3JUyy7PG8ht16sG3ED2fdnFtWPzPvK/zRydu1nj5iYsdOhrsVkLkX6efv4+O+y7MI9wQCBjvRbYjB/DqdHGVYmhRL7icxl1+z1tV1N+z16WyHQqh/RpDlbhx7isqnZp4IONhASve1ZzBZTKfV0HNPgXtgUsqMgxaU+atl73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NDfTZ1gI; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NDfTZ1gI"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52caebc6137so2296837e87.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424919; x=1721029719; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98PTXT4eMNM5mO8khQju4uqMurThGCk2mRYzgc96Pw0=;
        b=NDfTZ1gIsjo0SwZBc2DQpt90OCbgdZ6f1vRzEoS3NisN3VMUA3KprHTzp5+gyH4+SY
         WPtvGDFYpS+ysFh1yAkQXk53XBi8FoYoEwAlJFD5JuhD7zQUlPL5wW9ngoyqHyKEs8o1
         yG/WxUoyIXSWiwP5knR0LdEgmH9gruQLLP7ltT934o/ABJfM2ogl+tUCJ70X6O+sW0Bx
         mMPCNNodxNTpgcbOlvJ3zhf8A+8GiJS+HQQSZ6cporal8TsjopAvsMISO1ISR2qk2sZ8
         gomLCEaD/bPyV6jHaWwcaLMo+sSJJMmzpepPNQ6pIurOYOkx65NOs781GHV1L6eokjmk
         Y+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424919; x=1721029719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98PTXT4eMNM5mO8khQju4uqMurThGCk2mRYzgc96Pw0=;
        b=tAdmQmsB6MuLcwH19P+UzlDt2XHcicEPzmnY328QiqSPEmIsvjVCZ3EO1EQHmg8at9
         tCTQ7TRmWRHhJ4QWli4yPfyJ5FthDIQkkzTsL8quZH0BIpw5ZS4zGDq65fyEseKx1icH
         ORsklENZzVLqTzVsWh8/p8SquYA7kYtMk390duwm3455lZTn7xiHk/S/r5PDokBwv29j
         fBHy9Ox9MGp6cF+eUC9ZytqnGtO7FrugRG3x2ThFIsqvD6G5jZFmE+CZN0WoOAX1CL1Q
         wlfmZJ5cqEdokevxmfKvlqsz8f0azXKMRNrusMb1o1HYpq1SFPxm5rd89HodK+Da0E/8
         +K+A==
X-Gm-Message-State: AOJu0YxOGPGUYlmhWeu+y+SBte0d22aGjdo/Cb7vD4pkW3lg33Yow0d/
	V1zQPz6OBGc9Q5aTI8DG9amoIlcsWulU8c7Ti/D/pQK2j162T323ietOMd44kHN+5/daRgJ5F5A
	sxV8=
X-Google-Smtp-Source: AGHT+IHMCWtgGYyLzFW1e4MnPd3IB8Kl57Kr+x9oDZ36TlDvvi/FiLu95LGuwhxWjvgrNfndL6lw/Q==
X-Received: by 2002:a19:6908:0:b0:52c:e17c:3741 with SMTP id 2adb3069b0e04-52ea061f265mr7133649e87.5.1720424919348;
        Mon, 08 Jul 2024 00:48:39 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc9b3sm153656925e9.46.2024.07.08.00.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:38 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 13/19] virtio_net: convert to use virtio_find_vqs_info()
Date: Mon,  8 Jul 2024 09:48:08 +0200
Message-ID: <20240708074814.1739223-14-jiri@resnulli.us>
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
to virtio_find_vqs_ctx(), allocate one of virtual_queue_info structs
and pass it to virtio_find_vqs_info().

Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 drivers/net/virtio_net.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 18165faafa92..686ecd819fec 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5297,9 +5297,8 @@ static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqu
 
 static int virtnet_find_vqs(struct virtnet_info *vi)
 {
-	vq_callback_t **callbacks;
+	struct virtqueue_info *vqs_info;
 	struct virtqueue **vqs;
-	const char **names;
 	int ret = -ENOMEM;
 	int total_vqs;
 	bool *ctx;
@@ -5316,12 +5315,9 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
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
@@ -5332,24 +5328,22 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
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
 
@@ -5371,10 +5365,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
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

