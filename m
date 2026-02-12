Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F82296BD2
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931402; cv=none; b=XplObqvtQehv6zidtbpManWzUnswvAiNyR8DGm8mNlaQENT5t1zmGYD3tW06z0ULAr87sLqlnPvOL4cpWJFdDvKuyBHgl3yxcSPZKHOZX+9LPnabegxmVhbBW8lpVh0EPBuPUtYGC2IixbAKwAhZ0TGk6MkVz5Eqs7+RhCes8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931402; c=relaxed/simple;
	bh=M+bfuEN1su7NmxM1Tw6CX2qOcOTwn0Rv3r5GE2+cibk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8GfPim48vCf1GpTZo/2s2XInCCa1LfUDHprcKX74kIOaIzjoEJf629JFAvDwrOyEZ6VoMgaxXLGB0xgH48QaeJmNVGvsZSn+moATnKxoBxfGxba1NBLXmSRujmqGaCXXtbdmOW2Znva7URliR1+nZ2CaQ/6eePD6QwdGP7OnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMbCcHt3; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMbCcHt3"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2baaceb4613so561053eec.0
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 13:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770931400; x=1771536200; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+9lU8ttHS0Y3rUeACRp1GPu77nMoViWOTfYZGCx7ag=;
        b=JMbCcHt3SIOK5WcevMpoWsI0H1zW8o0tLI0ZBGLQJlT93vWRzyQf35QZw+mFAkhGQq
         JE3iOm8qVbCKkG29l5Jkiyiom63hljiTbjNoIXc5/YFl2Wr9n944pQlTBLDIOoJE67zF
         dXZ3u/b5fzGaQ0EPRwoxYtORgbJdSH5cL7SiJ3X1Sms+0PekaQSGdx3GXy+JkC5tS3JG
         f739Lt99mCeBr7Ioak2WCwSCgXZzVHSOh3wy6ghDp3VgvkH/svu/zXFo+iVQYaRjNESR
         f4tt8zTHu7vHWieX3Ym4wr8GxD2I4a3/oXpYHa5wnYra3KJj7ym9k4iNwR/O83lhJk9T
         AF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931400; x=1771536200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+9lU8ttHS0Y3rUeACRp1GPu77nMoViWOTfYZGCx7ag=;
        b=p3HOao8ntyUnIx/6uMpdCHkSlMV7DuWVvm3NA+ijcTS7YO3EQ3E+FFmHeD6mS4P1or
         AmLIHIyt78aub7IpxbBtbzH9cwBsQYJGG2kXrJj66PPS/ZXQ3CbibR6XWYz4v1Vfx088
         5srreXIQOGKobY3svJBjMPMxxFYgEYo/s0n+0NaE7xQAvE+daVUq7pMpg0J9b+k5vRVH
         DHTRM4QJGM2vTMYcOWgVLMguXuXK/XBbaIDibQWNIGcw6q7IoLC99W+P2nB8NhXI8Mda
         6XJ3rEy1x3CapRmmnpzKBWkm1t0KhATMWzawXpPnoTgLIrQIjYDCrz0ZX6vLwkCUOWRK
         Ncew==
X-Forwarded-Encrypted: i=1; AJvYcCXLG3/cxVY8nwTUvZtfW4Mq8A2OqCY+Vt1xgTR5A9ArFYBCCmN7DcLvwMyLQFyHWDvrt7TOVlqfFU+U5wIq5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAeAFE2KLzmTjDr1hXSmF7WY3COqFvEia4OpbPZ72GOw92c+rN
	G6gMCLeKxWqVdFZ43N+EWhWCIow3M/HL8awpNtqiLHqsKQkOxFwh43LF
X-Gm-Gg: AZuq6aKh5AhbsN//gGqOrk8R54Xh2nBN58urO3/ghIwEFFVjqy0BtzQbouNWmN8NUpW
	eASUS/KBZTy3/RwuksNAs5kJXodIrJrvNC64tgPGZFNWqmby6tVaWMd0A9QYhruHZ0OIjfe36Vg
	X5n3eOnJgt4GE+bLvtigRNCcVRbEe7NHuVT4bKPIhq03xEUPnJzYPzSmcbHd0OtgB9VAHNEcf34
	/9oZuzO5YXkIhnOeJAJJSrchoILpKiJWgiJdE3lMCf/qvi2Ho8z6piZQwxVG4xSctKkes1y5VHA
	tu5IekbIMhWzB1jLn+k3f6CgLrQ35mHGAY5AboMVUTDrosc9cv68zQ/PY042M4mFLkHIjwIr+km
	S6xMtT1wI9yPrsQe6wXu/02RiaM3zWIzAhHgOxIZbUqlAKkQoCEznb/DB940TnF2gsVnCvCAQUu
	a/Ykz3xHb64KXx+AuViDTJFi28TvaQA3FZVpfMzm9GgCM=
X-Received: by 2002:a05:7301:4449:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2baba1b8829mr112653eec.14.1770931400275;
        Thu, 12 Feb 2026 13:23:20 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dba2aadsm4282884eec.1.2026.02.12.13.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 13:23:19 -0800 (PST)
Message-ID: <905f5ee5-53f7-428f-9560-13d9aa1d1b19@gmail.com>
Date: Thu, 12 Feb 2026 13:23:17 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
 mhocko@suse.com, rppt@kernel.org, muchun.song@linux.dev,
 zhengqi.arch@bytedance.com, rakie.kim@sk.com, roman.gushchin@linux.dev,
 surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com> <aY3r75eewxbArKVu@linux.dev>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <aY3r75eewxbArKVu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/26 7:07 AM, Shakeel Butt wrote:
> On Wed, Feb 11, 2026 at 08:51:08PM -0800, JP Kobryn wrote:
>> It would be useful to see a breakdown of allocations to understand which
>> NUMA policies are driving them. For example, when investigating memory
>> pressure, having policy-specific counts could show that allocations were
>> bound to the affected node (via MPOL_BIND).
>>
>> Add per-policy page allocation counters as new node stat items. These
>> counters can provide correlation between a mempolicy and pressure on a
>> given node.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> [...]
> 
>>   int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
>>   {
>>   	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
>> @@ -2446,8 +2461,14 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
>>   
>>   	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
>>   
>> -	if (pol->mode == MPOL_PREFERRED_MANY)
>> -		return alloc_pages_preferred_many(gfp, order, nid, nodemask);
>> +	if (pol->mode == MPOL_PREFERRED_MANY) {
>> +		page = alloc_pages_preferred_many(gfp, order, nid, nodemask);
>> +		if (page)
>> +			__mod_node_page_state(page_pgdat(page),
>> +					mpol_node_stat(MPOL_PREFERRED_MANY), 1 << order);
> 
> Here and two places below, please use mod_node_page_state() instead of
> __mod_node_page_state() as __foo() requires preempt disable or if the
> given stat can be updated in IRQ, then IRQ disable. This code path does
> not do either of that.

Thanks, I also see syzbot flagged this as well. I can make this change
in v2.
