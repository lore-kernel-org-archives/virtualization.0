Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131667E99
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs1cYlmb"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53F0541E46
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 18:16:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53F0541E46
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Xs1cYlmb
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id txgINFdWDzkP
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 18:16:45 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 924F441E1E
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 18:16:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 924F441E1E
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 93C7AB822E6;
	Thu, 14 Dec 2023 18:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D50DC433C7;
	Thu, 14 Dec 2023 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702577801;
	bh=Pf8WEkmg/p1UYf/KczRbr+QOJbe21dt16Gmp2yRVACI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xs1cYlmb6iE360KCEn9ot8ir0F934QmsYPpxsI9nXVWIsHdKhvZo/9kxt9XNlUHt3
	 hOvjzMmQxEpGroOokP0vcdeW1Htb8iWrZPJCn9AeI/xDWA51wQqCdyboe583VmshfA
	 GuNV03mpyIH6m/08ygL0bdGmJTglSyt+zMr/LtgT0wC/WiVeBgt2ZFQDerDOD81xKB
	 Vv+hkIkS/gRNXNsmmev0nJXVv48QwupIEZSCtuiGVv1GFTjIFnLKgN3EMFYHtVAXdh
	 AB6WfjhBS0rChH8HPqbSFj8DU/U3XbmB+hWFFUi0kwuRhhPIJ6as2u85/0ahIx+exn
	 PsJI7/u13g/KA==
Date: Thu, 14 Dec 2023 19:16:39 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>, 
	Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v18 04/26] drm/shmem-helper: Refactor locked/unlocked
 functions
Message-ID: <xvo6rwsripjoiwazvjhkxvyleiexuhvclh7wvt5kuiw5cmkaa7@jgcdrtkzw7a6>
References: <kw5bho3jx73d3glvtewmjvqt4qty4khju6dcwypuh25ya3gi4b@7slmijjqdi4p>
 <20231128133712.53a6f6cb@collabora.com>
 <37208c72-7908-0a78-fc89-2fa9b8d756a5@collabora.com>
 <20231129085330.7ccb35d3@collabora.com>
 <ioqghyaeftyo7tuyfecn252ykxwgltrkhh2pwktjejqhewntbb@bym3rsjxnxfp>
 <20231129144609.7544e773@collabora.com>
 <6da6mzwfzwbn5rhiebypo5e2v6rhtpn2fovwvfnoo333zjgobf@bgtuwhum3trp>
 <20231129164705.7461a294@collabora.com>
 <jvhedgegvavn5mvvx2men2rxitvnq7u3dsxwfx3wokxldmysjz@y5av3l2w4gk6>
 <161189c2-db65-2542-5d19-77a56b56cfac@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mogag3hjc3jfzn6"
Content-Disposition: inline
In-Reply-To: <161189c2-db65-2542-5d19-77a56b56cfac@collabora.com>


--5mogag3hjc3jfzn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 02:43:16PM +0300, Dmitry Osipenko wrote:
> On 12/4/23 15:55, Maxime Ripard wrote:
> >> Okay, that means s/_locked/_nolock/ in drm_gem_shmem_helpers.{c,h}, I
> >> guess.
>=20
> DRM subsys and majority of kernel uses common _locked postfix. We should
> retain the old naming scheme by using _locked() in DRM. It's not
> worthwhile changing the name to a much less popular variant for a no
> good reason.
>=20
> Maxime, are you okay with keeping the _locked name?

Yeah... I still don't really like it, but you're right that it's best to
remain consistent over my opinion :)

Maxime

--5mogag3hjc3jfzn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXtGhgAKCRDj7w1vZxhR
xdWmAQCtgo8n/tvT2Kt3YvY+zwK+WyI5LucgGMiuXB4A1VJkmwEAgpA7YSFGzvRg
qhtdUYJJREmkWwghndQNv4kd/aVYhw0=
=rtVm
-----END PGP SIGNATURE-----

--5mogag3hjc3jfzn6--
