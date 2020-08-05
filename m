Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEB0C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3217422D05
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPxfHWUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3217422D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 04FE3226D3;
	Wed,  5 Aug 2020 13:44:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oRbcEb6pxfeu; Wed,  5 Aug 2020 13:44:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6684D214FD;
	Wed,  5 Aug 2020 13:44:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50125C0051;
	Wed,  5 Aug 2020 13:44:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBDDBC004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DA3FF87848
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gI4jtohmZlpf
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3384D8781C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q6OJqxU8Sp5UYmolvKk955VfeDV9wjAzILoG6EGszAQ=;
 b=RPxfHWUZXBAKDCfl9zwQSb9YbnYY8vjYenaVj5rYzwYkptKy7b2Ncs28Ne67LO2vsK3VR+
 tx/q9fkzEUxrIKrPCMm9Cm9U71kbU956r78OXnR1f9OJi/8gSIWAZ0Ams9GeTRRhPj570t
 rNIpdJHHrwviDSGnypQ18hfzYpkNj9s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-jUNWX7WfPryh71moxWnwmw-1; Wed, 05 Aug 2020 09:44:52 -0400
X-MC-Unique: jUNWX7WfPryh71moxWnwmw-1
Received: by mail-wm1-f71.google.com with SMTP id h205so2745075wmf.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Q6OJqxU8Sp5UYmolvKk955VfeDV9wjAzILoG6EGszAQ=;
 b=CHeuH5tBbvFvYFc1h+P2380jlwjFIH465hJa3FkASoXdQZglnqvs2snSQ2uGS8WMT9
 6iFXp96Z4by3g5b86rgu/UhLLbyuLvVyL9728OsD+MLX+h1z4UapDHP0zii0Zv2jX7li
 gdA7twcuhhtKEYPxnxuftJ/m1p22v24SfUUZeGgl4Trxi0X/BMieOaozRX03dOX0J6lO
 OB5iKGZUatNW7OJk80VRNyOEd/QveTEDBa+JnF+33f1uej63CUAFpVYO//sICCSRtx9P
 c1RLV71ZEwtuW1aRckTMmicixnQSUfZPI++RwrbJ+JC/uFlFtORFleWv93w3qTwk4gUC
 WxWA==
X-Gm-Message-State: AOAM532L6b1YpMOD3VMDoWCacCDdDtNVZRSngAzJu6eCkzGaaEoU6Zlc
 2DskbWBeiqdZ2/QcgjDY/pRChgu9XRYQo8TGs7gyuiSj4oWm+R/VB1TE6StEfynIcbeN4xquNp8
 lOk4VZ3DbmimZbNCVKUdRcaf1xJPnsclP5/sVKkyjZQ==
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr3637833wmj.128.1596635091102; 
 Wed, 05 Aug 2020 06:44:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIP5APlUbJFDt9cc/+rC2+q+FdTyHsKg7qMGdbwa6FJ2pprZGU/KyCZL+3OX8oaPf4PHL5Hg==
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr3637816wmj.128.1596635090938; 
 Wed, 05 Aug 2020 06:44:50 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 x4sm3352368wru.81.2020.08.05.06.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:50 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 34/38] drm/virtio: convert to LE accessors
Message-ID: <20200805134226.1106164-35-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Virtgpu is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 0a5c8cf409fb..4d944a0dff3e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -39,8 +39,8 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 	u32 events_read, events_clear = 0;
 
 	/* read the config space */
-	virtio_cread(vgdev->vdev, struct virtio_gpu_config,
-		     events_read, &events_read);
+	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
+			events_read, &events_read);
 	if (events_read & VIRTIO_GPU_EVENT_DISPLAY) {
 		if (vgdev->has_edid)
 			virtio_gpu_cmd_get_edids(vgdev);
@@ -49,8 +49,8 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 		drm_helper_hpd_irq_event(vgdev->ddev);
 		events_clear |= VIRTIO_GPU_EVENT_DISPLAY;
 	}
-	virtio_cwrite(vgdev->vdev, struct virtio_gpu_config,
-		      events_clear, &events_clear);
+	virtio_cwrite_le(vgdev->vdev, struct virtio_gpu_config,
+			 events_clear, &events_clear);
 }
 
 static void virtio_gpu_init_vq(struct virtio_gpu_queue *vgvq,
@@ -165,8 +165,8 @@ int virtio_gpu_init(struct drm_device *dev)
 	}
 
 	/* get display info */
-	virtio_cread(vgdev->vdev, struct virtio_gpu_config,
-		     num_scanouts, &num_scanouts);
+	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
+			num_scanouts, &num_scanouts);
 	vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
 				    VIRTIO_GPU_MAX_SCANOUTS);
 	if (!vgdev->num_scanouts) {
@@ -176,8 +176,8 @@ int virtio_gpu_init(struct drm_device *dev)
 	}
 	DRM_INFO("number of scanouts: %d\n", num_scanouts);
 
-	virtio_cread(vgdev->vdev, struct virtio_gpu_config,
-		     num_capsets, &num_capsets);
+	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
+			num_capsets, &num_capsets);
 	DRM_INFO("number of cap sets: %d\n", num_capsets);
 
 	virtio_gpu_modeset_init(vgdev);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
