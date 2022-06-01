Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1131C433F5
	for <virtualization@archiver.kernel.org>; Wed,  1 Jun 2022 02:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 413FF40193;
	Wed,  1 Jun 2022 02:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mGJQ1Js6v4Pv; Wed,  1 Jun 2022 02:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AF01C4015F;
	Wed,  1 Jun 2022 02:22:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75229C0039;
	Wed,  1 Jun 2022 02:22:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68ECEC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 02:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42730417B4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 02:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jfvjs1ZW0ymS
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 02:21:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E348B409A8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 02:21:56 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id y187so564617pgd.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 19:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=2okyrQI7zzxx6armVnSyvWo3k8iS+WCjiSoArjw0fEE=;
 b=lNtCXz826IraqgepKCt/0lBy+mvMAaE2ivM/1NtE1GDoY942T5NsfhN91WTgx4ANjM
 0xSVtO126oHxAM52jRDdWZORous5WBraQcL6dZQ8Ia53sJcte67lY7MPex9Z5MtwU/t3
 gxaV3/h3l0sz5h8It0hfiUZ5SYwVEdE3yMgblQkT9Y7FDq3ZPzr1CjWqoNE8KqzydtL7
 /271RuA8uiEl61xA0JyyHu0VZm0P0a/V1g89g4LrVnV+p4AgH0064N0SDE9eU5hfMl7g
 VE5X+2RmPw9fzhPqM6nWyZPLMWd+FDtQhwGBuRG5GGmVbXw2C45XfOEmviQBpXcD90GI
 aq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2okyrQI7zzxx6armVnSyvWo3k8iS+WCjiSoArjw0fEE=;
 b=WlC7NOf+h+zQQKTXKJzWjqSxDLbENMo06x5l9qz75ZOckTnpQsFzErbzgz/lfJo7R1
 n+hGTTw+9G89IGxVlXx3rab+68H3NyflBZuYTI//KrejQqVVm6XsEf7UgAWSpzTPTVFQ
 fmGqWseGHCQI/YeDmNna/Uv8LUd2TR+J8mYzeCh92VKLqlYlqgFCugB6+0IHLPShqWOh
 vLsizmwodEqiKSbI4TyOG+yW6udsr3jJGfEBNUL9zKoCPZXJRq07prGgsI9FEWLDehaA
 Hrxwxm2BBoWS56svLVbYoNiutLw1a6oG7X/s0SH2AhURjveWTSpcXj7XA2nT5sMcJ4S3
 L3xg==
X-Gm-Message-State: AOAM533mqV9he33WV4RRjsJ/W3YH1qiHcXapV4nkYpXQ34esWKSi0BBb
 1mmJXE7w73CK0mfMq6poAA/rYg==
X-Google-Smtp-Source: ABdhPJzW0LFXWu1OWiBefZkXNcr/MWs15wzhND3amhX9Ouk0RYJnIvws91AeF3f0YhsM1ih2w98Iwg==
X-Received: by 2002:a05:6a00:23ce:b0:50d:823f:981 with SMTP id
 g14-20020a056a0023ce00b0050d823f0981mr65646297pfc.10.1654050116005; 
 Tue, 31 May 2022 19:21:56 -0700 (PDT)
Received: from [10.255.89.136] ([139.177.225.233])
 by smtp.gmail.com with ESMTPSA id
 r4-20020a170902ea4400b001641a68f1c7sm190180plg.273.2022.05.31.19.21.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 May 2022 19:21:55 -0700 (PDT)
Message-ID: <5f622a65-8348-8825-a167-414f2a8cd2eb@bytedance.com>
Date: Wed, 1 Jun 2022 10:17:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: Re: [PATCH 0/3] recover hardware corrupted page by virtio
 balloon
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?=
 <naoya.horiguchi@nec.com>
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
 <Yo/I3oLkd9OU0ice@xz-m1.local>
 <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
 <0d266c61-605d-ce0c-4274-b0c7e10f845a@redhat.com>
 <4b0c3e37-b882-681a-36fc-16cee7e1fff0@bytedance.com>
 <YpTngZ5Qr0KIvL0H@xz-m1.local>
 <CAPcxDJ5UMfpys8KyLQVnkV9BPO1vaubxbhc7f4XC_TdNO7jr7g@mail.gmail.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <CAPcxDJ5UMfpys8KyLQVnkV9BPO1vaubxbhc7f4XC_TdNO7jr7g@mail.gmail.com>
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

On 5/31/22 12:08, Jue Wang wrote:
> On Mon, May 30, 2022 at 8:49 AM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Mon, May 30, 2022 at 07:33:35PM +0800, zhenwei pi wrote:
>>> A VM uses RAM of 2M huge page. Once a MCE(@HVAy in [HVAx,HVAz)) occurs, the
>>> 2M([HVAx,HVAz)) of hypervisor becomes unaccessible, but the guest poisons 4K
>>> (@GPAy in [GPAx, GPAz)) only, it may hit another 511 MCE ([GPAx, GPAz)
>>> except GPAy). This is the worse case, so I want to add
>>>   '__le32 corrupted_pages' in struct virtio_balloon_config, it is used in the
>>> next step: reporting 512 * 4K 'corrupted_pages' to the guest, the guest has
>>> a chance to isolate the other 511 pages ahead of time. And the guest
>>> actually loses 2M, fixing 512*4K seems to help significantly.
>>
>> It sounds hackish to teach a virtio device to assume one page will always
>> be poisoned in huge page granule.  That's only a limitation to host kernel
>> not virtio itself.
>>
>> E.g. there're upstream effort ongoing with enabling doublemap on hugetlbfs
>> pages so hugetlb pages can be mapped in 4k with it.  It provides potential
>> possibility to do page poisoning with huge pages in 4k too.  When that'll
>> be ready the assumption can go away, and that does sound like a better
>> approach towards this problem.
> 
> +1.
> 
> A hypervisor should always strive to minimize the guest memory loss.
> 
> The HugeTLB double mapping enlightened memory poisoning behavior (only
> poison 4K out of a 2MB huge page and 4K in guest) is a much better
> solution here. To be completely transparent, it's not _strictly_
> required to poison the page (whatever the granularity it is) on the
> host side, as long as the following are true:
> 
> 1. A hypervisor can emulate the _minimized_ (e.g., 4K) the poison to the guest.
> 2. The host page with the UC error is "isolated" (could be PG_HWPOISON
> or in some other way) and prevented from being reused by other
> processes.
> 
> For #2, PG_HWPOISON and HugeTLB double mapping enlightened memory
> poisoning is a good solution.
> 
>>
>>>
>>>>
>>>> I assume when talking about "the performance memory drops a lot", you
>>>> imply that this patch set can mitigate that performance drop?
>>>>
>>>> But why do you see a performance drop? Because we might lose some
>>>> possible THP candidates (in the host or the guest) and you want to plug
>>>> does holes? I assume you'll see a performance drop simply because
>>>> poisoning memory is expensive, including migrating pages around on CE.
>>>>
>>>> If you have some numbers to share, especially before/after this change,
>>>> that would be great.
>>>>
>>>
>>> The CE storm leads 2 problems I have even seen:
>>> 1, the memory bandwidth slows down to 10%~20%, and the cycles per
>>> instruction of CPU increases a lot.
>>> 2, the THR (/proc/interrupts) interrupts frequently, the CPU has to use a
>>> lot time to handle IRQ.
>>
>> Totally no good knowledge on CMCI, but if 2) is true then I'm wondering
>> whether it's necessary to handle the interrupts that frequently.  When I
>> was reading the Intel CMCI vector handler I stumbled over this comment:
>>
>> /*
>>   * The interrupt handler. This is called on every event.
>>   * Just call the poller directly to log any events.
>>   * This could in theory increase the threshold under high load,
>>   * but doesn't for now.
>>   */
>> static void intel_threshold_interrupt(void)
>>
>> I think that matches with what I was thinking..  I mean for 2) not sure
>> whether it can be seen as a CMCI problem and potentially can be optimized
>> by adjust the cmci threshold dynamically.
> 
> The CE storm caused performance drop is caused by the extra cycles
> spent by the ECC steps in memory controller, not in CMCI handling.
> This is observed in the Google fleet as well. A good solution is to
> monitor the CE rate closely in user space via /dev/mcelog and migrate
> all VMs to another host once the CE rate exceeds some threshold.
> 
> CMCI is a _background_ interrupt that is not handled in the process
> execution context and its handler is setup to switch to poll (1 / 5
> min) mode if there are more than ~ a dozen CEs reported via CMCI per
> second.
>>
>> --
>> Peter Xu
>>

Hi, Andrew, David, Naoya

According to the suggestions, I'd give up the improvement of memory 
failure on huge page in this series.

Is it worth recovering corrupted pages for the guest kernel? I'd follow 
your decision.

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
