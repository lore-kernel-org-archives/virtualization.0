Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537842C688
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Mar 2024 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753054; cv=none; b=gqU79wG7CMbhJsz0DsmKo3e2/ifeCTS7y9uYUTW0X9Crm70g/TioU9VDkDGt5hRLNleZglwzo9Muc96PpAYmzI5oCaCM8fXQr+evtWtOYJw8T1LufuIEueG+p+ugnbEH0EOfl2LGWYDhqdJiKYqKs7g6uqN44DPxYq4JlPcKGWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753054; c=relaxed/simple;
	bh=AEbkWv6kVBRVdwmlsE4qnTwSVZJF80FknKhy9jehwtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzBC6ypH+Ji2vbu0e3ASIssp2uF/bKG6Q+qPvbgbkf1jExqUfmuvxhu8+fG0vgKpNhH9v9WgmRYRzcOF6lWs9TgA4WxVBU/U7k+MDnqeq+vpXaRt/x6AFEzrCbH1cRHutpZp37G6HR3a3o6S+ZruftKyuARVY/TZGeUOWZLgrUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M9bHa4cu; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9bHa4cu"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB6BA400F8
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Mar 2024 09:10:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7GgEHoWCeyHv
	for <virtualization@lists.linux-foundation.org>;
	Mon, 18 Mar 2024 09:10:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=stevensd@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D1F6640017
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1F6640017
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=M9bHa4cu
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D1F6640017
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Mar 2024 09:10:49 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1dfff641d10so7070325ad.2
        for <virtualization@lists.linux-foundation.org>; Mon, 18 Mar 2024 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710753049; x=1711357849; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4k9PEqyseGl9R4Xjb6sD+hX6x38ZM1eW1FtX5qGx6w=;
        b=M9bHa4cukZ+zWJPZjppwYB02ia5CVLiul+19Ka33zpJDksWLMnLDTYrVCrnC6i4V2n
         OoMHXyREHRjZXd/VUbIaqt3sRIMaTENxVXgXDotmVEZPZqbRJ7joPxsDq5f9Sw3d5yZJ
         neIf55oNnuunP/wHkkVzo41A7hJqQ9POm2s2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753049; x=1711357849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4k9PEqyseGl9R4Xjb6sD+hX6x38ZM1eW1FtX5qGx6w=;
        b=kfq7dJfEThby0/iVocLsO1hh7y7v0BW/dmKRJvYS2oOjwAfNPltTAGJH2ckZ3fSv+y
         Hqpbtmv1B6hLtphzko9DFG+k0ZUN7U/3H8MNt61QcfGeee5Kx23tL9rWhNsZ6f5tGDEl
         ZePu0xa/heKEKXVPlsdr7Xn2OoAfp+zQ/A0I6moiYB0c/xOSe91WU/a7q9qMV3H2x44U
         ZoBw4kXb4rDGdib1DieOxfEH2AjgsMGYIyPjbaD/i2qpQn9+JmRXayIoW+hKC0FhPYKT
         j4cRJvvFtb7xSU9llUPSckd+2qbgncImpKMzAREF9Tso/b3cWkS7KGFhZPzBs/Aur1TW
         EMjg==
X-Gm-Message-State: AOJu0Yw2qMRC1Yoj2PX3rVQuWBR/g0dvy1UMfkOEzSfIj0Hdlk7DgJwq
	ZDWGq+kH/QAJsX02npvdp2yKx4s622ZWnoGxRVNbMm5MGs9TFgqVoJ45FwoIfw==
X-Google-Smtp-Source: AGHT+IFdSR0Hi+GPovYTovnK7ZCWypCpDqw5SyDfY+jC/DJpAUK2tThpxcCKoa66LOiGKPWGw/bDZg==
X-Received: by 2002:a17:902:a3cf:b0:1de:dcb4:b0b9 with SMTP id q15-20020a170902a3cf00b001dedcb4b0b9mr10201447plb.40.1710753048934;
        Mon, 18 Mar 2024 02:10:48 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:171e:5cf4:dcfa:390f])
        by smtp.gmail.com with UTF8SMTPSA id u4-20020a170902e5c400b001dc01efaec2sm3569171plf.168.2024.03.18.02.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 02:10:48 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH 1/2] virtio_balloon: Give the balloon its own wakeup source
Date: Mon, 18 Mar 2024 18:10:33 +0900
Message-ID: <20240318091034.535573-2-stevensd@google.com>
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
---
 drivers/virtio/virtio_balloon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..7fe7ef5f1c77 100644
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
@@ -1028,6 +1028,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	}
 
 	spin_lock_init(&vb->adjustment_lock);
+	device_set_wakeup_capable(&vb->vdev->dev, true);
 
 	virtio_device_ready(vdev);
 
-- 
2.44.0.291.gc1ea87d7ee-goog

