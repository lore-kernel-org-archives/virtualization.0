Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812C364B8
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919972; cv=none; b=VYEgYk5i4c6JYpAulOvl7i3iWEl87A6sCVuJA9AelPi8wvGmgeJr7H6pZpQjRYYyw4leC05GDyssyRm5SPWhJegnxxaoNtU0NFzuGZU8ymu7JMjmGqsoN3bxBJ5FCCClBLVgNG1DguHsIy1zns/yMH36I5UT9Aq32lZvdLoq+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919972; c=relaxed/simple;
	bh=rK08lC8h70tM+jBp3b7B85bfPjBarpj/C+Yd2hRo22M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLP6B18wb4EgjXsLQx78/BEX3zeh1ToXRQlk/Afiai7Lj9XKeo5q6pW4FKQejtNXiVI9xLhKxcHqazsYbFqCvEmPF8YENtJk2DwDLy2P5Tp0LL1X/l6+iq0iA6U06bKR/BGBAil9g0wK2XV25it0IGO+thkcrutf1+1ki4IewJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hMbZH04V; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hMbZH04V"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47A5741E14
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 17:46:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ck4OSD5uZTKL
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Mar 2024 17:46:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7AB1541E0F
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7AB1541E0F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hMbZH04V
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7AB1541E0F
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 17:46:08 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3c1e80e447dso1034861b6e.0
        for <virtualization@lists.linux-foundation.org>; Fri, 08 Mar 2024 09:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709919967; x=1710524767; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZYf0KQeywWJjZBtMXb+CC74/7IAx0iyjAYpGhr4CHk=;
        b=hMbZH04VlVji3qOpr8mvVdoxB5QmPWaLelmyaQxIxdYhgJ8GaVyZAfTswZkqsZW9rk
         xYjZf+x8QGljhUbW79NJlIJy9Oi5SxbWrUSWvk6kqzBeYKQraUEdFutqdHKeo1zqbcSv
         /iHRoc/7YxkSv1n4YbGff826pr/QKY5HtjJDE5fkMSnOvZ+BxSEZ4zIjlCLqTQb2sDuO
         BM1s7evoY0oEpFJHkhRmvMPo5uCof0luUP3LIH9nTy/6SBDe10Ya36R9eR4hIAcXLOm6
         DCuruy52T1dwgQ0HwxTawL6Saj4RX1WlFHXqgKdXs2UqxzPv3RJGQyscBRoXXxxpwm01
         8JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919967; x=1710524767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZYf0KQeywWJjZBtMXb+CC74/7IAx0iyjAYpGhr4CHk=;
        b=KxTd1yFotVTuLB9cOKgsonrkyLZvuHRrp0rlHmrkGw37cPBiy7rfPxZyBQi22uU23j
         +9BUq4CLWxrmeaWoKwY/DoOoGSGc4XiH0sdoh4+Ieuq09EYFaaSpXNpDCMvb9KE2sKGF
         VFb4oBn5+oAZo3qfBmU6sjiaHMxSUVKlKk8xvPWt6CMl6Aj/AH/mfPzlgM1Xxv6YlUHf
         LGJBaafSAsuT8606+xfedKkf/Ctta98VdvHcmbS+2QTGA94ZzhE9rDwUde63Oo5pwvX1
         czewjJ8WbwoSt6+8sre28AnjSGjOXAk+UjReMOVf7UqsOm25iAmXS36HkPN7bG+/z4mZ
         /kow==
X-Forwarded-Encrypted: i=1; AJvYcCW3Vi1/oPv2mfAaWraKz5Nz4GpPqR9cXSb898zDGdYmokB3ftJlhrkNI8KBQcVrEqPYLH+l81Essn9sGsAd+/E46dlX28czp3DQgIpLbWvqBvxUlL5/ERv5tg==
X-Gm-Message-State: AOJu0Yykj0ntFy/NyI9XDA9nWWRAluHVZZXxasrBZZ9ndjHBEGBnGx+l
	pyh12NvCDKxH9b6e/Cmw5friVG6mMmdz9ZYvbr7uCBjxMhDXAjhC8mXuXr67rcY=
X-Google-Smtp-Source: AGHT+IG/7S0/bhrT9Ch0XEq+I93hxTOeDTQg4sBqPyBXTbTrJFkEN75WabLyNMNzEVIsrKpv74Bpcg==
X-Received: by 2002:a05:6808:23d4:b0:3c2:34b4:2b05 with SMTP id bq20-20020a05680823d400b003c234b42b05mr1861100oib.25.1709919967381;
        Fri, 08 Mar 2024 09:46:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0568081a0100b003c1e577140asm1940100oib.25.2024.03.08.09.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:46:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rieIH-007YP8-Qj;
	Fri, 08 Mar 2024 13:46:05 -0400
Date: Fri, 8 Mar 2024 13:46:05 -0400
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
Subject: Re: [PATCH v3 2/8] iommu/sva: Use iopf domain attach/detach interface
Message-ID: <20240308174605.GV9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122073903.24406-3-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 03:38:57PM +0800, Lu Baolu wrote:
> @@ -215,7 +202,23 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
>  		group = abort_group;
>  	}
>  
> +	cookie = iopf_pasid_cookie_get(iopf_param->dev, pasid);
> +	if (!cookie && pasid != IOMMU_NO_PASID)
> +		cookie = iopf_pasid_cookie_get(iopf_param->dev, IOMMU_NO_PASID);
> +	if (IS_ERR(cookie) || !cookie) {
> +		/*
> +		 * The PASID of this device was not attached by an I/O-capable
> +		 * domain. Ask the caller to abort handling of this fault.
> +		 * Otherwise, the reference count will be switched to the new
> +		 * iopf group and will be released in iopf_free_group().
> +		 */
> +		kfree(group);
> +		group = abort_group;
> +		cookie = NULL;
> +	}

If this is the main point of the cookie mechansim - why not just have
a refcount inside the domain itself?

I'm really having a hard time making sense of this cookie thing, we
have a lifetime issue on the domain pointer, why is adding another
structure the answer?

I see we also need to stick a pointer in the domain for iommufd to get
back to the hwpt, but that doesn't seem to need such a big system to
accomplish - just add a void *. It would make sense for the domain to
have some optional pointer to a struct for all the fault related data
that becomes allocated when a PRI domain is created..

Also, I thought we'd basically said that domain detatch is supposed to
flush any open PRIs before returning, what happened to that as a
solution to the lifetime problem?

Regardless I think we should split this into two series - improve the PRI
lifetime model for domains and then put iommufd on top of it..

Jason
