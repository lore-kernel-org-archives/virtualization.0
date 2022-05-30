Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7C0C433F5
	for <virtualization@archiver.kernel.org>; Mon, 30 May 2022 11:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F2A68289B;
	Mon, 30 May 2022 11:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KsrhmaBYH_2L; Mon, 30 May 2022 11:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F1E382862;
	Mon, 30 May 2022 11:37:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50575C0039;
	Mon, 30 May 2022 11:37:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE40C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 11:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BCE660EE5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 11:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zCbSew2WMQyg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 11:37:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6737560EC6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 11:37:36 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id j6so10331171pfe.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 04:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=oTn7xiqfMVG/Ets8BTsPYZb54RZ76weVWzmNwY5pPOo=;
 b=Sh2IF70NIweZY1YxFBbcJj+h+93R3gV45P301sqtBAYvTC1LNCDTVqNx/GSSKFseWa
 036lnyaVMqBdidXXcWzlLqYbAfPD0hzUxzNox8v3xnfLv+i5LbHZhjiNZ8yWdpfNl3G3
 r4C4g95JJpHGovTumWZYkpfVmrLEopIK4AehBE72PgZl8X4XClsrN0lOOBRnalM+mC5d
 udC0XbG5Vm4ceV5WRHq5u07rZcJdbZW27bvY8sxba93MwzgTx74f1gLC1QMyximZtc/J
 RpJdnh0P03nLKATKs+sTq8cow6FQuGkrgwkTOkS8kMXQexvE3T4U5h29KV6xAdOofSnn
 Saxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=oTn7xiqfMVG/Ets8BTsPYZb54RZ76weVWzmNwY5pPOo=;
 b=U5Nuu2NQkC8xSfJmjJN6nFicvRYHQ2IoPtE+7/PMPHi8i1TMOF0jM+ztzwllIi8al/
 nyiS46NFElCOQR7FzQA8HZV1er5YqTH2DS0GFRkWQTdo5kJV1dHlxD2IJW+zbSlLmeaz
 JXxv00eOSv0qA43G4Qpb4TMAwYQHM675615sFK1qxStDeJjlyXq7ZJUOli2Pl8gYS6Sw
 vdDGjR1e2p11aJKMzAmiF1B+IyWv1EqLFsWwEkeOhEZWtRx5a0Jbo5Dronx9q2hTkxp1
 qAN5aWlhWpI1KCt8EV9vhxDRUG2Kvm5IXMzU9z6+LhJaHisjl+qbrZABcTTyOHIGGaEW
 Q9CA==
X-Gm-Message-State: AOAM530PpjtIjkkyp5oZeMPnnhg3WAJD7d02uqGjc5C0pfI8Z3Bx+brC
 iqPhV5U9NHko/vKHIL3HSiHFiA==
X-Google-Smtp-Source: ABdhPJzonQ9UZ2K3KajjLc5t3cYmEGAE0YbTTOskwZ6mVqc54jbu+C/Juy1kTZLlt6QZEc2VPOnxMQ==
X-Received: by 2002:a65:618e:0:b0:3fb:177f:d365 with SMTP id
 c14-20020a65618e000000b003fb177fd365mr17788413pgv.265.1653910655546; 
 Mon, 30 May 2022 04:37:35 -0700 (PDT)
Received: from [10.255.89.136] ([139.177.225.249])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a17090a718100b001e2608203d4sm4426742pjk.5.2022.05.30.04.37.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 May 2022 04:37:34 -0700 (PDT)
Message-ID: <4b0c3e37-b882-681a-36fc-16cee7e1fff0@bytedance.com>
Date: Mon, 30 May 2022 19:33:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jue Wang <juew@google.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
 <Yo/I3oLkd9OU0ice@xz-m1.local>
 <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
 <0d266c61-605d-ce0c-4274-b0c7e10f845a@redhat.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <0d266c61-605d-ce0c-4274-b0c7e10f845a@redhat.com>
Cc: mst@redhat.com, =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?=
 <naoya.horiguchi@nec.com>, LKML <linux-kernel@vger.kernel.org>,
 qemu-devel@nongnu.org, Linux MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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



On 5/30/22 15:41, David Hildenbrand wrote:
> On 27.05.22 08:32, zhenwei pi wrote:
>> On 5/27/22 02:37, Peter Xu wrote:
>>> On Wed, May 25, 2022 at 01:16:34PM -0700, Jue Wang wrote:
>>>> The hypervisor _must_ emulate poisons identified in guest physical
>>>> address space (could be transported from the source VM), this is to
>>>> prevent silent data corruption in the guest. With a paravirtual
>>>> approach like this patch series, the hypervisor can clear some of the
>>>> poisoned HVAs knowing for certain that the guest OS has isolated the
>>>> poisoned page. I wonder how much value it provides to the guest if the
>>>> guest and workload are _not_ in a pressing need for the extra KB/MB
>>>> worth of memory.
>>>
>>> I'm curious the same on how unpoisoning could help here.  The reasoning
>>> behind would be great material to be mentioned in the next cover letter.
>>>
>>> Shouldn't we consider migrating serious workloads off the host already
>>> where there's a sign of more severe hardware issues, instead?
>>>
>>> Thanks,
>>>
>>
>> I'm maintaining 1000,000+ virtual machines, from my experience:
>> UE is quite unusual and occurs randomly, and I did not hit UE storm case
>> in the past years. The memory also has no obvious performance drop after
>> hitting UE.
>>
>> I hit several CE storm case, the performance memory drops a lot. But I
>> can't find obvious relationship between UE and CE.
>>
>> So from the point of my view, to fix the corrupted page for VM seems
>> good enough. And yes, unpoisoning several pages does not help
>> significantly, but it is still a chance to make the virtualization better.
>>
> 
> I'm curious why we should care about resurrecting a handful of poisoned
> pages in a VM. The cover letter doesn't touch on that.
> 
> IOW, I'm missing the motivation why we should add additional
> code+complexity to unpoison pages at all.
> 
> If we're talking about individual 4k pages, it's certainly sub-optimal,
> but does it matter in practice? I could understand if we're losing
> megabytes of memory. But then, I assume the workload might be seriously
> harmed either way already?
> 

Yes, resurrecting a handful of poisoned pages does not help 
significantly. And, in some ways, it seems nice to have. :D

A VM uses RAM of 2M huge page. Once a MCE(@HVAy in [HVAx,HVAz)) occurs, 
the 2M([HVAx,HVAz)) of hypervisor becomes unaccessible, but the guest 
poisons 4K (@GPAy in [GPAx, GPAz)) only, it may hit another 511 MCE 
([GPAx, GPAz) except GPAy). This is the worse case, so I want to add
  '__le32 corrupted_pages' in struct virtio_balloon_config, it is used 
in the next step: reporting 512 * 4K 'corrupted_pages' to the guest, the 
guest has a chance to isolate the other 511 pages ahead of time. And the 
guest actually loses 2M, fixing 512*4K seems to help significantly.

> 
> I assume when talking about "the performance memory drops a lot", you
> imply that this patch set can mitigate that performance drop?
> 
> But why do you see a performance drop? Because we might lose some
> possible THP candidates (in the host or the guest) and you want to plug
> does holes? I assume you'll see a performance drop simply because
> poisoning memory is expensive, including migrating pages around on CE.
> 
> If you have some numbers to share, especially before/after this change,
> that would be great.
> 

The CE storm leads 2 problems I have even seen:
1, the memory bandwidth slows down to 10%~20%, and the cycles per 
instruction of CPU increases a lot.
2, the THR (/proc/interrupts) interrupts frequently, the CPU has to use 
a lot time to handle IRQ.

But no corrupted page occurs. Migrating VM to another healthy host seems 
a good choice. This patch does not handle CE storm case.

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
