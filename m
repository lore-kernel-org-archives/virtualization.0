Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B673FBB9
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918389; cv=none; b=ZZZPdbLXQPb0aupqTscdwx2UqsmxTUKiuoR49B8UFeeQpKzXdiImhjHb8hMOwV4kwP+3exoA7et+GRoyz2DbiXXJ+H1Nqm4UnlSEjclV0a0G6Jhb0I40+OV1Z1q/CIvweBLEsETzwWwhsKIQOa6mJ0mTLyxfdqDdBgPNKtReMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918389; c=relaxed/simple;
	bh=JzkeDh5AwdfJCEuCQJCZYQvR6O/baYk0o5Ac9VAu/wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjmcZ7XHn1zya7IF7pLEQHFtxHJkBRdWtai4BMqp01DwUwlftu9+/p3zvm5wlxbrdzINITsW2Q71toQ3THuvgemxcmr5EPDnvnzWtirNmxDqp0dWeBR5wMLVY+fcI4dMDdhzW7N7gtRWLTayrsl9j1t2FE0O3QpvI1BrKyNBr1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gK1j6OS2; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gK1j6OS2"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 474B040232
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 17:19:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8eSsert2kb4g
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Mar 2024 17:19:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 614D140194
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 614D140194
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gK1j6OS2
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 614D140194
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 17:19:47 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5a1b861e255so675953eaf.1
        for <virtualization@lists.linux-foundation.org>; Fri, 08 Mar 2024 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709918386; x=1710523186; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QyfvgQ7g3k3inQ55L9jhBCdrQml4NQHWxp+tVzvR3qY=;
        b=gK1j6OS2hZmg2IDl+urXvb+qOz+5bGyDtno2xggBzIP+WJoeuJnY0sBhQ4HdMyww/U
         6RwPJar65mb1OOa9kKLNKOa1LbkwP9+ZdmOirI/c5Qlp+eeQdPVYaoxBZwUM8nxum1Nz
         Z3U4Hu3lHgRF/Ge1w35PT86qa7Zqn135q17iwNtaJr8qNBJ7xb9w98GzNmPm/klg0Jbs
         hR99MHRg9XuZ2RI7ADW49zFGGjGQdUo09b4RsIvKoIKhJIi38YmR0KsTWCIR9SBPjkh+
         yz0zq1lPiPjPCSYEap2whbejK1K7DKCqgfJp0nkJBu5CqePde9tOhbRELlN38sNf3pHx
         BF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709918386; x=1710523186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyfvgQ7g3k3inQ55L9jhBCdrQml4NQHWxp+tVzvR3qY=;
        b=Hpro/UwalKVLdPu//lQj2BpbUNKTx4aGEqBNvowsRWsR2d84CPPzK2yqx2iSW00/sg
         Sw+jp3mlaNOewSowp59IAx/4VxlkA6+5JcFdIAS50a73d6vLk18M4bWPmd2AxIdRWJvM
         PaK59aLwLfwtZUx4gv1sM9JDjZKUfaI6RNDcWodDe/0l00tFKABIgxY79nOe6UtoaTgB
         ObcprQpxNEGVih/Oz+aCz3mI2UA7rt8dAnwnewjCZHHGqE0d4OhykXOPfzd8sHCw0WSv
         fWjrIojsApi/+sIWHxGnT0fkTmkBdCALsa1f0pEqjolSaFfqxKVwlwvsVQWzCIZTANGO
         TPKw==
X-Forwarded-Encrypted: i=1; AJvYcCUpobKxLEVxG5KglXohPa+6aXfGcEv1RepqOMiA8xRr7v0Chzs0viZVGzwHgdhug9VpsRzXeuheZ3h5WYNf0LRZziPIfRtu/2lkOANFlXnX2q0vYyAqpE9osQ==
X-Gm-Message-State: AOJu0YyCed83dIKAu2nSFCagTeIeiR54SEsHfkpaq6jJLAO0ExmChNw6
	BRqK7U4VqQ5R6gXcvbWr5CoYEuQbP+VK/gHMDtabfL6By8eehIF/x17j+lDySFE=
X-Google-Smtp-Source: AGHT+IHGXwED6hQvAWGBvs0kxPiSJ0tL8OBtEwFzgQm9eQ3JplhnsbF7jKSfoG/okjgvLWcpY+GZ4g==
X-Received: by 2002:a05:6820:229b:b0:5a1:c935:2eca with SMTP id ck27-20020a056820229b00b005a1c9352ecamr2575641oob.6.1709918386043;
        Fri, 08 Mar 2024 09:19:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bs18-20020a056820179200b005a12e140fa2sm490330oob.22.2024.03.08.09.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:19:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ridsm-007URd-IT;
	Fri, 08 Mar 2024 13:19:44 -0400
Date: Fri, 8 Mar 2024 13:19:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240308171944.GU9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <CABQgh9FwOVsFe3+5VG0_rDruJVW0ueHTcsnxUcVAvFqrF4Vz6Q@mail.gmail.com>
 <CABQgh9G5yFZ_p+tfvnJqOQo+Be62rMDatsEX1rhD_oTiXDaw5w@mail.gmail.com>
 <20240306160120.GN9225@ziepe.ca>
 <74d6f11a-9415-48e5-a165-7b9f5b87873d@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d6f11a-9415-48e5-a165-7b9f5b87873d@linux.intel.com>

On Thu, Mar 07, 2024 at 09:54:53AM +0800, Baolu Lu wrote:
> On 2024/3/7 0:01, Jason Gunthorpe wrote:
> > On Wed, Mar 06, 2024 at 11:15:50PM +0800, Zhangfei Gao wrote:
> > > Double checked, this does not send flags, 0 is OK,
> > > Only domain_alloc_user in iommufd_hwpt_paging_alloc requires flags.
> > > 
> > > In my debug, I need this patch, otherwise NULL pointer errors happen
> > > since SVA is not set.
> > This is some driver bug, we need to get rid of these
> > iommu_dev_enable_feature() requirements.
> 
> Yes. Especially iopf should be independent of SVA.
> 
> The problem in the arm smmu v3 driver is that enabling iopf is actually
> done in the enabling SVA path, while the enabling iopf path does nothing
> except for some checks. It doesn't matter if iopf is tied with SVA, but
> when it comes to delivering iopf to user space, we need to decouple it.

Yes. Each driver is going to need to get a to a NOP for the feature
things then we can remove them.

I did half the ARM driver in my part 2, the iopf bit still needs
doing there.

Jason
