Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853E4C25B0E
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12364404E9;
	Mon, 15 Aug 2022 21:53:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12364404E9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EIO8t93P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WzKQ05hrLh6r; Mon, 15 Aug 2022 21:53:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 52A6C40359;
	Mon, 15 Aug 2022 21:53:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52A6C40359
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B095C0033;
	Mon, 15 Aug 2022 21:53:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B4FCC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2601B817B5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:53:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2601B817B5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EIO8t93P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pKFlWva-ISlO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:53:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 758E2814A9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 758E2814A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660600429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Woc1p74LnDMz9TXkvyQIlZ2BlUNGXfNgs76Y3D9lgg=;
 b=EIO8t93P3kfXNAsBT/04iFY8+UDi+h+6Ja1sB+Codqfa5HvX60m5BJW3l34R0YGtIlKVfo
 44LMM2lM2id6AiARmVEC3OasTe27qqsrgbCNthiCQDJRhv6zJbP+ktaWxKBaQkphe6vzex
 OsckFOLEsycEeA64aaZafE+LqOVi64w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-_cXPTyshN6ueq7NdgP2M-w-1; Mon, 15 Aug 2022 17:53:48 -0400
X-MC-Unique: _cXPTyshN6ueq7NdgP2M-w-1
Received: by mail-wm1-f70.google.com with SMTP id
 c17-20020a7bc011000000b003a2bfaf8d3dso4076904wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 14:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=0Woc1p74LnDMz9TXkvyQIlZ2BlUNGXfNgs76Y3D9lgg=;
 b=RJ+FhD9IpK4jy5sHjSwllCafAuMoUd2RqypVDjpZ9KO6zTuWu3MFcJtQrUxr0wWKnQ
 ZGNWDPqj5TmCUtUzZC0JXgrqU/N0BRYHQekVTxLlYSRanAO/HZKx0wwtTQQlEMHSGsOI
 c/OXOgSWsEC2eXil+Tlq1zJuSSW4q5MyGBu0PgTE5hnQfrE2NuKVH70eoMcP6C+7gTx/
 UJ11eeeUTcWic6spduk1KjH9pZMZcTgmdRUCbPqAtDLLix7wXlcAjDl3S9giiZcSVA+n
 NlE4b+Q7mujaGlIbIIwxtpvZgPwuiQ+2hxXiOznVbAE3Wiy+/CjIWqhA0F707iSXepoT
 5XfA==
X-Gm-Message-State: ACgBeo2gvKIal1dNHHZK1g4OmkUpwQthmcP5kmtioAAQ4lfNNJ+02/oO
 UhOps9S8PwUfs3nA4Hc/wMpapKXOMX7+jnJG9HKiJX2gNH09Xa4YYRoUs8aU3auxds1hBBy6kE0
 DP8pzWOJcVzG3mvsrIMj4Y7zcaKdBBtdufEmDxcEcIg==
X-Received: by 2002:a05:600c:ad4:b0:3a5:50b2:f991 with SMTP id
 c20-20020a05600c0ad400b003a550b2f991mr16731033wmr.146.1660600426184; 
 Mon, 15 Aug 2022 14:53:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7WhVEK8u+bWBQ+vsIP1p2ogF6bjbQsW8dmESOECqvboXglS7PHGAZ3CszZnuGHypllX9oYGw==
X-Received: by 2002:a05:600c:ad4:b0:3a5:50b2:f991 with SMTP id
 c20-20020a05600c0ad400b003a550b2f991mr16731025wmr.146.1660600425942; 
 Mon, 15 Aug 2022 14:53:45 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 n32-20020a05600c502000b003a2d47d3051sm13154371wmr.41.2022.08.15.14.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 14:53:45 -0700 (PDT)
Date: Mon, 15 Aug 2022 17:53:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] virtio-mmio: Revert "virtio_mmio: support the arg
 sizes of find_vqs()"
Message-ID: <20220815215251.154451-6-mst@redhat.com>
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

This reverts commit fbed86abba6e0472d98079790e58060e4332608a.
The API is now unused, let's not carry dead code around.

Fixes: fbed86abba6e ("virtio_mmio: support the arg sizes of find_vqs()")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_mmio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index c492a57531c6..dfcecfd7aba1 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -360,7 +360,7 @@ static void vm_synchronize_cbs(struct virtio_device *vdev)
 
 static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int index,
 				  void (*callback)(struct virtqueue *vq),
-				  const char *name, u32 size, bool ctx)
+				  const char *name, bool ctx)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct virtio_mmio_vq_info *info;
@@ -395,11 +395,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 		goto error_new_virtqueue;
 	}
 
-	if (!size || size > num)
-		size = num;
-
 	/* Create the vring */
-	vq = vring_create_virtqueue(index, size, VIRTIO_MMIO_VRING_ALIGN, vdev,
+	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
 				 true, true, ctx, vm_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
@@ -503,7 +500,6 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		}
 
 		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
-				     sizes ? sizes[i] : 0,
 				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
 			vm_del_vqs(vdev);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
