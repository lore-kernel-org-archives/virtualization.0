Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66417B023
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545788; cv=none; b=C7e2Y/j+gJYPlyarTUlFGgy2jMI95YDONgPeyWG5uw5S+VDcux5s6aaQ6UzTsVbfz36JtLqiLwknfLkUIA0MMhx1c66MQLpvV/2IjSlu2lncRe/a+y/sowRZVCTcaVA3DjwactDRlkc8+d6ljsym6UNK49EBTRBMbWQZkNE1UoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545788; c=relaxed/simple;
	bh=U2yil5Qb35IaDxgZxylKOI0ns/g0yuIBAEJBs8zRkd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA08m3NUuwn1zkv5TBMiGImc9hNIUxzNQQG0vIaod8MPbpfADdU2eqA6XuzDmtZO81aKljcQ7+CDaIlsIrP27vvLqX49Y3D89niRy75MgzEAJkgjPs+sTgVlfWK14gPeQXKgmjcPmWJSMh55O+2OXxr0ri+EbMmUcGzCdsAjCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XU4Q6TZs; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XU4Q6TZs"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4D4E4132D
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 17:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3qwfP7q7aIkB for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Jul 2024 17:23:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6D90541318
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D90541318
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XU4Q6TZs
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D90541318
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 17:23:04 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-70365f905b6so1634718a34.0
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jul 2024 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720545783; x=1721150583; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inAts80JAO6fbZNUSLsGehHdbq06fgxJBKqzxxwcrbY=;
        b=XU4Q6TZsco6+xXTtMQjSyUh2cAYJxeFXc5frWMuawIjaHaDZ1/5GnI5JMHNxUvXSpu
         v7V3JIwpQk3NMp+fnHQEY80mmS2CknMB4JI/dsbwGRihKk5myYxRsrnv+afb6f7c6mAf
         zoMn41M/94u342x4Nv3fFqQJmuWI4JOrsoiGxcaMhJNG/IY/8MR7nx5CsvCeE74w84pj
         AJC1twh7tFxLBQVgap5+FMJATtAmzzQ0Umd4JLp8z/GdOFmWyGx9KdNfBz9py+rgGsUW
         tBpWM7ktCpubfFQb62/OaSyhArVfTEzuWEPkNgkOKzZfl0fcRZML6E3uGqRH8091U1VH
         PXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720545783; x=1721150583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inAts80JAO6fbZNUSLsGehHdbq06fgxJBKqzxxwcrbY=;
        b=KS705T2V9AWtLUOVYHv7IHq7Xk+zCZdaO7V89rZ+TkoElk37nSEQyzS6vytY/9dYQP
         gyuE0XZ6te+yGBmWS5woVfF4V1Bsk4Cx0hG7Y226A5sv6m2cw28FiTmW6RB2vaUXj/+R
         2GS76Pfsb/vMbOX1s+IAAMoNeXIMP3zoZqthTvCCUkQJJXEWwYcfzrlr5eVrFr17X/dt
         CokzWS26j+aT/bOw4VOFDoq+bmpE0q7uWoWI+XcOZtaDMsDvJ/mD0pSoMpYTXk7wRisG
         c5FLO7LF5vIhK4/k2RUXYMpoLrrp3G/o55IWDS4NiJa4VmxdXfju/mYDiMXIPO4fYmUJ
         kp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWENSnL1s6g/vYoAqF0FfsIgr8jAxQU1vq3X9DNrB6VpX0LRhbKJD3e3iWUiUJWRDb3UdPwJn7WMPa5ZlwbXUWRZa4sOvRUQk+0VaWIQ7JtEyqppGyxEPwA5w==
X-Gm-Message-State: AOJu0YxoZm/qwv/8+nwyFQ1y9QN3qcKipd/2Fs5LOOB125oQvzHXJmac
	vJTx2huI+U1hXEtEwQ4xPyq27rG/qoXgR3PTDdzd3wA6+Sso0RmwGmM9XTW1xKg=
X-Google-Smtp-Source: AGHT+IGVRFbVHaFI7Hg/zyr5X/JIozW5U5BQaYFUSCyCuMlqJhtXyislRKpp2oru18TCtv4Lx2o1lA==
X-Received: by 2002:a9d:3e19:0:b0:703:6ab8:1fe3 with SMTP id 46e09a7af769-70375a0547bmr3177744a34.15.1720545783587;
        Tue, 09 Jul 2024 10:23:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff80c7sm116481785a.3.2024.07.09.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:23:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sREYQ-002ipU-Hx;
	Tue, 09 Jul 2024 14:23:02 -0300
Date: Tue, 9 Jul 2024 14:23:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, catalin.marinas@arm.com,
	kernel-team@android.com, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20240709172302.GH14050@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <172009718026.360360.18220408964887632139.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172009718026.360360.18220408964887632139.b4-ty@kernel.org>

On Thu, Jul 04, 2024 at 03:18:57PM +0100, Will Deacon wrote:
> On Tue, 02 Jul 2024 14:34:34 +0800, Lu Baolu wrote:
> > This series implements the functionality of delivering IO page faults to
> > user space through the IOMMUFD framework. One feasible use case is the
> > nested translation. Nested translation is a hardware feature that
> > supports two-stage translation tables for IOMMU. The second-stage
> > translation table is managed by the host VMM, while the first-stage
> > translation table is owned by user space. This allows user space to
> > control the IOMMU mappings for its devices.
> 
> Applied first four to iommu (iommufd/attach-handles), thanks!
> 
> [01/10] iommu: Introduce domain attachment handle
>         https://git.kernel.org/iommu/c/14678219cf40
> [02/10] iommu: Remove sva handle list
>         https://git.kernel.org/iommu/c/3e7f57d1ef3f
> [03/10] iommu: Add attach handle to struct iopf_group
>         https://git.kernel.org/iommu/c/06cdcc32d657
> [04/10] iommu: Extend domain attach group with handle support
>         https://git.kernel.org/iommu/c/8519e689834a
> 
> Jason -- feel free to use this branch as a base on which you can take
> the iommufd parts.

Done, the whole series is in iommufd for-next

Thanks,
Jason
