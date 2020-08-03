Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA9CC433E0
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04D022C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElgYwo0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04D022C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 565CC207A6;
	Mon,  3 Aug 2020 21:00:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id abWn0wF1hslq; Mon,  3 Aug 2020 21:00:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D044C207A1;
	Mon,  3 Aug 2020 21:00:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6513C0050;
	Mon,  3 Aug 2020 21:00:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F153C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7F0288657C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cu1OuRTi1Mvw
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E13F2864B8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+ItaiktMWQThwK9MNBEGmvl3xKPTH4X3U+c0Slx6t4=;
 b=ElgYwo0Z8Qa2gHDPwFEOaSPfgtMgoR/M7T8UGKDsrPw1X6JX2A4PzPdIjsRmFGwqi6MT7i
 YfzO5Wo35eP2knBAX0+C5zc+aZTg1Dp4EZtPIQconJ7ihmqCQsq62L8POBe7Nmjawrqqhz
 e+z4JcX+Dc4utuoWF62Ds0pdr+6cMaU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-hr5HPQi8OKCX9EWnH6mIpw-1; Mon, 03 Aug 2020 17:00:20 -0400
X-MC-Unique: hr5HPQi8OKCX9EWnH6mIpw-1
Received: by mail-qv1-f72.google.com with SMTP id h6so5134714qvz.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 14:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z+ItaiktMWQThwK9MNBEGmvl3xKPTH4X3U+c0Slx6t4=;
 b=ANEXJBwN41ohljuqhB3MGsIXrWksi+/Ynxgwes7DEgVmlC35euO+mH9PkNBm7Pdulm
 ilA9PtCl9UhYs/WYnIMRIrfWiJsG8umC9KMj0YJ3El3tmqlLvUPUZU0ehah5Vrkh7qOQ
 UtCGFe43xqd6z1BwRPq9rHQOAuK0M8WMK91UsCfMiDRiav8qU0a66SZ/SihoH3HoWa16
 7ROJ/jZnGBrVMlGDszT6KSP735ghRxtqo639UXgHudQXxOnlGKW7cxKWVukmXto+DmYM
 RxpFGQdJUpxNxJiyaC5VoJJ2cVtHGgF15bknvW5Txh8AQaFNShk58er6OXY1Y8M8dCeK
 32sA==
X-Gm-Message-State: AOAM530NgwJVhx+g0TriiqdZFP3tNJkXYCaY9jUVgM1RV7y+gHoZpUe5
 bEKDJX04apPBaZ1XFUq3di9q5hvCNCD49OMpfV2VLy6KrFbEISP89NBAZKi5uP6CeSW70n/5iDU
 wZ90Hm6KLNhfH5Y+fucYOecSsufNCysnuu5OroJ4bbg==
X-Received: by 2002:ac8:67c9:: with SMTP id r9mr18651350qtp.301.1596488419951; 
 Mon, 03 Aug 2020 14:00:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzloXbOQAlj4ro+4XgmgIovn+tYHtggGdaX11HDzJFycK9jYjTdhtwEjKQPzQhIBulzPwzfyg==
X-Received: by 2002:ac8:67c9:: with SMTP id r9mr18651337qtp.301.1596488419750; 
 Mon, 03 Aug 2020 14:00:19 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id i19sm19928319qkk.68.2020.08.03.14.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 14:00:19 -0700 (PDT)
Date: Mon, 3 Aug 2020 17:00:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/24] virtio_vdpa: legacy features handling
Message-ID: <20200803205814.540410-22-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

We normally expect vdpa to use the modern interface.
However for consistency, let's use same APIs as vhost
for legacy guests.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_vdpa.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index c30eb55030be..4a9ddb44b2a7 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -57,9 +57,8 @@ static void virtio_vdpa_get(struct virtio_device *vdev, unsigned offset,
 			    void *buf, unsigned len)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
-	const struct vdpa_config_ops *ops = vdpa->config;
 
-	ops->get_config(vdpa, offset, buf, len);
+	vdpa_get_config(vdpa, offset, buf, len);
 }
 
 static void virtio_vdpa_set(struct virtio_device *vdev, unsigned offset,
@@ -101,9 +100,8 @@ static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
 static void virtio_vdpa_reset(struct virtio_device *vdev)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
-	const struct vdpa_config_ops *ops = vdpa->config;
 
-	return ops->set_status(vdpa, 0);
+	vdpa_reset(vdpa);
 }
 
 static bool virtio_vdpa_notify(struct virtqueue *vq)
@@ -294,12 +292,11 @@ static u64 virtio_vdpa_get_features(struct virtio_device *vdev)
 static int virtio_vdpa_finalize_features(struct virtio_device *vdev)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
-	const struct vdpa_config_ops *ops = vdpa->config;
 
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
-	return ops->set_features(vdpa, vdev->features);
+	return vdpa_set_features(vdpa, vdev->features);
 }
 
 static const char *virtio_vdpa_bus_name(struct virtio_device *vdev)
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
