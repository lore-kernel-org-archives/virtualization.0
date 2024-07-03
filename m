Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1AE176AA4
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010402; cv=none; b=UOmAbwVmsimoUHuVb4Ob07WvO/GVrEJ1JSYPpdbkwuh5FeErCvWDZGXei4KoQC268vYxj8Lb/oVexl3imLrzywtexgWfFnxfhQaFNKk0aJ3WYvPgR4hSVR0tBPCQkucJ+DejbG5jy+NdLl7ziW8uA25MqK1Sw0ku42QIc10eZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010402; c=relaxed/simple;
	bh=5+UktUzhX8C8aALuCj04oWz3I1T0rCZ1kJBMZ9C/3Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNuHWrRjxSNrR+NWifN/ZG1gVOFqOiV1J9hAlKBGvZH+LDmdA/gAHzghgRDZMXPZsZmEAAS/BzYN72MLA8fkEqdzai1JWOaOtfdzxosaid52SD+HeyMVg81kCTDXezTY80ry7gTWlA6SrfE5ZVf4e4GXmsJ2mIpo4+GrF2t9i2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=N7D2cV7U; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="N7D2cV7U"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36785e72a48so1023501f8f.3
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010399; x=1720615199; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Veprld19k222/OZdz5YllIKYAzbaxGkgLJk38L3wsdY=;
        b=N7D2cV7UriGgunCkYN3FimLl3rAfiJf8qTiYXrhvXzYqG7Ark5dSAWtE8PaOhLutYE
         t4tydc1uFE8OHOKDR68yiHxgFwrX5z9EhJhIIECbNwFrI1nSzVOX5gnduT22KjqDfdPZ
         i0V2HV0Y54dP049HQwOutqfYuef7vUHIJFVKwqZp4yOIvmuqzJ78VBujuaBh8yEkbEVF
         BaFTWjJIXdFbDLCUOGKQ310CH6vhLbwXgZeQgSBQgGCW0F7MKSNy8KGDuN7dzbErlNpO
         jAzon2s2eeNArl/RpgEDX8G4VLun7Oye/RjWSlDxLMkucFop1TGmSg/y2aN4a2l3yUXd
         BhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010399; x=1720615199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Veprld19k222/OZdz5YllIKYAzbaxGkgLJk38L3wsdY=;
        b=f6En/wWpIWKP6lABD6TgimZEgDt402UxpYHvVZBH+1QViWrt2w5tTXZYFI5IhCpi93
         dRfj9sK09KHCg2tlEX3cR6xyHxzpt2Tl8s16TV0nqW23Cmt7VpBAmtHcU3+1wmGk37Se
         6NJewSBRGQca+T9AQz2qbEbq8smUiSq/z8JuaX7plrvx2gi2Se+SaA7jPziCO/5WlTy8
         CJ0VPn7GqXK96dirgAEJwFiy4QYYcV8ji02ac9yiK6a3xSoGOLj44+5FmGWXTM5IVMun
         0X+AY9Ei/xWkg0AgjyEbDSdoKD+6xDLSvuNKuzINLuOaxko3UTKRhnfxwhD25SivL7jN
         mw2A==
X-Gm-Message-State: AOJu0YweNWefEjclfFKtfbEmcXuPTxfUeGn/btArLjR7av7wOQUnjbho
	2iSjREDrh+sbUWKLvdy89De6EN2PuomQarKHjdErtDYdGiK9zEWnA5jDQ7MI6yx652IToxXNxfJ
	f
X-Google-Smtp-Source: AGHT+IGxhMeWot8hu/KfyS1pCuiciejhBBMTHhWVrP90/xVHgDSnFJsEet1LuUfEV9bZZ4u7Mcp1Hg==
X-Received: by 2002:adf:f48e:0:b0:366:ed80:d056 with SMTP id ffacd0b85a97d-36775699f6fmr7321905f8f.14.1720010399619;
        Wed, 03 Jul 2024 05:39:59 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678eb6593bsm3081358f8f.93.2024.07.03.05.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:59 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 16/19] virtio_balloon: convert to use virtio_find_vqs_info()
Date: Wed,  3 Jul 2024 14:39:10 +0200
Message-ID: <20240703123913.969202-17-jiri@resnulli.us>
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
to virtio_find_vqs(), have one of virtual_queue_info structs and
pass it to virtio_find_vqs_info().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_balloon.c | 34 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c0a63638f95e..02ae30cc96ec 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -545,9 +545,8 @@ static void update_balloon_size_func(struct work_struct *work)
 
 static int init_vqs(struct virtio_balloon *vb)
 {
+	struct virtio_queue_info vqs_info[VIRTIO_BALLOON_VQ_MAX] = {};
 	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
-	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
-	const char *names[VIRTIO_BALLOON_VQ_MAX];
 	int err;
 
 	/*
@@ -555,33 +554,26 @@ static int init_vqs(struct virtio_balloon *vb)
 	 * will be NULL if the related feature is not enabled, which will
 	 * cause no allocation for the corresponding virtqueue in find_vqs.
 	 */
-	callbacks[VIRTIO_BALLOON_VQ_INFLATE] = balloon_ack;
-	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
-	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
-	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
-	callbacks[VIRTIO_BALLOON_VQ_STATS] = NULL;
-	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
-	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
-	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
-	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
+	vqs_info[VIRTIO_BALLOON_VQ_INFLATE].callback = balloon_ack;
+	vqs_info[VIRTIO_BALLOON_VQ_INFLATE].name = "inflate";
+	vqs_info[VIRTIO_BALLOON_VQ_DEFLATE].callback = balloon_ack;
+	vqs_info[VIRTIO_BALLOON_VQ_DEFLATE].name = "deflate";
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
-		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
-		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
+		vqs_info[VIRTIO_BALLOON_VQ_STATS].name = "stats";
+		vqs_info[VIRTIO_BALLOON_VQ_STATS].callback = stats_request;
 	}
 
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
-		names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
-		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
-	}
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+		vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].name = "free_page_vq";
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
-		names[VIRTIO_BALLOON_VQ_REPORTING] = "reporting_vq";
-		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
+		vqs_info[VIRTIO_BALLOON_VQ_REPORTING].name = "reporting_vq";
+		vqs_info[VIRTIO_BALLOON_VQ_REPORTING].callback = balloon_ack;
 	}
 
-	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
-			      callbacks, names, NULL);
+	err = virtio_find_vqs_info(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
+				   vqs_info, NULL);
 	if (err)
 		return err;
 
-- 
2.45.2

