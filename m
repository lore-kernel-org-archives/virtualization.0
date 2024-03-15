Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E3182D4
	for <virtualization@lists.linux.dev>; Fri, 15 Mar 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710499523; cv=none; b=Wpld/FWptDXR74f79wY89H+vrAtkJKADmm3s8TGNehe65rbDMQQ4hKPnD74MQV6lLcBClta/V2oBfNIijQSH7u4R67qsjOg/kcJxlc8b2T7YmoQF0gIWJPxEpMLTlnIh8Sq1fIOhAEd9auTbm+LDx+u60xpomhZoE379uaTcPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710499523; c=relaxed/simple;
	bh=bExp8w4yC2O1tjVcUf1kZYbRYugIDaUo473OxyfzMAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDFW5Rz7q6eN9tO5GsQSWiuwLnQV6js7ZFuAJSF9PFbuxlAibmNs42m26K3wVftKyv/FxTn43h1cL6IJNUpqHBeLH5WTHmWm418Rm4VJK2TYyWNskrux3ylbYk/sEMNSIwzn7tetw2hFxEIJZAQEf9QX+GEDxr5XRPQ0fT4jEX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBqNzL4H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBqNzL4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710499520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/YC89ubOap0oGrzs+kFy37210zX0/90mg3/bLKoN+p0=;
	b=cBqNzL4H3PWoDEk7NxFjQ+p0dv2Gu8Vr6ZsDPdtm/qHjTn/p8i3rqx2/QQde9sFV8iRV5w
	qUuoUWx239yNjToRfV7HZ60vyx3xyOCha4yInvBbmw5tfqKxZRbthgbrVa0JxhOJhH5MMN
	eFD8E0eTszhNqri+n+8NLW9Q8XBOU84=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-XDSIA24cN1iqZ8DENPTXgA-1; Fri, 15 Mar 2024 06:45:19 -0400
X-MC-Unique: XDSIA24cN1iqZ8DENPTXgA-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-21e57398aeaso1847735fac.0
        for <virtualization@lists.linux.dev>; Fri, 15 Mar 2024 03:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710499518; x=1711104318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YC89ubOap0oGrzs+kFy37210zX0/90mg3/bLKoN+p0=;
        b=pcaVHR7MnsRQycPuE+TFihdr9XUc5nvda/Bh1HxpBGgtqIkQZ22yCmhoJuAdRry1ze
         uSjwwellkDbO0YC6AcQOryAGTpVsXovSKCkK4YSe0Jmejuh0EMKacGV4RU9if9R3Yg1w
         Xttb1lImNy6HMkpe/eBz8lI+pWZF+JrbSKW30vfovWnlZ+qo0qMz3yR+7slScNGx3ah5
         wuuRT3lr/Nd4i5DbS3lYKF3nTtj6aQoA+le98Hsbqo6k8tCI22W9bvuhzZzNKqOrwi39
         4RDlo9Ua3vzTEX/X7jc8/4+FhP2ohW1MGe3TpAtPraWxuifCcunQNoxHXwTtP1ZY2q+P
         b9Hg==
X-Gm-Message-State: AOJu0Yy4e2TpBT76szhQI5Y3eNXnFTZKrgpo0w/1m+HeZo/j4hBryT0h
	mhXjjRJgECTGDRmpMlzbj9ozuyHUuOCe+PfhRstk5Pmc7s3lV+pc7iTOGUbFBpg6ig+EOCjGRXR
	haZnxGrERa8C1AIBhOuD3N9v670hAa7joFzr240bpiBL8YdFZ+lLgRZaYw6j2LyDm
X-Received: by 2002:a05:6870:d14d:b0:221:a433:8a52 with SMTP id f13-20020a056870d14d00b00221a4338a52mr4804869oac.43.1710499517822;
        Fri, 15 Mar 2024 03:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE8YkXr1X/1EFB+cmMGi/VY50tMCHIXHSE5grcsDLLOizJidTHTyc/m1pqbHQqgDkGfzb8xA==
X-Received: by 2002:a05:6870:d14d:b0:221:a433:8a52 with SMTP id f13-20020a056870d14d00b00221a4338a52mr4804846oac.43.1710499517437;
        Fri, 15 Mar 2024 03:45:17 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id b19-20020aa78713000000b006e6c3753786sm3090677pfo.41.2024.03.15.03.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 03:45:16 -0700 (PDT)
Message-ID: <63002c24-8117-458f-84c7-fa4f7acd8cc6@redhat.com>
Date: Fri, 15 Mar 2024 20:45:10 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
 shan.gavin@gmail.com, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, mochs@nvidia.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
 <20240314074216-mutt-send-email-mst@kernel.org>
 <23dc6d00-6a57-4ddf-8611-f3c6f6a8e43c@redhat.com>
 <20240314085630-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240314085630-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


+ Will, Catalin and Matt from Nvidia

On 3/14/24 22:59, Michael S. Tsirkin wrote:
> On Thu, Mar 14, 2024 at 10:50:15PM +1000, Gavin Shan wrote:
>> On 3/14/24 21:50, Michael S. Tsirkin wrote:
>>> On Thu, Mar 14, 2024 at 08:15:22PM +1000, Gavin Shan wrote:
>>>> On 3/14/24 18:05, Michael S. Tsirkin wrote:
>>>>> On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
>>>>>> The issue is reported by Yihuang Yu who have 'netperf' test on
>>>>>> NVidia's grace-grace and grace-hopper machines. The 'netperf'
>>>>>> client is started in the VM hosted by grace-hopper machine,
>>>>>> while the 'netperf' server is running on grace-grace machine.
>>>>>>
>>>>>> The VM is started with virtio-net and vhost has been enabled.
>>>>>> We observe a error message spew from VM and then soft-lockup
>>>>>> report. The error message indicates the data associated with
>>>>>> the descriptor (index: 135) has been released, and the queue
>>>>>> is marked as broken. It eventually leads to the endless effort
>>>>>> to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
>>>>>> and soft-lockup. The stale index 135 is fetched from the available
>>>>>> ring and published to the used ring by vhost, meaning we have
>>>>>> disordred write to the available ring element and available index.
>>>>>>
>>>>>>      /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
>>>>>>      -accel kvm -machine virt,gic-version=host                            \
>>>>>>         :                                                                 \
>>>>>>      -netdev tap,id=vnet0,vhost=on                                        \
>>>>>>      -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
>>>>>>
>>>>>>      [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
>>>>>>
>>>>>> Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
>>>>>> virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
>>>>>> ARM64. It should work for other architectures, but performance loss is
>>>>>> expected.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>>> ---
>>>>>>     drivers/virtio/virtio_ring.c | 12 +++++++++---
>>>>>>     1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>>>> index 49299b1f9ec7..7d852811c912 100644
>>>>>> --- a/drivers/virtio/virtio_ring.c
>>>>>> +++ b/drivers/virtio/virtio_ring.c
>>>>>> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>>>>>     	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>>>>     	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>>>> -	/* Descriptors and available array need to be set before we expose the
>>>>>> -	 * new available array entries. */
>>>>>> -	virtio_wmb(vq->weak_barriers);
>>>>>> +	/*
>>>>>> +	 * Descriptors and available array need to be set before we expose
>>>>>> +	 * the new available array entries. virtio_wmb() should be enough
>>>>>> +	 * to ensuere the order theoretically. However, a stronger barrier
>>>>>> +	 * is needed by ARM64. Otherwise, the stale data can be observed
>>>>>> +	 * by the host (vhost). A stronger barrier should work for other
>>>>>> +	 * architectures, but performance loss is expected.
>>>>>> +	 */
>>>>>> +	virtio_mb(false);
>>>>>
>>>>>
>>>>> I don't get what is going on here. Any explanation why virtio_wmb is not
>>>>> enough besides "it does not work"?
>>>>>
>>>>
>>>> The change is replacing instruction "dmb" with "dsb". "dsb" is stronger barrier
>>>> than "dmb" because "dsb" ensures that all memory accesses raised before this
>>>> instruction is completed when the 'dsb' instruction completes. However, "dmb"
>>>> doesn't guarantee the order of completion of the memory accesses.
>>>>
>>>> So 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
>>>> can be completed before 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.
>>>
>>> Completed as observed by which CPU?
>>> We have 2 writes that we want observed by another CPU in order.
>>> So if CPU observes a new value of idx we want it to see
>>> new value in ring.
>>> This is standard use of smp_wmb()
>>> How are these 2 writes different?
>>>
>>> What DMB does, is that is seems to ensure that effects
>>> of 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
>>> are observed after effects of
>>> 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.
>>>
>>>
>>
>> Completed as observed by the CPU where vhost worker is running. I don't think DMB
>> does the work here. If I'm understanding correctly, DMB ensures the order of these
>> two writes from the local CPU's standpoint.
> 
> No this makes no sense at all. All memory accesses are in order from
> local CPU standpoint.
> 

It's true if compiler doesn't reorder the accesses, and light-weight barrier
like 'dmb' and 'isb' is used. Otherwise, the accesses still can be disordered
on the local CPU, correct?

>> The written data can be stored in local
>> CPU's cache, not flushed to DRAM and propogated to the cache of the far CPU where
>> vhost worker is running. So DMB isn't ensuring the write data is observed from the
>> far CPU.
> 
> No but it has to ensure *ordering*. So if index is oberved then ring
> is observed too because there is a MB there when reading.
> 

Right. It should work like this way theoretically. I don't know the difference
between 'dmb' and 'dsb' from the hardware level. The description in ARMv9 spec
is also ambiguous. Lets see if Matt will have comments. Besides, this issue is
only reproducible on NVidia's grace-hopper. We don't hit the issue on Ampere's
CPUs.

> 
>> DSB ensures that the written data is observable from the far CPU immediately.
>  
>>>
>>>
>>>> The stronger barrier 'dsb' ensures the completion order as we expected.
>>>>
>>>>       virtio_wmb(true)         virt_mb(false)
>>>>         virt_wmb                 mb
>>>>           __smp_wmb               __mb
>>>>             dmb(ishst)              dsb(sy)
>>>
>>> First, why would you want a non smp barrier when you are
>>> synchronizing with another CPU? This is what smp_ means ...
>>>
>>>
>>>> Extraced from ARMv9 specificaton
>>>> ================================
>>>> The DMB instruction is a memory barrier instruction that ensures the relative
>>>> order of memory accesses before the barrier with memory accesses after the
>>>> barrier. The DMB instruction _does not_ ensure the completion of any of the
>>>> memory accesses for which it ensures relative order.
>>>
>>> Isn't this exactly what we need?
>>>
>>
>> I don't think so. DMB gurantees the order of EXECUTION, but DSB gurantees the
>> order of COMPLETION. After the data store is executed, the written data can
>> be stored in local CPU's cache, far from completion. Only the instruction is
>> completed, the written data is synchronized to the far CPU where vhost worker
>> is running.
>>
>> Here is another paper talking about the difference between DMB and DSB. It's
>> explaining the difference between DMB/DSB better than ARMv9 specification.
>> However, it's hard for us to understand DMB/DSB work from the hardware level
>> based on the specification and paper.
>>
>> https://ipads.se.sjtu.edu.cn/_media/publications/liuppopp20.pdf
>> (section 2.2  Order-preserving Options)
>> (I'm extracting the relevant part as below)
>>
>> Data Memory Barrier (DMB) prevents reordering of memory accesses across the barrier.
>> Instead of waiting for previous accesses to become observable in the specified domain,
>> DMB only maintains the relative order between memory accesses. Meanwhile, DMB does
>> not block any non-memory access operations.
>>
>> Data Synchronization Barrier (DSB) prevents reordering of any instructions across
>> the barrier. DSB will make sure that all masters in the specified domain can observe
>> the previous operations before issuing any subsequent instructions.
>>
> 
> What you are describing is that smp_wmb is buggy on this platform.
> Poossible but are you sure?
> Write a small test and check.
> Leave virtio alone.
> 

Yes, I guess smp_wmb() ('dmb') is buggy on NVidia's grace-hopper platform. I tried
to reproduce it with my own driver where one thread writes to the shared buffer
and another thread reads from the buffer. I don't hit the out-of-order issue so
far. My driver may be not correct somewhere and I will update if I can reproduce
the issue with my driver in the future.

> 
>>>> A DSB instruction is a memory barrier that ensures that memory accesses that
>>>> occur before the DSB instruction have __completed__ before the completion of
>>>> the DSB instruction.
>>>
>>> This seems appropriate for when you want to order things more
>>> strongly. I do not get why it's necessary here.
>>>
>>
>> Please refer to above explanations.
>>
>>>> In doing this, it acts as a stronger barrier than a DMB
>>>> and all ordering that is created by a DMB with specific options is also generated
>>>> by a DSB with the same options.
>>>>
>>>>>>     	vq->split.avail_idx_shadow++;
>>>>>>     	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>>>     						vq->split.avail_idx_shadow);
>>>>>> -- 
>>>>>> 2.44.0
>>>>>

Thanks,
Gavin

