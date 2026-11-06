Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982497;
	b=l21UfOlrFZxv46kTSOh6zzgeNxLcm/jtmIptyNylc+ovOTQQKXmmBV/E17xVLImtxxjM
	 XyHQEu+lsUsrfQgVU9OjDpnbBVeeqSJnzDh7fwijL6CvG45NUWtiGo+lSofpCEBdP09gU
	 YpQI1ZTNW7kT8heW9DXjc4I25W25tz57vm4I1T4knLfDMYBpDlSQsjDbOV+6RqmU46q9Q
	 80cfTgDTWVVPMG86lEVuq73LXFGUzU2rRJPK1+0ftcHVApYQVvSuzLYvNezQV+hEx3eLS
	 xvGDvtjDy6yVqqUUxNbWDuavKgobk9iIRbNAlEFszu4RNpdZhQQrNqy+MKujkbCeLFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982497;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lAzREmPd8V04xkZahNISw8+faOXFwqXGCzhg8LhXU2c=;
	b=XUMdX4fXn8zo99V69Pa2Q/7HmrWVQ/mYEU9DW5UWyC2zBEP8haDZWIltAHaHne2tsh5C
	 cUWarS/wOFYo/Qkzl44rvnFZ4pn/SEnaVPz+lCztm7CagkKfIp9M0HQsp4uhL4T/701Og
	 +64VlHSp4iKjnDfjqLODBZMwAKslBZoRpTpGpqrSOmauc0tWDzyoyhh8Cx/cVibPWqDTH
	 uoXnXImSTxp38jy1KH/yYbpoQ5twC3C/qOv8VpE3ADbKbRJYe5EJmdVOwA+wsXYtEU2jF
	 TEiyfPJd9P5RdRwBQ5cyNqdADUbFSaGJrCLvzZoTwbCEdBP/xu+yUbvE9QKueJQ9mMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJnFWhnq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0C606A32E
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJnFWhnq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0F51F0089F;
	Fri,  6 Nov 2026 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982497;
	bh=lAzREmPd8V04xkZahNISw8+faOXFwqXGCzhg8LhXU2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IJnFWhnqahWFhoE5JXCMMu3ymDOVhoF11VkY7Gr2K5HXV9AyejIv68o3Y5xi1FbYz
	 8AxkDeSf054aVdF5zCYRZWv8jcF0AEkI97nPQah2/KHhUvm+Dh1zydw3Jujzk/F8sc
	 aTwIM/BWEZR6t1eXFs9fWoCNNxtII8D3wsS9G2a2++oj79L1TlR30FRV6DR1qeDwUK
	 7+tFMyeLxYximLuYN67HmYmmNJiCGRiFXjxF1wcbWYXhaMsJsQ1JE5KHgQx9C9ZovX
	 fme26jWzlALCdUKUNDcjiSenMwP+as4JxzxujZSLIGMPsLlBpZ8Zs7kvyPuUZB2goC
	 0sUxo0nod12Sg==
Message-ID: <sashiko-outbox-201812@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 01/12] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106161838.94308-2-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
 <20261106161838.94308-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:28:16 +0000
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
> READ_ONCE policy sampling in patch 9.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106161838.9430=
8-1-mynameisjune111@gmail.com?part=3D1

