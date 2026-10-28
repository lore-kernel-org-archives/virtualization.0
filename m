Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156803;
	b=jqFhTn9BGC/9+PVE9QQaOm6r3ha09NMlz0BRDruWxgIJ9CwGmvNpV/OgAXfdyPblr6Ve
	 dIzWGqs0Q+GhIa/yGyDeTuK+D06XjuZBfnvFkGjF3miyrdnEyEx91kx7WQl5sZvno0NB3
	 h70ELfukGdMBMZHbk9tDUEbg0zcyLBLd3UCokOKFbGC/YekDNAUDOti8bpCPTxDF841lI
	 6D62QOxdbA87K65/Cj1njqeNbvVldNBGpIEh43R3H9MUbhCiuSufrF796xSu6Fhk17+zF
	 ChdlG9txbqoszgkeWEKod5DAAdL77mqMOqDT/Pag45CDIzNAR/YAYwX/hkMDa6QVb/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156803;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qOD73dIpcdNUprDdW2OCQKmo4PYXZ5AgJmaXhhtPluU=;
	b=HTniYotlm9bqvPq+x56JHDFehPJ/h7A55q79P87jUNAhrA/qXn65IBUMc9blEYMSdEF+
	 8g5XzSIJ78ICGnT2//tzuHZM1/1TModFZLA/s8onAEWvdtdoTh1OBlksGvV8DannkZZe6
	 CgleVsvNFjiXmMtsQyVtu5k2GTulMlIVkYbgtkyv0I1ljHd0GHs+Dyy00Qof/VJPZvhDI
	 7eHSb3BTTbSnN5rU7FgUt/pFCHXGmf4Qivy6eZDrbhl4jX+nqEa8qU8pZ7KW1u3HiLE2Q
	 2ik1ZRx3UMH788TfwFYLyPSLNAalEIpLigDOEe3hACl4YaEPVAvf/a06ZDxMR2nRLQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmppFl0M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341C606A31E
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 03:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmppFl0M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D6E1F031E0;
	Wed, 28 Oct 2026 03:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793156803;
	bh=qOD73dIpcdNUprDdW2OCQKmo4PYXZ5AgJmaXhhtPluU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NmppFl0M5D8F6pLNPAnQCzOXt+Ho+vZfCrKeFm8Zdksx5OwfSUWs21YnnCKxEKJ+8
	 SstQb1HUtHbpTu6nQ94hQ45SNnHVINor4K+oOlUwqe3EJkHXuxgiy/Qk436sahfPsF
	 JMFGNtXMvoI3GNTdC6Mk82DaA32i52wHBFW2o/OVFpCWPhXhdTLAjDp9KXzuSNlHlt
	 WB3U6fBZFI5BFzeJG88gZECzH1qVaI7T6xJjWLLBNQdW3waiVhDjW0XJP/SqA69aFF
	 vqVFZwgEy9QO+GZOUbMyOEYLdR1TKOBxJrJ8HVX6GThv1DFR4bUd5JIHP2z91WAnhm
	 HuCLlgr7nDX4A==
Message-ID: <sashiko-outbox-187378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/14] ALSA: virtio: complete control transitions and
 preserve drain tail
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-13-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:06:42 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Pending signals can interrupt synchronous PCM state changes or the RX
> teardown wait after the device has accepted the command. Recovery can then
> issue a conflicting request before the previous transition has completed.
> Wait for SET_PARAMS, PREPARE and START within the existing timeout, as for
> STOP and RELEASE, and make the pending-RX drain wait non-interruptible.
> Device reset still cancels the wait and the timeout remains bounded.
>=20
> Track whether a control request was submitted. Expose that information to
> the pause-restart state machine so it can distinguish a definitive failure
> from a timeout or reset after submission. The next patch uses this helper.
>=20
> Keep INTEGER64 control values in the aligned response-data allocation
> instead of placing them immediately after the four-byte response header.
>=20
> Capture DRAINING must allow consumption of the remaining tail without
> queueing fresh RX requests. Permit its indirect ACK while stopped and skip
> the refill in the transfer callback. A non-staged drain test returned
> -EPIPE with v5; the corrected kernel returned the final frame.
>=20
> These changes address Sashiko findings in patches 1, 5 and 6 of this
> series. They apply after the included prerequisites.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D12

