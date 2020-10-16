Return-Path: <SRS0=Urmt=DX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FDEC43457
	for <virtualization@archiver.kernel.org>; Fri, 16 Oct 2020 13:13:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBB62084C
	for <virtualization@archiver.kernel.org>; Fri, 16 Oct 2020 13:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geY0X6mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBB62084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 12C6D8892A;
	Fri, 16 Oct 2020 13:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yLyR4ikuW1cS; Fri, 16 Oct 2020 13:13:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 52E3588922;
	Fri, 16 Oct 2020 13:13:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 426D1C0052;
	Fri, 16 Oct 2020 13:13:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39DFDC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 13:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 274BF88924
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 13:13:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X3rf2k4bbj5W
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 13:13:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D749388922
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 13:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602854026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/GCi79zDDWJnh1oE+IGSqyeTEpkoS02M8NJnTnJPBQA=;
 b=geY0X6mruhE5+3ps4JmedbcSTfrjixu0AIe6gWcRD8NSzEFGBaFfDb2QtTe7V5WKCp9Qjq
 XET6pX3r69DYWr9N4B0q0GGACmoBEtxb8ZToE/ePpiocZPTpAApTHmQ5Ntdfr4uR+05GXx
 49H5AESGc/8b35nGS1v3cEC+r1k5vV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419--GoBk286PPSx0wVv5pyA3A-1; Fri, 16 Oct 2020 09:13:41 -0400
X-MC-Unique: -GoBk286PPSx0wVv5pyA3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 740DE8030BE;
 Fri, 16 Oct 2020 13:13:39 +0000 (UTC)
Received: from [10.36.113.23] (ovpn-113-23.ams2.redhat.com [10.36.113.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 797975D9D5;
 Fri, 16 Oct 2020 13:13:33 +0000 (UTC)
Subject: Re: [PATCH v1 25/29] virtio-mem: Big Block Mode (BBM) memory hotplug
To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-26-david@redhat.com>
 <20201016093835.GH44269@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7abe3109-741c-b7ed-8d83-fc7c42c7f843@redhat.com>
Date: Fri, 16 Oct 2020 15:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016093835.GH44269@L-31X9LVDL-1304.local>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On 16.10.20 11:38, Wei Yang wrote:
> On Mon, Oct 12, 2020 at 02:53:19PM +0200, David Hildenbrand wrote:
>> Currently, we do not support device block sizes that exceed the Linux
>> memory block size. For example, having a device block size of 1 GiB (e.g.,
>> gigantic pages in the hypervisor) won't work with 128 MiB Linux memory
>> blocks.
>>
>> Let's implement Big Block Mode (BBM), whereby we add/remove at least
>> one Linux memory block at a time. With a 1 GiB device block size, a Big
>> Block (BB) will cover 8 Linux memory blocks.
>>
>> We'll keep registering the online_page_callback machinery, it will be used
>> for safe memory hotunplug in BBM next.
>>
>> Note: BBM is properly prepared for variable-sized Linux memory
>> blocks that we might see in the future. So we won't care how many Linux
>> memory blocks a big block actually spans, and how the memory notifier is
>> called.
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
>> drivers/virtio/virtio_mem.c | 484 ++++++++++++++++++++++++++++++------
>> 1 file changed, 402 insertions(+), 82 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index e68d0d99590c..4d396ef98a92 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -30,12 +30,18 @@ MODULE_PARM_DESC(unplug_online, "Try to unplug online memory");
>> /*
>>  * virtio-mem currently supports the following modes of operation:
>>  *
>> - * * Sub Block Mode (SBM): A Linux memory block spans 1..X subblocks (SB). The
>> + * * Sub Block Mode (SBM): A Linux memory block spans 2..X subblocks (SB). The
>>  *   size of a Sub Block (SB) is determined based on the device block size, the
>>  *   pageblock size, and the maximum allocation granularity of the buddy.
>>  *   Subblocks within a Linux memory block might either be plugged or unplugged.
>>  *   Memory is added/removed to Linux MM in Linux memory block granularity.
>>  *
>> + * * Big Block Mode (BBM): A Big Block (BB) spans 1..X Linux memory blocks.
>> + *   Memory is added/removed to Linux MM in Big Block granularity.
>> + *
>> + * The mode is determined automatically based on the Linux memory block size
>> + * and the device block size.
>> + *
>>  * User space / core MM (auto onlining) is responsible for onlining added
>>  * Linux memory blocks - and for selecting a zone. Linux Memory Blocks are
>>  * always onlined separately, and all memory within a Linux memory block is
>> @@ -61,6 +67,19 @@ enum virtio_mem_sbm_mb_state {
>> 	VIRTIO_MEM_SBM_MB_COUNT
>> };
>>
>> +/*
>> + * State of a Big Block (BB) in BBM, covering 1..X Linux memory blocks.
>> + */
>> +enum virtio_mem_bbm_bb_state {
>> +	/* Unplugged, not added to Linux. Can be reused later. */
>> +	VIRTIO_MEM_BBM_BB_UNUSED = 0,
>> +	/* Plugged, not added to Linux. Error on add_memory(). */
>> +	VIRTIO_MEM_BBM_BB_PLUGGED,
>> +	/* Plugged and added to Linux. */
>> +	VIRTIO_MEM_BBM_BB_ADDED,
>> +	VIRTIO_MEM_BBM_BB_COUNT
>> +};
>> +
>> struct virtio_mem {
>> 	struct virtio_device *vdev;
>>
>> @@ -113,6 +132,9 @@ struct virtio_mem {
>> 	atomic64_t offline_size;
>> 	uint64_t offline_threshold;
>>
>> +	/* If set, the driver is in SBM, otherwise in BBM. */
>> +	bool in_sbm;
>> +
>> 	struct {
>> 		/* Id of the first memory block of this device. */
>> 		unsigned long first_mb_id;
>> @@ -151,9 +173,27 @@ struct virtio_mem {
>> 		unsigned long *sb_states;
>> 	} sbm;
>>
>> +	struct {
>> +		/* Id of the first big block of this device. */
>> +		unsigned long first_bb_id;
>> +		/* Id of the last usable big block of this device. */
>> +		unsigned long last_usable_bb_id;
>> +		/* Id of the next device bock to prepare when needed. */
>> +		unsigned long next_bb_id;
>> +
>> +		/* Summary of all big block states. */
>> +		unsigned long bb_count[VIRTIO_MEM_BBM_BB_COUNT];
>> +
>> +		/* One byte state per big block. See sbm.mb_states. */
>> +		uint8_t *bb_states;
>> +
>> +		/* The block size used for (un)plugged, adding/removing. */
>> +		uint64_t bb_size;
>> +	} bbm;
> 
> Can we use a union here?

As I had the same thought initially, it most probably makes sense :)

Thanks!


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
