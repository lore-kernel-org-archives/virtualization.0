Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2033E477
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DHD0hG5W"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4F734039D
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 14:38:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4F734039D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=DHD0hG5W
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yjZi6acisiVz
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Dec 2023 14:38:12 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9154B40158
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 14:38:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9154B40158
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-777754138bdso110949485a.1
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Dec 2023 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701441491; x=1702046291; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXr7TXa/tMpuDEqpeATCPHGX6v9H50ZNaBHg4Hp0sUA=;
        b=DHD0hG5WzOG3IKk5y+hatWUIEkLHfU0Oyg66qsoshqiO0eFLygoMUWOQxKpT8UHVb+
         /GbhanTNAexAFxr4BaVGKAGbGg6RyT4TrJ/e95rt7HcJaMLwA2hbC2bWreXAoGPowWD1
         4mZtTUU+KFM5lGBpJB6X77Ya21RmLiVmOTjtXogRVXlJ3gkoFpMfDZOxIqf3WaclmTJY
         PLVyprzdaCQzVGn6V93c9rXizBZAP1oSOF2A9XXjaPdMFmzFdLDcsmbTbzNDewUupORC
         gYvMLQtAVZThb2UFo6TbB++6Lw/ig/k7kpgIHIlam4aZUdbLimZd2pWunDn2U4CR8V6y
         nn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441491; x=1702046291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXr7TXa/tMpuDEqpeATCPHGX6v9H50ZNaBHg4Hp0sUA=;
        b=rwI3mpkRfj7QeIpdGZdnd0aojNipnP0JvF9RwLIFnfPHeb0hD01H2e8n1JNvjFOzpR
         PtQkElDfbkhDgr9xkGnq/yIqIPZOiXzeEE7rQ8yFAGvO59Zj/1XhTcdqnMef0+9ERfGW
         KSxhNH+tBnyA68O9sbiwpW5LnEq5Zxl2fVb19F6sm7XOTf68Cki1tnRsmdA19pJDUq8E
         Ktaqqxhnhw9Lpt4HVm5jWNnMJOTxBqZz/DFyZOFWDFv2PaNgVvz2ES8zYza3VKZiTdqL
         WKiACcH8v7xNfB44Sxw4k8M1jV5uxi2qMqKHPFgrALz5Vaqj2TqtQoSeuVOX8qM7hzFQ
         Ni0A==
X-Gm-Message-State: AOJu0YwFy0s0LB8N3YFoGACxOE0ECapHCuS3i0l3mQmQ9rNkPw8DdWQx
	yQeDMb3si17wo0mOkhJR5cz99A==
X-Google-Smtp-Source: AGHT+IFe8E0VqRO1AEaToLaRVQzH95JILmWc2UsaE9FahWhPD0VYJtmSp9BHS2kePetr70qtmP4TFw==
X-Received: by 2002:a05:620a:c0d:b0:778:ba89:2fbd with SMTP id l13-20020a05620a0c0d00b00778ba892fbdmr22271407qki.36.1701441491386;
        Fri, 01 Dec 2023 06:38:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a110100b0077dd463da60sm1533049qkk.126.2023.12.01.06.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:38:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r94eg-006FYA-Dl;
	Fri, 01 Dec 2023 10:38:10 -0400
Date: Fri, 1 Dec 2023 10:38:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iommu: Add iommu page fault cookie helpers
Message-ID: <20231201143810.GK1394392@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-2-baolu.lu@linux.intel.com>

On Thu, Oct 26, 2023 at 10:49:25AM +0800, Lu Baolu wrote:

> +void *iopf_pasid_cookie_get(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
> +	void *curr;
> +
> +	if (!iopf_param)
> +		return ERR_PTR(-ENODEV);
> +
> +	xa_lock(&iopf_param->pasid_cookie);
> +	curr = xa_load(&iopf_param->pasid_cookie, pasid);
> +	xa_unlock(&iopf_param->pasid_cookie);

No need for this locking, the caller has to provide some kind of
locking to protect the returned pointer.

I'm not sure how this can work really..

What iommfd wants is to increment the device object refcount under
this xa_lock.

I'm not sure this is the right arrangement: Basically you want to
have a cookie per domain attachment for iopf domains that is forwarded
to the handler.

So maybe this entire thing is not quite right, instead of having a
generic iopf attached to the domain the iopf should be supplied at
domain attach time? Something like:

iommu_domain_attach_iopf(struct iommu_domain *, struct device *,
                         ioasid_t pasid, struct iopf *, void *cookie);

The per-attach cookie would be passed to the iopf function
automatically by the infrastructure.

Detach would have the necessary locking to ensure that no handler is
running across detach

Then the cookie is logically placed in the API and properly protected
with natural locking we already need.

Jason
