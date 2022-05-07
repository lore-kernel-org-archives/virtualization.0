Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C052C433FE
	for <virtualization@archiver.kernel.org>; Sat,  7 May 2022 00:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21F5581B69;
	Sat,  7 May 2022 00:32:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I5eyTg_L5K3i; Sat,  7 May 2022 00:32:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B4E5081B48;
	Sat,  7 May 2022 00:32:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75769C0032;
	Sat,  7 May 2022 00:32:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65BA6C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 00:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E82C40191
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 00:32:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ea47JZxWWbsw
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 00:32:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 532BF4014E
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 00:32:00 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id p6so8386282pjm.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 17:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Wn0dXbP2ZNZ5rtmEUdIAq+AKjqvzHBKlvsWStfjh/W0=;
 b=fOrVM+EV4Gunf/aPtxP1nt32zwg0Xwz4PfvGKYnHCgQwFAwWTfFddYQ/YZ4R+7AKqb
 yiWWR2ufEtrREpn9n4vplBM48DbtYM0u7ut3ChXkCkslhGtgm7lKrSesCev0H/+ruwKV
 RUcFjA56oR02AtOyIvEG4He/xOKdub2cATeQ45KylHC3J+N4e1sr09CX/oxFTm32kvDD
 bEiuOeH3vz12FQVgretkDDpYELaFELIc6FVOqt4G4YCPKtGSfn8wwoIMX7mXf31T6X0Q
 BAX8mKz3jEOI6r6BdE8CROzOUylSc5p6GfOJjTDCIieZRNatDok1m5TYn7FWJm8VPh0D
 oIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Wn0dXbP2ZNZ5rtmEUdIAq+AKjqvzHBKlvsWStfjh/W0=;
 b=X24o7lX1bm1UJMwdXE9P4gqEYetcFkG7T0MeHIpCC3wAFc8RExgX3w2e4EElupY9qT
 HsINxhuPBjlKMcLD4EDOm+q58y7Zt3iGriNbh+bv1C0Hibx8Uo1aQL4TVxDC5035c/db
 dqW8gwUScR8pc0qLbF+/tJOf4X+iY8NqrkeuRtue2YKDaJfEpwDD01NxYDMYcQKGtGqi
 SszncYy23m22x5OJ+NvhA7sckseG88vqZbKHBMmGy5jn74U82JCv8Axvbdo3Aq1wkisr
 bnYdFGXHX5d46LgVvnBa+tmSrHdme1H67fWNh2c3nV+zDWqcfAkYVuHQz5VAjnVC/W4a
 s19Q==
X-Gm-Message-State: AOAM532BZOtTsSNE5lwqDa2QiVmiy3hmNHhh7g/xlZejPoanjdt6wJRT
 /B9PajPD9KUfzXKTcLqpjBUoPw==
X-Google-Smtp-Source: ABdhPJyckdf3ooD9/x8FQrTgykRhfqi6qP1ZrPcpvmWgj2IWql69kx0Wu/RQ52gT5LiMdQFMnHPxLw==
X-Received: by 2002:a17:902:bd05:b0:158:544d:6557 with SMTP id
 p5-20020a170902bd0500b00158544d6557mr6514519pls.70.1651883520388; 
 Fri, 06 May 2022 17:32:00 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090341c100b0015e8d4eb278sm2471067ple.194.2022.05.06.17.31.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 May 2022 17:31:59 -0700 (PDT)
Message-ID: <a60933f2-ef07-92a3-66cf-071670a03101@bytedance.com>
Date: Sat, 7 May 2022 08:28:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 3/4] mm/memofy-failure.c: optimize hwpoison_filter
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
 <20220429142206.294714-4-pizhenwei@bytedance.com>
 <20220506085920.GC1356094@u2004>
 <3c0e25fb-695d-4a29-6de4-c892f89cea7a@bytedance.com>
 <ac3fc5b9-d09c-5fb6-998d-f7c655d7fa00@redhat.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <ac3fc5b9-d09c-5fb6-998d-f7c655d7fa00@redhat.com>
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


On 5/7/22 00:28, David Hildenbrand wrote:
> On 06.05.22 15:38, zhenwei pi wrote:
>>
>>
>> On 5/6/22 16:59, Naoya Horiguchi wrote:
>>> On Fri, Apr 29, 2022 at 10:22:05PM +0800, zhenwei pi wrote:
>>>> In the memory failure procedure, hwpoison_filter has higher priority,
>>>> if memory_filter() filters the error event, there is no need to do
>>>> the further work.
>>>
>>> Could you clarify what problem you are trying to solve (what does
>>> "optimize" mean in this context or what is the benefit)?
>>>
>>
>> OK. The background of this work:
>> As well known, the memory failure mechanism handles memory corrupted
>> event, and try to send SIGBUS to the user process which uses this
>> corrupted page.
>>
>> For the virtualization case, QEMU catches SIGBUS and tries to inject MCE
>> into the guest, and the guest handles memory failure again. Thus the
>> guest gets the minimal effect from hardware memory corruption.
>>
>> The further step I'm working on:
>> 1, try to modify code to decrease poisoned pages in a single place
>> (mm/memofy-failure.c: simplify num_poisoned_pages_dec in this series).
>>
>> 2, try to use page_handle_poison() to handle SetPageHWPoison() and
>> num_poisoned_pages_inc() together. It would be best to call
>> num_poisoned_pages_inc() in a single place too. I'm not sure if this is
>> possible or not, please correct me if I misunderstand.
>>
>> 3, introduce memory failure notifier list in memory-failure.c: notify
>> the corrupted PFN to someone who registers this list.
>> If I can complete [1] and [2] part, [3] will be quite easy(just call
>> notifier list after increasing poisoned page).
>>
>> 4, introduce memory recover VQ for memory balloon device, and registers
>> memory failure notifier list. During the guest kernel handles memory
>> failure, balloon device gets notified by memory failure notifier list,
>> and tells the host to recover the corrupted PFN(GPA) by the new VQ.
> 
> Most probably you might want to do that asynchronously, and once the
> callback succeeds, un-poison the page.
> 
Yes!

>>
>> 5, host side remaps the corrupted page(HVA), and tells the guest side to
>> unpoison the PFN(GPA). Then the guest fixes the corrupted page(GPA)
>> dynamically.
> 
> I think QEMU already does that during reboots. Now it would be triggered
> by the guest for individual pages.
> 
Yes, currently QEMU supports to un-poison corrupted pages during 
reset/reboot. We can reuse some code to do the work in this case, this 
allows a VM to fix corrupted pages as soon as possible(also no need to 
reset/reboot).

>>
>> Because [4] and [5] are related to balloon device, also CC Michael,
>> David and Jason.
> 
> Doesn't sound too crazy for me, although it's a shame that we always
> have to use virtio-balloon for such fairly balloon-unrelated things.
> 
Thanks!

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
