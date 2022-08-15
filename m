Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF33C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4452403ED;
	Mon, 15 Aug 2022 21:54:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4452403ED
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NGpLmSbR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PSprBQMSghuW; Mon, 15 Aug 2022 21:54:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C2E9408BD;
	Mon, 15 Aug 2022 21:54:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C2E9408BD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2842C002D;
	Mon, 15 Aug 2022 21:54:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 853D3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 630DC403FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:54:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 630DC403FF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NGpLmSbR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UfYOskCxqY_f
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:54:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9CBC6403E5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CBC6403E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660600439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bnInJhTNmcRkk5WIZQp/adh2w/55qWjBovtngHxo1PM=;
 b=NGpLmSbRi18KNpyxpmPcyFRF5dIAl0h7RdZnmyFBegf9yCyAdqsIAP2BSrvsYjAYkbCzKK
 vizdjwbfZ9edzW1kTfEdysyzARqmOa33Feg2WE3hDYtBt5RYyclKYF9D++KXjRtRtimAQI
 ia67PLMtYP7rLskkFnhEiundvJ3JiRc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-93-Wn1U8_OYNCGtoHN1LYWreA-1; Mon, 15 Aug 2022 17:53:43 -0400
X-MC-Unique: Wn1U8_OYNCGtoHN1LYWreA-1
Received: by mail-wm1-f70.google.com with SMTP id
 b16-20020a05600c4e1000b003a5a47762c3so4046421wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 14:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=bnInJhTNmcRkk5WIZQp/adh2w/55qWjBovtngHxo1PM=;
 b=UUiDiFcgS8JciIpWytPbYBKDZypvtrLiRDbgteYrA2BfbIQelylVNs94EJzF22yShR
 z33CR7eDXvpy7SzS+m3V8l91nFNh5Z14M9fLTAK3JPqTmraB4aYg99zAn9a2ftpTWbvx
 6PF3C69jpTD9CbwkIaUDr+4ztc+fFfxqOR3sEckrlqfkU4EiDW6kufY10IKGqzoWAOZh
 1eh1esnbThv1tSSmpy1cVLK7B+GmbOoczJcQOzD8lYM3YsJ8ghsQfCqzi1nkMeVRSyZt
 NYVU0gxfO3Bqk+hi8lGFTBkoXXRUgTu3keselvuyIxhFH7f36gc2WjtpSAGHkfbGDU0M
 6d2Q==
X-Gm-Message-State: ACgBeo0UUKsK3z1qKA3sb+AjFazWhKH7jNVvnA/glfd/B79ORWKjFc4n
 DqWXCB7MAdMfaTg3msGatZJQ4VMoMK8IRgagmr4N2jrjTONGJcMcMF1o79AB08oyRaRcomwbSg9
 1MfEDpQxuIP9M4I6MkzMHTJbm3am61DfJaM6FPSBpyw==
X-Received: by 2002:adf:eb8e:0:b0:223:a1f6:26b2 with SMTP id
 t14-20020adfeb8e000000b00223a1f626b2mr9621597wrn.216.1660600422332; 
 Mon, 15 Aug 2022 14:53:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4jlIHrGyk0NQDFhbHw+XilfZD0zV7zttfZd98h/WsQfsn3+HtdmVcfipmuVvb8Tr8KPbBRvA==
X-Received: by 2002:adf:eb8e:0:b0:223:a1f6:26b2 with SMTP id
 t14-20020adfeb8e000000b00223a1f626b2mr9621582wrn.216.1660600422078; 
 Mon, 15 Aug 2022 14:53:42 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 b3-20020a05600010c300b002217339ce90sm8455090wrx.8.2022.08.15.14.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 14:53:41 -0700 (PDT)
Date: Mon, 15 Aug 2022 17:53:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] virtio: Revert "virtio: add helper
 virtio_find_vqs_ctx_size()"
Message-ID: <20220815215251.154451-5-mst@redhat.com>
References: <20220815215251.154451-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220815215251.154451-1-mst@redhat.com>
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
