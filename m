Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265569;
	b=IRqWXLi1LBdkjSzP6BB1hkIUHGhrEqhExj0ZJNAKNFaIk5Zag5RuUSJWAd+gppS2iDYK
	 k827Gl+XLQJVHcapjdqq0bpPBaeZ1liRFQkckD8sBEn6BmuLL/qXUCJmMpn31vzdAaa3n
	 /fuAq1I32eW6OX1pm9OQrEskUNxy1Ib/dTTsprh7hN+4eBQ/1/g9/9CAimigxPt9s/5sR
	 LGJJVxMhHw8tJX4mKFBxiNxFgD3d4Ag3F1MFKUMYr+Fn3+G6r35Sib9yfZzMFAH1pN/58
	 +MBSUkSKG9R0WY0DHW7Sfs7j0Nca2xgEZpHDdeI9M2UTlSpnZfmRBzd7h0FX+SUkAVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1mccbGATVn3MhFywTGCd3V71SEenNi5NNrAEe9iR35A=;
	b=azqK+jHyiUx8H8+Q/zttF+WX6lw5E+REfbFJxzXuP/PAYdwZ6sE1p3YNFwZLixkmM1/g
	 C6I0Ap4hKRp9XsxeR7jV+S6Dayvj9blfYy2IodZw2dFPLyLjg+bHcg1pDlKhLHlfyLm7c
	 Ih7Tl83B0GnrL2NM8fxZNat2U4f2ZQ5wkKQykcrHBFtdkpw64bN1F89PVNCYFAG91EIPR
	 F0iPVy+yYtScGGhwPgUGKilbXmaYhgzo0fSreMGOXcS3r3CfzT3fZDJoOTfqENk2Gh7ka
	 5BE0COs+2Pr2FadUvU8+8oIyhtgbGg7BTWr5yPPk/DbcuiGggWQqlXL+cGNR6uZnnZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPz+zI39;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8302606A31C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPz+zI39
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D1D1F01825;
	Thu, 29 Oct 2026 09:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265568;
	bh=1mccbGATVn3MhFywTGCd3V71SEenNi5NNrAEe9iR35A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BPz+zI3923cN98t7xUPjmlZX7Rop1faVYstUT7MvBAaCwDLBlRjrfaTJ3Eeur73nh
	 kI0MzW7V9dVrvRfNXxpYl5vxzPg21cOPLoQ7Dfar9x6janSnGLPUxy0UhmZeoWnPKV
	 /XAer5WuG1HjMvIZUkA07PXAn5opzholXwnhtGkmeze+S72MVhU8W6GYT3ZT3ViJmf
	 BY2iA2sIgmFpQqm8csstt+FYM7AgsvamTQTUbn5YK/eST7d4PZsOEkJpsQ1EksA12I
	 EbdVJdL4jEgRauhs7AbULH/N9YG7l4hEnxKXk9uYcHDlx/BDuKZRBATRxqohp0r5wV
	 b1xXB5LU0svTg==
Message-ID: <sashiko-outbox-189022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/14] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-4-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:19:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Keep the control queue available through snd_card_free() so close-time
> STOP and RELEASE commands can still be submitted. Block new control
> requests and mark pending messages canceled before reset, then release
> their queue references only after reset and queue deletion.
>=20
> For PCM queues, detach each remaining virtqueue buffer after the device
> has stopped DMA and retire its message without reporting a normal
> completion. Detach all queues before deleting them so outstanding DMA
> mappings are unmapped and no token remains for a late device completion.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D3

