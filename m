Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C61EB42
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aF8AVfHR"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4572341DC3
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 13:58:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4572341DC3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aF8AVfHR
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R7xipKHISms2
	for <virtualization@lists.linux-foundation.org>;
	Wed, 15 Nov 2023 13:58:08 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A425416D0
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 13:58:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A425416D0
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-42135f8e08fso42787631cf.1
        for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 05:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700056687; x=1700661487; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KL+XKeTm+HS5yIv1+qB2Kl+EdYaEuM6uxRpozUNk15w=;
        b=aF8AVfHRKFkmfF5QU08xYq0G4ljQwR0WzxtnDdHwghbxGcfCeA51IYMSK2C91P9YPT
         +gNtAyUOGTCUQNRrZpoABYvm0INVjK5zoO1mfnB4xo5oZd16KR/VvW5f3G8wdYTi6Lmw
         By6wlQNxEsaf3NZstQAzYjy4CrjSjpxXNVRxrOEXDeVZrjci8oAP9GoKY24/TLEknwk/
         piYsdkuI1uZ1RvIpcK2OMSmeKnkl+NF9nuBCU6DAajqcRho8Krtn4vGDKA5CKb3SN47m
         7c5tB0Mut0AoHWQhHJdg0R8Z17F2GpxvT5H+SKZPZfZKqklJnlkqgF7t8vBxXA8yctg+
         epuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700056687; x=1700661487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL+XKeTm+HS5yIv1+qB2Kl+EdYaEuM6uxRpozUNk15w=;
        b=BxsgbW69b8X0dMt59lNy8m7rHLSpyDGdtB+++CUdnDeKS0y9kJkvpcN9sGR5WcaFf7
         5sIIGSAwcHfqaGlZrVC06W+fAzjCS6RRD0H4DAjSJUsRsoCtLsZAONgnAJQoXpxnuaFE
         7M0+cmONgvyiDzVG/Fk0gsx8LppCR6Z018TIzv7xu91wy6WXcst1KDPJ6nHieQezO1fJ
         J0tVotMhkN0QSlJZqhJzjWYw5h1NSzSqGEXN+K0Vft+UWJ9pCHcP9OwDr0lUiH5APFv2
         htb2ND97HdX5TiaxsrqUf+OqC1Q5BuY5NqjtEeW489ykPAtZGXCEsMZ9ZT3eTkC6It3f
         Js0A==
X-Gm-Message-State: AOJu0YwtNNBYU+mO45rYlNdtix0KSD17NZ4VOdSwmhWXcBfsotTq4FMq
	UIBeYPRkO4j1/SPopAW43pVNEg==
X-Google-Smtp-Source: AGHT+IHaKxJpp001exVovZ4EBDqBHs310q9gAHegSv6c6n8XW7Wb8GybvCcKXWJGvY9i5/iI45wjWw==
X-Received: by 2002:ac8:5dd4:0:b0:421:f8d8:e0d8 with SMTP id e20-20020ac85dd4000000b00421f8d8e0d8mr1428187qtx.38.1700056687165;
        Wed, 15 Nov 2023 05:58:07 -0800 (PST)
Received: from ziepe.ca ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id d22-20020ac86696000000b0041818df8a0dsm3553547qtp.36.2023.11.15.05.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:58:06 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r3GP8-0007bi-2i;
	Wed, 15 Nov 2023 09:58:06 -0400
Date: Wed, 15 Nov 2023 09:58:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZVTObiybC1MYlSam@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <c774e157-9b47-4fb8-80dd-37441c69b43d@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c774e157-9b47-4fb8-80dd-37441c69b43d@linux.intel.com>

On Wed, Nov 15, 2023 at 01:17:06PM +0800, Liu, Jing2 wrote:

> This is the right way to approach it,
> 
>    I learned that there was discussion about using io_uring to get the
>    page fault without
> 
>    eventfd notification in [1], and I am new at io_uring and studying the
>    man page of
> 
>    liburing, but there're questions in my mind on how can QEMU get the
>    coming page fault
> 
>    with a good performance.
> 
>    Since both QEMU and Kernel don't know when comes faults, after QEMU
>    submits one
> 
>    read task to io_uring, we want kernel pending until fault comes. While
>    based on
> 
>    hwpt_fault_fops_read() in [patch v2 4/6], it just returns 0 since
>    there's now no fault,
> 
>    thus this round of read completes to CQ but it's not what we want. So
>    I'm wondering
> 
>    how kernel pending on the read until fault comes. Does fops callback
>    need special work to

Implement a fops with poll support that triggers when a new event is
pushed and everything will be fine. There are many examples in the
kernel. The ones in the mlx5 vfio driver spring to mind as a scheme I
recently looked at.

Jason
