Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763942;
	b=pvF1vojQZtRm803NF/16xx0KW5+8vSs2bJa908lVGP538tKSbQMBHBSx4lX8UhZPfzT6
	 hHagpZZra36Pu67DgjAgLEBTFSwzsrg1rxE9PJpAqqDcEevy8EEhCacalJ94xxYpN/ukd
	 kItciNGD2YqX8v+S8HHNxn4j2Y5r4kjo5NGDMI3SvQvrxtPXFXH7R6ee+zizWzx3+EE7X
	 wjS5CMmCkXxkDUqrdKkwJUcVdMQe8p6yGrK8PzV3KUCsFbCHeF14xpy8R4t1clnR1Z4cp
	 0aYSh/Y+4Ps77GVGvPtMqxPITdXrFM0uLRBtOmLh5bLG0EZtI09R0+U1Bo4QQlzPjHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZWueSpOS900P7Vs4cBiTr3fWj7NOFsuJUl3ANKNed/Q=;
	b=i2o1w9r+0G0bqdZDmrXVWvLSpa8/lCyU3V3MJIl8l3L8/k6ELI8Cq+M+eshbzIF14FBM
	 Oy+Qmk2Q2lGT2GREWDGv33w1HzvB6hjyfbFzOtApnssCicqJNVdA3OQXAQ1ZrdssnT2bY
	 DbU2N9Q7h1eD8D+SPILHgfBP0rQPxaTAgYXI0tTmrXhz6w8H6HmMEu+xHTKyke2p11O3x
	 Dj/U99mLaWMOypkKma/tzO3GAEqjbhmD+pHunCeP4jFWCPjU4i3HJCLVdP690fJXzq5M3
	 oTgfF6V/E+xC9rjjKAPpoihXVR8/BkfjzKMRyY0HNvNpzixfDMogB8Tgjvs9eFB71QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUWQ54mp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6E606A31B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 03:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUWQ54mp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CD91F000C1;
	Wed,  4 Nov 2026 03:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793763942;
	bh=ZWueSpOS900P7Vs4cBiTr3fWj7NOFsuJUl3ANKNed/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUWQ54mpDYNlcs1FXMqYcOuDbiJ6yjv3Y5YxiVWaixkQ8+24ey2E23MybwZs4dAmJ
	 Ray4VM+Z04s0rkeMKYXIdvBZygdS1hKpB5lhpmRva4JycIxLemhupBES+zris22qh7
	 QJEpYOQtgObAPaKLMzNF+iBrqy0DFBE9NmUpasHpgaKBjNhV+S4oazRuaps6vM+Jel
	 f0r/tm1oU85hBpsvDEJ9RXVPkf6BpF47pwBJJRBVIgH4DCHS1Ws5OKfbd2IQcFfwI4
	 6JppcakjM4b1+SbKbU3ai/22PpSy40XCGeoj2Rh3sxyqkrOcYkhm95WwOvLzIHQFrY
	 I8Y/vmhFcBJ7Q==
Message-ID: <sashiko-outbox-196632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 12/12] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104021745.57733-13-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
 <20261104021745.57733-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:45:41 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document the five opt-in virtio_snd capture module parameters. State that
> capture_allow_empty, capture_allow_short, capture_packed_status and
> capture_pause_restart require capture_staging, and use the ALSA kernel
> parameter restriction tag for each entry.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021745.5773=
3-1-mynameisjune111@gmail.com?part=3D12

