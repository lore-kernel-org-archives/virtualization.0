Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189151EB39
	for <virtualization@lists.linux.dev>; Fri, 30 May 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748610812; cv=none; b=ZBMX6MWJ2BOdYYIgx/mYMU8bFmXSSf5aMg0BvTmsBWO8xlxy0KuDmUp8O+Qihs6KmRUroEhs1VZzUVAaaEwvfQMB5BMxb3MjltTxOISauWsm5ZuXBHK7WDqdwIKk5KFUvyeZPvgId4uUlOFOXRrq1kUZj+ndd4btYvy/mwr1GlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748610812; c=relaxed/simple;
	bh=YzzfOkZonnNobw/MSDDNi6dFqgxd+FfGu+ZCT1wVXIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPndfAgOfOkXNCextlsbojprOzQlYJvoIRROOu/fP8rdyF+eNZcM9DCV7L7VKdH/BhDbRno0XF+rNtInOc72QvQbSOBLcmR91TYNLdwlE6+KPaT15EDghcNWCMV3N7a5Z6Z3qgSx/g/SwQ4rF3mudw+nDF3LV7RnwrtPvQaapGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NlQ5lIk+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NlQ5lIk+"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f8a87f0c0fso22656316d6.0
        for <virtualization@lists.linux.dev>; Fri, 30 May 2025 06:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748610810; x=1749215610; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXA7FAwWEoQjWV4rxG699tTwIZ0uS94bp969KPskIC8=;
        b=NlQ5lIk+KaEzmQpusjKdYAq0UMte2xz+ftoQACQjmtZIU3gYdrjc7XReidSZGyCkIL
         /SqJzwPcC9uzd6jQKTrEKHmbtywbr7LYMhxObCksYYLTeVNyn1dzqvBzjwqizY/jvuX0
         H+FNhnFwAXDk0wgvtE5JgjHV1DGRq7e7bRAvF91O7bEMRlcnzvK8S7PKwk+qZnyBYV2P
         ydauYoJEzk7UvtgriR8uvBDo6V4halvmr5iqt4yOp2+3YduncQpIlQpFvCuTGh9P807c
         2qHeWuYWbEo6+bdFRIk7yVeBezA45CVNI5UEhV8s3Uw0Ez5MaaJTjEYSoGc1X9S/RclA
         LjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748610810; x=1749215610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXA7FAwWEoQjWV4rxG699tTwIZ0uS94bp969KPskIC8=;
        b=XgaCuSCkO6+hhXlQqBt3GHBjGIEE/UQ60f9Onunod2gATqKD9v5ejQJcadskRCahL/
         JvKyFF0UdRozfBr5zoxeXy0um6OTiSHRltQd1kz5vBTQJgw9UvUynsLAE72+DmAwn/y9
         TQ3huygmVIkV2/+hVOt6mK/PkffaBBlcL/7IjLZ4Q5vIrkrwN7iTUd8nduCBgcXQ9367
         fqDjD+MtUMldWIzNMXBO52Xr2T6l+ENuRuGxSPPhdHjs8rRDubVJO4aWYGgXVOHAJSoY
         ZnCZYRRA8+atrfKuX97WuRZ3dvdAul/OmhjlCCWnEwChrnycNmWJB+nZX6+1cmbH8lri
         cN+w==
X-Forwarded-Encrypted: i=1; AJvYcCXu0xQFDDI9gDXi64VM7vi7PAsvOywXZwWql9/BqTWd9g9W/EZgIuS92GZNaSmMRq3745JyCZGGX6yurIbOHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsXmcpFl5ojrfTpBNCkI6livJ/PI9gtRaUICzh95cX0OPaL8sQ
	52F5zEczx3ldrq70GtaVmTJH6EWy35KtmrtaTGJhNvto7XdaxkHBuYHDW8YUlLoZxHA=
X-Gm-Gg: ASbGncu7Spewo2YzKCYCWpjHBJZKC56emzGbWjskTLFRdQoVBL+9z5d8UL+jGhKDKAa
	DEVfKjHWrDespMMpT17/SuDsmeEj0RbHhHEgGZXLnKsxMQF1IF7fsagjRUXLMn+wDk7KaUJk2bq
	+0XATBJz1YAuVYpkKF5rnixY4PWkgTcnjCXdB+wtmDNBr5RHycc7ooA5HYI7Sp1iWj68Anb0ct9
	Pnep0wX+sePpu4ae3aMnIIs/ytq9T+XK/0VPCXhVwJHP/4i/Ab/KUvMxjHe+zCBJ0V49JdijbEa
	d6fX2XhrHDqeZxYA54AQe8RZrm4yXlSipoRlEEIlS2RC7khowV/5r+fJHSGSQVu1XHEmKiHYAvH
	eooPqp4kizuQaxLWAf5M9OWfJdYU=
X-Google-Smtp-Source: AGHT+IGtkifcyZecjpf7VInCkUgq6fH3Aod006JAllttC9Fo9yWIYJYoM2lXdlBl79Y0FfzZWiBAvg==
X-Received: by 2002:a05:6214:27ef:b0:6fa:a0ac:8d5b with SMTP id 6a1803df08f44-6faceb4f359mr56609796d6.3.1748610809691;
        Fri, 30 May 2025 06:13:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6c03c58sm22554386d6.0.2025.05.30.06.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 06:13:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uKzY8-00000001DzD-0cum;
	Fri, 30 May 2025 10:13:28 -0300
Date: Fri, 30 May 2025 10:13:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Jacob Pan <jacob.pan@linux.microsoft.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	will@kernel.org, eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250530131328.GB236098@ziepe.ca>
References: <20250410230008.GA6905@ziepe.ca>
 <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250416181759.GF493866@ziepe.ca>
 <20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250525190703.GD12328@ziepe.ca>
 <20250527205428.GA14019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250528000425.GC146260@ziepe.ca>
 <20250529182219.GA20289@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250529183815.GA236098@ziepe.ca>
 <20250529220839.GA9911@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529220839.GA9911@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Thu, May 29, 2025 at 03:08:39PM -0700, Shyam Saini wrote:
> > How does your platform work at all? Isn't 0x08000000 physical memory in
> > your address map? 
> 
> unfornately, this 0x08000000 physical address is not in our address map

Is your issue PCI related, do you have a PCI switch without ACS mapped
here?

Jason
