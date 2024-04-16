Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C20383CA4
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237626; cv=none; b=jSsSmnfdct5n0gMbXytB+2/GqhsyZIx0zTQUQolgUKiHxa419WuFExKxKKGuR2BZPmPVfTUu8zUesxGOsgMcLD1vFBPbOM2t6KpVu4g0BjYmCrzBUdtAGiGK0piCcjAwOBQbwJs+7ADpxgojBjaYgt2IC/VgejU0AiO8onTFXEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237626; c=relaxed/simple;
	bh=clVen3V1jipql/Yrjw6Ruj73LS3KLaVB/ACn5a3b6ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbJcIR7U67kYjKojZLPo199TScmjdWZnIp6sNPTFVU7sO3rVQFB85xx7k4pM51j+lo/WMAMGcgQNpgeDjEP4g64weubASNQNQA/LqqLvAGW7A9Fe10k2J9ZCvAokUZQBCyIDSv147HUGolXV9WO2Ajjob0WitSQkqXWPD1g1qso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S1xolNxW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S1xolNxW"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so21288195ad.0
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 20:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713237624; x=1713842424; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+lHv0WjSUS0/ZTvnK4A3g1boJSBNj3lLffVIsFdrOUs=;
        b=S1xolNxWmgOUv6OKea3xh2hpv7hkfefJCHAhtisa6nEzpe2FuBnyqO/48wWlapOY1A
         9PujnmK9/dFMM81huvwl51HBH3XQwulMuFsOB1xlIkx1WQpUz9qChxPvhTecV3zemRfc
         qkglXqT1/TU8ptt3IhM/dNyWBwQdUZH33NreUY4QNI2+wdBv0lNxC2Ujkodsw/rJ7/ua
         YKff7IhzbexMLdRI5MxYWT4lRTwxDN9dSXf3nY5muSdnRqrJn1z05wyjblXsErAQHMda
         Dh5OR9FrIwWM/1Mf+QASzsOApUboPs4iE+WM5G+ERXCOzT93ySFH8ZeEzNApgNmRg7EW
         cFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237624; x=1713842424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lHv0WjSUS0/ZTvnK4A3g1boJSBNj3lLffVIsFdrOUs=;
        b=kLAn5x54YfPaciCMKfHmcV3FtrojE8WXis1BUh5SWTOh3+TFSZijnQQcLZk7/mcp9L
         C+XMzr1AfpmCxm9gF52M6LZ0/3nL3VdDpGAnrnx2c3hCFNCKPkHK3ej0RYSlT/labpUB
         zeYxs+zlCvA1MTKRPgjtCnIZtc1vaqbKWashNqggEY+cSPjhadArc16iLsoEibkn1b3V
         /dzG+7FSbaBMZC6ZKX0f1XWBzxY4sLRcuIkgAz60AccwLw99YBrPii9gyzSKW/sVFM1+
         AbIuTwGa+S72AqWre8Jmf2W0tgOnT8s0bhVg4R9BpgRW8O4bmCX4etuvWGis4K8JIi7p
         HyIA==
X-Forwarded-Encrypted: i=1; AJvYcCXJqYex0q/EuBNUN+P/E7MdsPjpTXE3ims/xpcv+1wAzTbO4Vp6ny55yIi5452cP+XjA0hH2rHtJ/wOocyPSKhYtZuzRMWKcnprUJAkCbk=
X-Gm-Message-State: AOJu0YweskkpnicYDOopz4Cnn3MSuu+jd8EbkWpIKmH/kbsX1l3v/nbL
	mzajjFw/obtnXGu7czPx7FqQM6RxUsPhmpZjfd273Y76j6kxZBDClEOoZTFzvXM=
X-Google-Smtp-Source: AGHT+IGkkCHrVas2WX9GNLxY+hWNmIALkljn0FUFyXThYhisWj9SErZLdlVT0OL3IKHgguvcHYHNDQ==
X-Received: by 2002:a17:903:41d0:b0:1e4:53b6:6be with SMTP id u16-20020a17090341d000b001e453b606bemr2302239ple.1.1713237624396;
        Mon, 15 Apr 2024 20:20:24 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001e4458831afsm8674525plh.227.2024.04.15.20.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 20:20:24 -0700 (PDT)
Message-ID: <c88b999f-39f9-4771-bb28-b6b0cd5ba22c@bytedance.com>
Date: Tue, 16 Apr 2024 11:20:19 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [RFC 0/3] Improve memory statistics for virtio balloon
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240415084113.1203428-1-pizhenwei@bytedance.com>
 <ee1ac0fb-daf7-4aea-b07e-f8879b6b860b@redhat.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <ee1ac0fb-daf7-4aea-b07e-f8879b6b860b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/15/24 23:01, David Hildenbrand wrote:
> On 15.04.24 10:41, zhenwei pi wrote:
>> Hi,
>>
>> When the guest runs under critial memory pressure, the guest becomss
>> too slow, even sshd turns D state(uninterruptible) on memory
>> allocation. We can't login this VM to do any work on trouble shooting.
>>
>> Guest kernel log via virtual TTY(on host side) only provides a few
>> necessary log after OOM. More detail memory statistics are required,
>> then we can know explicit memory events and estimate the pressure.
>>
>> I'm going to introduce several VM counters for virtio balloon:
>> - oom-kill
>> - alloc-stall
>> - scan-async
>> - scan-direct
>> - reclaim-async
>> - reclaim-direct
> 
> IIUC, we're only exposing events that are already getting provided via 
> all_vm_events(), correct?
> 

Yes, all of these counters come from all_vm_events(). The 'alloc-stall' 
is summary of several classes of alloc-stall. please see '[RFC 2/3] 
virtio_balloon: introduce memory allocation stall counter'.

> In that case, I don't really see a major issue. Some considerations:
> 
> (1) These new events are fairly Linux specific.
> 
> PSWPIN and friends are fairly generic, but HGTLB is also already fairly 
> Linux specific already. OOM-kills don't really exist on Windows, for 
> example. We'll have to be careful of properly describing what the 
> semantics are.
> 

I also notice FreeBSD supports virtio balloon for a long time, 'OOM 
kill' is used on FreeBSD too.(LINK: 
https://klarasystems.com/articles/exploring-swap-on-freebsd/)

> (2) How should we handle if Linux ever stops supporting a certain event 
> (e.g., major reclaim rework). I assume, simply return nothing like we 
> currently would for VIRTIO_BALLOON_S_HTLB_PGALLOC without 
> CONFIG_HUGETLB_PAGE.
> 

Luckily, virtio balloon stats schema is tag-value style. This way would 
be safe enough.


Suggestions in patch [1-3] are good, I'll fix them in the next version 
if this series is acceptable.

-- 
zhenwei pi
