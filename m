Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F5AC433DB
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 09:03:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAEE23138
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 09:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAEE23138
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7E08F850A8;
	Tue, 19 Jan 2021 09:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TLl5sRNN0a2Z; Tue, 19 Jan 2021 09:03:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 88133850D6;
	Tue, 19 Jan 2021 09:03:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F010C1E6F;
	Tue, 19 Jan 2021 09:03:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67820C08A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 50F3A850A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pufxIFLPi3-2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:03:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 441EA850D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611047021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4JtlqU9lds82sAqd8DAPPefBYOoZlrxQtVNKgw6XdhY=;
 b=K/3fQVZPmmOIDrazynI98nMTMO0BR6KOcb3HljpzvxJjJMv4NBpx8dGRM9YIAUgarR+74+
 FjnDnKYTd0y8Iq/ut+8wj29o+5+wRqIzbhwB0FxFwHRvHKvTLgb8dUFo3NQRNw6TvZ2Eme
 nlfVKFCKkBj0LNoBg+qyRVJLHvUG6/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-QR70-h6vPom3FGRmfyvqIg-1; Tue, 19 Jan 2021 04:03:36 -0500
X-MC-Unique: QR70-h6vPom3FGRmfyvqIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EB831800D41;
 Tue, 19 Jan 2021 09:03:34 +0000 (UTC)
Received: from [10.36.112.67] (ovpn-112-67.ams2.redhat.com [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0C072C303;
 Tue, 19 Jan 2021 09:03:24 +0000 (UTC)
Subject: Re: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with Arm
To: Vivek Gautam <vivek.gautam@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org
References: <20210115121342.15093-1-vivek.gautam@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a8fd0176-3888-44cf-d659-2e2213a59969@redhat.com>
Date: Tue, 19 Jan 2021 10:03:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: jean-philippe@linaro.org, jacob.jun.pan@linux.intel.com, mst@redhat.com,
 joro@8bytes.org, will.deacon@arm.com, shameerali.kolothum.thodi@huawei.com,
 yi.l.liu@intel.com, lorenzo.pieralisi@arm.com, robin.murphy@arm.com
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

Hi Vivek,

On 1/15/21 1:13 PM, Vivek Gautam wrote:
> This patch-series aims at enabling Nested stage translation in guests
> using virtio-iommu as the paravirtualized iommu. The backend is supported
> with Arm SMMU-v3 that provides nested stage-1 and stage-2 translation.
> 
> This series derives its purpose from various efforts happening to add
> support for Shared Virtual Addressing (SVA) in host and guest. On Arm,
> most of the support for SVA has already landed. The support for nested
> stage translation and fault reporting to guest has been proposed [1].
> The related changes required in VFIO [2] framework have also been put
> forward.
> 
> This series proposes changes in virtio-iommu to program PASID tables
> and related stage-1 page tables. A simple iommu-pasid-table library
> is added for this purpose that interacts with vendor drivers to
> allocate and populate PASID tables.
> In Arm SMMUv3 we propose to pull the Context Descriptor (CD) management
> code out of the arm-smmu-v3 driver and add that as a glue vendor layer
> to support allocating CD tables, and populating them with right values.
> These CD tables are essentially the PASID tables and contain stage-1
> page table configurations too.
> A request to setup these CD tables come from virtio-iommu driver using
> the iommu-pasid-table library when running on Arm. The virtio-iommu
> then pass these PASID tables to the host using the right virtio backend
> and support in VMM.
> 
> For testing we have added necessary support in kvmtool. The changes in
> kvmtool are based on virtio-iommu development branch by Jean-Philippe
> Brucker [3].
> 
> The tested kernel branch contains following in the order bottom to top
> on the git hash -
> a) v5.11-rc3
> b) arm-smmu-v3 [1] and vfio [2] changes from Eric to add nested page
>    table support for Arm.
> c) Smmu test engine patches from Jean-Philippe's branch [4]
> d) This series
> e) Domain nesting info patches [5][6][7].
> f) Changes to add arm-smmu-v3 specific nesting info (to be sent to
>    the list).
> 
> This kernel is tested on Neoverse reference software stack with
> Fixed virtual platform. Public version of the software stack and
> FVP is available here[8][9].
> 
> A big thanks to Jean-Philippe for his contributions towards this work
> and for his valuable guidance.
> 
> [1] https://lore.kernel.org/linux-iommu/20201118112151.25412-1-eric.auger@redhat.com/T/
> [2] https://lore.kernel.org/kvmarm/20201116110030.32335-12-eric.auger@redhat.com/T/
> [3] https://jpbrucker.net/git/kvmtool/log/?h=virtio-iommu/devel
> [4] https://jpbrucker.net/git/linux/log/?h=sva/smmute
> [5] https://lore.kernel.org/kvm/1599734733-6431-2-git-send-email-yi.l.liu@intel.com/
> [6] https://lore.kernel.org/kvm/1599734733-6431-3-git-send-email-yi.l.liu@intel.com/
> [7] https://lore.kernel.org/kvm/1599734733-6431-4-git-send-email-yi.l.liu@intel.com/
> [8] https://developer.arm.com/tools-and-software/open-source-software/arm-platforms-software/arm-ecosystem-fvps
> [9] https://git.linaro.org/landing-teams/working/arm/arm-reference-platforms.git/about/docs/rdn1edge/user-guide.rst

Could you share a public branch where we could find all the kernel pieces.

Thank you in advance

Best Regards

Eric
> 
> Jean-Philippe Brucker (6):
>   iommu/virtio: Add headers for table format probing
>   iommu/virtio: Add table format probing
>   iommu/virtio: Add headers for binding pasid table in iommu
>   iommu/virtio: Add support for INVALIDATE request
>   iommu/virtio: Attach Arm PASID tables when available
>   iommu/virtio: Add support for Arm LPAE page table format
> 
> Vivek Gautam (9):
>   iommu/arm-smmu-v3: Create a Context Descriptor library
>   iommu: Add a simple PASID table library
>   iommu/arm-smmu-v3: Update drivers to work with iommu-pasid-table
>   iommu/arm-smmu-v3: Update CD base address info for user-space
>   iommu/arm-smmu-v3: Set sync op from consumer driver of cd-lib
>   iommu: Add asid_bits to arm smmu-v3 stage1 table info
>   iommu/virtio: Update table format probing header
>   iommu/virtio: Prepare to add attach pasid table infrastructure
>   iommu/virtio: Update fault type and reason info for viommu fault
> 
>  drivers/iommu/arm/arm-smmu-v3/Makefile        |   2 +-
>  .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      | 283 +++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  16 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 268 +------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +-
>  drivers/iommu/iommu-pasid-table.h             | 140 ++++
>  drivers/iommu/virtio-iommu.c                  | 692 +++++++++++++++++-
>  include/uapi/linux/iommu.h                    |   2 +-
>  include/uapi/linux/virtio_iommu.h             | 158 +++-
>  9 files changed, 1303 insertions(+), 262 deletions(-)
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
>  create mode 100644 drivers/iommu/iommu-pasid-table.h
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
