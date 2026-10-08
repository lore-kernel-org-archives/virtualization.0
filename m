Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257743D3CFF
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444551; cv=none; b=MThkBrbm8uUgn74XxUZaXncvhmQ2YhvIF//FWBbAc1dW9xI9LKdFger6brZyyJd4rWAlQ+WOmQIbSW0ds+bNow89dVHcB36ugeAmOGaeErReNkc3f2DS1QokJA2ukIaODzMmlyF1CCxRN5DeFXcvMquoeQ012PhhCCevtbZ3a6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444551; c=relaxed/simple;
	bh=F1aJkc+aZj1XO3gFFnD7V+lPNgSFdoKsaGI0IJLRlWE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=A/5DtMqmqPgU1jHABPTbWjKrthRO5u1HSjyms3kaw0isgLoFkBpiEW5sHcKRHgVz5a7+yM9vx4mzjFupV50vSN8eBXPoZU5YXK2L5LvQf61qPz+amf82IZLjN+Pxt5t0Jj+GAJlucMGytxhuNY7cY/dMwVPRX9D/Yc4Bw/4uT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9MQDLfk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9MQDLfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469C21F00893;
	Thu,  8 Oct 2026 07:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791444549;
	bh=F1aJkc+aZj1XO3gFFnD7V+lPNgSFdoKsaGI0IJLRlWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g9MQDLfkeyfvsBRqxRDT+XUsL/uzqLFxeeMN8QCAHDSshdLReWCWQmMQ4uco14uya
	 06nWbcCje5k85IHGAi3fBp/RgImIcXVNQEnHXvUbMDu5KknxlT/x6MCbicVDFq3i43
	 zXR9PGhjDzcsPxRbn9sSduXapFCeUlrTdyNChiFJBJgH99HxyEMwGAI5AJiA06MuP7
	 w/tLrdHwu+Y8MEiczK8X9UyEMFJMYT3pVqpv/IOXLXNyD7QvJV6x95RSidIutSNgfo
	 xv0+/3VnOYK3CYnHTfuSdnCAKLxLvx+1LJyX+tYpZvb2dzFIIPI4Q6HyLi+VCYa8YW
	 pd0b/evfvqmAg==
Message-ID: <sashiko-outbox-163757@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/13] x86/msr: Remove rdmsr_safe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261008071839.2247074-4-jgross@suse.com>
References: <20261008071839.2247074-1-jgross@suse.com>
 <20261008071839.2247074-4-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 07:29:08 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> rdmsr_safe() has no users left. Delete it.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008071839.2247=
074-1-jgross@suse.com?part=3D3

