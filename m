Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24BCC77B75
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 07:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A4D984193;
	Fri, 21 Apr 2023 07:00:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A4D984193
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZDje3k/b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WwVY9XNK0yLC; Fri, 21 Apr 2023 07:00:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AD2ED81FC8;
	Fri, 21 Apr 2023 07:00:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD2ED81FC8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DAA6C007A;
	Fri, 21 Apr 2023 07:00:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BADBC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60126427D2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:00:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60126427D2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZDje3k/b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3LzjqP-iSlQd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:00:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27A37427D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27A37427D1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682060423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lpiVqfxPDVOVyIcQKLUY3sjIFaYVM+b/8XYAogBT64g=;
 b=ZDje3k/bSBa2znrhumRD2qwlseq5/w7RL3BG6uSZrQ0Dajy69yFy99QAvh4dRpdrgg4OsG
 z4+x1oz3+fAnfBOMxq6lExuIGIIa3DAtd8EiTj7q2SrqB/se6Om5faX9bntOqAzBr76623
 XOon2BaOkxTABYM6AnHQwkRtRm4/Ny0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-HsYTJlsWNa-hcGkNyzxfbQ-1; Fri, 21 Apr 2023 03:00:21 -0400
X-MC-Unique: HsYTJlsWNa-hcGkNyzxfbQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-2fcec825133so435970f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 00:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682060420; x=1684652420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpiVqfxPDVOVyIcQKLUY3sjIFaYVM+b/8XYAogBT64g=;
 b=QOCrWMiw9h1WvkuR3kB08IipEzubUNmi8KA3neiTczE/4Ecq15Xzte0WpMXVoe79S4
 /C/ctDpTfz+hRTemMFtiJju+T+9RHd/VfN72bp1i4rhj73fUVG5gjLsGJbyZhnHuga5e
 NV4VX/E/TcEZezA0h5ycOCATIGMWPiGx7UJNHbYaiVC8IoIe0Sdh/kuXdLNFBOmi8PJR
 lXmmbMaOfsOUpnftZAmXcAgnw0skfvqDZKUWbWEf0zmeOKldRHIXP5pJ7uy3hbo4YwYu
 KJR+FkBJWBZod/+30Fgn6nSqqPjoSKVmHCdoQtCWYYczBOfKIfU0BtTPLJRPlv6qOVsU
 gAVg==
X-Gm-Message-State: AAQBX9fQPS6qNe03Sxkchh+Ar7gBgg1yULR9Zv6cPDZdS6NwE3FTjKm4
 FhtHr2q4XwlcnNJIanDH6EubWv59BKpIKkpmR9qBD9hM0RW8LPS043nXHFyL4PXgr4bheqP1aA1
 15uVBrgj9nLwfi/fqD+oJGYPtwJvlZcwfQn/wACy4jA==
X-Received: by 2002:a5d:508c:0:b0:2f4:bc68:3493 with SMTP id
 a12-20020a5d508c000000b002f4bc683493mr3137921wrt.34.1682060420655; 
 Fri, 21 Apr 2023 00:00:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZscfyWPk0FUaFkFq8X9xGWbsfYMR49h0BahBp10uWnCx5uwQ3l78RWokX6He4VumLzicsf2A==
X-Received: by 2002:a5d:508c:0:b0:2f4:bc68:3493 with SMTP id
 a12-20020a5d508c000000b002f4bc683493mr3137896wrt.34.1682060420318; 
 Fri, 21 Apr 2023 00:00:20 -0700 (PDT)
Received: from redhat.com ([2.55.62.70]) by smtp.gmail.com with ESMTPSA id
 e22-20020a5d5956000000b003012030a0c6sm3732010wri.18.2023.04.21.00.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Apr 2023 00:00:19 -0700 (PDT)
Date: Fri, 21 Apr 2023 03:00:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 05/14] virtio_net: introduce xdp res enums
Message-ID: <20230421025931-mutt-send-email-mst@kernel.org>
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-6-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230418065327.72281-6-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

On Tue, Apr 18, 2023 at 02:53:18PM +0800, Xuan Zhuo wrote:
> virtnet_xdp_handler() is to process all the logic related to XDP. The
> caller only needs to care about how to deal with the buf. So this commit
> introduces new enums:
> 
> 1. VIRTNET_XDP_RES_PASS: make skb by the buf
> 2. VIRTNET_XDP_RES_DROP: xdp return drop action or some error, caller
>    should release the buf
> 3. VIRTNET_XDP_RES_CONSUMED: xdp consumed the buf, the caller doesnot to
>    do anything
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


I am not excited about using virtio specific enums then translating
to standard ones.

> ---
>  drivers/net/virtio_net.c | 42 ++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0fa64c314ea7..4dfdc211d355 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -301,6 +301,15 @@ struct padded_vnet_hdr {
>  	char padding[12];
>  };
>  
> +enum {
> +	/* xdp pass */
> +	VIRTNET_XDP_RES_PASS,
> +	/* drop packet. the caller needs to release the page. */
> +	VIRTNET_XDP_RES_DROP,
> +	/* packet is consumed by xdp. the caller needs to do nothing. */
> +	VIRTNET_XDP_RES_CONSUMED,
> +};
> +
>  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>  
> @@ -803,14 +812,14 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  
>  	switch (act) {
>  	case XDP_PASS:
> -		return act;
> +		return VIRTNET_XDP_RES_PASS;
>  
>  	case XDP_TX:
>  		stats->xdp_tx++;
>  		xdpf = xdp_convert_buff_to_frame(xdp);
>  		if (unlikely(!xdpf)) {
>  			netdev_dbg(dev, "convert buff to frame failed for xdp\n");
> -			return XDP_DROP;
> +			return VIRTNET_XDP_RES_DROP;
>  		}
>  
>  		err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
> @@ -818,19 +827,20 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  			xdp_return_frame_rx_napi(xdpf);
>  		} else if (unlikely(err < 0)) {
>  			trace_xdp_exception(dev, xdp_prog, act);
> -			return XDP_DROP;
> +			return VIRTNET_XDP_RES_DROP;
>  		}
> +
>  		*xdp_xmit |= VIRTIO_XDP_TX;
> -		return act;
> +		return VIRTNET_XDP_RES_CONSUMED;
>  
>  	case XDP_REDIRECT:
>  		stats->xdp_redirects++;
>  		err = xdp_do_redirect(dev, xdp, xdp_prog);
>  		if (err)
> -			return XDP_DROP;
> +			return VIRTNET_XDP_RES_DROP;
>  
>  		*xdp_xmit |= VIRTIO_XDP_REDIR;
> -		return act;
> +		return VIRTNET_XDP_RES_CONSUMED;
>  
>  	default:
>  		bpf_warn_invalid_xdp_action(dev, xdp_prog, act);
> @@ -839,7 +849,7 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  		trace_xdp_exception(dev, xdp_prog, act);
>  		fallthrough;
>  	case XDP_DROP:
> -		return XDP_DROP;
> +		return VIRTNET_XDP_RES_DROP;
>  	}
>  }
>  
> @@ -987,17 +997,18 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
>  
>  		switch (act) {
> -		case XDP_PASS:
> +		case VIRTNET_XDP_RES_PASS:
>  			/* Recalculate length in case bpf program changed it */
>  			delta = orig_data - xdp.data;
>  			len = xdp.data_end - xdp.data;
>  			metasize = xdp.data - xdp.data_meta;
>  			break;
> -		case XDP_TX:
> -		case XDP_REDIRECT:
> +
> +		case VIRTNET_XDP_RES_CONSUMED:
>  			rcu_read_unlock();
>  			goto xdp_xmit;
> -		default:
> +
> +		case VIRTNET_XDP_RES_DROP:
>  			goto err_xdp;
>  		}
>  	}
> @@ -1324,18 +1335,19 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
>  
>  		switch (act) {
> -		case XDP_PASS:
> +		case VIRTNET_XDP_RES_PASS:
>  			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>  			if (unlikely(!head_skb))
>  				goto err_xdp_frags;
>  
>  			rcu_read_unlock();
>  			return head_skb;
> -		case XDP_TX:
> -		case XDP_REDIRECT:
> +
> +		case VIRTNET_XDP_RES_CONSUMED:
>  			rcu_read_unlock();
>  			goto xdp_xmit;
> -		default:
> +
> +		case VIRTNET_XDP_RES_DROP:
>  			break;
>  		}
>  err_xdp_frags:
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
