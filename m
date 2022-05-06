Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E4FC433F5
	for <virtualization@archiver.kernel.org>; Fri,  6 May 2022 13:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0D2D40291;
	Fri,  6 May 2022 13:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id frupLmLsKJJy; Fri,  6 May 2022 13:42:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1719540025;
	Fri,  6 May 2022 13:42:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3D52C0039;
	Fri,  6 May 2022 13:42:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CC8DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73B728254D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l9g5PmONjN56
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:42:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 623ED82542
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:42:25 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id 204so3508201pfx.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=PfUI54DC+Rd4JhaHhM79SH7hCQA6BnGmIDFJn3u5zLM=;
 b=aKsXfyC6aHrcUWOwO7G7UYAV68+b8gHqoJddnLu0t/IA7s7HawCsFCGO/Kujg873Y6
 KVD3LFFVeuekk+wEAOPy1Y6U1hO5gUa0jLOw8Bvc5N02CNRvkanaEg2w/JG5wka+Oslx
 ydesijDYApsY+LM85LShGfEnGycGRv/VEdWYUy9FfhhdzljJFiBXPOyi/Pa35WArWkKX
 BhCl/GlGG23ObBA0eoXzfYFXawe6ko9nCA940pYhFh0G0ZTDtWM5vfpTM+6JW1Njun30
 ZsFjAFyFgMjFBHj+GWTjf33CG4KH/W+9w3UtvRGjoUgC8vdqfTBth8M1FRYVYh8Z+xd5
 8xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=PfUI54DC+Rd4JhaHhM79SH7hCQA6BnGmIDFJn3u5zLM=;
 b=Lz4xzoALhGh0v6ptMCt1jpgGXPbZjAb7KJOwBol5mv3bhykuQs5TN9DsZl/qRaAUgU
 GXEvuUeru6zlnYM1bLcm3b7CPbgUgI3X1K7DaRA2JoqfC8j6Fagm3z1P56vZCWoD4a92
 aXdvPx0lBckZA9ThImA4N4O9aSZRCkho2iF7Pe0vaR0DdeMUYRqTZM8HNuc5G7zRLCij
 VT8VbxurKYxEP25BMB3Kf7WE6AJUJYOM999789EiiYkcfb6EnUSxx9NKMkXrMIBt1AYg
 BGTxnlf24D/hdsF6MN70LA69ruVq0rKbG8chFNhwl79zKdUHYYIEnnFK3w9qxZFrYvpK
 06aw==
X-Gm-Message-State: AOAM531tm+5dVgWlxV6wXi7IEJbPZNGiVODn4/3fwYNrqbwaT7mohVfV
 tm57/iTVTd+XrgUlr97D+yn9pQ==
X-Google-Smtp-Source: ABdhPJySJILodY6XqJPjPbH87bJIVRNRr+CgOPpU7dPLFadY++HIHQRCjgCYnQukNaA1I2A/cUztMg==
X-Received: by 2002:a63:8449:0:b0:3c6:4145:6a1c with SMTP id
 k70-20020a638449000000b003c641456a1cmr2839205pgd.590.1651844544773; 
 Fri, 06 May 2022 06:42:24 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a056a001c4e00b0050dc76281fesm3333258pfw.216.2022.05.06.06.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 May 2022 06:42:24 -0700 (PDT)
Message-ID: <3c0e25fb-695d-4a29-6de4-c892f89cea7a@bytedance.com>
Date: Fri, 6 May 2022 21:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 3/4] mm/memofy-failure.c: optimize hwpoison_filter
Content-Language: en-US
To: Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
 <20220429142206.294714-4-pizhenwei@bytedance.com>
 <20220506085920.GC1356094@u2004>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220506085920.GC1356094@u2004>
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



On 5/6/22 16:59, Naoya Horiguchi wrote:
> On Fri, Apr 29, 2022 at 10:22:05PM +0800, zhenwei pi wrote:
>> In the memory failure procedure, hwpoison_filter has higher priority,
>> if memory_filter() filters the error event, there is no need to do
>> the further work.
> 
> Could you clarify what problem you are trying to solve (what does
> "optimize" mean in this context or what is the benefit)?
> 

OK. The background of this work:
As well known, the memory failure mechanism handles memory corrupted 
event, and try to send SIGBUS to the user process which uses this 
corrupted page.

For the virtualization case, QEMU catches SIGBUS and tries to inject MCE 
into the guest, and the guest handles memory failure again. Thus the 
guest gets the minimal effect from hardware memory corruption.

The further step I'm working on:
1, try to modify code to decrease poisoned pages in a single place 
(mm/memofy-failure.c: simplify num_poisoned_pages_dec in this series).

2, try to use page_handle_poison() to handle SetPageHWPoison() and 
num_poisoned_pages_inc() together. It would be best to call 
num_poisoned_pages_inc() in a single place too. I'm not sure if this is 
possible or not, please correct me if I misunderstand.

3, introduce memory failure notifier list in memory-failure.c: notify 
the corrupted PFN to someone who registers this list.
If I can complete [1] and [2] part, [3] will be quite easy(just call 
notifier list after increasing poisoned page).

4, introduce memory recover VQ for memory balloon device, and registers 
memory failure notifier list. During the guest kernel handles memory 
failure, balloon device gets notified by memory failure notifier list, 
and tells the host to recover the corrupted PFN(GPA) by the new VQ.

5, host side remaps the corrupted page(HVA), and tells the guest side to 
unpoison the PFN(GPA). Then the guest fixes the corrupted page(GPA) 
dynamically.

Because [4] and [5] are related to balloon device, also CC Michael, 
David and Jason.

> Now hwpoison_filter() can be called both with *and* without taking page refcount.
> It's mainly called *with* taking page refcount in order to make sure that the
> actual handling process is executed only for pages that meet a given condition.
> IOW, it's important to prevent pages which do not meet the condition from going
> ahead to further steps (false-positive is not permitted).  So this type of
> callsite should not be omittable.
> 
> As for the other case, hwpoison_filter() is also called in hwpoison_inject()
> *without* taking page refcount.  This actually has a different nuance and
> intended to speculatively filter the injection events before setting
> PageHWPoison flag to reduce the noise due to setting PG_hwpoison temporary.
> The point is that it's not intended here to filter precisely and this callsite
> is omittable.
> 
> So in my understanding, we need keep hwpoison_filter() after taking page
> refcount as we do now.  Maybe optionally and additionally calling
> hwpoison_filter() at the beginning of memory_failure() might be possible,
> but I'm not sure yet how helpful...
> 
> Thanks,
> Naoya Horiguchi
> 
>>
>> Cc: Wu Fengguang <fengguang.wu@intel.com>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   mm/memory-failure.c | 14 +++++---------
>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index ece05858568f..a6a27c8b800f 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1800,6 +1800,11 @@ int memory_failure(unsigned long pfn, int flags)
>>   		goto unlock_mutex;
>>   	}
>>   
>> +	if (hwpoison_filter(p)) {
>> +		res = -EOPNOTSUPP;
>> +		goto unlock_mutex;
>> +	}
>> +
>>   try_again:
>>   	res = try_memory_failure_hugetlb(pfn, flags, &hugetlb);
>>   	if (hugetlb)
>> @@ -1937,15 +1942,6 @@ int memory_failure(unsigned long pfn, int flags)
>>   	 */
>>   	page_flags = p->flags;
>>   
>> -	if (hwpoison_filter(p)) {
>> -		if (TestClearPageHWPoison(p))
>> -			num_poisoned_pages_dec();
>> -		unlock_page(p);
>> -		put_page(p);
>> -		res = -EOPNOTSUPP;
>> -		goto unlock_mutex;
>> -	}
>> -
>>   	/*
>>   	 * __munlock_pagevec may clear a writeback page's LRU flag without
>>   	 * page_lock. We need wait writeback completion for this page or it
>> -- 
>> 2.20.1
>>

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
