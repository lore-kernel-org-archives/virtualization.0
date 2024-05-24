Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2512C47D
	for <virtualization@lists.linux-foundation.org>; Fri, 24 May 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560223; cv=none; b=nOdtQovcBz99yVCRcwFroGpAyowxCxp9VtVSEnyaGHniy3LohtkIzh9vOsLxR9CqeqpQm+6ajg1T0tgFPJYMHYploSA1Nnory1BVQ2qNaUF3TfA/XKB+QIFIqGUcljaTfs0Lytuvru8481i3p1KX6RUWHZuQ9F4gc3rxNnjk4l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560223; c=relaxed/simple;
	bh=801tCOV5OAv0DZm2X9cQ9Ugasii44hxsZOXOquLuSwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR6buN4nOn5goWXVJ0RT+FiQDzDrzAcb+KvZM8DG0nOzBngLpXIzVB63v5Ulr0EU6dOBxmg7Y1+gxE1r8p2etDVIPvbW9sLXW6ZXTMN+WlwDeJBpRNYGTFcv2cl59IEz3WO5cAAmTKghK7Ys2ExzKWjCKQeMNzRZh6w5c3ZYGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=omEOteNG; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="omEOteNG"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5C3F82A6C
	for <virtualization@lists.linux-foundation.org>; Fri, 24 May 2024 14:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1lczlYt1rOX for <virtualization@lists.linux-foundation.org>;
 Fri, 24 May 2024 14:17:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2E75982798
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E75982798
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=omEOteNG
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E75982798
	for <virtualization@lists.linux-foundation.org>; Fri, 24 May 2024 14:16:59 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-794ab0f7214so40852185a.3
        for <virtualization@lists.linux-foundation.org>; Fri, 24 May 2024 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716560218; x=1717165018; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suZw9oB6HBTqRgA6OrNMLSYpruM3XqODKPk/UHtyCxE=;
        b=omEOteNGVde+CGSsJeYJM9jaAwoICbyyODeAKuglmE2+3uo725u57IZomp+YIfv03/
         AnWkwGTKW7K7rC9Lw03V2d7NDrQsaKdq+LTnBTHMATiXQC6gNqkExSP2qTeQqqCAcDUv
         AK7iUPXJZhNecVuhdNs8j8fLbv1a4JCo875PviN5MJRgjx0VtSJ1M7aNyDoBO0znksaD
         UMP1I49f3P6RzmlCRWcJkVIlkmqAyBf6Q0XkHGcZVQITZQ5Q/2dUaV8/8+DppeYSYlu7
         yANip+xp05tWHqFAAd3aYLKPlcrbXtitBumSADHDac4XPqMwOA4xL4vzeGdrJQcV5EfJ
         DwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716560218; x=1717165018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suZw9oB6HBTqRgA6OrNMLSYpruM3XqODKPk/UHtyCxE=;
        b=JVFGW63GBIHsMP/ikFV7pJix7JGv7msUcdhKx7KxqLz17CQkHsbSisabjh5MS8aenB
         ACkkhwZEp5mKJBHrxbx2vXtAoWwWbiaofzT7TqrlLxvn4W7VLtanFzXSIvNhm24BywHe
         AbNbxyEc0QOrVETdQwUEQBIEt6GovBuIKz6L7y0T/m8TMuPpqDS4378NzYDSYzmFpxTN
         9cLuqjbfqRKgxp1tltt4lpKPb84AFjlzGikIr5/cAznZMI7c3bENq2aSU7GLKp1p1pPe
         ET0kYBBK0RqqlFDrQ3ShPHCHIG1RKlNLKs7ecCJIkejtSGmnwj0wv22Mg049Cp0adPsn
         5gcA==
X-Forwarded-Encrypted: i=1; AJvYcCWzDNbxXq/mehGzKQy1ggg45Ym4TO1ewR6Wfi/s18dk3Wbatr+aHSKtQVgaeuLBWJtFTI0UZoSQLXMfGjqdUTUKqZNm/2lhNgB+FwNSrVO6APQFw8qsJCal7w==
X-Gm-Message-State: AOJu0Yyd+LFyz2BRnbSLyLOnSQulZyzXpZBVeaOJ2sUrbURsw9NPbwOr
	AOFFNyuogZ2y0YL+ZMAQQq6B8zSNuppgCE0CmJgBVXGSw9sh8WsRvii9OO2U4O8=
X-Google-Smtp-Source: AGHT+IGJz8qoEDJMKsE3K/mi44tccE8zp05AFCzKA8aB112w+RpaAl9TlJZS6IYNjZCyNnjlwMPUfw==
X-Received: by 2002:a05:6214:2f09:b0:6ab:86fe:514c with SMTP id 6a1803df08f44-6abcd0b1f1cmr32057116d6.38.1716560218580;
        Fri, 24 May 2024 07:16:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070dab0dsm7645576d6.34.2024.05.24.07.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:16:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAVj7-001Jqp-Hy;
	Fri, 24 May 2024 11:16:57 -0300
Date: Fri, 24 May 2024 11:16:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
Message-ID: <20240524141657.GO69273@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <79bacf16-dfa6-42c7-b02d-117985e38472@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79bacf16-dfa6-42c7-b02d-117985e38472@linux.intel.com>

On Mon, May 20, 2024 at 09:24:09AM +0800, Baolu Lu wrote:
> On 5/15/24 4:37 PM, Tian, Kevin wrote:
> > > +static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user
> > > *buf,
> > > +					size_t count, loff_t *ppos)
> > > +{
> > > +	size_t response_size = sizeof(struct iommu_hwpt_page_response);
> > > +	struct iommufd_fault *fault = filep->private_data;
> > > +	struct iommu_hwpt_page_response response;
> > > +	struct iommufd_device *idev = NULL;
> > > +	struct iopf_group *group;
> > > +	size_t done = 0;
> > > +	int rc;
> > > +
> > > +	if (*ppos || count % response_size)
> > > +		return -ESPIPE;
> > > +
> > > +	mutex_lock(&fault->mutex);
> > > +	while (count > done) {
> > > +		rc = copy_from_user(&response, buf + done, response_size);
> > > +		if (rc)
> > > +			break;
> > > +
> > > +		if (!idev || idev->obj.id != response.dev_id)
> > > +			idev = container_of(iommufd_get_object(fault->ictx,
> > > +							       response.dev_id,
> > > +
> > > IOMMUFD_OBJ_DEVICE),
> > > +					    struct iommufd_device, obj);
> > > +		if (IS_ERR(idev))
> > > +			break;
> > > +
> > > +		group = xa_erase(&idev->faults, response.cookie);
> > > +		if (!group)
> > > +			break;
> > is 'continue' better?
> 
> If we can't find a matched iopf group here, it means userspace provided
> something wrong. The current logic is that we stop here and tell
> userspace that only part of the faults have been responded to and it
> should retry the remaining responses with the right message.

The usual fd-ish error handling here should be to return a short write
(success) and then userspace will retry with the failing entry at the
start of the buffer and collect the errno.

Jason
