Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365837F32E;
	Sun,  4 Oct 2026 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099619; cv=none; b=WlbL9kW8+K5z59YLK2/VDy7nXCt4m1S48xCsokkiNSS+xT36O6Tv3aROTydTitn9dBLSJTxwc8YXy+qTjF+iUwq6dJ5hd9Tj9GCwDP8XlkjPas7fBq1N1QDZhZOTz65YgGWMMVh4wOrysrimOKci6Pl0gnGNjVlyPrZT8FNndXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099619; c=relaxed/simple;
	bh=TwUKx9+VNY09jetDGXKlfxLNLnX1KIaLcta90PBDXzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eB82FDNhYcN0/mYuNttKTJutqDErXdMJJDcTgJuArzYPx+TSHBKPtCmabPyBdj0HPxQw0my34sjGOs8AJWqwxxobrxGVKRnHvrhq7Np+us3R3hBbwpYTCyNuq0pCfXYU4R5ItSXNTOdA/ixYEmK/ycSPDraDclmBzK+vZy+bx1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL0RGdWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL0RGdWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AC11F000FF;
	Sun,  4 Oct 2026 07:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791099617;
	bh=xsdtTVezR8rCaYXY+08CjVTsy6gChxgLwa4fTY7m+yw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hL0RGdWsAWH/qZxLplmOTcp5I9vPdT9t72TRmNg6yqspWH9jOf39+I8GvpuhV84vY
	 G3UqHQVxQ/4+6dBU4u9z69m7rn5+TpFo4njx03ZnsmYSlKXgymIBJ6hHBBLT6aPzn4
	 Jg5Bo+l19RRASWNNxNR27PGaEYsdUjclX0XrW4Ntl499dfFe9ETqIpplDjy03aKhBE
	 XOG0lMFbnTLvl+LHWERwgCvAYk4d+hsA5rnUC1S4sFTnBt3Vb+cNs8oz3EEKJuScN+
	 7cjO0y6uAFXQ6gMelOZLah6EAzb6NuGQvXtXoiOvWx/ORVp7rz99MQNX6/9r0I8JlM
	 /FOvz95xwTFQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] vhost/vsock: size receive SKBs from declared
 payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daehyeon Ko" <4ncienth@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev
In-Reply-To: <20261004073419.4039011-1-4ncienth@gmail.com>
References: <20261004073419.4039011-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 07:40:17 +0000
Message-Id: <20261004074017.80AC11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> vhost_vsock_alloc_skb() allocates an skb from the total guest descriptor
> length before reading hdr->len.  Descriptor capacity and declared payload
> length are independent, so a guest can supply a large descriptor with a
> zero or short payload.
>=20
> On Linux v7.2, 455 zero-payload packets with 64 KiB descriptors retained
> 30,255,680 bytes on a 256 KiB receive buffer while rx_bytes and buf_used
> stayed zero.  A full-payload control retained 265,984 bytes.  The existing
> SKB_TRUESIZE(0) budget caps skb count but does not account for the
> descriptor-sized allocation.
>=20
> Repeating this across connections can exhaust host kernel memory.
>=20
> Trimming after allocation is insufficient.  Linear skbs retain their full
> head, while a nonlinear payload exceeding head tailroom can retain its
> first page fragment.
>=20
> Copy the header into a stack object, validate hdr->len before allocating,
> and size the skb from the declared payload plus the header.  This keeps t=
he
> allocation proportional to receive accounting for both linear and
> nonlinear skbs.
>=20
> Use payload_len > len - sizeof(hdr) for validation.  This avoids addition
> overflow on 32-bit hosts and ensures payload_len fits the subsequent
> int-length copy path.
>=20
> Fixes: ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs for handling l=
arge receive buffers")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004073419.4039=
011-1-4ncienth@gmail.com?part=3D1

