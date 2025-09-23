Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81E245006
	for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631038; cv=none; b=CRHIe21PyPVUP+QVI2C7P/OexdXGlT/vM0JGk4YCFNO1SAVXypWo/cs01TmNbD2f5e9Gwpfx4wxaSv30ZJKmOTQZzJKAww4uo3D1OKUm2yRA5FXWxE0gW73+k/f8K+5WMBEEDCW1+YCAL8MTS9K/X0y56AJaG7PTbp6TabdBx+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631038; c=relaxed/simple;
	bh=4/rN8y5+hFoB6Cf/znI8mLfQe+LliZ/NJWGVQ6hJxaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHvyZfX8bR/MhUpGcmjX7uMcGtyFyRATxtI7GKWnwtp5yic0UthOv6wsKPdyCkGu1S5sfuRuLax7nd09nNU3UsjapYBWwkdHWGPDKAKUgm4rdyOmt8YQcE+x74S9snBISkzgwU4YJbvRKM6zmiTfdMfzx0qGhSmEZBdajcc+cF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ipgHxLjV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ipgHxLjV"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5518177251so2618943a12.0
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758631036; x=1759235836; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4210Fm1QpLo6WEa68t+fTvLZqwxqcYrVkyyGk5pqsks=;
        b=ipgHxLjVkYeTowZMl9LTmtN5gezyz2PfLpXTaRvWUaj56q1L55Pfu1xIXz5XI8wKjq
         ufHdoy69J3wIGNjSYK0DcFMzJmeNFcUx92wT6cr9FVZlbNkyoFP3ZKjnA+6FoHZVCjmu
         BkhNccsvRgvdI7l4WcktgSU3fX7pxHdhFcx2s3uVPVfnKOTRMpc1YCs6SfO9fz10rT97
         W37EkPeU0wTT08qazAd3nF+9g8/BrPY/cqnLFpBtBVbHYk+NNfDYJHkN9btthFKTCE2J
         aZFblR7BJEg1sA0hzYERTIKunxngwYY+gWE1ifbr4KmSYZkYY6hJ70AzTNQlGIZksrK8
         oK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758631036; x=1759235836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4210Fm1QpLo6WEa68t+fTvLZqwxqcYrVkyyGk5pqsks=;
        b=NRgprzy9jmCur9g31suZZeh0D+0oZ/e8XZGdCrkQ3G9dcrCqZEiQC1qMkrSiFVu8hh
         u8x7r07Gr4PrfwZ+yZGiRdDUjD9q/qG060JK2v8HkV0KcRW3H+ioD5t2AexQeG8vMCQ2
         xiZ4OTL9j8H+pyLASP/9A3G5OWjQl5H9qegmn3bftlZ0ZsW6zJLqM3V34fZws/TXthk8
         HdloLd5MQod2EAwO0s98Qvr5axHgdZHcFPpoMsSnxckook+9apllYTtj5gtty7V50kUk
         p72ETOcUuOVSIwmxSXKF1+iivA40w1q0n6g+dqEHT/9TmPiOFBr+xfE8YGzMgLarfTLi
         SPuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvOljVgo/a8wzwSYzSRXhZ/UyXXKpJEHYbkVb0wIel51yzPZbPlnXOQdqrBDKqnPJrojb3mdTTnnWugEnK1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhloJKYW+IhSDeeZk+a4NpETV5ppOtz9ucUIHiMcy6fuRxMAhA
	XYLOmIg6QJN2trFv51S2XYzCMAXnDdVlof11G5iD3KX+5h4PsCSVoMDT+8KDHwm/stw=
X-Gm-Gg: ASbGnctMaDCN5s5JmYmmezC8L8K48gvOnG2WN8Rmhri7Q//pA32/CgI/qhnrKlsZ1Lp
	Fwu2GrNLS7iZqcsykP7OQChf9CJ64y/f/cMxDKiMr/XE6v2rGcyrQJG0DpZCj+2bd/cw7spkvSb
	EfFdejC1ig5tR5uUb2HWQWBnDjBwB3a1+Flt3It03R16oxVH49ls/Em9iWIfPZtr9ek2Tyxe6+X
	9+6DVD9fcbdVAfJAi6E4rU2gEh01ffsYE/GdpnKRUJv3hicK9OUo+2DL4kVScoz0NhprdpJnGpB
	FtZ6+QuMED2m3C8iMVH+N67poUaMSi/Xw98/olRzkzxSoEaC06s90Iapv7WrQbIXwb7L+Vc8xWI
	wSVg8wdNyhb0Nnv/rEEoYnTeoeK5dvkj/gYE+batC649sLhRjubH/9MWmWSmZzm4g0q+PkeE=
X-Google-Smtp-Source: AGHT+IE39Ar0QDkR4Xr9h08I1/hHt1iycT4gYz0WAi6LZWYuJ7bIzRYt764/EzbqkiDYrN0iB/PnTQ==
X-Received: by 2002:a17:903:2c0b:b0:275:b1cf:6dd7 with SMTP id d9443c01a7336-27cc48a0b06mr27799065ad.34.1758631035835;
        Tue, 23 Sep 2025 05:37:15 -0700 (PDT)
Received: from [10.88.213.9] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803601e3sm162427175ad.144.2025.09.23.05.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 05:37:15 -0700 (PDT)
Message-ID: <2739dcc3-7c38-492c-854a-731298396a0c@bytedance.com>
Date: Tue, 23 Sep 2025 20:37:09 +0800
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
 <CACGkMEuvT3=a+6LyaFZFmCZzGS5tntPSbSJg=h6FAHdk89pC8g@mail.gmail.com>
Content-Language: en-US
From: Sheng Zhao <sheng.zhao@bytedance.com>
In-Reply-To: <CACGkMEuvT3=a+6LyaFZFmCZzGS5tntPSbSJg=h6FAHdk89pC8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/17 16:16, Jason Wang wrote:
> On Mon, Sep 15, 2025 at 3:34 PM <sheng.zhao@bytedance.com> wrote:
>>
>> From: Sheng Zhao <sheng.zhao@bytedance.com>
>>
>> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
>> even small IO requests to occupy an entire bounce page exclusively. The
>> kind of memory waste will be more significant on arm64 with 64KB pages.
> 
> Let's tweak the title as there are archs that are using non 4KB pages
> other than arm.
> 

Got it. I will modify this in v2.

>>
>> So, optimize it by using fixed 4KB bounce pages.
>>
>> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
>> ---
>>   drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++----------
>>   drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
>>   2 files changed, 83 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
>> index 58116f89d8da..768313c80b62 100644
>> --- a/drivers/vdpa/vdpa_user/iova_domain.c
>> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
>> @@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iova_domain *domain,
>>   static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
>>                                           u64 iova, u64 size, u64 paddr)
>>   {
>> -       struct vduse_bounce_map *map;
>> +       struct vduse_bounce_map *map, *head_map;
>> +       struct page *tmp_page;
>>          u64 last = iova + size - 1;
>>
>>          while (iova <= last) {
>> -               map = &domain->bounce_maps[iova >> PAGE_SHIFT];
>> +               map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
> 
> BOUNCE_PAGE_SIZE is kind of confusing as it's not the size of any page
> at all when PAGE_SIZE is not 4K.
> 

How about BOUNCE_MAP_SIZE?

>>                  if (!map->bounce_page) {
>> -                       map->bounce_page = alloc_page(GFP_ATOMIC);
>> -                       if (!map->bounce_page)
>> -                               return -ENOMEM;
>> +                       head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_PAGE_SHIFT];
>> +                       if (!head_map->bounce_page) {
>> +                               tmp_page = alloc_page(GFP_ATOMIC);
>> +                               if (!tmp_page)
>> +                                       return -ENOMEM;
>> +                               if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
>> +                                       __free_page(tmp_page);
> 
> I don't understand why we need cmpxchg() logic.
> 
> Btw, it looks like you want to make multiple bounce_map to point to
> the same 64KB page? I wonder what's the advantages of doing this. Can
> we simply keep the 64KB page in bounce_map?
> 
> Thanks
> 

That's correct. We use fixed 4KB-sized bounce pages, and there will be a 
many-to-one relationship between these 4KB bounce pages and the 64KB 
memory pages.

Bounce pages are allocated on demand. As a result, it may occur that 
multiple bounce pages corresponding to the same 64KB memory page attempt 
to allocate memory simultaneously, so we use cmpxchg to handle this 
concurrency.

In the current implementation, the bounce_map structure requires no 
modification. However, if we keep the 64KB page into a single bounce_map 
while still wanting to implement a similar logic, we may need an 
additional array to store multiple orig_phys values in order to 
accommodate the many-to-one relationship.

Thanks

