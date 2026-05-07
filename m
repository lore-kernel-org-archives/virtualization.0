Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC56A3E958D
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158793; cv=none; b=dWEOMSnZUIi2czzyd9tcf6lq547wXLGusTIkjyHG5I+dgyss2JXyx7WQXdMq2AbfITCgWIqWvQv5cvCDW8sLTAf6EaXo4Y0ukMvFFlwDVTxpg2oBo2Nk8POBI0SDk11h5SjZcRu8Qnw6BfPOzVV0W/FOINgMqnWnvuUpLJamIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158793; c=relaxed/simple;
	bh=a1ipHP4vJKqQ1PCjSE2XOtkD4KIsGKmi/PHR4V/X8j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r+zcwU3JWwREXUKKe85YP+v0fTKscPPas9pV/bL/rYU6PfQ8rylJWQgeLIM8Wwld4oaIpKVrfzhwxH4+1ECiTjJ/H6TsNsvHPWUejPpY8oC+87RpiQ5Ma4zp+9y6UlyH1bLYdt+0WBWeJsvT2IR56VAV7UuCeCa5NTsJJ+Mh4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIDM7Pvx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIDM7Pvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778158789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6a38SeOw0jKuyeFe5c6jTpEyvp+0L5OzxyUUit2nySo=;
	b=CIDM7PvxaB/92BFSQQq61oXocNmEx8gNQCRArFTpft9gsQGLJTa7GjMgM5GwQ/o+x2Z3NY
	S07D1Sf9J86ZShwoCZ0BgRVr2PNyAHz4Pe4dZ7/0jv6JF/KjoMCKtnwWyZ/iVBdF8XwSd4
	lEKwTILUfzYoc8PgTTHnw1nSHh87ees=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-9bVBGDAeOXSFP64rDzMluQ-1; Thu, 07 May 2026 08:59:48 -0400
X-MC-Unique: 9bVBGDAeOXSFP64rDzMluQ-1
X-Mimecast-MFC-AGG-ID: 9bVBGDAeOXSFP64rDzMluQ_1778158787
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d103e46c3so517886f8f.3
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 05:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158787; x=1778763587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6a38SeOw0jKuyeFe5c6jTpEyvp+0L5OzxyUUit2nySo=;
        b=ajS7Oiu3p3Zjb6HQKfvBrlbWSfObceMLuzlj1wt+sf7UZmltKr13lhsqWyP5zpy7PV
         TtL7wqN53P2TRGCr8oLeDdlCzPN6uahNB+6x8e6xPvoGj9kd0mF7+PXZizvP4LPleByC
         qo9FVAaIJ18l/mC7wmDGp7vpC5EsvUO38kmEe/qUZ52QLto/4DF28+eM615t48myYeeK
         y8jXaMkvG6JbzK5tJVNR+z16QaV0Bq/K4ERmFsfPSt4LuSdPKTTO3b15sGse/VGs8EDd
         plaRE2URpivyVwPZbYEdKZheWX6dsjeS8c579HNCaz0Uk6iKLLCwMQ64duzRiOxPiR/+
         qmZA==
X-Forwarded-Encrypted: i=1; AFNElJ+632GtHqFuB1H8+1Ju5YO66E3RagReDt3wJo+SiGCbBwoVz15LSQS1m2EZE4MVu3o7E+LRieYjqr5NgAw3QA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGuTFgOPqU6mVVfDlZnWUdiBfpCGazVtg60ZijujM5nQin2F6i
	LPs0usjeG41Ig621z0WfSaky9eOgempF0oA4eqDqNNrrJ+bUO1fS5GI21A4uFEGeE9uIcB0y1uo
	FMd6IAHhSmuXfe162Toq+9YUgYJxLELEefmWxhn5EINQQMAah4St7QsQi+Qk/s9NYBJO1
X-Gm-Gg: AeBDiespSL0Tza3l+XkHfi5iS435bbq12G6J05pzSOELKYv+mgi0F7yRFF3ozQ41zk2
	cZ/EdD7O8jaBlc6g0um1E09FZ8QItVQQmJoxC3yALlU3RuB+lhaDcmlNPyXDXwrSp1zBgD6/Soh
	j29cQ0T0dU5o3FI5h2JPos5skDAflQXb2+hjIV83BHMDEHAi9BLRRwMjPRoD6GZFsx2PJHDYHP+
	7T8/M1fpRFhHyvPbtwLkFMocFMR0icc5cKMKZOquUAZwbQ91KUHa3F/Om3RUZo4nV78VR72ZIm3
	2IyHO3+pMwIYKSQo4MdF2NgX/OeV105SX280LNIe+J5ay5nwk2/mGMmUfWUrAABuBdWQpC6mcDF
	SHCZatQ7+EEPKIF7ZTk7hjVC4HUzB2Po/QIOvsUChPmdfqjwCxr2zXyNS9sNmlp/9TtoTqIuqLA
	==
X-Received: by 2002:a5d:5d89:0:b0:449:4079:4c39 with SMTP id ffacd0b85a97d-4515d5c5750mr12867088f8f.29.1778158787136;
        Thu, 07 May 2026 05:59:47 -0700 (PDT)
X-Received: by 2002:a5d:5d89:0:b0:449:4079:4c39 with SMTP id ffacd0b85a97d-4515d5c5750mr12867018f8f.29.1778158786505;
        Thu, 07 May 2026 05:59:46 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f2203csm20313623f8f.37.2026.05.07.05.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:59:45 -0700 (PDT)
Date: Thu, 7 May 2026 14:59:13 +0200
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
Message-ID: <afyMCyBvZpzWrLtO@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260507074113-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bn_nCW1C6fjQU0KJMOtu6iHLfqAIN8uef4hzLvTFJX8_1778158787
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, May 07, 2026 at 07:45:10AM -0400, Michael S. Tsirkin wrote:
>On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
>> On Wed, May 06, 2026 at 11:37:45AM -0400, Michael S. Tsirkin wrote:
>> > On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
>> > > On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
>> > > > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > > > >
>> > > > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>> > > > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>> > > > > >
>> > > > > >virtio_transport_recv_enqueue() skips coalescing for packets
>> > > > > >with VIRTIO_VSOCK_SEQ_EOM.
>> > > > > >
>> > > > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>> > > > > >a very large number of packets can be queued
>> > > > > >because vvs->rx_bytes stays at 0.
>> > > > > >
>> > > > > >Fix this by estimating the skb metadata size:
>> > > > > >
>> > > > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
>> > > > > >
>> > > > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>> > > > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> > > > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> > > > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> > > > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
>> > > > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> > > > > >Cc: Jason Wang <jasowang@redhat.com>
>> > > > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> > > > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
>> > > > > >Cc: kvm@vger.kernel.org
>> > > > > >Cc: virtualization@lists.linux.dev
>> > > > > >---
>> > > > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
>> > > > > > 1 file changed, 3 insertions(+), 1 deletion(-)
>> > > > > >
>> > > > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>> > > > > >--- a/net/vmw_vsock/virtio_transport_common.c
>> > > > > >+++ b/net/vmw_vsock/virtio_transport_common.c
>> > > > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> > > > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>> > > > > >                                       u32 len)
>> > > > > > {
>> > > > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
>> > > > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> > > > > >+
>> > > > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>> > > > > >               return false;
>> > > > >
>> > > > > I'm not sure about this fix, I mean that maybe this is incomplete.
>> > > > > In virtio-vsock, there is a credit mechanism between the two peers:
>> > > > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
>> > > > >
>> > > > > This takes only the payload into account, so it’s true that this problem
>> > > > > exists; however, perhaps we should also inform the other peer of a lower
>> > > > > credit balance, otherwise the other peer will believe it has much more
>> > > > > credit than it actually does, send a large payload, and then the packet
>> > > > > will be discarded and the data lost (there are no retransmissions,
>> > > > > etc.).
>> > > >
>> > > > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
>> > > > state to account credit")
>> > > > and find a better fix then?
>> > >
>> > > IIRC the same issue was there before the commit fixed by that one (commit
>> > > 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
>> > > not sure about reverting it TBH.
>> > >
>> > > CCing Arseniy and Bobby.
>> > >
>> > > >
>> > > > There is always a discrepancy between skb->len and skb->truesize.
>> > > > You will not be able to announce a 1MB window, and accept one milliion
>> > > > skb of 1-byte each.
>> > > >
>> > > > This kind of contract is broken.
>> > > >
>> > >
>> > > Yep, I agree, but before we start discarding data (and losing it), IMHO we
>> > > should at least inform the other peer that we're out of space.
>> > >
>> > > @Stefan, @Michael, do you think we can do something in the spec to avoid
>> > > this issue and in some way take into account also the metadata in the
>> > > credit. I mean to avoid the 1-byte packets flooding.
>> > >
>> > > Thanks,
>> > > Stefano
>> >
>> > Why do we need the metadata? Just don't keep it around if you begin
>> > running low on memory.
>>
>> I don't think removing the skuffs will be easy; we added them for ebpf,
>> zero-copy, and seqpacket as well.
>
>You do not need to remove them completely.
>
>> For now, we're already doing something:
>> merging the skuffs if they don't have EOM set.
>
>
>Right that's good. You could go further and merge with EOM too
>if you stick the info about message boundaries somewhere else.

This adds a lot of complexity IMO, but we can try.

Do you have something in mind?

>
>> As a quick fix, I'm thinking of reducing the `buf_alloc` value to account
>> for the overhead and notifying the other peer, at least until we find a
>> better solution.
>>
>> Stefano
>
>well if you want to support pathological cases such as 1 byte messages
>that would mean like 100x reduction no?
>

Yep, but since this patch is already merged, IMHO that is better than 
losing data in those pathological cases.

Thanks,
Stefano

