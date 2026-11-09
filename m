Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203902;
	b=TRUHsj9SFS3oedYKbmwFNqzk6IRMdKrDX0a8h2la/n0opgnDF09H3/sg7XohLXvWAHZQ
	 TLxyDUbYx6a7n2j4zm/J/GIxxXYhEhCMZgjjRwQfqtPGpBTL6gXOrGyQS4at2pp76hLx8
	 ayAehqrQVCh8qrww7pPUjWu1yBr9Elu1fcV9xkaG9+C0FbM77JkGTCKmFmlfDHJNoFPj/
	 TYsP08z4+w4NU+GS5nd/dJUHK4hZJbp/qEgpNx2NZmxzt0Rm0UVGN7zGHe2EaRIJsMym/
	 PCXL2RjnftYaBKXP2CbnKFeVRbMsFmwh8Sy075AEIeWUW9yE6oyxV/U98yJspGb/Gbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203902;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8kgk2s1BDPoGx8z6VEMyByixhHxqx+/hqI2eAc6Pl/w=;
	b=AqmRxO8ogF8gup+8OIeGVSZtoXji1ztBlM7n26rfUKrNay3SE3FuQWE3qYmScf6TDWnW
	 1CVTz/PvDAFvvDQdHTx5+nC+KB5EmmjYvfsC7EgEhAWbZbL2A+rbJ70aVpO1HhZ62lWpF
	 gL/bXDDvZWz6akWQp+/IOxRq1lqu/47K6GbHlq0AkAw/D8SwZCSHuIeV03JUEnRJ37t8n
	 cMNjLgb922SrklENvwaLGI1dpPXH8SeZ6nWlpH0Le83huMr75SVOJXDrXLTtMC2m+WGi4
	 WVrVRvR3do80fY9MkQuXOB8AwJwe3u1SHEJn1Oi9ykiaspqlHbYE5Jdkb0OJ+HV2/7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMirM362;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6231606A321
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMirM362
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13921F0089F;
	Mon,  9 Nov 2026 05:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203901;
	bh=8kgk2s1BDPoGx8z6VEMyByixhHxqx+/hqI2eAc6Pl/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AMirM362rg8bEQb6ceECmalUjTHSJxZ/a9mN4yY3pWdgqvnKcYijxgacd2IvZnJ7g
	 IyhVxl6Ofp1gZgZrdg6jQtSLD7ozBvVzbZsxR/xUR3ikgWI6Oy4DmPHd097FPdMtEw
	 Jsfx2sVhmMG5F3qCygqhlS7gmGmbF4vAY5I7A5wA8sj/Dgiom3bnB30tdF2uIaVbld
	 U9owqHBpWmVeynxGauew3Vg8P6EeMBvczrM0PWOHuDu29dWnfLxksrrKNlfidpORrN
	 E09pT/a5m2/CasmRlZSM9KFlnD67hGokhS7t2kd73+yEbDTtnGhB1Vqi54oCq0iqkd
	 ajjA2iqQH1Vwg==
Message-ID: <sashiko-outbox-204467@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] panic: Add a platform panic notifier list
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
In-Reply-To: <42090fa4453561ebc35f35cc563ec79933eebe75.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
 <42090fa4453561ebc35f35cc563ec79933eebe75.1794201807.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:58:16 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] crash: kexec_trylock() held across panic_notify_platform()
  breaks kdump
--

commit 27b42ef2d74e73a1aad7b08a71b2e46383b32891
Author: Zack Rusin <zack.rusin@broadcom.com>

panic: Add a platform panic notifier list

This commit adds a platform panic notifier list (panic_notifiers_platform_l=
ist)
that runs early in vpanic() and in __crash_kexec(), along with a kernel
parameter to disable it.

Link: https://lore.kernel.org/r/ateYxCu63pRY9EGq@pathway.suse.cz

> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d0bd2d0cf8990..10b4384294c2b 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
[ ... ]
> @@ -139,6 +140,8 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  			struct pt_regs fixed_regs;
> =20
>  			crash_setup_regs(&fixed_regs, regs);
> +			/* For crash paths that bypass panic() */
> +			panic_notify_platform();
>  			crash_save_vmcoreinfo();
>  			machine_crash_shutdown(&fixed_regs);
>  			crash_cma_clear_pending_dma();

[Severity: Medium]
Can calling panic_notify_platform() while kexec_trylock() is held prevent
kdump from running if a platform notifier callback panics?

panic_notify_platform() sets done =3D true before invoking the notifier
chain so that a callback that panics will not re-run the list when it
enters vpanic().  However, when __crash_kexec() is entered directly on a
crash path that bypasses panic() (such as oops_end() -> crash_kexec()),
__kexec_lock is already held:

  crash_kexec()
    __crash_kexec(regs)
      kexec_trylock()
      panic_notify_platform()
        <callback panics>
          vpanic()
            __crash_kexec(NULL)
              kexec_trylock()  <-- fails, skips kdump

Because vpanic() never returns to the outer __crash_kexec() frame,
machine_kexec() is never reached and the crash dump is lost.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794201807.gi=
t.zack.rusin@broadcom.com?part=3D1
