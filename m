Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A437F00F
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165568; cv=none; b=C9LNprvRjZP3Z0F+cgnmvpoDRCiMrvTpZqBvFg0mRWJ0igNtfBJ3vYrxZfx3Ti0aJG65pR+X7B+JHzfZYNQDSLE2UcaFBIGOsV43Olc6QnPJ5VxBLAUipTPd0i7lJoEPfiZKrh/hdMPvrL36ZHfAbJmCPJ8x4MTQPu/RM/3tIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165568; c=relaxed/simple;
	bh=ecrl1iYp1xnobO4BxmeiQm41yhEPr+oCWaARqAkOs0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hi+Lb5vR6evm239vFrTaOOIx5wiMn5JyGoSlzyua9aMy5YxMb6sdMP/Ho5b5+1QBdObHQRayAEa2/PCmmCLbHvTKEzfVNwn0cvWklK/7RP07N97ugpwPQVLUS1oGKXLwCAD0iQ1Xj3X9mZgiIsjVo1m338Nkp7JOOm6M3e5obII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOnt3OXQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOnt3OXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778165565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y78B/0dJ3VS7H6g0/jf9q/rfkjPnyDot3aaQ8HfMN5Y=;
	b=FOnt3OXQcbX5pUMO0TfB4NCPzlscJKq+v1izF1GJlENpUEWBwfRjA+RZuH7u9TWiXcaDwL
	qA6yZm9HlEGEILQaX0ftw/czjLAfQ6lGKrPzzauneq3AB+iTtUZlm9teO/NVqL9uWLUN1F
	DLkXegBXvbpWYQyZZmVclVP5m2Rj/k0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-rz_NkTv3N6mZi9N-rlU5pA-1; Thu, 07 May 2026 10:52:43 -0400
X-MC-Unique: rz_NkTv3N6mZi9N-rlU5pA-1
X-Mimecast-MFC-AGG-ID: rz_NkTv3N6mZi9N-rlU5pA_1778165563
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ba661b6c550so93437366b.0
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 07:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778165562; x=1778770362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y78B/0dJ3VS7H6g0/jf9q/rfkjPnyDot3aaQ8HfMN5Y=;
        b=dTy766/BFeL2B2YWZxdHhTbxn6s2hn8UcYxzi/rJR1HP9VkwsdiHJG/y0gA/V89CoH
         Hhde44Cu1XZqJ33CAtItI8qarwvqEVbLGXD4UWUfRc0VHLPE2TjI6IZbtBHHKYh8p1jV
         yKkfRw5rLjyCd64MKUGeMEPp7JvKjVvh1BIr01b7+eavo4izBJMX2zMuxtXeDoJOqQYn
         nkOTIZLlHxMi6GGeTHVC77p6ASSjNBcBv8aiJVe+MDvu2AuqPSR1lGrxIv1Ikh1sT31c
         Z+Jw0/z4RyA5WN7zUlI2eh7esvhbtfB06gZd+YHm7LWtzj9kdbxZdXqV1ahgjf0+5m7Q
         PtCw==
X-Forwarded-Encrypted: i=1; AFNElJ8fp9EEXWTvUvY0VIYiwL0pxLmyGWNGWWlNLK1OkE4aG1PUAhakJmk6Fsx9wkQzBb4odBZTqZ2/E3Mxn9OE1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/FauXlraFUeKWdamRI/vCKPOX26ZPSDkdmvrEku6lHP7QBEXf
	Z/RrdkvmL2PG7MVNJdhBjw4xBnKaYfLP4xIkHvrwi08J32ugDsjGn5spMJx+WLYYzVgnQxy8NE8
	80aR5YgFUJZMakU/GOJ6JgMcOPnKi5crRNUgN0Y3qr+f9bIEe7lIHCm+3kZMjFfEb8OoO
X-Gm-Gg: AeBDiesRzrXQTd7adsBvLscvevfXmxjQcHU31otOuCSCYxz8loEVG9SuBwiLpVQND3N
	wnbAj3nTrblUZUxKr8u1+bVFMFs+jFADN6ihNvejYOTVdVIbEjGVo6dTHmjOOLwN1uH8Yi0OdU3
	JQorC/FGQHFflp950L/8nu6VKypeuwKrEphMBwxyJOBsNu2CHk/o/+tMlRI5DQ39NwArjnVC6ju
	MvJ4gl5aw99ghEzP33shKi2OUGko0J6xXWVYESfhoBmRNv172Sg/2TXuM65vHxJVhxe0Wo9TDQ9
	zR/2/NZ4HcpazgZMYjNX986VM+SI3c5hefg1Yti2MM+Wf/sYrprz6eFyMZCL1NYF6eWfrfu/biH
	CEL13Jw+qg8TEcvJbzAP1K4D0h2Tymlhd/meG6e+Fw0ClkrtE++c=
X-Received: by 2002:a17:907:e152:b0:bc9:e1b1:8edf with SMTP id a640c23a62f3a-bc9e1b192e3mr84389166b.12.1778165562153;
        Thu, 07 May 2026 07:52:42 -0700 (PDT)
X-Received: by 2002:a17:907:e152:b0:bc9:e1b1:8edf with SMTP id a640c23a62f3a-bc9e1b192e3mr84386266b.12.1778165561383;
        Thu, 07 May 2026 07:52:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc81cd34ce8sm90853066b.9.2026.05.07.07.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:52:40 -0700 (PDT)
Date: Thu, 7 May 2026 10:52:37 -0400
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
Message-ID: <20260507104701-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <afyMCyBvZpzWrLtO@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _lmiCehbweZwTHX-SbUhKO-ji-wH0XuSUXWlXoWAlyo_1778165563
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, May 07, 2026 at 02:59:13PM +0200, Stefano Garzarella wrote:
> On Thu, May 07, 2026 at 07:45:10AM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
> > > On Wed, May 06, 2026 at 11:37:45AM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
> > > > > On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > > > > > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
> > > > > > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> > > > > > > >
> > > > > > > >virtio_transport_recv_enqueue() skips coalescing for packets
> > > > > > > >with VIRTIO_VSOCK_SEQ_EOM.
> > > > > > > >
> > > > > > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> > > > > > > >a very large number of packets can be queued
> > > > > > > >because vvs->rx_bytes stays at 0.
> > > > > > > >
> > > > > > > >Fix this by estimating the skb metadata size:
> > > > > > > >
> > > > > > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
> > > > > > > >
> > > > > > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> > > > > > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > > > > > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > > > >Cc: Jason Wang <jasowang@redhat.com>
> > > > > > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
> > > > > > > >Cc: kvm@vger.kernel.org
> > > > > > > >Cc: virtualization@lists.linux.dev
> > > > > > > >---
> > > > > > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > > > > > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > > > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
> > > > > > > >--- a/net/vmw_vsock/virtio_transport_common.c
> > > > > > > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > > > > > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > > > > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > > > > > > >                                       u32 len)
> > > > > > > > {
> > > > > > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
> > > > > > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > > > > > >+
> > > > > > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> > > > > > > >               return false;
> > > > > > >
> > > > > > > I'm not sure about this fix, I mean that maybe this is incomplete.
> > > > > > > In virtio-vsock, there is a credit mechanism between the two peers:
> > > > > > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
> > > > > > >
> > > > > > > This takes only the payload into account, so it’s true that this problem
> > > > > > > exists; however, perhaps we should also inform the other peer of a lower
> > > > > > > credit balance, otherwise the other peer will believe it has much more
> > > > > > > credit than it actually does, send a large payload, and then the packet
> > > > > > > will be discarded and the data lost (there are no retransmissions,
> > > > > > > etc.).
> > > > > >
> > > > > > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
> > > > > > state to account credit")
> > > > > > and find a better fix then?
> > > > >
> > > > > IIRC the same issue was there before the commit fixed by that one (commit
> > > > > 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
> > > > > not sure about reverting it TBH.
> > > > >
> > > > > CCing Arseniy and Bobby.
> > > > >
> > > > > >
> > > > > > There is always a discrepancy between skb->len and skb->truesize.
> > > > > > You will not be able to announce a 1MB window, and accept one milliion
> > > > > > skb of 1-byte each.
> > > > > >
> > > > > > This kind of contract is broken.
> > > > > >
> > > > >
> > > > > Yep, I agree, but before we start discarding data (and losing it), IMHO we
> > > > > should at least inform the other peer that we're out of space.
> > > > >
> > > > > @Stefan, @Michael, do you think we can do something in the spec to avoid
> > > > > this issue and in some way take into account also the metadata in the
> > > > > credit. I mean to avoid the 1-byte packets flooding.
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > >
> > > > Why do we need the metadata? Just don't keep it around if you begin
> > > > running low on memory.
> > > 
> > > I don't think removing the skuffs will be easy; we added them for ebpf,
> > > zero-copy, and seqpacket as well.
> > 
> > You do not need to remove them completely.
> > 
> > > For now, we're already doing something:
> > > merging the skuffs if they don't have EOM set.
> > 
> > 
> > Right that's good. You could go further and merge with EOM too
> > if you stick the info about message boundaries somewhere else.
> 
> This adds a lot of complexity IMO, but we can try.
> 
> Do you have something in mind?

I'll send something shortly just to give you an idea.


> > 
> > > As a quick fix, I'm thinking of reducing the `buf_alloc` value to account
> > > for the overhead and notifying the other peer, at least until we find a
> > > better solution.
> > > 
> > > Stefano
> > 
> > well if you want to support pathological cases such as 1 byte messages
> > that would mean like 100x reduction no?
> > 
> 
> Yep, but since this patch is already merged, IMHO that is better than losing
> data in those pathological cases.
> 
> Thanks,
> Stefano




