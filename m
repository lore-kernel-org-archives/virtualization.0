Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A2446B4
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424905; cv=none; b=XHFgBxDePWT094ynpAm1j2w7x9CcmDtXdEtFTaDFl/wJsXgm5GgsnvEOVQdi8GW28g9/C7wZqmhiQnzferQKIkhRFx/ud81rQ4TZK1JxQ/lMGMryFgf/nmnZR5zUgjUxjKfqB6DODcSu0V4Du38tx5Gd8qfkyR+T6OWfIgs1jQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424905; c=relaxed/simple;
	bh=Ejlf1kqfgu4Sjr9vD62wFu8Yxljiio3MmUzYjCugIOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ycu9TIynoahhFy78Ia0XqAyVOFcJu9wd6fesF4kHPvKJjhYfGG6ox5KwPrd/scC8tik+JOicjcU0JFIOUIt/zD91SG+Q9LQpRmQCkWdGzqZpeEptz2LZlOjRWyJxjqTcWL20SdZBoiWpv8SigKk0h3gsqTVtiTLXC7jQtoC70qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PJXnhPs4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PJXnhPs4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4265b7514fcso11757965e9.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424901; x=1721029701; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwAIl/qCoX0iq4tp93u5F8klCUOPLZX57WWCkCb3iw0=;
        b=PJXnhPs46U9pGyteKt7zeyD0wIRpDrWhRVTYhdKWE4WT15B3dy0pd3ozYGGjlGcltK
         Myya4UUBt929JBOz7sXrwzQ3qxWiA7sqS6Zy2uDCJck44WJ0C+w/rfcP2GVf8vwkems3
         pmHHqANPsnzgWXeqKXtOVnNj91jT6nYtPRDQ4c/+i8gD/GhbAfEHXFdcpznvsQAuAFuh
         XTYcBuGRZmEdwY438rQT67ziuHOn2PQ3YQjz3BSLQoEbAIXe/9Jh1rPGdmDAQm8qzkgP
         gI68xCx6dqRHecKIGkAcbm+xKe0Tbs4/LZuK8iAzNu7sUq63HRhBD4Nv3HGDC0s9MHGZ
         ONNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424901; x=1721029701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwAIl/qCoX0iq4tp93u5F8klCUOPLZX57WWCkCb3iw0=;
        b=AboroBi7tiSxALI+XwruiBcphPYywd5+4QD8aLRx8eH5pfYpTf3Mm4lT5/f2D2fcQZ
         jhs/RNqp1lkDFltKWS6BuQUDgg7EVqmx7GNANfxsxWQTyhVCxpqolQnX+iUxiaSjpVzg
         7gDXkxaYt4XpVgOLf62psmMrn07qWRiTxgdiNIYeV1BvnhzvLE1w7SWd87wKGDfddxwQ
         xH64NTGIX4pg0VD+aDcH9l1QiggP+REOWFGRTN861vnVz2iDsmhfsl0sLHR3lDu0Do6i
         uKuc5uXvZidPfbDnwKNSvkCyTSpjUKT9H3gNBk4d+ir/bpg955INkq+M3JcmmsuTPtT0
         QIeQ==
X-Gm-Message-State: AOJu0YxB+FDYpXh6fq1Y2w1v3/GPEE6I6qDMg8J7PKIDBoXBLIHjPtO6
	pW+GtgiYUC1OxmmNmtl+Isy2smm/NakO5zv3Uk03zr5JxCUE+ewUyNI0eAirDVJ1clZqC6AXsLX
	/huk=
X-Google-Smtp-Source: AGHT+IEbz5z/nelVZviow6VMwdI55cfaOTDtNhBnSIVL/TiL+CZqBDcFKl6b0AU7RH2Itf8SUPAgQw==
X-Received: by 2002:a05:600c:3107:b0:426:6085:f6ec with SMTP id 5b1f17b1804b1-4266085f948mr40711125e9.7.1720424901319;
        Mon, 08 Jul 2024 00:48:21 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc937sm155839375e9.40.2024.07.08.00.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:20 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 03/19] virtio: make virtio_find_single_vq() call virtio_find_vqs()
Date: Mon,  8 Jul 2024 09:47:58 +0200
Message-ID: <20240708074814.1739223-4-jiri@resnulli.us>
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

