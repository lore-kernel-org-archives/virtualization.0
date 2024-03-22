Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42345EE78
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127384; cv=none; b=PntrHiGIIKK0/OTUaCsHyp2fZt88iS+ng1iogYFj1VuXd9sgxPN7pQgqHluBTosW6kVj2Sdrz5NYL81wQXrIcjUhx2Wxj2gWkWOTnliBECvlZII9idg2V5n+Cv1NoCr/b/lxBDay+EoMl/cIv6kLn/KO1Ac7UuiKwjYkHABLVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127384; c=relaxed/simple;
	bh=7ur9VHXBBmtR/BzJooZLLcq+YeBquA9kLKNbVLwTOXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/NtcEQ/XIG2828uzjfaDRmtNkHoY0j3hl3DFVX9na8ZgoYXgYu1mcVCB7hzQb/0NL8AlhSVaIx3ov4hFlcA8Sw2iFdM1I6vFpBzaAowY2gm8CtEJ/gwer9VY8t0QbXH8NIVi+r/1vqVlUGpopQHh1rH5k8UmLbymmwusJNlyMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TcTBBVyK; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TcTBBVyK"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 902E9418DA
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 17:09:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MYnDqpUlYQbV
	for <virtualization@lists.linux-foundation.org>;
	Fri, 22 Mar 2024 17:09:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 777A440279
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 777A440279
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TcTBBVyK
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 777A440279
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 17:09:41 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-78a26803f1aso160983585a.3
        for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711127380; x=1711732180; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApAHAb/kVXuA2vroBRV/sxLLRFwBeKrRqNlXizxetGM=;
        b=TcTBBVyKAusos2I1MVDYRZGIWj8EOqomnFsQVYa9hdOCsmUhzwXZn1OhbDt2S4zSq9
         zxMQN4lV4KEbFG5I/Ea2x710TqgAcZyaXWkK3QVyrW3qrYMBws+azEE3N/OjPj44bjPH
         cQOzA9N4YDBxVVXPX2mwvdTuYdxdvwxoWgS51wMdtCB5HWbRB4dWILKAfMvIyabfhXxz
         WeVX01tmEd61DfIoCpenCZ0bQrM2y+jcFUTRJ4OubMfP+cSQrewLiTjJZGHo5dv7I6pF
         Ph/cUBPHglBrbdtvqgwfqMNh47o8UuKgS78oh3WLB8VFYS2VHiNBtwzrdYS9egFVXExv
         dAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127380; x=1711732180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApAHAb/kVXuA2vroBRV/sxLLRFwBeKrRqNlXizxetGM=;
        b=QE8BTr18i/k2aspaNe05OXhSUY1WzUpH0EdYBGNr/r7/RkbsZ04Ufhq1Mpr18wrxjy
         vj8H70GahW0BOL6pLr5j8LvmsZTDE9ht8MILK5TnML2bxhXnJNJ0ttGgDat6Y84gMUuj
         EJY975D9ae7gM/elq16IT8gYRaQsP2NFgooL9xqFmoNIjZWF+VywG1EvW+6obeXiPwY7
         Qd7KQNjY0Q+z1qmJLrwIHMqd1tJ82sUoA0eRy0PYvbnomMcFdUXSUyCoE6WDrhx0I+RE
         bY2MTpHTBrPAMkEG+wN9Yqw/6U4mWSBkbcqtNtNj2QAYf5vsm2zPIaP98jB10Lz32zCI
         xC8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt5qmKBsnS9LEOzmAGWbVtKCJ8HzSHTaiUAwdS1gF2uXBMAhcvcl6tsIYRk9lTyZPa+tIodSiQQKTvZbZ3kvtPTyJ1vjzSTDB5WHdtOuMuRNij0CFIxlUkxA==
X-Gm-Message-State: AOJu0YxuLdxnXXWYV826sQL96tpzXgcFBNGmbri7FQH7DG/HdyAlP5DR
	ry4NIbgmuwVvrWGW0hjGtUCfZyO9YK+SZ07jXzypOCBZR8nRUwP6uAHSmPe//Bs=
X-Google-Smtp-Source: AGHT+IEL8xR2S4VoPl+Aw327BSxdHoOXFRAq/bqB5JLQ7T86b5yNtZewLe/kyN/nOGUpgLU+Lu7bKg==
X-Received: by 2002:ae9:e401:0:b0:78a:2d4b:3b06 with SMTP id q1-20020ae9e401000000b0078a2d4b3b06mr18512qkc.76.1711127380253;
        Fri, 22 Mar 2024 10:09:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id a12-20020a05620a02ec00b00789fa326156sm921596qko.82.2024.03.22.10.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:09:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rniOh-00CSno-4j;
	Fri, 22 Mar 2024 14:09:39 -0300
Date: Fri, 22 Mar 2024 14:09:39 -0300
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
Subject: Re: [PATCH v3 4/8] iommufd: Add iommufd fault object
Message-ID: <20240322170939.GJ66976@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-5-baolu.lu@linux.intel.com>
 <20240308180332.GX9225@ziepe.ca>
 <e66064d7-c384-4f14-9459-ea21809b51b5@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66064d7-c384-4f14-9459-ea21809b51b5@linux.intel.com>

On Fri, Mar 15, 2024 at 09:46:06AM +0800, Baolu Lu wrote:
> On 3/9/24 2:03 AM, Jason Gunthorpe wrote:
> > On Mon, Jan 22, 2024 at 03:38:59PM +0800, Lu Baolu wrote:
> > > --- /dev/null
> > > +++ b/drivers/iommu/iommufd/fault.c
> > > @@ -0,0 +1,255 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (C) 2024 Intel Corporation
> > > + */
> > > +#define pr_fmt(fmt) "iommufd: " fmt
> > > +
> > > +#include <linux/file.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/iommufd.h>
> > > +#include <linux/poll.h>
> > > +#include <linux/anon_inodes.h>
> > > +#include <uapi/linux/iommufd.h>
> > > +
> > > +#include "iommufd_private.h"
> > > +
> > > +static int device_add_fault(struct iopf_group *group)
> > > +{
> > > +	struct iommufd_device *idev = group->cookie->private;
> > > +	void *curr;
> > > +
> > > +	curr = xa_cmpxchg(&idev->faults, group->last_fault.fault.prm.grpid,
> > > +			  NULL, group, GFP_KERNEL);
> > > +
> > > +	return curr ? xa_err(curr) : 0;
> > > +}
> > > +
> > > +static void device_remove_fault(struct iopf_group *group)
> > > +{
> > > +	struct iommufd_device *idev = group->cookie->private;
> > > +
> > > +	xa_store(&idev->faults, group->last_fault.fault.prm.grpid,
> > > +		 NULL, GFP_KERNEL);
> > 
> > xa_erase ?
> 
> Yes. Sure.
> 
> > Is grpid OK to use this way? Doesn't it come from the originating
> > device?
> 
> The group ID is generated by the hardware. Here, we use it as an index
> in the fault array to ensure it can be quickly retrieved in the page
> fault response path.

I'm nervous about this, we are trusting HW outside the kernel to
provide unique grp id's which are integral to how the kernel
operates..

> > > +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
> > > +				       size_t count, loff_t *ppos)
> > > +{
> > > +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
> > > +	struct iommufd_fault *fault = filep->private_data;
> > > +	struct iommu_hwpt_pgfault data;
> > > +	struct iommufd_device *idev;
> > > +	struct iopf_group *group;
> > > +	struct iopf_fault *iopf;
> > > +	size_t done = 0;
> > > +	int rc;
> > > +
> > > +	if (*ppos || count % fault_size)
> > > +		return -ESPIPE;
> > > +
> > > +	mutex_lock(&fault->mutex);
> > > +	while (!list_empty(&fault->deliver) && count > done) {
> > > +		group = list_first_entry(&fault->deliver,
> > > +					 struct iopf_group, node);
> > > +
> > > +		if (list_count_nodes(&group->faults) * fault_size > count - done)
> > > +			break;
> > > +
> > > +		idev = (struct iommufd_device *)group->cookie->private;
> > > +		list_for_each_entry(iopf, &group->faults, list) {
> > > +			iommufd_compose_fault_message(&iopf->fault, &data, idev);
> > > +			rc = copy_to_user(buf + done, &data, fault_size);
> > > +			if (rc)
> > > +				goto err_unlock;
> > > +			done += fault_size;
> > > +		}
> > > +
> > > +		rc = device_add_fault(group);
> > 
> > See I wonder if this should be some xa_alloc or something instead of
> > trying to use the grpid?
> 
> So this magic number will be passed to user space in the fault message.
> And the user will then include this number in its response message. The
> response message is valid only when the magic number matches. Do I get
> you correctly?

Yes, then it is simple xa_alloc() and xa_load() without any other
searching and we don't have to rely on the grpid to be correctly
formed by the PCI device.

But I don't know about performance xa_alloc() is pretty fast but
trusting the grpid would be faster..

IMHO from a uapi perspective we should have a definate "cookie" that
gets echo'd back. If the kernel uses xa_alloc or grpid to build that
cookie it doesn't matter to the uAPI.

Jason
