Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200409;
	b=KD079KtYmcj9WKhRHYn+i37ZXNJFE4j9yhM2r35wlv1uIzO1waQkpgjubKpdO2Xl/j+3
	 9pCs4dMZ5ZzYpfgF39DbdErFm/Uk550O926tiPApkRdHsy1dAMd3gMHHLewtytR3jQ1L1
	 sKeyVOZhiaohW9o8+N1cqnW/MihFd/hWTEeDt24Z8Ur5YqHHQqyEWv6pEAUth8riL7q35
	 cC4EJWiYr192EztiqLH7dvGTKLMYA2XK1mW9piicBmpq5sUa2AbeVqDXjQkWRTB+al/5R
	 1abDR5nJqTc6At8vkZhR0th5TIwyEpsljkqhoaHeF83AsYBZDoMfjbWvQXv/kQi6Hig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200409;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3imGrkEpHkRRFSltzD9nwj900Qui8XtxzswH1nxg748=;
	b=laSh3tHgJ+4brZiZB00boN6ppeNvBCVc2sSC0Tx9iRFN1q0kLsZjnNjkPv/TMilSaZsa
	 vUjWVzxBQO/tvTSOxhU1e73kha380sSyX4+PZCSNIvqpt4tB+ybnBL8pb+r5uTVBZziYf
	 tZE78tkCSf7k5F1Vf8ofLSE0FTnNUcJOAFpri9ZTTolotsOmxw+3tXX4eCU9bMGiFEPJK
	 VUcEj32lPEHphQCC1ofHlj1ZRIUVeG1Mhv4vSFEcBQ+lE0vX8vQ//3CjwRFwz5HD1MDHp
	 uaUISm9asL4WOgGrUmLM7Z3ZGMOPJXQewL2+b7/BJn7XdFmZ+CgUm2pZojQ1LPJN5rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="ZgDL/Nzd";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F6606A31E;
	Wed, 28 Oct 2026 15:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 203F6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=ZgDL/Nzd
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A263D40E04D4;
	Wed, 28 Oct 2026 15:13:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PN37A0igGQJR; Wed, 28 Oct 2026 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793200397; bh=3imGrkEpHkRRFSltzD9nwj900Qui8XtxzswH1nxg748=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZgDL/NzdjfjcID7q6Un7LHdLo5v4QtGZunYdgEtimMn5nectyejEi2phvkYOVTRr+
	 X3GDSw4Bb2yjzV/O+o8+g1RbnblWQ6teLJ4VxqFdxAi4vLIyssJ/J8g5TH6/5afH9t
	 U55k8+ZCMGC6mfytYVdMeRdBslAAYegc6OocXV6hu7XLMjfLevW4Ha9REXYIvYI2We
	 KIHE0KeZByp7xz4LTsEXKA0xPZya0y2WnpCeq5xbYNdPEwvJ+gaCXprzC+atFUsLso
	 xilfumHoqEEgYOU0Spy3JraRVAj5lmo4tM3hymr7kP/oJyefDWvGF97szsa4NNFjVf
	 JS2LnnR7Oo2Dm6Gy6+E2fvAU5id58CrNooWEH7Z2U+Ww3iyUyC6OgIjfNVruxrcGK+
	 2y68BZ0OzeM539hJ/H3IaNA4caWb2AGaCLvPKoz0InGBU5dcXWTSS0vf0GodHeeKhA
	 cQr0It+PAjeuV1mZhduJL6WOteYQ9ZCS0geEwFyXbmpEF5xtgUyN/8NZ0AEP+bij6q
	 WeJ5WK77dIo58MUL9jOxjWVd+nwd64gifdgqk2slOT/Uo1LebHMbME1EkuQRAjv/C/
	 IBZRa1mGtS2C1IQc4SYbnNgJZnkIVhTeSgy0Zar0UylGfGwMcFVNcDgbzTnrb6/Qih
	 coBRoAVVkHrnuTQ2TY6Za6os=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C445A40E04CF;
	Wed, 28 Oct 2026 15:13:01 +0000 (UTC)
Date: Wed, 28 Oct 2026 08:12:58 -0700
From: Borislav Petkov <bp@alien8.de>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v1] x86/vmware: Fix i386 high-bandwidth hypercall
 arguments
Message-ID: <20261028151258.GAauIQ-vbIjX2xuQXd@fat_crate.local>
References: <4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin@broadcom.com>
 <CABQX2QMNetg9iYRRsQmeM3+1tnC94ccWM=450wMZL_sUbqAJtA@mail.gmail.com>
 <20261028060042.GCauGPirK7ePNeTGF0@fat_crate.local>
 <CABQX2QP=cpMfFTdmxdQr6uVnJSF5uVQj7F6bdGwpdb1BT_UtJQ@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABQX2QP=cpMfFTdmxdQr6uVnJSF5uVQj7F6bdGwpdb1BT_UtJQ@mail.gmail.com>

On Wed, Oct 28, 2026 at 08:02:52AM -0400, Zack Rusin wrote:
> I haven't seen this. I need to update my kernel setup to fetch those
> muted Sashiko reports. Anyway, both are valid but they're preexisting
> issues in vmwgfx. I was planning to rip out most of that code in
> vmwgfx but I can provide fixes for these two. We could land them via
> your tree if you need them as a prerequisite for landing the above,
> I'll just make sure nothing touches that code via the drm tree while
> the changes are staged in yours. Or I can send out the vmwgfx fixes to
> dri-devel and land them in parallel via the regular drm tree. Let me
> know what you prefer.

Oh, I was actually only pointing them out and they're not really
a prerequisite.

I thought you guys should see this if you haven't and perhaps take a look at
fixing them or documenting them, as this is our main modus operandi right now,
in the age of AI-finds-bugs-in-code.

But ripping them out is the best fix anyway! :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
