Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B54CC05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 17:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90A7E41870;
	Thu,  2 Feb 2023 17:16:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90A7E41870
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KfciQNzR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x5SzNOlcc3kW; Thu,  2 Feb 2023 17:16:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 784BC404F5;
	Thu,  2 Feb 2023 17:16:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 784BC404F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5688DC0033;
	Thu,  2 Feb 2023 17:16:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22813C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA44281A2B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:16:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA44281A2B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KfciQNzR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SuqmE6wbUm6X
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:16:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C10981A16
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C10981A16
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675358208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uy+Vya/fYh3PSRar8kQjLgK1zcHNT7rb/JLZXSZVFNA=;
 b=KfciQNzR8Gk5C1feiHyoKNdx36rbZx9M+AJc6gm1xmnYs+PRZXLRhpyL/7dvZ4hAZiw2Vh
 YsYQQ+Wf9svjMKYxNjEcoDiDWNKo5FrZpMcmQDnsDJnYPnWp7LwTZz/pa+hs0fJIYHsEYQ
 IUnKIC67HxqlNTOV4YXUPKJCMLj6GIw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-114-_ALynCFYOJeHWGq8LtcoiA-1; Thu, 02 Feb 2023 12:16:47 -0500
X-MC-Unique: _ALynCFYOJeHWGq8LtcoiA-1
Received: by mail-wr1-f69.google.com with SMTP id
 i9-20020a0560001ac900b002bfda39265aso357642wry.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 09:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uy+Vya/fYh3PSRar8kQjLgK1zcHNT7rb/JLZXSZVFNA=;
 b=ZR2S09/C1CzpgEKozP1rYPPbeUFGlZgLzwAtHPU1hsXlKR1yvpJg/xajuMQhGPi0pk
 0kIbZf0NETQ+LYHQi8PPiBlHxw0VV/K7CKyZlEbHrTyUgc5+8JinEcd02TPBwt/f2ypU
 SPsQBVwhmM6dupKTRLHfp+kPoN/mVsXhXCW1oP+5YqGd4P+gQQRgeLU2L7iNBQZ+5ZCy
 oEAxnYKw0okDpb/8dAtAxxrNDs05oZ1ThsoHXvXTN7LMhVgXIJf1XPIDGEajMmjSBuuy
 0vB+Sb7TlTpImec3LIpw4ePG6ORq8WCogzF5zJmzs98k1x1ka7cV7bfYfziyRO5JflpU
 K+sw==
X-Gm-Message-State: AO0yUKX45KUDyYsF+EhszW92TgX+7HXmdRPc1T+IyVnd0+wsZopUEqnL
 Jm2V25t84U38p83X2OJYmguo92g3mZG5vaDvVhvOiL0uNsRxtXKKd1Kh1/TCb5vS5V0lemLgASh
 XujljlbuB3wYVzTMGM/fSnlFdDuxFcPMpi18K3LfDyQ==
X-Received: by 2002:a5d:678e:0:b0:2bc:aa67:28fb with SMTP id
 v14-20020a5d678e000000b002bcaa6728fbmr5237721wru.49.1675358206354; 
 Thu, 02 Feb 2023 09:16:46 -0800 (PST)
X-Google-Smtp-Source: AK7set99wHFHlz7JJlOEHJxXx69qk5APn0sS5AATVtKlYWnjhoL70/xNO1BtCMLkdGIqpqEnGGDDLg==
X-Received: by 2002:a5d:678e:0:b0:2bc:aa67:28fb with SMTP id
 v14-20020a5d678e000000b002bcaa6728fbmr5237705wru.49.1675358206151; 
 Thu, 02 Feb 2023 09:16:46 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 t10-20020adff60a000000b002bbddb89c71sm12704wrp.67.2023.02.02.09.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 09:16:45 -0800 (PST)
Date: Thu, 2 Feb 2023 12:16:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 18/33] virtio_net: receive_merageable() use
 virtnet_xdp_handler()
Message-ID: <20230202121547-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-19-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230202110058.130695-19-xuanzhuo@linux.alibaba.com>
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

On Thu, Feb 02, 2023 at 07:00:43PM +0800, Xuan Zhuo wrote:
> receive_merageable() use virtnet_xdp_handler()
> 
> Meanwhile, support Multi Buffer XDP.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

typo

> ---
>  drivers/net/virtio/main.c | 88 +++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index d7a856bd8862..fb82035a0b7f 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -483,8 +483,10 @@ int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  			unsigned int *xdp_xmit,
>  			struct virtnet_rq_stats *stats)
>  {
> +	struct skb_shared_info *shinfo;
>  	struct xdp_frame *xdpf;
> -	int err;
> +	struct page *xdp_page;
> +	int err, i;
>  	u32 act;
>  
>  	act = bpf_prog_run_xdp(xdp_prog, xdp);
> @@ -527,6 +529,13 @@ int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  		trace_xdp_exception(dev, xdp_prog, act);
>  		fallthrough;
>  	case XDP_DROP:
> +		if (xdp_buff_has_frags(xdp)) {
> +			shinfo = xdp_get_shared_info_from_buff(xdp);
> +			for (i = 0; i < shinfo->nr_frags; i++) {
> +				xdp_page = skb_frag_page(&shinfo->frags[i]);
> +				put_page(xdp_page);
> +			}
> +		}
>  		return VIRTNET_XDP_RES_DROP;
>  	}
>  }
> @@ -809,7 +818,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  	unsigned int xdp_frags_truesz = 0;
>  	struct page *page;
>  	skb_frag_t *frag;
> -	int offset;
> +	int offset, i;
>  	void *ctx;
>  
>  	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
> @@ -842,7 +851,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  				 dev->name, *num_buf,
>  				 virtio16_to_cpu(vi->vdev, hdr->num_buffers));
>  			dev->stats.rx_length_errors++;
> -			return -EINVAL;
> +			goto err;
>  		}
>  
>  		stats->bytes += len;
> @@ -861,7 +870,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
>  				 dev->name, len, (unsigned long)(truesize - room));
>  			dev->stats.rx_length_errors++;
> -			return -EINVAL;
> +			goto err;
>  		}
>  
>  		frag = &shinfo->frags[shinfo->nr_frags++];
> @@ -876,6 +885,14 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  
>  	*xdp_frags_truesize = xdp_frags_truesz;
>  	return 0;
> +
> +err:
> +	for (i = 0; i < shinfo->nr_frags; i++) {
> +		page = skb_frag_page(&shinfo->frags[i]);
> +		put_page(page);
> +	}
> +
> +	return -EINVAL;
>  }
>  
>  static struct sk_buff *receive_mergeable(struct net_device *dev,
> @@ -919,13 +936,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	xdp_prog = rcu_dereference(rq->xdp_prog);
>  	if (xdp_prog) {
>  		unsigned int xdp_frags_truesz = 0;
> -		struct skb_shared_info *shinfo;
> -		struct xdp_frame *xdpf;
>  		struct page *xdp_page;
>  		struct xdp_buff xdp;
>  		void *data;
>  		u32 act;
> -		int i;
>  
>  		/* Transient failure which in theory could occur if
>  		 * in-flight packets from before XDP was enabled reach
> @@ -983,69 +997,33 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
>  						 &num_buf, &xdp_frags_truesz, stats);
>  		if (unlikely(err))
> -			goto err_xdp_frags;
> +			goto err_xdp;
>  
> -		act = bpf_prog_run_xdp(xdp_prog, &xdp);
> -		stats->xdp_packets++;
> +		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
>  
>  		switch (act) {
> -		case XDP_PASS:
> +		case VIRTNET_XDP_RES_PASS:
>  			if (unlikely(xdp_page != page))
>  				put_page(page);
> +
>  			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>  			rcu_read_unlock();
>  			return head_skb;
> -		case XDP_TX:
> -			stats->xdp_tx++;
> -			xdpf = xdp_convert_buff_to_frame(&xdp);
> -			if (unlikely(!xdpf)) {
> -				netdev_dbg(dev, "convert buff to frame failed for xdp\n");
> -				goto err_xdp_frags;
> -			}
> -			err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
> -			if (unlikely(!err)) {
> -				xdp_return_frame_rx_napi(xdpf);
> -			} else if (unlikely(err < 0)) {
> -				trace_xdp_exception(vi->dev, xdp_prog, act);
> -				goto err_xdp_frags;
> -			}
> -			*xdp_xmit |= VIRTIO_XDP_TX;
> -			if (unlikely(xdp_page != page))
> -				put_page(page);
> -			rcu_read_unlock();
> -			goto xdp_xmit;
> -		case XDP_REDIRECT:
> -			stats->xdp_redirects++;
> -			err = xdp_do_redirect(dev, &xdp, xdp_prog);
> -			if (err)
> -				goto err_xdp_frags;
> -			*xdp_xmit |= VIRTIO_XDP_REDIR;
> +
> +		case VIRTNET_XDP_RES_CONSUMED:
>  			if (unlikely(xdp_page != page))
>  				put_page(page);
> +
>  			rcu_read_unlock();
>  			goto xdp_xmit;
> -		default:
> -			bpf_warn_invalid_xdp_action(vi->dev, xdp_prog, act);
> -			fallthrough;
> -		case XDP_ABORTED:
> -			trace_xdp_exception(vi->dev, xdp_prog, act);
> -			fallthrough;
> -		case XDP_DROP:
> -			goto err_xdp_frags;
> -		}
> -err_xdp_frags:
> -		if (unlikely(xdp_page != page))
> -			__free_pages(xdp_page, 0);
>  
> -		if (xdp_buff_has_frags(&xdp)) {
> -			shinfo = xdp_get_shared_info_from_buff(&xdp);
> -			for (i = 0; i < shinfo->nr_frags; i++) {
> -				xdp_page = skb_frag_page(&shinfo->frags[i]);
> +		case VIRTNET_XDP_RES_DROP:
> +			if (unlikely(xdp_page != page))
>  				put_page(xdp_page);
> -			}
> -		}
>  
> -		goto err_xdp;
> +			rcu_read_unlock();
> +			goto err_xdp;
> +		}
>  	}
>  	rcu_read_unlock();
>  
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
