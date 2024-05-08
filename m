Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24057B666
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127088; cv=none; b=atVxNTAjGtPK1SkpYRoHYWKF/isauJVWTQp6ebIYznSftBpA9CjNGH5fl5aggsrVx43kjnl6rqHN1DRthdstgMIKfz/Dn3YdzPiuISBTvpZdxVxcwJwZxbpxwCcpxzwrTRg27zDSoVRlSqsDAbYlJn+ehmaNz41p+dTR2mmN4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127088; c=relaxed/simple;
	bh=uBM6JM2ZTgWImlBMh9qZnnFVCD7oJnWjagsz3xFxGHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoTrLOThaNEq3q3JQop8sMokOEQ62PWXAAMqhjiAVkQlwpqTWTRazSEpewkWEiGj/PaXPKzoIqRSSAGTBrCSshxaVGzG+bvX89i5uKxLbZM0RD/StYZCLSrMQRjPSdxedLh6lDIYKZMR9rbfdzkfxO7otHCWI9xH2w1JeAsUsrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZZmMcINF; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZZmMcINF"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE72540276
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:11:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wc2uZdir25wy for <virtualization@lists.linux-foundation.org>;
 Wed,  8 May 2024 00:11:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 94C98401F9
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94C98401F9
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ZZmMcINF
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 94C98401F9
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:11:23 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3c6f785208dso395933b6e.1
        for <virtualization@lists.linux-foundation.org>; Tue, 07 May 2024 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715127083; x=1715731883; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjfjkkVg/cpW+PObSNC5kJwblm845FpifEdrDmGUGho=;
        b=ZZmMcINF9V4wTCIpWZYxSxAgluawrVJ2BZonVgI4E68yX/FA0OKnTnoR7M7uHyTREc
         BnbFKDzTRIC9RcK/1wicXNSC1GFO/eP90rqbsQLo/n06o6iuxXZnt6vyC0GIb6t0Xz7a
         zH04vPljM+zYcalQkxyO2iWXPo2m3r13RM5kXEHtvtd+0RNsBWJZpW42u68oiaF1tBwJ
         A7NJS01FZuCmQqhnXzNd85wRSZ0FvOAdBIPK6dImINEbavvxV2BDOuEDz/EdRyc+V/l9
         Vzs5kI5qCxX1Ed1l0rKkmB5lHZLFuWZ1q00f3wN6LnXL+sm0aYoSV3zYgpzLGxX4qm86
         D1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127083; x=1715731883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjfjkkVg/cpW+PObSNC5kJwblm845FpifEdrDmGUGho=;
        b=AD41JVrW24Z6BBbH6CAaVyGvqregxEUQ3ZjGDaEMLujXo18KxdFpzxHGJ58/5UZgyy
         TyPA2rTfZml23RPedMQxw4+b3t13ZRByK7XVVAT5GmMUqWmIjYwtNNfPBHxJaLudbdwH
         aWEYNeimIJnzFXVImtcnWL8M56icM//r+5GwxM5lhWgs9iPzsdXzupUrMxetkHX4NQe7
         LvPZQCOMOFd2/GtdgeprjWD+CBG2cLJpTO+zHlUaEDSACjDElyeLxtJuGt6XmzgCW2WM
         JVBZ5WTdLZyngNCICRCV7QvFhFI0ApQgOLL8kF3DzVMQhIkFFlhW8DR8/iKqO+jUBw2d
         VrwA==
X-Forwarded-Encrypted: i=1; AJvYcCVuL/eTAWKHmjam35f3qS/m0/VcbmVHuu6SoyJGsDcef6HKqxl4mAKTuUHhoCrnz+QUhrgiNbD+/rSv/fARm+KKECRKtgvWE0Yi7mWZaZ5r0HYEW4MJ9TApOA==
X-Gm-Message-State: AOJu0YwkuQpJeT1MTJMtfZwqWCphOZ5Gb11xkH1tXbMvi7rd0EbJrDRL
	99TCaCQZJrrXpqpQAB0DGyVFgaNROVytBgN2POsjt2138RNN+quRIEf6zqeiz6s=
X-Google-Smtp-Source: AGHT+IG3+7w7f2p3irDmhGGNwkdvL9xcGar5FA005YCMCjPsSm14lX0tCqyBYbPWhopBlbU40pavfg==
X-Received: by 2002:a05:6808:30a6:b0:3c9:7717:713a with SMTP id 5614622812f47-3c9852fa4e6mr1310067b6e.38.1715127082991;
        Tue, 07 May 2024 17:11:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id f14-20020a0cf7ce000000b006a0e5626f67sm5081832qvo.50.2024.05.07.17.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:11:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Uu1-0004QL-RV;
	Tue, 07 May 2024 21:11:21 -0300
Date: Tue, 7 May 2024 21:11:21 -0300
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
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
Message-ID: <20240508001121.GN4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-6-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:06PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index ae65e0b85d69..1a0450a83bd0 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -36,6 +36,10 @@ struct iommu_attach_handle {
>  			struct device	*dev;
>  			refcount_t	users;
>  		};
> +		/* attach data for IOMMUFD */
> +		struct {
> +			void		*idev;
> +		};

We can use a proper type here, just forward declare it.

But this sequence in the other patch:

+       ret = iommu_attach_group(hwpt->domain, idev->igroup->group);
+       if (ret) {
+               iommufd_fault_iopf_disable(idev);
+               return ret;
+       }
+
+       handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+       handle->idev = idev;

Is why I was imagining the caller would allocate, because now we have
the issue that a fault capable domain was installed into the IOMMU
before it's handle could be fully setup, so we have a race where a
fault could come in right between those things. Then what happens?
I suppose we can retry the fault and by the time it comes back the
race should resolve. A bit ugly I suppose.

> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 83b45dce94a4..1819b28e9e6b 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -50,6 +50,7 @@ enum {
>  	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
>  	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
>  	IOMMUFD_CMD_HWPT_INVALIDATE,
> +	IOMMUFD_CMD_FAULT_ALLOC,
>  };

I think I'd call this a CMD_FAULT_QUEUE_ALLOC - does that make sense?

Jason
