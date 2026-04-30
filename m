Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0858639FCA2
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533638; cv=none; b=CdW/yXTfkKK/wsAbCrz4YC9ZhCSE8ZyCEETcVs2KL/pJXU4SIOMb+FOnAsIglpQ8nOILWX5gvy6Mw2AOmH4QzekE8n+K5j7ZOsZMoCoAZLgdVu2rvt6B6r02zNMNMmk5j63YaNYOy+isGBQ4DR6siUv/sySAF5rnDj6NX0pUpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533638; c=relaxed/simple;
	bh=Ads+3QxyeYiGlOBEWPgPsqxI6HlLrvSPwPz5KOdmWVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSM+ppQP8yrVT5hAZ1x9rgN7TnRqqm5QsqkF6pfk91iwbf6gG9OeQ0HEdeU2atLKyxszxyIbSjy3xlAVXK5ofSKSwrSd4SYCV4J7z1EyQiW8ipFsu7CLQwAVDkjXGrGcr9xvK7mxxsAu6hSWC2rXyfph8RFcf20/NIruzw7mMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cVzJPCpM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cVzJPCpM"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-baa8c78ac7fso75978266b.0
        for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777533635; x=1778138435; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ads+3QxyeYiGlOBEWPgPsqxI6HlLrvSPwPz5KOdmWVs=;
        b=cVzJPCpMRbdSZvb4ok56BgxI/fqcCpbDNqZKN7N7IbEOlNwJaBUJSoKKX/kfv6v6su
         YhL7TMUeMw4rFvkcuqK1F3S6OYh5E8JXMI1Oa17GhYXk14BCyPxq4RdOaHFIWlXveBDk
         YhMHcsMlucGNLq73ZkBBokWag3sfLx/S5zjC/6UvIKwQnN5TvGOlMK6SKhURAuaY+w5R
         4wIaYvVSyNFA7ZkEkRcnfRD7VyRt5NJlGz+hDmMt33fsUd3ahO2DKB12Dl4AtI9D019A
         HTdZqWx9WYgeRGLKlsJnGwcQnHRBLU8pUVDDiUd45ifVDCbxQokvW6CR0QO9a5RpJU6T
         yDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777533635; x=1778138435;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ads+3QxyeYiGlOBEWPgPsqxI6HlLrvSPwPz5KOdmWVs=;
        b=M8hJ/YDrEW8JtFCIvZZtaUaHashwHthJTWY8/0MiqHKa+Dl29LnBrONOWyvDJnuiDX
         3Fz2uQJM0Neao+UlVsHB8A9IZs0i0H2WH3rEK/bXiN0lRy3jZbHl4WYw1Nsm+QksUaKL
         luWsPYYR02BkZg3sIdw9YboY+r/NbW/trSbfFq8PZIb5iqtXTUncd/5CWC8Igdso3a0s
         xdRbtG0zCpZT5oraujzs4AMYiXl05sWUXEvP4zowB7zwXszQswkODYB3pl1kdTLjEcKT
         qN3+W6ukENUQYDTZnk7jAVa/DclUjojO79QczJU7MBGBD4bw7KwYoNVB3XyzZNxOJOdM
         9jGA==
X-Forwarded-Encrypted: i=1; AFNElJ9eJVrbBU6lh0NqOhCJb6RF6Ou7E9rq1blqKL0a4zuuD3mWSeQ24SgIkkJiItv5tgnrW/p5DEIsPY3/ro4bXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpGbq/kMXj+/6q1snBsqANJqN9Hw6f8fbG66yVw6n6lEk2iTtb
	WErH56Y8b2fz+qWReA3fmawCqvxcf9WJ3qHuRGIuknqgJJN08AKTs3LrTwlOq7ADml0=
X-Gm-Gg: AeBDieuUdn1m6ZuLbxww43veGOpz1yqwLTmzf0ueCH04jcYoQbBg9xyU30bVZg4/WCF
	r40G6sdaVqz8W6UuzWAqfC5JDCgfVVw4I6UguTubY6+4/qqK70WNwz6b60coaomJG+qzh15GOHU
	cB6a6+ZLH5LhEZ9iu3EtY9eJADOXmCLkFXRjjURDYZd308xz7W6hXiLx1rGXnNZZ/XrTPArkWz7
	NQCsA7vepZbkwqytE9IBHp6S9vJIpiIJzanIHrpF3Ruf80z9R70VzN7M8JE3lOPmrJ/3UEru7DW
	D9ZfYWZ53IB+1g+usIaXmMSvdYSxhnAsXSkByB3TNUqjYKaRFMIM6Y1fvr59KVZzJhXpkLDJ+xm
	W6RzdcWBjB9uunjm8M17C/OVQR6e8fkuzu0m7NgYVnYdTOW/EnmrnmZBDBsQUN8dWcJH0Tuk3lI
	HN4o1f4slLCZAfNZW1N9s9qNizsgBsb8E7EAlUXEUdcde582AiOXFoze45zxLUIZyuBllmNUmwk
	CMwEYr0a6fwPfb+O9Nr+RQ6masdbh5STR7dgQYLDHFay4NcpoZUFYuQ2dpJMi+Z
X-Received: by 2002:a17:906:f59f:b0:baa:3cf6:4f53 with SMTP id a640c23a62f3a-bbac4cd24e8mr96501966b.5.1777533631909;
        Thu, 30 Apr 2026 00:20:31 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb9859381f1sm195133066b.46.2026.04.30.00.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 00:20:31 -0700 (PDT)
Message-ID: <5bd029fe-35ee-4bbc-8e05-0df8c4125b6a@suse.com>
Date: Thu, 30 Apr 2026 09:20:31 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] x86/msr: Remove duplicate #include
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 virtualization@lists.linux.dev
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <20260429184530.9FE585E8@davehans-spike.ostc.intel.com>
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
In-Reply-To: <20260429184530.9FE585E8@davehans-spike.ostc.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bDevfDxIoFmK0m5J3Ck90Kev"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bDevfDxIoFmK0m5J3Ck90Kev
Content-Type: multipart/mixed; boundary="------------E61UZdTOazfuXzVVU9KdIpfQ";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 virtualization@lists.linux.dev
Message-ID: <5bd029fe-35ee-4bbc-8e05-0df8c4125b6a@suse.com>
Subject: Re: [PATCH v2 8/8] x86/msr: Remove duplicate #include
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <20260429184530.9FE585E8@davehans-spike.ostc.intel.com>
In-Reply-To: <20260429184530.9FE585E8@davehans-spike.ostc.intel.com>

--------------E61UZdTOazfuXzVVU9KdIpfQ
Content-Type: multipart/mixed; boundary="------------yLBIECXcxsq6T7uu3ff9fq8P"

--------------yLBIECXcxsq6T7uu3ff9fq8P
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDQuMjYgMjA6NDUsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiBGcm9tOiBEYXZlIEhh
bnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPg0KPiANCj4gZXJybm8uaCBpcyBh
bHJlYWR5IGluY2x1ZGVkIGZvciBDIGNvZGUgYXQgdGhlIHRvcCBvZiB0aGUgaGVhZGVyLg0K
DQpJJ20gc2VlaW5nIG9ubHkgYXNtL2Vycm5vLmggYmVpbmcgaW5jbHVkZWQuDQoNCkkgZG9u
J3Qgc2F5IGxpbnV4L2Vycm5vLmggaXMgbmVlZGVkLCBidXQgdGhlIHJlYXNvbmluZyBpcyBu
b3QgcmVhbGx5DQpjb252aW5jaW5nLg0KDQoNCkp1ZXJnZW4NCg0KPiBaYXAgdGhlIGR1cGxp
Y2F0ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBs
aW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiANCj4gICBiL2FyY2gveDg2L2luY2x1ZGUvYXNt
L21zci5oIHwgICAgMSAtDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLXB1TiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3IuaH5yZG1zci1kdXBzLTEx
IGFyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oDQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL21zci5ofnJkbXNyLWR1cHMtMTEJMjAyNi0wNC0yOSAxMTozODo1Ny44Mzg3MzI0MDUg
LTA3MDANCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmgJMjAyNi0wNC0yOSAx
MTozODo1Ny44NDE3MzI1MTkgLTA3MDANCj4gQEAgLTE3Miw3ICsxNzIsNiBAQCBzdGF0aWMg
aW5saW5lIHU2NCBuYXRpdmVfcmVhZF9wbWMoaW50IGNvDQo+ICAgI2lmZGVmIENPTkZJR19Q
QVJBVklSVF9YWEwNCj4gICAjaW5jbHVkZSA8YXNtL3BhcmF2aXJ0Lmg+DQo+ICAgI2Vsc2UN
Cj4gLSNpbmNsdWRlIDxsaW51eC9lcnJuby5oPg0KPiAgIA0KPiAgIC8qIFNob3J0LWNpcmN1
aXQgdGhlIHBhcmF2aXJ0IE1TUiBpbmZyYXN0cnVjdHVyZSB3aGVuIGl0IGlzIGRpc2FibGVk
OiAqLw0KPiAgICNkZWZpbmUgcGFyYXZpcnRfcmVhZF9tc3IJbmF0aXZlX3JlYWRfbXNyDQo+
IF8NCg0K
--------------yLBIECXcxsq6T7uu3ff9fq8P
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------yLBIECXcxsq6T7uu3ff9fq8P--

--------------E61UZdTOazfuXzVVU9KdIpfQ--

--------------bDevfDxIoFmK0m5J3Ck90Kev
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnzAr8FAwAAAAAACgkQsN6d1ii/Ey8d
1ggAn16/BFg/ht1lmzZfPnnbt6QhIm5XOXXmHd8z8PX01vUFMhlxnWw/e7RBej24WgF7FXCRLdmN
1RvlqkvWlVh+PgptjEOIfNLvPwBnj+UMJqsECc369o90wt9c1qjrb3S+SVEc5W47yms1S1fSZK/R
U3YDnd1RYDqx+OEhM9vZNffqpK/PKAMExrxY5m0levE8yC1Y5al3kCNFfILz7a/n4MW/XRSntNpQ
KvWstgwc9b9Wqboxj6g38R3NklO+Ath2PGYzIMGTcbsV+hu0LdKLU87YMwHPt33hXkfhCACy4etA
WoJ6F3tmsGzBQ1uWw/6Y1v/MRitc8JC/jJjGRRnbsw==
=CGD3
-----END PGP SIGNATURE-----

--------------bDevfDxIoFmK0m5J3Ck90Kev--
