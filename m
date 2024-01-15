Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E517BD5
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jan 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z0MxmH2P"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67B5041835
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jan 2024 16:47:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67B5041835
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Z0MxmH2P
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Otn2az6oJI2P
	for <virtualization@lists.linux-foundation.org>;
	Mon, 15 Jan 2024 16:47:26 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D434640252
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jan 2024 16:47:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D434640252
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4298e866cd6so55295161cf.0
        for <virtualization@lists.linux-foundation.org>; Mon, 15 Jan 2024 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705337244; x=1705942044; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2crKgiTXcC8UeiyKNQE9cMBlk/o9KLy3IDkuGS6sULY=;
        b=Z0MxmH2PpdpihkMmwb9b8TQC9ENG+63NUqSO20Xq2UDYvW4XHvfKmRsUGJA1VyBzD8
         86gvZEKKDNS1It4Z0uBbVHw1BvMHuDWlLBP+QaiylaFaUOwgqXieVq9ZhvMhk4A5u++R
         GuatNBTrv4o9krwzBlgYEbt14T6eQ5plMuozkwAfBXS4ZPISebJfCC+0mqsyvs9dfnk3
         6ShsyR4NNbm+3KsXJ0wPy/tCmRTHl63qxBKKjqvVZC8f4f5FfktCkd0PUpI8EvuUekaJ
         AlYQqmrNFm/QzjTzskNkOSYp9DPkpDwwGu+P++vh3r2Ub8BSxNnGzct/VVBb+wqSapbw
         6Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705337244; x=1705942044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2crKgiTXcC8UeiyKNQE9cMBlk/o9KLy3IDkuGS6sULY=;
        b=k5m/Vp/WovNMce381ejc4bYa7pudyLJreWYWdlmkpPgu6vaglJvAMuVWyr48QAjWOc
         P37R0ZWWUTgq+/uQcB/kYbjEETA6U+0tkFgVtQIK9arSPWnAQbiZMeNCnL6SILwHHzHa
         oUAOOeLMCdrmcV818PYsl+QSJEFvXGtOs5g7qhN1nlf5NM4z15D9dA09sR4ceDoNChi3
         JpCaR9XNjscakjOJvXfxAPC031+egNGOVgEPr3CGMUG71lBAcZOoGqxCq4lvk/gKXhJN
         c+J6Rgwda+fLwac67y1Kg1iS0BO9akEltbKH2OmalHszLIO1c3hUTaA29F3Ir02W03cE
         NRlQ==
X-Gm-Message-State: AOJu0YyC9xk+A0Fd2zjapZhgQZAj4RQVZPf2tVHNwdKB3zdMmtXKX0QD
	DqPczSgPFlcxFdBdgGi/V4ISxLHVi54c+Q==
X-Google-Smtp-Source: AGHT+IHytem9ZiSpp/IMZZ23Px9ow/WDIS5U8JgImTeFhW9KwLcIg20JNrAqcGdlqr/VIaHDsAnzDg==
X-Received: by 2002:a05:622a:11ca:b0:429:ffda:679c with SMTP id n10-20020a05622a11ca00b00429ffda679cmr139180qtk.25.1705337244703;
        Mon, 15 Jan 2024 08:47:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id eh18-20020a05622a579200b00425b3fd33f2sm4023338qtb.90.2024.01.15.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:47:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPQ7P-003tM0-9N;
	Mon, 15 Jan 2024 12:47:23 -0400
Date: Mon, 15 Jan 2024 12:47:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20240115164723.GB50608@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <b822096cc3b441309d99832c587be25a@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b822096cc3b441309d99832c587be25a@huawei.com>

On Fri, Jan 12, 2024 at 05:46:13PM +0000, Shameerali Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Thursday, October 26, 2023 3:49 AM
> > To: Jason Gunthorpe <jgg@ziepe.ca>; Kevin Tian <kevin.tian@intel.com>; Joerg
> > Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin Murphy
> > <robin.murphy@arm.com>; Jean-Philippe Brucker <jean-philippe@linaro.org>;
> > Nicolin Chen <nicolinc@nvidia.com>; Yi Liu <yi.l.liu@intel.com>; Jacob Pan
> > <jacob.jun.pan@linux.intel.com>
> > Cc: iommu@lists.linux.dev; linux-kselftest@vger.kernel.org;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org; Lu
> > Baolu <baolu.lu@linux.intel.com>
> > Subject: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
> > 
> [...]
> 
> Hi,
> 
> > +static ssize_t hwpt_fault_fops_write(struct file *filep,
> > +				     const char __user *buf,
> > +				     size_t count, loff_t *ppos)
> > +{
> > +	size_t response_size = sizeof(struct iommu_hwpt_page_response);
> > +	struct hw_pgtable_fault *fault = filep->private_data;
> > +	struct iommu_hwpt_page_response response;
> > +	struct iommufd_hw_pagetable *hwpt;
> > +	struct iopf_group *iter, *group;
> > +	struct iommufd_device *idev;
> > +	size_t done = 0;
> > +	int rc = 0;
> > +
> > +	if (*ppos || count % response_size)
> > +		return -ESPIPE;
> > +
> > +	mutex_lock(&fault->mutex);
> > +	while (!list_empty(&fault->response) && count > done) {
> > +		rc = copy_from_user(&response, buf + done, response_size);
> > +		if (rc)
> > +			break;
> > +
> > +		/* Get the device that this response targets at. */
> > +		idev = container_of(iommufd_get_object(fault->ictx,
> > +						       response.dev_id,
> > +						       IOMMUFD_OBJ_DEVICE),
> > +				    struct iommufd_device, obj);
> > +		if (IS_ERR(idev)) {
> > +			rc = PTR_ERR(idev);
> > +			break;
> > +		}
> > +
> > +		/*
> > +		 * Get the hw page table that this response was generated for.
> > +		 * It must match the one stored in the fault data.
> > +		 */
> > +		hwpt = container_of(iommufd_get_object(fault->ictx,
> > +						       response.hwpt_id,
> > +
> > IOMMUFD_OBJ_HW_PAGETABLE),
> > +				    struct iommufd_hw_pagetable, obj);
> > +		if (IS_ERR(hwpt)) {
> > +			iommufd_put_object(&idev->obj);
> > +			rc = PTR_ERR(hwpt);
> > +			break;
> > +		}
> > +
> > +		if (hwpt != fault->hwpt) {
> > +			rc = -EINVAL;
> > +			goto put_obj;
> > +		}
> > +
> > +		group = NULL;
> > +		list_for_each_entry(iter, &fault->response, node) {
> > +			if (response.grpid != iter->last_fault.fault.prm.grpid)
> > +				continue;
> > +
> > +			if (idev->dev != iter->dev)
> > +				continue;
> > +
> > +			if ((iter->last_fault.fault.prm.flags &
> > +			     IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) &&
> > +			    response.pasid != iter->last_fault.fault.prm.pasid)
> > +				continue;
> 
> I am trying to get vSVA working with this series and got hit by the above check.
> On ARM platforms, page responses to stall events(CMD_RESUME) do not have
> an associated pasid.  I think, either we need to check here using
> IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID or remove the check 
> as it will be eventually done in iommu_page_response(). 

That doesn't sound right..

The PASID is the only information we have for userspace to identify
the domain that is being faulted. It cannot be optional on the request
side.

If it is valid when userspace does read() then it should be valid when
userspace does write() too.

It is the only way the kernel can actually match request and response
here.

So, I think you have a userspace issue to not provide the right
pasid??

Jason
