Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FFB2581
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710420626; cv=none; b=qmkkRegdEwcPnrIWvm5THtRKFLslgjcgAFOjCf/fYicTZzynIwcSNC7VUdSdwXrh5G533TDZURT//QxwuI2hmnzzOTs3tYhO1V7qs1yAwrEE8H10sZQhv10NQfWdBfmBZJDsRxJjVw8uK7N7BvTbULrNhSUJ0gUWkA45Pi5T5Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710420626; c=relaxed/simple;
	bh=dj1A/fUS1g7cQVRcUGlz9j57twwZfLXHvxcl85dh9bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXJTU1IwptXY6aNICX1t2bPuN7RilhRQvfw7pkyxoLf8CnM9U/4HS2n+o02Sf7XoRj032WTYJD2IEH8QQevrlnKdzm52WcLeLJng9Q75Lxx4hWmVMKuyznYsgD1SMqmw/RWHHE2VNQWCBG4S5d6SAhAy8jI59BHs04Kl8nQBUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THxMpcRe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THxMpcRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710420623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JugQATvY6YilsDeUh+JSk0j4lwCKfjARrjMcGpoo2I=;
	b=THxMpcRe7SmtI6vG4R37en/NDSw/g4KF/lmRw7WthbSpJ45clC0xcPkftADTSPKATJ6hUN
	ocG1mg34loJkt6rjQ2PDtiVzhaPGYc0dz38atRim7IH3K6WLzXcYwVGNbmkNShfNE1aaXA
	9+kxalgXyXnbRxGBia+kDnksc4lXHW8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-S8JVD7UWMPqxpW92cf0BfQ-1; Thu, 14 Mar 2024 08:50:22 -0400
X-MC-Unique: S8JVD7UWMPqxpW92cf0BfQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dda642853eso9566285ad.2
        for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 05:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710420621; x=1711025421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JugQATvY6YilsDeUh+JSk0j4lwCKfjARrjMcGpoo2I=;
        b=qpT5YXffobCyyqNQ+1MxZRvV04FNPINKV9OUrYYsXh6SENbNeQlOg0702ypuap1jWj
         vZ5xeUvykjwpJyeJ0n6P6SBVCM15OJZNf61EoAwF2qt0ouh2KeUJtvZxFGSrart+7TIL
         1u+Z+gdcrtWp851qOhDYBdYDYM6bsckAI3ZZS2SdwgH5ftMV/h9FzV0j1ST1rhsIaP8A
         Yxt9QrM1p2NRoDX2EsOLZ3z+Qc/ZVvZbJdeoDfsF9X7gzPMcaHAW9lGmnQZv7s878x81
         5r/FIGzIhTtMUWlY97Zw9orU2s5JcizMM/3ElW3aEJGMRpM+vvWSB0ws+c9H42Xphtnf
         U6lQ==
X-Gm-Message-State: AOJu0YwiHHvq/vR4/DgTePijrobxztte9Slc0PMm7/+8SSUVziaz1iUJ
	L0ZtpyDrmEJmahSOomlvGDu4LKeL8TiHEfitWKL8SftLbsvd0mhlKSWKNbjqpCDnqXOYLktZy6H
	AVJmrIPVbn3RKHYAcGvHCQVPIPmdqCnnoM5P7Rkocj3ezFuigjgcolrsQFGMuJIyn
X-Received: by 2002:a17:902:ba8c:b0:1dd:916d:771f with SMTP id k12-20020a170902ba8c00b001dd916d771fmr1299434pls.39.1710420621263;
        Thu, 14 Mar 2024 05:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqsGU2ry7VV2mdfejjivkYSa8XmnwJOgmDP+Hceb/WTio9PW3VdLpDdDFKJXGaRAfrmAiHuQ==
X-Received: by 2002:a17:902:ba8c:b0:1dd:916d:771f with SMTP id k12-20020a170902ba8c00b001dd916d771fmr1299421pls.39.1710420620870;
        Thu, 14 Mar 2024 05:50:20 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b001db2ff16acasm1588244plf.128.2024.03.14.05.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 05:50:20 -0700 (PDT)
Message-ID: <23dc6d00-6a57-4ddf-8611-f3c6f6a8e43c@redhat.com>
Date: Thu, 14 Mar 2024 22:50:15 +1000
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
 shan.gavin@gmail.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
 <20240314074216-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240314074216-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 21:50, Michael S. Tsirkin wrote:
> On Thu, Mar 14, 2024 at 08:15:22PM +1000, Gavin Shan wrote:
>> On 3/14/24 18:05, Michael S. Tsirkin wrote:
>>> On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
>>>> The issue is reported by Yihuang Yu who have 'netperf' test on
>>>> NVidia's grace-grace and grace-hopper machines. The 'netperf'
>>>> client is started in the VM hosted by grace-hopper machine,
>>>> while the 'netperf' server is running on grace-grace machine.
>>>>
>>>> The VM is started with virtio-net and vhost has been enabled.
>>>> We observe a error message spew from VM and then soft-lockup
>>>> report. The error message indicates the data associated with
>>>> the descriptor (index: 135) has been released, and the queue
>>>> is marked as broken. It eventually leads to the endless effort
>>>> to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
>>>> and soft-lockup. The stale index 135 is fetched from the available
>>>> ring and published to the used ring by vhost, meaning we have
>>>> disordred write to the available ring element and available index.
>>>>
>>>>     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
>>>>     -accel kvm -machine virt,gic-version=host                            \
>>>>        :                                                                 \
>>>>     -netdev tap,id=vnet0,vhost=on                                        \
>>>>     -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
>>>>
>>>>     [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
>>>>
>>>> Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
>>>> virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
>>>> ARM64. It should work for other architectures, but performance loss is
>>>> expected.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
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
>>>
>>>
>>> I don't get what is going on here. Any explanation why virtio_wmb is not
>>> enough besides "it does not work"?
>>>
>>
>> The change is replacing instruction "dmb" with "dsb". "dsb" is stronger barrier
>> than "dmb" because "dsb" ensures that all memory accesses raised before this
>> instruction is completed when the 'dsb' instruction completes. However, "dmb"
>> doesn't guarantee the order of completion of the memory accesses.
>>
>> So 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
>> can be completed before 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.
> 
> Completed as observed by which CPU?
> We have 2 writes that we want observed by another CPU in order.
> So if CPU observes a new value of idx we want it to see
> new value in ring.
> This is standard use of smp_wmb()
> How are these 2 writes different?
> 
> What DMB does, is that is seems to ensure that effects
> of 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
> are observed after effects of
> 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.
> 
>

Completed as observed by the CPU where vhost worker is running. I don't think DMB
does the work here. If I'm understanding correctly, DMB ensures the order of these
two writes from the local CPU's standpoint. The written data can be stored in local
CPU's cache, not flushed to DRAM and propogated to the cache of the far CPU where
vhost worker is running. So DMB isn't ensuring the write data is observed from the
far CPU.

DSB ensures that the written data is observable from the far CPU immediately.
  
> 
> 
>> The stronger barrier 'dsb' ensures the completion order as we expected.
>>
>>      virtio_wmb(true)         virt_mb(false)
>>        virt_wmb                 mb
>>          __smp_wmb               __mb
>>            dmb(ishst)              dsb(sy)
> 
> First, why would you want a non smp barrier when you are
> synchronizing with another CPU? This is what smp_ means ...
> 
> 
>> Extraced from ARMv9 specificaton
>> ================================
>> The DMB instruction is a memory barrier instruction that ensures the relative
>> order of memory accesses before the barrier with memory accesses after the
>> barrier. The DMB instruction _does not_ ensure the completion of any of the
>> memory accesses for which it ensures relative order.
> 
> Isn't this exactly what we need?
> 

I don't think so. DMB gurantees the order of EXECUTION, but DSB gurantees the
order of COMPLETION. After the data store is executed, the written data can
be stored in local CPU's cache, far from completion. Only the instruction is
completed, the written data is synchronized to the far CPU where vhost worker
is running.

Here is another paper talking about the difference between DMB and DSB. It's
explaining the difference between DMB/DSB better than ARMv9 specification.
However, it's hard for us to understand DMB/DSB work from the hardware level
based on the specification and paper.

https://ipads.se.sjtu.edu.cn/_media/publications/liuppopp20.pdf
(section 2.2  Order-preserving Options)
(I'm extracting the relevant part as below)

Data Memory Barrier (DMB) prevents reordering of memory accesses across the barrier.
Instead of waiting for previous accesses to become observable in the specified domain,
DMB only maintains the relative order between memory accesses. Meanwhile, DMB does
not block any non-memory access operations.

Data Synchronization Barrier (DSB) prevents reordering of any instructions across
the barrier. DSB will make sure that all masters in the specified domain can observe
the previous operations before issuing any subsequent instructions.

>> A DSB instruction is a memory barrier that ensures that memory accesses that
>> occur before the DSB instruction have __completed__ before the completion of
>> the DSB instruction.
> 
> This seems appropriate for when you want to order things more
> strongly. I do not get why it's necessary here.
> 

Please refer to above explanations.

>> In doing this, it acts as a stronger barrier than a DMB
>> and all ordering that is created by a DMB with specific options is also generated
>> by a DSB with the same options.
>>
>>>>    	vq->split.avail_idx_shadow++;
>>>>    	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>    						vq->split.avail_idx_shadow);
>>>> -- 
>>>> 2.44.0
>>>

Thanks,
Gavin

