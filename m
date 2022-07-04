Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA66CC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 17:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60C968191E;
	Mon,  4 Jul 2022 17:17:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60C968191E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H2jIeC7p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1qT_MuQmX_pa; Mon,  4 Jul 2022 17:17:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F139D818C4;
	Mon,  4 Jul 2022 17:17:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F139D818C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7CC9C0032;
	Mon,  4 Jul 2022 17:17:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B810BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9270940325
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9270940325
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=H2jIeC7p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0nN4o_KKsude
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98D714030F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98D714030F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656955060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSo0TPjRmSn1V/oaklydrMSZvzy1inQBu0gNIodOnPc=;
 b=H2jIeC7p3D/Ftmxf3HlM4JMRG7r310U0C2OSMKOKmah9QupLXxyc34WU9kAS0ZRqLa6vP5
 ZqcRAisjKj7Ask4nCfJ6Jwfrv/20Fn+I2LGjbh4dDnjPw82hCyrMRcfP59ojoCbWU4OsRN
 9HTEb/ofGHoktpJPeLOMeg9dXNRKdtc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-y1WSk7E2MMaKkWoz9vKF6Q-1; Mon, 04 Jul 2022 13:17:39 -0400
X-MC-Unique: y1WSk7E2MMaKkWoz9vKF6Q-1
Received: by mail-qt1-f198.google.com with SMTP id
 ck12-20020a05622a230c00b00304ee787b02so6199861qtb.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 10:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tSo0TPjRmSn1V/oaklydrMSZvzy1inQBu0gNIodOnPc=;
 b=SVT7UjwS/Ikc9AbRFTd0O4uqX5Ced3RFI14fDgeqtWASMd4VrZy/Ndhurza+b0Bmt6
 xA7O4o6nXSj90gDj0oux2GtnXhabr8T8aoZO+EQrYGyswniYTI65b4GJOZy08Nj5Mk+l
 i6Ga6+ypPTySh3Ctdx6CQwjfxiNBbP0nP/7prVglSJgRZwnbyO3HG1a0x1M49RVQtkuG
 s9IqC4iCOKpcNwUQncY6dIW6tzkLtzIVN+CUPyVW0PP/xv70gZgpiejRfcEUWiQsvL62
 UAq2LfNmRNTpTw8o1idlv4Omx5mm7kObUeA9j2qygYA1vGxfK3ikg3w2P5JMj4g6UkdY
 VPJw==
X-Gm-Message-State: AJIora/r1ousdMC5TVgt4Y8q5IB7a8xu19SGQKI4t2JNckNo053jErt3
 Lqj+LgDsTSgn+u/VJHVbtKAXwezHc9qni9ZBNKKUW6ctPMyDP+NGLAME1S+gIRwuT2SbcjUBSbm
 enfN5si2qHY2ObKiBwjL3CsSZJCuqWdDlaCFKeub4bUJ6YSnAvqfyEDSZ7T/gM8FixRA0ipSppM
 HmH/idltpcvslJIMT6og==
X-Received: by 2002:a05:620a:2697:b0:699:cca7:f8b2 with SMTP id
 c23-20020a05620a269700b00699cca7f8b2mr20820473qkp.738.1656955058240; 
 Mon, 04 Jul 2022 10:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uc6e9t+TDjozVIHS20Xkm/89T4WuJyrekSiGRvrPx9nG54HgL0oXw8KiDuQ3MmSutE1rHC3Q==
X-Received: by 2002:a05:620a:2697:b0:699:cca7:f8b2 with SMTP id
 c23-20020a05620a269700b00699cca7f8b2mr20820452qkp.738.1656955057917; 
 Mon, 04 Jul 2022 10:17:37 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it.
 [79.46.200.206]) by smtp.gmail.com with ESMTPSA id
 y7-20020a37f607000000b006a75e8d920bsm10788838qkj.88.2022.07.04.10.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 10:17:37 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 4/6] tools/virtio: move feature negotiation in
 vdev_info_init()
Date: Mon,  4 Jul 2022 19:16:59 +0200
Message-Id: <20220704171701.127665-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704171701.127665-1-sgarzare@redhat.com>
References: <20220704171701.127665-1-sgarzare@redhat.com>
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

The feature negotiation are per device, so it' s better to move them
earlier in vdev_info_init() since vhost_vq_setup() contains the code
to initialize virtqueue.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/virtio_test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 765e64895dab..2d8a3e881637 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -69,7 +69,6 @@ void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
 {
 	struct vhost_vring_state state = { .index = info->idx };
 	struct vhost_vring_file file = { .index = info->idx };
-	unsigned long long features = dev->vdev.features;
 	struct vhost_vring_addr addr = {
 		.index = info->idx,
 		.desc_user_addr = (uint64_t)(unsigned long)info->vring.desc,
@@ -77,8 +76,6 @@ void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
 		.used_user_addr = (uint64_t)(unsigned long)info->vring.used,
 	};
 	int r;
-	r = ioctl(dev->control, VHOST_SET_FEATURES, &features);
-	assert(r >= 0);
 	state.num = info->vring.num;
 	r = ioctl(dev->control, VHOST_SET_VRING_NUM, &state);
 	assert(r >= 0);
@@ -149,6 +146,8 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 	dev->mem->regions[0].memory_size = dev->buf_size;
 	r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
 	assert(r >= 0);
+	r = ioctl(dev->control, VHOST_SET_FEATURES, &features);
+	assert(r >= 0);
 }
 
 /* TODO: this is pretty bad: we get a cache line bounce
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
