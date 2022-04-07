Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9518BC433EF
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 15:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7B3D41B77;
	Thu,  7 Apr 2022 15:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ip-_ie29Mb6S; Thu,  7 Apr 2022 15:31:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25C3941B72;
	Thu,  7 Apr 2022 15:31:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC812C0083;
	Thu,  7 Apr 2022 15:31:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 824CCC0012;
 Thu,  7 Apr 2022 15:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 617DB40CBA;
 Thu,  7 Apr 2022 15:31:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aMHzDwxUkAKp; Thu,  7 Apr 2022 15:31:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0F7740CC2;
 Thu,  7 Apr 2022 15:31:08 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7B78668AFE; Thu,  7 Apr 2022 17:31:03 +0200 (CEST)
Date: Thu, 7 Apr 2022 17:31:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/5] iommu: Replace uses of IOMMU_CAP_CACHE_COHERENCY
 with dev_is_dma_coherent()
Message-ID: <20220407153103.GA15336@lst.de>
References: <db5a6daa-bfe9-744f-7fc5-d5167858bc3e@arm.com>
 <20220406142432.GF2120790@nvidia.com> <20220406151823.GG2120790@nvidia.com>
 <20220406155056.GA30433@lst.de> <20220406160623.GI2120790@nvidia.com>
 <20220406161031.GA31790@lst.de> <20220406171729.GJ2120790@nvidia.com>
 <BN9PR11MB5276F9CEA2B01B3E75094B6D8CE69@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220407135946.GM2120790@nvidia.com>
 <fb55a025-348e-800c-e368-48be075d8e9c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fb55a025-348e-800c-e368-48be075d8e9c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Nelson Escobar <neescoba@cisco.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Christian Benvenuti <benve@cisco.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
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

On Thu, Apr 07, 2022 at 04:17:11PM +0100, Robin Murphy wrote:
>> My take is that the drivers using this API are doing it to make sure
>> their HW blocks are setup in a way that is consistent with the DMA API
>> they are also using, and run in constrained embedded-style
>> environments that know the firmware support is present.
>>
>> So in the end it does not seem suitable right now for linking to
>> IOMMU_CACHE..
>
> That seems a pretty good summary - I think they're basically all "firmware 
> told Linux I'm coherent so I'd better act coherent" cases, but that still 
> doesn't necessarily mean that they're *forced* to respect that.

Yes. And the interface is horribly misnamed for that.  I'll see what
I can do to clean this up as I've noticed various other not very
nice things in that area.

> One of the 
> things on my to-do list is to try adding a DMA_ATTR_NO_SNOOP that can force 
> DMA cache maintenance for coherent devices, primarily to hook up in 
> Panfrost (where there is a bit of a performance to claw back on the 
> coherent AmLogic SoCs by leaving certain buffers non-cacheable).

This has been an explicit request from the amdgpu folks and thus been
on my TODO list for quite a while as well.  Note that I don't think it
should be a flag to dma_alloc_attrs, but rather for dma_alloc_pages
as the drivers that want non-snoop generally also want to actually
be able to deal with pages.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
