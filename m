Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A64B20E8
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="haLiI+wq"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AB1CA435F3
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 02:19:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB1CA435F3
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=haLiI+wq
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2E_N7hhSOL9v
	for <virtualization@lists.linux-foundation.org>;
	Wed, 10 Jan 2024 02:19:38 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 67461402F4
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 02:19:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67461402F4
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3bbd6f87959so2935446b6e.1
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jan 2024 18:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704853177; x=1705457977; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDxSSelDpoPAQNyNUVcKc0KClc7DkRzMA025xPQnKWc=;
        b=haLiI+wquA73br+2abhyzwgq9R0tLaY1NSjB0RTBADVeo5zBLj9nsSQ5dran05cqtp
         lN5rs3n2+uh6GrtYIemL2sM5eL0TNp575m75xF0GeGSQOD32sTZMfik1wvDTwKUeozLM
         N0jryjL8WF6rYd5C3v8m/Cy4bGUDJIlfPe8fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704853177; x=1705457977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDxSSelDpoPAQNyNUVcKc0KClc7DkRzMA025xPQnKWc=;
        b=lo521ZHvoFv/1Z/HpoosOdtSv7pYiDJuT1m7hf9nq+nKWIHQMBBeHqXv3s5dwzTIN0
         NnGWByl6A4vPtLoJor7p19I3rOHEKHjyZKvxk3x4KYqesD4JyzF9Yw/nJiFUt++8p0rA
         PGiAi3rE7x3Gvyi6XzG3TLTrvEZ+WsEvh3lLyUfqLcWrFBMK8DQ1UPENTWA2j0kiwNUT
         BdvN3gqi6NRIak9TgWuDvbllS7e7UeLO/Y6anxI5k6LQ/REw7s1QbYcB4yJR8aD+pjxX
         lfV3ijhMiDgSDUxvoaZR2Rhx6TTAAvl0BtqcZ4j8dqZB7nsQCUm/1sPdBxWRLlGpIC7i
         zYtQ==
X-Gm-Message-State: AOJu0Yzqr5Pv/Vp/QYquNA448s8J8G9w4XLiBvL2oLXJDz6IuGdrcaMh
	oX7ch3iCKHLrQtU8saOPR8TVkiRVauHP
X-Google-Smtp-Source: AGHT+IFKHS5gDIO09q4/OhKTSjfjm+tc4wEqOP2FsjkQaw+kuulPuiBk57t/oQBggGgZgoQQef8G/A==
X-Received: by 2002:a05:6808:1289:b0:3bc:316b:e5a8 with SMTP id a9-20020a056808128900b003bc316be5a8mr394036oiw.54.1704853177387;
        Tue, 09 Jan 2024 18:19:37 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:9106:7b1d:78f7:d925])
        by smtp.gmail.com with UTF8SMTPSA id y13-20020aa7854d000000b006d9bb4400f0sm2337199pfn.88.2024.01.09.18.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 18:19:36 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v3] virtio_balloon: stay awake while adjusting balloon
Date: Wed, 10 Jan 2024 11:19:25 +0900
Message-ID: <20240110021925.1137333-1-stevensd@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

A virtio_balloon's parent device may be configured so that a
configuration change interrupt is a wakeup event. Extend the processing
of such a wakeup event until the balloon finishes inflating or deflating
by calling pm_stay_awake/pm_relax in the virtio_balloon driver. Note
that these calls are no-ops if the parent device doesn't support wakeup
events or if the wakeup events are not enabled.

This change allows the guest to use system power states such as s2idle
without running the risk the virtio_balloon's cooperative memory
management becoming unresponsive to the host's requests.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
v2->v3:
 - Use _irq spinlock functions with adjustment_lock in workqueue, since
   the lock is accessed in an interrupt context.
v1 -> v2:
 - Use adjustment_signal_pending flag instead of a sequence number
 - Call pm_stay_awake/pm_relax on parent device instead of adding a wake
   event to the virtio balloon device

 drivers/virtio/virtio_balloon.c | 57 +++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1fe93e93f5bc..fa710e6c505a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -119,6 +119,11 @@ struct virtio_balloon {
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
+
+	/* State for keeping the wakeup_source active while adjusting the balloon */
+	spinlock_t adjustment_lock;
+	bool adjustment_signal_pending;
+	bool adjustment_in_progress;
 };
 
 static const struct virtio_device_id id_table[] = {
@@ -437,6 +442,31 @@ static void virtio_balloon_queue_free_page_work(struct virtio_balloon *vb)
 	queue_work(vb->balloon_wq, &vb->report_free_page_work);
 }
 
+static void start_update_balloon_size(struct virtio_balloon *vb)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&vb->adjustment_lock, flags);
+	vb->adjustment_signal_pending = true;
+	if (!vb->adjustment_in_progress) {
+		vb->adjustment_in_progress = true;
+		pm_stay_awake(vb->vdev->dev.parent);
+	}
+	spin_unlock_irqrestore(&vb->adjustment_lock, flags);
+
+	queue_work(system_freezable_wq, &vb->update_balloon_size_work);
+}
+
+static void end_update_balloon_size(struct virtio_balloon *vb)
+{
+	spin_lock_irq(&vb->adjustment_lock);
+	if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {
+		vb->adjustment_in_progress = false;
+		pm_relax(vb->vdev->dev.parent);
+	}
+	spin_unlock_irq(&vb->adjustment_lock);
+}
+
 static void virtballoon_changed(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
@@ -444,8 +474,7 @@ static void virtballoon_changed(struct virtio_device *vdev)
 
 	spin_lock_irqsave(&vb->stop_update_lock, flags);
 	if (!vb->stop_update) {
-		queue_work(system_freezable_wq,
-			   &vb->update_balloon_size_work);
+		start_update_balloon_size(vb);
 		virtio_balloon_queue_free_page_work(vb);
 	}
 	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
@@ -476,19 +505,25 @@ static void update_balloon_size_func(struct work_struct *work)
 
 	vb = container_of(work, struct virtio_balloon,
 			  update_balloon_size_work);
-	diff = towards_target(vb);
 
-	if (!diff)
-		return;
+	spin_lock_irq(&vb->adjustment_lock);
+	vb->adjustment_signal_pending = false;
+	spin_unlock_irq(&vb->adjustment_lock);
 
-	if (diff > 0)
-		diff -= fill_balloon(vb, diff);
-	else
-		diff += leak_balloon(vb, -diff);
-	update_balloon_size(vb);
+	diff = towards_target(vb);
+
+	if (diff) {
+		if (diff > 0)
+			diff -= fill_balloon(vb, diff);
+		else
+			diff += leak_balloon(vb, -diff);
+		update_balloon_size(vb);
+	}
 
 	if (diff)
 		queue_work(system_freezable_wq, work);
+	else
+		end_update_balloon_size(vb);
 }
 
 static int init_vqs(struct virtio_balloon *vb)
@@ -992,6 +1027,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 	}
 
+	spin_lock_init(&vb->adjustment_lock);
+
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
-- 
2.43.0.472.g3155946c3a-goog

