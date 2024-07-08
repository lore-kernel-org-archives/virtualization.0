Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B84044C8F
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424903; cv=none; b=D/avNzjC92MkZ4nxnZF0+/dEgZxwEsOrwb+8Hm9QAJ7rA18wBpF8IUat+KRI8Tkc9zTKGwgA8u2riTcDSKVsXTYtl6kpaw0SMDClXVZgHHf8kdqXljWEl+ST3q4rUbbNm/7JB7oHt+JOqy4ogjJhFWyIV3aHwlyRvrZ+NvCBgig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424903; c=relaxed/simple;
	bh=F1IcreTe4McxAC8/b/Zfr2kSHzGbyrXxRXQZT1N+gnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vcjk3MfEeV6jehVh1KnYdK5rYr0eT3UvThYCvO0tMxxJDq4Ox5UweT40ZDsunyaFHEwfPC2+iNk6gBQw1er/GNcsZh8IAGwT00hQKbYePJ2WuStv+o/MhDuj+QeROGFt30EdiSogVRl4bgKrME7Z8nGwA18lo9AelA6KKLDEYGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=q4UPAARE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="q4UPAARE"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36798779d75so3146974f8f.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424899; x=1721029699; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4QyZxjQeVInXiOWo+EZehC9F5Y80Pa7P1UNx96u8OQ=;
        b=q4UPAAREJcCtWqjf3e4cIi+kAJhO9arNaYWiz8aijPsSMPESFLAW/NRFBzg+PVyC81
         Wgtb7P5M2/HnWor1pIqaQ6efYXkpstVHmyvrv1KlK93DT++9mI02gJztAtcZnG/abP6D
         NBhTDAf/5i8mQljayAeIz1S6+it95BO5cO4BfzPQsjTKhZs/mTbdqFIqT8zb2Hfi7ypU
         6mgvMfNdUPsCy77KTZF9RJwoMyxu8RRB6lHMELH5ddP2ajIbW5zyKuZZV5ivgGC8vtG2
         6BUJsZ6NT3goNtpK8/syxiiZMSqvYmDCfdK1/UO10H9hxUuF/fJdDYbjlYPSQ4XdaZer
         cVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424899; x=1721029699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4QyZxjQeVInXiOWo+EZehC9F5Y80Pa7P1UNx96u8OQ=;
        b=JMWx6Wr169TXiDGMYR0gE8LOZKHl0TJG8S9RWO5efaO0J19Kwtwt4cB61+ovFyJyoK
         RyVZfCqM7bB0enY7Msz5gTdstNivHqBMWegEtCGXj/R7tfJpLOk5pDR1QnstfjCrlEvU
         u0YsIPdtzCfEQxWYM3T+l16jfckevnEy41IJveUf3jYEYfu24z3Tk4bCGAnVCmxq+6bj
         4fEKAVePQJ5+nx5+M2ltzPk/3xeVzLWJz+RlxjBKz34DWQQikErSCGIF5hZw6MTghdtx
         wz+NFCkNZ0EFHcLzrJGlOLxvsU4BAl+w7swkLr0KCogXm7LGX9ANT+LsUFvZIjunhZZp
         1pMg==
X-Gm-Message-State: AOJu0Yybg3K5tR2EbY+ex/g8V3F+7ab3ZV9GcjeGJChGcAifpJOB4tMe
	C6cj9kFLZqP7B5LeLAsjo/r0Bn1XJm4fRs/SGB/5uWhpSxkGFVsJUV942ue2OTXCE0fcSOY6wWC
	O214=
X-Google-Smtp-Source: AGHT+IEL2858Ka4fFIB++AEtxD/Fovx5SOExfz4b8TMhrrfRMUZnRCh9d+tmsNXIDCVfWTnXK0dJqw==
X-Received: by 2002:adf:fa0a:0:b0:366:f74f:abf0 with SMTP id ffacd0b85a97d-3679dd26d38mr9037117f8f.16.1720424899606;
        Mon, 08 Jul 2024 00:48:19 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd66fsm27238085f8f.8.2024.07.08.00.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:19 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 02/19] virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
Date: Mon,  8 Jul 2024 09:47:57 +0200
Message-ID: <20240708074814.1739223-3-jiri@resnulli.us>
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

In order to prepare for conversion of virtio_find_vqs*() arguments, make
virtio_find_vqs() to call virtio_find_vqs_ctx() instead of op directly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index da9b271b54db..d19eaf6bafbf 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -225,22 +225,23 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 }
 
 static inline
-int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[],
+			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
+	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
+				      desc);
 }
 
 static inline
-int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
+int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[], const bool *ctx,
+			const char * const names[],
 			struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
-				      desc);
+	return virtio_find_vqs_ctx(vdev, nvqs, vqs, callbacks,
+				   names, NULL, desc);
 }
 
 /**
-- 
2.45.2

