Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9DB7E0E8
	for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768088693; cv=none; b=Xy7QLXDXPJ8xnu/gW050EhgU2kz9AdwxITn2agX9vwaq+u1p9vfp/ODcikrEu7ODEZrg/CWNI8ED/zfU4+PKAjbXN0FFzI4Q3fmuv8RjfsoLe/swjBez0iCGu8Kim30PR+TpSPXPeyVZz6caHmDN9sGtNwEUfJ3FsHUw3UIaFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768088693; c=relaxed/simple;
	bh=0hlf1EwjX8n89d+KRv9w/Zg1vh2Xb1fqWAUVd6PX608=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fqs01CF2h61Q/KXCIuGQyBLRKWsyIlMaR+ITJr8jsXjkirlRAJsxDeGgHMg+QjWnBKvIzptDi7xwAw3wyugxEtOSxQDC+5vtyXltVQvltPw5cDuySyRaiUr5Pve5agT1SDQyFXhrNc35rWVtIcr0WtgnQ8Qwd7HzZxzE119loH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehYhFCYb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehYhFCYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768088691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0NZhG5CFt1ybfdmia3vmiDdp4otmf8/CdWQnIGdtkyg=;
	b=ehYhFCYbzn6NQai3bTI03BukoRnmx3GQrIvwUWOcYgkgtClT8OX6JBC4kG9Fdn7SRqYge7
	tdIIoLrO9a3SWNCYpJy9RXdZtSqT3JVuB4dtbSlNhXXPZJhkGgswtmU6GFjtgAFUVTQBx1
	V1KeIdyunX8V4njz9xH3BGQSf+rju60=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-cpFjumjqPJ6p-OUpsW7xfw-1; Sat, 10 Jan 2026 18:44:47 -0500
X-MC-Unique: cpFjumjqPJ6p-OUpsW7xfw-1
X-Mimecast-MFC-AGG-ID: cpFjumjqPJ6p-OUpsW7xfw_1768088686
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47788165c97so30062105e9.0
        for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 15:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768088686; x=1768693486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NZhG5CFt1ybfdmia3vmiDdp4otmf8/CdWQnIGdtkyg=;
        b=D4XCs4rrayOzX3trU837UqM68f36mewEXLoyr681nGF2lGiytiPwEFE7s2nxUNZOT5
         08gxiLd4qhRTI6txPT+PzwuOjMuw/vhoElr5mCDw5OPpYyfoVmsH2m2106mh8ee+0RcS
         8x6y9rW/9hT2HCiYij95jl9okajMCrtwC89SYVt4JMqFIy7Og8P6vSYuvJthvK/UR6Zh
         /PU4tHKDjNiUGCY4+Zv0Hk5ehyrIfKy2pIBdrhR51GVjw3Q/Gnyw5Uw5M4ZqLGIh68qt
         VQNtS/2XhrsmyFJl8V6fIzdlTrmSqNzYElkr6jvlHAT83icXuXXEjcxL3E7cMx49gGGY
         QiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhXNxifU9U3F8zCchiiWdUfsyj6Z8EtR7nu9eSGiT3CiURTGVrCcji48vDUuZTQ1vlWEbVH5+u9f2FKvOznw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrDPF97f24WzhkbRUexqtvoa+3L6fNp4/HlvKkZJG++m8vGz1b
	LqMNsINMY/qn7ryOCWd5SsCNoZPTbsBQv47Quo6w6hkZgUnqjsDFZelEdKpy9IIjtn9hVfH9Cf8
	YrAK8QH6ux1P1oXkG0CahIZes4JfiB0kN1W3dOv2Uwc+HDdFWFlCqpFaLRRzojuS3c+M2
X-Gm-Gg: AY/fxX5N8HLAJVuPxM1L8tOu4ekOU+BRv3ovVb96a3rODzrNeHENNHunx559+QhprMM
	1zPNDGADNTW0mhd1DkCVjU5wvxqCBeK+a69Pyg2Un5vMppBhn/Yyo/lW8PHBKUMHSYEzDyY/8e/
	I51gf2A2yrBPd7ZcQX+n+AX4LhKTK1888IrxE6UlHag9bsO1vPCoSHO2W3+uhgJ7p9X8WoU53cN
	1YkQtAMCfNLrsb4oEMIFYnJ0PU5kMaThQRB5Ec56LuP5NFqhQUokEe4VwwuAdhRe42vAxEj2cWA
	OlVB+WAN1CBWsyQ151xxb62a8y/73h1S+S72w75Ixhlarud40ztOcwVR06cNTWUcmOcy9zxL9aM
	SezmWJFraLyQVkq83hETZWTWZX5iCSM0=
X-Received: by 2002:a05:600c:8b57:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-47d84b61399mr146048225e9.35.1768088686013;
        Sat, 10 Jan 2026 15:44:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWkxbGlnPNV/i0aKN6HHihFYnCeF7i35rO33Z3KEBVwX5gEpgyJ5DuhDBv8/FZocKje+6kqw==
X-Received: by 2002:a05:600c:8b57:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-47d84b61399mr146048185e9.35.1768088685621;
        Sat, 10 Jan 2026 15:44:45 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8662c09bsm100644835e9.2.2026.01.10.15.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 15:44:44 -0800 (PST)
Date: Sat, 10 Jan 2026 18:44:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 02/12] vduse: add vq group support
Message-ID: <20260110183910-mutt-send-email-mst@kernel.org>
References: <20260109152430.512923-1-eperezma@redhat.com>
 <20260109152430.512923-3-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260109152430.512923-3-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GO8GJUeoGtuWXijJ3Hi0Nc7dsCrBkLBeIErOxsVfroo_1768088686
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 09, 2026 at 04:24:20PM +0100, Eugenio Pérez wrote:
> @@ -1252,12 +1266,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  		if (config.index >= dev->vq_num)
>  			break;
>  
> -		if (!is_mem_zero((const char *)config.reserved,
> -				 sizeof(config.reserved)))
> +		if (dev->api_version < VDUSE_API_VERSION_1 && config.group)
> +			break;
> +
> +		if (dev->api_version >= VDUSE_API_VERSION_1) {
> +			if (config.group >= dev->ngroups)
> +				break;
> +			if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> +				break;
> +		}
> +
> +		if (config.reserved1 ||
> +		    !is_mem_zero((const char *)config.reserved2,
> +				 sizeof(config.reserved2)))

Hmm but if api version is 0 then group should be 0 no?
We should validate.


