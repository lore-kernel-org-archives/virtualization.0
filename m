Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF3241696
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763967353; cv=none; b=YICNDg6CYszoPYby0GDxR0rU4jPls6hJOLG9V95n7ZUkV7Waf86PbpK3NpTkGVx9TsSecZaOTpYg9Uv9sTEZjEP3zEL85aNtZhl1HCi+kDPCYL60AluID42Ua8/Cvsbq55X2QQf94esOWErAZS7NRIqhDpK4e4f524w8SBqyIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763967353; c=relaxed/simple;
	bh=a4qMLYoLqh14x5R4HIfeoF8rKvEGU/r1XnAUIuUE8qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GC8w2+Z01UJe5seJFFiTE6LUc+iUOfNtZBQav6Ly7r2p6ATTqOPtnoWCdw9+9uhfEZPMUQZwLQywl8b4H/qrB9fJM+YkM4Xq36zXd2MFey0b/1smZf+6xQJI/ZjCSiAjiP9d1YQPuO8MUag1Sq5yLbtfMXGB9n7bI94I6eZza78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TU08M3pZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TU08M3pZ"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b72bf7e703fso651864366b.2
        for <virtualization@lists.linux.dev>; Sun, 23 Nov 2025 22:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763967348; x=1764572148; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a4qMLYoLqh14x5R4HIfeoF8rKvEGU/r1XnAUIuUE8qc=;
        b=TU08M3pZ/ojStcOgSrQTFaMSpKhK+NEaBaN7RFV1HKAw4tdS8+QKR4ULYVeaJjyYkB
         hNVmejrESdNN7875F9DILUhUTJijP/vq0vvYjC3u17QSvFXQ0kpIRq9OehPnPyGPBErr
         uIbaX8ajWLJ3/SUg/gxp5kGyOJO5VRR7HcQh9JCUJ/KvmSspcuMmwGMqnGerJPZwpoAH
         UihsURYXkDBDRqHFM326NVI3iEoPsaBMC5PnB48VrNrOap0JQXd7XZQSqsc2cd0Q+36G
         W+JKlsptxjAbhDQV3jO0O+4y7BKEtx5PTePe/iFiOc8Es8Sef+KfJnbNAtchJa7Oz+Du
         3q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763967348; x=1764572148;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4qMLYoLqh14x5R4HIfeoF8rKvEGU/r1XnAUIuUE8qc=;
        b=vcDPweEMBDGWP9gVL0yaL+Ql1qFH0oihJX70+kU1KQXr/QgCLBJmg1I8ETT7V+JVaI
         Lctw03l4PJ0wppufQ0dlzfhAW39pdVS8+6kXXB+XKTNb0tmeAA7Xb2UoA06I2gts0M0V
         J9lyP5PCniCfb7axxj/xRJ1EecqBNoCPyExOpun1VWXmy7bf9m/iMu1TuVopYeP36o+N
         VRnbrU5AXMsAaLsksJW8kEzKeDJafG68CA3YrrRf+8ejdFyNAUqGo0eCKLFmr7iPGYIZ
         +N2fNMkHGh3WYqYj106FZyElIQhiayEY2HWR7CrEABkbCAvCIRxncYjuoQsCD02cpfEj
         GslQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOgNCRI5y+6f3b8UaBIX1rWBuT/hpN3tCVBCgaGXAtiMxpdwAroFMoU7sZEhNTr/v+x1ylf/lveimI94GCgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YweoUguN9Am8Fya7ScD145FQgtFegVhTss7wRMXLo9BEzyk1ju4
	SVYFc2Bc518rZlQNkO66eQ9JuIP5rzH7AhAf/ZYRpN+/+kL9c/5gCOyVckmYtPBGl+QgpcK+wdQ
	I0nLdX2s=
X-Gm-Gg: ASbGncuUi7TsnAlGk2bN4qQvR2LLGjUC8l7F6EdBRzL44v8e8YNOrgJssuB5Aw6jWVT
	wAEkO8fsTp4NHgzkepKlxELSXp++xwkc2gfQ1q27IKyUf0SBLElFeu3+1m2KOy4EsfcqSLOFQ7g
	wZnTY93XjZKmcj5yFWxhuF0BNRI97MBO9Gr71aFIu88Apn+AnwqQ6t0TbhE7S5fqftsv7z5GbBH
	ZLnWa6MjiUkExhAEDbXJOCzBomRecI3rmOvS7UZ60LWlK3LT/omClB/Y7Ya2VNLjmE+bmltKGir
	VDZrcYJMcI48p5/9xSM7LOv3aqmZbnOEHn7bTS3zLJJce9iZ1gL3VitMlAAUEmUDIul3XAy3LVG
	w3HU1bnwpLsDahxtz6mUT0wG67aP3DzSB6oFAgc6ZaX4eRXWiIa2gO8JIheMo5RdW099JW27yLJ
	epbA3dnrRyRR69PWqo5d0lEeleksfi9UWQDMl7oqvE9g5ZQHAzX2Exu8j/DAOPGm+YkjtWe9LVQ
	lEJY2pJ3j1YNLTzzwpnO2egFxGdOdy1EuloDyY=
X-Google-Smtp-Source: AGHT+IEM46sBoidOONMdY6F3oAmBVDOf6i+8F7241HLSpkAR60OcqxQEQPMneaYRD79kqK/LDZKD7g==
X-Received: by 2002:a17:907:3f2a:b0:b76:36ed:9fbe with SMTP id a640c23a62f3a-b7671a7a1cdmr1072927666b.40.1763967348136;
        Sun, 23 Nov 2025 22:55:48 -0800 (PST)
Received: from ?IPV6:2003:e5:871a:de00:dd24:7204:f00a:bf44? (p200300e5871ade00dd247204f00abf44.dip0.t-ipconnect.de. [2003:e5:871a:de00:dd24:7204:f00a:bf44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765503a990sm1203093766b.63.2025.11.23.22.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 22:55:47 -0800 (PST)
Message-ID: <47fed3cd-58fd-4670-a939-7b2e7ca1b673@suse.com>
Date: Mon, 24 Nov 2025 07:55:46 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] LoongArch: Add paravirt support with
 vcpu_is_preempted() in guest side
To: Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, x86@kernel.org
References: <20251124035402.3817179-1-maobibo@loongson.cn>
 <20251124035402.3817179-3-maobibo@loongson.cn>
 <CAAhV-H5Oag+mDp0CfZ1VDeapeKas354j68JZN9bN42=D4huowA@mail.gmail.com>
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
In-Reply-To: <CAAhV-H5Oag+mDp0CfZ1VDeapeKas354j68JZN9bN42=D4huowA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AKfOm3Kbax9qlTbc8gnUDRKE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AKfOm3Kbax9qlTbc8gnUDRKE
Content-Type: multipart/mixed; boundary="------------ePwLpA0utK1z0DrhxPEAXiVi";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, x86@kernel.org
Message-ID: <47fed3cd-58fd-4670-a939-7b2e7ca1b673@suse.com>
Subject: Re: [PATCH v2 2/3] LoongArch: Add paravirt support with
 vcpu_is_preempted() in guest side
References: <20251124035402.3817179-1-maobibo@loongson.cn>
 <20251124035402.3817179-3-maobibo@loongson.cn>
 <CAAhV-H5Oag+mDp0CfZ1VDeapeKas354j68JZN9bN42=D4huowA@mail.gmail.com>
In-Reply-To: <CAAhV-H5Oag+mDp0CfZ1VDeapeKas354j68JZN9bN42=D4huowA@mail.gmail.com>

--------------ePwLpA0utK1z0DrhxPEAXiVi
Content-Type: multipart/mixed; boundary="------------imVIQBVKAQQS75YfpAqza0DE"

--------------imVIQBVKAQQS75YfpAqza0DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjUgMDc6MzMsIEh1YWNhaSBDaGVuIHdyb3RlOg0KPiBIaSwgQmlibywNCj4g
DQo+IE9uIE1vbiwgTm92IDI0LCAyMDI1IGF0IDExOjU04oCvQU0gQmlibyBNYW8gPG1hb2Jp
Ym9AbG9vbmdzb24uY24+IHdyb3RlOg0KPj4NCj4+IEZ1bmN0aW9uIHZjcHVfaXNfcHJlZW1w
dGVkKCkgaXMgdXNlZCB0byBjaGVjayB3aGV0aGVyIHZDUFUgaXMgcHJlZW1wdGVkDQo+PiBv
ciBub3QuIEhlcmUgYWRkIGltcGxlbWVudGF0aW9uIHdpdGggdmNwdV9pc19wcmVlbXB0ZWQo
KSB3aGVuIG9wdGlvbg0KPj4gQ09ORklHX1BBUkFWSVJUIGlzIGVuYWJsZWQuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogQmlibyBNYW8gPG1hb2JpYm9AbG9vbmdzb24uY24+DQo+PiAtLS0N
Cj4+ICAgYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vcXNwaW5sb2NrLmggfCAgNSArKysr
Kw0KPj4gICBhcmNoL2xvb25nYXJjaC9rZXJuZWwvcGFyYXZpcnQuYyAgICAgICB8IDE2ICsr
KysrKysrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCsp
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvbG9vbmdhcmNoL2luY2x1ZGUvYXNtL3FzcGlu
bG9jay5oIGIvYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vcXNwaW5sb2NrLmgNCj4+IGlu
ZGV4IGU3NmQzYWExZTFlYi4uOWE1YjdiYTFmNGNiIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9s
b29uZ2FyY2gvaW5jbHVkZS9hc20vcXNwaW5sb2NrLmgNCj4+ICsrKyBiL2FyY2gvbG9vbmdh
cmNoL2luY2x1ZGUvYXNtL3FzcGlubG9jay5oDQo+PiBAQCAtMzQsNiArMzQsMTEgQEAgc3Rh
dGljIGlubGluZSBib29sIHZpcnRfc3Bpbl9sb2NrKHN0cnVjdCBxc3BpbmxvY2sgKmxvY2sp
DQo+PiAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4+ICAgfQ0KPj4NCj4+ICsjaWZkZWYgQ09O
RklHX1NNUA0KPj4gKyNkZWZpbmUgdmNwdV9pc19wcmVlbXB0ZWQgICAgICB2Y3B1X2lzX3By
ZWVtcHRlZA0KPj4gK2Jvb2wgdmNwdV9pc19wcmVlbXB0ZWQoaW50IGNwdSk7DQo+IEluIFYx
IHRoZXJlIGlzIGEgYnVpbGQgZXJyb3IgYmVjYXVzZSB5b3UgcmVmZXJlbmNlIG1wX29wcywg
c28gaW4gVjINCj4geW91IG5lZWRuJ3QgcHV0IGl0IGluIENPTkZJR19TTVAuDQo+IE9uIHRo
ZSBvdGhlciBoYW5kLCBldmVuIGlmIHlvdSByZWFsbHkgYnVpbGQgYSBVUCBndWVzdCBrZXJu
ZWwsIHdoZW4NCj4gbXVsdGlwbGUgZ3Vlc3RzIHJ1biB0b2dldGhlciwgeW91IHByb2JhYmx5
IG5lZWQgdmNwdV9pc19wcmVlbXRwZWQuDQoNCkkgZG9uJ3QgdGhpbmsgc28uIFdoZW4gdGhl
IFVQIGd1ZXN0J3MgdmNwdSBpcyBwcmVlbXB0ZWQsIHdobyB3aWxsIHVzZSB0aGlzDQpmdW5j
dGlvbj8NCg0KDQpKdWVyZ2VuDQo=
--------------imVIQBVKAQQS75YfpAqza0DE
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------imVIQBVKAQQS75YfpAqza0DE--

--------------ePwLpA0utK1z0DrhxPEAXiVi--

--------------AKfOm3Kbax9qlTbc8gnUDRKE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmkkAXMFAwAAAAAACgkQsN6d1ii/Ey8I
0gf/YCT12ru5754lpR2Z13qnrHOpfqrznDHRwf4PsOpLP6YbnMP3gD2BG9hoMyBb/apZEADtE/3y
2EzqEnDo7VORctQrCZoGVMXTGJxMyVLvct5wOk0G7MboOFo2Ad3jaJWPxCXj/RHCxEsNk1E+U+97
V9IJBmM3qLYinjC9/a0Cgr5xz/Xd2PZuba/LM8XrNJAMTiFhJHf8y2ceElgFg2Rp8PKiKaaM93RU
Loro2dsdhCGcoA+IDTQVg0pgyo20cbeBQzrcMhISvTQu41mUz/tIpQWJYc/fUu0jtHo1392Mk4Py
aDdbd+Zb3uFMMJ8GUNnjyEUqm4Pyupd1+lcGh8+S5A==
=UH6T
-----END PGP SIGNATURE-----

--------------AKfOm3Kbax9qlTbc8gnUDRKE--
