Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C381684A5
	for <virtualization@lists.linux-foundation.org>; Sun, 27 Oct 2024 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730038395; cv=none; b=i+RgrkDbhTaehbHmEmUmZomt1LNj9csHyHB9Lj2bpMLVnqD3WUL768x5lX6lKxUqof609hC2iBk+G0P4s+qwZy7t3gU21cb731OohosfJbHReNpoF3kqBsXZuwuu1ffnxCsUx/MdkGrE/21MPXL3nmis9P4uwCn+GG5fQAJmjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730038395; c=relaxed/simple;
	bh=NuJVWMDK6/NmMLATecVP6fHMJcRsxCQ6vGdOe7SC6Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/c8ceNggDE4ky//1pHrSvvoK8nUFVM64RTLR24zlNihUUnMM1ahb0qE1rSjYF7RP+e1lMJg9OZ5TTfBHBz7jn9FCBw0QoPd18FS0sZDCHdOzNNG0UzbyLzMuGvb3RapoDpFGkLi6SS1YZLPBoyjBWF78Bdhg6mCDjVguLCcVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yk3s/8yQ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yk3s/8yQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0BDB740450
	for <virtualization@lists.linux-foundation.org>; Sun, 27 Oct 2024 14:13:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K9_2bp47IH6k for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Oct 2024 14:13:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12b; helo=mail-lf1-x12b.google.com; envelope-from=zhangfei.gao@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 34F54404D7
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34F54404D7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yk3s/8yQ
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 34F54404D7
	for <virtualization@lists.linux-foundation.org>; Sun, 27 Oct 2024 14:13:10 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-539d9fffea1so3235573e87.2
        for <virtualization@lists.linux-foundation.org>; Sun, 27 Oct 2024 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730038388; x=1730643188; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mY015nA+JmXHvPrUJpYeYBU2P2Uf8UWr8WMYD7k1UEk=;
        b=Yk3s/8yQ6GIlTqE1kE9Ic3SE8C0g3IKFKnt/RgdK5J1ndojgGJUqKnDWhsuTa5sP2h
         AzMWpziOpU7fmohWcOvg9M8OAfHTnMndYv5qSLdCkrxooHFaC1xJKj5nlcXOjokWoLaF
         F+CbrZLTQFGVG8ER2osObk8WMRQ3XZnft99Fh0ODDwJht2RmEejY+kjditH9ojNIPbJB
         LQ2I99PBRsFsq9Z2NQSjbZwGc6Ok9KKkHpNbBQTknT8O/KVbw3DE/yohfQS0lOkZGzon
         ikIZv97NOyw7ns90bF3IImaEZNS2ocUptED5bBmXfyqHS/WV7OPbtuDQgok2Asnq2qqC
         KmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730038388; x=1730643188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mY015nA+JmXHvPrUJpYeYBU2P2Uf8UWr8WMYD7k1UEk=;
        b=CEpO6wGLet2ubRDZ6vPlmgsJJ2IwAIyZeD/0XuQuQRVr0hjmP/UZl+KvSIYkFQ+8eg
         xewNAP1aj9cKxOrDzjYEDwzCKzSHa8aRo18UxJ34KFU29sQUvVyi2GVl4V3+n76TT/tu
         UISU+XE0rU7d3pveCDI6exwgX3sdmYwEtJDmnnuZRJc011CidDm0ipy3rJWuP4rJFe4Q
         U73MxXgZ59O+fApiBGblTAcv8eblkqzkZyPJKpIyrV/M/k0MD9Mu4tbqM0rh1uAGikEj
         gqB/apd+kWamyeN1nFDSb0LvJgqNyoIEn+on0etdwkZPvi/V/OsHG6ePenRA/cXUEBOB
         GANw==
X-Forwarded-Encrypted: i=1; AJvYcCUURNSgVQpdw29hBD8UriF25H1ikiAR/Is0+QFul3yq825A3Tt4JCgd5e3Za0l6UO23t3fl92rblIJPm5S3PQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzDKLA7PfTFAq2CbGZJd9gG/CrXPW4y/E7wl6nkYcpmIlmf32AD
	yzw5x3lj7imBHx7Fj+irFGc6lO/+VAgsjI21IaXO1NloFnhAMxyK1v/397qIuLGiRhvP30LwAmD
	nVGQWi2YqLXCaVtiU9GN64YCkRa/fh/o5SFjT0Q==
X-Google-Smtp-Source: AGHT+IG4rD8sxA4zeN56s3nv4eo2saz2wQJT8dqXvPZ5lIrF4A6ASYbFn9RyJjsRApMWKVy/sZQFavLyt3vl81pP7/0=
X-Received: by 2002:a05:6512:3b27:b0:539:de9c:c890 with SMTP id
 2adb3069b0e04-53b34c5f9b5mr1778649e87.42.1730038387547; Sun, 27 Oct 2024
 07:13:07 -0700 (PDT)
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
In-Reply-To: <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sun, 27 Oct 2024 22:12:55 +0800
Message-ID: <CABQgh9HYDRVOYtL=jgc4CqX0XhNmCtBDOCm8S6_mgBzBtZVk7Q@mail.gmail.com>
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

On Fri, 18 Oct 2024 at 10:45, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> Hi, Baolu
>
> On Fri, 18 Oct 2024 at 09:58, Baolu Lu <baolu.lu@linux.intel.com> wrote:
> >
> > On 2024/10/17 21:08, Jason Gunthorpe wrote:
> > > On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:
> > >
> > >> Yes, you are right
> > >>   I am using SRIOV vf and stall feature, so is_virtfn == true
> > >>
> > >> Our ACC devices are fake pci endpoint devices which supports stall,
> > >> And they also supports sriov
> > >>
> > >> So I have to ignore the limitation.
> > > I see, so that is more complicated.
> > >
> > > Lu, what do you think about also checking if the PCI function has PRI
> > > ? If not PRI assume the fault is special and doesn't follow PRI rules?
> > >
> > > Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
> > > fault?
> >
> > This limitation applies to PRI on PCI/SRIOV VFs because the PRI might be
> > a shared resource and current iommu subsystem is not ready to support
> > enabling/disabling PRI on a VF without any impact on others.
> >
> > In my understanding, it's fine to remove this limitation from the use
> > case of non-PRI on SRIOV VFs. Perhaps something like below?
> >
> #include <linux/pci-ats.h>
> >         if (dev_is_pci(dev)) {
> >                 struct pci_dev *pdev = to_pci_dev(dev);
> >                 if (pdev->is_virtfn && pci_pri_supported(pdev))
> >                         return -EINVAL;
> >         }
>
> Yes, this works on our platform.

Will you send this patch?

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks
