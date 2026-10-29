Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265199;
	b=o48Kk3F0g711Ranv7XFiutvJauTTZQLW7tCPvmGnIeEthlNCC2t1sNuNyTXiMVNkmH3C
	 69BELsFgKF5f7A5GnYOaAYsyIZ41AgkJKZivAGnnAuCu8qyXoOkFIMCI7UavnXqhUUpU3
	 2pQeGdUlcNk6xuSZrIqWQMlsoyo0nN7ok8lkxZa0cEvI3PWVo+l3k7wNsbQDCw/WOyoW/
	 KX29TWCdgIOF3w9fCFBtiBCt0sTgfF2+4sMqZgwYEhzm1MkS+Z9U5wcyNS0iIAOF5KlfM
	 VlaMI8lypAztd9H0Sj9zFOnxUrfWcVOVQtLihbF2aCLwt84xb70nXzSw5bwL0jVSZ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265199;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kXbt9vgvyUDc2BL6tfX95q/53Q7QsQDjPKURYmmy9uE=;
	b=SkCXTFG39BKKU34p+LZ9YFlTjYCKvdGU4MaxAodAzxqx/xfVwqZ9mtoQhsxzoAUca58e
	 BBqSsxOaOc4vJsDbaVvk+DmWlnAuJQvDbvA2dE33VQhdZkswAepgRRpbAyeBQM4iQ+v2I
	 E3+lZOw+5oN2CJzc98hE/QT3gJo+AusoMqcPq90RstTixXusryDXt2xlTAERGzeIfhuKt
	 pHQbSAVI4nI+mhL8g8/JU3FRzLy856rXMgrUkngXJbZjVAQPIntEcLPHjtd9UcOZeuFBc
	 DN8h36xvh+dR/NBP3ay/EkGun8qpKBF1xhpw71x2kXpm4a7uKNFWRG5h+MvJax0grYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0XTFHoS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17520606A321
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0XTFHoS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D41E1F031E2;
	Thu, 29 Oct 2026 09:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265198;
	bh=kXbt9vgvyUDc2BL6tfX95q/53Q7QsQDjPKURYmmy9uE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0XTFHoSUZeSSp/GO8ZYIMLLnXLtXBUdD18huQMrUMX4zXYZUF5HR+wuZ38I/uls+
	 x0PCcXmYXp/eJjEIEwtYL1ryfSn7kTWagAHgtY+t9F4IvNZFJW9UdRhAzEfa8/U4Aq
	 M4uawpbKV4GevuMxK1D399h361en9uNbmcy2Wwn/sHlcSErsP+/sEcQxkf3Zw6b7IE
	 +mrrHjHRMca0lmpiESucFbA8k1LAckwXFnlBoNsZgLCL02BdV68lLILYJxFvP7OTbg
	 0lAkMcaNPR1IKZ8nzo5U0SEOIaZsnaACYYI7SRg+HKEpU4lG8g9a8QBTiOEsVzq/U0
	 ikHEpvIY4tvaw==
Message-ID: <sashiko-outbox-189007@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/14] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-7-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:13:18 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D6

