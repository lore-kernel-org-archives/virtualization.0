Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846134AAC57
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573586; cv=none; b=Iooc2lQ8fM0bxoIr/csAo1ZsW+VtB09AfhnWWcVrwNvl84v2/6fh+a0uyBL34+BlzXBR5dS4hhJIT3upscb096qXG2brFws52KTFhrPIVA8mYb+rnsLOeFmALrRwd6HFOg526GHnW/c8+EyVDng7gYb7aJDzD0pPs4Lw9idNQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573586; c=relaxed/simple;
	bh=8mQzj4CMfkvmsbe4ng5ofTnqrlIyiun6eHARzaEvT/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfrGSlgfNFr3m93Dg/s/3TpsPDbXtAeYXAxhb1YkBRX4DgqB15JAL8I+kEUKjQI586ME5n11uSVMUPwncZ/dc8P32cUVp25iaTV1k6ad510EVRGqjz9hOZZXM5j1XxVout8p0L1LqW2uOMtXigkRtR59YjFGQuaOEuulag5jhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cR0uOhBj; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cR0uOhBj"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1576904a12.1
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 08:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573584; x=1790178384;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dPwr/XKrP02zV+CxYm0Ro52fa7+xpBq//n4SeJI+By4=;
        b=d1mr1OXdKlcPGsTvQdT4NRZfu8R754kD3qjgBCFxa1ZCQGLGiCaNr6azGgNALvRnXs
         7S0de2I/U+ZdLYizV+D0sRpPxgXqlnVxfSqQq8J52rqyPrw3ok5P2CRyuEXp6qX7WV7f
         3SWSzS/JxceOyqXMjrTXv1wLum7X4/sXab4+q1/Ix5llVAki4E4aipQ9QDRKIg3V596L
         Dn8pgE5T5dQAqngLqb400bV1dFnK3W5J+LYbkSpqIyeGBvxs+3pjG9Q//zD9d8YJZxOK
         RDJrq1ymcyffObL3tGq0N/2UJEM/K6PrXFdUsy+T2a+aa+vVI9c3+s+OQVs7bpKfQhrd
         K/OA==
X-Forwarded-Encrypted: i=1; AKwUvByBSBQUSQ8F/0FzXkKpE/T3kFRSClUjnv3IX/w8yJgui0WZHrWYkQ2fgCRhKxOc0T6+tcRIF207FO3k2Aro7g==@lists.linux.dev
X-Gm-Message-State: AFuF++nvEnqLbyXqyTKZkt8HDALHwXiOjsMgqUNzINbPPOaGS91pbDAy
	GtAZj70UZpKtjwuqOG9hHN9RR3xhy/VDfWR5j12/mobwwGPb8C/lNNTwm8dMcIY0hl5knIVSHmq
	xYIGsxjdVxH3WqjZAKS3sbikmpheegbEBkpAGfZkbX6ovV7KB+scDiIOTnmaJf/S/MC8GvaK/PB
	AyZutiWK8b6vcLhEz2s1Q8xtRbdcyUZW4PPxswcH+DclY0NtIP4rv7/nsLYQqXdJCbaj38LoFGV
	zoEIZosoqG9BC+hT7Q=
X-Gm-Gg: AYBFou28ywUczcfLZn9zwbgqTyylFSAs2IvwbxRGPCPA7vilOuumlNCPBhXZT5Dxau1
	VygyjckqGApErr38OjeI5WvSTxgfizVGsgZc7O5fZtFbBoPSpVS/85sbkKYQL4gmGiTg4CPTcOF
	EB+8weA4LI+E7RrXEn6HP6hIItGU8CC/liaj0nFj1hyyV3Th00NXXKt7+yWn6hLAdSnkENRO039
	Lqd8HDz0kAgaezhFbLpOnBquN2RoRik+sv9gKVZoNhHZwMkvcQKwPmWV1/QIMcPcsPEq43FqcMI
	tUkDfgdtAXK0sTLY8HUMww6B21oVjEf+87rbLC3Majk3ueOOEXOStcNtikEU7rr/ipSUeSfFaf4
	SsnvnqvIWwXSXfF4WleQ0jBqcWp1LKiCiSkeSr0ihjePz5x30V4lH3KPS6Kf2SLmrDWZJtIjjBw
	J7RKqc2HqUiG7BjjpuCzhv9O1+HhFDWEwW
X-Received: by 2002:a17:90b:2b90:b0:39e:1bfa:c5f0 with SMTP id 98e67ed59e1d1-39e35e304f9mr86349a91.5.1789573580463;
        Wed, 16 Sep 2026 08:46:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39e3619c876sm13625a91.5.2026.09.16.08.46.19
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 08:46:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5b609be5e96so4588881e87.3
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789573578; x=1790178378; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dPwr/XKrP02zV+CxYm0Ro52fa7+xpBq//n4SeJI+By4=;
        b=cR0uOhBjMpT3B0KS3qxkxM65UNN1thqfoz22OSNPlG1vm9u6+A/GSNI9pJiE2XFyRF
         QGX+3MDYC6o1CIBox3RuG11i/jS3LmNrmXSlWCeMHZVsTeSWRpZO5qUzUehik46YCwqP
         ZOrqDHTd6svNOqtWfbYTPp618FagRRCnR5Dq4=
X-Forwarded-Encrypted: i=1; AKwUvBwAfby77re6tmpZGOOYPyQRp2E0s3PxyooEIZbSZzJ1anmsFPKwO3p5Z41D3vXNCBsfRUkLungMxHgK4uc3rA==@lists.linux.dev
X-Received: by 2002:a05:6512:3a96:b0:5b8:9f19:7364 with SMTP id 2adb3069b0e04-5b8b664d7d0mr906766e87.32.1789573578193;
        Wed, 16 Sep 2026 08:46:18 -0700 (PDT)
X-Received: by 2002:a05:6512:3a96:b0:5b8:9f19:7364 with SMTP id
 2adb3069b0e04-5b8b664d7d0mr906738e87.32.1789573577574; Wed, 16 Sep 2026
 08:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1788414671.git.zack.rusin@broadcom.com> <03e5c9855e9578b00abf8da69764f1b468597218.1788414671.git.zack.rusin@broadcom.com>
 <4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj> <CABQX2QNc1GP5ZgizK=9+6XN9Ow4dsUKaFD51oGke=OP6hxCyYw@mail.gmail.com>
In-Reply-To: <CABQX2QNc1GP5ZgizK=9+6XN9Ow4dsUKaFD51oGke=OP6hxCyYw@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 16 Sep 2026 11:46:02 -0400
X-Gm-Features: AcwNN1XauT4DI8kJvb2ZsRlgCwi33Fix1zpJ7UXepYXRuYiki9XQ5pm-upBHmuM
Message-ID: <CABQX2QOLRgNwGH4y7Fjshp=rNd=X0FetdY2Mj49TFRq=UiqpKg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] x86/vmware: Add the vmware_record_panic_msg sysctl
To: Joel Granados <joel.granados@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org, 
	Petr Mladek <pmladek@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, John Ogness <john.ogness@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>, 
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000743b42065b9b911e"

--000000000000743b42065b9b911e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 7:44=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com=
> wrote:
>
> On Thu, Sep 10, 2026 at 4:32=E2=80=AFAM Joel Granados <joel.granados@kern=
el.org> wrote:
> >
> > On Tue, Sep 08, 2026 at 02:07:14PM -0400, Zack Rusin wrote:
> > > Full panic text is useful on ordinary guests. Encrypted guests should
> > > export it only when an administrator opts in. Reporting a crash does =
not
> > > require transferring the log.
> > >
> > > Enable panic recording by default for ordinary VMware guests and disa=
ble
> > > it when guest memory encryption is active. Expose the policy as the
> > > boolean kernel.vmware_record_panic_msg sysctl and document that it
> > > controls only the vmware.log transfer.
> > >
> > > Register the sysctl only after the panic buffer and dumper are ready,=
 and
> > > only when sysctl support is built. A registration failure leaves the
> > > internal default in force.
> > >
> > > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > > ---
> > >  Documentation/admin-guide/sysctl/kernel.rst | 14 +++++++++++++
> > >  arch/x86/kernel/cpu/vmware.c                | 23 +++++++++++++++++++=
++
> > >  2 files changed, 37 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentat=
ion/admin-guide/sysctl/kernel.rst
> > > index b6328cd0f43e..4577e935ddcf 100644
> > > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > > @@ -1690,6 +1690,20 @@ entry will default to 2 instead of 0.
> > >  =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >
> > > +vmware_record_panic_msg
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > +
> > > +Controls whether panic kmsg data is written to the host's ``vmware.l=
og``.
> > > +This setting does not control the separate VMware guest-crash event.
> > > +
> > > +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +0 Do not write panic kmsg data to ``vmware.log``. This is the
> > > +  default for encrypted guests.
> > > +1 Write panic kmsg data to ``vmware.log``. This is the default for
> > > +  ordinary guests.
> > > +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This seems like it can be represented in a boolean value. Any reason wh=
y
> > you did not use proc_dobool for your handler? Would it make sense to
> > have vmware_record_panic_msg as a boolean?
>
> Thank you for taking a look! This follows the existing Hyper-V
> implementation of hyperv_record_panic_msg, which uses an int and
> proc_dointvec_minmax with 0/1 bounds. I thought that consistency
> across the codebase was more important even though I agree that bool
> and proc_dobool() would be a better fit.

I've been thinking about it and the more I look at this code the more
I feel like respinning v2 and changing vmware_record_panic_msg to
bool. Because kernel.hyperv.record_panic_msg is already in, I'm
worried that if I'll do someone might object based on the fact that
the same option for hyperv behaves differenty introducing a subtle
inconsistency. Any strong opinions on that before I go ahead and make
that change?

z

--000000000000743b42065b9b911e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEqB
E+GP3GBha+VExQ8G2Mg5Uh7VVyhEuHjWuSlNiQWpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkxNjE1NDYxOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKuTc5XRk9N5KvAo8BSyfA1z2ZRDOQP9D3/YaQ6W
jWaxMEOI0SXsNBAUsw7aOK455W5VxxuEmnk416xb5BVo3VgQWSg0C716sRExYUJU+JyIXtZYXMuw
R16+JfXtq0RYuB2Sw1T5JcJuV2/1pTRxtOCbt2GZbiQq905+5MmlqbIcXHgzuU1f7eKkLuiLUZpd
5WD8OcNVc7efQJh92lZP+FhYIe/0+jMKJOSWFqrYI4iJn0hyrCRZUcHBQlmUwNMDSsfLRP43+hW+
wHnZW5R2XeVaKyvBusBZVoPkXdsamuuY3PaA1Aw7u9eT2tThTI44VaXJt6kFrtES2X6LKmx/XTw=
--000000000000743b42065b9b911e--
