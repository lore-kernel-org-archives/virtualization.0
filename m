Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585FE4195D0
	for <virtualization@lists.linux.dev>; Wed,  7 Oct 2026 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412016; cv=none; b=ewIQz1AGrJr29D9Ti1gpFhE15K0dqCT+W7DvxiUGn6qNqPxhODKX21QgnozsA16LMUuspt0uXBPDDM9BNYapTAfq/KbweTXcMhQqIY379YislCtNcBOcKmXZhCR7zfnVfyqD1qFzQTgzINp+p3tl1Uoc0pGdMvlKNcCNgXaxbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412016; c=relaxed/simple;
	bh=wdpFw+0FWg90J2bNCbp3S6jUX948ir6CAlMfviI4umQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dfSQKN2P1CjP2Yh2HyXYLI0M4IG0DHk4lfzW7UhLGyjGx3Y60QnGqo6dwx0wmRGQ+nJyaMTEYpiiCQdGzgLRnHZ8gMznvw/W8JhP2N4yVTSakAm3G50dtzOgMuttFoC1cdzjYUkEvtjJlpttJFNqp0F+WdrPrvia3cmpgkTC0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+eq8uQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+eq8uQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A89B1F000FF;
	Wed,  7 Oct 2026 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791412013;
	bh=wdpFw+0FWg90J2bNCbp3S6jUX948ir6CAlMfviI4umQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h+eq8uQepAAe/GVD9dYfwVGCrzH2nFzEQnpNRtB1l3DwKYmCnF5Vf+pedZs9HLjgN
	 cKhxs/lh/EuJgXGW//GIvmCgqANwuxB59KMpkfOg+xnEi+f1zrBzS8dqbY798EBHiM
	 wcyLPGFY54k8JQ6VlXywszA7uRb2T7kxGx8xAwhH3iJYtT9MkE/opd8csAuYlRqRQ+
	 ZOJ4jyOHu2vgSabRNMlGraS2lOSVK9LSYFryUWoeuZqKgkKM/L0qLvyDXnCwuf9ifc
	 MXwzRL74T0wlDa6smD7vv2y+Y+Go+oSCeK7PZyLcBv8IUCwjX2Nw7Pqd1ZQtMvnGXC
	 7UYU5RYya+OLw==
Message-ID: <sashiko-outbox-163411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] Revert "drm/virtio: Add pixel blend mode property to
 cursor plane"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261007222244.295186-1-dmitry.osipenko@collabora.com>
References: <20261007222244.295186-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 22:26:52 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The cursor blending mode was added twice because the same change was
> applied by accident from different patches. Revert the second patch.
>=20
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: https://lore.kernel.org/dri-devel/ce84d3d2-e78b-4939-aecf-9ef7267bd=
42a@samsung.com/
> Fixes: 6947b78df4d2 ("drm/virtio: Add pixel blend mode property to cursor=
 plane")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007222244.2951=
86-1-dmitry.osipenko@collabora.com?part=3D1

