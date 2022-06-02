Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AB6C43334
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 09:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1E1582EF0;
	Thu,  2 Jun 2022 09:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lSNT6Pf8QXof; Thu,  2 Jun 2022 09:40:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 092FD82EAD;
	Thu,  2 Jun 2022 09:40:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1905C0032;
	Thu,  2 Jun 2022 09:40:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CC06C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63FC960EF7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:40:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxDplPMhZTNH
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:40:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6DD1660EE7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654162822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52LjxcDCDPkycB4f7TfSZD4ZH4TRdf/5KkEsxrmPS+E=;
 b=J06owR+A0CISQyNw/9Jx6rM7WLd5H58UuGE8fPS67OV04g+qRFD/qmYk+RygmXZEF7LR6d
 6xFHs3HnXdqs1Pb0S+VFahuzETADbsHZqKqjrUR0Orwv35IVV7L68ziqQI3bFs77i0+zbp
 0ThY9AgQTpjg08kc8yWQTtpWcw+w/eA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-47N92efxNN2qGIyh8l0iKw-1; Thu, 02 Jun 2022 05:40:22 -0400
X-MC-Unique: 47N92efxNN2qGIyh8l0iKw-1
Received: by mail-wr1-f71.google.com with SMTP id
 bv12-20020a0560001f0c00b0020e359b3852so661235wrb.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Jun 2022 02:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=52LjxcDCDPkycB4f7TfSZD4ZH4TRdf/5KkEsxrmPS+E=;
 b=MDwFd+xs/iRz2Ejg7V984orciTaqEb9FbqIkdP9vfpaeLti/aF+y9besD0S0+LBJ1n
 rYYwRcECyi6ODXnyIYfFgmDdkfEOsVYfdvuOOGDb5jTQR35IlDn67csBg6OiOG2Vaf/m
 xuxlKMl0t8wiqg1TcMj98s7ClQi6F93YD6g87TETVfFQ66fQNyUHxkYIYsXRSF/KTZds
 vCdRy9Gi3a+ftwdiX9OFa6765Psh7js1IId1VuOQLP0IJY9q6UwFEb6i3FuklcKVngtP
 r1McyoQahKJJ3lP6NnFKz+km0uojNyGNd7zr8+cscCINxeN15JOjNRc1GVmELFd0MBGx
 Fk8A==
X-Gm-Message-State: AOAM530ws7F4VvboZrKkZ9MyHW1TPzWZbbIJs1n+flTx3fPLJtMhrB2j
 ktVB9z3/s5mSedY873oOYQSI33cs2hA5FbFGN7t1RR8d3Kyx69QHqzQ2fP+KMZPSABEgtPgLImV
 kH0qD21Cg9Lvxwq7PYse/mQ8zdl5XbRFKPpGk8stX7g==
X-Received: by 2002:a05:600c:5126:b0:39a:eede:5bf4 with SMTP id
 o38-20020a05600c512600b0039aeede5bf4mr3176145wms.81.1654162820607; 
 Thu, 02 Jun 2022 02:40:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHYaDjNFGZohw0FilN1sHRbTenO2UBUUNE+T3ndq17x5ElP+Hjk2H4wgNC7lGgcxhyEKxNTg==
X-Received: by 2002:a05:600c:5126:b0:39a:eede:5bf4 with SMTP id
 o38-20020a05600c512600b0039aeede5bf4mr3176113wms.81.1654162820283; 
 Thu, 02 Jun 2022 02:40:20 -0700 (PDT)
Received: from [192.168.178.20] (p57a1a7d6.dip0.t-ipconnect.de.
 [87.161.167.214]) by smtp.gmail.com with ESMTPSA id
 d13-20020adfef8d000000b0020fc40d006bsm3830184wro.17.2022.06.02.02.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jun 2022 02:40:19 -0700 (PDT)
Message-ID: <8e4ffc3f-62c3-636e-e65b-af4b5bbc6c99@redhat.com>
Date: Thu, 2 Jun 2022 11:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
To: zhenwei pi <pizhenwei@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?=
 <naoya.horiguchi@nec.com>
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
 <Yo/I3oLkd9OU0ice@xz-m1.local>
 <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
 <0d266c61-605d-ce0c-4274-b0c7e10f845a@redhat.com>
 <4b0c3e37-b882-681a-36fc-16cee7e1fff0@bytedance.com>
 <YpTngZ5Qr0KIvL0H@xz-m1.local>
 <CAPcxDJ5UMfpys8KyLQVnkV9BPO1vaubxbhc7f4XC_TdNO7jr7g@mail.gmail.com>
 <5f622a65-8348-8825-a167-414f2a8cd2eb@bytedance.com>
 <484546da-16cc-8070-2a2c-868717b8a75a@redhat.com>
 <fc4ade80-a40a-d24d-d44d-16b48232b89f@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <fc4ade80-a40a-d24d-d44d-16b48232b89f@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: mst@redhat.com, Jue Wang <juew@google.com>,
 LKML <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org,
 Linux MM <linux-mm@kvack.org>, Paolo Bonzini <pbonzini@redhat.com>,
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

On 02.06.22 11:28, zhenwei pi wrote:
> On 6/1/22 15:59, David Hildenbrand wrote:
>> On 01.06.22 04:17, zhenwei pi wrote:
>>> On 5/31/22 12:08, Jue Wang wrote:
>>>> On Mon, May 30, 2022 at 8:49 AM Peter Xu <peterx@redhat.com> wrote:
>>>>>
>>>>> On Mon, May 30, 2022 at 07:33:35PM +0800, zhenwei pi wrote:
>>>>>> A VM uses RAM of 2M huge page. Once a MCE(@HVAy in [HVAx,HVAz)) occurs, the
>>>>>> 2M([HVAx,HVAz)) of hypervisor becomes unaccessible, but the guest poisons 4K
>>>>>> (@GPAy in [GPAx, GPAz)) only, it may hit another 511 MCE ([GPAx, GPAz)
>>>>>> except GPAy). This is the worse case, so I want to add
>>>>>>    '__le32 corrupted_pages' in struct virtio_balloon_config, it is used in the
>>>>>> next step: reporting 512 * 4K 'corrupted_pages' to the guest, the guest has
>>>>>> a chance to isolate the other 511 pages ahead of time. And the guest
>>>>>> actually loses 2M, fixing 512*4K seems to help significantly.
>>>>>
>>>>> It sounds hackish to teach a virtio device to assume one page will always
>>>>> be poisoned in huge page granule.  That's only a limitation to host kernel
>>>>> not virtio itself.
>>>>>
>>>>> E.g. there're upstream effort ongoing with enabling doublemap on hugetlbfs
>>>>> pages so hugetlb pages can be mapped in 4k with it.  It provides potential
>>>>> possibility to do page poisoning with huge pages in 4k too.  When that'll
>>>>> be ready the assumption can go away, and that does sound like a better
>>>>> approach towards this problem.
>>>>
>>>> +1.
>>>>
>>>> A hypervisor should always strive to minimize the guest memory loss.
>>>>
>>>> The HugeTLB double mapping enlightened memory poisoning behavior (only
>>>> poison 4K out of a 2MB huge page and 4K in guest) is a much better
>>>> solution here. To be completely transparent, it's not _strictly_
>>>> required to poison the page (whatever the granularity it is) on the
>>>> host side, as long as the following are true:
>>>>
>>>> 1. A hypervisor can emulate the _minimized_ (e.g., 4K) the poison to the guest.
>>>> 2. The host page with the UC error is "isolated" (could be PG_HWPOISON
>>>> or in some other way) and prevented from being reused by other
>>>> processes.
>>>>
>>>> For #2, PG_HWPOISON and HugeTLB double mapping enlightened memory
>>>> poisoning is a good solution.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> I assume when talking about "the performance memory drops a lot", you
>>>>>>> imply that this patch set can mitigate that performance drop?
>>>>>>>
>>>>>>> But why do you see a performance drop? Because we might lose some
>>>>>>> possible THP candidates (in the host or the guest) and you want to plug
>>>>>>> does holes? I assume you'll see a performance drop simply because
>>>>>>> poisoning memory is expensive, including migrating pages around on CE.
>>>>>>>
>>>>>>> If you have some numbers to share, especially before/after this change,
>>>>>>> that would be great.
>>>>>>>
>>>>>>
>>>>>> The CE storm leads 2 problems I have even seen:
>>>>>> 1, the memory bandwidth slows down to 10%~20%, and the cycles per
>>>>>> instruction of CPU increases a lot.
>>>>>> 2, the THR (/proc/interrupts) interrupts frequently, the CPU has to use a
>>>>>> lot time to handle IRQ.
>>>>>
>>>>> Totally no good knowledge on CMCI, but if 2) is true then I'm wondering
>>>>> whether it's necessary to handle the interrupts that frequently.  When I
>>>>> was reading the Intel CMCI vector handler I stumbled over this comment:
>>>>>
>>>>> /*
>>>>>    * The interrupt handler. This is called on every event.
>>>>>    * Just call the poller directly to log any events.
>>>>>    * This could in theory increase the threshold under high load,
>>>>>    * but doesn't for now.
>>>>>    */
>>>>> static void intel_threshold_interrupt(void)
>>>>>
>>>>> I think that matches with what I was thinking..  I mean for 2) not sure
>>>>> whether it can be seen as a CMCI problem and potentially can be optimized
>>>>> by adjust the cmci threshold dynamically.
>>>>
>>>> The CE storm caused performance drop is caused by the extra cycles
>>>> spent by the ECC steps in memory controller, not in CMCI handling.
>>>> This is observed in the Google fleet as well. A good solution is to
>>>> monitor the CE rate closely in user space via /dev/mcelog and migrate
>>>> all VMs to another host once the CE rate exceeds some threshold.
>>>>
>>>> CMCI is a _background_ interrupt that is not handled in the process
>>>> execution context and its handler is setup to switch to poll (1 / 5
>>>> min) mode if there are more than ~ a dozen CEs reported via CMCI per
>>>> second.
>>>>>
>>>>> --
>>>>> Peter Xu
>>>>>
>>>
>>> Hi, Andrew, David, Naoya
>>>
>>> According to the suggestions, I'd give up the improvement of memory
>>> failure on huge page in this series.
>>>
>>> Is it worth recovering corrupted pages for the guest kernel? I'd follow
>>> your decision.
>>
>> Well, as I said, I am not sure if we really need/want this for a handful
>> of 4k poisoned pages in a VM. As I suspected, doing so might primarily
>> be interesting for some sort of de-fragmentation (allow again a higher
>> order page to be placed at the affected PFNs), not because of the slight
>> reduction of available memory. A simple VM reboot would get the job
>> similarly done.
>>
> 
> Sure, Let's drop this idea. Thanks to all for the suggestions.

Thanks for the interesting idea + discussions.

Just a note that if you believe that we want/need something like that,
and there is a reasonable use case, please tell us we're wrong and push
back :)

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
