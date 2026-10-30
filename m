Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386450;
	b=SRtI1ZTvl/6PShapJPWQWVIKB5BaOT31WyWiwvGGxk7jFs5gyOf1AM86RKiHTh+KDJrQ
	 34TlZDU+0MyaoWBPhjeJyXcbPzUgsogkGWiZcZUXGIpyly4KFetEHsFrfOpUZtoenUjED
	 QwCO5AwpywQpHmUIVpGq55VVU7Y9YmRqtINQF0OZb/hXbGwAVadhRjPTi8VPlq9nWzFVn
	 e9pT8m9nDHor5TBIu09vey6OKq7BLTiamlfJWkrP8+bIOPK8b4rhQUs6aGSzi1DcV1sCx
	 la54CbJLW9jA6cbAFC6FS80KaIXGUFosWRO1K0BTFRpQteoUau8snDC/HFErfnuiFLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386450;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+us3svZciqXLyX4HNandAVGuu3KTVxFbWEz4mBIsHKo=;
	b=pbHC/8+BC0n3luM/aSufhyTZxLwzWG2z2n2ta2VhQwDohudlgtdU6CgM+wbGIwW+/njD
	 2bBu4J6kn3Cuj6fw/6qbAC2vMCg+Y0nQn6BEd+MPcO40gEghvDUEg6POBvo3KvGlAa6Ey
	 Ah1vuta7YW0aDKiQHFNV5VPef2ees0PNOuLA2rnstR6DqnV60omOzU+hFDUMiVov6J6F5
	 tRexHG+PJvqFsSTFrLjs3ufuCBRjMPovghTEnXq5aKsd5fI/MmVFCkKYPJttiu27aFBfa
	 MXzaeggAo3ZfsW4Dn/FhSI5yt0MFtl9yJUDi5lFwpd6TsiKusXUnn1c28Kblx5Tpkeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEf3u2dE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B28606A31D
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEf3u2dE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF681F0093A;
	Fri, 30 Oct 2026 18:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793386449;
	bh=+us3svZciqXLyX4HNandAVGuu3KTVxFbWEz4mBIsHKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KEf3u2dEnaYyEGQJ8OPafhgX1n0iq/yggqynRDijesaaTPPFZjBKJfkV42989QBV9
	 pwyYzbMCcXHWfSqg+EquTJ4z/rFpv417gtimG/G6gvwnI/cKutBkT+3qhChdslfd65
	 Do9p/IdTp+FsdD9etFDcB0DGg9VbdRcIuHz0pC5Mz1vhNB2z502t5fwvdDNQycv9MJ
	 6nbKHaQ2OausnMzE0c555FY7Clru1JSMr2XuNkRSEuZQHHBmUr9YLQ45G5X0/YO6tG
	 WeCgfUk+Wsofs9wInzto2Rv9H2RJfbl/A/cYkmjGfL1mlIusTKz1eEhFiCSzrI9lVv
	 Ya7Wxi3VSn/jQ==
Message-ID: <sashiko-outbox-191418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v7 2/5] um: vector: trim skbs before verifying the
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <d5a36cae5997d36ae6b4bb192a251194e61a8a2f.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
 <d5a36cae5997d36ae6b4bb192a251194e61a8a2f.1793276116.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:54:09 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The vector receive path over-allocates the skb and only trims it
> to the received length after the transport header is verified.
>=20
> A follow up patch will complete the packet checksum in software within
> virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
> checksum would be computed incorrectly over the unreceived tail of the
> buffer).
>=20
> Trim first, so the import sees the packet as it was received.
>=20
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/305bcadb19f4a539a31=
8c6b87c829fbe43d0ffdb.1793276116.git.mst@redhat.com?part=3D2

