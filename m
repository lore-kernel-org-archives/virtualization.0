Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3C5A79B;
	Mon, 12 Oct 2026 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802694; cv=none; b=Ag3kqxy7CQ4QEwSXi9T2ZhbajBON/NRSWEpnbz276AL2QCmtV4NnCvLo0mUWHPye63BpdpfxPpwB6kHwNFlYCrMnddYYfpV7CYdfqIbaqCdQYzKuUJQG4hOu4g9baA9ipGL+/3FO47spCLKxf5iZMJ2laoKL9ZTjBn1xByV3CAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802694; c=relaxed/simple;
	bh=jWCXVBRnw6Ro09IFp+7+93R08arNtiyF1Gy7wYG5gfk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XlA5DUii/L+TK14UyamLpls7D2as1nhj1Tc3VhxNdN1BCkPCilozkoklyXMU8ASt9pLtmof6mOezAIlLKX6c9Y9Pb0X7PwuahnvTo3dKSy1rgFIlqLXNrGjJTdSIA/Gt7lHJMLtWoD3PTh19VxENV+6Rv3qUwKytKcdbTStxgj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPXnoH93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPXnoH93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19A81F0089B;
	Mon, 12 Oct 2026 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791802693;
	bh=zBo646bvUBCMrdKyOfz8JgGTR+qahxfgGoy7njxgB4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MPXnoH93GLZx6i9UlvBsUicF1wlw39LcXyI1iPmp6Kt6coocbMAInJ43Kleikd3Dk
	 8e4xfgb5SvGDoM7IJsuypIEOvNmPoErEXxW9erzkJEyJ+1XPCnUTzwaWSM4PLfsZw2
	 h2j9MS1y769epBzzq3JTTcyx7Wb8YzaJwn1TqPemAQKvnntCCrrOGb1ZC5OT2o/jLG
	 2h8/M0Pj7MgbfvMVplHxlBEL8dSEjqt2Teo64TSrk9tRtcce5uSwx/p84R/NP6N+Qu
	 IxqYS0G/kXu0g319k2a28pkHFVmpxHfxApul/yYVi6O7U4fCGVemMHNkWF+bnNoEN+
	 K6maGRKz5G+gw==
Message-ID: <sashiko-outbox-167998@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] vhost-scsi: do not count PI bytes in the data length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261012103954.136698-1-physicalmtea@gmail.com>
References: <20261012103954.136698-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 10:58:12 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> vhost_scsi_handle_vq() moves pi_bytesout or pi_bytesin into the
> protection sgl and subtracts those bytes from exp_data_len.  The length
> passed to TCM is still exp_data_len + prot_bytes.
>=20
> prot_bytes comes from virtio_scsi_cmd_req_pi.  With
> VIRTIO_SCSI_F_T10_PI negotiated, vhost reads that header and does not
> check that the CDB is a READ or WRITE.  sbc_check_prot() replaces
> data_length from the CDB only when the protect field is non-zero.
> target_cmd_size_check() leaves a write's data_length unchanged when the
> CDB size is smaller, so a command that does not get that replacement
> keeps a data_length larger than the data sgl.
>=20
> The KASAN report is a MODE SELECT whose header had pi_bytesout set.
> The data sgl held only the parameter list.  spc_emulate_modeselect()
> walked data_length and read the next physical page.
> [ ... ]
>   ret_from_fork
>   ret_from_fork_asm
>=20
> Fixes: 9f977ef7b671 ("vhost-scsi: Include prot_bytes into expected data t=
ransfer length")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012103954.1366=
98-1-physicalmtea@gmail.com?part=3D1

