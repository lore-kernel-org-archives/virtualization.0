Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3426D3A8D8
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424920; cv=none; b=dtCCAXjksV8tCMih+vHVWNJZINkOPyJrQF5pXvvGtObRjUE+qNCwq4A0aGB3idI8me2B5jiTDHkNTmWV+Rxwhg1GZrFY9rqjkfCabHvLM8ecpz2s+SFMHVAhziY0BtNlw0selxPhzpYsTxyVzaJ/a8QKEd3D43/cVLYqs2bRoIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424920; c=relaxed/simple;
	bh=L/3en0bkvOysInXLFUAmmljOLApUNUuJ0gjHrjskSC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJHOGGBX2eVKdl4VebZaOgjDde4ebHDOzInZjB5628BxswEMJ7DmshUXt/oXJbx64ES76Sh7gOKoXMrnIiI7Dp9xYceWytm+S7sSyevy+kdorjs7wAipgowM1PQgiqfS0XPqGfn4PrT9rIBeOOswoeAqlp99AKT7KR1rpjUJJM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ozblGGBa; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ozblGGBa"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3679e9bfb08so2019488f8f.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424917; x=1721029717; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqVaCC9DZgHd9nT60tI2Q6fo236s+2BQRfq0WTkR1tQ=;
        b=ozblGGBa9p9Icl4hT08d9Nh+dt6KhTg4KDwtcbgKKwHEpWo14ZX5o3OxjzgkuEWGP+
         jiLo877cYht8kIb7pg3hk1TC2Qzc9W8RdnL2clxXsJybjkmbrsvX9mD8+Kzx2eSM+crN
         lsKD8sbdwcUztb4qsMlXaLZLszfs5XHwuxN03kKhnrTFr5J8ISg/ft3EiLVFfMGazULL
         L7wBp2SmYBPOc9FqfeHIlcCWvIjDh8TXBueaxOqJTE/xbxWqjf+p8xFr1Z/tjxW4v9Y3
         HCn9aSct3Lih9iv5PzxqLD7UrlW4Kygu/Ibl2gxG9DII5FvtMig7CywLBrWZ8oNZTWl6
         eqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424917; x=1721029717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqVaCC9DZgHd9nT60tI2Q6fo236s+2BQRfq0WTkR1tQ=;
        b=kk73cSmkpQZpchk9nJIivXLwGLFMkAkdC/m8vhVb3oVIPJJhd1wXcg5ZOQ9dzvmypO
         jlBlce27mGyOUNfSQwADLihVmCEN6JYiqIJgK5qnENPBkHY/ACYSEEu6eDlCfNN6TSmy
         GLmzW2/dWJhIhpttmm3QEHN19VARVR51ucb5PgY4GTlCplHHHqXUIGtRHYFfqCR/RCCU
         ilHfdIZlVDKBoYVT3GaTIny04M01PD9gM7m3e72+hhfQl09yYHjS2orZf7S2SbemW3v6
         LR+Rgdgiy9+V2NQp5kKJLM336rz/oyjEcYkwWJqvZHhJzClJi00e9cSJWTyKBMk5gmUD
         P8qg==
X-Gm-Message-State: AOJu0YxNpmHzcVFRYxjG5s8O6+Hc136BJjFX7g6JsTVGkXE3+bJiyMcV
	x/asHQhC9kY/JonRwV5E78SdLoZSqQTAEAoEIbr2ohXNPQVyb/KHIAdImvlscDg9flNeiToIExQ
	st7A=
X-Google-Smtp-Source: AGHT+IHwj+cIqqdYVWzDjnYRYZw5sYVZEqcY366UVPA/e/0gbkPDLYPx6rsXlX8+lMykVDnQTemFwA==
X-Received: by 2002:adf:fd89:0:b0:362:69b3:8e4d with SMTP id ffacd0b85a97d-3679f722489mr8610567f8f.25.1720424917628;
        Mon, 08 Jul 2024 00:48:37 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a3b1e523sm8796053f8f.53.2024.07.08.00.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:37 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 12/19] virtio_crypto: convert to use virtio_find_vqs_info()
Date: Mon,  8 Jul 2024 09:48:07 +0200
Message-ID: <20240708074814.1739223-13-jiri@resnulli.us>
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

