Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FEA225A23
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462199; cv=none; b=QBfomblNqvKOgfq8JdkDQsYnzcJnpxBvDVxb988DJT1MpnasoE+QahxNEnWlHSnqeRkRgK2rWw5ko2nEcnm/mp1G7gEwU7do++RW37o79oCnRK36Ovqm1U/QiitgURSuksohuCO2KF9+PssDOTPXTYZPk4OJs//f7/pFm88HKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462199; c=relaxed/simple;
	bh=1j1LyNigN5AHD08zHiexmmDlfFxiEshK30KkAloLUzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=g1dGsRdRgUPKA5BHt7B4pHuDbEWwMm7dn/Kg7RjvniuyD2dfq064UbxJ8q6SOE0b5pRJvRjXwOB97rhEp8xsco7VTnqpTGc5rXh7Tjsv7uR+ziN0s9yEBOO/2yiTNEtHmcKQ1XG877n+EVlZju3K38o8emmIFUeORJQNOTTffyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=giBD+iCt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giBD+iCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751462197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sy4nWTHPkpPaaqEvDu9i4dBMnt5aD41NB3JYr++qf2M=;
	b=giBD+iCt241No1VQH+/Mm1ZL1Rz74zPjHtTgtkLG+Da7xCYC7XjmZm2+jc+NNWYfNEuvbY
	pn1CUcj/TGiJcHQzGTdvnGW4sf91RC18Q8pdV4/AoGfhUz9Eqbyv3+BPjzSQqh91FkgWB7
	fawukV79xKn7aT3FQsriAh7nT4/NqNk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-9xQ5HjiXOiC8wH8zgtzV8A-1; Wed, 02 Jul 2025 09:16:36 -0400
X-MC-Unique: 9xQ5HjiXOiC8wH8zgtzV8A-1
X-Mimecast-MFC-AGG-ID: 9xQ5HjiXOiC8wH8zgtzV8A_1751462195
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451deff247cso37106655e9.1
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 06:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751462195; x=1752066995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy4nWTHPkpPaaqEvDu9i4dBMnt5aD41NB3JYr++qf2M=;
        b=dfgYUprpAmJi7qGFyZi7+oeWZVHdw5zXjweqcZCljxaeUl4fjSFCixTWfv7Zsdld+z
         ckdpvjK+KhBxVFNfcBo1nY+gsMQq/uzMyNtSInEheKskroXApLMt8CSFu8Ji0xEzMNDC
         6jpBD2xwaX8ixZ9G9UjvA7i1BCCW/rkE73ZCqh1rLZ/VtC78b094K0J9OqX/l49rPdJq
         KK0iYZWga5/HRyP1IInfvIRsc6tt1KJG1O2ptzC1gFmUU3x05fAjl7Q1Udi1XOyHCq22
         MV0mbOpa03rSDCXxDL1DP9bn1Jk/nC1NeCTDKa7NkPMW1hhS2pabCbEKfVtJKXEg4qp3
         nHcw==
X-Forwarded-Encrypted: i=1; AJvYcCX1o4r1lKn4GKiP+Osid9upkhIfQpfV+5QavlPJe8Kr5iTXJLfoIs04YqPh2c9kRavADcRKhnOvIc5xkf3JqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhkrsMR1PyB0fhJahQsmoXnqakWrXybgv6dNoUF0YzLtjxkzVF
	w7enQvRFJT/aSbgveMAAnotbwozJ4JlkJLvAjWQ4S9S0XMlkq8QvT+pIJgwu53hO4isB2RlZcER
	SAuDqLpXCiI/Q8SruCVfJRuqg+6bQ8iAmSOynTcRHUW2E8nb5UxpOWgirecUYi3/X5oL/
X-Gm-Gg: ASbGncvwXWPO7tlFTwo1/fiQxsme/2e2NtriSlH6bnEyP8PoPhyuJmAh53m2rqq6bel
	fUvmMcpHioxmTMRyEfpcPfd8fswap4JRUiEbICCGJ8PiF6WWH57s0m5xsJvNPMzyiDoZ7llN9XN
	3oi6bMCR15m/v7RjnG4hrpqLBF/Jg0CRI3NK+evN1IEjaM9wRJW44p5CGcfN9LKqnbYTnXx8O6A
	kBVlZSJfSd1Fb7jPJhiypzLFjliEEOh1YI4cURqu2Dx4Pu5fI4e+aDhxysY6vC4BXeBf319RrEu
	ehwBLpYmfrraBDuES+I9KG0tKsRe
X-Received: by 2002:a05:600c:c0dc:b0:453:45f1:9c96 with SMTP id 5b1f17b1804b1-454a3c610camr23628725e9.14.1751462193951;
        Wed, 02 Jul 2025 06:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK+MShUn1qdie/bqB3hm1XM6IQ/XjWSETD0pYwme5TdPq6afvGUkaA/cLuoccNQG7Dhu4OBw==
X-Received: by 2002:a05:600c:c0dc:b0:453:45f1:9c96 with SMTP id 5b1f17b1804b1-454a3c610camr23628285e9.14.1751462193306;
        Wed, 02 Jul 2025 06:16:33 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.164.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e72c1sm15900209f8f.1.2025.07.02.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 06:16:32 -0700 (PDT)
Date: Wed, 2 Jul 2025 15:16:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Keir Fraser <keirf@google.com>, Steven Moreland <smoreland@google.com>, 
	Frederick Mayle <fmayle@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 4/8] vsock/virtio: Resize receive buffers so that each
 SKB fits in a page
Message-ID: <3s4lvbnzdj72dcvvh2nnx4s7skyco4pbpwuyycccqv3iudqhnn@5szfvvgxojkb>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-5-will@kernel.org>
 <20250701201400.52442b0e@pumpkin>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250701201400.52442b0e@pumpkin>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oRt0zpSRahbMWT31aZ6oRXVqXKehBIbFXrut5uF6FSc_1751462195
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 01, 2025 at 08:14:00PM +0100, David Laight wrote:
>On Tue,  1 Jul 2025 17:45:03 +0100
>Will Deacon <will@kernel.org> wrote:
>
>> When allocating receive buffers for the vsock virtio RX virtqueue, an
>> SKB is allocated with a 4140 data payload (the 44-byte packet header +
>> VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
>> overhead, the resulting 8KiB allocation thanks to the rounding in
>> kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
>> higher-order page allocation for the sake of a few hundred bytes of
>> packet data.
>>
>> Limit the vsock virtio RX buffers to a page per SKB, resulting in much
>> better memory utilisation and removing the need to allocate higher-order
>> pages entirely.
>>
>> Signed-off-by: Will Deacon <will@kernel.org>
>> ---
>>  include/linux/virtio_vsock.h     | 1 -
>>  net/vmw_vsock/virtio_transport.c | 7 ++++++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> index eb6980aa19fd..1b5731186095 100644
>> --- a/include/linux/virtio_vsock.h
>> +++ b/include/linux/virtio_vsock.h
>> @@ -109,7 +109,6 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
>>  	return (size_t)(skb_end_pointer(skb) - skb->head);
>>  }
>>
>> -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
>>  #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
>>  #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
>>
>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> index 488e6ddc6ffa..3daba06ed499 100644
>> --- a/net/vmw_vsock/virtio_transport.c
>> +++ b/net/vmw_vsock/virtio_transport.c
>> @@ -307,7 +307,12 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>>
>>  static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
>>  {
>> -	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
>> +	/* Dimension the SKB so that the entire thing fits exactly into
>> +	 * a single page. This avoids wasting memory due to alloc_skb()
>> +	 * rounding up to the next page order and also means that we
>> +	 * don't leave higher-order pages sitting around in the RX queue.
>> +	 */
>> +	int total_len = SKB_WITH_OVERHEAD(PAGE_SIZE);
>
>Should that be an explicit 4096?
>Otherwise it is very wasteful of memory on systems with large pages.

This is a good point!

What about SKB_WITH_OVERHEAD(VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE) ?

Thanks,
Stefano

>
>	David
>
>>  	struct scatterlist pkt, *p;
>>  	struct virtqueue *vq;
>>  	struct sk_buff *skb;
>
>

