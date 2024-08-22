Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D21C6B5
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318857; cv=none; b=oTcRtahD5rlror56G5c07bVqmnvKVuli3UUBSSrECXdzq3NNdVotQkBxfKuZpq7oMo+QNXW8kY9LZiJaWyiL3lXR/Wmc4jUE0wq1eOwcrfcEXrCQMo8pLufiO/4iafUmJL5d/2gSvP3dnRCSYUW8kHHsxL4eUThenZN4q5HVLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318857; c=relaxed/simple;
	bh=oYY91fFEjEN9efKqyNhmWVch5Wj8/iFn9/fj6KslRN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KV4EHVIIacK3ufFF7UtPRgrTCubdUahKi9Xm8A9Aqs3Mlni2Gxysl/lBy5ILhLN6i8Ko5k82rXytDfTIPtaWbd5UxtRsNzHfs6TWn/qV6hGH0f5mCZcZadeGOJjXsaMRhCRHDGMmyCb1LShKYqpMRzBsd+A7fYHIBVbBi3nRWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAMc3/Z2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAMc3/Z2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724318855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H7a5jRzTUwzKcSW8d6oGjIu2DVuvdV+vF5MesYvhiso=;
	b=WAMc3/Z2j48iTUKoElgOr56vKdN/7O2gaTEaSYxcqJARctmE2jCGacyO63PafZVv3+czOx
	zVhMmPF7K3n9t4tJcw4wTXBo1TWpM/d7C+Ni7R+V1D22oWufl4V1jeUv6pwJ2fgdlvUebs
	ulJOQ1CMHQV1D65tnnnpWLnYmpnSIZg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-pd6NU0p_MliKr83UMbjWQg-1; Thu, 22 Aug 2024 05:27:30 -0400
X-MC-Unique: pd6NU0p_MliKr83UMbjWQg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37187b43662so321422f8f.0
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318849; x=1724923649;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7a5jRzTUwzKcSW8d6oGjIu2DVuvdV+vF5MesYvhiso=;
        b=e0Gwx9Na25b76ohGYPlZFV70d1ueMixAhSUBmTzkyvIDxTYZMyHre8nOoU7zx6OawD
         qbpDouGQbcVgIPzhkFZS9HWq6mpKH65zAaFoHB3I3Zz7HG2R67Iout54u4JCaGABadT+
         RQjZueQsqjf3mugh/kr7jA55ZUa/qMspwvxbGYE9Sp6Gh9BG/SSc2L4qNSIkrLDvHC1X
         xvIHbCplm3jRzTI3Jub1SgCqiR75QG4kvYHHOsih+IN+c39I+WVn7T/I1XQmbgmXFuEr
         slFxDfSH8eHwC8hLbRyuwlD0U6L+CxxBz5khasDm2sCSsoXO4CbICOvBNsHUJeRICxwd
         uQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5UjE6z8pz0sDiHitCM/I4wukPgsZPhkfTNxeEJtXe40ePP7suxIzN9htiIp0pfU3GO1xlXyJ1U5J0lABqYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHG99hYOxi4TkuupdU6tPDtMAaHOTjIRcWtwrXIMUCT7d8S5Bd
	tbIiWQyxirbp++T6dfGHqvn2D7f768jsk4uhxkUzldtWP0v65Jkgpajpgq/IOBNCb8vxyy4YM6a
	yz0dMWDSFlFShMdiciNpzX5qGuKhsVoGas0XbXkTxWfxgvDUeHUlKzEeAk1lfAuC1
X-Received: by 2002:adf:fd88:0:b0:368:4226:4085 with SMTP id ffacd0b85a97d-372fd57fde9mr2727806f8f.8.1724318849100;
        Thu, 22 Aug 2024 02:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIvBkhnYOVrxo0QhjznTV8+FVIepvOCubbXSHIQCjlleQDoXl7+u2Y1P0MDp2HHNne/hHLZA==
X-Received: by 2002:adf:fd88:0:b0:368:4226:4085 with SMTP id ffacd0b85a97d-372fd57fde9mr2727770f8f.8.1724318848180;
        Thu, 22 Aug 2024 02:27:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70f:2b00:f928:47d8:c9be:9d87? (p200300cbc70f2b00f92847d8c9be9d87.dip0.t-ipconnect.de. [2003:cb:c70f:2b00:f928:47d8:c9be:9d87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm18004545e9.16.2024.08.22.02.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 02:27:27 -0700 (PDT)
Message-ID: <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
Date: Thu, 22 Aug 2024 11:27:25 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>
Cc: Barry Song <21cnbao@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZscAtVskxgONe3gT@tiehlicka>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.24 11:11, Michal Hocko wrote:
> On Thu 22-08-24 10:39:09, David Hildenbrand wrote:
> [...]
>> But then the question is: does it really make sense to differentiate
>> difference between an NOFAIL allocation under memory pressure of MAX_ORDER
>> compared to MAX_ORDER+1 (Linus also touched on that)? It could well take
>> minutes/hours/days to satisfy a very large NOFAIL allocation. So callers
>> should be prepared to run into effective lockups ... :/
> 
> As pointed out in other subthread. We shouldn't really pretend we
> support NOFAIL for order > 0, or at least anything > A_SMALL_ORDER and
> encourage kvmalloc for those users.
> 
> A nofail order 2 allocation can kill most of the userspace on terribly
> fragmented system that is kernel allocation heavy.
> 
>> NOFAIL shouldn't exist, or at least not used to that degree.
> 
> Let's put whishful thinking aside. Unless somebody manages to go over
> all existing NOFAIL users and fix them then we should better focus on
> providing a reasonable clearly documented and enforced semantic.

Probably it would be time better spent than trying to find ways to deal 
with that mess. ;)


I think the documentation is mostly there:

"The VM implementation _must_ retry infinitely: the caller cannot handle 
allocation failures. The allocation could block indefinitely but will 
never return with failure. Testing for failure is pointless."

To me, that implies that if you pass in MAX_ORDER+1 the VM will "retry 
infinitely". if that implies just OOPSing or actually be in a busy loop, 
I don't care. It could effectively happen with MAX_ORDER as well, as 
stated. But certainly not BUG_ON.


"Using this flag for costly allocations is _highly_ discouraged" should 
be rephrased to "Using this flag with costly allocations is _highly 
dangerous_ and will likely result in the allocation never succeeding and 
this function never making any progress."

I do also agree that renaming NOFAIL to make some of that clearer makes 
sense.

Likely, checkpatch should be updated to warn on any new NOFAIL usage.

