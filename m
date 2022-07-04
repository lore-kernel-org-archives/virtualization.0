Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EF8C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 17:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3722F408D4;
	Mon,  4 Jul 2022 17:17:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3722F408D4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RSPITYAp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ofzYjuru0yIA; Mon,  4 Jul 2022 17:17:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CC82040600;
	Mon,  4 Jul 2022 17:17:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC82040600
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E615C0032;
	Mon,  4 Jul 2022 17:17:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE84DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C672160B9A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C672160B9A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RSPITYAp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k0fMEqA2WwiZ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FC716001B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FC716001B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656955038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eVND3GM+OEtAkbTKlrFfIkv0IqFoHwP40bUkEd6doGs=;
 b=RSPITYApMKz1cM4nlVsIYDVBJZqtYpti3pqvkVjkuD+pr+zI3Hyd3otsHJqNbc0vL6nVnz
 HgomKnYFykRxFP2NgLs/S39fUJAK5/7qMaae25CkJZUEz9RLk6jkEMhM8YWbKfuxVXEhrw
 6R3yfYOYMewAdcXktSyHQv/eSHwLezk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-oUyfB8jJPB2TD_tGERXEOQ-1; Mon, 04 Jul 2022 13:17:15 -0400
X-MC-Unique: oUyfB8jJPB2TD_tGERXEOQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 u17-20020a05620a0c5100b006b28349b67fso4646684qki.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 10:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eVND3GM+OEtAkbTKlrFfIkv0IqFoHwP40bUkEd6doGs=;
 b=5uysY+SDu+RaDbYLuBuEfNJz+BGf3AjZpeyL4QubPIDZneTAfKPK4SPUPWHlZDdt6Z
 +v4TwEeeB1rVCAAXYFmIGVu0FcTfPNXE7s6ra6CQOOSl2eVRV+eWVZA9baJD5yOHgSfC
 FsMAw14SUFhVmR2WWYVogOozwsMgeOUH3aGl0Eu4aIcoyVSaPWKhgKBnhQF9uTifmMeI
 RBhSmQfEGwY9UI/7J41bz3Pif0oWsrCbqmv7w4EvXqgVLALW1tNFq1EJmcIqxC6YrcxN
 k7WGzeBvC+F0IXW0Yc6EC8PFV85oaMDmDpebSGbW+MzbOxMtvCkfGDS/9i3SmyoktP6C
 ZliA==
X-Gm-Message-State: AJIora+X8W+scmxEjsVM+iwMEIlbMrcgHVehriZTE4gZWId01VLX8Zh4
 B+JyT8vivBt6sAfwXxHmY7G3gKoqH0g1kNBzR9cNJPejd/302MOTx1jJGhhzogsUkmTbvAZGp2E
 7GYD6CrJ3B5HIjny3zG2afyxO8V4vgUCV6fwLECNKc8AMhbCYtBkbGEMqqbRWudY6cv1dFyIMNx
 WI1w9YJjNp1F69PtUHvQ==
X-Received: by 2002:ac8:5b44:0:b0:318:291d:8f59 with SMTP id
 n4-20020ac85b44000000b00318291d8f59mr24361556qtw.22.1656955033451; 
 Mon, 04 Jul 2022 10:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1srxXAHH5r1Kdxl8lINLquxuasM0BWZ/em5yNCcgZULj5nIl3JWsRbNRPyI0zQuAgROZCfdxw==
X-Received: by 2002:ac8:5b44:0:b0:318:291d:8f59 with SMTP id
 n4-20020ac85b44000000b00318291d8f59mr24361526qtw.22.1656955033118; 
 Mon, 04 Jul 2022 10:17:13 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it.
 [79.46.200.206]) by smtp.gmail.com with ESMTPSA id
 o16-20020a05620a2a1000b006a68fdc2d18sm21656078qkp.130.2022.07.04.10.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 10:17:12 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 3/6] virtio_test: call __virtio_unbreak_device
Date: Mon,  4 Jul 2022 19:16:58 +0200
Message-Id: <20220704171701.127665-4-sgarzare@redhat.com>
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

Commit 8b4ec69d7e09 ("virtio: harden vring IRQ") initialize vq->broken
to true, so we need to call __virtio_unbreak_device() before starting
to use it.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/linux/virtio.h | 2 ++
 tools/virtio/virtio_test.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 363b98228301..feb720d4304f 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -66,4 +66,6 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      const char *name);
 void vring_del_virtqueue(struct virtqueue *vq);
 
+void __virtio_unbreak_device(struct virtio_device *dev);
+
 #endif
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 23f142af544a..765e64895dab 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -177,6 +177,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
 	long long spurious = 0;
 	const bool random_batch = batch == RANDOM_BATCH;
 
+	__virtio_unbreak_device(&dev->vdev);
 	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
 	assert(r >= 0);
 	if (!reset_n) {
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
