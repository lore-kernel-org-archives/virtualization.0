Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442112D75C
	for <virtualization@lists.linux.dev>; Tue, 22 Oct 2024 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589596; cv=none; b=KloEWG+CnNhHl06miGr83a8oX+nCYqX8r+1jrY7+dcytZYcV71Yvrd0llPeJKrDJkQ7i8PEdWnSxH9xCDgYQnilfKA/H5aO33Sx6YJZkhEqL4UhpsELTJJVOXW1IF65SHElPO2nWBVqN7ftDw7Mmjb6H08YkJmVC0C53PSGlCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589596; c=relaxed/simple;
	bh=scYnifXivjL0Q2p6hFdT+qK2TYmlEqX9KGFnsALuogc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSJzgl1RMC0oODoPMBitKjB7CFq1H3bd7I1schGjw0FYhFsMN7tMd949Vcv/7vcq3X5YOezytHMppdcMxxfofKd3U6ZF85kFQIPXw4aPTvPv/LRNuffS+QzqwIVELMZvnsXA6S1PD10H6Vj8g9GOfrcAHzKAs3p1a+7iV2753F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6wGcYgA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6wGcYgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729589593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PVXjarjpT2me/HEqV5U+dOBsyl8V0kY5yMijGXx3qRE=;
	b=K6wGcYgAkQssUFs3F5ABHmLT7+GgYioM41w0yJX/NDNUAMzawn8sVP25cw2MDum43Z+xLD
	XQDET7wDDDinNP5Zf7fIZZW6G3Hve8Kv8342Yo2HoGpDkps7ZW2ATmuYaShtdYLKRF3KG9
	QPMpgKecg1wOKVZIixSsbHrcht8gw8E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-hBGoNXGqOO29LU6O88gfRQ-1; Tue, 22 Oct 2024 05:33:12 -0400
X-MC-Unique: hBGoNXGqOO29LU6O88gfRQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4316300bb15so30992945e9.2
        for <virtualization@lists.linux.dev>; Tue, 22 Oct 2024 02:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729589591; x=1730194391;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PVXjarjpT2me/HEqV5U+dOBsyl8V0kY5yMijGXx3qRE=;
        b=caztzygsR9qpZw5/abqmR+91/45DSJ7gXCZMHDbiowfyNNzMpanDkKo6xD/EWpkN74
         UA0ixHZowQQtKi0P0HemBcHj0S+MM6Uc45ARInCVjwfXxfO9QPICwK+mq3WbP3lSaiRT
         3l8iHKFhdPQIpzx2Stg26vHD8gwusSEI4wRUYzjukD4affbHBMTNxqD6j+L7g3TsfkO3
         5ztbLfuwCSE6l6NCnIh/HC5f1Ap3Py1UDKi04UKxBk1mTxCLMLj0yBCGoaRWF0JmCfDU
         iDEP74r2Qm0v16ofvMzx6IzXOjFJQux7w4adl1a8ay2ZEuDidbpdkzIXnAKNN2CZS5UK
         ui2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9yIKwmYj9GjMcsz+MyTjcdcLssWlkFMIkWRJXv47LVweuKCYyAfVUxW5JcYVFPEdBqKGer/4yEm5gdzapHw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yznc4v+5LQoi5CZIvsm1R0WwcfvoZasmgCZjq+6Ep9iTSVOn1OE
	Nj+ksU9q/1hHbale1KxcGribQjMNtXCvlYEd1YFM/jL4Hp22ohT8XHLEVUJFWAQCr2cZNhtBCgE
	zSGldCIqYer8Bn6SF/aN++ZTw6jo3Jdq5i3t+SIysmBTW3b5hw1rNT5DnwHZfm4tw
X-Received: by 2002:a05:600c:1d04:b0:431:43c6:e868 with SMTP id 5b1f17b1804b1-4316168989amr116823815e9.23.1729589590828;
        Tue, 22 Oct 2024 02:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsVMtr0vPoX3GC1cafvEWG+eXenTikKUk4UF7+4sSq9bykVMQaJpWzxJ8Y3D4BsFBHFgf+EQ==
X-Received: by 2002:a05:600c:1d04:b0:431:43c6:e868 with SMTP id 5b1f17b1804b1-4316168989amr116823485e9.23.1729589590404;
        Tue, 22 Oct 2024 02:33:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f700:352b:d857:b95d:9072? (p200300cbc705f700352bd857b95d9072.dip0.t-ipconnect.de. [2003:cb:c705:f700:352b:d857:b95d:9072])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c311bsm81820335e9.29.2024.10.22.02.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 02:33:09 -0700 (PDT)
Message-ID: <1238f2a3-88a2-4996-92f2-05735801002b@redhat.com>
Date: Tue, 22 Oct 2024 11:33:07 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
To: Gregory Price <gourry@gourry.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, John Groves <John@groves.net>,
 virtualization@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
 qemu-devel@nongnu.org, Dave Jiang <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com,
 wangkefeng.wang@huawei.com, John Groves <jgroves@micron.com>,
 Fan Ni <fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>,
 =?UTF-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240815172223.00001ca7@Huawei.com>
 <fc05d089-ce04-42d2-a0d7-ea32fd73fe90@redhat.com>
 <Zu07AU3aUrHBMXaw@PC2K9PVX.TheFacebook.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zu07AU3aUrHBMXaw@PC2K9PVX.TheFacebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.09.24 11:06, Gregory Price wrote:
>>> 2. Coarse grained memory increases for 'normal' memory.
>>>      Can use memory hot-plug. Recovery of capacity likely to only be possible on
>>>      VM shutdown.
>>
>> Is there are reason "movable" (ZONE_MOVABLE) is not an option, at least in
>> some setups? If not, why?
>>
> 
> 
> This seems like a bit of a muddied conversation.

Cleaning up my inbox ... well at least trying :)

> 
> "'normal' memory" has no defined meaning - so lets clear this up a bit
> 
> There is:
> * System-RAM (memory managed by kernel allocators)
> * Special Purpose Memory (generally presented as DAX)
 > > System-RAM is managed as zones - the relevant ones are
> * ZONE_NORMAL allows both movable and non-movable allocations

.. except in corner cases like MIGRATE_CMA :)

> * ZONE_MOVABLE only allows non-movable allocations
>    (Caveat: this generally only applies to allocation, you can
>     violate this with stuff like pinning)

Note that long-term pinning is forbidden on MOVABLE, just like it is on 
MIGRATE_CMA. So we try that common use cases cannot violate this.

> 
> Hotplug can be thought of as two discrete mechanisms
> * Exposing capacity to the kernel (CXL DCD Transactions)
> * Exposing capacity to allocators (mm/memory-hotplug.c)
 > > 1) if the intent is to primarily utilize dynamic capacity for VMs, then
>     the host does not need (read: should not need) to map the memory as
>     System-RAM in the host. The VMM should be made to consume it directly
>     via DAX or otherwise.
> 
>     That capacity is almost by definition "Capital G Guaranteed" to be
>     reclaimable regardless of what the guest does. A VMM can force a guest
>     to let go of resources - that's its job.
> 
> 2) if the intent is to provide dynamic capacity to a host as System-RAM, then
>     recoverability is dictated by system usage of that capacity. If onlined
>     into ZONE_MOVABLE, then if the system has avoided doing things like pinning
>     those pages it should *generally* be recoverable (but not guaranteed).

There is, of course, the use case of memory overcommit -- in which case 
you would want 2). But likely that's out of the picture for this tagged 
memory.

> 
> 
> For the virtualization discussion:
> 
> Hotplug and recoverability is a non-issue.  The capacity should never be
> exposed to system allocators and the VMM should be made to consume special
> purpose memory directly. That's on the VMM/orchestration software to get right.
> 
> 
> For the host System-RAM discussion:
> 
> Auto-onlined hotplug capacity presently defaults to ZONE_NORMAL, but we
> discussed (yesterday, at Plumbers) changing this default to ZONE_MOVABLE.
> 
> The only concern is when insufficient ZONE_NORMAL exists to support
> ZONE_MOVABLE capacity - but this is unlikely to be the general scenario AND
> can be mitigated w/ existing mechanisms.

It might be worthwhile looking at 
Documentation/admin-guide/mm/memory-hotplug.rst "auto-movable" memory 
onlining polciy. It might not fit all sue cases, though (just like 
ZONE_MOVABLE doesn't)

> 
> Manually onlined capacity defaults to ZONE_MOVABLE.
> 
> It would be nice to make this behavior consistent, since the general opinion
> appears to be that this capacity should default to ZONE_MOVABLE.

It's much easier to shoot yourself into the foot with ZONE_MOVABLE, 
that's why the default can be adjusted manually using "online_movable" 
with e.g., memhp_default_state.

It's all a bit complicated, because there are various use cases and 
mechanisms for memory hotplug ... IIRC RHEL defaults with its udev rules 
to "ZONE_MOVABLE" on bare metal and "ZONE_NORMAL" in VMs. Except on 
s390, where we default to "offline" (standby memory ....).

I once worked on a systemd unit to make this configuration easier (and 
avoid udev rules), and possibly more "automatic" depending on the 
detected environment.

-- 
Cheers,

David / dhildenb

