Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D617B024
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546609; cv=none; b=GmnD6yu0Y1Xjmv0/WSRGPHmpW3Z/86BVaMv0JDrnRsi/61b2hS2AFT3z5kHmSG1opTocG7FjC54KedsqFxZEzDUSjGS91RSJ6w/CKPHk5BZ7RBg4DMHotgmeeYZB0uGTce/r2Z6EKrRHDj4m6kbKvlMjdbaeoExOte7eUJdP5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546609; c=relaxed/simple;
	bh=ybUpRykbhepziN9syApY4S0KNYPzhQzyVpqfFsxbFkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNPM2XugOYiKuXqoMKZ1kFVJea/+i6jgKzKXSerdlGbZi1ebfalSso3Tf4iDJIejzR+XKgdELsreg2fVScE847zIcXCRqdn/pJO8s1UYStlsfGDlwzXTcaAZytlc1gurLPrKZQpBDv5gizXQD59OKmTB7oSaVe5Z6Z9rgs2YkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HUJR7bZl; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HUJR7bZl"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA2EA819B8
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 17:36:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 01BT_zF4RE7Q for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Jul 2024 17:36:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5DB838188B
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DB838188B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HUJR7bZl
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5DB838188B
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 17:36:45 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-447e57103d5so17770211cf.2
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jul 2024 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720546605; x=1721151405; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ktxBVI1f7SCZNiJbmLEe3WqbtU8UsAv3DUj8UortQs=;
        b=HUJR7bZlBwZvas3swh1pE/egrKt8hgtMQLjkl+mTUwvQhwDPQOfcL1jCvaHP/GbMI4
         1GQAMvkWkuAFo4mkD5L/ZzbeXX3k/fNnOKw76CfDGON6U15Dgmt7VCpXNXoSzPVAllFo
         Xhr1IcXzfHbKttP7DIWJk25/GA+8wP3BDZfxs1GHBpyO4jd3nbZTfpHITIt5wBmcE4nf
         WOX/0T6BE5ceTkmUDXaS07wnEbDoFEVBFzjC4n9bfv/MyGY2WgEh4DbTVv5sCgtQoYLP
         R9BT+yQokUv846IhRkxWTkl04UqlP9lvAXjGAUNbaFmPWYrjBoQ97qGbe3+sENi3VSER
         fO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546605; x=1721151405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ktxBVI1f7SCZNiJbmLEe3WqbtU8UsAv3DUj8UortQs=;
        b=szrgT23Q33xQ6RfaB+90bLON8WS8IX2RgH7Mi1UTVBtZ5jok/aQHM76YkyneZ+K7MC
         yaIEs1NeSwsMTncnRdOykUmJ8ppesnllZBAA58DXCR40P9v8Zn70gAC0ot9tOuV/Irns
         w04lWbXgFMDlniz8PGIbEdHXPQFfvdaAqq/dje+U1Bv3n5u8B2zjFj9EJSdNhmMutsC0
         wnVuCqGI1J1T0op9Z8lcz2Jz97uN4dnvO5bsYBjpuKQH8pYgExW9HFhBkg+jhQ0ILYmo
         WNlXiEtOEzo/ioLUNqpp7wIE7MzviX5ujlm5YdNrPyIdfYIrsjJ4O5v6aOvKhsT4Jy5R
         eBQA==
X-Forwarded-Encrypted: i=1; AJvYcCUb9iL58FGk7vIci8dglrXmEee7JDB4rGA4KmgKmp0gJOETKvRmYv++a7O8rqeKLccvTHmIudNY7y5Rznt/vNMyX2rgn+Zts/uzdf+8zv/I++5ec0f8Jx7qtg==
X-Gm-Message-State: AOJu0YwTin8+odPe+r5lh6YOgMmRL6FMHi/echN05pznBJJpEBzMzi+P
	rFUOTfBxP4tJtw50fhIKoeICpKXFa8/TC1WIWWfSfadpTmUUAnmApO+o6NH4FLU=
X-Google-Smtp-Source: AGHT+IEey3aVdoUnVEY9s9+wQwMkPK21WmHGPGMn7kqGKdsDHciJdWQY/uQZYPc75ra9uDqujYUDpg==
X-Received: by 2002:ad4:5d6e:0:b0:6b5:7ee:1d79 with SMTP id 6a1803df08f44-6b61bce1891mr38703216d6.26.1720546604791;
        Tue, 09 Jul 2024 10:36:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61c40e5e7sm10084406d6.72.2024.07.09.10.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:36:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRElf-002kZ7-8R;
	Tue, 09 Jul 2024 14:36:43 -0300
Date: Tue, 9 Jul 2024 14:36:43 -0300
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
Subject: Re: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20240709173643.GI14050@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-8-baolu.lu@linux.intel.com>
 <Zn8oZ80p0p1bHgBC@ziepe.ca>
 <7421b923-0bd6-4c9d-81e6-07d954085171@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7421b923-0bd6-4c9d-81e6-07d954085171@linux.intel.com>

On Mon, Jul 01, 2024 at 01:55:12PM +0800, Baolu Lu wrote:
> On 2024/6/29 5:17, Jason Gunthorpe wrote:
> > On Sun, Jun 16, 2024 at 02:11:52PM +0800, Lu Baolu wrote:
> > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > +{
> > > +	struct device *dev = idev->dev;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * Once we turn on PCI/PRI support for VF, the response failure code
> > > +	 * should not be forwarded to the hardware due to PRI being a shared
> > > +	 * resource between PF and VFs. There is no coordination for this
> > > +	 * shared capability. This waits for a vPRI reset to recover.
> > > +	 */
> > > +	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > +		return -EINVAL;
> > I don't quite get this remark, isn't not supporting PRI on VFs kind of
> > useless? What is the story here?
> 
> This remark is trying to explain why attaching an iopf-capable hwpt to a
> VF is not supported for now. The PCI sepc (section 10.4.2.1) states that
> a response failure will disable the PRI on the function. But for PF/VF
> case, the PRI is a shared resource, therefore a response failure on a VF
> might cause iopf on other VFs to malfunction. So, we start from simple
> by not allowing it.

You are talking about IOMMU_PAGE_RESP_FAILURE ?

But this is bad already, something like SVA could trigger
IOMMU_PAGE_RESP_FAILURE on a VF without iommufd today. Due to memory
allocation failure in iommu_report_device_fault()

And then we pass in code from userspace and blindly cast it to
enum iommu_page_response_code ?

Probably we should just only support IOMMU_PAGE_RESP_SUCCESS/INVALID
from userspace and block FAILURE entirely. Probably the VMM should
emulate FAILURE by disabling PRI on by changing to a non PRI domain.

And this subtle uABI leak needs a fix:

		iopf_group_response(group, response.code);

response.code and enum iommu_page_response_code are different
enums, and there is no range check. Need a static assert at least and
a range check. Send a followup patch please

Jason
