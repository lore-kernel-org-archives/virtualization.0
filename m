Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DBF20C490
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438646; cv=none; b=RhBaDcXrIsvBIstcgLxjh2ZA9YaAxR2qhzdXgZxaSca8CFZA2VndzQ8od8/FVxJWZvt7LFe8nltw/hK42lXKfl1kzShAWNWAPtuoDuUnWBh6wRkXD6fhs9zrQdlD4kCCs+DpWr+9tW62gCgx5322ZektPJgFRL1v2ssGR7xFGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438646; c=relaxed/simple;
	bh=mfXNeTj+Q8ZX0NBisxbi4QQyQ/0LK4y+WrTTR40VPyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qvw8iAEXTGJyLLCVi9Kr47vaiV9FNpbYpzI/OPeN16ktJ0BOvHELKa5ewqCuhwPyaq6hQJUq6Bifd4hfXszQSCf2ARLuN1utIBot69j/lo54BTGwu9npoM82Plo5h92TNXFmeeCRjQGyZzaWQAiBlrJCx5GqViav4ES7qMxVLos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=akZK25EO; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="akZK25EO"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42AD38386E
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 09:24:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w6SLNo-r-376 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Feb 2025 09:24:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CF6CB837C0
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF6CB837C0
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=akZK25EO
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CF6CB837C0
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 09:24:02 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-220bff984a0so10628425ad.3
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Feb 2025 01:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1739438642; x=1740043442; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+g1corMoWLkqgaHyL0dUry18PBH1WwZj6geDsmEd1Y=;
        b=akZK25EOaKUuggxmo4sFUO0SBEYlmZaEqia/9igEwguMT3mVPs6TjM/pExe8GOn45H
         /GBzCUj0iQgzM5h24MI/nnVhYnBRBqm+0fTScuNHHnLjNqp9WDWO0N5xBRWTh41vYvfH
         wsy8XzALXa58ruoPl+/XEPNN2A6IFgYjhNOmhdPeteZhxPV7np2SR00pRdcEOFRwYvVB
         Vl5tjVMWFlOqb57wVLTZfFbK2WMMyZTE+/IU/1Kl8qhrqt9Oz9WKTXrPOQ+bIc+Y9nc0
         49JAEi/+yDXeZu90s9TWVbGp5zRYa1lLOBzRyYn9uTXUVLw2r/UNS5ilg5T7jJoqHGmj
         j+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739438642; x=1740043442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+g1corMoWLkqgaHyL0dUry18PBH1WwZj6geDsmEd1Y=;
        b=FDyzNA20cnKXJOXhtyI6ikVkrokd+AZKYqYESoDp9KF2Q+Bjef9pwLvwArrDvQKrQy
         VqzWYVTlWYAX+JywIvrKVr14Q0qA3P8Lv41NlZUzyR+zQi46CXln+Xg/vFGKPGnj+TYA
         yFuQoPZcv6KTYj8rcdfFlahsrtIvgqoHGc83N5vAwgfBovpxnIvDE/LkqQtLyMfZzu1a
         G9B3a5E3BmZyy2HISz6mb3evxhWKP7GoNbZJe/OK+/IjyftcxnoajpH8tJDkav4rAWA+
         6AaAXKqFKrfAGdvpAcF/DPphwC5Uyj8qii+18u1HPrlRIz6ylfCqfhAQ+AoWERlDQ8o2
         gIKA==
X-Forwarded-Encrypted: i=1; AJvYcCWxPd8Bmw+rM2nqAA1d+i4m9HjkTnlAzaL3b8xLIE3e3KqRVDBQKv/iV6K2WD+ibcDXqlkeBDs7BSJu9OzH7Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyOGbM6bI97VoLQ5Ixz/STucWFMMZZbnsyEVvSdhnrHEbQnY937
	D+nabmce8e34VLRo9zWiLyn8u/sWBTDF9veSq4P/GVrKq9qG+UNnvlw7SQAFEwk=
X-Gm-Gg: ASbGncs7YmruUqwIClu4AJxLUqK06+crZElDt4Fevh5y2yxw99oumo7lECZ+tzeMfM9
	8LF36rYKL3OaWAXFMS5CXxl/5hP80hXJR3lwhYwsSGXlO1aEHJYkSG0flCDHl3xMTf9ZSMdYNVR
	hTLpmJlLMEuk8SxNQNp8kiFU3WsvxmbaLSew896xxZbCbpne9t4lO3W9147hmRrF15kGQAkAx78
	nTGiF/iQGfgVTOTqxkF3R9zOqSrHdJ98PQSawsJaYdeKvpPRlj99sDL+OT1lLKkyW/X8/JAYli8
	l2WDXUOSbTrjVDTmdCgYbXADhteD
X-Google-Smtp-Source: AGHT+IGF+4e3Af2SCI8Rg8n4coZI7ErejXVy5bxQnzx65sHDQNZjtZ7hhVxDzaYqpoDifzZ7gAKFSQ==
X-Received: by 2002:a17:902:e950:b0:220:c813:dfb2 with SMTP id d9443c01a7336-220d2153077mr52167375ad.44.1739438642097;
        Thu, 13 Feb 2025 01:24:02 -0800 (PST)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ad3fb8sm805579a91.26.2025.02.13.01.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:24:01 -0800 (PST)
Message-ID: <0fa16c0e-8002-4320-b7d3-d3d36f80008c@daynix.com>
Date: Thu, 13 Feb 2025 18:23:55 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tun: Pad virtio headers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250213-buffers-v1-1-ec4a0821957a@daynix.com>
 <20250213020702-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250213020702-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/02/13 16:18, Michael S. Tsirkin wrote:
> 
> Commit log needs some work.
> 
> So my understanding is, this patch does not do much functionally,
> but makes adding the hash feature easier. OK.
> 
> On Thu, Feb 13, 2025 at 03:54:06PM +0900, Akihiko Odaki wrote:
>> tun used to simply advance iov_iter when it needs to pad virtio header,
>> which leaves the garbage in the buffer as is. This is especially
>> problematic
> 
> I think you mean "this will become especially problematic"
> 
>> when tun starts to allow enabling the hash reporting
>> feature; even if the feature is enabled, the packet may lack a hash
>> value and may contain a hole in the virtio header because the packet
>> arrived before the feature gets enabled or does not contain the
>> header fields to be hashed. If the hole is not filled with zero, it is
>> impossible to tell if the packet lacks a hash value.
>>
>> In theory, a user of tun can fill the buffer with zero before calling
>> read() to avoid such a problem, but leaving the garbage in the buffer is
>> awkward anyway so fill the buffer in tun.
> 
> 
> What is missing here is description of what the patch does.
> I think it is
> "Replace advancing the iterator with writing zeros".
> 
> There could be performance cost to the dirtying extra cache lines, though.
> Could you try checking that please?

It will not dirty extra cache lines; an explanation follows later. 
Because of that, any benchmark are likely to show only noises, but if 
you have an idea of workloads that should be tested, please tell me.

> 
> I think we should mention the risks of the patch, too.
> Maybe:
> 
> 	Also in theory, a user might have initialized the buffer
> 	to some non-zero value, expecting tun to skip writing it.
> 	As this was never a documented feature, this seems unlikely.
 > >
>>
>> The specification also says the device MUST set num_buffers to 1 when
>> the field is present so set it when the specified header size is big
>> enough to contain the field.
> 
> This part I dislike. tun has no idea what the number of buffers is.
> Why 1 specifically?

That's a valid point. I rewrote the commit log to clarify, but perhaps 
we can drop the code to set the num_buffers as "[PATCH] vhost/net: Set 
num_buffers for virtio 1.0" already landed.

Below is the rewritten commit log, which incorporates your suggestions 
and is extended to cover the performance implication and reason the 
num_buffers initialization:

tun simply advances iov_iter when it needs to pad virtio header,
which leaves the garbage in the buffer as is. This will become
especially problematic when tun starts to allow enabling the hash
reporting feature; even if the feature is enabled, the packet may lack a
hash value and may contain a hole in the virtio header because the
packet arrived before the feature gets enabled or does not contain the
header fields to be hashed. If the hole is not filled with zero, it is
impossible to tell if the packet lacks a hash value.

In theory, a user of tun can fill the buffer with zero before calling
read() to avoid such a problem, but leaving the garbage in the buffer is
awkward anyway so replace advancing the iterator with writing zeros.

A user might have initialized the buffer to some non-zero value,
expecting tun to skip writing it. As this was never a documented
feature, this seems unlikely. Neither is there a non-zero value that can
be determined and set before receiving the packet; the only exception
is the num_buffers field, which is expected to be 1 for version 1 when
VIRTIO_NET_F_HASH_REPORT is not negotiated. This field is specifically
set to 1 instead of 0.

The overhead of filling the hole in the header is negligible as the
entire header is already placed on the cache when a header size defined
in the current specification is used even if the cache line is small
(16 bytes for example).

Below are the header sizes possible with the current specification:
a) 10 bytes if the legacy interface is used
b) 12 bytes if the modern interface is used
c) 20 bytes if VIRTIO_NET_F_HASH_REPORT is negotiated

a) and b) obviously fit in a cache line. c) uses one extra cache line,
but the cache line also contains the first 12 bytes of the packet so
it is always placed on the cache.
