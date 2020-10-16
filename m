Return-Path: <SRS0=Urmt=DX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747B5C433E7
	for <virtualization@archiver.kernel.org>; Fri, 16 Oct 2020 09:11:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27192145D
	for <virtualization@archiver.kernel.org>; Fri, 16 Oct 2020 09:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNB5vZr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27192145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 31E2A88AB2;
	Fri, 16 Oct 2020 09:11:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4iJ49yG3K8U9; Fri, 16 Oct 2020 09:11:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5929488AAD;
	Fri, 16 Oct 2020 09:11:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B710C07FF;
	Fri, 16 Oct 2020 09:11:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0028C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 09:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8E92E88820
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 09:11:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wb4B3g6eWNjO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 09:11:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D2BBB88736
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 09:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602839493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0iuzsKV+en+co/Ft7zltRtGpfmCivUKMQYMYF4dZIE=;
 b=aNB5vZr3C43v+Ylpr04BcuN+kwJHBJIhDoZl+qrC97AONeRrL6WMCWrowutQiNkJ4u3Dcp
 DU29kNCTJuInLuByN1/GPSQe+luONZKZ3v3WS4P+Psy0tH4MXsJP8uWBaK4URBbJkJDUh4
 RFBQOzBZAUj1XgpgGMRn0hc2iGmB4wA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-K1OXnZx8NnSMeViY6FHIoQ-1; Fri, 16 Oct 2020 05:11:31 -0400
X-MC-Unique: K1OXnZx8NnSMeViY6FHIoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5222F1020906;
 Fri, 16 Oct 2020 09:11:30 +0000 (UTC)
Received: from [10.36.113.23] (ovpn-113-23.ams2.redhat.com [10.36.113.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EFE41992D;
 Fri, 16 Oct 2020 09:11:25 +0000 (UTC)
Subject: Re: [PATCH v1 05/29] virtio-mem: generalize check for added memory
To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-6-david@redhat.com>
 <20201015082808.GE86495@L-31X9LVDL-1304.local>
 <994394f3-c16d-911c-c9fc-d2280f32e7b1@redhat.com>
 <20201016021651.GI86495@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5caec772-295c-436a-2b19-ca261ea1ad0c@redhat.com>
Date: Fri, 16 Oct 2020 11:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016021651.GI86495@L-31X9LVDL-1304.local>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

>> That's an interesting corner case. Assume you have a 128MB memory block
>> but only 64MB are plugged.
> 
> Since we just plug a part of memory block, this state is OFFLINE_PARTIAL
> first. But then we would add these memory and online it. This means the state
> of this memory block is ONLINE_PARTIAL.
> 
> When this state is changed to OFFLINE_PARTIAL again?

Please note that memory onlining is *completely* controllable by user
space. User space can offline/online memory blocks as it wants. Not
saying this might actually be the right thing to do - but we cannot
trust that user space does the right thing.

So at any point in time, you have to assume that

a) added memory might not get onlined
b) previously onlined memory might get offlined
c) previously offline memory might get onlined

> 
>>
>> As long as we have our online_pages callback in place, we can hinder the
>> unplugged 64MB from getting exposed to the buddy
>> (virtio_mem_online_page_cb()). However, once we unloaded the driver,
> 
> Yes,
> 
> virtio_mem_set_fake_offline() would __SetPageOffline() to those pages.
> 
>> this is no longer the case. If someone would online that memory block,
>> we would expose unplugged memory to the buddy - very bad.
>>
> 
> Per my understanding, at this point of time, the memory block is at online
> state. Even part of it is set to *fake* offline.
> 
> So how could user trigger another online from sysfs interface?

Assume we added a partially plugged memory block, which is now offline.
Further assume user space did not online the memory block (e.g., no udev
rules).

User space could happily online the block after unloading the driver.
Again, we have to assume user space could do crazy things.

> 
>> So we have to remove these partially plugged, offline memory blocks when
>> losing control over them.
>>
>> I tried to document that via:
>>
>> "After we unregistered our callbacks, user space can online partially
>> plugged offline blocks. Make sure to remove them."
>>
>>>
>>> Also, during virtio_mem_remove(), we just handle OFFLINE_PARTIAL memory block.
>>> How about memory block in other states? It is not necessary to remove
>>> ONLINE[_PARTIAL] memroy blocks?
>>
>> Blocks that are fully plugged (ONLINE or OFFLINE) can get
>> onlined/offlined without us having to care. Works fine - we only have to
>> care about partially plugged blocks.
>>
>> While we *could* unplug OFFLINE blocks, there is no way we can
>> deterministically offline+remove ONLINE blocks. So that memory has to
>> stay, even after we unloaded the driver (similar to the dax/kmem driver).
> 
> For OFFLINE memory blocks, would that leave the situation:
> 
> Guest doesn't need those pages, while host still maps them?

Yes, but the guest could online the memory and make use of it.

(again, whoever decides to unload the driver better be knowing what he does)

To do it even more cleanly, we would

a) Have to remove completely plugged offline blocks (not done)
b) Have to remove partially plugged offline blocks (done)
c) Actually send unplug requests to the hypervisor

Right now, only b) is done, because it might actually cause harm (as
discussed). However, the problem is, that c) might actually fail.

Long short: we could add a) if it turns out to be a real issue. But
than, unloading the driver isn't really suggested, the current
implementation just "keeps it working without crashes" - and I guess
that's good enough for now.

> 
>>
>> ONLINE_PARTIAL is already taken care of: it cannot get offlined anymore,
>> as we still hold references to these struct pages
>> (virtio_mem_set_fake_offline()), and as we no longer have the memory
>> notifier in place, we can no longer agree to offline this memory (when
>> going_offline).
>>
> 
> Ok, I seems to understand the logic now.
> 
> But how we prevent ONLINE_PARTIAL memory block get offlined? There are three
> calls in virtio_mem_set_fake_offline(), while all of them adjust page's flag.
> How they hold reference to struct page?

Sorry, I should have given you the right pointer. (similar to my other
reply)

We hold a reference either via

1. alloc_contig_range()
2. memmap init code, when not calling generic_online_page().

So these fake-offline pages can never be actually offlined, because we
no longer have the memory notifier registered to fix that up.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
