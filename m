Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690301A08C4
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075470; cv=none; b=PITiySYLnjb7MHYKx0KSVMFLrKHybmwWjN8iA1ygy+kiR/hps6CCzi/PeDefQiRMZGdg7960BZQrU7Nbns86dSkfoURWRH46nbVAgMghRL+MIKScz5668iZsI8qI+lvTZ9eZbXN3rcDuAuuOsATWtAGfdBC4QvAxitEEky3P98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075470; c=relaxed/simple;
	bh=TQktfFbKOlspRXMIKwj8qMPJgpPGocOe/4XMTU3L+4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c06toNEvvd74zyF6XZ8e2yWXr1MDQDwNOBrerbBaQ0+MZAoYtkOdhzZhRMpjmOLYkDLMUOYf0vNhw9pcQh3ozPDewFYqLkaUt6B68iE3/ljbsz2Lh9SQgiawBLKHidJzEidLdrtddLIgz6MvLGKFLOju8SR3k+KcN0ob9PEEd3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ujXb75Me; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ujXb75Me"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-425624255f3so1634415e9.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075468; x=1720680268; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B++zJDtgq5sTpKrB01eRCD+yw7hKFDrG76xjf7Hz5Uk=;
        b=ujXb75MeDovmBkrWRVm9QN8k3bKraLqVOsI7V0TPw1AxANC2KGycL7Hi2iNYK5i0El
         KopssKxYoP5riGmeKQBNOn6c04r3ffsJCakOts10f8xXoDSy5EzW148FutTLhjpYzmtp
         ENxO2/DMHpkl+fF6BNlZNzRrbVWD/atgrQMpNBgCkJFEXQXsLih/0h1bpbeTO21Mbc1k
         VdOp0Cpw7n89ASgjMpwyhgmYEAQ1kwgUCVplxCAh18k43Eyu50cIyELvaS9zbW+/bg9b
         rScPi58IlOYCJAN35iQ6vlH8m5Q8Z4fx7rrCRKa1YxpA76qyFc0pkHNv+GjTASjycbgo
         uDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075468; x=1720680268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B++zJDtgq5sTpKrB01eRCD+yw7hKFDrG76xjf7Hz5Uk=;
        b=uywWWmCWpK0VZGz5ntbzcMGH8pYZSxsTEvH/i4TrKa6cY3pZHEMGLPb5DTIz+qFy3M
         98510x7qBbSn5lKDdv5U72gjAamEg9MpNggqQd2cddLkqsFxbbBoe5wCb6sYmKZDahCH
         b4zsKgYqwTkxwX+oRl/K2DqW99UknRXr5VXpl/ktf5K4REIBnXj73+fYDZPi3x9fcK7n
         Aro4+6mYz6LmXb9+MwhO5U0R0LBCAN6yF7VhbqAbZFDOjua7o/9LO1x+jAZ+n/7PzcvE
         /tVagNCYXhnzddI0AhaeswB1nlYx6gQNZfWm0YBxFuFVHubuKrhpChdMSK1KcxGO/mxl
         l+kA==
X-Gm-Message-State: AOJu0YzUhB8zC1hiBfVYkZFv8y0X7WHp2ll9Uta4vcRq67/j6K1qkdLr
	DIjENmJcvZa04ORLg4qsB+nCRzbt6tgJ9UiZmTMmLlFR3Cv3ozMH4v3SJ2OhPO5FGbdKRKgC9iD
	v
X-Google-Smtp-Source: AGHT+IEXXGK+u+aV3C15dZxDRwqOzzL1ZYd33GpYrsOatyRv4xEN72jGda/sHaQ5K9E+RmQp6DGvow==
X-Received: by 2002:a05:600c:3595:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-4264b1971fdmr4247705e9.17.1720075467914;
        Wed, 03 Jul 2024 23:44:27 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d6133sm11146475e9.13.2024.07.03.23.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:27 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 16/19] virtio_balloon: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 08:43:47 +0200
Message-ID: <20240704064350.1097716-17-jiri@resnulli.us>
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
to virtio_find_vqs(), have one of virtual_queue_info structs and
pass it to virtio_find_vqs_info().

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

