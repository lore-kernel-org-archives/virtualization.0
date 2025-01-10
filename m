Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA632054F0
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505954; cv=none; b=f1oqnrAJeHjrumIVNQitz94wy+8HrLC4xBlAwy0mJXi42QFzqAKn5c/ZnS9oTGI6Ae61AudOO/I9lgJVyo1hnG+oHzzoeKcdNhX5nQAhoO68HnzHICu9EP4vk0eUXga4hhvhdg6qptk9EkrOf3zjoO3ffdmGkxtSYmftaj+nH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505954; c=relaxed/simple;
	bh=xwTt7EqwBQG9jsW/MlOAUi0BI8IrI3gTou3huVPPuY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrEgOMEz/CyWwBUGfHqAWsirCX7oRbEqXnsZ3WLxwpc2uOpfX6yalING4gQs2xojjUFubW1vJ2ewdTOkObhhvwwHx487N/n+V1Yq1BjKxct6dyXGGx5gNr7mzGW7IUGAlgcnQL62j4uXAjJkgZWsyqqbccDGkqySS58E3j9zcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=dwK86jMi; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="dwK86jMi"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D02C4103E
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 10:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id olScTMUk-PSm for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 10:45:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5119D41036
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5119D41036
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=dwK86jMi
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5119D41036
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 10:45:51 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2165cb60719so33092395ad.0
        for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 02:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736505950; x=1737110750; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsqFmJrwySuAsgeQ23Hdp8zYfHgcqjGeQVThq/MnWD0=;
        b=dwK86jMi8fWxx88ej0WAETyYxWmK9ANghPB3/KIDCYp5uG5YQunrS7jBxrUYHu1Z3u
         VnRnu5KRXOy4bI6FsPYCa384NFtD87t8LgXWOSVxgKH0/3PR5yxxlVQLWUf+W6qVnb2y
         iU6hVmZzrqbVR1TgtsU8+dGyuyv0ElK4186/YKeD1tUbhO04xPghrRM8dcT9nkI46w8I
         Ad80+6LMaBEX1yDxzZFrh1UxfO0gmSQZbIkV5fz2GixR6dFxrJQx9g4/R5SdltI6iUNA
         QHAWRucmOSxjD0U1xKXV3W2pOy/jhGssaQG7nWDcsPYYvgKhsw+7Tq1b0RawuCRx9bwQ
         mrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736505950; x=1737110750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsqFmJrwySuAsgeQ23Hdp8zYfHgcqjGeQVThq/MnWD0=;
        b=UWP8/hH4elKJ4eynTfSqny7RZRwahdwKTKOqKXC4jruvLaOcuHfJAt36ByAqlnrmu9
         Iyst7n/KYQuWGNLOSziblgLgegfJ+lb7ag64JP6HfPz+CBRTkhWfYUh9yaRwPqRBIsZZ
         3SFPQiExkBIvKDqsP5hzthJvJ27Nvv2uuKJ2OLk1dWvEy76gBFoIfSRkI4QvKuWEZ3ak
         KI+HxU4BsJgpwbwcUaDJI5kZZLtFOZOBFvcJYIm2HVTcv81gyT+/o4NEUt8Il41cQsww
         U9KvfsHFrUViQQqVNX436VtZGPNThD0hcrfTRM6ZnI1al3jJ2RjaKa7XQ7x23ZSGmCjz
         +d6w==
X-Forwarded-Encrypted: i=1; AJvYcCVljbGjWOleHdGRTL2nvSTQefX4QftFw3hFaoOsP1GBEc4CL7S1PEZTofpqdJtksag6gqxz/PH202BuEuDTcg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz39cdUfJFxb3RDHIhYKyluFXUk7XtpFHnD+72p7SykBvlSjXK0
	r3lSoV61IhFuZPIdu4AXb41v3yYHkHQ+U+NiKyEEysgZsETY2BjEyzHDDfEtagE=
X-Gm-Gg: ASbGnctzZJQ7WlCxD4haCKIdoKGJ84kP3P5pZuRA4841PlfXYeuoFDyDLL+11WHo0rA
	77vCGmKzDby8UE7Jtpn2J/avhVJOV2ImURQy8fGpMNx6x9RAl97+crSarUV5/m6fM7mxt0NpHBp
	BalSEc+hlaiBV7c3EI3P0RSPbhlPuK/oxTZtwPZZ9CTLflIXNNnL0yLdUaNkuZ/AsBnfsI1uN1/
	aIOsQsUOIGedntLwHgVgg8GZrhrFBCta0IB288Yc8AY5PbWinsabb7jRzsU9Xn8+1s=
X-Google-Smtp-Source: AGHT+IFPsdQcQ1JqLrS7hF+DlyZPpDcSA6WD6jF46cfVg9u5bIjzxZ5xlWPHe2yN4Ld9eivHDLICVA==
X-Received: by 2002:a17:902:ecc5:b0:216:7cbf:9500 with SMTP id d9443c01a7336-21a83f36df7mr150799945ad.6.1736505950548;
        Fri, 10 Jan 2025 02:45:50 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e0dfsm11714655ad.41.2025.01.10.02.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 02:45:50 -0800 (PST)
Message-ID: <3a5001b5-9a07-4dfd-8cec-1e5f7180b88a@daynix.com>
Date: Fri, 10 Jan 2025 19:45:44 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
 <677fc517b7b6e_362bc12945@willemb.c.googlers.com.notmuch>
 <5e193a94-8f5a-4a2a-b4c4-3206c21c0b63@daynix.com>
 <20250110033306-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250110033306-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/10 17:33, Michael S. Tsirkin wrote:
> On Fri, Jan 10, 2025 at 01:38:06PM +0900, Akihiko Odaki wrote:
>> On 2025/01/09 21:46, Willem de Bruijn wrote:
>>> Akihiko Odaki wrote:
>>>> On 2025/01/09 16:31, Michael S. Tsirkin wrote:
>>>>> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
>>>>>> tun used to simply advance iov_iter when it needs to pad virtio header,
>>>>>> which leaves the garbage in the buffer as is. This is especially
>>>>>> problematic when tun starts to allow enabling the hash reporting
>>>>>> feature; even if the feature is enabled, the packet may lack a hash
>>>>>> value and may contain a hole in the virtio header because the packet
>>>>>> arrived before the feature gets enabled or does not contain the
>>>>>> header fields to be hashed. If the hole is not filled with zero, it is
>>>>>> impossible to tell if the packet lacks a hash value.
>>>
>>> Zero is a valid hash value, so cannot be used as an indication that
>>> hashing is inactive.
>>
>> Zeroing will initialize the hash_report field to
>> VIRTIO_NET_HASH_REPORT_NONE, which tells it does not have a hash value.
>>
>>>
>>>>>> In theory, a user of tun can fill the buffer with zero before calling
>>>>>> read() to avoid such a problem, but leaving the garbage in the buffer is
>>>>>> awkward anyway so fill the buffer in tun.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>
>>>>> But if the user did it, you have just overwritten his value,
>>>>> did you not?
>>>>
>>>> Yes. but that means the user expects some part of buffer is not filled
>>>> after read() or recvmsg(). I'm a bit worried that not filling the buffer
>>>> may break assumptions others (especially the filesystem and socket
>>>> infrastructures in the kernel) may have.
>>>
>>> If this is user memory that is ignored by the kernel, just reflected
>>> back, then there is no need in general to zero it. There are many such
>>> instances, also in msg_control.
>>
>> More specifically, is there any instance of recvmsg() implementation which
>> returns N and does not fill the complete N bytes of msg_iter?
> 
> The one in tun. It was a silly idea but it has been here for years now.

Except tun. If there is such an example of recvmsg() implementation and 
it is not accidental and people have agreed to keep it functioning, we 
can confidently say this construct is safe without fearing pushback from 
people maintaining filesystem/networking infrastructure. Ultimately I 
want those people decide if this can be supported for the future or not.

> 
> 
>>>
>>> If not zeroing leads to ambiguity with the new feature, that would be
>>> a reason to add it -- it is always safe to do so.
>>>> If we are really confident that it will not cause problems, this
>>>> behavior can be opt-in based on a flag or we can just write some
>>>> documentation warning userspace programmers to initialize the buffer.
> 

