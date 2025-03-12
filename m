Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2023F294
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778882; cv=none; b=YcTpkDe2NR0Wu79qZO5SKFMg83qizg7ZxkVoNxbhV5GLueisqvx0dSW0rBGj4i4vLDbfDLCqjQnWDZ0KbSKAKAJZewlYM9oBNMkPNQY0YShqU4XKxOGmiDmH4fdJGgZLAQ6gb6f3KQ2EbqcXZ//VD7iOGaKJBVHW0/vdKBn6RrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778882; c=relaxed/simple;
	bh=642luVwR1rhiDQGagfzXLNku1fz9PVRwe+Q1hzu9vWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dA+8EhNYfxb+rheFkmObQ9GbgLsQdTWzAYGht/Gg8jAdHUIlGjtD8FJ5igI7VMeYBIPXVUe0zIdHkQDuSR4ib6lcXJeMnZc+y/CQWYnyjp85u5EwsmjLzVS07X+AvG51ANnoPaRWV5U9KhtkhzSZkndpI4peosKnhH5gL2tjNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GmAeVX2x; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GmAeVX2x"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-549946c5346so5308943e87.2
        for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 04:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741778878; x=1742383678; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4RxqkGR94BPVGce5aV+9P2qyNU9Q+0BqyoQl1HOjM88=;
        b=GmAeVX2xfKMUA0F9MWWjcl9zdyCb+BahuG84nhkRe5enNgetstaeKeVWAjH+mofi82
         qzOjgztjcim6JSMt6zBC/cavrrsYLKDdtvs39/Mz5RSlf1n5qQxefoGmXypNLmfTevIr
         qTIEI6kuysBJ62FEphdUXg+pKSsOeryauOf7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778878; x=1742383678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RxqkGR94BPVGce5aV+9P2qyNU9Q+0BqyoQl1HOjM88=;
        b=YvnI+/LA9l/fhvO09ksTUetNqKrmAMSVam3obzPE7Onxl+AtD/sFoFVtLbZCsW4jXF
         wjYxfPTZEyIzooBmBt8Gj9O09qR/zNnk7pe91K3KjSj7TnYKnjtvYsCk54R9xqyRid1y
         Dix/tjEYcXMql7xYmoJ43kGksUw3vxitknw3Qw/vQmMBGH9AOiBld+lHJRxuyAATO2El
         2qWw0b/0EoWjRg9Q4vSg2+SYXLYX7EgYe2JiBzn6+rzwdBrhkmH+VLIij3St5TqbFu4A
         9BmRS/NOPTIAhRZ6LCMscSr2S09BDcQ9k0GeCDI1mGQ7jAB/Lys9ZS9Co9o9xAQSb+sZ
         mOUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSyvwtQZR5swjIyG791fuDOLbfkE6nhWS4OVWC7FNQsL3mjjp324SqVFNnq86OIoUcQWHEk0FMmyzAQMq5fg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMBZmCLs2aN1BiZ0944nOB1cQYi3GqbZnjB/XqmvmABKwAR0XT
	IQ/iEeRAADXTRMLWG1tbc26C3TOQbxsTTZbQUYFda2ysUw4KbmPakGpp/NXsmvfcV5rpstvpu4v
	Sm4zNSxxd7uk3Q5tsrW2AQtELhb3aStymDUOm
X-Gm-Gg: ASbGncsM5sGNuLzUtrzQH9FCTMCoVEV5/BjgC1duh/PRI1Vi2EGSGZS4/jXnlQSDOPw
	GG3KmYSSRcWV7fUrvJG7IzvQ9YOoUVyYQCcKAVSpPxvI0IsBAajHyJiA4fsCwaSvabnV8eIXouY
	V3daJ25zq9dNKrJzms+Y0vcrF9OuLvHVHbJrn7
X-Google-Smtp-Source: AGHT+IFz7qpG7V+Kbq70TQD/9gDNpGcCQ/LRrCkBUthIcg/Md6j7eAeD2NVl4CUOxYd9b2UL5bp/p0DO4gajmqvOGyk=
X-Received: by 2002:a05:6512:39d4:b0:549:39d8:51ef with SMTP id
 2adb3069b0e04-54990e29b80mr7756038e87.6.1741778878180; Wed, 12 Mar 2025
 04:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241219114400.858980-1-ajay.kaher@broadcom.com>
 <20250310102607.GDZ86-P3VFA-x2iy4l@fat_crate.local> <c2f26b4f-e42c-f152-c33d-4c0dd8d68da6@amd.com>
In-Reply-To: <c2f26b4f-e42c-f152-c33d-4c0dd8d68da6@amd.com>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Wed, 12 Mar 2025 16:57:45 +0530
X-Gm-Features: AQ5f1JrOnXEKk5ljpUjCDD0mea1IrDAGKMU01A5L56i8HOU-XDdL9fs_YXWEAOw
Message-ID: <CAD2QZ9Y3Tyvda-fYpYpuU1T7LTmR3yMTT9c=mf_DWY1sfKjKUg@mail.gmail.com>
Subject: Re: [PATCH] sev-snp: parse MP tables for VMware hypervisor
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, kevinloughlin@google.com, 
	bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ye.li@broadcom.com, bo.gan@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, florian.fainelli@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000055e9480630237fb9"

--00000000000055e9480630237fb9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 6:42=E2=80=AFPM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> On 3/10/25 05:26, Borislav Petkov wrote:
> > On Thu, Dec 19, 2024 at 11:44:00AM +0000, Ajay Kaher wrote:
> >> For VMware hypervisor, SEV-SNP enabled VM's could boot without UEFI.
> >> In this case, mpparse_find_mptable() has to be called to parse MP
> >> tables which contains boot information.
> >>
> >> Fixes: 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for=
 SEV-SNP guests")
> >> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> >> Signed-off-by: Ye Li <ye.li@broadcom.com>
> >> Tested-by: Ye Li <ye.li@broadcom.com>
> >
> > That SOB chain is wrong. Ye's SOB means, he's sending the patch but tha=
t
> > doesn't look like it.

I will add CDB for Ye in v2.

> >> ---
> >>  arch/x86/kernel/cpu/vmware.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware=
.c
> >> index 00189cd..3e2594d 100644
> >> --- a/arch/x86/kernel/cpu/vmware.c
> >> +++ b/arch/x86/kernel/cpu/vmware.c
> >> @@ -26,6 +26,7 @@
> >>  #include <linux/export.h>
> >>  #include <linux/clocksource.h>
> >>  #include <linux/cpu.h>
> >> +#include <linux/efi.h>
> >>  #include <linux/reboot.h>
> >>  #include <linux/static_call.h>
> >>  #include <asm/div64.h>
> >> @@ -35,6 +36,8 @@
> >>  #include <asm/apic.h>
> >>  #include <asm/vmware.h>
> >>  #include <asm/svm.h>
> >> +#include <asm/mem_encrypt.h>
> >> +#include <asm/efi.h>
> >>
> >>  #undef pr_fmt
> >>  #define pr_fmt(fmt) "vmware: " fmt
> >> @@ -429,6 +432,10 @@ static void __init vmware_platform_setup(void)
> >>              pr_warn("Failed to get TSC freq from the hypervisor\n");
> >>      }
> >>
> >> +    if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
> >
> > cpu_feature_enabled(X86_FEATURE_SEV_SNP)
>
> I think this should really be cc_platform_has(CC_ATTR_GUEST_SEV_SNP).

cc_platform_has(CC_ATTR_GUEST_SEV_SNP) works, I will make appropriate
changes in v2.

Thanks Borislav, Tom.

- Ajay

--00000000000055e9480630237fb9
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
kPwzH0/UqVP+eM3EQII1r4Uiee8YifwxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgwc6GO95nPh0DhXVGYwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIG9Y
LEZTaqr76z3c/BTAwYrW4e5VWw1GVaGVARUv7hWbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MDMxMjExMjc1OFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADfaQyAl7OkjlCdRtseM9AhMbCi6QGm8xTJDTk0e
DB8YOIYQEltz+/fNiBHSKa3Gtz2+g3uxZMwjFpvOSmQ4RnvxFIqxZQa7nmHGw4JeO1lnZ2+QrhDw
SDvuQS/i4DH8ibKK9kcnMP/LZaVGMTbul/SwRH0wfYXTfSoEN0ebMyxsZwRAmOtx9uhrrAAmAIzU
Yax3ibD/GGa5C1TqyLOgRno6rtGBdwKuZ0BnA9F0rju0nvDZOhrTtkVnYtf6tTWGrUC7eTwMfyGj
N1yvyS20y2eSsJFctCQvveuXefdJBpd844Kl9uOwMCG7UhbsIySSlLcBuKmED2gYuMdM0OyEPGc=
--00000000000055e9480630237fb9--
