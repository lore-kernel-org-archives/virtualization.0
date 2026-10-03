Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0738331B;
	Sat,  3 Oct 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013618; cv=none; b=OfwzXbQHBgOAS3nxRjDTTppslzoDM3nQzgtyX8L16lSkq4JY2dYx7BWbOy64ZxH5BoTrW6a3mGXZRI/6fKEGjR/7Tw2XA2Vth3FBrWhWypTpSM5mdylcinmnAVwJ5fgyjbNUr6WkMbOJ/rpmBUsEZSvOuqWbM5iH+1EDOgans98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013618; c=relaxed/simple;
	bh=MzPILafAFVUnENb8hM5NYy2qly2gbgdhGu95J2IkAAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZXGsdCv6DxSuUnloV4BSsCCYHmB3Jv3u6qAoVbalI2ctnavkpIdFgcAp23g4rhDuqIH4Knlo2ml+vKI5WFtdrI6EoSVgNUtN8vIuitAnKtacmp4/GT0lvsHd0KBI2qVkeyASc5Tbf5fIa54hUv0LwoybDHCA1VLxjzBPIHqUKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLpUnMuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLpUnMuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ED31F0089B;
	Sat,  3 Oct 2026 07:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791013617;
	bh=MzPILafAFVUnENb8hM5NYy2qly2gbgdhGu95J2IkAAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aLpUnMucx99v/vRJUvVhJ/Lq9RkfdQzJr4Z33iUIh5dSJHU0Sds61zkoGIYnhTT5I
	 fXDwzVOLcLWGVy9CRKXxmVk7xMGF5isGH58dbOzczlUOCnb3KBKA4DgsRZ2uWIOavy
	 dOjtJQfUCsxdH04wXM2aBEdvwSrUi5mKWBHRH8a5hUuGap8ywIxGSwzkSeW4C0ocSV
	 idcDPhlghgFrELq+MtKonCL8ywmT6uA6O4TKjlM06dvcecA93d2H8JxvN8aoSRpU94
	 T6q+sSyibryv6rRW8aHogpfcHxDN/ZH+V8lVVgnAw0e7SE35UwiMo/LEMOIslrBFsm
	 AqfMmcNgsIsmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] vsock: coalesce RX write-space notifications in
 lock batches
Reply-To: sashiko-reviews@lists.linux.dev
To: physicalmtea@gmail.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev
In-Reply-To: <20261002074551.318789-5-physicalmtea@gmail.com>
References: <20261002074551.318789-5-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 07:46:56 +0000
Message-Id: <20261003074656.A9ED31F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Jia Jia <physicalmtea@gmail.com>
>=20
> Each received packet updates peer credit and calls sk_write_space() when
> send space is available. A writer cannot use the newly advertised credit
> until the socket lock is released, so repeated callbacks within one lock
> batch cannot let it make progress sooner.
>=20
> For the callback installed by sock_init_data(), record one pending
> write-space notification and deliver it immediately before release_sock().
> Save the initial sock_def_write_space() callback when the AF_VSOCK socket
> is created because it is not visible to virtio_transport_common when built
> as a module. Custom write-space callbacks retain per-packet notification
> behavior.
>=20
> Set the batch socket before processing its first packet so a batch
> ending on that packet cannot lose the notification.
>=20
> Packets outside the eligible STREAM/RW batch path retain per-packet
> notification behavior. The 64-packet and 64K limits cap the packets whose
> notifications can be coalesced.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002074551.3187=
89-1-physicalmtea@gmail.com?part=3D4

