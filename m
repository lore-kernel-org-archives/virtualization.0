Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D7374D1
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LwC7usLK"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F082A43539
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 11:43:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F082A43539
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LwC7usLK
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VKTir1jZR3e5
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Dec 2023 11:43:57 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF3124028D
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 11:43:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF3124028D
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d32c5ce32eso1515955ad.0
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 03:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702295036; x=1702899836; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWSOqTGWbN7/1kah/VavpIcFubAITMhMWD90A/nR/50=;
        b=LwC7usLKWtLdwP1qiZzgs1gadRvCR+upb5fw1DAgR19ZA49lDlmzvNJ9apHQWs7oXT
         4E7dWOD4yZS9ACXVVGauAJSouKTYbDDAWcRRHBWuhgIchuka6djDefuM/pHVrLRvYVNd
         SA6DgzWdkyx0NJt47tAkArcG80EGXzeOlPXjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702295036; x=1702899836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWSOqTGWbN7/1kah/VavpIcFubAITMhMWD90A/nR/50=;
        b=CWGKQVh3vqI1GOuPrOb0r6U/4jvlcgulPyUDhMM5c/DhR2X44ax6RJ1C4RS7Xextwm
         oS2xqQz9TG6Fasgh7A9aMsu8aVXSWm+isBjmBb7YdgX9aD9C7UV+NfvQOrpanJ6XQrzB
         d0HDkciTASiDLcmwjNkQgk22LDGQ2vuzK/giP4fp5dZS/h0TA4R5s5vi2YwRH5BbIXLN
         1eAhBHUvTZeUsrE8SJrqqtWkZyqfTKk4MJdCRY/vMekqYyDvpWh1PsGAa3gq4CuBhfp5
         KE3G+Br2/cAB9z4f2oMBTezHoFtYdU35AeX6jFrtKhSFwtVf3zoErSaiv4zxq9NGJhvv
         HBCg==
X-Gm-Message-State: AOJu0YyTFyRa7xYOj9vEHJi9Sh2vLUA10OhDj0V1P7MIR2tZgmsT3Iqk
	IhklMYzi5MJPVYCgtTTqXQCx4Q==
X-Google-Smtp-Source: AGHT+IH7Xh1az1wiQpVmjLradIRIrBROYVFJjrZ2ymcEvhmwqw1W9rUCiU1B3MJGvYEVoR+YJZt6iA==
X-Received: by 2002:a17:902:ecc4:b0:1d0:7b67:c535 with SMTP id a4-20020a170902ecc400b001d07b67c535mr5058442plh.17.1702295036027;
        Mon, 11 Dec 2023 03:43:56 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f046:fcb8:db69:41ed])
        by smtp.gmail.com with UTF8SMTPSA id n2-20020a170902d2c200b001cfd0ddc5b9sm6388253plc.262.2023.12.11.03.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 03:43:55 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH] virtio_balloon: stay awake while adjusting balloon
Date: Mon, 11 Dec 2023 20:43:46 +0900
Message-ID: <20231211114346.1132386-1-stevensd@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

Add a wakeup event for when the balloon is inflating or deflating.
Userspace can enable this wakeup event to prevent the system from
suspending while the balloon is being adjusted. This allows
/sys/power/wakeup_count to be used without breaking virtio_balloon's
cooperative memory management.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1fe93e93f5bc..811d8937246a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -119,6 +119,11 @@ struct virtio_balloon {
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
+
+	/* State for keeping the wakeup_source active while adjusting the balloon */
+	spinlock_t adjustment_lock;
+	u32 adjustment_seqno;
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
+	vb->adjustment_seqno++;
+	if (!vb->adjustment_in_progress) {
+		vb->adjustment_in_progress = true;
+		pm_stay_awake(&vb->vdev->dev);
+	}
+	spin_unlock_irqrestore(&vb->adjustment_lock, flags);
+
+	queue_work(system_freezable_wq, &vb->update_balloon_size_work);
+}
+
+static void end_update_balloon_size(struct virtio_balloon *vb, u32 seqno)
+{
+	spin_lock(&vb->adjustment_lock);
+	if (vb->adjustment_seqno == seqno && vb->adjustment_in_progress) {
+		vb->adjustment_in_progress = false;
+		pm_relax(&vb->vdev->dev);
+	}
+	spin_unlock(&vb->adjustment_lock);
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
@@ -473,22 +502,29 @@ static void update_balloon_size_func(struct work_struct *work)
 {
 	struct virtio_balloon *vb;
 	s64 diff;
+	u32 seqno;
 
 	vb = container_of(work, struct virtio_balloon,
 			  update_balloon_size_work);
-	diff = towards_target(vb);
 
-	if (!diff)
-		return;
+	spin_lock(&vb->adjustment_lock);
+	seqno = vb->adjustment_seqno;
+	spin_unlock(&vb->adjustment_lock);
 
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
+		end_update_balloon_size(vb, seqno);
 }
 
 static int init_vqs(struct virtio_balloon *vb)
@@ -992,6 +1028,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 	}
 
+	spin_lock_init(&vb->adjustment_lock);
+	device_set_wakeup_capable(&vb->vdev->dev, true);
+
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
-- 
2.43.0.472.g3155946c3a-goog

