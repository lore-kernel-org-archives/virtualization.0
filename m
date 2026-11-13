Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575832;
	b=0O3P+6JAu1W58x0h79OitgfAOy7WbR+SOyR6tHh996DhzltPJ6nidysdinyLKNJMNbKX
	 VShKu3TydTc/v+WT7QX7xX0TWKVspPpFPvzT6MW3Fq2NiOvSp/52kVhb2n8TM6ocS36ei
	 T29Fg4a79A7oMdq4HM46Fc7KcHbiTlqJ6eMHbKwHQPDd2bA6NUiyCHO9DDAUlUdD+QwCR
	 9+eNceIgnR2pYRD2kr5aUa/QK/NpuYYMndAskSqtSIKTN39CIxZYSWBa5UPNDCqgAENqe
	 NxtyL0xAFE9sDuGD2QrXU6vKETxtYGp3ikuO4OblE76S7D3NsyZ62VcaxjrV842bnyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1yxq1E5qiydxNJ9IyMJnY4p2sP60jCTVvX506ZHTMTg=;
	b=N1jg6jtpnLjpLz63Bv1swYGmc/cTUJAbHxbdQO635VFZAvc9wlWlHA3+VHp/Vpf8BiP0
	 /v8fpY4x777NYXDPykSF0sAlTJvOpfFUKAS7lbUexHTH1gaMeAnyPb7P/SEqw0wXr/IVn
	 C7mYH3HYJ7N/v2huLt0J8WKXTma1iBiYW5WKu8zYH8+xnMuMeDKmrixS2imvL76AGAmIo
	 5qQeFTJiE8+fZSeUA7tH96afH/sjf+927RGjzJWp0kjz+mBxipSsHRltl1VMl3H7TB69L
	 ijOc6xmvsbN4iEppwAVUghqEsezC5e6WPW2QuMwDmaJmdMvCya7uBRRsawxZ03MpzoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CQkMHvt/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A2606A323
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQkMHvt/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1936B1F000C4;
	Fri, 13 Nov 2026 13:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575832;
	bh=1yxq1E5qiydxNJ9IyMJnY4p2sP60jCTVvX506ZHTMTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CQkMHvt/1f473FMb7jG+7w+OpNCFaAwUF6i/dsocaMFu/2yj9qH5YiutVd6zsJgIA
	 55sa3EzlvEPM02WzP6SXiEH+gR3tVM6f7kDcIQlv4fgWKTjpezKKsdm9B9DKRahAy5
	 bBK59yPTdVLCEuoSVxZAuGOBPz+2E0rRphc6gTtuELF3d2tpUM/XsVEQK+bvZ3/Aoe
	 03hdPHwmnn7j3ULQRPBXRJSxBQmMHCnqSDyFwaIR3YkLOxAtT+WrZz9vvcMRY55Qc5
	 rCpXcfHU+nLMHlc1PlqqUBcDtOcWT9EaAgptTEXPgbWH49pnrt5grAVjyE+qipGHua
	 nn1ZxDCUqVgVA==
Message-ID: <sashiko-outbox-212836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 5/8] vhost/vsock: negotiate datagram support with
 guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-5-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
 <20261113-vsock-dgram-support-v2-5-bacfc85b71ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:17:11 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Expose VIRTIO_VSOCK_F_DGRAM in the vhost feature bitmap and retain the
> negotiated value for each guest.  Keep datagrams disabled until the
> feature is negotiated.
>=20
> Use a vhost-specific datagram destination check to look up the guest
> in the socket's network namespace and require its negotiated datagram
> feature. The common virtio implementation supplies the bind and
> message operations; destination validation remains in connect() and
> sendmsg(), where the remote CID is available.
>=20
> Reject guest datagrams on ingress unless the receiving virtqueue
> acknowledged the feature. Complete rejected descriptors normally so the
> queue can continue processing subsequent traffic.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v2-0-bacfc85b71ce@redhat.com?part=3D5

