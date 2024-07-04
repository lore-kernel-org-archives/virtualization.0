Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049481A070D
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103691; cv=none; b=NHS3AqGrnXFYogPX8spPxm964VBbkwaRjYemEgbc2GoMySP6StKqjEcBRZDEdSeA1oNzqZStOkFx18pQDZO2Y0Z9KKyUrEY0m/BhAWVRQLGWMf8P4MGUmn8WMET4Q6dse2ivqD0JlBDAhW5yTFRTv0uo1XgFkxVuqHMgI+Y6hQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103691; c=relaxed/simple;
	bh=u8zu0xv0/dGY9BSdEi8sVeJG+BR7QiXKjBDatfhAi68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrTPON7C1F948RXEmdDxCHSSLRFDjgSKeO1NHcfM2stocwX20rHwsQwdXFLovqZhQq1kP1EpU+2LbexwdRu2JL1FgjokvOxdSPLW2ETi5I7qsKCmZp9+21HRNfizEhDng0UE0nxoGdafpl1mV73O+YqoqHf3BwvNrw0FxNW01sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=m6RNQbdK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="m6RNQbdK"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so6061215e9.2
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103688; x=1720708488; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yor0U0kA9/znvXYDKZMSG509WLabVTcjuBLmV7A0v5k=;
        b=m6RNQbdKWP62EO3keeQtsjVZaaBz06l6gqTmnTGJzxu35YDQ28ZX6NOGfLyKLwoOJF
         s44/Saco33G3/duTz7C0oSjlA3Pk+flcGZUPYDGmRGF9TENzG3dvsxmeN5OxW6xnSfia
         hPRy8grGZ67n3Vf1jE96+Q0GDPJ1uQ3kR13m0Am0glW2fdiGdGW4clbJXRBuUX47e1+R
         BJ3WzD95Ls0vOH9Sf4iTZUzcOVb1QhKIlP2iwXpVk992ukprQmm07/rzKT2LVIw4whFe
         55sL/O9F4RJPRJbGLSJy7x5aI16oN8l0j1MqKFfCJS6e3HfttyeMO0bCzmErSHZvNi7Q
         G0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103688; x=1720708488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yor0U0kA9/znvXYDKZMSG509WLabVTcjuBLmV7A0v5k=;
        b=BwT74YLB5C1etJkES3hb9iemNMSG5s6Wqv/TPLWB5te48tK7sdghUW/NIX2Qu6Z6YG
         jbnNnQLOHP6/8jnTDcuCzUv7rtOzT51KlVVYFpulujkxAzHy9nVvDsBfLNIk9/UzTqLS
         v73lItv9DxFSMV6Zj/mQBkpydQgB9cJ/QzIhUThDCKPk4k9j1LSw2XMfTavhfVZ1heJ0
         +AaCeDCT3btQFIIFbsylYNMhYFDNvn+bgmB0/7l98Q8+TiVBTVkuFJhl0QQDdJ2Cgey7
         Dra/MW/YVuZwAtbnxmovAp5J4tyoUTCGhBbWO7fyVd2nSplgXhWZmZm/8Nu6e9MaJ3R9
         tk6g==
X-Gm-Message-State: AOJu0YxRvAlm8OG75JciBez7qLLVUEXfmenPy7PtIlEPR11lRvV/cAAM
	e2BV9ONxTzr4Qlk8r90y3HvqCzSvHmisi4fn5EHmUDPYc9/TbN3JDe3S5G+yaPfHRwP6dNLww4E
	decE=
X-Google-Smtp-Source: AGHT+IGW67EaKhCn/yRxQm+CKDeJj4OADTfDZfqOBNmuZbm4NGqzLAcRl0YlLl4mNc7LB49FGamBcQ==
X-Received: by 2002:a05:600c:219:b0:425:80e1:a6b4 with SMTP id 5b1f17b1804b1-4264a3d903cmr17506455e9.19.1720103688492;
        Thu, 04 Jul 2024 07:34:48 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d509asm26722155e9.8.2024.07.04.07.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:34:48 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 16/19] virtio_balloon: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 16:33:04 +0200
Message-ID: <20240704143307.1212454-17-jiri@resnulli.us>
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

