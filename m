Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAD9C4332F
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 10:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A7C14038D;
	Wed, 14 Dec 2022 10:58:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A7C14038D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6CDKCDi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jYXOps7Z3epV; Wed, 14 Dec 2022 10:58:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D220B40491;
	Wed, 14 Dec 2022 10:58:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D220B40491
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A37DFC0033;
	Wed, 14 Dec 2022 10:58:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9788CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 10:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C56760B0B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 10:58:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C56760B0B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T6CDKCDi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VQAorDGiZJDU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 10:58:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57C2260B00
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57C2260B00
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671015532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsm8rypiWXXlAJ/OnIAvVOQDlYOOMt1+SaQ7hOIMf78=;
 b=T6CDKCDihF+0BOz/Fb8yhLYxRctXcgmKlxfotPR6NdPFrwq97drZnM5v/rPOEl4cyi+Sld
 ZIy8QF3Gf6MmtN08vjyCC1Lz2tScKY5/4paDrv9Vx01pLksy9/KaedqbU5WD0VcBAhNvBc
 V0gw1mmL4lIITBIilRRHPeuJFdXw+/k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-aKocp3rSPg6jsYS6AYKVVA-1; Wed, 14 Dec 2022 05:58:50 -0500
X-MC-Unique: aKocp3rSPg6jsYS6AYKVVA-1
Received: by mail-wm1-f71.google.com with SMTP id
 o5-20020a05600c510500b003cfca1a327fso6251110wms.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 02:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bsm8rypiWXXlAJ/OnIAvVOQDlYOOMt1+SaQ7hOIMf78=;
 b=RohWkVJAxgednvtfbiktjhx5C3J4XnBW8FPTbkaYOGUiFSmZgbEkbK71pFWCYJ7xzl
 T/ooVKyIFuASDvL5FIJvKW4D8oiTM3DerCHdinATjTBh3sZDmSV/kiPaVPsYBPV0QPIW
 rIb5RSULojuQO9T+fcKpO9Dsp4g4n2zwltHS5nLmi0blZaX52KH2XGoVLWSa/qyGDXLr
 D6hppbiCbCiQ1XBx9tLcLb6UiiQtBvWIEfFIrbXSLSrxfnlfmqMcwi+mK9MC+rbut2XJ
 FSS3Tdxj4PP14JWTD8DUT+EsAR0nGArf7GLf6DYaZbcrDo8cfxwbYZ4bOm15LPqZGe52
 SVzQ==
X-Gm-Message-State: ANoB5pn2+7RbFbvD5t0UndO+fz1qaxQAF1/xJ14SEw0opuVMJx1Jk0YE
 2t5Oz8qkJG+rRUl0o+2jH0sce96hw5d5H/WXks3uXtynZg2Zm0z3v09texhiHHf864gpy6samff
 zkpclDXHuZWymGH0ebLC5uu98e8Crc2SlhZk+lccKVw==
X-Received: by 2002:a05:600c:1c9e:b0:3d2:7a7:5cc6 with SMTP id
 k30-20020a05600c1c9e00b003d207a75cc6mr16127431wms.18.1671015529755; 
 Wed, 14 Dec 2022 02:58:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4GhTuy3yFMob3cVWbwQSim+kT62Pp9g1pSNQfJtskVOvtO6CT9jLknO7unhHjf9Ss6p0OSBw==
X-Received: by 2002:a05:600c:1c9e:b0:3d2:7a7:5cc6 with SMTP id
 k30-20020a05600c1c9e00b003d207a75cc6mr16127414wms.18.1671015529490; 
 Wed, 14 Dec 2022 02:58:49 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-87.dyn.eolo.it. [146.241.97.87])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c3b1100b003c6b7f5567csm7893601wms.0.2022.12.14.02.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 02:58:49 -0800 (PST)
Message-ID: <4b66f91f23a3eb91c3232bc68f45bdb799217c40.camel@redhat.com>
Subject: Re: [PATCH net-next v7] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
From: Paolo Abeni <pabeni@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Wed, 14 Dec 2022 11:58:47 +0100
In-Reply-To: <20221213192843.421032-1-bobby.eshleman@bytedance.com>
References: <20221213192843.421032-1-bobby.eshleman@bytedance.com>
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

On Tue, 2022-12-13 at 19:28 +0000, Bobby Eshleman wrote:
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 5703775af129..2a5994b029b2 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -51,8 +51,7 @@ struct vhost_vsock {
>  	struct hlist_node hash;
>  
>  	struct vhost_work send_pkt_work;
> -	spinlock_t send_pkt_list_lock;
> -	struct list_head send_pkt_list;	/* host->guest pending packets */
> +	struct sk_buff_head send_pkt_queue; /* host->guest pending packets */
>  
>  	atomic_t queued_replies;
>  
> @@ -108,40 +107,33 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  	vhost_disable_notify(&vsock->dev, vq);
>  
>  	do {
> -		struct virtio_vsock_pkt *pkt;
> +		struct virtio_vsock_hdr *hdr;
> +		size_t iov_len, payload_len;
>  		struct iov_iter iov_iter;
> +		u32 flags_to_restore = 0;
> +		struct sk_buff *skb;
>  		unsigned out, in;
>  		size_t nbytes;
> -		size_t iov_len, payload_len;
>  		int head;
> -		u32 flags_to_restore = 0;
>  
> -		spin_lock_bh(&vsock->send_pkt_list_lock);
> -		if (list_empty(&vsock->send_pkt_list)) {
> -			spin_unlock_bh(&vsock->send_pkt_list_lock);
> +		spin_lock(&vsock->send_pkt_queue.lock);
> +		skb = __skb_dequeue(&vsock->send_pkt_queue);
> +		spin_unlock(&vsock->send_pkt_queue.lock);

Here you use a plain spin_lock(), but every other lock has the _bh()
variant. A few lines above this functions acquires a mutex, so this is
process context (and not BH context): I guess you should use _bh()
here, too.

[...]

> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index 35d7eedb5e8e..0385df976d41 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -3,10 +3,116 @@
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

It looks like the above enum is not used anymore, you can drop it.

[...]

> @@ -121,20 +108,18 @@ static void vsock_loopback_work(struct work_struct *work)
>  {
>  	struct vsock_loopback *vsock =
>  		container_of(work, struct vsock_loopback, pkt_work);
> -	LIST_HEAD(pkts);
> +	struct sk_buff_head pkts;
> +	struct sk_buff *skb;
> +
> +	skb_queue_head_init(&pkts);
>  
>  	spin_lock_bh(&vsock->pkt_list_lock);
> -	list_splice_init(&vsock->pkt_list, &pkts);
> +	skb_queue_splice_init(&vsock->pkt_queue, &pkts);
>  	spin_unlock_bh(&vsock->pkt_list_lock);
>  
> -	while (!list_empty(&pkts)) {
> -		struct virtio_vsock_pkt *pkt;
> -
> -		pkt = list_first_entry(&pkts, struct virtio_vsock_pkt, list);
> -		list_del_init(&pkt->list);
> -
> -		virtio_transport_deliver_tap_pkt(pkt);
> -		virtio_transport_recv_pkt(&loopback_transport, pkt);
> +	while ((skb = skb_dequeue(&pkts))) {

Minor nit: since this code has complete ownership of the pkts queue,
you can use the lockless dequeue variant here:

	while ((skb = __skb_dequeue(&pkts))) {

> +		virtio_transport_deliver_tap_pkt(skb);
> +		virtio_transport_recv_pkt(&loopback_transport, skb);
>  	}
>  }
>  

Other then that LGTM. @Michael: feel free to take this via your tree,
once that the above feedback has been addressed, thanks!

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
