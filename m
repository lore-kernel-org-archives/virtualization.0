Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AAB3CD8BD;
	Tue,  6 Oct 2026 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275341; cv=none; b=Wjw28sgEnoSxtyFGxtevfdmxp8WlYXh+pGkEaqDr2XvWuseW7gQ6Go6z0HdHdn77wB8TNy2aRdtKiky09A7BbxljAwHKluzo2Mx9G42V1M87o+4tLqgOXThJ8/1e2BWR1ynPUaY3NbQo/qXus43T6UeD1fkC8NPGgjwC/arRr9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275341; c=relaxed/simple;
	bh=4iw3G0TbgLLSK0wn4Oi01o41mOFoWSuTHvidFV5xYSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oY86+kpS2tAGmTYw0JlDNW18J1iAHczPJA51I8R4PwWthUkQm5uL/EtfEU7+xNEcuh8AcymYdf9IRi+tRzxv9AWKNcVDrdzdDwRECiHQAzXoBXcIFeBziL+M1hVHqncoVp9UKAZqIm8BMqokITXE3oEb1edFDXHV0bXzZGgqdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA5oYM9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA5oYM9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5664C1F000FF;
	Tue,  6 Oct 2026 08:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791275340;
	bh=jmbOLCQaT2M2vqA5H+5LHx9I5pcwz+t1V9YKBKhM64o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UA5oYM9eAErTf9a92wPUf/7h/LkPqNPPufEg4p1DZWOkTNSWP1fipmxt+itPxY6wo
	 +SnT5XfdHKbpXVGlIok7LFXW/ak1mKYSKTETxk65cEUcT4eHHY1CyW8RYw+AZIzQ2t
	 xFfpliMoifZ7lewQqTMlk/ps8pM7xdou/m4j7g3iDYMHtz8QpifPWby0QSPaIJO2Uc
	 Rvh4ziQk+1neliJurQ86/Uw7P4BvGAfE88PMpnhsIuqZCg8VJX5ehKGgrhj5y/UU+x
	 GwDWcTnjjnGlH5/I1HY5skMN/Pw8uR73W72cnI3w1oaH7l/TVYX/8lcjYinKGixPyn
	 0LC2Im+P6RPvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost-scsi: do not count PI bytes in the data length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org
In-Reply-To: <20261006082102.27085-1-physicalmtea@gmail.com>
References: <20261006082102.27085-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:28:59 +0000
Message-Id: <20261006082900.5664C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> vhost_scsi_handle_vq() moves pi_bytesout and pi_bytesin into the
> protection sgl and subtracts them from exp_data_len.  The length passed
> to TCM is still exp_data_len + prot_bytes.
>=20
> That sum matched an older target path which subtracted prot_length
> again.  sbc_check_prot() now replaces data_length from the CDB only
> when the protect field is non-zero, and only for READ and WRITE.
> target_cmd_size_check() leaves a write's data_length unchanged when the
> CDB size is smaller.
>=20
> MODE SELECT, SET TARGET PORT GROUPS and UNMAP then use data_length as
> the size of t_data_sg.  The PI bytes are not in that sgl.  A parameter
> list that ends on a page is followed by a read of the next physical
> page.
>=20
> [ ... ]
>   ret_from_fork
>   ret_from_fork_asm
>=20
> Fixes: 9f977ef7b671 ("vhost-scsi: Include prot_bytes into expected data t=
ransfer length")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006082102.2708=
5-1-physicalmtea@gmail.com?part=3D1

