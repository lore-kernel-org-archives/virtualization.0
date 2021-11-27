Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE3AC433F5
	for <virtualization@archiver.kernel.org>; Sat, 27 Nov 2021 23:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0160C402C9;
	Sat, 27 Nov 2021 23:10:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 823g_F_gloNQ; Sat, 27 Nov 2021 23:10:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 57081402D8;
	Sat, 27 Nov 2021 23:10:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D42B3C0030;
	Sat, 27 Nov 2021 23:10:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ABC4C001C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 23:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB5E64013E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 23:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nK8dntQg9azC
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 23:10:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB24B4012A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638054603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1EKa07C9btxCh09mEEz7bXhy2ReeCiovE+mbyXMOvJk=;
 b=d38KLuZIgOyPlfOSMhfHTF7Nuyr+7slFwvk4D+GkSOsKBw0oTI+Y6Ms1psyJccXq1KNfFj
 y4fxOlD8q/8XhCDb9C0jt9eJKluODXdZUbyUt/38klPXQrbyQ/nWoFsOFwW2N0NUTN9A5t
 xW5VEPBwdYBgAuIZvtuEPBatofjCTJQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-uoO7ljsmNpy7d6RSczo-Bw-1; Sat, 27 Nov 2021 18:10:02 -0500
X-MC-Unique: uoO7ljsmNpy7d6RSczo-Bw-1
Received: by mail-wm1-f70.google.com with SMTP id
 j193-20020a1c23ca000000b003306ae8bfb7so7154941wmj.7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 15:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1EKa07C9btxCh09mEEz7bXhy2ReeCiovE+mbyXMOvJk=;
 b=bxdDXDWRsDyiqTP6J51f0lcCv0JNhFgHlIXZwE98UITIh39ICeUp1qe92K5eE5k7uj
 O1rq/dD6OY/toPgqeA065QnU5/i1MvvAQiNrSVIfAPwni4PJ+kP3Qpve7z50BJJmXwug
 pUAiqYI6RaFDbdh2Wu/zE+zf8kuYOMQpeSB9HMTpVNt819XrIyw7d375j7KmePsV8tpN
 i5h+9wmYZdZMYyL7vhLC4aFEA54nSV2++ZOydFuYTig6FTeHIbERQT2LWoft2p1X9mlo
 ZdwD3fG6z0CrCBQRnbPLKqxxNfBd6i/vS4qhweGEqH/E3C+g/IkJrSy8R+Vy74NdCkkj
 neRw==
X-Gm-Message-State: AOAM5308svyUcDcnpTUIGWS3IkMSVaEJfkX0ZQjUqLP7xKXZ3cLl5z0Q
 srzF/yOVaVnvjTEVD5tzEU3XtfOm3ZRC4mtiifHuVaCwCwLzEUa/E2MEBU/meYD/1uvMRQwGKYl
 GzUFJ99yakfIBDCx2zZ71wpCUdgrzR6Cs9J1jDvBdhg==
X-Received: by 2002:a05:6000:18a3:: with SMTP id
 b3mr23540223wri.343.1638054601078; 
 Sat, 27 Nov 2021 15:10:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzms3nBiSGgLSlbVrcBrfL3xe3M9wymYpfR9ud7pfgrJAw8q/TcFAUVVL2cyPsBTALpRaDwUg==
X-Received: by 2002:a05:6000:18a3:: with SMTP id
 b3mr23540196wri.343.1638054600882; 
 Sat, 27 Nov 2021 15:10:00 -0800 (PST)
Received: from redhat.com ([2.55.9.9])
 by smtp.gmail.com with ESMTPSA id e8sm9296105wrr.26.2021.11.27.15.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Nov 2021 15:10:00 -0800 (PST)
Date: Sat, 27 Nov 2021 18:09:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 4/5] iommu/virtio: Pass end address to
 viommu_add_mapping()
Message-ID: <20211127180742-mutt-send-email-mst@kernel.org>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-5-jean-philippe@linaro.org>
 <7b79fe9b-9d51-8bda-2868-b48781f07fc9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7b79fe9b-9d51-8bda-2868-b48781f07fc9@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, will@kernel.org
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

On Sat, Nov 27, 2021 at 06:09:40PM +0100, Eric Auger wrote:
> 
> 
> On 11/23/21 4:53 PM, Jean-Philippe Brucker wrote:
> > To support identity mappings, the virtio-iommu driver must be able to
> > represent full 64-bit ranges internally. Pass (start, end) instead of
> > (start, size) to viommu_add/del_mapping().
> >
> > Clean comments. The one about the returned size was never true: when
> > sweeping the whole address space the returned size will most certainly
> > be smaller than 2^64.
> >
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric
> 
> > ---
> >  drivers/iommu/virtio-iommu.c | 31 +++++++++++++++----------------
> >  1 file changed, 15 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index d63ec4d11b00..eceb9281c8c1 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -311,8 +311,8 @@ static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
> >   *
> >   * On success, return the new mapping. Otherwise return NULL.
> >   */
> > -static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
> > -			      phys_addr_t paddr, size_t size, u32 flags)
> > +static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
> > +			      phys_addr_t paddr, u32 flags)
> >  {
> >  	unsigned long irqflags;
> >  	struct viommu_mapping *mapping;

I am worried that API changes like that will cause subtle
bugs since types of arguments change but not their
number. If we forgot to update some callers it will all be messed up.

How about passing struct Range instead?

> > @@ -323,7 +323,7 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
> >  
> >  	mapping->paddr		= paddr;
> >  	mapping->iova.start	= iova;
> > -	mapping->iova.last	= iova + size - 1;
> > +	mapping->iova.last	= end;
> >  	mapping->flags		= flags;
> >  
> >  	spin_lock_irqsave(&vdomain->mappings_lock, irqflags);
> > @@ -338,26 +338,24 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
> >   *
> >   * @vdomain: the domain
> >   * @iova: start of the range
> > - * @size: size of the range. A size of 0 corresponds to the entire address
> > - *	space.
> > + * @end: end of the range
> >   *
> > - * On success, returns the number of unmapped bytes (>= size)
> > + * On success, returns the number of unmapped bytes
> >   */
> >  static size_t viommu_del_mappings(struct viommu_domain *vdomain,
> > -				  unsigned long iova, size_t size)
> > +				  u64 iova, u64 end)
> >  {
> >  	size_t unmapped = 0;
> >  	unsigned long flags;
> > -	unsigned long last = iova + size - 1;
> >  	struct viommu_mapping *mapping = NULL;
> >  	struct interval_tree_node *node, *next;
> >  
> >  	spin_lock_irqsave(&vdomain->mappings_lock, flags);
> > -	next = interval_tree_iter_first(&vdomain->mappings, iova, last);
> > +	next = interval_tree_iter_first(&vdomain->mappings, iova, end);
> >  	while (next) {
> >  		node = next;
> >  		mapping = container_of(node, struct viommu_mapping, iova);
> > -		next = interval_tree_iter_next(node, iova, last);
> > +		next = interval_tree_iter_next(node, iova, end);
> >  
> >  		/* Trying to split a mapping? */
> >  		if (mapping->iova.start < iova)
> > @@ -656,8 +654,8 @@ static void viommu_domain_free(struct iommu_domain *domain)
> >  {
> >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> >  
> > -	/* Free all remaining mappings (size 2^64) */
> > -	viommu_del_mappings(vdomain, 0, 0);
> > +	/* Free all remaining mappings */
> > +	viommu_del_mappings(vdomain, 0, ULLONG_MAX);
> >  
> >  	if (vdomain->viommu)
> >  		ida_free(&vdomain->viommu->domain_ids, vdomain->id);
> > @@ -742,6 +740,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> >  {
> >  	int ret;
> >  	u32 flags;
> > +	u64 end = iova + size - 1;
> >  	struct virtio_iommu_req_map map;
> >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> >  
> > @@ -752,7 +751,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> >  	if (flags & ~vdomain->map_flags)
> >  		return -EINVAL;
> >  
> > -	ret = viommu_add_mapping(vdomain, iova, paddr, size, flags);
> > +	ret = viommu_add_mapping(vdomain, iova, end, paddr, flags);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -761,7 +760,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> >  		.domain		= cpu_to_le32(vdomain->id),
> >  		.virt_start	= cpu_to_le64(iova),
> >  		.phys_start	= cpu_to_le64(paddr),
> > -		.virt_end	= cpu_to_le64(iova + size - 1),
> > +		.virt_end	= cpu_to_le64(end),
> >  		.flags		= cpu_to_le32(flags),
> >  	};
> >  
> > @@ -770,7 +769,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
> >  
> >  	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> >  	if (ret)
> > -		viommu_del_mappings(vdomain, iova, size);
> > +		viommu_del_mappings(vdomain, iova, end);
> >  
> >  	return ret;
> >  }
> > @@ -783,7 +782,7 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
> >  	struct virtio_iommu_req_unmap unmap;
> >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> >  
> > -	unmapped = viommu_del_mappings(vdomain, iova, size);
> > +	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
> >  	if (unmapped < size)
> >  		return 0;
> >  

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
