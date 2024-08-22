Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB46502BE
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313881; cv=none; b=tmrWlhMYEtsFYSTgORuzohl2lYwe/WjjNtgd5lG/t4edNF4ZwNyNQAo3WtN02gj/eiSc6jiodthPIqT5Gg4T9mUTfaqOjM7KtDYAW9aGjg6NQsQCz3JKfN1yWehFa79DqV3T+qUe94k1+IC68ZRUoToeCCkMd0vKwDtHhIhfDFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313881; c=relaxed/simple;
	bh=MqxDByvrd+WHkbDfNLxOVxQbw40SaRPUNg1oIpPC/yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fD8cpMOkNosEdA7lEq7A8vb2K4/fxGzdqOAdaioCRaCdnohqVeQ+RmexP2N0jAvXoY5XESev9aYMWUxNMc0WGVXBhqMrW8JKYePjXNZT9bqNITsrFMdePiG5c80y1NxZoUkeiAHm49bcK0/B2yUcCTaafIASmWoaPCxRUn6tR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g+bSb6a2; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g+bSb6a2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724313869; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2BbQWat81tz/GQoQpQ9RvbaiG8gESqcNeLdTDdRv6ps=;
	b=g+bSb6a2T7O+XRQYEsPH3IcM+YkMO2tEmkOLz06f9ZNS8DM3r2x6p4yMq/tQ7gJVt78870zfL2jBvqyWO1P4dm2OeRJPgp6kRmAtBqf70jUWzbm0ef8WCVjaE/hsFB3Qs4miFBworkpV2kX2+mnilAUJmm7EpWXhqfAdtsdQqP0=
Received: from 30.221.130.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDOMmTj_1724313866)
          by smtp.aliyun-inc.com;
          Thu, 22 Aug 2024 16:04:27 +0800
Message-ID: <e811aeca-b8df-489a-b2ee-96abf6877d8c@linux.alibaba.com>
Date: Thu, 22 Aug 2024 16:04:25 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Yafang Shao <laoar.shao@gmail.com>, David Hildenbrand <david@redhat.com>,
 Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
 v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <9fa8eca0-ad4e-445c-a21e-aaabb6aa4160@linux.alibaba.com>
 <ZsbuwJPtRwr5Hi6E@tiehlicka>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZsbuwJPtRwr5Hi6E@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michal,

On 2024/8/22 15:54, Michal Hocko wrote:
> On Thu 22-08-24 15:01:43, Gao Xiang wrote:
>> In my opinion, I'm not sure how PAGE_ALLOC_COSTLY_ORDER restriction
>> means for a single shot.  Because assume even if you don't consider
>> a virtual consecutive buffer, people could also do
>> < PAGE_ALLOC_COSTLY_ORDER allocations multiple times to get almost
>> the same heavy workload to the whole system.  And we also allow
>> direct/kswap reclaim here.
> 
> Quite honestly I do not think that PAGE_ALLOC_COSTLY_ORDER constrain
> make sense outside of the page allocator proper. There is no reason why
> vmalloc NOFAIL should be constrained by that. Sure it should be
> contrained to some value but considering it is just a bunch of PAGE_SIZE
> allocation then the limit could be higher. I am not sure where the
> practical limit should be but anything that requires more than couple of
> MBs seems really excessive.

Yeah, totally agreed, that would make my own life easier, of
course I will not allocate MBs insanely.

I've always trying to kill unnecessary NOFAILs (mostly together
with code cleanups), but if a failure path increases more than
100 LOCs just for rare failure and extreme workloads, I _do_
hope kvmalloc(NOFAIL) could work instead.


> 
> And for PAGE_ALLOC_COSTLY_ORDER and NOFAIL at the page allocator level I
> would argue that we do not want to provide such a strong guarantee to
> anything order > 0. Just use kvmalloc for that purpose. Sure we
> practically never fail up to costly order but guaranteeing that is a
> different story.

Agreed.

Thanks,
Gao Xiang

> 
