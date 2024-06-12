Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8038A17B4E5
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198645; cv=none; b=d+mdKf2e0r7uKMYItM5OY2pra+c2/Aw0RDXBtGmfMVwJwTVPdJwfPIbENugKvMeT+Y+vK9+BiWRAxzUptjyiLTKXMNvu5lAQm+cwSO4dIUyDbF2HvFgiBy3fW237grOZEDZr2udzdxqvXey1PH41G+dOYDy/icMMtq02DsGNri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198645; c=relaxed/simple;
	bh=ZzY3qCMPDQaQOhhG+Cblq6ulH8qDjUPPFb/f9zNHOOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3+drRYrneqEOqtmIydUelpjuJjpYt1cNGzfUrQschyOkaroDEnxy278ekNKC50FwBb4WKnOGcGj1eQJ+hzQ9GeeHTOjZBt4Ah7qZauBLxaytHh6bp3c/vAwFydBpeGXWJCOISZTvXowF9BO48QRUXsHpqf9kDsFHcVcUxkmAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fSk76ly6; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fSk76ly6"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E5CCB40B17
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:24:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ay3y21u67oRC for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 13:24:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5EFEC40026
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5EFEC40026
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fSk76ly6
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5EFEC40026
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:24:02 +0000 (UTC)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-440f035214eso18084891cf.2
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718198641; x=1718803441; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXrU57CQXz06V3OC089KtN6n0lzdkX95OHg+FjYAde0=;
        b=fSk76ly6wWQ8vDMNOvD92yF3jtgEsgkaBmekQeKjcbdzzB9DBv4Bi9+GRYh+jhgZnG
         Iu+T527PmgW2paziUkAqWRC8JVyhMyA/SoX8YPP+uN/cweRyNjcVBrEyJ5vUvn9mPMIL
         bU52yPzrWYWHeyHpCRvK/bi7B92jLlmQLsWQTIwpQ5tAr1CTLntUdbvx48GNzLTKeo0p
         qGR4EmhWRe/l3tJp2f4aKL3+hTQujDvYt/oxjOlE8K41GUXN7mKGfc8FNwR2oX2KOXFj
         T3q1mKAS4eV/ULm3OEmlSWt7ezwrjqG50Oq7jmkOGWVXi2xnPdu35cAv4T/fgmDjN3fk
         evng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198641; x=1718803441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXrU57CQXz06V3OC089KtN6n0lzdkX95OHg+FjYAde0=;
        b=V1v3AEfJG7pbl4MQ268NBELfcOKjb8BRkuWidS5E0e0UoefR2dqfRnke0v2OLmGzXh
         xonTvB0rigJtIdo917kG2VTkAfdjRFzM5vP415fimMJpVNe0GbPgS4XjARxh4mnb10Fp
         nWzYhmYE0Mbwp+WurP495v9Cylyq16Xrt7qXP+jllRS/l8MxHgWAVt1L0fJAXk1+t1vX
         okSqXmcb8eHO7rnS1u0JTkBdv9InY1TZG/ze+tJ5vFSQxWyJ1/vz2iAzq1y37vrlnLDN
         mlEB6iBUM6BH3hVeCVhRHfmcBWaAh2F1LpUjqk8glj23MzukwbzhA7A1XlxCZ2nci2RJ
         8qVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGh8ZTF86pQsubdpY7r2aJVt4FF6Uhf3QosnKeF+yLbR2M/AVdXcQWuzpJBMrJdc7TgpDMKWssVnF7w+uOQU1MddTnQf7tdLObA7WW9Yh1urzFHLBLSAz1yA==
X-Gm-Message-State: AOJu0YyyXqhIq7V42TjFR9RMD0F5pE7DetIIibygNzCI82VjGDLArNq4
	1csWyfuccUTQCThxx/LU+qOd+097Ee7HyCCnIQMzmZhyEO+jHPjqwfLAj2p69L8=
X-Google-Smtp-Source: AGHT+IFCgwK6nkMac+bbLrNRTZhR+zW7VHze00Gv6obmMLZnfPVZUTNFdOzpdXn2ab5aoZ07hd2k1g==
X-Received: by 2002:ac8:7f4a:0:b0:440:1c5a:5c9b with SMTP id d75a77b69052e-4415ac0ecbcmr16496121cf.7.1718198641035;
        Wed, 12 Jun 2024 06:24:01 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4403895aa9asm55436811cf.7.2024.06.12.06.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:24:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNxG-008t4f-Ig;
	Wed, 12 Jun 2024 10:23:58 -0300
Date: Wed, 12 Jun 2024 10:23:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/10] iommufd: Add iommufd fault object
Message-ID: <20240612132358.GU791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-7-baolu.lu@linux.intel.com>
 <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jun 07, 2024 at 09:17:28AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Monday, May 27, 2024 12:05 PM
> > 
> > +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
> > +				       size_t count, loff_t *ppos)
> > +{
> > +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
> > +	struct iommufd_fault *fault = filep->private_data;
> > +	struct iommu_hwpt_pgfault data;
> > +	struct iommufd_device *idev;
> > +	struct iopf_group *group;
> > +	struct iopf_fault *iopf;
> > +	size_t done = 0;
> > +	int rc = 0;
> > +
> > +	if (*ppos || count % fault_size)
> > +		return -ESPIPE;
> 
> the man page says:
> 
> "If count is zero, read() returns zero and has no  other  results."

The above does that? 0 % X == 0

> > +
> > +	mutex_lock(&fault->mutex);
> > +	while (!list_empty(&fault->deliver) && count > done) {
> > +		group = list_first_entry(&fault->deliver,
> > +					 struct iopf_group, node);
> > +
> > +		if (group->fault_count * fault_size > count - done)
> > +			break;
> > +
> > +		rc = xa_alloc(&fault->response, &group->cookie, group,
> > +			      xa_limit_32b, GFP_KERNEL);
> > +		if (rc)
> > +			break;
> > +
> > +		idev = to_iommufd_handle(group->attach_handle)->idev;
> > +		list_for_each_entry(iopf, &group->faults, list) {
> > +			iommufd_compose_fault_message(&iopf->fault,
> > +						      &data, idev,
> > +						      group->cookie);
> > +			rc = copy_to_user(buf + done, &data, fault_size);
> > +			if (rc) {
> 
> 'rc' should be converted to -EFAULT.

Yes


> > +				xa_erase(&fault->response, group->cookie);
> > +				break;
> > +			}
> > +			done += fault_size;
> > +		}
> > +
> > +		list_del(&group->node);
> > +	}
> > +	mutex_unlock(&fault->mutex);
> > +
> > +	return done == 0 ? rc : done;
> 
> again this doesn't match the manual:
> 
> "On error, -1 is returned, and errno is set appropriately. "
> 
> it doesn't matter whether 'done' is 0.

It is setup so that once the list_del() below happens it is guarenteed
that the system call will return a positive result so that the
list_del'd items are always returned to userspace.

If we hit any fault here on the Nth item we should still return the
prior items and ignore the fault.

If we hit a fault on the first item then we should return the fault.

Jason
