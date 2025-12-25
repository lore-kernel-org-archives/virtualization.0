Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C6C194A76
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766678144; cv=none; b=DeTWmeSW4futj21OK4KsC93uyvuNDBnqkuysI2Ha+V7ZETUxDkn4HBQu16xfl/62fOiM6snRiYKGT52Frv60n9gcbaywmx+Q/cirjDTE151ptkTrNRypIAoe9qsDO0vTUUUGfPVi8UoCS14ilq4mSh8Xghagu4kzb8eJ5ymI7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766678144; c=relaxed/simple;
	bh=DgG95W0KWoWtUbCoxucc6TeEUsImaF4Yq6XZDFST7nU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sff73BeP+KeMycBY943HAh+yKYCUTFeTcx+gbwbIbA0RSFeERAFqdTsMSg8GvRqF5cqAZpQwLt4RMnK3s4H2GKWjb5J9am1Z4cOZBi+SuKNbLdNmZBcFX6lDN1XXyErz7z0FDo/OTI2HzC1kDDrUSWhq1a/5xatEIIYUxt0mtsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaBHR8R2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaBHR8R2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29f102b013fso82258265ad.2
        for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766678142; x=1767282942; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hYaWKXWkYbIN4q4wZN9wEW98pBsJkuu1pUVxbOWJvx0=;
        b=jaBHR8R22sjSRKo4mwBOxXgbbCpX1JzaD9fZhQ63Bo1D85JOI3qZ4V1mu02ZwaqcFc
         99QLa/Z6Y7fjhuTf5DkNBh6c5aXTUI4SesJajkn21wwFidJP/u3Qd7YHDpymJFfk4zY2
         n7IClitcX6QjYxzE+hh73gfCTy2fwVxPghrXvTdP3GyA1rZeAmoPz6SIbnfG/SXqQNZN
         skiQq/VUTQx/+HDT3jnrRZjq2mbve9ZcaCg3xlwOIOjPbfth3Zl1hPi7s9IxA0tqZS/e
         eZHL9bAbwoFqG96i61nsoWFU4mCmTo6TTvUPsoXzIvHIRw45+ajyM3tfmKwysCsGWyXb
         q0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766678142; x=1767282942;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYaWKXWkYbIN4q4wZN9wEW98pBsJkuu1pUVxbOWJvx0=;
        b=pV1YSH2hyzaziw0pNGFSJCElBFgXcmL0zeJdV3Qr4jwYgpnXxyo/O+TYjtwRdYXyRV
         I4FGe91saJWXLZ1tKmec4guVdVArQPIOKvehn8/Ex8bDBcwqTYhpP+KDsfX00uIqbPBI
         8IOI/dbA0UP0T3eaCsen0kjrc8lavRqmZ4585PvGSkSQJxSSAtl4LzwRZE0IAArEzw/y
         KBMw5q7WJLxDgHjXnlTn+uWJiLNJLl3Ns7a7f+HsL1ZQskwUCnH5Vonip/JhHF2+r/WM
         4oDLk/T/CAmgRfL3MMVzn8Kontq5Uv8xbtiJOtINwWBySlwN4hwJd031jqT6V5aTWUw7
         6g3A==
X-Forwarded-Encrypted: i=1; AJvYcCW0F5BvM0wHP2ZfOZhdLjzLjn+bxpwj65vAXblbTIh975PHgK7pfWYF1vEAuffJv2jaYHk6leuy3H0PzPVI/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaRKeqjgRRnLtXBVElyxVMO07rmVCPJnWSSZqBg89mx6m+Cf7n
	/Y+HlFf/XeGRhEseTa94u2OEWxgeHKD2am+IkTyjBm0YFq4eE3f4J/xE
X-Gm-Gg: AY/fxX5EsbBIfSm0AIVcYCNIwOSaQ94PWnLnUMpgJ+VzjX+yuoRx3ySp+y1Cz5vEhQZ
	rATD4UEAYvsNpFgy2P9UOjC6oKcVwyX5MMCd0KACYX48RJhC8URToRV2+YxYKETjsjeWC5wTprE
	GsW/Cfnu2YvykFfKvKyYFoDav/HXy4wKExNQzV4ch3h0mty7Fn0J0DftF+SUndXW8JVQzlEA9zY
	oIE0I9sh0svfXP2DojwZvgWNomuklMthr54oAEUZjE1vg3yjKcJXtc34fTFAYBE2JdHG7SSei4u
	FNQ8Xcqtke64rj3aeQpX8+KIcHGFZQ/ltD56bQJIDj5+5rB1vXhdT5Gx6nmDAdbJYU0W3fhGcL4
	sVuzsQzaWvZe43jRHb1v0vvbDwpuIZhSWP0V2o3+qr1FdG3cbD05T3uxKnPywa/1AI7YVp2D+X3
	bt4kPx04LqZ5symFmBXvodENDNYlNNe6+6Ywt5vv0o5HFRy5xrLPgQlJ8eSRbpcQ==
X-Google-Smtp-Source: AGHT+IFjaNIMrol5SdAN856m9AmK7B5O/amLAW7CnntJVFYaTER95zxgN8oN1gQDiGKwdhTwQiVC5Q==
X-Received: by 2002:a17:902:da48:b0:2a0:d33d:a8f0 with SMTP id d9443c01a7336-2a2f2a4f5acmr169647525ad.50.1766678142511;
        Thu, 25 Dec 2025 07:55:42 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:77e8:13fb:83fb:4ed6? ([2001:ee0:4f4c:210:77e8:13fb:83fb:4ed6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c839b7sm185337805ad.37.2025.12.25.07.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 07:55:42 -0800 (PST)
Message-ID: <dd4d01d7-29a8-43b3-bb5b-f50ea384aadb@gmail.com>
Date: Thu, 25 Dec 2025 22:55:36 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <75e32d60-51b1-4c46-bd43-d17af7440e74@gmail.com>
Content-Language: en-US
In-Reply-To: <75e32d60-51b1-4c46-bd43-d17af7440e74@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 23:49, Bui Quang Minh wrote:
> On 12/24/25 08:47, Michael S. Tsirkin wrote:
>> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
>>> Hi Jason,
>>>
>>> I'm wondering why we even need this refill work. Why not simply let 
>>> NAPI retry
>>> the refill on its next run if the refill fails? That would seem much 
>>> simpler.
>>> This refill work complicates maintenance and often introduces a lot of
>>> concurrency issues and races.
>>>
>>> Thanks.
>> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
>>
>> And if GFP_ATOMIC failed, aggressively retrying might not be a great 
>> idea.
>>
>> Not saying refill work is a great hack, but that is the reason for it.
>
> In case no allocated received buffer and NAPI refill fails, the host 
> will not send any packets. If there is no busy polling loop either, 
> the RX will be stuck. That's also the reason why we need refill work. 
> Is it correct?

I've just looked at mlx5e_napi_poll which is mentioned by Jason. So if 
we want to retry refilling in the next NAPI, we can set a bool (e.g. 
retry_refill) in virtnet_receive, then in virtnet_poll, we don't call 
virtqueue_napi_complete. As a result, our napi poll is still in the 
softirq's poll list, so we don't need a new host packet to trigger 
virtqueue's callback which calls napi_schedule again.
>
> Thanks,
> Quang Minh.
>
>

