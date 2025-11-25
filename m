Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FAC221DB6
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078207; cv=none; b=SIRLIz45EiPExPx7lolw0bThERg5Wz+y5Lu0Gb8+zuj2idLdpR9obl/5rJ+wso6+zfDDlUlhL8BEJSzZKtJBEsu4KcUb1oKNtpF9QrFiAjtn9r200E2RJkzqAbD7He1FvQZNpAd0NflBJJq2uUZrxvJPyeZ5xhCXlTMFevlo3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078207; c=relaxed/simple;
	bh=+Y1v7sCggB8kCzsqN2mZDt51Jg55DMtOvzPXpKu+JKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/9Q1Ap5F8H24d6vFaiwITSoVjYibWABa7fu3nWLPKfLwpflY9s6V5atR7Cbe2x6bG4ATMT72kg2Ugy23LVT3Pw32Sa+L8PSYZjd9bAB0yzbA1ip9Jhxd/rI5oLmt0tJLamF9vUDEcCQb5U9AbZSUGKDegQLM+bsS4OE51ulAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UQNwOxih; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UQNwOxih"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b737502f77bso791864966b.2
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 05:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764078204; x=1764683004; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Y1v7sCggB8kCzsqN2mZDt51Jg55DMtOvzPXpKu+JKY=;
        b=UQNwOxihbBZcsKcmupmEGVZlc30cNJynp/rM018a1OOmpblld8jj+HcwyH8EuJMwaN
         Wk8qC98JrUb8poSE5Gzly1iLmVD//dyEfGiv5j0rW3NWAlFakUi7SWq6l3SjHLsDIKwZ
         5KJFz1qbc/1BVQA0YHHVFchMuYLasct5H9sHr2ACbKdof8ijme0Lm96xa/LCZhkCQjCw
         spfZfVAQVuPAtEYHp4k+Y0Ev4M90ERyFi8TM4g5ifUkPeJJox8seBoyh4RvPYQzv/jRw
         STQyqueG9cTEuuxB06mN1wFFdmjMY4lKA4QXhsx9VU56kF27HmsB/mCrmg6wk7zOlc6S
         GUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764078204; x=1764683004;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Y1v7sCggB8kCzsqN2mZDt51Jg55DMtOvzPXpKu+JKY=;
        b=QvSwMG1DeFf6Um3zrh1IzmHyAzbasCE+9Swi9kJCsmE/tpJGjWf5C09yg8ukxRwGoe
         TjMyeQENdeIO+95l8LcZhrbgLXgmHEDd6fvaT4SE4uFDGbABzxS4/X2zCJzzBIGWNaOs
         TLHwguYCCyOR6I0rU73snPhDbpUWhYPg6Mj/QXf3oV3agXZ69c686l3oRMhRMLKldNJC
         eJrSjbLZHMx5oet7ftaxtqJy+WUiCMTDsUh+1bn4lS2q2wxBdHd+jJykehH1zEklh054
         2F+G0h5+msKmL4Q1KfNFex3yk063INiahMzEdzZlJ86y0XcCVGS2A6GMhTY/J7Gk9ijl
         jnng==
X-Forwarded-Encrypted: i=1; AJvYcCW2o2uX19ZGlWIK1HY4CsVMAaBpSsioszd75PkFhlRZ8+IoZ7JAVZgBHH34Pi7cRi0sEXSiZempc4QMfFrmeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWbGPzk7J76/L7kvBqVBAyjgQ98fQo/ayWJ7UKb56P5jsApndT
	VpPyZvqnJ9zqT5M8Zk8qCpjuVnH2cDjpUucmbB+2esQMwWdWSIJzB8YA1I2iaE/Ae+c=
X-Gm-Gg: ASbGncukLO+mtKbmgSiABYH05K74yxc2xONL8G2FzdC6p7JRacAA8G5S2zG9aEsajoj
	pVBb2IB9eL0oDt6JgFcQFfffcu9Hr6m+rVWNKi24IZQJ8tlx5anoQQtkXSGaDqxKSZf7aSBdn9F
	7SqQz408ojz/O8tW8kS6hfGB+jwb16G99NkCYkv/PYhR2haUlZH7AzM7kGAZzW2V1INVER3n8GY
	MH4+A69kEQpVBfPvVUfXlgWnphKbstPvc3pHvQNRnlgYtNBpglgag65XvdySyJUOy+EU2BUIN4t
	OnSoJ82E3CJp9IwTqo9jKWgyTCkndONcP5G7cBPFZY3vE4yUA3CymAUPQ7Ts8Tz6yV7D2JVaxfy
	MsM5D2Tyi32iNt24PpMhuhod+R55kW74XNd0HIK4C7Cu1vL7yTSziVnzdj0qq2PaIGLGK51J1Mw
	Vh+P1cCB4Bnr4yrkjI8yruNIWzSK6+zf15pDBkCA+P4L6tQ6tGEX/AVdrnFOtfP718Ar3CYpNm4
	UMNcZlqOlHWn5vmK1+UnyawfYYIcVeMXzqsfM8=
X-Google-Smtp-Source: AGHT+IFvnJTZzpY+oPO0dpqEF5XBkCpe6TdYm0tZj5OI0PaktJVwIJMYDwEJFQ9dKG5pfNivM6WlVA==
X-Received: by 2002:a17:907:3e14:b0:b76:6c85:9b60 with SMTP id a640c23a62f3a-b76c50c2412mr248883566b.0.1764078203982;
        Tue, 25 Nov 2025 05:43:23 -0800 (PST)
Received: from ?IPV6:2003:e5:871a:de00:dd24:7204:f00a:bf44? (p200300e5871ade00dd247204f00abf44.dip0.t-ipconnect.de. [2003:e5:871a:de00:dd24:7204:f00a:bf44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d50328sm1618009466b.20.2025.11.25.05.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 05:43:23 -0800 (PST)
Message-ID: <d129cb1e-38b8-4e44-b6a4-f408cfa3427a@suse.com>
Date: Tue, 25 Nov 2025 14:43:22 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/paravirt: Remove trailing semicolons from
 alternative asm templates
To: Uros Bizjak <ubizjak@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
 virtualization@lists.linux.dev, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20251120191716.124642-1-ubizjak@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20251120191716.124642-1-ubizjak@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0GJuKqzROFSz9dQqhlq0fYOU"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0GJuKqzROFSz9dQqhlq0fYOU
Content-Type: multipart/mixed; boundary="------------F6nMHD0hL40I8I13uu8iviJW";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Uros Bizjak <ubizjak@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
 virtualization@lists.linux.dev, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <d129cb1e-38b8-4e44-b6a4-f408cfa3427a@suse.com>
Subject: Re: [PATCH 1/2] x86/paravirt: Remove trailing semicolons from
 alternative asm templates
References: <20251120191716.124642-1-ubizjak@gmail.com>
In-Reply-To: <20251120191716.124642-1-ubizjak@gmail.com>

--------------F6nMHD0hL40I8I13uu8iviJW
Content-Type: multipart/mixed; boundary="------------yPtyD0wUt3hOBE1K5s1d0BWw"

--------------yPtyD0wUt3hOBE1K5s1d0BWw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMTEuMjUgMjA6MTUsIFVyb3MgQml6amFrIHdyb3RlOg0KPiBHQ0MgaW5saW5lIGFz
bSB0cmVhdHMgc2VtaWNvbG9ucyBhcyBpbnN0cnVjdGlvbiBzZXBhcmF0b3JzLCBzbyBhDQo+
IHNlbWljb2xvbiBhZnRlciB0aGUgbGFzdCBpbnN0cnVjdGlvbiBpcyBub3QgcmVxdWlyZWQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBVcm9zIEJpemphayA8dWJpempha0BnbWFpbC5jb20+
DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0K
SnVlcmdlbg0K
--------------yPtyD0wUt3hOBE1K5s1d0BWw
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------yPtyD0wUt3hOBE1K5s1d0BWw--

--------------F6nMHD0hL40I8I13uu8iviJW--

--------------0GJuKqzROFSz9dQqhlq0fYOU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmklsnsFAwAAAAAACgkQsN6d1ii/Ey80
NQf9H5v9a9Y8yBSWoKDCD/f1zCaqiY2db393LEhbcqifrvbJYOlDkykj63kfNS520muCi84X5Luc
UvEQp+B47FYFCsy4UDG75fhppJljsdzW8MeHXvrRO7i/egrrrcBbpUwhK03CHU4G8cPhRysH3LMA
DRA+gFAQjiweRbYzkBKT15prH/CwARs0LS3jo9sG9mdZg0DLdmypMfiZ80UzS2jPqhMPneL3qr7T
SOSkqUkukagQU3jL0ka0ntcdcWq80hrDGlGVfC69ack+4U4y87BMHgXJUD8KpiJkW0ie4e1Bj0MB
Iudd2tTyOPwETS4xvLk4Ye4nnal4yhPDlalCVFP8qQ==
=FkD8
-----END PGP SIGNATURE-----

--------------0GJuKqzROFSz9dQqhlq0fYOU--
