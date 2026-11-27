Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795761639;
	b=AlHTISFYmpeoTqYVByPCTvEGMCesrsqw2Ty6uuaMkSCHZ8O7vFlpIbcHuamu/7VewVzI
	 0oSUzX8KVD2a4k97K+k4j+PdVeLgxOAgQ45kEuNT19MgD6TLmVB0Ty/E4C5McSESuCla2
	 jqdFRDlImOImVUuvmtoEVj7zpJkP7WHvrZ4AjuYO1iekPG+qEWCb3GzMw8vz0mqGxm9m1
	 V2DFgTjcjrjTsEmpWBpuR94Ix/zY3HyrzZFxIP2vknCblT/me9F5PtVbXPFOpQ+ucegTb
	 KPvOgpvvY+tjlhj/rbi5xDJNn8WYQMZLmbQU6RIuB2mlVf6rSct6GPNOGstwJAxR4ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795761639;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d5D69x/Hydzj+x3hm9RykWf5FgF6e2JaM+et6tIYpME=;
	b=SX64abEV9AZwNyXSfEQuhmwctvCnmWD6rc3TvI981Rz/QeBb4WUSsTxV+k348PJhx0EE
	 VgJt2l+1q6W9/8iOpoIsSByDADscx5xZxx4yajBiR/zxErF/sz+yUZPOObCpY0LLoYhyJ
	 A+sBO5cTr5rFvGJwOhpuU0qYh9WesEWvFnyumbWDaxDQeUZyyIApijwbUeiv8WNGyktmP
	 M1V3owxSIN529L3hUC+NUks1EGBcdZoPLGWintg6X3ogmSZqkXZORfHdSCx1FHfYxmLiI
	 T8YJT5Kg4YZgGym7fcGlLndXt5lCboWeQaUZ/Ls713AimsDDt+Tp5MJJxuUDuPeTTqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luCKXNxz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7280B606A31E
	for <virtualization@lists.linux.dev>; Fri, 27 Nov 2026 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luCKXNxz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AF61F00899;
	Fri, 27 Nov 2026 06:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795761639;
	bh=d5D69x/Hydzj+x3hm9RykWf5FgF6e2JaM+et6tIYpME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=luCKXNxz3sVf/LaHTm7l4dajMNF59of3zDH7VnZHAl1rtaYPAd44zZeQnclapfrZF
	 5zrXKoYaHNPorNWE1IW2svK2ILFBO/oZwDj49iYue6IjyRiA1iLfkhlbMUBce6spND
	 js7n5dxDp3KIVwkMwBasVPWJmRdzaRpuOXFnUGcfy7maazH2PHM2Oq0ubdzPDGkLsA
	 b3YXGseEhQGauuzNwECvWEexAnc8TAAg3yZ5orG+IwY8x8UG0lbulenQSG24TW4MTI
	 IEP70Yeq9MJCKgQN1rf8/dzb7NmTbsVUBg2UHVsz1w8T/k0KOLt0mavtL963CZlmxi
	 n+GxYgunwJaZA==
Message-ID: <sashiko-outbox-236748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 0/2] vsock/virtio: reduce RX per-packet
 socket overhead
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261127062700.29387-1-physicalmtea@gmail.com>
References: <20261127062700.29387-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 06:40:38 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127062700.2938=
7-1-physicalmtea@gmail.com
