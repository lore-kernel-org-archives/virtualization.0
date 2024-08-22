Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600113B29B
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338976; cv=none; b=fPX2a9jqvpyLvBjAcFPDQLDp6QcN92It61OIdKwdwfi9ACEiQtGUpbKEB/Pe56yBiKpe8bINMU4OH00rZtRMIaZD4wvSelWKFR6Ew+azSgUu4DrT/Vzov0DiSSeAc8yWH0upkPidlpZh6D0GjvsueDuzHfvv5+aF6kRGPMmgTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338976; c=relaxed/simple;
	bh=T6Y8XdqqTqyK3t61vtBURqlaVo4hw+ZglMbAsIVyMxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YK9tOcwGdzIneLB+8uNOdO0xmy3ZEWjdP/3KXEKR+a0oX4lLm+aUVyvaw/xpDDKdwEiM3OjogpyU+6L1w8RUkCWFXFDN/JJSbBoNzHbNAJb4ZKW7GAQpGcQ2as8XNV0GkjPJO2G+z5tuN9+c3/pPvFhm9WNNXssoNMTKHcSsKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k3J4yYl0; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k3J4yYl0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724338970; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=peTEqBgOuAT8bs3zeMz5eUMcF0EAlNt2QLgLaqnO5Gs=;
	b=k3J4yYl0jyNbdE6ZqmLyJy9lSb2Cb8hHim11j/e0Tw+jSskjNRkqPJQeh9pmuj3QFXshTDPigK8SUuuIw0re7PVfLmo7BYCFDFjtmRMXjrq2mcXqSjpfO0KpMYFJZe+XrAmR/JOGG5070+ACC/vIvhn8CeucH5Gbbfr/67RvcyA=
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDQjJbl_1724338966)
          by smtp.aliyun-inc.com;
          Thu, 22 Aug 2024 23:02:48 +0800
Message-ID: <f26bffb3-13ea-464e-8197-b53837caa0d5@linux.alibaba.com>
Date: Thu, 22 Aug 2024 23:02:46 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
 cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
 iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com,
 roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
 vbabka@suse.cz, virtualization@lists.linux.dev
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <9fa8eca0-ad4e-445c-a21e-aaabb6aa4160@linux.alibaba.com>
 <ZsbuwJPtRwr5Hi6E@tiehlicka>
 <e811aeca-b8df-489a-b2ee-96abf6877d8c@linux.alibaba.com>
 <CALOAHbDoTnzovaw2nmmywiZLxiVx+dJymG2znrWN1+=VSowsRQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CALOAHbDoTnzovaw2nmmywiZLxiVx+dJymG2znrWN1+=VSowsRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/22 22:35, Yafang Shao wrote:
> On Thu, Aug 22, 2024 at 4:04 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Hi Michal,
>>
>> On 2024/8/22 15:54, Michal Hocko wrote:
>>> On Thu 22-08-24 15:01:43, Gao Xiang wrote:
>>>> In my opinion, I'm not sure how PAGE_ALLOC_COSTLY_ORDER restriction
>>>> means for a single shot.  Because assume even if you don't consider
>>>> a virtual consecutive buffer, people could also do
>>>> < PAGE_ALLOC_COSTLY_ORDER allocations multiple times to get almost
>>>> the same heavy workload to the whole system.  And we also allow
>>>> direct/kswap reclaim here.
>>>
>>> Quite honestly I do not think that PAGE_ALLOC_COSTLY_ORDER constrain
>>> make sense outside of the page allocator proper. There is no reason why
>>> vmalloc NOFAIL should be constrained by that. Sure it should be
>>> contrained to some value but considering it is just a bunch of PAGE_SIZE
>>> allocation then the limit could be higher. I am not sure where the
>>> practical limit should be but anything that requires more than couple of
>>> MBs seems really excessive.
>>
>> Yeah, totally agreed, that would make my own life easier, of
>> course I will not allocate MBs insanely.
>>
>> I've always trying to kill unnecessary NOFAILs (mostly together
>> with code cleanups), but if a failure path increases more than
>> 100 LOCs just for rare failure and extreme workloads, I _do_
>> hope kvmalloc(NOFAIL) could work instead.
> 
> If the LOCs in the error handler are a concern, I believe we can
> simplify it to a single line: while (!alloc()), which is essentially
> what NOFAIL does and is also the reason we want desperate NOFAIL.
> 
> A better approach might involve failing after a maximum number of
> retries at the call site, for example:
> 
>    while (try < max_retries && !alloc())
> 
> At least that is better than the endless loop in the page allocator.

Funny.

Thanks,
Gao Xiang
