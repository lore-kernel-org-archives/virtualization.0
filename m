Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC225380FCD
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440785; cv=none; b=lNvk+7ugXR1dBfvwWhUN+Pek/OVezBoWVTS/dvm/QGb25zHVhWoI8DT4aHCbpVB9kzWu60Sc4Pitffkk8PFAF3U602uKRxNKOnRwRn7DWVKYT+2PfyDVT9v56fV+ZBkSeCEMDoYHFvX4xkUjkAuttBEvLX6Ki62HQvUas7BDWYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440785; c=relaxed/simple;
	bh=VD5Gm+hR15ohJ5wVTjgweg6mMAFFp2xYQK7jmt6Fwt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QfbUtWjBEJbCO67QasY5ej7dXBtI3Wqma2Wjh5Y6rCGM07Ju/TkICE2a7/WawCxWlgv3kB29JGZUklCUKlBO95+iuQ/Er2Sx2WkOyJV2px1VHXBQTiQGSuCG8MpTijldjNY6ttgtW2cKdBbrRUAY/NPLjfOAvdzTUmx7xPlTP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqQk3Jb2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqQk3Jb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FAE1F000FF;
	Sat, 26 Sep 2026 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790440781;
	bh=VD5Gm+hR15ohJ5wVTjgweg6mMAFFp2xYQK7jmt6Fwt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqQk3Jb2AMUp39KSzyyV2ZYAtxsdRvTSqT2kCAmjswk0HtltsP0xeAqrnGfFG+t+z
	 tuY1grYCSWc+v0N6lsYq+WZdFUfTROdk+01ezQ7Z/Pbfj/I/ZiGycjO9Sre48LAmta
	 0LpdRsJW4V5LziTbdYsHVKorHezvZ9GkPamb+ZeLsfsn4XAAiFLoUJlixcpiHtkf+d
	 Kj9pcs2HJFWj1J+S1wBA3JGI/7zpymHSwypAUXgz1JvN9nXSQF6sgxtk8JrE+fGx4L
	 yaNlIo6dHrN2AznsNLr8mf9TwRRpR1NsSg2r35n8c5s9c1FQCQ6L3lByBLmRoLtTf8
	 0803ndnE8hCVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] drm/qxl: wait for pending commits before
 applying DirtyFB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dillon Amburgey" <dillona@gmail.com>
Cc: dri-devel@lists.freedesktop.org, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260926163123.39217-3-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
 <20260926163123.39217-3-dillona@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:39:41 +0000
Message-Id: <20260926163941.76FAE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The modeset locks protect software state, but a nonblocking commit can
> swap that state before its hardware updates finish. DirtyFB can then
> race primary-surface replacement and draw into the preceding surface.
>=20
> Wait for the current CRTC commits while holding the modeset locks before
> checking the primary and issuing dirty updates. Return wait and lock
> errors to the caller instead of reporting success.
>=20
> Fixes: 9973c879cff7 ("drm: qxl: Atomic phase 3: Wire up atomic page_flip =
helper")
> Assisted-by: LLM sparse
> Signed-off-by: Dillon Amburgey <dillona@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163123.3921=
7-1-dillona@gmail.com?part=3D2

