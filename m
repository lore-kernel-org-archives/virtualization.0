Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6C1A08D4
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075465; cv=none; b=a4fxGz/KSnKelTpuKzeN4Lkn/rj6jsymIxSfrovH7Ujr0btQyDmoQ4WbbOizlp27S9sBW7lfUIFZdYF0DpHwXFZK3z85MlyCkJT9G9SkUjRubfCnn9US1pSehBQ9CXmhXmCCXykxa1VvtxwL+aytKuBTgrDDqIPE6JWdq722RYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075465; c=relaxed/simple;
	bh=Tc03fCYWCsqgLYaLkpCrCh555BfkiS7b6YGmQkPnnPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QE944Gg01g0CU3okekQKWIJCvBrYQl3Z0/VlxPeFJa0Rej23yWPwrZHqdOY8QrvCIvC5EWvRD1SHSQTqi/sGp2Rm4p0XlztVapUFwuIH7bYbejv9S46cgi35ttNirVavwJPcANeZ67vchod2kgtj0E3hZpBPfEDMJM3DpVNr7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GPocCVlD; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GPocCVlD"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee7885ac1cso2729861fa.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075462; x=1720680262; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCxHpLTTh6l+bHB79KLzsEs/hzVG8oVHFiHklSTT38k=;
        b=GPocCVlDULvBFBH000OA481sx8+FyXFSbxiPKCgi3cyIEBDcpNEYBBXf9upBVfJy2p
         GaDN4oxlDVfV8iuWzc4wp8UnZjio+RJcxKu8kCRkUOCnuyBaxDqdcBgdyuKE0v1m3PPj
         kbfvMdjmlbPC8h8s+9deQStWNMLpJQ2nL9A/x4TKa0DArnXuslTO/COB1IC42p4iGCH+
         u7go4nGI/9szlq/i3b1cAzdn19lFDQGe5PY7kv2tbni4bx3D34xCsTl8UOl2hBqJ6/ZS
         wZ6zW2H2TF4TvBoCQlhtjVDHdoJ6UqxxVnjfFAGaeaFCppyv6v2YlRFQXqqQPx9kk+Ro
         tG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075462; x=1720680262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCxHpLTTh6l+bHB79KLzsEs/hzVG8oVHFiHklSTT38k=;
        b=ajtkjb6S9HK0Kw1mgtV+RNiaJfSYg7j3BfSF4oYd7YGq1jz7f69cvq5RuVPnFDfkWK
         83OuQ7D1aW0qLP3I3X34hflOSrnpQHIoune/G5y7I8WnOCw80d1kJ93DQ6tK+bEv+URN
         U6PXoT3WnpBOct/7MNz0mr9N8BxRGupfcCKorXPkOA3bKJMkrFk//HHzq+NhIwDrCyxN
         Kqmz8himCTABdIzltcEjzXlVoXWucPALa9z+/YvBWdxRZ4DuBFcJpkyELaZ4QGa2AX5F
         0xwKwPUmSIM8B0DzArguU/yyGTJv0Es3aWX7SIoXNq9LBNQxlvc/DMzVi5Dpfqx7uJBp
         iWeQ==
X-Gm-Message-State: AOJu0YxBQSGL+DQ5vhoO0b7j6IOAIhZNFrpWFUyazjQPTrU6hY5tk0yb
	Y6B3y4PGczhUt8Pdn2nKVkGRR7msFp+2AsiEhMjHLlYDn4IVNwA4xHhx4p81AXDIWwDnZBiPhxE
	G
X-Google-Smtp-Source: AGHT+IHIfP3BfwnnacKcaABm8BYfFWtm6r2czLFlasF80mpXHrlNgYRauU6VP/xReMyiIvKxVEfiyQ==
X-Received: by 2002:a2e:3306:0:b0:2ec:56b9:259b with SMTP id 38308e7fff4ca-2ee8edf3485mr3193481fa.49.1720075461105;
        Wed, 03 Jul 2024 23:44:21 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a104dbdsm17577747f8f.113.2024.07.03.23.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 13/19] virtio_net: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 08:43:44 +0200
Message-ID: <20240704064350.1097716-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704064350.1097716-1-jiri@resnulli.us>
References: <20240704064350.1097716-1-jiri@resnulli.us>
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

