Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2272C76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 09:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DB5182269;
	Tue, 28 Mar 2023 09:29:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8DB5182269
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dp24mF+i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DZc7bHTGcQHe; Tue, 28 Mar 2023 09:29:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 352A181F50;
	Tue, 28 Mar 2023 09:29:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 352A181F50
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D3F5C0037;
	Tue, 28 Mar 2023 09:29:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E5BDC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1AB2A6122E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AB2A6122E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dp24mF+i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oSTQPBW5Bw4K
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 603E66125D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 603E66125D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679995760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2MTYkIHhyDg1tSTjOD+oc1eBs9Ie8OrzP6nP660U11M=;
 b=dp24mF+ig1sMH5ui4tiI3pdqH+HGJJfMsYMJby/ngvS9oq7Tz/KLIeNuHWu6atUeve8xRC
 oPg2h+gXmm2M+ZAs/yGn2ZV6uMITmUm04h49Kx/CKrHs7kQh99NkUuwC0Zg9c+gvXOfsgr
 9Zyz8jVM5pBYzfY+rQL37SF4x6k2u1k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-uMWT94QQNYakakAM7cussg-1; Tue, 28 Mar 2023 05:29:19 -0400
X-MC-Unique: uMWT94QQNYakakAM7cussg-1
Received: by mail-qt1-f199.google.com with SMTP id
 m7-20020a05622a118700b003e4e203bc30so5338083qtk.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679995758;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MTYkIHhyDg1tSTjOD+oc1eBs9Ie8OrzP6nP660U11M=;
 b=N+KcSZKOyx49SzDkeQcPzoU7/UuQ3fOYMVmr3SURHamEoOTeyOSLSP4F6AHf1eM5OK
 rfN8jekzJm9S8HWtnDWG9YgQ5JN4wqp66T30ygqPCLbC5qtIlFkvydWEE3aHEHFxgt9u
 B/xFHrxddghgt8HIJMtqMLFgRs1Hi0JnkAR55VYLHFgUAnRXN7HqNnGeuEI9/Pg7N7HJ
 cl+UkvdjAr6p6xa3sDZDwCBLyRGnmLqFkCPmsDNRfK9LdKGdDSKcP1PkylfILla1mVUq
 YGf7HpF3PeP69ATvcqX1qGDvm4R/JyNia2ysq433t5luhNOyUUsWw7vM9WfArlaIFnT5
 ZXMQ==
X-Gm-Message-State: AAQBX9eJQJaN+05TyNnT6c34MmgGOPnBmUmmxVr1rZ25LwseGpQaiPuv
 UcLWIjxVtwsclXC8FZrOX+QLhglVMP7hSA7o+5hHYCngOO1Exown75fo5mazSuX0pQgLD1fgZbS
 bdUeVgoUw9e5Ykj7856uy3+UpU09zDl1L+RWPWXTbpA==
X-Received: by 2002:a05:6214:260f:b0:56b:fb58:c350 with SMTP id
 gu15-20020a056214260f00b0056bfb58c350mr23964666qvb.26.1679995758198; 
 Tue, 28 Mar 2023 02:29:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350YbQdtTvthYdS2lSVNkd7CIQnOjtbLTtQpWx6BoakwOHWkvtaIfcNuo2kDx2/O8wrbZT546kA==
X-Received: by 2002:a05:6214:260f:b0:56b:fb58:c350 with SMTP id
 gu15-20020a056214260f00b0056bfb58c350mr23964649qvb.26.1679995757971; 
 Tue, 28 Mar 2023 02:29:17 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 z9-20020a376509000000b0074283b87a4esm10340876qkb.90.2023.03.28.02.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 02:29:17 -0700 (PDT)
Date: Tue, 28 Mar 2023 11:29:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 2/3] virtio/vsock: WARN_ONCE() for invalid state
 of socket
Message-ID: <lgpswwclsuiukh2q5couf33jytf6abneazmwkty6fevoxcgh5p@3dzfbmenjhco>
References: <728181e9-6b35-0092-3d01-3d7aff4521b6@sberdevices.ru>
 <30aa2604-77c0-322e-44fd-ff99fc25e388@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <30aa2604-77c0-322e-44fd-ff99fc25e388@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Sun, Mar 26, 2023 at 01:09:25AM +0300, Arseniy Krasnov wrote:
>This adds WARN_ONCE() and return from stream dequeue callback when
>socket's queue is empty, but 'rx_bytes' still non-zero.

Nit: I would explain why we add this, for example:

This allows the detection of potential bugs due to packet merging
(see previous patch).

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 7 +++++++
> 1 file changed, 7 insertions(+)

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b9144af71553..ad70531de133 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -398,6 +398,13 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	u32 free_space;
>
> 	spin_lock_bh(&vvs->rx_lock);
>+
>+	if (WARN_ONCE(skb_queue_empty(&vvs->rx_queue) && vvs->rx_bytes,
>+		      "No skbuffs with non-zero 'rx_bytes'\n")) {

Nit: I would rephrase it this way:
"rx_queue is empty, but rx_bytes is non-zero"

>+		spin_unlock_bh(&vvs->rx_lock);
>+		return err;
>+	}
>+
> 	while (total < len && !skb_queue_empty(&vvs->rx_queue)) {
> 		skb = skb_peek(&vvs->rx_queue);
>
>-- 
>2.25.1
>

Anyway the patch LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
