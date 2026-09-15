Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B8480DEC
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493986; cv=none; b=CPfYlwQbQO5t/Xs+XAm+sm55KreQst5PsIyzH91ahQNLBC/MBttcS56otRf2QmNgvfKPKppBb+0dBwp2+O3+R6LmS484PRhOU58+weYQqJwD2pW9PNOjLPO0lUO/MDRQh8RY+5MJCKW/UTr4d+jXKpWw0QzpgnF7gLaOfTdnanA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493986; c=relaxed/simple;
	bh=WmSVMac8+SLORtYWIrK46gQF9Y15l2xygPjfBQmxAOg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BtJqu2dbUzlgVIQa2Y22fthHjyJy1m7a0FnF/nT3l+x4r+llhkJii3jq8Mb+NiiRXjFq6Jdb8BkCQ9F+TxHrLhecXSp+Tf5G2FBAC9zbju1EG71qfxSXt6RBykj2x4gD4iNE3HnB4MBY5X4Q4ic0JTQVhQUdaey4+oscgirfVKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/IFBRLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/IFBRLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A5D1F000FF;
	Tue, 15 Sep 2026 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789493985;
	bh=WmSVMac8+SLORtYWIrK46gQF9Y15l2xygPjfBQmxAOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K/IFBRLhyyMLHplXRFYzJNDK043uuOMwAnfn7sJhx+T8RVsnhRPB/Z/Ya1t7eNahv
	 Kgm1bVFpXHq+qhVRqe/kgbH1A1lwuCDjQRllC1J1xGBK3sW2yB1F8oLD6vT9QzIOa5
	 DKQwdZ2Nr3HdmN3xyMldGRRZlNUxTC+2JWbi5RagJveQQXgu7m5Kfv5jeX270yyt/o
	 vuBY6eh/Ol9VIweDvlGTKQMoQ709zMt4EZDSzEttGxb8qpxNxWAwa2J16HRLTTICvL
	 IEUoYXQnkqlWqiWVgXbmHUhL7MT/WzOATGkFx9WjDgwGs8zG8J96WqnGzTe8XRrE52
	 afHdBRDHtHTRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] vsock: ignore empty child namespace mode writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260915173050.3176344-1-qwe.aldo@gmail.com>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
 <20260915173050.3176344-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 17:39:44 +0000
Message-Id: <20260915173945.04A5D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> __vsock_net_mode_string() returns success without updating new_mode when
> the transfer length is zero. Its caller then reads the uninitialized enum
> and may permanently store a stack-derived value in the write-once child
> mode.
>=20
> Return before calling __vsock_net_mode_string() when *lenp is zero so
> that the helper is never invoked with nothing to parse and new_mode is
> never read uninitialized. This also prevents an empty write from
> locking the current mode.
>=20
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915173050.3176=
344-1-qwe.aldo@gmail.com?part=3D1

