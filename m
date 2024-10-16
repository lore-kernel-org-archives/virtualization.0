Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20E914B06C
	for <virtualization@lists.linux-foundation.org>; Wed, 16 Oct 2024 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043933; cv=none; b=Ys9dTFfvBBThkfrclGV8tl7rpoY70WjFxbz+3WUeLyTIf43N3UGjSFkxyddmnHOL4XyQPyomErY3yrPUJt3A+xi3M/LIrERQzZ1YOS1USrNMUSTw8UbEcPqkd4KOgBO0pHEaxbpVdf4C6ejZpMEeR0hiY4FA+ZXdKKT1n+Wsmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043933; c=relaxed/simple;
	bh=dVq8802sNgxsYQrKPhpLGl2Ji48gzebkMI0KMfI8BG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1lovrnWDhmOtp1b5G86KwcmM+Cs5PuiABEOuBZyz5UeoxG87lFDiTgai61ke5uAklWLdFmqvCRyw+qEAUcutdJOgsM87MCwUyFX7i99pM9W5Lj+5MJEAUV70axDZm+TfNZse7j2fYEGTkSV/p2MzWOwLEEZ2PDvwX1/2rmIVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=taPsKg/3; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="taPsKg/3"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6F78608A9
	for <virtualization@lists.linux-foundation.org>; Wed, 16 Oct 2024 01:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 58axMPPvDt3P for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Oct 2024 01:58:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12c; helo=mail-lf1-x12c.google.com; envelope-from=zhangfei.gao@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 72C25608BE
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72C25608BE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=taPsKg/3
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 72C25608BE
	for <virtualization@lists.linux-foundation.org>; Wed, 16 Oct 2024 01:58:50 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-539fe02c386so443143e87.0
        for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 18:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729043928; x=1729648728; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A/rtU2ORxq4VQYJugdVXcy5ZyrAZXc1jQ9TPE/XvnVI=;
        b=taPsKg/3qWvKprQdk3phNhMmb+0X8gCssBdCtIoyy1uiD27gPjIoAXg4/qiyv37FNV
         vog56jukz9kYlWqmVq9k0iF56Xdq0Vnd19g4vFmtMxHsUwISNt6CB85sl7zgSZ/nx805
         fJvEBxXRoO/1qR7WwRNOe3a1b7sZZknKJAt05qIQQq7qpmvHG/6AQvvf4hA+nj22sEUQ
         lvf37bx8j+ZRPI0pXa7DtR3o5iuTbt6T46xz45H50KFGEl4ILq8ViAUvFMKDbyrAhB7j
         GV3w8v8DaWz5wpyUVMJQyhNS/dBghEltbV+/bBhRE4q8EsnOo/SRhr2qbGgnn4kHbjNx
         Y/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729043928; x=1729648728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/rtU2ORxq4VQYJugdVXcy5ZyrAZXc1jQ9TPE/XvnVI=;
        b=Nj+6wAZMEW5BgDPqxcI9c90nS4F5wdUZkcQXLeT859I13ckn/Ek6V3KGyrUGEW9w0E
         QoWo/dna0JKAjw+nN3P6pi+86rvAWRNypG8FeXFXeEJZDye9Ptk7FONvBsaSldld3E9S
         qGKSUc1nQmnjhEpKixmDcYxEyuaVWBGYKbIvxRFSaUxgZwBT8dRNSpOrvNe4qc/I6oD8
         ziAz87CcHeejkuN2xvDC+sMfeTsI4ixDecv6DUQhqRKGNNjocDE0yWGxpqRq1FkWNnYx
         wxpSCmsaceBAwBoTn1CY4NH47SVCXHgT6yYekII+qPcW2vi6F0H69r6FjDOVCs6r4Mdg
         rsTA==
X-Forwarded-Encrypted: i=1; AJvYcCU5DwOvnC9BCRcLJ+usDV9w5l1uMHIYnE7miW5yIdC+7Zqs8hi4yhv1nq3xvQar0ujZqglr4LJfFNmWqpgNUA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxWw8iNIFesymNqJlYLpRyLkCg2b7imXF7AA6qu5hcecrYjXVn0
	Lb7TukRo8rjwlD53OWkVvNknzt6KqDHXevl+gOLqwCzJa70y6WdUF9fRvUogqMZ5KBaoDy7jRwg
	D+awv1E0NqdyMXd3g5ioJsKFQBhJko1rdsq+jbQ==
X-Google-Smtp-Source: AGHT+IEB/XndljAYmvf9daRxR8zUkYMGinPm83aD1j6YhAnINHWEAphdGASnRtu0uajjdc4lTF2hFS3dM0SJE/wV/i4=
X-Received: by 2002:a05:6512:3a94:b0:539:fc1b:36d1 with SMTP id
 2adb3069b0e04-53a03c8fc81mr731316e87.6.1729043927809; Tue, 15 Oct 2024
 18:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
In-Reply-To: <20241015125420.GK1825128@ziepe.ca>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 16 Oct 2024 09:58:36 +0800
Message-ID: <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > +{
> > > +       struct device *dev = idev->dev;
> > > +       int ret;
> > > +
> > > +       /*
> > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > +        * resource between PF and VFs. There is no coordination for this
> > > +        * shared capability. This waits for a vPRI reset to recover.
> > > +        */
> > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > +               return -EINVAL;
> >
> > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > And now I am hacking to comment this check.
> > Any suggestions?
>
> Are you using PCI SRIOV and stall together?

Only use smmuv3 stall feature.

>
> > > +       mutex_lock(&idev->iopf_lock);
> > > +       /* Device iopf has already been on. */
> > > +       if (++idev->iopf_enabled > 1) {
> > > +               mutex_unlock(&idev->iopf_lock);
> > > +               return 0;
> > > +       }
> > > +
> > > +       ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
> > > +       if (ret)
> > > +               --idev->iopf_enabled;
> > > +       mutex_unlock(&idev->iopf_lock);
> >
> > Also iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_SVA); is required
> > In thinking how to add it properly.
>
> FEAT_SVA needs to be deleted, not added too.
>
> smmu-v3 needs some more fixing to move that
> arm_smmu_master_enable_sva() logic into domain attachment.

Will think about this, Thanks Jason

>
> Jason
