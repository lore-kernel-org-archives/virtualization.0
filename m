Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575288;
	b=V1MCMUMKODaqqBEvtHYqXwzS5NMpjZv3B7mBh1hYCsQuJRPKu1hb+nkTF7hs0OO9OmdE
	 Y445w0YrD7/Bsf2m1DnExx+tul7C8EQEw9/SUcQ3s+/FQFCQfY/Esc4B/ayoDAAdfr1yU
	 DgmZ9ZOG6+9BEK1n3BYv2Rl7FUCjYYIwWLphyQWFhR04tj8FEyH1LEzdgB1mviXnn6LOb
	 nRFD3rxx1MTPWmffbOATrum1pzoQUFU3wcUN5w82xJ+wxX++Id7HQceQEKpBoRw5KeOvD
	 ybgnOOw3J8mE6p7iR81rL5enT/HOD9rsN7MP3OGmEkBUyHJ0/7FW74oXDMNAQBmNvDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575288;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l+Oevkm40WhwJIy4qr+IyYY8C5l6MjjJGzsnPyxvGpE=;
	b=UYvIFCjVpXDPSxTRrOln9QzNVDazTSWbp6dFiRJODl4rAkgmpF6gqB5FDAtd6rONBleh
	 6maDu5wjOXuAshAHN8xRVKRuzlELlVVzj7+l4AIQrrH4/s/yYViYRpZEeIUukNTB2S9Bz
	 IczoEdHXZoAoVILi+y+WqvUe7gJLZ4DdkV2Avuqzm5aNshvvWmOqaC1/HRLOm/Bc/ArUe
	 BnWmJhwIS91Ns+JYVUQnTu5GGC8kCTn4pToUbaBpTXhfBSEoz8UtS7FqJ13+Ue0BqXpFW
	 TRlxKkO+3qQWT1RXLDLjSBpptukBsEuypFEaKHv0o5UD4XKjBpo+gQH86D+OPYm8dpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcQulqrk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AA4606A327
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcQulqrk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838041F000C4;
	Fri, 13 Nov 2026 13:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575287;
	bh=l+Oevkm40WhwJIy4qr+IyYY8C5l6MjjJGzsnPyxvGpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XcQulqrkBlH+1t3TOknl2U7JGHAL/Y0OIx0RoU0FDnxuQBgSJL/BmZjZEG6xSso7N
	 nhqxGKL8oSgEZTysJKbotLF3yVX3eDxJZK3XCoZwqwKWL+zHOI/OJwOTesyK6catfG
	 MvdWrRVg3vV4Re9k+VzNahB5RzhrCJgHb1L3atLbXWxAVzPEtaS8kVaASY/UqqEJXc
	 Af508QloFjCiS5ugAIJvp34FoxAP16DF9QIIAnBNpT30umjFstomION45v7VBRIUnK
	 DfodLr05Xfv97Tv6rf0xF9EArxMlXPObcxX6LL9ubaAWTvwT0ol1Rb0pCGUk/px/WW
	 Z9/rObX/+sLzw==
Message-ID: <sashiko-outbox-212824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 4/8] vsock/virtio: negotiate datagram support on
 the guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-4-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
 <20261113-vsock-dgram-support-v2-4-bacfc85b71ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:08:07 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Advertise VIRTIO_VSOCK_F_DGRAM and record whether the device
> negotiated it. Gate datagram socket initialization and destination
> checks on the negotiated feature and the transport's supported network
> namespace mode.
>=20
> Perform device capability checks at socket creation without requiring
> a remote address, which is not yet known for an unconnected datagram
> socket. The common virtio implementation provides the datagram data
> path.
>=20
> Discard received datagrams when the device has not negotiated support,
> including when a socket was initialized through another transport.
> Reject packets addressed to a different CID using the full 64-bit wire
> value before bound-socket lookup narrows it or matches a wildcard.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v2-0-bacfc85b71ce@redhat.com?part=3D4

