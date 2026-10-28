Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180862;
	b=tQUcbbnHcu9AMo9d7q1GaDtP5xbiOyhVh+MRIGsuU89w2/t/ioRyMLGtB10jBwcU3A+u
	 rrLD4sR9B5r8QySOpYiNJ4bpnQDkb/X16OV4DT0m3XPUGpoIHgBFx295iNPOrqrVNWunE
	 T+tygX0H28k4jPX2QdbUBuJ0hAwFO2WbD7Nnh21zGbcl1N99zeqoBn0oFViYAeGJg98qz
	 grub4P4qOCtpgzVS8EVvx/nQEIcRQLxJDyLGJe+us4y8OfPiE1hblGCxEOLgSbs5vdDb0
	 FtQtIpsQxJH3wopbA/togQ2VKsKRDvWAHTwzBZcq/AaDjWtuqvVEuCOxQLlkROOYXbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180862;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tvuMRkYdHusFNyjlpbKLMX7XVFf37MC+iHMiKCtt0aA=;
	b=NphxC9KD1aG2iJ0nFxwP2v8fmvAFqoawb5y2I4gMU3xlOykRnU5AJ3qw3nuYGCmjdiMB
	 fZ3SYdChh6I766LqaElYJ+F1mpeSUJe7DcOirc8qoOSQbIXiwufVbSgr5gZAN33X3EcFV
	 5Hgxf87gejExgvdi0dak24f+UTGLszsDKMgk1QJl693rBDvVMJdG3tH+hBTWiKMHhEGJS
	 yfYRqEIxY+ej5ssfbNc4lWQ7mGJtmtMYOLRw3iyXZ8qkiv7c49n8nlF9PSJHAb2K3WOaI
	 vkNPlnjWUeP4lgWm0V/0Rrm5e7kblmwuvFfv/feattHD9GuqqjAmB6MXKuZnlQ2/IzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iNSh2gN/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C5606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNSh2gN/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D80A1F01828;
	Wed, 28 Oct 2026 09:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793180862;
	bh=tvuMRkYdHusFNyjlpbKLMX7XVFf37MC+iHMiKCtt0aA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iNSh2gN/BirZGBom7zVWAglky12+7VdWJkJNt55S0lPUWHq0As6YgkmtPgYdX0sHf
	 NYvxWn8oxbDAq477fdQ/ODEiMuIpBBaZMZ7JfrFTIyGU/Rf1rvWUIrHUMOWzBQYGuA
	 csJgJ2uCqhr3AxflGS4YvHDASZTOkCmdBr6O5BrqZuQsurT48DSv23emmB3zWL5p0n
	 KORsn/hLwdei5kOP9dJe/ml/nzmjhIDoU6cGK49WzTAzDKlZfDm9yNeKqybfuS/HVu
	 GiBZt3RvsCRT8LeIIpEhLC5o3z7dhr9jNxEqskDdYojsMeKvGK00+vueCxO1Rm59PG
	 BikVLUM0Hlj+g==
Message-ID: <sashiko-outbox-187693@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/16] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-11-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 09:47:41 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> READ_ONCE policy sampling in the following patch.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D10

