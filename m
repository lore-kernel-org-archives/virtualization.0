Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26BD1A08C9
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075443; cv=none; b=QWm8ZEFthyHOfaCbTYQ1kPlLtuQ3VldRO005vW+3VuZJaEzoOB3h8GCrtqO80EK+r6ZYq7pCnhG3Z+H+zfgMwxz8OiLa457jj0Hzb26R5jNddGVm92hDrqzWlywfvS+DNZnjrVj8cht8NU0yfeK4Ohe4DIuzpp/aacLqbdvf7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075443; c=relaxed/simple;
	bh=Ejlf1kqfgu4Sjr9vD62wFu8Yxljiio3MmUzYjCugIOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+R/33Kbbo1UC9n+8Yw9BzvSkhJAg5RZ1h8hAaQ3EVZW/8AiM6m2iH6ezK3rdtJ6o/TQH4auvBR2e4xbkB4E3teX2mwKCaAnQDl7UIg0XOxoT/IgsVWIGqhVk8vtIywQtyfUwU314RNkN/6c72HTdQ23W647tcLFU3j9z/58/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=m937kByL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="m937kByL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424a3ccd0c0so1816565e9.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075440; x=1720680240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwAIl/qCoX0iq4tp93u5F8klCUOPLZX57WWCkCb3iw0=;
        b=m937kByL50+LE5u2I5b5pU05g/cII0IKLPbGiBsJxkxvIhp+Z3bMyOdfmkNlFh66Zs
         s+TZJSaRiU2XshWuAzpFR+kLih6YM5A1f8vSMSIquGokpDAaW4x5SO0jlO16XIlChwXY
         cx3CP5C+QQChOraxJptzw7j231vzFnmjUfnRrFV4/1GxkLO0YvT97q44nBctQ8IvGxjX
         EzyTbq3JwiVj9aAAUvIUcnQxJLQXrYP4nU54X9ymdacMfXeGzbg7+vTucvTMRfalKYN+
         WUCzcbZfjH4KYihkfG49pOs+o1yPOMvl+KIlupdmlTnHTuiiP4vn+0Wd+kPMODwrqEiG
         ziUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075440; x=1720680240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwAIl/qCoX0iq4tp93u5F8klCUOPLZX57WWCkCb3iw0=;
        b=nN/d04WE9i6PkSIQvl2gomzKJN7rwIF6TjVdep1rBTSENu9ym/fFATNUmpJrM71H1S
         GLxXzigWx/hrcZ3dFmHr0BNM2ceiKjtiACwqvIvLWrE+xUZQ47nIUxl5ILDOAUop4Rku
         apH4poZZjhYgPX74yx6qE5Mm/EOysaQOZ+dKi1Oh3uyBqz3Kyb/RvdcoojaYX86NJLhM
         i5CfEO/uCFuBY5AHja/K/Ra1elvyLGg/RO2jDeFqK37Z3G1o+GK1hHAifLtfw13+hD8j
         2jweq+kcIAvPcF1CobcE8J81h+w38V9fYMn92t/4QnJVJesLcQaBbELRMAWhGABu7ImA
         TP2A==
X-Gm-Message-State: AOJu0YwY7jlT8G4z+3JbXSXH7aTFZmE2RAW4sUQ/g54Ll8SSEotp1fzR
	DPSOGcwbuZb0YAwchEa8WsLfMYVXxk0RFoId6BZk7sv3Ko1s5YmKKN9h6KejNitlcCIgzydSWKn
	A
X-Google-Smtp-Source: AGHT+IGC9epl8tYA6KqbEHGivEscgCEtJcA+VDIZW+iFUOLk4Ee7mir5wybhYvz3Pp+z/MqSSAWKAQ==
X-Received: by 2002:a05:600c:2d55:b0:425:77b4:366d with SMTP id 5b1f17b1804b1-4264a3e3515mr4973105e9.11.1720075439951;
        Wed, 03 Jul 2024 23:43:59 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1f23f9sm10857695e9.26.2024.07.03.23.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:43:59 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 03/19] virtio: make virtio_find_single_vq() call virtio_find_vqs()
Date: Thu,  4 Jul 2024 08:43:34 +0200
Message-ID: <20240704064350.1097716-4-jiri@resnulli.us>
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

In order to prepare for conversion of virtio_find_vqs*() arguments, make
virtio_find_single_vq() to call virtio_find_vqs() instead of
op directly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index d19eaf6bafbf..82a1d798b2f1 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -210,20 +210,6 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
 	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
 }
 
-static inline
-struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
-					vq_callback_t *c, const char *n)
-{
-	vq_callback_t *callbacks[] = { c };
-	const char *names[] = { n };
-	struct virtqueue *vq;
-	int err = vdev->config->find_vqs(vdev, 1, &vq, callbacks, names, NULL,
-					 NULL);
-	if (err < 0)
-		return ERR_PTR(err);
-	return vq;
-}
-
 static inline
 int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
@@ -244,6 +230,20 @@ int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 				   names, NULL, desc);
 }
 
+static inline
+struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
+					vq_callback_t *c, const char *n)
+{
+	vq_callback_t *callbacks[] = { c };
+	const char *names[] = { n };
+	struct virtqueue *vq;
+	int err = virtio_find_vqs(vdev, 1, &vq, callbacks, names, NULL);
+
+	if (err < 0)
+		return ERR_PTR(err);
+	return vq;
+}
+
 /**
  * virtio_synchronize_cbs - synchronize with virtqueue callbacks
  * @dev: the virtio device
-- 
2.45.2

