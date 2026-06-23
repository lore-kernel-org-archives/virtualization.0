Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71526F2BF;
	Tue, 23 Jun 2026 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217393; cv=none; b=u98PINTCyE11pqqVYF7utkNpEMN2SBDxynLJyGrBMKRreNpt+xew1W1nofbVMI5P8ZP4XECHMv6osHAGDQLeXYeKbkZtu3UBLDtzvW3wX4+Jm5HXbOsyi/K/hf6rFYMYC0noPrZXRCPp5+TdydFZ34FcWbAptGz8X1PD7sRkFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217393; c=relaxed/simple;
	bh=oKS7djhZMShjtBJXE+8Ol06UKF1SeaAy7/05xhRr/A4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z3qBSFM8puHMbNh51+gsTU0xqlpXsf+d7dRC2qGIUREb/S75TH8izTeO8a7zW4efnw6a1PmfGlJbUKu+Tc75q/Hs+5RQsQmmlaK+CtkIwQ/QHldY/55zgjpfppdfq0SbnaGTEmuh1bx69tuH9SqKAjWz2M170vOlA54MCwK4SkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St1G5y2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St1G5y2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7631F000E9;
	Tue, 23 Jun 2026 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782217392;
	bh=1R2JmcSBJ9hhc9XkLoH0Y29gsCImg0RQzwJhPe2LY3o=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=St1G5y2BEsN4MDxwqtm9l8wk8s+xgsmSN8D8goDW44412NRvuSrLoEWNzcT8Mto6z
	 0p1cldldlAzPNTyj+tCx+7I7MIcT7AE1mac31xX2aDTv0/lFC5rJAa3L4VYsiW5Ibl
	 pEyhOsEQfaJ+gShZ0k8u8J1YwgIE7qrVCH0yQV9ccbTTH9pFLeAC5m9s/eu3JK3zR4
	 iSV7WwYnCms/jGN8Pz6DmPLN/et652XtWMOURCWlb2+vrTVtBqHMHhO0DWzqiyQomR
	 lLVhQlcXf9wduuJTSSZqw0IKADV1EbdrAnjv9aMVS4g5JaXNIfDm8tvuTeBAnDF+NR
	 QykyDb+20OPiw==
Message-ID: <a31c1a44826d420eb1c1e5e4f877f6c3df8d5507.camel@kernel.org>
Subject: Re: [PATCH] virtio_console: fix endian conversion in
 handle_control_message()
From: Amit Shah <amit@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 23 Jun 2026 14:23:09 +0200
In-Reply-To: <20260623092141.631355-1-ben.dooks@codethink.co.uk>
References: <20260623092141.631355-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, 2026-06-23 at 10:21 +0100, Ben Dooks wrote:
> There are a couple of prints in handle_control_message() which should
> have converted cpkt->id through virtio32_to_cpu() before passing to
> a print.
>=20
> This fixes the following (prototype) sparse warnings:
> drivers/char/virtio_console.c:1538:17: warning: incorrect type in
> argument 4 (different base types)
> drivers/char/virtio_console.c:1538:17:=C2=A0=C2=A0=C2=A0 expected unsigne=
d int
> drivers/char/virtio_console.c:1538:17:=C2=A0=C2=A0=C2=A0 got restricted _=
_virtio32
> [usertype] id
> drivers/char/virtio_console.c:1553:25: warning: incorrect type in
> argument 3 (different base types)
> drivers/char/virtio_console.c:1553:25:=C2=A0=C2=A0=C2=A0 expected unsigne=
d int
> drivers/char/virtio_console.c:1553:25:=C2=A0=C2=A0=C2=A0 got restricted _=
_virtio32
> [usertype] id
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Amit Shah <amit@kernel.org>

		Amit
