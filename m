Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0420C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 17:24:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6918B64EDB
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 17:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6918B64EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21C676F638;
	Wed,  3 Mar 2021 17:24:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FLqvER37A-Tl; Wed,  3 Mar 2021 17:24:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C233605E5;
	Wed,  3 Mar 2021 17:24:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79562C000A;
	Wed,  3 Mar 2021 17:24:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A968C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CE496F638
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:24:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4eSjehKKyu8F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:24:18 +0000 (UTC)
X-Greylist: delayed 00:05:56 by SQLgrey-1.8.0
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2822E605E5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:24:18 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id i9so5834131wml.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Mar 2021 09:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5iBsMQqFOU14HEvyYWYO+cEIgAJ26J54CPr7LWlg7Ck=;
 b=tJsSbW7npNeXuT2aUfv+xVzgDPQaXPBn/6WhvvP+1VpmGrNWVlB/6c73uxaz1NkEnV
 kuYCUjcUrfSFI2/OlqRPlXzBBSlUpgblF/vd2AUFIsDz3l1X+8C1xy0N/ypdfroHVoqk
 /sBnwUtbxubfsNj1+4sQS56KQAeYGICeiPg1Sm0yFT6f72NZXglUsrDDWhxlLI8TzRvc
 HyRqlUtaBuwmcy1tpzZ1TG+MQzSeIiYtJrDYvzs/zM6Ksw6N5gyMQKU27zae1ci/Q2zn
 SGKaMqxm9hi2hv5Bg3uSsGsdocWUssbrjXRYj2ff7z6+XkW1cRE5F5QQunLfqdKrxPoN
 3Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5iBsMQqFOU14HEvyYWYO+cEIgAJ26J54CPr7LWlg7Ck=;
 b=m+ynjJJqQDUHsUc5KoV40+GMO/dl+crd7L1YKlVVuGtSnEY3T5n5u/I8L30wIqgkxk
 t/aETF1HlbqFIJoyfl+5fyfCEclluAm1Re0tpKOT5cpFwQstx4RWvzkbJkmrnoSSyAgc
 AiEYE3X68PV+jOP5jpmaE+NKNb+rIN7abwYz8hO2K+yJj8r4LWYhlA+WTCB2ihuuIJDP
 38qycT/T4wLXanb+Aw+4WMSs+in6aQypP3VWVfTCh0jqQ+u84ivlO88oAmHyu1n23NKT
 rcVCfXgoL5AJHNM/X7ekOFHd+YG76S8aBCs2yuSW6eNjpTuB9yy+xUP2i3jpxeTXKfdM
 1ojw==
X-Gm-Message-State: AOAM530KcPCYY3AgUDMQTusIApFaKSOS7L7EdhQEMBKbuEBTe30qUQeM
 0EDF/BDflD/1xphXtzXJifTzx87zZHIJ3A==
X-Google-Smtp-Source: ABdhPJwC8M1M+ADRQsf7KzCeua/t0GLhmB9md5x6408Cc3EtgTN6TPy0ZU8dctF1TddT/5Mj9RvYVA==
X-Received: by 2002:a05:600c:2f08:: with SMTP id r8mr31246wmn.95.1614791900389; 
 Wed, 03 Mar 2021 09:18:20 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 91sm10498408wrl.20.2021.03.03.09.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 09:18:19 -0800 (PST)
Date: Wed, 3 Mar 2021 18:17:58 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 06/15] iommu/virtio: Add headers for table format
 probing
Message-ID: <YD/ExjIwG/as52CI@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-7-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-7-vivek.gautam@arm.com>
Cc: jacob.jun.pan@linux.intel.com, mst@redhat.com, joro@8bytes.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, yi.l.liu@intel.com,
 lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Jan 15, 2021 at 05:43:33PM +0530, Vivek Gautam wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> Add required UAPI defines for probing table format for underlying
> iommu hardware. The device may provide information about hardware
> tables and additional capabilities for each device.
> This allows guest to correctly fabricate stage-1 page tables.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> [Vivek: Use a single "struct virtio_iommu_probe_table_format" rather
>         than separate structures for page table and pasid table format.

Makes sense. I've integrated that into the spec draft, added more precise
documentation and modified some of the definitions.

The current draft is here:
https://jpbrucker.net/virtio-iommu/spec/virtio-iommu-v0.13.pdf
Posted on the list here
https://lists.oasis-open.org/archives/virtio-dev/202102/msg00012.html

> 	Also update commit message.]
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> ---
>  include/uapi/linux/virtio_iommu.h | 44 ++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 237e36a280cb..43821e33e7af 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -2,7 +2,7 @@
>  /*
>   * Virtio-iommu definition v0.12
>   *
> - * Copyright (C) 2019 Arm Ltd.
> + * Copyright (C) 2019-2021 Arm Ltd.

Not strictly necessary. But if you're modifying this comment please also
remove the "v0.12" above

>   */
>  #ifndef _UAPI_LINUX_VIRTIO_IOMMU_H
>  #define _UAPI_LINUX_VIRTIO_IOMMU_H
> @@ -111,6 +111,12 @@ struct virtio_iommu_req_unmap {
>  
>  #define VIRTIO_IOMMU_PROBE_T_NONE		0
>  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
> +#define VIRTIO_IOMMU_PROBE_T_INPUT_RANGE	3
> +#define VIRTIO_IOMMU_PROBE_T_OUTPUT_SIZE	4
> +#define VIRTIO_IOMMU_PROBE_T_PASID_SIZE		5
> +#define VIRTIO_IOMMU_PROBE_T_PAGE_TABLE_FMT	6
> +#define VIRTIO_IOMMU_PROBE_T_PASID_TABLE_FMT	7

Since there is a single struct we can have a single
VIRTIO_IOMMU_PROBE_T_TABLE_FORMAT.

>  
>  #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
>  
> @@ -130,6 +136,42 @@ struct virtio_iommu_probe_resv_mem {
>  	__le64					end;
>  };
>  
> +struct virtio_iommu_probe_page_size_mask {
> +	struct virtio_iommu_probe_property	head;
> +	__u8					reserved[4];
> +	__le64					mask;
> +};
> +
> +struct virtio_iommu_probe_input_range {
> +	struct virtio_iommu_probe_property	head;
> +	__u8					reserved[4];
> +	__le64					start;
> +	__le64					end;
> +};
> +
> +struct virtio_iommu_probe_output_size {
> +	struct virtio_iommu_probe_property	head;
> +	__u8					bits;
> +	__u8					reserved[3];
> +};
> +
> +struct virtio_iommu_probe_pasid_size {
> +	struct virtio_iommu_probe_property	head;
> +	__u8					bits;
> +	__u8					reserved[3];
> +};
> +
> +/* Arm LPAE page table format */
> +#define VIRTIO_IOMMU_FOMRAT_PGTF_ARM_LPAE	1

s/FOMRAT/FORMAT

> +/* Arm smmu-v3 type PASID table format */
> +#define VIRTIO_IOMMU_FORMAT_PSTF_ARM_SMMU_V3	2

These should be with the Arm-specific definitions patches 11 and 14

Thanks,
Jean

> +
> +struct virtio_iommu_probe_table_format {
> +	struct virtio_iommu_probe_property	head;
> +	__le16					format;
> +	__u8					reserved[2];
> +};
> +
>  struct virtio_iommu_req_probe {
>  	struct virtio_iommu_req_head		head;
>  	__le32					endpoint;
> -- 
> 2.17.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
