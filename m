Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED08C433EF
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 01:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F0E7410B1;
	Mon, 29 Nov 2021 01:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VIrEQIo88tty; Mon, 29 Nov 2021 01:12:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3AAF9410AC;
	Mon, 29 Nov 2021 01:12:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09B65C001C;
	Mon, 29 Nov 2021 01:12:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92976C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 01:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78D99402C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 01:12:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AHXuM2G7JfSb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 01:12:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 588ED4018D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 01:12:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1C72061038;
 Mon, 29 Nov 2021 01:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA35C004E1;
 Mon, 29 Nov 2021 01:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638148357;
 bh=aELK/pKqc8nJVVr6JTDLAfcoVvTYsEkVAluHXrd8hcE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=blE2B1O9qDPRBnmqvCoHvHZyM/PO6Zhmyen321mVJeWr/4c1s5wMi3x2AyzXYM6J3
 EdW9lyHNbojTBmko3JWmAdhBPX2Y79TaaRRVfslVcSEDaHgK5hlGIY8WwzQ6XsroCQ
 096xY4vFXFkAp38yJle0uba0XPy3XfKJOYTCKo46IOzqSLyIF5a/AiAJlFCxbpsgWS
 04Pf2vz94BCt5DTiy3L4Tj+fkUDOaqD1fo76BZ8+hrKpxTusxxv3kUGMT9cXmQYkWH
 yW+K6QYOU0JAIVXrwN+RCzWtQaZ0WjdFwDSRSqF8s8PcwT4CSuAP3C8qmUwB2pVTyi
 KUHI0FiA4bppw==
Date: Sun, 28 Nov 2021 20:12:36 -0500
From: Sasha Levin <sashal@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.15 7/7] virtio-mem: support
 VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE
Message-ID: <YaQpBKh+fUJM+p/y@sashalap>
References: <20211126023006.440839-1-sashal@kernel.org>
 <20211126023006.440839-7-sashal@kernel.org>
 <74c1d756-3f7c-7085-0ae9-2c082dce63b2@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <74c1d756-3f7c-7085-0ae9-2c082dce63b2@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Sebastien Boeuf <sebastien.boeuf@intel.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Hui Zhu <teawater@gmail.com>
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

On Fri, Nov 26, 2021 at 09:51:23AM +0100, David Hildenbrand wrote:
>On 26.11.21 03:30, Sasha Levin wrote:
>> From: David Hildenbrand <david@redhat.com>
>>
>> [ Upstream commit 61082ad6a6e1f999eef7e7e90046486c87933b1e ]
>>
>> The initial virtio-mem spec states that while unplugged memory should not
>> be read, the device still has to allow for reading unplugged memory inside
>> the usable region. The primary motivation for this default handling was
>> to simplify bringup of virtio-mem, because there were corner cases where
>> Linux might have accidentially read unplugged memory inside added Linux
>> memory blocks.
>>
>> In the meantime, we:
>> 1. Removed /dev/kmem in commit bbcd53c96071 ("drivers/char: remove
>>    /dev/kmem for good")
>> 2. Disallowed access to virtio-mem device memory via /dev/mem in
>>    commit 2128f4e21aa2 ("virtio-mem: disallow mapping virtio-mem memory via
>>    /dev/mem")
>> 3. Sanitized access to virtio-mem device memory via /proc/kcore in
>>    commit 0daa322b8ff9 ("fs/proc/kcore: don't read offline sections,
>>    logically offline pages and hwpoisoned pages")
>> 4. Sanitized access to virtio-mem device memory via /proc/vmcore in
>>    commit ce2814622e84 ("virtio-mem: kdump mode to sanitize /proc/vmcore
>>    access")
>>
>> "Accidential" access to unplugged memory is no longer possible; we can
>> support the new VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE feature that will be
>> required by some hypervisors implementing virtio-mem in the near future.
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Marek Kedzierski <mkedzier@redhat.com>
>> Cc: Hui Zhu <teawater@gmail.com>
>> Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/virtio/virtio_mem.c     | 1 +
>>  include/uapi/linux/virtio_mem.h | 9 ++++++---
>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index bef8ad6bf4661..78dfdc9c98a1c 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -2758,6 +2758,7 @@ static unsigned int virtio_mem_features[] = {
>>  #if defined(CONFIG_NUMA) && defined(CONFIG_ACPI_NUMA)
>>  	VIRTIO_MEM_F_ACPI_PXM,
>>  #endif
>> +	VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE,
>>  };
>>
>>  static const struct virtio_device_id virtio_mem_id_table[] = {
>> diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
>> index 70e01c687d5eb..e9122f1d0e0cb 100644
>> --- a/include/uapi/linux/virtio_mem.h
>> +++ b/include/uapi/linux/virtio_mem.h
>> @@ -68,9 +68,10 @@
>>   * explicitly triggered (VIRTIO_MEM_REQ_UNPLUG).
>>   *
>>   * There are no guarantees what will happen if unplugged memory is
>> - * read/written. Such memory should, in general, not be touched. E.g.,
>> - * even writing might succeed, but the values will simply be discarded at
>> - * random points in time.
>> + * read/written. In general, unplugged memory should not be touched, because
>> + * the resulting action is undefined. There is one exception: without
>> + * VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, unplugged memory inside the usable
>> + * region can be read, to simplify creation of memory dumps.
>>   *
>>   * It can happen that the device cannot process a request, because it is
>>   * busy. The device driver has to retry later.
>> @@ -87,6 +88,8 @@
>>
>>  /* node_id is an ACPI PXM and is valid */
>>  #define VIRTIO_MEM_F_ACPI_PXM		0
>> +/* unplugged memory must not be accessed */
>> +#define VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE	1
>>
>>
>>  /* --- virtio-mem: guest -> host requests --- */
>>
>
>As 2. and 4. are part of v5.16-rc1 but not v5.15-stable
>
>Nacked-by: David Hildenbrand <david@redhat.com>

I'll drop them, thanks!

-- 
Thanks,
Sasha
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
