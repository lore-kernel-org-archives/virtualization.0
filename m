Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166001F78FD
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737096668; cv=none; b=GGByZmHmVXsRYRkOMqS+1DgRGjnVMzPlRBlSuIQb74x3JRHFqQPMbFx/uEhIqJ/OwYz9e4pJH3RnohwSHEuSfcrUzrTSDcUnf5Hj18Winb0VV6353gFwko98pLVtX2MUNkHFq+VjCrvFxRYIiPXZZnTr8J8fSmQWCQZ6UX3oT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737096668; c=relaxed/simple;
	bh=2u2YVfoxLd7Cvn3rxair1v5iw/Nh3ozWpr+rXKeCIOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmV153KOIksYcUpOkHBfqda95Ayjr8GjNFN2hc7d78SPHgnJVpP15ddQu9aNNyz5xvYp7gwe6uhFgOm+2Tf/Etp74J/Hz7NC+TViwGvAQjnn+5n0HDzNTtr7LyvXW9PxUYem+cPvRurtpqPcE/bB6kQnkIfRKPe+JHryw8j53CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=rhfMyAa4; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="rhfMyAa4"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABD27607D5
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 06:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1F60Iek1SoN for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jan 2025 06:51:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0E2EB607C4
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E2EB607C4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=rhfMyAa4
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0E2EB607C4
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 06:51:03 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-21649a7bcdcso31226285ad.1
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 22:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737096663; x=1737701463; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxvFAOToWR486xbEC+Pgvw2Hl5TN/daUG+P6fxzoIwU=;
        b=rhfMyAa4RWScO6IsT2B1P8x9cFaAZDL/8LaAjdbA/9zfqN8xdj0JSUz857J/hZy+65
         XDBNql2rdJs4Rlt7emXQQnBFMjmCWI3VKpfObiaiL8Mq3Qffiplef/FMoVJpfDq78Ryh
         ANkAOfs7MdHvz7Vx0QcxbZXH2CYzuJewnkAkbQpHNOdm75m8Mnbbeu0sIzz7JJ0CoeDT
         bfElYoD6XyYZKY3en93TzEPkfpX33AiWyl61SqXhSz3Dk6CddrzB2tUJVn5XPPjzv6/C
         x+AT7gx+R04vrTVbpb7h7BN3X1Cfs2R9QWySPf+ugPUca12MKp8UgsMt6Pfb4sFYj8td
         dV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737096663; x=1737701463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxvFAOToWR486xbEC+Pgvw2Hl5TN/daUG+P6fxzoIwU=;
        b=W8I3xJXedil4IRbgsUQ6QweGMYIMF0a0Tdea5XEsJq7v0T6OczUyAgwB7iFm76ivJF
         E4zeBMerj5xDZFPW2p1Bx7LTUjGPWORIGbVRuPhGtxBWmFyW1sWcYRpT0UXPhx6Y860i
         2TnGXC7SUHrEnnC9lZ1juKpTj8fZ6NKu+2CXhFQOqqO+/UE3orJnP6g9ms/Ro9FU3ngg
         Mvq3zICx8JEn+eWRhHKNUKjMCU58RqaJQFlxjNMOLRSzvTOuHGvj+c3DOEym504K2yQH
         nfIp6DWkTRGTC2aYahlFBnmG4g6wi4BaGGtiOc7AS+iJ2QQ+FEw3MAvZNv2MtUf+WM6a
         /S8w==
X-Forwarded-Encrypted: i=1; AJvYcCWIYCS3Ff0n5kWaL4/RKpzc9Mr6r7xFSDrPyvN90diIHpEe8X2Ayr/IPQunmf7L3k3rcWM7P5WbK0sQQVQwpA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywr9hthKEBdJGG3MRfxRvD0ps0JkkpOYLautpxN4gcr7aa56CyU
	cRFgpljWjjUbHhbLdnB+35rCGQFxzVOiYBFIB5EgPlBII0EWdJVq1QrPaX2XfVE=
X-Gm-Gg: ASbGncthdJQbr0aMPeFWL79tHpSejutrKLoYEY5ID/GYzKf2u7kB97ZomWqknKQQpaG
	OhFlogKuUsLo+UlNTq58C9nbH8Pz9qH+3aXVOMGr1QqfCUHiQcL5/Qm5NljiqAyKXXv0ho/ZTIS
	Tg1FMBF+J5oXaHDyc9CHN0OXnaYcxEnj+L6PAdvbGnE/83iF6ifxOr0A62vO1u71BRqwuBxnBCE
	Wdq6Vs7AdIjmNQne7+6Q2posNJEkVkvEwlmKGMmdi4AUsMykZNUm2Rh5JxEVBnt3fM=
X-Google-Smtp-Source: AGHT+IHEp4jaCJNggzbZ2ij/bh9rzGAo+Mt5lP+zOwoLCq8mYHxh8b68OP5RujQgDJEqW/JvnG0eSA==
X-Received: by 2002:a05:6a00:2296:b0:72a:8b90:92e9 with SMTP id d2e1a72fcca58-72daf931244mr2463308b3a.5.1737096662981;
        Thu, 16 Jan 2025 22:51:02 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f07b9sm1110387b3a.3.2025.01.16.22.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 22:51:02 -0800 (PST)
Message-ID: <1a419eb7-0ca4-43ea-9420-da0c35e5f1a9@daynix.com>
Date: Fri, 17 Jan 2025 15:50:56 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/9] tun: Unify vnet implementation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
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
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116031331-mutt-send-email-mst@kernel.org>
 <678901682ff09_3710bc2944f@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <678901682ff09_3710bc2944f@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/16 21:54, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
>> On Thu, Jan 16, 2025 at 05:08:03PM +0900, Akihiko Odaki wrote:
>>> When I implemented virtio's hash-related features to tun/tap [1],
>>> I found tun/tap does not fill the entire region reserved for the virtio
>>> header, leaving some uninitialized hole in the middle of the buffer
>>> after read()/recvmesg().
>>>
>>> This series fills the uninitialized hole. More concretely, the
>>> num_buffers field will be initialized with 1, and the other fields will
>>> be inialized with 0. Setting the num_buffers field to 1 is mandated by
>>> virtio 1.0 [2].
>>>
>>> The change to virtio header is preceded by another change that refactors
>>> tun and tap to unify their virtio-related code.
>>>
>>> [1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
>>> [2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> Will review. But this does not look like net material to me.
>> Not really a bugfix. More like net-next.
> 
> +1. I said basically the same in v2.
> 
> Perhaps the field initialization is net material, though not
> critical until hashing is merged, so not stable.
> 
> The deduplication does not belong in net.
> 
> IMHO it should all go to net-next.

I will post the future version for net-next. I also intend to post the 
field initialization for net-next too.
