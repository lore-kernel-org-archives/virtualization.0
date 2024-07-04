Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C319409E
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103675; cv=none; b=PoHnITSciN1jS26UxbeioXoiPsGx9XJX2L3wItFuBSSJEQCcwSDEjh7WR1aT4OH0rvCWHpFKN2K3ETZ8WfyYOEQNRp8ukdOlAkEpN/sX1tde4iW21iILVZuyleU50tudrZQ+sfVGAPSTuykFOuxCKW+cBVfPhMURNQBjPJjZONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103675; c=relaxed/simple;
	bh=tMxO5pVMwcYlBVu0CQ6USUmJ7SMtuU4dwwSltV94N+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAni3UaRa5D9PwAyH0f7ADOKulbj+NcgHd1vgBC4+VgPBJ1OVnYtWLISa5NAEe7TZ5k4LSUlzpdgUknOrJ49z9jJp56pldsaAKdnAUkkOtkVRSovFl6UD5NxrZDBFP9P23Rg2OH6AnsdAlAjYsPzOzW/2E4WazU8krHbxdDz55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=f5Bo+6+I; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="f5Bo+6+I"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-425814992aeso4738125e9.1
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103672; x=1720708472; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98PTXT4eMNM5mO8khQju4uqMurThGCk2mRYzgc96Pw0=;
        b=f5Bo+6+I5M02pBe+yp5dDuGvxFfAXGJDrctJEzwEIM+BkzzQqYmydO+VUmP90vWNBt
         CC3qJEoph0HOONDudQIlFbMxM6f6SWgLZyC7bakr26sBLnZkXjoX2XQpZ5fF8pAIaKgL
         S5lLpHcwyCN0QHRUnqmQE/aEg7sDIVaSwR+dp8N4vANEyjfhTKECZhz9bhmrXvZEAhB0
         cSQ8B9k80j6wXFDj3uOhDr1hIl1XTJZ4fhuHdWfv2Cg8hr6J1p+lJowkBNbEv6Yzr09X
         +8+FbtZECbZYihYRytw9zaFBBuM/h6ox0gqHuWvKA485Cb3AFUkLhy7655Y76svafNHY
         mgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103672; x=1720708472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98PTXT4eMNM5mO8khQju4uqMurThGCk2mRYzgc96Pw0=;
        b=p629CkB22xJtc6yOu0e7ivWxyu2epsGuFhPtw4WbuZ735QSodT/Cr4/rJp73fTg1XO
         jlaW8KHsKPk2p1XzoTSyxch1CxutP8+E+e+UjdsfoI/HEVWQjis0w/9S09WS56S2MFxS
         wnYWFL4CD0g9GI2Bk1mbXl7/USn8HOfKwMHX8nXwWHLihxC8e6Uk9xAoTQLZZTy/2YOa
         MfBoS8A9e31/0+3je8uHS5UUFU7DlBlDEomigVz6dhupWovMlDM2WjibbU0cCqfTJ1vO
         8nPQ5rl74T3xqwfVJnjCfqdPDGT6bcD+TKynaelh8sS6HU6Uq7j6Ir/fafzfQz93aFAA
         RC4Q==
X-Gm-Message-State: AOJu0Yzuc8GpzhjBxpGLm+QkA8vWGi0OWLsIZGO0PSHUErSm8fJk+qi7
	6p1/e15CN9uN0v+mNaGcMJdKqcnlJBE7A7XAP3AIHy9OdNayz2/ajvHMyrJApmdPlH5vkssWQPo
	gIog=
X-Google-Smtp-Source: AGHT+IE1eXtpeLIJn1GR4TZ3baQGv+dtlMpod5CWk2UCBShZwSIcIJIsAQqVt/MIAoJ5MBUIuz9nAQ==
X-Received: by 2002:a05:600c:4851:b0:425:7c18:df9f with SMTP id 5b1f17b1804b1-4264a428fbdmr11976905e9.40.1720103672687;
        Thu, 04 Jul 2024 07:34:32 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a28333dsm27227735e9.40.2024.07.04.07.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:34:32 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 13/19] virtio_net: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 16:33:01 +0200
Message-ID: <20240704143307.1212454-14-jiri@resnulli.us>
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

