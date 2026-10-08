Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6474963B6
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464142; cv=none; b=RzySegmzJJ7gCTl7dIgn7LT4Nl04wtQ0BcLkS7wHmgfZ06gINiHce9SGDWoZ2P1ljkOroL0C4aAyLvay3/7xi3082oSGI09cw01C9M/h0Niewjt1C+WpFnjTFLx8ItEcvMIjhXDRwK6AKz8/SeXh+jkDlAHvHJcodOqRUIv2sUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464142; c=relaxed/simple;
	bh=1ScEMZALS+KyeCebEanxsN3jjfN2QTpMSftH9q5jvfc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aZ/0v582BtPgSq0+9vUzSzItk25lZ2GLJ3GVmyP/161uuhoB04RGvrhtFX9uKycRmlLrVHowhwz5hWXux5VNOPpGnC/PwSz3KRQHwtcRmDoBNvf3Da6l3/v2tt2Z/jp1sx0ESJgjh1eub5IkRPSFp07oOX1n1Hzo/jiok64bM6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inRmw/gq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inRmw/gq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F7D1F000FF;
	Thu,  8 Oct 2026 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791464140;
	bh=rktpP2gLSLdIsTiZgovPuFnm9RdrBC9/eEzpNZqp2rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=inRmw/gqAubl9e5PXsJ2sTlQ1LjTVIpXM0imTm2Nw0UzzeNzI8SWTUiZyUMcmjvfu
	 AiAQSDPdNe6+ilpfXYU5FPYfu8x6Rurbt6BZqwYgUhewBmmuY8CkGbKgYQu1jZeqhN
	 WgiI9wLbQ6un382nhs8h2qbcM1f2sAQ2R9iUNUXKZMJie+1mZX5n3S6hzndygVNLMh
	 QLX54V1q7HzwqexY29AKo/GFLBDu7woQk56TQwoo5zlvRHbUvl4jQ6C9jgarfV/NeA
	 iA2Vly73EMOlhjsAMVZoVp3skF63GkTIGxd5YYYsfFXmlagKyW9iUARNifU0NfvQ8V
	 tOwzECMMpP8aQ==
Message-ID: <sashiko-outbox-164182@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: Fix out-of-bounds read in
 qxl_update_offset_props()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julio Faracco" <jcfaracco@gmail.com>
Cc: dri-devel@lists.freedesktop.org, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261008124317.32199-1-jcfaracco@gmail.com>
References: <20261008124317.32199-1-jcfaracco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 12:55:40 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/qxl: Incomplete fix leaves out-of-bounds read in qxl_conn_get_=
modes()
- [High] drm/qxl: Lockless reallocation of client_monitors_config causes Us=
e-After-Free
--

commit 3364903c8ea46fb8e3ab3b182d79c5b5a9cc250d
Author: Julio Faracco <jcfaracco@gmail.com>

    drm/qxl: Fix out-of-bounds read in qxl_update_offset_props()

This patch introduces a helper to safely validate bounds when the client
reports fewer monitors than configured, preventing an out-of-bounds read.
The helper is applied to several functions across the qxl display driver.

> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -148,6 +148,21 @@ static int qxl_display_copy_rom_client_monitors_conf=
ig(struct qxl_device *qdev)
>  	return status;
>  }
> =20
> +/*
> + * Return the client monitors config head for @output, or NULL when the
> + * client monitors config is absent or does not cover this output's inde=
x.
> + */
> +static struct qxl_head *qxl_output_get_client_head(struct qxl_output *ou=
tput)
> +{
> +	struct qxl_device *qdev =3D to_qxl(output->base.dev);
> +	struct qxl_monitors_config *cfg =3D qdev->client_monitors_config;
> +
> +	if (!cfg || output->index >=3D cfg->count)
> +		return NULL;
> +
> +	return &cfg->heads[output->index];

[Severity: High]
Does this code create a use-after-free race condition?

The qxl_client_monitors_config_work_func() workqueue asynchronously executes
qxl_display_copy_rom_client_monitors_config() and=20
qxl_alloc_client_monitors_config(), which frees and reallocates=20
qdev->client_monitors_config before acquiring the DRM modeset locks.

Since this helper reads qdev->client_monitors_config into cfg without any
synchronization locks, if the background workqueue frees the configuration
array immediately after this fetch:

    kfree(qdev->client_monitors_config);

could the subsequent bounds check (cfg->count) and array access
(&cfg->heads[output->index]) dereference freed memory?

> +}
> +
>  static void qxl_update_offset_props(struct qxl_device *qdev)

[ ... ]

> @@ -1111,15 +1127,17 @@ static enum drm_connector_status qxl_conn_detect(
>  		drm_connector_to_qxl_output(connector);
>  	struct drm_device *ddev =3D connector->dev;
>  	struct qxl_device *qdev =3D to_qxl(ddev);
> +	struct qxl_head *head;
>  	bool connected =3D false;
> =20
>  	/* The first monitor is always connected */
>  	if (!qdev->client_monitors_config) {
>  		if (output->index =3D=3D 0)
>  			connected =3D true;
> -	} else
> -		connected =3D qdev->client_monitors_config->count > output->index &&
> -		     qxl_head_enabled(&qdev->client_monitors_config->heads[output->ind=
ex]);
> +	} else {
> +		head =3D qxl_output_get_client_head(output);
> +		connected =3D head && qxl_head_enabled(head);
> +	}

[Severity: High]
Does qxl_conn_get_modes() remain vulnerable to the same out-of-bounds read?

This patch fixes the issue here and in a few other places, but=20
qxl_conn_get_modes() has an identical pattern that was not updated:

    if (qdev->client_monitors_config) {
        struct qxl_head *head;
        head =3D &qdev->client_monitors_config->heads[output->index];
        if (head->width)
            ...

If output->index exceeds qdev->client_monitors_config->count during a mode
probe, won't this still trigger the KASAN slab-out-of-bounds memory read?

> =20
>  	DRM_DEBUG("#%d connected: %d\n", output->index, connected);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008124317.3219=
9-1-jcfaracco@gmail.com?part=3D1
