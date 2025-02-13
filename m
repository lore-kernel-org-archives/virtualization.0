Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34821E2847
	for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439940; cv=none; b=JwDiVVyOJJ66V0W5wrD6SZ3Dw0KsyBHbtNegmjYNfqSfIQoNbHeGye/PWSr3mrsbPolRVvhBsi3F9ipRuocehbuRXqMaqjeXD3o2VDG43XcXdpr1aLOlKf1T5SL4N8GD6w8ZCI/Ob3kxxEJoV1f7xCWaIiGGEMa7FqdO0L2GeSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439940; c=relaxed/simple;
	bh=3Ilo/X3a30c4xDyqJmeIBjYKRtFgQM1sP1z2Knqi7Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoJcKV2ps/EE3i/sEkcrFPfu4cqBjpQDYW35gdFd2URXcbgYStllNGCe98qqdmvWOEff/IKxB3m8JIAJAQAiOr0+rZLixsfScH1b7aL2OX1piJFJBPVkIIU9l8I3v0f/MhZULChcO1nM+JAYv1LY8WCGfRbJRLXAlt6O+aI4Evs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pFGrvy+j; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFGrvy+j"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dc73cc5acso362564f8f.0
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 01:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739439937; x=1740044737; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ilo/X3a30c4xDyqJmeIBjYKRtFgQM1sP1z2Knqi7Q0=;
        b=pFGrvy+jTedsek6US8JEqYdSvMtIjn67hBUk9mQP0R2T1lWyez5MsNnaKlTimzQqw6
         F+HcOn9miOYPkbSHvEKUHnPeZSLOVxZqWh0zYagfZKN15E+T4OJMLBEgMAq6Djx+BpbW
         t32AnBdipXTxDysbH11gx5Q9E1q9mTX8eBs3xjd/BxNWacjuAQTrjig42aESX/pQBmvQ
         FWXxTGNOuRbEnYtwMDQQ4qd6YJ7mpI+xfjes05MICDCyNswGb8U1oeFUOxejOAMrBM83
         8DjEZsyxNMmpJIS+jG1em78dfaAf7hoWL4gDwtBH4n+vXHy6uIDfE/6GeyBOU6IgVxju
         qUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739439937; x=1740044737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ilo/X3a30c4xDyqJmeIBjYKRtFgQM1sP1z2Knqi7Q0=;
        b=r5QnR1ibXq/uc6tds4dzK0EgLT+n0GUE9mhNaIRPjpT1iGxXF7X5eGL768jhtvzR2B
         s2O+5vHbF1+VTx2LDZSbEM+L90nEe31GSzPUm7cQ7S0hhjTW3LbG3AryOcZP+2GE7mcm
         bHYRr0gQWCMhinnPvV9aTyElosT/fL4YuqZmgDRWEaoST5o8dz6EEUa2gYYrhiFKVNyc
         Z7M4cLB6KikUUsbe5oGXnvoefEVdWuVmWHmUXo0zv70q1uzjdDvrpwJVmTvGCbPh7eUE
         gziylN0Iqn5c7D17tkVas8yT9/CVpFhspSy8FPrDNl9GqBZnssbRhdUKPNfJygNqZFop
         Mfaw==
X-Forwarded-Encrypted: i=1; AJvYcCWBX+i5Shi0LXNmt+vW5vs8vhe/g8Yqlwx2IVo1l6RzI1+s4s8VECRKg1Vzau0YHZWJ5WvAlZ1W+VDHzHlgIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzU5WxD4i0payWKIynxj6go97T686WFEw7IQAK+dALDjiON8knC
	eVi79ZUQNEUecZyd7khEyuT5gKG8AUByXW4C/aItAtqrilfyzh4yaVQVqlzraVw=
X-Gm-Gg: ASbGncs0GssaBb2rBC0qRrjUawvLqmXagXsVUSW7yUHTPvN1dScMrsVuOrwQXjMqHnr
	2+La2v8Yx8oZf9hHEBJuXgqjPKJH/WLHNMx4f6e2/KdQAr/3bzX1udCQo4EHeQcEzKxRRemuIzK
	iyYYS4hERfshGsLac4JU1OEdBMJyqtLxhU9ov/3yWuITnHVaO4Ujo+rbPmsI2OPQ35QlK7HWlnZ
	LQ0P/sGkFLEFidqoWw2lthGxz1WGy8HlGxMpcMMAZcLan19VAMu/2Bbt/PU8WriDCygRF5VOl6L
	4q2s5OGrmAk29g==
X-Google-Smtp-Source: AGHT+IEIeCgAGFBXoUwvmjdG4kaT43lYwV+Fkp3fDkVeP6qXvOFBGNPRA7BU0T2qf6XHumXXrDCSDQ==
X-Received: by 2002:a5d:47ca:0:b0:38d:cc9c:630c with SMTP id ffacd0b85a97d-38f24f2c099mr1998761f8f.10.1739439936845;
        Thu, 13 Feb 2025 01:45:36 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b41b5sm1396930f8f.14.2025.02.13.01.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:45:36 -0800 (PST)
Date: Thu, 13 Feb 2025 09:46:01 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	"zhangyu1@microsoft.com" <zhangyu1@microsoft.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, patches@lists.linux.dev,
	tina.zhang@intel.com
Subject: Re: [PATCH 3/5] iommu/virtio: Move to domain_alloc_paging()
Message-ID: <20250213094601.GA243081@myrica>
References: <0-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com>
 <3-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com>
 <20250212112235.714b0a14@DESKTOP-0403QTC.>
 <20250212233053.GV3754072@nvidia.com>
 <67ad876d.170a0220.3c21dc.85ceSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ad876d.170a0220.3c21dc.85ceSMTPIN_ADDED_BROKEN@mx.google.com>

Hi Jacob,

On Wed, Feb 12, 2025 at 09:47:23PM -0800, Jacob Pan wrote:
> Our code and backend support are still in the early stages, that is why
> I am attempting to convert virtio-iommu driver to iommu_pt. Not sure if
> anyone has done the QEMU part to support VIRTIO_IOMMU_F_ATTACH_TABLE?
> @Jean @Eric Do you know?

As far as I know Tina worked on this most recently:
https://github.com/TinaZhangZW/qemu/commits/virtio-iommu/vt-d-pgtable/
https://lore.kernel.org/all/20231106071226.9656-1-tina.zhang@intel.com/

Thanks,
Jean
