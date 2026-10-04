Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A7F3F44C1
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791125981; cv=none; b=ayZNBm/57u65uwWA065PjFT/fVnEtufBrAao4nA3StSdAT5NaZ/V4XOF7fU/wf40hXl5EJq73daUlUZvIAt153RIrP4U7KvF7I2R5lJZmZZzpY0D2KIRIBKZgd+E0NT9ElJI8xrP0M5lPX74Z3NPvAs4rtI6oWcG08c5XypXOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791125981; c=relaxed/simple;
	bh=4ijVm7F9GG/hbyomP4tFcvhpUMw7ufLYreCayPTVeu4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O7YE4cfOuEM3HOOy3oMVGIupyBVOXVdNCExM9FeEL1JIm+b2bATPnpMWG29fn8wYKyWIGkG3fnXblDG9482laW0YpMFQ2J5WfquEnLDT5mycjbZ91kZzsjqgIo8Xp+tHOBMuyLSLqwmJ7Whnh1PdzylMwynwlwnH3XzUiw0SCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKqmLEw2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKqmLEw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AD81F000FF;
	Sun,  4 Oct 2026 14:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791125979;
	bh=4ijVm7F9GG/hbyomP4tFcvhpUMw7ufLYreCayPTVeu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKqmLEw2pRfYRnUfv2UVVKZDvT1xYLv17rVZX7tQXYQuNm64Rv9NYJNzGgJqrj3zF
	 AB32P2HVFxITnfLgkjHxg9hiJv2gp9PbO5CM78T98iKXjwgXxnaPu2Kglx8dqxTR8Y
	 8sTnUwfrXbfTUC/wz4hBArUytEJ8aopoGF5QsjN5VtGRp5jFAFYru2CtxbgwqdYEG6
	 QzhbeEBllhQKSiPWTZelqJj60aH+UO1L3qhNuAVu+oyk7sdthhKeAz4h3DXNV3lZ7u
	 P9LNFkSH2ZD4XiUdYTVElJVZX5CWwJuEyKfrHKThFF5TGdd1bUBcNtmGylwezyhn9T
	 mTogyux0YWn0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virtiofs: validate fixed-output response length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byeongchan Sung" <tjdqudcks0424@naver.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261004144801.663923-1-tjdqudcks0424@naver.com>
References: <20261004123405.586168-1-tjdqudcks0424@naver.com>
 <20261004144801.663923-1-tjdqudcks0424@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 14:59:38 +0000
Message-Id: <20261004145939.54AD81F000FF@smtp.kernel.org>
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
> out_argvar requests. Reject positive and internal restart error values,
> require valid error replies to be header-only, and do not copy output
> arguments from error replies.
>=20
> A header-only FUSE_STATFS success returned stale fields in nine of
> nine calls across three boots. The fixed kernel rejected the short
> response and preserved complete replies, valid error replies, and
> variable-output controls.
>=20
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Byeongchan Sung <tjdqudcks0424@naver.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004144801.6639=
23-1-tjdqudcks0424@naver.com?part=3D1

