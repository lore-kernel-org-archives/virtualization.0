Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C64438A
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831267; cv=none; b=Mm7kqP53SA+UTC3cUCaI55G3frM8KZYY2Ri9ZdMLWHorAnNuZ6HHU9VqPCljfjgtybmk0USKwxEBGrHAbxr541dlVzqCTgNkAdG1PG2+3JJ5yvgEaNnwYSh2nhvKDIpSKGHatWAYYQoGVXRBERRYrI6Z9fCsWn9rQxJlZ5fAC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831267; c=relaxed/simple;
	bh=BLv7Oj3VZ7iceafKAUY/widGHGZAc/uj42nv+VKIa/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i22+9APUsHVikpZvVpYthZ3eGzOmsVGt6tz0JsUN9BtAvCKO8MOIEcJ4kXg2iCXTra+il5RAjomjylTsTukAItl+Wd3WOMR7YMcFi5jPz2ENeal9jh+D+t36AdGpx8QH0T9RpG0q7NwaR1koopGJkTTWbUmy6/dp2uiR1KM7T5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkqGeczu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkqGeczu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710831265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icGFjCa1xrYUbecPG8RFGWPxGwZQyKoWyFdK0JxSbj4=;
	b=XkqGeczuFyoeRgLNjZL8QhwtUGKYlmhpd4sMJPCf93WSGkdC0W6WaeY9HxwUD27BWRWiNd
	g33deR7tpd6qW285Ct713DdTj2U899a8gpFVyYJD4mOxJePFC/73KWrLZO/k53179tPxTZ
	1RwSh+2Ficoz29Kq7NcTWHRybi7fk60=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-i9V3VRjGNaaEnEOEpitheA-1; Tue, 19 Mar 2024 02:54:23 -0400
X-MC-Unique: i9V3VRjGNaaEnEOEpitheA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dde0e7514bso46512955ad.1
        for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 23:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710831262; x=1711436062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icGFjCa1xrYUbecPG8RFGWPxGwZQyKoWyFdK0JxSbj4=;
        b=c0KjBPAnaz5E8N8TBm2yPNGhCQjSyroUJ3FrWi0zXBElNY2ZEDJyuQ3GvFRn4jVOde
         /9GVf5YIyrHu1Psccb/PFNJrTANeYn3x5OllPLGVv2s0J7VjZhQ0wWhN+lKgeKpg7OY5
         32sa5JdUrv+5/GcbdWBKSuWsfsrLcGahbXKhU0Qlm3YU504bNEpJJKDZkRnBm8vpTAbj
         SfQzKVe7ND+wFXghQ12xACi77scEDg1cvm7eG68pYyrTcH3EAsh7RAFNdNxYBSdq7dYy
         SczqiPf8LIdwDyjf43R1X/fSOTUl9B9wFovEBZFikwdEITcHA/0B3A+Amqlq8I+YdFkB
         BayA==
X-Forwarded-Encrypted: i=1; AJvYcCUx0anVW6W3cP+kjqlzR6qyHYQ3jZisJFBvTQy19I+AlhJnZyl3yDGude43FvRuqply9FrHkvlYnTXZ8RmS7di1YGwu0NJ4s1jv/jow3Hg=
X-Gm-Message-State: AOJu0YySrE+vDtv9wWGvWPoKj9BEYGYT8UK4V3SL3PD496u4uXxVUewI
	yTUP2fvuC5a6DvQ3TbXcYkYlRMXGeu/uLpND8RSl8w0fm3EZUcGE/jkUbB9YYiifD3iRynsJKu2
	p4hwYZVav/ZoEC4OPqM5+wBOnTPMkHcHhZjBgq7bxpVHdPaByZCG1axa0bS5Kc146
X-Received: by 2002:a17:902:e882:b0:1e0:1bfd:c1cd with SMTP id w2-20020a170902e88200b001e01bfdc1cdmr5859891plg.54.1710831262342;
        Mon, 18 Mar 2024 23:54:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS5nCGnHthe4SH4yG07pw+TKNbzItAryCrM74VL3kORDsmNhqLMKxBM1cXZ8h6C+/DTf6k8g==
X-Received: by 2002:a17:902:e882:b0:1e0:1bfd:c1cd with SMTP id w2-20020a170902e88200b001e01bfdc1cdmr5859880plg.54.1710831262001;
        Mon, 18 Mar 2024 23:54:22 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b001dee4bd73e0sm9335536pla.59.2024.03.18.23.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:54:21 -0700 (PDT)
Message-ID: <6b829cfc-9cbe-42eb-9935-62d2cf5fbcc4@redhat.com>
Date: Tue, 19 Mar 2024 16:54:15 +1000
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
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240319020949-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 16:10, Michael S. Tsirkin wrote:
> On Tue, Mar 19, 2024 at 02:09:34AM -0400, Michael S. Tsirkin wrote:
>> On Tue, Mar 19, 2024 at 02:59:23PM +1000, Gavin Shan wrote:
>>> On 3/19/24 02:59, Will Deacon wrote:
[...]
>>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>>> index 49299b1f9ec7..7d852811c912 100644
>>>>> --- a/drivers/virtio/virtio_ring.c
>>>>> +++ b/drivers/virtio/virtio_ring.c
>>>>> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>>>>    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>>>    	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>>> -	/* Descriptors and available array need to be set before we expose the
>>>>> -	 * new available array entries. */
>>>>> -	virtio_wmb(vq->weak_barriers);
>>>>> +	/*
>>>>> +	 * Descriptors and available array need to be set before we expose
>>>>> +	 * the new available array entries. virtio_wmb() should be enough
>>>>> +	 * to ensuere the order theoretically. However, a stronger barrier
>>>>> +	 * is needed by ARM64. Otherwise, the stale data can be observed
>>>>> +	 * by the host (vhost). A stronger barrier should work for other
>>>>> +	 * architectures, but performance loss is expected.
>>>>> +	 */
>>>>> +	virtio_mb(false);
>>>>>    	vq->split.avail_idx_shadow++;
>>>>>    	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>>>    						vq->split.avail_idx_shadow);
>>>>
>>>> Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
>>>> here, especially when ordering accesses to coherent memory.
>>>>
>>>> In practice, either the larger timing different from the DSB or the fact
>>>> that you're going from a Store->Store barrier to a full barrier is what
>>>> makes things "work" for you. Have you tried, for example, a DMB SY
>>>> (e.g. via __smb_mb()).
>>>>
>>>> We definitely shouldn't take changes like this without a proper
>>>> explanation of what is going on.
>>>>
>>>
>>> Thanks for your comments, Will.
>>>
>>> Yes, DMB should work for us. However, it seems this instruction has issues on
>>> NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
>>> from hardware level. I agree it's not the solution to replace DMB with DSB
>>> before we fully understand the root cause.
>>>
>>> I tried the possible replacement like below. __smp_mb() can avoid the issue like
>>> __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
>>>
>>> static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
>>> {
>>>      :
>>>          /* Put entry in available array (but don't update avail->idx until they
>>>           * do sync). */
>>>          avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>>          vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>>
>>>          /* Descriptors and available array need to be set before we expose the
>>>           * new available array entries. */
>>>          // Broken: virtio_wmb(vq->weak_barriers);
>>>          // Broken: __dma_mb();
>>>          // Work:   __mb();
>>>          // Work:   __smp_mb();
> 
> Did you try __smp_wmb ? And wmb?
> 

virtio_wmb(false) is equivalent to __smb_wmb(), which is broken.

__wmb() works either. No issue found with it.

>>>          // Work:   __ndelay(100);
>>>          // Work:   __ndelay(10);
>>>          // Broken: __ndelay(9);
>>>
>>>         vq->split.avail_idx_shadow++;
>>>          vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>>                                                  vq->split.avail_idx_shadow);
>>
>> What if you stick __ndelay here?
> 
> And keep virtio_wmb above?
> 

The result has been shared through a separate reply.

>>
>>>          vq->num_added++;
>>>
>>>          pr_debug("Added buffer head %i to %p\n", head, vq);
>>>          END_USE(vq);
>>>          :
>>> }
>>>
>>> I also tried to measure the consumed time for various barrier-relative instructions using
>>> ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
>>> __smp_wmb() but faster than __mb()
>>>
>>>      Instruction           Range of used time in ns
>>>      ----------------------------------------------
>>>      __smp_wmb()           [32  1128032]
>>>      __smp_mb()            [32  1160096]
>>>      __mb()                [32  1162496]
>>>

Thanks,
Gavin

