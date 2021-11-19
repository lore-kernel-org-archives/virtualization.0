Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6E8C433F5
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 13:53:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456FF61247
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 13:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 456FF61247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01EBD61C03;
	Fri, 19 Nov 2021 13:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MqOtOsSI0NI0; Fri, 19 Nov 2021 13:53:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 57FE561BF0;
	Fri, 19 Nov 2021 13:53:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D6D8C002E;
	Fri, 19 Nov 2021 13:53:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB6CAC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 13:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD86681B01
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 13:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fdX6eVF75QR9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 13:53:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C2E381AF6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637329992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3+6kH4StMkEoq1XpPJCF03DaBu92Bct8Eayd8/ogV0=;
 b=WgBxsET7JzM+ArpbATgTSCfXLY/YIAzMtlnKNZdYGjjXbVU99nNKw0n3Vwz329Zo6Ozytb
 5VswkFFpXk+U3njiwu3p7LUCDmus03ks8uUX5wMPIQa4vzx/J5iJvbj+Iw88yVMAv7p+6U
 4u0MTzZy9wBJS4PrgfaCwr/qQAbpbsg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-HOJMwdYqONKJawthxKs60A-1; Fri, 19 Nov 2021 08:53:11 -0500
X-MC-Unique: HOJMwdYqONKJawthxKs60A-1
Received: by mail-wm1-f70.google.com with SMTP id
 187-20020a1c02c4000000b003335872db8dso3605167wmc.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 05:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:organization:in-reply-to
 :content-transfer-encoding;
 bh=G3+6kH4StMkEoq1XpPJCF03DaBu92Bct8Eayd8/ogV0=;
 b=Ggmz17a9ARLgUg29JwuT2KNyzO8i5/yZxY5svI7QJNj81r4d3vg4zMLCuWCZLqfUzQ
 tOPCraAeI0Iuhkkip1vkVL4VLy/gsWT9BcpZT7fAcKir+fwECGcH8D++UDdRM67V4Mcd
 Noqx1I3vWaOFwfUcIQMNvq5sTQFhjujR26EwHY0nsPYZM2uYVuhvXxJSwdcEP48eSXd+
 fVuNxmz9oUU+HRfLA7Xsf4KXSP4lacswy6pvlmf5eKs36r9O0pmytRRRgM2g1AeV2VO5
 XkaWi2gXWzVuttnB7DwswTw42V5RiqEwta1qE4mD2srQrkZCRaFZ8SFbsJp4y6tQomOu
 pjwQ==
X-Gm-Message-State: AOAM530VsFGV2RL+Vt06158vjp6Bohal/CanzASQSCRic7+ciE2RtSy+
 11RntnMhMWHQvqu9GtOUp6czq2OyBSWGK/8uXWL87FinDodGtfDl/6akkJkLxqNoj4EOtuKeVjN
 LHzX3qjg2gkkcYO/thVptOis902Fq0m5ydHNW6cRDKw==
X-Received: by 2002:a1c:7dce:: with SMTP id y197mr6948987wmc.155.1637329990046; 
 Fri, 19 Nov 2021 05:53:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmI5S6SM+4NsdufE8cZTETbg73qqYUmEneMJ0Yj+kH76MCSmBm6fJh3c02xRxGcgAPjiNF2A==
X-Received: by 2002:a1c:7dce:: with SMTP id y197mr6948910wmc.155.1637329989637; 
 Fri, 19 Nov 2021 05:53:09 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6271.dip0.t-ipconnect.de. [91.12.98.113])
 by smtp.gmail.com with ESMTPSA id
 p2sm13798147wmq.23.2021.11.19.05.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Nov 2021 05:53:09 -0800 (PST)
Message-ID: <eec5cc46-ec6d-e997-c8f1-9a7d3c57468c@redhat.com>
Date: Fri, 19 Nov 2021 14:53:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] virtio_balloon: add param to skip adjusting pages
From: David Hildenbrand <david@redhat.com>
To: David Stevens <stevensd@chromium.org>
References: <20211118091130.3817665-1-stevensd@google.com>
 <290e140c-abc1-76b8-e036-5b550b8b99c4@redhat.com>
 <CAD=HUj7i7foyPE8a6dhj+=UR2jn5_vaQx-3jjKtjYrY8iSJWzw@mail.gmail.com>
 <3ecd8132-ad5c-0a37-7334-d58ccc58a495@redhat.com>
Organization: Red Hat
In-Reply-To: <3ecd8132-ad5c-0a37-7334-d58ccc58a495@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 19.11.21 14:36, David Hildenbrand wrote:
> On 19.11.21 08:22, David Stevens wrote:
>> On Thu, Nov 18, 2021 at 8:17 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 18.11.21 10:11, David Stevens wrote:
>>>> From: David Stevens <stevensd@chromium.org>
>>>
>>> Hi David,
>>>
>>>>
>>>> Add a module parameters to virtio_balloon to allow specifying whether or
>>>> not the driver should call adjust_managed_page_count. If the parameter
>>>> is set, it overrides the default behavior inferred from the deflate on
>>>> OOM flag. This allows the balloon to operate without changing the amount
>>>> of memory visible to userspace via /proc/meminfo or sysinfo, even on a
>>>> system that cannot set the default on OOM flag.
>>>>
>>>> The motivation for this patch is to allow userspace to more accurately
>>>> take advantage of virtio_balloon's cooperative memory control on a
>>>> system without the ability to use deflate on OOM. As it stands,
>>>> userspace has no way to know how much memory may be available on such a
>>>> system, which makes tasks such as sizing caches impossible.
>>>
>>> But that user space also has no idea "when" that memory will become
>>> available, it could be never.
>>
>> Isn't this statement always true with respect to
>> MemTotal/sysinfo.totalram? The kernel allocates and reserves memory,
>> so there will always be some amount of memory that will never be
>> available to userspace.
> 
> Please note that early allocation, most importantly the memmap,
> are not accounted to MemTotal. This memory is similarly not managed
> by the buddy. (thus the name adjust_managed_page_count())
> 
> But yes, there will always be some memory that will be accounted to
> MemTotal that can never get freed. With memory ballooning it can easily
> be in the range of gigabytes.
> 
>> And if you look at things from the context of
>> a specific userspace process, there will be other processes running
>> and using memory. So while that statement is true with respect to this
>> change, that is also true without this change. The specific details
>> might be changed by the proposed parameter, but it wouldn't be
>> introducing any fundamentally new behavior to Linux.
>>
> 
> Please note that the hyper-v balloon just recently switched to using
> adjust_managed_page_count() proper accounting reasons:
> 
> commit d1df458cbfdb0c3384c03c7fbcb1689bc02a746c
> Author: Vitaly Kuznetsov <vkuznets@redhat.com>
> Date:   Wed Dec 2 17:12:45 2020 +0100
> 
>     hv_balloon: do adjust_managed_page_count() when ballooning/un-ballooning
>     
>     Unlike virtio_balloon/virtio_mem/xen balloon drivers, Hyper-V balloon driver
>     does not adjust managed pages count when ballooning/un-ballooning and this leads
>     to incorrect stats being reported, e.g. unexpected 'free' output.
>     
>     Note, the calculation in post_status() seems to remain correct: ballooned out
>     pages are never 'available' and we manually add dm->num_pages_ballooned to
>     'commited'.
> 
> 
>>> This problem is similar to memory hotplug,
>>> where we don't know "when" more memory might get hotplugged.
>>
>> There are some meaningful differences with respect to hotplug. First,
>> with the balloon, the kernel knows exactly what the maximum amount of
>> memory the guest could have is.
> 
> Not quite. There are hypervisors that add more memory using
> DIMMs (and as far as I heard virtio-mem) when required but
> always fake-unplug memory using virtio-balloon.
> 
>> Since the VM was created with that
>> specific amount of memory, assuming that the host will be able to
>> provide that amount of memory to the guest if the guest needs it is a
>> relatively safe assumption (and if the system administrator doesn't
>> want to make that assumption, they can skip using this parameter). On
>> the other hand, with hotplug, the only maximum value the kernel has is
>> the theoretical limit allowed by the hardware. That is clearly a
>> different sort of limit, and of markedly less value.
> 
> So what you actually want to expose to user space is the initial VM size.
> We cannot reliably say what the maximum in the future will be
> (memory hotplug), it can even be lower than the initial VM size. So it's
> a pure heuristic after all.
> 
>>
>> Second, there's also the difference as to the nature of the event. If
>> someone went through the trouble to configure a VM to use the
>> virtio_balloon, then I think it's fair to say that inflating/deflating
>> the balloon is a 'normal' event that can happen with some regularity.
> 
> I disagree. Libvirt adds virtio-balloon as default to each and every VM.
> Some people use virtiio-balloon to logically unplug memory, to eventually
> never hotplug it again.
> 
>> On the other hand, I don't think anyone would say that hotplug of
>> physical memory is a normal event.
> 
> Well, I would say that :) The hyper-v balloon is a good example, and the
> xen balloon also hotplugs actual memory on demand. And it's
> becoming more popular in the virtio world with virtio-mem as well
> (which some cloud providers already support).
> 
>>
>>> With deflate-on-OOM this behavior makes sense, because the guest can use
>>> that memory whenever it wants -- it's actually available as soon as we
>>> need it.
>>
>> Well, by some definition of 'need'. It's available as soon as the
>> kernel is about to OOM some process. By that point, we've probably
>> already evicted a lot of caches, and the end user is going to be
>> having a bad time. If we get to this point, given how poorly Linux
>> usually behaves under low memory conditions, I think it is not an
>> unreasonable viewpoint to prefer to OOM kill something, rather than to
>> pull a paltry 1MB out of the balloon, at least on systems that are
>> relatively resilient to OOMs.
> 
> Don't get me wrong, I am absolutely not a fan of deflate-on-oom. I think
> it was a mistake, but apparently, there are some actual users.
> 
>>
>>>>
>>>> When deflate on OOM is not enabled, the current behavior of the
>>>> virtio_balloon more or less resembles hotplugging individual pages, at
>>>> least from an accounting perspective. This is basically hardcoding the
>>>> requirement that totalram_pages must be available to the guest
>>>> immediately, regardless of what the host does. While that is a valid
>>>> policy, on Linux (which supports memory overcommit) with virtio_balloon
>>>> (which is designed to facilitate overcommit in the host), it is not the
>>>> only possible policy.
>>>>
>>>> The param added by this patch allows the guest to operate under the
>>>> assumption that pages in the virtio_balloon will generally be made
>>>> available when needed. This assumption may not always hold, but when it
>>>> is violated, the guest will just fall back to the normal mechanisms for
>>>> dealing with overcommitted memory.
>>>>
>>>> Independent of what policy the guest wants, the virtio_balloon device
>>>> does not consider pages in the balloon as contributing to the guest's
>>>> total amount of memory if deflate on OOM is not enabled. Ensure that the
>>>> reported stats are consistent with this by adjusting totalram if a
>>>> guest without deflate on OOM is skipping the calls to
>>>> adjust_managed_page_count.
>>>
>>> What about simply exposing the number of inflated balloon pages
>>> ("logically offline pages") e.g., via /proc/meminfo to user space? It's
>>> then up to smart user space trying to be smart about memory that's not
>>> available right now and might never become available eventually in the
>>> future -- but still that user space wants to optimize for some eventuality.
>>
>> That approach would require a lot of changes to userspace - probably
>> nearly everywhere that uses _SC_PHYS_PAGES or get_phys_pages, or
>> anywhere that parses /proc/meminfo. Actually properly using "logically
>> offline pages" would require an additional API for monitoring changes
>> to the value, and updating to that sort of listener API would not be a
>> localized change, especially since most programs do not account for
>> memory hotplug and just use the amount of physical memory during
>> initialization. Realistically, nearly all of the callers would simply
>> add together "logically offline pages" and MemTotal.
> 
> I'd appreciate a more generic approach for user space to figure out the
> "initial memory size" in a virtualized environment than adding
> some module parameter to virtio-balloon -- if that makes sense.
> 
> MemTotal as is expresses how much memory the buddy currently manages,
> for example, excluding early allocations during boot, excluding actually
> unplugged memory and excluding logically unplugged memory. Adjusting that
> value makes perfect sense for virtio-balloon without deflate-on-oom.
> 
> Instead of changing MemTotal semantics, I'd say we introduce some other
> mechanism to figure out the initial VM size -- "logically offline" memory
> is just an example. "MemMax" might be misleading and easily wrong.
> "MemInitial" might be an feasible option.
> 
> Yes, some special user space applications would have to be adjusted.
> 
>>
>> It's also not clear to me what utility the extra information would
>> provide to userspace. If userspace wants to know how much memory is
>> available, they should use MemAvailable. If userspace wants to have a
>> rough estimate for the maximum amount of memory in the system, they
>> would add together MemTotal and "logically offline pages". The value
>> of MemTotal with a no-deflate-on-oom virtio-balloon is a value with a
>> vague meaning that lies somewhere between the "maximum amount of
>> memory" and the "current amount of memory". I don't really see any
>> situations where it should clearly be used over one of MemAvailable or
>> MemTotal + "logically offline pages".
> 
> The issue is that any application that relies on MemTotal in a virtualized
> environment is most probably already suboptimal in some cases. You can
> rely on it and actually later someone will unplug (inflate balloon)
> memory or plug (deflate balloon) memory. Even MemAvailable is suboptimal
> because what about two applications that rely on that information at
> the same time?
> 

BTW, the general issue here is that "we don't know what the hypervisor
will do".

Maybe "MemMax" actually could make sense, where we expose the maximum
"MemTotal" we had so far since we were up an running. So the semantics
wouldn't be "maximum possible", because we don't know that, but instead
"maximum we had".

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
