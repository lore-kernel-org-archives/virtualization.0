Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11262C25B4E
	for <virtualization@archiver.kernel.org>; Tue, 24 Jan 2023 15:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 839DE60AAE;
	Tue, 24 Jan 2023 15:20:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 839DE60AAE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iw4UWK5C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qq6_qOL7Ebv4; Tue, 24 Jan 2023 15:20:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BF24D60777;
	Tue, 24 Jan 2023 15:20:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF24D60777
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A622C0032;
	Tue, 24 Jan 2023 15:20:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03803C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 15:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D330F404BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 15:20:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D330F404BF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iw4UWK5C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JC1GR4KDvMTg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 15:20:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94FAA40C7C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94FAA40C7C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674573638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDb2U5bj4qLnGLbCg1xC9iOAx4lXLgAzJbxtIVGln6c=;
 b=iw4UWK5C5DmS2lxWbNcTnhujj4AduoyO57yrr2LvtrY3D3qbcxSFghBsJSIfjy1hL4t65e
 6gL63uNPsZV1IB6wf5Meq0SomStPJlR3ZTzCseqZ4Kg1JD6AqXP0jRqbarQjXoC9n0VIhU
 MdjfvgoLDkdyHphsEj9+mbxkAT4t17Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-5-71ZqAmNhNzOzHRIw7nEi2g-1; Tue, 24 Jan 2023 10:20:34 -0500
X-MC-Unique: 71ZqAmNhNzOzHRIw7nEi2g-1
Received: by mail-wr1-f72.google.com with SMTP id
 k11-20020adfe3cb000000b002be503e7f28so2396581wrm.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 07:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EDb2U5bj4qLnGLbCg1xC9iOAx4lXLgAzJbxtIVGln6c=;
 b=wjsq/ZfxzAfa/qmeR6SqQhL0tRQAjNEUN0d/l0/CTRcHbdxbx8QNAaqLj9E+GnVmAS
 Ci29DVyibC4ayycFqH10MN6GkDef+KKipdTRmBPV+J4hNpTqQmWwp1XThXxi3OmrjZgT
 aLYxG61BWLDykNObBwj8Z0/d/wlXqJ3afKAsxYG7vNAPi61P0viiKT0Vkx+8DQz5KMIz
 8oieFaCEbdN0i5rjEOAsozUyWEIgqPmWJERQNV1HYH5BiiRGSx39YM8o/e7mvqY/thQF
 +tcnoD2O3dTr7FcjpxQPt5BbwxBgp9aCo48fqvfBMV7W7OvxA2ToYS9htV4tGm4PFiui
 RY9Q==
X-Gm-Message-State: AFqh2krBViYOAXjBKonLcJwmCStPor2l5B/O5zeLBh2KSd1DxSZmcPUe
 wLMb/bcxEjhe5cKLkAdh98f66sBdBUOYGWuh06/lGQuGOzkW110R8gPTFqV9bfrjH+0+iYKHVAX
 Qx/PVSPc/hQd5cWk5mUgDN9sPWNLMOGd4A7d1wI7IHQ==
X-Received: by 2002:a05:600c:3412:b0:3d6:e790:c9a0 with SMTP id
 y18-20020a05600c341200b003d6e790c9a0mr29312388wmp.10.1674573633774; 
 Tue, 24 Jan 2023 07:20:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvTaxaYATaMQGSOLQgsxj0xqFj+ZcmGJtf/QfZ434oHCSFRqhTuzzUTnrOVqXVi5jH2mRZ+0Q==
X-Received: by 2002:a05:600c:3412:b0:3d6:e790:c9a0 with SMTP id
 y18-20020a05600c341200b003d6e790c9a0mr29312359wmp.10.1674573633416; 
 Tue, 24 Jan 2023 07:20:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9?
 (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de.
 [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
 by smtp.gmail.com with ESMTPSA id
 f31-20020a05600c491f00b003cfa81e2eb4sm2221227wmp.38.2023.01.24.07.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jan 2023 07:20:32 -0800 (PST)
Message-ID: <1bf30145-22a5-cc46-e583-25053460b105@redhat.com>
Date: Tue, 24 Jan 2023 16:20:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan
 <surenb@google.com>, Mike Rapoport <rppt@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Anshuman Khandual <anshuman.khandual@arm.com>, mark.rutland@arm.com,
 will@kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <072de3f4-6bd3-f9ce-024d-e469288fc46a@quicinc.com>
 <acd8d55c-8528-bb21-488e-e5999c3c4e4e@redhat.com>
 <2faf67fe-b1df-d110-6d57-67f284cd5584@quicinc.com>
 <de3f1fd1-bcec-c6e5-e57a-b06674144c3b@redhat.com>
 <c38fa123-7750-20de-ed0b-de3346bddc82@quicinc.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] memory pressure detection in VMs using PSI mechanism for
 dynamically inflating/deflating VM memory
In-Reply-To: <c38fa123-7750-20de-ed0b-de3346bddc82@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Sukadev Bhattiprolu \(QUIC\)" <quic_sukadev@quicinc.com>,
 "Srivatsa Vaddagiri \(QUIC\)" <quic_svaddagi@quicinc.com>,
 "Patrick Daly \(QUIC\)" <quic_pdaly@quicinc.com>,
 "Trilok Soni \(QUIC\)" <quic_tsoni@quicinc.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 24.01.23 00:04, Sudarshan Rajagopalan wrote:
[...]
>> One problematic thing is that adding memory to Linux by virtio-mem
>> eventually consumes memory (e.g., the memmap), especially when having
>> to to add a completely new memory block to Linux.
>>
> Yes we have thought about this issue as well where-in when system is
> heavily on memory pressure, it would require some memory for memmap
> metadata, and also few other places in memory hotplug that it would need
> to alloc_pages for hot-plugging in. I think this path in memory_hotplug
> may be fixed where it doesn't rely on allocating some small portion of
> memory for hotplugging. But, the purpose memory_hotplug itself wasn't
> for plugging memory on system being in memory pressure :).

Some small allocations might be classified as "urgent" and go to atomic 
reserves (e.g., resource tree node, memory device node). The big 
allocations (memmap, page-ext if enabled, eventually page tables for 
direct map when not mapping huge pages) are the problematic "memory 
consumers" I think.

> 
> 
>> So if you're already under severe memory pressure, these allocations
>> to bring up new memory can fail. The question is, if PSI can notify
>> "early" enough such that this barely happens in practice.
>>
>> There are some possible ways to mitigate:
>>
>> 1) Always keep spare memory blocks by virtio-mem added to Linux, that
>> B B  don't expose any memory yet. Memory from these block can be handed
>> B B  over to Linux without additional Linux allocations. Of course, they
>> B B  consume metadata, so one might want to limit them.
>>
>> 2) Implement memmap_on_memory support for virtio-mem. This might help in
>> B B  some setups, where the device block size is suitable.
>>
>> Did you run into that scenario already during your experiments, and
>> how did you deal with that?
>>
> We are exactly implementing 2) you had mentioned i.e. enabling
> memmap_on_memory support for virtio-mem. This always guarantees that
> free memory is always present for memmap metadata while hotplugging. But
> this required us to increase memory block size to 256MB (from 128MB) for
> alignment requirement of memory hotplug to enable memory_on_memmap, for
> 4K page size configuration. Option 1) you mentioned also seems

The memmap of 128 MiB is 2 MiB. Assuming the pageblock size is 2 MiB, 
and virtio-mem supports a device block size of 2 MiB, it should "in 
theory" also work with 128 MiB memory blocks.

So I'd be curious why the change to 256 MiB was required. Maybe, that 
kernel config ends up with a pageblock size of 4 MiB (IIRC that can 
happen without CONFIG_HUGETLB -- which we should most probbaly change to 
also be PMD_ORDER due to THP).

> interesting - its good to have some spare memory in hand when system is
> heavily in memory pressure so that this memory can be handed over
> immediately on PSI pressure and doesn't have to wait for memory plug-in
> request roundtrip from Primary VM.

The idea was that you'd still do the roundtrip to request plugging of 
device memory blocks, but that you could immediately expose memory to 
the system (without requiring allocations), to eventually immediately 
prepare the next Linux memory block while "fresh" memory is available.

This way you could handle most allocations that happen when adding a 
Linux memory block.

The main idea was to always have at least one spare one lying around. 
And as soon as you start exposing memory from one of them to the page 
allocator, immediately prepare the next one.

> 
> Do you think having memmap_on_memory support for virtio-mem is useful to
> have? If so, we can send the patch that supports this in virtio-mem?
> 

I think yes. However, last time I though about adding support, I 
realized that there are some ugly corner cases to handle cleanly.

You have to make sure that the device memory blocks to-be-used as memmap 
are "plugged" even before calling add_memory_driver_managed(). And you 
can only "unplug" these device memory blocks after the memory block was 
removed via offline_and_remove_memory().

So the whole order of events and management of plugged device blocks 
changes quite a bit ...

... and what to do if the device block size is, say 4MiB, but the memmap 
is 2 MiB? Of course, one could simply skip the optimization then.

Having that said, if you managed to get it running and it's not too 
ugly, please share.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
