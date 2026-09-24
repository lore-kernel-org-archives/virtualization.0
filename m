Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6AA33372A
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266775; cv=none; b=iy2TyzyKEtru0umwn1XGISDPbImVjlnC34jyRBIR0GdWZ47pOXk71YC63KTzkCK3cGN3Hdr9ycpnvHGeHxJMkW5Ky3ad63KlhstB7sReI4azzxL9OT7yxvCxDlVPJLHSQZlz+PmEeMGosRoiaf0bXap51zcuD8yxMnepcD/lkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266775; c=relaxed/simple;
	bh=QCa3b9XG1XroOH0eYVZZCH2QrHuqyuzIJtFGNO3D5Xo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mfjtcyLF502kskLemV2zFSXogNi+NREtUMS5s3IOpbUGdRXgUTIZE52hgFnLdfL0F5mLs6SADHvIoFECWdJWXtwnIFxWh4k/LnCH4sSe/IIpF0DCV5E2js6VbyIgEni1cGYw6+2k6rxDR/8petBSKeQfzSvYouWxQyafMx5ZpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5oMDfCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5oMDfCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B001F00893;
	Thu, 24 Sep 2026 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266772;
	bh=QCa3b9XG1XroOH0eYVZZCH2QrHuqyuzIJtFGNO3D5Xo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R5oMDfCVrftTBnm15mlCmUIO9PsQ5tP4VBCHBIeCBu0VzmAGF60bommN8poKf0yka
	 E5mY1qKIh1XI5s6hwSXiMxvd6oFmTGP7aj1gjJajmciCmMaKbh5akhhwHm9RA4YEn7
	 tLosFbjRvVpiY2JJLyNDlJiQB2hJwb+bCl29LFdjlFo2hCaUPbHn+aUxP3BG5EAbkc
	 cJpopdxWRFD6JVqz4zbInM7iPqtcDHS47CbTFvHmoCd/XfQ4cp2a8h1RwJk/ojt3oo
	 ToQBj7il4Da8GPqO1S9xl6Wzdo5E7qx/JSbfGb4avn4cuiTR0XzCBXSrrmmvTodgCC
	 Ggq0Kl8IOQK9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] virtio-usb: add OTG role query support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Skalkin" <igor.skalkin@oss.qualcomm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260924160907.145405-5-igor.skalkin@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <20260924160907.145405-5-igor.skalkin@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:19:31 +0000
Message-Id: <20260924161932.34B001F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> With both host_role and device_role negotiated, a port's own role is
> ambiguous (host|device) - determining it requires more than reading
> the two feature bits. Introduce a minimal OTG command/event queue
> pair (otg_vq_base, otg_vqueues[], otg_init()/otg_deinit()) and
> otg_get_role(), a synchronous VIRTIO_USB_CMD_OTG_GET_ROLE request/
> response exchange, and query every port's role individually during
> probe instead of the alternative of overloading the config space
> ports field with role bits.
>=20
> This replaces the previous commit's DEVICE-only placeholder for the
> both-roles-negotiated case with the real per-port answer.
>=20
> Signed-off-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924160907.1454=
05-1-igor.skalkin@oss.qualcomm.com?part=3D4

