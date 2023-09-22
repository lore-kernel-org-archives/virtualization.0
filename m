Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E775CCD4843
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 16:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80E366110F;
	Fri, 22 Sep 2023 16:27:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80E366110F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=PapO3wOS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 95Gc8-BKYVKn; Fri, 22 Sep 2023 16:27:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D5EFF60E0A;
	Fri, 22 Sep 2023 16:27:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5EFF60E0A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4247C0039;
	Fri, 22 Sep 2023 16:27:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 203D5C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 16:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEC4E838B6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 16:27:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEC4E838B6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=PapO3wOS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MY0_ThAuY1XT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 16:27:18 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD49183638
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 16:27:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD49183638
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4121788397fso19128841cf.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1695400036; x=1696004836;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KIMfIRUyRo38QcWwN/NLrw49quL7mRXAZqALVytIzPA=;
 b=PapO3wOS3Kjo8J6bpgmff0u/oOFbeRloTD52tX8uKH/lAEgx+Oa9wNnqiUR/i6/6jj
 lH+yVaP2eSft178VuLrbwLMu1I6Od/UHSllt8/4nIEr6Oa1KezbaWV221zI60KSqNg/X
 gJ6Njxr/3ibw2+L77hOxNFelz98/Srb1FtjLCMwhwAkGiv06DN82/dBgD8v5fYR3Pp3F
 AE0K8yodUP6cuEY3GX0QTleBsgtfR2HRT3HY4aMXkN1GKVoNZELLKt6e0sq266kJ8FmR
 bSBTF27+10Geibzi5RXi10/eRZU51hrI204mVcNZ2SVFfaUmuc9YHurcVk/ybXN0u5NR
 SFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695400036; x=1696004836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIMfIRUyRo38QcWwN/NLrw49quL7mRXAZqALVytIzPA=;
 b=QJdRDLczrF5C+EYEtuGuMPPwyPZgPWRYhS1AoKB5kMCY7LJlfV6RrdOskdrmmwzzqX
 iNEX3DdD52mnvViq98fj16ifcz0A6HqYe8RCYULTlXYMrhyBNUlzZbsCTiZRCOhM9iVR
 uR7N798pAikAREVP6i0z19GZoSM3KoOaIjGjQ6tGgc/BNWczVtt4i3kH25qLiJ0R3GWC
 lFjdXI7GFPoE0K0B5Vig6v7hCKoo51ucdirgZqYUmByPqDXZHLkH3AILwiV0B1L8KQT4
 Z5zDRUEWI/cPZgg363CVoASG2DP9QH90rR7y3cW7oUUDM6SnFNueUb0gsJW/IZFZIva/
 KHfQ==
X-Gm-Message-State: AOJu0YyfgRAglf23L4EB+Lr3EfsamPPwCpo91+t/tXx+v5DIYSjb+6PC
 Duam2XL5Rh5QgD2+mB8gNca8PA==
X-Google-Smtp-Source: AGHT+IHrRpYZK6H4zhpjDINCwImDGLSpKzbih7um8bbAruvRPEQN9Wtq+nGMybIYZj0RAXnHk3iVYg==
X-Received: by 2002:ac8:7c56:0:b0:403:a662:a3c1 with SMTP id
 o22-20020ac87c56000000b00403a662a3c1mr3995742qtv.29.1695400036252; 
 Fri, 22 Sep 2023 09:27:16 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.26.201]) by smtp.gmail.com with ESMTPSA id
 gb6-20020a05622a598600b004108bebd1fcsm1560682qtb.24.2023.09.22.09.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 09:27:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qjizq-000aGI-UW;
 Fri, 22 Sep 2023 13:27:14 -0300
Date: Fri, 22 Sep 2023 13:27:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922162714.GH13795@ziepe.ca>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica> <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica> <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, Will Deacon <will@kernel.org>
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

On Fri, Sep 22, 2023 at 02:13:18PM +0100, Robin Murphy wrote:
> On 22/09/2023 1:41 pm, Jason Gunthorpe wrote:
> > On Fri, Sep 22, 2023 at 08:57:19AM +0100, Jean-Philippe Brucker wrote:
> > > > > They're not strictly equivalent: this check works around a temporary issue
> > > > > with the IOMMU core, which calls map/unmap before the domain is
> > > > > finalized.
> > > > 
> > > > Where? The above points to iommu_create_device_direct_mappings() but
> > > > it doesn't because the pgsize_bitmap == 0:
> > > 
> > > __iommu_domain_alloc() sets pgsize_bitmap in this case:
> > > 
> > >          /*
> > >           * If not already set, assume all sizes by default; the driver
> > >           * may override this later
> > >           */
> > >          if (!domain->pgsize_bitmap)
> > >                  domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> > 
> > Dirver's shouldn't do that.
> > 
> > The core code was fixed to try again with mapping reserved regions to
> > support these kinds of drivers.
> 
> This is still the "normal" code path, really; I think it's only AMD that
> started initialising the domain bitmap "early" and warranted making it
> conditional.

My main point was that iommu_create_device_direct_mappings() should
fail for unfinalized domains, setting pgsize_bitmap to allow it to
succeed is not a nice hack, and not necessary now.

What do you think about something like this to replace
iommu_create_device_direct_mappings(), that does enforce things
properly?


static int resv_cmp(void *priv, const struct list_head *llhs,
		    const struct list_head *lrhs)
{
	struct iommu_resv_region *lhs = list_entry(llhs, struct iommu_resv_region, list);
	struct iommu_resv_region *rhs = list_entry(lrhs, struct iommu_resv_region, list);

	if (lhs->start == rhs->start)
		return 0;
	if (lhs->start < rhs->start)
		return -1;
	return 1;
}

static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
					       struct device *dev)
{
	struct iommu_resv_region *entry;
	struct iommu_resv_region *tmp;
	struct list_head mappings;
	struct list_head direct;
	phys_addr_t cur = 0;
	int ret = 0;

	INIT_LIST_HEAD(&mappings);
	INIT_LIST_HEAD(&direct);

	iommu_get_resv_regions(dev, &mappings);

	list_for_each_entry_safe(entry, tmp, &mappings, list) {
		if (entry->type == IOMMU_RESV_DIRECT)
			dev->iommu->require_direct = 1;

		if ((domain->type & __IOMMU_DOMAIN_PAGING) &&
		    (entry->type == IOMMU_RESV_DIRECT ||
		     entry->type == IOMMU_RESV_DIRECT_RELAXABLE)) {
			if (domain->geometry.aperture_start > entry->start ||
			    domain->geometry.aperture_end == 0 ||
			    (domain->geometry.aperture_end - 1) <
				    (entry->start + entry->length - 1)) {
				ret = -EINVAL;
				goto out;
			}
			list_move(&entry->list, &direct);
		}
	}

	if (list_empty(&direct))
		goto out;

	/*
	 * FW can have overlapping ranges, sort the list by start address
	 * and map any duplicated IOVA only once.
	 */
	list_sort(NULL, &direct, resv_cmp);
	list_for_each_entry(entry, &direct, list) {
		phys_addr_t start_pfn = entry->start / PAGE_SIZE;
		phys_addr_t last_pfn =
			(entry->length - 1 + entry->start) / PAGE_SIZE;

		if (start_pfn < cur)
			start_pfn = cur;

		if (start_pfn <= last_pfn) {
			ret = iommu_map(domain, start_pfn * PAGE_SIZE,
					start_pfn * PAGE_SIZE,
					(last_pfn - start_pfn + 1) * PAGE_SIZE,
					entry->prot, GFP_KERNEL);
			if (ret)
				goto out;
			cur = last_pfn + 1;
		}
	}

out:
	list_splice(&direct, &mappings);
	iommu_put_resv_regions(dev, &mappings);

	return ret;
}
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
