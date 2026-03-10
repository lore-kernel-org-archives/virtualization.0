Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A5027A462
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773116288; cv=none; b=ufcvmJz5PX3dbCpufSXws5Hj2nSvtHRBgpYsUo8LelSaU1v18W2jtlybY8M95w9wo4J0aqS3/sW/U/eydPV/uM95JjdwmaNyXXAmIjUOSVk2V6B0qx3FB8gsNaUIsHxLFcwZXwcYobP5V3/6pBfDgHkFgGTE9QQzxDbfXRHBD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773116288; c=relaxed/simple;
	bh=PahFcLGm0qrHP5eACh398npBTmRxC9eQ1+VlQ3Eq6ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdUyCudbkwjSvqob0tNdhxts8Y3Wsy8Uk46trbywwE0xXnvrqiRU3rJfD0MJfed/GNBo/cq00tn22RZs1n2hVFB1Q1cwIJMhzglL7bu9TxrECKicAARRI/3gz7Q2zdA1u2VHrP22FXiGpTygNsxaEpXL+R1NQH5OMY+BlzmHBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iuDSOn1y; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iuDSOn1y"
Message-ID: <dcf2e654-ad2f-4390-9b62-078e664158de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773116274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yt6x+E9G8bhHLBAbORSNHeQ7FRJQ5mKhDBf43c4KJEA=;
	b=iuDSOn1y6V1DqIsON7tHkFy5Nf6ZsyQnerFcze7MRHwWzGLSBLAtvA3+rhb7NBNX/FrEBH
	xJO2vvJRVh8zuVZ3005BQ9IZ80iwWYC+IphE4MgFYEZdsFDyZGxWu4fXAhG7RORtkV4/OG
	JR3oBF9lm1h1HGlqIu4kV0DLpC5Gr3w=
Date: Mon, 9 Mar 2026 21:17:43 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
 vbabka@suse.cz, apopple@nvidia.com, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
 hannes@cmpxchg.org, joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, mst@redhat.com, rppt@kernel.org,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, rakie.kim@sk.com,
 roman.gushchin@linux.dev, surenb@google.com, virtualization@lists.linux.dev,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
 <aa9aDGwk8YteaEob@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <aa9aDGwk8YteaEob@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/9/26 4:43 PM, Shakeel Butt wrote:
> On Fri, Mar 06, 2026 at 08:55:20PM -0800, JP Kobryn (Meta) wrote:
>> When investigating pressure on a NUMA node, there is no straightforward way
>> to determine which policies are driving allocations to it.
>>
>> Add per-policy page allocation counters as new node stat items. These
>> counters track allocations to nodes and also whether the allocations were
>> intentional or fallbacks.
>>
>> The new stats follow the existing numa hit/miss/foreign style and have the
>> following meanings:
>>
>>    hit
>>      - for BIND and PREFERRED_MANY, allocation succeeded on node in nodemask
>>      - for other policies, allocation succeeded on intended node
>>      - counted on the node of the allocation
>>    miss
>>      - allocation intended for other node, but happened on this one
>>      - counted on other node
>>    foreign
>>      - allocation intended on this node, but happened on other node
>>      - counted on this node
>>
>> Counters are exposed per-memcg, per-node in memory.numa_stat and globally
>> in /proc/vmstat.
>>
>> Signed-off-by: JP Kobryn (Meta) <jp.kobryn@linux.dev>
> 
> [...]
> 
>> +
>> +	rcu_read_lock();
>> +	memcg = mem_cgroup_from_task(current);
>> +
>> +	if (is_hit) {
>> +		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(actual_nid));
>> +		mod_lruvec_state(lruvec, hit_idx, nr_pages);
>> +	} else {
>> +		/* account for miss on the fallback node */
>> +		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(actual_nid));
>> +		mod_lruvec_state(lruvec, hit_idx + 1, nr_pages);
>> +
>> +		/* account for foreign on the intended node */
>> +		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(intended_nid));
>> +		mod_lruvec_state(lruvec, hit_idx + 2, nr_pages);
>> +	}
> 
> This seems like monotonic increasing metrics and I think you don't care about
> their absolute value but rather rate of change. Any reason this can not be
> achieved through tracepoints and BPF combination?

We have the per-node reclaim stats (pg{steal,scan,refill}) in
nodeN/vmstat and memory.numa_stat now. The new stats in this patch would
be collected from the same source. They were meant to be used together,
so it seemed like a reasonable location. I think the advantage over
tracepoints is we get the observability on from the start and it would
be simple to extend existing programs that already read stats from the
cgroup dir files.
