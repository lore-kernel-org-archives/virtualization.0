Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C51B1A08D4
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075462; cv=none; b=mpAhqDSmj8/lYQA0BEWcG/NsBLR2Saj5+Qc7M0QNcDtjGO6wUUwk0BWNL6UadRQIEyi1jhIrlcX/PL15kpI3Nf1Pm1yHeb8MhMhQ14E4UDkcOBcg3vmHQ+0M2sfrlp+XW+duLYmNgHkWJhPbNX4h6o0k0skf/MKS+KpklcEdOLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075462; c=relaxed/simple;
	bh=DjJ7wYstH6jNGfdPmOX4sz6rKLj6cbOpt+phupljmls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMtdB30enj0TZj04IyH/RRagrzYuYCRxSUJfDjicrfiZ1MGQT52nl357u0mtLuuXfv6EIwqUI2m+dAWzZ53XNi54Pi8dwlDY1ZWjZNHxZ1vDfWLbOgVcyYPd7E0HGr4Z21jGNHOpr16EQlWrIrqKWCtjKpqFofjV73f0TBpCUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0dt9caBS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0dt9caBS"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so3270691fa.3
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075459; x=1720680259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Xpj4yE+QuyudGiYwUMRImfZz6Sl/gkB2rYDo5cEA0U=;
        b=0dt9caBSP+n9V3bdYD8rfsiwgQkT+bRSnrT8sN+u2t7RPTmsrrqYAnRZ8qFmaRy/pL
         92OqrzC0NNNUwv+dfyW844PGMJmafcryZzbJpZNuRvmuWsZkUZJnfbggL1LPp0u8GZLh
         aGXKLmZCpcqYyTwRtNqaSgtT326IxJfOahpP5PrK/RreaXrs/jir2e8dZvNXSv997NXO
         vPLTzTuv3pdCQiSVCHRyBXyKjS0VOhoRJa/6xq8NJ8uR9/wlDWg2WQ79fR9ZXZwjbpvg
         22zSgQwF8HNwGyO8JNZgwD8uhXpJlkrbyoW/Mdnc/4bOV1/tsQNgli0O0YIIW5Ghh8TF
         h01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075459; x=1720680259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Xpj4yE+QuyudGiYwUMRImfZz6Sl/gkB2rYDo5cEA0U=;
        b=GZFF+DtHg2puCsqYY7ks00IPxTMGH5rd56PO6gtSN2p6i/3DtpLAw5u10jwTqkveJl
         YxUFVDCyhteagOvWnUY/kBUqs2aWnSuCUDLtQe3VrLLKHUh9GYChV40lXlDRS/fqurru
         cAxIkeUCwbW97vxKjdQdHDU+N5SHlc0xJ0QHJskwHYPC81CSFulG3I14YEA/cQkt4OmF
         gmj9gg7V6erdAgB5ZTPIWoUqLbsFRy0uG72zvnydmzRAgDn6oicczK9jLU5Ml3jpzM7c
         MyCWkLkV43gkfAsjR4utGn7BYKeCGQoOpJuidUylPFs96ONlmyr3cx9OsbK5xc9+P3pe
         qP+Q==
X-Gm-Message-State: AOJu0YwpH7fJbgMK5ymYwjrYXnR2UeSprGyQDtY4UfKwq5mxRFk1OIbN
	HtgB+G/kARsZJe0DYcP0KOSvCDf8n3gJjO0NI0bhfv21jUeO5LCvuZnX3uuprRxZoyLRkwVfLwB
	y
X-Google-Smtp-Source: AGHT+IEAU/U6tBhs5jcBMGBqsXG4XAGF6gQ/cmLZpgHHvXoiaX12/1fvULsniv9eLeTX8JkRQkaSPQ==
X-Received: by 2002:a2e:8007:0:b0:2ec:6755:a0cf with SMTP id 38308e7fff4ca-2ee8edd52f1mr3520451fa.32.1720075458998;
        Wed, 03 Jul 2024 23:44:18 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678ed75772sm4684305f8f.62.2024.07.03.23.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 12/19] virtio_crypto: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 08:43:43 +0200
Message-ID: <20240704064350.1097716-13-jiri@resnulli.us>
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
to virtio_find_vqs(), allocate one of virtual_queue_info structs and
pass it to virtio_find_vqs_info().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 drivers/crypto/virtio/virtio_crypto_core.c | 31 +++++++++-------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 30cd040aa03b..b8119d1f9931 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -96,11 +96,10 @@ static void virtcrypto_dataq_callback(struct virtqueue *vq)
 
 static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 {
-	vq_callback_t **callbacks;
+	struct virtqueue_info *vqs_info;
 	struct virtqueue **vqs;
 	int ret = -ENOMEM;
 	int i, total_vqs;
-	const char **names;
 	struct device *dev = &vi->vdev->dev;
 
 	/*
@@ -114,26 +113,23 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 	vqs = kcalloc(total_vqs, sizeof(*vqs), GFP_KERNEL);
 	if (!vqs)
 		goto err_vq;
-	callbacks = kcalloc(total_vqs, sizeof(*callbacks), GFP_KERNEL);
-	if (!callbacks)
-		goto err_callback;
-	names = kcalloc(total_vqs, sizeof(*names), GFP_KERNEL);
-	if (!names)
-		goto err_names;
+	vqs_info = kcalloc(total_vqs, sizeof(*vqs_info), GFP_KERNEL);
+	if (!vqs_info)
+		goto err_vqs_info;
 
 	/* Parameters for control virtqueue */
-	callbacks[total_vqs - 1] = virtcrypto_ctrlq_callback;
-	names[total_vqs - 1] = "controlq";
+	vqs_info[total_vqs - 1].callback = virtcrypto_ctrlq_callback;
+	vqs_info[total_vqs - 1].name = "controlq";
 
 	/* Allocate/initialize parameters for data virtqueues */
 	for (i = 0; i < vi->max_data_queues; i++) {
-		callbacks[i] = virtcrypto_dataq_callback;
+		vqs_info[i].callback = virtcrypto_dataq_callback;
 		snprintf(vi->data_vq[i].name, sizeof(vi->data_vq[i].name),
 				"dataq.%d", i);
-		names[i] = vi->data_vq[i].name;
+		vqs_info[i].name = vi->data_vq[i].name;
 	}
 
-	ret = virtio_find_vqs(vi->vdev, total_vqs, vqs, callbacks, names, NULL);
+	ret = virtio_find_vqs_info(vi->vdev, total_vqs, vqs, vqs_info, NULL);
 	if (ret)
 		goto err_find;
 
@@ -153,18 +149,15 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 				(unsigned long)&vi->data_vq[i]);
 	}
 
-	kfree(names);
-	kfree(callbacks);
+	kfree(vqs_info);
 	kfree(vqs);
 
 	return 0;
 
 err_engine:
 err_find:
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

