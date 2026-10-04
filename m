Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7494503E1
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117980; cv=none; b=kj+Qo+sHYTWLQXCk3fBtHVv9XL1CAPNOHYZ5YYR5cpqbkrqWw8b0DEi/SVu8nGlIm0QEdyh4yt+2JbwSkH8i9JLaOBiOEIFo3X1pTWQ6k2mjNErr297CT2wcXMGBgDKgvkmV6kgwIevreBDjZ0Le8KtYYWZ2Qmh23ccu2qxBNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117980; c=relaxed/simple;
	bh=qozKKlSPatNjuYHtslE+Lc97Lg4Yb3+Q47WBuBlYdMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aE06dAC9ZY8mED383AzW0wByqsHIil2neSxaaiMoqmXHEnwAl4vh5lgbsD0WqTbLBW5GluuO9V8Ume+kvgCFRzauSuQrvaXsezfN1H4z3cuP0Yh5fmvIrpxxCE1DxCyRRGxGVqUCu+C8gQ67+0dy502cqEFYSV4B0BrpzbttvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipvYyvKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipvYyvKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D991F000FF;
	Sun,  4 Oct 2026 12:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791117977;
	bh=qozKKlSPatNjuYHtslE+Lc97Lg4Yb3+Q47WBuBlYdMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ipvYyvKwODFbFhjqKpWBnNlOnYXzJwHWOqLc3v9xh08Ezc8mekxC6KESRfSeCztk0
	 KRm5yOvLWYstVTT8kc3qiYMFv8yt/Qru6GCECUtAsSYaGgOo1fmBynKy9E9wNKck6C
	 /EWFPsMaki7P60GB91nndX9KIitnyPILz3r66qqDzwkvXALGWsuyDshgQFW/dDgDR4
	 sJs8zRkcGX8N6qpRQ8YXf63Mocgsv59dcU+o9C0Njr5kejfCngYJep3UXvt/GAkofA
	 b7ASIMA1wL8r0tqvBC82nHtR+juiG/iRfywCUiMP/ZKv/bPi7bOSgAWvOAVsBHLxXl
	 ue4UqxtZ50Yag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtiofs: validate fixed-output response length
Reply-To: sashiko-reviews@lists.linux.dev
To: sungbyeongchan <tjdqudcks0424@naver.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261004123405.586168-1-tjdqudcks0424@naver.com>
References: <20261004123405.586168-1-tjdqudcks0424@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:46:16 +0000
Message-Id: <20261004124616.D7D991F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> A short successful virtiofs response can leave the fixed-output
> portion of the request argument buffer unwritten. The completion path
> nevertheless copies the full declared output to the request destination,
> allowing stale allocator contents to reach callers such as
> fuse_statfs().
>=20
> Require successful fixed-output responses to contain their complete
> declared output. Continue to permit a shorter final argument only for
> out_argvar requests, and do not copy output arguments from error
> replies.
>=20
> A header-only FUSE_STATFS success returned stale fields in nine of
> nine calls across three boots. The patched kernel rejected the short
> response in three boots and preserved complete replies and existing
> error controls.
>=20
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004123405.5861=
68-1-tjdqudcks0424@naver.com?part=3D1

