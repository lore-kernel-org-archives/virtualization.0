Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462814;
	b=KYotTqzee9Q4CZsnSbeqFvh2PnA/0J1gpWQxw2FJlGPDs82Cu4mrnfImEChQlvg78rMo
	 JSypFLFjOP+Tgd6ecKJFrpdIOdErLGJlKUY0pQmq8oZ9kYHxpmr6s0eeDDQzt7Qsq/Ekc
	 k2hNJA60scpVkF0qx9OHKsnXO9y2CWTbCog3TvLR7bLA6V4F0j8JQUhlR1PJPd2ye9fkj
	 Br3tpzVC/iN7I2YVsTJnzYQWTHgbw8/j1/ASNo6A48575LX0Hid9llm6GDZsBhKIU9eI5
	 5fJQ5nV1h9MfPxh7EthZwZAYgq7bly4SXOJLFMuu8gigMTbowsWY+d2LztD2MuEMV/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462814;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q51jPlumwFO7fmU1ywcR+IilhdFLHR1cpdlX9HfO54s=;
	b=nCBdJoqUh47BDs+km2+d8XkpKQy5TYJPFrvMWPY2jhTqL5DVXa72vgi+/fNIdFrFbBPO
	 brvYrXrqXH3yMv1wBx6xneZBlartZEzzFNs8TkRkghBl/5ad0Vr3C8mUQQIWyILJdzKm6
	 50qCddLZc5ARvwjzx4DTZgtoC1vesVVvLA28BPHawxV7idMEp/G6PTxr4UremQkNVFgQb
	 Ah84H2CQ196vgkenkgJhGzVG/cSZFRI8TBA+U/1XTCQI8TZOCID6lu2MDuHKZgq85FhOm
	 fZlMbxmMmtuj9sPlOAHGK3nk6FWTsQMhwwv/uZZzdMknkGc7MjDui7bGQXTsIVA3t9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HC+AcdaH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5647606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HC+AcdaH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045841F00A05;
	Thu, 12 Nov 2026 05:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462814;
	bh=q51jPlumwFO7fmU1ywcR+IilhdFLHR1cpdlX9HfO54s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HC+AcdaH/BcywI8+2W9BwW3U8y64C+N5YkUzQXROk5N+/TJl4QpwKk57X9m4JyG0q
	 UfIDiENqyJeMRXkl3qMHz128R/RhJ99QTWRHIpsdKbr8Zan3sSv/csT2SXyI13D5Qd
	 gniZea3egTqik35NDJBggFJAAhHl5ffHKqAzXTxNtkqb31P1tlcp4LPs5MevLezqiM
	 rWmsgLIPHYxaKRm+1meELNg4h2/IuTOq5qtMZIJ3046P/Yx93vDMycgS0l9rIop6wr
	 28cd89RDpmQHWAbxY/5zITPAlDt+EmTxQE1BYIjqpwtDPCvj2iHwUpPp+7t4HwrHZb
	 YxYM4tqBUxJZA==
Message-ID: <sashiko-outbox-210486@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 15/17] ALSA: virtio: reject invalid playback
 completions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-16-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-16-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:53:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A TX completion currently advances the hardware position even when the
> used length is malformed or the device reports an error. Validate the
> fixed status response before publishing progress. Retire the request
> once, latch XRUN and schedule error delivery while preparation is
> active. Keep malformed or failed transfers out of successful playback
> byte accounting.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D15

