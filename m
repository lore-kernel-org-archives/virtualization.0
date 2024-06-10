Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B76F2F1
	for <virtualization@lists.linux.dev>; Mon, 10 Jun 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009773; cv=none; b=Z36vpsmy0KBohL6AAgbBVtqqJtChGln8lE3HJv5I9cK4NYiTZiaUiHRJw+o4JdQTv1Z5COCdHj1j+BfjwzpFXNEWPOBE47Ly+2PXkkyGWqpGm+HayxBTJbHRYUVqSt/lTO1kaLUwDeaf7SZY3fexpdW+ygIcCKzfXDHDSysoSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009773; c=relaxed/simple;
	bh=4X3NzY/0G9gnq5hEYrDAdraQf2at+G7MFAtOMz5dTUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSM5e7eYcnhYRF49aF+PoCu6D3i8dgi0d6VqNp0AOTgHd1ypN1qRxafhA4StmthgMQBg9qlibJajqdzncU7COz+IXMLj+Cs2GoGZR2XwRwytcmPLe9GivHingt5l9W7ulx5PR3oC2zdFgdYmeJ2zVelYvCCcLS9hL9lfCgFZ8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLOeJrd8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLOeJrd8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718009771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K7xP27zKqY4v47zLxGRsdu26ar7Ig8tqaIa+76/1NNg=;
	b=aLOeJrd8ambtbxju63VRtCW0HkoflUQWYi0l6wiLlofuAaeXuJKreOkLGJOyGGuO2fJkY/
	r7iEXZVS6qf1gvk7FkM8PDkmSQHW0bAkt1Q/CNXJ/ug9sTF83WikQVzqgHBdrAajrhEj9B
	y9H4655+ru1jXIFg2yV8/3zgRDNfVFo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-9kNFfFVWMGi9FAIBEwSO9w-1; Mon, 10 Jun 2024 04:56:05 -0400
X-MC-Unique: 9kNFfFVWMGi9FAIBEwSO9w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421f3b7b27eso4400365e9.1
        for <virtualization@lists.linux.dev>; Mon, 10 Jun 2024 01:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718009764; x=1718614564;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K7xP27zKqY4v47zLxGRsdu26ar7Ig8tqaIa+76/1NNg=;
        b=ONAeaRJC2r/1K7Z5JodJ2V/J0LptK678LtxtomAhGiH83JWiFRjVglcGS+isiSZT9H
         Pg3BFD5bzLyB2dBJ+ikkzsylQfzmZ3NJqfG++cQ90ahHM2HU+TP0Zw35MxB0duXHv3XN
         YiyIEPK3Q/gblsuNehjNKirRAGTIp6TQJTepA3JtMTqAe5HxnwkWHXQDWt8944MeryS2
         P5inZQTIJq0PZtARmWXJUq/HgKh9F8MTOMr7p8br8Wvda6BV0vnTxUDrHET3xamjIES5
         W8N8DtUwVO6AStrhpfU6ytajuACykHiqD5Iy8mMrZkziO9ruzSJPbCDeV4Jv6Abw4Gkn
         Fq1w==
X-Forwarded-Encrypted: i=1; AJvYcCWl8WU4io0PHeJsEQ/pyqiiQ/YtjrotPgjTx+8mm/tvbcI01ytsKwAUwtqG1L8eJsVKwLc/FIQ5zNzwfH4OQZvIuRTUDTpEACKqfvLuQws=
X-Gm-Message-State: AOJu0YwqI/iBS22BK2kLZo/Um7M22qF8KuI8tqyiOfWTggdnACz0T4bR
	PT/0n7/+zaOFkpe+BZv/OcPFmJ/Ab90lIi1F5GHsQQ+MF+JvFbFylftIbBxjyH09DEkQxEcAOro
	E3GPpgPJt1p1uBIw49ab0e3z8gFPVVxE94NP8fCYmDJZJAFC1coV/O1W/jINlRkF4
X-Received: by 2002:a05:600c:4fc1:b0:422:aca:f87e with SMTP id 5b1f17b1804b1-4220acafc07mr8547315e9.19.1718009764175;
        Mon, 10 Jun 2024 01:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8VQ0Q4YEczV/EAVgWH6dX6M5wlMcQB+GZ0NoLgBFXD6JcjrTO0xiRa6CUmh2pcsQldmgXsA==
X-Received: by 2002:a05:600c:4fc1:b0:422:aca:f87e with SMTP id 5b1f17b1804b1-4220acafc07mr8546975e9.19.1718009763680;
        Mon, 10 Jun 2024 01:56:03 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f23c67e70sm2326824f8f.33.2024.06.10.01.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:56:03 -0700 (PDT)
Message-ID: <5d9583e1-3374-437d-8eea-6ab1e1400a30@redhat.com>
Date: Mon, 10 Jun 2024 10:56:02 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: initialize memmap of
 !ZONE_DEVICE with PageOffline() instead of PageReserved()
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 xen-devel@lists.xenproject.org, kasan-dev@googlegroups.com,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>
References: <20240607090939.89524-1-david@redhat.com>
 <20240607090939.89524-3-david@redhat.com>
 <ZmZ_3Xc7fdrL1R15@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZmZ_3Xc7fdrL1R15@localhost.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.24 06:23, Oscar Salvador wrote:
> On Fri, Jun 07, 2024 at 11:09:37AM +0200, David Hildenbrand wrote:
>> We currently initialize the memmap such that PG_reserved is set and the
>> refcount of the page is 1. In virtio-mem code, we have to manually clear
>> that PG_reserved flag to make memory offlining with partially hotplugged
>> memory blocks possible: has_unmovable_pages() would otherwise bail out on
>> such pages.
>>
>> We want to avoid PG_reserved where possible and move to typed pages
>> instead. Further, we want to further enlighten memory offlining code about
>> PG_offline: offline pages in an online memory section. One example is
>> handling managed page count adjustments in a cleaner way during memory
>> offlining.
>>
>> So let's initialize the pages with PG_offline instead of PG_reserved.
>> generic_online_page()->__free_pages_core() will now clear that flag before
>> handing that memory to the buddy.
>>
>> Note that the page refcount is still 1 and would forbid offlining of such
>> memory except when special care is take during GOING_OFFLINE as
>> currently only implemented by virtio-mem.
>>
>> With this change, we can now get non-PageReserved() pages in the XEN
>> balloon list. From what I can tell, that can already happen via
>> decrease_reservation(), so that should be fine.
>>
>> HV-balloon should not really observe a change: partial online memory
>> blocks still cannot get surprise-offlined, because the refcount of these
>> PageOffline() pages is 1.
>>
>> Update virtio-mem, HV-balloon and XEN-balloon code to be aware that
>> hotplugged pages are now PageOffline() instead of PageReserved() before
>> they are handed over to the buddy.
>>
>> We'll leave the ZONE_DEVICE case alone for now.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 27e3be75edcf7..0254059efcbe1 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -734,7 +734,7 @@ static inline void section_taint_zone_device(unsigned long pfn)
>>   /*
>>    * Associate the pfn range with the given zone, initializing the memmaps
>>    * and resizing the pgdat/zone data to span the added pages. After this
>> - * call, all affected pages are PG_reserved.
>> + * call, all affected pages are PageOffline().
>>    *
>>    * All aligned pageblocks are initialized to the specified migratetype
>>    * (usually MIGRATE_MOVABLE). Besides setting the migratetype, no related
>> @@ -1100,8 +1100,12 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
>>   
>>   	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
>>   
>> -	for (i = 0; i < nr_pages; i++)
>> -		SetPageVmemmapSelfHosted(pfn_to_page(pfn + i));
>> +	for (i = 0; i < nr_pages; i++) {
>> +		struct page *page = pfn_to_page(pfn + i);
>> +
>> +		__ClearPageOffline(page);
>> +		SetPageVmemmapSelfHosted(page);
> 
> So, refresh my memory here please.
> AFAIR, those VmemmapSelfHosted pages were marked Reserved before, but now,
> memmap_init_range() will not mark them reserved anymore.

Correct.

> I do not think that is ok? I am worried about walkers getting this wrong.
> 
> We usually skip PageReserved pages in walkers because are pages we cannot deal
> with for those purposes, but with this change, we will leak
> PageVmemmapSelfHosted, and I am not sure whether are ready for that.

There are fortunately not that many left.

I'd even say marking them (vmemmap) reserved is more wrong than right: 
note that ordinary vmemmap pages after memory hotplug are not reserved! 
Only bootmem should be reserved.

Let's take at the relevant core-mm ones (arch stuff is mostly just for 
MMIO remapping)

fs/proc/task_mmu.c:     if (PageReserved(page))
fs/proc/task_mmu.c:     if (PageReserved(page))

-> If we find vmemmap pages mapped into user space we already messed up
    seriously

kernel/power/snapshot.c:        if (PageReserved(page) ||
kernel/power/snapshot.c:        if (PageReserved(page)

-> There should be no change (saveable_page() would still allow saving
    them, highmem does not apply)

mm/hugetlb_vmemmap.c:           if (!PageReserved(head))
mm/hugetlb_vmemmap.c:   if (PageReserved(page))

-> Wants to identify bootmem, but we exclude these
    PageVmemmapSelfHosted() on the splitting part already properly


mm/page_alloc.c:                VM_WARN_ON_ONCE(PageReserved(p));
mm/page_alloc.c:                if (PageReserved(page))

-> pfn_range_valid_contig() would scan them, just like for ordinary
    vmemmap pages during hotplug. We'll simply fail isolating/migrating
    them similarly (like any unmovable allocations) later

mm/page_ext.c:          BUG_ON(PageReserved(page));

-> free_page_ext handling, does not apply

mm/page_isolation.c:            if (PageReserved(page))

-> has_unmovable_pages() should still detect them as unmovable (e.g.,
    neither movable nor LRU).

mm/page_owner.c:                        if (PageReserved(page))
mm/page_owner.c:                        if (PageReserved(page))

-> Simply page_ext_get() will return NULL instead and we'll similarly
    skip them

mm/sparse.c:            if (!PageReserved(virt_to_page(ms->usage))) {

-> Detecting boot memory for ms->usage allocation, does not apply to
    vmemmap.

virt/kvm/kvm_main.c:    if (!PageReserved(page))
virt/kvm/kvm_main.c:    return !PageReserved(page);

-> For MMIO remapping purposes, does not apply to vmemmap


> Moreover, boot memmap pages are marked as PageReserved, which would be
> now inconsistent with those added during hotplug operations.

Just like vmemmap pages allocated dynamically during memory hotplug. 
Now, really only bootmem-ones are PageReserved.

> All in all, I feel uneasy about this change.

I really don't want to mark these pages here PageReserved for the sake 
of it.

Any PageReserved user that I am missing, or why we should handle these 
vmemmap pages differently than the ones allocated during ordinary memory 
hotplug?

In the future, we might want to consider using a dedicated page type for 
them, so we can stop using a bit that doesn't allow to reliably identify 
them. (we should mark all vmemmap with that type then)

Thanks!

-- 
Cheers,

David / dhildenb

