Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146ED305053
	for <virtualization@lists.linux.dev>; Wed,  3 Dec 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777370; cv=none; b=l6Fl3uH6bYqIYEBX5Z826lyhBvL0lqT/ISIhI2Sw0tTu/ei6y8Y8RLkITy2nC+BxqsG03m/PeDqwBtxZST+PpP8NlqgrqMRih/RZrg3nLcFhma4MW6taeF+SlWsNfO16WZ9441pazXQH7ONRfVgWrxA5fY5ba7RgXARUwvvH4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777370; c=relaxed/simple;
	bh=rGwUVR+Yo8u1COwzMDod6hKjMoB7taY0GEiWuVQTc1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hitVCEdfZnw0jzliSEo6Q0Fg/84YR/+CvFT4kQbZf9aWGpJner8Nu8+fZEsuSjeHCjGHdLAONFaTxHjNbyKY3PVVg2s1EjACzIu66mO0YYiZ7C5SItL6IvF4ExJQ8sgy5pQ6as5ugSPlf9HJUyZ6uhqwAB1V6Op9XvmBtnbwOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fYUGSnVG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fYUGSnVG"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-645a13e2b17so4375936a12.2
        for <virtualization@lists.linux.dev>; Wed, 03 Dec 2025 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764777363; x=1765382163; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rGwUVR+Yo8u1COwzMDod6hKjMoB7taY0GEiWuVQTc1o=;
        b=fYUGSnVG/ZO1uFxLDtmcFkJNoU07RhEQPD1uxmeAU1M6KhK0XmV4Q27MVEw6d4IolH
         1DBGQMEfaMdwfXFqIfg/QSdfxTlAKf2nFsE+rQQWVDv8IxE5EYM4jOGj1AFZzO2KDiGB
         HbAkc9n4Rv5DBfYoazaS67r0rT7kvreuz4aiIcwO0YxOGw0lluEm7Oyvp4sN9wvOdKR9
         IyPvXOuT0qKaz44M2zUaX0mOqvOlx858QXO9E9aBe3Dm5zqmZ3C3y4tGpn2fGyzyO6P9
         /3s4vt8Sxvjhjn6G6rRpNiU01SvxcL/Wv9mgrMO5uVNoK/hLET2Z/owcCzmSbQhU/xhg
         Wbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764777363; x=1765382163;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGwUVR+Yo8u1COwzMDod6hKjMoB7taY0GEiWuVQTc1o=;
        b=fqKzEUofuSMJElADC2gQJ07BkC0RH4OMZh7412vbUZkr0RBdbMeW1VZ30ZbXW7vYJr
         G4ktfsBONv7s9EH95YqTnja2Agr8+n68Pb5XyJXvFEuui7gOoPnwzDm420qRf9yUtC7y
         43+STWpI72A+dODIzL8g0cUmQvGNWKACSj9VTp8pjBedoQnPw3pMru7PAOHBg8TYtUFv
         wUz7cOMQvo9GcLLQH8z8OeEyvdFdS8nNXwEne69eoVOK50WsXCLin8aZF+t1b4n5R4NB
         c3bCyJAokr60wWiZW442IrkhW9zi9n7Bgc1XtUnC9tTtd04BMZlpSc94uf/MKEj3uBCe
         tDlA==
X-Forwarded-Encrypted: i=1; AJvYcCXadqwPTwRq9lQf1Kb21LizHWX0oiDtO7GgDrfmNsO4aEN+yfj6DWmXAAPAydQDU/LRBWyG+ELKRjopMqHDfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNfBjiDWMc7HxqYrgYfCbyevz819uVu/XusI5FvjpUw4BbGijZ
	BxKuy/uuAwfhyVz+Wb1h/e5BuYQb7rrxIrA8teUQ/1Y7m2a6OGs0Bu8251G7v1A9qm5Ko+IByM4
	h2nPvGzs=
X-Gm-Gg: ASbGncu+elIMlwt16TQPFY8noYPFLZewrtA3aDgSaoWtzCrOTMchnB7qnVx1SwYxVnV
	57TlPtV3IcGEA6SbAnXSebYoa1Tny2IPniXNCdovk1uwDWPFZXIHS1o/k0H8LOMeUHYW9llk4Dr
	Yy+3IjzWPBxQNDemNuXMNGwlRCNerd6/2moKZXP2txB0psgKxeKF+Z8uOrsJX8Se5Pzt0J51Olz
	7T1/hgXBhL5tML0xa0y84JI0qe6oUzLJKD9LpC8yuaLaTaeeEIanLr9VyX6ERjaAcCGzblWV29p
	wuRjXJ0XeremTBPDlqGUfPuE73Aqx13JbViz6xU8dnADEEbqEhnfLkrx/zxd0HxZlUx+PG/UywI
	tuCImFXj+iW5rPRS6NYczNiUoXTtIH1W9CEDleX8W1h6e/QqK6ARkM4L/7G2SGYzru9MbKPMYnb
	urlne8XzVrD2F1wJXN7EcQAiCDnMgz9Hv+ELJWLQf4Zm9RTL2C9wIKiaL9RACyK9ADUCeOyQeBu
	miQNmxSdt5SrqpvxZGcP1kC1mxIDUEjW4/Ng5VJL1UtCNg=
X-Google-Smtp-Source: AGHT+IFzMoHXMvPnvPGUzvn/vx6+nfEiLoC9s5Ug4YFQdJmhDa4LIG8rBroQF9b6s48OOMZFczAzww==
X-Received: by 2002:a05:6402:3490:b0:645:dc63:d467 with SMTP id 4fb4d7f45d1cf-6479c4d07f2mr2302837a12.31.1764777363026;
        Wed, 03 Dec 2025 07:56:03 -0800 (PST)
Received: from ?IPV6:2003:e5:8721:bb00:9139:4e25:a543:997? (p200300e58721bb0091394e25a5430997.dip0.t-ipconnect.de. [2003:e5:8721:bb00:9139:4e25:a543:997])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510615c0sm18955089a12.30.2025.12.03.07.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 07:56:02 -0800 (PST)
Message-ID: <032a028f-9fe5-4839-a596-f4e6317d7946@suse.com>
Date: Wed, 3 Dec 2025 16:56:01 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] LoongArch: Add paravirt support with
 vcpu_is_preempted() in guest side
To: Bibo Mao <maobibo@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
References: <20251202024833.1714363-1-maobibo@loongson.cn>
 <20251202024833.1714363-3-maobibo@loongson.cn>
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
In-Reply-To: <20251202024833.1714363-3-maobibo@loongson.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EZw1MvBXaSvkPDo4EOD01VVW"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EZw1MvBXaSvkPDo4EOD01VVW
Content-Type: multipart/mixed; boundary="------------a5fJUwHmYWdNLGNpd1wdClpm";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Bibo Mao <maobibo@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Message-ID: <032a028f-9fe5-4839-a596-f4e6317d7946@suse.com>
Subject: Re: [PATCH v3 2/2] LoongArch: Add paravirt support with
 vcpu_is_preempted() in guest side
References: <20251202024833.1714363-1-maobibo@loongson.cn>
 <20251202024833.1714363-3-maobibo@loongson.cn>
In-Reply-To: <20251202024833.1714363-3-maobibo@loongson.cn>

--------------a5fJUwHmYWdNLGNpd1wdClpm
Content-Type: multipart/mixed; boundary="------------K000PKIClv4O3gxWiudeC0FG"

--------------K000PKIClv4O3gxWiudeC0FG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMTIuMjUgMDM6NDgsIEJpYm8gTWFvIHdyb3RlOg0KPiBGdW5jdGlvbiB2Y3B1X2lz
X3ByZWVtcHRlZCgpIGlzIHVzZWQgdG8gY2hlY2sgd2hldGhlciB2Q1BVIGlzIHByZWVtcHRl
ZA0KPiBvciBub3QuIEhlcmUgYWRkIGltcGxlbWVudGF0aW9uIHdpdGggdmNwdV9pc19wcmVl
bXB0ZWQoKSB3aGVuIG9wdGlvbg0KPiBDT05GSUdfUEFSQVZJUlQgaXMgZW5hYmxlZC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEJpYm8gTWFvIDxtYW9iaWJvQGxvb25nc29uLmNuPg0KDQpB
Y2tlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4N
Cg==
--------------K000PKIClv4O3gxWiudeC0FG
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------K000PKIClv4O3gxWiudeC0FG--

--------------a5fJUwHmYWdNLGNpd1wdClpm--

--------------EZw1MvBXaSvkPDo4EOD01VVW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmkwXZEFAwAAAAAACgkQsN6d1ii/Ey/A
6gf+OzJ1GuN+i4gYgw0rrRsFkDE/iIZ8rlg42muTU7O5Tzj6EbOcKdgP3hhuMhwAUvSdnaGzSJfL
K5hTIUpAfhOzdDwf4e3Rn8vzQ8v1iWjDHn4K9bcwWLtNBCho22cW/7tJNvD6f+JFHzinFQKXcb0W
9z2VLGlEqA+4DaMysNBzgBM7h8gIqnOUgUv2v7AyuPRtNj5aytgVzcqkmBOQRN0VRlHtZbtV43Bn
5CnrZzSkIsNC1cd6C9t/7GIyjNGR6O/3eCx0oWVFhDJ4N9ljeB6N8dYl1d12s6Pv8qI9YTfUkdA7
Q//lMusSKlMF2p8IjOK1oMgATLlqclqubyE/llgPaQ==
=n+FE
-----END PGP SIGNATURE-----

--------------EZw1MvBXaSvkPDo4EOD01VVW--
