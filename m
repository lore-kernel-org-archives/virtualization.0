Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA02857F9
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229449; cv=none; b=gAxgpJ1j/yL6hgELR/apLwPkONjmmlzPrUHJiNzqxzUJSYE6tE0O88iZVSFtwzJ7r43MamD7ZwfqPM0LV3D3rQbTMhp/ZMvTv3YyPfoENd6wp5KLzNsZf5HctCgXizAJXnL4RdY+ovsUQLvUGdqZ2S8gEFMGiT+ZU7UrridMmE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229449; c=relaxed/simple;
	bh=pNpcSL9WFG/dfCK8Ux+dUJneofiCTUBlKDdEWDy6x0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D85dOvTRCjqB30kBsG237M+sl9x0khcCQ5MlW4HYBv+Vjv4BcrqNKZU2ZY17KZ9KJYfPxH5bDTGvMB0n0xCYJ6wiZ2/9fk3T+cRmh+f2JHnwWUelhAHVpl3z5mOIFZ/8Hc2QYp0EMCTcTtLud8d56PVwlkoXIFzPnUJiAd/C2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRhZVO+v; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRhZVO+v"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7114060596
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 21:04:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f8f3HK7CshMX for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Sep 2025 21:04:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ADBAE60593
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADBAE60593
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XRhZVO+v
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ADBAE60593
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 21:04:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 64B3C601D4;
	Thu, 18 Sep 2025 21:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEAFC4CEE7;
	Thu, 18 Sep 2025 21:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758229445;
	bh=pNpcSL9WFG/dfCK8Ux+dUJneofiCTUBlKDdEWDy6x0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRhZVO+vcwmGXhCry6oiRXlURjGYtfw4fMPfne7z1yxjUFyxvl0j52tR08yKLOJAW
	 dOijzPhLd/tZPUzGy8Xb6/aGhLeS8RwFk9Or4+jYrBLo1za/QNKH4z654YNp0xte0d
	 lXmpB1kE8aOKLVpjLuI2y1apXnEarTr4ncFmjFr3vZ2O7IIbjceeDWnwYSuHaq4qeD
	 iFLpYZcjaQEmu/KzxOy39LGSYo5Ww3MgRbI8bPpoomAq1nlEZtWbXqgLpOiPApyX+E
	 AGwA2ICVA70+mcHlzNSiKce4m1EMyCmSAzAOTg2YXkAGqHs1yTz4p9TdhZ6HWmQhua
	 2Ex7R7Kq/HRvQ==
Date: Thu, 18 Sep 2025 22:03:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: andriy.shevchenko@intel.com, harald.mommer@oss.qualcomm.com,
	quic_msavaliy@quicinc.com, virtio-dev@lists.linux.dev,
	viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hdanton@sina.com,
	qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
	virtualization@lists.linux-foundation.org, quic_ztu@quicinc.com
Subject: Re: [PATCH v10 0/3] Virtio SPI Linux driver
Message-ID: <2b128530-ed43-49e9-a9bc-2736a2d13da2@sirena.org.uk>
References: <20250908092348.1283552-1-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ql5mcInMSvUHTFGF"
Content-Disposition: inline
In-Reply-To: <20250908092348.1283552-1-quic_haixcui@quicinc.com>
X-Cookie: Victory uber allies!


--ql5mcInMSvUHTFGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 08, 2025 at 05:23:45PM +0800, Haixu Cui wrote:
> This is the 10th version of the virtio SPI Linux driver patch series which is
> intended to be compliant with the upcoming virtio specification
> version 1.4. The specification can be found in repository:
> https://github.com/oasis-tcs/virtio-spec.git branch virtio-1.4.

Does anyone have any thoughts on this?  It feels like we're mostly ready
here.

--ql5mcInMSvUHTFGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjMc78ACgkQJNaLcl1U
h9AoFgf8CxaSKWRQTF2EIc8YZmt6WWiIcgEkmLizccfnEBPfQUDBpvLhSPVaBd4+
VjpFlnBb6Yy8CiIIGKL0pU5M+5bO8oFY+jMr/OGLe+MR9ZvEJ1FrZ0/cQ8Ib4XIB
a5uMJKDNfhj68a5LIiY+kYEoZb8R2vSRegaEUisnMF336eGvCKMMXNPMREwXMMlY
16VZ0u/0LvCXqHg3/hbMq21ifDS9OYwMdswOgdyQsYbosvNI/D40Tx8UUGRUEcT7
FFqY1JU9FqNCDdFnOpDcDqG3ztm17xD9dGzwS+IXquFgP6CeA+TgwpFBCKbrmJDY
rTW+PGucJ4kFLHaqZhOkT+veSzPt+g==
=a5Fe
-----END PGP SIGNATURE-----

--ql5mcInMSvUHTFGF--
