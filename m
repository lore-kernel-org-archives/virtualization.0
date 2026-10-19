Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B64E3236;
	Mon, 19 Oct 2026 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406826; cv=none; b=MsX0FvVwbJiOC1Z4Z2VdTxoM1HTXluNwlilZz2VOMe0BGX+BWPJef2ebitrka/6ZNKPSN3PIw8qsTZoOBOFbceMmRkzXYcgr4DqfvViTRJssLgrV/mkETAtfbC2tVSndR/jVETSxsMmuzGfmKMkOsYwvLMU2gY1KZWw+i/XALNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406826; c=relaxed/simple;
	bh=OyP5qKjojQU55MZ5aIPOxkm7Sd3rGJnPSxEwuWYCsCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UUVYX4CivilUuUcsUmVx5swBOGPa06H5Jbt4ZkksG/ahMTMr6GqaCIW8Xm3KYqCXMZ5KbrQRIrFKDsjl+BCEoeA6UmjbOa5C1b8CXipXPVDnlhzWJued7ZHDABmdYwDlBm/dJJtlm621+mDMMFcTHfGYa/5XaH8vhn9dI9tZgGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RJrgegDS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3yq5gli; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RJrgegDS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3yq5gli"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792406821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+H3ORQrwht0RhH+jV/nG3TxmFwVK7hnaHuDKuALH5U=;
	b=RJrgegDSh31nSEeRaJ40tX9/wCik01AUj23iNKFod8Vpe5ofRKiuMhcPTZ57MmiKpzCWTr
	XU4gMrQtGXzOXRjA88LaB+n2r4ogDkXj5oj63WGWgGObA+eFOxrV0KiZeRsdMsTOoiqkxP
	BELJw07TMmdrlW3wiMH3Qddl7ylj1edkuLs2gXy5SwdmiikCP2Z+uUaorINQKT3ar5rdvC
	WYNGsHTgatQw2BiLOzvd1r/2NIffMdC79bzZ/an4CjVR8p0heUzhn/ksRwNoAbC2KJDoaJ
	VpNQeXKcaejCw3h6CKqU4g6oJWZ2U0XmV0lsBFakoeL89CdlplLKVBb1Z3cGtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792406821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+H3ORQrwht0RhH+jV/nG3TxmFwVK7hnaHuDKuALH5U=;
	b=L3yq5glitizDFhda1Bh5+tTcD0rO1VcMiIZrlrRUvxqJJWdj3FfRuqPmo0KDmfK9TVGTwE
	I7vKDiEiUZZXqeDw==
To: Zack Rusin <zack.rusin@broadcom.com>, sashiko-reviews@lists.linux.dev
Cc: Petr Mladek <pmladek@suse.com>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Kees Cook <kees@kernel.org>,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, "H.
 Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>,
 Borislav Petkov <bp@alien8.de>, Joel Granados <joel.granados@kernel.org>,
 Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Ajay Kaher <ajay.kaher@broadcom.com>, Bo Gan
 <bo.gan@broadcom.com>, virtualization@lists.linux.dev, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Maaz Mombasawala
 <maaz.mombasawala@broadcom.com>, Alexey Makhalov
 <alexey.makhalov@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, Stephen
 Brennan <stephen.s.brennan@oracle.com>, Steven Rostedt
 <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap
 <rdunlap@infradead.org>, Michael Kelley <mhklinux@outlook.com>, Eugenio
 Perez <eperezma@redhat.com>, kexec@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 2/6] crash: Notify pre-kdump callbacks before
 switching kernels
In-Reply-To: <CABQX2QNHSjP+FFppUR1ohthwvCjWNA2ozOuZtnwwdNu7WGaV0g@mail.gmail.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>
 <20260928180829.3A3461F000FF@smtp.kernel.org>
 <CABQX2QNHSjP+FFppUR1ohthwvCjWNA2ozOuZtnwwdNu7WGaV0g@mail.gmail.com>
Date: Mon, 19 Oct 2026 12:53:00 +0206
Message-ID: <87v76yotln.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-09-28, Zack Rusin <zack.rusin@broadcom.com> wrote:
>> > @@ -139,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>> >                       struct pt_regs fixed_regs;
>> >
>> >                       crash_setup_regs(&fixed_regs, regs);
>> > +                     panic_notify_pre_kdump(NULL);
>>
>> [Severity: Medium]
>> Will this cause pre-kdump notifiers to receive a NULL message pointer instead
>> of the expected panic message?
>>
>> If a system panic occurs and kexec is configured with the default setting of
>> crash_kexec_post_notifiers=0, vpanic() triggers __crash_kexec(NULL) before
>> reaching its own explicit panic_notify_pre_kdump(buf):
>>
>> kernel/panic.c:vpanic() {
>>     ...
>>     if (!_crash_kexec_post_notifiers)
>>         __crash_kexec(NULL);
>>     ...
>>     panic_notify_pre_kdump(buf);
>> }
>>
>> When this happens, __crash_kexec() will invoke panic_notify_pre_kdump() with
>> a NULL message pointer. This permanently consumes the once-per-boot guard,
>> and any callback relying on the documented msg parameter will experience
>> data loss or potential NULL dereferences, violating the API contract that
>> promises the panic message during a panic.
>
> afaict Sashiko gets tripped up here by the doc from the previous
> email. Nothing in this series dereferences the msg. The only callback
> is the VMware logger in patch 4, which ignores the argument. It reads
> the printk buffer, where vpanic() has already written the panic line.

If you are not using the argument, why are you providing it in your new
API? Just drop the argument. If any future pre_kdump panic notifiers
need additional information, they can adjust the API appropriately.

John Ogness
