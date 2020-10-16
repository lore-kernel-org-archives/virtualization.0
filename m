Return-Path: <SRS0=Urmt=DX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D90C433E7
	for <virtualization@archiver.kernel.org>; Fri, 16 Oct 2020 09:18:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E199220872
	for <virtualization@archiver.kernel.org>; Fri, 16 Oct 2020 09:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tc4D7wDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E199220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4BB60882E7;
	Fri, 16 Oct 2020 09:18:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rcOG5SCA6MAf; Fri, 16 Oct 2020 09:18:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82058877D4;
	Fri, 16 Oct 2020 09:18:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E294C07FF;
	Fri, 16 Oct 2020 09:18:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D134C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 09:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E584F2E70F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 09:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XNtlqyy8ricq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 09:18:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id D6C972E70E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 09:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602839928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkDAPJVLLNu9aqbT2ZGJGKmJO7QPtcaA3nJyCliA/rs=;
 b=Tc4D7wDssbMYWcxY5eJQvSl350RZbQG8X5Oh6O3Ojnhyo3oc1VWL5zFIcHASmjGX2IEhJ2
 EKr9X36PbP6Ir7dpm36KFivyURQxh5dUCJCPqDmOQ2/7T+brKk+VXyBi/c11ZiWogwlgmi
 Sfw3hIn61wsgGqsT7f7tWXsrf6+gXJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-N2dJj4zyMFWma92NUVlemw-1; Fri, 16 Oct 2020 05:18:46 -0400
X-MC-Unique: N2dJj4zyMFWma92NUVlemw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2142284BA66;
 Fri, 16 Oct 2020 09:18:45 +0000 (UTC)
Received: from [10.36.113.23] (ovpn-113-23.ams2.redhat.com [10.36.113.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 817366EF70;
 Fri, 16 Oct 2020 09:18:40 +0000 (UTC)
Subject: Re: [PATCH v1 09/29] virtio-mem: don't always trigger the workqueue
 when offlining memory
To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-10-david@redhat.com>
 <20201016040301.GJ86495@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <82afba4e-66e2-ce05-c092-267301b66de9@redhat.com>
Date: Fri, 16 Oct 2020 11:18:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016040301.GJ86495@L-31X9LVDL-1304.local>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

On 16.10.20 06:03, Wei Yang wrote:
> On Mon, Oct 12, 2020 at 02:53:03PM +0200, David Hildenbrand wrote:
>> Let's trigger from offlining code when we're not allowed to touch online
>> memory.
> 
> This describes the change in virtio_mem_memory_notifier_cb()?

Ah, yes, can try to make that clearer.

> 
>>
>> Handle the other case (memmap possibly freeing up another memory block)
>> when actually removing memory. When removing via virtio_mem_remove(),
>> virtio_mem_retry() is a NOP and safe to use.
>>
>> While at it, move retry handling when offlining out of
>> virtio_mem_notify_offline(), to share it with Device Block Mode (DBM)
>> soon.
> 
> I may not understand the logic fully. Here is my understanding of current
> logic:
> 
> 
>   virtio_mem_run_wq()
>       virtio_mem_unplug_request()
>           virtio_mem_mb_unplug_any_sb_offline()
> 	      virtio_mem_mb_remove()             --- 1
> 	  virtio_mem_mb_unplug_any_sb_online()
> 	      virtio_mem_mb_offline_and_remove() --- 2
> 
> This patch tries to trigger the wq at 1 and 2. And these two functions are
> only valid during this code flow.

Exactly.

> 
> These two functions actually remove some memory from the system. So I am not
> sure where extra unplug-able memory comes from. I guess those memory is from
> memory block device and mem_sectioin, memmap? While those memory is still
> marked as online, right?

Imagine you end up (only after some repeating plugging and unplugging of
memory, otherwise it's obviously impossible):

Memory block X: Contains only movable data

Memory block X + 1: Contains memmap of Memory block X:


We start to unplug from high, to low.

1. Try to unplug/offline/remove block X + 1: fails, because of the
   memmap
2. Try to unplug/offline/remove block X: succeeds.
3. Not all requested memory got unplugged. Sleep for 30 seconds.
4. Retry to unplug/offline/remove block X + 1: succeeds

What we do in 2, is that we trigger a retry of ourselves. That means,
that in 3. we don't actually sleep, but retry immediately.

This has been proven helpful in some of my tests, where you want to
unplug *a lot* of memory again, not just some parts.


Triggering a retry is fairly cheap. Assume you don't actually have to
perform any more unplugging. The workqueue wakes up, detects that
nothing is to do, and goes back to sleep.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
