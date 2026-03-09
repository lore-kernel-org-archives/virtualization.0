Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678A28751B
	for <virtualization@lists.linux.dev>; Mon,  9 Mar 2026 03:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773027072; cv=none; b=eS398C1ope/AuWqxIORjbRCKbHpHhtldHv+CG8RjQaFhmRcf+FbLYG6b5IjEkx2k2vmqIhydOCu15/lhwbyqOMg0Kk60BFa+wILvn2vSZh6A7vK19UttOOrfB1/8SqXenr1qIAeoqAgje5WvcquGnkWv3CTDr/ucQgmHYlNHpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773027072; c=relaxed/simple;
	bh=Cq7pOWkgy5Xl5CZLed48itED/PWHe5kSVrGncmLnpYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdWDnxEx/xHwJDDDPf9u8Uz1hPsxUEqAegtnoXpKIhPm+rQi8giPblbgoEvfR8FFSxJ7pHNn9kt+m9K54OQcw4A6/A6t9P0AxUVdJ5ep71lvELXsydUnT2wMR/4JlB2ESXG0nsJsundzz/y+Puffte3ukM+LtSNuM6Rhx92n50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I1WPgWyD; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I1WPgWyD"
Message-ID: <c64681a1-2069-421c-9e62-bb63e4ce261a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773027058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGRzB9NB7RnJy1AFfNjO4UdJlA1IIFldq9U5XbxXvLE=;
	b=I1WPgWyDe1PpSkWi58Zt5V7YwT8hbeXPtsYCQU2giIVSqguWg0dr5EDnvQX68WY0JDajo9
	tmo9uHiI36ZHcYV17iiu58tmXfGiZvnz/M6Mgeww97WrWDnV7hmN4VjOCNQ1+WVMItxj8U
	hawDYa8Qn46vurq+8oinWUsny/0xQRQ=
Date: Sun, 8 Mar 2026 20:30:47 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
To: Usama Arif <usama.arif@linux.dev>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
 vbabka@suse.cz, apopple@nvidia.com, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
 hannes@cmpxchg.org, joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, mst@redhat.com, rppt@kernel.org,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, rakie.kim@sk.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 virtualization@lists.linux.dev, weixugc@google.com,
 xuanzhuo@linux.alibaba.com, ying.huang@linux.alibaba.com,
 yuanchu@google.com, ziy@nvidia.com, kernel-team@meta.com
References: <20260308192438.1363382-1-usama.arif@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <20260308192438.1363382-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/8/26 12:24 PM, Usama Arif wrote:
> On Fri,  6 Mar 2026 20:55:20 -0800 "JP Kobryn (Meta)" <jp.kobryn@linux.dev> wrote:
[...]
>> +static void mpol_count_numa_alloc(struct mempolicy *pol, int intended_nid,
>> +				  struct page *page, unsigned int order)
>> +{
>> +	int actual_nid = page_to_nid(page);
>> +	long nr_pages = 1L << order;
>> +	enum node_stat_item hit_idx;
>> +	struct mem_cgroup *memcg;
>> +	struct lruvec *lruvec;
>> +	bool is_hit;
>> +
>> +	if (!root_mem_cgroup || mem_cgroup_disabled())
>> +		return;
> 
> Hello JP!
> 
> The stats are exposed via /proc/vmstat and are guarded by CONFIG_NUMA, not
> CONFIG_MEMCG. Early returning overhere would make it inaccuate. Does
> it make sense to use mod_node_page_state if memcg is not available,
> so that these global counters work regardless of cgroup configuration.
>

Good call. I can instead do:

if (!mem_cgroup_disabled() && root_mem_cgroup) {
	struct mem_cgroup *memcg;
	struct lruvec *lruvec;
	/* use lruvec for updating stats */
} else {
	/* use node for updating stats */
}

This should also take care of the bot warning on mem_cgroup_from_task()
not being available.
