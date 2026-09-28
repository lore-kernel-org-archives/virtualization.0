Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB9E36B920;
	Mon, 28 Sep 2026 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618791; cv=none; b=RXfCYPpRDGbFGYbywj4gKRW56A6GxiUvSi9xOPzgh3LkGnCZyP09Jge5ArlZt9rh2iSfwmcger5VsatXT6O0ABu1Lkv1zD3dBBwisyT4BP/r/Q7b9CQ8rzcrtWTxqIAjSba9gnPXtUfLGR2DQgNPjaTvQ/b7gCcVaxttuxD81a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618791; c=relaxed/simple;
	bh=rlEcCFeUPs+x9r7HXq7bxxuRWx4JY4b5aq3nw05rsIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n753JQCciwRqwl9Wu6VjGf6kO1psl4gZxy7myF1J8Eq6CoAsxkNftitr+lI+0sosOyGAk/CdZfqrLuAd0WpSjxrXwCAppGuWZu9lrabi+wT7asdepVwWwRRrIC9cxqQ+kE5zJS/jqBgldNuM8LQKA8GtPuvfknlxlmiFD9OtT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAzBJX+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAzBJX+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E672E1F000FF;
	Mon, 28 Sep 2026 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618789;
	bh=VvnLUUTkX/vIglRHw90BFQnofbQcleiKGqQ/3UvoQgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SAzBJX+miQZMsrjtZnZVwB+vVsYd8t/CB1vCRrh254uQduyjLc1tWlok7LeiQvVgN
	 kOcV8DN5elvF6rMYTI5lCVXHCpd3Cg8TyCLberdU2d+YykpmwkjSf/Jc28p3vYye8h
	 7OgpThCBX+HO58moCieWN4AWtE4ghMRMRnUVeitcYTFB4fG/XWTpPw8KSUK1l5PPtS
	 bv2we7ISA08i4FUkQV39V3TYifCK7J/C9WVsoU6T/sBmYSNqEj+Anj4m0l8mWATdRi
	 4pmmA/FFIpGQDXLvbReFBLRYn4BRiR5n9QkOaNXJRUm72njTHy5dsGAq2mCQILiMkg
	 bEXDFPbwrp1ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] x86/vmware: Add the vmware_record_panic_msg
 sysctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mike Rapoport" <rppt@kernel.org>, "Petr Mladek" <pmladek@suse.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Baoquan He" <baoquan.he@linux.dev>, "Zack
 Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Borislav Petkov" <bp@alien8.de>, "Guilherme
 G. Piccoli" <gpiccoli@igalia.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Michael Kelley" <mhklinux@outlook.com>, "Ajay
 Kaher" <ajay.kaher@broadcom.com>, linux-doc@vger.kernel.org, "Stephen
 Brennan" <stephen.s.brennan@oracle.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Bo
 Gan" <bo.gan@broadcom.com>, "Maaz Mombasawala" <maaz.mombasawala@broadcom.com>, "Kees
 Cook" <kees@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, x86@kernel.org, "Jonathan
 Corbet" <corbet@lwn.net>, "Thomas Gleixner" <tglx@kernel.org>, "Brennan
 Lamoreaux" <brennan.lamoreaux@broadcom.com>, "Joel Granados" <joel.granados@kernel.org>, kexec@lists.infradead.org, "John
 Ogness" <john.ogness@linutronix.de>, "Sergey Senozhatsky" <senozhatsky@chromium.org>, "Michael
 S. Tsirkin" <mst@redhat.com>, "Alexey Makhalov" <alexey.makhalov@broadcom.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, "Ian
 Forbes" <ian.forbes@broadcom.com>
In-Reply-To: <269888613b5dc16d19899b2c87c5ecdfd2610e8d.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <269888613b5dc16d19899b2c87c5ecdfd2610e8d.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:06:27 +0000
Message-Id: <20260928180627.E672E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] doc: rST title underline too short for vmware_record_panic_msg
--

commit c541f42ddd949c322e4b6facb84fc17737ed184a
Author: Zack Rusin <zack.rusin@broadcom.com>

x86/vmware: Add the vmware_record_panic_msg sysctl

This commit adds a new sysctl kernel.vmware_record_panic_msg to control
whether panic or fatal-oops data is written to the host log before kdump.
It allows administrators to configure this logging behavior depending on
guest encryption, and defers sysctl registration until the logger is ready.

Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f=
3zjbz7c@srfabx6lsusj

> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
> index ffea61d448ebb..be13c143b8bb0 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst

[ ... ]

> @@ -1690,6 +1690,26 @@ entry will default to 2 instead of 0.
>  =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> =20
> +vmware_record_panic_msg
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Low]
Is the underline for this section title one character too short?

The title vmware_record_panic_msg is 23 characters long, but the underline
is only 22 characters long. In reStructuredText, the underline must be at
least as long as the text it underlines, so this regression will trigger a
warning during Sphinx documentation builds.

> +
> +Controls whether panic or fatal-oops kmsg data is written to the host's
> +``vmware.log`` before kdump. This setting does not control the separate

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790014793.gi=
t.zack.rusin@broadcom.com?part=3D5
