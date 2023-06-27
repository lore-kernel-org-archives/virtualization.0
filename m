Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C52EB64DC
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 13:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 001B241B46;
	Tue, 27 Jun 2023 13:14:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 001B241B46
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=am4sD++9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tGB4Ac6hdk8R; Tue, 27 Jun 2023 13:14:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0438C401D3;
	Tue, 27 Jun 2023 13:14:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0438C401D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC864C007C;
	Tue, 27 Jun 2023 13:14:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9846BC0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 13:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 705FD41697
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 13:14:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 705FD41697
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bWXLM0Yd7RHF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 13:14:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E8A0401D3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2E8A0401D3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 13:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xr3MnWCaYQoh+mxzisQXAS9kK17MGURfaRMV8GgA6To=;
 b=am4sD++9Grj/U2grbY5z3pw+9vounwHdnUqTUic2G0VjHVlAP3SOyg08NmbxzSimWEqlpT
 9b5GjpArZ5OTreDI2GdQ3Ec2HYXOeSQ4nZvYTkungILrHRcRUBH/uXnGt/Df9jaOkGq8Lo
 AyepvA12PYd8H3MV9vim6JC/0ce/Dos=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-rLKuSTIePcSxF5QLMgPz6A-1; Tue, 27 Jun 2023 09:14:14 -0400
X-MC-Unique: rLKuSTIePcSxF5QLMgPz6A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f9bef91aa4so29049605e9.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 06:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687871653; x=1690463653;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xr3MnWCaYQoh+mxzisQXAS9kK17MGURfaRMV8GgA6To=;
 b=NUFV3K4mdS578xEGj06jLXXSuk+O643k79v1wPHBxkpX/Ob5O2w9g5YjqAQyQo0FDf
 SmZkbGf3V7NPBEfSr4XG3FMEmzBwnHjRu+mNkvOKPjJW/jvbFDb/Jey8dUKHPMu9F/mg
 QUTwTKSkNnyBX4yPL5zPPWeFI0dllZi78DqMu0SJx2gCQIDyZ8uROJhLD0qSpLQTprDR
 I2rdQyCeTeCiTyMbEfRAwWBHrdKfIBXBne/82mA9/qD2RxmcpwjOaa1rG8E+3N7cPs7A
 TT0p9PyjsV0ZZUEJisUr6BKEAmLC9RhNNjM++PS16YVP2sdHQtgDg3kHzNbCs+2lqNz6
 68eg==
X-Gm-Message-State: AC+VfDz3z20uMWhAsi5hM2h77owkjOKjWVnTbua6CGLA32ZWocuINwIL
 2uG/tNtpnb3euufCTXbzoRVRhBG67yS69fLFGX+muUIime/j5r3jkTxQ0SmgFrlIAeSP6ZVH6QE
 5WHIqj2uppL9BKroLErIDUfZ/vBFu5eD1u/WZhv+BJw==
X-Received: by 2002:a7b:c017:0:b0:3f7:aad8:4e05 with SMTP id
 c23-20020a7bc017000000b003f7aad84e05mr25894506wmb.11.1687871653450; 
 Tue, 27 Jun 2023 06:14:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6jPe2n9lCZVjh6G47APR7hQm7cv3dmFUt5cTIyprmkTo8/GF2dG+yghkrXAmZXtcjVtznmIQ==
X-Received: by 2002:a7b:c017:0:b0:3f7:aad8:4e05 with SMTP id
 c23-20020a7bc017000000b003f7aad84e05mr25894478wmb.11.1687871653032; 
 Tue, 27 Jun 2023 06:14:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:4900:68b3:e93b:e07a:558b?
 (p200300cbc737490068b3e93be07a558b.dip0.t-ipconnect.de.
 [2003:cb:c737:4900:68b3:e93b:e07a:558b])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a05600c378b00b003fa95f328afsm6173913wmr.29.2023.06.27.06.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 06:14:12 -0700 (PDT)
Message-ID: <74cbbdd3-5a05-25b1-3f81-2fd47e089ac3@redhat.com>
Date: Tue, 27 Jun 2023 15:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Michal Hocko <mhocko@suse.com>
References: <20230627112220.229240-1-david@redhat.com>
 <20230627112220.229240-4-david@redhat.com> <ZJrYv0JIcrNyf2py@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/5] mm/memory_hotplug: make
 offline_and_remove_memory() timeout instead of failing on fatal signals
In-Reply-To: <ZJrYv0JIcrNyf2py@dhcp22.suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>
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

On 27.06.23 14:40, Michal Hocko wrote:
> On Tue 27-06-23 13:22:18, David Hildenbrand wrote:
>> John Hubbard writes [1]:
>>
>>          Some device drivers add memory to the system via memory hotplug.
>>          When the driver is unloaded, that memory is hot-unplugged.
>>
>>          However, memory hot unplug can fail. And these days, it fails a
>>          little too easily, with respect to the above case. Specifically, if
>>          a signal is pending on the process, hot unplug fails.
>>
>>          [...]
>>
>>          So in this case, other things (unmovable pages, un-splittable huge
>>          pages) can also cause the above problem. However, those are
>>          demonstrably less common than simply having a pending signal. I've
>>          got bug reports from users who can trivially reproduce this by
>>          killing their process with a "kill -9", for example.
> 
> This looks like a bug of the said driver no? If the tear down process is
> killed it could very well happen right before offlining so you end up in
> the very same state. Or what am I missing?

IIUC (John can correct me if I am wrong):

1) The process holds the device node open
2) The process gets killed or quits
3) As the process gets torn down, it closes the device node
4) Closing the device node results in the driver removing the device and
    calling offline_and_remove_memory()

So it's not a "tear down process" that triggers that offlining_removal 
somehow explicitly, it's just a side-product of it letting go of the 
device node as the process gets torn down.

>   
>> Especially with ZONE_MOVABLE, offlining is supposed to work in most
>> cases when offlining actually hotplugged (not boot) memory, and only fail
>> in rare corner cases (e.g., some driver holds a reference to a page in
>> ZONE_MOVABLE, turning it unmovable).
>>
>> In these corner cases we really don't want to be stuck forever in
>> offline_and_remove_memory(). But in the general cases, we really want to
>> do our best to make memory offlining succeed -- in a reasonable
>> timeframe.
>>
>> Reliably failing in the described case when there is a fatal signal pending
>> is sub-optimal. The pending signal check is mostly only relevant when user
>> space explicitly triggers offlining of memory using sysfs device attributes
>> ("state" or "online" attribute), but not when coming via
>> offline_and_remove_memory().
>>
>> So let's use a timer instead and ignore fatal signals, because they are
>> not really expressive for offline_and_remove_memory() users. Let's default
>> to 30 seconds if no timeout was specified, and limit the timeout to 120
>> seconds.
> 
> I really hate having timeouts back. They just proven to be hard to get
> right and it is essentially a policy implemented in the kernel. They
> simply do not belong to the kernel space IMHO.

As much as I agree with you in terms of offlining triggered from user 
space (e.g., write "state" or "online" attribute) where user-space is 
actually in charge  and can do something reasonable (timeout, retry, 
whatever), in these the offline_and_remove_memory() case it's the driver 
that wants a best-effort memory offlining+removal.

If it times out, virtio-mem will simply try another block or retry 
later. Right now, it could get stuck forever in 
offline_and_remove_memory(), which is obviously "not great". 
Fortunately, for virtio-mem it's configurable and we use the 
alloc_contig_range()-method for now as default.

If it would time out for John's driver, we most certainly don't want to 
be stuck in offline_and_remove_memory(), blocking device/driver 
unloading (and even a reboot IIRC) possibly forever.


I much rather have offline_and_remove_memory() indicate "timeout" to a 
in-kernel user a bit earlier than getting stuck in there forever. The 
timeout parameter allows for giving the in-kernel users a bit of 
flexibility, which I showcases for virtio-mem that unplugs smaller 
blocks and rather wants to fail fast and retry later.


Sure, we could make the timeout configurable to optimize for some corner 
cases, but that's not really what offline_and_remove_memory() users want 
and I doubt anybody would fine-tune that: they want a best-effort 
attempt. And that's IMHO not really a policy, it's an implementation 
detail of these drivers.

For example, the driver from John could simply never call 
offline_and_remove_memory() and always require a reboot when wanting to 
reuse a device. But that's definitely what users want.

virtio-mem could simply never call offline_and_remove_memory() and 
indicate "I don't support unplug of these online memory blocks". But 
that's *definitely* not what users want.


I'm very open for alternatives regarding offline_and_remove_memory(), so 
far this was the only reasonable thing I could come up with that 
actually achieves what we want for these users: not get stuck in there 
forever but rather fail earlier than later.

And most importantly, not somehow try to involve user space that isn't 
even in charge of the offlining operation.

-- 
Cheers,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
