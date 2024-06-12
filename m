Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5E5178398
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197561; cv=none; b=m/7Zts7eGQ8k2rev/LVORk9gMHwTPGMOK/N+qHHa1YilU1SVX490Kji5ps3lJhYIBJfsDQef7lmF6OfpRI/s2cFsv5sALPgJ/R6ieiVlm4IBv1wEstwyk4GRynduXp8Tr/NwQisVuQnwcHIPCJatGtjFI9rivFWiHAGOgjZOK0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197561; c=relaxed/simple;
	bh=ZEtvmtKABe5cseBf1TQXddb/XlidEBvU7pk6GOUuaPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifUOVeSL11qdRObIKEnr98j743V9xrqf7f0Qc9zaaFfNSD0HuGrLnpN9Dd8Pjzsm6OsLCD8KCkVftWqknfY4AKBooN1nTr6v4l2zwLNH+YeJHh+0YAYfIYd8SB4jaGTx3ANLznnrMnxuAsmf23yWK7xJ6TSi6JELHR6N/5JkR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mskfZVad; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mskfZVad"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CFDD40164
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:06:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7J12nPKPKlI for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 13:05:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E958840162
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E958840162
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=mskfZVad
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E958840162
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:05:58 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-795502843ccso273470285a.1
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718197557; x=1718802357; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5+L89ZKqGUTpMf1suZvMFendyezHPKfwgJALrCf+rE=;
        b=mskfZVadnoKGD77FwmQXdoMAknWxedYhI4k0grRX1uohF1gJKGn4zubvN8JiqpMfUY
         I1fhsG2ALwSZaqnhRrw7ZZxEFUig9HvQ2tG7S91OA3KbhdaK1wWoIBglJkYVufjYF970
         eSyXhuEsYlMOHSpuT1KS6y/J5SUpUcX0dUUeQ/lO3iAYPxrFWqmjNaBO+QT8M3/6ZWKE
         HG8K8Lq4OIeqyV3Z78dVWQaFYSQatd2XY35pH/uhSlmzWVUd54dxGS7guV9FsHWEQWqS
         l5ND7rD1U/ML0ayLHClC8Hh36+GX7PITKMGsDxCCdwubahDAO3bFHEqjQQhq1Y/jWHj8
         MeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197557; x=1718802357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5+L89ZKqGUTpMf1suZvMFendyezHPKfwgJALrCf+rE=;
        b=W+eY4FssVhc9iM9BDq9c3ZEnquwlJ+Tjvfspz+G4zxGOpm8i2hAc0ytBS1YfPTR5z5
         rFE7LP9iIzrb3xLrwUA+VAFuqQuNU+HL9seu7UeLlA/pir3FFzeLx4T7+KuKHFvkAKKb
         spI7ecIZROdUIZWiNQty+6afZasOesNH81IuTaMBT5e6apFf9TCZtMpNCU9Y2Xmpd9HK
         xLqmeC7Xk1DQZIzDYIWeQGiwsUnbj2MM94KkIhdbONMRpQlYAA/0t32E8AVYZt+zSIQE
         ac910wO9EGkBv2z/ejb725AXSZ25tQ76YDCcSPwroCDs0dCiKsY/2B9czbMaX2CtLzQb
         z8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCURQ6VysqRaDdnODJ24ZStwe7sJ1keXu7zXbQhlNfvnIFC3ZP0RikJF94+Gvc1gyeBeLTRacKCQindrXNd65R6vATNBn6XlB/zNXXD9CkARg4iBN1e+Ck9eGg==
X-Gm-Message-State: AOJu0Yxegui5m22IGb7B5uaWmVEofv+84GONMn30xrOkzHD+/Esl3u4t
	ucjaixYoBzJXBP1r4ciUir6c1lDutAnPvk0IZkUUa1KEsd6KTraEL28ITRm74Ao=
X-Google-Smtp-Source: AGHT+IG1BTvMWtYF5LbHSWwvjvLFjW6jHuSKJ/rLzRBprtYaUFP9m1zLl5I+VkR+7lmlXV4LBkzoeA==
X-Received: by 2002:a05:620a:4155:b0:78f:a08:64fc with SMTP id af79cd13be357-797f6011308mr167864085a.30.1718197557266;
        Wed, 12 Jun 2024 06:05:57 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955973b340sm369859385a.4.2024.06.12.06.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:05:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNfm-008n9h-Pf;
	Wed, 12 Jun 2024 10:05:54 -0300
Date: Wed, 12 Jun 2024 10:05:54 -0300
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
Subject: Re: [PATCH v6 02/10] iommu: Remove sva handle list
Message-ID: <20240612130554.GR791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527658A85092F88329EB73E98CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <afaf133b-7175-467f-a254-060b66b9cb4e@linux.intel.com>
 <BN9PR11MB527693E470478D92564A31718CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527693E470478D92564A31718CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jun 07, 2024 at 09:35:23AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Thursday, June 6, 2024 2:07 PM
> > 
> > On 6/5/24 4:15 PM, Tian, Kevin wrote:
> > >> From: Lu Baolu <baolu.lu@linux.intel.com>
> > >> Sent: Monday, May 27, 2024 12:05 PM
> > >>
> > >> -	list_for_each_entry(handle, &mm->iommu_mm->sva_handles,
> > >> handle_item) {
> > >> -		if (handle->dev == dev) {
> > >> -			refcount_inc(&handle->users);
> > >> -			mutex_unlock(&iommu_sva_lock);
> > >> -			return handle;
> > >> -		}
> > >> +	/* A bond already exists, just take a reference`. */
> > >> +	attach_handle = iommu_attach_handle_get(group, iommu_mm-
> > >>> pasid, IOMMU_DOMAIN_SVA);
> > >> +	if (!IS_ERR(attach_handle)) {
> > >> +		handle = container_of(attach_handle, struct iommu_sva,
> > >> handle);
> > >> +		refcount_inc(&handle->users);
> > >> +		mutex_unlock(&iommu_sva_lock);
> > >> +		return handle;
> > >>   	}
> > >
> > > It's counter-intuitive to move forward when an error is returned.
> > >
> > > e.g. if it's -EBUSY indicating the pasid already used for another type then
> > > following attempts shouldn't been tried.

Yes, it looks like iommu_sva_bind_device() should fail with EBUSY if
the PASID is already in use and is not exactly the same SVA as being
asked for here.

It will eventually do this naturally when iommu_attach_device_pasid()
is called with an in-use PASID, but may as well do it here for
clarity.

Also, is there a missing test for the same mm too?

I'd maybe change iommu_attach_handle() to return NULL if there is no
handle and then write it like:

if (IS_ERR(attach_handle) && PTR_ERR(attach_handle) != -ENOENT) {
	ret = PTR_ERR(attach_handle);
	goto out_unlock;
}

if (!IS_ERR(attach_handle) && attach_handle->domain->mm == mm) {
   /* Can re-use the existing SVA attachment */
}

> > > Does it suggest that having the caller to always provide a handle
> > > makes more sense?

I was thinking no just to avoid memory allocation.. But how does the
caller not provide a handle? My original draft of this concept used an
XA_MARK to indicate if the xarray pointed to a handle or a domain

This seems to require the handle:

-	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
-	if (curr) {
-		ret = xa_err(curr) ? : -EBUSY;
+	ret = xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);

Confused.

> > I'm neutral on this since only sva bind and iopf path delivery currently
> > require an attach handle.
> 
> let's hear Jason's opinion.

At least iommu_attach_handle_get() should not return NULL if there is
no handle, it should return EBUSY as though it couldn't match the
type.

Jason
