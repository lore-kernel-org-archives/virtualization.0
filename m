Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7648C8BD
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999050; cv=none; b=hoFIalFucK1VUtic8cLh2z9U2KNEUjH51kCkbQjOPFZ0sbV4nooP5ooP6sJ4QPkP3AR0uxIkNzDcw/IWO2mYM9phtdijTN3QZ3tTVSz1HGTtci0SaQDMxoIE8+pPtYfzEuX3VrhlkaFzABjjZXf369BqEhsdz7oNe+LWbO/alec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999050; c=relaxed/simple;
	bh=2vNM4P2xnGuAG3lTftkwlu0d8ky0Pc81tFLomdyLZA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHg22ovZu2qnaI1TYFWDiZJtEr15nrxw9nceRZ/rKC4cIeUMb/Lx+vBCFuL17xo4HCcvlpTds5/tFR9m4QZrib/w7nLjxJkQ8p+8oLK5alUNZW/o8dmHajsk2A9e7IlWml6nAsWlaEDZqasKgsVoqRysBoSX7MUYiXXPt7cd9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBIKWU2S; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBIKWU2S"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79827d28fc4so48782837b3.1
        for <virtualization@lists.linux.dev>; Tue, 05 May 2026 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777999047; x=1778603847; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PMfEZkH6rxvYX9869GT2iOu8sbvJpC6I3W7itO6JEjI=;
        b=TBIKWU2SNxYDlW/8suJoHP/MoMDPm6q9eCGw78bovdZe/Ty9vOK33khD9Wo43fFeMl
         f7RmTIid6bsUEycj/amqs/zJEskNNfp1snoJ6atvqlL43WxeKNOerw725jisQgpEjVrs
         07MuhpMAqytEpnR4USqZC6X/F6yVr7nXB/jkoes6tBCLN7DoT58foWeQalQvYnqo/kgj
         zA3Tainu7XqWRp/LLsMmj39h8xi9RtIzkoIkU03tjkuge5iebphkciQBfd4Ia4hpxJKJ
         K2dndFJVf5rA8wM4DglBJ3ecBa4hiHfpI2vgO4pP7/ODBioXSxFCotrfdDIaY+H7SbmA
         NsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999047; x=1778603847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMfEZkH6rxvYX9869GT2iOu8sbvJpC6I3W7itO6JEjI=;
        b=WP1GUyvcuzmyz/wMw/aI3+7AR39j/6ZHOiEE+Td3K+mE10PA86a9myl1QoaXOEIaNE
         BVGZJFQEbbrHp6e20n7V6yKhkwiCTJbAEgZ01h5kl3c0bGj3+Ibi2KOhgqu+STq9s6+X
         mJvlYZ3ceU9HKACWdvoVMGUt/CKhFNhLVGsoGEqxcj6MqrSpFDsyWJ3CObwC8qHkRIwt
         mL3uD8cxLAcMADNO8yBKsvlNNNApdG1/JLCmXcOzekewp9bTP4wkB412onhz6B+3AZ0M
         91whOFXINZEASNl6sLY7IDQPBtalSZpj5OwS2t0mn6stqztYpHUPmToWvMVN159r6CnG
         MWIA==
X-Forwarded-Encrypted: i=1; AFNElJ+KUe1XJYSaQjM/ZRMNebPUnlVw4BjLEwFz3bs/dVjyZmnshExTQYaWqjGFUdE9VG9Fa+v4Cbyy/KwU3gjGTA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz19lyWjzSvVvy26CEYH2Yx5m6l4Kuysk07vOinbk5BZKuHAUyQ
	VOd+bMBFI+z98AQILrXcN2fMehRLZ5LXVoqESnuOeX4L6JHlqPIpYVtB
X-Gm-Gg: AeBDieuLD0wYXGOTyoEkeeq+JnK1hBtOJ8DX/6NpJsTqlQtfNynhg9A1GDF6RIHVXvV
	gZpC/eK0+v4DR9RVRV9KZtn8p4UyKCtingCFBRqTllet7AjkNgGqlYHi874OuIV1OeeQHan1N14
	IrLtv4flzc1LRxOkTgH7t2gcr2Ml7nXcHOaX2wCOHR/jM8S9FA6beaKSwnsuidqq477PUMYER7W
	6orpjwhv8Vs8u2rW8SjGNJvRn1oNxlI7pFen2vCQZ9IQUs1+10UVhYvUs+AFn9Fn88k1chNwc6E
	bemGenh8efWPcvpBy0P4K+6vgUUHyuk7FiP77rCPS9CVhrUa9AlqfeHXSr6FCq7U2GV9Y2QzIBu
	Yg0Vyp0M0KpRTLcgC3C52ONG13DzFQ+VZBgxLkN/4Q5AvhQesIBnseUSUChX9EOy5PSzr9xbO8g
	X3mM6yIh+kwINigipwFYDGajc2mbCMMf4dRE8Z/a29zXV4KtKE6idsR78=
X-Received: by 2002:a05:690c:a018:b0:7b3:6c50:2e8f with SMTP id 00721157ae682-7bd77109d77mr140515237b3.41.1777999047308;
        Tue, 05 May 2026 09:37:27 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66525651sm66719897b3.3.2026.05.05.09.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:37:26 -0700 (PDT)
Date: Tue, 5 May 2026 09:37:22 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afocwkfBHJ5u10rx@devvm29614.prn0.facebook.com>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afoF_cHfl6ygcupM@sgarzare-redhat>

On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
> On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > 
> > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
> > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> > > >
> > > >virtio_transport_recv_enqueue() skips coalescing for packets
> > > >with VIRTIO_VSOCK_SEQ_EOM.
> > > >
> > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> > > >a very large number of packets can be queued
> > > >because vvs->rx_bytes stays at 0.
> > > >
> > > >Fix this by estimating the skb metadata size:
> > > >
> > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
> > > >
> > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > >Cc: Jason Wang <jasowang@redhat.com>
> > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
> > > >Cc: kvm@vger.kernel.org
> > > >Cc: virtualization@lists.linux.dev
> > > >---
> > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
> > > >--- a/net/vmw_vsock/virtio_transport_common.c
> > > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > > >                                       u32 len)
> > > > {
> > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
> > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > >+
> > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> > > >               return false;
> > > 
> > > I'm not sure about this fix, I mean that maybe this is incomplete.
> > > In virtio-vsock, there is a credit mechanism between the two peers:
> > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
> > > 
> > > This takes only the payload into account, so it’s true that this problem
> > > exists; however, perhaps we should also inform the other peer of a lower
> > > credit balance, otherwise the other peer will believe it has much more
> > > credit than it actually does, send a large payload, and then the packet
> > > will be discarded and the data lost (there are no retransmissions,
> > > etc.).
> > 
> > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
> > state to account credit")
> > and find a better fix then?
> 
> IIRC the same issue was there before the commit fixed by that one (commit
> 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
> not sure about reverting it TBH.
> 
> CCing Arseniy and Bobby.
> 
> > 
> > There is always a discrepancy between skb->len and skb->truesize.
> > You will not be able to announce a 1MB window, and accept one milliion
> > skb of 1-byte each.
> > 
> > This kind of contract is broken.
> > 
> 
> Yep, I agree, but before we start discarding data (and losing it), IMHO we
> should at least inform the other peer that we're out of space.
> 
> @Stefan, @Michael, do you think we can do something in the spec to avoid
> this issue and in some way take into account also the metadata in the
> credit. I mean to avoid the 1-byte packets flooding.
> 
> Thanks,
> Stefano
> 
> 

Indeed the old pre-fix skb code would have the same issue.

I can't think of any way around this without extending the spec.

Best,
Bobby
