Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF0547046;
	Mon, 28 Sep 2026 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618621; cv=none; b=EU1CBxLoqc5IPLf0YgpDarjQMzL45Z8O+ckgkOoioUYaVKjeyi2XTCs3ioWXMThlnGIy/BEiY5f98keuxBm5k3ZzV9MgEPyFnX5DyHZCgD843DefGAAMIx7nwrS/qCMdbGzkPMyJUpJR1ICtaCdlQkK5JdaHclKjHPIAB9TLCHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618621; c=relaxed/simple;
	bh=Em6qkKYb+gUcvRKeEmVxlAsqhkqcC0JJ8qJlMwTzxyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QjImnSEaBITZQ+rxBWQoFhwzHx0Fqfn0Ypv52KJi5cZLa/oTFxdgyGdAKgXJ255r2ArLVSy/zW0t3j38ZdVEgIUnng+Lm787Dpz8DKStLyh9szYO8BwKxqSuwblnVIB8BZXxwlmk2F/GSK/2YqeaEYUPkUE874exVXnBeZC16gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn6zrALh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn6zrALh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9CE1F000FF;
	Mon, 28 Sep 2026 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618619;
	bh=Em6qkKYb+gUcvRKeEmVxlAsqhkqcC0JJ8qJlMwTzxyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rn6zrALhktzX3F+Qlx/sCblhKYPW7bRfEE6BJ6xnmgqwaOWPYFxo3ixhEbhKg+r6O
	 e+H0GV5kzwq5abYap6EhWyHAJC1ciZuD2u0jDx9k44qyxiXPne3k2fpLGlOgSPsAvj
	 OwM397eqZzSNjsfzqndd+jf/KLESRjltxZU/R1iVbMDCCWbu/p93B+z3mO8ywoG57y
	 xzafkjNjqPMxcRwwOFpja7N2v1AIZyxgkL4Swwhv1YzEVOo8jIp6dyaAvh4X2Re4Uy
	 hepOuRZUAcK5Ws1/P2ZRnr9lfpFOMkIu3O07XVV7l6pIWnXLAT/YBnrAqtYoAK0XpE
	 XEhnD18itDbdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] x86/vmware: Report guest crashes after kmsg
 dumpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Petr Mladek" <pmladek@suse.com>
Cc: "Alexey Makhalov" <alexey.makhalov@broadcom.com>, "John Ogness" <john.ogness@linutronix.de>, kexec@lists.infradead.org, "Stephen
 Brennan" <stephen.s.brennan@oracle.com>, "Shuah Khan" <skhan@linuxfoundation.org>, bcm-kernel-feedback-list@broadcom.com, "H.
 Peter Anvin" <hpa@zytor.com>, "Bo Gan" <bo.gan@broadcom.com>, "Maaz
 Mombasawala" <maaz.mombasawala@broadcom.com>, "Joel Granados" <joel.granados@kernel.org>, "Ian
 Forbes" <ian.forbes@broadcom.com>, "Randy Dunlap" <rdunlap@infradead.org>, "Michael
 Kelley" <mhklinux@outlook.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Eugenio
 Perez" <eperezma@redhat.com>, "Borislav Petkov" <bp@alien8.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Kees Cook" <kees@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Sergey
 Senozhatsky" <senozhatsky@chromium.org>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Ajay
 Kaher" <ajay.kaher@broadcom.com>, linux-doc@vger.kernel.org, "Ingo Molnar" <mingo@redhat.com>, "Thomas
 Gleixner" <tglx@kernel.org>, x86@kernel.org, "Brennan Lamoreaux" <brennan.lamoreaux@broadcom.com>
In-Reply-To: <996d3ceefd98ed9a7c40508e6f62039ba5a15325.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <996d3ceefd98ed9a7c40508e6f62039ba5a15325.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:03:36 +0000
Message-Id: <20260928180337.6F9CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> VMware accepts a structured guest-crash event, but a host configured with
> backdoor.coredumpOnCrash may terminate the VM before the hypercall
> returns. Keep this event separate from the pre-kdump log sender.
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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790014793.gi=
t.zack.rusin@broadcom.com?part=3D6

