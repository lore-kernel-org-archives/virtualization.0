Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D073EC2E3
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154320; cv=none; b=MKFDRWI7GV2MjFU8JL9m4IYQOcy3njoB6qR2THcEw5UBX89yfA2aomiUqXIUBrHN83+xhD1rGw/IOn+a5Fjlp9hJjCxwuCnoDG2lE/m1y8lp2CTldq31koZ5XCnJ8NgOHyUFJLmfAciPauS5lQt4ENGQcb5PhNpJNoKXwf2v5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154320; c=relaxed/simple;
	bh=lvuRrcMHuxAF9URp6OhLBiPGZ+f4f+w8cDaxKKzlWH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=e96mC62SvMAhb2eVAtpnsm1KBJHgMHdWS0o24xYPJO7Uo6wdpKlJJFZqzurRrlyQ9M1vZddk3Mk+sjJvKnP+5bChwKYQngULjxmTmwFGpgBuN1gflexDIh+in9vfvyeM8BCh81V0P6N2IUWGpVmavcYAilYxqw1YEQODWQEzKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZQx4yV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZQx4yV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778154317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XB8uKgfriwIOrN1HH+uQzFZrRsNz6/XjSTKr5IkjkA=;
	b=FZQx4yV136ErWXBMphVuMnmmz2E0L1GV/EMfDriYtktNq/ZCWwk1tLb44tsglO9X7Csbce
	rJgnq87MQ4fZj/huVKpRJkdxHOCGH5doyVPU3Gw06SBNhBaCBfohW2cD2IF76V+dXxz+2W
	4hDAyiZwjshMTbejf1RBMO+wEMFM6RI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-8HBZfjAANl2Mtiox8vvpWA-1; Thu, 07 May 2026 07:45:16 -0400
X-MC-Unique: 8HBZfjAANl2Mtiox8vvpWA-1
X-Mimecast-MFC-AGG-ID: 8HBZfjAANl2Mtiox8vvpWA_1778154315
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44696b11265so833978f8f.0
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 04:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778154315; x=1778759115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XB8uKgfriwIOrN1HH+uQzFZrRsNz6/XjSTKr5IkjkA=;
        b=a9EnEjjLX+j7rrun2Cn3AvSzYMaZeWwTAt8fiwtj6G+qa4QBVWZpJo/Y8URNOYsLfV
         +4cE8vr0ubs2ITWL7C/fjP3qbadAMmPSAa3DbvpajTCp3ooB7U5MnDG5xeEWF6OjI5he
         Jb7EqCIqyRdLffxjgSubXMZJs1xAwXbEsDIMObkz8ybGwgu/bBnVnj3PsJwoDlWPw02Y
         DxaYUG5FhmtkrhF/4n/0oQEJLlu7vizh+Vl6OZQQ5+VERYzn4P2vxgeoCKIV6AxFGadH
         bs45G3Wx6/+RxIqUIcOI8TjtYcI8rt9YaE9xpFxnu68u25/ri0Q8O6/808Yeqy1m60np
         qaxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9M2csdA8VLwAXfNaYBkTBF7HYNP6TXekfWPuXzRnxeSNxMPP7fd+dmnqMLzhmLxGNb4ByhEt84si7hCGnCIw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxw+UYARfsrh3UEb9fbCOTf7KzagtuxFjzs1+lNc3BPXjetzygd
	XZRiFCR6rR7NVOUwpseGlRoreOwdBBr1SVMhGAIzkCyXgGasq4/byyw2YLZLxb14kdwRhKm7BIA
	PvxPvvMe2Uytt8QutpHmSJ0BKSz4w3TEkUMGsBc4IO38K1e4rUKdnfLBOyUGo/o7tQa30
X-Gm-Gg: AeBDiesd5k2nU9dYhzI+tccD97VqZrn6zoH2Ah7o6MkRV6DNIHr4MAIyTGf9KANQZFJ
	kksqFilFQto+wdGyx4hTPweXXcWWon4fDnmbgqp/tCQHa+2YjsxPTgpwBIEBbWN1kykIs08wvYp
	1nnZ4fY9MWCt75JAhgqGKPQcY3qWxQvYsKKYGEi930iMQ4W28yZu6/Su1vWWkUYsZoZLHdp29Va
	8zJLE+UL8bdYJPS3NBp7E+rhFh2qhL66aVWopauk2czoReMgUnY5wayayDDpMwsxIOBLOg/8Sos
	QVdIH8DSjEIoyzABMfo42iQZ7oiazf5lmtWQdrk11yR3M31Fobq4zr2sb+11dZcYcUrBpyOAGsi
	eupJX8xyxOK+L06hgImWe/W2U9qxxb/EkK7M4j9zceLak7e6k7qY=
X-Received: by 2002:a05:6000:200b:b0:43d:7b85:6c95 with SMTP id ffacd0b85a97d-4515d5c567emr12448714f8f.33.1778154315104;
        Thu, 07 May 2026 04:45:15 -0700 (PDT)
X-Received: by 2002:a05:6000:200b:b0:43d:7b85:6c95 with SMTP id ffacd0b85a97d-4515d5c567emr12448641f8f.33.1778154314419;
        Thu, 07 May 2026 04:45:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960fd6sm20870119f8f.31.2026.05.07.04.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 04:45:13 -0700 (PDT)
Date: Thu, 7 May 2026 07:45:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260507074113-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <afxVH2So9BbZ3Gta@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2oP7XFGgovK-n8A6Up5Je1Sz-wN7MmKQKeEBIeqq2dI_1778154315
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
> On Wed, May 06, 2026 at 11:37:45AM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
> > > On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > > > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > > >
> > > > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
> > > > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> > > > > >
> > > > > >virtio_transport_recv_enqueue() skips coalescing for packets
> > > > > >with VIRTIO_VSOCK_SEQ_EOM.
> > > > > >
> > > > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> > > > > >a very large number of packets can be queued
> > > > > >because vvs->rx_bytes stays at 0.
> > > > > >
> > > > > >Fix this by estimating the skb metadata size:
> > > > > >
> > > > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
> > > > > >
> > > > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> > > > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > > > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > >Cc: Jason Wang <jasowang@redhat.com>
> > > > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
> > > > > >Cc: kvm@vger.kernel.org
> > > > > >Cc: virtualization@lists.linux.dev
> > > > > >---
> > > > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > > > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >
> > > > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
> > > > > >--- a/net/vmw_vsock/virtio_transport_common.c
> > > > > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > > > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > > > > >                                       u32 len)
> > > > > > {
> > > > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
> > > > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > > > >+
> > > > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> > > > > >               return false;
> > > > >
> > > > > I'm not sure about this fix, I mean that maybe this is incomplete.
> > > > > In virtio-vsock, there is a credit mechanism between the two peers:
> > > > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
> > > > >
> > > > > This takes only the payload into account, so it’s true that this problem
> > > > > exists; however, perhaps we should also inform the other peer of a lower
> > > > > credit balance, otherwise the other peer will believe it has much more
> > > > > credit than it actually does, send a large payload, and then the packet
> > > > > will be discarded and the data lost (there are no retransmissions,
> > > > > etc.).
> > > >
> > > > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
> > > > state to account credit")
> > > > and find a better fix then?
> > > 
> > > IIRC the same issue was there before the commit fixed by that one (commit
> > > 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
> > > not sure about reverting it TBH.
> > > 
> > > CCing Arseniy and Bobby.
> > > 
> > > >
> > > > There is always a discrepancy between skb->len and skb->truesize.
> > > > You will not be able to announce a 1MB window, and accept one milliion
> > > > skb of 1-byte each.
> > > >
> > > > This kind of contract is broken.
> > > >
> > > 
> > > Yep, I agree, but before we start discarding data (and losing it), IMHO we
> > > should at least inform the other peer that we're out of space.
> > > 
> > > @Stefan, @Michael, do you think we can do something in the spec to avoid
> > > this issue and in some way take into account also the metadata in the
> > > credit. I mean to avoid the 1-byte packets flooding.
> > > 
> > > Thanks,
> > > Stefano
> > 
> > Why do we need the metadata? Just don't keep it around if you begin
> > running low on memory.
> 
> I don't think removing the skuffs will be easy; we added them for ebpf,
> zero-copy, and seqpacket as well.

You do not need to remove them completely.

> For now, we're already doing something:
> merging the skuffs if they don't have EOM set.


Right that's good. You could go further and merge with EOM too
if you stick the info about message boundaries somewhere else.

> As a quick fix, I'm thinking of reducing the `buf_alloc` value to account
> for the overhead and notifying the other peer, at least until we find a
> better solution.
> 
> Stefano

well if you want to support pathological cases such as 1 byte messages
that would mean like 100x reduction no?

