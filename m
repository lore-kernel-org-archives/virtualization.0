Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794982480;
	b=vWnSuzEcB0SGyNVksshfMOds4ZM7dN0LpZ9/eyF+E/owPLn9MdTdadUQA3lIjoXYQTb4
	 t1YDWChlHCUryUf3ul0M6DLsVOvzTHZe5SXKzPYqeUDMPt+6ePWwJzPCR0SBSIgL/Fa+c
	 AoZRXmgvxOuQHTLEzuuISIN/xDTrnpY4oGTplP9Qc3uYYuRy/iL/SdDJ0boTgqkYy0hkj
	 dZB9lnOUhIjEox5FQNbp6xFMB3g3NBhKEJI5QuouBF+J0lfYG39hytQwvKdUhM7ICprii
	 YX02kqBowhWsFVAuOdzV9fiBO39dFbiYGpibgb97JMSCE6zEYIWD7G/gEJ94xK+GTgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982480;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GEsC5dU0bfsqEDCQJOmPH05HbP/lwlu2etaBbyPSMes=;
	b=TxCcCd1gORFSuXd56+A7pyoSDMYl/AUiutFIZmOwEenPJfrha57AAjIpvgtW7/kfxcmb
	 ssGJLsB3D7w2ER5teQDvHV38HGLsDsU6pRk0v2T5UoRH0zuiLh5a6Z6nhpcvJz+6iRYFQ
	 kOxdoIeZy7i2u63HCDnR2MO7rdbqtnI5cESrXnbTd5+G5v9wdEtj2Mv6TxjYzQPG1pPE4
	 2hFfKbAbjVKPgGgHEQ2FevSBP1uNg+IM65/rolTNx6+Dsi8B/5yi7fWsMUX1+qxYbuKwv
	 FIaN+Nj21ruCoKA5E9/DqkXafDtPOkWxg1Cb/Z76LiQpIjG3ClPEcYzSRD5fQLb5M3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBRH3nX+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC22606A31C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBRH3nX+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A962E1F000C4;
	Wed, 18 Nov 2026 06:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794982480;
	bh=GEsC5dU0bfsqEDCQJOmPH05HbP/lwlu2etaBbyPSMes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VBRH3nX+HG7tRJcwuVSjRxroM9vW1LnhK+vZ4rdcUJoOw5LWDg4vrNWwDkbiV6Suk
	 4woI2ffp2U/etaAL4tAgyBMdYUtalPdg4+VyHt2ZR6zQe5D8kWqojtOgmzuer/IUy2
	 Uey6NUQ9kGoXtdiev0Y3XJ9/L+316F9hXqKwYdeXVzBvWNZLvoZ5b4Ctk1PTMggtwj
	 Oaz7fLeFfRWaY0wkH/Gh+ktU/i1/cTUwFVH0tL9es8+bBtoTiDQPfg2S3EaUNabKlM
	 l8MPXkNfYYQ6qyn2HMHJ7yGlK/m5BPPbYSvSQKUrmwHwZmMd4p65dJIB5ysBt8tTSx
	 tht8T5pnK0vJg==
Message-ID: <sashiko-outbox-220212@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg
 sysctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>
Cc: "Borislav Petkov" <bp@alien8.de>, "Ajay Kaher" <ajay.kaher@broadcom.com>, "Alexey
 Makhalov" <alexey.makhalov@broadcom.com>, x86@kernel.org, "Joel Granados" <joel.granados@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, "John
 Ogness" <john.ogness@linutronix.de>, "Steven Rostedt" <rostedt@goodmis.org>, "Sergey
 Senozhatsky" <senozhatsky@chromium.org>, "Kees Cook" <kees@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Bo Gan" <bo.gan@broadcom.com>, "Brennan
 Lamoreaux" <brennan.lamoreaux@broadcom.com>, kexec@lists.infradead.org, "Guilherme
 G. Piccoli" <gpiccoli@igalia.com>, "Maaz Mombasawala" <maaz.mombasawala@broadcom.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Stephen
 Brennan" <stephen.s.brennan@oracle.com>, "Michael Kelley" <mhklinux@outlook.com>, "Ian
 Forbes" <ian.forbes@broadcom.com>, "Bradley Morgan" <brads@mainlining.org>, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:14:38 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Allow administrators to disable host log transfer on ordinary guests or
> opt in on encrypted guests. Expose the boolean recording policy through
> kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
> Zero disables recording, nonzero integers enable it, and reads return
> 0 or 1.
>=20
> Register the sysctl only after the logger is ready. A registration failure
> leaves the internal default in force. Document that the log is sent
> before kdump, and that disable_panic_notifiers_platform_list also skips
> it.
>=20
> Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw=
7f3zjbz7c@srfabx6lsusj
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794980455.gi=
t.zack.rusin@broadcom.com?part=3D3

