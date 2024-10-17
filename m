Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49322611
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729129479; cv=none; b=LuPl6cuFT71LcktGYxNuaUVc0RmIKDXxACDlk4Bo5LUgd4yYm64EuweIuuRFYvRiXJqObSTMByOZFxDEBRjy1LyXD81zkS2ofG0PWY7CQL1i3RJN910eDbluRz/rJJ/55fbMnGQ4LFXCfzcmIh+9r714upSARBBAFdLvWtDfA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729129479; c=relaxed/simple;
	bh=2+pnXpEJ3Ejed6zS36rBiZimXMhI+VQNS2H6P//GnIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCKQxr4UZTr6cfFR4wdDJ9HrHmGTrxafXnrizvFLzqoPYYsoo5kkuIs4euGMIHFczZnxcyeWGYMbIKfqzc2s3UQD8ijggl+Veen/lzNYM+PlAn4+D9UJd32zbq/ie8IWKiOAGvgJAE4T4Oxy0Ci4pXhgfs+Wr1fMPGe4r5yE2Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Apv140TK; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Apv140TK"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 79C0A400FE
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 01:44:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wWgp6YsWK7ZE for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Oct 2024 01:44:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12a; helo=mail-lf1-x12a.google.com; envelope-from=zhangfei.gao@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 07684400F2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07684400F2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Apv140TK
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 07684400F2
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 01:44:31 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so571365e87.1
        for <virtualization@lists.linux-foundation.org>; Wed, 16 Oct 2024 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729129469; x=1729734269; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bOLME2vkiS4WulapUGeKy8qBzIm8BZ3xRNuJKUmClTw=;
        b=Apv140TK0LZQnw5dq1R3/RzbaQXS7pjMqfjlV4sIsvpidNKrwdkj7RNDHCdqguR1tA
         VQjnNRb7p/Aob1KRzztR/JXSfkrFuHPQOc9Niy2XNswUlxtwb5CaurAELdMZGV6QPRa+
         yieFyZ85JwPUpevNvFBGVkS9ZnwUUs+xJ6ZQAOziy720juqAex9NeoPyeewapeElSDaS
         jvVkPLTVNqTKg/A/l59tDYdyPa03DZbhtchNR3l9ZQhPFleMP9atQN3FYKSvnYR1JG6L
         YL/NtEKSuVRjL/DRKXMc8ouCr0e7mJohmVirgq7KtT+6hqGoSNQmQH2sE/ugvevFozYE
         sScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729129469; x=1729734269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOLME2vkiS4WulapUGeKy8qBzIm8BZ3xRNuJKUmClTw=;
        b=LFDwAQCpWafF+69CnsUzkUzMAkMGpeI9LxuARgL/AQ3NbE5gTXqhXZV59AzfXLTNIw
         qNqqv6ShUJbS9QLmntqgBJ4nz7Z9z1nEMIgXAgJ21II7Y37KHC7i6UzYp9uCiMHE2XTu
         GKEWaYlNyfMv9GR0bdgj6eLPUhxSPG905DpL6fp5gmWx6NYMrLyWx45bOBXxij1koWIi
         rqNjrW67vJdCYzkRPIbpaliL8v8mwNqBiHAj/3rLti/4ctIv7G7rayB2+1EpHNQL+yw7
         /tfhPpzOed9W9eYLbo3oziPHMlHUOZ2AtrOcIkYEdJ0vU4pkrq3TRIIdshDQCuV1onk5
         kXWA==
X-Forwarded-Encrypted: i=1; AJvYcCWqceCwOl+sYBE3wk1e+oLIP9MJXBRjEVweQ88e7mtiJggb8WOSq8DmMvXPnHvVa5CisiFVlYu/F/K5Xn4Eeg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxq6NpWtj6tSf6yXbM3Xv/3t0C0lT8bkCCTZi1/LxAWqHxZzuOS
	3VIwjRpi+vmwypvb7I8exM8yP5A3BnrFpQaihX9xTOSvyKsfBXjEIkmfvF90FvEximFlHiGO4BC
	lISnzaH7x6tApEXhAGyg1NjXCnqHYBVHJgZEfOA==
X-Google-Smtp-Source: AGHT+IGqvkXfSOamlQfTibVlHYj9ChYt1KAqdmYe0Mwzkkqn6GXfzsT96yxwcBZHy6+yoP+eA8EwacKcwppzcsWH1y0=
X-Received: by 2002:a05:6512:124c:b0:539:e333:181f with SMTP id
 2adb3069b0e04-53a03f04762mr4004850e87.10.1729129469334; Wed, 16 Oct 2024
 18:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
In-Reply-To: <20241016152503.GB4020792@ziepe.ca>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 17 Oct 2024 09:44:18 +0800
Message-ID: <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
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

On Wed, 16 Oct 2024 at 23:25, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Oct 16, 2024 at 09:58:36AM +0800, Zhangfei Gao wrote:
> > On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > > > +{
> > > > > +       struct device *dev = idev->dev;
> > > > > +       int ret;
> > > > > +
> > > > > +       /*
> > > > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > > > +        * resource between PF and VFs. There is no coordination for this
> > > > > +        * shared capability. This waits for a vPRI reset to recover.
> > > > > +        */
> > > > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > > > +               return -EINVAL;
> > > >
> > > > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > > > And now I am hacking to comment this check.
> > > > Any suggestions?
> > >
> > > Are you using PCI SRIOV and stall together?
> >
> > Only use smmuv3 stall feature.
>
> Then isn't to_pci_dev(dev)->is_virtfn == false?
>
> That should only be true with SRIOV

Do you mean
if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn == false)
    return -EINVAL;

This is fine

>
> > > FEAT_SVA needs to be deleted, not added too.
> > >
> > > smmu-v3 needs some more fixing to move that
> > > arm_smmu_master_enable_sva() logic into domain attachment.
> >
> > Will think about this, Thanks Jason
>
> Can you test it if a patch is made?

Yes, sure.

Thanks
