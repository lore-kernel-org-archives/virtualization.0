Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AEB25634
	for <virtualization@lists.linux.dev>; Fri,  3 Jan 2025 04:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735878705; cv=none; b=X65SE0PM/DI9EWAFRhhzkAGRI4Jd1zYlZyueWQiUXSeiqvnhIVazt+WgRHpNGWCwz8rYhsJx4Spcjgtwkhy2bx8u5vwGd3TRIzCy3GAIIQtFwxVxA3wNtoL2M6JagD71NDJYAaqAB7VKBvJgglSBL1Vetn+neak7lup3N/EvqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735878705; c=relaxed/simple;
	bh=vdykmE6oap4M9+8GH28EWHM5ahb+CbiIpXgzrzqHGw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+BLTrl6AXyzqYvLi1ieuhAOSlMO6ri7OccL4vpw/e0ihVMhlvZogGEXSRK//A93KJszGGn1ngTv4i7de+SFjvoO36/QaF+Er3960gg7m42RquViFsir/NtGpnkhTu6g5ot90//wN+qvMTMARVf0XteTAVWamIpkBQhJ6K4eFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hpGI3tvl; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hpGI3tvl"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30039432861so135064231fa.2
        for <virtualization@lists.linux.dev>; Thu, 02 Jan 2025 20:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1735878700; x=1736483500; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OGQ/xJwZi/p+71xAqaqZjh4cdQoe5rtB48gbw5tpGN4=;
        b=hpGI3tvlQp2VlluGylS9hyadmmiDMk214sz/LgWKK1iko95n6mSyT2uJ8gAxzOGJpi
         avt7jMpqt7xVREGIIwiLGyiRi26UrfujEvfrU+xkER45CrqK9giGQBdjJ+/XZePrsebS
         9aI+Wt00AuINOMIuJv/BNbZYvbHzPVtP3gGsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735878700; x=1736483500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGQ/xJwZi/p+71xAqaqZjh4cdQoe5rtB48gbw5tpGN4=;
        b=rnz/cyg7kZ/WGV4n2OL3qpWbSdpa1iSnLxhgNvMI/fJsJOp1WmJVpYS8/f3Mp1lNtr
         l874Vh9WXNEvsn6FRfWEA1sRLeI7CRyg/rT20PsEQAzc1xlKB7k5kKjidNrGTHSrT6l0
         70SxQhRCuU/3C7cm3Madf0ya1OAaFW1dk/GczPVMZE2GEfsSZIeN2911OM8xkuuza/ni
         Mn9bKk+mw8KD5fDZyeZ6px35nBlSz1uTDOO0rNDIbzz2ZuUWCCQJMGb1JhOeyZI63K1I
         jyLWSZwURzj8NIE8gHcBEO3+y53MoLcLkZpL2NnpedtvyjzyI3Bw1rFfwSJwW3Va+2vP
         m95Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMhtr4vCE4pps17cKTL79cC3hTy07ZAg1u/2KBmuIIdHbb+ijGiIXZCTofX5C5nzjr9UDnKra8AcL+QUTV+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5zjY9Oi7QrfLWYbk5WhiZo47TGHO/dFv9JF6ItW5KURGQoR1u
	DNDWV6S4Eeqse5UEW659IqNzlqe5dXZGH3ZcL6nmDSphNXGPFUvbjI1oPxT+qJ50pxRZ+LsGJg+
	9KXI8yzSq5BmO9j+xNXnw+oLe9AC+kEWXEDMR
X-Gm-Gg: ASbGnctHJvJLmG5BmsP0k7Oqv5F6XU8LK0d5Hx4gxcdpjKJtLmMXgJBYsU/9iPRSrTO
	r8sqIyrPJ1Of4eBldl5ITbeC3JIQKUrYFaUrCnQ==
X-Google-Smtp-Source: AGHT+IHg8Xp73i7vtJHg4Vs68/IN1Hn8x0gb4MAwBrMvhAPHyJOFRSDnZlHZvjNwVChGzTnr2b+Js8TFRBqDjcG05zQ=
X-Received: by 2002:a05:651c:4ca:b0:302:3355:f756 with SMTP id
 38308e7fff4ca-304685de7e4mr133599141fa.35.1735878699707; Thu, 02 Jan 2025
 20:31:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241219114400.858980-1-ajay.kaher@broadcom.com> <CAGdbjmKSpQSh=xr7MguoSgP85VTR5eu1xUeUXD8RtvZn-=MW3A@mail.gmail.com>
In-Reply-To: <CAGdbjmKSpQSh=xr7MguoSgP85VTR5eu1xUeUXD8RtvZn-=MW3A@mail.gmail.com>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Fri, 3 Jan 2025 10:01:27 +0530
Message-ID: <CAD2QZ9atira8k-CgfqEY81ixZK9aPVte48qD+XnwL5LejhqO5Q@mail.gmail.com>
Subject: Re: [PATCH] sev-snp: parse MP tables for VMware hypervisor
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: bp@alien8.de, bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ye.li@broadcom.com, bo.gan@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, florian.fainelli@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004b314c062ac5c128"

--0000000000004b314c062ac5c128
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 9:26=E2=80=AFPM Kevin Loughlin <kevinloughlin@googl=
e.com> wrote:
>
> On Thu, Dec 19, 2024 at 6:44=E2=80=AFAM Ajay Kaher <ajay.kaher@broadcom.c=
om> wrote:
> >
> > For VMware hypervisor, SEV-SNP enabled VM's could boot without UEFI.
> > In this case, mpparse_find_mptable() has to be called to parse MP
> > tables which contains boot information.
> >
> > Fixes: 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for =
SEV-SNP guests")
> > Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> > Signed-off-by: Ye Li <ye.li@broadcom.com>
> > Tested-by: Ye Li <ye.li@broadcom.com>
> > ---
> >  arch/x86/kernel/cpu/vmware.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.=
c
> > index 00189cd..3e2594d 100644
> > --- a/arch/x86/kernel/cpu/vmware.c
> > +++ b/arch/x86/kernel/cpu/vmware.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/export.h>
> >  #include <linux/clocksource.h>
> >  #include <linux/cpu.h>
> > +#include <linux/efi.h>
> >  #include <linux/reboot.h>
> >  #include <linux/static_call.h>
> >  #include <asm/div64.h>
> > @@ -35,6 +36,8 @@
> >  #include <asm/apic.h>
> >  #include <asm/vmware.h>
> >  #include <asm/svm.h>
> > +#include <asm/mem_encrypt.h>
> > +#include <asm/efi.h>
> >
> >  #undef pr_fmt
> >  #define pr_fmt(fmt)    "vmware: " fmt
> > @@ -429,6 +432,10 @@ static void __init vmware_platform_setup(void)
> >                 pr_warn("Failed to get TSC freq from the hypervisor\n")=
;
> >         }
> >
> > +       if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
> > +           !efi_enabled(EFI_BOOT))
> > +               x86_init.mpparse.find_mptable =3D mpparse_find_mptable;
>
> As far I know, Linux itself currently doesn't PVALIDATE the address
> ranges scanned in mpparse_find_mptable(), and Linux accesses these
> addresses as encrypted during early boot. Given this, am I correct
> that the guest firmware that you're using is doing the PVALIDATE of
> these ranges before starting Linux (else there would be a crash upon
> scan)? And then presumably the firmware is also making sure that this
> memory is encrypted so that Linux isn't reading unencrypted data as
> encrypted (i.e., garbage)?

Yes, Linux (as a guest) receives valid data.

> If so, does that mean all the ROM region scans removed in [0] are
> permissible for SEV-SNP guests booting on whichever guest firmware
> this is? But you only want/need the mptable info here?

Yes, VMware firmware validates MPTABLE info when 'non-EFI guest boots
on VMware Hypervisor'. The other ROM regions removed in [0] were not
encrypted and validated. This is a specific use case for the VMware platfor=
m.
Linux today assumes SNP VMs will be booted with UEFI.

> [0] 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for
> SEV-SNP guests")
>
> More broadly, ideally the guest firmware would communicate to Linux
> that these ranges are safe to access (perhaps via the e820 table),
> rather than Linux making the assumption that the ranges are safe for
> non-EFI SEV-SNP guest boots in this scenario. However, since you're
> only changing vmware_platform_setup() for such boots, I don't think we
> need to hold up this patch on that generality.

This is a VMware specific scenario. VMware Hypervisor makes the MPTABLE
memory available in e820 when 'non-EFI guest boots on VMware Hypervisor'.
So it makes sense to do the changes only for vmware_platform_setup().

- Ajay

--0000000000004b314c062ac5c128
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fEfjRz/Z5b6J+pnCj2dzb2Wir3qx4rt1/aShjQasncmTZ0r8rOk2G3RmKolDmTmWPMeCgzL2KeQs
QRXTsKFFi0np4iUyWo+MDCofsswor1HkoXwlmoIAdrFL+cw3qvOowpOB0pe3+G1rWNvJvYsOAzG6
2a8X0kwMSTEGjJgAX+jQjqwdP8C4ZxmE7n236E9GiM8kfhFFAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2FqYXkua2FoZXJAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQkdXtSp1Dzqn1C33ctprG/
nnkbNDANBgkqhkiG9w0BAQsFAAOCAgEAQbg6h5rEci8mKF65wFYkl7cvu+zaAia4d24Ef/05x2/P
WAuBmkkDNwevol3iJzQNwlOuR4yR0sZchzw7mXSsqBhq1dgSNbReQ0qJU0YWze48y5rGlyZvCB1Q
Z8FbyfrHGx4ZQJcjB1zeXJqqW6DPE5O8XOw+xTEKzIQxJFLgBF71RT5Jg4kJIY560kzMLBYKzS1f
7fRmy20PR3frP6J2SwKPhNCsXVDP3t0KC5dUnlUf/1Ux2sVe/6G8+G7lBCG3A1TaN4j9woYHN7Y/
U0LCVM46Gf7bFsu7RzwcrKtSOnfJ3Fs7V+IWCrTMvbCSQylAy3+BMkMGFZ0WwtXNLxbYIEhKAZmH
npugOtDKS6j4LkLxkHr/dTYZvfdOXZXTIlz8qTfkTKw4ES4KW3EGzfnRZCL2VD27/GAtt0hwPWrY
HL087+VQLA9RUVdfnigRjZOPWo//78ZaDd9PPWbLKqa6EIboR2nSV5miF9fQinDnxToBGplQEcXG
WwCF8syc/0n0xzLlb/IOwxmkzMizN/3/vVp5eGh64OGdhSwzZDBQuVS08Wgfd3nVHT6zh1F0jBgZ
ACv82jjjtABB+Tg1VZ0vcRr5ZzTC1WylB7ik6soemgWAgbrQfhNh0uHr9jq+NAbTA4wqUK6gA5LP
kPwzH0/UqVP+eM3EQII1r4Uiee8YifwxggJkMIICYAIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgwc6GO95nPh0DhXVGYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMU8
pgX8oOCQm5zlfwB3b3DcPy5w257uyjwh07gSFkx7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MDEwMzA0MzE0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJ
KoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBVfR13NGOcJogif5AOLxV2
pUZsOT+8kRwIhluhFJuBaqnJi12DBwtUcyf9GU4Fc/g1Z3W6wOJIXmoqVbcsFvnmQnRlGD8y3olk
5hLXLMRoXCGBd0DnWKaYaGuVdc8dNJi5ODrZQgA7/oQEo4z4MswSV+GR1rdV3ipYZwriZYG44JmI
b4HuUAuameZ7goOEGznt+xChN3RAWGiwJ/DqqKhsvkRUqjVqDgtlMlJ1Tvv32raSmVqbNovgeQMo
R6EtyN+17BAur/2J8YM+VqU0OqBudSkEDlZD/NMZKYpI22Hq5YdRsi2KhpgJLocp95xK5qtFV5Kw
tpd5BFLWGhYntuPN
--0000000000004b314c062ac5c128--
