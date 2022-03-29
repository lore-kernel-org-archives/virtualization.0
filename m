Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1403C433F5
	for <virtualization@archiver.kernel.org>; Tue, 29 Mar 2022 07:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92C3F60C05;
	Tue, 29 Mar 2022 07:49:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UiPWp_8kpyFh; Tue, 29 Mar 2022 07:49:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0FB0860C04;
	Tue, 29 Mar 2022 07:49:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4EF4C001D;
	Tue, 29 Mar 2022 07:49:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E17B9C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 07:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6DD441729
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 07:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qoNispofvQcD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 07:49:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6612A4171A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 07:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648540180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lsR/34KqJqbBBpHRK+08f40lqnu5rbIFXnCvn3suC+k=;
 b=Abao1opdVqJg4JqGvAlpWFRhSoCnNtvBaICR7JL9MLWXeckXhbz/OBhEOUZZ/CFTs6vd2i
 tIcP2EJbfJhvVgkhf0I1Gqa02AviEGx0NVKdMDGKlzT0Z3h6cqm/U1nHx+0zzDkolXEUPV
 UwzapTbWfuRkih5A65BSwGIRxSwF/GA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-l9n34Uv2PNiux0n5zgbsew-1; Tue, 29 Mar 2022 03:49:38 -0400
X-MC-Unique: l9n34Uv2PNiux0n5zgbsew-1
Received: by mail-qv1-f71.google.com with SMTP id
 z1-20020ad44781000000b00440ded04b09so13110894qvy.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 00:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lsR/34KqJqbBBpHRK+08f40lqnu5rbIFXnCvn3suC+k=;
 b=6+k3HzWYmtaU7uYxOK56iFYxfGDeoB7nIem7pNIncmDuGkY8vZ42JW1lGxNvlopOzy
 bd62DCbN9BFoaak7/b44SrqxCI9Q1/O0ChrOO+JvB1Gyh9KgWw3dAmTSt89k/X4HZ1Iq
 3ttBDo/SlNzPd+k7c4Ah7/T949ykjtelPzOGELE2zkPFQD5QBhDfPW6rRh8YBeR9tKTt
 Xjsd9W1XgeUEQFBHu7Hruhngk6QwuX3h93Vtwu55UtpJYNWf0rZEpCkthgQvWjnagUcJ
 /apEKjzTtzQtKWMK6MBpUNW+C1LVL2q0+xKrXM67vl0SE8776dhnlwatSsJEO2qyYFBN
 A4jg==
X-Gm-Message-State: AOAM533s+3jAEJI/FzHb8mdignLMMFqMyTtj4OQYu+RFKChYVirkOztY
 UQqa8cA+Cq6VPBz/tsRrE1b/L8wFqOqX2tXszT0ZTiy8eaYUdTcpVah+/L3KoqTJqu9jtQYjdrt
 d99+n1p3xtjibJF+1UnTiUv9ctayzORfziv3O/uW7WA==
X-Received: by 2002:ac8:5743:0:b0:2e1:cee6:f15 with SMTP id
 3-20020ac85743000000b002e1cee60f15mr26099600qtx.634.1648540178444; 
 Tue, 29 Mar 2022 00:49:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF88WnyEL92F591a91CJkQdQTk0tHBD5HJOhEHqqmJn3s+62AbX5AdLhjztsk5SSSRj9HebA==
X-Received: by 2002:ac8:5743:0:b0:2e1:cee6:f15 with SMTP id
 3-20020ac85743000000b002e1cee60f15mr26099593qtx.634.1648540178179; 
 Tue, 29 Mar 2022 00:49:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-67.retail.telecomitalia.it.
 [79.46.200.67]) by smtp.gmail.com with ESMTPSA id
 bs32-20020a05620a472000b0067d4560a516sm9478080qkb.32.2022.03.29.00.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Mar 2022 00:49:37 -0700 (PDT)
Date: Tue, 29 Mar 2022 09:49:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_ring: remove unnecessary to_vvq call in vring
 hot path
Message-ID: <20220329074932.5wtyi7fd7ud5dedd@sgarzare-redhat>
References: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Mar 28, 2022 at 06:58:16PM +0800, Xianting Tian wrote:
>It passes '_vq' to virtqueue_use_indirect(), which still calls
>to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
>unnecessary call of to_vvq in hot path.
>
>Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>---
> drivers/virtio/virtio_ring.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>index 962f1477b1fa..d597fc0874ec 100644
>--- a/drivers/virtio/virtio_ring.c
>+++ b/drivers/virtio/virtio_ring.c
>@@ -205,11 +205,9 @@ struct vring_virtqueue {
>
> #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>
>-static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
>+static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
> 					  unsigned int total_sg)
> {
>-	struct vring_virtqueue *vq = to_vvq(_vq);
>-
> 	/*
> 	 * If the host supports indirect descriptor tables, and we have multiple
> 	 * buffers, then go indirect. FIXME: tune this threshold
>@@ -507,7 +505,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>
> 	head = vq->free_head;
>
>-	if (virtqueue_use_indirect(_vq, total_sg))
>+	if (virtqueue_use_indirect(vq, total_sg))
> 		desc = alloc_indirect_split(_vq, total_sg, gfp);
> 	else {
> 		desc = NULL;
>@@ -1194,7 +1192,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>
> 	BUG_ON(total_sg == 0);
>
>-	if (virtqueue_use_indirect(_vq, total_sg)) {
>+	if (virtqueue_use_indirect(vq, total_sg)) {
> 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> 						    in_sgs, data, gfp);
> 		if (err != -ENOMEM) {
>-- 
>2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
