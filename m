Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D33B27E7
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281449; cv=none; b=r6xSHDTN2W8QMCprQz2Pn7MyPww+Xpf/XW4U9+FOtmlJ3d1DUpp19soEFv1AwmovqdkPnVjgKyUY0/y8eT4jSDZvbKyTS7UP71JIhfXq2CMNuedUpPb5WjW98RKr94oPB+0GXwF2xVFl0QZxrC2icCQr2I+oTxd4Atmsj065eqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281449; c=relaxed/simple;
	bh=f5ZaCcXphri7bMhe7GM20TiwTIEqiWMLqhHDtLfhq4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ESEDuqr6GZR6L3ba6FjyzyalJJ5PL+4jH3PRcut0+1iYpJooSEX0WpQLk48ToVCORYq4IlpFmp8pj4ORQfOy7PK6RFwBeSZM2f/Ih6L1PAh/AOBGpbM1IjFoU6ncNImFkv5kyTuw1VAY2oefvjstthc1M7ssmdBR3CcJ5iwC+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPtIyMUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPtIyMUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2285A1F000FF;
	Tue,  6 Oct 2026 10:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791281448;
	bh=f5ZaCcXphri7bMhe7GM20TiwTIEqiWMLqhHDtLfhq4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPtIyMUTIaYJ8mi8ODivKsttDO9xSlAJJeXv8NVDtC4k3o2/SGTCtDjc/MPQ84beX
	 SiboIoSLwwZnnYtbzxurPwc3k2UmqrQAuG5SKzkUkV/yyG3rmfewzxIgAP1tEb26wv
	 0bqPcNor33CmkZEpTaO9kp7FV5sMIH5VrgNviax0fGBYzIkmPIpy8qHJdynJUHzr8t
	 Qv/09taCxX7c7WHGoljFRwqer7bWDsAKwPIuSgvy71lmgygF6Y8dKtLfv7Mrjyijb0
	 c8nybvkNlV/YYPRXG9xPy5zNyq3qA9QG4NgwFnJAd2c1FVhxnr7SncnqHBlkv8rJW1
	 prtb6KXvZqtcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_ring: use shadow flags when detaching split
 descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: sungbyeongchan <tjdqudcks0424@naver.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261006100400.842345-1-tjdqudcks0424@naver.com>
References: <20261006100400.842345-1-tjdqudcks0424@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 10:10:47 +0000
Message-Id: <20261006101048.2285A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Split virtqueues save descriptor flags and next indexes in desc_extra
> before publishing descriptors to the device. The detach path uses the
> shadow next index, but decides whether to continue by rereading the NEXT
> flag from the shared descriptor.
>=20
> A device can change the flag after publication and make
> detach_buf_split_in_order() detach an adjacent active descriptor. This
> overcounts num_free and may put a descriptor on the free list twice.
>=20
> Use the shadow flags for the continuation decision as well. This keeps
> all detach metadata in the same driver-owned snapshot and avoids an
> unnecessary shared-ring read.
>=20
> A VDUSE/virtio-vdpa test which changed NEXT after publication made six
> valid completions return seven descriptors, with one descriptor ID
> duplicated on refill. With this change, the same test returned six
> unique descriptors, while the unmodified control remained unchanged.
>=20
> Fixes: 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra for s=
plit virtqueue")
> Assisted-by: LLM
> Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006100400.8423=
45-1-tjdqudcks0424@naver.com?part=3D1

