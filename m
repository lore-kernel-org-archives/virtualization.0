Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052213BAFF
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Mar 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546061; cv=none; b=axjY9uhurnG/PAhqmSC9priloBZ9jOwmjSzwFssGpbqmkR97O5fbaSvgGbwgfuyy5d3i3Vja2l5hNoKKTeIHVF601sZm73gGsEhtb1O1BntnGdyX2PoJ9OZfM4iIr/HCUT4krLXJ6tkfWUaGhjPFFcBUNUm9+PiwrgA0TsqSv90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546061; c=relaxed/simple;
	bh=+fnPEP5LofR/YkwTOOjws1iuVa2ieMZ1vJLvtYNQ7OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNvQLe+h29UdukUb7WjyLkjs5LmjNO9h8q6d3wF7TKBSMW0b6b0r8GUZyeLp3bjVV2aT2PjHW+dTbwvPJycZkLBaVp3XVWNfpD5RM04Lze7ZZ8O5PjXiYLCAgQeP5l7uMCghY5wViE5laRuh433IfuL6NixbRBlV1Sbcv+aLb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4cYrqgk; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4cYrqgk"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A3564058A
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Mar 2024 13:27:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zwMoQ_ojjhys for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Mar 2024 13:27:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=mripard@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A023740589
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A023740589
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p4cYrqgk
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A023740589
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Mar 2024 13:27:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 632E7CE1DB4;
	Wed, 27 Mar 2024 13:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527BDC433C7;
	Wed, 27 Mar 2024 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711546051;
	bh=+fnPEP5LofR/YkwTOOjws1iuVa2ieMZ1vJLvtYNQ7OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4cYrqgkZ5yR7qOyVmXAK6DNicMANTj9MoO3Ly2aMyd9olFbTRqMM410U7a1HbqBF
	 BBGyKztQYn+jgZ0gMdHhmWE/CQLavoPNnnA77UiTkS+Jingwh7g5AVE4tP4G4e+WFy
	 azkgCGC3Mk8wbHHnbmmKObNlVP5pDWzqdhqh+HAXPE8o+1l+Hlu8tswxiaVM1Ul+v3
	 UZIRARydgHnI7ECFVslwev4AIl3+vH0o85jzBa4zAD8XNfd936b14q//9bEplTNQEs
	 DOK3S7d/FoKpW3V3bjlb0IdnyLScR5VwaGAJ1kq+XFnDpPAL50yEJQi08FswygCuFA
	 RH7g1qmxJ7Dxw==
Date: Wed, 27 Mar 2024 14:27:29 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Alex Constantino <dreaming.about.electric.sheep@gmail.com>, 
	1054514@bugs.debian.org, airlied@redhat.com, carnil@debian.org, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	spice-devel@lists.freedesktop.org, timo.lindfors@iki.fi, tzimmermann@suse.de, 
	virtualization@lists.linux-foundation.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 1/1] drm/qxl: fixes qxl_fence_wait
Message-ID: <20240327-cuddly-smooth-trogon-59c02d@houat>
References: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
 <20240308010851.17104-1-dreaming.about.electric.sheep@gmail.com>
 <20240308010851.17104-2-dreaming.about.electric.sheep@gmail.com>
 <db4c8e74-5c79-49be-9781-a5d8669eccc1@leemhuis.info>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="odhn7ryspel32gtq"
Content-Disposition: inline
In-Reply-To: <db4c8e74-5c79-49be-9781-a5d8669eccc1@leemhuis.info>


--odhn7ryspel32gtq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 20, 2024 at 04:25:48PM +0100, Linux regression tracking (Thorst=
en Leemhuis) wrote:
> On 08.03.24 02:08, Alex Constantino wrote:
> > Fix OOM scenario by doing multiple notifications to the OOM handler thr=
ough
> > a busy wait logic.
> > Changes from commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") w=
ould
> > result in a '[TTM] Buffer eviction failed' exception whenever it reache=
d a
> > timeout.
> >=20
> > Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
> > Link: https://lore.kernel.org/regressions/fb0fda6a-3750-4e1b-893f-97a3e=
402b9af@leemhuis.info
> > Reported-by: Timo Lindfors <timo.lindfors@iki.fi>
> > Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1054514
> > Signed-off-by: Alex Constantino <dreaming.about.electric.sheep@gmail.co=
m>
> > ---
> >  drivers/gpu/drm/qxl/qxl_release.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> Hey Dave and Gerd as well as Thomas, Maarten and Maxime (the latter two
> I just added to the CC), it seems to me this regression fix did not
> maybe any progress since it was posted. Did I miss something, is it just
> "we are busy with the merge window", or is there some other a reason?
> Just wondering, I just saw someone on a Fedora IRC channel complaining
> about the regression, that's why I'm asking. Would be really good to
> finally get this resolved...

I've ping'd Gerd last week about it, but he couldn't remember the
details of why that patch was warranted in the first place.

If it works, I'd prefer to revert the original patch that we know used
to work instead of coming up with some less proven logic, which seems to
be quite different to what it used to be.

Alex, could you try reverting 5a838e5d5825c85556011478abde708251cc0776
and letting us know the result?

Thanks!
Maxime

--odhn7ryspel32gtq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZgQeuAAKCRAnX84Zoj2+
dtzBAX9D2qc3cRTI5gt0TJbZn+B1KZluieFl8m0F3A4+AMDS3Evkhqnpw13peeHP
19X3+xUBgN+7f0zhgWoJGzvnglkgra50VOoD9JZHUkmxpgZHXMavpspIDYDdwpKe
xEgQ8lSVDQ==
=4Ivy
-----END PGP SIGNATURE-----

--odhn7ryspel32gtq--
