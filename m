Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A1DC433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 17:46:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC13E64ED7
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 17:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC13E64ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 758114011B;
	Wed,  3 Mar 2021 17:46:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id asxvfe_ukrt9; Wed,  3 Mar 2021 17:46:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2666840132;
	Wed,  3 Mar 2021 17:46:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8DA0C000A;
	Wed,  3 Mar 2021 17:46:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C79E8C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:46:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B61AC840D5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:46:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 68VTItSeKSWP
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:46:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4AB7B84008
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:46:47 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id m1so7142055wml.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Mar 2021 09:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=snvF1oZRAeOuQ652xF7hxq8e8Xbivy9W17OCql8Ju58=;
 b=N4GzE8TYwDr5X4gxi0SyFxRoTBr18n1OZjxbvypLvGP0Y4FoY0LysvNlydxCGejw5o
 /cBkCZJLNvfwhcIGdhFCqyxDwdKIZ6qjVhtXO7fN9azK3VGGOf3w8vj2aAp59oSB8xdN
 0dPT6MSfpozH0a30HioSChw0qmgAqCUYwcaapdq7uWhX/Cau9DcgXlxcfIWQUMNLc/LK
 TFzBMXyK/zWnYtJMBqnKSmu5upeKLdHMql2kQ6zKb0XVFDIJl4dEbHe0xo7Qskg90KJL
 JLt1qlFufE95dlru/PO4iXTOUfQzsqlVCf9J3BlUkcK+TVC4CiGinPkkPQSne2U/TFlH
 LzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=snvF1oZRAeOuQ652xF7hxq8e8Xbivy9W17OCql8Ju58=;
 b=FoJYhb55DZjlASRXJBiwuVYgSV9qqlPYoJdGyWym9E6aBs7KbAwXFAhx9/kYEw9GkO
 IRQUDvdNG9nC0xdFMB3Zj9ot7rA8r2d1wQa3wUgF0KENl3C14is2sEMvbOFfNzAMnJYC
 Wzeu4Dv2exzQsixRP+9045lukQg7nhHbHA/qR9Kpt+UOJU+uKFcAGBBIc8iT5I0QjBVP
 8VCFSvp/e9S2iJ34IDCa+0mfnzWudpUL8aTiEubRBeVLOWoJvrd4xDeBLRgePiCwjGmr
 5pSygBH/cP1RYK2c+BhjheHTu4/p/uErJM9HWALnsXu0Hi2IjiV/53GzGPQ1YYWFOsUJ
 dA7Q==
X-Gm-Message-State: AOAM531HSwGGpHWyrkQsEqu+VrE33PQK99SJ2qhd2rs0Qzt2UeM7oKrM
 QLG0PriVKcLR2OoYNT4JhLTkbxWofqYxcA==
X-Google-Smtp-Source: ABdhPJz0FpEULBkKSmdBklW+Kq2/Ls1+mEtrqGKqrnMSwdqjEtdd4QHizAokDIN5S9VOM4P4MLCxhg==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr74337wmi.132.1614792096379;
 Wed, 03 Mar 2021 09:21:36 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s23sm6477150wmc.35.2021.03.03.09.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 09:21:35 -0800 (PST)
Date: Wed, 3 Mar 2021 18:21:14 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 09/15] iommu/virtio: Update table format probing
 header
Message-ID: <YD/Fiuxd9/kThGxt@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-10-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-10-vivek.gautam@arm.com>
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

On Fri, Jan 15, 2021 at 05:43:36PM +0530, Vivek Gautam wrote:
> Add info about asid_bits and additional flags to table format
> probing header.
> 
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
>  include/uapi/linux/virtio_iommu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 43821e33e7af..8a0624bab4b2 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -169,7 +169,10 @@ struct virtio_iommu_probe_pasid_size {
>  struct virtio_iommu_probe_table_format {
>  	struct virtio_iommu_probe_property	head;
>  	__le16					format;
> -	__u8					reserved[2];
> +	__le16					asid_bits;
> +
> +	__le32					flags;

This struct should only contain the head and format fields. asid and flags
should go in a specialized structure - virtio_iommu_probe_pgt_arm64 in the
latest spec draft, where I dropped the asid_bits field in favor of an
"ASID16" flag.

Thanks,
Jean

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
