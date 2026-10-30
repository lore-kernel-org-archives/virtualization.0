Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360275;
	b=sW9LnSMGaNtskAUSpXQokdjOcL+mK8avuZXEN3isA9OJjiG+ek5UjnND2BCY8Q8ols4Z
	 kBV951g581Tn4j0VoAM+bFMeH6bXbv4xH2nehU6iMQ98hu/lYbAzhHKDFIMIeV37Sqm74
	 qdaPSkzyoIAgRUOa1PcX17+siazXJqCTTlijDlvIamtS/Iuqa8CDEZhquzHMKMRaM3bmh
	 zTSBn0J5uzsAmaBVRt7hj/6GjUNxyrVC9PcYiqASHjz3khSaXo4/ng1fbvclVRipC/OAM
	 zOkxNkIkceDDdPzpXmNy10UoLiCW8z/96UUKyqEwpoTUFZwPN+SKkLBPovKztOOnlMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type;
	bh=2TdFwSLld4QzeN4xCtR7SPOBFqA4szj65Dl45dXunEo=;
	b=DaWpukKOZobxvqL53UKLTE4awkeAj3LkWpCeTdKJL27rGQbSnCPzJFyaJuSfKFvXvVjA
	 8+s4+lhpqIQb9Ir27PR+T5JlN/hLEGrEnP5YElCKxGJyySvtj/Uu6YlOrYslqI0xoq7Iz
	 VA2n+vF7KpsOBnqWrx9xNqncHOLGefs+bfkAJVZeWR0CAkrvzPsOt3XMh2YhkAkqxT8r0
	 hjpnW9AqADmN/KuFqhhS3mdNwl34LKRUy+wW4xuDcRmiPYvgrZwQuwbPwDyNbXE8D4FjJ
	 n+zYo5gMvMP3p1dy/waycX2ottz4J0ckcdqzwTx/7lSkBaIkGyBcUG5st6FifW3vvEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YieL5sv5;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A5606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 11:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 426A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YieL5sv5
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so854851a12.2
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 04:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793360272; x=1793965072; darn=lists.linux.dev;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2TdFwSLld4QzeN4xCtR7SPOBFqA4szj65Dl45dXunEo=;
        b=YieL5sv5i07SZLcnMxcJxoZTVDZ9T+W35d9QPzA1nZg4EB4/VcNYZxrQ2xG5BHnJ+X
         kjch1us608QF1ktZM9B9E2O9pe9sVUhnppAVE9hiWh6Co2MnzVJgUcmwSv2ao4yVYjUR
         LMrUruT5rhnOiCZCjsZv3ZR5ebkFNye+3cV+8AJR1LVW0LHXw7Jt1w5NOSa0daK346qt
         bSr5uRkBKsit6+2Vl0JqHNOCfKz9aT89pO7Hrg4uKokdOCwtBzn28hsKvLah+OGyj8lk
         M04iDht8uWyeBgqIZFqZElSif6G1LUbZvsHZYAqZnXtChsihsyM1JaIHbTPOuyXcroYt
         l5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793360272; x=1793965072;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TdFwSLld4QzeN4xCtR7SPOBFqA4szj65Dl45dXunEo=;
        b=sGWZIrR/vWYWcF7bewpGiTQ4Irw5MPkK9p6u8mKmou4DVoj+HRhVKhhcAkkkKWrA1x
         Ke58IjXfi5XM0eOaVTtrEoq8/PWkOjHc7rmsxHK0hs0v1Z28t55Mday9/wjpO8AIAey6
         HdWd3VG/9PuBczHDYeNKfECPxP/n0McSSeKo1zFdLsQFrKLA5x45m20YoDcKsxSUbcp0
         mmbL7eZ2UFbqQMiBh+jd85qb5JBdbD9kM87yUiWFYwp5OQFmX4TcNrwZPENaljH7sDOR
         OnlVzQWZIcNynvZ71+aYKNgdUjKWFqjGdCG22Y0i446ZIO23q0DQZO0r0zKPhL/f4Y08
         oAZA==
X-Gm-Message-State: AFq9FYL5Aw2iyE949GTXl18mWTAMfnztb3APJBso8bjLUU46WcID5okm
	2rL+pFS0Z6rtKaC9ssKPzgUIgyLryMqIY3g9mNBygORlOn72nzZUpfesVbbZkiMfeGg=
X-Gm-Gg: AYBFou1XalthT6DZ75G5eAjovH0jNaCbY6x8D/RYCBUy6bgk29SsyYfqJ1hdBa6OfUV
	OFwa3XTE2jOlu6IAAduRzvrc/WCPKYGReHi88SRB0e7bnzio81JyXCWtI69VBWmddZz0VVCeFQe
	GWK6V6q+Jq7Db0rN24uNnbJF42Dgalq4nSIKHKZmnlGVr3JdaiIpJzX0BTjpOg3BBhMBYiKGZfx
	qJTNGVVbBGACpzIGSFVImMB2rqeMwUScJPFsiEZyZajUpWPTm5ityfYcObXzKrN55wkbecPkRRp
	lp3bhdh/GwrLHWlRxalTfVKMkDv4jXFTBGkZNF9uVv7ef+X7kGatDICRH6PM/SHO/Anj7BEiFoD
	1xZPEcCC3HNb+c5RqiedSYVCMLx4HBUvdApmd1Q37x61yIkn2ZiHvWLOiiGbhPDuTUvtXz/XqnT
	/WeG/vgQMHXYAWucAHeVCdMiFbFQ8Z27P6/cdN6lRnClMJpmjeEaEexvxI1J2rl5ygwy0ufhTc3
	aDXd8zLgtu5Mr55yIff4RK2WVuJLOHArcACfEyJfvVpNKA4zLoeBA5KAq2u+IYl5KK1FHUfeIa5
	Twa8DvV5BZrmzq4FN4uUaoInhaolrK5gP5mxtdnEp/twF82elcENfB/p+Jli4ZvjNXIu5cIyaux
	45dqk1py2hgMSO7GCdkfJr0y3xG/rWEhmgp06tXqjoRkz2xQvpsP5j6Y=
X-Received: by 2002:a17:907:80b:b0:c2d:be57:f73a with SMTP id a640c23a62f3a-c4ca7a072dcmr182967966b.13.1793360272617;
        Fri, 30 Oct 2026 04:37:52 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cb092c042sm27677566b.82.2026.10.30.04.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 04:37:52 -0700 (PDT)
Message-ID: <f7213045-4605-4655-9c88-ab3cafa0a80f@suse.com>
Date: Fri, 30 Oct 2026 12:37:51 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: paravirt: Mark steal_acc as __initdata
To: Thorsten Blum <blum@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: virtualization@lists.linux.dev, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261030111053.114812-3-blum@kernel.org>
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
In-Reply-To: <20261030111053.114812-3-blum@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2BwsZTx69HSxgfco3oc0Wvi3"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2BwsZTx69HSxgfco3oc0Wvi3
Content-Type: multipart/mixed; boundary="------------Nzr0UlVtZSKudWhbVnfiI9EU";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Thorsten Blum <blum@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: virtualization@lists.linux.dev, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <f7213045-4605-4655-9c88-ab3cafa0a80f@suse.com>
Subject: Re: [PATCH] arm64: paravirt: Mark steal_acc as __initdata
References: <20261030111053.114812-3-blum@kernel.org>
In-Reply-To: <20261030111053.114812-3-blum@kernel.org>

--------------Nzr0UlVtZSKudWhbVnfiI9EU
Content-Type: multipart/mixed; boundary="------------02U2QW2VwF8f3BV2DKooFBr0"

--------------02U2QW2VwF8f3BV2DKooFBr0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMTAuMjYgMTI6MTAsIFRob3JzdGVuIEJsdW0gd3JvdGU6DQo+IHN0ZWFsX2FjYyBp
cyBvbmx5IHdyaXR0ZW4gYnkgcGFyc2Vfbm9fc3RlYWxhY2MoKSBhbmQgcmVhZCBieQ0KPiBw
dl90aW1lX2luaXQoKSwgYm90aCBvZiB3aGljaCBhcmUgX19pbml0IGZ1bmN0aW9ucy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFRob3JzdGVuIEJsdW0gPGJsdW1Aa2VybmVsLm9yZz4NCg0K
UmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVy
Z2VuDQo=
--------------02U2QW2VwF8f3BV2DKooFBr0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------02U2QW2VwF8f3BV2DKooFBr0--

--------------Nzr0UlVtZSKudWhbVnfiI9EU--

--------------2BwsZTx69HSxgfco3oc0Wvi3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmrkgY8FAwAAAAAACgkQsN6d1ii/Ey8d
7gf/d0xlUYSFeFD5bOSurFsAT+L8A5rU1G79UcwL9ZErAMBMWOU/nYlpNzn6eqRIVUp9+l2gLi4f
xndbnOzCWlPF6xEEn835vmRb30jKyilOIgMzJIZ2LXe7DYRiUMvysU5GTI0mOJZ7nkQKZDvmuSCO
5QFcO8eMArtB/Bi3v3bpW6CqzxRoql7UAWKarMBJdLQrSz/okf5dIqy2uQMp/90mrzqR4ZdicmVn
9TSAAjdkWqf3GRB6Y84SaGUjgoJhL6R3xZnWAAKYk7XKHtWCe7AMLo6RU8H5zpbFwPrjHy2E5T5d
59GkECXL9V6MZPiEhIxD5LgVnE1CwHaKRdcje1XAtQ==
=WJpP
-----END PGP SIGNATURE-----

--------------2BwsZTx69HSxgfco3oc0Wvi3--
