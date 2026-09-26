Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519B3815D2
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440922; cv=none; b=O0EkOEKNzZPnunoYlwTj9CTGI9sqNgy3q8272T5uHSBgNtrVCUwaj+JcL/OnvH9h37HPuzw+sDpx9bUSumdCIqblYDl/h1uBacXvH584PNY37kUVmbN+wt//rK5uNpLFWxT3+IsP16u7GIXwNaauWp9muowYEe/tnk4Ebzm2E2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440922; c=relaxed/simple;
	bh=U89+kmtfsOWlRFigA3CHEGQ2aPXOnjJ5VGEkFsbUFxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n0+sQwTU6SdHP10N4bluvLl/oMDq8WfDVlAzIBxxFutqwk4hF/HoA3akQYNyizMSTr1yP0TBfy9+eAFdETxhZ/UO6kN7tW8FSv+piFJl4rdUoeB1MPe6pC59GG0RZJ5HuKE9f06a5byTK7Rm5nIjdzmca7mM2T4EJfVOeYfbgnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc3YlU+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc3YlU+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E801F000FF;
	Sat, 26 Sep 2026 16:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790440920;
	bh=U89+kmtfsOWlRFigA3CHEGQ2aPXOnjJ5VGEkFsbUFxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gc3YlU+Yr5R8VzXFSSDTF2gVpx4HpXhK5sX2IIOrUZoN0Of0NnrwlUWIjs/rSZzCU
	 xq9nGMeBevFelRBGZWMqGBGFFOU4F/Ws9W7587QgDMkedQ7f2/NanqIp7o/WsEQpL+
	 eajpnsr5xph/ob0jaj+pvEGquSDKbvo0I2Eo8pBTIl/4R1Wnaten/ZPugAtNFmS0qH
	 WSTOh//zPqS9z4d30AYKvnkh5TMutDS24rXnLC9sk5x/atfwAHyZqyJdwpUBzVjI10
	 Mcn6J3rumdcE2W/bWjC3YUeKs2y+JAB1IiZBnlIEHgEyJ9PMm2HU7dXLY1CZdf99Nj
	 s+6yIAnUXq+qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] drm/qxl: own packed primary shadows in atomic
 plane state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dillon Amburgey" <dillona@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260926163123.39217-5-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
 <20260926163123.39217-5-dillona@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:41:59 +0000
Message-Id: <20260926164159.E6E801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Preparing a dumb framebuffer changes device-wide layout and BO shadow
> bindings before the atomic commit succeeds. An aborted preparation can
> redirect live framebuffers to an uncommitted shadow. Per-plane cleanup
> can also remove a shadow binding still needed by another head using the
> same framebuffer.
>=20
> Give each prepared primary plane state a reference and pin to a shared
> shadow. Compute the complete new layout and prepare one matching shadow
> without changing the displayed states. Include all primary planes and
> CRTCs so replacement and repacking redraw every head under the same
> commit dependencies. Release each state's resources independently.
>=20
> Keep the primary while any new primary plane remains active, and destroy
> it when the last head turns off, including DPMS with retained framebuffer
> bindings. Route DirtyFB clips through each matching active plane state
> to its packed slot; copy clips before the draw helper translates them.
>=20
> Retain allocation-based packing and full-framebuffer drawing here; plane
> source geometry is handled separately.
>=20
> Fixes: 90adda2ce898 ("drm/qxl: cover all crtcs in shadow bo.")
> Assisted-by: LLM sparse
> Signed-off-by: Dillon Amburgey <dillona@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163123.3921=
7-1-dillona@gmail.com?part=3D4

