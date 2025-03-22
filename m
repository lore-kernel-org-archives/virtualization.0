Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02561C68F
	for <virtualization@lists.linux.dev>; Sat, 22 Mar 2025 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742605701; cv=none; b=H4eAWFRlGjHDGsKgAXdYWmPMGFmfCthy49APN9wAO9597FP8M8YEY+jtOWILKeb9SXuGMhcdwNOiEeXBK1zlKN1oGSvQPQPv9y/3scqd3fpQlHbxzyC8JhML0hjC13RMzKHsHv4/PG4m6kwWKIuAVUlkonXQfJn4ng5ll9RzZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742605701; c=relaxed/simple;
	bh=UlCEukpy828X+t+n7YKj+Gp5G6r5hcYtbALRFRMl084=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peaE/PzzF5smib35Z7Nk4GFHbdwS7moxYy5RgqONqKFx7NaDh89VC5e03v1Ufk6rL+NANE+J7e1Z5JC8aE4I0vfmlSOHXNbtk9Hv2RtA1cjZGHOe4CaNJcllxEoWWXDSBbJl8Li8speHqqy6bNdROSJEmPyFWZJEht69OKz8baM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFtuOukf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFtuOukf"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2263428c8baso51375ad.1
        for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 18:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742605699; x=1743210499; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PORJkvOxkuHko+fxCJKgIIFheR3by/P8aDDODWCERsg=;
        b=GFtuOukfRENEuVg61W5+ojo7QQV6nBS8+5k3MrukzH9SJBvUvoNoHc5eOj3fzyOW4V
         Uz1v1xqAL3L+bz9++2IVkFCYMM2rP596LIapCwtNwTLaeaKdUAe2BVZXrFML0GZYLZMW
         SYwbIyCNmPDWmF0qq0Hl26iTkavpEc420R31fJLv1gVCXgsnsJKGuCAd+h6AriaWjzoP
         0PB7odLlr07HEGFx4vl49pGy5bcgAG0jwZQm5xQCqKu1CMv8s1GM+vwF2UpfhQo4q01X
         JTuZPCVTG3OpQwz3FZ4bfRPoNBwz7NzJcoAn9uqpGh3t4NDD41Px6HlEy/ItBLUUavrx
         jRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742605699; x=1743210499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PORJkvOxkuHko+fxCJKgIIFheR3by/P8aDDODWCERsg=;
        b=p3Mr+187j52S0+0VpDLRKkMsnIu2KXnP2K5wX3Mha9Kg5mozaYLyAOn+/6mnqTU6v3
         2kmk2hRLLcWD1G6HMntR8R3iUKsbWHT3q8LLqYVrbYdcpgCriS5IxXsoB1YpqYa/OJvU
         UdpSDoNT6WUQ/TaR6RQMzT4taybyDukslTePo0GMGqqdgrMCDze4r/hch7brqNMx/Bau
         qvy2cCMgaaWAayUwlPaFYFYKlm+XFbaCZGli6Txm8EOGukEwI72WU7YqCzlOCJS+uOkh
         kfKSUzd+PgMDOErt8M5tapnndDjWWfBtwT7Y8/+0oqn1aZTNbGLiISmgsBj1sNFqfFQr
         xwDw==
X-Forwarded-Encrypted: i=1; AJvYcCVfUMc/sak5bnFmlYfG4lzgbFsJOKONsXMPl8Kd8AIKqBCee3zY/yk/ob7pCHxXsbtzH8CmlqzsHNOL98IkRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/XxdWJFRbGAVHnf/dRlFLaXvt8NyGiiJ9A86+CkezsxZL3ZiG
	zKDwFVAbU5b7FJOWPsCMeL3IneEmbuyFzqfaIanZROclpkTUfcG4Xqh0G+Qxg3/Ek3ny5kMYmMY
	7cjlVmtVJp+FsaHIDjM7RacZkkbd87yWDRP1M
X-Gm-Gg: ASbGncuSNU2GxXxORC5FZqFav3kdPRZ+CHwYeCEy/kjrA1j9cLYq8iqdBQkyQmAh8WT
	ZK9wRvKfjX7lk//i5OsJ0CwEPwQe3K+FTnF4hSQVTNv/dz1ZnSaUqkAL8qKh2VSBrDVm0DYDup4
	nGZV7E9ez7FIbOr+Nea73uOjhtYIC9uRbFug9o0LrCNArpN4EbbcxQMfy/RV4JhdLdGeo=
X-Google-Smtp-Source: AGHT+IHwBjcoBQJD7PgR24WQYCLIQsyJ/8mCgJRTKFIdiYFR1Yc44CsmaI9H6JC3a7kMd6MKs5kEznfjIsb/OAkQoIg=
X-Received: by 2002:a17:902:e742:b0:215:79b5:aa7e with SMTP id
 d9443c01a7336-22799f46955mr693655ad.13.1742605698803; Fri, 21 Mar 2025
 18:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250228014416.3925664-1-vannapurve@google.com>
In-Reply-To: <20250228014416.3925664-1-vannapurve@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 21 Mar 2025 18:08:06 -0700
X-Gm-Features: AQ5f1JoTxkcQ6rnzBlVlnNhEnnZwVceT5ZUnX3gSJIePazDtJUJ8CyOxsH4dLZY
Message-ID: <CAGtprH-8oJ66nunFHvZu_KcHjDM3=nTn1g46dSUOHMaOwo5HrA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] x86/tdx: Fix HLT logic execution for TDX VMs
To: dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, ak@linux.intel.com, 
	tony.luck@intel.com, thomas.lendacky@amd.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	pbonzini@redhat.com, seanjc@google.com, kai.huang@intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, 
	afranji@google.com, kees@kernel.org, jikos@kernel.org, peterz@infradead.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:44=E2=80=AFPM Vishal Annapurve <vannapurve@google=
.com> wrote:
>
> Direct HLT instruction execution causes #VEs for TDX VMs which is routed
> to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
> so IRQs need to remain disabled until the TDCALL to ensure that pending
> IRQs are correctly treated as wake events. As per current TDX spec, HLT
> #VE handler doesn't have access to interruptibility state to selectively
> enable interrupts, it ends up enabling interrupts during #VE handling
> before the TDCALL is executed.
>
> Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> effectively solved this issue for idle routines by defining TDX specific
> idle routine which directly invokes TDCALL while keeping interrupts
> disabled, but missed handling arch_safe_halt(). This series intends to fi=
x
> arch_safe_halt() execution for TDX VMs.
>
> Changes introduced by the series include:
> - Move *halt() variants outside CONFIG_PARAVIRT_XXL and under
>   CONFIG_PARAVIRT [1].
> - Add explicit dependency on CONFIG_PARAVIRT for TDX VMs.
> - Route "sti; hlt" sequences via tdx_safe_halt() for reliability.
> - Route "hlt" sequences via tdx_halt() to avoid unnecessary #VEs.
> - Warn and fail emulation if HLT #VE emulation executes with interrupts
>   enabled.
>
> Changes since v6:
> 1) Addressed Kirills's comments.
> 2) Fixed a build failure.
>
> v6: https://lore.kernel.org/lkml/20250225004704.603652-1-vannapurve@googl=
e.com/
>
> Kirill A. Shutemov (1):
>   x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
>
> Vishal Annapurve (2):
>   x86/tdx: Fix arch_safe_halt() execution for TDX VMs
>   x86/tdx: Emit warning if IRQs are enabled during HLT #VE handling
>
>  arch/x86/Kconfig                      |  1 +
>  arch/x86/coco/tdx/tdx.c               | 34 ++++++++++++++++++++++-
>  arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
>  arch/x86/include/asm/paravirt.h       | 20 +++++++-------
>  arch/x86/include/asm/paravirt_types.h |  3 +-
>  arch/x86/include/asm/tdx.h            |  4 +--
>  arch/x86/kernel/paravirt.c            | 14 ++++++----
>  arch/x86/kernel/process.c             |  2 +-
>  8 files changed, 78 insertions(+), 40 deletions(-)
>
> --
> 2.48.1.711.g2feabab25a-goog
>

Just a ping for review of this series if anything more needs to be discusse=
d.
