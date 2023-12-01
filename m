Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1B4A9AC
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FXCKzb5d"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5884A42138
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 15:25:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5884A42138
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FXCKzb5d
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4t4V3IBPT4e3
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Dec 2023 15:25:01 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 83ADC42124
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 15:25:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83ADC42124
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77d895c298eso115642385a.3
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Dec 2023 07:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701444300; x=1702049100; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NIctRRSn0vwGQpdvNDPNBUzRbr3mcV06BO064VqiQvE=;
        b=FXCKzb5dVonBXn6maA46xgrXD+k5kK9xc9qyNm7RJZcQ020JU0N9b9EYBp2Pl2tks4
         bVgasT2trAoNrJKn6VaeF8a97USl03hUqzx2/vk/XJaEfD3b6kcrSTZJYGxmpFctrOOe
         zHfMMwXkimfvUX9PBou8vu9Tfv5myZ5IZh9RgDaXUjsTEOwTw4UHa5Cu+AgG4ZzhXfTd
         fPSu2hOJKQt5Oj28giwGMfXqJ73NesYEkgiCYHjQBW4Ao0sNYFf0zzdCC8PnUAkW6uI5
         KPwc1bhkE7FF0+CxowLPOeLXxAjE1w57bCtmFSA7GOorWGi1QAaSblvhsYbgq9DWwNGP
         GVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444300; x=1702049100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIctRRSn0vwGQpdvNDPNBUzRbr3mcV06BO064VqiQvE=;
        b=Ix1OqQPwi97kzwLV3ErKEyLjea/RFfCTk1v8pcNE7zwjzfRSkRFiEJCVbRdsA5uCVe
         45g5nAL495ysZwuJ3WUVFMDw1g5X3FuHrE7TIuIigYKrkWECkP2/Avd+3948wug3CLRq
         jzL/LlCbcU1+jxaCZ/dSN3pFAj+nYGTrtI/8ETaUSpVI2LCLkLwmQ6EV5ulDIzLlTBaO
         n3tvaHPlggDJuzT9XKtOdYZZjz3hMpLSwjtXddALoMt5oFxtlJNEyWD3ixyvVW9TBWXu
         TUf/owt6jpkadAvePNHW7M7aSdEpENjrDGbkfBLSKeAFv9EkwPTIueGJ0N8C+Dvb/QrT
         OXTg==
X-Gm-Message-State: AOJu0Yx2pyPaYoK+gVPGz89XXMEDL3JN4/nmPc/DojauRu5A55i5xaRT
	817PMjMhH3v268gR6RB6N3fnyA==
X-Google-Smtp-Source: AGHT+IH9aQsdojUrYLvHxO5KK9009RG0u9DrfU1zkCcGPgQMNQH05O1B5rZ99KIPwto9uIZJVs6JwQ==
X-Received: by 2002:a05:620a:6507:b0:76d:aa3b:ac9c with SMTP id qb7-20020a05620a650700b0076daa3bac9cmr30406177qkn.46.1701444300373;
        Fri, 01 Dec 2023 07:25:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id n17-20020a05620a295100b007676f3859fasm1572386qkp.30.2023.12.01.07.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:24:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r95Nz-006G1Y-DA;
	Fri, 01 Dec 2023 11:24:59 -0400
Date: Fri, 1 Dec 2023 11:24:59 -0400
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
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20231201152459.GB1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-5-baolu.lu@linux.intel.com>

On Thu, Oct 26, 2023 at 10:49:28AM +0800, Lu Baolu wrote:

> +static ssize_t hwpt_fault_fops_write(struct file *filep,
> +				     const char __user *buf,
> +				     size_t count, loff_t *ppos)
> +{
> +	size_t response_size = sizeof(struct iommu_hwpt_page_response);
> +	struct hw_pgtable_fault *fault = filep->private_data;
> +	struct iommu_hwpt_page_response response;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iopf_group *iter, *group;
> +	struct iommufd_device *idev;
> +	size_t done = 0;
> +	int rc = 0;
> +
> +	if (*ppos || count % response_size)
> +		return -ESPIPE;
> +
> +	mutex_lock(&fault->mutex);
> +	while (!list_empty(&fault->response) && count > done) {
> +		rc = copy_from_user(&response, buf + done, response_size);
> +		if (rc)
> +			break;
> +
> +		/* Get the device that this response targets at. */
> +		idev = container_of(iommufd_get_object(fault->ictx,
> +						       response.dev_id,
> +						       IOMMUFD_OBJ_DEVICE),
> +				    struct iommufd_device, obj);
> +		if (IS_ERR(idev)) {
> +			rc = PTR_ERR(idev);
> +			break;
> +		}

See here it might be better to have a per-fd list of outstanding
faults per-fd and then the cookie would just index that list, then you
get everything in one shot instead of having to do a xarray looking
and then a linear list search

> +static const struct file_operations hwpt_fault_fops = {
> +	.owner		= THIS_MODULE,
> +	.read		= hwpt_fault_fops_read,
> +	.write		= hwpt_fault_fops_write,
> +};

nonseekable_open() behavior should be integrated into this

> +static int hw_pagetable_get_fault_fd(struct hw_pgtable_fault *fault)
> +{
> +	struct file *filep;
> +	int fdno;
> +
> +	fdno = get_unused_fd_flags(O_CLOEXEC);
> +	if (fdno < 0)
> +		return fdno;
> +
> +	filep = anon_inode_getfile("[iommufd-pgfault]", &hwpt_fault_fops,
> +				   fault, O_RDWR);
> +	if (IS_ERR(filep)) {
> +		put_unused_fd(fdno);
> +		return PTR_ERR(filep);
> +	}
> +
> +	fd_install(fdno, filep);
> +	fault->fault_file = filep;
> +	fault->fault_fd = fdno;

fd_install must be the very last thing before returning success from a
system call because we cannot undo it.

There are other failure paths before here and the final return

Jason
