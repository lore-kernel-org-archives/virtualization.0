Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28CEC43457
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 08:51:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7087A20790
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 08:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+Px0ttA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7087A20790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F0B9E8727B;
	Mon, 19 Oct 2020 08:50:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Y5+ecd4QRl5; Mon, 19 Oct 2020 08:50:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C0C0D87265;
	Mon, 19 Oct 2020 08:50:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2DA6C0052;
	Mon, 19 Oct 2020 08:50:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 369D2C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 08:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 09EC72045D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 08:50:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbwZeCl874ri
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 08:50:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 306972043D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 08:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603097451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+GLhGk+DGr7aqMMN9qogQIvYXULDe5V4KCY/zVX1ro=;
 b=d+Px0ttAQJYwG5DhU0LtjeSuqHn6s9Pyatq7hs3a0CS+aqu4Qllljn/wECjZXekvT4lVbk
 dsi0gGlF3DCMR86CbHtcPCTS8BzQ4n2pNCgyX6mKj5QQj3tATPXoHiy9B3ZQtIAOKUBvno
 e0rjZIZprM6cO/20YKxdCh5aszK5s38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-zf7Z9wQlPKyxDxftXp6dLA-1; Mon, 19 Oct 2020 04:50:49 -0400
X-MC-Unique: zf7Z9wQlPKyxDxftXp6dLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F9F310A0B83;
 Mon, 19 Oct 2020 08:50:48 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8A7B50B44;
 Mon, 19 Oct 2020 08:50:41 +0000 (UTC)
Subject: Re: [PATCH v1 29/29] virtio-mem: Big Block Mode (BBM) - safe memory
 hotunplug
To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-30-david@redhat.com>
 <20201019075406.GE54484@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e7f7d154-a1e3-0a89-743e-69f51c0e06fc@redhat.com>
Date: Mon, 19 Oct 2020 10:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019075406.GE54484@L-31X9LVDL-1304.local>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 19.10.20 09:54, Wei Yang wrote:
> On Mon, Oct 12, 2020 at 02:53:23PM +0200, David Hildenbrand wrote:
>> Let's add a safe mechanism to unplug memory, avoiding long/endless loops
>> when trying to offline memory - similar to in SBM.
>>
>> Fake-offline all memory (via alloc_contig_range()) before trying to
>> offline+remove it. Use this mode as default, but allow to enable the other
>> mode explicitly (which could give better memory hotunplug guarantees in
> 
> I don't get the point how unsafe mode would have a better guarantees?

It's primarily only relevant when there is a lot of concurrent action
going on while unplugging memory. Using alloc_contig_range() on
ZONE_MOVABLE can fail more easily than memory offlining.

alloc_contig_range() doesn't try as hard as memory offlining code to
isolate memory. There are known issues with temporary page pinning
(e.g., when a process dies) and the PCP. (mostly discovered via CMA
allocations)

See the TODO I add in patch #14.

[...]
>>
>> +	if (bbm_safe_unplug) {
>> +		/*
>> +		 * Start by fake-offlining all memory. Once we marked the device
>> +		 * block as fake-offline, all newly onlined memory will
>> +		 * automatically be kept fake-offline. Protect from concurrent
>> +		 * onlining/offlining until we have a consistent state.
>> +		 */
>> +		mutex_lock(&vm->hotplug_mutex);
>> +		virtio_mem_bbm_set_bb_state(vm, bb_id,
>> +					    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE);
>> +
> 
> State is set here.
> 
>> +		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>> +			page = pfn_to_online_page(pfn);
>> +			if (!page)
>> +				continue;
>> +
>> +			rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
>> +			if (rc) {
>> +				end_pfn = pfn;
>> +				goto rollback_safe_unplug;
>> +			}
>> +		}
>> +		mutex_unlock(&vm->hotplug_mutex);
>> +	}
>> +
>> 	rc = virtio_mem_bbm_offline_and_remove_bb(vm, bb_id);
>> -	if (rc)
>> +	if (rc) {
>> +		if (bbm_safe_unplug) {
>> +			mutex_lock(&vm->hotplug_mutex);
>> +			goto rollback_safe_unplug;
>> +		}
>> 		return rc;
>> +	}
>>
>> 	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
>> 	if (rc)
> 
> And changed to PLUGGED or UNUSED based on rc.

Right, after offlining+remove succeeded. So no longer added to Linux.

The final state depends on the success of the unplug request towards the
hypervisor.

> 
>> @@ -1987,6 +2069,17 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
>> 		virtio_mem_bbm_set_bb_state(vm, bb_id,
>> 					    VIRTIO_MEM_BBM_BB_UNUSED);
>> 	return rc;
>> +
>> +rollback_safe_unplug:
>> +	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>> +		page = pfn_to_online_page(pfn);
>> +		if (!page)
>> +			continue;
>> +		virtio_mem_fake_online(pfn, PAGES_PER_SECTION);
>> +	}
>> +	virtio_mem_bbm_set_bb_state(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED);
> 
> And changed to ADDED if failed.

Right, back to the initial state when entering this function.

> 
>> +	mutex_unlock(&vm->hotplug_mutex);
>> +	return rc;
>> }
> 
> So in which case, the bbm state is FAKE_OFFLINE during
> virtio_mem_bbm_notify_going_offline() and
> virtio_mem_bbm_notify_cancel_offline() ?

Exactly, so we can do our magic with fake-offline pages and our
virtio_mem_bbm_offline_and_remove_bb() can actually succeed.


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
