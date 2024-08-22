Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C523CB
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310114; cv=none; b=nSREXfjE7kl3SHcj3OHIozGNIErPcmtww5PPi+cc7yZNc9qGCO9PCd54UwJJtooDoj/Jew5p7xJl47wbGjBDyIkzpyfQeQGg2P1yE6yyPNGPJFhTkJoycw0VHt22Fd16ilz58r/YbKY2rEDtvuLmIPjYTMNdpuPMUyGQnqH217o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310114; c=relaxed/simple;
	bh=g7A/r+IfAFyOaFuKyRq6j9YvyA3fYhcdAgO/yjFAErI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AclyxWwV0Jd+OIe+gGLlC18STbLTrkeb/msROentOcBPDq/eK7Xv0NF7hTokf95q1yunFwkdZUS6Y6oZA0UfHEKi3czkoDejuFyjygDgW2/Bbg+LZNR8HIYGyLp6O/twvc/cqzleYkeKWR0RV8D4R1YQ/3HlkLa1LI/UdNsGO38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DCWyk5xq; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DCWyk5xq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724310107; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=N2fEU+06lguC78zu1nUxZMhGeMq6Xm3dBHYAYYSq9a4=;
	b=DCWyk5xqzwtUc1MOel7DPuGO9azij1L+jz4quiMPvWF5EDqWaa++zuQncg8lHntA6C3CfNKECarnLB8FlmXGZKeGwN0Fa69RgZpcRMsR7wcWsh1Q7SrAshi9bvTJSdzcDi3iRcaancegI7xFI8CcGVY10NMwURbNztBEO941b5w=
Received: from 30.221.130.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDOC3sx_1724310104)
          by smtp.aliyun-inc.com;
          Thu, 22 Aug 2024 15:01:45 +0800
Message-ID: <9fa8eca0-ad4e-445c-a21e-aaabb6aa4160@linux.alibaba.com>
Date: Thu, 22 Aug 2024 15:01:43 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Michal Hocko <mhocko@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, David Hildenbrand <david@redhat.com>,
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

On 2024/8/22 14:40, Linus Torvalds wrote:
> On Thu, 22 Aug 2024 at 14:21, Michal Hocko <mhocko@suse.com> wrote:
>>
>> The reality disagrees because there is a real demand for real GFP_NOFAIL
>> semantic. By that I do not mean arbitrary requests and sure GFP_NOFAIL
>> for higher orders is really hard to achieve but kvmalloc GFP_NOFAIL for
>> anything larger than PAGE_SIZE is doable without a considerable burden
>> on the MM end.
> 
> Doable? Sure. Sensible? Not clear.
> 
> I do not find a single case of that in the kernel.
> 
> I did find three cases of kvcalloc(NOFAIL) in the nouveau driver and
> one in erofs. It's not clear that any of them make much sense (or that
> the erofs one is actually a large allocation).

I don't follow all the thread due to other internal work ongoing
but EROFS could do _large_ kvmalloc NOFAIL allocation according to
PAGE_ALLOC_COSTLY_ORDER (~24kb at most due to on-disk restriction),
my detailed story was outlined in my previous reply (and thread):
https://lore.kernel.org/r/20d782ad-c059-4029-9c75-0ef278c98d81@linux.alibaba.com

Because EROFS needs page arraies for vmap and then do decompression,
for the worst case, it almost needs ~24kb temporary page array
but that is the end user choice to use such extreme compression
(mostly just syzkallar crafted images.)

In my opinion, I'm not sure how PAGE_ALLOC_COSTLY_ORDER restriction
means for a single shot.  Because assume even if you don't consider
a virtual consecutive buffer, people could also do
< PAGE_ALLOC_COSTLY_ORDER allocations multiple times to get almost
the same heavy workload to the whole system.  And we also allow
direct/kswap reclaim here.

Failure path is complex in some cases like here and it's hard
to reach or get it right.  If kvmalloc() will be restricted on
< PAGE_ALLOC_COSTLY_ORDER anyway, I guess I will use a global
static buffer (and a sleeping lock) as a worst fallback to fulfill
the extreme on-disk restriction.

Thanks,
Gao Xiang
