Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1961C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 22:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 621EE81852;
	Mon, 15 Aug 2022 22:00:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 621EE81852
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EHiMupOJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gWN3-Kq6DpDe; Mon, 15 Aug 2022 22:00:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0742381842;
	Mon, 15 Aug 2022 22:00:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0742381842
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D08B1C0033;
	Mon, 15 Aug 2022 22:00:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FFA7C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C42140928
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:00:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C42140928
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EHiMupOJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rk0xti7w6Ddl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:00:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F9AC4091F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F9AC4091F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660600838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bnInJhTNmcRkk5WIZQp/adh2w/55qWjBovtngHxo1PM=;
 b=EHiMupOJ2icYjOXVQ8sFxh3ko4sXMrIsr1zUjvxgs2aZ2xlNXKOVwuIbtfqcTrgo9pEjNB
 +9h++a7QLDe7Vq4zfaMRKjME/FqhPMgaBrWboaHEQrVlh2BvP96jVbtn13Za7qCsvvuiNj
 ZADl3pbeZ7R/Ve5a/OJ38NwC46IhjlQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-214-5PL1R_rCMnukbhFZu9e9dA-1; Mon, 15 Aug 2022 18:00:37 -0400
X-MC-Unique: 5PL1R_rCMnukbhFZu9e9dA-1
Received: by mail-wm1-f72.google.com with SMTP id
 203-20020a1c02d4000000b003a5f5bce876so687695wmc.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 15:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=bnInJhTNmcRkk5WIZQp/adh2w/55qWjBovtngHxo1PM=;
 b=1byyHluGxNJ6Zj3LInQRur1vRSyFNQ0GWGE/17KJAG34XTONmMntgyGWm7LkqKTCEm
 fUON84wHb5leweZUMmok9hx4eBez+a8jHjm7SbFre/38P+Z1PXNNmr+YHrPEMVKlQE2q
 3kzJs5CR3+aZNd5yoH0uLY5WjlquoRUDMH4YQNiRJwRbvQYjIqv5u/4JN8wdMPG8pAdl
 TJvveST4UYCaLlb76INsg5TY/OAjiz5pmSobMfmqh99l3/QDkpZxREIAhAjI6d4NGHF0
 O8voYFGLXTVo5qFzYT3omGYC3K3WmS6xroBpVWKqZQZ4Nm3kX/xIDY1D57kSZ35sjqQI
 P17Q==
X-Gm-Message-State: ACgBeo2YaohJaD4sbhEJ0eW6WB9W8kMyv9Fv+RnQlzMlOPpRPmXYSNpo
 GtRtz6Jk1JpcUx6vcooTZ9fal9SUmTZ08l9W77ZLakSzWky0NOH6T6+WS0igTWci0Vtg9Hk4oi/
 IkrXg3aXmkS4F5YW3a4aicP5Z4XC066d6djU/j2pPPA==
X-Received: by 2002:adf:fe0d:0:b0:220:5df9:e5cf with SMTP id
 n13-20020adffe0d000000b002205df9e5cfmr10037602wrr.332.1660600836189; 
 Mon, 15 Aug 2022 15:00:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7neOEEnsfPvVNfIdJ1DGmTNBVQIoh+gohySWeq1ab7WHyHnV34ZmbBICAeo695PHmm06CKHw==
X-Received: by 2002:adf:fe0d:0:b0:220:5df9:e5cf with SMTP id
 n13-20020adffe0d000000b002205df9e5cfmr10037579wrr.332.1660600835925; 
 Mon, 15 Aug 2022 15:00:35 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 r187-20020a1c44c4000000b003a5f2cc2f1dsm6101446wma.42.2022.08.15.15.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 15:00:35 -0700 (PDT)
Date: Mon, 15 Aug 2022 18:00:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] virtio: Revert "virtio: add helper
 virtio_find_vqs_ctx_size()"
Message-ID: <20220815215938.154999-3-mst@redhat.com>
References: <20220815215938.154999-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220815215938.154999-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

This reverts commit fe3dc04e31aa51f91dc7f741a5f76cc4817eb5b4: the
API is now unused and in fact can't be implemented on top of a legacy
device.

Fixes: fe3dc04e31aa ("virtio: add helper virtio_find_vqs_ctx_size()")
Cc: "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 6adff09f7170..888f7e96f0c7 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -241,18 +241,6 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 				      ctx, desc);
 }
 
-static inline
-int virtio_find_vqs_ctx_size(struct virtio_device *vdev, u32 nvqs,
-			     struct virtqueue *vqs[],
-			     vq_callback_t *callbacks[],
-			     const char * const names[],
-			     u32 sizes[],
-			     const bool *ctx, struct irq_affinity *desc)
-{
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, sizes,
-				      ctx, desc);
-}
-
 /**
  * virtio_synchronize_cbs - synchronize with virtqueue callbacks
  * @vdev: the device
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
