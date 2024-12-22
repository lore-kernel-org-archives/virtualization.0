Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8550722071
	for <virtualization@lists.linux-foundation.org>; Sun, 22 Dec 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734832806; cv=none; b=exowggUpVsKkrp0QGz2uvPtWOzWthj0ERmj3DbsjNKAZPb77zRZAGF9jQC5N7X2ZNPDeSNrj1X8hO2gZPpdg/r2zdHawkOvBNuj+vU3rCouoOKRUzFLAB5ykFtxTCwfXFCEzKwDuhz5rivuSG4NX24INtZti8cyjEMTesK9f18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734832806; c=relaxed/simple;
	bh=PupV0ghxIQT+OZ8i8/5gBczxTlBbCc38Y2ykxQw1oFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P6AAkziPUl+SuhoER2DoaHKDOpbWEXRdwPm+b7Azz7h9NhQIEGq5mkXujR2myehGrDa4LGMqswmJq3o1paG5EKt7DGKYsbLuwNxSQMT47D/4TkeC3zXbbyTMBeDIahY59fSOAyQK7njVwVdqSkRBaekxvRfGiKZi2bCyuZYxs6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4qmukoe; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4qmukoe"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F3176084A
	for <virtualization@lists.linux-foundation.org>; Sun, 22 Dec 2024 02:00:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XbMNgkkMZVWX for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Dec 2024 02:00:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::e32; helo=mail-vs1-xe32.google.com; envelope-from=demiobenour@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 08D9D6083B
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08D9D6083B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=F4qmukoe
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 08D9D6083B
	for <virtualization@lists.linux-foundation.org>; Sun, 22 Dec 2024 02:00:02 +0000 (UTC)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4afe2a1849bso1769489137.3
        for <virtualization@lists.linux-foundation.org>; Sat, 21 Dec 2024 18:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734832801; x=1735437601; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWFU15fJ4L3Ec0ACNvMZbS9c3dQNjLQi5WORN5noOTw=;
        b=F4qmukoeqtfb2FYnCdc24Y3x/vU94qS6qeoWOyxNG8TqSx3e2us7K+fi1pOuHbRHlj
         vqyI1B9w3JBJgsbuVPQ6oPTpr9uz4nL/+uJlrM+gySIumazhzktop2EI/4ivBYA4+EbO
         jdt5hi68wlAD2d5OQCudN0NjP+8gMwwdl0k/eHW2uKFchI/J8XRUNA71RHYSf4eOO5mI
         tKqmw+XneBxE2g7WC58S82+IxuaLUpU0zD/nAHISkOxdoU1WUHZShYc+gb7G/v+0AI/m
         LpO2QmdeydFMd4LRrx6Q1dtSPXNMUN2rxYhalq9VZ8Xr+hFFw+wzFB4+VHAt/gdOm97c
         wB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734832801; x=1735437601;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWFU15fJ4L3Ec0ACNvMZbS9c3dQNjLQi5WORN5noOTw=;
        b=hxF6PVkAHPpNRcr8IhjhCAvuW0Ll8eAOkHCG4j/zbq9oDwIMO4ntmMlS/gK3W6xrBe
         TwTJQPbukhVLR+UmX5SA1KjtjOblRUOsFMSMKVZmILzo0wYu2xD0XGq7g4iGF+TM0hFb
         nmt9C8EfntfsrfdPSLvkEhZqvWt+1811KmmXwhi3qk9gV2dMl3/2Kmf7XXC4pgrbe1WP
         jFRwVw9S0jde7GYe/Jg3zzN3WPwzFUYNyPkk/0HQmuO8t1Zh9nCHiHcjwTeOTHu1hR3w
         Va0+V/f40EQkBGU0h2DaNoN/PrQ+Al27PAoXsHgis/hTBidpRMNqyM9iIrRJv+BZrN15
         ed3A==
X-Forwarded-Encrypted: i=1; AJvYcCXHocCBEtwFos3j36Xq5up7a8b0kfEmleqm5fpGwHYcGh87mCI7+3EtNYDE4whWDx4kJ1u5yQCS2pR6ZBsyYQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwSCq2Hn6wUVFYpL43goPUHB8boVmeOOFcb1+lSQeIQj9Fw4NRJ
	DbM9TVmEvwVydZBxD9ZIvyciHHvAt7TW4vcgUIU3S92yPeu8bdaC
X-Gm-Gg: ASbGncvymQWDwa96D6hGzTE0gcyw6TSwI2FN7J9TRy8aqjZnOiI7RWJFB8ik/keAfi+
	zu3CjpdVWnTM1NZCoBiPNGK7XGAMu9UjH8EWvvMaDzkinx2u7Sm8qs3sT15Ip4R241eIzG1+Xw4
	ZUSiaeaL8o+Wc9IDxnTniyBLzPrSziostyIZXbH6fgCyqhoLB5i8uTKlndDSDWYEQgOxHpES+IP
	t4zlB0/+r3qhNx5fis0wNwZKThTFWJ0hkrjJqrDmPNaO0aujKC5DjD3CxA=
X-Google-Smtp-Source: AGHT+IFKHaVz4WvgkgRU7/knTE0SXER/wJFjxFtceqzkT6YsvNlgrKqNJe11JRtidu0QIkQ76Yt8mw==
X-Received: by 2002:a05:6102:4427:b0:4af:e61d:e22f with SMTP id ada2fe7eead31-4b2cc473647mr9803375137.24.1734832801423;
        Sat, 21 Dec 2024 18:00:01 -0800 (PST)
Received: from [10.138.7.94] ([163.5.171.73])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8610ad582cdsm1134069241.32.2024.12.21.17.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 18:00:00 -0800 (PST)
Message-ID: <2fb36b50-4de2-4060-a4b7-54d221db8647@gmail.com>
Date: Sat, 21 Dec 2024 20:59:58 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] drm/virtio: implement blob userptr resource
 object
Content-Language: en-US
To: Honglei Huang <honglei1.huang@amd.com>, Huang Rui <ray.huang@amd.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Lingshan Zhu <Lingshan.Zhu@amd.com>
References: <20241220100409.4007346-1-honglei1.huang@amd.com>
 <20241220100409.4007346-3-honglei1.huang@amd.com>
 <Z2WO2udH2zAEr6ln@phenom.ffwll.local>
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <Z2WO2udH2zAEr6ln@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 10:35 AM, Simona Vetter wrote:
> On Fri, Dec 20, 2024 at 06:04:09PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <Honglei1.Huang@amd.com>
>>
>> A virtio-gpu userptr is based on HMM notifier.
>> Used for let host access guest userspace memory and
>> notice the change of userspace memory.
>> This series patches are in very beginning state,
>> User space are pinned currently to ensure the host
>> device memory operations are correct.
>> The free and unmap operations for userspace can be
>> handled by MMU notifier this is a simple and basice
>> SVM feature for this series patches.
>> The physical PFNS update operations is splited into
>> two OPs in here. The evicted memories won't be used
>> anymore but remap into host again to achieve same
>> effect with hmm_rang_fault.
> 
> So in my opinion there are two ways to implement userptr that make sense:
> 
> - pinned userptr with pin_user_pages(FOLL_LONGTERM). there is not mmu
>   notifier
> 
> - unpinnned userptr where you entirely rely on userptr and do not hold any
>   page references or page pins at all, for full SVM integration. This
>   should use hmm_range_fault ideally, since that's the version that
>   doesn't ever grab any page reference pins.
> 
> All the in-between variants are imo really bad hacks, whether they hold a
> page reference or a temporary page pin (which seems to be what you're
> doing here). In much older kernels there was some justification for them,
> because strange stuff happened over fork(), but with FOLL_LONGTERM this is
> now all sorted out. So there's really only fully pinned, or true svm left
> as clean design choices imo.
> 
> With that background, why does pin_user_pages(FOLL_LONGTERM) not work for
> you?

+1 on using FOLL_LONGTERM.  Fully dynamic memory management has a huge cost
in complexity that pinning everything avoids.  Furthermore, this avoids the
host having to take action in response to guest memory reclaim requests.
This avoids additional complexity (and thus attack surface) on the host side.
Furthermore, since this is for ROCm and not for graphics, I am less concerned
about supporting systems that require swappable GPU VRAM.
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
