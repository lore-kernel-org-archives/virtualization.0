Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95C1DF742
	for <virtualization@lists.linux.dev>; Wed, 19 Feb 2025 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966224; cv=none; b=KSeBfrVVngvuS11GwyiL+lvT5j5uIX3/rhlciWlUKP/N399Yg6mIqMZZYUsRvGaEJa0KH0CeIywIQ1VU9jUgZRioTJRblX+k8NbUhf43uwTP1FNn3wI0UcY9GbYU6ZwbnwKnMPFoaWVKB/xthQyDQhchAWPlMCNbNRsvXWVexUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966224; c=relaxed/simple;
	bh=6RY7FVDmjzHQ80JIOPX5CPjs33fql1if6bYOaBzH3d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1YpDbqMtvYiaPuT3kYxYRQ3/T3Rg32jew26p9rekwh2nSV8sFnI+IFvoR7zevsUuE36bNStsfEq691iwOGi5y8dk6GYpTrhRi1OyDreQvK7n3ZRwTxrMX6sAiIgg+sf7IJiYD9fZpQ233bFoiiW6aGTrr8gB3QZHGmyEMXFHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xgm36uwd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xgm36uwd"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso30221205e9.2
        for <virtualization@lists.linux.dev>; Wed, 19 Feb 2025 03:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739966221; x=1740571021; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=okn6O09si7kBE/1dHlS71dUjErVE7LOWp8T65eAQeJw=;
        b=Xgm36uwd7v2jZTnU75gAClvZKmN/nODOiQQ/igenn2mQ6j2bIw3vyWryR8r6x3WQlt
         2YKSVzdnVsKvJsJDLctimnUdnCVWa2sPIkxD/eflOo66AUEPVoX/PehoU15enIZZv8dP
         7Sqt/bskrnG7Tj4irxn7C62AzzT6/0OMfE82PUA9xWG1fd1zU3qIyD52oyLQzokKrMsp
         PvHRGFi/goOkZghTwJanF5DMHSA76o0GpXdUgma0abLllqkbQkKQESS9dkOzswxLtLpJ
         9ZnT88OA3MOKAWlPHqnGutpkGLPCKXRZuUlz+GLy3T7/JmO6Y7iH//qx6Shd/PW8THGB
         CswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739966221; x=1740571021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okn6O09si7kBE/1dHlS71dUjErVE7LOWp8T65eAQeJw=;
        b=E0eL+7/6HN1gQyRyX9oUjdC9QmHa8PrH0k2dqAkz6tfClSC0okiEGis7s5yQd8+WcE
         PE9Ic38j2i6ERaBditBGyfF3ok0puJrVuNrx40OSyNyy7sAmLOEEKPcg6vHCuKxCaFH/
         H+JUw69Aq9RrGDtJXGOMeAOxnN+t1FMbxkVX9s/cJ74MEz/Xd2R2SDD1aPbcVUcGWfVl
         1S71ZsVfblh/lKCTgDogFiScKlL+xHOGDCefjF9jYG9vmWvksTSFUBM6Fd9Bh8/IdcDO
         rSnJDTxmfo6VSZu2Mn6B8Woa1F1m2SQNRnSCsGXtsDADLf93Jvz9VpJFNlPreZGoTBWZ
         7yfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWplgMPM6OPU34EaN97ONG1PmSMXaiOgpPb56z7Dr7DmqoHPQPeRVWAcTGodDWBSvF73OWl7WibirO4Q3aJ8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGsrkErT3u0OUtY/lwiE+0l70oo7R07umvhUrJRaGO/t3SZWT4
	yxNIOBlMn5jtEzrc8U2o7EDUy0QtVftcKVFylgu0KobrzSdO+SBLYIJIabW9l4Y=
X-Gm-Gg: ASbGncsIHUW7OlSNT1xkoGhQ6onu+vPIEoacHkSqwbvS9ijRCggjhPm3ypjdt2hAm9U
	F2Zu55o6nvLLC+p5+1E1oD6kDW2VCae9W7XHwPzYvaleOwHbmSUQCrGj/zEJaCetmiAn9F3ljSX
	XT5HBQkljws8VQ65L7X8cqA9PqJtlRncGyM6x5bwdG6/uvhmvIuekxSDhOk5ZxLM547iMWxTx19
	gRQ385uEGyd49dcQgY6EC/mFh6lIUvBVUwNBYBbMxsEu6PDTpn3MgPngWOls+JPcdjWYyQkz7VH
	IBhdq3BXlR/yVg==
X-Google-Smtp-Source: AGHT+IHSWNh//eVPg2Iw3nDUVl0/mWY9Z+uXIwGFBr+HZ53WHNcQN3v6J5LnzFUh/oHgFMghQ7chOw==
X-Received: by 2002:a05:600c:19c7:b0:439:9b80:ca6f with SMTP id 5b1f17b1804b1-4399b80ccd1mr24399735e9.5.1739966220791;
        Wed, 19 Feb 2025 03:57:00 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43984924201sm88322405e9.6.2025.02.19.03.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:57:00 -0800 (PST)
Date: Wed, 19 Feb 2025 11:57:25 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	"zhangyu1@microsoft.com" <zhangyu1@microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, patches@lists.linux.dev
Subject: Re: [PATCH 3/5] iommu/virtio: Move to domain_alloc_paging()
Message-ID: <20250219115725.GB513544@myrica>
References: <3-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com>
 <20250212112235.714b0a14@DESKTOP-0403QTC.>
 <20250212233053.GV3754072@nvidia.com>
 <67ad876d.170a0220.3c21dc.85ceSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250213094601.GA243081@myrica>
 <5irmuy6xwrjsrdjy7tmfzlnotxqdoqagjdsdtqjrrit673zaka@r43nyvc5gcyf>
 <20250213180919.GC243081@myrica>
 <cu7lznx5bxnqoavt3ri4dtzwt7lu3loitn7a344rbnmahpnc6h@2e2dknchxjmd>
 <20250219103518.GA513544@myrica>
 <jdyb4bxo5miiybkjbmnkszlcx5vwik7lqa5kgx4ptsage6tlu7@axsub4six2uu>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jdyb4bxo5miiybkjbmnkszlcx5vwik7lqa5kgx4ptsage6tlu7@axsub4six2uu>

On Wed, Feb 19, 2025 at 07:11:43PM +0800, Yu Zhang wrote:
> On Wed, Feb 19, 2025 at 10:35:18AM +0000, Jean-Philippe Brucker wrote:
> > On Wed, Feb 19, 2025 at 05:39:19PM +0800, Yu Zhang wrote:
> > > On Thu, Feb 13, 2025 at 06:09:19PM +0000, Jean-Philippe Brucker wrote:
> > > > On Fri, Feb 14, 2025 at 01:03:43AM +0800, Yu Zhang wrote:
> > > > > On Thu, Feb 13, 2025 at 09:46:01AM +0000, Jean-Philippe Brucker wrote:
> > > > > > Hi Jacob,
> > > > > > 
> > > > > > On Wed, Feb 12, 2025 at 09:47:23PM -0800, Jacob Pan wrote:
> > > > > > > Our code and backend support are still in the early stages, that is why
> > > > > > > I am attempting to convert virtio-iommu driver to iommu_pt. Not sure if
> > > > > > > anyone has done the QEMU part to support VIRTIO_IOMMU_F_ATTACH_TABLE?
> > > > > > > @Jean @Eric Do you know?
> > > > > > 
> > > > > > As far as I know Tina worked on this most recently:
> > > > > > https://github.com/TinaZhangZW/qemu/commits/virtio-iommu/vt-d-pgtable/
> > > > > > https://lore.kernel.org/all/20231106071226.9656-1-tina.zhang@intel.com/
> > > > > 
> > > > > Thanks a lot for this information, Jean.
> > > > > IIUC, these patches were trying to add VT-d IO page table support in
> > > > > virtio-iommu, but it is not based on Jason's generic PT [1]. Just wondering,
> > > > > does anyone have plan to do the incorporation? 
> > > > 
> > > > I'm not aware of anyone working on this at the moment. Something you will
> > > > need for a portable pviommu is a library that manages PASID tables rather
> > > > than page tables [1], because the Arm SMMUv3 arch only support assigning
> > > > PASID tables to the guest. Alternatively you could implement opaque PASID
> > > > table allocation via host calls, letting the guest allocate GPA space and
> > > > the host manage the PASID table, but that idea didn't seem very popular at
> > > > the time.
> > > 
> > > Thank you, Jean. Just had a study of the spec. For ARM SMMUv3, letting
> > > the guest manage the PASID table, and then assigning it directly to the
> > > backend in ATTACH_TABLE request looks quite resonable. But for VT-d,
> > > my understanding is the PASID table shall be managed by host. By "that
> > > idea didn't seem very popular", do you mean that people also want the 
> > > ATTCH_TABLE request for VT-d also assign the PASID table(an virtual one
> > > managed by the guest). If yes, why? 
> > 
> > No, the proposal for managing the PASID table in the host was done before
> > the VT-d architecture added Scalable mode, so at the time they also had to
> > assign whole PASID tables to the guest and weren't keen on managing it in
> > the host. I believe in revision 3 (2018) the architecture added support
> > for Scalable mode and the ability to manage PASID tables in the host.
> > 
> > Nowadays it wouldn't make sense for a pvIOMMU to manage the VT-d PASID
> > tables in the guest, because as I understand it there is no demand for
> > supporting the legacy mode address translation of VT-d.
> 
> Thanks, Jean. Yeah, my understanding is that old revisions of VT-d looks
> more like the ARM SMMUv3. But with scalable mode introduced, there's no
> need for a pvIOMMU to allocate a guest version PASID table on VT-d.
> 
> So my question becomes: why do we need a library that manages PASID
> tables in the guest? To also support AMD IOMMU besides ARM SMMUv3(
> I saw your spec proposed both ATTACH_TABLE request for AMD GCR3 table
> and ATTACH_TABLE request for AMD page table, but don't know which one
> is more preferred in practice)?

I don't know either, but given that the parts about AMD and RISC-V in the
proposal haven't received feedback they will definitely change, and it's a
question for AMD and RISC-V people.

Thanks,
Jean
