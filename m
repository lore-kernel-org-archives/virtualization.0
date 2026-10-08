Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8DF2BE656
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475341; cv=none; b=bhkBIUkYJxpRk+iqJD7bhAnxKSKAxolC4FYaYglC9T1wLu1mcL5K8LnRxfah9sG4cFPt2K4NFOmuXvO2DX7LXs7AitvvBSCycKxSrSiOQTZCfOmgA0voNiN5NgVPn7TW8aUlezkDQFTGhtXcuIkoo8aJGlUOxrsAPZbiG1wtzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475341; c=relaxed/simple;
	bh=tLM8VtgCTiJeWanOYIim4nvZdH6bkNRkWQrJQt9pbT0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HucXmTSDaLm7XkZAfHOKPw+VNih+d0UMirg0MVQV7U0BZ1uT3610sH6DqVt0+0ldiusX7HtIvUq6lHaV4cXaY8JokrDfVnL0tneKYq/vMD+/mDhZaTKhqkSohcA3IKzZgRWibYNNe2MjWovhrh7uSogaKSI5ModVg7S5dT07+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrTqHEsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrTqHEsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663EA1F000FF;
	Thu,  8 Oct 2026 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791475340;
	bh=LbSzFmjdbFQNnnw5zyfrch3z5uqe+fr3eBb+EfhCGBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UrTqHEsl/B19pJPPaQvfXUHpbRKM8wMh36pHA003m2Oy/uiZT/9j1TT98wo2J1Wsk
	 KK9Ir4h7N0K01AA9j1zZy1NG4YcCX5K9wa9Mbr9np4igLAsvIPx+QbLtfF3ner4gSk
	 ePkkqig6Ru8+0T9c+dinz9ccWiURukqc0J+CXFV05fc4WOA24vQGvglhYSci8HTRbb
	 882ijw1Qbesjh2/01QawSVhh+q7FQUzAqFI0/azcCz9mZwGRRfZVg6dr81TPZkzYWY
	 +X0eim2U5HMkws4+uNrL/ajHhqGdNWu6UU2sDeKD/J8htG/dDfF77FmPW2cFSj3mOr
	 8nWKlmwNQgthA==
Message-ID: <sashiko-outbox-164363@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] drm/qxl: Fix out-of-bounds read in client monitors
 head access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julio Faracco" <jcfaracco@gmail.com>
Cc: dri-devel@lists.freedesktop.org, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261008155034.55688-1-jcfaracco@gmail.com>
References: <20261008155034.55688-1-jcfaracco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 16:02:19 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/qxl: use-after-free in qxl_output_get_client_head() due to con=
current reallocation
--

commit 81383457292a90ad6073bf06583b55f1415d8a86
Author: Julio Faracco <jcfaracco@gmail.com>

drm/qxl: Fix out-of-bounds read in client monitors head access

This commit factors out the client monitors configuration access into a new
qxl_output_get_client_head() helper function to prevent out-of-bounds reads
when the client reports fewer monitors than the default. It updates several
places, including the mode probe path, to use this new helper.

> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
> index 63fc7c6a7f1a5..9be9ded8d1639 100644
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
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this introduce a potential use-after-free?

If an unprivileged userspace process inside the guest repeatedly invokes the
DRM_IOCTL_MODE_GETCONNECTOR ioctl (which calls qxl_conn_detect() and
qxl_conn_get_modes()), it will read qdev->client_monitors_config into the
local cfg pointer here.

Meanwhile, a concurrent qxl_client_monitors_config_work_func worker thread
could be reallocating qdev->client_monitors_config in response to host
monitor configuration changes:

qxl_display_copy_rom_client_monitors_config() {
  ...
  if (qxl_alloc_client_monitors_config(qdev, num_monitors)) {
  ...
}

qxl_alloc_client_monitors_config() {
  ...
  kfree(qdev->client_monitors_config);
  qdev->client_monitors_config =3D NULL;
  ...
}

Since the worker thread frees the structure without holding
mode_config.connection_mutex or any other lock, could the worker free the
configuration after the reader fetches the pointer but before it accesses t=
he
array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008155034.5568=
8-1-jcfaracco@gmail.com?part=3D1
