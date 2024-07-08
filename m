Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0989F3FBB3
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424927; cv=none; b=A0/Wy/F7H2ffPL9yfX/AXPLOG8nzDEi8lxWrMC+aIKv8H03IEVsBpz0Fh4eMCUOqINuzZJ7GRB81TjCDdpYvP3inSRjPCIJmqE2E0Pb6fMPVOZriVDuxfEBIJoaVN7AuAYrKQxv3rmhTQUdgBkfynyB037k0TjC06GScygevyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424927; c=relaxed/simple;
	bh=u8zu0xv0/dGY9BSdEi8sVeJG+BR7QiXKjBDatfhAi68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKGX0KEmM03P7Wa70NUUxPgzjfFLvRyPGHExMKZlhvJvFXjOY8yNuOavOEtst6QaOntP2cnStmQZl10ZAwUWjvCy9dTKT7JG90+y0kDFXno2v6T5sLC5NIrVUAz+FlImX4cpfUWZ8DNq8g2JK5DSPUHNcS+VxdKeNrDUjwG12IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uz0UxrJb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uz0UxrJb"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4265ff0c86eso10417015e9.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424924; x=1721029724; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yor0U0kA9/znvXYDKZMSG509WLabVTcjuBLmV7A0v5k=;
        b=uz0UxrJbZx1EhZD54PnagKMq9Wpfk39x7tkJ2hAxuQdBBmYDsz7khNLVSoevx9wvAk
         0rrwUpsM1aKE2FGDom2vZuh62tTpLpXGM+otnalhYLukYAIaFqH7tDcw6he2CfhHJ5EQ
         rqOACO5c5ZCUJrsqEbLtrjmORk4mV2royWuyvDrZv1Qez5ataB8ovlaT+ez5ZV5yHAE6
         RsYG5flRRU0Q+U/sBvlclfgAji5nkBTECGPy5Yi2l46BUM9QxzEf/wpeeogb3ZJxBYja
         b/vYoCqappBhvLX32EoA96jVkSSz8ji+lq+TVG38vRY2e24X1gK3XYk9P2WyI5THW5w+
         VukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424924; x=1721029724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yor0U0kA9/znvXYDKZMSG509WLabVTcjuBLmV7A0v5k=;
        b=V197uyjfpvKRBqo4bVp3836K9eDlDAkRjmUoxXMhKwqdhCkH0FY87w4JYmp7JWyYFq
         2S+ZmlKIE+p6AU+W6kqIkqafKszpiUR3dxvy1rpnGSeaCZI2zN20aWZpGfchbzLpnEbE
         J4WlE6R0c2ppNYqKuwkw5MZ7l+v54+qDyGw5piwippHfSOQwR4k+qcFShDA0PcbL8l6H
         WpG6CPbbL+tsVfFJj039CQ94yfzyLChS8bYZCiZjxiirZZ85k2vmSs82EktC8yJFFEBf
         3+HdAFeSxJRYASmQooiK6I6bLpkr9y1E2Ga0sCN3lmGrMslAciqlNV12CiVVi+F4s0ad
         pl2w==
X-Gm-Message-State: AOJu0YwZWe2igSATVcicyID+FAdh6Z4JV2ZSZIuyad0waCCyhYPYNEDe
	hT+NxrlSJwT1l0MDln9ryoHCw+bZUkbYG/JGu3uiRT124kp7vgkXnIFXUN+E8TzzqyglZ+znaju
	TNiM=
X-Google-Smtp-Source: AGHT+IFzvvS3HDpGBIyZczsMCr6voB+uGzoSfgNd99mbjlW1dYDbOkRZw61oGKSFZ4H4tcmvhF0xDg==
X-Received: by 2002:a05:600c:33a7:b0:426:5f75:1c2c with SMTP id 5b1f17b1804b1-4265f751d54mr37996325e9.11.1720424924613;
        Mon, 08 Jul 2024 00:48:44 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266857c28esm37762625e9.2.2024.07.08.00.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:44 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 16/19] virtio_balloon: convert to use virtio_find_vqs_info()
Date: Mon,  8 Jul 2024 09:48:11 +0200
Message-ID: <20240708074814.1739223-17-jiri@resnulli.us>
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
to virtio_find_vqs(), have one of virtual_queue_info structs and
pass it to virtio_find_vqs_info().

Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 drivers/virtio/virtio_balloon.c | 34 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 9a61febbd2f7..cfa710abf441 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -560,9 +560,8 @@ static void update_balloon_size_func(struct work_struct *work)
 
 static int init_vqs(struct virtio_balloon *vb)
 {
+	struct virtqueue_info vqs_info[VIRTIO_BALLOON_VQ_MAX] = {};
 	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
-	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
-	const char *names[VIRTIO_BALLOON_VQ_MAX];
 	int err;
 
 	/*
@@ -570,33 +569,26 @@ static int init_vqs(struct virtio_balloon *vb)
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

