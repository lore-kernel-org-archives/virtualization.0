Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791173EC839
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444709; cv=none; b=Mem106zxFbyg8IxMxt62gpWsf6TebUc+CYT8LUC3FOq/KoiPzIdnujynxQCnybI3s4DdR+GaFibFmtGFKnh1q0uRcAZ3CV0UBBniGEs0sp3vnq3epPHjGVgvz2TbqKeL7N37Uu5/GlhI5uLe8VIFAOtcjk60/AKULw0HjF43r9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444709; c=relaxed/simple;
	bh=CSRlHdqVKGGvA5wcCf+/6Dz/C3x8Ip9VbtBMwLEnPPg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hxtiZWOtytuz9RmjE2KiYgDLG0O1kUxYNouHtXW2kkrgNtxUX7K2P5t45dO8ytMB5lqN4RijekTof9ZD4u1mNby/LX9tFwDUNZrno/LYirrEWtq3V043YGpNgJf0VQEaAmRMGzAw6c6PenS3AvHe6mh1ftiDovcy847ATPXtPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+VdR9Gt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+VdR9Gt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A481F00893;
	Thu,  8 Oct 2026 07:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791444693;
	bh=CSRlHdqVKGGvA5wcCf+/6Dz/C3x8Ip9VbtBMwLEnPPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R+VdR9GtAYDEc4Iek3Z6KuPDrSY+VjjB55DCzPOTli2C3pLs27o4w69mi6QwzrayZ
	 oJsom+FIulxcQXq6vaNVbyNIPL5y32VMNxKdCTP/AoywJn78NMI1ZTW6t4bLoeYX8j
	 Al+at1g3A2KVj7HgUw3pwvdvuRBqKT/ALQ9jCuPe6otruYl0T+ETfAhwsLfqTEYGX4
	 8D2w7lYkku3+yFEf3LcEoNo/fBr2x5pYyfykjqyrsPyvUFFvnbSIZ8YnpwL23B/NYs
	 5ZtacxnLpZk5CfqMCasBfJo2DmSLNm2SH8EXQcNCjQH6UKgEf9JZ4gtZUtmRGIj1r4
	 eBNTMklvxCO7w==
Message-ID: <sashiko-outbox-163766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/13] x86/msr: Remove rdmsr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261008071839.2247074-12-jgross@suse.com>
References: <20261008071839.2247074-1-jgross@suse.com>
 <20261008071839.2247074-12-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 07:31:33 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> rdmsr() has no users left. Delete it.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008071839.2247=
074-1-jgross@suse.com?part=3D11

