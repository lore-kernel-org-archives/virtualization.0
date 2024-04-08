Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82D12A169
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585992; cv=none; b=rq2A2tysufPrn/2tpcK3EUBRGN1OoFCWMxPMI038EkLlE/dj8O1eKEjlaAhvTgDtTmvoqT2BCL+cz9L/sMG3dX8RNIhmVClQpBTOyiRx1NVFkX3PByH7J9VsSByLKNrhStO0aXS0C9sfyN8kNOLgkr1Bn5Qy+aKeqabvaFlRghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585992; c=relaxed/simple;
	bh=aOckf8npwbeO73onf1zvZsoS3mECBJj89vWb1uXTPPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1wYC/HyMO7clK6eq6JPX8nFEstTEzT/Tf/0rtS1Mkoiptgcfuv3qupVNIaMVXYzqBEesm2Qs7FDp1H7PyYAxy97JWx7iu26PKZ+/L4vRCKibO5qb4xLPzVbP7B4ziu1YdXyQ9ScPbDKwbDdGp2Muvy5C3NAq8rQNS3W2tBvXK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OWnBnjue; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OWnBnjue"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C95B8134E
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 14:19:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KI65Y9DRY3Tx for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 14:19:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DB6C381346
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB6C381346
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=OWnBnjue
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DB6C381346
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 14:19:49 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-690bd329df2so21673296d6.2
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712585988; x=1713190788; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/gkgj06mHoGEBTKOjzdrcRyFw1djs3fy2Wv1GZpCOs=;
        b=OWnBnjueQzyiFthT0CUQHgSHOkl1YWb3yoMWtQ8kHgzgYwl2lTtZq2X0051eleqC7P
         zqq9dZE/Ss2+nPie3oMTerRUCgrbVi1ZBmAXimn/HrzF5EkRmApF/XHauyAyrbpnG7sD
         UrP0dmlh4cJKLqHqDCxUBlXukayMbvhOzOP+C4JjxS3btFCodf/oNDq9sWELhl1ZL98A
         GryMHoWMm8NDuNguBRsek6F7A5uK+FR/Rtm1N9r3yhdK1nYpj9YwSmyN1ze7tfqBygNn
         UsJO5I0ChZZVHrs1LDA4ibVpzfFZGOPRD9hFgWAZyKUM6Ec4p+iJsYokhB20f3wciYmD
         vF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585988; x=1713190788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/gkgj06mHoGEBTKOjzdrcRyFw1djs3fy2Wv1GZpCOs=;
        b=M7HqKWki7lutBv+QycNrkMn+cqnNPlJYHPX0EHM5B/1DDru0LLk++SO3VF30mOvWbZ
         AKJep+LAsWwlJI/LNnGm3ConIbe0Z95A5HQqzJp7qZnLNBfGNPn60kJtdTVes5unztpO
         SpXjRIEll5ORwnjhdqye8y9+HbUfRN+f8DDuAuPJr7+Mvv65G9SGdsxgQ9RSm3v8FktD
         77Ge3CnbRP3STM9UkFMEdn5N6wxDPe4DEfGuk8pnTQreddvqj5i3m9YeS9dgcFfObqvS
         SxPydLMpSXHpXqwK8EhDrTmGrq1zgd07Ix0zC+D3O0n8ICJWJZqqZ5D5loVxS0WbcGJp
         Q7yA==
X-Forwarded-Encrypted: i=1; AJvYcCVB//azP0MmjM894oyW2vtOc/RORzncdqDyzL4wIUTaOYpUbxTAsm9jadks7YfsTd/eCM+hNv2r6KYOAsPHKgvw6rZ2N14Ntj/KCFRnhI2AVS8F4fL2elnZeA==
X-Gm-Message-State: AOJu0YwgpYp+X71toLdGtyqKWU4IcsCJDFvGkz3sIQciJTmGCOOFlvJe
	qRxB+nvMEVj0Y+/LVwQcDeMlBvS8WWYKEBUL8xcHYFGSvzFCisEdrNDB63526Fk=
X-Google-Smtp-Source: AGHT+IE8Gxhq268X4xisT4dmVwJbupLs0jwAwPMQeWGGRMXB87HiENKFwyhJYlQDe1J23nu23fbpaw==
X-Received: by 2002:ad4:5763:0:b0:696:9df4:58e5 with SMTP id r3-20020ad45763000000b006969df458e5mr10787694qvx.1.1712585988440;
        Mon, 08 Apr 2024 07:19:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p4-20020a0cf684000000b0069b215adb5csm410376qvn.25.2024.04.08.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:19:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rtpqc-005GwN-7j;
	Mon, 08 Apr 2024 11:19:46 -0300
Date: Mon, 8 Apr 2024 11:19:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240408141946.GB223006@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>

On Sat, Apr 06, 2024 at 02:09:34PM +0800, Baolu Lu wrote:
> On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
> > On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
> > > +	/* A bond already exists, just take a reference`. */
> > > +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
> > > +	if (handle) {
> > > +		mutex_unlock(&iommu_sva_lock);
> > > +		return handle;
> > >   	}
> > At least in this context this is not enough we need to ensure that the
> > domain on the PASID is actually an SVA domain and it was installed by
> > this mechanism, not an iommufd domain for instance.
> > 
> > ie you probably need a type field in the iommu_attach_handle to tell
> > what the priv is.
> > 
> > Otherwise this seems like a great idea!
> 
> Yes, you are right. For the SVA case, I will add the following changes.
> The IOMMUFD path will also need such enhancement. I will update it in
> the next version.

The only use for this is the PRI callbacks right? Maybe instead of
adding a handle type let's just check domain->iopf_handler  ?

Ie SVA will pass &ommu_sva_iopf_handler as its "type"

Jason
