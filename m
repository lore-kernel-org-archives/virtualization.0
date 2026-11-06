Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793924231;
	b=ouksWQFL9yt1ypMnu79hn0Et0ihf+KjIA7rKhpg7w1NFxxud+BFhffBC1WbkSXTxnx4s
	 Rtbb6wofpfXd/EmrUn6D0aa8ZTQC0BVmQ9mLyjStfM9J+i3ep0JarKKdWN94t1BazaUJn
	 E73HYSCeteliVTFXh4FnoXNgg0kBdN7uGMddDVf090GgLVMvDYEKNijGeOCXcp985DtGS
	 iRO0vUG3zYvoOC+gVpRr+P/Fl77lnu5fXlD9zFZES6GIMTPNNAuah+TimiYh7mqkK/3a3
	 2m6PrsjF0FJiaCc7TBnGplsCtlbxFNzLTNYjcUn0e5CSQVr2gFQ2dvqJ6J9d/M2w9zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924231;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SU6H1R7L1Yyx24JFXkrkEvYfOKxB+3r5RMOK/N/Q4BI=;
	b=GZE7/kr95mx55NmeMQ3dj8S82vy0ZS6CCN45kAFPk/YVXZ49kkQLcOcz2Xq/NjQdn72X
	 B6N7YtSGB8fNY5Z6NUIDAkHcVNDSUFwca4M6FBOZP83GD8ZPE2ir0oeHmFBGJleXsSU4t
	 nkL+a7YM/gTyLAFLAtCzrNZ/dJp7ZESXT9sKvubjLvkiF40r89hrbGpGhRQdbTCxmzaco
	 ftkap6HHQTp0I4/MFLW47rhWdXn6VzmK1CU81k6Wd45JKCHaMcxjyxjhtHj1tdpdTsPIs
	 GVoGZ/stSJ7mA1fud+PlhcR8Ey5R7qWoBOBjN+x5KSrXwHYjg1KYtn8nWIp4OHiQuug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKISnjRN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E269606A31B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKISnjRN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E451F0089F;
	Fri,  6 Nov 2026 00:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793924231;
	bh=SU6H1R7L1Yyx24JFXkrkEvYfOKxB+3r5RMOK/N/Q4BI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BKISnjRNQNiN3khkEDdGcyfmsATbDfnXqgi2qlNVfTArOD9NlbRinQlEOrqYY603r
	 5oKWIB6nUmbcTR0el7TD/1vV7T/jTsq8pfoIiqmmeSjKMzkGVdasTEMQLRLmpb8Nen
	 h1HXnRFmjoVdfHUTsILmfBV0LXPKc0p12tRRUKpeN7iq4e5c4RWh9eQYolONed/Gk9
	 lGkeL9bWgp2tcXm9UIc8wWimvm9wNwmDq1KaKewVur4pqQGCEW07TyxBdaZR96O7by
	 d9DSbbEJxq2uIVxHUUiXdud7Mj6sXSKndC4qGeBRs2/AhOPdiKt+wyvb5/mcvuA6gO
	 ZCxBMOFHD6kFg==
Message-ID: <sashiko-outbox-200432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 12/12] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106000644.20460-13-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
 <20261106000644.20460-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:17:10 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document the five opt-in virtio_snd capture module parameters. State
> that capture_allow_empty, capture_allow_short, capture_packed_status and
> capture_pause_restart require capture_staging, and use the ALSA kernel
> parameter restriction tag for each entry.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106000644.2046=
0-1-mynameisjune111@gmail.com?part=3D12

