Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386452;
	b=J4gAvdH2V5pFubOm32vPYUrip0DVjePVNzpNqN/glpXswgF2f9nKAiYdnFDaaaTgK0CT
	 INOG16wabZj+C0bPvHJUo+g+smo+JBtkTaAhF2wB2v53PFRH9rICa43ipdsFCS+LBxrCk
	 uomxOH0kwvcWXhY/WKQWjLg3IVMfQsRn9UoJAM7DB5YMxXv0dfGRpbUSX9zc636l273OB
	 Hlj3/bosAJB0prlshB5jGnPPOGQY6YMOZvPMZtRGjEvIVspLWf6Z4wUp0hL4Y6xTD7W7k
	 xqTXXflSVVhVoA4Hq9sokO0u2rX2MaYbo0hZ6/0C33oasxYoYJwpS9fAVLSzW0PSSuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386452;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Stie0N+CoVJT4reoqnaCFilq4ru1mDZF+kqZMWGckt8=;
	b=Ckmu0G2MWZk2vZgwVjK23Ru+CD0xZHtLPiBNsq+cHgJ4xbOI/8dMuZiUKsHINoHot5A2
	 r3GZA40YBnHbOkftRojA1MdD67+37vL6vgXII4KjEyUJnYHXY/gh9NrfhRAOR4/4TZ/4T
	 FKY5fUztT7c5bfisywQAP+ivF5RdQwdqExjK6ZMXhlVmpu/QfvgSuw1HAAJJF4t1MMula
	 GBmxTHaVCkUOUT2UGouLnJu0s+JIJU00jikMrIcMq4NfpPV7FBvjSm7MHJHP6eZuAW/0c
	 GCY+5G5qvLT2cF216LtLamVdq+nm9WT/h6FUHjc914Ct4JNr1NxCI5GTSSHQZlrSXHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRN+iK9N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42B606A324
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRN+iK9N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B861F00A18;
	Fri, 30 Oct 2026 18:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793386451;
	bh=Stie0N+CoVJT4reoqnaCFilq4ru1mDZF+kqZMWGckt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cRN+iK9NuRg6itXNOotSL/5uwQ7qPYM6rWA0HQ/zS8m0YrbHfSzlYcF16+Tj85sha
	 tAMm5UbhK7vowRQlp944wLblmeSdXN8uw9OuzCCab1yDGSifbxGJL2Mv6Sn1JwK0ai
	 wh2p41A1mrQPwSQa0ZKsTP79EwxsYkZiaF01AGsguIfas6syWJp1UAUCMyg7zU4U+k
	 aYRfCMJbnO2hWzbSOOop4bAIBUGBeIil4eAHgeiniVC0a2+vFH1F78cd0cJWD51hrT
	 cNggqXtv6icz/D3tSw4+mJ0L5uFBAg3AYqUS/t5/X5msu86eae4Tqt2PkQyorfGrHt
	 52RTvRLvAZG/A==
Message-ID: <sashiko-outbox-191421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v7 5/5] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <7ff59e838eba4b63768327dfe553d6d9cac6afbf.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
 <7ff59e838eba4b63768327dfe553d6d9cac6afbf.1793276116.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:54:11 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The ingress validation as implemented by the previous
> patch is stricter than what it replaced: GSO
> packets whose checksum metadata matches no transport header are
> dropped, and non-GSO ones get their checksum completed in place.
> Such packets used to pass with the metadata unvalidated,
> and with no overhead.
>=20
> I judge that this should not affect any deployments, but there is still
> some risk that it does.  In case a deployment depends on them anyway,
> provide a per-netns switch to get the old behavior back:
>=20
> echo 0 > /proc/sys/net/core/virtio_net_hdr_validate
>=20
> The default is validating.
>=20
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/305bcadb19f4a539a31=
8c6b87c829fbe43d0ffdb.1793276116.git.mst@redhat.com?part=3D5

