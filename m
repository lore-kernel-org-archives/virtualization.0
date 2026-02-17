Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294B32D5C91
	for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314527; cv=none; b=tTieuOXKNvOvd1NQCFJndxRu8b3VIOXmXCbw8Tnn/YYVVyTcaUo4pqTaCuJOI7Zw6S/Iu4/SzEAhf06AZ9o3irnGPNRV972V+I/esWURta3jXnsDfhdJ2tu6Hiv95KHqnVUjGJT1ssHvzJcfC17WEV2iPHdaZhABJx+MmZiCYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314527; c=relaxed/simple;
	bh=NPI6mWl+poWFT5q7oQSSbSjNljd6hZWCNDu3vvNn0uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u61s9GA0zxVpl9eOneATQ2UouBDAKUsXZCny5L3a3IJboD8mDh94DkrSgocmv6iLPT4xaha/jjdUvMzAtKQzHhEJ9HOxgYan+qT8k9zrabJnz4lXlp2hHn3RKX37LQBGcclXbETFtkdqOhrIBpXfh15yH4rVOstCqbFQDjYF+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDo8xc7Y; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDo8xc7Y"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-127380532eeso9916841c88.1
        for <virtualization@lists.linux.dev>; Mon, 16 Feb 2026 23:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771314525; x=1771919325; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FnMNqYmQNZzpA0ckivNAm3K36XWptoI0fu8qkH7ny3w=;
        b=HDo8xc7Y9/upzeJ7jeC7MYreJe7s/NcRZGzoNLOgD9PqxSTt5T5KDpnXtSRD0tSEbb
         O0mrhtQtAeicxROTI1Qru9e/ZZ8aOryjL3O7b7aSXf4TU5kBdIXi0cwjCtOHL7611zEn
         SMN7Pd2RsdsiTK2Th2nhehhECnddA/j+LOyrkef7JIQmRwJggm7I0UaLmT88+CxJyHrV
         2X+WWP93ApeSXJtpNtB9rZR2N1KgOvJWQPxs2MtkyaHcvXLX6nvVz6juydg8+qsKMUWZ
         v5IQK9cAi3Txq/WWj/IyVFA2QyjsCsIq5NR8Y8IujfBWi9v9JcyZwnMAv7+RNvx1vDX9
         Xe2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771314525; x=1771919325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnMNqYmQNZzpA0ckivNAm3K36XWptoI0fu8qkH7ny3w=;
        b=gxWDZHxU/trzNGOZc4V1OaTkshY1kZnKIm/1zLqfvamgZ5EuCi6WLbeejKO2bgskeq
         1jjrGzB9s5qqtZLNspqa9Cb+PRy0kjziE3WM4rdWNmlbF88lptB2jrdxxdo2NOOmOVgy
         2JyCkWcaYn5JXlXz+vBLUiqlYX25iw+ErKUwCbiXu+pzqCVd+l/Qom+4LL5xZDREBe+/
         vRWe7cTdWhDpc7bqyUq+ZgNAluNwKtqqFvd+K6vvE1TaAt233QBBAEuQi5uXETvOnl4D
         N+nmmLgs3dVhf4/dfarZJhsi2UM+ZMJRme2SJa186Om6BBzxL5JrlL3vnRPexfa8hrRC
         cO/w==
X-Forwarded-Encrypted: i=1; AJvYcCUxkKpg1O9HhUppEWnEMOdb77LlE9a3Efncylq2wSc17W24fC4ZcN4oV9qIMeLxW9TdT1Rxi56TtF32DJCtIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYHUxhx4AXpulMcSHNhElsSnOAHudrvkJYwg+ICG0UpOKWFLdo
	1PpHbYIjoS54EozsGU0X4J3wuHwVIiLB+I2OGI//JHYK3gXsBAqnp8/o
X-Gm-Gg: AZuq6aJUmInhETBrYFvmckqbmjbY3T+AWJxICL8RGYAGFvncAMWT2ormdewLba7I6yc
	RE2KbCyFnjDhWIgKZz6qIUrd9yJLBZDS5Mh6g6XTi3udBzDBKbCXu3jmwFsvSaeiu7V5OIVkvj0
	2cWqJrgufc53a0ihwH6ePnzShl8mQZdKgmK/CpG6lNeOglylnFJMVAaHI1TtS30wVjDqU/4chSF
	UY2rsjlIqd1i+/hc1ulXd4LM8A5hK5Co3yjuWZo3+fOn7n5ot43FFw7D/X62oAA7wzETUaMbjP8
	3RS9B3BvbukoHWgEUxTq5Hfth3z9A+WnUAwdJr4qjPESNOL1ucQ05IBbkT/UwtYXeRxEVm+IoNn
	6Hakqc94uiwlOMG0sAdqnvjdlYXPvWoU6f7bB4NUKN0b7uyYhlcPgbyX9GWiESXaUkrB8iTW2ld
	3FZRKkEYcM+BAPQyTO3rf/kdkz4XNUCFY4
X-Received: by 2002:a05:7022:f102:b0:11d:e25a:d9ca with SMTP id a92af1059eb24-1273ae69c9bmr5761013c88.26.1771314525054;
        Mon, 16 Feb 2026 23:48:45 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cada1csm13124794c88.9.2026.02.16.23.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 23:48:44 -0800 (PST)
Message-ID: <9ae80317-f005-474c-9da1-95462138f3c6@gmail.com>
Date: Mon, 16 Feb 2026 23:48:42 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
To: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
 rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com> <aY2BcIHIARSwwQpo@tiehlicka>
 <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com> <aZLUm95Y-dKkdBWI@tiehlicka>
 <3fe7c5dd-b184-4421-a21c-bafce6aa7b09@gmail.com> <aZOHIQj3pJ-9dW_0@tiehlicka>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <aZOHIQj3pJ-9dW_0@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/26 1:07 PM, Michal Hocko wrote:
> On Mon 16-02-26 09:50:26, JP Kobryn (Meta) wrote:
>> On 2/16/26 12:26 AM, Michal Hocko wrote:
>>> On Thu 12-02-26 13:22:56, JP Kobryn wrote:
>>>> On 2/11/26 11:29 PM, Michal Hocko wrote:
>>>>> On Wed 11-02-26 20:51:08, JP Kobryn wrote:
>>>>>> It would be useful to see a breakdown of allocations to understand which
>>>>>> NUMA policies are driving them. For example, when investigating memory
>>>>>> pressure, having policy-specific counts could show that allocations were
>>>>>> bound to the affected node (via MPOL_BIND).
>>>>>>
>>>>>> Add per-policy page allocation counters as new node stat items. These
>>>>>> counters can provide correlation between a mempolicy and pressure on a
>>>>>> given node.
>>>>>
>>>>> Could you be more specific how exactly do you plan to use those
>>>>> counters?
>>>>
>>>> Yes. Patch 2 allows us to find which nodes are undergoing reclaim. Once
>>>> we identify the affected node(s), the new mpol counters (this patch)
>>>> allow us correlate the pressure to the mempolicy driving it.
>>>
>>> I would appreciate somehow more specificity. You are adding counters
>>> that are not really easy to drop once they are in. Sure we have
>>> precedence of dropping some counters in the past so this is not as hard
>>> as usual userspace APIs but still...
>>>
>>> How exactly do you tolerate mempolicy allocations to specific nodes?
>>> While MPOL_MBIND is quite straightforward others are less so.
>>
>> The design does account for this regardless of the policy. In the call
>> to __mod_node_page_state(), I'm using page_pgdat(page) so the stat is
>> attributed to the node where the page actually landed.
> 
> That much is clear[*]. The consumer side of things is not really clear to
> me. How do you know which policy or part of the nodemask of that policy
> is the source of the memory pressure on a particular node? In other
> words how much is the data actually useful except for a single node
> mempolicy (i.e. MBIND).

Other than the bind policy, having the interleave (and weighted) stats
would allow us to see the effective distribution of the policy. Pressure
could be linked to a user configured weight scheme. I would think it
could also help with confirming expected distributions.

You brought up the node mask so with the preferred policy, I think this
is a good one for using the counters as well. Once we're at the point
where we know the node(s) under pressure and then see significant
preferred allocs accounted for, we could search the numa_maps that have
"prefer:<node>" to find the tasks targeting the affected nodes.

I mentioned this on another thread in this series but I'll include here
as well and expand some more. For any given policy, the workflow would
be:
1) Pressure/OOMs reported while system-wide memory is free.
2) Check per-node pgscan/pgsteal stats (provided by patch 2) to narrow
down node(s) under pressure. They become available in
/sys/devices/system/node/nodeN/vmstat.
3) Check per-policy allocation counters (this patch) on that node to
find what policy was driving it. Same readout at nodeN/vmstat.
4) Now use /proc/*/numa_maps to identify tasks using the policy.

> 
> [*] btw. I believe you misaccount MPOL_LOCAL because you attribute the
> target node even when the allocation is from a remote node from the
> "local" POV.

It's a good point. The accounting as a result of fallback cases
shouldn't detract from an investigation though. We're interested in the
node(s) under pressure so the relatively few fallback allocations would
land on nodes that are not under pressure and could be viewed as
acceptable noise.
