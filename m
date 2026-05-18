Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E23093DF
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098071; cv=none; b=kStAdNhFo3or1oveOewi7LnuNPKucsBevlU/4W65UIs57C5y0XWNuyoTPYCaTq2UQwxUdwyziIgUm38tjSnBgzcRi+jigLfnt3reH1noVI6U+iXbcL5XoN9okd863uZjkwIKi1aVD7Mw1HGR/sGdxHVmpXzmeFh0iGRtPwW4bLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098071; c=relaxed/simple;
	bh=4zTgc3MrSXjdVxBLifDn4ookpCiP1+7JJZFvxKeNMGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YagtvgXbjgAQF4+34ccjmkmHyhzG3IRweXRh/Rn+LdGmnwW/fQNq4izjE+gcGq6frNKzF64l2oKkSSRRvH9xM+teRqCI+bjxMmYvq7BHoScRVbfgqf+lWdFQ4TaeUqW5R8HEXkDOXbK6PGrZx5HakrzLeCNjWc+WpIhVgZxgQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBb0fs8p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBb0fs8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779098069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nILacjinhuq+t07PuaZ1UF4X/Jp2boNoTuckG+xzMEI=;
	b=BBb0fs8p90w9/WPfCt03TKP1uVX0DmhPTaN9aRVEVFg+8prN/a3QmunuC8WNgM+4710gpe
	nDdVxGbWYc/awDBCdaN/h26NxGJ5k4oCkufK0aLzv8YiIpbORAfrHnP/zYcJDVJv6IgLzi
	m0aP7bjtgV+8gShvo7HgQbhjdKQxWSE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-FfrvywhKPsSw-lpEQA5FoQ-1; Mon, 18 May 2026 05:54:27 -0400
X-MC-Unique: FfrvywhKPsSw-lpEQA5FoQ-1
X-Mimecast-MFC-AGG-ID: FfrvywhKPsSw-lpEQA5FoQ_1779098066
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45e81291d62so469050f8f.1
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 02:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098066; x=1779702866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nILacjinhuq+t07PuaZ1UF4X/Jp2boNoTuckG+xzMEI=;
        b=Yv2IX6pyrJgOOAhejDBeOb7P2O/T2CRTAsUIhsrnF+NpF8mygJ1oXehTxMqpVhmBMg
         vFJ4rsi9b1lGEehK3tTnxhmZZIQmr30GbsphLCMaWvNNutxz63WPneQr7x95IGgZpI5T
         kGqBMRh6MUb7rfsgw8FPnJIE0OZfd4pWA9Ju1joVhljD2L/o/g8KRGEx8rjQUvnKyt4a
         heEOVxxzRDupPmkjbuZAmb3zB7NJ4QnCInl89A4v/dWaiCTdYSfbnBJdA7EFh/St76o1
         zbYddqGEKSZ6op+2AcvAz11hUI8v4ub52p0dnaKLzXZZx+fcsvGSffj2l/Fp5iHV8cD9
         RqFA==
X-Forwarded-Encrypted: i=1; AFNElJ9QLy1xVQV0zcpi54sc/t7+e7vpysnOjOe9DHaXP+gAINdWhEUHgWZ3U/KFLG/U4xnD8y/LUJKGN9DRlDJx3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFz50QXeHHhdWMS5wmqFl7OnPhDXlhJOsgnj5C/sNDBwp+BGxb
	1raKhmT1aG24BxNxVnbdXW56Ki/D7rV755MjH0HWS/bHJt1Bnfm6o059R277YzRF6xqp2t85M2r
	2jUL4TJXPkK+nxcZ8Ecwg9h54l+b1DJLC/WhZsACYufMAwy85hUrLaCem3H/sS7sFzciL
X-Gm-Gg: Acq92OHiwiwWXgoupShtMxXTzNTqjhsBfzSpn7xGM+oPolV5OwtnXNlN2niSOFKhUPE
	yBUgFo5hYLl2tF0UDD8DjyRvgUIuiG8MV5F3lIkkBWi8ka+yB64CzF9xFALljJrttFzT0Pb9CAC
	rtUoyYoyibqeWCqGFr+RUiIEcfVEj1obZ2/2NEDrBmO9oxzZx5qp/zZQkUOTccRnMsSs+QrcJDJ
	d0x3yK567qMGK1q1A5xKQCvvtqc25t/h+uaP+IB6MFz4UAAJPdkoEuiLRFrsi+76BnHlSUCvZTK
	+H5yUvbmlO4nln8PXyUgWo3LRzWhRD7kexsUg6OudfNFUdm+NJoxBLYo9tobSo1DfwX2tyaQgVA
	mFa7t9QnJVIZi+u7LTgkrnLr0YkBA4Wfp/H484TM+MjcVuiI/EGi0eOyFz56MAqHRrW2ZGcHoCw
	==
X-Received: by 2002:a05:600c:848c:b0:48f:d0f1:ed28 with SMTP id 5b1f17b1804b1-48fe60e4e32mr219978105e9.1.1779098066390;
        Mon, 18 May 2026 02:54:26 -0700 (PDT)
X-Received: by 2002:a05:600c:848c:b0:48f:d0f1:ed28 with SMTP id 5b1f17b1804b1-48fe60e4e32mr219977635e9.1.1779098065788;
        Mon, 18 May 2026 02:54:25 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19b1dsm35194218f8f.17.2026.05.18.02.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:54:25 -0700 (PDT)
Date: Mon, 18 May 2026 11:54:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <agrg1GVzoJWtNuSd@sgarzare-redhat>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin>
 <agrXvCtNRlySlwgx@sgarzare-redhat>
 <20260518053223-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260518053223-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IH0RBH6UCwrlTPA_RhGn_130MACqAbxWvqZ6xrvxsc4_1779098066
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, May 18, 2026 at 05:33:08AM -0400, Michael S. Tsirkin wrote:
>On Mon, May 18, 2026 at 11:18:24AM +0200, Stefano Garzarella wrote:
>> On Sat, May 16, 2026 at 12:53:29PM +0100, David Laight wrote:
>> > On Thu, 14 May 2026 11:29:48 +0200
>> > Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >
>> > > From: Stefano Garzarella <sgarzare@redhat.com>
>> > >
>> > > When a large message is fragmented into multiple skbs, the zerocopy
>> > > uarg is only allocated and attached to the last skb in the loop.
>> > > Non-final skbs carry pinned user pages with no completion tracking,
>> > > so the kernel has no way to notify userspace when those pages are safe
>> > > to reuse. If the loop breaks early the uarg is never allocated at all,
>> > > leaking pinned pages with no completion notification.
>> > >
>> > > Fix this by following the approach used by TCP: allocate the zerocopy
>> > > uarg (if not provided by the caller) before the send loop and attach
>> > > it to every skb via skb_zcopy_set(), which takes a reference per skb.
>> > > Each skb's completion properly decrements the refcount, and the
>> > > notification only fires after the last skb is freed.
>> > > On failure, if no data was sent, the uarg is cleanly aborted via
>> > > net_zcopy_put_abort().
>> > >
>> > > This issue was initially discovered by sashiko while reviewing commit
>> > > 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
>> > > but was pre-existing.
>> > >
>> > > Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>> > > Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> > > Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
>> > > Reported-by: Maher Azzouzi <maherazz04@gmail.com>
>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > ---
>> > >  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
>> > >  1 file changed, 34 insertions(+), 49 deletions(-)
>> > >
>> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > index 989cc252d3d3..1e3409d28164 100644
>> > > --- a/net/vmw_vsock/virtio_transport_common.c
>> > > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > > @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>> > >  	return true;
>> > >  }
>> > >
>> > > -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>> > > -					   struct sk_buff *skb,
>> > > -					   struct msghdr *msg,
>> > > -					   size_t pkt_len,
>> > > -					   bool zerocopy)
>> > > -{
>> > > -	struct ubuf_info *uarg;
>> > > -
>> > > -	if (msg->msg_ubuf) {
>> > > -		uarg = msg->msg_ubuf;
>> > > -		net_zcopy_get(uarg);
>> > > -	} else {
>> > > -		struct ubuf_info_msgzc *uarg_zc;
>> > > -
>> > > -		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> > > -					    pkt_len, NULL, false);
>> > > -		if (!uarg)
>> > > -			return -1;
>> > > -
>> > > -		uarg_zc = uarg_to_msgzc(uarg);
>> > > -		uarg_zc->zerocopy = zerocopy ? 1 : 0;
>> > > -	}
>> > > -
>> > > -	skb_zcopy_init(skb, uarg);
>> > > -
>> > > -	return 0;
>> > > -}
>> > > -
>> > >  static int virtio_transport_fill_skb(struct sk_buff *skb,
>> > >  				     struct virtio_vsock_pkt_info *info,
>> > >  				     size_t len,
>> > > @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> > >  	u32 src_cid, src_port, dst_cid, dst_port;
>> > >  	const struct virtio_transport *t_ops;
>> > >  	struct virtio_vsock_sock *vvs;
>> > > +	struct ubuf_info *uarg = NULL;
>> > >  	u32 pkt_len = info->pkt_len;
>> > >  	bool can_zcopy = false;
>> > > +	bool have_uref = false;
>> > >  	u32 rest_len;
>> > >  	int ret;
>> > >
>> > > @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> > >  		if (can_zcopy)
>> > >  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>> > >  					    (MAX_SKB_FRAGS * PAGE_SIZE));
>> > > +
>> > > +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
>> > > +		    info->op == VIRTIO_VSOCK_OP_RW) {
>> > > +			uarg = info->msg->msg_ubuf;
>> > > +
>> > > +			if (!uarg) {
>> > > +				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> > > +							    pkt_len, NULL, false);
>> > > +				if (!uarg) {
>> > > +					virtio_transport_put_credit(vvs, pkt_len);
>> > > +					return -ENOMEM;
>> > > +				}
>> > > +
>> > > +				if (!can_zcopy)
>> > > +					uarg_to_msgzc(uarg)->zerocopy = 0;
>> > > +
>> > > +				have_uref = true;
>> > > +			}
>> > > +		}
>> >
>> > Surely that block should only be done if can_zcopy is true?
>> > And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
>> > If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.
>> >
>> > It info->msg->msg_buf is already set then I think you have to disable zero-copy.
>> > The caller has already requested a callback - and you can't add another.
>> >
>> > In any case by the end of this can_zcopy and have_uref are really the same flag.
>>
>> I kept the same approach we had before, trying to make as few changes as
>> possible.
>>
>> All these potential issues seem to be pre-existing and should be eventually
>> addressed in other patches IMHO. This patch one only resolves the main issue
>> of calling `skb_zcopy_set()` for every skb to avoid leaking pages, etc.
>
>the patch is upstream now, right? So pretty much have to be patches on
>top.

If those are actual issues, then yes. TBH, I didn’t look into that 
aspect and left it as it was before. We should take a closer look at how 
MSG_ZEROCOPY is handled.

David, if you think it needs fixing and you have time, feel free to send 
patches on top.

Thanks,
Stefano

>
>> @Arseniy can you help on this?
>>
>> >
>> > >  	}
>> > >
>> > >  	rest_len = pkt_len;
>> > > @@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> > >  			break;
>> > >  		}
>> > >
>> > > -		/* We process buffer part by part, allocating skb on
>> > > -		 * each iteration. If this is last skb for this buffer
>> > > -		 * and MSG_ZEROCOPY mode is in use - we must allocate
>> > > -		 * completion for the current syscall.
>> > > -		 *
>> > > -		 * Pass pkt_len because msg iter is already consumed
>> > > -		 * by virtio_transport_fill_skb(), so iter->count
>> > > -		 * can not be used for RLIMIT_MEMLOCK pinned-pages
>> > > -		 * accounting done by msg_zerocopy_realloc().
>> > > -		 */
>> > > -		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
>> > > -		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
>> > > -			if (virtio_transport_init_zcopy_skb(vsk, skb,
>> > > -							    info->msg,
>> > > -							    pkt_len,
>> > > -							    can_zcopy)) {
>> > > -				kfree_skb(skb);
>> > > -				ret = -ENOMEM;
>> > > -				break;
>> > > -			}
>> > > -		}
>> > > +		skb_zcopy_set(skb, uarg, NULL);
>> > >
>> > >  		virtio_transport_inc_tx_pkt(vvs, skb);
>> > >
>> > > @@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> > >
>> > >  	virtio_transport_put_credit(vvs, rest_len);
>> > >
>> > > +	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
>> > > +	 * skb_zcopy_set() increases it for each skb, so we can drop that
>> >                                                            ^ must
>> >
>> > > +	 * initial reference to keep it balanced.
>> > > +	 */
>> > > +	if (have_uref) {
>> > > +		if (rest_len == pkt_len)
>> > > +			/* No data sent, abort the notification. */
>> > > +			net_zcopy_put_abort(uarg, true);
>> >
>> > Is it worth optimising for the 'nothing sent' case ?
>>
>> What do you suggest doing?
>>
>> I followed what TCP does.
>>
>> Thanks,
>> Stefano
>>
>> >
>> > -- David
>> >
>> > > +		else
>> > > +			net_zcopy_put(uarg);
>> > > +	}
>> > > +
>> > >  	/* Return number of bytes, if any data has been sent. */
>> > >  	if (rest_len != pkt_len)
>> > >  		ret = pkt_len - rest_len;
>> >
>

