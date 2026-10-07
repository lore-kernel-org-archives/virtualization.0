Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E54071D9
	for <virtualization@lists.linux.dev>; Wed,  7 Oct 2026 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354754; cv=none; b=H4ARh51ii3BziDR/823aKw3b9XGb19yKAJ1CnGS20A+GDDsaz4AydmdIEG84AioNdJG26chY61oHisUsMTmH76/D+QPUgV9J3F47qz4OLWYoXUZqjXMZ8e/l2FRX3uVe4Ry3q/0irCx8hl6e6Mba8x1u8+bfPkVZX7WT35AtOa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354754; c=relaxed/simple;
	bh=Ug2JTHIcarjSUIMVMkFRWO40OAswhYUidcPC5miPOSY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rXqd2gJIkoK1edVyLENsV24iMdam4jzgx2s1uye2+JDWGzShlf85nvKsn4wK2s4BxRi5aZLKFNzVG0LXgMOyfm0M1lNlGHiA5sP1fms6HZA4c32ncDvJkLFBNRMppbuEbnyGosghfPZZherFeCFwtpR2v+FoAOVTD+mPsrl5bJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXA8Q55a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXA8Q55a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F461F0089B;
	Wed,  7 Oct 2026 06:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791354753;
	bh=eP8S7IjyNwtr8zHEgxs2pWVX+PYJ88efwIbTh9e6zhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXA8Q55aQakBCbBCzptOWl4YDmSzAB5ekL2nGuS8lXeNSINh8mOdzeaIpG+s9fnMn
	 CEaoifjeCtQMVeyDnYzezuDH/b2HLniT50y3tGSa7G7PFilwm26mFLX+urLmziOUva
	 nByj2w+HJzbGc2tOVN6V5Z6OL9IK2Ggd3/rhWCXcSI1WljqxgWbg6OJi1sN9Izxnmq
	 ksUIwxzvHPjAbvvciAGVzYOCjE5NFttqm7gC86tU1zMsLLOSm6gI6IJp+3Hz8z/d65
	 B/c+CTBKvOmU9FlPnkHroRJVnbdOBzMS6SbQWNFDpyM63826FyC5cnhMasVwcYj22P
	 /vJKy+s6uVsww==
Message-ID: <sashiko-outbox-162671@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] virtiofs: validate fixed-output response length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sung Byeongchan" <tjdqudcks0424@naver.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261007061949.23008-1-tjdqudcks0424@naver.com>
References: <20261007061949.23008-1-tjdqudcks0424@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 06:32:32 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> A short successful virtiofs response can leave the fixed-output portion of
> the request argument buffer unwritten.  The completion path nevertheless
> copies the full declared output to the request destination, allowing stale
> allocator contents to reach callers such as fuse_statfs().
>=20
> Require successful fixed-output responses to contain their complete
> declared output.  Continue to permit a shorter final argument only for
> out_argvar requests.  Reject positive and internal restart error values
> and require valid error replies to be header-only.  The error already
> stored in the FUSE output header is returned by fuse_request_end(), so do
> not copy output arguments from an error reply.
>=20
> This was found by source review with AI assistance.  A header-only
> successful FUSE_STATFS reply returned stale fields in nine of nine calls
> across three boots.  The fixed kernel rejected the short response and
> preserved complete replies, valid negative-error replies, and
> variable-output replies.
>=20
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007061949.2300=
8-1-tjdqudcks0424@naver.com?part=3D1

