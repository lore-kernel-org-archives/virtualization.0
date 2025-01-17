Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18B17FAC2
	for <virtualization@lists.linux.dev>; Fri, 17 Jan 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131733; cv=none; b=unzCL2SlV3xT907v6redtMscXjyAUYwitJkCOeDJlyRJ6j4V/+vxi9KEDOTBW7Dc6CoRNeDqtAcHctqKzJ3ZPDrDVSr6nVgZV9tpC5lZBY5rlnYkcLmlBVvRrDuctvQYvkM19aGmSn3QAiZRYMVb+v318NHub4rDgKv3NtgOkgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131733; c=relaxed/simple;
	bh=mnQWYBcH7K4Pdk8X99isVoWJk81Loe1tgbM8hVfgExI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPPXNlUxMXtCfzKJsfa5CpdhKDLWjlp+A/pfyxhSkZROWqv2eGcHZI/3JsCmnzCwmp8GNfWhV0PVtmpiUnDMT5d0kY2A51ut2vE0Hyy8ngPQ2YaXcJbceIdqdgPYNduQfLQBj/kZpBhkHpwyVMedstN9gbT38oPAm5bwwsbjNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CjZes5iZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CjZes5iZ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e3778bffdso2532424e87.0
        for <virtualization@lists.linux.dev>; Fri, 17 Jan 2025 08:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737131729; x=1737736529; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RszBn5kNzLzH234uH5cn+iReWHdiosemvxGMigyfbrc=;
        b=CjZes5iZQRT5B7N81xhGb/w+ftYZyG0t1eUJq9IIbkrN+0um5jQZk249Mp29vrMGGt
         jiA4DnKsmboKWW99M0XuCILItRaNc2xAnw5FaINox36+ezewFLLM/n1ghUjMCAeGbsA7
         9G2VMk/PEOU8IdomMy7AGcTTm976LcgjpmgDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737131729; x=1737736529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RszBn5kNzLzH234uH5cn+iReWHdiosemvxGMigyfbrc=;
        b=oe/NRo2GIT2Bxz0st+qfKBJoXS14ztQtStAEwOrS0+wxSNvuvfsd19b4bpUzLU1pnu
         YS30bf8b5sVnK5N9EEa8g7mLZMtDKjhi7le1FBDkUGqS/7GHXT0FoNb/eRnQVyTbfbZo
         jZEVGZ7MVoY9Wh6Uge7TX+ro2T2kUpfALi0iLeWN3FVGVD9eMtNkIy85ru2A6q2ML6BX
         OWZAgU9EfhyNJZgPKj1tlmaqNd6lMX5UQzMgVAC1OmzYL0bCoeYS9AGytEji21+R9DnU
         XOhp+zdDeWFzoZhQFKdJm8tQtABy8cGXCCMysON2J3hWB5TI8zXyi+w7gVhsuGUBG2NH
         g95A==
X-Forwarded-Encrypted: i=1; AJvYcCUwZkCZG9PFsdfvsX29KJJ5jxw+NIi7VHZ0x5V1zM/JzdLsO7sWfH6MF4Irw3lc5286P5ZC+r1bxi3SQFCGsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNyLKJCLpoTyUD/eigGnQVsHfWYOI8wFm++8ijoove1NMneHrQ
	89V/kOzPkho5JjdzY/Y6iBK5DixXGfDh1RIse6MqB9zm1ltO/idaupdwJcejwNcvsSb9VU+uUF2
	Ll6vYX93VVwBs9Bb2a0/VOWyMNdkEQxa7AH9l
X-Gm-Gg: ASbGnct4XR7ph8j1AYd/v13lgPPcFr3REGWruH3PkVwmorwNvY+TorGh0CkJidQGPQi
	dkAAPKV0e8SNtN6B0VqIn9EDxkMolAVKlPKA3iQ4=
X-Google-Smtp-Source: AGHT+IE+1ouVQSfilbFl3vxpKg1u3o6lUBhbQh/XPcdIrJ7aBqOmZUmbeQhBteHH0YJePPyWBk5+DBeggufhmMXM6v0=
X-Received: by 2002:a05:6512:1094:b0:542:6366:762a with SMTP id
 2adb3069b0e04-5439c251116mr998969e87.25.1737131729222; Fri, 17 Jan 2025
 08:35:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241219114400.858980-1-ajay.kaher@broadcom.com>
 <CAGdbjmKSpQSh=xr7MguoSgP85VTR5eu1xUeUXD8RtvZn-=MW3A@mail.gmail.com> <CAD2QZ9atira8k-CgfqEY81ixZK9aPVte48qD+XnwL5LejhqO5Q@mail.gmail.com>
In-Reply-To: <CAD2QZ9atira8k-CgfqEY81ixZK9aPVte48qD+XnwL5LejhqO5Q@mail.gmail.com>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Fri, 17 Jan 2025 22:05:16 +0530
X-Gm-Features: AbW1kvYSnZ8M9hSC4O7PQcmeS0f1L1RXuY_hfshnsow_jSfeogD7BUs297fydSU
Message-ID: <CAD2QZ9aaTxnraJfZbWj9zWvh13_hrFuMUCo=3stRNxcSdQ+05w@mail.gmail.com>
Subject: Re: [PATCH] sev-snp: parse MP tables for VMware hypervisor
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: bp@alien8.de, bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ye.li@broadcom.com, bo.gan@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, florian.fainelli@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ac6630062be97ff5"

--000000000000ac6630062be97ff5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 10:01=E2=80=AFAM Ajay Kaher <ajay.kaher@broadcom.com=
> wrote:
> > > For VMware hypervisor, SEV-SNP enabled VM's could boot without UEFI.
> > > In this case, mpparse_find_mptable() has to be called to parse MP
> > > tables which contains boot information.
> > >
> > > Fixes: 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation fo=
r SEV-SNP guests")
> > > Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> > > Signed-off-by: Ye Li <ye.li@broadcom.com>
> > > Tested-by: Ye Li <ye.li@broadcom.com>
> > > ---
> > >  arch/x86/kernel/cpu/vmware.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmwar=
e.c
> > > index 00189cd..3e2594d 100644
> > > --- a/arch/x86/kernel/cpu/vmware.c
> > > +++ b/arch/x86/kernel/cpu/vmware.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/export.h>
> > >  #include <linux/clocksource.h>
> > >  #include <linux/cpu.h>
> > > +#include <linux/efi.h>
> > >  #include <linux/reboot.h>
> > >  #include <linux/static_call.h>
> > >  #include <asm/div64.h>
> > > @@ -35,6 +36,8 @@
> > >  #include <asm/apic.h>
> > >  #include <asm/vmware.h>
> > >  #include <asm/svm.h>
> > > +#include <asm/mem_encrypt.h>
> > > +#include <asm/efi.h>
> > >
> > >  #undef pr_fmt
> > >  #define pr_fmt(fmt)    "vmware: " fmt
> > > @@ -429,6 +432,10 @@ static void __init vmware_platform_setup(void)
> > >                 pr_warn("Failed to get TSC freq from the hypervisor\n=
");
> > >         }
> > >
> > > +       if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
> > > +           !efi_enabled(EFI_BOOT))
> > > +               x86_init.mpparse.find_mptable =3D mpparse_find_mptabl=
e;
> >
> > As far I know, Linux itself currently doesn't PVALIDATE the address
> > ranges scanned in mpparse_find_mptable(), and Linux accesses these
> > addresses as encrypted during early boot. Given this, am I correct
> > that the guest firmware that you're using is doing the PVALIDATE of
> > these ranges before starting Linux (else there would be a crash upon
> > scan)? And then presumably the firmware is also making sure that this
> > memory is encrypted so that Linux isn't reading unencrypted data as
> > encrypted (i.e., garbage)?
>
> Yes, Linux (as a guest) receives valid data.
>
> > If so, does that mean all the ROM region scans removed in [0] are
> > permissible for SEV-SNP guests booting on whichever guest firmware
> > this is? But you only want/need the mptable info here?
>
> Yes, VMware firmware validates MPTABLE info when 'non-EFI guest boots
> on VMware Hypervisor'. The other ROM regions removed in [0] were not
> encrypted and validated. This is a specific use case for the VMware platf=
orm.
> Linux today assumes SNP VMs will be booted with UEFI.
>
> > [0] 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for
> > SEV-SNP guests")
> >
> > More broadly, ideally the guest firmware would communicate to Linux
> > that these ranges are safe to access (perhaps via the e820 table),
> > rather than Linux making the assumption that the ranges are safe for
> > non-EFI SEV-SNP guest boots in this scenario. However, since you're
> > only changing vmware_platform_setup() for such boots, I don't think we
> > need to hold up this patch on that generality.
>
> This is a VMware specific scenario. VMware Hypervisor makes the MPTABLE
> memory available in e820 when 'non-EFI guest boots on VMware Hypervisor'.
> So it makes sense to do the changes only for vmware_platform_setup().

Kevin, thanks for your time and sharing your thoughts. Please let me know
if you have any updates or need further information from my side.

Looking forward to hearing from you.

- Ajay

--000000000000ac6630062be97ff5
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
QSAyMDIzAgwc6GO95nPh0DhXVGYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFPa
G3qpYpd5iUuO+hAGibWnMR3SPp1Ou23cl8a8ocyPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MDExNzE2MzUyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJ
KoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCceQdTsTGIGrliq6FQGGb9
CKksVUmAuJ0Aots91NQhrn7pGJ8SqEPZxmVtFfAlmhCXbvJnRnfPU3mtrD6PZrhs28SRZ809WWlD
nEiuajXyt+PFWTP8X7T5PxrQJf5t5BQOnYlo8pFwmAN05CIMJiHbmFhg0WoYZbGJZzectJ14WRuO
Iys/XnaAQFq3P3EBTrXu9cSmchq7cJKOXl4By5J5aKqyuW7rBOmjDT0bqszM5A1ddkDOLdInFtdo
9pwjMZgxdoZ4w7Q/RbCumEuWMN1sGverqfNVIRLqYUh4iFBRZWwJ9dAltsa+cI/sum87Hpi3CXoF
ISnQ5mEIsIndwSw3
--000000000000ac6630062be97ff5--
