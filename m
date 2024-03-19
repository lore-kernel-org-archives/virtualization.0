Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E07CF1B
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830340; cv=none; b=sBlrZ4lx724kmiOQ6UaFJP7Ad61jWy05uQUe1BWNf3CKvI2mmmvfwOMbnpTHy/AMnwXkTmMnxvSVG/i5hfQIsHrZ2ex7uU9d5sf8pjRQpv9V8h5cA1SpsDJmMGsIvEUqU/i9OgDEGH4jUPKBOduRnyEww3W9Oe0eVaCjlVPZfyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830340; c=relaxed/simple;
	bh=QgucDFrEr/SvLAZY1wBdMptDb13bGtRFhwoS3CnfYNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PITrePI3dfPub8ijfvEtYnQgHtkP+6ZDf/DtZlhnLSSYLrcVZdbtNZ/3JtfZx32X4aG8iGV1vXezGWLelwfjzhCLMlEkfEgmNZhTpqw+WFFHDbuiRRUE7K2pyCAgrYlJQoqtCRllVtm0t3IQtoDXUs4ez+EmRx8TVJY+1d7Q5sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvKPPN7/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvKPPN7/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710830337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PWFWfjNWiRH0RK0T1uriWMCNRFoVCxB1MnvhpCDvFQ=;
	b=hvKPPN7/X4RBR2qEe50dzR5TTXOGdm0t8U+YHdlU78QtybURq1X5SBSixLS/iSib1ApG+e
	5RWRq73erimWIqoZXkynF7ALMOlMX6aTQz7WLIMWSSlorWcksXzKyRTdBE196wXk9uXTh4
	fiYJgo1lfpVrDdvWoWYfDFQdVotBzvo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-5e2ip-giMye17Fv7DySf_A-1; Tue, 19 Mar 2024 02:38:56 -0400
X-MC-Unique: 5e2ip-giMye17Fv7DySf_A-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e04e1ac036so5118778b3a.3
        for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 23:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830335; x=1711435135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PWFWfjNWiRH0RK0T1uriWMCNRFoVCxB1MnvhpCDvFQ=;
        b=h6LBExoTEDFtXUOPHEPY/zKPSkvdfEEUhDzzd3YLeI+n886rAgxnSUJV6TFEm49NEv
         nR28ifzUX8V3tVai+zPtIlMEP8o8I9G9rJIfWw+ClyqRwQrv4gEGXwAjm5oeZBXTkgaa
         ns9J88a6AVBQeSmD2diOf00M4SEqRGDE61ZrRb8sb7Oyw4TuhuOYS9O+E7t2132Vsg+3
         m5ZOz1qLrJhlfeeLaOd4L9HcK8EtkIqOgQvHe2Kp+UCAvXuB8CHjp2MiRbmPbS5UObsh
         nDe01ous4HrCWE5ye0bVWmRSWDKznuJFHRSgwn4ua2xqMvAJFTehyzRYSbx3oMK9ybwz
         6rqg==
X-Forwarded-Encrypted: i=1; AJvYcCWp4cT3e7acDbKsV+p2TXk0bNTtiSO9Lrjn6wFeAzmybxE6WwFZ50w+in0YLgfxLIPef6y3fx6yP0jv/65hp1GhY0tSNUY/0Xo5BeQP2Gs=
X-Gm-Message-State: AOJu0YzPMnICF7qwVkgsL3bcsmLIgS07MXTD5e3ZTgPTb2YUViwysOrW
	5+1sMfZ4FV+ndk70rvCbo/bJrRI3lebCbQDmOn4rhqMC+XMUmTpsJirqu3Hcdiu+BuJsKYPymqj
	55I2U/RQ4gXSljMxS39HU1/5jfiqz0zuT8eeu/ZF8CXfAfyahbAI2/NS+6PgmyNDa
X-Received: by 2002:a05:6a21:78a9:b0:1a3:5299:1648 with SMTP id bf41-20020a056a2178a900b001a352991648mr11972188pzc.16.1710830335509;
        Mon, 18 Mar 2024 23:38:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4CuCVJiYhCSgYrUKlARZPvazBultLs5Ehqesd5coo9WIACzRgb9oUYr+Q8e3TOtm1pisQnQ==
X-Received: by 2002:a05:6a21:78a9:b0:1a3:5299:1648 with SMTP id bf41-20020a056a2178a900b001a352991648mr11972179pzc.16.1710830335114;
        Mon, 18 Mar 2024 23:38:55 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b001db8f7720e2sm10759114pln.288.2024.03.18.23.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:38:54 -0700 (PDT)
Message-ID: <9b3030d1-cb2c-4ce0-8b24-1074b616fc84@redhat.com>
Date: Tue, 19 Mar 2024 16:38:49 +1000
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
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240319020905-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 16:09, Michael S. Tsirkin wrote:

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
>>          // Work:   __ndelay(100);
>>          // Work:   __ndelay(10);
>>          // Broken: __ndelay(9);
>>
>>         vq->split.avail_idx_shadow++;
>>          vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>                                                  vq->split.avail_idx_shadow);
> 
> What if you stick __ndelay here?
> 

        /* Put entry in available array (but don't update avail->idx until they
          * do sync). */
         avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
         vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);

         /* Descriptors and available array need to be set before we expose the
          * new available array entries. */
         virtio_wmb(vq->weak_barriers);
         vq->split.avail_idx_shadow++;
         vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
                                                 vq->split.avail_idx_shadow);
         /* Try __ndelay(x) here as Michael suggested
          *
          * Work:      __ndelay(200);    possiblly make it hard to reproduce
          * Broken:    __ndelay(100);
          * Broken:    __ndelay(20);
          * Broken:    __ndelay(10);
          */
         __ndelay(200);


> 
>>          vq->num_added++;
>>
>>          pr_debug("Added buffer head %i to %p\n", head, vq);
>>          END_USE(vq);
>>          :
>> }
>>
>> I also tried to measure the consumed time for various barrier-relative instructions using
>> ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
>> __smp_wmb() but faster than __mb()
>>
>>      Instruction           Range of used time in ns
>>      ----------------------------------------------
>>      __smp_wmb()           [32  1128032]
>>      __smp_mb()            [32  1160096]
>>      __mb()                [32  1162496]
>>

Thanks,
Gavin

