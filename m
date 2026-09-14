Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75547440A31
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384299; cv=none; b=E4guEikXvXLrAVpxSbXsth+bB8wQQdkOwCKpSORW1xmE3j5VodWY4SJIOJjO9/cHnUwRK05zHLIWb/WEKHDdX1GztOfWKnuFCYoXdKT6W6BN7nLv2Ht2Qt+IC2yq1DC5Y6vDpm9sE3f5tp91c/tbgjLnuwkUwSRUxtEr+Lj/PdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384299; c=relaxed/simple;
	bh=TeHu8bS50xDZnijxFYGK04XvVMOArmp4vFusAc1vByg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G+/c9qWizWXj0kG2epsMrm1fu4VM1Q0fsEXiaksVGrEye9Kw1P0UYLe1kx9gLHrvID8v3yZcY0wrG+g8Glh4ixqLeKtgfVlD87MuUKd0GZgxw2AVmUnKBUwm4h9LpmKemM4Go3ghj/gonAtX/2k9s+oTSWcc+ipo98UFnGeN814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egNb/13C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egNb/13C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300691F00898;
	Mon, 14 Sep 2026 11:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789384289;
	bh=DX4P1yDSx3Jinn4cf7zxkYLcnN/yGIhblsLbJ9RBrz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=egNb/13C9boVskP8CndonHGB59H/I/TxNln3HKNPRprOPnjy11SW/hn1HR51tx/XK
	 6WXYxy6CnH9lb9FK1hG5ptmYPLJS+XAaIC0hPsztiZhTGAdTMQB9HNHkqtZ1N3Y3AA
	 UR5OVyTDE7I3UYA3TvnEipLm0gYtUYVw92aaL9BE7jriSE8bytd2KeG6BRvIWsv1gN
	 Hiy/j9qOKwZdvsIOn7ASRA9aqxunvqJcW7moOj8ms7eED9C3Z42sCGP2vJVONPHsYz
	 QfsUPi4SogXAoyTCl0pm+XbcWgRf6hBgbw3E+b8aWNw+4WLeU/VCl+h97hu7imUKv8
	 iUMzgbGL4CgUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/vblank: Don't arm vblank timer with invalid
 frame duration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260914110004.211027-1-tzimmermann@suse.de>
References: <20260914110004.211027-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 11:11:28 +0000
Message-Id: <20260914111129.300691F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] AB-BA deadlock between synchronous hrtimer cancellation in drm_crt=
c_vblank_start_timer() and drm_handle_vblank() taking vblank_time_lock.
--

commit de00db596b26306bffcd319a867015e9f4b1faa6
Author: Roman Ilin <me@romanilin.is>

drm/vblank: Don't arm vblank timer with invalid frame duration

This commit modifies drm_calc_timestamping_constants() to check for INT_MAX
overflows and returns an error instead of proceeding with invalid frame
durations. It also updates drm_crtc_vblank_start_timer() to propagate this
error, allowing the driver to fall back to immediate vblank events.

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13e423..72b543bca9e31 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c

[ ... ]

> @@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *cr=
tc)
>  	struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
>  	struct drm_vblank_crtc_timer *vtimer =3D &vblank->vblank_timer;
>  	unsigned long flags;
> +	int ret;
> =20
>  	if (!vtimer->crtc) {
>  		/*
> @@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *cr=
tc)
>  			hrtimer_try_to_cancel(&vtimer->timer);

[Severity: High]
This is a pre-existing issue, but can this busy-wait loop cause a hard
deadlock?

When CPU 1 enables vblanks, it holds the vblank_time_lock while executing t=
his
synchronous cancellation loop:

CPU 1:
drm_vblank_enable() {
    spin_lock(&dev->vblank_time_lock);
    __enable_vblank(dev, pipe);
    ...
    drm_crtc_vblank_start_timer(crtc);
    while (hrtimer_active(&vtimer->timer))
        hrtimer_try_to_cancel(&vtimer->timer);

If the timer has just fired concurrently, CPU 2 executes the callback which
attempts to acquire the same lock:

CPU 2:
drm_vblank_timer_function() {
    ...
    drm_handle_vblank(dev, pipe);
    spin_lock(&dev->vblank_time_lock);

This creates an AB-BA deadlock where CPU 1 spins forever waiting for the
callback to finish on CPU 2, while CPU 2 spins forever waiting for CPU 1
to release vblank_time_lock. Is it safe to synchronously cancel the timer
here while holding a lock that the timer's callback also takes?

>  	}
> =20
> -	drm_calc_timestamping_constants(crtc, &crtc->mode);
> +	ret =3D drm_calc_timestamping_constants(crtc, &crtc->mode);
> +	if (ret)
> +		return ret;
> =20
>  	spin_lock_irqsave(&vtimer->interval_lock, flags);
>  	vtimer->interval =3D ns_to_ktime(vblank->framedur_ns);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914110004.2110=
27-1-tzimmermann@suse.de?part=3D1
