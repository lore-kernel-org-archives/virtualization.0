Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9F33A9EF
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931531; cv=none; b=BhxEGcQKxMGh9Y2k5hzjuJHSIevAiidke70jsN2UlCEpZI69+16Npykscoqq6AC6giTLEGdDaQZoYfaf9wDxywnJP5Ra4FyeQyIexMXEq7GUxD8aah8Xb2LpsznVHMGujdyraBWklX8uPxitkOnXKP61xLBqvSmF+4wNZctlId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931531; c=relaxed/simple;
	bh=4VOKf0xEU2BdqyQq8g7jnYrqEcpcWaBqoYKpXVHd/0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erRjkU3LuLb5Pp62U+cNz+6nJV+GXUv57nTb4JJDX+ll7UHDlm8NdVmxrTzVwqEKIHRzjDlUMAGeLKIgBN/vsQ6uUNlc+12dH1T7Xw6sKf3Vib787O1HUGqz9KYW6Sf7HGFoqMHSJ9o9pKalTiKbWUfvdbUB+Pk0+AEa73evwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg3Vm2nB; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg3Vm2nB"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ba94dbf739so335436eec.1
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 13:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770931529; x=1771536329; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCh0D1PgFCAnFv/ObCs8wiM+Hp+1ve3byqWcWmOrNFg=;
        b=Sg3Vm2nBtBY2qE/qEvRCPjV2LvYZ8oT4rblIZzUodwVlZ+83PKcjw90FVh90uhheis
         m6gbp3DkJ5erIY777Kudq1/Os6MQlBWvpMpAJz+x0XB0ZxM92KigjzZbRmFDx8RCl6T2
         qTAEc+2t+8zkeqbhHrcJNIG0S7dDRBWDKEszKovjuh4btwC5H1hILXfOhRfPFwusCNhN
         BS+RezqiXlUnIUcYIS9kw6NIXtKGzDfVy425/UlQsKv4AbXhqgMNorGolG/CHSVnKr8L
         rdm320e1BaHQvIDu6aVb13lWNECVjobikSZ1G9sm+r4ktsbzR5BVpJz7DH6yLYCXpsG+
         KfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931529; x=1771536329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCh0D1PgFCAnFv/ObCs8wiM+Hp+1ve3byqWcWmOrNFg=;
        b=aGxsyaSAi9pvV3JOizhu0b2TPG52LOy6IKsjAQKWflRuPQohDQV9ZnU6SWwGPJ2iRM
         V/yI0j1MOdC7OSBqb9Ee+6pdHbmAkoCw8wQ6qVNy+4LWxHnC3w+c7Ku0QDaXpSX96/Yt
         0PkeYZMiME5+GQojx9kgezc5aigaLPVVQQbZ8LdYlciR0+rHCFDHu/QQiKdeNbp6MtFD
         mI0KTQwqg29fyB2MY5IERFsXPQswCW6pJgIaD7IzHL/iBxvr/v4ZFNBApagoidutRJ+1
         k7hCMZ3TJByK4HFQddXn7njkdhuOxFieUavhLNTpI7f3qxL4VoysKP2hCPuadF2BvCYm
         03cA==
X-Forwarded-Encrypted: i=1; AJvYcCWOwrbMy56USONfRg92YaT/Gter1pSjDc9cxr7mCFQ9YaSgcNbsrF+5sY2gHykH8nnAqs1R+xumcn33uJxCeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdXZE0ZNJJebOErZ8AFKIrQCy/a9D0XaIjUXR8Rv1uBAn9gRgs
	ior8RsmXPHR5KjVF9gN9iEnVhd2RI+xXkrVkUjHR+iYSpKtQLQZLl5sR
X-Gm-Gg: AZuq6aIGO5HELWFztp10IHzuobF+dTLTLeaDaJ6XmbYgnHdMEKnKV83WQpezVck2CqU
	x/BD3TG7R0oPGIA9CuFaR6brE6Q/AJ7tcyA6u1cnGocwcjkc+CiDoA+FqPLaiQHDDNutnl3vqEa
	N4QK8O8nSZo2qhH/FI8rGd84/e3JPtUYwcjP8jvrt1zJvHkIKPeHOVsoszrPnFH136DWv3Y+ihV
	xvqBVPHcjnNoDkNx6tp/HktydtSGaoOg5BDRpUqIwexChJfI+gGKetHOAbE/MOrMxz63Dge5mVv
	G44O3huHzllxFcPOK/PUdGJ4qyuYWtcKdD2YnEX28Q34Yl6IQ6OALI3EdAbRWFK2IuUMe1mJoP0
	XR8SeaYxpSr3mmM+aoiWL62mGom3llW+b+AsziKlHrA6rQYV59nB+vGdiH77Flt/4yX0GT505Qd
	uGJCuQOkWQyIfushbLUlxWVWSDhv361vFU
X-Received: by 2002:a05:7301:7c12:b0:2b7:f44a:a6ad with SMTP id 5a478bee46e88-2baba136a9cmr114756eec.42.1770931529389;
        Thu, 12 Feb 2026 13:25:29 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd0614sm4779914eec.22.2026.02.12.13.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 13:25:28 -0800 (PST)
Message-ID: <b5927ae8-3108-4d65-bee9-be306fb697b4@gmail.com>
Date: Thu, 12 Feb 2026 13:25:26 -0800
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
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <96b63efb-551f-4dd5-b4a2-ac67da577431@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/26 7:24 AM, Vlastimil Babka wrote:
> On 2/12/26 05:51, JP Kobryn wrote:
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
> Are the numa_{hit,miss,etc.} counters insufficient? Could they be extended
> in a way that would capture any missing important details? A counter per
> policy type seems exhaustive, but then on one hand it might be not important
> to distinguish beetween some of them, and on the other hand it doesn't track
> the nodemask anyway.

The two patches of the series should complement each other. When
investigating memory pressure, we could identify the affected nodes
(patch 2). Then we can cross-reference the policy-specific stats to find
any correlation (this patch).

I think extending numa_* counters would call for more permutations to
account for the numa stat per policy. I think distinguishing between
MPOL_DEFAULT and MPOL_BIND is meaningful, for example. Am I
understanding your question?
