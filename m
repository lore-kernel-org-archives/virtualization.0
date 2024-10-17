Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764821DED4F
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170494; cv=none; b=Ff3Iquxj/4aWxxGP0pUyyb7zPGsuSjKF5kmQeDrxBSYfguH24sTSqfOU0RzwrU5eqB65DAXqJZiBVxswqLna+mwrsiK/28XScxmwPxN+riQpNN+Wzhjuq1FrDFuycse8SEGNmLO58ZSCD7a8u7NlrPLTXlDgVa3bns7Mr4rdRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170494; c=relaxed/simple;
	bh=MCRIxE9GhA2NAkXdzXaszALYW7VA4HLq5f6MBrAaTKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlvIpTJo8ogZJqX7ouBNcKM+7e+//wmHRJowLC3lUkx1Kvxu4KCryZaNCR2ZqhGib9L9dSFiPM1fVkY4CVPfM5w7RhIGCNNLG9mk6gZL/j7zHhwVmnv7/rdQnlhT322Y6A2AhbkklH6gu9d1ZseTfz4t/95pSjngbv7fBPBWsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lYrV18LY; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lYrV18LY"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED180608B4
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 13:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b4vOOiFrPH82 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Oct 2024 13:08:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3CBC660671
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CBC660671
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=lYrV18LY
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3CBC660671
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 13:08:08 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4608e389407so12233361cf.2
        for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729170487; x=1729775287; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wq3teVnFjCQljMHeJKswAqz9sY5geo+xNzpep4xNz44=;
        b=lYrV18LY9VthTVO4c2fNoKD7x/uKk5c7+hhqUfCJqLBp2DVIFLm0ttkY2iGsUP+NI8
         4qnAc3SQIUtkrkdh/KKArf3jK0wRnU5k8rqqoN+E4G4fuFQv2Ob7uidMRHH1MAf+Xroq
         iVXa/+EvvYdkxtr7fp1fwzll+/DVDR8CAWZJsqaS5Uqqdi6Xl6E12KeW4WkcVTPcfWxg
         MAIYLOW8xWlFyepjSB2On/wPIidJRGr7/NZ+c3GnxcqkrMIaeXBQdNUThRL4luIMXN+n
         Z3DG+qPkRxNXXPIeRHAuWaxJ9kF376xAeqbhgqOPNQu687UvlaAZl4wLWY4SO1D7KYC/
         tQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729170487; x=1729775287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq3teVnFjCQljMHeJKswAqz9sY5geo+xNzpep4xNz44=;
        b=rrZFSpyhZsPKMSsss3uYT5z1YvwlQOlEYhP5FaQVsApzY/hfF5bKokJz0BM3Vg2Nmx
         48jY20dZ6tUwvvOtr3rfuEybMWtR9hFiBVxlgJigYloMvIgNuMYl9/gFC+ZUi6YyxF7l
         u0af2CY4YPf3IBlyW5evdMjK1mZxgnD2cwiBZGETQR4lVHUCFD+mE2V3eJbHg0ZzrH4n
         N+qSfXf5oj/qlRG62wjWY4Ik/iK+DTdZENac5HoA80R6ROmkOyRSYnRNg5Uc57540ZhF
         frHYTpmG2FQdCqGC1dKnTEx+bDJrKxq4NSOdRde10/yUwwwIR1Ff+KxsKWDZtPuRXASV
         SRhw==
X-Forwarded-Encrypted: i=1; AJvYcCVWuD+81+XVWPFdKFCvIzjGsSLeQv0gZcrH3cmhs8Ch/NE8ZfaeGvnTVBBiCwq0F1UK52cSagEiFXcTq5KicQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwBply0YL5hwx4jkTJ/FndsxvIlZ/vDvvhU8Hi4ELisSlsVzsPM
	MGDjyzFdGU0dH4VAaJ1NbqvNebgTt/SN7x5eatHihgRhYQFWSdEPZEN4zhZgTJA=
X-Google-Smtp-Source: AGHT+IFIWL+tda1Up3Uym74uSu9HXo+USovi7zkNskhvncDpsDguxTD9i3KfGBRjr2fW7WKmWz8dEg==
X-Received: by 2002:a05:6214:460f:b0:6cb:d558:6f00 with SMTP id 6a1803df08f44-6cc2b8dc70emr135440876d6.29.1729170486776;
        Thu, 17 Oct 2024 06:08:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2299043dsm28134646d6.136.2024.10.17.06.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:08:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1QEX-003tKN-T4;
	Thu, 17 Oct 2024 10:08:05 -0300
Date: Thu, 17 Oct 2024 10:08:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241017130805.GA926121@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca>
 <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>

On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:

> Yes, you are right
>  I am using SRIOV vf and stall feature, so is_virtfn == true
> 
> Our ACC devices are fake pci endpoint devices which supports stall,
> And they also supports sriov
> 
> So I have to ignore the limitation.

I see, so that is more complicated. 

Lu, what do you think about also checking if the PCI function has PRI
? If not PRI assume the fault is special and doesn't follow PRI rules?

Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
fault?

Jason
