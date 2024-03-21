Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C817D2
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Mar 2024 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710984304; cv=none; b=ebwSzZAwqFeSOYmu4CjZ+PgqtYmD9DxH8H0HewnflgUw9f2G+70839IMPuYvNTJXoB8OIVwu+96PbShyOcNosebvP4bTdQa8WVX8XjItlGciTGfqJtsbB31634OE4HVQDqlNcNA7XNZEMeATiVglowoxAZpoH6TbRyHmkdSLZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710984304; c=relaxed/simple;
	bh=9qViWAiTCFIgFNI104sEmf2/03Isba6KDxtepjBz+As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVXu53eNp9MbI9gqDGeR8zcVCngfFsOZiuPbE6Pdf55MkZFjJ8oySx5Gnq5CmODTfm3iALaa+/X2fkQ5R/e0928d3mxR0F8RxClAw+IGEeBxdxwKoA6QpWDcpLlqLJrFsU2RFzOF1ypgHmRWB3FXEFOwN5DQJrIT64yOBBudNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kj/dJ4uK; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kj/dJ4uK"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE3B54075C
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Mar 2024 01:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AvwsZ91HwHZn
	for <virtualization@lists.linux-foundation.org>;
	Thu, 21 Mar 2024 01:25:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=stevensd@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9E29040743
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E29040743
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kj/dJ4uK
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E29040743
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Mar 2024 01:25:00 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-29df3333d30so404664a91.1
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Mar 2024 18:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710984300; x=1711589100; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKMmiCHffcx2ZBQ5QrgfnTfmU8fHpt/uWul6SXcgwsw=;
        b=kj/dJ4uKVlrvuqjOKe8hjJLTCXKIYKBUxoakBBiAF7A3Xh1UWUlag6QX5C2rCLOq2A
         EdZ127YTksWyHKkReIDfeC6Ka085r3sDguym60h36LOJkOyDpf/7st2sMMCsu8lwsdoY
         HURpsFkF29R3119AW3HgBbMVL2PPYxTJ7OAo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710984300; x=1711589100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKMmiCHffcx2ZBQ5QrgfnTfmU8fHpt/uWul6SXcgwsw=;
        b=V9UP4xmlNcsZ0h7+a8ISNiGWFaSuU3ypTbb0R9SPe6EEW71sBUxZvfI2jE1mr+NMcn
         gXRyrLQaJZ5tNf4vXRP3LWUsu3bCQYuvfO6wqTa1U6wB0QPA8TBZzqysr3Zc5Qoxi/N8
         QwnU56ioYlmtxTCTulZyTTFSpJ04LmTqYWq3WRQolNa3IQ2j2lG9De5+fBWDYOZF5YQu
         t0mWU9eix5Tpmh98yCZw7U96xXg78dob90YytatyQfOusbDcqzZDACzhgVp1QQ/3MgBS
         aKauWbLE7an2srj01EoeET+kigENem6vJLoeb/etxmEhiJvraaxzjKNdW0Pc4ubg4iIw
         U4Jw==
X-Gm-Message-State: AOJu0YzT+HU4gsPSky0qYle1aO+yyV8OKf2kHTCt244JGi5jQ8msLeef
	A188+a2++1/wCdUCfr2sDeaoofwDQUsaTwLuta95e+PslZ2nQRbkWQjnPJqOoQ==
X-Google-Smtp-Source: AGHT+IFblfDsuIjIHTVJCb0dAYrbnIzAn8PgVyToCqQbTiekWIhtFt694PRGUKrwdZCzQZU0XxixSQ==
X-Received: by 2002:a17:90b:4cc3:b0:29c:7620:6fde with SMTP id nd3-20020a17090b4cc300b0029c76206fdemr746531pjb.36.1710984300365;
        Wed, 20 Mar 2024 18:25:00 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d837:1d3e:d3cd:7674])
        by smtp.gmail.com with UTF8SMTPSA id sw15-20020a17090b2c8f00b0029bc2b845c4sm2309353pjb.11.2024.03.20.18.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 18:25:00 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 1/2] virtio_balloon: Give the balloon its own wakeup source
Date: Thu, 21 Mar 2024 10:24:44 +0900
Message-ID: <20240321012445.1593685-2-stevensd@google.com>
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

Wakeup sources don't support nesting multiple events, so sharing a
single object between multiple drivers can result in one driver
overriding the wakeup event processing period specified by another
driver. Have the virtio balloon driver use the wakeup source of the
device it is bound to rather than the wakeup source of the parent
device, to avoid conflicts with the transport layer.

Note that although the virtio balloon's virtio_device itself isn't what
actually wakes up the device, it is responsible for processing wakeup
events. In the same way that EPOLLWAKEUP uses a dedicated wakeup_source
to prevent suspend when userspace is processing wakeup events, a
dedicated wakeup_source is necessary when processing wakeup events in a
higher layer in the kernel.

Fixes: b12fbc3f787e ("virtio_balloon: stay awake while adjusting balloon")
Signed-off-by: David Stevens <stevensd@chromium.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..89bc8da80519 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -450,7 +450,7 @@ static void start_update_balloon_size(struct virtio_balloon *vb)
 	vb->adjustment_signal_pending = true;
 	if (!vb->adjustment_in_progress) {
 		vb->adjustment_in_progress = true;
-		pm_stay_awake(vb->vdev->dev.parent);
+		pm_stay_awake(&vb->vdev->dev);
 	}
 	spin_unlock_irqrestore(&vb->adjustment_lock, flags);
 
@@ -462,7 +462,7 @@ static void end_update_balloon_size(struct virtio_balloon *vb)
 	spin_lock_irq(&vb->adjustment_lock);
 	if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {
 		vb->adjustment_in_progress = false;
-		pm_relax(vb->vdev->dev.parent);
+		pm_relax(&vb->vdev->dev);
 	}
 	spin_unlock_irq(&vb->adjustment_lock);
 }
@@ -1029,6 +1029,15 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	spin_lock_init(&vb->adjustment_lock);
 
+	/*
+	 * The virtio balloon itself can't wake up the device, but it is
+	 * responsible for processing wakeup events passed up from the transport
+	 * layer. Wakeup sources don't support nesting/chaining calls, so we use
+	 * our own wakeup source to ensure wakeup events are properly handled
+	 * without trampling on the transport layer's wakeup source.
+	 */
+	device_set_wakeup_capable(&vb->vdev->dev, true);
+
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
-- 
2.44.0.291.gc1ea87d7ee-goog

