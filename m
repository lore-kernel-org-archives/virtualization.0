Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1301EBA0B
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996869; cv=none; b=BNi0+m3NIf3kHRWrJLryoUpnSuLwR6xENu8PlKQUKSUFpxx1KVQtJA1hKsXRr+mKZT1c75GiDcz9kbMEepASdaVb2EMnU5PxxrncYIEB+T6JgWjWIqM4fQpY5GqKbW7hB8MZ+q00BT68PwgLUcsdw9B7ccrTFPu4h2NCKk9nfLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996869; c=relaxed/simple;
	bh=i4IXolkJjiswk2VvQqrP3XoASrWnqInKJYEPGAho1LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjsXYpn0FJtlqTASaTA/9/hEj6azBZnH3ndIV52DBIwXT+FnaqnvWDyjZb/1RlkJwFpbQpVJ+C9hYDnoBDSA47Jrk4zceeIQJAcxsqupmzJeLZaC63KvsG0N0K9CW8ffo3gHV7eNyWo1ZEE+wSRvFWMMWcza3EzO25LijLDL4lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nkrJrRFl; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nkrJrRFl"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7AB9440450
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 12:54:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A1hJic0zsEnv for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Oct 2024 12:54:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 075CF4042A
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 075CF4042A
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nkrJrRFl
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 075CF4042A
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 12:54:23 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7b1363c7977so60525685a.1
        for <virtualization@lists.linux-foundation.org>; Tue, 15 Oct 2024 05:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728996862; x=1729601662; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GXrdlSFMUk7+CH9DKGI8Zx5IfrY4LnBclgt58OvS+5w=;
        b=nkrJrRFlqMHQoWd2SqTVmLG4niUPiVXdG88diCCGIkaE94uMYz01R4BClHqMY5RKJW
         gNlpfwKxuHjOoHu+/T/gREmw0E7F120fLrd/ftc1h5MHdgF0wgll7/1hBqkiOuL2ue1Q
         qMhnoKlrqcRY9IWBFlGddp93oq1Jwcy4Amm5f2FKkFYMMz6/9J9eQBTnVZpvAM2kQj40
         JNYEtx1HsGjIOfwgqxirqqeKO5oFG4jIjli7G9I/CHxKc2r5gIYZKZykzhlkC6B6j0X4
         /YFLGRSDP6q5dSfJ+jy4ZFdeHvqBXFWMHp7i/6LvggTsvrZVDnnlWmURl/5U/lvTy9j7
         Wb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996862; x=1729601662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXrdlSFMUk7+CH9DKGI8Zx5IfrY4LnBclgt58OvS+5w=;
        b=XxD5GLj+ZSq+fGeGIcn8PrmNuAAJZaGEJh9ST2uAcfffXnopN8P6+iHx1pM0UWBqvN
         KPvdkfuVgs41Zba4dYetxIbLhmbtpw4Q6LKWnHV1uKMeTD0trPkWrsm4ktqNar/hZ9GE
         CAFckGl6puqmIPTUSgRlOkVFcuw3Ra1Uj21qtiQgd1ciOGc56b2Lu+NM+lHS3kP+8EEr
         ArtJHJBs+VTans42vTSLy+HKqYN6jhaiRedTm2rn6gQzrHFg8qVMaN8T13MJhecnLKDO
         RU2bbCr/+iwh3UDx1e+2M6kyIQDQyHfl1gHQY+Wuc5gAtTLXsfKFf7v78rEEyybIC4Sp
         JgmA==
X-Forwarded-Encrypted: i=1; AJvYcCUoT7UT21i3Cx66NKmdPLmRYon0mVYNb6wJdKlWqrdot+Nk4OA6A4nQzu6/71uwNqtJUQOM+a3cCIpHC3wdSA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwCHomrev493D80M+F4icHtDCf+uDoyoqJOqpqIrCXy3zfiVS03
	/ToHDOiwrX7wjfaorPs7X5fNF/MJ5ZshQORxm6o82fZeiFBQmjT13ihBH4kKog8=
X-Google-Smtp-Source: AGHT+IEY7UaOsHtqws8kw4oYjkjQT/STsmKzQC1Y7WlXbDI4yfdqKavj7rrCgoa2GhsXIWLphKj2jg==
X-Received: by 2002:a05:620a:1a03:b0:7a9:bf33:c174 with SMTP id af79cd13be357-7b1417cac1amr47266685a.16.1728996861913;
        Tue, 15 Oct 2024 05:54:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136167139sm68208785a.26.2024.10.15.05.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:54:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0h48-00D49x-If;
	Tue, 15 Oct 2024 09:54:20 -0300
Date: Tue, 15 Oct 2024 09:54:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241015125420.GK1825128@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>

On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > +{
> > +       struct device *dev = idev->dev;
> > +       int ret;
> > +
> > +       /*
> > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > +        * should not be forwarded to the hardware due to PRI being a shared
> > +        * resource between PF and VFs. There is no coordination for this
> > +        * shared capability. This waits for a vPRI reset to recover.
> > +        */
> > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > +               return -EINVAL;
> 
> I am using the SMMUv3 stall feature, and need to forward this to hardware,
> And now I am hacking to comment this check.
> Any suggestions?

Are you using PCI SRIOV and stall together?

> > +       mutex_lock(&idev->iopf_lock);
> > +       /* Device iopf has already been on. */
> > +       if (++idev->iopf_enabled > 1) {
> > +               mutex_unlock(&idev->iopf_lock);
> > +               return 0;
> > +       }
> > +
> > +       ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
> > +       if (ret)
> > +               --idev->iopf_enabled;
> > +       mutex_unlock(&idev->iopf_lock);
> 
> Also iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_SVA); is required
> In thinking how to add it properly.

FEAT_SVA needs to be deleted, not added too.

smmu-v3 needs some more fixing to move that
arm_smmu_master_enable_sva() logic into domain attachment.

Jason
