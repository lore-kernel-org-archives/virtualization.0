Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230561A4B69
	for <virtualization@lists.linux-foundation.org>; Wed, 23 Oct 2024 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678980; cv=none; b=NSdXQWUSSwVgo7PpK067gTHD0iSdxnk/cmKfyucLNcEv5ZEfX8VLyWWNzlj60gvVsnca2V9E4gDGRv+mOyIdSsMCf3qPJ7TuAy/q3i9GDIUMRp90nS/VBX13UC6Z/xOH6dFeHLXUMhWGfnaoXd9QXxUp2cvTcQKLzpeZADgA46g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678980; c=relaxed/simple;
	bh=NS4ilObULb/+LNuO08aUDsktHnNBmiP8ABY85oWc1eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWXvjAulVS537Hznbf0fUtxfwpOw6BSzsSYkL2Xy8DsQUS7upxewwlrIHXalKfV4cYYBTG135Tnz7vYGBWeLStyQhSH99aK/wOmgggLRj2RG2s0Mq+xL8jUNeEfRYeJjRRB73smBJOx+aofNLz9Ja9zgrNkCNy1F/H9j5dfDvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GK9F6McV; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GK9F6McV"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB56840263
	for <virtualization@lists.linux-foundation.org>; Wed, 23 Oct 2024 10:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xSJ2yQV6o89e for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Oct 2024 10:22:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::22b; helo=mail-lj1-x22b.google.com; envelope-from=zhangfei.gao@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1360440167
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1360440167
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GK9F6McV
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1360440167
	for <virtualization@lists.linux-foundation.org>; Wed, 23 Oct 2024 10:22:56 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so52171421fa.3
        for <virtualization@lists.linux-foundation.org>; Wed, 23 Oct 2024 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729678974; x=1730283774; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=it5qqymkWGY0OitCSnqR7X8aXYDfuNSva2WMI6HrQ68=;
        b=GK9F6McViavRMQUNFRfM6hyYh5Q1SHcJa/xwpQ3RqngElcRL94sSgI33qdmIY6cJdk
         TLKSZYsu+xG5RPjVor3joH6nHTIO0Y5CwQcra/KOrBB3ElWjeoAY6L1Vhnm0aabXsPoR
         k8ncn/CD4fEvUa4lSAbPXzCCcq31GRWGCkiSfekgpvztZ479jQXsvpEfOxk8CtPwJmbv
         SPCq4K4n1vPquNVL6ah+/LDFM7DFPasjFD4ckwU/eHW0evtxac666JWsQbochx0fAPpS
         f3T5sLKwiP7sDt+mgzN7ktkJ0oT28L7A4tRPgHbyTQp0Pnh0rn6fgaXLuBXhVywzwGsf
         tFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729678974; x=1730283774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=it5qqymkWGY0OitCSnqR7X8aXYDfuNSva2WMI6HrQ68=;
        b=GqA8mNVlPb4YCbv/LvtbIiMUrDyd6Tdq3prlNpiLgoFuushmnz9jVgYzE5lQqcu7Uj
         rELYWnncLhVfasqqiy+PiqfwJQxeHG+gpoGq2CpX8OMCXgTDUhRu3rDtrHjpGFzThX2j
         RJaSZczVK8U4G7bhCDNZYL69wYyJzsqZzlOSLdRvkwd4zSlhjefXHTxXsdPodGxZOMLT
         B1nw2jTsoQhk9afQZ71w3OAISJzk3fswXe+wv4W/6i3pgKnKDulGms+0scznrfWhjVhl
         B2VNktEDUtVHhopNbS6MAChbhf8kp/HKiqg4Fhf/G0c/COQ/20rZ/Dj2hP9jXHsoyQr7
         wwCg==
X-Forwarded-Encrypted: i=1; AJvYcCXA1JpOsXWf+Pmuc76SLvs2ny3xvseU32sfvMyruJmF7Dj1g4Rfq8s/TctRAyWHS+zuGfbFTW6prYfC03Xzyw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YymENTBRSiMm1RIvZyTy9g4J0+/y5hUMg9NUrnYrAchO0QGV+1w
	r6Ie8ktJMqz3rUrWujT3Ku6VIOn95xN7288X5qhg1n7GGPzjeeMlZ12CyScS1dY6A8xpsGH42dm
	fnPIAuc+prD1vFcjEu/TNTpMLN+bA7Jx5Sb0OBA==
X-Google-Smtp-Source: AGHT+IHSlBLk0S83wm+5RZnogzP4oUfDRPvMnigWOthmmvnTrPqpN9jwiZcT3cwHLQu70zUFj7sVT87cHsqqjLDYfWw=
X-Received: by 2002:a05:6512:308a:b0:536:56d8:24b4 with SMTP id
 2adb3069b0e04-53b1a30c28cmr1039048e87.5.1729678974140; Wed, 23 Oct 2024
 03:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca> <20241018135343.GA1914429@nvidia.com>
 <CABQgh9Hd0QCfEtVcMyXG+=KHuZdGGUA=kk5iL_ysOzfOpLh=-w@mail.gmail.com> <20241022145257.GB864191@nvidia.com>
In-Reply-To: <20241022145257.GB864191@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 23 Oct 2024 18:22:42 +0800
Message-ID: <CABQgh9E4XE6G7cK6_77ZsXgvfdOfa4rXXU2VUVxkqRd01tG+Rw@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 22:53, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Oct 22, 2024 at 10:30:10PM +0800, Zhangfei Gao wrote:
> > On Fri, 18 Oct 2024 at 21:53, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 12:25:03PM -0300, Jason Gunthorpe wrote:
> > > > > > smmu-v3 needs some more fixing to move that
> > > > > > arm_smmu_master_enable_sva() logic into domain attachment.
> > > > >
> > > > > Will think about this, Thanks Jason
> > > >
> > > > Can you test it if a patch is made?
> > >
> > > Here it is:
> > >
> > > https://github.com/jgunthorpe/linux/commits/smmuv3_nesting/
> > >
> > > fa1528253d2210 iommu: Remove IOMMU_DEV_FEAT_SVA
> > > 5675560a272cf5 iommu/vt-d: Check if SVA is supported when attaching the SVA domain
> > > 94bc2b9525b508 iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
> > >
> > > Let me know..
> >
> > With these patches, do we still need ops->user_pasid_table?
>
> It makes no change - you need user_pasid_table to make
> IOMMU_DOMAIN_NESTED work.
>
> If you aren't using IOMMU_DOMAIN_NESTED you shouldn't need it.

OK, I misunderstood.

Then with user_pasid_table=1
both with these patches and without patches, user page fault is OK.

>
> > if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
> >                 attach_handle = iommu_attach_handle_get(dev->iommu_group,
> >                                 fault->prm.pasid, 0);
> >
> > // is attach_handle expected effect value here?
> >                 if (IS_ERR(attach_handle)) {
> >                         const struct iommu_ops *ops = dev_iommu_ops(dev);
> >
> >                         if (!ops->user_pasid_table)
> >                                 return NULL;
> >                         /*
> >                          * The iommu driver for this device supports user-
> >                          * managed PASID table. Therefore page faults for
> >                          * any PASID should go through the NESTING domain
> >                          * attached to the device RID.
> >                          */
> >                         attach_handle = iommu_attach_handle_get(
> >                                         dev->iommu_group, IOMMU_NO_PASID,
> >                                         IOMMU_DOMAIN_NESTED);
> >
> > Now I still need set ops->user_pasid_table, since attach_handle can not
> > return from the first iommu_attach_handle_get with fault->prm.pasid = 1,
> > but the second iommu_attach_handle_get with  IOMMU_NO_PASID,
> > suppose it is not expected?
>
> The second handle_get will always fail unless you are using
> IOMMU_DOMAIN_NESTED in userspace with iommufd.
>
> What testing are you doing exactly?

I am testing vsva based on Nico's iommufd_viommu_p2-v3 branch,
which requires IOMMU_DOMAIN_NESTED in user space with iommufd.

About the three patches
1. Tested host sva, OK
2. Simply tested vsva on guests, OK, will do more tests.

Thanks
