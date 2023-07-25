Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FC1C001DE
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 15:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 984424029F;
	Tue, 25 Jul 2023 15:39:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 984424029F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V4gGBYet
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7Rk9ZbRVl9a; Tue, 25 Jul 2023 15:39:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F060402A8;
	Tue, 25 Jul 2023 15:39:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F060402A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E44B1C0071;
	Tue, 25 Jul 2023 15:39:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43B1BC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B2D980E9A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:39:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B2D980E9A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V4gGBYet
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Fzqkq0nhqoo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:39:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C336380D41
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:39:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C336380D41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690299560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bcCFU2Ivogkl7HFNHxFyEJm3ALVxSHEsRN1xT36+tVI=;
 b=V4gGBYetdkq9G5WRd9rX0G/VgkA4zCqlEbga2bN0wGBxKgf/Ec+ehPYlhlPS0qvfXtVGFD
 c+rpNhlnHXD384Rsf+cYKWrpK0bja+fcFKw+D+6q9lJCr1X1uL5txIxzDjaqv2URbcQ5Wd
 8w7TwHDFNz16/WQkeaMVT0hz9G3MSkI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-2jvWZqz0OVSDMmeIi3tuaQ-1; Tue, 25 Jul 2023 11:39:17 -0400
X-MC-Unique: 2jvWZqz0OVSDMmeIi3tuaQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3a5ab2d2b3bso5950432b6e.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 08:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690299556; x=1690904356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcCFU2Ivogkl7HFNHxFyEJm3ALVxSHEsRN1xT36+tVI=;
 b=Db70N6j76kx24gssshUABxzzUoGZxAIb8+YKlczmLVAYG4wpK4k3DdodDvRrLgE0Ye
 ehNNinJlTsmPL3p5bFa3izzAphoOCbclIPKQEOHnh7397Xnd3QbHWGTaQC5/epTkq3Yp
 64aNoqzhFX97diWHsod+lfeTXZmVygPZHHlB6ulDa4FkpzPw67maOJrZtvGkUFROoSM+
 lXmzm/zOaUnd0MFGEgOBj6XjMqBoWCmznmDSaTPcpbMv9v16YZgMJ1MqbybWptcTxZjw
 4bWnVprAqnj1gnXQacgkULH8riBMPaRJJDB4x48x577nn8wBGtdRPy+FyGeZhkMT7KVq
 uzTg==
X-Gm-Message-State: ABy/qLbm/38m5kMCCBfSvkMH2eqlu/baqHhodXwwdAKjpDHGt07ViA0m
 fs6QboVpCgOiVquaI5X5NTsXFGgsd769dW319ZWx3fvgXoPH43IkY/fiIoTqLGBm50f+GloV3++
 BW/1BBIG58KwBKc4Aqsup8eRuhixU1msF2ZR0qx2VlA==
X-Received: by 2002:aca:903:0:b0:3a4:2983:fae4 with SMTP id
 3-20020aca0903000000b003a42983fae4mr13668673oij.16.1690299556759; 
 Tue, 25 Jul 2023 08:39:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0TGaUqzi7xbyp+p32xHTznjTx8QeM+1IFMYrpqrtgsnqXajAIOZAP2vbA9ODUoVXO9/LaIw==
X-Received: by 2002:aca:903:0:b0:3a4:2983:fae4 with SMTP id
 3-20020aca0903000000b003a42983fae4mr13668657oij.16.1690299556430; 
 Tue, 25 Jul 2023 08:39:16 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.153.113])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a0cf249000000b005ef81cc63ccsm4396365qvl.117.2023.07.25.08.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 08:39:15 -0700 (PDT)
Date: Tue, 25 Jul 2023 17:39:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 1/4] virtio/vsock: rework MSG_PEEK for SOCK_STREAM
Message-ID: <p5sh4fskegski2l4d5jkziaun266mjnzfpig6qs5zsxg55rc4t@vfi2icif57pj>
References: <20230719192708.1775162-1-AVKrasnov@sberdevices.ru>
 <20230719192708.1775162-2-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230719192708.1775162-2-AVKrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Jul 19, 2023 at 10:27:05PM +0300, Arseniy Krasnov wrote:
>This reworks current implementation of MSG_PEEK logic:
>1) Replaces 'skb_queue_walk_safe()' with 'skb_queue_walk()'. There is
>   no need in the first one, as there are no removes of skb in loop.
>2) Removes nested while loop - MSG_PEEK logic could be implemented
>   without it: just iterate over skbs without removing it and copy
>   data from each until destination buffer is not full.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Reviewed-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 41 ++++++++++++-------------
> 1 file changed, 19 insertions(+), 22 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b769fc258931..2ee40574c339 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -348,37 +348,34 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 				size_t len)
> {
> 	struct virtio_vsock_sock *vvs = vsk->trans;
>-	size_t bytes, total = 0, off;
>-	struct sk_buff *skb, *tmp;
>-	int err = -EFAULT;
>+	struct sk_buff *skb;
>+	size_t total = 0;
>+	int err;
>
> 	spin_lock_bh(&vvs->rx_lock);
>
>-	skb_queue_walk_safe(&vvs->rx_queue, skb,  tmp) {
>-		off = 0;
>+	skb_queue_walk(&vvs->rx_queue, skb) {
>+		size_t bytes;
>
>-		if (total == len)
>-			break;
>+		bytes = len - total;
>+		if (bytes > skb->len)
>+			bytes = skb->len;
>
>-		while (total < len && off < skb->len) {
>-			bytes = len - total;
>-			if (bytes > skb->len - off)
>-				bytes = skb->len - off;
>+		spin_unlock_bh(&vvs->rx_lock);
>
>-			/* sk_lock is held by caller so no one else can dequeue.
>-			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>-			 */
>-			spin_unlock_bh(&vvs->rx_lock);
>+		/* sk_lock is held by caller so no one else can dequeue.
>+		 * Unlock rx_lock since memcpy_to_msg() may sleep.
>+		 */
>+		err = memcpy_to_msg(msg, skb->data, bytes);
>+		if (err)
>+			goto out;
>
>-			err = memcpy_to_msg(msg, skb->data + off, bytes);
>-			if (err)
>-				goto out;
>+		total += bytes;
>
>-			spin_lock_bh(&vvs->rx_lock);
>+		spin_lock_bh(&vvs->rx_lock);
>
>-			total += bytes;
>-			off += bytes;
>-		}
>+		if (total == len)
>+			break;
> 	}
>
> 	spin_unlock_bh(&vvs->rx_lock);
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
