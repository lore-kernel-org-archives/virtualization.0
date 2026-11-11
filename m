Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356266;
	b=Hs8ywwfglZo4xZydU6PrjLLpsafMetlopcDcDDhb48YGCyytx8abO4tOS7k632iDbOun
	 kPynZrp5B5WgQNDBh63G58+m29mH1TAuo3aimbd3JGx1Br0KJzXpo/U+S6xLutUaH8Cb3
	 ECu4Th87tdESDxKc6kK3dQH1xu53Sur1VbUSeeB5SyuNfzIGFtMpWkD9czPPi2usR0Trs
	 VhD5oWP84K4qILqZRzpKOPpI3kcbueSYsbpuz9sdUs38PjgVoVeq8QQww+W32CbT1H1al
	 uCI0Y6jShAMqXMhFWYWrkyW2vEohFYsGX2oAMoeQ7x8gKrcKakbuurAiiWSnWzLxs4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356266;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n9EkYwWQcCGTYc2XHZRjpMsJdFASlNxnszN8JwS8YsI=;
	b=pvsk/8C585clTuh29uPRxOvfwcsCTiKRS/NBfJ0HTeu2t+PB/R/aTO1M1Eubi6E3j71/
	 97r1F95FTzMlTqkVurdtP1HjwX1xkv5THrcuh903sVtTYr98sVRT+kkR25y5VnwGV9jvl
	 mk1EIF3S7wvRr11IhBHwjommXouRYTHPdUYao6fAF+yRDp8Z1thoprxdT1ZBp8mtKQQXx
	 yvKWbUHAAHEZs9cINBEoTGTbTyyZzIg8dfR+blHKEc4e2mEqylEIQU8NWpTHxcYUPJjWa
	 4MWLrMR82ALi8cctpsK0avSl3hjEy7hDV5TFDo0Y3aMNz+rk0gLBkx/+uIJxZ7dXftg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1VYoMqP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C52606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1VYoMqP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943CF1F0089F;
	Wed, 11 Nov 2026 00:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356265;
	bh=n9EkYwWQcCGTYc2XHZRjpMsJdFASlNxnszN8JwS8YsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j1VYoMqPHWdeHF42nnxM4Y7RwR71TjViV+9pKNz0QYLC21C0MkoDXcKqix0hHtMTg
	 IVrfsOrGd0AHS0UZp4GWuDRnu6BFiaU5rhec+sbJk/f7TMg9dSV6TpM6jptL9Ew+Tp
	 6CNvteqhSwbD5m9J1sU0gJEw5+ybcnL8XHV96FW6v1yOgPl97gkQOIPsS7uDAWysrM
	 PoNwa92dEGmgHI+0QfLC8X9Msn70MQxwczFL6yzUrRjkROSgdc7zl+IgDYSTfShPZE
	 veYAbfkW6WkhQ9AaYmeIE+2o8JXIcC7wxEOVyAYmAE9IyIGTL0Y/iM2BhFlVMnnjRf
	 l7ODJEXOz4d6g==
Message-ID: <sashiko-outbox-208008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 04/16] ALSA: pcm: notify drivers after linked
 prepare completes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-5-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:17:45 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A linked prepare can finish one member before another member's driver
> prepare or reset fails. Drivers that admit transfers after their own
> prepare callback can then accept an ACK while the group action is still
> incomplete.
>=20
> Add an optional prepare_complete callback. After all sleeping prepare
> and reset actions have succeeded, take the group and member PCM locks,
> publish every PREPARED state, and notify opted-in drivers before
> releasing those locks. Keep the buffer locks and access gates held
> throughout the operation. A concurrent DROP observes the group before or
> after this commit point.
>=20
> On a driver error, notify only the attempted prefix, including the
> failing member. Opted-in members in that prefix return to SETUP. Leave
> unreached members untouched. Preflight failures have no completion
> callback. Preserve SUSPENDED and DISCONNECTED states if finalization
> finds either in the affected group or prefix. Successful driver actions
> canceled by such a state return -ESTRPIPE or -EBADFD, respectively. A
> driver error keeps its original return value. DISCONNECTED takes
> precedence when a linked group contains both terminal states.
>=20
> Do not generate a stop-timer event while closing prepare admission.
> Ordinary legacy drivers keep their existing successful preparation and
> pointer rebasing. The new callback runs with the group and member locks
> held and must neither sleep nor acquire another PCM stream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D4

