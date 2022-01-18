Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CBBC433F5
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 15:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B81BD812E5;
	Tue, 18 Jan 2022 15:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cncEfUC9uqX8; Tue, 18 Jan 2022 15:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 71CA2812CC;
	Tue, 18 Jan 2022 15:06:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DC98C0039;
	Tue, 18 Jan 2022 15:06:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF2ECC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CCD0D4094D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ojxlIADW8gNK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:06:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A7A54027B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642518398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6xo5lbFE9mVmkTmHb6sCJ+UU8tLWZ8QGadDUdtyAdg8=;
 b=gUjx/J0Zrk5k31lxpORvGnZ7m2qwyS5TC4rBDJLUHB/7ZmGaUenQhliZzZB5i/WbBORvE0
 XBJdrTWHJMZEGLosIaGMjk/x6/CMWFI2FQmJWhLxNcLDgmH5MJ8f6s+5LxvBbxdRg8nkYB
 7/ro439Qp333qV0OTpxornYYoH6b1q4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-4cyRJIuZPjqq_OZDf8kacg-1; Tue, 18 Jan 2022 10:06:36 -0500
X-MC-Unique: 4cyRJIuZPjqq_OZDf8kacg-1
Received: by mail-qk1-f200.google.com with SMTP id
 b189-20020a3780c6000000b0047b06f34f4cso6471324qkd.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 07:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6xo5lbFE9mVmkTmHb6sCJ+UU8tLWZ8QGadDUdtyAdg8=;
 b=RYVphEyoAknCOeScl4hWddClK0sdiOgC2h6XkmmfU9u85o+aTWRZ30aFWQ+SVFCNtO
 lu9KYK6eDQA6X5QpwH8urZLo+6xwecA/bAcE/O+kVmBHmiidZ0GWdmOdFT6gOwILUSEV
 ZXhHG2KVkLUufG1S2uVBidDxKvQ+TU3SMVas+mIn2MCaCg3oQ7UXLAxwntmT9k1vk4AA
 fvy+f8pxkMZ9r03vmI+a4b4Jbe1XEf0/Q92w/DtxabKMdntSr3gmlBnGkk49+nWmFyKD
 m8G1uKCX5NTvNimuLmK21UHtuFH02vrdRuzGmyVojESTzk23p1r4Lyc/oD9WgqzjA5eU
 ypLQ==
X-Gm-Message-State: AOAM530z3JA9udWlgGE6WGPu3TSZXcmIPnmRy0X2bDKMU9DCUhSdzBxe
 zg+z/g5sH+XJ90cLWKGEbodfXCAGWIDNA2X6pLZNHXdSaxHKfujbFI8ll/wL8sjckLRFGxPs1Pz
 cAjyn7R4nkeya2qWXP6+3h1XT8lygNHTQGtXbbfyKo4qGbjFjyczOUxklpyUl0BIyGlxvHc6Duh
 YpRHeU0JPIAN08GmJSXQ==
X-Received: by 2002:a05:620a:c41:: with SMTP id
 u1mr18228763qki.31.1642518395795; 
 Tue, 18 Jan 2022 07:06:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXEcL4f7ANyD583jjp3XX8T3sNAL4m2po3Z93AidWiJto0LEpLibFjH30+TEsI2sEVNstxRw==
X-Received: by 2002:a05:620a:c41:: with SMTP id
 u1mr18228729qki.31.1642518395480; 
 Tue, 18 Jan 2022 07:06:35 -0800 (PST)
Received: from steredhat.redhat.com
 (host-95-238-125-214.retail.telecomitalia.it. [95.238.125.214])
 by smtp.gmail.com with ESMTPSA id b140sm9127737qkg.113.2022.01.18.07.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jan 2022 07:06:34 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] tools/virtio: fix virtio_test execution
Date: Tue, 18 Jan 2022 16:06:31 +0100
Message-Id: <20220118150631.167015-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

virtio_test hangs on __vring_new_virtqueue() because `vqs_list_lock`
is not initialized.

Let's initialize it in vdev_info_init().

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/virtio_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index cb3f29c09aff..23f142af544a 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -130,6 +130,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 	memset(dev, 0, sizeof *dev);
 	dev->vdev.features = features;
 	INIT_LIST_HEAD(&dev->vdev.vqs);
+	spin_lock_init(&dev->vdev.vqs_list_lock);
 	dev->buf_size = 1024;
 	dev->buf = malloc(dev->buf_size);
 	assert(dev->buf);
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
