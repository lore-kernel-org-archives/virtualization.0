Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843681;
	b=B9VMh7dbGSC5F9dWU/OabTcY1W5yAwhD2IFbmqCKku1JB46XF4mmVOPTdY0mBsKNmKDn
	 PTUaVbUS7hY4XP31tRu9BccBX7BtjWmR+6/znd+fSUzVgG8PeaVtACd6ejn9auyfrthM2
	 yykPQRit8ya4O9gw3y1xq4gC2F6I+DUCyk8lz+lDUZiwy7onyQB3F6McIiN0OVqfF/GZv
	 gvoO4yNpqqpSdTIagaKw486fQMjGCNHmjdDFaydOR26D9wbvaKpj3KmDzBT5Xaa44R0sT
	 5ElbkNOIz7e2gX9BYKJABgGOL6nnYm8o/3BhH8xIoUr09wFm0lLnePuZ8Y4b7Cymf3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843681;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T8nKCtONW2syeLL+kQ0jNlQ7YtjIQxY0WpitV0NQm5s=;
	b=pu+/wV6P032ORYt4dFIgkBNRpEn3fRCD8VGhRvIWVoK4QG6dIO3wpPyfORWDHmMsYTcf
	 +8RbLinlJeIST3IH1HxNVAqU7N3Y7cMxFBHmxtcKNdsR0Id82q3O/VwkWS9gxtWIHZj+y
	 GnNJPbzE3wAKVkUV4lankVZPh+B0mWkZGwU7P+HCJSWLnMarHU7aY8WzMlqiMWDcCTh2e
	 qYbA/Pa7pjH6v/qobbFt4tZ+d94AuwloN8WNf5Bu4FOOM1LfnpLPimHYODVOY73rcKpd3
	 kXJ97McsPFmjaUkrh1QthY2JOAElW74awt0LcOSIq/rgbGHQhbzHU9Ik855Iv6QMBsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MR1FfZ8s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1B606D805
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MR1FfZ8s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FBA1F00919;
	Thu,  5 Nov 2026 01:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793843681;
	bh=T8nKCtONW2syeLL+kQ0jNlQ7YtjIQxY0WpitV0NQm5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MR1FfZ8stLRcQo0IvZKoX5Pvxr+z4LFlRGsijQwg25W1YugiIhE9mU8mdFXhhs7fV
	 DZhxIq0sMRFwfGDCVYK1zTpr4TIjF4+Lm6MWgHI2fQvEagXlwoyEiMuvDqHrVlXyju
	 RbR8vQny2lMhbg06uk4rowT3FtiIRE5gnwzy3nIKL6LyT3fq5CbQXE+2CVV54G7W/G
	 TAk/ckEHbEy31Hot0MV4YzWgYPne93G/5T1VxNoqKEB2bPj77vCYqOUiZFJjTh9q5k
	 Qmw4BpHEd2cxNo3oVdy8DLIWxwpgApBsAs0aPL/KbUKFPyCrr3ztJhXnK0u5iPBf+A
	 58JOx0guAlanw==
Message-ID: <sashiko-outbox-198422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 6/7] selftests/vsock: test the guest vsock
 device network namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-vsock-guest-ns-v5-6-48179b9b66b8@meta.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
 <20261103-vsock-guest-ns-v5-6-48179b9b66b8@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 01:54:40 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add tests for guest vsock device namespace assignment, including ns
> destruction and the device moving between namespaces.
>=20
> The tests drive the device through ynl's cli.py and create guest
> namespaces with unshare, so they need python3, PyYAML and unshare. A
> missing one skips only these tests, not the whole script.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-vsock-gues=
t-ns-v5-0-48179b9b66b8@meta.com?part=3D6

