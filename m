Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30238C43334
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 09:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C586641529;
	Thu,  2 Jun 2022 09:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IHHRtamit0XC; Thu,  2 Jun 2022 09:32:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C572841528;
	Thu,  2 Jun 2022 09:32:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 838EBC0032;
	Thu,  2 Jun 2022 09:32:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B5C5C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:32:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30E5460E92
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:32:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fciaY1rSbrUU
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:32:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FCE160BE8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:32:02 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id b135so4260386pfb.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Jun 2022 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=7I3ikvFHTI+6AcR3ilkUpnEXgPD/1szD0jLieUltRxk=;
 b=ItV3NywPYNHm1FfgUjBMRW09NCS6oZOMYKz9eWsHEfWk8NyiBKqb/2k4YL46y5CYnS
 blv+H/a7RyNuy6xKLlhF3jjuJhJr5mcHOPtnbO/jkk6avb7yQjCS4MILmz0LsS5C90bQ
 2bi6vOnb22JDvS3GDo/U2ag2yMtw9pvUFAWAPHoaf6ogV7rhYjAH7RVXa4ug20vRoC1q
 8sbl0XOZqCq4DQ7fsF6gXfURhOy2h7n3cxn2UDORy08kinTTXUX3gSKIz5tIRQXutU96
 sjFjTgmRcpZ0ybdSelwgQIopM8JAAX5NjwYRPfgweHy78H1EOXprtzPilNT8DlE6W4nQ
 Jpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7I3ikvFHTI+6AcR3ilkUpnEXgPD/1szD0jLieUltRxk=;
 b=qPLIuusX4NIbVvfGHrAwbK8Le6I5TI03VeSWsbRpn22vW6n2a5HeSnYs0lSGiovztI
 6ECqPVYMRRVVgTj0eVp80V3uAnhPGvII2ragTXLe7u4THYNLVbzI0LstkaSHBEVsmZl0
 vCunnRVmim4b4ROJJiD3fLZu1KeO+0l4vIldJSV4Sw7KTO6WZJD7jYExzq1bhsAyW99D
 /13/CFA0CtccJnJRxktIx+X6u6tC1J7KLZ2KyNkgqoF8GLqdOAmaB35kPn5QFUagnX7w
 Gid9Kx9MMhdVq9fhfCiwYaWxtSTnuV8dtReT9djN4+ZhaskkULWNb9hM3INBwdbyY/VR
 qWHQ==
X-Gm-Message-State: AOAM533vKCaagiC+2whwJPWXDYJlwriI/9KpnzQGgWk59hjTc5QahsB/
 b9KN5o8QeAUmIDsVB+RL5mMZkg==
X-Google-Smtp-Source: ABdhPJyGhLUAVF5lUAJbWPQRaAlP5yR+8T7MH5RjDJxKjPQKPSggZoMgr0IYcNvpnD6X4KJsg11e7w==
X-Received: by 2002:a63:754b:0:b0:3fb:2109:e4d2 with SMTP id
 f11-20020a63754b000000b003fb2109e4d2mr3421775pgn.447.1654162321444; 
 Thu, 02 Jun 2022 02:32:01 -0700 (PDT)
Received: from [10.255.89.136] ([139.177.225.233])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a056a0024cf00b00512ee2f2363sm3131645pfv.99.2022.06.02.02.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jun 2022 02:32:00 -0700 (PDT)
Message-ID: <fc4ade80-a40a-d24d-d44d-16b48232b89f@bytedance.com>
Date: Thu, 2 Jun 2022 17:28:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
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
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <484546da-16cc-8070-2a2c-868717b8a75a@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 6/1/22 15:59, David Hildenbrand wrote:
> On 01.06.22 04:17, zhenwei pi wrote:
>> On 5/31/22 12:08, Jue Wang wrote:
>>> On Mon, May 30, 2022 at 8:49 AM Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>> On Mon, May 30, 2022 at 07:33:35PM +0800, zhenwei pi wrote:
>>>>> A VM uses RAM of 2M huge page. Once a MCE(@HVAy in [HVAx,HVAz)) occurs, the
>>>>> 2M([HVAx,HVAz)) of hypervisor becomes unaccessible, but the guest poisons 4K
>>>>> (@GPAy in [GPAx, GPAz)) only, it may hit another 511 MCE ([GPAx, GPAz)
>>>>> except GPAy). This is the worse case, so I want to add
>>>>>    '__le32 corrupted_pages' in struct virtio_balloon_config, it is used in the
>>>>> next step: reporting 512 * 4K 'corrupted_pages' to the guest, the guest has
>>>>> a chance to isolate the other 511 pages ahead of time. And the guest
>>>>> actually loses 2M, fixing 512*4K seems to help significantly.
>>>>
>>>> It sounds hackish to teach a virtio device to assume one page will always
>>>> be poisoned in huge page granule.  That's only a limitation to host kernel
>>>> not virtio itself.
>>>>
>>>> E.g. there're upstream effort ongoing with enabling doublemap on hugetlbfs
>>>> pages so hugetlb pages can be mapped in 4k with it.  It provides potential
>>>> possibility to do page poisoning with huge pages in 4k too.  When that'll
>>>> be ready the assumption can go away, and that does sound like a better
>>>> approach towards this problem.
>>>
>>> +1.
>>>
>>> A hypervisor should always strive to minimize the guest memory loss.
>>>
>>> The HugeTLB double mapping enlightened memory poisoning behavior (only
>>> poison 4K out of a 2MB huge page and 4K in guest) is a much better
>>> solution here. To be completely transparent, it's not _strictly_
>>> required to poison the page (whatever the granularity it is) on the
>>> host side, as long as the following are true:
>>>
>>> 1. A hypervisor can emulate the _minimized_ (e.g., 4K) the poison to the guest.
>>> 2. The host page with the UC error is "isolated" (could be PG_HWPOISON
>>> or in some other way) and prevented from being reused by other
>>> processes.
>>>
>>> For #2, PG_HWPOISON and HugeTLB double mapping enlightened memory
>>> poisoning is a good solution.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> I assume when talking about "the performance memory drops a lot", you
>>>>>> imply that this patch set can mitigate that performance drop?
>>>>>>
>>>>>> But why do you see a performance drop? Because we might lose some
>>>>>> possible THP candidates (in the host or the guest) and you want to plug
>>>>>> does holes? I assume you'll see a performance drop simply because
>>>>>> poisoning memory is expensive, including migrating pages around on CE.
>>>>>>
>>>>>> If you have some numbers to share, especially before/after this change,
>>>>>> that would be great.
>>>>>>
>>>>>
>>>>> The CE storm leads 2 problems I have even seen:
>>>>> 1, the memory bandwidth slows down to 10%~20%, and the cycles per
>>>>> instruction of CPU increases a lot.
>>>>> 2, the THR (/proc/interrupts) interrupts frequently, the CPU has to use a
>>>>> lot time to handle IRQ.
>>>>
>>>> Totally no good knowledge on CMCI, but if 2) is true then I'm wondering
>>>> whether it's necessary to handle the interrupts that frequently.  When I
>>>> was reading the Intel CMCI vector handler I stumbled over this comment:
>>>>
>>>> /*
>>>>    * The interrupt handler. This is called on every event.
>>>>    * Just call the poller directly to log any events.
>>>>    * This could in theory increase the threshold under high load,
>>>>    * but doesn't for now.
>>>>    */
>>>> static void intel_threshold_interrupt(void)
>>>>
>>>> I think that matches with what I was thinking..  I mean for 2) not sure
>>>> whether it can be seen as a CMCI problem and potentially can be optimized
>>>> by adjust the cmci threshold dynamically.
>>>
>>> The CE storm caused performance drop is caused by the extra cycles
>>> spent by the ECC steps in memory controller, not in CMCI handling.
>>> This is observed in the Google fleet as well. A good solution is to
>>> monitor the CE rate closely in user space via /dev/mcelog and migrate
>>> all VMs to another host once the CE rate exceeds some threshold.
>>>
>>> CMCI is a _background_ interrupt that is not handled in the process
>>> execution context and its handler is setup to switch to poll (1 / 5
>>> min) mode if there are more than ~ a dozen CEs reported via CMCI per
>>> second.
>>>>
>>>> --
>>>> Peter Xu
>>>>
>>
>> Hi, Andrew, David, Naoya
>>
>> According to the suggestions, I'd give up the improvement of memory
>> failure on huge page in this series.
>>
>> Is it worth recovering corrupted pages for the guest kernel? I'd follow
>> your decision.
> 
> Well, as I said, I am not sure if we really need/want this for a handful
> of 4k poisoned pages in a VM. As I suspected, doing so might primarily
> be interesting for some sort of de-fragmentation (allow again a higher
> order page to be placed at the affected PFNs), not because of the slight
> reduction of available memory. A simple VM reboot would get the job
> similarly done.
> 

Sure, Let's drop this idea. Thanks to all for the suggestions.

Hi, Naoya
It seems that memory failure notifier is not required currently, so I'll 
not push the next version of:
[PATCH 1/3] memory-failure: Introduce memory failure notifier
[PATCH 2/3] mm/memory-failure.c: support reset PTE during unpoison

Thanks you for review work!

> As the poisoning refcount code is already a bit shaky as I learned
> recently in the context of memory offlining, I do wonder if we really
> want to expose the unpoisoning code outside of debugfs (hwpoison) usage.
> 
> Interestingly, unpoison_memory() documents: "This is only done on the
> software-level, so it only works for linux injected failures, not real
> hardware failures" -- ehm?
> 

I guess unpoison_memory() is designed/tested by hwpoison-inject only, I 
have no idea to fix memory failure on a hardware platform. I suppose 
it's the first time that unpoison_memory() is required by hardware-level 
(balloon VQ).

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
