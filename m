Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99448B38C
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997485; cv=none; b=j5mL5EDm0zAVqJaLejBHD7KGdlQhC8m7BLhgTyH14DPU8aIFmA+D9V9pMja66zXeVqGDQDAdBwlm0i9d24skpv27W1EGNW11NHQLPufyFvXpJ4DBkkctEix0T/7Yh1jWmeyUldco13Sv1UiIcOzGlJcInpVpLXATQXNbFh4Fiis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997485; c=relaxed/simple;
	bh=NZswvJER178yJggzp3PBiIDtYWsGq7nDkywdtiyUvBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bIAwnCflTO56XeEflkJKMnD5OARJ47cDcyfFhMieI/svutT3V1pLUE4BC1c1LDigiZ5HZg35VtnGygHXBq4weXwFKfaxHy0QV+lDym/NKhbS2OIp1hlqlvQ9iruQiCmVhbtWSFk+TQAFd5LaV48vukqOY82JgYWc6f2L2jKlyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxdgOpJY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxdgOpJY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777997483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDx07l4ozVnxxK7UujBIhmzxsF1zsTEyokH05DVKlSg=;
	b=OxdgOpJYuMmuzI+PiSGvEdcn/oON3Uh9IhlDdMHkXwz8Ay11naenidSqjYZ1Fagk8dKmYD
	HtLhJ04IlGsju/SYDbHV70VB/lAaWTERWFYL7HeRlhp5vJ14baGAV0NUqBgUrLlUalbc0I
	FwoHRODvJev5syNldtylDQEr+jQw2N8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-VplpzWd6OlW2FxLTkyDiOw-1; Tue, 05 May 2026 12:11:19 -0400
X-MC-Unique: VplpzWd6OlW2FxLTkyDiOw-1
X-Mimecast-MFC-AGG-ID: VplpzWd6OlW2FxLTkyDiOw_1777997478
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a55ecc32cso50422985e9.1
        for <virtualization@lists.linux.dev>; Tue, 05 May 2026 09:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997478; x=1778602278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDx07l4ozVnxxK7UujBIhmzxsF1zsTEyokH05DVKlSg=;
        b=bJMyq99JoE1lt595hDExemOwHYiheRBDj5gVQGENgLlRhp1YYMbm/VDExjKgnwmhZF
         zEQpNxqRLm2pzDii7Hsy1frEexGs4KVX6NczsqFHAApxFJtmxo6Cp2Zq738ajzBuX7gm
         8uYaPhIJK4GjmGdekB31KeWUdaqfpW1DqudsBPLWmYkiwvwcfojkquoQdSgatCtSCx4d
         uQlo0qPjiH5WoSokT+cWK6QCwEAiczCxVunjP8oFWlHmFp5e8tL/5wCebVf7NzuEurGB
         lxfLxcoJh9K531AhQBnb/q8xzPRLtkkE4cX2U229Yho588socG+aRm2gBN8fjsnS2LX7
         FAiw==
X-Forwarded-Encrypted: i=1; AFNElJ9zmGpXaC0sGtj1LP6s4uJqWV3H07xf1BruN7wqu418uuzoGXeOvZvQAr09bHeTgOxtiYNW67lyPyZBpxTLqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm89OkomoZF4u+Ww74u9NvQQLdaND55I70WB/ndxmXA5pCDfSY
	Ewle8yoHVS880eU7i5iDIa68kgLXa7/DFqUzefbnESXOBDXLe7z31mhkqd7ym0dygiS1afYNT/J
	rrNr5peTzHLdT44fUPaMpB9EsRDgjewm777Khur0B65tHJun7mMfBkG318T1VQivmT1M/
X-Gm-Gg: AeBDieucjw3RCrGkVxYeYJLSsRJk8LxXf7GbGQtVGc3s/mSa36eyblV7n3J9ZSTVRMN
	TsAvRgsTwz4hf61f6NKw1yjfOBHQ0lrST81jGmiRo88mSSEpDnDdPRLwMMakoZc5XWxVRQhf16x
	UAWxIvCkIbXEwR8leTaS2Y3qrqH3cdySfmx1ilrHFEjJQ7QIE8EqXazekMtR8v2FmoAOBxr6wKP
	rXDJsf1/B/I8bLs6n2SDcjAcCMCpF8gZG8H8i92/dP02IN+VJGgsrXtA+gpXCaTSH8hwV04eQXK
	gGoo/zyfS+FKPbgp3jLaROB36sE4wt5S84Sj0Lc1GtSSmZOb4d5uQp2sETsHUoo9yqt/o6xVBjX
	3HtpUY4U7rQFH6JuFC0kOCD8AgvCFNbJSGmF4ZUOBtxDGE8GEJPhB+UgwA3ZH4CIO9MxFnNxO7Q
	==
X-Received: by 2002:a05:600c:1d0d:b0:488:8840:e5ae with SMTP id 5b1f17b1804b1-48e51c723bfmr551495e9.24.1777997478333;
        Tue, 05 May 2026 09:11:18 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0d:b0:488:8840:e5ae with SMTP id 5b1f17b1804b1-48e51c723bfmr550795e9.24.1777997477746;
        Tue, 05 May 2026 09:11:17 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb3dc1sm380443525e9.14.2026.05.05.09.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:11:16 -0700 (PDT)
Date: Tue, 5 May 2026 18:11:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Dumazet <edumazet@google.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afoF_cHfl6ygcupM@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -h0cNICznI3debzjSXnNbNcRByDmvshDrHdtrD6iz0Q_1777997478
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
>On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>> >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>> >
>> >virtio_transport_recv_enqueue() skips coalescing for packets
>> >with VIRTIO_VSOCK_SEQ_EOM.
>> >
>> >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>> >a very large number of packets can be queued
>> >because vvs->rx_bytes stays at 0.
>> >
>> >Fix this by estimating the skb metadata size:
>> >
>> >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
>> >
>> >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>> >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> >Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> >Cc: Stefano Garzarella <sgarzare@redhat.com>
>> >Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> >Cc: Jason Wang <jasowang@redhat.com>
>> >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> >Cc: "Eugenio Pérez" <eperezma@redhat.com>
>> >Cc: kvm@vger.kernel.org
>> >Cc: virtualization@lists.linux.dev
>> >---
>> > net/vmw_vsock/virtio_transport_common.c | 4 +++-
>> > 1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>> >--- a/net/vmw_vsock/virtio_transport_common.c
>> >+++ b/net/vmw_vsock/virtio_transport_common.c
>> >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>> >                                       u32 len)
>> > {
>> >-      if (vvs->buf_used + len > vvs->buf_alloc)
>> >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> >+
>> >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>> >               return false;
>>
>> I'm not sure about this fix, I mean that maybe this is incomplete.
>> In virtio-vsock, there is a credit mechanism between the two peers:
>> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
>>
>> This takes only the payload into account, so it’s true that this problem
>> exists; however, perhaps we should also inform the other peer of a lower
>> credit balance, otherwise the other peer will believe it has much more
>> credit than it actually does, send a large payload, and then the packet
>> will be discarded and the data lost (there are no retransmissions,
>> etc.).
>
>I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
>state to account credit")
>and find a better fix then?

IIRC the same issue was there before the commit fixed by that one 
(commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with 
sk_buff")), so not sure about reverting it TBH.

CCing Arseniy and Bobby.

>
>There is always a discrepancy between skb->len and skb->truesize.
>You will not be able to announce a 1MB window, and accept one milliion
>skb of 1-byte each.
>
>This kind of contract is broken.
>

Yep, I agree, but before we start discarding data (and losing it), IMHO 
we should at least inform the other peer that we're out of space.

@Stefan, @Michael, do you think we can do something in the spec to avoid 
this issue and in some way take into account also the metadata in the 
credit. I mean to avoid the 1-byte packets flooding.

Thanks,
Stefano

