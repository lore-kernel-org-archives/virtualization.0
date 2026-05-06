Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81E425CFE
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076065; cv=none; b=arjKoWenPmq47r13yDNXEoqj7I9vRaD0rHkprVMSm7dPO75u8/ulWTLRE3BO9hZsLAa1hjIT2nvaqMfYdqvpGjbdhKsfV9HiRfuS5l9hdFhVa1rWq0QA8Dwvx4XlLMw76xrgizXCkWVQCP6GcEicnwzgFhJmFeuIgOp1urZWfbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076065; c=relaxed/simple;
	bh=SFiFDucNaRObAcaMrKWI6BPwF1qadwuDj2Vt2SN+ha0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eeN/cjm88uEY8FFPPnoURrbKlCCDOfFI3ZGXBA7z2bMwE0X+IDs/LlpMeui7ZkrVKsv/IHPEggMkkdtvQMlMPmK99fzlASd1ymxVJPsScR9bWBnUK8Hfmp0TZ4iAPaD8QtW/TUBiM5Mn2Uqbab3DwlpGvMMiqb2LFGUwDajfMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnG++F4+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnG++F4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778076063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCRVTBZQDAEVaqanV0j4+1ERDgnWXkjidry1aEHpyPY=;
	b=VnG++F4+qAcUHowyf+uyrQVrnL8vykawaSgup+HVcPu2jqO/unY195F++DD+W6t5O/clJf
	WW6M68ILLdcjIuY0x9jK0648YWFw37GMfVYgU+jkfBUiOu9C0Gq5Tt7N1F7j5c76I2p/0f
	Vp/nDhz77bn4EqZNk3PnbjgoUJVRgCk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-NDxaK0RhPgO4ijExSkWNuw-1; Wed, 06 May 2026 10:00:59 -0400
X-MC-Unique: NDxaK0RhPgO4ijExSkWNuw-1
X-Mimecast-MFC-AGG-ID: NDxaK0RhPgO4ijExSkWNuw_1778076058
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44d9ace59efso2749042f8f.1
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 07:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778076058; x=1778680858;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCRVTBZQDAEVaqanV0j4+1ERDgnWXkjidry1aEHpyPY=;
        b=c1MTIl0vzTwKaQJsrhSoyTUtJqWuuTGj86bWzxPLiUPUssj9Bd/+2JWDSVyQKLffXk
         ZsmLffSKM8yAOjEL43dqSyygolIfWbwc8lC2ZKqOq4fK1vB6iKxqJ8V9U/uQifgYoIst
         7mJ/X3Ir3+CDhimZ0kZQEt/QL19FeAmYR1FqZTAN8PPhxCyBxuLW7W2b3poGkWnc+Okh
         zH4HqSb/VR7vQG9FlFOZqbox2+agYnwKQ5pRaq+djibXIpNDMteo5aQXOECMErPmQESx
         xZcSmUXYogjO6gNaPWxaymKjYEEnFSCj8TKKAC0RQb8LWOwMcxSDmezwyeYXYMdVN0hj
         yPfg==
X-Forwarded-Encrypted: i=1; AFNElJ+B+ggMdqOrDFHvxCmOEIwz3vXG9uHv1TElVBfhKmv3lzU8muh+LBbdKy5IaaUq9nxy3t0EDWuW2VKy1vcGaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFBflRtpMAJXhb3LUcTZ4TS8lH2Zh0ot6fMi8r4m2jpTPfutsq
	VJ9u7yt5g1AqRADizS60sLufF5dRFShYPQ2aJHnksNG+R74Jdm/sID1KuvTQGL5RfPayfrekmF7
	XzquDF9laKz4QmYzvAAXdnPJY/Xm4Po+qH4wYV+hCU34CUxVp4GW7bdJAaRUs3qkkNU2L
X-Gm-Gg: AeBDieth0cDvGfvAGYbOTY1S3shi4VjjlyYZiE+czz0uGdo00Hbfj2Ki4RgOwhXtmxa
	TrFsxNHU2tbB2jeepqZfGYAF/E7BBm5QIdSEr79QKFfOKg3t56fohJkMmhgOefvGTeK5lSly+o6
	NdKI3F3Fqbb3/MSvFwUSBD5QPw+2aQSFZFEqELm+1OChVjDYsqPs0l6aGcytJdC9jrmDFPD8+1G
	19wgtnJmHb38b8AbP9HeodU8zUcwWF7MWz6f3cS/m3SRM1HrPNwSxXT7PIVWGs+RfmTxR7lPqGd
	wROfH0zQAtMJOtvJ7BoWM7TPbB+kWaLMY3+8Uk4FJrTsWSZ/YeOTMtulQFVm+aMVL4EE8JEItZ+
	MxXKPGLxg9BwfZG8txCzmHus3Gyyn0xy2e9FsZaWbYkd+Q6qHWKVJS9XKv/emtQ+9e1CFhdtuog
	==
X-Received: by 2002:a05:6000:2c03:b0:43d:21a:9a3e with SMTP id ffacd0b85a97d-4515d5c54c0mr5877765f8f.32.1778076057316;
        Wed, 06 May 2026 07:00:57 -0700 (PDT)
X-Received: by 2002:a05:6000:2c03:b0:43d:21a:9a3e with SMTP id ffacd0b85a97d-4515d5c54c0mr5877593f8f.32.1778076056142;
        Wed, 06 May 2026 07:00:56 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d36dacsm12654112f8f.32.2026.05.06.07.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:00:55 -0700 (PDT)
Date: Wed, 6 May 2026 16:00:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afs9FsY51D3zRA5N@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <afocwkfBHJ5u10rx@devvm29614.prn0.facebook.com>
 <e1f32df5-b6a1-47a8-a783-fcc8e3c91f25@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e1f32df5-b6a1-47a8-a783-fcc8e3c91f25@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P2dNWNX7qPyUXXhEJ8tAtzhHxn_XrvMtoPiR9WhwlgY_1778076058
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 06, 2026 at 12:50:04PM +0300, Arseniy Krasnov wrote:
>
>
>05.05.2026 19:37, Bobby Eshleman wrote:
>> On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
>>> On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
>>>> On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>>
>>>>> On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>>>>>> virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>>>>>>
>>>>>> virtio_transport_recv_enqueue() skips coalescing for packets
>>>>>> with VIRTIO_VSOCK_SEQ_EOM.
>>>>>>
>>>>>> If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>>>>>> a very large number of packets can be queued
>>>>>> because vvs->rx_bytes stays at 0.
>>>>>>
>>>>>> Fix this by estimating the skb metadata size:
>>>>>>
>>>>>>       (Number of skbs in the queue) * SKB_TRUESIZE(0)
>>>>>>
>>>>>> Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>>>>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>>>>> Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>> Cc: Stefano Garzarella <sgarzare@redhat.com>
>>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>>>> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>>>> Cc: "Eugenio Pérez" <eperezma@redhat.com>
>>>>>> Cc: kvm@vger.kernel.org
>>>>>> Cc: virtualization@lists.linux.dev
>>>>>> ---
>>>>>> net/vmw_vsock/virtio_transport_common.c | 4 +++-
>>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>>>> index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>>> @@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>>>>> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>>>>>>                                       u32 len)
>>>>>> {
>>>>>> -      if (vvs->buf_used + len > vvs->buf_alloc)
>>>>>> +      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>>>>>> +
>>>>>> +      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>>>>>>               return false;
>>>>>
>>>>> I'm not sure about this fix, I mean that maybe this is incomplete.
>>>>> In virtio-vsock, there is a credit mechanism between the two peers:
>>>>> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
>>>>>
>>>>> This takes only the payload into account, so it’s true that this problem
>>>>> exists; however, perhaps we should also inform the other peer of a lower
>>>>> credit balance, otherwise the other peer will believe it has much more
>>>>> credit than it actually does, send a large payload, and then the packet
>>>>> will be discarded and the data lost (there are no retransmissions,
>>>>> etc.).
>>>>
>>>> I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
>>>> state to account credit")
>>>> and find a better fix then?
>>>
>>> IIRC the same issue was there before the commit fixed by that one (commit
>>> 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
>>> not sure about reverting it TBH.
>>>
>>> CCing Arseniy and Bobby.
>
>Thanks!
>
>>>
>>>>
>>>> There is always a discrepancy between skb->len and skb->truesize.
>>>> You will not be able to announce a 1MB window, and accept one milliion
>>>> skb of 1-byte each.
>>>>
>>>> This kind of contract is broken.
>>>>
>>>
>>> Yep, I agree, but before we start discarding data (and losing it), IMHO we
>>> should at least inform the other peer that we're out of space.
>>>
>>> @Stefan, @Michael, do you think we can do something in the spec to avoid
>>> this issue and in some way take into account also the metadata in the
>>> credit. I mean to avoid the 1-byte packets flooding.
>>>
>>> Thanks,
>>> Stefano
>>>
>>>
>>
>> Indeed the old pre-fix skb code would have the same issue.
>>
>> I can't think of any way around this without extending the spec.
>
>Hi, thanks, agree with Bobby, that accounting metadata (e.g. skb size here) was not implemented "by
>design" in credit logic - another side of data exchange knows nothing about that. Also the same
>situation was before skb implementation was added by Bobby. So looks like need to update spec may be.
>

Even if we change the specifications, we still need to work with older 
devices, so we should find a solution for this as well.

My main concern is data loss, so I'm considering the following options:

1. Notify the other peer of a smaller buf_alloc from the start, leave 
some room for overhead, and when it's running out, notify them that 
buf_alloc = 0. This way, the peer realizes it can’t send anything else.

2. Or update buf_alloc each time by removing the overhead, similar to 
what’s currently done in virtio_transport_inc_rx_pkt(), but also do it 
in virtio_transport_inc_tx_pkt().

As I said, IMO this patch alone is incomplete; we need to communicate 
with the peer somehow regarding space. I don’t think including the 
overhead in fwd_cnt is spec compliant, since the other peer has no idea 
how much overhead is needed, but reducing buf_alloc should be okay, even 
though I’m concerned about packets in flight.

As a quick fix, I think option 2 might be the easiest; I’ll run some 
tests and send over a patch.

But in the long run, I think we absolutely need to improve memory 
management in vsock, perhaps by avoiding custom solutions.

Thanks,
Stefano

