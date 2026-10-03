Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E02BFC85;
	Sat,  3 Oct 2026 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013616; cv=none; b=VBM76pXxYwrWMM1cazfwNzcRqfrIVhDH2zQD9GNh6R/OmmRtI//pSUknTjSl90gZNGge/R7+jrnvr2XoKpT4kLX3+UmPhhtfTbX6r6/cJsbHZa3ZyB/1o7c+p8gaPto6XhvOQ9fLQsRCVeEH5q2hbC47eQxIeMyZRSiISdNmGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013616; c=relaxed/simple;
	bh=DYGTvUZ3cq9vJDi2DZvM7ouJWIFkzS99xRKP99N0U/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nc3ukVo48RGdNEb3m8NoLKXip+Unbt35jCjeIWa8zqZWdhOcd6MucAAq/T8tzDkpBFolLBmbAcZ7BEtuwz/ImTVm+yd6sgspMLsSgB0NZU9EnPk4a5BwHkRq7q1YyV0/WzpqHKyawvLkdc//rxs5kgExooYAAWzsPZHqkRrtUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr/ZjIka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr/ZjIka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DE01F0089C;
	Sat,  3 Oct 2026 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791013615;
	bh=DYGTvUZ3cq9vJDi2DZvM7ouJWIFkzS99xRKP99N0U/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xr/ZjIka/EuXVM/r6t8catu6287pEZgC35lWFNJ/Kp+/iCO+Gb17nXnTagLBNw+np
	 bh44cztIhP65COyRySDffHF0WBY96Gssq9jurF4L6WwmLqtZlPv2HXf9SDfQFbw/rM
	 /3K1FvxtcrIknCm1ZmrhR+MXpV/nUmaPD3nnkSkOvV2L0btZPEzBH6wimZNPfqN3g9
	 RuM4RlzuYgYKyA+c3O+zl2hhVts08viUSoDdHbky+NY/27Flih9SxRYdyFNfGWmykR
	 dO2x2KYLhJYSONCq+ui5uvbZUWjK9Gli0C3zVt/LQhpFXNDQMKewakEJGNvY5hPKyH
	 vz7a+z0NTeQug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] vsock: amortize RX socket locking for stream
 packets
Reply-To: sashiko-reviews@lists.linux.dev
To: physicalmtea@gmail.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261002074551.318789-3-physicalmtea@gmail.com>
References: <20261002074551.318789-3-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 07:46:54 +0000
Message-Id: <20261003074655.22DE01F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Jia Jia <physicalmtea@gmail.com>
>=20
> The virtio-vsock RX worker currently acquires and releases the socket lock
> for every received packet. Keep the lock held while processing a bounded
> run of packets that belongs to the same socket.
>=20
> Only ordinary RW packets for an established STREAM socket whose transport
> and protocol remain unchanged are eligible. Control packets, SEQPACKET
> traffic, state or transport changes, malformed packets, and sockets whose
> protocol has been replaced end the active batch and retain their existing
> handling.
>=20
> Serialize the initial eligibility check with sk_callback_lock because
> sockmap removal restores the protocol without taking the socket lock.
>=20
> Limit each batch to 64 packets or 64K of payload to bound the work
> performed under one socket lock. Keep the lookup reference until the batch
> finishes.
>=20
> The virtqueue callback remains a queue_work() callback. Batching runs only
> in the process-context RX worker.
>=20
> Introduce virtio_transport_rx_batch_finish() to tear down the batch and
> release the socket lock and lookup reference.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002074551.3187=
89-1-physicalmtea@gmail.com?part=3D2

