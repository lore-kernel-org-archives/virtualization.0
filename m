Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780489;
	b=o4BlzXfcFqE05FOd3P/X6b/XnQpt4Lf5/rUAprfwuE07OeWp1Pe6y0tNWiNSlWEVPKEv
	 P5dBchZz6wc3b0PYeRhubbPViznH2iY2cx5QpD8zSDXdsBiuB/a/mxyJKRCqlxy1c0BmJ
	 V6pcoKFHkl3+t8fVaC+C2fY7BgN0038uVFPnvURAm/20fEa1molzFzHm6oUwOIcP3Q6C9
	 T6QSv3HsGnrcgVykT5Y/gBAWW2GbPQ+efHeYJXU8zGJTrPJRo6xO68rsfFemRER5m+0VK
	 X4fjHgxw9jkXDhQ3sEYWx9ad5H7OsQfKrUYNVGerES5iDg3J7Y9RQtXPsL55dlDo7sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780489;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TVHM9IC2TpAU/5MhZGfCLcKk7w6OTkMiXTnebz0PtJA=;
	b=qbeBZaoWg1RQfzWQLe8bXWxagTM9IglO39W2k8uYJT1cTiAKADDwB9iZXrRYG3hhGhgP
	 LFB7l4fAP2bGWoyKSSpz4iGB1JUwZAQS83mPzB7xX5NDnK6YfQ60INHHt4kDNbUq9X6t9
	 HyfZZ8no0+g5Uo0NMxNbXEXIxlOFa6Fwjswfu40x0/wYHX7xLNC2pthqWVZEloU99ESmJ
	 LPuUkDiiMegUeA1XPh1oxAUifFHAIsR7dh2vWufzNA2jbA+ZKR9PnzEKx0GvS5a1Vuo7Y
	 FGL2eDd6nLjGQWBCq9HgTdZoQQMQEbJbdFgpHXIRSDRBFpMldqDzjhYfC/DTjjt+3wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lNbPDsn/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A0606A31B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lNbPDsn/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DDE1F000C1;
	Wed,  4 Nov 2026 08:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793780488;
	bh=TVHM9IC2TpAU/5MhZGfCLcKk7w6OTkMiXTnebz0PtJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lNbPDsn/73nDg3JqKljKyolQj9PuI+gXoOOGP2vAZmZZiOXDYyI7FcO4YcYwIk+V9
	 9Xz2BuD85DXUxFEyazVEwQLCK1NlVI8thruPk+IcPfxpK5pKsth2dDSSUfV6t3O5i9
	 VHwgTksO8CJUPrDpx1jVkN288hGTh+tNRJ67kCVkpEtJH7QJItEx1nF06tdtVYJ3wZ
	 2+evajfL1HcImhVcQses/zr2RSrqaq2vctP/olmaYRKjCNt9WgkCdIBcUugbAptScx
	 ezR4RlPPeO2V6xO9aN6UhpDLDyAWMiru4oyzKb46B4xyC0/eLUdO4OncqKvzRYsnfw
	 TnOz09sutfcdQ==
Message-ID: <sashiko-outbox-196872@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools/virtio/virtio-trace: fix swapped read/write label
 in path error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104081903.1834-1-gubin@cmss.chinamobile.com>
References: <20261104081903.1834-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 08:21:27 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> make_path() builds the path whose direction is given by
> this_is_write_path, but the pr_err() labels it with the opposite
> direction: "read" when building the write path and "write" when
> building the read path, pointing the user at the wrong side when
> path generation fails. This is a cosmetic fix: only the error
> message text is wrong, the path construction logic is unaffected.
>=20
> Swap the literals so the message matches the attempted path.
>=20
> Fixes: 108fc82596e3 ("tools: Add guest trace agent as a user tool")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104081903.1834=
-1-gubin@cmss.chinamobile.com?part=3D1

