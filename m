Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21BEC61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 17:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D76682022;
	Thu,  2 Feb 2023 17:24:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D76682022
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C/qnb+yW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gOhANk4DaWvC; Thu,  2 Feb 2023 17:24:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ABD3A81EF6;
	Thu,  2 Feb 2023 17:24:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABD3A81EF6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 874D2C0033;
	Thu,  2 Feb 2023 17:24:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB1FEC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 789A481EF6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:24:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 789A481EF6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T7dzQl3z3v-U
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:24:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A427182022
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A427182022
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675358645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zi7pe0UxkBtEbi7YCeZA5YzsyNiHTHBrH46k3JXR73E=;
 b=C/qnb+yWVPess2jif2RMLf+cwDX26deBIqIomkLrBxJZabFmYcg+JviQ4C5Q8zwvW0N/Tw
 eiN8KKPAyUYggL0N/jbSr1THnZguJ82JDfx+V97paH1dzUJ4K95rhbH+UpY3hsZ0E6Coyx
 p0yX8t2fjiTK69aSEVwt7XmA692rzeI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-387-rpRxRM5dNp272Ri38kkGlQ-1; Thu, 02 Feb 2023 12:24:03 -0500
X-MC-Unique: rpRxRM5dNp272Ri38kkGlQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 m3-20020a05600c3b0300b003dfdc6021bcso1167363wms.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 09:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zi7pe0UxkBtEbi7YCeZA5YzsyNiHTHBrH46k3JXR73E=;
 b=hoQ36BE7+XEAFXUGhfvKol97ZP9X2qgA1FsmjLGP/HWKm6kGT1W3/DvyoRO1jGf50R
 5zyRtUUC8j2t6yCa1vNFtaKoICP0XDXFWb0nev26jJHuL7IatjinDvbi3ygBzwjwEGkI
 t1mfAcpLxUzyt79fRjw4LwqZZB2FhW6fJddfNFfRsrTAfx8+Clv7w/yv5tu4PqsWGgTq
 ytklywfIWxLa6SAYOXVwPlG/1c5LiG43fMwNy9a0XAozAXuVJzGlrYm/NZNpDhR5LH84
 zQyWkM4uuPqbWgDE4ClBIWB224JdSmBPMO2GLwDPDG85IXLPHgxU5uM6tkztP94I2pKd
 nTMw==
X-Gm-Message-State: AO0yUKX9smDjwSjZp8ZCZw0WFsgeOKUpAbuLGrAnsA00vAI1Xn5z3WHA
 pyp72zIX/g5JvEAY9EO25oYCCbJBoNH3qXD+LM5qVBArcsPEr/QU3UCGvf9/xZib2kkC3oG9Ohr
 sh/zHjTx4r3mEyjkr2+KY/uhTKz1G9wHUc2hJIU6l6g==
X-Received: by 2002:a05:600c:3c9b:b0:3dc:46e8:982 with SMTP id
 bg27-20020a05600c3c9b00b003dc46e80982mr6465490wmb.19.1675358642279; 
 Thu, 02 Feb 2023 09:24:02 -0800 (PST)
X-Google-Smtp-Source: AK7set+SWaayznR+KdR4VtGrVFlQFcvR61IRH4Fc/O+4J8EkSdt36bLQbXIq6MZx64YFcR2JlMxuJA==
X-Received: by 2002:a05:600c:3c9b:b0:3dc:46e8:982 with SMTP id
 bg27-20020a05600c3c9b00b003dc46e80982mr6465465wmb.19.1675358642098; 
 Thu, 02 Feb 2023 09:24:02 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 c18-20020a7bc012000000b003d1e3b1624dsm5423336wmb.2.2023.02.02.09.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 09:24:01 -0800 (PST)
Date: Thu, 2 Feb 2023 12:23:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 19/33] virtio_net: introduce virtnet_tx_reset()
Message-ID: <20230202121745-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-20-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230202110058.130695-20-xuanzhuo@linux.alibaba.com>
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

On Thu, Feb 02, 2023 at 07:00:44PM +0800, Xuan Zhuo wrote:
> Introduce virtnet_tx_reset() to release the buffers inside virtio ring.
> 
> This is needed for xsk disable. When disable xsk, we need to relese the

typo

> buffer from xsk, so this function is needed.
> 
> This patch reuse the virtnet_tx_resize.

reuses

> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>  drivers/net/virtio/main.c       | 21 ++++++++++++++++++---
>  drivers/net/virtio/virtio_net.h |  1 +
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index fb82035a0b7f..049a3bb9d88d 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -1806,8 +1806,8 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
>  	return err;
>  }
>  
> -static int virtnet_tx_resize(struct virtnet_info *vi,
> -			     struct send_queue *sq, u32 ring_num)
> +static int __virtnet_tx_reset(struct virtnet_info *vi,
> +			      struct send_queue *sq, u32 ring_num)
>  {
>  	bool running = netif_running(vi->dev);
>  	struct netdev_queue *txq;
> @@ -1833,7 +1833,11 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
>  
>  	__netif_tx_unlock_bh(txq);
>  
> -	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
> +	if (ring_num)
> +		err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
> +	else
> +		err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> +
>  	if (err)
>  		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
>

This __virtnet_tx_reset is a really weird API.

Suggest just splitting the common parts:

__virtnet_tx_pause
__virtnet_tx_resume

we can then implement virtnet_tx_resize and virtnet_tx_reset
using these two.

  
> @@ -1847,6 +1851,17 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
>  	return err;
>  }
>  
> +static int virtnet_tx_resize(struct virtnet_info *vi,
> +			     struct send_queue *sq, u32 ring_num)
> +{
> +	return __virtnet_tx_reset(vi, sq, ring_num);
> +}
> +
> +int virtnet_tx_reset(struct virtnet_info *vi, struct send_queue *sq)
> +{
> +	return __virtnet_tx_reset(vi, sq, 0);
> +}
> +
>  /*
>   * Send command via the control virtqueue and check status.  Commands
>   * supported by the hypervisor, as indicated by feature bits, should
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> index af3e7e817f9e..b46f083a630a 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -273,4 +273,5 @@ int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  			struct net_device *dev,
>  			unsigned int *xdp_xmit,
>  			struct virtnet_rq_stats *stats);
> +int virtnet_tx_reset(struct virtnet_info *vi, struct send_queue *sq);
>  #endif
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
