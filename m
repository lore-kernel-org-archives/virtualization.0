Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413656;
	b=F6WSzn+3fcClhWiYm70VKVSf8BHvq9Oey8LGzIDzD2T84Mh8bru2gTpNPbyxoRhWlAxQ
	 MHtwtScQpdvrsZLLJqyhh1qSoVCLK/efJukd3slctsKC5Dtc9ZG3OIs5eckE0zlW3OG+e
	 4mJk+XyX4QzpxGccE9FJjLbyr4eXOntnxgo99ZiTrbq4xzH6FoblVa8aAAXaRS0V07+rN
	 G6J25uhgW7N75J4r9U/QVlr6gJcPXRUkdM5W++QYfEdQ+B98Ngqi0yduLCxzcFnwAVXRO
	 +un8ppOOQLOI3VHvSxm1cFpbiBBY/74PTOa0SZ1FMq5/wMf2yWox4Yq9wrVdnON4JLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413656;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zt0nWnarm3Zdoc7Ssm/jehXHHgTJ2q/qsT3H0qGWxa0=;
	b=YkvNgEJyMuzSi9XKCFAEwktsrZR50TKFToV5jAjFqs7Ntfcou7E/mYmrIcUc0Uz7WCj2
	 otSi2vqBy4J0Leg896dck4zCFZFEp9nULQv1T5P8mK38zHhKKWPzFxugrRhOzbUWsAFxS
	 M8vXmVEpTYwr6AJvB2pk8ZNYHfYLWAigX1oytqkZYE0iaTZ0FV08M8XBonww2IiactWxB
	 LSVC6fNkR09ABDKmtkT8k80CMPe3tRXDS+Bj/6sw0e4B6PfFQ52DEdt545OVSXdsxMSi4
	 wxYrwA215n8MTrEhjcPUTomzzqRxxCwx6ygLaeEIziFE46OrKasd9En3zlBnhaX8y5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N24BtWU1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B5606A31D
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N24BtWU1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD881F000C1;
	Sat, 31 Oct 2026 02:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793413656;
	bh=zt0nWnarm3Zdoc7Ssm/jehXHHgTJ2q/qsT3H0qGWxa0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N24BtWU1WnzCm38KJpKi/NfL9nML9ffKpzETelbBfDVyLbaAff18YN4Bco2oPAWXp
	 IBQRjZVKbCGFTCiAXDaRT0S5g0T/bmCGkoC0QNjvrQ70eTnhIcomPtBMSv3DGm5CQy
	 RXYGZ/DrBuqdf8SevDBTWFEgUeKf5TGxsQP7K2UoaxmGQyqKG9ExVOfEAJduSCOnvb
	 ZOMFW2rW7wwftA/3eilxb7whFJY3t0Nf0lMnu8MWhdTz3/YTvW6ziibffdr4/mHLvW
	 Dh2FpHDv3hg1U0zOtYnUzLeR8P0hQ525Vw7OiapycoiLTamu7Hp7omeA/GlR64VpKD
	 jHc80LuEKzpEw==
Message-ID: <sashiko-outbox-191706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 06/14] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-7-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:27:35 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request is
> still pending. A later teardown may then submit another RELEASE before the
> first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels t=
he
> pending request and wakes the waiter.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D6

