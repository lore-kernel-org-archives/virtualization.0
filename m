Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29336C433DF
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 10:23:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9921620578
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 10:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2FE544J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9921620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F289086FEC;
	Mon, 19 Oct 2020 10:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xmQfdxNqnn6D; Mon, 19 Oct 2020 10:23:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 66BF086EAD;
	Mon, 19 Oct 2020 10:23:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 486CBC088B;
	Mon, 19 Oct 2020 10:23:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36F6AC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 10:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 32F3C86DD1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 10:23:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aPv-q_Mx_usq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 10:23:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5821F86D2A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 10:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603102979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dClCYoDEHGrmREG2sQsLlOLmsyhbsQZOxw+llhuTikA=;
 b=i2FE544Jx957q32E8RquAgfNIB3BCXY499nVlfXFHxvq05Kc3YG7BmeBf9Nos0OiagZu5t
 xT49ALndmI9jwpjov3JtX5qGMQ6nP6bFk9103N6UUEvamo34ZUSCEZNsrl2CjEpOVl/IRj
 ovgqodQnzEA3WmbMvEpicPNmML1L5+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-sPW-dcUcMnKKgPRZkQiKug-1; Mon, 19 Oct 2020 06:22:55 -0400
X-MC-Unique: sPW-dcUcMnKKgPRZkQiKug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63CAB10199A8;
 Mon, 19 Oct 2020 10:22:53 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 336545B4A4;
 Mon, 19 Oct 2020 10:22:45 +0000 (UTC)
Subject: Re: [PATCH v1 21/29] virtio-mem: memory notifier callbacks are
 specific to Sub Block Mode (SBM)
To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-22-david@redhat.com>
 <20201019015724.GA54484@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <794b68b2-a3da-5354-4a3b-62f94224c0a6@redhat.com>
Date: Mon, 19 Oct 2020 12:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019015724.GA54484@L-31X9LVDL-1304.local>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On 19.10.20 03:57, Wei Yang wrote:
> On Mon, Oct 12, 2020 at 02:53:15PM +0200, David Hildenbrand wrote:
>> Let's rename accordingly.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> drivers/virtio/virtio_mem.c | 29 +++++++++++++++--------------
>> 1 file changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index 3a772714fec9..d06c8760b337 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -589,8 +589,8 @@ static bool virtio_mem_contains_range(struct virtio_mem *vm, uint64_t start,
>> 	return start >= vm->addr && start + size <= vm->addr + vm->region_size;
>> }
>>
>> -static int virtio_mem_notify_going_online(struct virtio_mem *vm,
>> -					  unsigned long mb_id)
>> +static int virtio_mem_sbm_notify_going_online(struct virtio_mem *vm,
>> +					      unsigned long mb_id)
> 
> Look into this patch with "virtio-mem: Big Block Mode (BBM) memory hotplug"
> together, I thought the code is a little "complex".
> 
> The final logic of virtio_mem_memory_notifier_cb() looks like this:
> 
>     virtio_mem_memory_notifier_cb()
>         if (vm->in_sbm)
> 	    notify_xxx()
>         if (vm->in_sbm)
> 	    notify_xxx()
> 
> Can we adjust this like
> 
>     virtio_mem_memory_notifier_cb()
> 	notify_xxx()
>             if (vm->in_sbm)
>                 return
> 	notify_xxx()
>             if (vm->in_sbm)
>                 return
> 
> This style looks a little better to me.

Then we lose all the shared code after any of the mode-specific
handling? Like we have in MEM_OFFLINE, MEM_ONLINE, MEM_CANCEL_OFFLINE, ...

Don't think this will improve the situation.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
