Return-Path: <SRS0=lx0b=J6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE2AC433B4
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:28:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7BC6121E
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7BC6121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7BE681A23;
	Mon,  3 May 2021 08:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QW1uWiQg-jl9; Mon,  3 May 2021 08:28:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51C4983B89;
	Mon,  3 May 2021 08:28:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32650C000D;
	Mon,  3 May 2021 08:28:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBF86C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9FC9C60AF6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:28:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NmnXJ4-sF894
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:28:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C47E60B0E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620030521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oeOHRYo4V+sjXuBsEphc00viyXFIqMXEH0Oj0f+S1EU=;
 b=Mj+l2yoR6S/M4tP4lcyMK1XPZ9jyPTsaxiNkSMUFx0QOcE2Os3LDUS3fqJotYayX1hn4DM
 8c2wAtCZXF5iteutp8OLdhxVk4QkgQnn/0yRRELEHCFzwN3duH59oqWXcIRHmsUknts2yt
 GeZD8AlAV3t6250OeaAMu+mYjbrYaRg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-7RSnJ5bENN6US-xw2a9wWA-1; Mon, 03 May 2021 04:28:39 -0400
X-MC-Unique: 7RSnJ5bENN6US-xw2a9wWA-1
Received: by mail-wr1-f70.google.com with SMTP id
 a7-20020adfc4470000b029010d875c66edso3468215wrg.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 May 2021 01:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=oeOHRYo4V+sjXuBsEphc00viyXFIqMXEH0Oj0f+S1EU=;
 b=didvmkPLb3k9aBbrgNUCXRD+EqOdHLSj3dLw7H7ndnW6nlU93066AD5ogzINMJraje
 7HdpaSlFfvnfdJoz4mMpLD5oyG67e3isT8YgY1CrmdGE2veFUksqW5LzOnMNziUQM4zI
 /YwAOhMjDa6s12L9/HCtA0gqGVkQ68g7KanS6g1+qg+AVyviX00TbLiw9zED2pMPJ/O1
 jf06dj2hQwExETTF2m6r9bmPY3NASuOdv/MCzQW1vRVx9l8OyoQ9RNg+4e3k2gJbp33b
 c8CxbEjYu8KnvxZIlDtD94xF+fNlHF/OquV3MFRCBtTVMOIxte2XCyyN2uTIt6CnbO3+
 QH9Q==
X-Gm-Message-State: AOAM533PgwPk2GQKkBYftSmGO6JXR5kKy5SFy1e8+4lp4s0JI9S6Dyz6
 RCsVs2aZKi2zsN7OaUx9FHW2SusyX6Gar7yPG4iOfS/+JxtMDle8rNCVsDE7d27h/f3lZp8yHYN
 YElnMITlbuk20K/GOuzHoIjGxis3Bgxvilv5vvXyHXg==
X-Received: by 2002:a5d:6d85:: with SMTP id l5mr22979379wrs.22.1620030517789; 
 Mon, 03 May 2021 01:28:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaIYYprmCHdbWEQG0UKlOnfr25C8JpbLNd+9kN/fx46K8mzScJzZQz2ZSZd2ki6w32eeO6Cw==
X-Received: by 2002:a5d:6d85:: with SMTP id l5mr22979345wrs.22.1620030517468; 
 Mon, 03 May 2021 01:28:37 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c649f.dip0.t-ipconnect.de. [91.12.100.159])
 by smtp.gmail.com with ESMTPSA id r5sm12059190wmh.23.2021.05.03.01.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 May 2021 01:28:37 -0700 (PDT)
To: Mike Rapoport <rppt@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-8-david@redhat.com> <YI5H4yV/c6ReuIDt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 7/7] fs/proc/kcore: use page_offline_(freeze|unfreeze)
Message-ID: <5a5a7552-4f0a-75bc-582f-73d24afcf57b@redhat.com>
Date: Mon, 3 May 2021 10:28:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YI5H4yV/c6ReuIDt@kernel.org>
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

On 02.05.21 08:34, Mike Rapoport wrote:
> On Thu, Apr 29, 2021 at 02:25:19PM +0200, David Hildenbrand wrote:
>> Let's properly synchronize with drivers that set PageOffline(). Unfreeze
>> every now and then, so drivers that want to set PageOffline() can make
>> progress.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   fs/proc/kcore.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
>> index 92ff1e4436cb..3d7531f47389 100644
>> --- a/fs/proc/kcore.c
>> +++ b/fs/proc/kcore.c
>> @@ -311,6 +311,7 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
>>   static ssize_t
>>   read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>>   {
>> +	size_t page_offline_frozen = 0;
>>   	char *buf = file->private_data;
>>   	size_t phdrs_offset, notes_offset, data_offset;
>>   	size_t phdrs_len, notes_len;
>> @@ -509,6 +510,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>>   			pfn = __pa(start) >> PAGE_SHIFT;
>>   			page = pfn_to_online_page(pfn);
> 
> Can't this race with page offlining for the first time we get here?


To clarify, we have three types of offline pages in the kernel ...

a) Pages part of an offline memory section; the memap is stale and not 
trustworthy. pfn_to_online_page() checks that. We *can* protect against 
memory offlining using get_online_mems()/put_online_mems(), but usually 
avoid doing so as the race window is very small (and a problem all over 
the kernel we basically never hit) and locking is rather expensive. In 
the future, we might switch to rcu to handle that more efficiently and 
avoiding these possible races.

b) PageOffline(): logically offline pages contained in an online memory 
section with a sane memmap. virtio-mem calls these pages "fake offline"; 
something like a "temporary" memory hole. The new mechanism I propose 
will be used to handle synchronization as races can be more severe, 
e.g., when reading actual page content here.

c) Soft offline pages: hwpoisoned pages that are not actually harmful 
yet, but could become harmful in the future. So we better try to remove 
the page from the page allcoator and try to migrate away existing users.


So page_offline_* handle "b) PageOffline()" only. There is a tiny race 
between pfn_to_online_page(pfn) and looking at the memmap as we have in 
many cases already throughout the kernel, to be tackled in the future.


(A better name for PageOffline() might make sense; PageSoftOffline() 
would be catchy but interferes with c). PageLogicallyOffline() is ugly; 
PageFakeOffline() might do)

>   
>> +			/*
>> +			 * Don't race against drivers that set PageOffline()
>> +			 * and expect no further page access.
>> +			 */
>> +			if (page_offline_frozen == MAX_ORDER_NR_PAGES) {
>> +				page_offline_unfreeze();
>> +				page_offline_frozen = 0;
>> +				cond_resched();
>> +			}
>> +			if (!page_offline_frozen++)
>> +				page_offline_freeze();
>> +
> 
> Don't we need to freeze before doing pfn_to_online_page()?

See my explanation above. Thanks!

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
