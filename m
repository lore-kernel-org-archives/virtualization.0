Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203842;
	b=K3amk2Xk38gLnERhNMrf2xvyQmosBSIl40wFPSdjL2j53yQ02PDo+nBIhBjPxjZSCO3O
	 I/HuVbjMI5eecksQWwQKTEoMkP8yJjMp55lu/L7MIwTTqBCxe93/iriw5EP7axsp78vwQ
	 4yM51YsdNM+D2qkMu5WvskdEQaIlS4S1dACSmxJweJNViEtVGx205Rxv/inGEIBFl+VGC
	 /J51C94C2IfIfoD5WJf4MzJOn63OeplwjSBWqgHbMPNDSxkydD3hvxBqvfR1j4LII5vBa
	 gOpSv7wdhnJNKDDHUF/DUKf6CrkKGnQKSD1QQfc3+3CVo4qx/0sgqM6sGoPhUlsLtHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ji+N2UCWOUlma5D+SRQ8WQSLAke0ouvDumRVQuY2Z+c=;
	b=lIUH+fzK5EAWKdUzYvJ7zP0oFt8N/CJwVxviLFfECJ8gh6hUNDnfmUzu3EeVkRKhJWeA
	 iG7/SDCi4+eknC54qpNLSPuBlFL2yWanq4m23Bkvf/Bp7Kv2XH+WVOvHoaHWX1uFVuo6M
	 MrzsivbNSbyApF38AmPSs4HOhnTfYrgV3uNgKim5D+j1mmGR6MXB5za3ULWdqpx/zDxm5
	 QxGHPS8CY9r7fINzpPXu9UyZkJCMWlxkLX85OlkI1j2Fxyt9xA8fImBcvaYBOocSuMeQi
	 dDptHWyTr2WPr+76yxngkyB3qyoKK6iSNHLfSonOpZwIr5A9E1AUWn39Iz6mJaF7H7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QD98c7+Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACECC606A337
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QD98c7+Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAE61F008A5;
	Mon,  9 Nov 2026 05:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203841;
	bh=Ji+N2UCWOUlma5D+SRQ8WQSLAke0ouvDumRVQuY2Z+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QD98c7+ZA1lNMUKOFkGk7LJ8dsDdynROBQEfkSbKIBlupSF41HT80NJYhemdNrI3S
	 MKTnwESO65RErD5EnTgytlpNNm+kssE55ynH6AxlYM2R2z+JSEVM3+P1Uexz9xc5z1
	 PWuT9+gcgc3/y6ZOScC2Q2ADxzpQ+2vdQI1l2tAjD5zDC9YbONkTpJIpfIhTtbArZe
	 3bggyDVpp0OPtE4byymk8h206ghfQbuT8cfORqork37VnPoWY25I3cKRZS4XaSwhlC
	 RLQiIW9t7XhicVcwskHlOc7jH4xv5RY7KsEKQdl1ACJu8i0Vuk4DBYG1oMFcfwthfx
	 6PUjamWE7gYww==
Message-ID: <sashiko-outbox-204466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] x86/vmware: Add a bounded panic log sender
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
In-Reply-To: <b4befd89cc0b5844f499606b7d42f13cdb37046a.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
 <b4befd89cc0b5844f499606b7d42f13cdb37046a.1794201807.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:57:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A VMware guest may be unable to save its own logs after a crash. Copy
> the newest kernel log records to the host's vmware.log before kdump,
> so they remain available if the capture kernel fails.
>=20
> Register the sender on the platform panic notifier list and send the
> log through the low-bandwidth register interface. Allocate a fixed
> 8 KiB buffer during early init; 4 KiB can lose useful stack-trace
> context. The callback allocates no memory and emits no printk
> messages. Limit the transfer to the buffer size and make at most three
> attempts, retrying only if a VM checkpoint interrupts the transfer.
>=20
> Enable logging by default only in guests without memory encryption;
> encrypted guests should send their log to the host only when an
> administrator opts in. The copy is best-effort diagnostics; kdump does
> not depend on it succeeding.
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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794201807.gi=
t.zack.rusin@broadcom.com?part=3D2

