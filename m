Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5C327A1C
	for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030876; cv=none; b=tYaOjD0Yv23Dprcn0JA0iSlK+JVXX+3lHRiXGHaJpAohsFnwX/A161usI1YyKeYk/5xkEND/Lr324xfOLDA0Y7ASeJopCpUyp53JoOm5/Uda4qH3XTWcGA8oXjxfSap2scSLa1KP9fxbffKXXJesAVmtpGgGU5Kofkeu0NqfzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030876; c=relaxed/simple;
	bh=fWCmqFEd7OPomJ7rITpLZOiL9NrthwW4j7FV0SpV4dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V19b1W19zlqe0AZ8iI8GqPXcGqjAC2VGmsqa90M7rndahoWsyWmXZzEa3PaMQ40G62LUzyyKcVZ9Uc9t4c0RJRnAJYSmGLfgFGk2d0ZFz+Lc5aRlYukmG3KqegKKpdd4j0IaQzJxDnvE4Xp0DemfwuL6i8D8Zg7Tvpswn3PJTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gxIl3YNA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gxIl3YNA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26685d63201so20556625ad.0
        for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 06:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758030874; x=1758635674; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPYXwMaf9XORYOvpeTSKlqB+qoDKbzWhfT7TOlo6D2A=;
        b=gxIl3YNAU+jr3kG96VDBLuaqsXEDCHWqsky+YJDpfziv2uWJb+fvpXYXoOeuoEdgfi
         hxYXTS1fV8QDlg2mFBmrGlSCLCwEgDqAUFaf/jihch4RTfxCnNoqPuI1cP0gdzv/Ct/p
         qrnuQAvRcJvCHewVsU1R2Zx8HwTjVeq57LKIiGGA4RFA0eVAz/u9pmeszyl/JvoX94ny
         LcQIt4aS/uLgwWGGKvwnFLESJK5ErHUBAgwHbDtXyg6f7uBcyufTdx0wr70eLNQDWBbQ
         /8ovCOI+rDUFgkYxTAje/RaiKwPVJjx5uyrnTl3mITHfIJOeUdldR3KAXA3jJtAO39nD
         ggSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030874; x=1758635674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPYXwMaf9XORYOvpeTSKlqB+qoDKbzWhfT7TOlo6D2A=;
        b=D3cwwHK0n2nuHRvM3LED0g2z5PEx+hZ0fP3Occ6tHW1X6ZL2yDzqj5/3NJAT14Vy+I
         bvtxpNPAMtxc8JVv88lGJIZME8AY67u10zQGUIxBtV1cwkMGkjW2N2nUQThdwpOoFIVh
         v1DO8g9WGSurR5EzXE7N4ApfNKu0HL+MoFMae9hSCKGB/5W29siyHLJAgNE2zK5EIyG/
         QLKs0PbHfpoWTvvVh56+en4oAVdXSMiLkrtea1T+kghE2A7i2mt605sOgGv74TGEefql
         YhO6utcGgLc1o3L9hgELBDwtd/Fhmi3TkRBjqa0AfJ6Y3CQgFLMJQrALCFxv7fuaVy+K
         K+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9ZgrejBYxJgOLSdSfMqPDD4Y0Q6AQDHqP4sIJbPK0Y2TO/M72rnoukmHpufjyATF/aaTTCPAZ6oalFl0BPA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxiuf+pMHvd6pcsMsf3nol3ii+r7LQFIWZHA2is/tJiW2rngoGv
	yMcRZgA27ED9+dDhX653Ibrhk+4boxN/XArmWvP7k9T/6GqPWkD8xrI92B6Z7qb9d1o=
X-Gm-Gg: ASbGncvyJGn0NdTmPLNYB65nHz4PHfJDaYL2pG7u6t4qS3LUSAEYRQnCUAciox1wRVI
	IxvVUue3dt1E9UDVw2nmnjg27Wa2ZQezA1V/3WGFUo4bMNds1Xwk85ZlYRQ7joUxTUwZT+SGJkU
	mobhpDto2iBeZ6AbPV6ZjsTSiVUYgCcsYCV9sSGtW6REBqtd4HJsqUSgkpdfOY7qtmeYkXS/76i
	vrvCjCuTpzqqjnM+ikCTkLQ2WWvEdhx8/+dOWF1FCHdynWmtpHqLK0E4t6t3EkxNCnMladg+mjA
	wVL2VdVbKbSix7nF/BM3g/S4JFKTS8jC08tbmBlFx8MSY0k+sPJ44oBeob+XZ1kTcdylo4Wixfc
	+O2ht0mVj7fvsg3UghRSj9pWfl/6Ptn1zc9peXc1IuKF8/IRLReDgHFNvaniH5bAdkaSTliS0Tb
	SYEmWVHQ==
X-Google-Smtp-Source: AGHT+IG8lasNhNhAYlDmGUXLI8t/qpiw2FP6ff9Jqqn0r2lmG1QOH7Icm2zQ9M4bySvDLCeAO1oeKQ==
X-Received: by 2002:a17:903:f85:b0:260:5bab:8cad with SMTP id d9443c01a7336-2605babb245mr163297405ad.29.1758030874302;
        Tue, 16 Sep 2025 06:54:34 -0700 (PDT)
Received: from [10.88.213.9] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2677a5cf655sm52556865ad.4.2025.09.16.06.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:54:33 -0700 (PDT)
Message-ID: <18e7bf9b-eb4c-4c4c-a00e-bfe0bc07e81c@bytedance.com>
Date: Tue, 16 Sep 2025 21:54:19 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page
 size
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 xieyongji@bytedance.com
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
 <CACGkMEvWNOjFU0pgiS=LF2B+yEC-y_RU3w_P5_dr10RPH+5xrg@mail.gmail.com>
 <328b3f8f-cca7-4d8f-9335-24341b40b2d5@bytedance.com>
 <CACGkMEvXH+VpA-2sJ39QL4Rb3Gg0VCOKn5BApRpft=583Qcp2g@mail.gmail.com>
Content-Language: en-US
From: Sheng Zhao <sheng.zhao@bytedance.com>
In-Reply-To: <CACGkMEvXH+VpA-2sJ39QL4Rb3Gg0VCOKn5BApRpft=583Qcp2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/16 15:34, Jason Wang 写道:
> On Mon, Sep 15, 2025 at 7:07 PM Sheng Zhao <sheng.zhao@bytedance.com> wrote:
>>
>>
>>
>> 在 2025/9/15 16:21, Jason Wang 写道:
>>> On Mon, Sep 15, 2025 at 3:34 PM <sheng.zhao@bytedance.com> wrote:
>>>>
>>>> From: Sheng Zhao <sheng.zhao@bytedance.com>
>>>>
>>>> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
>>>> even small IO requests to occupy an entire bounce page exclusively.
>>>
>>> This sounds more like an issue of the IOVA allocating that use the
>>> wrong granular?
>>>
>>
>> Sorry, the previous email has a slight formatting issue.
>>
>> The granularity of the IOVA allocator is customized during the
>> initialization of the vduse domain, and this value is also modified in
>> this commit.
> 
> Ok, let's add this to the changelog.
> 
> Btw, do you have perf numbers to demonstrate the benefit?
> 
> Thanks
> 

For arm64 64KB base pages, compared with fixed 4KB bounce pages, using 
native pages is more likely to fill up the bounce buffer(default 64MB), 
resulting in I/O performance bottlenecks.

I used QEMU vduse-blk as the backend for testing write performance. 
Below are the fio test results:


	  | native       | fixed-4k
----------+--------------+-------------
numjobs=2 | bw=44.4MiB/s | bw=47.0MiB/s
iodepth=4 | iops=90.9k   | iops=96.1k
----------+--------------+-------------
numjobs=4 | bw=58.8MiB/s | bw=61.1MiB/s
iodepth=4 | iops=120.3k  | iops=125.4k
----------+--------------+-------------
numjobs=8 | bw=64.0MiB/s | bw=74.7MiB/s
iodepth=8 | iops=131.1k  | iops=153.1k
----------+--------------+-------------
numjobs=16| bw=69.8MiB/s | bw=92.7MiB/s
iodepth=8 | iops=143.0k  | iops=190.0k


Thanks

>>
>> Thanks
>>
>>>> The
>>>> kind of memory waste will be more significant on arm64 with 64KB pages.
>>>>
>>>> So, optimize it by using fixed 4KB bounce pages.
>>>>
>>>> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
>>>
>>> Thanks
>>>
>>
> 

