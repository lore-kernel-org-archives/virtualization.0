Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F438D
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127767; cv=none; b=gwaYOBbPv33ACOOhmeMfM/kiITSZR5s//DkGNYtMPrSC8zRWHFXm4MsSY6mYvzjU2W29zmmTRxxMFHoADOE93mNR0h9wqfdedmy/+EJD95qJiLzaDwCT73Ii/DSKH4GWubKW1Prt+70dsue6HdNpII0XJdbwBb32Ek2ziyoJGaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127767; c=relaxed/simple;
	bh=WGmcAoiIYkBzYTcnI6cjBMVdcLKjLO/t8etJMyy0xdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsOsj3tsV6Qk+23tR7qLtFssgBXxXPtP8FMbY6NS9aATmmbLz6f/87lJwsFM4Ull6I6/1bm0E8GaHAWF0NChaOuCEM/rmQGe69HgLUGeEf0Nv0wZPlRgy5M//4st+4rsxm0C69NU4O3R9x668wzaLYieCvWV9FRAaS+XiFQ5qxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Gzz7AN6H; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Gzz7AN6H"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 392EA406D4
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:22:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D6x4FvKA3dvU for <virtualization@lists.linux-foundation.org>;
 Wed,  8 May 2024 00:22:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::92f; helo=mail-ua1-x92f.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2B45540698
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B45540698
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Gzz7AN6H
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B45540698
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:22:44 +0000 (UTC)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7f170dc5f70so976354241.1
        for <virtualization@lists.linux-foundation.org>; Tue, 07 May 2024 17:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715127763; x=1715732563; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vVlsRAg17DQsgwypHbQum2UTPFFlE+iz9hu2GQEt7A=;
        b=Gzz7AN6H86YOoXK8YtKnVZofHgQssSMqYZmmaU+cmRQoH8w2OJq7I8iTjQa+6ZF3Jp
         QUU3sF7NjtYrF28WEcwQTVXsu4uvhDVGiHKHWXx+OfirYAEBJhaT/thRIwR37JON+Bh4
         EtV/XP0rZkZrGa76taf4XcoyDVQGU2x1BzVngKQEgwy6h/k8lAnjjKD7I5sAfv8bbXBw
         ynjSdm+NwacwHl59GTyOBaxwpQ7WcGYU+p/7LhRC+Au/kZbTcuoqYui2TVgkoR28duDI
         dyNFQir8/bmcatF/1kxuA3nXIlRZMsuloGPqFvx+3NU+AWELPR4tTz0F6jPknUGGQ+xN
         gnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127763; x=1715732563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vVlsRAg17DQsgwypHbQum2UTPFFlE+iz9hu2GQEt7A=;
        b=b5nRNO006aMOWyaMNwOt449STdeZ1K4yoUx9D/+MsL7UZVHNj3Mav82lNHuwk5oSDP
         aQcuDyW+695dPXOWbIxLFJPuTYPz1MPmHHnBqL739myi71arO3254OC+Vk0SN5zSlgXU
         tAPNCExRnIp08RV/VG+16UjC0yV4a73ZaLlcyOAelkYyOnZkeUEftbfoeRk0XJm3hKyo
         2VbjN7EiCy1sNywGgEcjAn1TQuCiSiazDBxzpI6zkrq/spioZXA7wCnvXF/h2wmkdcND
         QlqGVlAss/DyqFEnIUXWFlSpULEW+SxlMLfHJV4pS4LtJLc/JctPlVUHeWfTxNeC+giK
         cDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVble2/jhGWMBojn5daLRE2oCy2a3CmcUQJQODnmWGRZ2H2j7FMIITQ4XnTPt/clKbhR2IvtpWOpRyeBh4VEEDyKC2QiMeZA04R9pTzC1DzicPd9hPqTXIBNg==
X-Gm-Message-State: AOJu0Yyk8CFLJ0ccu8KgpJw0ZNZjEMFWnn//AxYYzcy6VB4jRzA8Cgsg
	2uKAADzMUGZSfbHbPyJ0bf/1AfClvr5OsBIaqvxW9HKuXed4Tn7R6I7qLQ1/gfE=
X-Google-Smtp-Source: AGHT+IECNvqKHwlIYvkCbsFT5xd8nj9nklkhaiaz6B3Vn7SJl6jIjBbaZQht1v4nImwi8swZj3JkDQ==
X-Received: by 2002:a67:f554:0:b0:47b:d787:9ca6 with SMTP id ada2fe7eead31-47f3c2f99d9mr1007624137.18.1715127763605;
        Tue, 07 May 2024 17:22:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id o6-20020a0ccb06000000b006a13cf08fd4sm1804740qvk.66.2024.05.07.17.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:22:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4V50-00059G-L2;
	Tue, 07 May 2024 21:22:42 -0300
Date: Tue, 7 May 2024 21:22:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
Message-ID: <20240508002242.GP4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-6-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:06PM +0800, Lu Baolu wrote:
> +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
> +				       size_t count, loff_t *ppos)
> +{
> +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
> +	struct iommufd_fault *fault = filep->private_data;
> +	struct iommu_hwpt_pgfault data;
> +	struct iommufd_device *idev;
> +	struct iopf_group *group;
> +	struct iopf_fault *iopf;
> +	size_t done = 0;
> +	int rc;
> +
> +	if (*ppos || count % fault_size)
> +		return -ESPIPE;
> +
> +	mutex_lock(&fault->mutex);
> +	while (!list_empty(&fault->deliver) && count > done) {
> +		group = list_first_entry(&fault->deliver,
> +					 struct iopf_group, node);
> +
> +		if (list_count_nodes(&group->faults) * fault_size > count - done)
> +			break;

Can this list_count be precomputed when we build the fault group?

> +
> +		idev = group->attach_handle->idev;
> +		if (!idev)
> +			break;

This check should be done before adding the fault to the linked
list. See my other note about the race.

> +
> +		rc = xa_alloc(&idev->faults, &group->cookie, group,
> +			      xa_limit_32b, GFP_KERNEL);
> +		if (rc)
> +			break;

This error handling is not quite right, if done == 0 then this should
return rc.


> +
> +		list_for_each_entry(iopf, &group->faults, list) {
> +			iommufd_compose_fault_message(&iopf->fault,
> +						      &data, idev,
> +						      group->cookie);
> +			rc = copy_to_user(buf + done, &data, fault_size);
> +			if (rc) {
> +				xa_erase(&idev->faults, group->cookie);
> +				break;

Same here

(same comment on the write side too)

Jason
