Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC34487AF
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Tw316C+0"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3095A848C7
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 15:14:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3095A848C7
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Tw316C+0
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8do-R86uliJa
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Dec 2023 15:14:08 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 56920848B7
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 15:14:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56920848B7
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77dd073b5baso118792385a.1
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Dec 2023 07:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701443647; x=1702048447; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVJUq6suPpiRp09p/ZEgMXSUtvlWnaDkWeaaG3LqGnA=;
        b=Tw316C+05FO+N1Zn6NT70cOP3JNwm2g9GPpxOhRI+8Bj6xPSAO7eyBoCoseQluZTP/
         RQ9AQxE0TC7WmH28xIiMhWbKz7YMsjYPTpDhZ2Pl7Xm9G7V5lBjhJ23uU5FHeAFgcQuD
         VUiDtItJK7NkHP92QMpYa8bhhcFaanvczIaFT8jR6r47cBUWkaOLW9CHhhL0mlCVGiFp
         bPKJii9Ir/O9O+BIAVKojAf0AiDa97ipaZzGxXajanxNpmSMr18bIZkgnHqB4R4D/8Af
         ppUTND2FNv4agvrtu2szp6VnTeoGcdC+2pAzFdQuNIiEKC1VXup8/BehngnJAnh6zlQ2
         /UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443647; x=1702048447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVJUq6suPpiRp09p/ZEgMXSUtvlWnaDkWeaaG3LqGnA=;
        b=mpMJWHkJGAsVy3+lwm6gRcR/F80KfXT9DUcIDm5jIA/FkadaB9xlYIqrwMnp65W3+K
         BYbk43r0gjjkj4M52QSzCL7F6VcnUuoTq+ZtdbJbHwvaAMy5G6PZHs5U2Wsn4VRnD1eg
         lLuSNTOXpiWednwrteltfWNq8IgZdOT6K97LhJy3YU/Wwg8gfaHwIr7kAItHxgi/bbpp
         RplIYvsd0L+7RCRxz5pVqW2u5PjWWde5wSD0lxM5ZAuhVqvl7XVjTCe/FOWUWVvBEUPk
         vwlhLJasC7t7gJ/icU4RaVT17A6ThV8gwesgNEYnJsxQ6kV5J1jrF4Kvd9JgeEcYkj+d
         9CiQ==
X-Gm-Message-State: AOJu0Ywl3i4Ul+Ldng/LrxIfekj8mVoCPcLUY5ABFk0LrkvBzuVDWlyC
	F/XkefQFfOF/ECqN/7ipOR2ymg==
X-Google-Smtp-Source: AGHT+IFojjBiYAyjB0qLsDw0/NdOZZDHh2j3CXMufmKOLt2sxpuBu/20ksASH3BMi0Fs2c9I9Tu+9Q==
X-Received: by 2002:a05:620a:1256:b0:77b:bf2e:c082 with SMTP id a22-20020a05620a125600b0077bbf2ec082mr27411255qkl.75.1701443647075;
        Fri, 01 Dec 2023 07:14:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id i9-20020a05620a27c900b007788c1a81b6sm1567869qkp.46.2023.12.01.07.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:14:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r95DR-006Fy6-Or;
	Fri, 01 Dec 2023 11:14:05 -0400
Date: Fri, 1 Dec 2023 11:14:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iommufd: Add iommu page fault uapi data
Message-ID: <20231201151405.GA1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-3-baolu.lu@linux.intel.com>

On Thu, Oct 26, 2023 at 10:49:26AM +0800, Lu Baolu wrote:

> + * @IOMMU_HWPT_ALLOC_IOPF_CAPABLE: User is capable of handling IO page faults.

This does not seem like the best name?

Probably like this given my remark in the cover letter:

--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -359,6 +359,7 @@ struct iommu_vfio_ioas {
 enum iommufd_hwpt_alloc_flags {
        IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
        IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
+       IOMMU_HWPT_IOPFD_FD_VALID = 1 << 2,
 };
 
 /**
@@ -440,6 +441,7 @@ struct iommu_hwpt_alloc {
        __u32 data_type;
        __u32 data_len;
        __aligned_u64 data_uptr;
+       __s32 iopf_fd;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)



> @@ -679,6 +688,62 @@ struct iommu_dev_data_arm_smmuv3 {
>  	__u32 sid;
>  };
>  
> +/**
> + * struct iommu_hwpt_pgfault - iommu page fault data
> + * @size: sizeof(struct iommu_hwpt_pgfault)
> + * @flags: Combination of IOMMU_PGFAULT_FLAGS_ flags.
> + *  - PASID_VALID: @pasid field is valid
> + *  - LAST_PAGE: the last page fault in a group
> + *  - PRIV_DATA: @private_data field is valid
> + *  - RESP_NEEDS_PASID: the page response must have the same
> + *                      PASID value as the page request.
> + * @dev_id: id of the originated device
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @perm: requested page permissions (IOMMU_PGFAULT_PERM_* values)
> + * @addr: page address
> + * @private_data: device-specific private information
> + */
> +struct iommu_hwpt_pgfault {
> +	__u32 size;
> +	__u32 flags;
> +#define IOMMU_PGFAULT_FLAGS_PASID_VALID		(1 << 0)
> +#define IOMMU_PGFAULT_FLAGS_LAST_PAGE		(1 << 1)
> +#define IOMMU_PGFAULT_FLAGS_PRIV_DATA		(1 << 2)
> +#define IOMMU_PGFAULT_FLAGS_RESP_NEEDS_PASID	(1 << 3)
> +	__u32 dev_id;
> +	__u32 pasid;
> +	__u32 grpid;
> +	__u32 perm;
> +#define IOMMU_PGFAULT_PERM_READ			(1 << 0)
> +#define IOMMU_PGFAULT_PERM_WRITE		(1 << 1)
> +#define IOMMU_PGFAULT_PERM_EXEC			(1 << 2)
> +#define IOMMU_PGFAULT_PERM_PRIV			(1 << 3)
> +	__u64 addr;
> +	__u64 private_data[2];
> +};

This mixed #define is not the style, these should be in enums,
possibly with kdocs

Use __aligned_u64 also

> +
> +/**
> + * struct iommu_hwpt_response - IOMMU page fault response
> + * @size: sizeof(struct iommu_hwpt_response)
> + * @flags: Must be set to 0
> + * @hwpt_id: hwpt ID of target hardware page table for the response
> + * @dev_id: device ID of target device for the response
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @code: response code. The supported codes include:
> + *        0: Successful; 1: Response Failure; 2: Invalid Request.
> + */
> +struct iommu_hwpt_page_response {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 hwpt_id;
> +	__u32 dev_id;
> +	__u32 pasid;
> +	__u32 grpid;
> +	__u32 code;
> +};

Is it OK to have the user pass in all this detailed information? Is it
a security problem if the user lies? Ie shouldn't we only ack page
faults we actually have outstanding?

IOW should iommu_hwpt_pgfault just have a 'response_cookie' generated
by the kernel that should be placed here? The kernel would keep track
of all this internal stuff?

Jason
