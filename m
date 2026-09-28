Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088E82E5B2A;
	Mon, 28 Sep 2026 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618914; cv=none; b=StnfLoWToak9b3mG+gc9AzuUtPxkiHEarldgg9KI6fJmzUWZNnyqzkSzkrWloG8xHZLQDs53eFVU1Z5G4pMjUB4j08IlFtkg6oOtbT9Keddr//s9duj8JcXY4hr/yDZ+65Nb/1yChYz90oW1mahm7yGkWTSFHbcvw10ZVlBX0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618914; c=relaxed/simple;
	bh=VAduLh3TWvxqkROFoB30Uwt0Ie9dflZ2OL65Gd/XqzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YNX2s5uQtA48/wuMUdomJ0ej4pjfNl1aaOJZeQLs1pS131Mvz0SksGfBGwQukwNt9yDhY+eajZ9WdB+2wYo/lRqOP2hYLK+Zqu12rAN+sAHt+/j9yhU+8+omCKDdnepEXuOksWzuXYIIaA/vrT00Ehplx965kCnHX0c18Y39vGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgFTbxNP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgFTbxNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3461F000FF;
	Mon, 28 Sep 2026 18:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790618912;
	bh=WUr4DNIEp8vqgR+y+EucUuJJumlJdmOaA0wpDfnBg4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BgFTbxNPFcXz6LSX4MLAxqXhEI3Ogbu+y2r9j0teZHuz/LNFhM56tuSTuG1QKMbAn
	 wNmeS1dZVeLgx14gogaR33nyrlxs052QlsSwV3O8C3k/2yr1YcCOJpzz6mKu78b63u
	 5PXcWBa8QdKK+HZA2/l/u62C2b4yfPTmpQzgVedkYjSoB3BbhqvBmAsZRk83hPuEy9
	 Pugfp3WQS/BrQ3kROsvl0hisrK67VTSbClkdohHx0VMN8f+Ql9rRBCzY10AY+iYSYz
	 5Bb6XrLVoYMRsN+hP48oUAZ5hVt7FfcM1ZpkW4H7PUSkkOtVa3/BRAhbJM3IJTgQqx
	 dQwNRTLrSR1PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] crash: Notify pre-kdump callbacks before
 switching kernels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Mladek" <pmladek@suse.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>, "Zack
 Rusin" <zack.rusin@broadcom.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>
Cc: "Kees Cook" <kees@kernel.org>, linux-doc@vger.kernel.org, "Shuah Khan" <skhan@linuxfoundation.org>, "H.
 Peter Anvin" <hpa@zytor.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, "Ian
 Forbes" <ian.forbes@broadcom.com>, "Borislav Petkov" <bp@alien8.de>, "Joel
 Granados" <joel.granados@kernel.org>, "Brennan Lamoreaux" <brennan.lamoreaux@broadcom.com>, "Guilherme
 G. Piccoli" <gpiccoli@igalia.com>, "Ajay Kaher" <ajay.kaher@broadcom.com>, "Bo
 Gan" <bo.gan@broadcom.com>, virtualization@lists.linux.dev, "Sergey
 Senozhatsky" <senozhatsky@chromium.org>, "Ingo Molnar" <mingo@redhat.com>, x86@kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Maaz Mombasawala" <maaz.mombasawala@broadcom.com>, "Alexey
 Makhalov" <alexey.makhalov@broadcom.com>, "Thomas Gleixner" <tglx@kernel.org>, "John
 Ogness" <john.ogness@linutronix.de>, "Stephen Brennan" <stephen.s.brennan@oracle.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Jonathan Corbet" <corbet@lwn.net>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Michael Kelley" <mhklinux@outlook.com>, "Eugenio
 Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com
In-Reply-To: <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:08:28 +0000
Message-Id: <20260928180829.3A3461F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] panic: Pre-kdump callbacks always receive NULL message in defaul=
t config
--

commit 8884313d127ae4b9734baebea7b4ba8dd25b38a5
Author: Zack Rusin <zack.rusin@broadcom.com>

crash: Notify pre-kdump callbacks before switching kernels

Fatal x86 oopses can call crash_kexec() without reaching panic(). Run the
pre-kdump chain from __crash_kexec() as well, after finding a loaded image
under the kexec lock and capturing the original registers.

Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz

>     the shared guard skips callbacks already invoked by panic().

[Severity: Medium]
Is this statement accurate?

During a standard panic-triggered kdump with crash_kexec_post_notifiers=3D0
(the default configuration), vpanic() calls __crash_kexec(NULL) before it
formats the panic message and calls its own explicit
panic_notify_pre_kdump(buf).

Because __crash_kexec(NULL) runs first, won't the new
panic_notify_pre_kdump(NULL) call consume the once-per-boot atomic guard,
rather than being skipped by it?

> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 2b36aa9fade06..5d9fe9e00f39f 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
[ ... ]
> @@ -139,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  			struct pt_regs fixed_regs;
> =20
>  			crash_setup_regs(&fixed_regs, regs);
> +			panic_notify_pre_kdump(NULL);

[Severity: Medium]
Will this cause pre-kdump notifiers to receive a NULL message pointer inste=
ad
of the expected panic message?

If a system panic occurs and kexec is configured with the default setting of
crash_kexec_post_notifiers=3D0, vpanic() triggers __crash_kexec(NULL) before
reaching its own explicit panic_notify_pre_kdump(buf):

kernel/panic.c:vpanic() {
    ...
    if (!_crash_kexec_post_notifiers)
        __crash_kexec(NULL);
    ...
    panic_notify_pre_kdump(buf);
}

When this happens, __crash_kexec() will invoke panic_notify_pre_kdump() with
a NULL message pointer. This permanently consumes the once-per-boot guard,
and any callback relying on the documented msg parameter will experience
data loss or potential NULL dereferences, violating the API contract that
promises the panic message during a panic.

>  			crash_save_vmcoreinfo();
>  			machine_crash_shutdown(&fixed_regs);
>  			crash_cma_clear_pending_dma();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790014793.gi=
t.zack.rusin@broadcom.com?part=3D2
