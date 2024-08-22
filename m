Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4E9187339
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319829; cv=none; b=Kaf+m8Gj3IJ1wgOL5dqTSdtsoBMEIuDvcjMT7N2PalGy7VHBMjw33iFpFaGhCFfem62viuwfxmy1NI4Oyr3ESqri4LfyWv30YMRHe3SPmV4KvU+C5Y/dPTwwI+OHSAYzZYO8NidehwFAfnsVvKIBkkTi4UoLQUTJUaYj375wmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319829; c=relaxed/simple;
	bh=4DTPvFMQfbCOcsA/cWAusBJlQg6KkwobS9yOQvCxECQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZmmDOQKGXgIIaUCUS43Eqsr5d7Y7djpfAWa2AYibThYgvEZJ6vw08i2jm+7SdhsUSuXq0pDJS0Qk0pqW4tZuAnOVK++d7UVMRP8d9nYQrgjRAXWYzHmGhZYYIU3gkLFTE1NCC2plgaRaukxX5v3pqratnRRKYDXZkeGGlXN548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BInzf9xJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BInzf9xJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724319826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8qIeUkM1CiKs3TMZL6yOmsW5pxWTgVW610+XGajzQpM=;
	b=BInzf9xJxVVPWP7ArtgP3M7Vike97Z1K/+hbFLSH1gqYh5Lbu5ZxHpZqIfaEkKbYp36e3u
	fiouDpQheKvfrdEKpAGu+LIWqJeQhlNbYNiXJAfdA3Vin1cxz5imwAD6NB77cb3ssXD53v
	uhg+KWvnuvhdLnI9gpW7nNXVIAEx808=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-gVBvbf5aPdOVcc-oJrW8YA-1; Thu, 22 Aug 2024 05:43:44 -0400
X-MC-Unique: gVBvbf5aPdOVcc-oJrW8YA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4281310bf7aso4088725e9.1
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319824; x=1724924624;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8qIeUkM1CiKs3TMZL6yOmsW5pxWTgVW610+XGajzQpM=;
        b=HiY7P9hpT7yd9g8ajRVNo2l8BgaWsifdWJEqVKbJi/fTFd/nsnZY8cIWccyr71/lc3
         m73lW9seUXVVCcUxecMSK8/WKmGWm9LSQCndRjOJvADQOGMswC7fQ6kiUzBV3ZEdkYoB
         6vGe8k/sJtGZtwq8GtWR8uZqaTcl3RiTn+6k1ZMxD/o9S1v3Y40dg0nlqDT3+uyYibMw
         P2HWns6ocB75NRh6oColk/tI20ircSC2SqfW8EiRP3tfYfzf9ISh6WiuUITNgoEvLWp9
         BEbL/V9tsBcCGtn2y/LrK6VXIWK6zjADPAZHjPCRC4yb1baL86h0O20yRQTkEAy8XuLO
         t5cw==
X-Forwarded-Encrypted: i=1; AJvYcCX+vz/xfyxjeselWq2zDuZODxtThSz3e56kivLeK02JvXK+aL/5tyLYYZQ7cGuqMMS4f24BX0n+chRSVwGyMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YydcgqP41QHa7Fvo9s4Gh3uqihtxY1QieRRA3kEUnJPlWtVLMsm
	Tgjtw5ApPdUqB1LbejgtNnbEX7mCfBYLiQd74rWoFjvcQEPr2SXHKzpJNBoWuhaFQLxwJz7pWcD
	gJwpz3q9Y73oHV/84QxVWw1tTgZWHp0u6t0Dx9qUMKas8mPifihYvCy7H6QMFP4/8
X-Received: by 2002:a05:600c:8516:b0:426:5e91:3ff1 with SMTP id 5b1f17b1804b1-42ac59ae975mr9083145e9.24.1724319823616;
        Thu, 22 Aug 2024 02:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIEKSkfI7/NFqkljdf+QGKhzB85okjPLFADalUmPJd274xThySPNye+UOIXTwfR4XGddqCtw==
X-Received: by 2002:a05:600c:8516:b0:426:5e91:3ff1 with SMTP id 5b1f17b1804b1-42ac59ae975mr9082785e9.24.1724319822766;
        Thu, 22 Aug 2024 02:43:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70f:2b00:f928:47d8:c9be:9d87? (p200300cbc70f2b00f92847d8c9be9d87.dip0.t-ipconnect.de. [2003:cb:c70f:2b00:f928:47d8:c9be:9d87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c1e3sm1226991f8f.35.2024.08.22.02.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 02:43:42 -0700 (PDT)
Message-ID: <4df58ef1-b379-484a-aa5d-ef77a1200c63@redhat.com>
Date: Thu, 22 Aug 2024 11:43:40 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>,
 Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
 v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev
References: <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka>
 <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka>
 <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka>
 <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
 <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.24 11:34, Linus Torvalds wrote:
> On Thu, 22 Aug 2024 at 17:27, David Hildenbrand <david@redhat.com> wrote:
>>
>> To me, that implies that if you pass in MAX_ORDER+1 the VM will "retry
>> infinitely". if that implies just OOPSing or actually be in a busy loop,
>> I don't care. It could effectively happen with MAX_ORDER as well, as
>> stated. But certainly not BUG_ON.
> 
> No BUG_ON(), but also no endless loop.
> 
> Just return NULL for bogus users. Really. Give a WARN_ON_ONCE() to
> make it easy to find offenders, and then let them deal with it.
> 
> Don't take it upon yourself to say "we have to deal with any amount of
> stupidity".
> 
> The MM layer is not some slave to users. The MM layer is one of the
> most core pieces of code in the kernel, and as such the MM layer is
> damn well in charge.
> 
> Nobody has the right to say "I will not deal with allocation
> failures". The MM should not bend over backwards over something like
> that.
> 
> Seriously. Get a spine already, people. Tell random drivers that claim
> that they cannot deal with errors to just f-ck off.
> 
> And you don't do it by looping forever, and you don't do it by killing
> the kernel. You do it by ignoring their bullying tactics.
> 
> Then you document the *LIMITED* cases where you actually will try forever.

So on the buddy level, that might mean that we limit it to a single 
page, and document "NOFAIL is ineffective and ignored when allcoating 
pages of order > 0. Any attempt will result in a WARN_ON_ONCE()". 
(assuming we can find and eliminate users that allocate order > 0 fairly 
easily)

{kv}malloc allocators would be different, as Michal said.

No idea if that is feasible, but it sounds like something you have in mind.

-- 
Cheers,

David / dhildenb

