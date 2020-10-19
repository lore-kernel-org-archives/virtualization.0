Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D528AC433DF
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 09:04:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347A420874
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 09:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOmL2U2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347A420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8D12686E2C;
	Mon, 19 Oct 2020 09:04:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g5pdGIfmpnfe; Mon, 19 Oct 2020 09:04:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E5D6185F95;
	Mon, 19 Oct 2020 09:04:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9AC0C0891;
	Mon, 19 Oct 2020 09:04:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB631C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 09:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AC64E8707D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 09:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QxQA4mENKuUp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 09:04:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9C29687044
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 09:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603098293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YN6WDY3oBcjnMWDUE8tH8DebUWuolXBVNxsWQNIqYJs=;
 b=GOmL2U2LZ2HSmEiFFfo7kjnpv/bq/cZ46waK1QEsVsyXP74xqBRLA+NXP1jXXTNBJk4UVX
 HI2bYkGsE6gabP8O4VDD/U6NZIXh49AZAATyuaL4jAWOfYjBNQ4HASrWG2UVgKhq/sDgdl
 mVXJDwdwRQbk3G0BOg2lq38Qj7dOzAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-Yo9k6QCxO1CcpnrFsWtE_A-1; Mon, 19 Oct 2020 05:04:50 -0400
X-MC-Unique: Yo9k6QCxO1CcpnrFsWtE_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72497104D3E3;
 Mon, 19 Oct 2020 09:04:49 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AAA21A4D6;
 Mon, 19 Oct 2020 09:04:42 +0000 (UTC)
Subject: Re: [PATCH v1 09/29] virtio-mem: don't always trigger the workqueue
 when offlining memory
To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-10-david@redhat.com>
 <20201016040301.GJ86495@L-31X9LVDL-1304.local>
 <82afba4e-66e2-ce05-c092-267301b66de9@redhat.com>
 <20201018035725.GA50506@L-31X9LVDL-1304>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5103e899-0ca2-0804-dee8-772b5737d34d@redhat.com>
Date: Mon, 19 Oct 2020 11:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201018035725.GA50506@L-31X9LVDL-1304>
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

On 18.10.20 05:57, Wei Yang wrote:
> On Fri, Oct 16, 2020 at 11:18:39AM +0200, David Hildenbrand wrote:
>> On 16.10.20 06:03, Wei Yang wrote:
>>> On Mon, Oct 12, 2020 at 02:53:03PM +0200, David Hildenbrand wrote:
>>>> Let's trigger from offlining code when we're not allowed to touch online
> 
> Here "touch" means "unplug"? If so, maybe s/touch/unplug/ would be more easy
> to understand.

Yes, much better.

[...]

> I am trying to get more understanding about the logic of virtio_mem_retry().
> 
> Current logic seems clear to me. There are four places to trigger it:
> 
>     * notify_offline
>     * notify_online
>     * timer_expired
>     * config_changed
> 
> In this patch, we try to optimize the first case, notify_offline.

Yes.

> 
> Now, we would always trigger retry when one of our memory block get offlined.
> Per my understanding, this logic is correct while missed one case (or be more
> precise, not handle one case timely). The case this patch wants to improve is
> virtio_mem_mb_remove(). If my understanding is correct.
> 

Yes, that's one part of it. Read below.

>    virtio_mem_run_wq()
>        virtio_mem_unplug_request()
>            virtio_mem_mb_unplug_any_sb_offline()
>  	      virtio_mem_mb_remove()             --- 1
>            virtio_mem_mb_unplug_any_sb_online()
>               virtio_mem_mb_offline_and_remove() --- 2
> 
> The above is two functions this patch adjusts. For 2), it will offline the
> memory block, thus will trigger virtio_mem_retry() originally. But for 1), the
> memory block is already offlined, so virtio_mem_retry() will not be triggered
> originally. This is the case we want to improve in this patch. Instead of wait
> for timer expire, we trigger retry immediately after unplug/remove an offlined
> memory block.
> 
> And after this change, this patch still adjust the original
> virtio_mem_notify_offline() path to just trigger virtio_mem_retry() when
> unplug_online is false. (This means the offline event is notified from user
> space instead of from unplug event).
> 
> If my above analysis is correct, I got one small suggestion for this patch.
> Instead of adjust current notify_offline handling, how about just trigger
> retry during virtio_mem_mb_remove()? Since per my understanding, we just want
> to do immediate trigger retry when unplug an offlined memory block.

I probably should have added the following to the patch description:

"This is a preparation for Big Block Mode (BBM), whereby we can see some
temporary offlining of memory blocks without actually making progress"

Imagine you have a Big Block that spans to Linux memory blocks. Assume
the first Linux memory blocks has no unmovable data on it.

Assume you call offline_and_remove_memory()

1. Try to offline the first block. Works, notifiers triggered.
virtio_mem_retry().
2. Try to offline the second block. Does not work.
3. Re-online first block.
4. Exit to main loop, exit workqueue.
5. Retry immediately (due to virtio_mem_retry()), go to 1.

So, you'll keep retrying forever. Found while debugging that exact issue :)


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
