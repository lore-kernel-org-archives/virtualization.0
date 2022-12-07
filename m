Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FC0C352A1
	for <virtualization@archiver.kernel.org>; Wed,  7 Dec 2022 09:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF7D981EC2;
	Wed,  7 Dec 2022 09:33:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF7D981EC2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K6ZptLTP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ado6gONdZCaV; Wed,  7 Dec 2022 09:33:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5860F81E0F;
	Wed,  7 Dec 2022 09:33:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5860F81E0F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39FFBC0033;
	Wed,  7 Dec 2022 09:33:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AD95C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 09:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6477405F4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 09:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6477405F4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K6ZptLTP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PZMcMlyRoP6x
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 09:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05D37400CE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05D37400CE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670405607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNEaWgUnEyEq3pixNIdJuD3ogN+VEJSCbXOc5Itmm6k=;
 b=K6ZptLTPAs+MVpasfTmJKjdK8pSOGrPwysZY9toHaVICoEL8aTwN6o+jjKSRaYAAJcuavy
 ds6NZe3o6Z32pqquJBnGmJs/oEydK0wcN3WehKFIUoUg1uO6US0fhcL4Ijso7qmhqQiKF6
 pqA3HXb0Y3giBvrojU6G/GiteGs8Ymw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-j6W4ous9OFKoIs4TT98oIQ-1; Wed, 07 Dec 2022 04:33:26 -0500
X-MC-Unique: j6W4ous9OFKoIs4TT98oIQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 r67-20020a1c4446000000b003d09b0fbf54so545673wma.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Dec 2022 01:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DNEaWgUnEyEq3pixNIdJuD3ogN+VEJSCbXOc5Itmm6k=;
 b=i27dDEbThKijZndBGzMCKJjIydaHYMWE/qtEv9a45ni3BUKpsx24xMlxwxso8GwyrN
 sRxeJ3Ua8YuUhJJSetsElHAVuSAxzwRCs6KgvnzKr5f8F5SorNlxZv97B6NLUAb0ecOC
 WpuAiAuYdbU14Csa97/s4jRituudqs+vNFqhksRwSeNo3yJolB4EPkf48S9BoLYfyhGl
 COp1Q0ET1KxQLEU18zGrkov0LVKmVaEsbMNnsMHT4adNdfB9CxVQrzKp/9LPbO+6Repx
 cXt+S158rBvWRmpC/YIEqQbUJMA94m/kQEOaSnGXnhS/WjwtJ8RUOInWsiyNZGe+1UX9
 X7iQ==
X-Gm-Message-State: ANoB5pkW9UKLoqjOiQTMWjvmf9Iypox/kH5bKo8rGCPHO7W933jCdFQf
 hCexKN9/llYA/Lo2HJCBzBAZUci43pK2mkU+eqNNLA0hN4Rxqd+tS/dk57/+URfNUAQrRvCUzil
 idSo3c9YTJHxcPj6qbFb6Zi/bRVCsZc8gzeI8lvxYow==
X-Received: by 2002:adf:f40d:0:b0:242:2bd5:b1ce with SMTP id
 g13-20020adff40d000000b002422bd5b1cemr19518369wro.519.1670405605664; 
 Wed, 07 Dec 2022 01:33:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7hVCwJXn1G2gZ1QbqkOxInRXOmGLIFnBp7xLwd5RYpissGS2YDvXCAQd5bcKlA67ovEbQGQw==
X-Received: by 2002:adf:f40d:0:b0:242:2bd5:b1ce with SMTP id
 g13-20020adff40d000000b002422bd5b1cemr19518344wro.519.1670405605403; 
 Wed, 07 Dec 2022 01:33:25 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-106-100.dyn.eolo.it.
 [146.241.106.100]) by smtp.gmail.com with ESMTPSA id
 n10-20020adffe0a000000b00241bd7a7165sm18392917wrr.82.2022.12.07.01.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Dec 2022 01:33:24 -0800 (PST)
Message-ID: <7cad964394ce47cff28ec7c2f5f1559880e29ae2.camel@redhat.com>
Subject: Re: [PATCH v5] virtio/vsock: replace virtio_vsock_pkt with sk_buff
From: Paolo Abeni <pabeni@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 07 Dec 2022 10:33:22 +0100
In-Reply-To: <Y3toiPtBgOcrb8TL@bullseye>
References: <20221202173520.10428-1-bobby.eshleman@bytedance.com>
 <863a58452b4a4c0d63a41b0f78b59d32919067fa.camel@redhat.com>
 <Y3toiPtBgOcrb8TL@bullseye>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cong Wang <cong.wang@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>
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

On Mon, 2022-11-21 at 12:01 +0000, Bobby Eshleman wrote:
> On Tue, Dec 06, 2022 at 11:20:21AM +0100, Paolo Abeni wrote:
> > Hello,
> > 
> > On Fri, 2022-12-02 at 09:35 -0800, Bobby Eshleman wrote:
> > [...]
> > > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > > index 35d7eedb5e8e..6c0b2d4da3fe 100644
> > > --- a/include/linux/virtio_vsock.h
> > > +++ b/include/linux/virtio_vsock.h
> > > @@ -3,10 +3,129 @@
> > >  #define _LINUX_VIRTIO_VSOCK_H
> > >  
> > >  #include <uapi/linux/virtio_vsock.h>
> > > +#include <linux/bits.h>
> > >  #include <linux/socket.h>
> > >  #include <net/sock.h>
> > >  #include <net/af_vsock.h>
> > >  
> > > +#define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
> > > +
> > > +enum virtio_vsock_skb_flags {
> > > +	VIRTIO_VSOCK_SKB_FLAGS_REPLY		= BIT(0),
> > > +	VIRTIO_VSOCK_SKB_FLAGS_TAP_DELIVERED	= BIT(1),
> > > +};
> > > +
> > > +static inline struct virtio_vsock_hdr *virtio_vsock_hdr(struct sk_buff *skb)
> > > +{
> > > +	return (struct virtio_vsock_hdr *)skb->head;
> > > +}
> > > +
> > > +static inline bool virtio_vsock_skb_reply(struct sk_buff *skb)
> > > +{
> > > +	return skb->_skb_refdst & VIRTIO_VSOCK_SKB_FLAGS_REPLY;
> > > +}
> > 
> > I'm sorry for the late feedback. The above is extremelly risky: if the
> > skb will land later into the networking stack, we could experience the
> > most difficult to track bugs.
> > 
> > You should use the skb control buffer instead (skb->cb), with the
> > additional benefit you could use e.g. bool - the compiler could emit
> > better code to manipulate such fields - and you will not need to clear
> > the field before release nor enqueue.
> > 
> > [...]
> > 
> 
> Hey Paolo, thank you for the review. For my own learning, this would
> happen presumably when the skb is dropped? And I assume we don't see
> this in sockmap because it is always cleared before leaving sockmap's
> hands? I sanity checked this patch with an out-of-tree patch I have that
> uses the networking stack, but I suspect I didn't see issues because my
> test harness didn't induce dropping...

skb->_skb_refdst carries a dst and a flag in the less significative bit
specifying if the dst is refcounted. Passing to the network stack a skb
overloading such bit semanthic is quite alike intentionally corrupting
the kernel memory.

> I originally avoided skb->cb because the reply flag is set at allocation
> and would potentially be clobbered by a pass through the networking
> stack. The reply flag would be used after a pass through the networking
> stack (e.g., during transmission at the device level and when sockets
> close while skbs are still queued for xmit).

I assumed the 'tap_delivered' and 'reply' flag where relevant only
while the skb is owned by the virtio socket. If you need to preserve
such information _after_ delivering the skb to the network stack, that
is quite unfortunate - and skb->cb will not work.

The are a couple of options for adding new metadata inside the skb,
both of them are quite discouraged/need a strong use-case:

- adding new fields in some skb hole
- adding a new skb extension.

Could you please describe the 'reply' and 'tap_delivered' life-cycle
and their interaction with the network stack?


Cheers,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
