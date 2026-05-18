Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD13EE1DB
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102546; cv=none; b=OKKcwQJpAWuT5VZoeVGKX13Aq/WgkGHCPQgJbynRY302ASG2Q1/BhA6ukEZ6ltCO4ry5kO9iMPG5C5fm7JO42eOQ1KFwcJO+xlRz23Bx57oOwLqJOuc7t2F9aBCV3edYxzyCyHzUc1GdXzraAPZrb2ZZyVeNfbwtwJF+aSxwF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102546; c=relaxed/simple;
	bh=y3lQJ8hKleP3cpjvWx4c1dbbB/MQsDLBh2c1U+YqGYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rE0OTe2ziOK/GRYnide/JGPN37ilfxi449NDY6Acc/wIL9tMiFKg5sQODUHTdhbfb9TbdxFQAhBLQVk95DpSvpuXMxr0cL3Vyrf2vMMgMVNNechAJp2gNt9ZLt6OHuWTlkcwnmZMkxfMtYMze8p+ZRuzjEazJx6KpGqR/np3LZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZB7LmtOX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZB7LmtOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779102543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EdVqpBql5Gqkrx4EFtfutWcr864h1ZHzOOzFvQJojI=;
	b=ZB7LmtOXxiEzpCnJdESn/DFQv+yPvBlUA11DzA61/n5HhboBOxLg+fWDuJzXklAsQRRmZH
	J09t5CD8TE8m99fGR8tyNuxzvbmkrhU2rbhU4EPoYE9rjnZjFtsuhoqvmngo9icU/LmJBa
	/v8+CbZBUuyzntkbxmfvhDJmkqHCO58=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-CDZJUrT0Mi-P-Go4sf1wzw-1; Mon, 18 May 2026 07:09:00 -0400
X-MC-Unique: CDZJUrT0Mi-P-Go4sf1wzw-1
X-Mimecast-MFC-AGG-ID: CDZJUrT0Mi-P-Go4sf1wzw_1779102539
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fdca5c638so19824005e9.1
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 04:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779102539; x=1779707339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EdVqpBql5Gqkrx4EFtfutWcr864h1ZHzOOzFvQJojI=;
        b=S9IrYYZRbFyyrVf2tXRVEyK0CAWR7eAX254OubdKgbcAFQjL/LgrBS4Q/CaH6WfTcr
         8NlQ24r7lbeM2mIaKDUE5Uwth29tAaXzOhLdFHTkrxLs0FT8R+fIJ7qfkWue/5Yv7Ymv
         QFyXurJvWNVmNrJm/c7U4s1FFAp3PzmkGg+u4c76xTrPcqD8SbfwwHkpY8tHqXxPduPo
         wHD5BHUfZF6O6l5aMdTSF/JJB0sztvVy1k4M95wdTfTFV70jbJcV/y6YefYeVwUAAvMp
         sXm5CT+UfF0Q/bP+OMi12hBKJ7lDOTHP+NRWSQ3JbowfqAOHU5qF6japNM1IWEjuKk7o
         Je0g==
X-Forwarded-Encrypted: i=1; AFNElJ+O5hWyrWDWBzPd1/rbfnkCOFVoW03UwsX+fZ2Vo5VvG4KU/gOMUkR0zDlObir9AAJGraz02QAlLvAuuNoHMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YznNzGerkZFqSfucVbPNhdl7yuKKRuhhcRuzzroTw+0Gf3ZsL5u
	D9tGI+Hc+lYp9wHGXDJTvhz0ezibf8QjysKpyxi4rfOGoerTFeo0xwBBDdQDEHOwtA+qKlMqemZ
	6SvmdPp6Lza/LD9qfphIWitI6gPu9/72c8YxHutH1FGB85Dik15/tsI4jcfXa5PDlzRtt
X-Gm-Gg: Acq92OEO0TGh1J5l0O2NEJS7Mj2NpB0dXsiK2xBWVmPZOWKRoeAv/kf34DHjDIUC0sP
	8KnZRINgoz+vt2HCAP7r6hl6QUKRtXTPHh+ZPGek7cTwUuNz+iFLG14sv498ZShW6LKAYujQZcL
	b2u0ABgFFoElcgPRjuZwYcwnoaxEzkv9JXu525KWmyNSRG8607qWBF0AIRVPZzOOlqv7yyf3D2n
	0W7vWYwBma0dzKY9bfA6Bjof4jKte+f5/pbcXy42qBd7GdSiLqfVcbMnKaKk1RZzARMC6Ktf1Jp
	BqwquinihnApevZK8MZQh2xTkblZWaJ/3F4+lPronzKIfFUtxuyr4GbQvOArYN8LzTe2XZe6Mtf
	mesOlCPh2PzadNU6o4XwkB/h4bNFeyb6f9MbnJ10wkc2bPKsh+xRDo2j1vuHNHzSXQaq3oWhyKQ
	==
X-Received: by 2002:a05:600c:848c:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-48fe60e54cbmr219184915e9.1.1779102538873;
        Mon, 18 May 2026 04:08:58 -0700 (PDT)
X-Received: by 2002:a05:600c:848c:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-48fe60e54cbmr219184145e9.1.1779102538164;
        Mon, 18 May 2026 04:08:58 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feb029180sm117425235e9.4.2026.05.18.04.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:08:57 -0700 (PDT)
Date: Mon, 18 May 2026 13:08:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <agrxFFkyvyB-kbvr@sgarzare-redhat>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin>
 <agrXvCtNRlySlwgx@sgarzare-redhat>
 <20260518053223-mutt-send-email-mst@kernel.org>
 <agrg1GVzoJWtNuSd@sgarzare-redhat>
 <20260518115005.5f13bd2b@pumpkin>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260518115005.5f13bd2b@pumpkin>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HQp8Kt_AKy1hJWIYvq-HuKxp9MYanSfV_9hHaWzw-Jc_1779102539
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, May 18, 2026 at 11:50:05AM +0100, David Laight wrote:
>On Mon, 18 May 2026 11:54:19 +0200
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> On Mon, May 18, 2026 at 05:33:08AM -0400, Michael S. Tsirkin wrote:
>> >On Mon, May 18, 2026 at 11:18:24AM +0200, Stefano Garzarella wrote:
>> >> On Sat, May 16, 2026 at 12:53:29PM +0100, David Laight wrote:
>> >> > On Thu, 14 May 2026 11:29:48 +0200
>> >> > Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >> >
>> >> > > From: Stefano Garzarella <sgarzare@redhat.com>
>> >> > >
>> >> > > When a large message is fragmented into multiple skbs, the zerocopy
>> >> > > uarg is only allocated and attached to the last skb in the loop.
>> >> > > Non-final skbs carry pinned user pages with no completion tracking,
>> >> > > so the kernel has no way to notify userspace when those pages are safe
>> >> > > to reuse. If the loop breaks early the uarg is never allocated at all,
>> >> > > leaking pinned pages with no completion notification.
>> >> > >
>> >> > > Fix this by following the approach used by TCP: allocate the zerocopy
>> >> > > uarg (if not provided by the caller) before the send loop and attach
>> >> > > it to every skb via skb_zcopy_set(), which takes a reference per skb.
>> >> > > Each skb's completion properly decrements the refcount, and the
>> >> > > notification only fires after the last skb is freed.
>> >> > > On failure, if no data was sent, the uarg is cleanly aborted via
>> >> > > net_zcopy_put_abort().
>> >> > >
>> >> > > This issue was initially discovered by sashiko while reviewing commit
>> >> > > 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
>> >> > > but was pre-existing.
>> >> > >
>> >> > > Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>> >> > > Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> >> > > Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
>> >> > > Reported-by: Maher Azzouzi <maherazz04@gmail.com>
>> >> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> > > ---
>> >> > >  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
>> >> > >  1 file changed, 34 insertions(+), 49 deletions(-)
>> >> > >
>> >> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >> > > index 989cc252d3d3..1e3409d28164 100644
>> >> > > --- a/net/vmw_vsock/virtio_transport_common.c
>> >> > > +++ b/net/vmw_vsock/virtio_transport_common.c
>> >> > > @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>> >> > >  	return true;
>> >> > >  }
>> >> > >
>> >> > > -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>> >> > > -					   struct sk_buff *skb,
>> >> > > -					   struct msghdr *msg,
>> >> > > -					   size_t pkt_len,
>> >> > > -					   bool zerocopy)
>> >> > > -{
>> >> > > -	struct ubuf_info *uarg;
>> >> > > -
>> >> > > -	if (msg->msg_ubuf) {
>> >> > > -		uarg = msg->msg_ubuf;
>> >> > > -		net_zcopy_get(uarg);
>> >> > > -	} else {
>> >> > > -		struct ubuf_info_msgzc *uarg_zc;
>> >> > > -
>> >> > > -		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> >> > > -					    pkt_len, NULL, false);
>> >> > > -		if (!uarg)
>> >> > > -			return -1;
>> >> > > -
>> >> > > -		uarg_zc = uarg_to_msgzc(uarg);
>> >> > > -		uarg_zc->zerocopy = zerocopy ? 1 : 0;
>> >> > > -	}
>> >> > > -
>> >> > > -	skb_zcopy_init(skb, uarg);
>> >> > > -
>> >> > > -	return 0;
>> >> > > -}
>> >> > > -
>> >> > >  static int virtio_transport_fill_skb(struct sk_buff *skb,
>> >> > >  				     struct virtio_vsock_pkt_info *info,
>> >> > >  				     size_t len,
>> >> > > @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> >> > >  	u32 src_cid, src_port, dst_cid, dst_port;
>> >> > >  	const struct virtio_transport *t_ops;
>> >> > >  	struct virtio_vsock_sock *vvs;
>> >> > > +	struct ubuf_info *uarg = NULL;
>> >> > >  	u32 pkt_len = info->pkt_len;
>> >> > >  	bool can_zcopy = false;
>> >> > > +	bool have_uref = false;
>> >> > >  	u32 rest_len;
>> >> > >  	int ret;
>> >> > >
>> >> > > @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> >> > >  		if (can_zcopy)
>> >> > >  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>> >> > >  					    (MAX_SKB_FRAGS * PAGE_SIZE));
>> >> > > +
>> >> > > +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
>> >> > > +		    info->op == VIRTIO_VSOCK_OP_RW) {
>> >> > > +			uarg = info->msg->msg_ubuf;
>> >> > > +
>> >> > > +			if (!uarg) {
>> >> > > +				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> >> > > +							    pkt_len, NULL, false);
>> >> > > +				if (!uarg) {
>> >> > > +					virtio_transport_put_credit(vvs, pkt_len);
>> >> > > +					return -ENOMEM;
>> >> > > +				}
>> >> > > +
>> >> > > +				if (!can_zcopy)
>> >> > > +					uarg_to_msgzc(uarg)->zerocopy = 0;
>> >> > > +
>> >> > > +				have_uref = true;
>> >> > > +			}
>> >> > > +		}
>> >> >
>> >> > Surely that block should only be done if can_zcopy is true?
>> >> > And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
>> >> > If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.
>> >> >
>> >> > It info->msg->msg_buf is already set then I think you have to disable zero-copy.
>> >> > The caller has already requested a callback - and you can't add another.
>> >> >
>> >> > In any case by the end of this can_zcopy and have_uref are really the same flag.
>> >>
>> >> I kept the same approach we had before, trying to make as few changes as
>> >> possible.
>> >>
>> >> All these potential issues seem to be pre-existing and should be eventually
>> >> addressed in other patches IMHO. This patch one only resolves the main issue
>> >> of calling `skb_zcopy_set()` for every skb to avoid leaking pages, etc.
>> >
>> >the patch is upstream now, right? So pretty much have to be patches on
>> >top.
>>
>> If those are actual issues, then yes. TBH, I didn’t look into that
>> aspect and left it as it was before. We should take a closer look at how
>> MSG_ZEROCOPY is handled.
>>
>> David, if you think it needs fixing and you have time, feel free to send
>> patches on top.
>
>I'm not fully sure how it all works.

Same here, so I pinged Arseniy who worked on that, since it seemed 
deliberate to have `can_zcopy` (and set `uarg->zerocopy` accordingly) 
only when it was supported by the transport.

>Especially the paths where msg->msg_ubuf is non-NULL, I suspect it should
>be added to all the skb even if the ZEROCOPY flag isn't set.
>I was just reading the one function.
>But there did look like some very dodgy conditionals.

I see, let's wait for Arseniy's feedback; otherwise, I'll try to fix it 
next week. As mentioned, this issue existed before this patch, so it 
shouldn't be a regression.

Thanks,
Stefano

