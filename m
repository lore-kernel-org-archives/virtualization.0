Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E358C200AF
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424931; cv=none; b=dNi95hmnzQJsYP7rjwFFYWmyuzw8sjXucduFDEqo3BrjJqJnHCN2kRWqTwWRaSJcs0OlHp/+rw/s/R9zGDBZgCo1sticH1zbwv2FrE0pURablROj+6bV1/9X23SxISfyo+kljT06C6KT/GGmvxp0Pm1QVQZkkaHLAyKBTGYFh58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424931; c=relaxed/simple;
	bh=TYVv5tlIK+hEtgFpV8xIUZUEQ/LE3nXC16vHrbiM9SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+SBSSL9vQJo4RrmNVRgi+kSAyiSYpIHP8qpg49RtiqjQDF7n6Ec5Mom313b351sq1Zb7FIWlFCUl1s2zSfIwsnGvJBKPn8RfKeZbn4XxmlIujuug+OxROpFh4xZrNAycHwFa26LRIck8pW5ghlTImBN1Z139gvy92MqndxVUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=K7KNWQ4v; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="K7KNWQ4v"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so9051985e9.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424928; x=1721029728; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SENFWRXvo+L3/xzPkroVW8rzpC5/DZKXhsaOup3Za/c=;
        b=K7KNWQ4v7EZDROtc7743LWSR3ceXVPE5Jp6fx4aYe7tz10cDAkqyyHoEnphgRQt053
         uu2DFdXCV/Pi2FaNPLptSDx6HNHXa77L5+H7LaervGYSbZn3CprkJzXHVXVMoOJmm7a/
         iqUAWWVKDR8eS0v3V7Fmke6ADscv7ktlgpvs35sfydPDjMVEl7d6NaPUiK9NDG71A6co
         K0/Zz8BG4+V64uPHbIERuPyRqBas+j5BfsaVFf5n2Vi7Qp53XQaNXmNv0ToKFhTrdWc8
         471nlCkCy0eCT2tbw+kfkEEpBOc4U7GEl9F2ECTUsrRnXJiX9wGrZjSkz/sIvqG2wTEk
         tfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424928; x=1721029728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SENFWRXvo+L3/xzPkroVW8rzpC5/DZKXhsaOup3Za/c=;
        b=hK7r2j5LPTZrkeQAo2QJTdNTFwPcStv0dbZRCBKV57KG1HH1oJTijQQUHJUtYQ5gTq
         i3peNddxb7j5aH1nnJSFAH9tnnli7L7+Q1P5VvAcI4puRNM2t3eaPfDl+/7obmJuyPow
         LkxtAwz6ubVAkRoUIkZf9RBxB+/77mQHR2DoZ3Q29559f+F3Ey+xaDT7Ve9HaWCFsaNK
         1UiRXCt2TqYyFhk1oWX9yAZX2DJG8KDC/i0wFwJljuMyF6HGS5a1lcbXIYrvEWaKypVo
         tdY2L9U7M43lLY9S44wS3j6eu3SURcT3O5TnncuGCW/fep9Xz89Lo8SdGOBAIX99zHVG
         6MRQ==
X-Gm-Message-State: AOJu0Yw4TXXeh2as77rVUomXUTWYN+V/QMeP5szrluznPe2lYCQk64Ba
	EtcP4uUbDLVySxjECYoAPkONpCpBP5PWkuuDa8OL/pFQ7+tkSs6jIi+qutCt8ErHUhwbKRygdS+
	5lS4=
X-Google-Smtp-Source: AGHT+IEm0XQFi7isbeyAPNzSMglayYvN45pRVAcA3zrzcjubGZeLClV1LYJGQYYUdB0Z90ZYOpuy9Q==
X-Received: by 2002:a05:600c:4a83:b0:426:5e55:199a with SMTP id 5b1f17b1804b1-4265e551c01mr36259565e9.23.1720424928399;
        Mon, 08 Jul 2024 00:48:48 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42669475e20sm30066925e9.14.2024.07.08.00.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:47 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 18/19] virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx() helpers
Date: Mon,  8 Jul 2024 09:48:13 +0200
Message-ID: <20240708074814.1739223-19-jiri@resnulli.us>
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

All callers of virtio_find_vqs() and virtio_find_vqs_ctx() were
converted to use virtio_find_vqs_info(). Remove no longer used helpers.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 7848fba7f48a..b6b615c3e21d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -230,38 +230,6 @@ int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
 	return vdev->config->find_vqs(vdev, nvqs, vqs, vqs_info, desc);
 }
 
-static inline
-int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
-			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[], const bool *ctx,
-			struct irq_affinity *desc)
-{
-	struct virtqueue_info *vqs_info;
-	int err, i;
-
-	vqs_info = kmalloc_array(nvqs, sizeof(*vqs_info), GFP_KERNEL);
-	if (!vqs_info)
-		return -ENOMEM;
-	for (i = 0; i < nvqs; i++) {
-		vqs_info[i].name = names[i];
-		vqs_info[i].callback = callbacks[i];
-		vqs_info[i].ctx = ctx ? ctx[i] : false;
-	}
-	err = virtio_find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
-	kfree(vqs_info);
-	return err;
-}
-
-static inline
-int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[],
-			struct irq_affinity *desc)
-{
-	return virtio_find_vqs_ctx(vdev, nvqs, vqs, callbacks,
-				   names, NULL, desc);
-}
-
 static inline
 struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 					vq_callback_t *c, const char *n)
-- 
2.45.2

