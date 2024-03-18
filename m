Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A32C6AC
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Mar 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753057; cv=none; b=SVBriccs2T7stxviUtkA67U7psM6aJzXXFEWWd5zJqyeLpFLOYWKDubMyPC2GHqPKbE+K0WvZwoCblbpk/CjMhT0V73tJqHZ6TgOvHTRvWQd1ltPo+XQldQclQev1j4O8lpHvLVtJMvZTUrPKyboSCJfy6AESMYqafprmWM4+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753057; c=relaxed/simple;
	bh=WAj/lupKn9ju6knpZ1sHqMnn1cpY+A7JRswPxULNynA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljHleSecMhTjZA+OVbkEjx25+3luUmY1NMmUBGpTeqXbKeSFn8QEijMdWqC8jIRgIRZ30GZhsOQpVRWa50POgtIBqQV95xVaCBboMnCywQceCs3+aoigGNlukpvKWKHEHlTO0PC2tc0O9Ap/m1xiA0Bnoi/7Z8DK/euIbNHxn8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y4jarg06; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y4jarg06"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C69E440223
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Mar 2024 09:10:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x3SkWnKxaFZV
	for <virtualization@lists.linux-foundation.org>;
	Mon, 18 Mar 2024 09:10:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=stevensd@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EC3BB40204
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC3BB40204
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Y4jarg06
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EC3BB40204
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Mar 2024 09:10:52 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6e6b3dc3564so3360281b3a.2
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Mar 2024 02:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710753052; x=1711357852; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6v9O+MdQXCltE5hZRZwhihQ7B9Z18jS30HxhjhSLFcM=;
        b=Y4jarg06U/wpexMWae5RRkYOZxpU+J/46v4O/2Xt/JX+rrs2Z6H3jv4C+AB/U21jgv
         YTiZ1emcpQzsaI8hulMmO9j8d08Zp7z7xKnbIVO19yfSYpmUvsrnIjr3IF6g0RduoxqO
         ulidggVdsLmfJk8lvbW5vHDSIKqlS+moYM3c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753052; x=1711357852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6v9O+MdQXCltE5hZRZwhihQ7B9Z18jS30HxhjhSLFcM=;
        b=ZiG6c5HHKcHc/NNUyxj7SR5wBYg6BY7FfORQitFmiENum7kWrUzQqrIaIgeU1kEyWn
         Y/BvilxiujFpzGZaz/Ocg8u8mLfLjd9Bt6grMBAeV4SWJQUgK3H34crJrPp47waYrOWc
         J0fgwaUzV5Jv4PpBF/f/9PpM6D3w8SAoNtTyEt5elNX4+Ed5fKfqYYsaYlLldHPSqOie
         V8VDDRQKq4/H3Ha02ExuJ6LcV2I7t9Q4EdjXM/GRQulouM/76sugs8ebnyIqLW5uCMpj
         4H35hLxk6Mba6lI0QwPKHpzjq4ykTHLCZfB0YMWkMoqV8eDkCN03x4zZ2bsCcsAAgBNa
         6OLw==
X-Gm-Message-State: AOJu0YxMFClagvQfhOfbF7eMzePrHQm5VFjAjo9M2SHAQd6eJ8nMOfIL
	MpfhGUxnoaFfGk0fAPr0ikc+UNpRqlJBpavyrGsAm9Jou+LZeIelMPCKm+0kCA==
X-Google-Smtp-Source: AGHT+IEYBOHcZ1AQbm5Xvte06YuwE4Ale8HcpwVLtcVBUfKjc9Dj84F5GV5VtNh0+hKKiCpGwY5DRg==
X-Received: by 2002:a05:6a00:92a4:b0:6e6:5396:ce43 with SMTP id jw36-20020a056a0092a400b006e65396ce43mr12702366pfb.7.1710753052211;
        Mon, 18 Mar 2024 02:10:52 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:171e:5cf4:dcfa:390f])
        by smtp.gmail.com with UTF8SMTPSA id i5-20020aa78b45000000b006e72c8ece23sm1065833pfd.191.2024.03.18.02.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 02:10:51 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH 2/2] virtio_balloon: Treat stats requests as wakeup events
Date: Mon, 18 Mar 2024 18:10:34 +0900
Message-ID: <20240318091034.535573-3-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240318091034.535573-1-stevensd@google.com>
References: <20240318091034.535573-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

Treat stats requests as wakeup events to ensure that the driver responds
to device requests in a timely manner.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/virtio/virtio_balloon.c | 75 ++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7fe7ef5f1c77..402dec98e08c 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -121,11 +121,14 @@ struct virtio_balloon {
 	struct page_reporting_dev_info pr_dev_info;
 
 	/* State for keeping the wakeup_source active while adjusting the balloon */
-	spinlock_t adjustment_lock;
-	bool adjustment_signal_pending;
-	bool adjustment_in_progress;
+	spinlock_t wakeup_lock;
+	bool processing_wakeup_event;
+	u32 wakeup_signal_mask;
 };
 
+#define ADJUSTMENT_WAKEUP_SIGNAL (1 << 0)
+#define STATS_WAKEUP_SIGNAL (1 << 1)
+
 static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_BALLOON, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -140,6 +143,36 @@ static u32 page_to_balloon_pfn(struct page *page)
 	return pfn * VIRTIO_BALLOON_PAGES_PER_PAGE;
 }
 
+static void start_wakeup_event(struct virtio_balloon *vb, u32 mask)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&vb->wakeup_lock, flags);
+	vb->wakeup_signal_mask |= mask;
+	if (!vb->processing_wakeup_event) {
+		vb->processing_wakeup_event = true;
+		pm_stay_awake(&vb->vdev->dev);
+	}
+	spin_unlock_irqrestore(&vb->wakeup_lock, flags);
+}
+
+static void process_wakeup_event(struct virtio_balloon *vb, u32 mask)
+{
+	spin_lock_irq(&vb->wakeup_lock);
+	vb->wakeup_signal_mask &= ~mask;
+	spin_unlock_irq(&vb->wakeup_lock);
+}
+
+static void finish_wakeup_event(struct virtio_balloon *vb)
+{
+	spin_lock_irq(&vb->wakeup_lock);
+	if (!vb->wakeup_signal_mask && vb->processing_wakeup_event) {
+		vb->processing_wakeup_event = false;
+		pm_relax(&vb->vdev->dev);
+	}
+	spin_unlock_irq(&vb->wakeup_lock);
+}
+
 static void balloon_ack(struct virtqueue *vq)
 {
 	struct virtio_balloon *vb = vq->vdev->priv;
@@ -370,8 +403,10 @@ static void stats_request(struct virtqueue *vq)
 	struct virtio_balloon *vb = vq->vdev->priv;
 
 	spin_lock(&vb->stop_update_lock);
-	if (!vb->stop_update)
+	if (!vb->stop_update) {
+		start_wakeup_event(vb, STATS_WAKEUP_SIGNAL);
 		queue_work(system_freezable_wq, &vb->update_balloon_stats_work);
+	}
 	spin_unlock(&vb->stop_update_lock);
 }
 
@@ -444,29 +479,10 @@ static void virtio_balloon_queue_free_page_work(struct virtio_balloon *vb)
 
 static void start_update_balloon_size(struct virtio_balloon *vb)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&vb->adjustment_lock, flags);
-	vb->adjustment_signal_pending = true;
-	if (!vb->adjustment_in_progress) {
-		vb->adjustment_in_progress = true;
-		pm_stay_awake(&vb->vdev->dev);
-	}
-	spin_unlock_irqrestore(&vb->adjustment_lock, flags);
-
+	start_wakeup_event(vb, ADJUSTMENT_WAKEUP_SIGNAL);
 	queue_work(system_freezable_wq, &vb->update_balloon_size_work);
 }
 
-static void end_update_balloon_size(struct virtio_balloon *vb)
-{
-	spin_lock_irq(&vb->adjustment_lock);
-	if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {
-		vb->adjustment_in_progress = false;
-		pm_relax(&vb->vdev->dev);
-	}
-	spin_unlock_irq(&vb->adjustment_lock);
-}
-
 static void virtballoon_changed(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
@@ -495,7 +511,10 @@ static void update_balloon_stats_func(struct work_struct *work)
 
 	vb = container_of(work, struct virtio_balloon,
 			  update_balloon_stats_work);
+
+	process_wakeup_event(vb, STATS_WAKEUP_SIGNAL);
 	stats_handle_request(vb);
+	finish_wakeup_event(vb);
 }
 
 static void update_balloon_size_func(struct work_struct *work)
@@ -506,9 +525,7 @@ static void update_balloon_size_func(struct work_struct *work)
 	vb = container_of(work, struct virtio_balloon,
 			  update_balloon_size_work);
 
-	spin_lock_irq(&vb->adjustment_lock);
-	vb->adjustment_signal_pending = false;
-	spin_unlock_irq(&vb->adjustment_lock);
+	process_wakeup_event(vb, ADJUSTMENT_WAKEUP_SIGNAL);
 
 	diff = towards_target(vb);
 
@@ -523,7 +540,7 @@ static void update_balloon_size_func(struct work_struct *work)
 	if (diff)
 		queue_work(system_freezable_wq, work);
 	else
-		end_update_balloon_size(vb);
+		finish_wakeup_event(vb);
 }
 
 static int init_vqs(struct virtio_balloon *vb)
@@ -1027,7 +1044,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 	}
 
-	spin_lock_init(&vb->adjustment_lock);
+	spin_lock_init(&vb->wakeup_lock);
 	device_set_wakeup_capable(&vb->vdev->dev, true);
 
 	virtio_device_ready(vdev);
-- 
2.44.0.291.gc1ea87d7ee-goog

