Return-Path: <SRS0=JY8S=IR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CC5C433DB
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 14:16:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C265E64E5B
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 14:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C265E64E5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D6B183CA9;
	Fri, 19 Mar 2021 14:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K4sSDuUYruoX; Fri, 19 Mar 2021 14:16:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07EB183C7D;
	Fri, 19 Mar 2021 14:16:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D478EC000F;
	Fri, 19 Mar 2021 14:16:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6DA6C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 14:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D47CB83CA3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 14:16:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KPJsw1QoRvvp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 14:16:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFC8E83C7D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616163381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9zw8CBtfbLr4B7lOytRKxO98oyOVaQpoL0ZeKO0tUA=;
 b=hpa8ZcdlwUCYGhzE6vxDqJVaPXqHgaIJmvCei9GfL0D8unSJBpm+z+8n093DnvAQXw1e0Z
 z6t95hz+HOgUW8oCJBFY53ibZaBTs9aabuIsOeoMEH2z2s/7PMbqpOGLrC7X57e5JCyLUw
 2eMYVU+XguOdYTnZU3Txl1uoLJ1Ee2c=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-1H3OQ5rQOMaQ6M0pgNCx9A-1; Fri, 19 Mar 2021 10:16:18 -0400
X-MC-Unique: 1H3OQ5rQOMaQ6M0pgNCx9A-1
Received: by mail-ot1-f69.google.com with SMTP id d16so14011764otc.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 07:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G9zw8CBtfbLr4B7lOytRKxO98oyOVaQpoL0ZeKO0tUA=;
 b=Gteai+RGT0HTY/zjgr92fqyuiAEdgrRIOCgwasj+t3xTenXtDN6qlgkrbHsYF/TNTr
 O8bzCKAJISRaqUNF6r6OzFJJl8yHIZIXROoanGlKd+dCCfk7Gc6w6jRXTXIr00o9WlwK
 lEDaVCYu9Okif0liHu312vthmOO6bQyntRfApvutzPZhwpVPMROwjfBm/E/aw/wobrxP
 Vns5x9rmIdlxwZ/J+LhDIg1rQ+QQs68U3hZfFUV/AGBuV+NEvHn6fg1GoaUNcLgiEzbh
 DYVRciatToKbyiB9dl17eaD/dGNDEOE8bsQQzc3wK7M33vR4MRdQGA8bibk1pZcJ05rI
 cv0g==
X-Gm-Message-State: AOAM530luAhy28YLoWYmbO/h2CaX7lcy/EEtW2gNyszWepdps5T+18hZ
 n7/gNDS192naqzbP73SxR9U2ZD2DIYLRC9xoaC67eBfm3SlTc/oAfj9q91Y2Ut9a2PGjVQ14j2X
 U0RrM3nUWRaUWPGIHDVFU2pMyxB2wKKSZJikhkKQopQ==
X-Received: by 2002:a4a:9843:: with SMTP id z3mr1589794ooi.51.1616163377366;
 Fri, 19 Mar 2021 07:16:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx2MNWNkKfrw15p1iOgcE1WNwGab8mOM64AvISX48wKkP2zrsJ388mw1npd31B6KpqhIwamA==
X-Received: by 2002:a4a:9843:: with SMTP id z3mr1589778ooi.51.1616163377153;
 Fri, 19 Mar 2021 07:16:17 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 v6sm1253529ook.40.2021.03.19.07.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Mar 2021 07:16:16 -0700 (PDT)
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
To: Vivek Goyal <vgoyal@redhat.com>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
 <20210319134948.GA402287@redhat.com>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <6a44908d-7e2d-d239-c56a-68730c5357cd@redhat.com>
Date: Fri, 19 Mar 2021 09:16:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210319134948.GA402287@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: miklos@szeredi.hu, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org
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

On 3/19/21 8:49 AM, Vivek Goyal wrote:
> On Thu, Mar 18, 2021 at 08:52:22AM -0500, Connor Kuehl wrote:
>> If an incoming FUSE request can't fit on the virtqueue, the request is
>> placed onto a workqueue so a worker can try to resubmit it later where
>> there will (hopefully) be space for it next time.
>>
>> This is fine for requests that aren't larger than a virtqueue's maximum
>> capacity. However, if a request's size exceeds the maximum capacity of
>> the virtqueue (even if the virtqueue is empty), it will be doomed to a
>> life of being placed on the workqueue, removed, discovered it won't fit,
>> and placed on the workqueue yet again.
>>
>> Furthermore, from section 2.6.5.3.1 (Driver Requirements: Indirect
>> Descriptors) of the virtio spec:
>>
>>    "A driver MUST NOT create a descriptor chain longer than the Queue
>>    Size of the device."
>>
>> To fix this, limit the number of pages FUSE will use for an overall
>> request. This way, each request can realistically fit on the virtqueue
>> when it is decomposed into a scattergather list and avoid violating
>> section 2.6.5.3.1 of the virtio spec.
> 
> Hi Connor,
> 
> So as of now if a request is bigger than what virtqueue can support,
> it never gets dispatched and caller waits infinitely? So this patch
> will fix it by forcing fuse to split the request. That sounds good.

Right, in theory. Certain configurations make it easier to avoid this 
from happening, such as using indirect descriptors; however, in that 
case, the virtio spec says even if indirect descriptors are used, the 
descriptor chain length shouldn't exceed the length of the queue's size 
anyways. So having FUSE split the request also helps to uphold that 
property.

This is my reading of the potential looping problem:

virtio_fs_wake_pending_and_unlock
   calls
     virtio_fs_enqueue_req
       calls
         virtqueue_add_sgs

virtqueue_add_sgs can return -ENOSPC if there aren't enough descriptors 
available.

This error gets propagated back down to 
virtio_fs_wake_pending_and_unlock which checks for this exact issue and 
places the request on a workqueue to retry submission later.

Resubmission occurs in virtio_fs_request_dispatch_work, which does a 
similar dance, where if the request fails with -ENOSPC it just puts it 
back in the queue. However, for a sufficiently large request that would 
exceed the capacity of the virtqueue (even when empty), no amount of 
retrying will ever make it fit.

> 
> 
> [..]
>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>> index 8868ac31a3c0..a6ffba85d59a 100644
>> --- a/fs/fuse/virtio_fs.c
>> +++ b/fs/fuse/virtio_fs.c
>> @@ -18,6 +18,12 @@
>>   #include <linux/uio.h>
>>   #include "fuse_i.h"
>>   
>> +/* Used to help calculate the FUSE connection's max_pages limit for a request's
>> + * size. Parts of the struct fuse_req are sliced into scattergather lists in
>> + * addition to the pages used, so this can help account for that overhead.
>> + */
>> +#define FUSE_HEADER_OVERHEAD    4
> 
> How did yo arrive at this overhead. Is it following.
> 
> - One sg element for fuse_in_header.
> - One sg element for input arguments.
> - One sg element for fuse_out_header.
> - One sg element for output args.

Yes, that's exactly how I got to that number.

Connor


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
