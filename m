Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A866C377A93;
	Mon, 28 Sep 2026 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618826; cv=none; b=RAuQwHq/fXOjLUdU03xdR9QjRFojvW7bxLYIr3CEMZlaYu4Oh9L3K3CrBrXlXczhZ2QAkIxfLHqdX5kPdyu3w7QyC0b0O2x7yM4tnk9Lom2cud9c0Wkpk0KqIe8FavRmoMtQiXAcyLZ/3gulRQOvE0KlFesS9hb6qRIcSRT17PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618826; c=relaxed/simple;
	bh=aXEt8cLj5MZO0I73asHe3zofPVNAzMphdpTAK0N6FfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X5WnPkRUmCkG0gV+NA+F4PKpQ6UIe3nLN3Kxm//CG8DNXcwtr6yyUzqblPS6kO7EH4QEATrm4W53nv+N1PSha3czFb+ueFAqoVi2EoW1frqVV6NbvqMi3fwQonoSXllK6YOng8kV9WX7vUFow9XWNmWaANpubITFV7u4mmDaCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkdDllWB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkdDllWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F9E1F00893;
	Mon, 28 Sep 2026 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618823;
	bh=aXEt8cLj5MZO0I73asHe3zofPVNAzMphdpTAK0N6FfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VkdDllWBAWV5FGuXwvbjEPRrpIDNW0dE7ueXGI1WvWp/AW/N7EAHBRQDMLs2+H3nz
	 pLEKPGak1yaX9UVq9Fb1ucxNAhmv6RWC70uuRxMLoWv6SR2MvvK3A5DtgZ6u97b+A3
	 xQtUpOQCtgBAySTeKXC1iLN8suUD9vmVagzo41ghn1qN/UGn5ubVotTTdDczQLk4gS
	 4K8YIEQOask3UeRdr8cFTjBIok+hbWq/Fb567PzFNDVn/hhYv0r2cv5Hzs+d0CRxoO
	 LwTagIm3x2qKu+gV6bbSJY9txsQB9ar07NT+kGal5ajgx0Hveq3co6x4xFXdGLYrEK
	 zAwMIRi9TF9Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] x86/vmware: Add a bounded pre-kdump log sender
Reply-To: sashiko-reviews@lists.linux.dev
To: "Baoquan He" <baoquan.he@linux.dev>, "Dave Young" <ruirui.yang@linux.dev>, "Zack
 Rusin" <zack.rusin@broadcom.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Petr
 Mladek" <pmladek@suse.com>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: bcm-kernel-feedback-list@broadcom.com, "Thomas Gleixner" <tglx@kernel.org>, "Brennan
 Lamoreaux" <brennan.lamoreaux@broadcom.com>, "Ian Forbes" <ian.forbes@broadcom.com>, "Michael
 Kelley" <mhklinux@outlook.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>, "Kees Cook" <kees@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Ajay Kaher" <ajay.kaher@broadcom.com>, "Maaz
 Mombasawala" <maaz.mombasawala@broadcom.com>, "Joel Granados" <joel.granados@kernel.org>, "Bo
 Gan" <bo.gan@broadcom.com>, virtualization@lists.linux.dev, "John Ogness" <john.ogness@linutronix.de>, "Sergey
 Senozhatsky" <senozhatsky@chromium.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kexec@lists.infradead.org, "Alexey
 Makhalov" <alexey.makhalov@broadcom.com>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, x86@kernel.org, "Shuah Khan" <skhan@linuxfoundation.org>, "Stephen
 Brennan" <stephen.s.brennan@oracle.com>, linux-doc@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, "Dave
 Hansen" <dave.hansen@linux.intel.com>
In-Reply-To: <c1313dbfd632d2d4f2c5a14577df24a6c1b3c34a.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <c1313dbfd632d2d4f2c5a14577df24a6c1b3c34a.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:07:01 +0000
Message-Id: <20260928180701.99F9E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Preserve the newest kernel log tail in the host's vmware.log, which can
> outlive a guest with no working userspace or persistent storage.
>=20
> Allocate an 8 KiB buffer during early init and register on
> panic_pre_kdump_list. A 4 KiB buffer can omit useful stack-trace
> context. Use a fixed byte budget so transfer work does not scale
> with PAGE_SIZE.
>=20
> Copy the newest records, prefix them with "log ", and send one RPC over
> the low-bandwidth register interface. Bound the transfer to 8 KiB and
> at most three checkpoint attempts; zero-fill a partial payload word and
> close the channel after every successful open.
>=20
> The callback allocates nothing and emits no printk messages. Enable it
> for ordinary guests, leaving encrypted guests disabled until explicitly
> enabled by the sysctl. Skip initialization without printk support, and
> leave logging disabled after allocation or registration failure.
>=20
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Link: https://lore.kernel.org/r/SN6PR02MB41574A11D309A0530C63E0FED4842@SN=
6PR02MB4157.namprd02.prod.outlook.com
> Link: https://lore.kernel.org/r/20260309235250.2611115-3-alexey.makhalov@=
broadcom.com
> Co-developed-by: Bo Gan <bo.gan@broadcom.com>
> Signed-off-by: Bo Gan <bo.gan@broadcom.com>
> Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790014793.gi=
t.zack.rusin@broadcom.com?part=3D4

