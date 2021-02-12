Return-Path: <SRS0=ygFP=HO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73DDC433E0
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 18:13:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A585D64D9F
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 18:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A585D64D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CD4C6F7F0
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 18:13:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r9JCp26waASP for <virtualization@archiver.kernel.org>;
	Fri, 12 Feb 2021 18:13:52 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 8C7ED6F77F; Fri, 12 Feb 2021 18:13:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B3F46F527;
	Fri, 12 Feb 2021 18:13:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31334C0174;
	Fri, 12 Feb 2021 18:13:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0F61C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 18:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B96176F527
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 18:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GFeu-GMYHJcv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 18:13:44 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 882486F644; Fri, 12 Feb 2021 18:13:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB5786F527
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 18:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613153621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QLqsR4sSEYCEMnG5ZaXCSNXnc9ht4025gA+UtCzISME=;
 b=Wlq8ngyByc2sPEc9l+/oXMHPH1gaLZ5H8SmR7HWne5gaenJxCF0GYAB+Lujlga08nUE958
 YUrfknbPhq2Hu2woJVq1RUaEynqS0LU7DtWgadf13c8zllFe9P9oV0/NN3rtQ/G+9icHzS
 oyNM+q1tnGYZfDdQBZ7VHmyYHkyButk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-bsa7C5m5OF-etwpAJO51Pg-1; Fri, 12 Feb 2021 13:13:37 -0500
X-MC-Unique: bsa7C5m5OF-etwpAJO51Pg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C801D80196C;
 Fri, 12 Feb 2021 18:13:34 +0000 (UTC)
Received: from [10.36.114.34] (ovpn-114-34.ams2.redhat.com [10.36.114.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8387A60BF1;
 Fri, 12 Feb 2021 18:13:24 +0000 (UTC)
Subject: Re: [PATCH 1/2] iommu: Report domain nesting info for arm-smmu-v3
To: Vivek Gautam <vivek.gautam@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org
References: <20210212105859.8445-1-vivek.gautam@arm.com>
 <20210212105859.8445-2-vivek.gautam@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <28c0204d-2a5e-4eb9-d869-9dbd6edab55a@redhat.com>
Date: Fri, 12 Feb 2021 19:13:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210212105859.8445-2-vivek.gautam@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: jean-philippe@linaro.org, jacob.jun.pan@linux.intel.com, mst@redhat.com,
 joro@8bytes.org, will.deacon@arm.com, shameerali.kolothum.thodi@huawei.com,
 yi.l.liu@intel.com, Lorenzo.Pieralisi@arm.com, robin.murphy@arm.com
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
On 2/12/21 11:58 AM, Vivek Gautam wrote:
> Add a vendor specific structure for domain nesting info for
> arm smmu-v3, and necessary info fields required to populate
> stage1 page tables.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  include/uapi/linux/iommu.h | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 4d3d988fa353..5f059bcf7720 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -323,7 +323,8 @@ struct iommu_gpasid_bind_data {
>  #define IOMMU_GPASID_BIND_VERSION_1	1
>  	__u32 version;
>  #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> -#define IOMMU_PASID_FORMAT_LAST		2
> +#define IOMMU_PASID_FORMAT_ARM_SMMU_V3	2
> +#define IOMMU_PASID_FORMAT_LAST		3
>  	__u32 format;
>  	__u32 addr_width;
>  #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> @@ -409,6 +410,21 @@ struct iommu_nesting_info_vtd {
>  	__u64	ecap_reg;
>  };
>  
> +/*
> + * struct iommu_nesting_info_arm_smmuv3 - Arm SMMU-v3 nesting info.
> + */
> +struct iommu_nesting_info_arm_smmuv3 {
> +	__u32	flags;
> +	__u16	asid_bits;
> +
> +	/* Arm LPAE page table format as per kernel */
> +#define ARM_PGTBL_32_LPAE_S1		(0x0)
> +#define ARM_PGTBL_64_LPAE_S1		(0x2)
Shouldn't it be a bitfield instead as both can be supported (the actual
driver only supports 64b table format though). Does it match matches
IDR0.TTF?
> +	__u8	pgtbl_fmt;
So I understand this API is supposed to allow VFIO to expose those info
early enough to the userspace to help configuring the viommu and avoid
errors later on. I wonder how far we want to go on this path. What about
those other caps that impact the STE/CD validity. There may be others...

SMMU_IDR0.CD2L (support of 2 stage CD)
SMMU_IDR0.TTENDIAN (endianness)
SMMU_IDR0.HTTU (if 0 forbids HA/HD setting in the CD)
SMMU_IDR3.STT (impacts T0SZ)

Thanks

Eric

> +
> +	__u8	padding[9];
> +};
> +
>  /*
>   * struct iommu_nesting_info - Information for nesting-capable IOMMU.
>   *			       userspace should check it before using
> @@ -445,11 +461,13 @@ struct iommu_nesting_info_vtd {
>   * +---------------+------------------------------------------------------+
>   *
>   * data struct types defined for @format:
> - * +================================+=====================================+
> - * | @format                        | data struct                         |
> - * +================================+=====================================+
> - * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd       |
> - * +--------------------------------+-------------------------------------+
> + * +================================+======================================+
> + * | @format                        | data struct                          |
> + * +================================+======================================+
> + * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd        |
> + * +---------------+-------------------------------------------------------+
> + * | IOMMU_PASID_FORMAT_ARM_SMMU_V3 | struct iommu_nesting_info_arm_smmuv3 |
> + * +--------------------------------+--------------------------------------+
>   *
>   */
>  struct iommu_nesting_info {
> @@ -466,6 +484,7 @@ struct iommu_nesting_info {
>  	/* Vendor specific data */
>  	union {
>  		struct iommu_nesting_info_vtd vtd;
> +		struct iommu_nesting_info_arm_smmuv3 smmuv3;
>  	} vendor;
>  };
>  
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
