Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795222058;
	b=4+CGzDwJxXl7qXNdE9+krOSqMjRtijLYDtsQMDiYLPqynD0H2/ZDODJWCQOWBgNfJbyH
	 Xj21YHqRIvXWvPi2RkrDE3wohC+5aGqyuGgZLUm/tmnQP0riB2WSQhy6O7x3TqDqZzyS2
	 IHZ5MwCQchJtbYiHawd0oWknm22+8F6w1SS5FYK2943wfQb2g8lzY3DjHcFfiEsn+nKEZ
	 vGJnoq9Vz72Rjtua0Vos9iW1EcQJ5V4uk21sJDetoXdMAbmjtVk69JZ5Sse+YhjwgY9h7
	 vHYduMHfEcKHSe7yf8dB6meniGiROpdTbyFZIMupfNkCl5O2LwSo3izSdoWJAeO0uqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795222058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Xm+bAJ6XfISn0S696Uqw7pdXFrZEL33i/yZUEH+CqPk=;
	b=FZO2MQ/FKdHYZljfPLpwyKCrA6JpVzpfeaoiZhwPtjn+XF5WYZGXDwBRKybvxxxCB4dt
	 YUlSpefnqeZlBxE4A7gsOXa3CVpHWijU/lt6es7V/j3KukMI/alSFRUuiK3fVCB/SaiH2
	 qnWbzawENvj2DCDiOdRdmaBMrgQpG8GJFYsFwoLDJBSlsmLmXdLtPwz7Mpsk1jfcxs3co
	 DMPhOH9MyvaJZtLbiEwIiZYiNsQ/3aVHwJ6+wX1Io+v11PeyOblzrakBw0mT1O+j/k+Ec
	 Wi7oR3UJ4pHPMU2imrtxUpahW9xzfhodTk65G9joOdn9ybCjG5Zvc5E3vR692Q8U7pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WNbL/NZy";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47A606A6A8
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 00:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB47A606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNbL/NZy
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-170135e43c7so2067777c88.0
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 16:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795222055; x=1795826855; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xm+bAJ6XfISn0S696Uqw7pdXFrZEL33i/yZUEH+CqPk=;
        b=WNbL/NZyd80l7D4deB9kuYkWLgK0zkaTiAzpPCpuzk4lN2dCSlbi6J+Vt2bhGwo9L3
         QoN7K3KSXSbLOR2j/NCsDQfZk1cz3sNAaMcbuON78OHKIoyrTCWF2KDgubn8dy9O4wFY
         xlGoNRcytvP4tQY1+P0SA1JuoGJ7sxc3a2pKgjqh7oxwK+BC5FIEHc3YK3aFV3zC7B38
         Oh73E98caqvUdIRW8L4e5kU5A2zMid3P3n2YpCUCNsOvcd4omIyULEPbwP4Mk7HE5xNY
         iNJkOo8XLBwCAzj9gAgCi0RQpIcx05lR5jZ+EVxqp0qkAM8eCuBxNn0JQ8tLBhsjxVfj
         kilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795222055; x=1795826855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xm+bAJ6XfISn0S696Uqw7pdXFrZEL33i/yZUEH+CqPk=;
        b=ZiNUwsYQqafSCWAqfy4ft54uSYuceyJ8iY4aV3SIh+hvyU/BdXwgxwzBDGKMbI8UZ3
         1Yi/zvEa6CsrNYQLnSilmgc3AhsauflP+rp5c3939ETZtInXDu3QNCu2KmVVxsezPlR1
         FhaarrmbHOMLKggw/WzvyjJbPFjjObBTACijhj106gggAIe/yZPaZlcQPLhWnAFjsJMA
         yEosbOjQwC078sbjiDXmWjhSeXMxV/q6jJ8ts3hEQDPAI43JTZF5jQE3wqMSfm69t78U
         /ZW79UUlXFl7rcfcPn9iR3ZHizSFgx4PaHT5KAGt+8oTahT04xyv3kPvas92quenoWiQ
         qYng==
X-Forwarded-Encrypted: i=1; AL+hErFkZsNHtsvWrWzlArT/Qp0og6jEq+yWdkRDH8pV4eD9Ogycewevm75OesBQxPgIrqWyt17lE90M7hsy7OhRuw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8bnywYSX0B8HcORTtdMlgbFbld5/evJe3EeSIw6vR6rKrNtnXE
	UhV4DJ7wvZ40IjdRO7IQAzPPHmjc/smPsdK/5CxutB9Mk+svx1Jwit6k
X-Gm-Gg: AYBFou2Yn/3m9GyPycQ6FcUvAftnvLI81pYOAd9zgBjwiRWDltXabCDhKlwemjEi18i
	0nJXLZICTZXsapORkm9+CSSocfd25VcigFvsWn8ECu2/yqt8ZuZ7mtXzmNf6u/nHHKtfuyjEqX/
	lSY0ON8Ig4n6zAZSpnVGwmLg4LaCEDCouAji0rkul503+tSesyqVZFHlhQ2NUTBBkpg+t82y2Ap
	zN3EjloKMt4+Jx+e3vYbFT+7OY3cedsu3B6aafkhOBY/oa7ZF6rTjPehjIVkOWeJYvcboSNe8p5
	trRf4eU3menomZOq74EurrjuOXNo5geVcEcikXRGO1kBlvgmjhgYrkX8a0SV1UpoT+OMclj70o6
	Dwfum0+9Fb6vCpigshm25mQH/kdQtcsgiBqy0gdHyDU7h/VhKPL2tca5j6MjLCj3MLFg0fdxf6f
	EvL3pgcus7G6B2jOkjIVw3dbJ63rnQhGTlMMVXGg8B7eVff8JZQnIHbXCaQvgD6LVkx9AJzo8kS
	hA/9kHm03iCuXiMjyyWaTddWBF0vt2FpRJXFNNQjqpLJ8cb+WkO0SbiX0hxOv/QTpHQvdQypgyG
	oL5Wb6Lc8yW3aeT3idw1QpPnyOzzxDB15A==
X-Received: by 2002:a05:7022:f50b:b0:1b5:2de3:bcfb with SMTP id a92af1059eb24-1b5568ee8famr5068684c88.25.1795222054917;
        Fri, 20 Nov 2026 16:47:34 -0800 (PST)
Received: from localhost ([2408:840d:6820:1a1b:6def:d896:8796:4938])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm2958460c88.11.2026.11.20.16.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 16:47:34 -0800 (PST)
Date: Sat, 21 Nov 2026 08:47:28 +0800
From: Yao Yuan <yaoyuan0329os@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Longfang Liu <liulongfang@huawei.com>, 
	Julian Ruess <julianr@linux.ibm.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Brett Creeley <brett.creeley@amd.com>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Eric Auger <eric.auger@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Mostafa Saleh <smostafa@google.com>, kvm@vger.kernel.org, 
	qat-linux@intel.com, virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v2 03/10] vfio: Allow untainted use of driver_override
Message-ID: <awDqE7DxRv9bYPQM@sapienza>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <fb0df5c89336b77a373ae0f890f63427e4adbb28.1795171088.git.u.kleine-koenig@baylibre.com>
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
In-Reply-To: <fb0df5c89336b77a373ae0f890f63427e4adbb28.1795171088.git.u.kleine-koenig@baylibre.com>

On Fri, Nov 20, 2026 at 12:11:04PM +0100, Uwe Kleine-König wrote:
> From: Alex Williamson <alex@shazbot.org>
>
> Driver overrides are the standard mechanism for binding vfio drivers
> to devices.  With the introduction of the support_driver_override flag
> in the core driver struct, it's now required for drivers to declare
> themselves as driver_override compatible, otherwise driver_override
> bindings will be denied or generate a kernel taint.
>
> Set the support_driver_override flag on the driver struct across all
> vfio drivers.
>
> Signed-off-by: Alex Williamson <alex@shazbot.org>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Ankit Agrawal <ankita@nvidia.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

LGTM.

Reviewed-by: Yuan Yao <yaoyuan0329os@gmail.com>

> ---
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
> 2.56.0.rc1
>
>
