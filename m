Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436F4C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3C52065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwCBFXZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3C52065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 03F80877F5;
	Wed,  5 Aug 2020 13:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q3MSiBdd+awI; Wed,  5 Aug 2020 13:44:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 628A0877F8;
	Wed,  5 Aug 2020 13:44:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CC59C0051;
	Wed,  5 Aug 2020 13:44:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82DD9C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 72B808820F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jn8jZlw3AJIg
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C881E8816B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+ItaiktMWQThwK9MNBEGmvl3xKPTH4X3U+c0Slx6t4=;
 b=LwCBFXZnmokhC5qZVyengnu9ZZ5U3MGb6bGZxzt3TnmGD88y9zOaclcloLNaGchIEnE2NV
 j2qa2nRDgj1scH9v/ir2nNfXqgJWfS2Ax8yvCUPfkk5LNp8oNO2puSz6RBXcF7qej7MOwd
 um3mvapCnxEZZP5yNdT+jDjGRmlnAEk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-DBNKt9xCMFKxDHJ5shM_bA-1; Wed, 05 Aug 2020 09:44:16 -0400
X-MC-Unique: DBNKt9xCMFKxDHJ5shM_bA-1
Received: by mail-wm1-f72.google.com with SMTP id u14so1976151wml.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z+ItaiktMWQThwK9MNBEGmvl3xKPTH4X3U+c0Slx6t4=;
 b=hm+UsEgF0LC4ThVk1EG8lMg7Oo+dN2MP8aUojA1XKwgQ8EeS9YXcUKZUeIalcteb43
 zR8zLnRIdzmDe14ELEpV4tHs3yBf4b3DGTMFeZVVjrMiJssOCqFY+/WLiny1aKY3SsBG
 HFAf6LhoRtOTatk0iU3kjcYggGzMQ+hT27wju13s5Dw85ornk9fkPjcvp+rB04YVfLwt
 7+EJO4R+8ix4ciCcHfFxKcEH82ZzRvrP7dThp6q5WWixY1qubfKyjcwlwtMAPhErVGGc
 Fk8FCBA1wa24iN9EkBI/xjK8N2cDS2foq+frORkDotGJgfGQNTud7Rw4NpA+ZTsWglCs
 EZ4A==
X-Gm-Message-State: AOAM530Ste3huRq6Um5qX/OQs6zJBDa5gPJk1EHl39+voEZQvuojqA/E
 dU+NfdFZtoCj9r6++wNo31b7yb99GbZVJZF5JnXMYC285aYIHIMZu8F5niNLTvNr6GwBloWip8L
 R+gSmTRQztWBbZteWfu7yKt8xderdaAKHcP7vDYmY2g==
X-Received: by 2002:a05:6000:1152:: with SMTP id
 d18mr3074176wrx.357.1596635055373; 
 Wed, 05 Aug 2020 06:44:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvA+Frs/2FvOknz7TvvmpwiVR+bgI+oEORnEClWTDh1sDHeItL0iJ+Rvz1Zn02P4rB2YHxLQ==
X-Received: by 2002:a05:6000:1152:: with SMTP id
 d18mr3074160wrx.357.1596635055122; 
 Wed, 05 Aug 2020 06:44:15 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 k1sm2780743wrw.91.2020.08.05.06.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:14 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/38] virtio_vdpa: legacy features handling
Message-ID: <20200805134226.1106164-22-mst@redhat.com>
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
