Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C87C433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 10:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98AD54040D;
	Wed, 24 Nov 2021 10:00:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hTRCRsK0YRfI; Wed, 24 Nov 2021 10:00:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C278403BE;
	Wed, 24 Nov 2021 10:00:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2BC3C001E;
	Wed, 24 Nov 2021 10:00:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 460ECC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 10:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3265F4037F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 10:00:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WTM29eU8BbK8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 10:00:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD702401F9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 10:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637748013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rarS66trAhJYbUtF3ni55b+eqwkvEx/XHG+aahK8Fxo=;
 b=avsES46GduBSbk4rwK0lLVZJz31TfkgbHgj8FEKXqF9aY7bZfyYx9+xIHpFuEmWoAH8bjK
 y7KHWyjHxqxMWpkUlpAtc20PqNVj/0ap5iO2b7xkm00/ka3/f8LLnKCLXcBfkWi19ukk7h
 QyIdHd+6NuR/+k3dYJ3x81oC7nfOuUY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-T4Ph-uFTPIudlROcOw_B3A-1; Wed, 24 Nov 2021 05:00:10 -0500
X-MC-Unique: T4Ph-uFTPIudlROcOw_B3A-1
Received: by mail-wm1-f70.google.com with SMTP id
 j193-20020a1c23ca000000b003306ae8bfb7so1053441wmj.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 02:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=rarS66trAhJYbUtF3ni55b+eqwkvEx/XHG+aahK8Fxo=;
 b=AT38RTZYGri7RNJ+FXMDe3qGGRSL0H7l3BNJ/0kNF9TkCg3OkjWwxGZYVR3EvBMcA1
 UYDPS/Y2rhBKVt8q3EMu+RibTVe9GoDVQqOHG1nw6OOj0tuC89emjDWl98cvVMFSWupn
 BY0QY1sf3EMAyj8Sl0+1tFLCy1XRSNf1lsyF0uZoEHiP/Et88NNyN8qT58giDknuxqGm
 QGQlC66sMX12d1kg3QxMv5RVdj0QtjjZRWSL/jxLo/WU4obCeifPhxQMGDtpq8daRv4B
 TCyrtQL5tVWEUGoW2pTGK02mOhzS3NcKclB8s93ztEwV917Tbmqc2IKpr2G7clEOYrGa
 60tQ==
X-Gm-Message-State: AOAM531W4ap5dxDz5hl6KsFkEQvxmjNlpv0N7eLTeIpFMjVxCkOia7IN
 vYFnE48TYy7ijon45DPCIWK7fsRdn0t3QFzUPrE9DlG88X7OFP2Y0PDOtUagPJiUt+UiDP4r6JV
 YeX5BxX2QJ+cbkd64RqjptEh3rnXo9eivUoRcBoTfyA==
X-Received: by 2002:a5d:5445:: with SMTP id w5mr16326303wrv.163.1637748009021; 
 Wed, 24 Nov 2021 02:00:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUIqKIABuwPQdf06Xa8xhD+Wt4DFTeviikI+tA1Znedm5s6tH3fnojeRa8Vcrz3QlEg4mSSA==
X-Received: by 2002:a5d:5445:: with SMTP id w5mr16326258wrv.163.1637748008719; 
 Wed, 24 Nov 2021 02:00:08 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6380.dip0.t-ipconnect.de. [91.12.99.128])
 by smtp.gmail.com with ESMTPSA id
 l15sm3955399wme.47.2021.11.24.02.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Nov 2021 02:00:08 -0800 (PST)
Message-ID: <119c6cac-22bf-de74-9f8d-3b383eeb8640@redhat.com>
Date: Wed, 24 Nov 2021 11:00:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
To: "Michael S. Tsirkin" <mst@redhat.com>,
 David Stevens <stevensd@chromium.org>
References: <20211118091130.3817665-1-stevensd@google.com>
 <290e140c-abc1-76b8-e036-5b550b8b99c4@redhat.com>
 <CAD=HUj7i7foyPE8a6dhj+=UR2jn5_vaQx-3jjKtjYrY8iSJWzw@mail.gmail.com>
 <3ecd8132-ad5c-0a37-7334-d58ccc58a495@redhat.com>
 <eec5cc46-ec6d-e997-c8f1-9a7d3c57468c@redhat.com>
 <CAD=HUj5wPYLKJxsjgcnMu_NYQ6eMwmd-VDU0gbWbqgzOPkV6fg@mail.gmail.com>
 <20211124032622-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] virtio_balloon: add param to skip adjusting pages
In-Reply-To: <20211124032622-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

>>>> I'd appreciate a more generic approach for user space to figure out the
>>>> "initial memory size" in a virtualized environment than adding
>>>> some module parameter to virtio-balloon -- if that makes sense.
>>>>
>>>> MemTotal as is expresses how much memory the buddy currently manages,
>>>> for example, excluding early allocations during boot, excluding actually
>>>> unplugged memory and excluding logically unplugged memory. Adjusting that
>>>> value makes perfect sense for virtio-balloon without deflate-on-oom.
>>>>
>>
>> That's a definition of how MemTotal is implemented, but it's not
>> really a specification of the MemTotal API. The closest thing to a
>> real specification I can find is "Total usable RAM (i.e., physical RAM
>> minus a few reserved bits and the kernel binary code)", from the proc
>> man pages. I think there is quite a bit of leeway in changing how
>> exactly MemTotal is implemented without violating the (quite vague)
>> specification or changing any observable semantics of the API. In
>> particular, leaving the pages in the balloon as part of MemTotal is
>> essentially indistinguishable from simply having a non-OOM killable
>> process locking an equivalent amount of memory. So this proposal isn't
>> really introducing any fundamentally new behavior to the Linux kernel.

How to indicate MemTotal completely depends on the intended semantics.
Using balloon inflation to logically unplug memory vs. some kind of
co-operational memory management with the hypervisor.

For co-operational management I would strongly advise using free page
reporting instead if possible. It can't drain the pagecache so far, but
there are approaches being discussed on how to make that happen (e.g.,
using DAMON, or avoiding the guest page cache using virtio-pmem).

>>
>>>>> It's also not clear to me what utility the extra information would
>>>>> provide to userspace. If userspace wants to know how much memory is
>>>>> available, they should use MemAvailable. If userspace wants to have a
>>>>> rough estimate for the maximum amount of memory in the system, they
>>>>> would add together MemTotal and "logically offline pages". The value
>>>>> of MemTotal with a no-deflate-on-oom virtio-balloon is a value with a
>>>>> vague meaning that lies somewhere between the "maximum amount of
>>>>> memory" and the "current amount of memory". I don't really see any
>>>>> situations where it should clearly be used over one of MemAvailable or
>>>>> MemTotal + "logically offline pages".
>>>>
>>>> The issue is that any application that relies on MemTotal in a virtualized
>>>> environment is most probably already suboptimal in some cases. You can
>>>> rely on it and actually later someone will unplug (inflate balloon)
>>>> memory or plug (deflate balloon) memory. Even MemAvailable is suboptimal
>>>> because what about two applications that rely on that information at
>>>> the same time?
>>>>
>>>
>>> BTW, the general issue here is that "we don't know what the hypervisor
>>> will do".
>>
>> I do agree that this is a significant problem. I would expand on it a
>> bit more, to be "since we don't know what the hypervisor will do, we
>> don't know how to treat memory in the balloon". The proposed module
>> parameter is more or less a mechanism to allow the system
>> administrator to tell the virtio_balloon driver how the hypervisor
>> behaves.
> 
> 
> Now that you put it that way, it looks more like this should
> be a feature bit not a module parameter.

It will be slightly better. At least the hypervisor can indicate the
what it's intending on doing.

>> And if the hypervisor will give memory back to the guest when
>> the guest needs it, then I don't think it's not necessary to logically
>> unplug the memory.
> 
> Ideally we would also pair this with sending a signal to device
> that memory is needed.

Such approaches are in general problematic because once the guest is
already OOM, the hypervisor will most likely not react in time and it's
essentially too late.

So you need some policy somewhere that monitors memory consumption and
makes smart decisions. Usually this is implemented in the hypervisor by
monitoring VM stats.

IMHO the device is the wrong place. I recently discussed something
similar offline with potential virtio-mem users.

> 
>> It might be a bit cleaner to explicitly address this in the
>> virtio_balloon protocol. We could add a min_num_pages field to the
>> balloon config, with semantics along the lines of "The host will
>> respond to memory pressure in the guest by deflating the balloon down
>> to min_num_pages, unless it would cause system instability in the
>> host". Given that feature, I think it would be reasonable to only
>> consider min_num_pages as logically unplugged.
> 
> Okay. I think I would do it a bit differently though, make num_pages be
> the min_num_pages, and add an extra_num_pages field for memory that is
> nice to have but ok to drop.
> 
> 
> As long as we are here, can we add a page_shift field please
> so more than 2^44 bytes can be requested?
> 
> 
>>> Maybe "MemMax" actually could make sense, where we expose the maximum
>>> "MemTotal" we had so far since we were up an running. So the semantics
>>> wouldn't be "maximum possible", because we don't know that, but instead
>>> "maximum we had".
>>
>> Rather than add a new API, I think it is much better to make existing
>> APIs behave closer to how they behave in a non-virtualized
>> environment. It is true that we could go through and fix a limited
>> number of special user space applications, but sysconf(_SC_PHYS_PAGES)
>> and /proc/meminfo are not special APIs. Fixing every application that
>> uses them is not feasible, especially when taking into account systems
>> with closed-source applications (e.g. Android). Also, while MemMax is
>> well defined, it has the same issues you brought up earlier -
>> specifically, applications don't know whether the hypervisor will
>> actually ever provide MemMax again, and they don't know whether MemMax
>> is actually the realy maximum amount of memory that could be available
>> in the future. It's not clear to me that it's significantly better or
>> more useful to userspace than simply changing how MemTotal is
>> implemented.
>>
>> -David
> 
> Agree on trying to avoid changing applications, limiting changes
> to device and guest kernel, this has a lot of value.

With free page reporting in place I barely see a future for such
features, but these are just my 2 cents.

Gluing it to a feature bit like "I, the device, will monitor your memory
consumption and adjust if you're in need of more memory" could be done.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
