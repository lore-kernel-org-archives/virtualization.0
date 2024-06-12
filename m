Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32517D377
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200347; cv=none; b=fVtHp4IR/3Iyt9GqOw+V7j6IUIX61a0dNUcm3Y61I8UX+m7jHj9XywzfuN1NsDyVnjeHjFZd/yb7qhcSDIki7ncWhrsMO7q/qTjx7bQguggfA1K9CpoYz41af+T9F0QCybWWIaCOMIBUhw7Kn9ki8p9Cl/rww1ynUBSzPx64ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200347; c=relaxed/simple;
	bh=Oo7eKQ/vuiKK57nzWHRwBZAQcLEcZwfz+apajKIxjpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq0b8CgURoSRXxDtnn2fWiYJkp5SD1wj3WhIbjRUhQam5wMLNKkeDu2tuuFygPp3zg6uAEzNDGmK9cP37Vtbe/OWISWQQSqeVLK+/2kTd+S12LgB7RSDHfBsPDPFULJwc5bJun6G3b4nNrVBnZVjlSSrdZ1kO/8CIDZjx01slLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V497sMK1; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V497sMK1"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA03A404E8
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o-1IdfqNH8vq for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 13:52:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b2f; helo=mail-yb1-xb2f.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org ED4D5404D9
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED4D5404D9
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=V497sMK1
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED4D5404D9
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:52:22 +0000 (UTC)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-df771b6cf71so7056219276.2
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718200342; x=1718805142; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n4yFXPH48K7YremfXbvI5F9w5geLcApF+zrC9idLOg0=;
        b=V497sMK12hY+fTF3JDn/gNo2SXkOrBLJVzpGXMzHu8gfIXW4+THUpnd2zlXGN3ihSL
         Ay1brFDvh0Hq7V+FZn1UBc3OQf2ektBCuO7Y8DUcvt8Y9e0P47N4GUHhNSRAznBscW6Z
         K9Cmt8HrcPW7x7ek78UuGpK2+CnKL0kQTDZKgC/duZeIuWRsH5Zhov9/f/Eqn16+H5j4
         Gta6sM5NbAKRdMdjTWFm68WUoontuvjd1KbocRvF2+pecoj+K3VNHjh5arThieH469yR
         9VgREA3rWmASUUpC0zg3ecV4jHhxXiINjwq6/3w9Jp2o61b/oA5CnD/uM1ovjzyVF1Cd
         z2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200342; x=1718805142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4yFXPH48K7YremfXbvI5F9w5geLcApF+zrC9idLOg0=;
        b=iTna4U8kSlslc61f1q2IvxeUWQnpwmtGp4uC3ZynKdJm7EgCMGqbdlRILQwc+o711h
         3QOdjoq/mNG4dNbH0qWVGdyITT1djZFDZB9MsZDldO2vdsu+I1y/cEV7K3dXVW1INHqm
         EzhYEC6stoL6QSaJWt2ceUwtdDmlgSK4686R9WywiitmCNfsMOf3n5X2ZKsFaeM6JexS
         cp8nOiom5GhBKyE+LjIdoQoR0padDdGXvG98ebJXgPwHB4t937UdWl7/0zclkRK8vzaQ
         gJjIIVufrgJHpNySgy3Z1XTwM4xmPc+HmbKJKMBuZv3HPruIF/kbTiMmzZfqqy8Ssl9l
         RHSg==
X-Forwarded-Encrypted: i=1; AJvYcCUJlO4PxBhfOw1g9ShOXNDJtvObU4DowdqeTQmgiRIP1oB7HTsOLxGfIK5mutIiezigdCcj4Gvjgpw6gfpMqYhDifXB1mVeBCJZ24bvsjSDKZZLkxTl6Fc1Lg==
X-Gm-Message-State: AOJu0YzT6D+n0Yzzi6rtQGBxqMHXxy90j3V9TXdlCA3xlP/BIUpIKmUV
	UtcRCrkVsbOyAtAgalcoUmlrKo27+abNil9BPFyi9OvrAdU0d2x+sJxf9f2R0cc=
X-Google-Smtp-Source: AGHT+IG5MsAGFlJNLCZBYHd/CyREyJszvbTdf4kNLXCsh8V0bZu+GJ7j2/lX4r8ZXtpS+8b1yVkNJQ==
X-Received: by 2002:a25:ac14:0:b0:dfe:388e:2987 with SMTP id 3f1490d57ef6-dfe694f0e9amr1659594276.64.1718200341645;
        Wed, 12 Jun 2024 06:52:21 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b08dafd095sm16499226d6.130.2024.06.12.06.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:52:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHOOh-0091GZ-F3;
	Wed, 12 Jun 2024 10:52:19 -0300
Date: Wed, 12 Jun 2024 10:52:19 -0300
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
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Message-ID: <20240612135219.GZ791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527040517.38561-6-baolu.lu@linux.intel.com>

On Mon, May 27, 2024 at 12:05:12PM +0800, Lu Baolu wrote:
> +/**
> + * struct iommu_hwpt_pgfault - iommu page fault data
> + * @size: sizeof(struct iommu_hwpt_pgfault)
> + * @flags: Combination of enum iommu_hwpt_pgfault_flags
> + * @dev_id: id of the originated device
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @perm: Combination of enum iommu_hwpt_pgfault_perm
> + * @addr: Fault address
> + * @length: a hint of how much data the requestor is expecting to fetch. For
> + *          example, if the PRI initiator knows it is going to do a 10MB
> + *          transfer, it could fill in 10MB and the OS could pre-fault in
> + *          10MB of IOVA. It's default to 0 if there's no such hint.
> + * @cookie: kernel-managed cookie identifying a group of fault messages. The
> + *          cookie number encoded in the last page fault of the group should
> + *          be echoed back in the response message.
> + */
> +struct iommu_hwpt_pgfault {
> +	__u32 size;

Given we fail the system call if size is not exactly the right value
we should probably drop it here.

The ioctl to get the FD can someday specify the format of the fault
messages if we need to upgrade. If we want to change it down the road
then the old FD will be exactly as it is now, and the user will
request a new format FD that only works in whatever the new way is.

Jason
