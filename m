Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794659091;
	b=tmAKUg1muKE3fkiOUVmfv7igLp8HmW3yTv9Gdcy5WmzNzca/n/ANGMKuAH5rZ91IYyFR
	 ngsVaPXhrJ80ZVb0ugauKAynlIFyZaQ5hJaHnkJVTyIFF6rB367R4lZs6wfCvh+B6cFJM
	 y3EVoxAzg/oPhkefyxvGYkkKHWYabnxC4GJbybNK0dK2sKxY+g9guKaNayVNHpJztmHRX
	 6bE2SYfaPDgHlFHERq5vXjJe27HOyp2pU1wQeZz/Ph0NFzkmppmY+WCxR7Z1FH//btKWF
	 hA8eePhNfEvCfKMaBMADKY8NKpA4W5Ep+2tFV5Hm3csSgY0fUAz3ztUJT5UImgADjtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794659091;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g6H5CC6+RklSpnR+NabvclHI2jedPvm/7vqDZgELwus=;
	b=2/x8KW2StcAmwMd+LLAkmhRGS8qsq3eUnVpxu2k7ocDv5FWc5KgEZ1BDPV7D/OSERxeu
	 tEKAULNZZwXWiNFvYpopSULKe1npu0vcFyWm4TcCSmepJfYrluhKvb/ta+jjfwtNsGVgw
	 5Tn39TG1nw3flD53CEJrV6cpsdPQkFzNQC3FLzPaRtlG9XjyiccRfFif52M5QMJ6bQPhQ
	 pJZpv7WkhaTrhk4QaW4oyIXao8gjeHv8ZAkdwkheHlcRCRxuHnR353EGPlNQO2QbNywcx
	 tPaW5TfrWBRV0ILpNPQS9Uqq6hwpUVYYKUJM1BTv1XNwD25aiMuIlFWi99tIK0fE5Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxkliEmV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D6606A330
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxkliEmV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6961F000C5;
	Sat, 14 Nov 2026 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794659091;
	bh=g6H5CC6+RklSpnR+NabvclHI2jedPvm/7vqDZgELwus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxkliEmVhTZIdc2ZDv6+P1FGvcCCsFAAsVDsjjmklL5QDFwGBVw3TYbPD9smNpu2b
	 eptpmLkH0nD3bnauhJyxwxZ1uiarD49M7smeybr7As2saquQFxIeI5IU2oggdOZ5PA
	 UXkevxC4XsZ4L+PAO0BCexlvwq8V8PKtDH3s/aUT7Pa6C6tP65fMVXi36Tq2XTz+XX
	 LezDOLFkEPvoBhBtpZfhLp9naIJHGxX9ZO5QhjbsRZDKpqw7NMC1y9ExVO1vwK6jJ4
	 s3wsZRya/SfTktGZ5+XKZDi+RTSof5z7J8xP467LPLlY4HyJF15JhPC8eKOAYRkIKQ
	 Jd3r1cozeSV2w==
Message-ID: <sashiko-outbox-214503@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 2/2] vsock/bpf: release sock lock while waiting
 for data in recvmsg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Mohm" <jrmmhm.kernel@eldare.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261114-kbh3-1-022-fix-v2-v6-2-96b6029bbffa@eldare.de>
References: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
 <20261114-kbh3-1-022-fix-v2-v6-2-96b6029bbffa@eldare.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 12:24:50 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>=20
> vsock_bpf_recvmsg() sleeps in vsock_msg_wait_data() with the socket lock
> held, so the virtio delivery worker, which needs that lock, deadlocks
> with the reader and all vsock rx on that worker stops.
>=20
> Release the lock around the wait. The reader can then wake without
> data, so the wait also has to loop; the fix needs both halves. The loop
> ends on data, the timeout, a signal (the sleep returns at once while
> one is pending), a lost transport after a failed connect(), or a state
> in which __vsock_recvmsg() would not wait. Those states go to
> __vsock_recvmsg(), so a non-blocking read now sees them before -EAGAIN.
> A blocking read interrupted by a signal now gets -EINTR, or restarts,
> instead of -EAGAIN. One tested difference remains: a reader asleep at a
> virtio transport reset gets -ENOTCONN, where a native socket gets
> [ ... ]
>=20
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-kbh3-1-022=
-fix-v2-v6-0-96b6029bbffa@eldare.de?part=3D2

