Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB743F074F
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081874; cv=none; b=e8Zj7uO+K3u7Mx7fdlmNaARH01C+jx0nGpqA14kZ+wj59WqOx8kr3SrywKsAWYGL5DdqLHePAG95YhPK5MSFvnEWR8VLrJphV0KGPPTpEXd9OanRNnhuj11Exf/JjdQJ7FR36IBqGJp36EdRJiDB2vNa2jfyRBiHcqbBDQd+q6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081874; c=relaxed/simple;
	bh=YJyiH7vsjN9wJDdrOLzg7WAgRAisr5GaMsdx9zFAeac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ivMH4XuM0FS1fp/JrUEgqLZDC80equYL1RRwPR1K/gZyaT6AEogKc08P364naDuCT7tj+rthvubsDu2t9Gf8sv4ya00ythQdCkb7IsV1RwS1k7Xg3cC9QChu1m/YBDyEHq3qxFiw5aP+gfYbK4QZkZTMrTxaVgMtQPikO6YG0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4lbImIi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4lbImIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778081872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4Q8PvkIMQ5a5m63+buAC7DaLgwo1MQIWybr1f7ZYKw=;
	b=T4lbImIi3eVgCdEJr4fiINhSEO1959aXs0IVYEXqNSN+Kn+9mr0p+M58BxA7mvgUcfWAvn
	XdFI73RTFc7EfGDT/AfftK+FHXmsu/2JoOBUu7dANkCDu66nsdu+Rk1tACWVj1bGEb4xp/
	yWafkmBxqQSk4SwcsB+q1e02OO5+cPg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-WYoeQ3qfOhSgPRJTrGaEcg-1; Wed, 06 May 2026 11:37:51 -0400
X-MC-Unique: WYoeQ3qfOhSgPRJTrGaEcg-1
X-Mimecast-MFC-AGG-ID: WYoeQ3qfOhSgPRJTrGaEcg_1778081870
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4470d6d2a4fso7417603f8f.1
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 08:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081870; x=1778686670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4Q8PvkIMQ5a5m63+buAC7DaLgwo1MQIWybr1f7ZYKw=;
        b=kV5s33NkSvBaI/lqq6VDBUe0OMibAgj6qMmJOavwFq5fdU9DxbC9JFuKKqde+4AFE0
         eFNehh1fch4P3e6TdzKYnCHX5PzsnTR6hlWI2Qltb1nlk1kIV5vrPpVZdOSMi340YSig
         Jwv7//4XcABypWpqSaqW5tJUzX5a7JCCOAOO1uXWpaF++d+S0PNg7U/bdsyt/aXrhnIF
         cyWLdwESLelhi+pLYMmBPzHmTXvpqNYrHVerl34ySXUF2myYEr/n0QdSFA2YXQ4yJGb1
         X14GpwUHA4f894xGkXxQ1uMYLzm+837rdfdJ7Maz5mJBG/o7tfUZyDfM2jNoy/W0WO/+
         G7cQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HohdzozOt7cq1mYnHhGQeAAT2hqTJ4fHhNDLiceYdlGJaBlo8F7lSJ7N29N+kLJe1deFrrKpqVJCWZchNnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaPsKHaGa5TTSUSwx5tuT99ZzoqXT3H8WGoxBLsiNK3BFr+XtZ
	uxFXtfs36u6hvq4tcE0OGFDC8PBNi81pBmlur7tLLHVs7M1xDadUbz8D8WsMIHYlLp2XBCWMf8x
	p5Zi0ymGV4xlChzfN7XV5gcCD91Hsb5wNdyB+G5pL+GjV4xuCaUFhY3pwkOd+ItVmsq5C
X-Gm-Gg: AeBDieto6eQb8bOvja5a4u4r9lrZhxgJCjJEo6aFdaKqf29mwVAaDhjxrF7d4OUhTtu
	l2/QgwUfAfX4YqjlUEXNLXfZZEHEFBnEsBfF/sRyG/syPI01zy6PmFBlmnCbb0kT71FzGg2T/GF
	VHmHFDkHfbhGZyWys+W2BwIrfCXHIzI1JvhTnEYqtUNtkf0nPrqxDII7OKT0QlUBG/kjOR3IxTX
	yPRstrXhqmKgXtMJt+oZdd6Vf8jJa1rWOtjLSGpAT0g2h79k7sS/CE2Ruy31PzI8gQEZ12sfXKf
	36F5g9fHd/H4OFsiLECzp4zJyk6A++daRpmnHCYZoU6s0XKH/zPa5Ur2yD6vytM1S9YbTjDjeEW
	J3A8kn5JbW9vyMP7rte+5fshwwpJXoVQYeWumYwA3Ka8QRdvKMvk=
X-Received: by 2002:a05:6000:4312:b0:43d:7d24:b4ff with SMTP id ffacd0b85a97d-4515da967a5mr7045450f8f.40.1778081869583;
        Wed, 06 May 2026 08:37:49 -0700 (PDT)
X-Received: by 2002:a05:6000:4312:b0:43d:7d24:b4ff with SMTP id ffacd0b85a97d-4515da967a5mr7045381f8f.40.1778081868998;
        Wed, 06 May 2026 08:37:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d36dacsm13194806f8f.32.2026.05.06.08.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:37:48 -0700 (PDT)
Date: Wed, 6 May 2026 11:37:45 -0400
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
Message-ID: <20260506113554-mutt-send-email-mst@kernel.org>
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
In-Reply-To: <afoF_cHfl6ygcupM@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X6I0kPzL_-oz4NvkgXoPGMroBXWXNwQz2hthK_DU97w_1778081870
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

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

Why do we need the metadata? Just don't keep it around if you begin
running low on memory.

-- 
MST

