Return-Path: <SRS0=ygFP=HO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474A7C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 18:18:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30E764E8E
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 18:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30E764E8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8D1EF875CB;
	Fri, 12 Feb 2021 18:18:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bh-lGKAYtust; Fri, 12 Feb 2021 18:18:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AA6C387564;
	Fri, 12 Feb 2021 18:18:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92530C0174;
	Fri, 12 Feb 2021 18:18:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8561FC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 18:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 737A687660
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 18:18:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pTawxqiQw7jr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 18:18:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B171F8765F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613153880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZl7b/r+ppu+9/FrF3IJzLz0mVLNre9CvDKAjn1o6yA=;
 b=dTkW5DlnkpXayzR4WJcRmoLv6wUGw85woB76+Sn+ghT3tcVg9fAjNpZxwJBjBKtX4qmx3L
 t9y528Fnh3FjVUCkdsJ8NLKPJbxdwy86Ory2Nw294UApB32kHk5PdmsI14la98Pl6AE6/A
 bRDBZdObQLne5kHxTcy0mpovUSk0LWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-h8Vd8kzrMlCZ5LdBkFC8Dg-1; Fri, 12 Feb 2021 13:16:25 -0500
X-MC-Unique: h8Vd8kzrMlCZ5LdBkFC8Dg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B61AAFA81;
 Fri, 12 Feb 2021 18:16:23 +0000 (UTC)
Received: from [10.36.114.34] (ovpn-114-34.ams2.redhat.com [10.36.114.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D7915C23D;
 Fri, 12 Feb 2021 18:16:14 +0000 (UTC)
Subject: Re: [PATCH 2/2] iommu: arm-smmu-v3: Report domain nesting info
 reuqired for stage1
To: Vivek Gautam <vivek.gautam@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org
References: <20210212105859.8445-1-vivek.gautam@arm.com>
 <20210212105859.8445-3-vivek.gautam@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <07d43c06-9876-2595-1139-b0bc67d94a2c@redhat.com>
Date: Fri, 12 Feb 2021 19:16:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210212105859.8445-3-vivek.gautam@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
> Update nested domain information required for stage1 page table.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index c11dd3940583..728018921fae 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2555,6 +2555,7 @@ static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
>  					void *data)
>  {
>  	struct iommu_nesting_info *info = (struct iommu_nesting_info *)data;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	unsigned int size;
>  
>  	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> @@ -2571,9 +2572,20 @@ static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
>  		return 0;
>  	}
>  
> -	/* report an empty iommu_nesting_info for now */
> -	memset(info, 0x0, size);
> +	/* Update the nesting info as required for stage1 page tables */
> +	info->addr_width = smmu->ias;
> +	info->format = IOMMU_PASID_FORMAT_ARM_SMMU_V3;
> +	info->features = IOMMU_NESTING_FEAT_BIND_PGTBL |
> +			 IOMMU_NESTING_FEAT_PAGE_RESP |
IOMMU_NESTING_FEAT_PAGE_RESP definition is missing too

Eric
> +			 IOMMU_NESTING_FEAT_CACHE_INVLD;
> +	info->pasid_bits = smmu->ssid_bits;
> +	info->vendor.smmuv3.asid_bits = smmu->asid_bits;
> +	info->vendor.smmuv3.pgtbl_fmt = ARM_64_LPAE_S1;
> +	memset(&info->padding, 0x0, 12);
> +	memset(&info->vendor.smmuv3.padding, 0x0, 9);
> +
>  	info->argsz = size;
> +
>  	return 0;
>  }
>  
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
