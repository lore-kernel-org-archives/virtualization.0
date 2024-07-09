Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289B51B86D0
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544444; cv=none; b=ni/pwUggpAo94l0wQ28huaftXJPYeZUV5Xdq1FrcqRW5vDKw+QrokG/r5dKSiHcIiXOmzNig0fDrpF0c5oMG7i8B2jILlPB2R/HVV2GqRT2Jpnah1zwTas221sbeDzCY6wXySyquNiYk9YbqNXcZwaNPpOoN0sVuzsYsuDL8x50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544444; c=relaxed/simple;
	bh=JgrYzVA7jCxQEkWilrTpq8hpV6Gml8vxozEpNZ2BRzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wdwu9jT992tJZgJwdnEDb9scZHhJyjZArLBiqkQTJ2DJen4v0VGFr7lPsM2owIeNj5KMkPmyC+jne/1iqPg9GB8UgLLBsNVq5/udddBWM9FsL3R84x1NkkcAnM/OO4RNJNPzc7zpWY2GK6kPrnX46qVL70osrLrRrNr2o9SzWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lMZAoj3m; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lMZAoj3m"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A61E760830
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 17:00:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fR_bw_jqfGSy for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Jul 2024 17:00:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f30; helo=mail-qv1-xf30.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9FADA607EC
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9FADA607EC
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=lMZAoj3m
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9FADA607EC
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 17:00:41 +0000 (UTC)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6b5f3348f05so23668316d6.0
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jul 2024 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720544440; x=1721149240; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aoKh6CbSkvE5uLHVYrlgWMx47IaolAIb/KMsl791ino=;
        b=lMZAoj3mpu5HcJJivw0jDWusKrlYVvK5/nL8fR4pZ3ikEfK5JM5lV8JWEbDFDN4MQ6
         nHDIkA6VBx7I0Ut8ZY1XIjeN8eD7MbTE5j3Vg5s+B/F0zZOCDz6nbrV1mpWsFKNqWGoj
         wZilE2Pcx1RhBgo5rb1ehDQz2pVXmWBlOgJM8Yaw/gvsm+0kAykBOMs9tnWhIt+NpuU0
         6Jw3l31we9P2YSfpywm+kDCcN8kE6qBAh3gm4Tnn7eoabSxxHMoocaEm14/hjMfr0uxX
         992OtXoGxhMsSezSA23LCnUBqd0blQ1svlvAuGKQsQL4xZ7X2BpRGMPEZb6IbPemvAqL
         xQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720544440; x=1721149240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoKh6CbSkvE5uLHVYrlgWMx47IaolAIb/KMsl791ino=;
        b=NGcrbyrkPRQo+95E/q8L7PZe12Wu3jI02AYkRi3qrosthOMr+rkT2k9pWbyinCf/ey
         NI21WgtOr8yJwLE6pF6mZYT2H+BAU+7ir7QJsWk3uS5PrTuJtB3IJJTfTCAHPiMKS3Wp
         4gW4oQ3+M4gsZ+fWu7I7qAhGHtKE0ePHI34x7vUnHFMVIa66UjBhGax0RSBoLQvjEJ7t
         cQ5JDPPOe+djNa/DGpZCgIVXNMiiscBDf25x3ADUp06ado287ynNsBNdKuDTZfrZyss6
         //EzNcYfUrupHpE4O6UzqGvrkIXmI4tuNnc3eZdL69YOuNlc2tDdzZe0DtO/FWaDLak+
         4ayg==
X-Forwarded-Encrypted: i=1; AJvYcCVOWm82/6/8GYLqCb40vELd/tPlgdDi2xLqY/nGLnqotLFBeHkEtwQCimIXTViPDaIrDYFBcbcOrw8b2o8oBrbEVwjGVYD/Xje3ejGOEGqEvRw/kjD2NurobQ==
X-Gm-Message-State: AOJu0YzhCuWW18ytSpJg1b5GNF8PEZ3yMLobs+ZUMMDKz77ktEX7r6yY
	Ew+5btaUTys4F5EdycBuDS7XKXf1IEVU4k/pHkHbxO4CJsw0GaQQ2QdiZqMMjcA=
X-Google-Smtp-Source: AGHT+IHQAqJ8Fss5qEp93E1gpLOGUNuxyAoBEmzUnNgYypyxw8q6HqRIgm5hrD+KkbzXQKOzZkmpdA==
X-Received: by 2002:a05:6214:21e9:b0:6b4:7910:2b60 with SMTP id 6a1803df08f44-6b61bc7f032mr32420906d6.6.1720544439969;
        Tue, 09 Jul 2024 10:00:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b59dfbsm12153401cf.52.2024.07.09.10.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:00:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRECk-002WM4-Ao;
	Tue, 09 Jul 2024 14:00:38 -0300
Date: Tue, 9 Jul 2024 14:00:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <20240709170038.GG14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <20240708162957.GB14050@ziepe.ca>
 <ZowxyUQAcqDJ4yZ6@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZowxyUQAcqDJ4yZ6@Asurada-Nvidia>

On Mon, Jul 08, 2024 at 11:36:57AM -0700, Nicolin Chen wrote:
> Maybe something like this?
> 
> struct iommu_viommu_event_arm_smmuv3 {
> 	u64 evt[4];
> };
> 
> struct iommu_viommu_event_tegra241_cmdqv {
> 	u64 vcmdq_err_map[2];
> };
> 
> enum iommu_event_type {
> 	IOMMM_HWPT_EVENT_TYPE_IOPF,
> 	IOMMU_VIOMMU_EVENT_TYPE_SMMUv3,
> 	IOMMU_VIOMMU_EVENT_TYPE_TEGRA241_CMDQV,
> };
> 
> struct iommu_event_alloc {
> 	__u32 size;
> 	__u32 flags;
> 	__u32 out_event_id;
> 	__u32 out_event_fd;
> 	__u32 type;
> 	__u32 _reserved;
> };
> 
> It can be "report" if you prefer.

Yeah, something like that makes sense to me. The other question is if
you want to multiplex the SMMUv3 and CMDQV on the same FD?

Or multiplex physical smmus on the same FD.

We are potentially talking about 5-10 physical smmus and 2-3 FDs per
physical? Does that scare anyone?

Jason
