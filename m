Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794982721;
	b=rBh3jenyIPUHyG6YJBZD1izQB/PqZBdwmEqJQqbI3RImnCURLVBxgR9Q8oGwJ1n4ZShO
	 J45VmQJy5HEp5zuh2OUepWpSPa3cBymp6854wPrZtxHTd8Htwi6j4xPiyC/ieT65owlZI
	 903ZLGwiD+y12vw/HrxjCpMDW6mnJ8nGEKE/TnrHKf2V43Je4bVyRI+//CpA+5EorBr37
	 NUseWstrSK17MKrum3OSwEwftlE81ALrQ7SqxlxJVbnLRKYa+DTBTGk0Wp64ZbDNH8f+2
	 VDINKQKgBJvcz3bgAz7hP87mh2qjLBwE+MkW+qLIhySExWAlIw/+xn/doJgz7Aq44/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982721;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k0sRL5gf7qde0RaorBjAxkV83mJn8qf9Qnk0L/FwqTY=;
	b=rC6PYkIuMwsR7aCM6I1V0l149dBazlZyp2/gCjiXbPoMbdCzPyhcqEpHHoxIHaslXcL3
	 7X2Scf0RsvPR5w6HI7XOIMAdN0zyt2/UAif5hkv0PwnOZVYkfhdy66e4fg/e6xsqsb68g
	 wKloBmS4EXY2AuZz6GaJ0z7eEAN1UOmBnX1BLT6xndae3eblft77dgT1AucmeouQFIbvC
	 /7soEU97eNqhDlum9KlyrVWIDchJaQQp76T8u6a+5niB1vY31JwahGMXjbcRoau5Frhb2
	 mgNKKsOKXMf0uFjLqB434pAb8G9Y4905a62kwpN+Nfy3vPg82jUuJFbrp0demYr0rvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clDNF3tG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572C606A32C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clDNF3tG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572AB1F000C4;
	Wed, 18 Nov 2026 06:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794982721;
	bh=k0sRL5gf7qde0RaorBjAxkV83mJn8qf9Qnk0L/FwqTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=clDNF3tGTOTKijrqHGYdDKY0j78Chuws2RC6H4nx9OkB1aR674QV92TBVX+7gZ4Wr
	 7xX0bvaBN+9RcQvn3Ns6gohunj1g2Ig1T6spV0mECiLzm6YjYfsvSKu2/xrm9mmCB/
	 SEPpHYtmqoujqZ2AttpZMdiRTL32wsaG3kqIb0M81uOkthteNplukIITXh8S0hxSGm
	 JUPZ1lqUBukMPi+mRW3iIe0jtH+gb3M9ygYMKfj1NzPcmm/R6EZsKtVE31OZW8Zuec
	 3kvsh12l2g7/l1u6KdnLP5ubV9H1by/oLcGbi9H3iP7YYzsD7tJVVnz7K9xftsJkA4
	 fg0zw67XCjQfg==
Message-ID: <sashiko-outbox-220233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] x86/vmware: Add a bounded panic log sender
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
In-Reply-To: <7e985e2aea6507a0444addd816d4251f78d048f6.1794980455.git.zack.rusin@broadcom.com>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <7e985e2aea6507a0444addd816d4251f78d048f6.1794980455.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:18:38 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794980455.gi=
t.zack.rusin@broadcom.com?part=3D2

