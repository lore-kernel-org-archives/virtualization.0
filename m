Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051B148E0C5
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791311778; cv=none; b=ulssiby9xy0kKb0YltGz2P7W0A9AHfKst70A93+dDajvj201BqpIjJoBk0izzxaMME+2ZJHPWNTUAWbwN+1ZxFfuct5jTU04FK+ogfCx9tbe3h597K2jxNv20bLpR11T0VAdFR/HbUSCQbUT+/xHaIVYskUkWxFKdeatsb/bM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791311778; c=relaxed/simple;
	bh=GdL21/BK6UCZNShVB6rRZAFnsX7mhzOyuEep2krkc9k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NM/Urq9BRC1Rkb998ifMlHp3EQInqBjuvxv48sojugRouy/m8DJNu1YQXy4yzA5Q3e1Dv+TbTzIjSEYzsPoZd7kwnYi/apJP5OHdytPTLv3pY67i5RCV+WBtrk+iEwCd8FLNL84T5ErKbM8Jycvz4jP7+P7D1oZZ9wI1jvj+5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jec3sEIy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jec3sEIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5071F00906;
	Tue,  6 Oct 2026 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791311776;
	bh=GdL21/BK6UCZNShVB6rRZAFnsX7mhzOyuEep2krkc9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jec3sEIyK5ZQ0kmKl/PxBJZLjRz381Bos5Ip3q3/stGk91GiAnnB4lRDJnMjtZkQN
	 YulnLzfrS0TxOJS5+F8SzqmXRjIWPY2Ppd3W6VJXsyf88bXFZrMkI3XFxzrQhjM/+h
	 vb+fBrP1B/W1AOZ3PeCi+cFKaV/0kYgG3llTgidphGj1KHMlWYy/z9V1JUbo0SrkzQ
	 gus7cryzTM2Ev8mOexk0/rUfPlXy/wAMI8wp/mEKQaUGOY4p9UtW2utDVEkM2t34Ei
	 H0WWYlx7iAUMPtIz2Q2d4NPeiBjQIBe1DiiCAJwwe9YhK5CWTiLhkrgv2POw8UuYh8
	 Fqf0ZpyQJt7yA==
Message-ID: <sashiko-outbox-162358@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virtiofs: validate fixed-output response length
Reply-To: sashiko-reviews@lists.linux.dev
To: sungbyeongchan <tjdqudcks0424@naver.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261006182408.1301152-1-tjdqudcks0424@naver.com>
References: <20261004123405.586168-1-tjdqudcks0424@naver.com>
 <20261006182408.1301152-1-tjdqudcks0424@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 18:36:16 +0000
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
> Assisted-by: LLM
> Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006182408.1301=
152-1-tjdqudcks0424@naver.com?part=3D1

