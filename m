Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4289C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 15:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F6018134E;
	Wed,  6 Apr 2022 15:48:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fqWl86qsQjDo; Wed,  6 Apr 2022 15:48:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DB4DF812FE;
	Wed,  6 Apr 2022 15:48:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB797C001D;
	Wed,  6 Apr 2022 15:48:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 245F5C0012;
 Wed,  6 Apr 2022 15:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 015EC41608;
 Wed,  6 Apr 2022 15:48:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GRSVap9QdgR6; Wed,  6 Apr 2022 15:48:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id D58E741299;
 Wed,  6 Apr 2022 15:48:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B11812FC;
 Wed,  6 Apr 2022 08:48:36 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164303F73B;
 Wed,  6 Apr 2022 08:48:30 -0700 (PDT)
Message-ID: <7455941b-ffc0-3771-7852-36fa685275e1@arm.com>
Date: Wed, 6 Apr 2022 16:48:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] iommu: Replace uses of IOMMU_CAP_CACHE_COHERENCY with
 dev_is_dma_coherent()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>
References: <0-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
 <1-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
 <20220406053039.GA10580@lst.de> <20220406120730.GA2120790@nvidia.com>
 <20220406135150.GA21532@lst.de> <20220406141446.GE2120790@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220406141446.GE2120790@nvidia.com>
Cc: Nelson Escobar <neescoba@cisco.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux-foundation.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 2022-04-06 15:14, Jason Gunthorpe wrote:
> On Wed, Apr 06, 2022 at 03:51:50PM +0200, Christoph Hellwig wrote:
>> On Wed, Apr 06, 2022 at 09:07:30AM -0300, Jason Gunthorpe wrote:
>>> Didn't see it
>>>
>>> I'll move dev_is_dma_coherent to device.h along with
>>> device_iommu_mapped() and others then
>>
>> No.  It it is internal for a reason.  It also doesn't actually work
>> outside of the dma core.  E.g. for non-swiotlb ARM configs it will
>> not actually work.
> 
> Really? It is the only condition that dma_info_to_prot() tests to
> decide of IOMMU_CACHE is used or not, so you are saying that there is
> a condition where a device can be attached to an iommu_domain and
> dev_is_dma_coherent() returns the wrong information? How does
> dma-iommu.c safely use it then?

The common iommu-dma layer happens to be part of the subset of the DMA 
core which *does* play the dev->dma_coherent game. 32-bit Arm has its 
own IOMMU DMA ops which do not. I don't know if the set of PowerPCs with 
CONFIG_NOT_COHERENT_CACHE intersects the set of PowerPCs that can do 
VFIO, but that would be another example if so.

> In any case I still need to do something about the places checking
> IOMMU_CAP_CACHE_COHERENCY and thinking that means IOMMU_CACHE
> works. Any idea?

Can we improve the IOMMU drivers such that that *can* be the case 
(within a reasonable margin of error)? That's kind of where I was hoping 
to head with device_iommu_capable(), e.g. [1].

Robin.

[1] 
https://gitlab.arm.com/linux-arm/linux-rm/-/commit/53390e9505b3791adedc0974e251e5c7360e402e
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
