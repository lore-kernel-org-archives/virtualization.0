Return-Path: <SRS0=lx0b=J6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5283FC43460
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 10:13:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB890611BD
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 10:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB890611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 883BA40553;
	Mon,  3 May 2021 10:13:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZfFmnEqRVn_t; Mon,  3 May 2021 10:13:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBA6940523;
	Mon,  3 May 2021 10:13:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AD40C000D;
	Mon,  3 May 2021 10:13:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25A41C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 10:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07DF083DAC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 10:13:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AE_dx0G7Ch1C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 10:13:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99FCF83DA8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 10:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620036830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfH/Rim8ttUy4kF1walnlnjFDNfkSM8H2CqszcJCsT8=;
 b=BevCE+COvDOK3u4GHQHdjBYuqAK8ilirf44Aztim5XQN3tcBHlVdXkc215Jgj/0RflPCnV
 SKfhT2w2SIIyZuvcjJ+UeN0tQr8oAEWh6lgjEmOlurXHo3xT/Mza0oegDUmtYR8OUGvQ7K
 U7kY1hwNJsr24irOxV418wMyPtfVHDs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-3iDKp0s4Mpe7pnRJzRucGw-1; Mon, 03 May 2021 06:13:48 -0400
X-MC-Unique: 3iDKp0s4Mpe7pnRJzRucGw-1
Received: by mail-wr1-f72.google.com with SMTP id
 67-20020adf81490000b029010756d109e6so3618232wrm.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 May 2021 03:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TfH/Rim8ttUy4kF1walnlnjFDNfkSM8H2CqszcJCsT8=;
 b=L2e6zuZ7EOmebQ1xEuTWtxbarade9BBjzVJghSLpqXgJBbNcu1/9vmPJCNW7OkIsNn
 vVLNOKyrZnKBeGvOqhgGtRO4bVQZ5iQSHLk/2WuPHd9tlK5utDWaSQ1ful+/ffB7mRVg
 0UX2MJU3dLUYSFfEu+5italWVE/H8bANqDcp+lwJ42/lOcjgZ12q+66E93KTCFEVSU9e
 Af7qFL+0NQ1GF0iOsHjo4Bob2TZqaDDFmsBqM3xehKJRQGke5BKJr7LjEnXfL7er1Zys
 TxxYcH8ivhbEjU8ux33p+AQKsi9SRvd7LsZkBR1X8je4uiyP5JJj5APnel3vYoPC0H2s
 gtPA==
X-Gm-Message-State: AOAM533mqV+tj0dgAydUbdIV4rK6ZOEVB+BGXuhm1MJOZlQx1gXtEiT0
 856xF/rH1u2F72/swz/yZ0BZ2hopiMnyEKF2EmaQ0zIKN9k60Ssr5fiP9DLiKyr+RWZqcJMpXXq
 9c2PBynqktxXczm8CZQZh5fqNNh3JiT/QCNbXNKYZBA==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr23980416wrm.392.1620036827527; 
 Mon, 03 May 2021 03:13:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzitx86hh7/AAfqMzT0jIWlPfTNKdYBUPj79ED4tgUYCy6GM6viNYbB0BIqh1/tiBOZIdssSA==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr23980386wrm.392.1620036827214; 
 Mon, 03 May 2021 03:13:47 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c649f.dip0.t-ipconnect.de. [91.12.100.159])
 by smtp.gmail.com with ESMTPSA id d2sm11770212wrs.10.2021.05.03.03.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 May 2021 03:13:46 -0700 (PDT)
To: Mike Rapoport <rppt@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-8-david@redhat.com> <YI5H4yV/c6ReuIDt@kernel.org>
 <5a5a7552-4f0a-75bc-582f-73d24afcf57b@redhat.com>
 <YI/CWg6PrMxcCT2D@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 7/7] fs/proc/kcore: use page_offline_(freeze|unfreeze)
Message-ID: <2f66cbfc-aa29-b3ef-4c6a-0da8b29b56f6@redhat.com>
Date: Mon, 3 May 2021 12:13:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YI/CWg6PrMxcCT2D@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Aili Yao <yaoaili@kingsoft.com>, Michal Hocko <mhocko@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Wei Liu <wei.liu@kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Steven Price <steven.price@arm.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Jiri Bohac <jbohac@suse.cz>, Haiyang Zhang <haiyangz@microsoft.com>,
 Oscar Salvador <osalvador@suse.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>,
 Mike Kravetz <mike.kravetz@oracle.com>
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

On 03.05.21 11:28, Mike Rapoport wrote:
> On Mon, May 03, 2021 at 10:28:36AM +0200, David Hildenbrand wrote:
>> On 02.05.21 08:34, Mike Rapoport wrote:
>>> On Thu, Apr 29, 2021 at 02:25:19PM +0200, David Hildenbrand wrote:
>>>> Let's properly synchronize with drivers that set PageOffline(). Unfreeze
>>>> every now and then, so drivers that want to set PageOffline() can make
>>>> progress.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    fs/proc/kcore.c | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
>>>> index 92ff1e4436cb..3d7531f47389 100644
>>>> --- a/fs/proc/kcore.c
>>>> +++ b/fs/proc/kcore.c
>>>> @@ -311,6 +311,7 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
>>>>    static ssize_t
>>>>    read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>>>>    {
>>>> +	size_t page_offline_frozen = 0;
>>>>    	char *buf = file->private_data;
>>>>    	size_t phdrs_offset, notes_offset, data_offset;
>>>>    	size_t phdrs_len, notes_len;
>>>> @@ -509,6 +510,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>>>>    			pfn = __pa(start) >> PAGE_SHIFT;
>>>>    			page = pfn_to_online_page(pfn);
>>>
>>> Can't this race with page offlining for the first time we get here?
>>
>>
>> To clarify, we have three types of offline pages in the kernel ...
>>
>> a) Pages part of an offline memory section; the memap is stale and not
>> trustworthy. pfn_to_online_page() checks that. We *can* protect against
>> memory offlining using get_online_mems()/put_online_mems(), but usually
>> avoid doing so as the race window is very small (and a problem all over the
>> kernel we basically never hit) and locking is rather expensive. In the
>> future, we might switch to rcu to handle that more efficiently and avoiding
>> these possible races.
>>
>> b) PageOffline(): logically offline pages contained in an online memory
>> section with a sane memmap. virtio-mem calls these pages "fake offline";
>> something like a "temporary" memory hole. The new mechanism I propose will
>> be used to handle synchronization as races can be more severe, e.g., when
>> reading actual page content here.
>>
>> c) Soft offline pages: hwpoisoned pages that are not actually harmful yet,
>> but could become harmful in the future. So we better try to remove the page
>> from the page allcoator and try to migrate away existing users.
>>
>>
>> So page_offline_* handle "b) PageOffline()" only. There is a tiny race
>> between pfn_to_online_page(pfn) and looking at the memmap as we have in many
>> cases already throughout the kernel, to be tackled in the future.
> 
> Right, but here you anyway add locking, so why exclude the first iteration?

What we're protecting is PageOffline() below. If I didn't mess up, we 
should always be calling page_offline_freeze() before calling 
PageOffline(). Or am I missing something?

> 
> BTW, did you consider something like

Yes, I played with something like that. We'd have to handle the first 
page_offline_freeze() freeze differently, though, and that's where 
things got a bit ugly in my attempts.

> 
> 	if (page_offline_frozen++ % MAX_ORDER_NR_PAGES == 0) {
> 		page_offline_unfreeze();
> 		cond_resched();
> 		page_offline_freeze();
> 	}
> 
> We don't seem to care about page_offline_frozen overflows here, do we?

No, the buffer size is also size_t and gets incremented on a per-byte 
basis. The variant I have right now looked the cleanest to me. Happy to 
hear simpler alternatives.


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
