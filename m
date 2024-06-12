Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34F17CA07
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200228; cv=none; b=EqqLVdSkbQA1+3wxJzZ5Jd5+KcTVkgO0FQPGYCqVB1wAKVY3eF7WnrUBr9R2G5cX7HtU4RgpV/B8b5cZlRr4G8dttSSDWzTKD+pv99hsN3L1uaAw2Tb/UnQlnvvaFly6G+rLikteNy83hyColNWZrN/obchM8EoaLoFaRD9uIjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200228; c=relaxed/simple;
	bh=hXC97HFGx9ulznhCQ/2sutiUlN20FWDeS6s8GSoSCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYktnVuHiNULAOeItLoK3/g8Wvkzu5/Jplu82jJ6aZC3IxI1fAbdF4G2yp+Wtv8tty5fGF9ABfpK/j2ZNDzP3OBSX+pLcCPgOI/rfQtB1p4kP9Fisz1aXeAIVKnA2W1zB9dMXtvBb8/ixjsxQISMGp37IobVytxRTEQpssgY/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DMA+vXf4; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DMA+vXf4"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B610040CA7
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4utODosg0RuP for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 13:50:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 704AB40AF0
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 704AB40AF0
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=DMA+vXf4
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 704AB40AF0
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:50:25 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-795569eede0so229154685a.2
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718200224; x=1718805024; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFYWkqrPwpmWXwb+4x3mhR3bmPCPe0lnYFyAxL0zKS8=;
        b=DMA+vXf4JBk7MnY0/58Ojsol2MyHyp7pWCE4GO3dNSbRXzopmTq3r40jJq8UT+mDgt
         Pv0OaqoMEaPeafn9Q+QgLw2UFWm0n81L06Aw6GrOZE+QDFYb5pJgSuVa7WzpE+3oRnIL
         H38O6wHbZJcH2J6m3QhaVVwbk75gI5628A3pfSdfWEmg6ynvP6zBQAoZRcLC0OVGqCjZ
         Exx5i5mqMrJs2BLfJgLEq61bNBHCDx05vjTsd1mZ5FXjOPEuqsOojs3tVXv/SzHiWnc3
         3ZsCAwkjGNw9gyBpupDSeSLjUOfD1utTXkFJexNgVdGIWRx0dKszoSZl+JVeI5/9BKDA
         XZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200224; x=1718805024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFYWkqrPwpmWXwb+4x3mhR3bmPCPe0lnYFyAxL0zKS8=;
        b=dIFhNS65vXsix+BNpyRFVC7QIHXTsvWoEdmPNgV7geFZ4HgE9Fz4k3Acl00AhcMYhX
         pT7Dev2CohvoKAXfmelXdurORS2V/Muz8LerZk1klma7muPsV34EYJQV+u3dPFZWdPIa
         tGX+17sVHgUerYLpn9EkAPgvCBqzppDOlDVLxuq2RnqSUiyttLbDm9iwNGXEShkanb+N
         zNAPErgSzj3OhDpv1E1UIykVug3UlYEexBNw7DRW8kmyqd4+0zMdw980FHAl9rbtxkOe
         +kIejhSVBImSH9PMof92CRN0tZif79cRjPzVS8IXwWBJ6NUiMBzFOsbRnFDVd7Pcxpb0
         Dqhg==
X-Forwarded-Encrypted: i=1; AJvYcCWEkX6usij1Im/FAC5Q+QaqjTEkI9gZJAL1rrqn7AWJ3fbLIwpeinDB6Yymz6RJp5ePTpXYST9qFBJmtq4KfWahhei9APOlX4xLluQG48v9b9Bkrl8kqf48JA==
X-Gm-Message-State: AOJu0YwVQEMTKWded+DMIcU6x4cxGhrK3CWCcsfY1BIwmaAcaJHm6H7e
	kFE80bNmGQV5ayFY40pu9ngcBFZWr/EHF2s76BtM79ERQLqbbz7xPOkCYeDVJUw=
X-Google-Smtp-Source: AGHT+IFqkOQ425CZ9HmV0W9cSIsAGs7sDRjX0/G/h21LJTdrIAx//TCFVCjqyP6rhlEYuwiQiSdwcw==
X-Received: by 2002:a05:6214:5d0e:b0:6b0:72ef:2877 with SMTP id 6a1803df08f44-6b1a7ad4ca7mr21677346d6.40.1718200223971;
        Wed, 12 Jun 2024 06:50:23 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b075e37080sm39031086d6.46.2024.06.12.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:50:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHOMn-0090iX-Nk;
	Wed, 12 Jun 2024 10:50:21 -0300
Date: Wed, 12 Jun 2024 10:50:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Message-ID: <20240612135021.GY791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
 <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240612131946.GT791043@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612131946.GT791043@ziepe.ca>

On Wed, Jun 12, 2024 at 10:19:46AM -0300, Jason Gunthorpe wrote:
> > > I prefer not to mess the definition of user API data and the kernel
> > > driver implementation. The kernel driver may change in the future, but
> > > the user API will remain stable for a long time.
> > 
> > sure it remains stable for reasonable reason. Here we defined some
> > fields but they are even not used and checked in the kernel. IMHO it
> > suggests redundant definition. If there is value to keep them, do we
> > need to at least verify them same as the completion record?
> 
> They are not here for the kernel, they are here for userspace.
> 
> A single HWPT and a single fault queue can be attached to multiple
> devices we need to return the dev_id so that userspace can know which
> device initiated the PRI. Same with PASID.
> 
> The only way we could remove them is if we are sure that no vIOMMU
> requires RID or PASID in the virtual fault queue PRI fault message.. I
> don't think that is true?
> 
> Cookie is not a replacement, cookie is an opaque value for the kernel
> to use to match a response to a request.

Oh I got this wrong, the above is the response, yeah we can ditch
everything but the cookie, and code right?

struct iommu_hwpt_page_response {
       __u32 cookie;
       __u32 code;
};

What is the workflow here? We expect the VMM will take the vIOMMU
response and match it to a request cookie for the kernel to complete?

Jason
