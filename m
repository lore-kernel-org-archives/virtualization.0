Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586A159211
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 23:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706486; cv=none; b=ANS5B0879xwnpDdAM9kx8o9kIYF2y04VvQuAonlOyDyn2gyRKmz2Skxi1jOvUv30evzL98Apummz6uOYeIWUShMHn1qJUvJBMWmpRTxx8TRzHCRTt1S4uzAcPUJm8T8Nm+AA4WOUEcYx1S4Q/A6sE0vei+m8aEPhORP9T+4ZLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706486; c=relaxed/simple;
	bh=08qq5HCWlZ+kc23Un20MVp8h4gAK+quDdzQ4miFER2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPvaV5xA8gp+YGUU9iaf9YkDY3LXyoGRDyIyuRC5ZF4/KeJ+ms2IT/k6oujgEn7D9WQQSPG8HLEiu3f6S5qAfDBD9uF14tn/5fQvAftbfLSe+fqtU+WcBWtILHeeyQYhD1lwHtv4VS7IGUdPkFYYfOa5Nx7YuSsVU/pj4HjTX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Vs4bOr4J; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Vs4bOr4J"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12A5081A5F
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 23:48:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sdSlrAP2Dgjd for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Apr 2024 23:48:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::730; helo=mail-qk1-x730.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6D87C81A3B
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D87C81A3B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Vs4bOr4J
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6D87C81A3B
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 23:48:03 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-78d735b0756so84049385a.1
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Apr 2024 16:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712706482; x=1713311282; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VhYxjqqqLEZ4NmXo+SZfv1SY139w6T7h5FSNcRUkNNQ=;
        b=Vs4bOr4JcUiV99TDD0vHOSeGgCdzPwNZGU5EULtay/LT1kTfqT/02SIdIY5wlS8gi/
         7gHG4Cza8w7OjTOEOr0ELrUb7RxoH9PyjdtAe9yIINEtIdZW0VYyj2AndkE/ui7jLfnV
         lnuVtfE/u3tYz4C9vfaVD5L9gt5ES0DEjqyo69tEx1E8QDKaqXQkkDPrDl5w3/oJKvCU
         y7vQDT1d8QZzp0XuDChCtu5kfqLVOHJ7b4gdU2y+0rFzphpA+x3YtKi1oE7pei3u4BaX
         Q8fBfl3IryaCne8AtOx+qZQ8DDmTmDoPKksK6eg/G2OCqmnofpSJz57l13vOJFFWKw2T
         NIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712706482; x=1713311282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhYxjqqqLEZ4NmXo+SZfv1SY139w6T7h5FSNcRUkNNQ=;
        b=fvdKQioHQo7wEJl4uVDEWRzSXJxDBYhEi4xrxkMjZHwL4t6nYcULUkUl7O4aijfxX6
         0gmRhW8Zf/zRk+/Sh+GNf2E1to8GQwHZbGTfsuOf4cUIjgtLI04n6ttz4S1gb2eBzaMJ
         Uki64w4sYOkQpdrpz1EMss216v5FDgIL8tACdXOnC1AU7lppTn+DCdo3YtU2WSqwbbKo
         sQOQMg4BKcLTbDQzLCMZzS23aw6jO3olKb+w+2CECDTyFIP16EWUXLa2yTM2YkwPitF7
         yr3/pGcNOlsJ8wNn3JPhnZ89du5gQ9ZcdA1SrCP/IbFPXscgXwHw2PwP8OAKRAz+LW79
         bYug==
X-Forwarded-Encrypted: i=1; AJvYcCXeCcx/ARcW2gE8gtdF82mc5RY80iwwzH76L8Z2zOtKiPrxt+kBbfl035vOkEX2MHPo71OUjB824guOnx592rye+8BhEKU7E9uFMSwA2tKwNqqVpLN3+Jjsbw==
X-Gm-Message-State: AOJu0Yyrp/hfv411EdBG4blutff/NKNzY3YZGXzOgXCL3gOZJLqyJVZi
	0PU+38ER9zU6K/NqMMQ3yxCqGVF2rAqBXMXt9eDNabWf6lEAOy+rJ4Csr2L4Nks=
X-Google-Smtp-Source: AGHT+IF1pNgXaBW/Yn6UlU21y660oCrae0FfmY/a+9BPxXzGL3pwhOQklD3p33dxkbP8tOGj4Kgh6A==
X-Received: by 2002:a05:620a:370b:b0:78d:37bf:74cf with SMTP id de11-20020a05620a370b00b0078d37bf74cfmr6318076qkb.5.1712706481980;
        Tue, 09 Apr 2024 16:48:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id j26-20020ac84c9a000000b00434f880039asm428978qtv.70.2024.04.09.16.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 16:48:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruLC4-007GFW-Ju;
	Tue, 09 Apr 2024 20:48:00 -0300
Date: Tue, 9 Apr 2024 20:48:00 -0300
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
Message-ID: <20240409234800.GD223006@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
 <20240408141946.GB223006@ziepe.ca>
 <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>

On Tue, Apr 09, 2024 at 10:11:28AM +0800, Baolu Lu wrote:
> On 4/8/24 10:19 PM, Jason Gunthorpe wrote:
> > On Sat, Apr 06, 2024 at 02:09:34PM +0800, Baolu Lu wrote:
> > > On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
> > > > On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
> > > > > +	/* A bond already exists, just take a reference`. */
> > > > > +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
> > > > > +	if (handle) {
> > > > > +		mutex_unlock(&iommu_sva_lock);
> > > > > +		return handle;
> > > > >    	}
> > > > At least in this context this is not enough we need to ensure that the
> > > > domain on the PASID is actually an SVA domain and it was installed by
> > > > this mechanism, not an iommufd domain for instance.
> > > > 
> > > > ie you probably need a type field in the iommu_attach_handle to tell
> > > > what the priv is.
> > > > 
> > > > Otherwise this seems like a great idea!
> > > Yes, you are right. For the SVA case, I will add the following changes.
> > > The IOMMUFD path will also need such enhancement. I will update it in
> > > the next version.
> > The only use for this is the PRI callbacks right? Maybe instead of
> > adding a handle type let's just check domain->iopf_handler  ?
> > 
> > Ie SVA will pass &ommu_sva_iopf_handler as its "type"
> 
> Sorry that I don't fully understand the proposal here.

I was talking specifically about the type field you suggested adding
to the handle struct.

Instead of adding a type field check the domain->iopf_handler to
determine the domain and thus handle type.

> The problem is that the context code (SVA, IOMMUFD, etc.) needs to make
> sure that the attach handle is really what it has installed during
> domain attachment. The context code needs some mechanism to include some
> kind of "owner cookie" in the attach handle, so that it could check
> against it later for valid use.

Right, you have a derived struct for each user and you need a way to
check if casting from the general handle struct to the derived struct
is OK.

I'm suggesting using domain->iopf_handle as the type key.

Jason
