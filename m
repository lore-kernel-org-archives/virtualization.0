Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1386A1E536
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710834107; cv=none; b=JoGrZCz0bIX5LG//qMSS2ZqibELPArDRxwIj/itOCnBJeMG4LVZOngDiplWaWJTFPj1UxGn7Mtiw79+oCXLHfsWq/kEjIL0iXcJO8i8JjIYLh6+Zre2G4iLQuGzz6WauL9hqTKyu0oiflwnt8nTmywGpAYJ6vFIwDu06auq4TXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710834107; c=relaxed/simple;
	bh=/DQK8Al4q2Iiu4OD4NZdTeLexQiz31UT/H20Cj8gkDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drN0T/IkcMZ8pPdZobg0U0N9IbBySJOt8AaiMy6DTrQ7jZc+VCKD0tK+JVeY5Ea53lqEyxyquk+guTZBfgymJb8uv0dYyz4QRZg4b4nb8yyG0mCskturN7zNGfiOSRFrDyod6MxvcIadqZnrktQiJmJyN65PkwLVZ56sxgpVdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Crm/7FBx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Crm/7FBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710834105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZENGAKckd1InNLrAPOyF9uUy4qFGPBOjBi+IwPE3MtM=;
	b=Crm/7FBxmsD3naOK1ta+fzyBNRkfSBXL+ojYx7PzJeqYJWSKEQ5aVJZkO12BJHWnkjx5ex
	bN2fvasDSCTFw1xObTnCz0/CM6XxVnVaxGZO6PdEfhnXMI9KJqsUbMVrwoI6TjuWnZUcMY
	52EhbUlquGyP5x4MPuS665qtCcJ/QAo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-qJqRlM3ENTuAZ--gc9Uhog-1; Tue, 19 Mar 2024 03:41:43 -0400
X-MC-Unique: qJqRlM3ENTuAZ--gc9Uhog-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29de982f09aso3634023a91.1
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 00:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710834102; x=1711438902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZENGAKckd1InNLrAPOyF9uUy4qFGPBOjBi+IwPE3MtM=;
        b=Ms2WWEgGdmPQ4gxBn4YjMTaAb4O4RLealWxD/+Dg1EchC/5fGXujE+yUmg0Or88XaI
         GV6CHuVpfttpUKuH3TFXIlNCd0xU4p81VeNorlQfpwz7qHVcoB9FqQMLb3sXjrrRKdY7
         5F03fDfBCR64uinoT6mZg3aEQATTAiSN6LfzCw4UGTT4lyTTUQvSWPJ1TEp5rX+GKVsz
         M9n5GPXa6IwTwDr5gq4AKMRJh/cXfw1l4NcZhd/5+HvALimtmyxCncoOq8gmELbpSX91
         ByktS5WSxU/f0vqZmUEZ/MXfsaloWlPqoV+Q9P6wCFLdAFIJwkxwNklSqLtwMxUAigag
         fQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3JPHxlS0yraDGZ2flWlw3X1k+05PR0JCPuYkdeXURFEAUjBMDm2dppQ6JYOE3xWjMRt1okiL5U5bbYolyFJbJObM5rjhgK/2Dyx0F24o=
X-Gm-Message-State: AOJu0Yy4u7Z9oO9e0bytYoUa/Sc73XR+udN6Ixvun6xT0xj6KjLhj7LD
	z0mjPdi2SawMTAcNoQXnz4h3aMwv5SSBNJeE+bwTUYOAmMcPYcwPNuEpqzrp2oHzl2zqYpQYZU8
	GRBPqyM6at2vIRQmk4AQzqPs7xtgRP1EUnPLSaPg+blqt80LnOTcBptc4Ef6ffYiS
X-Received: by 2002:a17:90a:f3c5:b0:29d:e75b:e73a with SMTP id ha5-20020a17090af3c500b0029de75be73amr1621487pjb.49.1710834102094;
        Tue, 19 Mar 2024 00:41:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjzCbjypzQuA5Jo77zZ7OknwZTx0eJueh9GmXOAvslsuDsH2aDA/AR+72V97FVuzm6mzOBDQ==
X-Received: by 2002:a17:90a:f3c5:b0:29d:e75b:e73a with SMTP id ha5-20020a17090af3c500b0029de75be73amr1621479pjb.49.1710834101764;
        Tue, 19 Mar 2024 00:41:41 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id pt7-20020a17090b3d0700b0029fe026ae17sm475104pjb.51.2024.03.19.00.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 00:41:41 -0700 (PDT)
Message-ID: <6df97716-6669-4d94-8923-41758f71fc07@redhat.com>
Date: Tue, 19 Mar 2024 17:41:35 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319020905-mutt-send-email-mst@kernel.org>
 <20240319020949-mutt-send-email-mst@kernel.org>
 <6b829cfc-9cbe-42eb-9935-62d2cf5fbcc4@redhat.com>
 <20240319030148-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240319030148-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 17:04, Michael S. Tsirkin wrote:
> On Tue, Mar 19, 2024 at 04:54:15PM +1000, Gavin Shan wrote:
>> On 3/19/24 16:10, Michael S. Tsirkin wrote:
>>> On Tue, Mar 19, 2024 at 02:09:34AM -0400, Michael S. Tsirkin wrote:
>>>> On Tue, Mar 19, 2024 at 02:59:23PM +1000, Gavin Shan wrote:
>>>>> On 3/19/24 02:59, Will Deacon wrote:
>> [...]
>>>>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>>>>> index 49299b1f9ec7..7d852811c912 100644
>>>>>>> --- a/drivers/virtio/virtio_ring.c
>>>>>>> +++ b/drivers/virtio/virtio_ring.c
>>>>>>> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>>>>>>     	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>>>>>     	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>>>>> -	/* Descriptors and available array need to be set before we expose the
>>>>>>> -	 * new available array entries. */
>>>>>>> -	virtio_wmb(vq->weak_barriers);
>>>>>>> +	/*
>>>>>>> +	 * Descriptors and available array need to be set before we expose
>>>>>>> +	 * the new available array entries. virtio_wmb() should be enough
>>>>>>> +	 * to ensuere the order theoretically. However, a stronger barrier
>>>>>>> +	 * is needed by ARM64. Otherwise, the stale data can be observed
>>>>>>> +	 * by the host (vhost). A stronger barrier should work for other
>>>>>>> +	 * architectures, but performance loss is expected.
>>>>>>> +	 */
>>>>>>> +	virtio_mb(false);
>>>>>>>     	vq->split.avail_idx_shadow++;
>>>>>>>     	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>>>>     						vq->split.avail_idx_shadow);
>>>>>>
>>>>>> Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
>>>>>> here, especially when ordering accesses to coherent memory.
>>>>>>
>>>>>> In practice, either the larger timing different from the DSB or the fact
>>>>>> that you're going from a Store->Store barrier to a full barrier is what
>>>>>> makes things "work" for you. Have you tried, for example, a DMB SY
>>>>>> (e.g. via __smb_mb()).
>>>>>>
>>>>>> We definitely shouldn't take changes like this without a proper
>>>>>> explanation of what is going on.
>>>>>>
>>>>>
>>>>> Thanks for your comments, Will.
>>>>>
>>>>> Yes, DMB should work for us. However, it seems this instruction has issues on
>>>>> NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
>>>>> from hardware level. I agree it's not the solution to replace DMB with DSB
>>>>> before we fully understand the root cause.
>>>>>
>>>>> I tried the possible replacement like below. __smp_mb() can avoid the issue like
>>>>> __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
>>>>>
>>>>> static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
>>>>> {
>>>>>       :
>>>>>           /* Put entry in available array (but don't update avail->idx until they
>>>>>            * do sync). */
>>>>>           avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>>>           vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>>>
>>>>>           /* Descriptors and available array need to be set before we expose the
>>>>>            * new available array entries. */
>>>>>           // Broken: virtio_wmb(vq->weak_barriers);
>>>>>           // Broken: __dma_mb();
>>>>>           // Work:   __mb();
>>>>>           // Work:   __smp_mb();
>>>
>>> Did you try __smp_wmb ? And wmb?
>>>
>>
>> virtio_wmb(false) is equivalent to __smb_wmb(), which is broken.
>>
>> __wmb() works either. No issue found with it.
> 
> Oh interesting. So how do smp_mb() and wmb() disassemble on this
> platform? Can you please check?
> 

I don't see they have been translated wrongly on Nvidia's grace-hopper:

===> virtio_wmb(vq->weak_barriers)

0xffff8000807b07c8 <+1168>:  ldrb    w0, [x20, #66]
0xffff8000807b07cc <+1172>:  cbz     w0, 0xffff8000807b089c <virtqueue_add_split+1380>
0xffff8000807b07d0 <+1176>:  dmb     ishst     // same to __smp_wmb()
     :
0xffff8000807b089c <+1380>:  dmb     oshst     // same to __dma_wmb()
0xffff8000807b08a0 <+1384>:  b       0xffff8000807b07d4 <virtqueue_add_split+1180>

===> wmb()

0xffff8000807b07c8 <+1168>:  dsb     st


> 
>>>>>           // Work:   __ndelay(100);
>>>>>           // Work:   __ndelay(10);
>>>>>           // Broken: __ndelay(9);
>>>>>
>>>>>          vq->split.avail_idx_shadow++;
>>>>>           vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>>                                                   vq->split.avail_idx_shadow);
>>>>
>>>> What if you stick __ndelay here?
>>>
>>> And keep virtio_wmb above?
>>>
>>
>> The result has been shared through a separate reply.
>>
>>>>
>>>>>           vq->num_added++;
>>>>>
>>>>>           pr_debug("Added buffer head %i to %p\n", head, vq);
>>>>>           END_USE(vq);
>>>>>           :
>>>>> }
>>>>>
>>>>> I also tried to measure the consumed time for various barrier-relative instructions using
>>>>> ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
>>>>> __smp_wmb() but faster than __mb()
>>>>>
>>>>>       Instruction           Range of used time in ns
>>>>>       ----------------------------------------------
>>>>>       __smp_wmb()           [32  1128032]
>>>>>       __smp_mb()            [32  1160096]
>>>>>       __mb()                [32  1162496]
>>>>>

Thanks,
Gavin

