Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAB42BE043
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697330; cv=none; b=JqKnTO4rrRYcSF5OFIFDphRKJW3LnK/ArRWRC/BknD4Pf3seL3H2C3G5TcUn8KtbOrpqsLXzxSqPEeYJORUmRH86SOwy9NoEsVtVFXbHXIvHgMer7N0h+NgSsONkwAWiGC4+bt12nUAQy4nMsDO70vo1j9q9vcSKNJY86LJDhQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697330; c=relaxed/simple;
	bh=AF9kFzEx7JejyTGZ8cnFBshOG6vP/fcO1Ng7rP/PM4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdLeEOqW6E/lqNtaZ6rv7gGaUEZxhi+jGxW/y8Wok6hy8MY9mnJ2ATNp7DRSFIl3dSE5MFMaLVIMiwMVhqrNjs5OFjTIOFr/B6Iq6wgmEUNdIJm9S6NaSMcY6UYzkGI2YSfytBc2Wsqw+U1h4+8iiD0dspcCgKXCOGcLI2wgcbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I97mKK7A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I97mKK7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752697327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYUlY8l27h/7HElLqMB3FsB5tNtQEv7BQSPs3aGZGIM=;
	b=I97mKK7A89LHUhHbbIY6eE9d93bLn/Sk1L5G/J+V6M1PYkTavTv0RqICkogAMfidIN7yEc
	ICaW5xJJtxWXJ7inBx6UvjiK7N/6zCRvWVRMJpFvg2jUHBndUuhLkjbA2iVJEOMSWEyVBR
	Ek3ponoImZzZCJdWMjZlO6hIee5KK/M=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-VCdUi-FbNYW18U6MN9nQkQ-1; Wed, 16 Jul 2025 16:22:06 -0400
X-MC-Unique: VCdUi-FbNYW18U6MN9nQkQ-1
X-Mimecast-MFC-AGG-ID: VCdUi-FbNYW18U6MN9nQkQ_1752697326
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8796b8132d8so3892339f.1
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 13:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752697325; x=1753302125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYUlY8l27h/7HElLqMB3FsB5tNtQEv7BQSPs3aGZGIM=;
        b=tKYq986Wh/pBXUV2i1CUvBZiJbYXbXxjFlDbCJY8R0TLCtb/HubhbZBngqtpTx/fBp
         4M0NK0L7qsX4dHGXIvkuOGYgjxsyrEMOXnzH0pXhaxZ8xEfj9vUYUYELNHozUY5K7tnC
         bUIQoJVvj6rDwn1dH1gdRZcZ1J93f2FEAgqvGgZK0wn93pR9QCHqacn+gwnKtwe98J0Y
         GUCr5LNlamgOHr7Jp18WmTFHny2Itbqu04UzuSOo6jP+fxKWGQMDpk4onEWE/ASb/0Hy
         Ciy9jbrFjT9VQr/Ldwh8lkvu517TYVCy1KC2/Xjf3dRRVYtPgNLa2WLAFNNxFraluxM4
         fu1g==
X-Forwarded-Encrypted: i=1; AJvYcCVjbQzuIoxR9SuclHcTnbBvSNMSu6HxQB9h+mcNXVO+t+t4qh7aqNsgrnPchaJ9IVj65/DVVRekewUIo0QThg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXAnHawTHMxqX91sb4a2ZY6ykbGJMhDtADVLsCUDyq93bv7f7p
	YBo02JUUPGkwbsCOScTtxPpF0lvnm5bqVtW8d27W/cjFqbfwYM4/2yeOmAwpmfWoOAthNJsCPE4
	ak5tQzD6ar9+3NjHaWzUjPbLz6tMFY7Vc4X91Ev2WK3RI44D0FK7iAq6+3wPKQGuU/pGR
X-Gm-Gg: ASbGncs775nrOxX9TOJs2CgFRonkT0PrPWRDNKBP/9izTNn/YqaOk3kyKUvKErmxA+/
	+jV5cRmfj3krfmWH21BJFHWR+pdNjbtq69FBrBGLpiTgG/wQL2Jpmz8TkZRaCZlTDYCAd5XCkv9
	3sGHSMQqcoxFE06uMKjNa46oHRZy9sIuqNuvtbG3FUvuScksEB2cODUrfiBIuhekeAOOiag4kd7
	PBcexgknG5zfWEbVBqlslTDVEPLRMFd8u1Clvsc3V/QrkyH43tN6o0UukVZxRPkMdwst2n+B8v6
	xdsNyocxOnE/sVHHEOWuOZ1ChgG6PZpLtjSoIWoFohc=
X-Received: by 2002:a05:6602:6c0d:b0:85d:9793:e0d8 with SMTP id ca18e2360f4ac-879c0794acbmr176030839f.0.1752697325470;
        Wed, 16 Jul 2025 13:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkHzND1GOZhUtrnweS8iLLorG8xWwJULGu3yKJfmGb1M9f2dylTV50f8jGTHeKpBnM155xlA==
X-Received: by 2002:a05:6602:6c0d:b0:85d:9793:e0d8 with SMTP id ca18e2360f4ac-879c0794acbmr176028939f.0.1752697325018;
        Wed, 16 Jul 2025 13:22:05 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569c534esm3205560173.92.2025.07.16.13.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 13:22:04 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:22:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Brett Creeley
 <brett.creeley@amd.com>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, Longfang Liu
 <liulongfang@huawei.com>, qat-linux@intel.com, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, virtualization@lists.linux.dev, Xin
 Zeng <xin.zeng@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 patches@lists.linux.dev
Subject: Re: [PATCH v3] vfio/pci: Do vf_token checks for
 VFIO_DEVICE_BIND_IOMMUFD
Message-ID: <20250716142203.677d4a5d.alex.williamson@redhat.com>
In-Reply-To: <0-v3-bdd8716e85fe+3978a-vfio_token_jgg@nvidia.com>
References: <0-v3-bdd8716e85fe+3978a-vfio_token_jgg@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fcBh7mtGihdk0BtiPFA76YauRaf5MOHUH12UXKFyzZU_1752697326
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 13:08:25 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> This was missed during the initial implementation. The VFIO PCI encodes
> the vf_token inside the device name when opening the device from the group
> FD, something like:
> 
>   "0000:04:10.0 vf_token=bd8d9d2b-5a5f-4f5a-a211-f591514ba1f3"
> 
> This is used to control access to a VF unless there is co-ordination with
> the owner of the PF.
> 
> Since we no longer have a device name in the cdev path, pass the token
> directly through VFIO_DEVICE_BIND_IOMMUFD using an optional field
> indicated by VFIO_DEVICE_BIND_FLAG_TOKEN.
> 
> Fixes: 5fcc26969a16 ("vfio: Add VFIO_DEVICE_BIND_IOMMUFD")
> Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/device_cdev.c                    | 38 +++++++++++++++++--
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  1 +
>  drivers/vfio/pci/mlx5/main.c                  |  1 +
>  drivers/vfio/pci/nvgrace-gpu/main.c           |  2 +
>  drivers/vfio/pci/pds/vfio_dev.c               |  1 +
>  drivers/vfio/pci/qat/main.c                   |  1 +
>  drivers/vfio/pci/vfio_pci.c                   |  1 +
>  drivers/vfio/pci/vfio_pci_core.c              | 22 +++++++----
>  drivers/vfio/pci/virtio/main.c                |  3 ++
>  include/linux/vfio.h                          |  4 ++
>  include/linux/vfio_pci_core.h                 |  2 +
>  include/uapi/linux/vfio.h                     | 12 +++++-
>  12 files changed, 76 insertions(+), 12 deletions(-)

Applied to vfio next branch for v6.17 with discussed fix.  Thanks,

Alex

