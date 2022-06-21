Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5A0C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 16:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 595F2404E5;
	Tue, 21 Jun 2022 16:09:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 595F2404E5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VBqKbmtn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e96O_ZQtZN42; Tue, 21 Jun 2022 16:09:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2578940492;
	Tue, 21 Jun 2022 16:09:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2578940492
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8B4FC0039;
	Tue, 21 Jun 2022 16:09:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 884EDC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 16:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 630E460E53
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 16:09:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 630E460E53
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VBqKbmtn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FpzUr7OegdD1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 16:09:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81CFC60E2A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81CFC60E2A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 16:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655827746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwdoYcSexrOCzV1teWJ7RyQQyOgHsOoOsUPcLIRzoFM=;
 b=VBqKbmtnn78BqU52r6XPrKrm133FzkCRmI+bknxwa2L25nB7UJfduHsjL/WWzYedoWBgf5
 +T3bgGFO8L8+oc+ihgsSzHL9QkZtc9aSRJ6wJuT6/1Bb1xGyaid0qSkI5JC1o7MI2h7WZZ
 DP6LZ3A8Hh8UhUN88vWnjzeb1drBW3U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-3kh9ilo0P0uGSZTgarL84A-1; Tue, 21 Jun 2022 12:09:06 -0400
X-MC-Unique: 3kh9ilo0P0uGSZTgarL84A-1
Received: by mail-wr1-f69.google.com with SMTP id
 e21-20020adfa455000000b0021b80b12356so2867974wra.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QwdoYcSexrOCzV1teWJ7RyQQyOgHsOoOsUPcLIRzoFM=;
 b=4fuDgcvcLZtqt7zAj6CT+SZAW5Ht7bx/uCVVfdVnCX4PSl/2ARDeUX7csEZRjgeVeG
 1+NnpdrKOc+4VUaxX8gNvi/NcnmAvrhET/zkaUn6MDY3y3YFpQrblaE6vEYLFAxpsA7A
 JfN5RbSXLOpJNCkt3pF6CPPsPOgTD1HplfP2ZuJSYFrBkP1AH7kd9LQ4aKzNf0/yqwYp
 QOyKXNiOXgjgOz5vPfoQlZA8gfxWMHla/HNNlBbjLrj1GlqpGo67cr7qqp6oeSuMgDD0
 R/3Hpn0u6U0boHqGiZZs9GLcCixUlZlWcakKZMUFJL4Z0jA50YywE31yy5vLvNZoA0Hp
 Kb0w==
X-Gm-Message-State: AJIora9o3LxWKhiFuXr0umY0evGDCl5SrRwqb+h/Xd/jORpzVqvZvWM0
 6LdEpvTOHbuY/qrEwR/8u9sgCEDi7HD7zGOSIp61ZPK23Emc+iN7LEgfP4snQA/pdUP16WIL8+H
 gT0mHiE7OCslmuhaoFaUQc/DlcNrGJUhob4H5W66XsSSqukL5Gwp416wvIFzyPh3D2VBDWx7mT5
 kYiOCqDXAMLn5LnwVhIA==
X-Received: by 2002:a05:600c:3489:b0:39d:b58f:6797 with SMTP id
 a9-20020a05600c348900b0039db58f6797mr31017440wmq.205.1655827744278; 
 Tue, 21 Jun 2022 09:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtz1/kwO2GKBAW1YJVuUDOT0/wuEhfMdbVmbF7WpAqjGTrMqa7Xyd1gz62UtYc+FOogELr3Q==
X-Received: by 2002:a05:600c:3489:b0:39d:b58f:6797 with SMTP id
 a9-20020a05600c348900b0039db58f6797mr31017415wmq.205.1655827743985; 
 Tue, 21 Jun 2022 09:09:03 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 ba7-20020a0560001c0700b0021b903a018bsm6531560wrb.92.2022.06.21.09.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jun 2022 09:09:03 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 1/3] vdpa_sim_blk: use dev_dbg() to print errors
Date: Tue, 21 Jun 2022 18:08:57 +0200
Message-Id: <20220621160859.196646-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621160859.196646-1-sgarzare@redhat.com>
References: <20220621160859.196646-1-sgarzare@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

Use dev_dbg() instead of dev_err()/dev_warn() to avoid flooding the
host with prints, when the guest driver is misbehaving.
In this way, prints can be dynamically enabled when the vDPA block
simulator is used to validate a driver.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 42d401d43911..a83a5c76f620 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -76,13 +76,13 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		return false;
 
 	if (vq->out_iov.used < 1 || vq->in_iov.used < 1) {
-		dev_err(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
+		dev_dbg(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
 			vq->out_iov.used, vq->in_iov.used);
 		return false;
 	}
 
 	if (vq->in_iov.iov[vq->in_iov.used - 1].iov_len < 1) {
-		dev_err(&vdpasim->vdpa.dev, "request in header too short\n");
+		dev_dbg(&vdpasim->vdpa.dev, "request in header too short\n");
 		return false;
 	}
 
@@ -96,7 +96,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &hdr,
 				      sizeof(hdr));
 	if (bytes != sizeof(hdr)) {
-		dev_err(&vdpasim->vdpa.dev, "request out header too short\n");
+		dev_dbg(&vdpasim->vdpa.dev, "request out header too short\n");
 		return false;
 	}
 
@@ -110,7 +110,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	switch (type) {
 	case VIRTIO_BLK_T_IN:
 		if (!vdpasim_blk_check_range(sector, to_push)) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"reading over the capacity - offset: 0x%llx len: 0x%zx\n",
 				offset, to_push);
 			status = VIRTIO_BLK_S_IOERR;
@@ -121,7 +121,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 					      vdpasim->buffer + offset,
 					      to_push);
 		if (bytes < 0) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_push_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
 				bytes, offset, to_push);
 			status = VIRTIO_BLK_S_IOERR;
@@ -133,7 +133,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 
 	case VIRTIO_BLK_T_OUT:
 		if (!vdpasim_blk_check_range(sector, to_pull)) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"writing over the capacity - offset: 0x%llx len: 0x%zx\n",
 				offset, to_pull);
 			status = VIRTIO_BLK_S_IOERR;
@@ -144,7 +144,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 					      vdpasim->buffer + offset,
 					      to_pull);
 		if (bytes < 0) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_pull_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
 				bytes, offset, to_pull);
 			status = VIRTIO_BLK_S_IOERR;
@@ -157,7 +157,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 					      vdpasim_blk_id,
 					      VIRTIO_BLK_ID_BYTES);
 		if (bytes < 0) {
-			dev_err(&vdpasim->vdpa.dev,
+			dev_dbg(&vdpasim->vdpa.dev,
 				"vringh_iov_push_iotlb() error: %zd\n", bytes);
 			status = VIRTIO_BLK_S_IOERR;
 			break;
@@ -167,8 +167,8 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		break;
 
 	default:
-		dev_warn(&vdpasim->vdpa.dev,
-			 "Unsupported request type %d\n", type);
+		dev_dbg(&vdpasim->vdpa.dev,
+			"Unsupported request type %d\n", type);
 		status = VIRTIO_BLK_S_IOERR;
 		break;
 	}
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
