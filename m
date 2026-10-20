Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524215;
	b=XS7/HlWfRW7ylhz7eJYRiqJ0fG329gJDDgrJlafmOeCUfi79Nv/oXomi7HdkCCS16GBt
	 tNaM81osqSUVp27iaMD6mshoftKPOd1atjoDM/E0sieqmpHpr5dUUg8YnQ/+J2xuQ3XVs
	 p2CNISyQ+8SBKwiQxRoqstft9PRSuiT1pM9dO9O98pM0+QzrzAtujyGB7gDfARp3YfHPY
	 ZpUX9WL8UtC8p6QPXSZljRbvDozcLSr6aTKn6NTLXatiSnccdyBaxSJzjmvSmUNlJVcNi
	 7WbAN93iYGCJ3l2TzbbjdOI1Nj23VYZzUqiBjTmYvGAj2NES35C/TFC7vDDXY8A2dOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524215;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=toEd0+/BC8CS9eO0qyu/yWx27eV1WIUAXnhJnuX/Kq0=;
	b=hrQZw+x4sLm2rGI8WrhJBE1z5HgZnQCFdsda4h8Qt039UGKhBxlaVqu+OJr4/U5JrAUg
	 GJx+W6SLK7yzH+bBEOBV3wFNjz1OUDyRxGoJywHrtLso+dQvrEWyKviJOYcWODTlengCt
	 CTiyZTAvjJnmRyBz/xuQG/OkLLTwV0UE/GEGXj1X7RJlss4TPXZYTTqRn4r2qLZhgShpD
	 y4l5oMphrqbtvQ1lj3yXeu/jKaFb78IcdsxIrf37Jq2o0YR1yChufqSFgBQk9eAGWC94M
	 oUGWaOX6FM4PjOidsaiIW+zVjlErPrIepkXxnYDmtUo0aeqESCqqeb0gONTtiTaV+5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hzPj3brt;
	arc=none smtp.remote-ip=209.85.161.100
Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0262606A31E
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 19:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0262606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hzPj3brt
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-6f74f6b46abso1835966eaf.0
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792524213; x=1793129013;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=toEd0+/BC8CS9eO0qyu/yWx27eV1WIUAXnhJnuX/Kq0=;
        b=KKexDpI7uVi9JzaZafoa3GqBZrQqGMNOxxgrZF4VEJXs49FrcrDoBlFBHF+NH7pYrF
         DakK1lwHG2Sb8+38nkyHKq09tZrttAjZNaEIVMjPRtClaOxgjOW4DXjlw1QHafJ235Ov
         FbJgaKY+1PzONGyR8oTxnP1wT2qsSmtfULM7nswx/nAozOQGq6etfUrZCdvaH8GOQmt8
         xRCbb80ag40l9yVvMCS7ILArPbQqXymF2kK6cH14Ye1UMc5HXjBVFSWGAry9dajUWkOC
         5vGYp6syYKtLrM+E2fWy9nnid/o1pqA1UlsAsDq9F8K/AHxzebiPoitgmdG7eClCHZuw
         qe0Q==
X-Forwarded-Encrypted: i=1; AKwUvBw8i1dhIaHcPbepen28hl6npkGM5Y02szksGpbrIAEHaMuhvyzbB5x696ORJj5KhSPUGHH+6FW5oWejQZIJ4Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLxaCtuzCF4qh6lYNQEXRjVXGCSZUr3NrchtDoOqK3mYByF0GiQ
	TmSYCAgJYODFmtVVQ9FfN3uDXQFVq+qorWRgqPSSAM7dKdRzsnOmRrJfaRjwbrNZnJpll7qeaWx
	NvONY9NRGfQW1rVw1FESFj4neT1orYhvCisDmcDzxJND/z8Hbfg2VMmT0OiwrhUzaa4DtHIXTjJ
	yHryUKM7SSxEdQWnmYntvgZBElErRBFbdxqKfx8GeeXdgT6XP5By9ygSuZLENB3OKKRTRJgR1RN
	sgq101vxvFTTmJe2mQ=
X-Gm-Gg: AYBFou1j8fdjMplbXgipodj74PS4odBmKPuQy6cOVmZJiLQTsW29hBvEJY93Jx9Z10R
	7PluU49ZHXGr2LHHBgOnu/9kKfQxBypiRpDfAWc5uDFrWJvGL+tm+MDFGOENMSE9/1kKRHCelYX
	W3b9eZQK03RmkTXBc4Nu2Dmd9qEBI+JdfeefC9u3r2i+J1lKrnrRXuThUSIvTXAqZEAKEvOzzqV
	M9Q9mi9+YMN3Z102LVVXIRxSASJcw4jTNSQ4hzsNt4e+KF/uEDJbxYp6DUAUdbaHqEmGpBYSc4X
	ba/db6D8TcW6tG8breql5/FffKqM7++X7tJCcW+yJoxYzhXxjJqPyA6xltB64vusiWEWH0UrhU5
	2Or4i4dpbjLFNessN/M1F5UkBhAxKQNTjQbsvmotUdR3Dk0ENlfSZXDJ0vq+EpngFWPgFV7ZgGx
	0wOss1wV/a1IgCnV4azKpeNXgQq/pZzlmT
X-Received: by 2002:a05:6820:341a:10b0:6cd:3ffc:ad05 with SMTP id 006d021491bc7-70358193bdamr5731679eaf.85.1792524213271;
        Tue, 20 Oct 2026 12:23:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-84cbcce0187sm3483a34.10.2026.10.20.12.23.31
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 12:23:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5ba4284e23eso2335175e87.2
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792524210; x=1793129010; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=toEd0+/BC8CS9eO0qyu/yWx27eV1WIUAXnhJnuX/Kq0=;
        b=hzPj3brtwJJ/JMOeSUTfKb9L4gekPgvFvbEt6TN4+PzEhnD6yV64UE39u4AVSrXZ8o
         f55LCDjd5wgtUrWknhUYiNcKBf8s3sTxJnHPyytrp9azvnsc9vdrU2kajiZfbvMOg2Gn
         MhCDLVrHHPJb9ZLZS9CzaMrwDxWaERggvI9Dk=
X-Forwarded-Encrypted: i=1; AKwUvBy/5QHld52cXfzzt87nN8RWXE4m98AYa0ue+n2fLKqFRK5303gw1NqjDFr50gUXYzofstxAhcBPgo9Pd11Sjg==@lists.linux.dev
X-Received: by 2002:a05:6512:a91:b0:5bc:d39d:b451 with SMTP id 2adb3069b0e04-5be509f6638mr4064203e87.9.1792524210044;
        Tue, 20 Oct 2026 12:23:30 -0700 (PDT)
X-Received: by 2002:a05:6512:a91:b0:5bc:d39d:b451 with SMTP id
 2adb3069b0e04-5be509f6638mr4064176e87.9.1792524209462; Tue, 20 Oct 2026
 12:23:29 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <cover.1790014793.git.zack.rusin@broadcom.com> <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
 <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com> <atdYIxwz8ksYNty6@pathway.suse.cz>
 <atd7GInNurGWLUha@pathway.suse.cz> <ateYxCu63pRY9EGq@pathway.suse.cz>
In-Reply-To: <ateYxCu63pRY9EGq@pathway.suse.cz>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 20 Oct 2026 15:23:15 -0400
X-Gm-Features: AclHuK9M32-EdHA1PszLB6Y1IscuEU7zjL5tmXKU0jHcFstdblGuIKRQsty0q34
Message-ID: <CABQX2QOKCpoUY_ObhFif7xN7OF-NzcxEM0JABAXo9n9KaacO7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] panic: Add a notifier chain for pre-kdump callbacks
To: Petr Mladek <pmladek@suse.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Borislav Petkov <bp@alien8.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, x86@kernel.org, 
	Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev, 
	Dave Young <ruirui.yang@linux.dev>, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, John Ogness <john.ogness@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Bo Gan <bo.gan@broadcom.com>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, 
	kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Michael Kelley <mhklinux@outlook.com>, Ian Forbes <ian.forbes@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d46df0065e4a9050"

--000000000000d46df0065e4a9050
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Petr.

First of all I really appreciate you going over this. Thanks!

On Tue, Oct 20, 2026 at 12:37=E2=80=AFPM Petr Mladek <pmladek@suse.com> wro=
te:
> Approach B: Three lists: platform, smp_safe, and smp_unsafe()
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> It is similar to approach A. We would just add an extra:
>
>      + panic_notifiers_platform_list
>      + disable_panic_notifiers_platform_list
>
> This list would be used for smp-safe notifiers which are
> required be some platform. It would be the notifiers which
> are crucial. Which are currently the reason to set
> "_crash_kexec_post_notifiers".
>
> It might be called also when __crash_kexec() is called
> outside panic().
[...]
> This patchset, adding vmware_log_notifier, might implement just
> the panic_notifiers_platform_list. The rest might be
> added by another volunteer.
>
> How does this sounds, please?

That sounds good to me. For v3 I'd do just the platform list:

- One call in vpanic(), right after kgdb_panic() and before the first
__crash_kexec(), whatever crash_kexec_post_notifiers is set to. The
list runs before kdump and before the other CPUs are stopped.
- One call in __crash_kexec(), after it has taken the kexec lock,
found a crash image and saved the registers, for paths that enter
kdump without panic(), like oops_end() or Hyper-V's hv_crash_handle().
Once the early panic call has run the list, the guard makes this one a
no-op. That removes the dependence on crash_kexec_post_notifiers you
pointed out before.
- A once-only guard shared by both, so the list also runs only once
when a callback panics.
- disable_panic_notifiers_platform_list as a boot and runtime switch,
checked in the same helper, replacing panic_pre_kdump_postpone.
- Kernel-doc with your definition: smp-safe callbacks a platform
needs, which would otherwise be a reason to set
crash_kexec_post_notifiers.

Roughly:
        kgdb_panic(buf);

        panic_notify_platform();

        if (!_crash_kexec_post_notifiers)
                __crash_kexec(NULL);

and in __crash_kexec():

        crash_setup_regs(&fixed_regs, regs);
        /* Direct entry outside panic() */
        panic_notify_platform();
        crash_save_vmcoreinfo();

I'd keep the second call in __crash_kexec() rather than crash_kexec(),
because afaict crash_kexec() can return without a crash image, e.g.
from the BPF kfunc, or from oops_end() before it panics. Calling the
list there would use up the guard even when no kdump follows.

crash_kexec_post_notifiers, the existing list and the kmsg dumpers
stay as they are, and moving other platforms over can come later.

The VMware log copy would be the only user, and it's still best-effort
diagnostics: kdump and the reboot don't depend on it. It copies the
log tail into an 8 KiB buffer. On panic() that happens after the panic
message and any local backtrace; on direct entry from an oops, after
the exception output. With the list enabled throughout, the copy
precedes the later panic notifiers, sys_info() and the all-CPU
backtrace step. The guest-crash report stays a late kmsg dumper that's
skipped while a crash kernel is loaded, because the host can power off
the VM inside that call.

If that matches what you had in mind, I'll do it that way in v3.

Guilherme, Stephen, Baoquan, does that work for you too?

z

--000000000000d46df0065e4a9050
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJgn
CNxVL33+iqpOJLjSQE+fI6/B7+bT9NdTrK/5e0egMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAyMDE5MjMzMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABXeJ4Zi7Hx37m/4xuENMuaBIjI5g8sV098DSsuq
GGOgFSRS+bPdWT+JQ5Th/CRo3u1z6eeXt3O18LZ2WHsM7+gUEGWy2LigXj16/Vkx7Wf6bIJ7OGyM
gvgMvpksvF0e8Er257K13eJFI8y1wyIM9EjupE87WC0j6Qrso26z6FVa4oCd/WIQj6LmheoX6BiI
4uqtLF21GGeLkrrv/qVwvyNXTsCZlii5gIifsGkS1Wu4/p1Q3YKmXStgF8+LfwpsBnWKCAoU59+U
DzxSNhTpQDkXXuTb+stS9jFKvjaPK3Dks11VMG88eqDfHIw71W2iGOuYqt/iCDJAGZhokJecljo=
--000000000000d46df0065e4a9050--
