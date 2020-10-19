Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A23C43457
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 09:12:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7658C22200
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 09:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGt5PHXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7658C22200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CE3EF875DD;
	Mon, 19 Oct 2020 09:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id olo960tmKS1Y; Mon, 19 Oct 2020 09:12:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BB4CF875DF;
	Mon, 19 Oct 2020 09:12:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FEEDC0052;
	Mon, 19 Oct 2020 09:12:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73F84C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 09:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 54611870A4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 09:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tZ9vF3WbZW6f
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 09:12:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3A9AA87088
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603098768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e42oimHczO8UN2V6y0CVX1eoq01WDcLuEdKCnGjzh98=;
 b=OGt5PHXSVsqfcUHxi8po4Rvi+Z0m7MYrYI1/kld1Uz7EqWGs0ZsPPo0CeluKkG0J3iJWCg
 dU0gKkqlpOK/MQ2mCeHL3AiGu1F5pJX4/U2g5fni/blsaMQxXgQF4nQs1WYVksWEBkkw0+
 szotTYmYWVBlL3COBT5q1VREtnsLFyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-4GhZDgGZNMKLMyd-CMZb-g-1; Mon, 19 Oct 2020 05:12:43 -0400
X-MC-Unique: 4GhZDgGZNMKLMyd-CMZb-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31FB31018724;
 Mon, 19 Oct 2020 09:12:38 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AE876EF45;
 Mon, 19 Oct 2020 09:12:33 +0000 (UTC)
Subject: Re: [PATCH v1 28/29] virtio-mem: Big Block Mode (BBM) - basic memory
 hotunplug
To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-29-david@redhat.com>
 <20201019034817.GD54484@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3e1c209e-e8bf-c547-fa90-6b73786bc915@redhat.com>
Date: Mon, 19 Oct 2020 11:12:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019034817.GD54484@L-31X9LVDL-1304.local>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

On 19.10.20 05:48, Wei Yang wrote:
> On Mon, Oct 12, 2020 at 02:53:22PM +0200, David Hildenbrand wrote:
>> Let's try to unplug completely offline big blocks first. Then, (if
>> enabled via unplug_offline) try to offline and remove whole big blocks.
>>
>> No locking necessary - we can deal with concurrent onlining/offlining
>> just fine.
>>
>> Note1: This is sub-optimal and might be dangerous in some environments: we
>> could end up in an infinite loop when offlining (e.g., long-term pinnings),
>> similar as with DIMMs. We'll introduce safe memory hotunplug via
>> fake-offlining next, and use this basic mode only when explicitly enabled.
>>
>> Note2: Without ZONE_MOVABLE, memory unplug will be extremely unreliable
>> with bigger block sizes.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> drivers/virtio/virtio_mem.c | 156 +++++++++++++++++++++++++++++++++++-
>> 1 file changed, 155 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index 94cf44b15cbf..6bcd0acbff32 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -388,6 +388,12 @@ static int virtio_mem_bbm_bb_states_prepare_next_bb(struct virtio_mem *vm)
>> 	     _bb_id++) \
>> 		if (virtio_mem_bbm_get_bb_state(_vm, _bb_id) == _state)
>>
>> +#define virtio_mem_bbm_for_each_bb_rev(_vm, _bb_id, _state) \
>> +	for (_bb_id = vm->bbm.next_bb_id - 1; \
>> +	     _bb_id >= vm->bbm.first_bb_id && _vm->bbm.bb_count[_state]; \
>> +	     _bb_id--) \
>> +		if (virtio_mem_bbm_get_bb_state(_vm, _bb_id) == _state)
>> +
>> /*
>>  * Set the state of a memory block, taking care of the state counter.
>>  */
>> @@ -685,6 +691,18 @@ static int virtio_mem_sbm_remove_mb(struct virtio_mem *vm, unsigned long mb_id)
>> 	return virtio_mem_remove_memory(vm, addr, size);
>> }
>>
>> +/*
>> + * See virtio_mem_remove_memory(): Try to remove all Linux memory blocks covered
>> + * by the big block.
>> + */
>> +static int virtio_mem_bbm_remove_bb(struct virtio_mem *vm, unsigned long bb_id)
>> +{
>> +	const uint64_t addr = virtio_mem_bb_id_to_phys(vm, bb_id);
>> +	const uint64_t size = vm->bbm.bb_size;
>> +
>> +	return virtio_mem_remove_memory(vm, addr, size);
>> +}
>> +
>> /*
>>  * Try offlining and removing memory from Linux.
>>  *
>> @@ -731,6 +749,19 @@ static int virtio_mem_sbm_offline_and_remove_mb(struct virtio_mem *vm,
>> 	return virtio_mem_offline_and_remove_memory(vm, addr, size);
>> }
>>
>> +/*
>> + * See virtio_mem_offline_and_remove_memory(): Try to offline and remove a
>> + * all Linux memory blocks covered by the big block.
>> + */
>> +static int virtio_mem_bbm_offline_and_remove_bb(struct virtio_mem *vm,
>> +						unsigned long bb_id)
>> +{
>> +	const uint64_t addr = virtio_mem_bb_id_to_phys(vm, bb_id);
>> +	const uint64_t size = vm->bbm.bb_size;
>> +
>> +	return virtio_mem_offline_and_remove_memory(vm, addr, size);
>> +}
>> +
>> /*
>>  * Trigger the workqueue so the device can perform its magic.
>>  */
>> @@ -1928,6 +1959,129 @@ static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
>> 	return rc;
>> }
>>
>> +/*
>> + * Try to offline and remove a big block from Linux and unplug it. Will fail
>> + * with -EBUSY if some memory is busy and cannot get unplugged.
>> + *
>> + * Will modify the state of the memory block. Might temporarily drop the
>> + * hotplug_mutex.
>> + */
>> +static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
>> +						       unsigned long bb_id)
>> +{
>> +	int rc;
>> +
>> +	if (WARN_ON_ONCE(virtio_mem_bbm_get_bb_state(vm, bb_id) !=
>> +			 VIRTIO_MEM_BBM_BB_ADDED))
>> +		return -EINVAL;
>> +
>> +	rc = virtio_mem_bbm_offline_and_remove_bb(vm, bb_id);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
>> +	if (rc)
>> +		virtio_mem_bbm_set_bb_state(vm, bb_id,
>> +					    VIRTIO_MEM_BBM_BB_PLUGGED);
>> +	else
>> +		virtio_mem_bbm_set_bb_state(vm, bb_id,
>> +					    VIRTIO_MEM_BBM_BB_UNUSED);
>> +	return rc;
>> +}
>> +
>> +/*
>> + * Try to remove a big block from Linux and unplug it. Will fail with
>> + * -EBUSY if some memory is online.
>> + *
>> + * Will modify the state of the memory block.
>> + */
>> +static int virtio_mem_bbm_remove_and_unplug_bb(struct virtio_mem *vm,
>> +					       unsigned long bb_id)
>> +{
>> +	int rc;
>> +
>> +	if (WARN_ON_ONCE(virtio_mem_bbm_get_bb_state(vm, bb_id) !=
>> +			 VIRTIO_MEM_BBM_BB_ADDED))
>> +		return -EINVAL;
>> +
>> +	rc = virtio_mem_bbm_remove_bb(vm, bb_id);
>> +	if (rc)
>> +		return -EBUSY;
>> +
>> +	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
>> +	if (rc)
>> +		virtio_mem_bbm_set_bb_state(vm, bb_id,
>> +					    VIRTIO_MEM_BBM_BB_PLUGGED);
>> +	else
>> +		virtio_mem_bbm_set_bb_state(vm, bb_id,
>> +					    VIRTIO_MEM_BBM_BB_UNUSED);
>> +	return rc;
>> +}
>> +
>> +/*
>> + * Test if a big block is completely offline.
>> + */
>> +static bool virtio_mem_bbm_bb_is_offline(struct virtio_mem *vm,
>> +					 unsigned long bb_id)
>> +{
>> +	const unsigned long start_pfn = PFN_DOWN(virtio_mem_bb_id_to_phys(vm, bb_id));
>> +	const unsigned long nr_pages = PFN_DOWN(vm->bbm.bb_size);
>> +	unsigned long pfn;
>> +
>> +	for (pfn = start_pfn; pfn < start_pfn + nr_pages;
>> +	     pfn += PAGES_PER_SECTION) {
> 
> Can we do the check with memory block granularity?

I had that initially, but the code turned out nicer this way (e.g.,
PAGES_PER_SECTION).

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
