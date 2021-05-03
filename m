Return-Path: <SRS0=lx0b=J6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80455C43462
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:16:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5EA561359
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EA561359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75ABC605B0;
	Mon,  3 May 2021 08:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id asUdGh0SvksH; Mon,  3 May 2021 08:16:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A23A6060D;
	Mon,  3 May 2021 08:16:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D16C2C000D;
	Mon,  3 May 2021 08:16:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 484F0C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34DFF83EEF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vy9t0EMaTWZl
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:16:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D5B583DD3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 08:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620029768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uB/EYYvRDIWzIKd9NUtpds132sJrn5ZaXZy/6UA0sM=;
 b=VZB1iDFbtPLrzaSGD81gg/kYOIvxINyTptqlvF0OeArO8imipNzYhU6IbWY11T8e3CggGl
 n3qg/023pft56MCXX36gSPreFEVRnTentmo5mP656j63uf3mI5fbUpG6bt6PRI2JTgH0bR
 LUGWCJY/DEflkSBMdnd6zBipOjWxAgM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-NoV__bMAMVqv1Dz8nc80nw-1; Mon, 03 May 2021 04:16:06 -0400
X-MC-Unique: NoV__bMAMVqv1Dz8nc80nw-1
Received: by mail-ed1-f70.google.com with SMTP id
 m18-20020a0564025112b0290378d2a266ebso4082002edd.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 May 2021 01:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3uB/EYYvRDIWzIKd9NUtpds132sJrn5ZaXZy/6UA0sM=;
 b=D1lwCk6FB++IsXM1BGCfxPQl3dNb2F9NdsfNO3KNMZuCSgnnwQ/PriigCADMPYU8CB
 kvavsIFiOtkRpMZucY14LCMJdg4DBPJsSuZQSVWa20nFQE+CJrhHcDtyANycXtl1y+7V
 Xa+8scHJ+0/FgeSIuD94nHJLJLXN1RqqlB9W4nsl73WfLcN/RZ1HTQNnkEtg1WusegYW
 XFqpQozEy0d22OvxdnCaNd3lSGAFvq1LXiwlkFdJLiLBhSMZ7Xopbep1rY2B2/zmehef
 rYzz1W353hD0RyVIGlr/n5045nj1+apEypUXQqZUlusIz23YlDLN88lDBfiwcMFshpRn
 ZkWw==
X-Gm-Message-State: AOAM532FMnVfcjjQVt8ch2oh6mksVA65oIR/VOXKI+yPAWJkF21zut6G
 qu+exNn6zteDd3eHFoHUpQ1T3iAIoChLnHE5wv8hYwH97/NG5dhJyknILxy6HS86vJg8bLrHQfV
 dFbdrBmpG8DY+bSKBsmTs5kTBbHG/BZE7KVC4lhrQDQ==
X-Received: by 2002:a17:906:8147:: with SMTP id
 z7mr11677896ejw.496.1620029764874; 
 Mon, 03 May 2021 01:16:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5t6QJnu76x0vRJx5wjyCiN1MvkzdCqG/1DMVBAPOiuRhGpdYa0HWbVhYZGZKhNk34vPvb6A==
X-Received: by 2002:a17:906:8147:: with SMTP id
 z7mr11677854ejw.496.1620029764611; 
 Mon, 03 May 2021 01:16:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c649f.dip0.t-ipconnect.de. [91.12.100.159])
 by smtp.gmail.com with ESMTPSA id lr15sm4554094ejb.107.2021.05.03.01.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 May 2021 01:16:04 -0700 (PDT)
Subject: Re: [PATCH v1 6/7] virtio-mem: use page_offline_(start|end) when
 setting PageOffline()
To: Mike Rapoport <rppt@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-7-david@redhat.com> <YI5HzXN7+ZTNXtcI@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <98f22a46-da8b-2891-fade-09937c0ccf69@redhat.com>
Date: Mon, 3 May 2021 10:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YI5HzXN7+ZTNXtcI@kernel.org>
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

On 02.05.21 08:33, Mike Rapoport wrote:
> On Thu, Apr 29, 2021 at 02:25:18PM +0200, David Hildenbrand wrote:
>> Let's properly use page_offline_(start|end) to synchronize setting
>> PageOffline(), so we won't have valid page access to unplugged memory
>> regions from /proc/kcore.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   drivers/virtio/virtio_mem.c | 2 ++
>>   mm/util.c                   | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index 10ec60d81e84..dc2a2e2b2ff8 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -1065,6 +1065,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
>>   static void virtio_mem_set_fake_offline(unsigned long pfn,
>>   					unsigned long nr_pages, bool onlined)
>>   {
>> +	page_offline_begin();
>>   	for (; nr_pages--; pfn++) {
>>   		struct page *page = pfn_to_page(pfn);
>>   
>> @@ -1075,6 +1076,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
>>   			ClearPageReserved(page);
>>   		}
>>   	}
>> +	page_offline_end();
> 
> I'm not really familiar with ballooning and memory hotplug, but is it the
> only place that needs page_offline_{begin,end} ?

Existing balloon implementations that I am aware of (Hyper-V, XEN, 
virtio-balloon, vmware-balloon) usually allow reading inflated memory; 
doing so might result in unnecessary overhead in the hypervisor, so we 
really want to avoid it -- but it's strictly not forbidden and has been 
working forever. So we barely care about races: if there would be a rare 
race, we'd still be able to read that memory.

For virtio-mem, it'll be different in the future when using shmem, huge 
pages, !anonymous private mappings, ... as backing storage for a VM; 
there will be a virtio spec extension to document that virtio-mem 
changes that indicate the new behavior won't allow reading unplugged 
memory and doing so will result in undefined behavior.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
