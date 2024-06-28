Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4C8C04
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623511; cv=none; b=qa6gqVUrAVccVquXdph0IS2dPNYGlvtw5vUBMwfud8vuxFLImWvRUGmfJA9PiJYW9O/aGiSfsnoqP10DJAYdy5VSmEtxwxs0HzjeKkb9qQDM/cddlLxPfnG8GTOFEyAeqBDTnO7JC8qXBkJzps+Xm5AARFWLBkXtWXepXQ/Y/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623511; c=relaxed/simple;
	bh=0qHl+0DqNRpvSKTfp02INWgx8IbLG3jiIbFjAdPVnaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATowG1Puh87Xxc2h9P7sqifairhsq9D7P2KIDZBVyktYOaz4NBduZs1l8ZL7nrIoWpw1XwKrV82SEvhyo5iP9gSPLz02CSMOxf8UZhdUpN7RtZ+Oc+Lz0+x8vkQfk1gHH80l8ggXok+L2Zvb9dH4DFcUhnmIqoCG7wyz65fAeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G3xcjhmJ; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G3xcjhmJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86BC184647
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.508
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2XgVYTHgLaD5 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jun 2024 01:11:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C77C184644
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C77C184644
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=G3xcjhmJ
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C77C184644
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 01:11:48 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-70aa5243449so250534b3a.0
        for <virtualization@lists.linux-foundation.org>; Fri, 28 Jun 2024 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623508; x=1720228308; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhWMM+W00ZGyNJkSp9eBep0aP7iOumSA6mBp+eSCZ4g=;
        b=G3xcjhmJXsCKk4hhAg3WmxvkzNsIIPT8gNCn8Oa48PFXWjYiagIZqQ48FQR+mUNCgJ
         /dlqACqoW+vcYFGyecfPksqS8MU2hD+8GuqP/8fhHiwtvOxth88AK8wSTbHtoy8VdXnQ
         8bJlnn0X7Z4r3CGnm2oGDmpS/bD46k8BGACafK3ChIetPCjoBvjM7y+5MjlCM4+aLfvV
         1EmOdZjwP18AxcETM0BaTZ+sVMvzpKGwHBtneGwRyd/0n+VzDULcuqI54PbPSGCGMnA2
         UnwlOKBONh6citGW1Gv4MROzg35bpo0wG3YX8U4w1d/DkuFYgclUgaFbG5iexVxoFgh6
         GCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623508; x=1720228308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhWMM+W00ZGyNJkSp9eBep0aP7iOumSA6mBp+eSCZ4g=;
        b=TdD6YFDm2cdnVXD7Fe7y8AMwe37XmcRbaYokBr9uWkVh7bMXp0V2SE4OWTDVnL0yX5
         cqY+chIA6cKzjFq52MfwYn0wBehPnRrcc0AK9FqCHrYxbHkm/d/ERJrEQcQJwcmWM8Vo
         5sMAl2fwMkjT18nI9l5HDe7+R38WPnQrbR6uWzx6074mcqzuqRprTd7c+qWI0v2VesPL
         JioGsWoiCI8W87GG0s2byfscVcKnko2iwPhiLeE/i08zOVOFZAmMVwaW3hAR7bj9yPv1
         KebYpUcLukDtkZX3yhhXt9Rr3d7muy5nOCsX9vFBi/61wY1d4dLZMuoUDzB09ghPrhqn
         tzfw==
X-Forwarded-Encrypted: i=1; AJvYcCXzU6wFwNLNUoo90Or/xxDs4mJW+fyXhXNx9b92Zjr9+UpWYoo2xXWorQGdJIlH8qxGC7x8BiUsesc0Fx7NljTAt36VM7jkrutWZZHlbWV6FdJ0eEXgm5mByQ==
X-Gm-Message-State: AOJu0YxEYJh8L/JRmuwKuHbl1TIz7hSUbnkVihD8zSojc1obvR3JWQy1
	VjWFR3H8PGA+imfJgxnhlwlCzLkWVJDJLxsdKhhqOsbSfCwcXP7EdAa7iMfH4ic=
X-Google-Smtp-Source: AGHT+IFV8W1dqzQexTf6L4R/t2BuL68I/iJC437XoQYe9jmo2sb2vcOp8E1T0SgaT9dJjMWIhEFnUw==
X-Received: by 2002:a05:6a00:9283:b0:705:d805:2168 with SMTP id d2e1a72fcca58-706745beb1fmr26156318b3a.10.1719623507953;
        Fri, 28 Jun 2024 18:11:47 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:47 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNIyF-0004Uj-H8;
	Fri, 28 Jun 2024 18:17:27 -0300
Date: Fri, 28 Jun 2024 18:17:27 -0300
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
Subject: Re: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <Zn8oZ80p0p1bHgBC@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-8-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:52PM +0800, Lu Baolu wrote:
> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> +{
> +	struct device *dev = idev->dev;
> +	int ret;
> +
> +	/*
> +	 * Once we turn on PCI/PRI support for VF, the response failure code
> +	 * should not be forwarded to the hardware due to PRI being a shared
> +	 * resource between PF and VFs. There is no coordination for this
> +	 * shared capability. This waits for a vPRI reset to recover.
> +	 */
> +	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> +		return -EINVAL;

I don't quite get this remark, isn't not supporting PRI on VFs kind of
useless? What is the story here?

Jason
