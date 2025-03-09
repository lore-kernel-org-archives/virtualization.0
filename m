Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077771CAA81
	for <virtualization@lists.linux.dev>; Sun,  9 Mar 2025 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526634; cv=none; b=FRCUr91vkl7REMzQfLH/04K+Qlv16/yIAfU7uHfFH/Cr6g/RGT3WmbvJDkVIFbCBoClJeMX1ePWMCGRFY/QHgEyU0Ne2/EP1IXFBp3YUyCkNhW+g7d6wfc1Q9plXFqgDcH40bj0fbd9wxuqQ6aHmbXWKekC+C56a94PMROwasHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526634; c=relaxed/simple;
	bh=amviRZAng65qhSPsIn/ez8PlX5/EY5IcXVvOyQBoCh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZNGvFCWFmn8to73uMN3GfOjykI1pgpoWD0gAsAaqyv/MgeSi4QgEcTuUKpAkkijCaXTEppVADyJGL8MOIjazSryjWGTiGcWW9ptIaMat+vVneLFz3barGNIWcCItoRDQD0W6+HJwBhL76Br1DCzq61GaOtkYKWAxheslRee0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgR/v5KD; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgR/v5KD"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-223a7065ff8so43494505ad.0
        for <virtualization@lists.linux.dev>; Sun, 09 Mar 2025 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741526632; x=1742131432; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78f5GfsZLdHs7HcZYqhufn9bqBeaLB9GfsmUNDdGsAU=;
        b=cgR/v5KDzX7eyyZqdioD0NJ84n+WMd0OMEkBCY9ivz9OMjHAfjNehqpU0jve6NBUfQ
         iylUrVyC/7aQ+erdAu9QAp0986CVLKaPAoKnZ7QOgPh76JScGNYRUJieX+0YRw/dp57C
         ARzx6iD5nYGF9JJV5ggNZiC19twLL90ow6rVisin61NKMXz1sDsygj9Lv7eLQGvexR42
         n8fqiAK4jNEGxiifi65ij5qqebc9SzNlSki5quectav3AytVYBIHsC9XOWwR8p+wPD0N
         o1BZSawz2LERH79fRp8eaQrbQ8ZrhqEmiGAJq2PArVVbiVQ5PAXFM6NubCE0Gti4B9nh
         pmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526632; x=1742131432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78f5GfsZLdHs7HcZYqhufn9bqBeaLB9GfsmUNDdGsAU=;
        b=V5tbCd+8V28Mpsupe7oO0zmepr36UNRpakDxJScQd+ljfaJTpg2JLErwpGh94gwmgV
         5YeyT/MlaA9McrOVq9EbAfVOJWaKJob8K/fZtixaGrrXbXziqp95uMK3CxwiRlDwk1SA
         P8PLahrqVnLxXXjoCbqSMmHvzJrtiX4R0cX36YTThRYFJaAPKenhIFNgDlaBXTBiZF28
         EEYjr0ySFK+qWyRv6UgqxROgAQAj7y+ziqlA+XAyYczEB3G5XayZGAifg+HH2QGmbcD3
         Pbqt5R8omU0nKmLHBM0+TIf9o2GuXnrKwVm/PaUKO8lXmANw26Td8QQwMDEJYyGvdon/
         iNyw==
X-Forwarded-Encrypted: i=1; AJvYcCXT+Px8uaFd8n+uenjOYWQ6E0rBoi/ZF6NEJh6pGTQ08f46BOcLySSmqjBJDeBa7AiRaDloML6kWE4hqq3g7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzTw8iUkctZIRhypOYw/A09Xyq+J2K5UCD22LV/IOtGRnEgR3C
	P4+e1eIUSfrYHL/nJjlXRgZWP75/gk9JlO0d7skwS5sEbm7GGhsA
X-Gm-Gg: ASbGncvaXlhzIEcMEAViHeIiHztxeXezdKvRvqgaQxr/8MsPZNgIuamnFsa0l+2Bqe+
	mhXKZWvLt+PgZZCMUToszCeQ1PnvinP+pQa0Kz/maoRRmwV6R8zNbvoBevrJVh+EuP0dFs/Kauu
	2SbpiYYaohpmdvLjXbKiTE79wTsgx3kx8sCcpos+cIsviWI7O2Z1NfIoXYCpAy5j5HMB24jE1bw
	PF5ourSY6ZPGr+YVH0t8LYWCDQUvCnyNsgRKsRXiI6bAkGeBf7wWN9WcI8Ec6eR6d8+GfgmHVSZ
	E1oMo4yfjQPYtkZKhJc0DlltUfvuf+jwTzXYYpdIkSDd5M4Gkq4VSeKMszw1k7+ar/OzZPd3Kof
	jiahRWdRjSa45tv02GapsBGYfJcmMvOeXET8RFeSm
X-Google-Smtp-Source: AGHT+IFtC936bSg/3HregqNsD+RiIvE+I7Cf0Sja++qaGUNlZeLkZuXJlqOzuqqV2Wpl3dx1MeKXQQ==
X-Received: by 2002:a17:902:eb81:b0:220:c86d:d7eb with SMTP id d9443c01a7336-22428ab863cmr167985465ad.36.1741526632153;
        Sun, 09 Mar 2025 06:23:52 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:c508:514a:4065:877? ([2409:8a55:301b:e120:c508:514a:4065:877])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d4f20913sm597161b3a.13.2025.03.09.06.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 06:23:51 -0700 (PDT)
Message-ID: <7abb0e8c-f565-48f0-a393-8dabbabc3fe2@gmail.com>
Date: Sun, 9 Mar 2025 21:23:35 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
To: NeilBrown <neilb@suse.de>, Yunsheng Lin <linyunsheng@huawei.com>
Cc: Qu Wenruo <wqu@suse.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Carlos Maiolino <cem@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Luiz Capitulino <luizcap@redhat.com>,
 Mel Gorman <mgorman@techsingularity.net>, Dave Chinner
 <david@fromorbit.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-nfs@vger.kernel.org
References: <> <180818a1-b906-4a0b-89d3-34cb71cc26c9@huawei.com>
 <174138137096.33508.11446632870562394754@noble.neil.brown.name>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <174138137096.33508.11446632870562394754@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/2025 5:02 AM, NeilBrown wrote:

...

>>
>>>    allocated pages in the array - just like the current
>>>    alloc_pages_bulk().
>>
>> I guess 'the total number of allocated pages in the array ' include
>> the pages which are already in the array before calling the above
>> API?
> 
> Yes - just what the current function does.
> Though I don't know that we really need that detail.
> I think there are three interesting return values:
> 
> - hard failure - don't bother trying again soon:   maybe -ENOMEM
> - success - all pages are allocated:  maybe 0 (or 1?)
> - partial success - at least one page allocated, ok to try again
>    immediately - maybe -EAGAIN (or 0).

Yes, the above makes sense. And I guess returning '-ENOMEM' & '0' &
'-EAGAIN' seems like a more explicit value.

> 
>>

...

>>
> 
> If I were do work on this (and I'm not, so you don't have to follow my
> ideas) I would separate the bulk_alloc into several inline functions and
> combine them into the different interfaces that you want.  This will
> result in duplicated object code without duplicated source code.  The
> object code should be optimal.

Thanks for the detailed suggestion, it seems feasible.
If the 'add to a linked list' dispose was not removed in the [1],
I guess it is worth trying.
But I am not sure if it is still worth it at the cost of the above
mentioned 'duplicated object code' considering the array defragmenting
seem to be able to unify the dispose of 'add to end of array' and
'add to next hole in array'.

I guess I can try with the easier one using array defragmenting first,
and try below if there is more complicated use case.

1. 
https://lore.kernel.org/all/f1c75db91d08cafd211eca6a3b199b629d4ffe16.1734991165.git.luizcap@redhat.com/

> 
> The parts of the function are:
>   - validity checks - fallback to single page allocation
>   - select zone - fallback to single page allocation
>   - allocate multiple pages in the zone and dispose of them
>   - allocate a single page
> 
> The "dispose of them" is one of
>    - add to a linked list
>    - add to end of array
>    - add to next hole in array
> 
> These three could be inline functions that the "allocate multiple pages"
> and "allocate single page" functions call.  We can pass these as
> function arguments and the compile will inline them.
> I imagine these little function would take one page and return
> a bool indicating if any more are wanted.
> 
> The three functions: alloc_bulk_array alloc_bulk_list
> alloc_bulk_refill_array would each look like:
> 
>    validity checks: do we need to allocate anything?
> 
>    if want more than one page &&
>       am allowed to do mulipage (e.g. not __GFP_ACCOUNT) &&
>       zone = choose_zone() {
>          alloc_multi_from_zone(zone, dispose_function)
>    }
>    if nothing allocated
>       alloc_single_page(dispose_function)
> 
> Each would have a different dispose_function and the initial checks
> would be quite different, as would the return value.
> 
> Thanks for working on this.
> 
> NeilBrown
> 

