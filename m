Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A11371D1F;
	Mon, 28 Sep 2026 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618657; cv=none; b=W2aiX8PqKVPqa7pp7czYA15qAjzk/weknDS9Bsz9nUlLtY0jD9KCyb9wQiAhcs/w/W2sGD4jPpYNdz494fDHQSmRcLM3Pjl0L4rMAFmI2tLkF44oNdGH4mm+vuNfQH/yObalRAjnR8dzPfuMbHu2GGD3l93PLjxDrbJW5+WWzWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618657; c=relaxed/simple;
	bh=al5fOqCdsYQeSS5YhK0c2oDQh/mMiyymN0ye+N+SIYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iexkaggtmw5cE0PUg3zDGaj860SIOHSBWF3ul3qOg2iSpWBIgoF3eR4YxNdZhPBos2zMDXt9/6ZhDkiL/nYPgOEQzdv3caJU0QC4KH/HIpuVKihoDjMxO/xs8lIXQH5lZJp8LzoQmMh3RI8tmARQoGbigbPkLb0C4Q28QxqnbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4PSbg2+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4PSbg2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC69C1F00893;
	Mon, 28 Sep 2026 18:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618655;
	bh=al5fOqCdsYQeSS5YhK0c2oDQh/mMiyymN0ye+N+SIYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G4PSbg2+N60B6P8KENLHuAe5rydDTlgDt3aKAW2qnRptKCvy7WVOcGHdRV3gZOI8f
	 XpLPUVvGZ8rR1my31rZrhY2rwGBE20oyfhOVVPVfqT99La7PZUG1QR2JH5XsUyz14P
	 7Y+AgUM9Vi4uEWghrq8XpfqegdOJ5JdXoNdwHBokYv/bNmlCr+xRbdR+i6x9jm3SKB
	 Dzxo23JJPfIQIRXh/8AX+O92iR4OgGgsk2prLVp9Lu5jfdrbzQDCN6h2rwSMNlHle+
	 qYyKYGoGRV2SkrWRRMqsf1CDweb3eQu+XO/PS9c5uQ37mCNscaASH5prcRvpNKqiwB
	 atrsYhNo5wEhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] panic: Allow postponing pre-kdump notifiers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>, "Zack
 Rusin" <zack.rusin@broadcom.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Petr Mladek" <pmladek@suse.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Joel Granados" <joel.granados@kernel.org>, "Eugenio
 Perez" <eperezma@redhat.com>, "Bo Gan" <bo.gan@broadcom.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Alexey Makhalov" <alexey.makhalov@broadcom.com>, x86@kernel.org, "Maaz
 Mombasawala" <maaz.mombasawala@broadcom.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Sergey
 Senozhatsky" <senozhatsky@chromium.org>, "Kees Cook" <kees@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Jonathan Corbet" <corbet@lwn.net>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Randy Dunlap" <rdunlap@infradead.org>, "Borislav
 Petkov" <bp@alien8.de>, "Michael Kelley" <mhklinux@outlook.com>, "John
 Ogness" <john.ogness@linutronix.de>, "Ian Forbes" <ian.forbes@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, "Stephen
 Brennan" <stephen.s.brennan@oracle.com>, "Shuah Khan" <skhan@linuxfoundation.org>, kexec@lists.infradead.org, virtualization@lists.linux.dev, "Thomas
 Gleixner" <tglx@kernel.org>, "Brennan Lamoreaux" <brennan.lamoreaux@broadcom.com>, linux-doc@vger.kernel.org, "Ajay
 Kaher" <ajay.kaher@broadcom.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:04:13 +0000
Message-Id: <20260928180413.BC69C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Provide an escape hatch for debugging kdump failures that may involve
> pre-kdump callbacks. Add panic_pre_kdump_postpone to skip their early
> invocation in crash core without consuming the once-only guard.
>=20
> When enabled, the chain runs before kdump only when
> crash_kexec_post_notifiers is also enabled. Leave the late panic call
> unchanged so callbacks remain eligible if that path is reached.
> Skipping the callbacks may prevent hypervisor crash handling.
>=20
> Suggested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Link: https://lore.kernel.org/r/bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igal=
ia.com
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790014793.gi=
t.zack.rusin@broadcom.com?part=3D3

