Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794982604;
	b=egNTs6fwt6y8VddREhIouC+D74pQSqjoJ6+hKzrUC3TpZFXUVdGQVI71xiVlV5d8FjOb
	 0rIedH+AVurQhr/uw1opPsPxbiJOhpHYym3piUeZavskPjyKu/WBIZd3gkwf7tK9JuPcl
	 nEDQgP0vdheu/4vNav/mahfK3eKEWBfI5G2CDVGnqlhFdJ5ijf1sY218cS3wxw0rH3d7+
	 rQxqOpno+kgv7ioyoEOxUMh0bcAVi9vwtrpM8suArZF8pPEZwcoiILWBKC704Nr6b0bl1
	 kn7Fq9BIiqTXa2pu1GR0EUzIgnn+q6pkqsf6AJqRSUA/SjYcfrODINi/E9CPDxQNxwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982604;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3is0CbO3NwPfqFRdxfgxQl4YKoG86sWiuHQ8/kCrTX8=;
	b=TBHD0zGJ5fsIr79Qwu3KvA24FsoPjZYVcwxBWIgABZSbriZlof8jIMNkBh83vrRLoiU2
	 PGKWG76rfoBTt+QIoeJTiWpe27HLOg0MUM0otrG2lRsnOUJ69udUjj3Cc1uC9lDxn7o09
	 nM4rm3xcPWY1cKTvSH3LFWQ4zMNt++eu6YjZjFihbOE37O8+Nu1iDvOoo8lSIQe5lTnPo
	 uVqmw/PA+ayINnRVkRNcwzgUuodVD1iUhFUQP+HUT327S0rvus8uVOz+D6O83uhkVloOL
	 8OjDTIos2ai16kk71kfHkAT/chh9kjB2GHIPVrtp3PtM/FICbNFNKyb1NkIZ7xyK8aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AUDNKUgw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED146606A31C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AUDNKUgw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEFD1F000C4;
	Wed, 18 Nov 2026 06:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794982603;
	bh=3is0CbO3NwPfqFRdxfgxQl4YKoG86sWiuHQ8/kCrTX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AUDNKUgwrZYHgJ2NQaoyAykoNg886dfxI8lHNyZHmQFprW4B3y7viXG7MyATTIyxJ
	 OSw4NLBFUeafPgHajFN5wS1i1hhYGW1vsvx/6NfvP2Nk5i8g2xcT8jUWALGYoSqtjn
	 yV3N7eD1g48E2SgMunIHYqsBrik54MwCcHGCtMbTt3bolvHkxaN693/l81Lbbw7K27
	 aw9kd66Og2drO+1pOr78tw8IQt8FUxJ7U/UWaVWbQaGmLQ8wJueb5IPZM9LiS48B2o
	 492p9fGNddfkRXbpEPDHAf6HKZiu3zBn/hITEddQ1/M661PtJ2nvllBsO+LFdPuqxX
	 1X7fDtxrFxVWA==
Message-ID: <sashiko-outbox-220232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] panic: Add a platform panic notifier list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>
Cc: "Kees Cook" <kees@kernel.org>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Stephen
 Brennan" <stephen.s.brennan@oracle.com>, "Bo Gan" <bo.gan@broadcom.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Jonathan Corbet" <corbet@lwn.net>, "Brennan
 Lamoreaux" <brennan.lamoreaux@broadcom.com>, x86@kernel.org, "Joel Granados" <joel.granados@kernel.org>, "Alexey
 Makhalov" <alexey.makhalov@broadcom.com>, "Ingo Molnar" <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, "Ajay
 Kaher" <ajay.kaher@broadcom.com>, "Bradley Morgan" <brads@mainlining.org>, "John
 Ogness" <john.ogness@linutronix.de>, virtualization@lists.linux.dev, "Steven
 Rostedt" <rostedt@goodmis.org>, "Maaz Mombasawala" <maaz.mombasawala@broadcom.com>, "Borislav
 Petkov" <bp@alien8.de>, "Shuah Khan" <skhan@linuxfoundation.org>, "Michael
 Kelley" <mhklinux@outlook.com>, "Randy Dunlap" <rdunlap@infradead.org>, kexec@lists.infradead.org, "Ian
 Forbes" <ian.forbes@broadcom.com>, "Sergey Senozhatsky" <senozhatsky@chromium.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <3d156f7b5ec4f3d6f91e288a38f87d2368f1365f.1794980455.git.zack.rusin@broadcom.com>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <3d156f7b5ec4f3d6f91e288a38f87d2368f1365f.1794980455.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:16:41 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Some platforms set crash_kexec_post_notifiers so their crash handlers
> run before kdump. That also runs every other panic notifier and kmsg
> dumper before the crash kernel.
>=20
> Add panic_notifiers_platform_list for platform callbacks that need to
> run early and are safe while other CPUs are still running. Call it
> from vpanic() before kdump and before stopping the other CPUs,
> independently of crash_kexec_post_notifiers.
>=20
> Also call it from __crash_kexec() if a crash kernel is loaded, since a
> fatal oops can enter kdump without panic(). Call it before taking the
> kexec lock, so a callback that panics can still enter kdump. Run the
> list at most once, including when a callback panics.
>=20
> Add disable_panic_notifiers_platform_list to skip these callbacks
> when debugging panic or kdump failures.
>=20
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Link: https://lore.kernel.org/r/ateYxCu63pRY9EGq@pathway.suse.cz
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794980455.gi=
t.zack.rusin@broadcom.com?part=3D1

