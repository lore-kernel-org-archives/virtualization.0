Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F43B635A
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154534; cv=none; b=itzm0DqA8f3w6GZ72BZxK4ti4vO/F283dcdb6EF4jhV3cpKB1ChZcdbEU33GyawL8c2XOLJfQt9VBiabSvIe2BfjJy2kr7VlCpuxAWW1IfgTp0A/w3J2567kxoyl06M1TPnMllmZ1z/PgGJkuM0fMsMDHL2IPeA3C5rHcc3+Fwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154534; c=relaxed/simple;
	bh=j4JiDda/YFoIagX73IEZN0L/UbyGkmuBieF00E1S/e0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dUTbDTtKfyJSpEAeUlO3SeCoOSnk3Np+xl8xj19qydiHC7T3yQarEYeGL7jQuFkGXKQFxCoSiAoLR+D/rtsP30X6731a26cgYxjSoFjXCntWnmcNAgzveN+GoHdJZO7yZyaLhLl3CMDSaEOU/DA/TMn504J6xlinIyYOYejWhR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqOS1Whr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqOS1Whr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4501F000C4;
	Fri, 16 Oct 2026 12:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792154533;
	bh=j4JiDda/YFoIagX73IEZN0L/UbyGkmuBieF00E1S/e0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cqOS1Whrt+v8LMW9MXRzBcWEmWlpI3WW4OJW+zdF0+9IrMzeIno7TQedzKBkEahC1
	 +r3eexB+aFNuudtjgpV+93apxj85/tOEh+dD59t4d2F1sFSZ8VNdIy1H5lV5Nw27Rv
	 Rwlg5+Fox0oQtk9gVApyiMGVGANwF0IaiuzlmFHDNWwRicJZghqWWTGCy/EOlRSgjM
	 FtTD+cQx3MzBdMGHmsz1KLMQAotZzpj/4XNJHQKzifGtcWlfcOalByvoyTeuaUtocX
	 UqDIHyAyYszc+JgkB/ElQhJEC9h8H46xzFlKDLDPGr5MNDv2t3/MMwtDuqk7GvCh8K
	 /kBwFmH66dflQ==
Message-ID: <sashiko-outbox-174319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 6/7] net: add ip4_parse()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <2645c102b2f73292d1973b82c95def24e48064e1.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <2645c102b2f73292d1973b82c95def24e48064e1.1792067836.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:42:12 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Multiple places in the net stack open-code the same minimal IPv4 header
> validation: pull the fixed header, check version 4 and IHL >=3D 5 (where 5
> is the fixed header size in 32-bit units) - and locate the transport
> header at IHL * 4 past the network header.
>=20
> Add a helper for doing that: it returns the validated header and
> the transport header offset, or NULL if truncated or malformed.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792067836.gi=
t.mst@redhat.com?part=3D6

