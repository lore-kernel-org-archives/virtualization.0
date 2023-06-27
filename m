Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178D4EB64DD
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 14:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ACFDC417FC;
	Tue, 27 Jun 2023 14:58:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACFDC417FC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AJDPU4GU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6tN04iEaCb50; Tue, 27 Jun 2023 14:58:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 01D83417F4;
	Tue, 27 Jun 2023 14:58:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01D83417F4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3793C0072;
	Tue, 27 Jun 2023 14:58:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49F59C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 14:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1691C6144C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 14:58:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1691C6144C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AJDPU4GU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vRPLIlT5gjia
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 14:58:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 115E361446
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 115E361446
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 14:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687877879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBsZGNNzl56VjNTKNf9g3STGv+bD1DKhCo4+kBNFHLc=;
 b=AJDPU4GUXcRI7B/2yVMxOL8/WWP/T3HhYJZbqF7Euf8Kmx5LYPMbEY6QJiBonoIvULTdy+
 v9dbfUyFSribP0t5deyb1vF1ivStxeS0kCGWuFtJvaIlZTNiVgtNfXgHQiFKfPVbzyyOKr
 LXkmM5DOHD1o/RNgm+vyZvYMZDy2sDM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-3a_5AgASNl2n5xsqhoGrug-1; Tue, 27 Jun 2023 10:57:56 -0400
X-MC-Unique: 3a_5AgASNl2n5xsqhoGrug-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fa871e1eaaso55138095e9.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687877875; x=1690469875;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nBsZGNNzl56VjNTKNf9g3STGv+bD1DKhCo4+kBNFHLc=;
 b=YeJsW0m1zx4rSF+oAI536fLKb8DhVl6E3pYM8WlhPxuwZ9qgFdzpHHfVN339YbGUAq
 ZxrWK6zLRCRS1lsz9RkD5gtNy7X1Ng2ztvdoG6ZRVld+am0JByhjKzqHcztveZyMHu12
 JDjsftBlHUcaTemTIPWa1ZTT8PLhZD8/OupXCBGjwrSmfDhVsAuQBJr8XL8MEIL6Xlhb
 yJOGudx6DO5CIC8Elsv2JxSOK74j+OpQL6FDscOuhKSiO/f9xyz2cOHKdgSn15Nq8rHx
 SYYTiZJv5el2CmgS1JXiY3v4YgeWKxzfD92V6mx1hPiDdxnUUqzQ0E/vsi1MJ4DWU6mh
 9uTQ==
X-Gm-Message-State: AC+VfDwnDidPgQGEcB6Hsbfo6pFVrqVO8/StCWS0qHHbWtEU7k5CnQ1V
 lrmsDyHqwN5qO8fDYi8mG1zI4NuKR7zBw6CrAMt5NYGvX+Zg04oWlC/1PJIz0UwpKefDEeh719l
 /+NLkccLFjS9todliXV9EztQtHkaOy/wEs1pZ0y/KCw==
X-Received: by 2002:a1c:f603:0:b0:3f8:f80e:7b64 with SMTP id
 w3-20020a1cf603000000b003f8f80e7b64mr35939320wmc.17.1687877875235; 
 Tue, 27 Jun 2023 07:57:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4OJIM0ycl9reSJHcWeIgPliu9ko0l3mhlC9E+Sxkbz7ygcqfi/Y9H9AcRdL4MqhL0uGti8Vw==
X-Received: by 2002:a1c:f603:0:b0:3f8:f80e:7b64 with SMTP id
 w3-20020a1cf603000000b003f8f80e7b64mr35939293wmc.17.1687877874781; 
 Tue, 27 Jun 2023 07:57:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:4900:68b3:e93b:e07a:558b?
 (p200300cbc737490068b3e93be07a558b.dip0.t-ipconnect.de.
 [2003:cb:c737:4900:68b3:e93b:e07a:558b])
 by smtp.gmail.com with ESMTPSA id
 k22-20020a05600c0b5600b003fb40f5f553sm3985669wmr.31.2023.06.27.07.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 07:57:54 -0700 (PDT)
Message-ID: <0929f4b9-bdad-bcb4-4192-44e88378016b@redhat.com>
Date: Tue, 27 Jun 2023 16:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Michal Hocko <mhocko@suse.com>
References: <20230627112220.229240-1-david@redhat.com>
 <20230627112220.229240-4-david@redhat.com> <ZJrYv0JIcrNyf2py@dhcp22.suse.cz>
 <74cbbdd3-5a05-25b1-3f81-2fd47e089ac3@redhat.com>
 <ZJrvhACxmaQmmwYP@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/5] mm/memory_hotplug: make
 offline_and_remove_memory() timeout instead of failing on fatal signals
In-Reply-To: <ZJrvhACxmaQmmwYP@dhcp22.suse.cz>
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

On 27.06.23 16:17, Michal Hocko wrote:
> On Tue 27-06-23 15:14:11, David Hildenbrand wrote:
>> On 27.06.23 14:40, Michal Hocko wrote:
>>> On Tue 27-06-23 13:22:18, David Hildenbrand wrote:
>>>> John Hubbard writes [1]:
>>>>
>>>>           Some device drivers add memory to the system via memory hotplug.
>>>>           When the driver is unloaded, that memory is hot-unplugged.
>>>>
>>>>           However, memory hot unplug can fail. And these days, it fails a
>>>>           little too easily, with respect to the above case. Specifically, if
>>>>           a signal is pending on the process, hot unplug fails.
>>>>
>>>>           [...]
>>>>
>>>>           So in this case, other things (unmovable pages, un-splittable huge
>>>>           pages) can also cause the above problem. However, those are
>>>>           demonstrably less common than simply having a pending signal. I've
>>>>           got bug reports from users who can trivially reproduce this by
>>>>           killing their process with a "kill -9", for example.
>>>
>>> This looks like a bug of the said driver no? If the tear down process is
>>> killed it could very well happen right before offlining so you end up in
>>> the very same state. Or what am I missing?
>>
>> IIUC (John can correct me if I am wrong):
>>
>> 1) The process holds the device node open
>> 2) The process gets killed or quits
>> 3) As the process gets torn down, it closes the device node
>> 4) Closing the device node results in the driver removing the device and
>>     calling offline_and_remove_memory()
>>
>> So it's not a "tear down process" that triggers that offlining_removal
>> somehow explicitly, it's just a side-product of it letting go of the device
>> node as the process gets torn down.
> 
> Isn't that just fragile? The operation might fail for other reasons. Why
> cannot there be a hold on the resource to control the tear down
> explicitly?

I'll let John comment on that. But from what I understood, in most 
setups where ZONE_MOVABLE gets used for hotplugged memory 
offline_and_remove_memory() succeeds and allows for reusing the device 
later without a reboot.

For the cases where it doesn't work, a reboot is required.

> 
>>>> Especially with ZONE_MOVABLE, offlining is supposed to work in most
>>>> cases when offlining actually hotplugged (not boot) memory, and only fail
>>>> in rare corner cases (e.g., some driver holds a reference to a page in
>>>> ZONE_MOVABLE, turning it unmovable).
>>>>
>>>> In these corner cases we really don't want to be stuck forever in
>>>> offline_and_remove_memory(). But in the general cases, we really want to
>>>> do our best to make memory offlining succeed -- in a reasonable
>>>> timeframe.
>>>>
>>>> Reliably failing in the described case when there is a fatal signal pending
>>>> is sub-optimal. The pending signal check is mostly only relevant when user
>>>> space explicitly triggers offlining of memory using sysfs device attributes
>>>> ("state" or "online" attribute), but not when coming via
>>>> offline_and_remove_memory().
>>>>
>>>> So let's use a timer instead and ignore fatal signals, because they are
>>>> not really expressive for offline_and_remove_memory() users. Let's default
>>>> to 30 seconds if no timeout was specified, and limit the timeout to 120
>>>> seconds.
>>>
>>> I really hate having timeouts back. They just proven to be hard to get
>>> right and it is essentially a policy implemented in the kernel. They
>>> simply do not belong to the kernel space IMHO.
>>
>> As much as I agree with you in terms of offlining triggered from user space
>> (e.g., write "state" or "online" attribute) where user-space is actually in
>> charge  and can do something reasonable (timeout, retry, whatever), in these
>> the offline_and_remove_memory() case it's the driver that wants a
>> best-effort memory offlining+removal.
>>
>> If it times out, virtio-mem will simply try another block or retry later.
>> Right now, it could get stuck forever in offline_and_remove_memory(), which
>> is obviously "not great". Fortunately, for virtio-mem it's configurable and
>> we use the alloc_contig_range()-method for now as default.
> 
> It seems that offline_and_remove_memory is using a wrong operation then.
> If it wants an opportunistic offlining with some sort of policy. Timeout
> might be just one policy to use but failure mode or a retry count might
> be a better fit for some users. So rather than (ab)using offline_pages,
> would be make more sense to extract basic offlining steps and allow
> drivers like virtio-mem to reuse them and define their own policy?

virtio-mem, in default operation, does that: use alloc_contig_range() to 
logically unplug ("fake offline") that memory and then just trigger 
offline_and_remove_memory() to make it "officially offline".

In that mode, offline_and_remove_memory() cannot really timeout and is 
almost always going to succeed (except memory notifiers and some hugetlb 
dissolving).

Right now we also allow the admin to configure ordinary offlining 
directly (without prior fake offlining) when bigger memory blocks are 
used: offline_pages() is more reliable than alloc_contig_range(), for 
example, because it disables the PCP and the LRU cache, and retries more 
often (well, unfortunately then also forever). It has a higher chance of 
succeeding especially when bigger blocks of memory are offlined+removed.

Maybe we should make the alloc_contig_range()-based mechanism more 
configurable and make it the only mode in virtio-mem, such that we don't 
have to mess with offline_and_remove_memory() endless loops -- at least 
for virtio-mem.

> 
>> If it would time out for John's driver, we most certainly don't want to be
>> stuck in offline_and_remove_memory(), blocking device/driver unloading (and
>> even a reboot IIRC) possibly forever.
> 
> Now I am confused. John driver wants to tear down the device now? There
> is no way to release that memory otherwise AFAIU from the initial
> problem description.

 From what I understood if offline_and_remove_memory() succeeded, the 
device can be reinitialized and used again. Otherwise, a reboot is 
required because that memory is still added to the system.

Thanks Michal!

-- 
Cheers,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
