Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE403D9558;
	Wed, 16 Sep 2026 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535804; cv=none; b=E2Ev4Vj9cSJLFKyM2xJJl2so3N0t32AEfhiXuJLjNVo9Q2e2it+nPvyrSODelTv4VFpms9nQ9RoFOR2D2EruyJH+VSdLNkTLS8lk4RuzUtvIJpG2L9ZNjNDafVJJIckeRHzTgRstMhT9WQidJ6+YBWEHGxR5o8bDiST8oxfqoLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535804; c=relaxed/simple;
	bh=EV75Lo1RnTPNfDHilEOJJw/QZ4DeMJpCLNdibHXNLzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mLRVmy+07gFz3gavtaz8WjPPpghUqhl/DNA5paXbErErGqi3gteuXfKgGP0QRqmqoGCipw0NIuf9bImFDzxZksxKU6PAuPxCgz2Ug8Qzm1RydwetKoeW/lgFlku6+SUkdcNMsW+gMkdaPCAP9yD1igiBDiKEkl41n0XY5Tsb9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsAvflTT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsAvflTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EAE1F000FF;
	Wed, 16 Sep 2026 05:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789535801;
	bh=EV75Lo1RnTPNfDHilEOJJw/QZ4DeMJpCLNdibHXNLzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nsAvflTTuNkVkHLizjzKMvQCTP0dhUPed9363GsF7ULJrMt6L4Xwt/2xyQVsG454j
	 zfH0WnfeQpLjuF8wtL7dXcYMGocbfV7BUWL8ch50CrlT22ddRcPX9vxbe7XEYi5nsY
	 J7v4YFVC4xUn9XF880ybwH8JbxpAN/c3stBx8gGjxAdILFqewHb/M+LRS/Ucvf47vW
	 Tqa3o7JI+qnhMp263e62zmO2m3zMpeJGKOEQTkUVTr9k0Zpx5R2qQ152rpVTl+0t48
	 ghGHEF+vvXvmOAjwmUULZwaCMNRjK04zw8BXaHwIWpQ5CYXvQtGXX7E5ZiuNTvGhNc
	 TcZ1IEpKuMEig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] percpu: Use X86_MEM_ENCRYPT for decrypted
 per-CPU data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <07cdda86e2c60b27a18023e2e5fae339b78db0ab.1789488039.git.zack.rusin@broadcom.com>
References: <cover.1789488039.git.zack.rusin@broadcom.com>
 <07cdda86e2c60b27a18023e2e5fae339b78db0ab.1789488039.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 05:16:40 +0000
Message-Id: <20260916051641.21EAE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Decrypted per-CPU data is gated by AMD_MEM_ENCRYPT. With
> INTEL_TDX_GUEST=3Dy and AMD_MEM_ENCRYPT=3Dn it falls back to ordinary
> per-CPU storage, so converting a variable to shared memory can expose
> unrelated data on the same page.
>=20
> Gate the declarations and linker section on X86_MEM_ENCRYPT, which both
> AMD_MEM_ENCRYPT and INTEL_TDX_GUEST select. Existing AMD configurations
> are unchanged.
>=20
> Keep the decrypted subsection page-aligned at both ends. The per-CPU
> template and each allocated per-CPU unit are also page-aligned, so page
> conversion cannot expose ordinary per-CPU data. TDX-only configurations
> may need additional space for this alignment and isolation.
>=20
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789488039.gi=
t.zack.rusin@broadcom.com?part=3D1

