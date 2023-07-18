Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF48EB64DC
	for <virtualization@archiver.kernel.org>; Tue, 18 Jul 2023 20:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 581716102B;
	Tue, 18 Jul 2023 20:27:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 581716102B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZlpgHkP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ii8ebntfHpxi; Tue, 18 Jul 2023 20:27:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DD0326100B;
	Tue, 18 Jul 2023 20:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD0326100B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3925C0072;
	Tue, 18 Jul 2023 20:27:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 397E3C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 20:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E6B881F56
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 20:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E6B881F56
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZlpgHkP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rUorybVR3TAC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 20:27:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96E7281F54
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96E7281F54
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 20:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689712062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFzQVLD8HSP1RQHiTiX0erd1kVWah51g3weAFxDkVck=;
 b=TZlpgHkPYRX5fSW8HwWOiCLtlvQxhtFqOsxKmbutZnDTY9hJTWTEGu+3pD26E9f6CAfDNF
 jdBS6XsSUBsHfuaP1LlD2zKN16ad84Nmeiw5zSx721UeAT0WvdH2jPtDMcgCFeRNRVddU8
 8+cz34h+0FriT+RFDj0HmykhWDKl9HA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-V5snVS3eNwmyGDa8yfKA_Q-1; Tue, 18 Jul 2023 16:27:39 -0400
X-MC-Unique: V5snVS3eNwmyGDa8yfKA_Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31437f02985so3869163f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jul 2023 13:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689712058; x=1692304058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UFzQVLD8HSP1RQHiTiX0erd1kVWah51g3weAFxDkVck=;
 b=TpDMTz7Axhw2A9uBG3LOmsTEedeJgHrLg/TtBkEdD4Vfzv/3+ALMCLA+3BeyYUEP2M
 1dYRch/xcM4pdDYQW/xvw8B2XyZVIXJ5ejiXqrlFML1hkXkNAa7isU9P+D1TMC5sjc5S
 DHCBvoEnUVR9TpFYyuVpnNR/NiuJPFo2mho+SXP0BnBy9A5HNEJjcUh/R5Zj8fJZzHHb
 AHCGWknrFcCaIEFeP0Lfn+jgvZuF+XxsQiZVGReEEa04RcnccpxyMx23Qw0+No0BJU8/
 gqOgEqTof/8HuDGvT2fy+BGKip3t7Q2zjgfB3d1u/JTTvzeg5cGhPuRVeMBuBDqPUdNT
 pr9A==
X-Gm-Message-State: ABy/qLYNaFQwBz7ZK7T+H2qit9CS6aswW/Z4W9Ttrbt7oWC7SAQQ6RH/
 08KUqb4v4rTTPkx4nkL5CXfHlUyAjeUKo3WpFm+yeG0yalMmihX1NxHIPmHn/D74YwHX109fggi
 eYnEbCCpWkUsihwuYMUYY5lDc8xdvsGWDtv4r+omkAQ==
X-Received: by 2002:adf:f045:0:b0:313:e591:94ec with SMTP id
 t5-20020adff045000000b00313e59194ecmr13934270wro.67.1689712058008; 
 Tue, 18 Jul 2023 13:27:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHUSL09uGLyJ1DR1WqntoobKzn63+jF7HDSK0e6I01IxLEjjbrBzLog+jIdJvOcqhUNu9bHBQ==
X-Received: by 2002:adf:f045:0:b0:313:e591:94ec with SMTP id
 t5-20020adff045000000b00313e59194ecmr13934256wro.67.1689712057598; 
 Tue, 18 Jul 2023 13:27:37 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 n13-20020adff08d000000b0031433443265sm3305560wro.53.2023.07.18.13.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 13:27:36 -0700 (PDT)
Date: Tue, 18 Jul 2023 16:27:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v2 2/4] vsock/virtio: support to send non-linear
 skb
Message-ID: <20230718162202-mutt-send-email-mst@kernel.org>
References: <20230718180237.3248179-1-AVKrasnov@sberdevices.ru>
 <20230718180237.3248179-3-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230718180237.3248179-3-AVKrasnov@sberdevices.ru>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jul 18, 2023 at 09:02:35PM +0300, Arseniy Krasnov wrote:
> For non-linear skb use its pages from fragment array as buffers in
> virtio tx queue. These pages are already pinned by 'get_user_pages()'
> during such skb creation.
> 
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 40 +++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index e95df847176b..6cbb45bb12d2 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -100,7 +100,9 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>  	vq = vsock->vqs[VSOCK_VQ_TX];
>  
>  	for (;;) {
> -		struct scatterlist hdr, buf, *sgs[2];
> +		/* +1 is for packet header. */
> +		struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
> +		struct scatterlist bufs[MAX_SKB_FRAGS + 1];
>  		int ret, in_sg = 0, out_sg = 0;
>  		struct sk_buff *skb;
>  		bool reply;
> @@ -111,12 +113,38 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>  
>  		virtio_transport_deliver_tap_pkt(skb);
>  		reply = virtio_vsock_skb_reply(skb);
> +		sg_init_one(&bufs[out_sg], virtio_vsock_hdr(skb),
> +			    sizeof(*virtio_vsock_hdr(skb)));
> +		sgs[out_sg] = &bufs[out_sg];
> +		out_sg++;
> +
> +		if (!skb_is_nonlinear(skb)) {
> +			if (skb->len > 0) {
> +				sg_init_one(&bufs[out_sg], skb->data, skb->len);
> +				sgs[out_sg] = &bufs[out_sg];
> +				out_sg++;
> +			}
> +		} else {
> +			struct skb_shared_info *si;
> +			int i;
> +
> +			si = skb_shinfo(skb);
> +
> +			for (i = 0; i < si->nr_frags; i++) {
> +				skb_frag_t *skb_frag = &si->frags[i];
> +				void *va = page_to_virt(skb_frag->bv_page);
>  
> -		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
> -		sgs[out_sg++] = &hdr;
> -		if (skb->len > 0) {
> -			sg_init_one(&buf, skb->data, skb->len);
> -			sgs[out_sg++] = &buf;
> +				/* We will use 'page_to_virt()' for userspace page here,

don't put comments after code they refer to, please?

> +				 * because virtio layer will call 'virt_to_phys()' later

it will but not always. sometimes it's the dma mapping layer.


> +				 * to fill buffer descriptor. We don't touch memory at
> +				 * "virtual" address of this page.


you need to stick "the" in a bunch of places above.

> +				 */
> +				sg_init_one(&bufs[out_sg],
> +					    va + skb_frag->bv_offset,
> +					    skb_frag->bv_len);
> +				sgs[out_sg] = &bufs[out_sg];
> +				out_sg++;
> +			}
>  		}
>  
>  		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);


There's a problem here: if there vq is small this will fail.
So you really should check free vq s/gs and switch to non-zcopy
if too small.

> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
