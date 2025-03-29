Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB011D6188
	for <virtualization@lists.linux.dev>; Sat, 29 Mar 2025 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743278144; cv=none; b=OoRgWDEyhFEkn/dssJSMujh+0tyvP1eGZ0mPf2B8Zm0eVPtYIO3ZRRZjKJXysf1ALkuMco2PEp6wzsxP76Xi0maCElrhvtNNdhSBBDwJ6mqh5x4+EpNUzFYykJCKkkCuNdshaNLAMZKHiLCm/mAiQKjX3o6soiIphRyblMsBebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743278144; c=relaxed/simple;
	bh=eZE8/hjKsHgtycknl8v1WA+0nxrA0HY3fPZvx4gGCLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaS7/n9j6q3tLMdjGM8W9VPL1QfgYXSjCXQxKU5QM5iTj1tT1U/OMgaiHygB59UyJo2FQKUIe4ZAzVQY5TwWaxat+O2UqaWJx4kUXXzFQW0d+ivmcu+/PSFXOmypqYJl1hKTArbDVyv2LrjAM+CIr3KlGXykk2u8nyhfmjFXPBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxYmdTmw; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxYmdTmw"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e694601f624so1863457276.1
        for <virtualization@lists.linux.dev>; Sat, 29 Mar 2025 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743278141; x=1743882941; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u308vrKVuoCKv+aJT65raHq9rbK345amQxp+zuYQWyM=;
        b=QxYmdTmw9Z60Yl/ZEBfmubgdObn/iE/isCJgHR6vQm+BPQ9ew7uHx/vMp4tfdRy7mR
         cfm65pirfTbU/N2ilgaia6YV/Rk2Vg9ZA9WJgkKaPjAI66rXwtcvy+5Y4imvgAl5AfIP
         Wrjj7l2cfgn70SI3Zv+r20zU4hiq9z2m5paRxoNqEarX17ca5f8Bc2CcjlvqK09EVfks
         hY0nHaUt6g/5GSVcT6o8dnSSh93snjEQgIKX87t3I99ALcAAmr+/U229kM7pxUAWcKtA
         y+9SeirT1kLXq8eHbPQmnKW7GcXu4+VqLhLauhAqp40GpBY7iHtHoDuB7mDwtbONUxJS
         94cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743278141; x=1743882941;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u308vrKVuoCKv+aJT65raHq9rbK345amQxp+zuYQWyM=;
        b=pWrgfHeoQ+bwqEjqETJ4OEH0XrPcQEZRKnvuUnX5hkDthqJG3P0TvLkvP9Hhw8rTWl
         sufVTcI2IwwUhqBlW7etEreBBZfhKibK6vo60yZyNUsbubyzHyFROAAXrA/6UJogj27G
         bqj0ZfSapSycasxRU0kiBogF5WlkwIeGofqluOs/Zxipt2JmBoU+nWvAHkRj6voxWuEy
         TGX4xq4/xRgUf7+aZhIrCK96vl3admGxD+3iIA7a0a06EZMlDM7R9ksebCkMQDLzPwh2
         5o7yt/rGaxoKRSbXZS8DGyAc19f9I7UXI3NI3tdo7sxrfR/8ufa1qafccaP16DvMKoZE
         WCgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5A0rcJsZJLyFoEgkFRGrxLCxSqKHruRM72fbzgNYSHZywBCST7jCQdUfamw1dBmFB9A/Ip7iQ7mFaihEePg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuawfTMED9FRsRLNfLkLUa6kKhRz/JEQpbfRwvMTaa5lwl79va
	jzVoyAhf4KZtITpBRTdiX6Ty29PbbB7UcnDUAcGezPphY33kpqhc
X-Gm-Gg: ASbGnct3Ltr1eJ49u9AFXAayqm1L77v2Wsp00eVMJUrTO019shGE4JP7InHApQyAKPt
	5bbQIzL7z4ffmCDH3spwNtly+dXpbz8E6ng3+N3bpj4wNp0KyKYxoFdQigLsSnBrk2ZSNlAK3mH
	YDjqB2/w41F5UA62rq9ZCssnLFUONz6G7wsCEfSln2rNzLsdbqjYxchK9RwZDQRp4sFo8s+3804
	sGc3bIvWIOtzz8dm/8N5k+2nFnQm4ueM+OXzvXog41l2hmGLoNMDyv2PH1zxlpqvZyEY7RUvJIm
	tdtndcPPKRNQQ73q+IGax/3FzCWy6+egHtBAAdozlW+1mnHFrvg=
X-Google-Smtp-Source: AGHT+IG4rcKHYfG6fUGVUeKFoCaHXdI7Vf7h1ZSu+rjN4tPNcDUIdkmqIFpDhXKjne+NQj0YXgNZuQ==
X-Received: by 2002:a05:690c:4883:b0:6fb:3b2b:e73e with SMTP id 00721157ae682-702571117d1mr59207557b3.14.1743278141336;
        Sat, 29 Mar 2025 12:55:41 -0700 (PDT)
Received: from [10.138.35.215] ([45.134.140.51])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7023a3c44besm13457077b3.55.2025.03.29.12.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Mar 2025 12:55:40 -0700 (PDT)
Message-ID: <3baabd6b-95ba-4f84-bdef-b44d6d071aba@gmail.com>
Date: Sat, 29 Mar 2025 15:56:00 -0400
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] *** Add virtio gpu userptr support ***
Content-Language: en-US
To: Honglei Huang <honglei1.huang@amd.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
 Huang Rui <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250321080029.1715078-1-honglei1.huang@amd.com>
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20250321080029.1715078-1-honglei1.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 4:00 AM, Honglei Huang wrote:
> From: Honglei Huang <Honglei1.Huang@amd.com>
> 
> Hello,
> 
> This series add virtio gpu userptr support and add libhsakmt capset.
> The userptr feature is used for let host access guest user space memory,
> this feature is used for GPU compute use case, to enable ROCm/OpenCL native
> context. It should be pointed out that we are not to implement SVM here, 
> this is just a buffer based userptr implementation.
> The libhsakmt capset is used for ROCm context, libhsakmt is like the role 
> of libdrm in Mesa.
> 
> Patches 1-2 add libhsakmt capset and userptr blob resource flag.

libhsakmt and userptr are orthogonal from each other.
Should the libhsakmt context be a separate patch series?

> Patches 3-5 implement basic userptr feature, in some popular bench marks,
> it has an efficiency of about 70% compared to bare metal in OpenCL API.
> Patch 6 adds interval tree to manage userptrs and prevent duplicate creation.
> 
> V2: - Split add HSAKMT context and blob userptr resource to two patches.
>     - Remove MMU notifier related patches, cause use not moveable user space
>       memory with MMU notifier is not a good idea.
>     - Remove HSAKMT context check when create context, let all the context
>       support the userptr feature.
>     - Remove MMU notifier related content in cover letter.
>     - Add more comments  for patch 6 in cover letter.

I have not looked at the implementation, but thanks for removing the MMU
notifier support.  Should the interval tree be added before the feature
is exposed to userspace?  That would prevent users who are doing kernel
bisects from temporarily exposing a buggy feature to userspace.
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
