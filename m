Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D205FB9E
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 23:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710892630; cv=none; b=OGePmvyfscLdMxcNrlaNDDE6o4M0IRIO6cnJBjoXxEMzdxZP/sdLD3W3W3dg19v50/WG8h567Uw7nozcilhk/S1UMERmSg1QOyr8rqAArAS4xPYJBv9OadYczTp7871/Jzv6gQkduYHC7kvIPJQCZ2MPyNzDfy6If87c11fH7Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710892630; c=relaxed/simple;
	bh=P5AL6oEzG45qwEcNC4qe16rjLvTkOuHzRuBNCSbDhkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xt8yQ1NCj32tDE+QVOe2BaAV8JNnYQTXde7PUmrVYuDOkYbnB9GC+6gyY3SxL8Rl63gtJPX5EsBjMOnB3/kjwO8To8Ptk+LWClBQPkmAnLdGrlgHqiyxGqNYzMrvE47SAjn/ieqci51ls0ecSo32ivbtfE72h84y9ppTNRxxawA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcuJldhe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcuJldhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710892626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYQV4r9zs4nIx65Nz1fOoMB0sTDImRp2TfUwSyH+J0Y=;
	b=dcuJldheM20uPum7AiSVqvtfZJ/R3TBPZebqT3zd+oCAON9DzG0YEF9antsP5RJ+X+ezaO
	uq1i5NbJ81+QMws4EgCL9z69ltk9YhS5fbdDxvYyuNXe/x9IamtQxF2lv6AiOorbqarx+G
	8Dg2U7VYERMBoRKTkoBy0BO0D1f0oUI=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-Qc7XiK1DOHiK1IIArZixng-1; Tue, 19 Mar 2024 19:57:05 -0400
X-MC-Unique: Qc7XiK1DOHiK1IIArZixng-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-2206493f627so6694056fac.1
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 16:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710892625; x=1711497425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYQV4r9zs4nIx65Nz1fOoMB0sTDImRp2TfUwSyH+J0Y=;
        b=DxuzFPaE7QwnRGHncSa5P/dbpyCxT3zfbu4S2fL2T5dj7wxlhtd4XxVzIQ3FSRr97x
         kqmFD4Oe+a8PadamVswUrUG/yzR62jqI3Mu08Ukl4GxAm7GjewdhPLMbPpXx9v9Tq322
         vnzvSkn9bzyxoA8V6Gk+fM8J8KJRlRME6M6N1dtLbWpTKEboBacssZ0GHrAdTVdOkKJf
         UeCnjjU4Cv+/4tipGThZyZKtEB8Kvslo8iTd0sOrFBwftFEfTMws99e63vi0hSz2WM4N
         bsHBIheIyMZcbRR5lZGCunqPRj22FhOPwhZKAwGpq/JImIsRqRMU+otJy+AgLyh0O7vT
         IN5Q==
X-Gm-Message-State: AOJu0YzDQGUa/wZX0xDTl9qglavmADzUpXMIlRJNBzEQyzGHuEPoQOkS
	tDB+rEs8QnZ0FtIbW9+gCgowO6HRC6CruLTDLRJstwt6aYrjRoABSIHY5oH86++9zmL0UTbZaQj
	zp8xLDXYeEKK/9RDab5xQeAEyajA3XZDwVO456FGYkWwwCBgCucidZ5thoSxXUl/A
X-Received: by 2002:a05:6870:b6a4:b0:221:bcde:29cc with SMTP id cy36-20020a056870b6a400b00221bcde29ccmr17583118oab.21.1710892624806;
        Tue, 19 Mar 2024 16:57:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4TxVfQFAYxTperCAEMsmhXIreADULgFe4gLlGCSkgk3/ZqneaXS1xQJLQfu2YBZU/LyKC2Q==
X-Received: by 2002:a05:6870:b6a4:b0:221:bcde:29cc with SMTP id cy36-20020a056870b6a400b00221bcde29ccmr17583110oab.21.1710892624537;
        Tue, 19 Mar 2024 16:57:04 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id m17-20020aa78a11000000b006e5af565b1dsm10339889pfa.201.2024.03.19.16.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 16:57:04 -0700 (PDT)
Message-ID: <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
Date: Wed, 20 Mar 2024 09:56:58 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
To: Will Deacon <will@kernel.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 yihyu@redhat.com, shan.gavin@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240319182251.GB3121@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/24 04:22, Will Deacon wrote:
> On Tue, Mar 19, 2024 at 02:59:23PM +1000, Gavin Shan wrote:
>> On 3/19/24 02:59, Will Deacon wrote:
>>>>    drivers/virtio/virtio_ring.c | 12 +++++++++---
>>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>> index 49299b1f9ec7..7d852811c912 100644
>>>> --- a/drivers/virtio/virtio_ring.c
>>>> +++ b/drivers/virtio/virtio_ring.c
>>>> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>>>    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>>    	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>> -	/* Descriptors and available array need to be set before we expose the
>>>> -	 * new available array entries. */
>>>> -	virtio_wmb(vq->weak_barriers);
>>>> +	/*
>>>> +	 * Descriptors and available array need to be set before we expose
>>>> +	 * the new available array entries. virtio_wmb() should be enough
>>>> +	 * to ensuere the order theoretically. However, a stronger barrier
>>>> +	 * is needed by ARM64. Otherwise, the stale data can be observed
>>>> +	 * by the host (vhost). A stronger barrier should work for other
>>>> +	 * architectures, but performance loss is expected.
>>>> +	 */
>>>> +	virtio_mb(false);
>>>>    	vq->split.avail_idx_shadow++;
>>>>    	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>    						vq->split.avail_idx_shadow);
>>>
>>> Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
>>> here, especially when ordering accesses to coherent memory.
>>>
>>> In practice, either the larger timing different from the DSB or the fact
>>> that you're going from a Store->Store barrier to a full barrier is what
>>> makes things "work" for you. Have you tried, for example, a DMB SY
>>> (e.g. via __smb_mb()).
>>>
>>> We definitely shouldn't take changes like this without a proper
>>> explanation of what is going on.
>>>
>>
>> Thanks for your comments, Will.
>>
>> Yes, DMB should work for us. However, it seems this instruction has issues on
>> NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
>> from hardware level. I agree it's not the solution to replace DMB with DSB
>> before we fully understand the root cause.
>>
>> I tried the possible replacement like below. __smp_mb() can avoid the issue like
>> __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
>>
>> static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
>> {
>>      :
>>          /* Put entry in available array (but don't update avail->idx until they
>>           * do sync). */
>>          avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>          vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>
>>          /* Descriptors and available array need to be set before we expose the
>>           * new available array entries. */
>>          // Broken: virtio_wmb(vq->weak_barriers);
>>          // Broken: __dma_mb();
>>          // Work:   __mb();
>>          // Work:   __smp_mb();
> 
> It's pretty weird that __dma_mb() is "broken" but __smp_mb() "works". How
> confident are you in that result?
> 

Yes, __dma_mb() is even stronger than __smp_mb(). I retried the test, showing
that both __dma_mb() and __smp_mb() work for us. I had too many tests yesterday
and something may have been messed up.

Instruction         Hitting times in 10 tests
---------------------------------------------
__smp_wmb()         8
__smp_mb()          0
__dma_wmb()         7
__dma_mb()          0
__mb()              0
__wmb()             0

It's strange that __smp_mb() works, but __smp_wmb() fails. It seems we need a
read barrier here. I will try WRITE_ONCE() + __smp_wmb() as suggested by Michael
in another reply. Will update the result soon.

Thanks,
Gavin

