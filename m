Return-Path: <SRS0=Jt+z=NQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20242C4338F
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 17:27:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F58B610CD
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 17:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F58B610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B6AC82451;
	Wed, 25 Aug 2021 17:27:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tyJsIYaldhpN; Wed, 25 Aug 2021 17:27:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E89828242D;
	Wed, 25 Aug 2021 17:27:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC86AC001A;
	Wed, 25 Aug 2021 17:27:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DDBFC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 17:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC31D4038F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 17:27:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cZkNMoLQVxKU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 17:27:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A364240105
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629912446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXaz0tPc7fZtJBb/dPevEF5ap0GWQE6Dpk8ZPpRNA/I=;
 b=IrEbMsopa9LMsIDFD9g5dHpoWAJRqx5gwnZTPjwYSBFcHT8kqEi7TQrzyBFeNqGeadmlmf
 BDQWYEN1A2QKW9pMvqsIQdv0kJc7EqQYuAny7o/2qNFDqYMDK774ipjf5i0rD2ILB75UOJ
 a62PwY16vU9eBrLMlcaQbdaNZqpFBaU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-CCgF4q_HMrqrv5hfUrwhUQ-1; Wed, 25 Aug 2021 13:27:23 -0400
X-MC-Unique: CCgF4q_HMrqrv5hfUrwhUQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 v18-20020adfe2920000b029013bbfb19640so70515wri.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 10:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=AXaz0tPc7fZtJBb/dPevEF5ap0GWQE6Dpk8ZPpRNA/I=;
 b=NBgw8TCqk42leGoDHdg5SBdmbHpA1vL795OtEwrSh0N4/NKgLPpLp9ql2M3lIh8ZEA
 TlmES84Wo/l+Xn85qG/7+A7xAsJliSkpxcfYiPPY8Ke6zhTSDFkzYaRhV88XzwvoX+oK
 QPblR1kf0VdA1PWJUsmxlkXjkICD0uKyyjfQ4Jr6Zpa3/afiRxdreltUpDSuElO1+HjM
 BQOZAkge6jCmxXRImYFI6eFDscQ/LoOU/rtAGn56tGTnPcJhdzCJM8BrhYLKUZXbIcil
 s0k8oOw96QzZIxEg92lwaxe2YLCYD/j55mHtqHizpQBNWN+uXIzjnYQrSZad3SBTEfvQ
 uFIw==
X-Gm-Message-State: AOAM530Pv5d0AUtSOFFxsi87BtVR4/0Ytse6w1cDEu8EB2zFQLuGCi5G
 wcXJNVYntYCpZm+i+ci52YuvT806jLxWew+meVXHMzzBeXa/QAAjrQVOYtUmPwSSY/iUHZR+29F
 eGbyASzbvKMNOMpbD1VvXPUTekwIvodZIh4fGn9j++Q==
X-Received: by 2002:a05:6000:1375:: with SMTP id
 q21mr22001457wrz.41.1629912441873; 
 Wed, 25 Aug 2021 10:27:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzstO6fv4t/9anZzviPu7bKujAkZrZHhfA3pIWg39sTZMi/ePcEnlXG2Gdkj6lY2fgt85/EZQ==
X-Received: by 2002:a05:6000:1375:: with SMTP id
 q21mr22001426wrz.41.1629912441574; 
 Wed, 25 Aug 2021 10:27:21 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
 by smtp.gmail.com with ESMTPSA id r129sm260673wmr.7.2021.08.25.10.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Aug 2021 10:27:21 -0700 (PDT)
To: Dan Williams <dan.j.williams@intel.com>
References: <20210816142505.28359-1-david@redhat.com>
 <20210816142505.28359-2-david@redhat.com>
 <CAPcyv4jfPSanWFNopzShtGiMDjwRuaci2n6hF3FCxsm1cG-ydg@mail.gmail.com>
 <bece6d48-57a3-e7d3-9b26-7faccfbcc7a8@redhat.com>
 <CAPcyv4h9ikp3fSaAc132DV=zrG-OJJ9-6ct8KZ3XhMZ-jbAR=Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/3] /dev/mem: disallow access to explicitly excluded
 system RAM regions
Message-ID: <e1ac08b0-a8fe-2668-9233-db85b918d7d5@redhat.com>
Date: Wed, 25 Aug 2021 19:27:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h9ikp3fSaAc132DV=zrG-OJJ9-6ct8KZ3XhMZ-jbAR=Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
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

On 25.08.21 19:07, Dan Williams wrote:
> On Wed, Aug 25, 2021 at 12:23 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 25.08.21 02:58, Dan Williams wrote:
>>> On Mon, Aug 16, 2021 at 7:25 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> virtio-mem dynamically exposes memory inside a device memory region as
>>>> system RAM to Linux, coordinating with the hypervisor which parts are
>>>> actually "plugged" and consequently usable/accessible. On the one hand, the
>>>> virtio-mem driver adds/removes whole memory blocks, creating/removing busy
>>>> IORESOURCE_SYSTEM_RAM resources, on the other hand, it logically (un)plugs
>>>> memory inside added memory blocks, dynamically either exposing them to
>>>> the buddy or hiding them from the buddy and marking them PG_offline.
>>>>
>>>> virtio-mem wants to make sure that in a sane environment, nobody
>>>> "accidentially" accesses unplugged memory inside the device managed
>>>> region. After /proc/kcore has been sanitized and /dev/kmem has been
>>>> removed, /dev/mem is the remaining interface that still allows uncontrolled
>>>> access to the device-managed region of virtio-mem devices from user
>>>> space.
>>>>
>>>> There is no known sane use case for mapping virtio-mem device memory
>>>> via /dev/mem while virtio-mem driver concurrently (un)plugs memory inside
>>>> that region. So once the driver was loaded and detected the device
>>>> along the device-managed region, we just want to disallow any access via
>>>> /dev/mem to it.
>>>>
>>>> Let's add the basic infrastructure to exclude some physical memory
>>>> regions completely from /dev/mem access, on any architecture and under
>>>> any system configuration (independent of CONFIG_STRICT_DEVMEM and
>>>> independent of "iomem=").
>>>
>>> I'm certainly on team "/dev/mem considered harmful", but this approach
>>> feels awkward. It feels wrong for being non-committal about whether
>>> CONFIG_STRICT_DEVMEM is in wide enough use that the safety can be
>>> turned on all the time, and the configuration option dropped, or there
>>> are users clinging onto /dev/mem where they expect to be able to build
>>> a debug kernel to turn all of these restrictions off, even the
>>> virtio-mem ones. This splits the difference and says some /dev/mem
>>> accesses are always disallowed for "reasons", but I could say the same
>>> thing about pmem, there's no sane reason to allow /dev/mem which has
>>> no idea about the responsibilities of properly touching pmem to get
>>> access to it.
>>
>> For virtio-mem, there is no use case *and* access could be harmful; I
>> don't even want to allow if for debugging purposes. If you want to
>> inspect virtio-mem device memory content, use /proc/kcore, which
>> performs proper synchronized access checks. Modifying random virtio-mem
>> memory via /dev/mem in a debug kernel will not be possible: if you
>> really have to play with fire, use kdb or better don't load the
>> virtio-mem driver during boot, such that the kernel won't even be making
>> use of device memory.
>>
>> I don't want people disabling CONFIG_STRICT_DEVMEM, or booting with
>> "iomem=relaxed", and "accidentally" accessing any of virtio-mem memory
>> via /dev/mem, while it gets concurrently plugged/unplugged by the
>> virtio-mem driver. Not even for debugging purposes.
> 
> That sounds more an argument that all of the existing "kernel is using
> this region" cases should become mandatory exclusions. If unloading
> the driver removes the exclusion then that's precisely
> CONFIG_IO_STRICT_DEVMEM. Why is the virtio-mem driver more special
> than any other driver that expects this integrity guarantee?

Unloading the driver will only remove exclusion if the driver can be 
unloaded cleanly -- if there is no memory added to Linux. Similar to 
force-unbinding dax/kmem without offlining memory, the whole device 
range will remain excluded.

(unloading the driver is only even implemented because there is no way 
to not implement it; there is no sane use case for virtio-mem to do that)

There are 2 things that are relevant for virtio-mem memory in regards of 
this series:

1. Kernel is currently using it (added virtio-mem memory). Don't allow 
access. Pretty much like most other things we want to exclude, I agree.

2. Kernel is currently not using it (not yet added virtio-mem memory), 
or not using it right now any more (removed virtio-mem memory). In 
contrast to other devices (DIMM, PMEM, ...) there is no sane use case 
for this memory, because the VM must not use it (as defined in the 
virtio-spec).


I care about 2) a lot because I don't want people looking at 
/proc/iomem, figuring out that there is something to map. And by the 
time they try to map it via /dev/mem, virtio-mem emoved that memory, yet 
a /dev/mem mapping happened and we have invalid memory access.

Mapping /dev/mem and accidentally being able to read/write virtio-mem 
memory has to be forbidden in sane environments. Force unloading a 
driver or preventing it from loading just to touch virtio-mem memory via 
/dev/mem is not a sane environment, someone is explicitly is asking for 
trouble, which is fine.

> 
>> We disallow mapping to some other regions independent of
>> CONFIG_STRICT_DEVMEM already, so the idea to ignore CONFIG_STRICT_DEVMEM
>> is not completely new:
>>
>> "Note that with PAT support enabled, even in this case there are
>> restrictions on /dev/mem use due to the cache aliasing requirements."
>>
>> Maybe you even want to do something similar with PMEM now that there is
>> infrastructure for it and just avoid having to deal with revoking
>> /dev/mem mappings later.
> 
> That would be like blocking writes to /dev/sda just because a
> filesytem might later be mounted on it. If the /dev/mem access is not
> actively colliding with other kernel operations what business does the
> kernel have saying no?

That the spec defines that that memory must not be read/written, because 
there might not be any memory after all anymore backing the virtio-mem 
device, or there is and the hypervisor will flag you as "malicious" and 
eventually zap the VM. That's different to most physical devices I am 
aware of.

> 
> I'm pushing on this topic because I am also considering an exclusion
> on PCI configuration access to the "DOE mailbox" since it can disrupt
> the kernel's operation, at the same time, root can go change PCI BARs
> to nonsensical values whenever it wants which is also in the category
> of "has no use case && could be harmful".

Right.

> 
>> I think there are weird debugging/educational setups [1] that still
>> require CONFIG_STRICT_DEVMEM=n even with iomem=relaxed. Take a look at
>> lib/devmem_is_allowed.c:devmem_is_allowed(), it disallows any access to
>> (what's currently added as) System RAM. It might just do what people
>> want when dealing with system RAM that doesn't suddenly vanish , so I
>> don't ultimately see why we should remove CONFIG_STRICT_DEVMEM=n.
> 
> Yes, I wanted to tease out more of your rationale on where the line
> should be drawn, I think a mostly unfettered /dev/mem mode is here to
> stay.

I could most certainly be convinced to

a) Leave CONFIG_STRICT_DEVMEM=n untouched
b) Restrict what I propose to CONFIG_STRICT_DEVMEM=y.

I could even go ahead and require CONFIG_STRICT_DEVMEM for virtio-mem.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
