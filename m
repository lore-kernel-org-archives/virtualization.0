Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F1383
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127912; cv=none; b=iu71/GbOAXJy9yHo0WheH58u9s3kgbxIriU0K1NJuQMWN3yKH0dPuTBZdghySegEIPfJELPWPCSIEh6g3IxcwEFBwVrsPjAc7JsN32ODKauQzPWbD5hLCr3aB2acaX1G8h3wiYNR7yfhngpgRrFlRr8NpVpnPMBkQHwc6lyY/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127912; c=relaxed/simple;
	bh=lwJncAe+bf7pRUOxcV0HmRnNwUlF2rdTBkMOBrZ2rk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPxltriGXx0/w9JtXdiRRR+uZKDyAi9ar0uUutB8fQgKhWYvpT60IsJx/6NY4lJAT9ykfNr2ZZKyNhi9FlHGjDiJL8X7C6WhqCJMmBZQk7G9OhwHm/QG5fmwrP7hEQ/7o41x8qI2+1p2ryXmRw1fS262Xh2lz2exNjQEnp1fjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C4uyhgbF; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C4uyhgbF"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E4D240709
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:25:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5J36N6_pGU5C for <virtualization@lists.linux-foundation.org>;
 Wed,  8 May 2024 00:25:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3BF02404E8
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BF02404E8
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=C4uyhgbF
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BF02404E8
	for <virtualization@lists.linux-foundation.org>; Wed,  8 May 2024 00:25:10 +0000 (UTC)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-43a317135a5so2156271cf.0
        for <virtualization@lists.linux-foundation.org>; Tue, 07 May 2024 17:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715127909; x=1715732709; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62oVLAkCTGDCTLLKSqh+lJU6r7gjh1o4XBhOsw5N1rI=;
        b=C4uyhgbF1s2hAEM3W1+F3q53GijNPu5EPje6BMepTCrVURvaMSpUoudw2C6qgf4vfM
         ibAotCQXcL0LTlbON7+0BBo91sZs7Vy9RJAPsEXrWaNcAF8SPOvPsAoSMUd92NBDyIGA
         MpVDjEw5zyEW1VXzl0DQnj5j9MOqNQc1598A8hbuQh+a4QrcganwXEnwyFN8Dk9dqfvQ
         cSuwOJ1sf8EFim7Ifijs7uCsq3qnOM8ki11OmQfwvjUK7c8lredAJjhtfydVReDPkxw3
         rc2cqrzaLRfUbXZ2fTmVJbFuM/VxDr0b5Kifoz3lLoA8YNGuaK0gR2gHZ/nbRdvBv71W
         GAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127909; x=1715732709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62oVLAkCTGDCTLLKSqh+lJU6r7gjh1o4XBhOsw5N1rI=;
        b=G2TaX0k9Padg+vneQrEGJ+6zXmlPkM7exAJ7sLV518cqTm2mLQ+MDNYJR/nCYwgevM
         hkMfWYuBXxFbwxzuRymOf85oYUJdlVjH+e7AqHOwh8ywad57Yo1ly5zel5yXtOHPXA6Z
         BYMzwscRowo9EbgZKXDd2a3Tv/ZYHGeE7j4LhMA3lH5L7lmEYTr4g1YT3Sh2rtf11CFF
         EJuUPTrnObcoZPh/4aey+0QA097Jpszcu3RodyZgJwKp3KA26VADa5XaWziWM/jrJj8y
         omL/+/p5DFoLr/h/YLI7cSjvDqmg0rJSj5ygHUWwrMGVt6yX9D6FntOZ6yijKxWa2bdj
         PmrA==
X-Forwarded-Encrypted: i=1; AJvYcCUiZ8SBhzZ73KNQMxNGx3ezTWQcU+Qm44wl9NOGwIfdPnc1nUzqAJQaxoS9Y1BcWbfnF2h0XrqC6dzlQIDgRU9XAJ/+5NlLWR1w7sQCwCycm805F6sux8s+FQ==
X-Gm-Message-State: AOJu0YxAWlHd+SeDVEVjlVsv+s/4xVDMZUf2b2TaT5UiWUcBEACncftM
	L30G7lub38oH3WnBi6HZW7Y58HewfmpAwmodBKDEIpS3lMLv2XbG7Iy3kaEzZGU=
X-Google-Smtp-Source: AGHT+IFTxEBXk6pFTSfXuSIuCjv+y/O+PL/HIbz5Je8O0KKZUh3tsAMV/ImOlBAPfnNJTqCSHSBJgg==
X-Received: by 2002:ac8:5e54:0:b0:439:b456:25b6 with SMTP id d75a77b69052e-43d8f7cbbe6mr61262901cf.30.1715127908960;
        Tue, 07 May 2024 17:25:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id hx1-20020a05622a668100b004364d940d3dsm6840475qtb.96.2024.05.07.17.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:25:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4V7M-0005JK-22;
	Tue, 07 May 2024 21:25:08 -0300
Date: Tue, 7 May 2024 21:25:08 -0300
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
Subject: Re: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240508002508.GQ4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-8-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:08PM +0800, Lu Baolu wrote:
>  /**
> @@ -412,6 +415,9 @@ enum iommu_hwpt_data_type {
>   * @data_type: One of enum iommu_hwpt_data_type
>   * @data_len: Length of the type specific data
>   * @data_uptr: User pointer to the type specific data
> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
> + * @__reserved2: Padding to 64-bit alignment. Must be 0.
>   *
>   * Explicitly allocate a hardware page table object. This is the same object
>   * type that is returned by iommufd_device_attach() and represents the
> @@ -442,6 +448,8 @@ struct iommu_hwpt_alloc {
>  	__u32 data_type;
>  	__u32 data_len;
>  	__aligned_u64 data_uptr;
> +	__u32 fault_id;
> +	__u32 __reserved2;
>  };
>  #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)

[..]

> @@ -359,7 +359,7 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
>  		 __reserved),
>  	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
> -		 __reserved),
> +		 __reserved2),

This is now how the back compat mechanism works. The value here is the
absolute minimum size, it should never increase. The first __reserved
is always the right value.

If you change it then old userspace that doesn't include the fault_id
will stop working.

Jason
