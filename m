Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B81166F32
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962391; cv=none; b=QAuAHqQ+BV5scdjAKvV5Fyumj0WWZ0Tbi2+zCZ9wbNyXN/h3fAEN3+FGFhMOvW8vuWHkOjG0Hm6JLerEoZOgYQRzIzjSgjbzylagybRuwZJ9eank2ATOKps6VBGWL0jeOKIs+iBBw9IrwtEJJqzVMpm1pB7aL26c67VCV+AfCb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962391; c=relaxed/simple;
	bh=syw8l1KwjEBWtLU1JH5AK1kULW2THayjgvY12VC2Tx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFvmTeM6vEtWxko/wKFAGiXCb5iFdTWGr4A+BsRRxhJHD3sFunk8kPgSCi/s8b75FWCMmpXqXi10/DkJrd/VPkBj8gbk1FBILr3qLpOFyEtOu91pa5swn5BqZKqEUIU47DDoBIoqYSW+DUZK211dG/R0zNzqFPze5Gpf8YRnoZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u74CFVTs; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u74CFVTs"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04122403EB
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 03:19:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lNx2Zy2UAQyx for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Oct 2024 03:19:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com; envelope-from=zhangfei.gao@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4A70C40129
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A70C40129
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u74CFVTs
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4A70C40129
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 03:19:47 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-539f84907caso1869539e87.3
        for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 20:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728962385; x=1729567185; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QZJ30zy3Y9wI3Z0YkhEC9QUrXIWOd4xHS/wNqEUb/eU=;
        b=u74CFVTsXXlJPDF8MUk7gHFM7H2HTnaWiSI6RhCxy1gjGyZB98PDarvRZiSo/zJDU/
         tz0Vc0r2m8KDeaSpd8b1Serk+fLadnzXGMEznkiLn2kH5+b65b/w7hMHAPPaQL5DPiaQ
         UUjQJwcmcX8Yf3WSV2E9w35J4DwI4TguVzpDGi28lsjEyI2YHdH41Am/cuJMtxpE3auS
         VaIk43E9xWuqjUwX5hz4mqrOInDNK6QaayMZqkV2guQNnhQOJbrNK1UcZyMWLMMO75A6
         umcnn6l/mO0sbMbUS2pq0Oe7g5G0YGVFGvkmW7F0DG2BmUkm1JTjlHbVKHeOrrAqQzPR
         1FvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728962385; x=1729567185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZJ30zy3Y9wI3Z0YkhEC9QUrXIWOd4xHS/wNqEUb/eU=;
        b=NCuYtv9UVF1JPP19jkFG/+UME88ebXPXsQ6Og8aduOCAiDmAT/hPHAzvo7EtZ0DiDd
         uirNKSCZTdzfk50rDaoWiuoGZPGmB+wkgtbdoDLeYYzfWCowk8AOZSctk5xM93SyBrZ7
         eZB97LNrS4ktCwUKH2Exl0XkNUSwXI2XjI4F8YhALoXrU9auB0wP8m0KZ2hpGF5pj7tu
         299w3XnLPyPaXcUypDf28vLgPf/pGR6W0n2lMf29bkCqgn4l2TG8Uco/hn+GEENZP5sq
         gfWgSGmVGnzUeGRRKeGHFSnGbVQfv41Cdo0t/6un/MTnoN9RRTDy3WTITyiZFe1er/2r
         i/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1cjFPx9O8E+qElfQv8nGNBvxi2ghXgZ2p49gTUZs/D5w4XlOjorRroj12bv492oX9hCkFdGBQWSstypQu4g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxjErxYDHtc4dJ/IONMuxdDgyrokkzwdwTUC43VP78LIyusuY1n
	J5ijoOms58WeimIJZHUV5qt64T2zTu+hrBcdk/EeOQivy+C3KjSz73K0O2QGmbC8SDLNRRTXPFk
	lNAk4oUuWkY02wf833Ecg00IIulUK6ucHPbDflw==
X-Google-Smtp-Source: AGHT+IF2l+l9aIjC2cv2bCp01lbBm8QlrtKCARf+AmZ684Kp2buFC5VFNgRnQSqkTeJHMQUtLY2v5L1TykBuAKg0PM4=
X-Received: by 2002:a05:6512:baa:b0:539:e94d:b490 with SMTP id
 2adb3069b0e04-539e94dbcd1mr3817040e87.43.1728962385314; Mon, 14 Oct 2024
 20:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com> <20240702063444.105814-8-baolu.lu@linux.intel.com>
In-Reply-To: <20240702063444.105814-8-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 15 Oct 2024 11:19:33 +0800
Message-ID: <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Tue, 2 Jul 2024 at 14:39, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Add iopf-capable hw page table attach/detach/replace helpers. The pointer
> to iommufd_device is stored in the domain attachment handle, so that it
> can be echo'ed back in the iopf_group.
>
> The iopf-capable hw page tables can only be attached to devices that
> support the IOMMU_DEV_FEAT_IOPF feature. On the first attachment of an
> iopf-capable hw_pagetable to the device, the IOPF feature is enabled on
> the device. Similarly, after the last iopf-capable hwpt is detached from
> the device, the IOPF feature is disabled on the device.
>
> The current implementation allows a replacement between iopf-capable and
> non-iopf-capable hw page tables. This matches the nested translation use
> case, where a parent domain is attached by default and can then be
> replaced with a nested user domain with iopf support.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  41 +++++
>  drivers/iommu/iommufd/device.c          |   7 +-
>  drivers/iommu/iommufd/fault.c           | 190 ++++++++++++++++++++++++
>  3 files changed, 235 insertions(+), 3 deletions(-)
>

> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 68ff94671d48..4934ae572638 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/iommufd.h>
> +#include <linux/pci.h>
>  #include <linux/poll.h>
>  #include <linux/anon_inodes.h>
>  #include <uapi/linux/iommufd.h>
> @@ -15,6 +16,195 @@
>  #include "../iommu-priv.h"
>  #include "iommufd_private.h"
>
> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> +{
> +       struct device *dev = idev->dev;
> +       int ret;
> +
> +       /*
> +        * Once we turn on PCI/PRI support for VF, the response failure code
> +        * should not be forwarded to the hardware due to PRI being a shared
> +        * resource between PF and VFs. There is no coordination for this
> +        * shared capability. This waits for a vPRI reset to recover.
> +        */
> +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> +               return -EINVAL;

I am using the SMMUv3 stall feature, and need to forward this to hardware,
And now I am hacking to comment this check.
Any suggestions?

> +
> +       mutex_lock(&idev->iopf_lock);
> +       /* Device iopf has already been on. */
> +       if (++idev->iopf_enabled > 1) {
> +               mutex_unlock(&idev->iopf_lock);
> +               return 0;
> +       }
> +
> +       ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
> +       if (ret)
> +               --idev->iopf_enabled;
> +       mutex_unlock(&idev->iopf_lock);

Also iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_SVA); is required
In thinking how to add it properly.

Thanks
