Return-Path: <SRS0=H6i0=NZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A96CC433EF
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 07:02:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF9D60F9C
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 07:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAF9D60F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1BE9835A6;
	Fri,  3 Sep 2021 07:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T0o4RAKTzSbo; Fri,  3 Sep 2021 07:02:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4999F83521;
	Fri,  3 Sep 2021 07:02:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B6EFC0010;
	Fri,  3 Sep 2021 07:02:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8B80C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 07:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B14FA425DA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 07:02:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EP8mwb-tTPWW
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 07:02:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02C28425D8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 07:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630652532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=07FgH7wT67po2w8bQGIw93/1x6mvSaBB2yNe5PGszL8=;
 b=HuTHYlizEorAg8tiOA18ayRy/5msQRMqonLlPwKCDRdOi9AkmEUMJaDGiQxUAmOqwsQHYk
 ++EtljYOLW62EYZvSscgCDgyUeTX1kxmm+3PX1cM72NOI205mtbJx83jMMM9JPPmzdQIPQ
 lFVefrli/B7LDafj8PfWnAydi+YpFLI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-EIEBxxKJMM2bXDhxNwS8EQ-1; Fri, 03 Sep 2021 03:02:12 -0400
X-MC-Unique: EIEBxxKJMM2bXDhxNwS8EQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 t15-20020a5d42cf000000b001565f9c9ee8so1261059wrr.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Sep 2021 00:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=07FgH7wT67po2w8bQGIw93/1x6mvSaBB2yNe5PGszL8=;
 b=nnkmecp5X+oXlDBrvEhv6vr4lUciE8GysDN+WRaASDwaivuPR3f5ovgD8nYJN0KoWB
 Gn/xXOIdYDm7CsbmtY1wGWjTfZxuI/ypjZWlXsfl9D8k9y/hIBe9Cj0GD2l78+e8DhT9
 VMNQWKDBV3QVtVIB/S7DZbXXtl5Tz05hIZiRFxb7yj2g/3zIpgl56tQj3WVkHzKpaWtn
 sFuXffsZPgtqcwmkO71AtL2BN0jIVFL03v7iTXanAs5DUodo3Mc67nslCsnFaBvhslAu
 MvDoFPuegbVqvSzdkBkaO6tUxTJ8Gu4ngOETwwMgbY8yTr6nZqgErauBm/xEVpai+nVL
 88+A==
X-Gm-Message-State: AOAM530J0rn/GnfAg2mccy1ZO9aX9wrBPCwYd4ojtLoB6p08b3a6WT6v
 HQYmH9neunfY/rSE+PAbRTxge/BYnGWH41isMwVBweK9SvrmwYl/ZYV1xA3YQtiTq/Yq/B/5q2P
 lO1oSbzH+tZ1Apd2epZfwHoT+/i6WBlQx3FENjR1eYQ==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr2223527wrv.402.1630652530798; 
 Fri, 03 Sep 2021 00:02:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydsWfnmMs9uEFqCpYm22oyb0W/h3tDknscsNUxRfbHoKaj/53aSdqrSr8X//PvyYQLUFL9pw==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr2223485wrv.402.1630652530498; 
 Fri, 03 Sep 2021 00:02:10 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207f:7f47:ccd3:7600:6a2d:c5a])
 by smtp.gmail.com with ESMTPSA id x9sm3336534wmi.30.2021.09.03.00.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 00:02:08 -0700 (PDT)
Date: Fri, 3 Sep 2021 03:02:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 3/3] virtio-mem: disallow mapping virtio-mem memory
 via /dev/mem
Message-ID: <20210903025630-mutt-send-email-mst@kernel.org>
References: <20210902160919.25683-1-david@redhat.com>
 <20210902160919.25683-4-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210902160919.25683-4-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>
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

On Thu, Sep 02, 2021 at 06:09:19PM +0200, David Hildenbrand wrote:
> We don't want user space to be able to map virtio-mem device memory
> directly (e.g., via /dev/mem) in order to have guarantees that in a sane
> setup we'll never accidentially access unplugged memory within the
> device-managed region of a virtio-mem device, just as required by the
> virtio-spec.
> 
> As soon as the virtio-mem driver is loaded, the device region is visible
> in /proc/iomem via the parent device region. From that point on user space
> is aware of the device region and we want to disallow mapping anything
> inside that region (where we will dynamically (un)plug memory) until
> the driver has been unloaded cleanly and e.g., another driver might take
> over.
> 
> By creating our parent IORESOURCE_SYSTEM_RAM resource with
> IORESOURCE_EXCLUSIVE, we will disallow any /dev/mem access to our
> device region until the driver was unloaded cleanly and removed the
> parent region. This will work even though only some memory blocks are
> actually currently added to Linux and appear as busy in the resource tree.
> 
> So access to the region from user space is only possible
> a) if we don't load the virtio-mem driver.
> b) after unloading the virtio-mem driver cleanly.
> 
> Don't build virtio-mem if access to /dev/mem cannot be restricticted --
> if we have CONFIG_DEVMEM=y but CONFIG_STRICT_DEVMEM is not set.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>


> ---
>  drivers/virtio/Kconfig      | 1 +
>  drivers/virtio/virtio_mem.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index ce1b3f6ec325..ff80cd03f1d1 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -101,6 +101,7 @@ config VIRTIO_MEM
>  	depends on MEMORY_HOTPLUG_SPARSE
>  	depends on MEMORY_HOTREMOVE
>  	depends on CONTIG_ALLOC
> +	depends on !DEVMEM || STRICT_DEVMEM
>  	help
>  	 This driver provides access to virtio-mem paravirtualized memory
>  	 devices, allowing to hotplug and hotunplug memory.

It would be nicer if there was a symbol in the MEMORY_ namespace
we can depend on exported by mm and depending on !DEVMEM ||
STRICT_DEVMEM.

E.g.

config MEMORY_EXCLUSIVE
        def_bool y
        depends on !DEVMEM || STRICT_DEVMEM

and then in virtio
	depends on MEMORY_EXCLUSIVE


the virtio change itself is ok though:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

for merging through -mm.

> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index b91bc810a87e..c2d93492cf0f 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2523,8 +2523,10 @@ static int virtio_mem_create_resource(struct virtio_mem *vm)
>  	if (!name)
>  		return -ENOMEM;
>  
> +	/* Disallow mapping device memory via /dev/mem completely. */
>  	vm->parent_resource = __request_mem_region(vm->addr, vm->region_size,
> -						   name, IORESOURCE_SYSTEM_RAM);
> +						   name, IORESOURCE_SYSTEM_RAM |
> +						   IORESOURCE_EXCLUSIVE);
>  	if (!vm->parent_resource) {
>  		kfree(name);
>  		dev_warn(&vm->vdev->dev, "could not reserve device region\n");
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
