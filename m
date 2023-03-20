Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E91C7618A
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 15:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3B9B40904;
	Mon, 20 Mar 2023 15:08:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3B9B40904
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S3/eMPW/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bUk8AQfymmIZ; Mon, 20 Mar 2023 15:08:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 68951403EA;
	Mon, 20 Mar 2023 15:08:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68951403EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51DA0C0035;
	Mon, 20 Mar 2023 15:08:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B990CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 946E061030
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:08:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 946E061030
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=S3/eMPW/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HbQqyAe92qFh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:08:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E35236102E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E35236102E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679324876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VgebBbttaGt4D40EQmQ7/+4mDXUoVf9daeLT8gWgLtM=;
 b=S3/eMPW/UlzHc5S+WhP3Fjnx2JLK1PatRiJyFOhhjH3yaJBgEEJ5M1fcva0glxwx1M91+c
 G1ah5IMrNkb3IHiKyerSw8C1bAPAoLN4N+aqHdp4cld2VzfME2cPjVmyyECImHJNmgu8ZE
 NXNd01jHYdz+QAh3aZUwAoJ1uu4l1Ss=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-CAD-Wsp6Osm2A-BMQ2UmIw-1; Mon, 20 Mar 2023 11:07:23 -0400
X-MC-Unique: CAD-Wsp6Osm2A-BMQ2UmIw-1
Received: by mail-wm1-f70.google.com with SMTP id
 i8-20020a05600c354800b003ed59bae33bso4594248wmq.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 08:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679324839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgebBbttaGt4D40EQmQ7/+4mDXUoVf9daeLT8gWgLtM=;
 b=ixE8NW+5vtCvoEIwkGUkLamiMrRqj7KKCYg2tL7IxnuDSG8Sg5Qqd1PPm22GSY0ZYD
 eVs9WoabA0njGP6l8AeJXlkgvOmsNoGU3I1m6knBmmGtLNf2+9/ixRyiH1Sw1GHtxCHT
 1TMh7fbuWBVfMGPeBtFwpN/HjSrRPpwOBf3b/UDj0/a4x/yG1qSzj5Zv8xoQHmf6hpkh
 Y6hE7ys7nU1z8F8Fa00OBUOYAAJkZ4+E8eJfA6tw9BMKuBjmAgQWAE/cMhXeQoUqX/xv
 QulfGPCdCJ0okcR/nhuHqeTj5J1rH9d1mLza/HnpTyodvDO+xfiUt7db2lFJe69qbRcH
 M5/w==
X-Gm-Message-State: AO0yUKWacYXrpTFEPPWRfBPARd67jv8wDTBGwf/VW+9DuwIkDg9OAe7Y
 zUhpOt9peInb1KR6n6Mx2t5utxFKn82cXkPsfIZ2U0iS0xoCCK0mkYZljrRhaxXyBTac0kbcsP8
 HNPgvDL3bDNWpDjzl+gKozdHgTnA5mvHb1A4ctUC8wQ==
X-Received: by 2002:a5d:574a:0:b0:2d7:a1e2:f5 with SMTP id
 q10-20020a5d574a000000b002d7a1e200f5mr1911372wrw.55.1679324839305; 
 Mon, 20 Mar 2023 08:07:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set/T14nWSia5GZnuqnU654Kdl6pDq7bn2tDAbaRQz0T3coNj3BVGpa9eETzLvxUNUoJckiLdQg==
X-Received: by 2002:a5d:574a:0:b0:2d7:a1e2:f5 with SMTP id
 q10-20020a5d574a000000b002d7a1e200f5mr1911351wrw.55.1679324838997; 
 Mon, 20 Mar 2023 08:07:18 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 k2-20020a5d6e82000000b002c55b0e6ef1sm9243349wrz.4.2023.03.20.08.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Mar 2023 08:07:18 -0700 (PDT)
Date: Mon, 20 Mar 2023 16:07:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 2/3] virtio/vsock: add WARN() for invalid state of
 socket
Message-ID: <20230320150715.twapgesp2gj6egua@sgarzare-redhat>
References: <e141e6f1-00ae-232c-b840-b146bdb10e99@sberdevices.ru>
 <da93402d-920e-c248-a5a1-baf24b70ebee@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <da93402d-920e-c248-a5a1-baf24b70ebee@sberdevices.ru>
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

On Sun, Mar 19, 2023 at 09:52:19PM +0300, Arseniy Krasnov wrote:
>This prints WARN() and returns from stream dequeue callback when socket's
>queue is empty, but 'rx_bytes' still non-zero.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 3c75986e16c2..c35b03adad8d 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -388,6 +388,13 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	u32 free_space;
>
> 	spin_lock_bh(&vvs->rx_lock);
>+
>+	if (skb_queue_empty(&vvs->rx_queue) && vvs->rx_bytes) {
>+		WARN(1, "No skbuffs with non-zero 'rx_bytes'\n");

I would use WARN_ONCE, since we can't recover so we will flood the log.

And you can put the condition in the first argument, I mean something
like this:
         if (WARN_ONCE(skb_queue_empty(&vvs->rx_queue) && vvs->rx_bytes,
                       "rx_queue is empty, but rx_bytes is non-zero\n")) {

Thanks,
Stefano

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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
