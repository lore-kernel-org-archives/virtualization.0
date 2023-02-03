Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF83C61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 08:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8DB1C40A99;
	Fri,  3 Feb 2023 08:55:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DB1C40A99
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZELNj4qD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lX-7UjMV3_Ma; Fri,  3 Feb 2023 08:55:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 075E040105;
	Fri,  3 Feb 2023 08:55:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 075E040105
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C974AC0032;
	Fri,  3 Feb 2023 08:55:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C96FBC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A2DD81D24
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:55:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A2DD81D24
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZELNj4qD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h2VZdAcIH1s7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:55:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 652D281C26
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 652D281C26
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675414536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NTRIC3PmgkbexfvmdzDVVE1snyz3cb/Iuh5EyQX83nQ=;
 b=ZELNj4qDigq4YwNuS1km3JJGI8+kTMccpLeTAkUeWqS56d0baqTvc8FAYVRgqPCXr/JxCk
 WAJZHjRUrQBEVU97lNLorp58jhFPwspswqrBcCQ2QaFR5k0e1KzA1cVCBlAkyxwuoI/i9K
 02OiLGPo0UGgQpF9EX3OImgvv/N9p2Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-216-wCiUu9SXMVSRUex03-u6ig-1; Fri, 03 Feb 2023 03:55:32 -0500
X-MC-Unique: wCiUu9SXMVSRUex03-u6ig-1
Received: by mail-ej1-f72.google.com with SMTP id
 21-20020a170906225500b0088b953a6df6so3493405ejr.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 00:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTRIC3PmgkbexfvmdzDVVE1snyz3cb/Iuh5EyQX83nQ=;
 b=u0ExZxj0hHYCv9T9QpJMh53Ldhk+Gx8KmSmNjaiWyjIJLpsLBpc46MMUfiQncGm7W6
 iEuDKI0KVI2mevjFC8jvmG8giIPWIiKUFj8ct+TIz1YKzKepQSjbpg26myFF+J6OnUgr
 fYBkSO7OOw7d39o3DNhHdeLYnqbHYtYs8R6PFdGEdORkDoHVAHG38b8F0Iavoftovtxt
 DyKuKv1xnB3RlUdXhVL9BrYbTfCxp2dkFNpfHsVPNbiFWyccLqJCig7a3VQy607b5M3T
 nx9wjo1n4w9p0OYPDbkDd6ciEzzXhC3K+cFvZTsPzYPxDqozkN9juYIMV8pnRFvxMXaC
 DRNg==
X-Gm-Message-State: AO0yUKXBEqNnFYcP/OYq+4CUDeCH9R+zog+DpbKDylkLyKdICvYrHyUh
 iRsJe18huep1uRI3qQrwwLasUuhRUpye+NY1eTOizVqmkdOqfJOKFqhDgpmWDpx3kAOZS4BTC/L
 1REpnKDWztu11s6NI/dqeNpZLASnybeCtWGar7IqsXQ==
X-Received: by 2002:a05:6402:34cc:b0:4a0:e0a3:3adc with SMTP id
 w12-20020a05640234cc00b004a0e0a33adcmr9869187edc.7.1675414531915; 
 Fri, 03 Feb 2023 00:55:31 -0800 (PST)
X-Google-Smtp-Source: AK7set+sA6ogVU1Whhi9IYFxyCPIOl3snDc0rUMN+CbivbyTZZKBNsts0SpPLVa3etlWkhkgN6ftWA==
X-Received: by 2002:a05:6402:34cc:b0:4a0:e0a3:3adc with SMTP id
 w12-20020a05640234cc00b004a0e0a33adcmr9869158edc.7.1675414531740; 
 Fri, 03 Feb 2023 00:55:31 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 h40-20020a0564020ea800b004a245d70f17sm792571eda.54.2023.02.03.00.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 00:55:30 -0800 (PST)
Date: Fri, 3 Feb 2023 03:55:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 16/33] virtio_net: introduce virtnet_xdp_handler() to
 seprate the logic of run xdp
Message-ID: <20230203035416-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-17-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230202110058.130695-17-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Thu, Feb 02, 2023 at 07:00:41PM +0800, Xuan Zhuo wrote:
> At present, we have two long similar logic to perform XDP Progs. And in
> the implementation of XSK, we will have this need.
> 
> Therefore, this PATCH separates the code of executing XDP, which is
> conducive to later maintenance and facilitates subsequent XSK for reuse.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

So you first add a new function then move users over.
This means that it's hard during review to make sure
nothing is lost in translation.
Do the refactoring in a single patch instead.

> ---
>  drivers/net/virtio/main.c       | 53 +++++++++++++++++++++++++++++++++
>  drivers/net/virtio/virtio_net.h | 11 +++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 5683cb576474..9d4b84b23ef7 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -478,6 +478,59 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	return ret;
>  }
>  
> +int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> +			struct net_device *dev,
> +			unsigned int *xdp_xmit,
> +			struct virtnet_rq_stats *stats)
> +{
> +	struct xdp_frame *xdpf;
> +	int err;
> +	u32 act;
> +
> +	act = bpf_prog_run_xdp(xdp_prog, xdp);
> +	stats->xdp_packets++;
> +
> +	switch (act) {
> +	case XDP_PASS:
> +		return VIRTNET_XDP_RES_PASS;
> +
> +	case XDP_TX:
> +		stats->xdp_tx++;
> +		xdpf = xdp_convert_buff_to_frame(xdp);
> +		if (unlikely(!xdpf))
> +			return VIRTNET_XDP_RES_DROP;
> +
> +		err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
> +		if (unlikely(!err)) {
> +			xdp_return_frame_rx_napi(xdpf);
> +		} else if (unlikely(err < 0)) {
> +			trace_xdp_exception(dev, xdp_prog, act);
> +			return VIRTNET_XDP_RES_DROP;
> +		}
> +
> +		*xdp_xmit |= VIRTIO_XDP_TX;
> +		return VIRTNET_XDP_RES_CONSUMED;
> +
> +	case XDP_REDIRECT:
> +		stats->xdp_redirects++;
> +		err = xdp_do_redirect(dev, xdp, xdp_prog);
> +		if (err)
> +			return VIRTNET_XDP_RES_DROP;
> +
> +		*xdp_xmit |= VIRTIO_XDP_REDIR;
> +		return VIRTNET_XDP_RES_CONSUMED;
> +
> +	default:
> +		bpf_warn_invalid_xdp_action(dev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +		trace_xdp_exception(dev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_DROP:
> +		return VIRTNET_XDP_RES_DROP;
> +	}
> +}
> +
>  static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
>  {
>  	return vi->xdp_enabled ? VIRTIO_XDP_HEADROOM : 0;
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> index 8bf31429ae28..af3e7e817f9e 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -22,6 +22,12 @@
>  #include <net/net_failover.h>
>  #include <net/xdp_sock_drv.h>
>  
> +enum {
> +	VIRTNET_XDP_RES_PASS,
> +	VIRTNET_XDP_RES_DROP,
> +	VIRTNET_XDP_RES_CONSUMED,
> +};
> +
>  #define VIRTIO_XDP_FLAG	BIT(0)
>  
>  struct virtnet_info {
> @@ -262,4 +268,9 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>  		stats->packets++;
>  	}
>  }
> +
> +int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> +			struct net_device *dev,
> +			unsigned int *xdp_xmit,
> +			struct virtnet_rq_stats *stats);
>  #endif
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
