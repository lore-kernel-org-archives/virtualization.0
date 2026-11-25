Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626718;
	b=ZzbFlH5/eWqtGTPlxipHjXgjDSuTohhexINFoHs6ZeuTDRwAlCr2VZR/Lqs5zz7Eug30
	 HSH+UJkRZYaKPh21FaKBW7jN7BdPp+dflKGLzxaYl+O+J1R2zQ71FQ1aOelxJI7G9IBxp
	 VrUcFINbg+3I6gl7sFhvG1zDqfQyRSzz96yN6jeHZ9GBLsVFsdmkCWpv7zFIhaTfdWOQd
	 XofIi4TMHX+3mOcGW/RGVx0KoWRezeJFqnmEESdQCqwk5BsVl6XlOjOL/32+2+6oHDuFe
	 p9JOUSkwKyZ1PBLsYab2CvtyCA9GchzoZdOd9/HB6qlJZmdsb1Lx8cU1rTBRv6K685Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626718;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type;
	bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
	b=fA+rJ1wy6G66elhFbILW7MtCPUdFyQYYXYHW0HxUdAzcDyaUUeauRdABVBawo5uhLWvh
	 8wodk2zY5jF0s6LC25ii3gGJi7Zuce5rGbGn9pFfnAhfneBD7bqUKNWwjkW864ldTTBRY
	 1hTV3mSUzpF2MKrjJzkQKlJnA6NYuqtxIAIBgLLzxbe81KIiRaLoGvzaGaDAkcGtqOw1g
	 q/poQlIjsDsdBi2Sz63jYf1k5nd83iwWhbEvvtk4DNk1wuqAjodHvX19TQGiv6/PY8eMJ
	 DLlvxQGEiOLv+BX0yRbmgjaN1DBjCN5X3QmuhHEMOu17IdtVQ6giC9XF1WN56Xms4RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PvzqpS9Y;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D61606A68F
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 17:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35D61606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PvzqpS9Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795626717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
	b=PvzqpS9YWn7uJPWfpfJTtVvtPA/h5KujtAShmaIUPw49Bt8JyYpi3CuWHSPTlz9R5MjML2
	jlyenGRyHkMhrKbQphOqZN5lyI8WLSybSnyeuPvfuE9/pgqFamFtE1+q10QCpgrl1Dbw1D
	g1wezw8n2khDnL28leAgb95avss+GyE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-5IfrEGBZP2u-cEB0DtIipA-1; Wed, 25 Nov 2026 17:11:53 +0000
X-MC-Unique: 5IfrEGBZP2u-cEB0DtIipA-1
X-Mimecast-MFC-AGG-ID: 5IfrEGBZP2u-cEB0DtIipA_1795626713
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b4e8af48c8so81944717b3.1
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 09:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626713; x=1796231513;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wMnvi84iHgMT5EehQPUOpPHMSRil6iMt6kQQwsIp6L8=;
        b=SnlaMZfn26CTVuKrmRXrV+vX8yd50119wjfjD2hs5c6GQOwiYjaro9Yg/cw0JFhSOj
         EEMvYMSFxxclaKSO/ECXLooP8GLqhZ2FVY5qFu1t7cloGkQfwSzXzi93YDaRpRpP2x2s
         wWpoMZ9SeTlFfUgCJprHLkaIqlumS7mlVpAfRO/nC2tnIMtMG7AjbDpJSS9BTHpZx221
         A4e11oxWNCfdKFUzzKOO/+jMld7kryC01SL+xlRSjxP3F8E7MKRUAcmd73Gka2pA1Yub
         DNeCCB06L+PAB1tJZbGI2AkKRjGsqnaUaX4r3hk02hRK5XGk93IhRdb0i0BPcQrBSpzC
         HstQ==
X-Forwarded-Encrypted: i=1; AL+hErHu2r9jzGAhKXtkpYBSzoqa09Yr1VVkdiOvUk3DbKlWMShc9tQMIJxiJvnWJqupPeV/VhEO42Hh6c30kiRIDQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Z7qgDQ4M/BLOUc4HjnBC0f10JWt8idt1EUJnQkLrLjpu3XJn5
	2Mu2PBkbmkv4ipIT92t0rGrZOak1P+cm3H2x2B0Za0fBCb2qhhjNILceu2SvurEHMamqcDaC2ZE
	d9m4X49SHhV5s8jwJDEeSrs0pdmbpJc0Gzw1p95Co+49DyV0BnpKO+rXVG0ucM36Bl40SekLH00
	Xvk1/9t6MUHTHOG4LW2P+2SMEzXSnimMXBfmDgPwspBz8=
X-Gm-Gg: AZFdTZdRZspr6SYIpO75UlDWShq4kYEuk/pT+rySl0cPu+hCjH8qff4cjOph7FZJkqW
	3yRb4Mjzl2Q/hzAMvOiINsEJuIBm04Z5oOQK+GCDKC+JWK9CQdQSBUI1gj3Z9VQvaW4fcZuURoM
	txcS3+vPsCzkDu2wzR4/ZJcuNn7oCwtuTj3nGtNg8GiGitaPU/ifa+HEQ=
X-Received: by 2002:a53:ca02:0:b0:67d:c2d1:5f40 with SMTP id 956f58d0204a3-67df44a9f94mr7458638d50.97.1795626712838;
        Wed, 25 Nov 2026 09:11:52 -0800 (PST)
X-Received: by 2002:a53:ca02:0:b0:67d:c2d1:5f40 with SMTP id
 956f58d0204a3-67df44a9f94mr7458599d50.97.1795626712243; Wed, 25 Nov 2026
 09:11:52 -0800 (PST)
Received: from 821463759402 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 09:11:51 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <aveRRt/rHQ1By6ul@devvm29614.prn0.facebook.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-7-1523c8e9b27e@redhat.com> <aveRRt/rHQ1By6ul@devvm29614.prn0.facebook.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 09:11:51 -0800
X-Gm-Features: Aa3M54rWhP6JPS6dAHPhCuA1V9j2mDkBDAmNkK_cOM-iU_dy7BMJhibPYf3kF0A
Message-ID: <CAAiTLFWpoZu9ArNVQ_uq6RRQyiiQYvy5=uNVbhpb=6-OBJV8mQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 7/8] vsock: fragment datagrams across receive buffers
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8Ttm6b_mu1Zv_lweGUvKdgvFXi9Q5ubjIwl_r7UBckM_1795626713
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Bobby Eshleman <bobbyeshleman@meta.com> writes:

(I've just noticed I've missed replying to this review, sorry about that).

> On Fri, Nov 13, 2026 at 06:15:47PM +0100, Sergio Lopez wrote:
>> The guest already uses page-sized RX allocations. A datagram can exceed
>> one RX buffer. Growing every posted buffer to hold a full datagram would
>> increase virtqueue memory use and make small queued datagrams retain large
>> backing allocations. With delayed reads, a bounded receive queue could
>> then fill after only a few messages.
>>
>> Define START and EOM flags for datagram packets. Mark outgoing messages
>> with both flags, and let vhost split a message across guest RX buffers,
>> keeping START on the first fragment and EOM on the last. When a data
>> packet meets a descriptor with no payload space, vhost returns that
>> descriptor with zero used bytes. It drops datagrams but requeues stream
>> and seqpacket data for a later buffer.
>>
>> Reassemble consecutive fragments in the guest before tap or socket
>> delivery. Bound a partial message to 64 fragments and 64 KiB. Discard
>> incomplete messages on malformed packets, a new START, a peer mismatch,
>> an intervening non-datagram packet, or virtqueue teardown. Require complete
>> framing for host and loopback ingress.
>>
>> A QEMU reproducer now delivers a 9 KiB datagram as one message and all
>> 16 messages of a delayed-read burst. Paired host/guest selftests cover
>> 64 KiB messages and the burst through both a userspace backend and the
>> patched Linux vhost backend, with stream and seqpacket controls. A nested
>> vhost-vsock guest posting header-only RX buffers also passes stream and
>> seqpacket receive tests.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  drivers/vhost/vsock.c                   |  15 +++++
>>  include/uapi/linux/virtio_vsock.h       |   8 +++
>>  net/vmw_vsock/virtio_transport.c        | 115 ++++++++++++++++++++++++++++++--
>>  net/vmw_vsock/virtio_transport_common.c |  11 ++-
>>  4 files changed, 141 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index f4fb2ac732f5..1ff4a9aff907 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -185,6 +185,19 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>  		 * buffer, we split it using multiple buffers.
>>  		 */
>>  		if (payload_len > iov_len - sizeof(*hdr)) {
>> +			if (iov_len == sizeof(*hdr)) {
>> +				/* Connected sockets must retry with the next buffer. */
>> +				if (le16_to_cpu(hdr->type) ==
>> +				    VIRTIO_VSOCK_TYPE_DGRAM)
>> +					kfree_skb(skb);
>> +				else
>> +					virtio_vsock_skb_queue_head(
>> +						&vsock->send_pkt_queue, skb);
>> +				vhost_add_used(vq, head, 0);
>> +				added = true;
>> +				continue;
>> +			}
>> +
>>  			payload_len = iov_len - sizeof(*hdr);
>>
>>  			/* As we are copying pieces of large packet's buffer to
>> @@ -244,6 +257,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>  		 */
>>  		if (VIRTIO_VSOCK_SKB_CB(skb)->offset < skb->len) {
>>  			hdr->flags |= cpu_to_le32(flags_to_restore);
>> +			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM)
>> +				hdr->flags &= ~cpu_to_le32(VIRTIO_VSOCK_DGRAM_START);
>>
>>  			/* We are queueing the same skb to handle
>>  			 * the remaining bytes, and we want to deliver it
>> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>> index 27b4b2b8bf13..e1937f756eeb 100644
>> --- a/include/uapi/linux/virtio_vsock.h
>> +++ b/include/uapi/linux/virtio_vsock.h
>> @@ -101,6 +101,14 @@ enum virtio_vsock_shutdown {
>>  enum virtio_vsock_rw {
>>  	VIRTIO_VSOCK_SEQ_EOM = 1,
>>  	VIRTIO_VSOCK_SEQ_EOR = 2,
>> +	/*
>> +	 * With VIRTIO_VSOCK_F_DGRAM, START marks the first RW packet of a
>> +	 * datagram and EOM marks the last. Both are set for a datagram that
>> +	 * fits in one packet. Fragments must be consecutive on the receive
>> +	 * virtqueue. Each packet's len is its fragment length.
>> +	 */
>> +	VIRTIO_VSOCK_DGRAM_EOM = VIRTIO_VSOCK_SEQ_EOM,
>> +	VIRTIO_VSOCK_DGRAM_START = 4,
>
> Should this be 4 if VIRTIO_VSOCK_DGRAM_EOM = VIRTIO_VSOCK_SEQ_EOM = 1?
> Seems like 3 is missing?

Yes, those are bitmasks. But they are also part of an enum, which is
weird and confusing. Perhaps I should prepend a patch removing the enum
and redefining those values in the form of "1U << 0"?

> Is VIRTIO_VSOCK_DGRAM_START strictly necessary? If we just received an
> EOM from a peer, then we know that the next pkt from that peer is also
> the start of a new dgram. We'd have to be careful to never abandon a
> datagram partway through, but for example I think we can just requeue
> the datagram fragment to later retry if we fail to place onto the vq?

Yeah, I thought about this quite a while too. Having START makes the
protocol less dependent on the transport semantics, allowing the guest
to identify an incomplete datagram to resume from a known boundary. I
think it makes the implementation more robust with a relatively small
cost.

Thanks!
Sergio.

