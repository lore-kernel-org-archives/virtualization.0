Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E13C7618E
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 11:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02DB540297;
	Fri, 21 Apr 2023 11:54:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02DB540297
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cCGe2hU2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4HxLAZzEIUh7; Fri, 21 Apr 2023 11:54:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E5FAB40237;
	Fri, 21 Apr 2023 11:54:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5FAB40237
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A75A2C007A;
	Fri, 21 Apr 2023 11:54:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1070AC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 11:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1F8760F4A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 11:54:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1F8760F4A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cCGe2hU2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 72OOBkQeQiiK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 11:54:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D76960ECD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D76960ECD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682078060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zTCkyNCDw87y9YK54Qoc5ZrsrCxJ0WjYKBdepsVglWA=;
 b=cCGe2hU2/m/92bfgaBuN/c5ZOEDogGlUpwCqmPxgbcMEsG6OqNDyqKgsH3/M8xm16fwSjm
 Oah1qIiW7k6zVbsgmalvnFDnajmjPTnvT5P1IYcI+/gefSsnmOgykPA7Rk8cp5vmN5kOQV
 OYCiv+hNeAJMMlA2kv1C2ZriDWzg8Hk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-vTTDLycROwK0FhD_DkmfQQ-1; Fri, 21 Apr 2023 07:54:17 -0400
X-MC-Unique: vTTDLycROwK0FhD_DkmfQQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f065208a64so10113195e9.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 04:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682078056; x=1684670056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTCkyNCDw87y9YK54Qoc5ZrsrCxJ0WjYKBdepsVglWA=;
 b=Ks2fNufJ2Zbl9c46qbT/8oYUkvEPWRTjJWqXRuQp8UCTT6ppP8tR3LH4/Aa3vpCK1b
 SaeDyOtthBOFYQTeAhqDhHs1Q9o+dcRXg488ls2W2G967HlpGZtIhrF/sEFFUB+Sx9Rp
 gOPH+y6Hy95l/CFYilXKWjlp4FFPcoZcmjPDdumtKYU0fvbW9G+Oo1W28FWr61pIwzVF
 5B76tEnDWgbue91tunVx5wSGbKOvgatTvYWj6GGxX/NEWpAqUhxzE6kxTMJlzCuUi7En
 UwYepaGhcgddKGZrRplqo2tOiJcaLvBt0yfkMW/LXxb6jcv7Okgvwr9GjezUrwwEWOkN
 9tUQ==
X-Gm-Message-State: AAQBX9csqjGru0J0CDo5KAsD65dWEqUkk9YwWUTlFDwAoeNII2pryoLk
 l1OCIDbKZJLQp0PO9SgHMVYAVjAP+wTQxkk+D79ppMfvo5md7g4rtD4BQ9Zw+77lc6e0EvIrVbd
 4YFm7rm3e+vpxSKoLi3JEG1B/0w8PRA0aYbXfI1Iuvw==
X-Received: by 2002:a1c:7c13:0:b0:3f0:7f4f:2aa8 with SMTP id
 x19-20020a1c7c13000000b003f07f4f2aa8mr1670980wmc.9.1682078055921; 
 Fri, 21 Apr 2023 04:54:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZPNvlOLr5DD66tuuC869SwSykh15XqDk/3/Joiay1rlLh5HihRAE02lGMlMCGfFwYa2F40+Q==
X-Received: by 2002:a1c:7c13:0:b0:3f0:7f4f:2aa8 with SMTP id
 x19-20020a1c7c13000000b003f07f4f2aa8mr1670958wmc.9.1682078055497; 
 Fri, 21 Apr 2023 04:54:15 -0700 (PDT)
Received: from redhat.com ([2.55.62.70]) by smtp.gmail.com with ESMTPSA id
 m2-20020a056000008200b002f53fa16239sm4216306wrx.103.2023.04.21.04.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Apr 2023 04:54:15 -0700 (PDT)
Date: Fri, 21 Apr 2023 07:54:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 05/14] virtio_net: introduce xdp res enums
Message-ID: <20230421075119-mutt-send-email-mst@kernel.org>
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-6-xuanzhuo@linux.alibaba.com>
 <20230421025931-mutt-send-email-mst@kernel.org>
 <1682061840.4864874-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1682061840.4864874-1-xuanzhuo@linux.alibaba.com>
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

On Fri, Apr 21, 2023 at 03:24:00PM +0800, Xuan Zhuo wrote:
> On Fri, 21 Apr 2023 03:00:15 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Apr 18, 2023 at 02:53:18PM +0800, Xuan Zhuo wrote:
> > > virtnet_xdp_handler() is to process all the logic related to XDP. The
> > > caller only needs to care about how to deal with the buf. So this commit
> > > introduces new enums:
> > >
> > > 1. VIRTNET_XDP_RES_PASS: make skb by the buf
> > > 2. VIRTNET_XDP_RES_DROP: xdp return drop action or some error, caller
> > >    should release the buf
> > > 3. VIRTNET_XDP_RES_CONSUMED: xdp consumed the buf, the caller doesnot to
> > >    do anything
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> >
> > I am not excited about using virtio specific enums then translating
> > to standard ones.
> 
> 
> My fault, my expression is not very complete.
> 
> This is not a replacement, but just want to say, there are only three cases of
> virtnet_xdp_handler. Caller only needs to handle this three cases. Instead
> of paying attention to the detailed return results of XDP.
> 
> In addition, virtnet_xdp_handler returns XDP_TX, but in fact, the work of XDP_TX
> is already done in Virtnet_xdp_handler. Caller does not need to do anything for
> XDP_TX, giving people a feeling, XDP_TX does not need to be processed. I think
> it is not good.
> 
> Thanks.

I don't really get it, sorry. If it's possible to stick to
XDP return codes, that is preferable.

> 
> 
> >
> > > ---
> > >  drivers/net/virtio_net.c | 42 ++++++++++++++++++++++++++--------------
> > >  1 file changed, 27 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 0fa64c314ea7..4dfdc211d355 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -301,6 +301,15 @@ struct padded_vnet_hdr {
> > >  	char padding[12];
> > >  };
> > >
> > > +enum {
> > > +	/* xdp pass */
> > > +	VIRTNET_XDP_RES_PASS,
> > > +	/* drop packet. the caller needs to release the page. */
> > > +	VIRTNET_XDP_RES_DROP,
> > > +	/* packet is consumed by xdp. the caller needs to do nothing. */
> > > +	VIRTNET_XDP_RES_CONSUMED,
> > > +};
> > > +
> > >  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
> > >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> > >
> > > @@ -803,14 +812,14 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> > >
> > >  	switch (act) {
> > >  	case XDP_PASS:
> > > -		return act;
> > > +		return VIRTNET_XDP_RES_PASS;
> > >
> > >  	case XDP_TX:
> > >  		stats->xdp_tx++;
> > >  		xdpf = xdp_convert_buff_to_frame(xdp);
> > >  		if (unlikely(!xdpf)) {
> > >  			netdev_dbg(dev, "convert buff to frame failed for xdp\n");
> > > -			return XDP_DROP;
> > > +			return VIRTNET_XDP_RES_DROP;
> > >  		}
> > >
> > >  		err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
> > > @@ -818,19 +827,20 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> > >  			xdp_return_frame_rx_napi(xdpf);
> > >  		} else if (unlikely(err < 0)) {
> > >  			trace_xdp_exception(dev, xdp_prog, act);
> > > -			return XDP_DROP;
> > > +			return VIRTNET_XDP_RES_DROP;
> > >  		}
> > > +
> > >  		*xdp_xmit |= VIRTIO_XDP_TX;
> > > -		return act;
> > > +		return VIRTNET_XDP_RES_CONSUMED;
> > >
> > >  	case XDP_REDIRECT:
> > >  		stats->xdp_redirects++;
> > >  		err = xdp_do_redirect(dev, xdp, xdp_prog);
> > >  		if (err)
> > > -			return XDP_DROP;
> > > +			return VIRTNET_XDP_RES_DROP;
> > >
> > >  		*xdp_xmit |= VIRTIO_XDP_REDIR;
> > > -		return act;
> > > +		return VIRTNET_XDP_RES_CONSUMED;
> > >
> > >  	default:
> > >  		bpf_warn_invalid_xdp_action(dev, xdp_prog, act);
> > > @@ -839,7 +849,7 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> > >  		trace_xdp_exception(dev, xdp_prog, act);
> > >  		fallthrough;
> > >  	case XDP_DROP:
> > > -		return XDP_DROP;
> > > +		return VIRTNET_XDP_RES_DROP;
> > >  	}
> > >  }
> > >
> > > @@ -987,17 +997,18 @@ static struct sk_buff *receive_small(struct net_device *dev,
> > >  		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
> > >
> > >  		switch (act) {
> > > -		case XDP_PASS:
> > > +		case VIRTNET_XDP_RES_PASS:
> > >  			/* Recalculate length in case bpf program changed it */
> > >  			delta = orig_data - xdp.data;
> > >  			len = xdp.data_end - xdp.data;
> > >  			metasize = xdp.data - xdp.data_meta;
> > >  			break;
> > > -		case XDP_TX:
> > > -		case XDP_REDIRECT:
> > > +
> > > +		case VIRTNET_XDP_RES_CONSUMED:
> > >  			rcu_read_unlock();
> > >  			goto xdp_xmit;
> > > -		default:
> > > +
> > > +		case VIRTNET_XDP_RES_DROP:
> > >  			goto err_xdp;
> > >  		}
> > >  	}
> > > @@ -1324,18 +1335,19 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> > >  		act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
> > >
> > >  		switch (act) {
> > > -		case XDP_PASS:
> > > +		case VIRTNET_XDP_RES_PASS:
> > >  			head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> > >  			if (unlikely(!head_skb))
> > >  				goto err_xdp_frags;
> > >
> > >  			rcu_read_unlock();
> > >  			return head_skb;
> > > -		case XDP_TX:
> > > -		case XDP_REDIRECT:
> > > +
> > > +		case VIRTNET_XDP_RES_CONSUMED:
> > >  			rcu_read_unlock();
> > >  			goto xdp_xmit;
> > > -		default:
> > > +
> > > +		case VIRTNET_XDP_RES_DROP:
> > >  			break;
> > >  		}
> > >  err_xdp_frags:
> > > --
> > > 2.32.0.3.g01195cf9f
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
