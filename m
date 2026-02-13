Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCB262FD0
	for <virtualization@lists.linux.dev>; Fri, 13 Feb 2026 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771018874; cv=none; b=mazG2rJMfWp2aI4JRtxaduAjvS108xpWF8mjEmzVWl6cUGp7/A77QfDMP1ahi+LaaQEOEsW+z3JihTZR9U1e4FOzKKleVeMeHqcL7xDtSfU38kHLMjZtNCOobXBnSOtmChn5dZQztJCkOtWCHtISI3v33pSzgLltuLMEaUPf1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771018874; c=relaxed/simple;
	bh=mH50sMrriyGDz+Qbrz5Taix8L1V/wsCNQUq+G3Lfn6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVrUNEyyCKaYjMl1jbj9gw9XRd9EqiFnkT5GnCtoFg1fPmP79MMm2Jbqua7TRlMG9h7tOnrqhoZybDeX+7SAD2Vl91qpeM0+FtTkmJdy60O+MvGom1pHGFGvmgtqxuWha5WboHQDGWkn67PvIcyf1wQVIUSX0G9k76QMEXhhcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ed/tNCZD; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ed/tNCZD"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-896f95e07f5so12618196d6.3
        for <virtualization@lists.linux.dev>; Fri, 13 Feb 2026 13:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771018871; x=1771623671; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yr4En5251tETgtYzeFZ5nnuFAQ7w2oyqC71nR7DQ8Wk=;
        b=Ed/tNCZDuwrYqpLoRjmYa4Nl8H5hfrQHZ+bjHfDIhjkrN+8dDiAR/XDPcQoiBmYhXg
         ydJj2ROOJMX/Nc6qO5SDErDody6QiYFwLgsN1qPRs+QvIWWi5hiLPVPOKOyZdtvh50y3
         ZmWsfcuGkoDvzKTgx1GdRpUo0z2NgBY8aIaiuqmkajhHMxCbLEf7PC8dN2U6GkGHxRdF
         C9hc5jSiWenJgMPB7gzJPfrTcmqG/LHVUC1rd2OOiHv5Lag1gG+/Y5q9CG5YFuwjTYY5
         T+XhTvFaaA3CfSafBz9gviPyzpQC5TM3IagKrYL/nm5ns+fZErDzIwofOY8y+50AZJ+K
         cPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771018871; x=1771623671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yr4En5251tETgtYzeFZ5nnuFAQ7w2oyqC71nR7DQ8Wk=;
        b=fmXcymVAK7K/uetUvJqtHulZlkBwPaBns2+/B7Qt6z8TRI/ZFnWWRyd+jDOupAqdEU
         fQAFgJiFyyD2PwrkbRjWBZpCOyHwqk0RyGNON/2S9rhmcTFRQ3UhrwUyhegpr/uNBp7d
         CrO1wg1OtANYJ2EPpuP1DU2loDoLJLDErr8RNZvksqZXZDI4VT6ra82+q9Oy+4rvoUQX
         Xh0fTPgHc0+TfwfEunnB/TAa+XNWxLvdH3fs+JA9ci+jK3QQK5G3GIK9djKtdKq+Tsdd
         pNul/gYXqsjVJwTA9LhAwSO5c2UJib/Dwukt8clcyRTCeRr8Klf26ZPaiNSOEuJUcEJV
         TbPg==
X-Forwarded-Encrypted: i=1; AJvYcCU4CST6+/wEmpSwmBpJjue9QyBRuileZwWCzLaI4ZtUb4z06T+GvrT2qKieH9z5B15ELdwOwT2JxN9dMQBRdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhlRv5e5h1iSsah8XrzUMYwNJ97vOvCQlCwDq0QK4OZbvgc3kQ
	6Krm+hJXgdlluilagO8uG5oW+k3xhirar2oVF/NMrasYU2roofev+7NP7B0gRu95
X-Gm-Gg: AZuq6aKekM5jP2Up9FDUq0qdZ031Dg/n4Fs/b9NcI/FqqhmZ3kFWVBN5gVvg6Atgqra
	mJbQ3vbbb3YK9+f3oX3qDvz931eO99pSlxWrpujAzInkBre/TKIpsjLUhqo4IZFKT03lMlT4slj
	V+M/hCvpEvM3HoziAIGafsCbLBfbY5GEBWRzytqgXvIc5qfy35TuxedQshJTlz7Ceh6bCZqWF4w
	qX7+uUpyGb4eu4KJN5F1QwJjgWV1Qb0plA19dEssIdDR2M4Oc7KA6rWD77JglXC4dlKCf8PKm2Z
	TTedFPGJoL5xhBx3080l92BGGJZVt4uI3r+/SGNSXNOxvTS8D3TGOr6z75+2YKTTXazhxGDiUc9
	4+2XEqrcDK7cNRYd8vRdj3WHNI02wFPaAkt6kP33ZDEsCXX/9HJzkj9ozcVIEITQF0dJZ7FGwFL
	09AJzXzkd7+d0tONckDVyrYE/o08lsPAa8jheTIdhtM6c=
X-Received: by 2002:a05:7022:618e:b0:11a:f5e0:dc8 with SMTP id a92af1059eb24-1273ae30dbemr1295141c88.28.1771012577689;
        Fri, 13 Feb 2026 11:56:17 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a69cc93sm8742855c88.6.2026.02.13.11.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 11:56:17 -0800 (PST)
Message-ID: <fd56ae2c-64ac-46bd-bcb2-503df995a6a1@gmail.com>
Date: Fri, 13 Feb 2026 11:56:15 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
To: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc: apopple@nvidia.com, akpm@linux-foundation.org, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
 hannes@cmpxchg.org, joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, mst@redhat.com, mhocko@suse.com, rppt@kernel.org,
 muchun.song@linux.dev, zhengqi.arch@bytedance.com, rakie.kim@sk.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com,
 virtualization@lists.linux.dev, weixugc@google.com,
 xuanzhuo@linux.alibaba.com, ying.huang@linux.alibaba.com,
 yuanchu@google.com, ziy@nvidia.com, kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
 <96b63efb-551f-4dd5-b4a2-ac67da577431@suse.cz>
 <b5927ae8-3108-4d65-bee9-be306fb697b4@gmail.com>
 <d52066f1-c83e-4406-adca-5a403adb4f44@suse.cz>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <d52066f1-c83e-4406-adca-5a403adb4f44@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/26 12:54 AM, Vlastimil Babka wrote:
> On 2/12/26 22:25, JP Kobryn wrote:
>> On 2/12/26 7:24 AM, Vlastimil Babka wrote:
>>> On 2/12/26 05:51, JP Kobryn wrote:
>>>> It would be useful to see a breakdown of allocations to understand which
>>>> NUMA policies are driving them. For example, when investigating memory
>>>> pressure, having policy-specific counts could show that allocations were
>>>> bound to the affected node (via MPOL_BIND).
>>>>
>>>> Add per-policy page allocation counters as new node stat items. These
>>>> counters can provide correlation between a mempolicy and pressure on a
>>>> given node.
>>>>
>>>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>>>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>>>
>>> Are the numa_{hit,miss,etc.} counters insufficient? Could they be extended
>>> in a way that would capture any missing important details? A counter per
>>> policy type seems exhaustive, but then on one hand it might be not important
>>> to distinguish beetween some of them, and on the other hand it doesn't track
>>> the nodemask anyway.
>>
>> The two patches of the series should complement each other. When
>> investigating memory pressure, we could identify the affected nodes
>> (patch 2). Then we can cross-reference the policy-specific stats to find
>> any correlation (this patch).
>>
>> I think extending numa_* counters would call for more permutations to
>> account for the numa stat per policy. I think distinguishing between
>> MPOL_DEFAULT and MPOL_BIND is meaningful, for example. Am I
> 
> Are there other useful examples or would it be enough to add e.g. a
> numa_bind counter to the numa_hit/miss/etc?

Aside from bind, it's worth emphasizing that with default policy
tracking we could see if the local node is the source of pressure. In
the interleave case, we would be able to see if the loads are being
balanced or, in the weighted case, being distributed properly.

On extending the numa stats instead, I looked into this some more. I'm
not sure if they're a good fit. They seem more about whether the
allocator succeeded at placement rather than which policy drove the
allocation. Thoughts?

> What I'm trying to say the level of detail you are trying to add to the
> always-on counters seems like more suitable for tracepoints. The counters
> should be limited to what's known to be useful and not "everything we are
> able to track and possibly could need one day".
In a triage scenario, having the stats collected up to the time of the
reported issue would be better. We make use of the tool called below[0].
It periodically samples the system and allows us to view the
historical state prior to the issue. If we started at the time of the
incident and attached tracepoints it would be too late.

The triage workflow would look like this:
1) Pressure/OOMs reported while system-wide memory is free.
2) Check per-node pgscan/pgsteal stats (provided by patch 2) to narrow
down node(s) under pressure.
3) Check per-policy allocation counters (this patch) on that node to
find what policy was driving it.

[0] https://github.com/facebookincubator/below
