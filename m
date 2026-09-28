Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF4376466;
	Mon, 28 Sep 2026 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618655; cv=none; b=V24jLY2vUtdNaOGTe4YKUevrtISqTHt/Xz+BpIDjqEIHHc5TOwh1RGO/o0Z1W12+9eEW91zW0c9VTi9xX626QERyB+mJilADn0uCN3NDiDfSfoJRpWBYG1lu3xNcmvwe+0e90/q4YkQuM77RC5JFyIUt7nahvAX6pfGyOol6dvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618655; c=relaxed/simple;
	bh=Zm1ZvYYOTuQ3ScOHQ7pIKzUfv4/g7hN/0crXo96RuGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZL1F+No+XuHhblYjOKkXDl5m2wPZ5P6zWl9Cp7z0DDxiYTKhq93fIqNV5kfKaWTssfwzPM9wRsS8IC+RWUd8Af9WhDLURj9FGplBzCx9i6VVrjIoWmlY/RsGlH+jAV4mbJ3Wk3okOuUIU+kyRBrSnHoZbJs4vOcgGX+nu3mVIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGJbMF8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGJbMF8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682061F000FF;
	Mon, 28 Sep 2026 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618653;
	bh=Zm1ZvYYOTuQ3ScOHQ7pIKzUfv4/g7hN/0crXo96RuGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jGJbMF8n7bcIQZiTn9RDUXb8IanJtLkNsZmHKna6T83BQoN+26fYS2G2okDl2MPya
	 PcN0XM/ontOUv4E3k++ARPjPXLbFBmfANvUWhgeO5a539SWdA2ULMjfohteKV1y0xc
	 6umSP1i+NadDHLoophmTeFdLrCzv9OgMHHTo4YZlzFnu8cNrFLhv2mWu7FqjalvmgX
	 Lor+y7KbUtuVqLjSpw3OKYPNOplV7I2JM/L8KUcI23kDqKODMpnwEEyXHVg1Dq+Xar
	 EnjXJtnvNU1rofcEIOcMUxaI9snofrIri1B8tN6ZVMCQax/NuLkvEhsigE68AHCrVH
	 N3VclxkSozUjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] panic: Add a notifier chain for pre-kdump
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Baoquan He" <baoquan.he@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Dave Young" <ruirui.yang@linux.dev>, "Zack
 Rusin" <zack.rusin@broadcom.com>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Ajay
 Kaher" <ajay.kaher@broadcom.com>, virtualization@lists.linux.dev, "Ingo
 Molnar" <mingo@redhat.com>, linux-kernel@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Joel Granados" <joel.granados@kernel.org>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, "Alexey
 Makhalov" <alexey.makhalov@broadcom.com>, "Eugenio Perez" <eperezma@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "John Ogness" <john.ogness@linutronix.de>, "Bo
 Gan" <bo.gan@broadcom.com>, "Michael Kelley" <mhklinux@outlook.com>, "Borislav
 Petkov" <bp@alien8.de>, "Ian Forbes" <ian.forbes@broadcom.com>, x86@kernel.org, "Stephen
 Brennan" <stephen.s.brennan@oracle.com>, "Kees Cook" <kees@kernel.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Randy Dunlap" <rdunlap@infradead.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Thomas Gleixner" <tglx@kernel.org>, "Maaz
 Mombasawala" <maaz.mombasawala@broadcom.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Brennan
 Lamoreaux" <brennan.lamoreaux@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, "Sergey
 Senozhatsky" <senozhatsky@chromium.org>
In-Reply-To: <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:04:09 +0000
Message-Id: <20260928180411.682061F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Selected crash callbacks should not require running every panic notifier
> before kdump. Add a separate atomic chain with an at-most-once dispatch
> helper, and invoke it before panic reaches the kmsg dumpers.
>=20
> The helper permits another call from the crash path without repeating
> callbacks or recursing into them. Document that callbacks may run in NMI
> context, with other CPUs running and the kexec lock held.
>=20
> Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790014793.gi=
t.zack.rusin@broadcom.com?part=3D1

