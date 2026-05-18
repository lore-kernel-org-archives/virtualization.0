Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705A31716A
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096797; cv=none; b=nnpQUi+3VNjO9OQL+qTxPjmP+s1u9N59tcybppgYgidAHBEhyQKOlpm0e44uZeRjOb9zHTWt6uJttcI5MuIsNZMlyvx4uJCZ9oMPtT/WAfD9ENkKfMMihg6/PCWveHk9HTjGWwBgK3ToySdhUH3SeQtxNx44PSDrO9ElHdH3w7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096797; c=relaxed/simple;
	bh=jSlre+l4xv2u3lht0ewJ63vmV7qP+xbiV5kD+x9/9jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZiTPyQU7LVe5xpzVhQAKWzS72971eSkCpB1eVG3/OtupkVzZPm/Q/fjOLTCsEXGpjpzNh0XkTksSwzR4d7vI+v3d12pg+cfb9yXezmgpllMk6ikjRDGqa7YHU+jqVt7eoUWJA95zjRhyRIr0Tzc9uvNzxwEWnA+C9RrO7T5AafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/CaEIFn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/CaEIFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779096795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/rMc/AxTWnfe6rPr4aOrLy+F5Zu/TWf0k5shSHIhIko=;
	b=H/CaEIFnctrW8LwWROHQmclAXO14GVI//8RqNtIbFTUScJ1n4mAyViylj7JUvJX6A9aPlF
	mXAZ3LGiv9VgH0fV+DcElauqHi1xHRGb1XzKCxWxt1wrZLWmV0JI95J/REs7TOp2RSy5+3
	d29Hw7uUUq8zJeOGdR/TExcKnJlVrcw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Q6Jo2tdIPp24hF7I6DVQlA-1; Mon, 18 May 2026 05:33:14 -0400
X-MC-Unique: Q6Jo2tdIPp24hF7I6DVQlA-1
X-Mimecast-MFC-AGG-ID: Q6Jo2tdIPp24hF7I6DVQlA_1779096793
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45e80183514so426314f8f.3
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 02:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779096793; x=1779701593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rMc/AxTWnfe6rPr4aOrLy+F5Zu/TWf0k5shSHIhIko=;
        b=TZa7yhd474yZU5SbeFowfD+yPYUtJDRKEo8ROv8w679SUjyoW6D1p9mTc4lkEQeuXZ
         JJNTHnHDsf4P13PvsVYFLildBqkpfdb30Y7fD4ZVNZYpUzc/QgBllwPrUWlIIA9rh63E
         M4fwNnaFNFqZ52tRisoF57KiVn8JS/0QYGXfeqH9bXOfEtrLYWYn5XfKlLfz9PpIBC13
         aQi24lBo4tAu7oKNsVvM7mZxGDSPfG1lR9IgPzBQ7rKzmVHnW7YOIXght8LdPU//eWjv
         Fy66XVUJYMKUnvWja9Ger8gFK1r9iYxog8e3lIFoFKvNnw+GiqHholhDA0ifcsnjtcL8
         A8vg==
X-Forwarded-Encrypted: i=1; AFNElJ9IwK9QRFEjpiNzO2+YsSFj4vkmMMKtgvxCTt+pf+CGdcgdc04K0/Ro9oAfb0RLXQ8pjyYpLZSy3Ny3uHHP/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdT8Lg2/oBz9Ibznh+x8yOJin8woD18TEXkkfX3ZVF5HSeqngo
	ArImI54oYRT3YWVwav3vPcYZLzA1KGp7mjbnwDYvckeNbLS/I3YBb8zgomKMHVnp6hAwh7GLhTx
	V99Ttgrw00ksQA7hQCrl8AlV3gd6G8zQnXh0Zn91p8Ln+OfqKxnMct76pwyqaqauqupk0
X-Gm-Gg: Acq92OFjM8uZTkMfgGBfbXLk3V9OPcywqS2xmxFo/MVFQrG5/dvH28fuR5IhAox75AI
	DdEj8Ox+5xJaZnGjtWB0zk5MdOqIvcUHASZei+M0SRLhVR3Vt0P/LERuHifQguCi25mCMzvuy9/
	Wv3nekiHmbRJlLI0nr19B0BgQiZGhDu77TS1UqbnKRb2TLSwqNQfNzwBItBtNAf8MU09uFH1Q7c
	0plorzZT5zl+sM/pikmihSW2zC8yhMIFSp5RAZPSNdPaYxGJkpnctUhpG09auldzESinVHfRd9R
	A0ErJMBxSxCd6clNTyzS98NY3waqKibUOFgXPrgV6QUXpdgrMe0lUxKDN1O+u/rdMJcpHN02hnZ
	tdTlQK0YfvIuIfAuxk46QJzVmby3oE65VWUK1QFDQ
X-Received: by 2002:a05:600c:a406:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-48fe6329913mr173599015e9.31.1779096792667;
        Mon, 18 May 2026 02:33:12 -0700 (PDT)
X-Received: by 2002:a05:600c:a406:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-48fe6329913mr173598345e9.31.1779096792146;
        Mon, 18 May 2026 02:33:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe5bc94sm140342335e9.4.2026.05.18.02.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:33:11 -0700 (PDT)
Date: Mon, 18 May 2026 05:33:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <20260518053223-mutt-send-email-mst@kernel.org>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin>
 <agrXvCtNRlySlwgx@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agrXvCtNRlySlwgx@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mAcosM1BFljPJpwRdloRgO6wdVjRFloigOlSQeQsnaQ_1779096793
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2026 at 11:18:24AM +0200, Stefano Garzarella wrote:
> On Sat, May 16, 2026 at 12:53:29PM +0100, David Laight wrote:
> > On Thu, 14 May 2026 11:29:48 +0200
> > Stefano Garzarella <sgarzare@redhat.com> wrote:
> > 
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > When a large message is fragmented into multiple skbs, the zerocopy
> > > uarg is only allocated and attached to the last skb in the loop.
> > > Non-final skbs carry pinned user pages with no completion tracking,
> > > so the kernel has no way to notify userspace when those pages are safe
> > > to reuse. If the loop breaks early the uarg is never allocated at all,
> > > leaking pinned pages with no completion notification.
> > > 
> > > Fix this by following the approach used by TCP: allocate the zerocopy
> > > uarg (if not provided by the caller) before the send loop and attach
> > > it to every skb via skb_zcopy_set(), which takes a reference per skb.
> > > Each skb's completion properly decrements the refcount, and the
> > > notification only fires after the last skb is freed.
> > > On failure, if no data was sent, the uarg is cleanly aborted via
> > > net_zcopy_put_abort().
> > > 
> > > This issue was initially discovered by sashiko while reviewing commit
> > > 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
> > > but was pre-existing.
> > > 
> > > Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> > > Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
> > > Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
> > > Reported-by: Maher Azzouzi <maherazz04@gmail.com>
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
> > >  1 file changed, 34 insertions(+), 49 deletions(-)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 989cc252d3d3..1e3409d28164 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
> > >  	return true;
> > >  }
> > > 
> > > -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
> > > -					   struct sk_buff *skb,
> > > -					   struct msghdr *msg,
> > > -					   size_t pkt_len,
> > > -					   bool zerocopy)
> > > -{
> > > -	struct ubuf_info *uarg;
> > > -
> > > -	if (msg->msg_ubuf) {
> > > -		uarg = msg->msg_ubuf;
> > > -		net_zcopy_get(uarg);
> > > -	} else {
> > > -		struct ubuf_info_msgzc *uarg_zc;
> > > -
> > > -		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> > > -					    pkt_len, NULL, false);
> > > -		if (!uarg)
> > > -			return -1;
> > > -
> > > -		uarg_zc = uarg_to_msgzc(uarg);
> > > -		uarg_zc->zerocopy = zerocopy ? 1 : 0;
> > > -	}
> > > -
> > > -	skb_zcopy_init(skb, uarg);
> > > -
> > > -	return 0;
> > > -}
> > > -
> > >  static int virtio_transport_fill_skb(struct sk_buff *skb,
> > >  				     struct virtio_vsock_pkt_info *info,
> > >  				     size_t len,
> > > @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > >  	u32 src_cid, src_port, dst_cid, dst_port;
> > >  	const struct virtio_transport *t_ops;
> > >  	struct virtio_vsock_sock *vvs;
> > > +	struct ubuf_info *uarg = NULL;
> > >  	u32 pkt_len = info->pkt_len;
> > >  	bool can_zcopy = false;
> > > +	bool have_uref = false;
> > >  	u32 rest_len;
> > >  	int ret;
> > > 
> > > @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > >  		if (can_zcopy)
> > >  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
> > >  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> > > +
> > > +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> > > +		    info->op == VIRTIO_VSOCK_OP_RW) {
> > > +			uarg = info->msg->msg_ubuf;
> > > +
> > > +			if (!uarg) {
> > > +				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> > > +							    pkt_len, NULL, false);
> > > +				if (!uarg) {
> > > +					virtio_transport_put_credit(vvs, pkt_len);
> > > +					return -ENOMEM;
> > > +				}
> > > +
> > > +				if (!can_zcopy)
> > > +					uarg_to_msgzc(uarg)->zerocopy = 0;
> > > +
> > > +				have_uref = true;
> > > +			}
> > > +		}
> > 
> > Surely that block should only be done if can_zcopy is true?
> > And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
> > If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.
> > 
> > It info->msg->msg_buf is already set then I think you have to disable zero-copy.
> > The caller has already requested a callback - and you can't add another.
> > 
> > In any case by the end of this can_zcopy and have_uref are really the same flag.
> 
> I kept the same approach we had before, trying to make as few changes as
> possible.
> 
> All these potential issues seem to be pre-existing and should be eventually
> addressed in other patches IMHO. This patch one only resolves the main issue
> of calling `skb_zcopy_set()` for every skb to avoid leaking pages, etc.

the patch is upstream now, right? So pretty much have to be patches on
top.

> @Arseniy can you help on this?
> 
> > 
> > >  	}
> > > 
> > >  	rest_len = pkt_len;
> > > @@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > >  			break;
> > >  		}
> > > 
> > > -		/* We process buffer part by part, allocating skb on
> > > -		 * each iteration. If this is last skb for this buffer
> > > -		 * and MSG_ZEROCOPY mode is in use - we must allocate
> > > -		 * completion for the current syscall.
> > > -		 *
> > > -		 * Pass pkt_len because msg iter is already consumed
> > > -		 * by virtio_transport_fill_skb(), so iter->count
> > > -		 * can not be used for RLIMIT_MEMLOCK pinned-pages
> > > -		 * accounting done by msg_zerocopy_realloc().
> > > -		 */
> > > -		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
> > > -		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
> > > -			if (virtio_transport_init_zcopy_skb(vsk, skb,
> > > -							    info->msg,
> > > -							    pkt_len,
> > > -							    can_zcopy)) {
> > > -				kfree_skb(skb);
> > > -				ret = -ENOMEM;
> > > -				break;
> > > -			}
> > > -		}
> > > +		skb_zcopy_set(skb, uarg, NULL);
> > > 
> > >  		virtio_transport_inc_tx_pkt(vvs, skb);
> > > 
> > > @@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > 
> > >  	virtio_transport_put_credit(vvs, rest_len);
> > > 
> > > +	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
> > > +	 * skb_zcopy_set() increases it for each skb, so we can drop that
> >                                                            ^ must
> > 
> > > +	 * initial reference to keep it balanced.
> > > +	 */
> > > +	if (have_uref) {
> > > +		if (rest_len == pkt_len)
> > > +			/* No data sent, abort the notification. */
> > > +			net_zcopy_put_abort(uarg, true);
> > 
> > Is it worth optimising for the 'nothing sent' case ?
> 
> What do you suggest doing?
> 
> I followed what TCP does.
> 
> Thanks,
> Stefano
> 
> > 
> > -- David
> > 
> > > +		else
> > > +			net_zcopy_put(uarg);
> > > +	}
> > > +
> > >  	/* Return number of bytes, if any data has been sent. */
> > >  	if (rest_len != pkt_len)
> > >  		ret = pkt_len - rest_len;
> > 

