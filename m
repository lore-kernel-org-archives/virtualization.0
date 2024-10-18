Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE21547E1
	for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 02:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729219529; cv=none; b=nknDgTUGsrAdZ3ypXRNJLej8GRfHq+MBuhkmkYqIDjAvy/UtO9uuuMfW9xKL5iZFEz9zOgyXJBZ+cuujPHVoAjYXFG1mteezj8yH92M2JMxI10eTagJq4lpkh6AvpRv2PjXsUiZ65OyV5vHkPrkM9CQXuXspisrJadRS2YSSl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729219529; c=relaxed/simple;
	bh=kgRRZiy9FfZN7xD7EZSFKYhFZvRCjUnO4G3r4bM18nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9J7HC/aIGAaW3F1GNDaBepZUUXX0pJT3dWP3D2ksq78rLbYQ6QnVevn6BIhwbhlAbN8woxI3A3o04R2UwlsR5XckEbNRarEPQU+iSHIaRvK/mKAJlozBXIddpKS0+weyiSi+WqswdLQmqhbZ8+xNixikvFe6TtVxZWtvGYNOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vlB6AB7i; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlB6AB7i"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2CEFE40252
	for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 02:45:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z8AuM36tZU4M for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Oct 2024 02:45:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::132; helo=mail-lf1-x132.google.com; envelope-from=zhangfei.gao@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CDFC140004
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDFC140004
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vlB6AB7i
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CDFC140004
	for <virtualization@lists.linux-foundation.org>; Fri, 18 Oct 2024 02:45:24 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-539e13375d3so1866707e87.3
        for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 19:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729219522; x=1729824322; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1sLZ/lXwGBM2rahMvEDIQo5diSLBoxj3foQMEQZCG+M=;
        b=vlB6AB7ioWcTqWj3/DjePmVM023Qk6Fw5WxHZfofZFy4oKYz8q2Zcoco7LBMHwHGI8
         gWToiaH4tFuV8km0S1yvbPrglh8I8p7zvkoRbj4oez2qz6B33Hu1JjZJUNrTIxMstmdm
         iomsL97n1upiaOm+znyzU8ZpgZTF2pUH6kDXKVuVNZENFhJKoaPY3WJ8hOf72i6qoKRp
         aHVwT3M1KDeCABsUF5NewbuLF4MrzNBgkO/OVtFvy6h5T45hYnxZ/5UIOIvtvZEyT1Gc
         IjY+6qwH/fgheqr8cc2gKPxx+JZknH05gZIXKwRvHi2qTVcCk+vY72xlX8qJspPQNOxf
         MLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729219522; x=1729824322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sLZ/lXwGBM2rahMvEDIQo5diSLBoxj3foQMEQZCG+M=;
        b=KvjLZcYPs1IOmnj+dI6XHaJyW8cBSFIwUj1nyRr7JanTMzwYy9OuMlhUU/yV0Qyst6
         +jsV4PJY/hSG63upv+xq11+4CDp/diGiMj0zPaB//Az/j/DEi91rM3K6nn/8/nnV2F79
         24krAQyVRxd1kojaOiCtnQMKv/YuFg8eTeMofkdVL15/PJPMeBHWD0QgLxLyWyOaFvPo
         yojJ8F1uO9sHz3dqldBChztG2cNpgogJoy30kY5NI7Jh9EfX3M6Cd6Zmh2o7Qh9LDC84
         1LnZzU+r5cOQfek6n+VegtWTjHpgm54kJaDHzdmOOGpW4i1rdoXLi1Fo2otN0uebltPX
         itlA==
X-Forwarded-Encrypted: i=1; AJvYcCWzeenCTi34xf1LQiE3eR+ODh9hmY5XGZ0Wa1NEC41TsOxMzcQNJ+PqLWvbZxXtdb+Ev0xzzmk6xW2XinJ36Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyxYZ7xWYDYCi0xW1H9VD9LdYHYpBnEd9xmG/Is5G8OdvuOMd4b
	TF9J3+NG0QJknR9dhDimcJAUHCNnLn7donfD4K2S5dXPglIizuCiBIk9vqnAxGVNq/Q+gyX+DwG
	tblg5kgX0Xuergi6aSHAF9FcDJVRZaxBL7h5bVw==
X-Google-Smtp-Source: AGHT+IE4lNRH1NWbi5vrC+GoEkZzjuYwAofdC4w+Awg53/xnT+cp6AFOUD/q+symJRS/APkqXdj2/T+NOFXcw+CS00A=
X-Received: by 2002:a05:6512:128f:b0:539:f1ce:5fa8 with SMTP id
 2adb3069b0e04-53a1550b9e6mr438878e87.49.1729219522198; Thu, 17 Oct 2024
 19:45:22 -0700 (PDT)
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
In-Reply-To: <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 18 Oct 2024 10:45:11 +0800
Message-ID: <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
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

Hi, Baolu

On Fri, 18 Oct 2024 at 09:58, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2024/10/17 21:08, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:
> >
> >> Yes, you are right
> >>   I am using SRIOV vf and stall feature, so is_virtfn == true
> >>
> >> Our ACC devices are fake pci endpoint devices which supports stall,
> >> And they also supports sriov
> >>
> >> So I have to ignore the limitation.
> > I see, so that is more complicated.
> >
> > Lu, what do you think about also checking if the PCI function has PRI
> > ? If not PRI assume the fault is special and doesn't follow PRI rules?
> >
> > Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
> > fault?
>
> This limitation applies to PRI on PCI/SRIOV VFs because the PRI might be
> a shared resource and current iommu subsystem is not ready to support
> enabling/disabling PRI on a VF without any impact on others.
>
> In my understanding, it's fine to remove this limitation from the use
> case of non-PRI on SRIOV VFs. Perhaps something like below?
>
#include <linux/pci-ats.h>
>         if (dev_is_pci(dev)) {
>                 struct pci_dev *pdev = to_pci_dev(dev);
>                 if (pdev->is_virtfn && pci_pri_supported(pdev))
>                         return -EINVAL;
>         }

Yes, this works on our platform.

Thanks Baolu.
