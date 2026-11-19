Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100187;
	b=fOO8p23roTd/4VcfqcCC1ejndmUGgNSTtgKOpugboJywPYE4/HM82X/bDFugtlSd8FO8
	 toRqY/y3bLEOdUeZzVRhBSpqTW8BJjnFu1/UN3PPXtO7d3bkJuhUn1O0deX1m6ayNX8bM
	 mMHHgAyQJGUAjpGjS4HXU2D5uDrbvoCrAzjoCAz6ajn7bGX2dLZ/KmoBfiIPgvkgXqnm5
	 RgRdexbcDAhB1BhAsd/asSMCW2iHOj58HmwfcSf7stl/w52iCKsZF+KroVnb7ymlzjHWG
	 EJI0cHFz4rVNoLVCEZlgV7nWG/VHAkNYgr6eDZOGAL1j0q4HLrDJYmcumfl/RUjXQ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=bMbyjACtLzAau3mHjynkxDTW6eWUIU5ieVZSzXwOIHE=;
	b=r2bitkTc/96m7kOz+JbJhA7/b+vs93OJoY4Xe2Emt7f/3pEi74wj4neisaDWm+VUs+VY
	 0tmhLXEAoL5C8OBI8eLBXC2K71Drql1hrlBpfxmBhN2QWN4M3ZqNlkFGI3Grzzh3+fLkT
	 D+68HZLShoFeSBeAy2GudqkYFPsBkz+l2S3kLzY9W9ygVeBHyjaXFKIABk9bJqIK0rdUZ
	 sluoO/vvtyesI7AZo5JUuKhqzLJowyXTRfrWaq5lyyLnLh0FoVsXNLFIgdmZ8rXqmx8y7
	 pFeksQijqWbIssS46S6eg10TVaqYwiMzsQS14zN9wK+czdtqHRPjsfWi9rlZQirPFpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JF+1vHfz;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE761606A32A
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 14:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE761606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JF+1vHfz
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a018493d57so72695e9.0
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 06:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795100184; x=1795704984; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bMbyjACtLzAau3mHjynkxDTW6eWUIU5ieVZSzXwOIHE=;
        b=JF+1vHfzJ08ewpjpHx911EI8Vz3Pc/lwtPto5LZv8wJxdFwYTEJKqxAqw1xM1X0PrA
         0AhtedmIcLRH5gyX9FYgTc5G9i2JVzlD1PLXTfXQCV2Qk66lZrE4R3Fq242QkzA+UKu8
         n+gSeR9NkFzHIgeg5q6atX6OpUjB6v8h/NklQVQ3Of83vlqjKbEpCr0b5dQRMCHUZHD8
         PjyM6j++6hjup0KTPbl8CX5pn4+yF1CtzaPrjrG2RekcSK6VXnkyFnQljmf0iZ246VE0
         OL9IGiqI4G73npmwZT0YeqMO2EmoCYfd9KQsZE3Pu/jnzaMW0pnLHD8g3qfssWUDwgce
         +1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100184; x=1795704984;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bMbyjACtLzAau3mHjynkxDTW6eWUIU5ieVZSzXwOIHE=;
        b=AEVeCMXU9iOqzePMoASx9mnpc8xeAQwUeYXWynVXojXxJMpqDOXExBbUkH591Us2gF
         KeFWxsJZ7pM+YmkZU700HkRtiGOZnF3NEmC7yq5si52ftiqOdFxYNdiG0Aj+169dpfLt
         5D4rnB2IlnJaHzJ7BdUuL6P+3jJX2snKqgFucs3MKELjysNvk6mBaeD+rjFk1Fsd9m8W
         DheDmFz1QnOxmRbuwaxjl5KGQZ+ATiI/HqdgV8yqCJa2n5wVMihyAP99H53/M0Ro/gR7
         VKrv+y9Y8HTKHRmJURjqd+R/dEYTNoQ4Jx8+sUYRfPRCNB9hWCJITqkqAwPWDnK8iIYZ
         d5nw==
X-Forwarded-Encrypted: i=1; AL+hErFanPtnDtnxaWaapXwDBKMFeHyktjgzAqOrc3CvrhWmfm3SHFXiA7Fa+rPET+6ZsI1VY134JJ5F3YpNF2FJyg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+TRLKSniRK6VzoPK0eP/bKpstyFkJHRBoOcXSjhuhryhYKuLoN
	dx6F6lJkYXFrSbIAwAmALsPptzpiawefjSBTrBKc6Jw/fMWtiFHpISGI25Vk/+7Nmw==
X-Gm-Gg: AYBFou0oaMSy00vu/gVJ7F7ysnPWcJWsp5PwBtoni9SPJjgWyYJccGdM38gWuutKIou
	HI3rfh7YnuX1tw57SvBGJOS4OqbPUjhEO4FS+5UsAixxoqjccicf6zzFA3xwnq6ofUwQ2sbcyOP
	wpBa4lZKGBn4x4+dRP3N2D4uXSw9AIviETBTlxH4chxwyz9pCJYQrV4pGazBMJdvSL5Mac98Ek2
	fskhw1ltpB42Q0I7rEI2Dqi9RBYDdi3Y/zc3iGS3XHFcRooV6TdPTamJVT32WtqWjwpL5OUUPKa
	BFXYNomr/E1SYIAnAwld59Bo2dexpn6LGneMnqzSH0Vzp7xmJFUN6GJPA8dPcgmG75IANZpz+sc
	MYWQLEso+hykFQ0e+H1WOHttJ4uUqfOL8jnr158TXzGaCDkYYoOgonjbJP71sZFvmQ7AF6joEx0
	9iaShCWuPHGB5jsvycRLq0+nEvqgXgQ6SHtRUdJ9rsB6KveUxgaX8TN0XOkouzHH7GBUnsCwZyK
	VdayNCCoWLkEXPtmsQ9v7d9VJK1kAh7peQEfNLn884HKuULYdHuJH00LohRY1UuN/eDECZ3mqj5
	b7o9kACNSZKAstzanHlcB4aKeL5EJyTZ8XI4Wl0Gz3dl8E5qJRO4iwYCW97rWbp+aOJmAf4=
X-Received: by 2002:a05:600c:1d01:b0:4a1:e384:5e12 with SMTP id 5b1f17b1804b1-4bb85193dc1mr748295e9.7.1795100183663;
        Thu, 19 Nov 2026 06:56:23 -0800 (PST)
Received: from google.com (160.193.189.35.bc.googleusercontent.com. [35.189.193.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b216esm43338685e9.12.2026.11.19.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:56:22 -0800 (PST)
Date: Thu, 19 Nov 2026 14:56:18 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Mete Durlu <meted@linux.ibm.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Eric Auger <eric.auger@redhat.com>,
	Pranjal Shrivastava <praan@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, qat-linux@intel.com,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] vfio: Allow untainted use of driver_override
Message-ID: <av8OEgaW0jEJC1OF@google.com>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261118235645.2907908-2-alex@shazbot.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118235645.2907908-2-alex@shazbot.org>

On Wed, Nov 18, 2026 at 04:56:44PM -0700, Alex Williamson wrote:
> Driver overrides are the standard mechanism for binding vfio drivers
> to devices.  With the introduction of the support_driver_override flag
> in the core driver struct, it's now required for drivers to declare
> themselves as driver_override compatible, otherwise driver_override
> bindings will be denied or generate a kernel taint.
> 
> Set the support_driver_override flag on the driver struct across all
> vfio drivers.
> 
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Cc: Longfang Liu <liulongfang@huawei.com>
> Cc: Ankit Agrawal <ankita@nvidia.com>
> Cc: Brett Creeley <brett.creeley@amd.com>
> Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: Michał Winiarski <michal.winiarski@intel.com>
> Cc: Julian Ruess <julianr@linux.ibm.com>
> Cc: Nipun Gupta <nipun.gupta@amd.com>
> Cc: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Mostafa Saleh <smostafa@google.com>
> Cc: Pranjal Shrivastava <praan@google.com>
> Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
> Cc: qat-linux@intel.com
> Cc: virtualization@lists.linux.dev
> Cc: intel-xe@lists.freedesktop.org
> Cc: kvm@vger.kernel.org
> Signed-off-by: Alex Williamson <alex@shazbot.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
> 
> Uwe, this should cover all the vfio drivers that expect to use
> driver_override.  Thanks,
> 
> Alex
> 
>  drivers/vfio/cdx/main.c                        | 1 +
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c              | 1 +
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 3 ++-
>  drivers/vfio/pci/ism/main.c                    | 3 ++-
>  drivers/vfio/pci/mlx5/main.c                   | 3 ++-
>  drivers/vfio/pci/nvgrace-gpu/main.c            | 3 ++-
>  drivers/vfio/pci/pds/pci_drv.c                 | 3 ++-
>  drivers/vfio/pci/qat/main.c                    | 3 ++-
>  drivers/vfio/pci/vfio_pci.c                    | 3 ++-
>  drivers/vfio/pci/virtio/main.c                 | 3 ++-
>  drivers/vfio/pci/xe/main.c                     | 3 ++-
>  drivers/vfio/platform/vfio_amba.c              | 1 +
>  drivers/vfio/platform/vfio_platform.c          | 1 +
>  13 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> index 28dc8c825600..fb7679bf92fd 100644
> --- a/drivers/vfio/cdx/main.c
> +++ b/drivers/vfio/cdx/main.c
> @@ -358,6 +358,7 @@ static struct cdx_driver vfio_cdx_driver = {
>  	.match_id_table	= vfio_cdx_table,
>  	.driver	= {
>  		.name	= "vfio-cdx",
> +		.support_driver_override = true,
>  	},
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> index 15b05b8c0c90..1603f81e0257 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> @@ -597,6 +597,7 @@ static struct fsl_mc_driver vfio_fsl_mc_driver = {
>  	.remove		= vfio_fsl_mc_remove,
>  	.driver	= {
>  		.name	= "vfio-fsl-mc",
> +		.support_driver_override = true,
>  	},
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index c82c59246a3f..5c56aff8db01 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1737,7 +1737,8 @@ static struct pci_driver hisi_acc_vfio_pci_driver = {
>  	.id_table = hisi_acc_vfio_pci_table,
>  	.probe = hisi_acc_vfio_pci_probe,
>  	.remove = hisi_acc_vfio_pci_remove,
> -	.driver = { .pm = pm_ptr(&hisi_acc_vf_pm_ops) },
> +	.driver = { .pm = pm_ptr(&hisi_acc_vf_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &hisi_acc_vf_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/ism/main.c b/drivers/vfio/pci/ism/main.c
> index cce3bdf1f070..263b377e87c4 100644
> --- a/drivers/vfio/pci/ism/main.c
> +++ b/drivers/vfio/pci/ism/main.c
> @@ -399,7 +399,8 @@ static struct pci_driver ism_vfio_pci_driver = {
>  	.id_table = ism_device_table,
>  	.probe = ism_vfio_pci_probe,
>  	.remove = ism_vfio_pci_remove,
> -	.driver	= { .pm = pm_ptr(&ism_vfio_pm_ops) },
> +	.driver	= { .pm = pm_ptr(&ism_vfio_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &ism_vfio_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
> index 18a6d224b1fd..63c89e461be8 100644
> --- a/drivers/vfio/pci/mlx5/main.c
> +++ b/drivers/vfio/pci/mlx5/main.c
> @@ -1451,7 +1451,8 @@ static struct pci_driver mlx5vf_pci_driver = {
>  	.id_table = mlx5vf_pci_table,
>  	.probe = mlx5vf_pci_probe,
>  	.remove = mlx5vf_pci_remove,
> -	.driver	= { .pm = pm_ptr(&mlx5vf_pm_ops) },
> +	.driver	= { .pm = pm_ptr(&mlx5vf_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &mlx5vf_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index 5ddec340b73b..946da32c61ff 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -1438,7 +1438,8 @@ static struct pci_driver nvgrace_gpu_vfio_pci_driver = {
>  	.id_table = nvgrace_gpu_vfio_pci_table,
>  	.probe = nvgrace_gpu_probe,
>  	.remove = nvgrace_gpu_remove,
> -	.driver = { .pm = pm_ptr(&nvgrace_gpu_pm_ops) },
> +	.driver = { .pm = pm_ptr(&nvgrace_gpu_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &nvgrace_gpu_vfio_pci_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/pds/pci_drv.c b/drivers/vfio/pci/pds/pci_drv.c
> index cf7e33d4d17b..1fcef987f1b0 100644
> --- a/drivers/vfio/pci/pds/pci_drv.c
> +++ b/drivers/vfio/pci/pds/pci_drv.c
> @@ -184,7 +184,8 @@ static struct pci_driver pds_vfio_pci_driver = {
>  	.id_table = pds_vfio_pci_table,
>  	.probe = pds_vfio_pci_probe,
>  	.remove = pds_vfio_pci_remove,
> -	.driver = { .pm = pm_ptr(&pds_vfio_pm_ops) },
> +	.driver = { .pm = pm_ptr(&pds_vfio_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &pds_vfio_pci_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
> index 69448fa57df4..8a616f9b6494 100644
> --- a/drivers/vfio/pci/qat/main.c
> +++ b/drivers/vfio/pci/qat/main.c
> @@ -695,7 +695,8 @@ static struct pci_driver qat_vf_vfio_pci_driver = {
>  	.id_table = qat_vf_vfio_pci_table,
>  	.probe = qat_vf_vfio_pci_probe,
>  	.remove = qat_vf_vfio_pci_remove,
> -	.driver	= { .pm = pm_ptr(&qat_vf_pm_ops) },
> +	.driver	= { .pm = pm_ptr(&qat_vf_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &qat_vf_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index e7c012febe91..fde2c3fc88eb 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -260,7 +260,8 @@ static struct pci_driver vfio_pci_driver = {
>  	.remove			= vfio_pci_remove,
>  	.sriov_configure	= vfio_pci_sriov_configure,
>  	.err_handler		= &vfio_pci_err_handlers,
> -	.driver		= { .pm = pm_ptr(&vfio_pci_pm_ops) },
> +	.driver		= { .pm = pm_ptr(&vfio_pci_pm_ops),
> +			    .support_driver_override = true },
>  	.driver_managed_dma	= true,
>  };
>  
> diff --git a/drivers/vfio/pci/virtio/main.c b/drivers/vfio/pci/virtio/main.c
> index 123ff5193812..1e02a8fd4a61 100644
> --- a/drivers/vfio/pci/virtio/main.c
> +++ b/drivers/vfio/pci/virtio/main.c
> @@ -222,7 +222,8 @@ static struct pci_driver virtiovf_pci_driver = {
>  	.id_table = virtiovf_pci_table,
>  	.probe = virtiovf_pci_probe,
>  	.remove = virtiovf_pci_remove,
> -	.driver = { .pm = pm_ptr(&virtiovf_pm_ops) },
> +	.driver = { .pm = pm_ptr(&virtiovf_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &virtiovf_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
> index 7dab3e024aa8..e0ab61f604de 100644
> --- a/drivers/vfio/pci/xe/main.c
> +++ b/drivers/vfio/pci/xe/main.c
> @@ -592,7 +592,8 @@ static struct pci_driver xe_vfio_pci_driver = {
>  	.id_table = xe_vfio_pci_table,
>  	.probe = xe_vfio_pci_probe,
>  	.remove = xe_vfio_pci_remove,
> -	.driver = { .pm = pm_ptr(&xe_vfio_pm_ops) },
> +	.driver = { .pm = pm_ptr(&xe_vfio_pm_ops),
> +		    .support_driver_override = true },
>  	.err_handler = &xe_vfio_pci_err_handlers,
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
> index fa754f203b2d..2c87caf1b7f7 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -137,6 +137,7 @@ static struct amba_driver vfio_amba_driver = {
>  	.id_table = vfio_amba_ids,
>  	.drv = {
>  		.name = "vfio-amba",
> +		.support_driver_override = true,
>  	},
>  	.driver_managed_dma = true,
>  };
> diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
> index a4d3ace3e02d..93d06032cdde 100644
> --- a/drivers/vfio/platform/vfio_platform.c
> +++ b/drivers/vfio/platform/vfio_platform.c
> @@ -116,6 +116,7 @@ static struct platform_driver vfio_platform_driver = {
>  	.remove		= vfio_platform_remove,
>  	.driver	= {
>  		.name	= "vfio-platform",
> +		.support_driver_override = true,
>  	},
>  	.driver_managed_dma = true,
>  };
> -- 
> 2.54.0
> 
