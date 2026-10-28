Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793167273;
	b=3oqmboT8GXyOtTAWQmK+unuG7Ume/aFvt7G7mMPzNQcAz8+1fVZuI9dkvjxf2I8SGVnP
	 k9NbmfYd6Dj6aZcFnHVq3sMBiLaloUEEyXEaXgA3o4dAgCnASHdRITy8aF1jj+4okCdAA
	 A1GKhWhumVcElmV1qeuc7U3auLlLSXQaf/qMWzna8nv5jasOeRkypdy/g3d0V38BAkktw
	 NcRocQsuxvfgdR4+yO0Pb7HTqE4jH85NQkcAUx7ZiQfk4W8QZQa8cjd2068U71ss67YtI
	 4Zb/GNWq/hRdiiR0rhPDl75vtFaz0cE4LiFRdNLu69INVPmRU7krW4MpoUgkxO69cLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167273;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=StQGvmW5dHLeZF+Vv+JIk9DEZOtfvNHFy4b+UUnTT8E=;
	b=ACrmVkuMvt1hSiD/CrcoYGvRfSikv2d80QFS3Be3MGxuADY1Trr+8YYPX8AH9luEj+uC
	 40FXfqqZztuZ4rRUM4z5w/5oe2ZEV7bNRGcevnwAmkV6+tDjZH+SJOaXWYWoGZznrhO61
	 CvPAg89ftoymRo4LoGmoVDggTpsklyzPiSv6czn593gkPW5fViOaeAHPtFKskKgX+Jfr2
	 SGlOU6T8FNM/5Lc7Xs9ALm/qDn4YEFDQlefgni0OB0nN64XCnBGCAiyE2gRsBH1MH17jo
	 f2cVw+/KSsOifSObBeVojaZe5k49vXdydq/JPbysK48baPsN+bI0Kp5seM3ZFHt3jxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Da4zzXf3;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA5606A321;
	Wed, 28 Oct 2026 06:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84FA5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Da4zzXf3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BD4D540E040C;
	Wed, 28 Oct 2026 06:01:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2D_q4lpLQLMK; Wed, 28 Oct 2026 06:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793167261; bh=StQGvmW5dHLeZF+Vv+JIk9DEZOtfvNHFy4b+UUnTT8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Da4zzXf3iJuEucJqmcEj+hezNaO8/B3DiVQ0cnTB5YJnrPdfTmHmxdxqrRbPbG1Ql
	 vUbTtVGcNEGwFcUe8YB4qlW56/D1j7NBBILTfbdTbNzufyiTShYDxA+6UkBACH4/CB
	 lld/XEuX9T4wHFI8osFB7Rmh4YoQ/x8p30Lfma8yXQ2ModJt0McAOet/FvZ1hweqUM
	 ikAA7cowsWywEhdPfChzfN7soMJjhchMYb1N9Q/YbDRiwa+l3xq8NNxH3vo1ARWiw5
	 xl0xmKPd7R3M8G6vCddFP0RFh0Al/AB3ejKzfpmrXnTFQ0MwRc9pEUgyWrKC1qb/nz
	 1jEK8fAm9h4u2ybJsVq+o4b5dsj5ERs53OoaY4RTXRm/up525lBk+6C3F6zanWqK+Z
	 d7DYSYWQ61evsjB9BwsxXOZrrdkb9ewjovzq0E29fAFt24QIyQFDVUs7aURfeoBRxo
	 sMOyf5amfs6eoGZ+eqLuiScylHWpikLxLpRXOPquQZRd4aaj3d8kcZ1PCe+gOYqZ47
	 5Ohuu2s/vM/FHRuV52ATuZUfjTnMgrRUcHddFrjSxkB9R5iMareOJDZD5YOtLeslVi
	 1HN1UIrI0FM0Y5Ktvtr9rMljtv0BXQYoB0TuWrnfn23w6Em42NZ2I/SblBgwhVhYyy
	 VMPxCRxj2fh7qnvjWhteZB+4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CD2A40E021A;
	Wed, 28 Oct 2026 06:00:45 +0000 (UTC)
Date: Tue, 27 Oct 2026 23:00:42 -0700
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
Message-ID: <20261028060042.GCauGPirK7ePNeTGF0@fat_crate.local>
References: <4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin@broadcom.com>
 <CABQX2QMNetg9iYRRsQmeM3+1tnC94ccWM=450wMZL_sUbqAJtA@mail.gmail.com>
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
In-Reply-To: <CABQX2QMNetg9iYRRsQmeM3+1tnC94ccWM=450wMZL_sUbqAJtA@mail.gmail.com>

On Tue, Oct 20, 2026 at 11:34:23PM -0400, Zack Rusin wrote:
> Gentle ping on this one. It's a stable fix for the i386 high-bandwidth
> hypercalls (vmwgfx uses them), Maaz reviewed it, and it still applies
> cleanly to v7.3. The hypercall cleanup series I'm about to post moves
> this assembly out of line and is based on it, so it would help to know
> whether it's queued or needs changes.

Sashiko complains about some pre-existing issues:

https://sashiko.dev/#/patchset/4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin%40broadcom.com

Please address them: if valid, you should see about fixing them, if not,
explain why they don't need to be fixed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
