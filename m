Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74AEC433DB
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 14:41:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CCE207A9
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 14:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CCE207A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DFD0E870D3;
	Tue, 26 Jan 2021 14:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5plEavkb9kaC; Tue, 26 Jan 2021 14:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B81187083;
	Tue, 26 Jan 2021 14:41:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DED2DC0FA7;
	Tue, 26 Jan 2021 14:41:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA932C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 14:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D10138526D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 14:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ATnnbfkJpVEQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 14:41:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 45D388525D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611672074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lpQ5FIdDj86dAJrmmf5VYfY1DlwRO3+NvNwOL07qIDw=;
 b=JzkU8chpbP+ZXG+0y5nz9vxUpObgAOtniyb8uN1FWyLpzhsyn1ssyjN1h0CoYFJ/pr9yf7
 04fqDa2+n9E48fpE68dthH4aeFbbH2jMICehjUIipEmW7C3+5l+Qtha9dANPteQlN5XpDA
 7B1KWv7nE3Ypyr/JfovQf8RA93+DHiY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-JA4yjm3NOpWU_HBIag4lsw-1; Tue, 26 Jan 2021 09:41:11 -0500
X-MC-Unique: JA4yjm3NOpWU_HBIag4lsw-1
Received: by mail-wr1-f72.google.com with SMTP id u3so11202978wri.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 06:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lpQ5FIdDj86dAJrmmf5VYfY1DlwRO3+NvNwOL07qIDw=;
 b=BGTDaI99X1bG4tHaaXzweBmKZbvlDpR+7WSORUEQiozGx1eoaKog3/PZObawdvKOrR
 D4N4BQL55YVmZAgC9AHN1SpiUUfd5PZNzuBKmhzo1z9s9pnzjBic+VFBcvhZ6Afg6Zk4
 u4IXbWvuBK69dbBmkw0Q2I8OYULiJjSXCwiBWh9wmXCSIg+SCaH9FXfT1Le596jDLTTk
 7D5KHYNPKcQ7OjH3Hq6txM3Jjgzvoe/uwhFg7B1p5plbJo7WwwMCvgx2A1EuoqO+YWTW
 0HvU4+RKK2Q+Rsul13LeRHR6mtUDnvOhkxJ7VEiFB36cDQngYACXMDFKE8TB2XNnT7pk
 0v/Q==
X-Gm-Message-State: AOAM532DH437oxMnvW9spQXBlJPpp6Y2M5EdhK7mRLzhRVHVGNWwgOJ0
 iLTr9w6AXr0c7suG7uzs8B/U14KZdl1ccIP4G6xxXO/7Lu1STRagsWUxjzLWX0QuLd5udOz3axj
 1/ah9SaRwD+2Ury1bRlmfX5QffhNZDzx+Q4Da4Xnbqw==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr6488589wrq.258.1611672069388; 
 Tue, 26 Jan 2021 06:41:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz39NDd6BmGGfj8bbtVOHXLcl2Kc7EC7CxqUvm9YDLAkU4h3pGT+kzWVgom/wIh//yZaOjzQw==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr6488565wrq.258.1611672069262; 
 Tue, 26 Jan 2021 06:41:09 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id k15sm3578856wmj.6.2021.01.26.06.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jan 2021 06:41:08 -0800 (PST)
Date: Tue, 26 Jan 2021 09:41:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] mm/memory_hotplug: MEMHP_MERGE_RESOURCE ->
 MHP_MERGE_RESOURCE
Message-ID: <20210126094058-mutt-send-email-mst@kernel.org>
References: <20210126115829.10909-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210126115829.10909-1-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Juergen Gross <jgross@suse.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Liu <wei.liu@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>, linux-hyperv@vger.kernel.org,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>,
 virtualization@lists.linux-foundation.org, Oscar Salvador <osalvador@suse.de>
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

On Tue, Jan 26, 2021 at 12:58:29PM +0100, David Hildenbrand wrote:
> Let's make "MEMHP_MERGE_RESOURCE" consistent with "MHP_NONE", "mhp_t" and
> "mhp_flags". As discussed recently [1], "mhp" is our internal
> acronym for memory hotplug now.
> 
> [1] https://lore.kernel.org/linux-mm/c37de2d0-28a1-4f7d-f944-cfd7d81c334d@redhat.com/
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/hv/hv_balloon.c        | 2 +-
>  drivers/virtio/virtio_mem.c    | 2 +-
>  drivers/xen/balloon.c          | 2 +-
>  include/linux/memory_hotplug.h | 2 +-
>  mm/memory_hotplug.c            | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 8c471823a5af..2f776d78e3c1 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -726,7 +726,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  
>  		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
>  		ret = add_memory(nid, PFN_PHYS((start_pfn)),
> -				(HA_CHUNK << PAGE_SHIFT), MEMHP_MERGE_RESOURCE);
> +				(HA_CHUNK << PAGE_SHIFT), MHP_MERGE_RESOURCE);
>  
>  		if (ret) {
>  			pr_err("hot_add memory failed error is %d\n", ret);
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 85a272c9978e..148bea39b09a 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -623,7 +623,7 @@ static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
>  	/* Memory might get onlined immediately. */
>  	atomic64_add(size, &vm->offline_size);
>  	rc = add_memory_driver_managed(vm->nid, addr, size, vm->resource_name,
> -				       MEMHP_MERGE_RESOURCE);
> +				       MHP_MERGE_RESOURCE);
>  	if (rc) {
>  		atomic64_sub(size, &vm->offline_size);
>  		dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index b57b2067ecbf..671c71245a7b 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -331,7 +331,7 @@ static enum bp_state reserve_additional_memory(void)
>  	mutex_unlock(&balloon_mutex);
>  	/* add_memory_resource() requires the device_hotplug lock */
>  	lock_device_hotplug();
> -	rc = add_memory_resource(nid, resource, MEMHP_MERGE_RESOURCE);
> +	rc = add_memory_resource(nid, resource, MHP_MERGE_RESOURCE);
>  	unlock_device_hotplug();
>  	mutex_lock(&balloon_mutex);
>  
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 3d99de0db2dd..4b834f5d032e 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -53,7 +53,7 @@ typedef int __bitwise mhp_t;
>   * with this flag set, the resource pointer must no longer be used as it
>   * might be stale, or the resource might have changed.
>   */
> -#define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
> +#define MHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
>  
>  /*
>   * Extended parameters for memory hotplug:
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 710e469fb3a1..ae497e3ff77c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1153,7 +1153,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  	 * In case we're allowed to merge the resource, flag it and trigger
>  	 * merging now that adding succeeded.
>  	 */
> -	if (mhp_flags & MEMHP_MERGE_RESOURCE)
> +	if (mhp_flags & MHP_MERGE_RESOURCE)
>  		merge_system_ram_resource(res);
>  
>  	/* online pages if requested */
> -- 
> 2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
