Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675424;
	b=I3vnlhZ4yD+zeaF/Fc07Crq7krqxtcOmzsbq9lVIKuPJUk50V8Hx8WJvdPNadXfudHeS
	 NzEj5VCXwPEmqZOs+RucoXeH5GLohktMfGkRVIruNvxTA2LFEvr9DafbfxCN1ghoynpNQ
	 WYLu9mbnEgSe716/T0m+ksvOpAaZTqSsAQewnlYyASJp7N589PEgICnfX4ETI2nxjR/rY
	 DzxzrFzfgAdUrgryvzu4b77UbkUaf4uu07rC3VTk84xwErndJsmIdXJ5ZwwCGTwBvdIvR
	 58V88Go8Ito/KKHhb3LZZJOldiNeI9DScF+HZUKiqkYBaZwwWSYf05QrZQlV2G6t0fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675424;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FtlKIvdzha7P4kIKCbxVfB7Nx1k6HvYj/N6MplUjGHc=;
	b=Y5XHuVAFzvRpSKR+7bDs/3nZlqIAPU7UxBlYT8OVF91PVSnYUFeVmz+mI80AclaY9PK8
	 0ub/kvoN10pRpvAcEikjPpSzRzLJGk4nQWREF5tVL15uibFtWQs9wil8EeE2M6frGdafb
	 avAqFPaqLkCRertA0qb7w0Yg+cyyvMOYHkH0QgXZlr0E8HB1YIAQYTbwB4IwrFKjv5OKL
	 BNzPooLQFfhNAU6twW49P8mfmapAB3gN9j3R8eK7OxcTWsLM86oGs8mbtkxQLPclIUGaE
	 Wx5LlD1TbR6YcL0dTaXzVn4fFzPpNPq4zY4rQevc2kcaIDwmG9bGfnwueGSusDWoAzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Waafp0PH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E1606A323
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Waafp0PH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868EB1F000C6;
	Thu, 26 Nov 2026 06:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675423;
	bh=FtlKIvdzha7P4kIKCbxVfB7Nx1k6HvYj/N6MplUjGHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Waafp0PH6q5c0kkpvAbYV3ecdNTI44GpBeytCUENsNWAQ5QtkXr308i+44H4AKZBJ
	 q6uEmatq1PV+fmLEn/mHAQtUlgRss5l1DBhbjtaLpQ7eCZ1FBz8Nj6N8xt7swqqcK/
	 5NtsyQT27Lb/5IbvF2OGpmxvCSgkMhdvyQlWB3v1C9ZOgtkr+CshSRsWWN1PwAWet+
	 VYkveSZaHtc5IiO3N07SemuJfFvit8XDih/ZtzF+ss79EPkt6GMCBY/K9VBbPedFig
	 nifTzP+1KoGBTQoWTfJuFmzB0IJViODHCqhfO2PAZ0avae/3LXSkvOhd7vwuxqEieN
	 rN6rAk30SiNHg==
Message-ID: <sashiko-outbox-234892@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y v2 0/4] virtio_balloon: quiesce balloon work
 before device shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dickson Wu" <dickson.wu@certik.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
References: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:43:43 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Sashiko has reviewed this 4-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-virtio-fin=
al-v2-0-4cfd5590e924@certik.com
