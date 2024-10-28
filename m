Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE251CC88B
	for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109411; cv=none; b=LtWbbanFwruj3RqDWJ7O84n7DCeU8gLewvTEiyGvR9D2UaPSkxZQo433ePtQMQc0o9fgox7ALyASQM7nk5fPOfgWH39g466yxJqr2DbmGulwh/LsrvVNB05P2T9KQZGjWYXM1Y0Rt9NUrVAB8K4xRFBKyO9LiwIcb3XuvRbl69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109411; c=relaxed/simple;
	bh=RiH6D3l1BYetcyeHc3NgSPwEUIKjfMpkQxy3ymImDug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBTXsNH1bCMGA0mziD6k4k9i1tVTlhP7vzKCR8Dhuut7EnGqfug4/uvyha8SJXuN1T8sDhshMeDonQwF5LJfb/b0vyPjQCaFP3kzah0aP3mIKUMVmZaGwxj74mytoGmSO/K+0qytCn4/KB8i769D+9D+kSZzDs6ZsnkBuY/MAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6dXVEo0; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6dXVEo0"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F0FF80BB5
	for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 09:56:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E-OetK9TQmpV for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Oct 2024 09:56:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com; envelope-from=zhangfei.gao@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F2E6380BA4
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2E6380BA4
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l6dXVEo0
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F2E6380BA4
	for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 09:56:47 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-539983beb19so4793772e87.3
        for <virtualization@lists.linux-foundation.org>; Mon, 28 Oct 2024 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730109405; x=1730714205; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P8zwHHVlFDhC3eCYRjgzIufh+8Duk97Oi3BDhNd/SH0=;
        b=l6dXVEo0fPlUsPyt9FSuVra/cflrb4T9GAdx1Ruuq8nmW5wWFbvKVNS1nyR46jhv6o
         lllJrQNb+mVBn87nOMJbE6pyMcV+ykZkg6q2AY3HaxT7M1yFsZTqAWJQ5gNbt5KZi6eT
         tYxim1ax5B0mskM5ksY2+/w01PxcMjbZ2wwHaTUbFr9odEaCNSu3TgdYh/hqT54LB/hl
         +wzht/58xEL6br4mNFUcM2Wgmcuj15xPKs3LUFazlsDyn5djnTMY2+MgA5g6QytkQKNT
         TI1mgsK8gqY19iFHuIt9qwTRuXNPfmtbxUvdlAp5GTtkyg2c8Z+3CpCfU0RIkdwY5W65
         sTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730109405; x=1730714205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8zwHHVlFDhC3eCYRjgzIufh+8Duk97Oi3BDhNd/SH0=;
        b=BVBUmw3VhJ3CuEpLorj+VzlchOv2qJgrlEhphF8oO3fip1J9usS+NsiloMdu1l4WAN
         IZYbyh5nSR567iU6GE0p0kT9n85KBfAh7BnKw80ImGx3zRxEmoVmx9x5TGee3LBw1mML
         ZErYR2HY1cFJlYXi7rDHVJCTjMIjyEMo92zn3IWypGaaHli37Bs+G8Zl+fzVYwq65ZjX
         F6qWbKBy54QKBzzSZXbArQTiRKw3fK661olqLWNwzfKltbkKQFGVXIb4+QxNKRne6gck
         lh1hV5RrCRSyAlqQzx/RoND6F5SwAizBi+CEtDYnfRD+eDtzF17Cje1rJ6xOH9OIFabD
         DHlA==
X-Forwarded-Encrypted: i=1; AJvYcCVH2sT5C7ohe8v5ucu6ZiRlBBexrsXU7R1GEmDTYruVfWxgXT9gjxjHJj7+wONKFdzrhn1pLoV0JwhhpDt5hw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxU4o+iWw0/W18lg69uxyXoCXdPH7+dLVU7GWhTWh1OFObWMpa7
	5hYLnDUAIAnrhhVsRoZUPjyH62h4OfX7xfpsfiujg5xZxg+2/an5wWV2Ja0c37mYtYH/daUY1KK
	0EkdtNt6BeLUmL+NvtfjQpZ4pOvr4rl0XbVEQVA==
X-Google-Smtp-Source: AGHT+IGPJlmP5++H8GZgIolANUUnQm/hil6sECZXrtRl0gMOO8zCL/uGJFkEPpBWQMpVap1I8eF1RQlMPNEQCKQkew0=
X-Received: by 2002:a05:6512:2304:b0:53a:aea:a9e1 with SMTP id
 2adb3069b0e04-53b34a1afd9mr3531208e87.54.1730109405411; Mon, 28 Oct 2024
 02:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca> <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca> <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
 <20241017130805.GA926121@ziepe.ca> <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
 <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
 <CABQgh9HYDRVOYtL=jgc4CqX0XhNmCtBDOCm8S6_mgBzBtZVk7Q@mail.gmail.com> <e030bf31-330c-4734-be13-634174c7b099@linux.intel.com>
In-Reply-To: <e030bf31-330c-4734-be13-634174c7b099@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 28 Oct 2024 17:56:28 +0800
Message-ID: <CABQgh9EQjEpHLn76g0Fdu7L6PwmYbiJxuPT-OSPKo7SrN7dAgQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Oct 2024 at 22:26, Baolu Lu <baolu.lu@linux.intel.com> wrote:

>
> Can you please make this change a formal patch by yourself? As I don't
> have hardware in hand, I'm not confident to accurately describe the
> requirement or verify the new version during the upstream process.
>

OK, how about this one

Subject: [PATCH] iommufd: modify iommufd_fault_iopf_enable limitation

iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
because the PRI might be a shared resource and current iommu
subsystem is not ready to support enabling/disabling PRI on a VF
without any impact on others.

However, we have devices that appear as PCI but are actually on the
AMBA bus. These fake PCI devices have PASID capability, support
stall as well as SRIOV, so remove the limitation for these devices.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/fault.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index bca956d496bd..8b3e34250dae 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/poll.h>
 #include <uapi/linux/iommufd.h>

@@ -27,8 +28,12 @@ static int iommufd_fault_iopf_enable(struct
iommufd_device *idev)
         * resource between PF and VFs. There is no coordination for this
         * shared capability. This waits for a vPRI reset to recover.
         */
-       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
-               return -EINVAL;
+       if (dev_is_pci(dev)) {
+               struct pci_dev *pdev = to_pci_dev(dev);
+
+               if (pdev->is_virtfn && pci_pri_supported(pdev))
+                       return -EINVAL;
+       }

        mutex_lock(&idev->iopf_lock);
        /* Device iopf has already been on. */
--

2.25.1
