Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203556;
	b=vLWzhTtT+4vBCBaBpA/c/DJJc7z5t+WlFDk0qCrkCxeudMEI6HNBMOxrhuxjPIpn4OoU
	 YfCNCqgnsvUk+Q0YHCAnAlcwhVnplhhsd920Ej2tEEPr2HzgoBUbvX8CTz5yidZXPke7D
	 vaKuCHdC3a70eO9TY+6OHL4JP9oEb1YhaN1xCU8RnZL9t/X+DsRY91e2+UqE6hwmr1s0s
	 I5QpRd2DyG4iHLTArnaTZRh8xsU4CuFeEjXlkl/7YBEcqudm40JqcOhHpUSNnSqtJdMCV
	 Rhvbb5j3ZEvne6v6CMB5oh6zJjyf4/35uMvymWwygXH8GREHfzBHi+U59aGZEcdz5/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203556;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ngLdVs5ADSc+NgiOyvdsEU2ojAZWKq+pUBeFdxdN+sA=;
	b=hQVv+2F9iB3n9G6YLFw+MEdhr3QJGfHsLRPTgIZnKZOmqcqVg3c0QTfT1LcWzldZdqkL
	 fSD8oRsRUVo3C6fKDm6BJBPueAEuRhS1XUggwY2pH9YM6Dw2V+hDwQ/bN5icdCPyj6EdE
	 UmiPjRW3mm0/Wq9Z/2worz+SkRL9cw7tU06e1dsEE0+kSui6juyhW8xHwlFiZFiXW49gt
	 Jn/aLjmws5yfhXsQ/geywu6QPreHHiEx7EaGDhqpQsBPv4abblhMQ/0V1jal4474nLDTU
	 6lKnEJVlHrxU07dauBBaYxBqkulgo5LE9UELDwoj6VyZmlxNYviAKH9XrpCBh0F3Lsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvhxiug+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57367606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvhxiug+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4EC1F0089F;
	Mon,  9 Nov 2026 05:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203555;
	bh=ngLdVs5ADSc+NgiOyvdsEU2ojAZWKq+pUBeFdxdN+sA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lvhxiug+ERAgyEb3q015lbkxsX0mFCoaNkuzkQF6afElu7r5uMW1MorylNaNp8Yar
	 +jXHTdkrnARbVZhFpIAnMv/ddZWUuBsvFhpZXIso0yAUsE/SrKjnAy1uGscJTyUDlk
	 aYkvbHBknQGPTMwxXhmDBBfpjFI98ujM7g48zfqgMYC8eXTZmQ3EnW5rp7475YSqk0
	 ZD17dKYztxfMZ9HSwhyTrlbEDW5WT0jcCgbW3CrM1zLCOAQ9rKbprFGGtYZTKZFJPd
	 89P6oT5HXDrSWmNvo8BwT7zOU0fHW8o7ENq71POAbiyOJBzYIGr23jwGw8z65neF1e
	 qZmLhBfHmAkBw==
Message-ID: <sashiko-outbox-204461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] x86/vmware: Report guest crashes after kmsg
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
In-Reply-To: <4dc02120a69e0d4b21f1ea3a12b4aedf6f22e706.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
 <4dc02120a69e0d4b21f1ea3a12b4aedf6f22e706.1794201807.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:52:33 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794201807.gi=
t.zack.rusin@broadcom.com?part=3D4

