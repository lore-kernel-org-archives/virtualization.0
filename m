Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA221B3727
	for <virtualization@lists.linux.dev>; Thu, 31 Oct 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395851; cv=none; b=GbCkdokg514h3aPsYR+R9BKJIjb/uWxnt/IOQL09yewqmX8iYOqwsXhQ8brjSQjVjU/GWBpZAszgiVTP2Za8j0Gm3nmXFeDISlbZXSaMNQTXTVXImEyWDNZFFXvnLYHTtQlUpS82e5//kNtdnyX218WTLy5oeaNrYrNrrvO7oBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395851; c=relaxed/simple;
	bh=pZ0/4MtkFUVPvfV/ywB73HL1pJJdQCYJdUGMpDz4N6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOK91NTbJ/4MHYaB8zAqp1xiFCNrXEmxoQvXTkHY/fj6Yu6LG+eDYIfi+AUpE7MTXCvM18WNa7YT+8Vz3aVatlnvaKsfbH9ciYCG3f1R0fCruyn1MK7QCFqMQiJjWBeHFlIk33EHTUhKAmPChWkUXOEkJFDtIdORpQhSxnqF+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwJV3oEU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwJV3oEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730395847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=po4aGjAZdOMFvGy5VxwhLDYTRzbKRpxyFH4vyJU9YZ4=;
	b=bwJV3oEUzF8+WoPZtZGE49UIwb6DvifhGXTN9JDbojwDyUH73A4qk10hf5FMX5LA4AwwtX
	R291ffZ3fGOmwkj5TCoXsAY+j7ba50WfYTJhhbOo4WMxzx79kQzZm33b/IULpGH3oGc2uV
	/STZIXPy6n1V4AJfn6j6W0rIVVZK14g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-8OG75b0fNTqq4ykksfpd-Q-1; Thu, 31 Oct 2024 13:30:40 -0400
X-MC-Unique: 8OG75b0fNTqq4ykksfpd-Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315d98a75fso7941665e9.2
        for <virtualization@lists.linux.dev>; Thu, 31 Oct 2024 10:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395840; x=1731000640;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=po4aGjAZdOMFvGy5VxwhLDYTRzbKRpxyFH4vyJU9YZ4=;
        b=cvG85nztrgByz2HePXmt6ztW7ZtBwNoCZUjaohtMI4nbHm9DaAscedOYwwI17V2S4J
         FvQ8oUoxWb5CuU2qhnIWmv5GMkI+tb3oXwtu2Ar9PFyrItW3B4/dg4oZBeuziz/aUqcs
         psRB+BYARoch1oKxsPHkL4oiDw7Mqolrgv+mC+ohqdK8NZKfLFCx8bc6S3ibl2Iknxe4
         65n3vbwyXjZQ01wbU9U4sGXrICf8SaKTlBHG7Q7GhoFkdN98yJ5kVa36Z3JElWIEhB0h
         Bk+JW0wL/tLrZsme15CoQ+YVi39Mk+oegJ2VR2zkiYkz44zfHH9cHAswyEOgyAZRo4MZ
         FHmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/0iopchIjGy1w/L1SeVfTnREyv0UwZJuHejDhxilYifnB4ezJeW4WkewQfWAW6OmCjDA2jOkvzXpm8Tqz0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyt8cnknd48austfL4H8UYg1Kuc40YzO9yXWVwxHUOwYRotBgW3
	gtOwmRCbBFGWY7C1ORrPQVwlAudxrZm//0obysAKMaxqIk0EgpdPZwR7H+m1D1+5q5YwWolOXWc
	VpQj2VGdm9k2oXaTaHMW4V99fFhUOwBsQvSB9SQHmP8C9Xo6Dd9bnOorkuPr/VCBe
X-Received: by 2002:adf:ce89:0:b0:37d:476d:2d58 with SMTP id ffacd0b85a97d-380611e56aemr13825435f8f.45.1730395839710;
        Thu, 31 Oct 2024 10:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEi4RPqd4a5QbOU7yDumOOtBgboxiLYO1zuyID1truLpjoe27PGIaeDpB/SPHnzDghbR46aA==
X-Received: by 2002:adf:ce89:0:b0:37d:476d:2d58 with SMTP id ffacd0b85a97d-380611e56aemr13825396f8f.45.1730395839298;
        Thu, 31 Oct 2024 10:30:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe? (p200300cbc70aed007ddf1ea94f7a91fe.dip0.t-ipconnect.de. [2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7280sm2745874f8f.59.2024.10.31.10.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:30:38 -0700 (PDT)
Message-ID: <3b5d2bf2-2d27-43a1-86fe-076878823edf@redhat.com>
Date: Thu, 31 Oct 2024 18:30:37 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] virtio-mem: s390 support
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>
References: <20241025141453.1210600-1-david@redhat.com>
 <ZyOv2E-WEcppbf3G@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <ZyO0lPkLPGnpDKrr@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZyO0lPkLPGnpDKrr@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.10.24 17:47, Sumanth Korikkar wrote:
> On Thu, Oct 31, 2024 at 05:27:06PM +0100, Sumanth Korikkar wrote:
>> On Fri, Oct 25, 2024 at 04:14:45PM +0200, David Hildenbrand wrote:
>>> Let's finally add s390 support for virtio-mem; my last RFC was sent
>>> 4 years ago, and a lot changed in the meantime.
>>>
>>> The latest QEMU series is available at [1], which contains some more
>>> details and a usage example on s390 (last patch).
>>>
>>> There is not too much in here: The biggest part is querying a new diag(500)
>>> STORAGE_LIMIT hypercall to obtain the proper "max_physmem_end".
>>>
>>> The last three patches are not strictly required but certainly nice-to-have.
>>>
>>> Note that -- in contrast to standby memory -- virtio-mem memory must be
>>> configured to be automatically onlined as soon as hotplugged. The easiest
>>> approach is using the "memhp_default_state=" kernel parameter or by using
>>> proper udev rules. More details can be found at [2].
>>>
>>> I have reviving+upstreaming a systemd service to handle configuring
>>> that on my todo list, but for some reason I keep getting distracted ...
>>>
>>> I tested various things, including:
>>>   * Various memory hotplug/hotunplug combinations
>>>   * Device hotplug/hotunplug
>>>   * /proc/iomem output
>>>   * reboot
>>>   * kexec
>>>   * kdump: make sure we properly enter the "kdump mode" in the virtio-mem
>>>     driver
>>>
>>> kdump support for virtio-mem memory on s390 will be sent out separately.
>>>
>>> v2 -> v3
>>> * "s390/kdump: make is_kdump_kernel() consistently return "true" in kdump
>>>     environments only"
>>>   -> Sent out separately [3]
>>> * "s390/physmem_info: query diag500(STORAGE LIMIT) to support QEMU/KVM memory
>>>     devices"
>>>   -> No query function for diag500 for now.
>>>   -> Update comment above setup_ident_map_size().
>>>   -> Optimize/rewrite diag500_storage_limit() [Heiko]
>>>   -> Change handling in detect_physmem_online_ranges [Alexander]
>>>   -> Improve documentation.
>>> * "s390/sparsemem: provide memory_add_physaddr_to_nid() with CONFIG_NUMA"
>>>   -> Added after testing on systems with CONFIG_NUMA=y
>>>
>>> v1 -> v2:
>>> * Document the new diag500 subfunction
>>> * Use "s390" instead of "s390x" consistently
>>>
>>> [1] https://lkml.kernel.org/r/20241008105455.2302628-1-david@redhat.com
>>> [2] https://virtio-mem.gitlab.io/user-guide/user-guide-linux.html
>>> [3] https://lkml.kernel.org/r/20241023090651.1115507-1-david@redhat.com
>>>
>>> Cc: Heiko Carstens <hca@linux.ibm.com>
>>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>>> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
>>> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
>>> Cc: Sven Schnelle <svens@linux.ibm.com>
>>> Cc: Thomas Huth <thuth@redhat.com>
>>> Cc: Cornelia Huck <cohuck@redhat.com>
>>> Cc: Janosch Frank <frankja@linux.ibm.com>
>>> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Jason Wang <jasowang@redhat.com>
>>> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> Cc: "Eugenio P?rez" <eperezma@redhat.com>
>>> Cc: Eric Farman <farman@linux.ibm.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>
>>> David Hildenbrand (7):
>>>    Documentation: s390-diag.rst: make diag500 a generic KVM hypercall
>>>    Documentation: s390-diag.rst: document diag500(STORAGE LIMIT)
>>>      subfunction
>>>    s390/physmem_info: query diag500(STORAGE LIMIT) to support QEMU/KVM
>>>      memory devices
>>>    virtio-mem: s390 support
>>>    lib/Kconfig.debug: default STRICT_DEVMEM to "y" on s390
>>>    s390/sparsemem: reduce section size to 128 MiB
>>>    s390/sparsemem: provide memory_add_physaddr_to_nid() with CONFIG_NUMA
>>>
>>>   Documentation/virt/kvm/s390/s390-diag.rst | 35 +++++++++++++----
>>>   arch/s390/boot/physmem_info.c             | 47 ++++++++++++++++++++++-
>>>   arch/s390/boot/startup.c                  |  7 +++-
>>>   arch/s390/include/asm/physmem_info.h      |  3 ++
>>>   arch/s390/include/asm/sparsemem.h         | 10 ++++-
>>>   drivers/virtio/Kconfig                    | 12 +++---
>>>   lib/Kconfig.debug                         |  2 +-
>>>   7 files changed, 98 insertions(+), 18 deletions(-)
>>>
>>>
>>> base-commit: ae90f6a6170d7a7a1aa4fddf664fbd093e3023bc
>>> -- 
>>> 2.46.1
>>>
>>
>> Tested successfully various memory hotplug operations on lpar.
>>
> Just to be more precise, tested memory hotplug/hotunplug combinations +
> Device hotplug/hotunplug operations on guest.

Thanks a bunch!

-- 
Cheers,

David / dhildenb

