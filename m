Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95F6FCC
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623510; cv=none; b=cOlBWk2IJ8sIHX/zJaDGDn6GtZsMLRmCoOu0auDrD9ezRyE1+0BOix79x2KvM2G23s6sNkjNbrWGrX67VqRPqj62pJXQXsbq0H757i5cX/KvNj2ck3jXfHa1nN19WN4KUur6W7enjMwol2V4I1CmA3MOUeQgmJy8Jlmt5CIKz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623510; c=relaxed/simple;
	bh=NmWmB8xJkdpQ6+qsRZ3yNW+0DCBVDLk7Mf7CANqDZmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0dM/oMifsu1qQuu4yzpXMgc83+82nACCeePLZGav1ZRLYkhyQ9uIqSkjhbJvivvf4xhiL+1Kp7EjNJBEghWCjqWgvIdJg1RKvojf7zfoUWwgHbnyzH6TN1x7XOYtZn5KyKbc9LemitsAZS1xT8KJJrF9HjwJOgdP1liXOWF0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JI5dMffU; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JI5dMffU"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02BF760646
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.508
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mKklKCrnaAdF for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jun 2024 01:11:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::12e; helo=mail-il1-x12e.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F1BF860636
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1BF860636
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JI5dMffU
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1BF860636
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:47 +0000 (UTC)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-376266a65c8so4993065ab.3
        for <virtualization@lists.linux-foundation.org>; Fri, 28 Jun 2024 18:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623507; x=1720228307; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EBVtd4lNh6ldbTw81Bxi6NFxymecp4v8R1CgV33/re8=;
        b=JI5dMffU5LC7loewRKSgTHx7oqZpcC9BedZ9Twx7ssgWrBBezTLXVUlQXJasXXrCd3
         eiHQxhxEM9CYIqL9Gh9fXdrjhdzKqth1gPje8OVezv6S8kq1pl7bJ9GHpayzxcGJiJeV
         m5vAtFi+bsAd0LEyqcZpkMLvg2CHtH91gTAE53l5y6FyQRWuY/ygmrj0e/2wLXI1iPE8
         ZGWE7+Qbo5u1m7xglf82GkQoQKmlyr93MQ6OFdc5tITAWV1ebzTC2R+Zw7v8u+1mKbTt
         JkH1VfFR6dM8H1XXcImadjVWSu2xOmLOHCilqHYHafpT62C0PP4W6giEyaQAXOtJRu2j
         dMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623507; x=1720228307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBVtd4lNh6ldbTw81Bxi6NFxymecp4v8R1CgV33/re8=;
        b=TW5Jt+X8Xw1U+6F55aD+UNZbzR827Fr7z8kmcYCzeyZ+4kzg/M1R0qA05g1PKXFzQm
         oPML/g9CXVkv5ye0N4nB8NbWP9PZ6BKQT44mcivSJe8jGL8qbHNUw7TK4xlTRn5/d8Pr
         m84yWe+ge2JXc2QNcoZrFDdo7aJPdY7yubW6ITNSo5obPV2yHzA5gnZrYGdq1rgBCq29
         2NdaTItWAfVJzyj03QyePJ4Wk1iJOE3h128yjZomzQ9Erms0bDDH4b8ZBQEgAT0f06+/
         F7vweWVRf0M9Nus+TIBr2Nzrcjr8Q0WLDD0z0Va6sD1L3rW4sYQbx9EuhDQDFlZYBCl1
         93Bw==
X-Forwarded-Encrypted: i=1; AJvYcCU2xZSTpgxdTAhzbNKEo5JqURF/aEiF37t+xgl+sQtmUC1ePLkVPl41q+yuxlfY1Z9XlUzm4hDvMc5maUgTbIECTOkzmcSYrmqP5WYhvYcD5Q8tBogrElPZsA==
X-Gm-Message-State: AOJu0YyoQCtOWCdVJxh1Kygty280ylGIXrLqkfNRfYx3Ls8B+zF5W6XU
	QO7NyJopVdgGb/RP7eeRIPh5BR7fah+S4xgoBAJRKpQPrOLBwS4tWuc6Q1XnKOU=
X-Google-Smtp-Source: AGHT+IE4QgUFrWMp+tH+7fcsNM5wNf5R+mcyUObJCqnJg+lJpDagM/8QA1d89wQbwLfqFUo7RgzINQ==
X-Received: by 2002:a05:6e02:20e2:b0:377:14a7:fc99 with SMTP id e9e14a558f8ab-37714a7ff6bmr145245465ab.24.1719623506847;
        Fri, 28 Jun 2024 18:11:46 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:45 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNInD-0004RY-K3;
	Fri, 28 Jun 2024 18:06:03 -0300
Date: Fri, 28 Jun 2024 18:06:03 -0300
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
Subject: Re: [PATCH v7 04/10] iommu: Extend domain attach group with handle
 support
Message-ID: <Zn8luxc+RLBOIIX0@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-5-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:49PM +0800, Lu Baolu wrote:

> +int iommu_replace_group_handle(struct iommu_group *group,
> +			       struct iommu_domain *new_domain,
> +			       struct iommu_attach_handle *handle)
> +{
> +	struct iommu_domain *old_domain = group->domain;
> +	void *curr;
> +	int ret;
> +
> +	if (!new_domain)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +	ret = __iommu_group_set_domain(group, new_domain);
> +	if (ret)
> +		goto err_unlock;
> +	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
> +	if (handle) {
> +		curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> +		if (xa_err(curr)) {
> +			ret = xa_err(curr);
> +			goto err_restore;

But this error unwind doesn't work because the xa_erase() already
happened and there may have been a handle there that we don't put
back.

Something like this - store to a reserved entry cannot fail:

int iommu_replace_group_handle(struct iommu_group *group,
			       struct iommu_domain *new_domain,
			       struct iommu_attach_handle *handle)
{
	void *curr;
	int ret;

	if (!new_domain)
		return -EINVAL;

	mutex_lock(&group->mutex);
	if (handle) {
		ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID,
				 GFP_KERNEL);
		if (ret)
			goto err_unlock;
	}

	ret = __iommu_group_set_domain(group, new_domain);
	if (ret)
		goto err_release;

	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle,
			GFP_KERNEL);
	WARN_ON(xa_is_err(curr));

	mutex_unlock(&group->mutex);

	return 0;
err_release:
	xa_release(&group->pasid_array, IOMMU_NO_PASID);
err_unlock:
	mutex_unlock(&group->mutex);
	return ret;
}

Jason
