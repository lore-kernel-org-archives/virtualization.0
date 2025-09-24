Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9026222ACEB
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695904; cv=none; b=dhdunCSG5IL2gh4SvmvyJ6L+32DiwFOwjilpqkDUAuhgxbwI25jAmxOm2NJFLDbvn82cf6FMRzI/I14myL1Xqlc/dWKpPxsH3fpC1Qo/xuXYlhNdhxb3MuEGQNIFF1HG2jbEgDMNYNaVPYjCQyuJe6FDmAWZCNBz6y/co7QHGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695904; c=relaxed/simple;
	bh=Y414l4Q4h9CyZswAYtdgfRLc+vH1uwVEFVIrOjI2NS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZwvzQ9qcAtqSG5IywMOA90Aol8O3mrjQOpHcB+QAP+Kdum8njbiafuXNX2KIokCAYfQP/bumskWaBpeSxLngdS0UZAoOPpMfSpHl8Wz7NSTj/gpnN3xuM90KrDyZQ+X4CMzUA8mn8RWV2IDGh+/NyMGmeOUzsxk+NtwH5n1OBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e8lJIbTE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e8lJIbTE"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77f22902b46so3901680b3a.0
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 23:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758695901; x=1759300701; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6Ov3S9HpN4cjEcIlojuqLvi3igYJ6DGKCzi466R5uM=;
        b=e8lJIbTEC4j/dHrWGIWCkRHKjbjFMzVBxnO+LgdCpgsKio5SuzSevqDPyEJzd/EoFB
         PNXLMTCqLnmdDJJmgseoDdnlsiuSJSfhbnBSAqjMdtc8xqGzoVx33y8NAnOrH0pOegRQ
         WeHbdgdFaUrvSk6IcITJehPOka4Shc7yEoeYR89y5DKS5CkaqL0/M/+rUVryTe4GnRxm
         y65J8CnX7zPo58l2RIPuz0sLpi9jniLfRFCNCgtEEoOsUTVs8SNlh8ARYpyCpkKpBTgs
         E7P2w5baxjRR5mWj61eOZRUivOlEWe0E4r/dMeVwy2xUuXmRBX0+pt7Lv8kLdwA0nbhY
         P5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758695901; x=1759300701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6Ov3S9HpN4cjEcIlojuqLvi3igYJ6DGKCzi466R5uM=;
        b=qSmxG1NR9NdodYTI74c5yXoVqoLxBmStuho22SuH1YrZ1agBgfQV2MJe2j32gUimS5
         NmabY6Fl2UVbtd3Qhv43f8tUlYwFI69qtG9T7IbaVqr+SUQ1SOrJYlbzIEDtEBXwmU/y
         Z+RMeUl94y34U/lbSw4qIrh+N0LIBue3UybLstn3NJtGjtjV+fMeVHysIfxcwbHWQ+zk
         TUd5xjNcu6cUUgkTcHXnAKZWY0EGXEaVLVpByqIXspjUKR05QCYJUBgtUzwjjf7rcetw
         0BnNNRdC+kpnNdlPOLhpxP0tVmdU69HTqPjX7ZAojIJny1v/zIB2kJkQ49VcqYtsfl0A
         7tXA==
X-Forwarded-Encrypted: i=1; AJvYcCUge12b3LIu2WzF3qa5f1ajqvv0r+4PLIV4z426hPiz4EmoHK2O3tjHR8IUK/WcpaAGHlvhJ7NGse7NSXpiTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJpfdTZDOR03MUSoUmf7vYU3yF6Nue/pYfXTT/nF4oQliXN+3U
	oba/I0s/5/ojmbfefPV1m9P53uGG3UPn3OrFoEQeixnCUaN97q5k+Kb7nGltz+bVIAA=
X-Gm-Gg: ASbGncux7uuIwruExy1ppIOdb52lJ4oAWICT4mGiMUdUDMlWFFZAOyrglTjSgc63eku
	EqkC1ZRAcNBXNsdHA0cWBvOiqZb9QBdGYwNPZYbC+UyjO+hSSYimD+Vvvjn4AYT9o6SDMv9E40M
	7AlpMGhLl2P74mV2bkqIZlG5qj54XJSBQajnm1Puf4bMugqcqedgEJQDACbmk3HVBGLjjZsm+ss
	FLe0yydJUrNnx0H4w82MtPg9KqKIZIE7rWGwDeN1Sed/asP3eqZzQSts5EgXttkCwa8iw8sVPNu
	XSXy9lveHX+dWsHlwokONOIU8auJRgPgHFqPhiXq1YOyM6c6OcnU70rCcHvoqJxrdsZJbqv4pWV
	z/aWqbWx9B8jp0m3t3yoMKICPA/qlVf2Jp/sFATRjHoTXjWQz4i8t10foh8RbfsU3V087gtc=
X-Google-Smtp-Source: AGHT+IGsFnvhEJuy1jeBg1o60pY8GGKmm8OjAXogiR/DVRn3nto/+G8JKif7BLpZrq6QkESMTuyG3w==
X-Received: by 2002:a05:6a00:4fd4:b0:77f:169d:7f62 with SMTP id d2e1a72fcca58-77f538ea09bmr6917644b3a.14.1758695900695;
        Tue, 23 Sep 2025 23:38:20 -0700 (PDT)
Received: from [10.88.213.9] ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec3dadbsm17605879b3a.68.2025.09.23.23.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 23:38:20 -0700 (PDT)
Message-ID: <b5bc34c2-b82a-475d-ba15-a7f67495b56a@bytedance.com>
Date: Wed, 24 Sep 2025 14:38:14 +0800
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
 <2739dcc3-7c38-492c-854a-731298396a0c@bytedance.com>
 <CACGkMEv3pUBF3Uv2s3MM0Qn--fP3mwN92SqE9NX4gNuMALBTUg@mail.gmail.com>
 <aed938d0-e70a-4af6-9950-d4d0b7d6a93f@bytedance.com>
 <CACGkMEv4TZOAyxaTkCvZ4rgyVsPet+r3pNSauHaGOYHim3Loag@mail.gmail.com>
Content-Language: en-US
From: Sheng Zhao <sheng.zhao@bytedance.com>
In-Reply-To: <CACGkMEv4TZOAyxaTkCvZ4rgyVsPet+r3pNSauHaGOYHim3Loag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/24 12:15, Jason Wang wrote:
> On Wed, Sep 24, 2025 at 12:05 PM Sheng Zhao <sheng.zhao@bytedance.com> wrote:
>>
>>
>>
>> On 2025/9/24 08:57, Jason Wang wrote:
>>> On Tue, Sep 23, 2025 at 8:37 PM Sheng Zhao <sheng.zhao@bytedance.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2025/9/17 16:16, Jason Wang wrote:
>>>>> On Mon, Sep 15, 2025 at 3:34 PM <sheng.zhao@bytedance.com> wrote:
>>>>>>
>>>>>> From: Sheng Zhao <sheng.zhao@bytedance.com>
>>>>>>
>>>>>> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
>>>>>> even small IO requests to occupy an entire bounce page exclusively. The
>>>>>> kind of memory waste will be more significant on arm64 with 64KB pages.
>>>>>
>>>>> Let's tweak the title as there are archs that are using non 4KB pages
>>>>> other than arm.
>>>>>
>>>>
>>>> Got it. I will modify this in v2.
>>>>
>>>>>>
>>>>>> So, optimize it by using fixed 4KB bounce pages.
>>>>>>
>>>>>> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
>>>>>> ---
>>>>>>     drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++----------
>>>>>>     drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
>>>>>>     2 files changed, 83 insertions(+), 42 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
>>>>>> index 58116f89d8da..768313c80b62 100644
>>>>>> --- a/drivers/vdpa/vdpa_user/iova_domain.c
>>>>>> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
>>>>>> @@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iova_domain *domain,
>>>>>>     static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
>>>>>>                                             u64 iova, u64 size, u64 paddr)
>>>>>>     {
>>>>>> -       struct vduse_bounce_map *map;
>>>>>> +       struct vduse_bounce_map *map, *head_map;
>>>>>> +       struct page *tmp_page;
>>>>>>            u64 last = iova + size - 1;
>>>>>>
>>>>>>            while (iova <= last) {
>>>>>> -               map = &domain->bounce_maps[iova >> PAGE_SHIFT];
>>>>>> +               map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
>>>>>
>>>>> BOUNCE_PAGE_SIZE is kind of confusing as it's not the size of any page
>>>>> at all when PAGE_SIZE is not 4K.
>>>>>
>>>>
>>>> How about BOUNCE_MAP_SIZE?
>>>
>>> Fine with me.
>>>
>>>>
>>>>>>                    if (!map->bounce_page) {
>>>>>> -                       map->bounce_page = alloc_page(GFP_ATOMIC);
>>>>>> -                       if (!map->bounce_page)
>>>>>> -                               return -ENOMEM;
>>>>>> +                       head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_PAGE_SHIFT];
>>>>>> +                       if (!head_map->bounce_page) {
>>>>>> +                               tmp_page = alloc_page(GFP_ATOMIC);
>>>>>> +                               if (!tmp_page)
>>>>>> +                                       return -ENOMEM;
>>>>>> +                               if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
>>>>>> +                                       __free_page(tmp_page);
>>>>>
>>>>> I don't understand why we need cmpxchg() logic.
>>>>>
>>>>> Btw, it looks like you want to make multiple bounce_map to point to
>>>>> the same 64KB page? I wonder what's the advantages of doing this. Can
>>>>> we simply keep the 64KB page in bounce_map?
>>>>>
>>>>> Thanks
>>>>>
>>>>
>>>> That's correct. We use fixed 4KB-sized bounce pages, and there will be a
>>>> many-to-one relationship between these 4KB bounce pages and the 64KB
>>>> memory pages.
>>>>
>>>> Bounce pages are allocated on demand. As a result, it may occur that
>>>> multiple bounce pages corresponding to the same 64KB memory page attempt
>>>> to allocate memory simultaneously, so we use cmpxchg to handle this
>>>> concurrency.
>>>>
>>>> In the current implementation, the bounce_map structure requires no
>>>> modification. However, if we keep the 64KB page into a single bounce_map
>>>> while still wanting to implement a similar logic, we may need an
>>>> additional array to store multiple orig_phys values in order to
>>>> accommodate the many-to-one relationship.
>>>
>>> Or simply having a bitmap is sufficient per bounce_map?
>>>
>>
>> Yes, using a bitmap can mark the usage status of each 4KB, but it may
>> not simplify things overall.
>>
>> - we will inevitably need to add an additional array per bounce_map to
>> store the orig_phys corresponding to each 4KB for subsequent copying
>> (vduse_domain_bounce).
> 
> I may miss something, the PAGE_SIZE is 64KB in this case, why do we
> need to store per 4KB orig_phys?
> 

Since one orig_phys originates from one IO request. If we want the 
minimum size of bounce pages occupied by an IO request to be 4KB instead 
of 64KB. we need to store their respective orig_phys values for each 4KB 
corresponding to the IO request.

In other words, we may not be able to guarantee that the orig_phys 
values of all IO requests within the same 64KB memory page are 
contiguous, so we need to store them separately.

Thanks
>>
>> - compared to the current commit, this modification may only be a
>> structural change and fail to reduce the amount of changes to the code
>> logic. For instance, cmpxchg is still required.
> 
> Thanks
> 
>>
>>
>> Thanks
>>
>>> Thanks
>>>
>>>>
>>>> Thanks
>>>>
>>>
>>
> 

