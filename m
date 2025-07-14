Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F5B25C80E
	for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505981; cv=none; b=cVKgEeVeLDCNq4hbN6CMB+NX3GubW1i/3w9RniKvoyRlRFNi/gt5VibNJKy57lBH7phUlzv9kGFLl5mqljf+hV2kbVa5P6feP1EUVG3wPW2UOiCbKcrBZN+qfMSTLRb2luQyBmcOLhvNuCpoHWbthbdOB+fTjjj4O+tPSHsRBVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505981; c=relaxed/simple;
	bh=wq3jkDXmL2kbDR8yLPZKxT4RkHzlMSQh4F6k/stG0gE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSJ5YNfjes6JXm9KOlahRINetloqcLoUhVM0PKxA8zafSh9tj8QOhKhk5yIgVwYM6Rt6vm3UhEqMlZgPZhZ1Qcxn0O6R5c5TS/+WrtUDwzJ6Tzqte2aZPcEI92lk4wWklt0Vf3IUH4UarcmgAipJtJ5ABfMbXMYp4lhuHx+sga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKr0gCAc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKr0gCAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752505978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAuWLDvGONYS4aGI3o9+xx7hOflsVGv3mSCNJ1rkux4=;
	b=jKr0gCAchVHMtUoYhZ5rlFxSz+wGhZ/YKpbhjjGrH/98yLYF97HrVcbjV0gKbYfZut6SMm
	BjKpGgldyERoLP7z2WPTxlC0XWxUfdaEFyXxYNLgNk1gqvY+RmWEalGflEb1Z0r9tTG5+A
	U2Ugto7lvIMcMR07OwhAMfrlCCej0V8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-FP9t9vovOp-HXgaSl9PEdA-1; Mon, 14 Jul 2025 11:12:57 -0400
X-MC-Unique: FP9t9vovOp-HXgaSl9PEdA-1
X-Mimecast-MFC-AGG-ID: FP9t9vovOp-HXgaSl9PEdA_1752505976
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3df57df1eb3so5692325ab.2
        for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 08:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505976; x=1753110776;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAuWLDvGONYS4aGI3o9+xx7hOflsVGv3mSCNJ1rkux4=;
        b=hK+2tMv/SWBo2cPjyg3oaS3G4fhOMYPcCqhWuYK9ULL88Avvuf78kHkuwNWBbd6ybl
         XOLwQaD+O6lTFWdjwn0i7SOvTIPyTmaTvnzzkVKDehigD63me99mKwCA3uUlmAdmqPCG
         YpNZIEvud2sN2KypRSO2F0zo1wzS3eJBm2RsW4AfvYnZJx2ObyFKFAXWGjHTA/Cupmty
         yED7B0XyMfDMyn506UU7ogw8pDffRWIUPhqyvW1TVIWc4d/zQ9rnXPTNPHDPOUxurS+1
         TsR0CQyjC9IXZ06cDdn6xebR3aJM2C8hQAZvWP2J9/JXV38HzQuiiAMAKJJ8FVmR2jyQ
         ewVA==
X-Forwarded-Encrypted: i=1; AJvYcCVOfKNbdobRMl3nS2ALxM6CpL5gGco4C6HpubvARZJ/mSauPeL6605+GIwqJlIa0Yypem5UaKt1m8PTtJXjBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC3Y65SmzRt/3GpWd/TzhLGLp175rvFxT/cgJOf2OmdFxiVmZI
	nda329LcrwEdNGVwqsHkDm+ZrPx5yXicLaUCt6XBDoAwUgc8NqEHTGDjYSSACAbfxJiH2COBvnu
	5L+HbvKriSgGoTh5Maq8r13s/hqU/9wRwnOd4nN2MUCBuG2t+1c2+UD2nAEqrPnRX8yYd
X-Gm-Gg: ASbGncs980mOeTc3U0JEerFHrKd7RAmTL/xbrZJvWRyYgskRg2VCLr43wCDxhGie9Og
	ZkhUX/oBdH8xVKlWcyom8ja18801NIwyoPhlIA66i1wyvQRdk7ogdA9/Jwm7bwg6XVeXh3SN+HN
	L9++sLjtdtGHEgiMx3TpwAT1gPm9MouqupVH6yvHvLj0RLg7ywH0n7SKJT9uSmiAHhnBNmNlmgD
	v+xfaOVQX+9MHlgJej0Vhs+nHRRIn2mO9vTT4oNz3stYNrEx+eQO1YuOerZ3fLlaJMKSzxb3vi/
	Bv+IGEgSSFeWAJpmHQNClLpvYf8a6/EcCJMJa4KBxYs=
X-Received: by 2002:a05:6e02:3083:b0:3d4:6d6f:6e1f with SMTP id e9e14a558f8ab-3e2543f45a2mr42635005ab.6.1752505976226;
        Mon, 14 Jul 2025 08:12:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQWWnsQP46KCBBDLLmrvxRjBMZE+wrW8uiPq3ltdhzNoM6uXIgiwf7w6/nI+O/Wf1S85BaBQ==
X-Received: by 2002:a05:6e02:3083:b0:3d4:6d6f:6e1f with SMTP id e9e14a558f8ab-3e2543f45a2mr42634705ab.6.1752505975706;
        Mon, 14 Jul 2025 08:12:55 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556970df3sm2049358173.90.2025.07.14.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:12:54 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:12:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Brett
 Creeley <brett.creeley@amd.com>, Giovanni Cabiddu
 <giovanni.cabiddu@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, Longfang Liu <liulongfang@huawei.com>,
 qat-linux@intel.com, virtualization@lists.linux.dev, Xin Zeng
 <xin.zeng@intel.com>, Yishai Hadas <yishaih@nvidia.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>,
 patches@lists.linux.dev, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, Terrence Xu
 <terrence.xu@intel.com>, Yanting Jiang <yanting.jiang@intel.com>, Zhenzhong
 Duan <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v2] vfio/pci: Do vf_token checks for
 VFIO_DEVICE_BIND_IOMMUFD
Message-ID: <20250714091252.118a4638.alex.williamson@redhat.com>
In-Reply-To: <20250714142904.GA2059966@nvidia.com>
References: <0-v2-470f044801ef+a887e-vfio_token_jgg@nvidia.com>
	<a8484641-34d9-40bf-af8a-e472afdab0cc@intel.com>
	<20250714142904.GA2059966@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ipcf5ZmRzqFTUr1y0utP49XhTBNV_q0KYdQV4BXR5O4_1752505976
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 11:29:04 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jul 14, 2025 at 09:12:30PM +0800, Yi Liu wrote:
> > On 2025/7/10 23:30, Jason Gunthorpe wrote:  
> > > This was missed during the initial implementation. The VFIO PCI encodes
> > > the vf_token inside the device name when opening the device from the group
> > > FD, something like:
> > > 
> > >    "0000:04:10.0 vf_token=bd8d9d2b-5a5f-4f5a-a211-f591514ba1f3"
> > > 
> > > This is used to control access to a VF unless there is co-ordination with
> > > the owner of the PF.
> > > 
> > > Since we no longer have a device name, pass the token directly through
> > > VFIO_DEVICE_BIND_IOMMUFD using an optional field indicated by
> > > VFIO_DEVICE_BIND_TOKEN.  
> > 
> > two nits though I think the code is clear enough :)
> > 
> > s/Since we no longer have a device name/Since we no longer have a device
> > name in the device cdev path/
> > 
> > s/VFIO_DEVICE_BIND_TOKEN/VFIO_DEVICE_BIND_FLAG_TOKEN/  
> 
> Alex, can you fix this when applying the v3 version?

Hmm, where's this v3 version?  Did you already send a version with
Shameer's fix (s/bind.argsz/user_size)?  Lore can't find it.  Thanks,

Alex

