Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692815;
	b=XTRBUZ6kYPYgj8E+oCn56KG0xfSqfYUC/indj0zA8cwuioqMPvKxa0ISeFzuTSL4lxnE
	 aztlhwDOjztjLz6OfNCzOCI8UOOrPk+p56q/3fJpfdpg50UMhSLTEXMK2TYSbJKtaEukM
	 Vw13bGe87+gsRlGblInmijvrIOGssNDmgGe8Cg2Ceyoc7uLbsgXikHiexQSS6aYZxJMwI
	 KDv0rb82xSLxQvCyk9vIGWlC8aUpT1ecAzkTNzbsFwtnOuT+cxUA5ozV8eHhUj3leESEU
	 nsWImLGAhsH3USO0TV2PBW3YC5ybGK/oJFn4b1zPXtFiXBMHKrgUj/HlVfyVj3+bYNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692815;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hsqZmaqCawpJnaTognm7aA36Scren9Jybtra+jnBacQ=;
	b=lP+Ajn0EOQ8Cxf3oBiRxYzW2leU1e6kLjvJXbOSLtTYw+/+PXuDe4k+lFg/YsYXrR9nY
	 3AunGOqrwaRyVARKly/46cZmyranDRalpzniaZve13nLlmRFN1ZsamuUXI6bCHK9ErnCU
	 lCP1OqZ/ShuByL9wQgKTEgVxe1h+Fc8mdu7+FwAef/NyuH8m8GCfD6ivCLCb6d1WoarYz
	 c/78v/OrH16CU75xdlrwNqYZB+abvj1irZrYywitWe+GpxOYKUVQiiXfjdb9VZbJpDZz+
	 VKxzyXwNGYd32ErZXDRdGIl1cJZ/14dy6MCztBiCxcHRyWnMWeogDg81kqITR0p2j6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ghKdtH/k";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54238606A32E
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghKdtH/k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E0B1F00919;
	Tue,  3 Nov 2026 08:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692815;
	bh=hsqZmaqCawpJnaTognm7aA36Scren9Jybtra+jnBacQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ghKdtH/kvmetF90fZORBSgxQj7v/ZmTk0xp//NIyxY3zOoJPc75FBR1NkKj1qNBK2
	 AdWYoWbPnxL1jcwG663mgdnDdtsVKon109HwfmIvZApMjn/KB0gLEx+nqST9cD4H+A
	 N6AKJho8/ldriWREdoA5V49MDTKsESLV7mJrknBuJfVcTU6D/0AZm4vIdBdF4ISTBU
	 HPKvMqjj2ElBmKau20JPPLKxEyyX5RVQyU5wBWH09HyRLZDXGGBGmV+yBDSzmpfBtX
	 aRwUXOv9lLm17HBYsPMY5i4lq3eqfdfAwIMs8iM4RmnYPQ3AG5dSRqoHjGP6dc5JXY
	 3L2fvzR/MS55w==
Message-ID: <sashiko-outbox-194785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/vmware: Map vTPM as private in encrypted VMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <e0e5389688fe4102b639c42295305e08f306a092.1793692366.git.zack.rusin@broadcom.com>
References: <e0e5389688fe4102b639c42295305e08f306a092.1793692366.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:00:14 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Alex James <alex.james@broadcom.com>
>=20
> Encrypted VMware guests can use a virtual Trusted Platform Module
> (vTPM) implemented by a paravisor, trusted code running alongside Linux
> inside the protected VM. Its register page needs a private mapping so
> accesses reach the paravisor instead of host device emulation.
>=20
> The default ioremap() path maps device registers as shared. Without a
> VMware private-MMIO override, this also applies to the vTPM registers,
> preventing the guest from communicating with the paravisor's TPM.
>=20
> Install is_private_mmio() for the vTPM's single register page when guest
> memory encryption is active and firmware supplies a TPM event log. This
> lets ioremap() select a private mapping for the device. Hyper-V already
> does the same for its paravisor vTPM in hv_is_private_mmio(), added by
> commit 812b0597fb40 ("x86/hyperv: Change vTOM handling to use standard
> coco mechanisms").
>=20
> [ zack: Moved the include and explained the private-mapping requirement ]
>=20
> Signed-off-by: Alex James <alex.james@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/e0e5389688fe4102b63=
9c42295305e08f306a092.1793692366.git.zack.rusin@broadcom.com?part=3D1

