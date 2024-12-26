Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45629481B1
	for <virtualization@lists.linux.dev>; Thu, 26 Dec 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735228592; cv=none; b=VGwg0+0IHs/dwzwszzrXMVy/7BobVUcS83jrK/v2FD19UHRdfaO56pmZC0hE7zPIuM+b75iQa9/BdhEhqpMOlAv7SHOxphdnJ21TS2bG5HbZMUuan0XWa9tHu6g8axauYCAy310vTxnwJozQWpmn3wqFchKd/3TnZzhRtrB4hbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735228592; c=relaxed/simple;
	bh=8dWJYbPztJGqtWyxWhBeuuSmO8/C62dlgZ4Yu0b3HA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBqmvyaILoBcKeWdrfOQiL9sKfKCuH/hal/cDhHqe4EBrrpJYc+WFuNiYJIq2FUjCJJBW5XCEqdKPLc1RAqC/sTXppyGBlSviISvWhjg9QBR+Wds3PB96C9C9WrP23NmqjbyxQmUfdk8FBQ6VkdBHc0nPvKzXRCI2s3tvOKbPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XX7+1bg9; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XX7+1bg9"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-85c5adbca8eso1347553241.0
        for <virtualization@lists.linux.dev>; Thu, 26 Dec 2024 07:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735228590; x=1735833390; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hc59ROmczJ+xhKnDxDLrZ6aDRtsoQSfavGFjRWSM6g4=;
        b=XX7+1bg9fe2Qwbwj8UoxiXRToUQjzWzJyv6GNAc5ljkMIwdMVQvmO09vcK1SbV3lzb
         tADNYTXymQxjjGrhXhOC9WByslx/j5GCOUCj6TP349CV7kq6Y3WKoJCGZd/rQcEGIbaI
         H6uasa13xiX1lxiK8FEUEyBvHCnIHAoB/gnQ4d9frEvAFz6ppmUgV/LiK9XHUr+sBNg0
         Gx7gRXJ5TF8FlKCCwlKRTbg9ucBjT4hlpwfr8nmgqHCcFRramWDfUdSLUB+TZcYtfvtL
         S3GmMI9UEvlY122lWbG66fxIM0x2rV6NXLk/BDjqOG4Xe5w/g1eJ3hnpLZM8gHW8gOs5
         MAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735228590; x=1735833390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hc59ROmczJ+xhKnDxDLrZ6aDRtsoQSfavGFjRWSM6g4=;
        b=ltA3sNdbIa8XnxwtaVssJV2F6/F3HvvCbJ9qSeY1fSQDGRnBNYygYUaAHOpyLjlzOJ
         8EP9lBPikGpZAZqwRbPvtQ35d0h7+E7kfozH+SEksWZFBesctifiFRoxS2WlGdzEuOM1
         VuK2ezunf8Zc9w5Ul6qtJoBbcGnq/MreFP46aHH/blAmxY/zaJX0xbFHqby+tImEYG/A
         NNzx2lG9RDv6pBOVgITg+HIFVrCuD1BkyL6gm2bmsJVWyJYzunKMYQcTy9BEGuYpjdw9
         UfBzJNwotusmqAOioVWQK9JexIfXf9NfiKSwTyQu6GPJYkBVl1Eq1mwQCzAQ84MBE4O4
         Ve/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCGFVIZIPkOPT7PBa52AxAkEBVCC3zvbqOuGNoZgIgoVOZ+pLE0DJWeaqEtsKE6QmUVUXrhohU7ahMkdOhfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyC1++Ma+m1rPd3hXLOtyipLLKnUcZJoOcs2wUDMF3uEDEZ34wd
	0c1EzLlWkFZxGI5LIJlkpy9osIFFcuZx8LEOFFmM6KxthvfJ8e0QRC8OcAZZvtkN38W/WduQtcc
	ODBIdiKAImV2gZvbx5eJfxrH3QgUxG134lcgB
X-Gm-Gg: ASbGncvhyrHKpwU41NqWotScIU7RyAyCM1pe8c9YHy02CpiRWZwBmpXZnSza0AxgWUU
	Jo1H0BMGi4hl/P7CJYRULNeADVr4WtlQFArMySsc=
X-Google-Smtp-Source: AGHT+IGmsZkvWC0kbJfvRZl/cHOWa+TRpd5M04qh6UpUoMJaRcxpyA16W5YpYURmLEtF5RMtlGpPTHy5psClPDoO490=
X-Received: by 2002:a05:6102:1493:b0:4af:af20:516a with SMTP id
 ada2fe7eead31-4b2cc31c290mr20060001137.1.1735228590053; Thu, 26 Dec 2024
 07:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241219114400.858980-1-ajay.kaher@broadcom.com>
In-Reply-To: <20241219114400.858980-1-ajay.kaher@broadcom.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Thu, 26 Dec 2024 10:56:19 -0500
Message-ID: <CAGdbjmKSpQSh=xr7MguoSgP85VTR5eu1xUeUXD8RtvZn-=MW3A@mail.gmail.com>
Subject: Re: [PATCH] sev-snp: parse MP tables for VMware hypervisor
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: bp@alien8.de, bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ye.li@broadcom.com, bo.gan@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 6:44=E2=80=AFAM Ajay Kaher <ajay.kaher@broadcom.com=
> wrote:
>
> For VMware hypervisor, SEV-SNP enabled VM's could boot without UEFI.
> In this case, mpparse_find_mptable() has to be called to parse MP
> tables which contains boot information.
>
> Fixes: 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for SE=
V-SNP guests")
> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> Signed-off-by: Ye Li <ye.li@broadcom.com>
> Tested-by: Ye Li <ye.li@broadcom.com>
> ---
>  arch/x86/kernel/cpu/vmware.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 00189cd..3e2594d 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -26,6 +26,7 @@
>  #include <linux/export.h>
>  #include <linux/clocksource.h>
>  #include <linux/cpu.h>
> +#include <linux/efi.h>
>  #include <linux/reboot.h>
>  #include <linux/static_call.h>
>  #include <asm/div64.h>
> @@ -35,6 +36,8 @@
>  #include <asm/apic.h>
>  #include <asm/vmware.h>
>  #include <asm/svm.h>
> +#include <asm/mem_encrypt.h>
> +#include <asm/efi.h>
>
>  #undef pr_fmt
>  #define pr_fmt(fmt)    "vmware: " fmt
> @@ -429,6 +432,10 @@ static void __init vmware_platform_setup(void)
>                 pr_warn("Failed to get TSC freq from the hypervisor\n");
>         }
>
> +       if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
> +           !efi_enabled(EFI_BOOT))
> +               x86_init.mpparse.find_mptable =3D mpparse_find_mptable;

As far I know, Linux itself currently doesn't PVALIDATE the address
ranges scanned in mpparse_find_mptable(), and Linux accesses these
addresses as encrypted during early boot. Given this, am I correct
that the guest firmware that you're using is doing the PVALIDATE of
these ranges before starting Linux (else there would be a crash upon
scan)? And then presumably the firmware is also making sure that this
memory is encrypted so that Linux isn't reading unencrypted data as
encrypted (i.e., garbage)?

If so, does that mean all the ROM region scans removed in [0] are
permissible for SEV-SNP guests booting on whichever guest firmware
this is? But you only want/need the mptable info here?

[0] 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for
SEV-SNP guests")

More broadly, ideally the guest firmware would communicate to Linux
that these ranges are safe to access (perhaps via the e820 table),
rather than Linux making the assumption that the ranges are safe for
non-EFI SEV-SNP guest boots in this scenario. However, since you're
only changing vmware_platform_setup() for such boots, I don't think we
need to hold up this patch on that generality.
