Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC0332917
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 06:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382493; cv=none; b=IRe3xaNn15kk0aJBqPqUhkRgAe4gCBLc7jXvMhYwVEg6vtoon68qBkSxg6lNnJof/y3ELpNqaLPVf5vY1SV4OaV9kllnCEZ9jdRz1nffuXfhUDdm2eSdal3PesiqsZ+eh/L4eu8FPt3n6tex+6wn+ZZX2gIPxTDq5nVeyoeQFn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382493; c=relaxed/simple;
	bh=TxGCibyeKxKkTZWMmZEfTZ0Hk4cAVCjiVlBujR9CsAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdaQCILkhZJRRwsTl4TlKiB27htqVNrmaDAxc9FY78FOYATgg6bOvTDKw5cLvseexx2kl9mN/4FOA2sU10yS83YVwQvudc7IPZFiTLEloATDUsEZVJ6TGMzPdB6/JxAIjWm8iLoP96G+hvlalYwEGB4qbpiUFENbdCaIpcrEA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uAFdS55K; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uAFdS55K"
Message-ID: <cd3d7e2c-79fa-4c00-89ad-83beddf98bae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773382487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTOLkQVeVRERnDaN2DY/VOKpnGSBVqeHDpUKHThv08w=;
	b=uAFdS55KeRCswjq75c2XPetMdLBZz02PMZndCgnGus7RcpkYRA42aQWgO5+73Z48XT+QNy
	goFei+e4hH/qigznuSXoYYNL6W3QKa4gIO+u47sTlzngo4sHrD4fcv3iyLO3QODXGRMxgX
	lvTyN830y+LMTKxFJU96X0nsOAQ57sI=
Date: Thu, 12 Mar 2026 23:14:36 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
 akpm@linux-foundation.org, mhocko@suse.com, apopple@nvidia.com,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
 rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 surenb@google.com, virtualization@lists.linux.dev, weixugc@google.com,
 xuanzhuo@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
 <3a42463b-9ddd-4d64-b64c-6c2e6e4fc75d@kernel.org>
 <343bbd5b-67a0-46c4-8ec4-69158bf26b3f@linux.dev>
 <874imkpba1.fsf@DESKTOP-5N7EMDA>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <874imkpba1.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/12/26 10:07 PM, Huang, Ying wrote:
> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
> 
>> On 3/12/26 6:40 AM, Vlastimil Babka (SUSE) wrote:
>>> On 3/7/26 05:55, JP Kobryn (Meta) wrote:
>>>> When investigating pressure on a NUMA node, there is no straightforward way
>>>> to determine which policies are driving allocations to it.
>>>>
>>>> Add per-policy page allocation counters as new node stat items. These
>>>> counters track allocations to nodes and also whether the allocations were
>>>> intentional or fallbacks.
>>>>
>>>> The new stats follow the existing numa hit/miss/foreign style and have the
>>>> following meanings:
>>>>
>>>>     hit
>>>>       - for BIND and PREFERRED_MANY, allocation succeeded on node in nodemask
>>>>       - for other policies, allocation succeeded on intended node
>>>>       - counted on the node of the allocation
>>>>     miss
>>>>       - allocation intended for other node, but happened on this one
>>>>       - counted on other node
>>>>     foreign
>>>>       - allocation intended on this node, but happened on other node
>>>>       - counted on this node
>>>>
>>>> Counters are exposed per-memcg, per-node in memory.numa_stat and globally
>>>> in /proc/vmstat.
>>>>
>>>> Signed-off-by: JP Kobryn (Meta) <jp.kobryn@linux.dev>
>>> I think I've been on of the folks on previous versions arguing
>>> against the
>>> many counters, and one of the arguments was it they can't tell the full
>>> story anyway (compared to e.g. tracing), but I don't think adding even more
>>> counters is the right solution. Seems like a number of other people
>>> responding to the thread are providing similar feedback.
>>> For example I'm still not sure how it would help me if I knew the
>>> hits/misses were due to a preferred vs preferred_many policy, or interleave
>>> vs weithed interleave?
>>>
>>
>> How about I change from per-policy hit/miss/foreign triplets to a single
>> aggregated policy triplet (i.e. just 3 new counters which account for
>> all policies)? They would follow the same hit/miss/foreign semantics
>> already proposed (visible in quoted text above). This would still
>> provide the otherwise missing signal of whether policy-driven
>> allocations to a node are intentional or fallback.
>>
>> Note that I am also planning on moving the stats off of the memcg so the
>> 3 new counters will be global per-node in response to similar feedback.
> 
> Emm, what's the difference between these newly added counters and the
> existing numa_hit/miss/foreign counters?

The existing counters don't account for node masks in the policies that
make use of them. An allocation can land on a node in the mask and still
be considered a miss because it wasn't the preferred node.
