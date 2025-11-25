Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5B221DB6
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078248; cv=none; b=h2l7QJuZtzkPwhEVC1KDB17E8dnUBfBw7bE0zXBKoOiV0Xt682t8jt3/fZMfTh1US19GvXIg9Ln6wJ+flDqj/J/NH/mGTRjIcwglGaekq9ccrqKhy2VVGIb8Y4sL0GqiBp46Micxd5z5qRj1T5Of04msNAeuC1hTJTtgFoXktes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078248; c=relaxed/simple;
	bh=+dWttCU3XKRwnEXf00rDPiDKLdfNac3+y3ajrXT0p/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WB29zlXamiEL6/YD+S4EvPqBAGCw7PFc9xnsDe/bIcPx6XeksppBPHCrabN31uiuyAjNU57UZCUhrxEXaG3q26IZAXd8sx6Z+7v04OJJXmaOPxu1L1Zn83DyCVxDGn7MsoKuWUFSor/YIsb9t/oz/MxKCF5gzfemDqYdZBNnioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OTY88bCv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OTY88bCv"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so9167896a12.1
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 05:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764078245; x=1764683045; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+dWttCU3XKRwnEXf00rDPiDKLdfNac3+y3ajrXT0p/g=;
        b=OTY88bCvE1xN+l8pl4T4C4nIYJZpX8RPtMXCghgyAjpz/Ebf391E783iL//bmIIuZ0
         azGp3NKr6Q+86m+NsoWd/1qP3+RObhb9JKfO3ELOrjgF1Mz+wt+ywmsQKXd7FTuRS3Sw
         g6A74jrbxRuCv1ALl8g1wzRni5xEYsg2VeBbX4EeE0YH9AcZaD90Bd3INVfE18xKf2ih
         3cgiIMESin8Pk4FmeXpwLCb2Ls+Z9zPMXphZ8rz+TjNvXEGOwdINPecKZQt2HS1AhDvX
         d8PtkfsB43DgNRJKkICERPKk8oE8EO4PL62vGHZ24mzrzmVSAZcG2Fn584IkXJIHjjqA
         Y5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764078245; x=1764683045;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dWttCU3XKRwnEXf00rDPiDKLdfNac3+y3ajrXT0p/g=;
        b=GKTNhU284XilajlchO3CgbJCdNxjGCfV2GytVEik5LtmaIxBO2dugjGH47PR7KkmRh
         G0GsIuLBNFPmPmTxvZfVV0mnaaNA8S+BrEYBJB6MlD4+q51hkxatyqL4SYyNgY/0eZXo
         RSUTcBijPfSayNpBRXKW3SY15QXDEZ2ImSDezDdY2ix47CnOfAAZR9ofbA6R4/b02UkL
         aq2itd39AC/sVeBLi/wrtrVcmnoVpYeHECsfoEEP5eWi3HfmMSigF48h6U04uqwJm9iB
         hJ8vlAMd9d0x71lu7UH8c0Ul6RyIjX0ULV6tNpM2pUDf91Q99NXL09lwTT/XB0J+W7dk
         64fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzmoUT04Sbr0bSSmRz3D/equEiSvG0M+XCTw6XntJti6+ddLBRxg+HNIBH7r0neFmBx93CULPAq88cKtoN0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDqcc4l3JCY/UZbmZYIXOW7vYFVJavC0ibmr3nLo4EoGuASWX0
	Ad+pWTJPBOWplzCtHEIpkFEfRIKiz7/UxzTPmonw8ykdCtuCITFfyMKVMh0G+fkfG0E=
X-Gm-Gg: ASbGncuidy1ah9sSvZvotwc0KmBv2o+yRYP6O8lziykIP2wOCNp6IXfSQLjWbyzpbps
	OCidB2NT2xxe6CUCwE4GSh1wlK143z6FL5X4fCdxt/PE21w4z2tPOYNXFK+4Hah4B5C3h/BdcDC
	5xdzJfFQltOKW6Oq/Xc4u2b8Szpng0Q6gjZVhGsj04YIA0VxYDGuBph8yMLEtn/xSHMb8QnhcpF
	oB7gqrMm+aRgTHiHaEQASYa8L110EEnYLaVAU6/3Bgc+5yMmc1IQRJtqdbFbjfiR7cWXDHRgqCW
	bx+Zgl4KhfTSjVg0ABompB3GA4BDbYacAE1fagWDxDimPaq9cxt7AJ46SFiY7LBSUniORbQXUKh
	wVd8z2faQ2TDs6tQfPwi9ASYpj/onx6BodQfLBm4LKVtgeAry747jUrmEDLwgR7vAxco9oix38g
	iyBlK8WO8MkffhtnpXNzvuLirf7dftt2YLSD33/ZK6gFixp/s+0WLAwM33ggg3aVHVpcQUqKK5j
	hF40OW7kgB6NHuTPLRVJXIEx9+aLto0PYtcslo+XMf2iMt8+g==
X-Google-Smtp-Source: AGHT+IE8GDsFTtC20Twr514R8S4vbcbwB2dTNWe9tHUlWIkkd4IgRNOjOKyqck+lalp6EnIyxEn3JA==
X-Received: by 2002:a05:6402:274e:b0:641:8644:f87f with SMTP id 4fb4d7f45d1cf-64555cd9bd8mr14739148a12.17.1764078244714;
        Tue, 25 Nov 2025 05:44:04 -0800 (PST)
Received: from ?IPV6:2003:e5:871a:de00:dd24:7204:f00a:bf44? (p200300e5871ade00dd247204f00abf44.dip0.t-ipconnect.de. [2003:e5:871a:de00:dd24:7204:f00a:bf44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b5a46sm15177885a12.8.2025.11.25.05.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 05:44:04 -0800 (PST)
Message-ID: <c9228c34-287e-43be-8d7b-6299b165dd6a@suse.com>
Date: Tue, 25 Nov 2025 14:44:03 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/paravirt: Use XOR r32,r32 to clear register in
 pv_vcpu_is_preempted()
To: Uros Bizjak <ubizjak@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
 virtualization@lists.linux.dev, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20251120191716.124642-1-ubizjak@gmail.com>
 <20251120191716.124642-2-ubizjak@gmail.com>
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
In-Reply-To: <20251120191716.124642-2-ubizjak@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nL0AI1WWneTpPyY0N6T000j2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nL0AI1WWneTpPyY0N6T000j2
Content-Type: multipart/mixed; boundary="------------K220xXVrm3xu9smLqluISTWT";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Uros Bizjak <ubizjak@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
 virtualization@lists.linux.dev, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <c9228c34-287e-43be-8d7b-6299b165dd6a@suse.com>
Subject: Re: [PATCH 2/2] x86/paravirt: Use XOR r32,r32 to clear register in
 pv_vcpu_is_preempted()
References: <20251120191716.124642-1-ubizjak@gmail.com>
 <20251120191716.124642-2-ubizjak@gmail.com>
In-Reply-To: <20251120191716.124642-2-ubizjak@gmail.com>

--------------K220xXVrm3xu9smLqluISTWT
Content-Type: multipart/mixed; boundary="------------BGXsZCFCqTrTYhAI8yoNeF3l"

--------------BGXsZCFCqTrTYhAI8yoNeF3l
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMTEuMjUgMjA6MTUsIFVyb3MgQml6amFrIHdyb3RlOg0KPiB4ODZfNjQgemVybyBl
eHRlbmRzIDMyYml0IG9wZXJhdGlvbnMsIHNvIGZvciA2NGJpdCBvcGVyYW5kcywNCj4gWE9S
IHIzMixyMzIgaXMgZnVuY3Rpb25hbGx5IGVxdWFsIHRvIFhPUiByNjQscjY0LCBidXQgYXZv
aWRzDQo+IGEgUkVYIHByZWZpeCBieXRlIHdoZW4gbGVnYWN5IHJlZ2lzdGVycyBhcmUgdXNl
ZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFVyb3MgQml6amFrIDx1Yml6amFrQGdtYWlsLmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0K
DQpKdWVyZ2VuDQo=
--------------BGXsZCFCqTrTYhAI8yoNeF3l
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------BGXsZCFCqTrTYhAI8yoNeF3l--

--------------K220xXVrm3xu9smLqluISTWT--

--------------nL0AI1WWneTpPyY0N6T000j2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmklsqMFAwAAAAAACgkQsN6d1ii/Ey+g
/wf8DVlgX06UO6Qd1FnvAr3Mo6gswbfOGfKEmTSJb6+R/mg2zKAUsaaAemAVIzGBFQzmRzjB37mC
ANt17y/BFyftTG9uRl7O+jNVV6oa1/q4oariR+xBTcMYL05xv/2ltorIB6IkSx1qXyIV7JUIVf1V
q7nJzoPzLUMo43GieUPUEKeyhqEn1E63Fcsi5zFroyngSHyaF2JLdJTTmq3u+35j0VQFi72s/Bfa
s+kZ25yjJ/fkSISjIl+Slas9SBb9hhLbBTcIhM/nKUJXod1V/Wi08pO2bOcl8nxCptG60HXC2buC
FapKxQNCqnrZbHXX/r9t3ccu+xQRmVPwjZdJymbL9g==
=7ZPT
-----END PGP SIGNATURE-----

--------------nL0AI1WWneTpPyY0N6T000j2--
