Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EDA13E7F6
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Mar 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740885; cv=none; b=qc6fN7sklvSFR4q5bNsel8vviES/+1ubst1U5vFgd1RIMwAkoTBfxoM7eIuNoTo0y63eMy+DgJb5/mVL1Q5WyezAFKWacrZQ6kifIX6yyISa4Mdq73njq6iJDkjLETLc579CIk1MPNoOwZQS3tJU2MTDQb6uKcqn/i9YPCQLxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740885; c=relaxed/simple;
	bh=v/bXOSBKu2eGpHEzaYDbJicIc8rMxQdp3cklgPly4s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+Xwo2yC3LUPrFLMi8J+ghpVG3QmgdSTniFCunCg8GWz6NJVjkEL6C74qHuIa51i5O/spwWBLKsYGRQUIR/aaFqFsXMNg2LHUc+IfhONBU3mLTpxLGBaQgG/mHm9q5a8XUatNM+W+GbWCrpyLhVu0NBirMP066ITSP0defshVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HYoNys+q; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HYoNys+q"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EC07606EC
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Mar 2024 16:01:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id elFPAK41vwpg
	for <virtualization@lists.linux-foundation.org>;
	Wed,  6 Mar 2024 16:01:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 33720606E5
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33720606E5
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HYoNys+q
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33720606E5
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Mar 2024 16:01:22 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-78830bba6a4so57602985a.0
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Mar 2024 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709740882; x=1710345682; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSA2YBah1Lj30DTvNjciwv55fQTPNlhcFkEFTOf2JJk=;
        b=HYoNys+qA6QotygHDvVssMG9wGdxpVklOqw+XDNxEoX+oZwgPkojOYxXBHkvFWRZQX
         2qaxCcf/NmFqtn61Kax7SSnTxrLj1JbOpoNoSMP/za/wmHgIWa3g66rdydldI8XcZEz/
         TtqUQR984QOr6eyOsZfVrWuNOM5NAoyLt1ePOmHQ6q2X1UsyDr0gLUEAxE55eYw8DgKR
         BsR7b00PXFGquhh9Te7JzPFHdsY6podU//NiVsZfIVlhAuUO47oJfPPV9ldsohakfWSL
         WKd1SL149Mfr8WZ433q6E/Np6NToieCLa7nEhFP0fnUEYw5IrAOdLMkiHA7bclJwNon7
         0XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740882; x=1710345682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSA2YBah1Lj30DTvNjciwv55fQTPNlhcFkEFTOf2JJk=;
        b=IlxKZV7RPTHV38n04YQBg3zO7TBX4jmHnmp1RHwFNkIBMMBUykLmYydgmm/0QkiNRm
         B3NcBUvXhY5HKcDcg2FwunbLDGArNyWcEevBNm7VyS0tLoVSvT5UehCi4m6LchzR9nYI
         gLoKLb+72JLaiLSAKFrfsdU2keo+QClCTziPeIG/5rfjSOLhEVGCqUQq9VFM81tRdNTk
         4nOrn4TF3b8SPflW5Sxozcic+a3jjDdJSQlhdSCxCm1/kMFR/DO0POsQNVyLIPCBuHk0
         CdRcy8/WauLL3Jt2pina9kgeTHHAXYR0m6tSzLTg0N9TrtvEWkfasxFvvofNmYdXkjpn
         iSJw==
X-Forwarded-Encrypted: i=1; AJvYcCWr61QHsc0ugaWnrQkNEva4XJW0rPCF/Wk+8lJmbRn+d8vQ9buAKsiIKcCWzH1EVITuOs05rciDx21+qlo9Yrlsid8qmhbklD/5QhlNuF9kr27VVG1KVcGAuA==
X-Gm-Message-State: AOJu0YzOd94c6vG44ChPFk2ZLKnhpJnhn0xKHhnnMbPSJwlOzECDwWf/
	vuP0EEdswYWHp55WsBd2FMCQMSklvcqNerD0iLTuMnxW7xhfvwzvtqSYVis3K00=
X-Google-Smtp-Source: AGHT+IHonZr06DjH8Yk84J1MO3pfMp1YqC5mCzQ7TjuwpRdCgfCoxMkD1Wnxg7YpHS7pifKwQl02jQ==
X-Received: by 2002:a05:620a:1a9f:b0:788:3766:b145 with SMTP id bl31-20020a05620a1a9f00b007883766b145mr6022406qkb.38.1709740881754;
        Wed, 06 Mar 2024 08:01:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a29c800b007881ff8cebasm4246571qkp.92.2024.03.06.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 08:01:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhtho-001egy-PW;
	Wed, 06 Mar 2024 12:01:20 -0400
Date: Wed, 6 Mar 2024 12:01:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240306160120.GN9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <CABQgh9FwOVsFe3+5VG0_rDruJVW0ueHTcsnxUcVAvFqrF4Vz6Q@mail.gmail.com>
 <CABQgh9G5yFZ_p+tfvnJqOQo+Be62rMDatsEX1rhD_oTiXDaw5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9G5yFZ_p+tfvnJqOQo+Be62rMDatsEX1rhD_oTiXDaw5w@mail.gmail.com>

On Wed, Mar 06, 2024 at 11:15:50PM +0800, Zhangfei Gao wrote:
> 
> Double checked, this does not send flags, 0 is OK,
> Only domain_alloc_user in iommufd_hwpt_paging_alloc requires flags.
> 
> In my debug, I need this patch, otherwise NULL pointer errors happen
> since SVA is not set.

This is some driver bug, we need to get rid of these
iommu_dev_enable_feature() requirements.

Attaching domains with properties should be entirely sufficient.

Jason
