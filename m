Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559623BA23F
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145014; cv=none; b=pyt6q309qBVfxFIUSgtuKMO+dNjXYFJ1Jtw3S3n/mPhnan3QIUPqhP6FECYMgHANx4Y+DyHQX0u5bPDJrw95bcXjBtIeYoD826FQa5UlvoO5zo0OCABBIsG7SCCFVEy6TsD06+Y4iScz4BlJUsZTZgjh/ZiqQ8lk1NaZWh/pmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145014; c=relaxed/simple;
	bh=Su7MqlfynL8vSWqkM5vxWmtynu5V1wq3cdMpdL7zE08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Yzgpb8kkkxylzcMmTdFM4grs5777xWqqsgLYsiI1kri5ag459hnvbZr+tLlOz+Z2A1NOgZzunxGYkTBV6ZL7v7TJq97dVwBNioT9LX4+fswFGjKSI04p6nRetLnKQwW64NUR8GChofYnOjrhaYBZouGrxrV1Hjm7iNsd2ZARXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWv2xYON; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWv2xYON"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778145001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0+Dw+cwNE8SIW/NQeUoL6sJg8a8J+n/owA/XlUfbDM=;
	b=bWv2xYONscM92OeCdL00yrt2ta2kVDB5d1oHRxbvx91RgNaBao4VIyY0ohI94XfdNbT42O
	em++TBOyUY1TTJSb37WZgoRpuBe/pxcCIy/h+g6GZeyNjKnIxEWMNEzyjdYYbqtBi1ut/m
	w2U1kjQp5SjhTC7lma1FbIAdo0/5pbY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-cgXXUsJxOJ-Sz251B_rOQA-1; Thu, 07 May 2026 05:10:00 -0400
X-MC-Unique: cgXXUsJxOJ-Sz251B_rOQA-1
X-Mimecast-MFC-AGG-ID: cgXXUsJxOJ-Sz251B_rOQA_1778144999
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-447f2ce5556so354267f8f.2
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 02:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778144999; x=1778749799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0+Dw+cwNE8SIW/NQeUoL6sJg8a8J+n/owA/XlUfbDM=;
        b=OZFU6PgizWOQbAUVIJz2r94x6MRTtPb2Nn+EzuNmMVRFin5NgliSbcE+O68s328Ma/
         zBmQ+zvLFWl7pjW8AYU9tapvKLbwIH9pKdr17IYrathKQcfZfbuXzfyo9TqL2GTu4o72
         bdrdCXMjZBlzf9NafD+gC48uYU3biY9UuYHPy61sArqBCXSPOmx4aIcX3u8UxWarlXzf
         m7hmohR1lwq8ibVGZVKW620Xl1ClmRJroDfRFRF/H4qR6Hst5Ygd6o//u+LkRSc7Xsyu
         H+aCgBq82vM8DKsyNav73zac7rclKBctrHtcuEuNZqpG7IjuS3KWytd2/FICcT0TKd7m
         cfzw==
X-Forwarded-Encrypted: i=1; AFNElJ/d8ylvGWO2DPS8PK/MRlt6VsPExsZTsdgyyw/yQV1uCBeBNSTEOrZk0/IyCXKtrHEUCa7yXHrsU5rP4JHkQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YygROU7rXiG0Xv/neo8zt+3HXeptaR/G6KtrbwShtTeBC48POjU
	4tLElUSD4Ouz22y2Li0vuWZKybS2+MqvtCJPZ6Qf8EDN1wQc8w9OJggpNPfKFiSw+AY4ATlC1IZ
	3DHo6s5w2ZBgrC5rBNvkqBP4Z0hJ92cVRc5EnaOGvlAohgoynP+jEgR4N2vZ84jtMNGmR
X-Gm-Gg: AeBDietWc95vYP7zb8RKGOzhxHyn0ZL29C0l0Fe87BV1ZzU4tVcJr21MFKvPXxPCj44
	44D1Aro+usqUS3xA/U3n3HG/kBFJuAXZo5g8cARMt7+9pE3817iW7cxfGqkzkkoytlH3MlNnjCu
	7y2vemPEJr/iq3LT2Upm7ZUWVdvQu4NC6QxzedDvl9fv6AH8pUg6qw2SgUejucEVvVWRxicR6oq
	ZcFMg5z0Ttwf+ppl6K+BwlKeFGRu9yASzdBlcBxKdLNx2sZhn+nMmjJJ5SCWox0dl1LFQsFwrZB
	YUxDgSemYmxdTajHk23C9qVJ0jbDDc4G6QNFx/UyqLroyioz0FOfCw4HVdcaiiJaeQAmAETAV2J
	QYoSoAQ5XSGiUnA+F2Ut0Cif2c4OZjtC93E1gA519eCxIH4GdTz5w8Fp5MUXWvonaQQdfUDmXlw
	==
X-Received: by 2002:a05:6000:310a:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-4515d3dcac9mr11750307f8f.33.1778144998972;
        Thu, 07 May 2026 02:09:58 -0700 (PDT)
X-Received: by 2002:a05:6000:310a:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-4515d3dcac9mr11750200f8f.33.1778144998234;
        Thu, 07 May 2026 02:09:58 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960973sm18883323f8f.30.2026.05.07.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:09:57 -0700 (PDT)
Date: Thu, 7 May 2026 11:09:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afxVH2So9BbZ3Gta@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260506113554-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PZJMq_Xdt7jJMXn96EIe--vsJd3swkIZOeesS4I49r0_1778144999
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 06, 2026 at 11:37:45AM -0400, Michael S. Tsirkin wrote:
>On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
>> On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
>> > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > >
>> > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>> > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>> > > >
>> > > >virtio_transport_recv_enqueue() skips coalescing for packets
>> > > >with VIRTIO_VSOCK_SEQ_EOM.
>> > > >
>> > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>> > > >a very large number of packets can be queued
>> > > >because vvs->rx_bytes stays at 0.
>> > > >
>> > > >Fix this by estimating the skb metadata size:
>> > > >
>> > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
>> > > >
>> > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>> > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
>> > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> > > >Cc: Jason Wang <jasowang@redhat.com>
>> > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
>> > > >Cc: kvm@vger.kernel.org
>> > > >Cc: virtualization@lists.linux.dev
>> > > >---
>> > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
>> > > > 1 file changed, 3 insertions(+), 1 deletion(-)
>> > > >
>> > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>> > > >--- a/net/vmw_vsock/virtio_transport_common.c
>> > > >+++ b/net/vmw_vsock/virtio_transport_common.c
>> > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>> > > >                                       u32 len)
>> > > > {
>> > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
>> > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> > > >+
>> > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>> > > >               return false;
>> > >
>> > > I'm not sure about this fix, I mean that maybe this is incomplete.
>> > > In virtio-vsock, there is a credit mechanism between the two peers:
>> > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
>> > >
>> > > This takes only the payload into account, so it’s true that this problem
>> > > exists; however, perhaps we should also inform the other peer of a lower
>> > > credit balance, otherwise the other peer will believe it has much more
>> > > credit than it actually does, send a large payload, and then the packet
>> > > will be discarded and the data lost (there are no retransmissions,
>> > > etc.).
>> >
>> > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
>> > state to account credit")
>> > and find a better fix then?
>>
>> IIRC the same issue was there before the commit fixed by that one (commit
>> 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
>> not sure about reverting it TBH.
>>
>> CCing Arseniy and Bobby.
>>
>> >
>> > There is always a discrepancy between skb->len and skb->truesize.
>> > You will not be able to announce a 1MB window, and accept one milliion
>> > skb of 1-byte each.
>> >
>> > This kind of contract is broken.
>> >
>>
>> Yep, I agree, but before we start discarding data (and losing it), IMHO we
>> should at least inform the other peer that we're out of space.
>>
>> @Stefan, @Michael, do you think we can do something in the spec to avoid
>> this issue and in some way take into account also the metadata in the
>> credit. I mean to avoid the 1-byte packets flooding.
>>
>> Thanks,
>> Stefano
>
>Why do we need the metadata? Just don't keep it around if you begin
>running low on memory.

I don't think removing the skuffs will be easy; we added them for ebpf, 
zero-copy, and seqpacket as well. For now, we're already doing 
something: merging the skuffs if they don't have EOM set.

As a quick fix, I'm thinking of reducing the `buf_alloc` value to 
account for the overhead and notifying the other peer, at least until we 
find a better solution.

Stefano

