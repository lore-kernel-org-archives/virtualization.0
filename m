Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9613EB813
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778065751; cv=none; b=V6MmoGC9Pu7e2PFXCPdURE8qvuA3pQ/xpOwq9VKmHzZ+oYwuIDdrGeB7IYCG3JCJ8LrGOsDXHh6mFs+zwkZ2nV/ubxyiCWBD5TKPD1mA/Vkt9MqFXtp3EMpqql7c+v/MjJnEQvDlFNi1l7uE6ZMuFOVe/F7hgarUW/Z3dgpFanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778065751; c=relaxed/simple;
	bh=oVfzOsTT/an2CQOSwx29znZfmc+2ruJ3lQqJSVimzzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=apPxHm8r4ughqWJ8ellurMhFZ03nYR3YOSt1SeK5B72uPlKhf8hRASVHl1O/OrIflA0K1OzveWqg9KWd8lCdaxsJvVxsoM/nxvHPp7IR+u+42UqKf4wZndc0gET4PMmyIGD8KTQAQm9+M3TSvdQfD3gczLWC6Z/AM++hcrw8csA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=caPBF2I0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="caPBF2I0"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso34880605e9.3
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 04:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778065748; x=1778670548; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVfzOsTT/an2CQOSwx29znZfmc+2ruJ3lQqJSVimzzk=;
        b=caPBF2I0b/M3aKVud8ZpSfxYGFxjcFilPwhjtjzio11XmzY3/5vgav3J4hkPTfUlxB
         /JjgvPmEPPQLj1HigJxrBOGQPtQm/lkBRo9FGPjdPo/n+et8pd7g0izMD6l21rLbfxos
         I9+GlY/hmk/BteiE4+UQndg6g0ZC0RUYoFfFjELLihtWGhoXSkhUYxl6ueR8Nvg9UboA
         yNnA0ssxYvvBqLCtEfhyQsrdAaw8ssw4KZp2CKBRUCgWfcHEUkEikJcrprycU2gzoVY7
         9ALSM9XVgWYikfVZZGSOBbJWYP93Ggx2+8DlDADicDN0UlohuEIuWrU01voup7RBEory
         Bh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778065748; x=1778670548;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVfzOsTT/an2CQOSwx29znZfmc+2ruJ3lQqJSVimzzk=;
        b=cMZAsu4iWe0tEg+P+AqNLQyAOVKHKDtHasar8DtLL1hM3ZrIWEYpAwMjB2+Ydrm75z
         S9Im+xN/29Ss7aFgJLvVYLfwRcgs64Fb0EjLma+8zffJbGaxu17f4YSRtHtG49FJdfTy
         uYlkKtaco9PPz9ipVjRU12qCDo2sBjdw2HgDfwRREvRNBHe0JY9qHpTFcpwiiNW5r65O
         m9/GNrlmTaPgAdFdhM2cucj1QTzcFMz7qign+ZPO8+k66rl6q4CqRF9IOLvzvVl3ylSr
         OM941zivXIekOV+c0w4welRY3WVpXNMuvAyvKBYH/LZyq+HtnfV13GoyIuTliIo/ZQHV
         2dVA==
X-Forwarded-Encrypted: i=1; AFNElJ/IAV3UDoRnF/e1VSfs3pXYJkM0oETnTnKpvJNF7a8JdycLMZbRK7UZTAD5er8GXYR/i+mn6vw5BPxeTGDR2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDxLO5KofOmhUqbFEXDkxU/oxcfO3IiYpgmHcpSVb2MBBJrZAF
	kaq53GONR3+RdJHgMVzsV7p5XUbCbTtzBzv5791sTZiMaBNfnC93T5nuDaMacNLPmDk=
X-Gm-Gg: AeBDieurgy5DKEPKzYa4Ju/Sgn4q/dEEQFujPDxpKh/8jcLSbHjSy6GgMG7KjyAsHoE
	WAv9SBaG+GUmUQKeuvinB3GJpCy2qy8j8qIoKtSpnd4FfoQlf1af8Yi4evfeeedjh8CMV1d5svt
	3zvn6pnvF9TVDBUSNKQA3VqKGF3KtupTfUdZss1mmFBv39ARX7fc67MeYUNoixjbHa/eLYLFL6l
	z7amCkKgnyI3JPXvzmZ7PZ+9FRjvkqpG2hZXLPOrxzQebNC3aAZq4pC+4R4m4BjqrvE4STIJasV
	qUtCIgC26Fyz25FZytRj/pyXwK05OD07gHztgLx+xobEiHydsgXkhuo4vYk+imvri5j/lefCAg2
	h2nX2dJt90m+OWLN5U7ZycHFqqyfjlCrXlrbSV7ih4F2HITG/YyYQ9lYc1erS8NDFVvfGrSVb5l
	wVL1KV2Pr5hpRiozD7Ms1UQG3COOZ8e0qCm3LzpDYaXpGBM7l80Fgzgn2HZgynpf/LasaR3aWyT
	SrvwtOjmrZtS2bNsKEij2X4PrA1Mxdx77Gz8SlyrB6BfRzMdufMnpse+cd5ExXC
X-Received: by 2002:a05:600c:a10d:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-48e51f483cdmr37717825e9.26.1778065748397;
        Wed, 06 May 2026 04:09:08 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530d8691sm32011935e9.2.2026.05.06.04.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 04:09:07 -0700 (PDT)
Message-ID: <c3d08fd7-4938-4db2-9962-1c87dab74a2f@suse.com>
Date: Wed, 6 May 2026 13:09:07 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] x86/msr: Consolidate rdmsr() definitions
To: Yan Zhao <yan.y.zhao@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 virtualization@lists.linux.dev
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <20260429184521.7AADEE4C@davehans-spike.ostc.intel.com>
 <afqhbl9pKKwsVjOy@yzhao56-desk.sh.intel.com>
 <afsXCIUjib70dBYz@yzhao56-desk.sh.intel.com>
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
In-Reply-To: <afsXCIUjib70dBYz@yzhao56-desk.sh.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CrBmqStcHQ99cTZsPCA000E2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CrBmqStcHQ99cTZsPCA000E2
Content-Type: multipart/mixed; boundary="------------Lk8caRrPxs0dol9WhnneIP1g";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Yan Zhao <yan.y.zhao@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 virtualization@lists.linux.dev
Message-ID: <c3d08fd7-4938-4db2-9962-1c87dab74a2f@suse.com>
Subject: Re: [PATCH v2 2/8] x86/msr: Consolidate rdmsr() definitions
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <20260429184521.7AADEE4C@davehans-spike.ostc.intel.com>
 <afqhbl9pKKwsVjOy@yzhao56-desk.sh.intel.com>
 <afsXCIUjib70dBYz@yzhao56-desk.sh.intel.com>
In-Reply-To: <afsXCIUjib70dBYz@yzhao56-desk.sh.intel.com>

--------------Lk8caRrPxs0dol9WhnneIP1g
Content-Type: multipart/mixed; boundary="------------EEVWZ0rnLUZbonvFZKbB5X7Z"

--------------EEVWZ0rnLUZbonvFZKbB5X7Z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMDUuMjYgMTI6MjUsIFlhbiBaaGFvIHdyb3RlOg0KPiBPbiBXZWQsIE1heSAwNiwg
MjAyNiBhdCAxMDowMzoyNkFNICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4+IE9uIFdlZCwg
QXByIDI5LCAyMDI2IGF0IDExOjQ1OjIxQU0gLTA3MDAsIERhdmUgSGFuc2VuIHdyb3RlOg0K
Pj4+ICsvKg0KPj4+ICsgKiBDb21tb24gcGFyYXZpcnQgYW5kIG5hdGl2ZSBoZWxwZXJzOg0K
Pj4+ICsgKi8NCj4+PiArI2RlZmluZSByZG1zcihtc3IsIGxvdywgaGlnaCkJCQkJCVwNCj4+
PiArZG8gewkJCQkJCQkJXA0KPj4+ICsJdTY0IF9fdmFsID0gcGFyYXZpcnRfcmVhZF9tc3Io
KG1zcikpOwkJCVwNCj4+PiArCSh2b2lkKSgobG93KSA9ICh1MzIpX192YWwpOwkJCQlcDQo+
Pj4gKwkodm9pZCkoKGhpZ2gpID0gKHUzMikoX192YWwgPj4gMzIpKTsJCQlcDQo+Pj4gK30g
d2hpbGUgKDApDQo+PiBSYXRoZXIgdGhhbiBkaXJlY3QgYWxsIChwYXJhdmlydCBhbmQgbmF0
aXZlKSBpbnZvY2F0aW9ucyBvZiByZG1zcigpIHRvDQo+PiBwYXJhdmlydF8qKCksIGRvZXMg
aXQgbWFrZSBzZW5zZSB0byBmaXJzdCBpbnRyb2R1Y2UgdGhlIGNvbW1vbiB2ZXJzaW9uIG9m
DQo+PiBoZWxwZXJzIGFuZCBkaXJlY3QgdGhlIGNvbW1vbiB2ZXJzaW9uIG9mIGhlbHBlcnMg
dG8gcGFyYXZpcnRfKiBvciBuYXRpdmVfKj8NCj4+IFNvLCB3ZSBjYW4gaGF2ZQ0KPj4NCj4+
ICsvKg0KPj4gKyAqIENvbW1vbiBwYXJhdmlydCBhbmQgbmF0aXZlIGhlbHBlcnM6DQo+PiAr
ICovDQo+PiArI2RlZmluZSByZG1zcihtc3IsIGxvdywgaGlnaCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KPj4gK2RvIHsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4+ICsgICAgICAgdTY0IF9f
dmFsID0gY29tbW9uX3JlYWRfbXNyKChtc3IpKTsgICAgICAgICAgICAgICAgICAgICBcDQo+
PiArICAgICAgICh2b2lkKSgobG93KSA9ICh1MzIpX192YWwpOyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXA0KPj4gKyAgICAgICAodm9pZCkoKGhpZ2gpID0gKHUzMikoX192YWwg
Pj4gMzIpKTsgICAgICAgICAgICAgICAgICAgIFwNCj4+ICt9IHdoaWxlICgwKQ0KPj4NCj4g
T3IgbWF5YmUgcy9jb21tb24vdHJhbXBvbGluZSA/DQoNCkknZCBzdWdnZXN0IF9fcmVhZF9t
c3IoKSBhbmQgZnJpZW5kcy4NCg0KDQpKdWVyZ2VuDQo=
--------------EEVWZ0rnLUZbonvFZKbB5X7Z
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------EEVWZ0rnLUZbonvFZKbB5X7Z--

--------------Lk8caRrPxs0dol9WhnneIP1g--

--------------CrBmqStcHQ99cTZsPCA000E2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmn7IVMFAwAAAAAACgkQsN6d1ii/Ey8H
4gf/XMTEwlUsw8sLZ428GZw0KtwhchRhyfWAOgEJshEIzQruNn+uulyCOWd4cqiCQWp6fVGkqwU0
hRibjS1rBpnPr7fRCqI0pLwe0eAHgdisMdjDT2XAmFWr0w0g2Xs/Q8UwiR8QMZXJhcA1o7wxYX09
bHxYPiH9MvQg71qeFb81e21iRX7pinRi7jdegW0HruDcdrAHvKUStTD71oosAsZqqmUES+E1Gpfa
LKEOxUGrwTjpoC7D3R01vcb8Pp0+M8nGB03BpcC1NRjaXT47ISynbtCm326zbqe8UHxvztPn2Wd8
XT6bx908cjJfr9Xfn00Yzeg0zKzRN4Bm3vyyRTIqiA==
=8slB
-----END PGP SIGNATURE-----

--------------CrBmqStcHQ99cTZsPCA000E2--
