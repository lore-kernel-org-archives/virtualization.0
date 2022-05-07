Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF85C433FE
	for <virtualization@archiver.kernel.org>; Sat,  7 May 2022 09:23:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8234640432;
	Sat,  7 May 2022 09:23:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2uhMMs21oUl9; Sat,  7 May 2022 09:23:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1477040025;
	Sat,  7 May 2022 09:23:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7C8BC0032;
	Sat,  7 May 2022 09:23:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1C6EC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 09:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89567400B9
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 09:23:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 89Zf-bmo3OM9
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 09:23:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A27E440025
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 09:23:04 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id v11so8194271pff.6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 May 2022 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=HsmL70Uxpre+Yuw44Bhf/DXDbaU8ZDKhOhdy778k+yo=;
 b=mlR3d80AhkwzzC9PKqaXsMDhWbQVXMEC6MCnzg1peU4Wr/mTRivGCNYgM7QRHTa0ub
 Z3V6OvjENlJU/wkZN2dPGw8DjSuZcoNR2oGUlIRRhQBVH/J/SmIEO4cp5zUEAua7DtmH
 km6VJHxTPXPOkXf28Bfd8y2Oj/hJ5Li/5hWOGMIjZcnUHnrxLi2Ce7b4K6swCToXCf7T
 kja+3ZAT4xc4qTctp1GdxZRAwko+jFMeVBxA7mgxWtFLT8zu8kr3WjghwHOyLiP52hWs
 ZvWYhgOn07sFKhQ0KVq2vNxuL3N6cigDdOzFwBCEHPNwFpfeLQXgfP/Z5DqDonJBga7k
 jzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HsmL70Uxpre+Yuw44Bhf/DXDbaU8ZDKhOhdy778k+yo=;
 b=BZLOPOfHTd4yL1QcTixAgEQ2Fx4zDYI46SXc9sn0/GzMTWdpfy/O8KpqjCzWJx1STd
 uiwzQSiqDOFH/H+L5taf19A0K4ZWOtdXtaBDKzdoWfTmiLd77sc0Uh/eDvqnd3673iBN
 76eXrGG/sYgCevCPaXcCjc8TigcJ3aI7i1Rf+E7GETfNDbb6Vv9xqavjK5lv4w9RnmW9
 pl+UdedjKZ2WS3X4oB4KYBTghGQr7PZNXMIEwBvZbB2ESssle0CNfgWnJxULt0Ub37yJ
 o3E1MT+8G+W/Td+6nvv2EvB9OpmAb1OQ5x3LCjQi6lAQRR0DQLjjINOoztR+LMMKXEfK
 fabg==
X-Gm-Message-State: AOAM530VBEQOpsVkftm4XOFWCwKoG0ZVyxg+jD0p2ufgrztIIbEpK0cz
 v/YPrIpzPkgRlY8V7SaXkiz9nw==
X-Google-Smtp-Source: ABdhPJyw3bAQ9HgqBVfd9NCUfNAz6xXstkZXK2fVR31183kcyPUZrKZY1G88F0L6iyNceYsna1Hw0Q==
X-Received: by 2002:a63:c013:0:b0:3c1:df82:c8b3 with SMTP id
 h19-20020a63c013000000b003c1df82c8b3mr6045188pgg.141.1651915383734; 
 Sat, 07 May 2022 02:23:03 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.239])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a17090322c900b0015e8d4eb2e7sm3216427plg.305.2022.05.07.02.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 May 2022 02:23:02 -0700 (PDT)
Message-ID: <23e06fc6-84fe-122e-fc07-02c5bfa7d50b@bytedance.com>
Date: Sat, 7 May 2022 17:19:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: Re: [PATCH 3/4] mm/memofy-failure.c: optimize hwpoison_filter
Content-Language: en-US
To: Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
 <20220429142206.294714-4-pizhenwei@bytedance.com>
 <20220506085920.GC1356094@u2004>
 <3c0e25fb-695d-4a29-6de4-c892f89cea7a@bytedance.com>
 <ac3fc5b9-d09c-5fb6-998d-f7c655d7fa00@redhat.com>
 <a60933f2-ef07-92a3-66cf-071670a03101@bytedance.com>
 <20220507082045.GA1716199@u2004>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220507082045.GA1716199@u2004>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, naoya.horiguchi@nec.com,
 linux-kernel@vger.kernel.org, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, linux-mm@kvack.org,
 akpm@linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>
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

On 5/7/22 16:20, Naoya Horiguchi wrote:
> On Sat, May 07, 2022 at 08:28:05AM +0800, zhenwei pi wrote:
>>
>> On 5/7/22 00:28, David Hildenbrand wrote:
>>> On 06.05.22 15:38, zhenwei pi wrote:
>>>>
>>>>
>>>> On 5/6/22 16:59, Naoya Horiguchi wrote:
>>>>> On Fri, Apr 29, 2022 at 10:22:05PM +0800, zhenwei pi wrote:
>>>>>> In the memory failure procedure, hwpoison_filter has higher priority,
>>>>>> if memory_filter() filters the error event, there is no need to do
>>>>>> the further work.
>>>>>
>>>>> Could you clarify what problem you are trying to solve (what does
>>>>> "optimize" mean in this context or what is the benefit)?
>>>>>
>>>>
>>>> OK. The background of this work:
>>>> As well known, the memory failure mechanism handles memory corrupted
>>>> event, and try to send SIGBUS to the user process which uses this
>>>> corrupted page.
>>>>
>>>> For the virtualization case, QEMU catches SIGBUS and tries to inject MCE
>>>> into the guest, and the guest handles memory failure again. Thus the
>>>> guest gets the minimal effect from hardware memory corruption.
>>>>
>>>> The further step I'm working on:
>>>> 1, try to modify code to decrease poisoned pages in a single place
>>>> (mm/memofy-failure.c: simplify num_poisoned_pages_dec in this series).
> 
> This is fine to me.
> 
>>>>
>>>> 2, try to use page_handle_poison() to handle SetPageHWPoison() and
>>>> num_poisoned_pages_inc() together. It would be best to call
>>>> num_poisoned_pages_inc() in a single place too. I'm not sure if this is
>>>> possible or not, please correct me if I misunderstand.
> 
> SetPageHWPoison() can be cancelled in memory_failure(), so simply bundling
> it with num_poisoned_pages_inc() might not be optimal.  I think that
> action_result() is supposed to be called when memory error handling is
> effective (not filtered, not cancelled). So moving num_poisoned_pages_inc()
> (and notification code in your plan) into this function might be good.
> 
OK, I'll remove this patch(mm/memofy-failure.c: optimize 
hwpoison_filter) from this series, and fix the other 3 patches in the v2 
version. Then try to implement/test as your suggestion in another series.

>>>>
>>>> 3, introduce memory failure notifier list in memory-failure.c: notify
>>>> the corrupted PFN to someone who registers this list.
>>>> If I can complete [1] and [2] part, [3] will be quite easy(just call
>>>> notifier list after increasing poisoned page).
>>>>
>>>> 4, introduce memory recover VQ for memory balloon device, and registers
>>>> memory failure notifier list. During the guest kernel handles memory
>>>> failure, balloon device gets notified by memory failure notifier list,
>>>> and tells the host to recover the corrupted PFN(GPA) by the new VQ.
>>>
>>> Most probably you might want to do that asynchronously, and once the
>>> callback succeeds, un-poison the page.
>>>
>> Yes!
>>
>>>>
>>>> 5, host side remaps the corrupted page(HVA), and tells the guest side to
>>>> unpoison the PFN(GPA). Then the guest fixes the corrupted page(GPA)
>>>> dynamically.
>>>
>>> I think QEMU already does that during reboots. Now it would be triggered
>>> by the guest for individual pages.
>>>
>> Yes, currently QEMU supports to un-poison corrupted pages during
>> reset/reboot. We can reuse some code to do the work in this case, this
>> allows a VM to fix corrupted pages as soon as possible(also no need to
>> reset/reboot).
> 
> So this finally allows to replace broken page mapped to guest with
> a healthy page without rebooting the guest. That sounds helpful.
> 
> Thanks,
> Naoya Horiguchi
> 
Yes, it's my plan. Thanks for your suggestions!

>>
>>>>
>>>> Because [4] and [5] are related to balloon device, also CC Michael,
>>>> David and Jason.
>>>
>>> Doesn't sound too crazy for me, although it's a shame that we always
>>> have to use virtio-balloon for such fairly balloon-unrelated things.
>>>
>> Thanks!
>>
>> -- 
>> zhenwei pi

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
