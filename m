Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3FEC5519F
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 09:00:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60041241A5
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 09:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUQenL0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60041241A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 917E2204F0;
	Wed, 18 Nov 2020 09:00:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HtwPI05wx8z2; Wed, 18 Nov 2020 09:00:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4980F204C5;
	Wed, 18 Nov 2020 09:00:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC12C0800;
	Wed, 18 Nov 2020 09:00:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6028C07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 69225867A1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:00:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id st6S0f+gqlTi
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 08:59:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 552CF86672
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 08:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605689998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gxx/VvkoJZ4QkIxP+qyRXmDmA8Z61VJCEEV8lV2lfkE=;
 b=CUQenL0tsEeJCscxfnIkkjF1lMlx2bL6H9BP7i1XTjxW4zP/61+bUovGUtY5wpzTTnA2Xt
 ue7uEjde/qz3KmbYWL8ijPHsCpzOtM8kIkk0ZAbIZF3Irn+WOeOThp4OHe/7wQp3J0tUOM
 GrweTCVd/WycaLRkk4gHL+uY2hdgdcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-RRR1uNM8PaKjgEH3DAAXIA-1; Wed, 18 Nov 2020 03:59:54 -0500
X-MC-Unique: RRR1uNM8PaKjgEH3DAAXIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD26110074B1;
 Wed, 18 Nov 2020 08:59:52 +0000 (UTC)
Received: from [10.36.114.231] (ovpn-114-231.ams2.redhat.com [10.36.114.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD2C360C43;
 Wed, 18 Nov 2020 08:59:46 +0000 (UTC)
Subject: Re: [PATCH v2 27/29] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
To: Andrew Morton <akpm@linux-foundation.org>
References: <20201112133815.13332-1-david@redhat.com>
 <20201112133815.13332-28-david@redhat.com>
 <20201117205301.bcef9773f3557a764d17b8df@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <842683af-0a1e-78ea-5b94-178eaf8f3239@redhat.com>
Date: Wed, 18 Nov 2020 09:59:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201117205301.bcef9773f3557a764d17b8df@linux-foundation.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>
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

On 18.11.20 05:53, Andrew Morton wrote:
> On Thu, 12 Nov 2020 14:38:13 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> virtio-mem soon wants to use offline_and_remove_memory() memory that
>> exceeds a single Linux memory block (memory_block_size_bytes()). Let's
>> remove that restriction.
>>
>> Let's remember the old state and try to restore that if anything goes
>> wrong. While re-onlining can, in general, fail, it's highly unlikely to
>> happen (usually only when a notifier fails to allocate memory, and these
>> are rather rare).
>>
>> This will be used by virtio-mem to offline+remove memory ranges that are
>> bigger than a single memory block - for example, with a device block
>> size of 1 GiB (e.g., gigantic pages in the hypervisor) and a Linux memory
>> block size of 128MB.
>>
>> While we could compress the state into 2 bit, using 8 bit is much
>> easier.
>>
>> This handling is similar, but different to acpi_scan_try_to_offline():
>>
>> a) We don't try to offline twice. I am not sure if this CONFIG_MEMCG
>> optimization is still relevant - it should only apply to ZONE_NORMAL
>> (where we have no guarantees). If relevant, we can always add it.
>>
>> b) acpi_scan_try_to_offline() simply onlines all memory in case
>> something goes wrong. It doesn't restore previous online type. Let's do
>> that, so we won't overwrite what e.g., user space configured.
>>
>> ...
>>
> 
> uint8_t is a bit of a mouthful.  u8 is less typing ;)  Doesn't matter.

In case I have to resend, I'll change it :)

> 
> Acked-by: Andrew Morton <akpm@linux-foundation.org>

Thanks!


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
