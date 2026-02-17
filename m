Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8B29CB24
	for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352352; cv=none; b=WBdUMIw0Y55B3ncLRkMbuL2Lk1GFFRc1/KezY4VuIFM76mmPKF7Il+PZUQrosXVtimPJnMFy88bSDtx3YFQO3DJcFbI39iOtcSJJ/0DDtsbq5ssGoO5VtcMjdNTE2qyBF49/4TPTKqEByvZ5J09z8Yf0DnffpDqIxFPNj7cl6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352352; c=relaxed/simple;
	bh=uVvbFmXUB18u0DcnJuRzA+yOILKBLpAcQf0siZ3y3yA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZcUPEzUc9543UWB7HzttU+ylXZnuU90/hAw9sKX4PTzyJDOP1Ws+D14ecyZ6YHM+aCDpGyGgQMSzccUK3fz1BOsMGeRNUyVlJ+Lv4E2J8sRoZdSQX1SHvEDeuHncOb9x+ZJrBroOoDJlvDrEeFz0+GcEF22F77LWsEPcmzXFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5Zc9yfk; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5Zc9yfk"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1233bc1117fso73717c88.0
        for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 10:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771352351; x=1771957151; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dh1AV8MM7TPE9F/5A0BmsGHV5nOWLB3oW6lLOMLZNVw=;
        b=W5Zc9yfkUYP6sgIOloPaugwdpZmUbMYB1Dx8yWo2zmQhlAnZQOqvxh9QL74RFvAtJb
         9zWQDYd5N+Z0q1wGwYg8xMZGr02o24Zf6dAw4FYD/KboFp0fQszgS10cLvItE4tH4PzX
         iKJNErtUrxnWUUrIvUgb7MQa0n0ctM/Z2szP9KFh8ryODl0ddlKrPC4qOQfDKMOMjDwY
         dPqtcgKsKNH0BO1TtyfwoAkRIM8f0+38VfqxaW9WVIvha1uhqyj2dv4HVAU5aEbUkJJa
         srw/4KatTHaw6xnODxWGmuSlYAnTzBhOVbL/krcIrioDOEsxj+MFjFJwsAZAA2El+EXt
         lU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771352351; x=1771957151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dh1AV8MM7TPE9F/5A0BmsGHV5nOWLB3oW6lLOMLZNVw=;
        b=jkwtn+IkxEKkoA1tskth+tegBlfs05ikIoyVf/EP8DFJGWBAdBqKC1b9so76fmdp94
         cxnmtDARZrhRHKS71vPVm2I4y1d/IgugPhCC5ogQ3TdMxoEV5pDY14nzCljKVRTwShwl
         yeOSmYHy4Q7ytkWMv7m5Mp+l9L2Q50JPTIZ/jW1bl+qeCle8p14JQBJ2J5OBsBxdIJXS
         EzhKQYi604GOzOOi17Qlv6HPLTHrfUMG8PrLFPZOFIe+M347n4nsT6VlsnkbtZfYyF9F
         madQQ2fGbXRa8nerAzZmamiEVhA7uBR+TQOk77MJSg0btt7P6x86MmurDUTYljcL787N
         i7KA==
X-Forwarded-Encrypted: i=1; AJvYcCV37ryEK2MCv1hD/tgO4tRYHzbjw8L3pAvgraR3MKpk8+F0RNRHYe3BeTPjoQroXnLo0IqlA4+XWZIXXHKCJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwR9LyfjdJ79uuL6N8EwNPjYcUyisTBSSB8qo5nTvOTWloa5km
	7HpnKA0DvYxml5bTVDSnqqSthTLKfgB5g+ltEA4XZgQWm6QBQ1cCuqoW
X-Gm-Gg: AZuq6aLGUmoLkbSArQ9+S/LY0iQi9A6D+CvsvviIVaFY8bOHqcHUhYgU2zO1QGltSTv
	5WUmCplqBGrTlim8q4OJk0neanf0onXbQsgMRLLJOkb2vY+ZvTvtP+8LDuGgWmEDZbAD8+t5Ufc
	wVC1qcLZAGzkSOn0yq6Dyqs44DFc61PelaY7Woh2fzxNsbcPAVV2GaSNTC545DBr9dANIsZoI7v
	aAXsncQ8ON+o7wK8qZXTtJ44yoLbV+5rs0E2lKjXdvy31cxLrUHJDEOjIBmvYqo1Li9GnxaNweB
	W2QT+d3hQZ4u9xuqVBmiDglgQ982NxUuxkOi2d6f/h62Vjn2ZSSEOxapptnRWRoEJ7xW6cohilA
	I2XWjsO8Pfqj/EKAjwv2aCIPSIHxUDj40RUHCi3j9OGEVhcqI4Ee+nW3WaQUp/bJRMsqCnIYFpR
	1xh69J9E1+RgmX+s6of4w+BOftbrgVHfJv
X-Received: by 2002:a05:7022:6709:b0:11a:fb0a:ceca with SMTP id a92af1059eb24-12741015280mr5221990c88.16.1771352350552;
        Tue, 17 Feb 2026 10:19:10 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c64282sm19689943c88.5.2026.02.17.10.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 10:19:10 -0800 (PST)
Message-ID: <c71f5dc7-d337-4510-96c4-38a83fca29ef@gmail.com>
Date: Tue, 17 Feb 2026 10:19:08 -0800
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
 <9ae80317-f005-474c-9da1-95462138f3c6@gmail.com> <aZRg_ZSDkbGWv7Vq@tiehlicka>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <aZRg_ZSDkbGWv7Vq@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/26 4:37 AM, Michal Hocko wrote:
> On Mon 16-02-26 23:48:42, JP Kobryn (Meta) wrote:
>> On 2/16/26 1:07 PM, Michal Hocko wrote:
> [...]
>>> [*] btw. I believe you misaccount MPOL_LOCAL because you attribute the
>>> target node even when the allocation is from a remote node from the
>>> "local" POV.
>>
>> It's a good point. The accounting as a result of fallback cases
>> shouldn't detract from an investigation though. We're interested in the
>> node(s) under pressure so the relatively few fallback allocations would
>> land on nodes that are not under pressure and could be viewed as
>> acceptable noise.
> 
> This is really confusing. You simply have no means to tell the
> difference between the requested node and the real node used so you
> cannot really say whether the memory pressure is because of fallbacks or
> your mempolicy configurations. That means that you cannot tell the
> difference between the source of the pressure and victim of that
> pressure.

What if I excluded the fallback cases? I could get the actual node from
the allocated page and compare against the requested node or node mask.
