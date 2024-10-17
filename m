Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB281DD884
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168546; cv=none; b=NrC/zqGJb5G1dF9T6Rfvfb1LTcKo1ykdW6Zrx4GTFNpxNLWq+exhqrhzeMaHVOpISbJc53oxtpuvojd/RbLDgaslXUUDqovrw+430bbmXChNSKPIX7d6RJQcYs3UBP2ZJ57lvDeBFgnOvn5b1/6/8IKa0QNYqNfcNDSf65ZhJk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168546; c=relaxed/simple;
	bh=stgROs37qwDGESBufWBachz+WHBFXWh4SvTQfT/sml0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwlEEjLKmvfLYMN1+U1Y40fyhw1+ENBJq+KeXs79uIToGt5b+tHOQAUGsFOcvuzsfsmexpr8IliKHlTjkeLPVknR7gn735NPQor+ZB06GLHz4Gek36UYFWeTH646i09pnMl9CfiGSCUN0p8k8d9ABJ/jiu86DSRpiKtQ+b81Vrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CMWYK5de; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMWYK5de"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9FDB6083D
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 12:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ioFtYcIt4Vcl for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Oct 2024 12:35:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com; envelope-from=zhangfei.gao@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 30EE460766
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30EE460766
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CMWYK5de
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 30EE460766
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 12:35:38 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-539f72c913aso1106513e87.1
        for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729168536; x=1729773336; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kM7OrfRTdZQrTofk4LGSXNvpUV7LDhsGRtxbKPLtBSM=;
        b=CMWYK5dekGlF1+2sU7HRY5vM78d8o4VmnLPhbXtd1d8hNgCNEk+q0afjRHToEYkLaw
         L7/1/fLqEnwQ07ZPmGXsprBwHeND/tIiKhQLC+KJl1Mwo1Ez2upN2c/05zqJDegZDQxC
         Xaeffe0m6Of8Ht+dTxQRaC4EdACXYEg+aBIkAFXjAsTD4lxR1WFiagCp8kuxt3/DJam0
         Sq1GlPkMkWoEjoJt5p4OOfV8IgLiOQVpDVb1uyM+bR6VD8lO7QLJWVjgCU7g0T1K2o7g
         Mtq36uE/c5k65l7Os1ysKPYTuGnjeAsUpTfV8rPDt2N+mF+TEa0Yt4Eu2eRlKfZOxisG
         tBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729168536; x=1729773336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kM7OrfRTdZQrTofk4LGSXNvpUV7LDhsGRtxbKPLtBSM=;
        b=nPGbBdpe06Eug30uYd9eZJ8Ml1mDV3qpzCYBso3lxLgNzDJV/DD3Vt79n/qb+S2F91
         S6cBpUIBFF5v4f6EWADxYpxvNKySD2Apg/F5hJ4MjeMyRP4lw1aG8wxlyL8EO1SLkWQI
         6jCLQ84aTtpnyBDFZYU2PmsU0EEuW0rqSxEeq93FpuBzmeR6ajIV5x8iiKEY4189sioN
         AX/63mze2cQUltRPlfLzkpa6y55fnCB+zOUmfICyL85C3xOg7whFuO+ZPt7jsZ0PHLV1
         ac5WnyLt76YqlP3xz98DMSlkEd8vgYkqqY7ou1AEW0TIqaMRRZJq9Msic3ZogB/GssaP
         5P+w==
X-Forwarded-Encrypted: i=1; AJvYcCU0KmrSN2px+KqXgi90Zxz9ETsYMtVDGi1rnPaz18TyiaumQztBuVzof9PFPXs1Q6izk5YwsP6tBYNEo1ShOQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzk6jdG2pyDuXU8oAGUa++2fFuTYFKf7xbDbJN39YldCF+FT0KJ
	aBDPWSQUdTdGrgYe4Fm0RIszPOwg9oRZKp17YPTIx5aRAC6JpY6qOyJLDmpcxU2qPk5nP3Hq9gf
	5i1BII880WH4wrvDkuJJJChEzsljG3QgzDG/r0Q==
X-Google-Smtp-Source: AGHT+IH4WJKolhUJPprqECOsvSWy5mgerznZLfFjdhTs0fsqDZ0hzHkE+rz7FwoNqJnQZ8jgoGMGTXT1t5RYO39n54k=
X-Received: by 2002:a05:6512:3085:b0:539:e873:6e6 with SMTP id
 2adb3069b0e04-53a03f82439mr5602333e87.43.1729168536304; Thu, 17 Oct 2024
 05:35:36 -0700 (PDT)
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
 <20241017120518.GI4020792@ziepe.ca>
In-Reply-To: <20241017120518.GI4020792@ziepe.ca>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 17 Oct 2024 20:35:24 +0800
Message-ID: <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
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

On Thu, 17 Oct 2024 at 20:05, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Oct 17, 2024 at 09:44:18AM +0800, Zhangfei Gao wrote:
> > On Wed, 16 Oct 2024 at 23:25, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 09:58:36AM +0800, Zhangfei Gao wrote:
> > > > On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >
> > > > > On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > > > > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > > > > > +{
> > > > > > > +       struct device *dev = idev->dev;
> > > > > > > +       int ret;
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > > > > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > > > > > +        * resource between PF and VFs. There is no coordination for this
> > > > > > > +        * shared capability. This waits for a vPRI reset to recover.
> > > > > > > +        */
> > > > > > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > > > > > +               return -EINVAL;
> > > > > >
> > > > > > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > > > > > And now I am hacking to comment this check.
> > > > > > Any suggestions?
> > > > >
> > > > > Are you using PCI SRIOV and stall together?
> > > >
> > > > Only use smmuv3 stall feature.
Sorry, this is not correct

> > >
> > > Then isn't to_pci_dev(dev)->is_virtfn == false?
> > >
> > > That should only be true with SRIOV
> >
> > Do you mean
> > if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn == false)
> >     return -EINVAL;
> >
> > This is fine
>
> No, I mean on your test system you are not using SRIOV so all your PCI
> devices will have is_virtfn == false and the above if shouldn't be a
> problem. is_virtfn indicates the PCI device is a SRIOV VF.
>
> Your explanation for your problem doesn't really make sense, or there
> is something wrong someplace else to get a bogus is_virtfn..
>
> If you are doing SRIOV with stall, then that is understandable.

Yes, you are right
 I am using SRIOV vf and stall feature, so is_virtfn == true

Our ACC devices are fake pci endpoint devices which supports stall,
And they also supports sriov

So I have to ignore the limitation.

Thanks
