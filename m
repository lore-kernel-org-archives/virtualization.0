Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFECFC433EF
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 13:36:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B9961AD0
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 13:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67B9961AD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E0DB401E9;
	Fri, 19 Nov 2021 13:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PqTuT0bpGPXl; Fri, 19 Nov 2021 13:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 02D3A40128;
	Fri, 19 Nov 2021 13:36:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C701CC002E;
	Fri, 19 Nov 2021 13:36:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FBB0C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 13:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20E80403DE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 13:36:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z7gBhD4hEMh9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 13:36:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D40324037D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637328995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppDOAp4QCE2oH7aSgsSgu1/csl6TSiKIhFgMrb8R4Ow=;
 b=HwhHGNLZlASjcpdBWMUkmHHuVsdPOE7pZqzk+oeGuGpI147Tz/uUzcBHlvjFzIcTk9TBML
 1eiUoc90RvSuSgIjkkSAaJPZbk/emqTDkJdsm/btoTpW/isCW6a9AZbc0bf10uw6Uc8p+a
 UT+r+46iaoZVNMnQ+h3liRwjdX3sKyI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-0IC8nBKUM1qTfQfLfw3MxQ-1; Fri, 19 Nov 2021 08:36:34 -0500
X-MC-Unique: 0IC8nBKUM1qTfQfLfw3MxQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 o10-20020a05600c4fca00b0033312e1ed8bso4748096wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 05:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=ppDOAp4QCE2oH7aSgsSgu1/csl6TSiKIhFgMrb8R4Ow=;
 b=RPpPHf1Aw6e9NqqIVgZ25TNT5D7Azd8lXZ0BrZWlVdJtMGEYVmFF5LqIGb9PgficHN
 KihFsCHSTWHMUAzt3aACcUn6MXTZgDX7D+K3oi3WXBHZU8jq6Xx4EtEzmpzVHq/tHAfm
 rDpllBC8x1Pwjdqvav3elmMHPu2emP7TS8/ijZQwv5roR6TKQSv6DNo4u3ZYsfp8geXc
 XicWYRK/hSPc/31MXog4grD3j5XLsp7IQCd+90eQLkvCArU9UI3yAu7HAycmcrZA0Mv1
 SMtGIpncBtYx3TLBIdNobdLL0Oeh+z5iu2H2qeurcP47Xb44p9BFV2FtTe1Fba7ut8Js
 IpJA==
X-Gm-Message-State: AOAM531AfLA8IAFDSEjhNbfh8POLYultaZiJtcXL9MRwfBerm0g9aGUf
 ALUqrVV/q9mpUD6qyrhemcIGMYtdzxflSe04jrroZ6X2ABC5UUXmtevhhRrZPIKdFOeygVhHJek
 ACDFMgHe9gSeCVzC2slHx7Zy6NAgJIxSlexLxrGTtcg==
X-Received: by 2002:a05:600c:1ca0:: with SMTP id
 k32mr7051681wms.74.1637328993165; 
 Fri, 19 Nov 2021 05:36:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrPI2ZUddZkh/U75MgX7ppDOaGQB8RMEx01CYo+XsHEzWkRVqI9yKiFA+85n6oRp8gT/n/Mg==
X-Received: by 2002:a05:600c:1ca0:: with SMTP id
 k32mr7051636wms.74.1637328992848; 
 Fri, 19 Nov 2021 05:36:32 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6271.dip0.t-ipconnect.de. [91.12.98.113])
 by smtp.gmail.com with ESMTPSA id
 s24sm2817042wmj.26.2021.11.19.05.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Nov 2021 05:36:32 -0800 (PST)
Message-ID: <3ecd8132-ad5c-0a37-7334-d58ccc58a495@redhat.com>
Date: Fri, 19 Nov 2021 14:36:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
To: David Stevens <stevensd@chromium.org>
References: <20211118091130.3817665-1-stevensd@google.com>
 <290e140c-abc1-76b8-e036-5b550b8b99c4@redhat.com>
 <CAD=HUj7i7foyPE8a6dhj+=UR2jn5_vaQx-3jjKtjYrY8iSJWzw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] virtio_balloon: add param to skip adjusting pages
In-Reply-To: <CAD=HUj7i7foyPE8a6dhj+=UR2jn5_vaQx-3jjKtjYrY8iSJWzw@mail.gmail.com>
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

On 19.11.21 08:22, David Stevens wrote:
> On Thu, Nov 18, 2021 at 8:17 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 18.11.21 10:11, David Stevens wrote:
>>> From: David Stevens <stevensd@chromium.org>
>>
>> Hi David,
>>
>>>
>>> Add a module parameters to virtio_balloon to allow specifying whether or
>>> not the driver should call adjust_managed_page_count. If the parameter
>>> is set, it overrides the default behavior inferred from the deflate on
>>> OOM flag. This allows the balloon to operate without changing the amount
>>> of memory visible to userspace via /proc/meminfo or sysinfo, even on a
>>> system that cannot set the default on OOM flag.
>>>
>>> The motivation for this patch is to allow userspace to more accurately
>>> take advantage of virtio_balloon's cooperative memory control on a
>>> system without the ability to use deflate on OOM. As it stands,
>>> userspace has no way to know how much memory may be available on such a
>>> system, which makes tasks such as sizing caches impossible.
>>
>> But that user space also has no idea "when" that memory will become
>> available, it could be never.
> 
> Isn't this statement always true with respect to
> MemTotal/sysinfo.totalram? The kernel allocates and reserves memory,
> so there will always be some amount of memory that will never be
> available to userspace.

Please note that early allocation, most importantly the memmap,
are not accounted to MemTotal. This memory is similarly not managed
by the buddy. (thus the name adjust_managed_page_count())

But yes, there will always be some memory that will be accounted to
MemTotal that can never get freed. With memory ballooning it can easily
be in the range of gigabytes.

> And if you look at things from the context of
> a specific userspace process, there will be other processes running
> and using memory. So while that statement is true with respect to this
> change, that is also true without this change. The specific details
> might be changed by the proposed parameter, but it wouldn't be
> introducing any fundamentally new behavior to Linux.
> 

Please note that the hyper-v balloon just recently switched to using
adjust_managed_page_count() proper accounting reasons:

commit d1df458cbfdb0c3384c03c7fbcb1689bc02a746c
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Wed Dec 2 17:12:45 2020 +0100

    hv_balloon: do adjust_managed_page_count() when ballooning/un-ballooning
    
    Unlike virtio_balloon/virtio_mem/xen balloon drivers, Hyper-V balloon driver
    does not adjust managed pages count when ballooning/un-ballooning and this leads
    to incorrect stats being reported, e.g. unexpected 'free' output.
    
    Note, the calculation in post_status() seems to remain correct: ballooned out
    pages are never 'available' and we manually add dm->num_pages_ballooned to
    'commited'.


>> This problem is similar to memory hotplug,
>> where we don't know "when" more memory might get hotplugged.
> 
> There are some meaningful differences with respect to hotplug. First,
> with the balloon, the kernel knows exactly what the maximum amount of
> memory the guest could have is.

Not quite. There are hypervisors that add more memory using
DIMMs (and as far as I heard virtio-mem) when required but
always fake-unplug memory using virtio-balloon.

> Since the VM was created with that
> specific amount of memory, assuming that the host will be able to
> provide that amount of memory to the guest if the guest needs it is a
> relatively safe assumption (and if the system administrator doesn't
> want to make that assumption, they can skip using this parameter). On
> the other hand, with hotplug, the only maximum value the kernel has is
> the theoretical limit allowed by the hardware. That is clearly a
> different sort of limit, and of markedly less value.

So what you actually want to expose to user space is the initial VM size.
We cannot reliably say what the maximum in the future will be
(memory hotplug), it can even be lower than the initial VM size. So it's
a pure heuristic after all.

> 
> Second, there's also the difference as to the nature of the event. If
> someone went through the trouble to configure a VM to use the
> virtio_balloon, then I think it's fair to say that inflating/deflating
> the balloon is a 'normal' event that can happen with some regularity.

I disagree. Libvirt adds virtio-balloon as default to each and every VM.
Some people use virtiio-balloon to logically unplug memory, to eventually
never hotplug it again.

> On the other hand, I don't think anyone would say that hotplug of
> physical memory is a normal event.

Well, I would say that :) The hyper-v balloon is a good example, and the
xen balloon also hotplugs actual memory on demand. And it's
becoming more popular in the virtio world with virtio-mem as well
(which some cloud providers already support).

> 
>> With deflate-on-OOM this behavior makes sense, because the guest can use
>> that memory whenever it wants -- it's actually available as soon as we
>> need it.
> 
> Well, by some definition of 'need'. It's available as soon as the
> kernel is about to OOM some process. By that point, we've probably
> already evicted a lot of caches, and the end user is going to be
> having a bad time. If we get to this point, given how poorly Linux
> usually behaves under low memory conditions, I think it is not an
> unreasonable viewpoint to prefer to OOM kill something, rather than to
> pull a paltry 1MB out of the balloon, at least on systems that are
> relatively resilient to OOMs.

Don't get me wrong, I am absolutely not a fan of deflate-on-oom. I think
it was a mistake, but apparently, there are some actual users.

> 
>>>
>>> When deflate on OOM is not enabled, the current behavior of the
>>> virtio_balloon more or less resembles hotplugging individual pages, at
>>> least from an accounting perspective. This is basically hardcoding the
>>> requirement that totalram_pages must be available to the guest
>>> immediately, regardless of what the host does. While that is a valid
>>> policy, on Linux (which supports memory overcommit) with virtio_balloon
>>> (which is designed to facilitate overcommit in the host), it is not the
>>> only possible policy.
>>>
>>> The param added by this patch allows the guest to operate under the
>>> assumption that pages in the virtio_balloon will generally be made
>>> available when needed. This assumption may not always hold, but when it
>>> is violated, the guest will just fall back to the normal mechanisms for
>>> dealing with overcommitted memory.
>>>
>>> Independent of what policy the guest wants, the virtio_balloon device
>>> does not consider pages in the balloon as contributing to the guest's
>>> total amount of memory if deflate on OOM is not enabled. Ensure that the
>>> reported stats are consistent with this by adjusting totalram if a
>>> guest without deflate on OOM is skipping the calls to
>>> adjust_managed_page_count.
>>
>> What about simply exposing the number of inflated balloon pages
>> ("logically offline pages") e.g., via /proc/meminfo to user space? It's
>> then up to smart user space trying to be smart about memory that's not
>> available right now and might never become available eventually in the
>> future -- but still that user space wants to optimize for some eventuality.
> 
> That approach would require a lot of changes to userspace - probably
> nearly everywhere that uses _SC_PHYS_PAGES or get_phys_pages, or
> anywhere that parses /proc/meminfo. Actually properly using "logically
> offline pages" would require an additional API for monitoring changes
> to the value, and updating to that sort of listener API would not be a
> localized change, especially since most programs do not account for
> memory hotplug and just use the amount of physical memory during
> initialization. Realistically, nearly all of the callers would simply
> add together "logically offline pages" and MemTotal.

I'd appreciate a more generic approach for user space to figure out the
"initial memory size" in a virtualized environment than adding
some module parameter to virtio-balloon -- if that makes sense.

MemTotal as is expresses how much memory the buddy currently manages,
for example, excluding early allocations during boot, excluding actually
unplugged memory and excluding logically unplugged memory. Adjusting that
value makes perfect sense for virtio-balloon without deflate-on-oom.

Instead of changing MemTotal semantics, I'd say we introduce some other
mechanism to figure out the initial VM size -- "logically offline" memory
is just an example. "MemMax" might be misleading and easily wrong.
"MemInitial" might be an feasible option.

Yes, some special user space applications would have to be adjusted.

> 
> It's also not clear to me what utility the extra information would
> provide to userspace. If userspace wants to know how much memory is
> available, they should use MemAvailable. If userspace wants to have a
> rough estimate for the maximum amount of memory in the system, they
> would add together MemTotal and "logically offline pages". The value
> of MemTotal with a no-deflate-on-oom virtio-balloon is a value with a
> vague meaning that lies somewhere between the "maximum amount of
> memory" and the "current amount of memory". I don't really see any
> situations where it should clearly be used over one of MemAvailable or
> MemTotal + "logically offline pages".

The issue is that any application that relies on MemTotal in a virtualized
environment is most probably already suboptimal in some cases. You can
rely on it and actually later someone will unplug (inflate balloon)
memory or plug (deflate balloon) memory. Even MemAvailable is suboptimal
because what about two applications that rely on that information at
the same time?

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
