Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754C5CB5
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Mar 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710984307; cv=none; b=nhZscE+32S5kqQ3I6lnF7gwgeu1IBaarwawg4LThbhIugaPYs8i+IuxNxHXFtvskgxkKAlsi3wMqbH97P4wBsgy7D+B4kQ2XI9qquAYFZ9ASULCTfppnT+0ZOdAMzuIblQNg0L4/8UVqDAjMelmlaua+MZ9+pp4M8beIQ8tefCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710984307; c=relaxed/simple;
	bh=wpS8fm0Fo8ZsmPmoFGOQ3aNztiAVNXAi///YoP3asEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPj4oleGI+xLzDEOEzbuZ+ljAs3S20E/jKjR1Tv3PsX3CIv9lIuIOodvq2IDtjE6/VG9/l5P31uSQxLD3L7fSSFPkKN8JfBx4roUsiCkVO3/Ru6vDOLlu91R+5QNjpZ0MFiw2xu0+IqNcsOHbaQ9jIN6gr4iywMzNxbsmRX50QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=arFBpH5J; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="arFBpH5J"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A1194075C
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Mar 2024 01:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4MpFLCHUeC2Z
	for <virtualization@lists.linux-foundation.org>;
	Thu, 21 Mar 2024 01:25:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=stevensd@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 03D9440743
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03D9440743
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=arFBpH5J
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 03D9440743
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Mar 2024 01:25:04 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1deefb08b9eso2807975ad.3
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Mar 2024 18:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710984304; x=1711589104; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bwghl2kBHBb0RS0OTenXBt5Ga/ttCmAZ1ErfJHsePc=;
        b=arFBpH5Jb+2TbVy5acbTDcd+9COZyEuMPYDqUxl3jpsCUiLP7pueDLM3aRqcXVL0k3
         XykMF3WrIXAW+yXpU2V6K3hXpVK1aB+ENszcXzFrFpO7uhRE1+MnGiSj3b6NtCR27+G/
         zpooI9/+ZFgO3fcXlzJzJ+obCyuDnNRIvVij0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710984304; x=1711589104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bwghl2kBHBb0RS0OTenXBt5Ga/ttCmAZ1ErfJHsePc=;
        b=ZkmlhNiG2fKXf7s9UWdZL7xFv3B4eOZjKujOKVq65nLeyXsqVD4jpnpqdcpxDGnr/c
         H66jAyr56/JOAml9qwnjQi4uZNHRzGdz7D96TWtGAR++4wPsFEajB66Bv1hwubt5Zyif
         xnCJLnEHmUScfalL6q6PyHhdvH4OxYklqiJotjgSUYDEUJ3cOXJUEPoTu0tbEr7UEywf
         Fkkyxfl0appLRa4YH//8K1B/oREpLNute4znag+xD0UISqpTKS6YtGFRpsXeuDdhcGzg
         SduLI/yb+nFJ4n6kxKPziQF4lFE98w9iMo26syaWnUx9NfIcqAgpjX1f+FpiYjevVAy2
         L6rw==
X-Gm-Message-State: AOJu0YylszxHO4FAwx9UG+7FCGSh2DoR75Lmqr0pND2UHfidQAdVlCFw
	HK5LUi/zrUo1k1nf54XtuFVVvzx7jbH9YBbmyXRIQKFFc/+xdjCIxkYuQwhL5g==
X-Google-Smtp-Source: AGHT+IFZHrEsSnSQLHK7vl91mKd0fj+nzVpmHYMY60a4WFFk+eLOrsMqyzek1/2wU1jM5XYbDU4/rg==
X-Received: by 2002:a17:902:e5c8:b0:1de:f29e:d7b with SMTP id u8-20020a170902e5c800b001def29e0d7bmr8585541plf.64.1710984303775;
        Wed, 20 Mar 2024 18:25:03 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d837:1d3e:d3cd:7674])
        by smtp.gmail.com with UTF8SMTPSA id v2-20020a170903238200b001dc3c4e7a12sm14411710plh.14.2024.03.20.18.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 18:25:03 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 2/2] virtio_balloon: Treat stats requests as wakeup events
Date: Thu, 21 Mar 2024 10:24:45 +0900
Message-ID: <20240321012445.1593685-3-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240321012445.1593685-1-stevensd@google.com>
References: <20240321012445.1593685-1-stevensd@google.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 75 ++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 89bc8da80519..b09e8e3c62e5 100644
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
 
+#define VIRTIO_BALLOON_WAKEUP_SIGNAL_ADJUST (1 << 0)
+#define VIRTIO_BALLOON_WAKEUP_SIGNAL_STATS (1 << 1)
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
+		start_wakeup_event(vb, VIRTIO_BALLOON_WAKEUP_SIGNAL_STATS);
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
+	start_wakeup_event(vb, VIRTIO_BALLOON_WAKEUP_SIGNAL_ADJUST);
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
+	process_wakeup_event(vb, VIRTIO_BALLOON_WAKEUP_SIGNAL_STATS);
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
+	process_wakeup_event(vb, VIRTIO_BALLOON_WAKEUP_SIGNAL_ADJUST);
 
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
 
 	/*
 	 * The virtio balloon itself can't wake up the device, but it is
-- 
2.44.0.291.gc1ea87d7ee-goog

