Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794982371;
	b=TMX1ZsGmwuGsDyyOPRrNMmWzKDuTLPFHvVfGxPmccQJdhluLIObXbsnAPrF2hAuuPzAC
	 yxWv8Ser3lDcsxVd16KyQZOjs9cO64RVpNyPQnUztX6z+/RxPX3D2xKS7bEspkiV89GfN
	 AjUIbJdcv3cMCrEuFhdjnwsKYycyuECWMkjGwyoB9YrWZtS/Q/ZzHkOjIaWp48seX4/7X
	 lld5Wxr5wSQhdEDL7vy4H7F/F7ucsqdw188ENdb8+3FtI0MM1YNf36djTPNHMVadtCONl
	 wFo+pPNWOS7cookDOs0mc6IV1PTyomJJDGOdezFaJ9IMRTkpTY20kJItljgnLgL9Log==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982371;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7pawrZRlYVDLwnVc36mchILpwWtc+qvWtadmaH7lhXg=;
	b=ZQIa/gjiN8EtQ4Nmpoeh9wkSEbWhKxWWkMA345hdE8fYCYL0wZxC7kCLjhywlj9eL9hD
	 8P1W2GKV7bXjJEydogQDRqlfrIDpK2HZrkFggY/T/gcWT5j3w+aBjAGP8olq8ynoXqpI8
	 xDtjPhQEpVcRbjfQEqQtb3BDurNPSRKDcnvm6st/gl675ir7wr5rX2WAagtvgZKcewhk8
	 cUVjfWRLEAOAC/sMS12+yLXIvwSuFts1ugnA6SQEqKwBhQBHMwQ/edVDJAZCrrTXOQvht
	 BzOfib5znGuRgJBbFo7NEkokNP2vcWhLAIARdRAe59LusAwLVUvE/wkKGnZd3g37CVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGQ8aJ16;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D2606A33A
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGQ8aJ16
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C6D1F000C5;
	Wed, 18 Nov 2026 06:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794982371;
	bh=7pawrZRlYVDLwnVc36mchILpwWtc+qvWtadmaH7lhXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGQ8aJ167ql8RT2XJgaOf0Eq6Q/gT8pXbnfVX5Ukky44PZgq4eSgl2nZ6ybWVCrJU
	 tddgUSUIbF0RlDcndQPmxC3KPAY1AX+dcSVxpdYzs1tsFLBf0m/NvQ45mJzKYnBhG9
	 bwKJiomH6Y6qavZ0/fN5fVOv6mkT3BnWeOBMwV/nMffn+XgN5gNpk6jvxcJ5Ox72Um
	 Y1D8Qr3ZgnA/NX8tg+1IJ2rddYnGAMOdpFvGh0teUlhMfhHlOudDj/UF1SkaGd76fT
	 KccOZv+SBIUrBDygTeqJV8qKJ1jyhx6hy8gIXFAuW4SGRVUwQtsikEySaxeheTu5l5
	 1RWVfoLjmwLBw==
Message-ID: <sashiko-outbox-220211@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] x86/vmware: Report guest crashes after kmsg
 dumpers
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
In-Reply-To: <d0f9c1188b5f78bb20bb43737b3cf80c5c0f94f4.1794980455.git.zack.rusin@broadcom.com>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <d0f9c1188b5f78bb20bb43737b3cf80c5c0f94f4.1794980455.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:12:48 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> VMware accepts a structured guest-crash event, but a host configured with
> backdoor.coredumpOnCrash may terminate the VM before the hypercall
> returns. Keep this event separate from the log sender, which runs
> earlier in panic.
>=20
> Register a panic-only kmsg dumper with late_initcall_sync(), after built-=
in
> dumpers registered by then. Skip the event while a crash kernel is loaded
> so the host cannot terminate the guest before kdump saves its vmcore.
>=20
> Issue the event at most once. With CONFIG_PRINTK=3Dn, use a late INT_MIN
> panic notifier. An unexpected dumper registration failure with printk
> enabled leaves reporting disabled rather than overtaking working dumpers.
>=20
> Link: https://lore.kernel.org/r/20260309235250.2611115-4-alexey.makhalov@=
broadcom.com
> Co-developed-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
> Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
> Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794980455.gi=
t.zack.rusin@broadcom.com?part=3D4

