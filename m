Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA02556E
	for <virtualization@lists.linux.dev>; Thu, 19 Jun 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342634; cv=none; b=e5KhHp8uwsFhZ9GfeZREagJjqhm9qRjFOVjJhnkSpohNjM9pROSt9QhaA+2hpJBC3UFqbDnd6MHQWIMcO0/WOAZZx0Gg1HQ2Mf2ajSJw1etm51xCuQA1uieipGKTN1dU17kZE6yPNK6lHfowDP6u99sPliz7RM+TCH7ULRvlGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342634; c=relaxed/simple;
	bh=1hirRnewnVTSaRWGgBit3cpzA+mUHqZUrx6XP1uGhbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YB4FJMbNU69DrhpwxcJXpjzINWwu2XHYg3Qy9h7kPfPpF4Al12f9y3NwWCkQ2NDDmHtmAQrFLzW6nWG0Q5sxmv7LVrvcUGmWs++k8rYQ5cyapqQsXVkgvqKA7nSM4Q3KDxwgzyKYbpAyOw/RcEaMfNqF76He7N4rZPy+cYPpJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P64a9e6V; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P64a9e6V"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2349f096605so12888635ad.3
        for <virtualization@lists.linux.dev>; Thu, 19 Jun 2025 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750342632; x=1750947432; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hs5sTPL4UKP6A3I0eYJSr3E+nHFf8KogN1avtTdVl5M=;
        b=P64a9e6VvXzhT5NZif5HePb9xlQXVxA122mFGIyOsbbMSOeehHIZSxQldqIzCW/ncX
         Qpxw+majC94MnO0iXMOoaiFGpIF9wL/qJp1yj4aMDmq41v5ikz/SotITbTv9OfOVFPtU
         wQEpaBfY+tSZOf5fR8JHM0RoOy+MhrnAOY1Yz8Pri9aKri+gXBlhaZCNsmlT58pBmaFZ
         f7x0m1ep6Ls3l5rHdALZjOo690dqRO85jXUwHmIkmz8IjU0+2TWvL8vf6T9Xd1qvXccN
         TJNehV6sXH3gN3IqTgb+5h3XekLDkKBjdjadExXt4lqQmrjt+qZT6byk2z4ExIw8yaeu
         sABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750342632; x=1750947432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hs5sTPL4UKP6A3I0eYJSr3E+nHFf8KogN1avtTdVl5M=;
        b=hP9KyUUSBlkL75+0TOKTlXMp9lSpc9OhElRAC0SNxXEwfAb8OEgSBVFifwHITeNYB0
         caf3LPYfrYtWZ9eEytsp7/5k4ulduSTQmq078F/t597vzd5kCip6EBMZG6mx5qbjKKUP
         L1ABekWT7gsAU9zw3HAGIQa/GE+csMHekwNYz226KTOfDCI4XMo/0opV2eE4NXTjaoqr
         wVuEjWLX1dRsSXfm2GNEJCzQamBS5L9cfMKEASPStBPJ/8FWume6N6sChqBz84RRRlia
         S4A5NClSRObOSZEOoKDuFvJbI2rnYwDm/uqQiczH4XWuFNYGqBZC1e0NaYK4/Mg0fXwd
         bwOA==
X-Forwarded-Encrypted: i=1; AJvYcCXo50VB6x9j1hj3DNPFPGTxhq2eNG/RK/iy7zGPvGeulzIDiwnvsIzFD8/e/IFXXkaNC+4UwAD/ahJhXfwdPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHvroOLEhS9yoiKHzXD8NtLrH/4jmBBamncOvcOC21lh5vvCY0
	wjLTFRkXkzfULPP3J5ExW37rcmu6LFxd0KRtj/Ik+cPnBJYBIbVBoWtO
X-Gm-Gg: ASbGnctglB269W+INfsfce3BRKLlJzlnNwmFQlFOro2kh/M9Ex6xpOyn6rumLqIFCM5
	GdykFLDLiMa3SfABe0hCmqOPmlTbtZuaKLQLMghYOWEmtV9PaIb4ZcgITEr9GIGM6SXVshZnew2
	F0Bq8mm6oa0OhFHTIQwBpGWc12QhQ+5tkwkI/6G+77AOoPAMrCiRkt+fh4TAoNrurVsCaNuH9jA
	To9PtPqEI9u8/Eb7SKJdPIjy20/bLPtE5xErjDuQMl7by2wP4M7V6U66NqVkBnDbEaOiO11g7XQ
	qMyMzC2G4ULTGUmFDIBOWyG9fmSAYXecK53I+1ib1OwedCq5TMYRr6idR9JZ+uRFYWL6KxTPc8h
	MH72Jnk/OU0u2+aF5cAMG/xxyLaLbwf1zMWC/07U3
X-Google-Smtp-Source: AGHT+IFirRO1ynx4PNieJwh+/qxRIudXvdXESLhzB5PFfPGxqyne4FswnV3bsltUa6DtqhYDvrtYcg==
X-Received: by 2002:a17:903:b88:b0:234:9094:3fb1 with SMTP id d9443c01a7336-2366b3c2d82mr381111275ad.35.1750342632036;
        Thu, 19 Jun 2025 07:17:12 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:5502:31a7:8320:fc5a? ([2001:ee0:4f0e:fb30:5502:31a7:8320:fc5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a1f93sm120183875ad.79.2025.06.19.07.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:17:11 -0700 (PDT)
Message-ID: <9a38a134-3ce8-4c91-a7e7-2a162cbf3b7c@gmail.com>
Date: Thu, 19 Jun 2025 21:17:03 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] virtio-net: xsk: rx: fix the frame's length check
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250615151333.10644-1-minhquangbui99@gmail.com>
 <20250615151333.10644-2-minhquangbui99@gmail.com>
 <20250618191111.29e6136e@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250618191111.29e6136e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/25 09:11, Jakub Kicinski wrote:
> On Sun, 15 Jun 2025 22:13:32 +0700 Bui Quang Minh wrote:
>> +/**
>> + * buf_to_xdp() - convert the @buf context to xdp_buff
>> + * @vi: virtnet_info struct
>> + * @rq: the receive queue struct
>> + * @buf: the xdp_buff pointer that is passed to virtqueue_add_inbuf_premapped in
>> + *       virtnet_add_recvbuf_xsk
>> + * @len: the length of received data without virtio header's length
>> + * @first_buf: this buffer is the first one or not
>> + */
>>   static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
>> -				   struct receive_queue *rq, void *buf, u32 len)
>> +				   struct receive_queue *rq, void *buf,
>> +				   u32 len, bool first_buf)
> I think Michael mention he's AFK so while we wait could you fix this
> kdoc? I'm not sure whether the kdoc is really necessary here, but if
> you want to keep it you have to document the return value:
>
> Warning: drivers/net/virtio_net.c:1141 No description found for return value of 'buf_to_xdp'

I want to add kdoc to clarify that the @len must be without virtio 
header's length. I'll fix it in the next version.

Thanks,
Quang Minh.

