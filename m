Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A1341678
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297021; cv=none; b=I6cqjMoYZyA18LwsuI5t7dX+uyFSz4DrrWKDk/nNI8jVu9LObyUe5Mth2mb1fhooOszaXS6QWIx6T+FWaBSKDOLKdjRbuvjslzY20lsT22aDDMoybhmwk06cXM2RZTsmhyIpIp+k6B3jHM5RFOXmxyqb5cYrY0auUN8+aBED22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297021; c=relaxed/simple;
	bh=i7jmKtKg7PeuT25Uc1BWE7cT/g0kspLdiSl6D9EotN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=X/Zhwf5dv8Wvj6LsqXv28tc+qZcdbOA55RpGQtaceCp3ua8AVZYuPkMSkTab7kJhJm5uW1Bnd1IZ2IQ5LCUfW2KD4ZSYTy3uUJK+rkmT/nBn8//uQZ/BRmNGXkHnJ3xB08IpFK3V55d/+AfOTU2BXyCLG/wAYIy8A2xRce5chw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pi01Ba6u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pi01Ba6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768297018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pg4CF8mbdvXgdlxK3eag1qF9zBIQiZ4lLsv36mMbgWM=;
	b=Pi01Ba6uThWnTNnUI8c1UqU1ZaIBNclqiwTbJqr318FXEcmttfMlzyX9khiVn0zHFQVUPv
	zxlKYYZO7/A0QpD1v5DhtstFx8EhWifUc76o/HGKd1W/kmvPUveAVoo1eecvdFnuwnNznO
	bG35TAYCm0bX6i6i1oH0iJzrJvekuAk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-syxbLfUmNQmbdtFcA31URg-1; Tue, 13 Jan 2026 04:36:57 -0500
X-MC-Unique: syxbLfUmNQmbdtFcA31URg-1
X-Mimecast-MFC-AGG-ID: syxbLfUmNQmbdtFcA31URg_1768297016
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so76454025e9.0
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 01:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768297011; x=1768901811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pg4CF8mbdvXgdlxK3eag1qF9zBIQiZ4lLsv36mMbgWM=;
        b=XCRGMECCW5GwbUPeSuAG6qSamKGcUysDDIzoPLtNar0D2CW9Uq5eL24XzLj5Gye2aW
         7D6hakcnWDZrJJ31pMZ7nnFGLDWHn7VctS4wU51oJO2/UecF44HFB2HRyK2lZvZmjU7Z
         M/+EV5tLUgPRk0NJtLKJ++/TnGPAzLhhGrvCFVW8gcuo0E9G0tjf3Kffk8qVtnsPWlB9
         QkFFkH3ppXX2t8cYuZ8EMYl0M71Bd5f07ECAPf6W8IJIQOJ9x4JXtGy9eYX0cZu0BAaA
         wbM5UKE3YB4omWM4lSlSxr6qo9gTDMJX2LZyRmzFfTYQMlhxDKADqHLD5pV8KUqDB03R
         Wsow==
X-Forwarded-Encrypted: i=1; AJvYcCWa0sAK5dvQeE8dPy8mGdYRU4+deElw3qS98UefKBDF4gXkpBsmugb7pre1H9NGhelczejTenGidWNAqhuN4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+0sNtCNfl/rKjzxVsjzjuXAUHASxSN+/5+nxeNqpCRhfmhV8C
	dhY9fGwXxHsKih0xNV7dLq/Cwb/p0IDUKIUYI1+D+DOoS7eLqtY5DXqzeYd/og8GS77p82vGoyW
	rMZb61RAwTRx2ChKcsTqVLQ3vrNOsVzQWbewvvY5Yg960Ic1cx5gybpHgY4TLGMQv4ONf
X-Gm-Gg: AY/fxX629sMEAevA4FGleS7mSXCm+FjH+S55LsZDnpSkOIOc3zpc6AzA9I5HeeVjSOl
	ssOjmi2/onp+iyGCjRtVNjPa6TkCYtRCt+Fla6F84+j1a8GklHHkMPhcHr+axtfGl+/fE5XD9fN
	Xf3lqeeQI+5WGtR7mvMbRQjEWmSXb6JJ6CBY6V+87XpKCfIkj88/HicrEEZx7UhrPWVAhUK50h6
	F8Bs42nUbCeq08D+4RyrKykEFGwQYNYb+6ZuKQTMLO8+CoJCJOMF1q+uhdSYCbCw3dkTmuqBwbe
	26qOkouBRGa6iS/R1w5RM8i+vyNuTz9io6a9m3KZbIqaPBgY5yj1z4kb2rwMCDMVQPt7lLY43QX
	WMwrPWjSPmixu44L3a3OGH+/KTzXYoV1BPvLV85ahpNBnRyCUHzVyIua05ynv+g==
X-Received: by 2002:a05:600c:1394:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-47d84b3467emr250088685e9.21.1768297011480;
        Tue, 13 Jan 2026 01:36:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBInHZFJ8RidwkWLMCKS42wGE9AndYw8hKlz7EsNrZzGfvzlSbcNPT7twl1koVSE4j25wDOQ==
X-Received: by 2002:a05:600c:1394:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-47d84b3467emr250088215e9.21.1768297010851;
        Tue, 13 Jan 2026 01:36:50 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5fe83bsm43257713f8f.38.2026.01.13.01.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:36:50 -0800 (PST)
Date: Tue, 13 Jan 2026 10:36:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vsock/test: Add test for a linear and non-linear skb
 getting coalesced
Message-ID: <aWYQRK-fRHOqQNc8@sgarzare-redhat>
References: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
 <20260108-vsock-recv-coalescence-v1-2-26f97bb9a99b@rbox.co>
 <aWEqjjE1vb_t35lQ@sgarzare-redhat>
 <76ca0c9f-dcda-4a53-ac1f-c5c28d1ecf44@rbox.co>
 <aWT6EH8oWpw-ADtm@sgarzare-redhat>
 <080d7ae8-e184-4af8-bd72-765bb30b63a5@rbox.co>
 <aWUk0axv-GZu7VD2@sgarzare-redhat>
 <0b15644b-9394-4734-9c0e-0a6d1355604a@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0b15644b-9394-4734-9c0e-0a6d1355604a@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mqycIRcWU2MfqWgiPQIg7w2WSDY0Xfk8enxyv6yF8Ag_1768297016
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 12, 2026 at 10:20:50PM +0100, Michal Luczaj wrote:
>On 1/12/26 17:48, Stefano Garzarella wrote:
>>>>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>>>>>> index bbe3723babdc..21c8616100f1 100644
>>>>>>> --- a/tools/testing/vsock/vsock_test.c
>>>>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>>>>> @@ -2403,6 +2403,11 @@ static struct test_case test_cases[] = {
>>>>>>> 		.run_client = test_stream_accepted_setsockopt_client,
>>>>>>> 		.run_server = test_stream_accepted_setsockopt_server,
>>>>>>> 	},
>>>>>>> +	{
>>>>>>> +		.name = "SOCK_STREAM MSG_ZEROCOPY coalescence corruption",
>>>>>>
>>>>>> This is essentially a regression test for virtio transport, so I'd add
>>>>>> virtio in the test name.
>>>>>
>>>>> Isn't virtio transport unaffected? It's about loopback transport (that
>>>>> shares common code with virtio transport).
>>>>
>>>> Why virtio transport is not affected?
>>>
>>> With the usual caveat that I may be completely missing something, aren't
>>> all virtio-transport's rx skbs linear? See virtio_vsock_alloc_linear_skb()
>>> in virtio_vsock_rx_fill().
>>>
>>
>> True, but what about drivers/vhost/vsock.c ?
>>
>> IIUC in vhost_vsock_handle_tx_kick() we call vhost_vsock_alloc_skb(),
>> that calls virtio_vsock_alloc_skb() and pass that skb to
>> virtio_transport_recv_pkt(). So, it's also affected right?
>
>virtio_vsock_alloc_skb() returns a non-linear skb only if size >
>SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)). And that is way
>more than GOOD_COPY_LEN, so we're good.
>
>At least until someone increases GOOD_COPY_LEN and/or reduces the size
>condition for non-linear allocation. So, yeah, a bit brittle.

I see, thanks for clarify. So please add all of this conclusions in the 
patch 1 description to make it clear that only loopback is affected, so 
no guest/host attack is possible. (not really severe CVE)

>
>> BTW in general we consider loopback as one of virtio devices since it
>> really shares with them most of the code.
>
>Fair enough, I'll add "virtio" to the test name.

Thanks.

>
>> That said, now I'm thinking more about Fixes tag.
>> Before commit 6693731487a8 ("vsock/virtio: Allocate nonlinear SKBs for
>> handling large transmit buffers") was that a real issue?
>
>I don't really think that commit changes anything for the zerocopy case. It
>only makes some big (>GOOD_COPY_LEN) non-ZC skbs turn non-linear.
>

I see.

Stefano

