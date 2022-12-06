Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73590C352A1
	for <virtualization@archiver.kernel.org>; Tue,  6 Dec 2022 10:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9F2C81E12;
	Tue,  6 Dec 2022 10:20:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9F2C81E12
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KJwp2tS7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cvVgf8SlhhbP; Tue,  6 Dec 2022 10:20:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 64C3981443;
	Tue,  6 Dec 2022 10:20:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64C3981443
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CB13C0033;
	Tue,  6 Dec 2022 10:20:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CB24C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 10:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47BC981E0F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 10:20:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47BC981E0F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RlIpnwqQcWp2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 10:20:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D425E81443
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D425E81443
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670322028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHrzc7nXr4YvCNaFmiJ1lG1BHgrUaPmAIMwaF5/OBO4=;
 b=KJwp2tS7QXn015PwBDP7+jXgN8Z2Zjce2Wq7Ij5FNUd2v87d8otQbYEZeuBN2uLDSI/syD
 O9E4pYdkLeTUcwDZ84yxsRZaTj6oCCtU8IsafDzMBcD58Y++kHoDG0E1INl1N3uFFMy64H
 J04JXsxp+xBL4KsWlFhmU9gjmT9YWus=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-471-dJSLoBerPCaoViEgsMqqIw-1; Tue, 06 Dec 2022 05:20:27 -0500
X-MC-Unique: dJSLoBerPCaoViEgsMqqIw-1
Received: by mail-qk1-f198.google.com with SMTP id
 x2-20020a05620a448200b006fa7dad5c1cso20322908qkp.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Dec 2022 02:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jHrzc7nXr4YvCNaFmiJ1lG1BHgrUaPmAIMwaF5/OBO4=;
 b=gjvxnkq72Ly6svmSdiI7vU74K4pHvO3p4RHvvDGaSQNsx/mXeMvBDkbM30vzXCHMHK
 4xBf9SRXSAVnEF4K2fqBKJZw5NUsn+gpBiZRrIcvZnf+QsQ12F5C0pnVrOilWdT6lkpS
 HvXZlPl5TbxxVmj4uwfN/kkl/L/AbBBXuMsDRqmEHQR3UcDSU2bdAsO/6RDaAXVl6F7P
 oJmUuAXe6ZnyfKFhViVPB/crJ/+glq9RLxhp7P9kxwubwOeLQKK9vwBTvH5H3hfhYm3/
 85yip8OY+uiFr6a4XoBBZBLJHeAkLUn6mmVLD/6mu4j4b7R5yH6gkiylsk0IECliI4xO
 okIg==
X-Gm-Message-State: ANoB5pm4ZluizP2UdQsvKtoU8lUXdln9jqrv77CRhzqafztkKoUvbv2J
 zLS3ki1xGzCashE9g4/SDYokOyAY+7orEQ85zucCCqJY0+mx9TDUpoYhqimXNVE26WuDnWmY/wS
 YLto/jXFjv2mKcZEdJtqzvL4euKPxAmZozz+/kGuQ6w==
X-Received: by 2002:a05:622a:4017:b0:3a5:4f7e:bab2 with SMTP id
 cf23-20020a05622a401700b003a54f7ebab2mr64363595qtb.527.1670322026694; 
 Tue, 06 Dec 2022 02:20:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5qvnmSSJhD7XhInjAoVoAZX/6OMJ6iTD3rm9lH6Om7UxRSOVZ1bSbEKEISqvQ5FcAl/6HHWQ==
X-Received: by 2002:a05:622a:4017:b0:3a5:4f7e:bab2 with SMTP id
 cf23-20020a05622a401700b003a54f7ebab2mr64363575qtb.527.1670322026401; 
 Tue, 06 Dec 2022 02:20:26 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-106-100.dyn.eolo.it.
 [146.241.106.100]) by smtp.gmail.com with ESMTPSA id
 bi6-20020a05620a318600b006fa16fe93bbsm14341627qkb.15.2022.12.06.02.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Dec 2022 02:20:26 -0800 (PST)
Message-ID: <863a58452b4a4c0d63a41b0f78b59d32919067fa.camel@redhat.com>
Subject: Re: [PATCH v5] virtio/vsock: replace virtio_vsock_pkt with sk_buff
From: Paolo Abeni <pabeni@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Tue, 06 Dec 2022 11:20:21 +0100
In-Reply-To: <20221202173520.10428-1-bobby.eshleman@bytedance.com>
References: <20221202173520.10428-1-bobby.eshleman@bytedance.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, Krasnov Arseniy <oxffffaa@gmail.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

Hello,

On Fri, 2022-12-02 at 09:35 -0800, Bobby Eshleman wrote:
[...]
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index 35d7eedb5e8e..6c0b2d4da3fe 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -3,10 +3,129 @@
>  #define _LINUX_VIRTIO_VSOCK_H
>  
>  #include <uapi/linux/virtio_vsock.h>
> +#include <linux/bits.h>
>  #include <linux/socket.h>
>  #include <net/sock.h>
>  #include <net/af_vsock.h>
>  
> +#define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
> +
> +enum virtio_vsock_skb_flags {
> +	VIRTIO_VSOCK_SKB_FLAGS_REPLY		= BIT(0),
> +	VIRTIO_VSOCK_SKB_FLAGS_TAP_DELIVERED	= BIT(1),
> +};
> +
> +static inline struct virtio_vsock_hdr *virtio_vsock_hdr(struct sk_buff *skb)
> +{
> +	return (struct virtio_vsock_hdr *)skb->head;
> +}
> +
> +static inline bool virtio_vsock_skb_reply(struct sk_buff *skb)
> +{
> +	return skb->_skb_refdst & VIRTIO_VSOCK_SKB_FLAGS_REPLY;
> +}

I'm sorry for the late feedback. The above is extremelly risky: if the
skb will land later into the networking stack, we could experience the
most difficult to track bugs.

You should use the skb control buffer instead (skb->cb), with the
additional benefit you could use e.g. bool - the compiler could emit
better code to manipulate such fields - and you will not need to clear
the field before release nor enqueue.

[...]

> @@ -352,37 +360,38 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  				   size_t len)
>  {
>  	struct virtio_vsock_sock *vvs = vsk->trans;
> -	struct virtio_vsock_pkt *pkt;
>  	size_t bytes, total = 0;
> -	u32 free_space;
> +	struct sk_buff *skb;
>  	int err = -EFAULT;
> +	u32 free_space;
>  
>  	spin_lock_bh(&vvs->rx_lock);
> -	while (total < len && !list_empty(&vvs->rx_queue)) {
> -		pkt = list_first_entry(&vvs->rx_queue,
> -				       struct virtio_vsock_pkt, list);
> +	while (total < len && !skb_queue_empty_lockless(&vvs->rx_queue)) {
> +		skb = __skb_dequeue(&vvs->rx_queue);

Here the locking schema is confusing. It looks like vvs->rx_queue is
under vvs->rx_lock protection, so the above should be skb_queue_empty()
instead of the lockless variant.

[...]

> @@ -858,16 +873,11 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>  static void virtio_transport_remove_sock(struct vsock_sock *vsk)
>  {
>  	struct virtio_vsock_sock *vvs = vsk->trans;
> -	struct virtio_vsock_pkt *pkt, *tmp;
>  
>  	/* We don't need to take rx_lock, as the socket is closing and we are
>  	 * removing it.
>  	 */
> -	list_for_each_entry_safe(pkt, tmp, &vvs->rx_queue, list) {
> -		list_del(&pkt->list);
> -		virtio_transport_free_pkt(pkt);
> -	}
> -
> +	virtio_vsock_skb_queue_purge(&vvs->rx_queue);

Still assuming rx_queue is under the rx_lock, given you don't need the
locking here as per the above comment, you should use the lockless
purge variant.

Thanks!

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
