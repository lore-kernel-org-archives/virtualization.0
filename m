Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C93164BB
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234432; cv=none; b=TdFuQZyaHEo6yfFWuKK9Jy3hGtBPCXhdYzIck0PGOZ0TXiKv5QK1FvU7qFofY8zgzxnajB5C55jsybq8WV94R/GcllfZQwVUfSeI7MhCcxOx0AslanUM1kXIZ7au6AgaU2HlaBR2Bx1njsPRkegsD98Y6uIS8hebsD+yZEYMSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234432; c=relaxed/simple;
	bh=bn5V7sjjhz2TSL+e1OJVyVRpHrStkkCUOUjysl82EdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUz7oQzcflZafyg7uaPsVvUVSCrE2s9ad4nBG2M+cx8EjRvmd3sCZMR0UHulH/T6QGHCPQdryC+eqBK20tWmrdkr1F3LupCRbHA+QNJDrlereokBJ9wjQ5NoRYlTwWir8Kzfm6qS5erVruziHALRurjXWXd/gh+fjsL1Dujf4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <441c25a9-0993-4fd9-9932-948321974c00@linux.dev>
Date: Fri, 8 May 2026 17:59:39 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/balloon: expose per-node balloon pages in node meminfo
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260508015316.25722-1-hao.ge@linux.dev>
 <731d7324-4eb7-44d2-bb7d-62b6fbe11c52@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <731d7324-4eb7-44d2-bb7d-62b6fbe11c52@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi David


On 2026/5/8 16:23, David Hildenbrand (Arm) wrote:
> On 5/8/26 03:53, Hao Ge wrote:
>> Commit 835de37603ef ("meminfo: add a per node counter for balloon
>> drivers") added NR_BALLOON_PAGES and exposed it in /proc/meminfo.
>> However, the per-node view at /sys/devices/system/node/nodeX/meminfo
>> was not updated, even though the counter is already tracked per-node.
>>
>> Add it to node_read_meminfo() so users can see balloon usage per
>> NUMA node without having to parse the raw vmstat file.
> Using ballooning with vNUMA is rather rare. But sure, why not.

Yeah, it's indeed not common.

We came across this while analyzing a customer's 16C 32G VM with 2 vNUMA 
nodes and balloon enabled.


>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>   drivers/base/node.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index d7647d077b66..53f4e51d6d82 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -513,6 +513,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>>   			     "Node %d Slab:           %8lu kB\n"
>>   			     "Node %d SReclaimable:   %8lu kB\n"
>>   			     "Node %d SUnreclaim:     %8lu kB\n"
>> +			     "Node %d Balloon:        %8lu kB\n"
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   			     "Node %d AnonHugePages:  %8lu kB\n"
>>   			     "Node %d ShmemHugePages: %8lu kB\n"
>> @@ -543,7 +544,8 @@ static ssize_t node_read_meminfo(struct device *dev,
>>   				    node_page_state(pgdat, NR_KERNEL_MISC_RECLAIMABLE)),
>>   			     nid, K(sreclaimable + sunreclaimable),
>>   			     nid, K(sreclaimable),
>> -			     nid, K(sunreclaimable)
>> +			     nid, K(sunreclaimable),
>> +			     nid, K(node_page_state(pgdat, NR_BALLOON_PAGES))
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   			     ,
>>   			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
>
> Shouldn't it be placed under "Unaccepted:", just like for /proc/meminfo?
>
Good catch, thanks. I overlooked this detail -- will fix in v2.

Thanks

Best Regards

Hao

