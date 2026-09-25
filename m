Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FBA496D49
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342115; cv=none; b=tnO5gy7WVRIJlnSngyL/im4M0p9lexVIrx2vL51OAFmXTSnDLltMDgPYz/rdQKQmj+i0TyZ33MHIUmjjcT5mOX3DEqQjcwkCc5ij1UGetkKp7k+YLBhVJ/ohBr2VvHXPh8pyaPOdpCpM8SogXuVAGbZ2vXjPTiDsrLo/1wz5Wnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342115; c=relaxed/simple;
	bh=stWaFr/EMX9+8WU2ewiho4HGW5nW1p1jjHtEGNyEdz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RV01gQ8p2yvC6OBP5Flbb92MWSpGoEysG3oMDCZ8Ekf3BuMnry/MYOwRaxMxHoDLYy0W9TOjfxShOlhs9Tfs0t3nP5pjJd0HkY1lxY+FSLP7Sd+3wvvmt/VmO+dA4uaimyPOHwoqUfwbDdrjTacrq8Snsoc4achhXkdeXFvjQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CpBDKGLf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CpBDKGLf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so5069535e9.0
        for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790342107; x=1790946907; darn=lists.linux.dev;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=stWaFr/EMX9+8WU2ewiho4HGW5nW1p1jjHtEGNyEdz8=;
        b=CpBDKGLfRw+EFwCqaI8bwyucp3cAUEV7ArGvAkvQHwo30wFKWhlesUoquuU/a1FIe0
         09AlyjIrON/Ca/H8dF8cg4EzRig7j5mMyAltzmIQUxzradjkXdAS/EvRL9SxlORjL0C3
         TMut/zvGZI+TGKMpErCmS/oDhFyuri4KBk73CtRK+j0HlItlHe5Cm/+FTC55eXvOL54F
         nRcWcGKHPemHMSgAvUEMHOlLdy/1xrJ1Ubdiw72Tib9A1zaffT0QTnSj24LBNXYYV5Ba
         1YrF22XYQactcj1SO/21jSiQdtaKd/Jq9OIdiFR5mzLbThsWTfcPQ/dKekIp2sCA2xs3
         d/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790342107; x=1790946907;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stWaFr/EMX9+8WU2ewiho4HGW5nW1p1jjHtEGNyEdz8=;
        b=XiMffVICKj22CNPW47PuP7WhYL/eP6lkTYNeLT26EMOThubnDuvv9TcSKvsLgcItXj
         v9qFOe9xJHq2oiAMDHhjKT6JnkIHVMIC3C21zU9yWr/cu3/3U8A2qq9K5+nah0nDWwk5
         +qH3yGiXG/8YA2Gr8dMlHVsjd6hgZYinwUN6P5QrQa1yn6rlv2vMXyGVEZmipBYuUeWh
         DnCBrnlJIwV1aemUP354ia60lNbNCF/spF0THq03PMSbj3LerDclKfFgQVHTcR8xe/9J
         rjsV5aD0zC0XoUBI78MR084pySBWQnJdmOnUFp2tFfv4KNSNZZl8BfGMNj9wrP2dhtKK
         rvGw==
X-Forwarded-Encrypted: i=1; AKwUvBw+RSMYdp9M9yEewt3OuF2pkbnncy0zcl0FE8j+JzuJGvTFbDyPkcBs8dEMdy1J0tyvmO6usbNd7fOIqF9r5Q==@lists.linux.dev
X-Gm-Message-State: AFuF++l0lTeNj6LV5KyW4mABLO3eVsh5mXYn24DZQU03Z4C1GeIBtgTP
	uOwRDUw0ILb3my9TTWqSuCMI/PboWqjFmlkjeACJ6NRmpxNc9tWk1aWCvCqlNUXwlNA=
X-Gm-Gg: AYBFou0ISonKqi6QQba4dUlFJhULf0LTlpJ8qlOYW6vUYEZdOLAtOubAZcAQL+g7nW4
	EUTIErSYH2T4qyYQDnCZsNv4SRJzZ6M60xWcu2pZGE9WLxrXETUQeyWWNkOF6AcPbtvMEfYax8G
	zaY0cgSb040BlrRbhwlpdmi1/IjBQPBHtLyYn9ZZcoYCg2P2+XZJK/1gKbdYPiPUkX4k0narmNH
	50cMHZ4w0IUQ5k3am48sgdzeCjTh4BWrCKEHO3bLd/++vvq2Ebh7Y4B/Ni3cMbzAm/CkevAj4h6
	nZ/nOPEE0f5gnjFKwGe7gUCyNSg4AAK5xXmXxEmAjqnDkwPq6nSviqZYYWNcGXVep5Foybh1qgS
	DQpooFkpNaWbazj6xdMu2njUeUOnfnrHAxJ/DqkGQwOSLpcRuCzxhDEaCa/5+rGkq7BKe1+LLCr
	e7zmRLQEDo3ZPXt5QokqwjqTJAu9m7wrlRskLNePclSi64aj638rSKEth6zrZjRjQiwzK90VZCq
	g0lHiUSahy9qypIOz3wPs/dsguB562RP8Ov9YfQ44WNo3F3ALZxDxJ7aEHSP6XQxtUuVANMXjHf
	+7cwqXjNJ4O94WNtoACkzw7nBRlmf5GXzlzZ
X-Received: by 2002:a05:600c:19c7:b0:49f:e546:86e3 with SMTP id 5b1f17b1804b1-49fe670ee79mr99393075e9.35.1790342107337;
        Fri, 25 Sep 2026 06:15:07 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe667ae2fsm147278005e9.13.2026.09.25.06.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 06:15:06 -0700 (PDT)
Message-ID: <d322debd-15a5-4dd8-9e34-f69dbecc1099@suse.com>
Date: Fri, 25 Sep 2026 15:15:05 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/17] x86/msr: Move MSR trace calls one function level
 up
To: Shreshth Srivastava <shreshth.srivastava@intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, virtualization@lists.linux.dev
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com
References: <20260911084211.3149957-1-jgross@suse.com>
 <20260911084211.3149957-5-jgross@suse.com>
 <20260923202654.1412087-1-shreshth.srivastava@intel.com>
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
In-Reply-To: <20260923202654.1412087-1-shreshth.srivastava@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iiBhoS9kLqdyghYbKwaF8gWa"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------iiBhoS9kLqdyghYbKwaF8gWa
Content-Type: multipart/mixed; boundary="------------NelZ0fzD6woPS0DUZIm6Q4Lz";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Shreshth Srivastava <shreshth.srivastava@intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, virtualization@lists.linux.dev
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Message-ID: <d322debd-15a5-4dd8-9e34-f69dbecc1099@suse.com>
Subject: Re: [PATCH v5 04/17] x86/msr: Move MSR trace calls one function level
 up
References: <20260911084211.3149957-1-jgross@suse.com>
 <20260911084211.3149957-5-jgross@suse.com>
 <20260923202654.1412087-1-shreshth.srivastava@intel.com>
In-Reply-To: <20260923202654.1412087-1-shreshth.srivastava@intel.com>

--------------NelZ0fzD6woPS0DUZIm6Q4Lz
Content-Type: multipart/mixed; boundary="------------6A9BMhW60Yidnn0G0XHNy8l6"

--------------6A9BMhW60Yidnn0G0XHNy8l6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMuMDkuMjYgMjI6MjYsIFNocmVzaHRoIFNyaXZhc3RhdmEgd3JvdGU6DQo+IE9uIDEx
LjA5LjI2IDEwOjQxLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gSW4gb3JkZXIgdG8gcHJl
cGFyZSBwYXJhdmlydCBpbmxpbmluZyBvZiB0aGUgTVNSIGFjY2VzcyBpbnN0cnVjdGlvbnMN
Cj4+IG1vdmUgdGhlIGNhbGxzIG9mIE1TUiB0cmFjZSBmdW5jdGlvbnMgb25lIGZ1bmN0aW9u
IGxldmVsIHVwLg0KPj4gSW50cm9kdWNlIHtyZWFkfHdyaXRlfV9tc3JbX3NhZmVdKCkgaGVs
cGVycyBhbGxvd2luZyB0byBoYXZlIGNvbW1vbg0KPj4gZGVmaW5pdGlvbnMgaW4gbXNyLmgg
ZG9pbmcgdGhlIHRyYWNlIGNhbGxzLg0KPiANCj4gSGkgSnVlcmdlbiwNCj4gDQo+IHJlYWRf
bXNyKCkgYW5kIHdyaXRlX21zcigpIGdldCBhIHNpbmdsZSB3cmFwcGVyIGJlbG93IHRoZQ0K
PiBDT05GSUdfUEFSQVZJUlRfWFhMIGlmZGVmIGhvbGRpbmcgdGhlIHRyYWNlcG9pbnQsIHNv
IGl0IGZpcmVzIGZvciBlaXRoZXINCj4gaW1wbGVtZW50YXRpb24uIHJkcG1jKCkgbW92ZWQg
aW50byB0aGUgc2FtZSBpZmRlZiBidXQga2VwdCB0aGUgb2xkDQo+IGFycmFuZ2VtZW50OiBz
dGlsbCBkZWZpbmVkIHR3aWNlLCBvbmNlIHBlciBhcm0sIHdpdGggZG9fdHJhY2VfcmRwbWMo
KQ0KPiBzdGlsbCBjYWxsZWQgZnJvbSBuYXRpdmVfcmVhZF9wbWMoKSBhYm92ZSB0aGUgaWZk
ZWYuDQo+IA0KPiBXaXRoIENPTkZJR19QQVJBVklSVF9YWEw9eSB0aGF0IGxlYXZlcyByZHBt
YygpIG9uIGEgcGF0aCB3aXRoIG5vIHRyYWNlDQo+IGNhbGw6DQo+IA0KPiAgICByZHBtYygp
ICAgICAgICAgICAgICAgICA9PiBwYXJhdmlydC1tc3IuaCwgUFZPUF9DQUxMMShwdl9vcHNf
bXNyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWFkX3BtYykNCj4gICAg
ICB4ZW5fcmVhZF9wbWMoKSAgICAgICAgPT4gWGVuIFBWIHNldHMgcHZfb3BzX21zci5yZWFk
X3BtYyB0byB0aGlzDQo+ICAgICAgICByZWFkcyB0aGUgdmFsdWUgb3V0IG9mIHRoZSBYZW4g
c2hhcmVkIFBNVSBwYWdlDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgID0+IHJldHVy
bnMgd2l0aG91dCBldmVyIGNhbGxpbmcNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbmF0aXZlX3JlYWRfcG1jKCksIHdoaWNoIGlzIHdoZXJlDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRvX3RyYWNlX3JkcG1jKCkgc2l0cw0KPiANCj4gU28gbXNyOnJk
cG1jIGRvZXNuJ3QgZmlyZSB1bmRlciBYZW4gUFYsIHdoaWxlIG1zcjpyZWFkX21zciBhbmQN
Cj4gbXNyOndyaXRlX21zciBub3cgZG8uDQo+IA0KPiBXYXMgdGhhdCBkZWxpYmVyYXRlPyBJ
ZiBpdCB3YXNuJ3QsIGhlcmUgaXMgYSBkaWZmIHRoYXQgdHJlYXRzIHJkcG1jIHRoZQ0KPiBz
YW1lIHdheSBhcyB0aGUgb3RoZXIgc2l4OiByZW5hbWUgYm90aCBkZWZpbml0aW9ucyB0byBy
ZWFkX3BtYygpLCBtYXRjaGluZw0KPiB0aGUgcHZfb3BzX21zciBtZW1iZXIgdGhleSBkaXNw
YXRjaCB0bywgYW5kIGFkZCBvbmUgcmRwbWMoKSBiZWxvdyB0aGUNCj4gZW5kaWYgaG9sZGlu
ZyB0aGUgdHJhY2Vwb2ludC4gbmF0aXZlX3JlYWRfcG1jKCkgaXMgdGhlbiBhbiB1bnRyYWNl
ZA0KPiBwcmltaXRpdmUgbmV4dCB0byBuYXRpdmVfcmRtc3JxKCkgYW5kIG5hdGl2ZV93cm1z
cnEoKS4gV291bGQgc29tZXRoaW5nDQo+IGxpa2UgdGhpcyBoZWxwPw0KDQpNeSBwYXRjaCBk
b2Vzbid0IGNoYW5nZSBhbnl0aGluZyBpbiB0aGlzIHJlZ2FyZCwgYXMgdGhlIFhlbiBQViBj
YXNlIGRpZG4ndA0Kd3JpdGUgdHJhY2UgZW50cmllcyBmb3IgcmVhZF9wbWMoKSBiZWZvcmUu
DQoNCk9UT0ggSSBhZ3JlZSB0aGF0IHRoaXMgaXMgbW9yZSBsaWtlIGFuIG92ZXJzaWdodCB0
aGFuIGEgZGVzaWduIGRlY2lzaW9uLA0Kc28gSSdsbCBkbyBzb21ldGhpbmcgYWxvbmcgdGhl
IGxpbmVzIHlvdSBhcmUgc3VnZ2VzdGluZyBiZWxvdy4NCg0KVGhhbmtzIGZvciB0aGUgcmV2
aWV3IQ0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmgg
Yi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3IuaA0KPiBpbmRleCBlYmEzMjVlY2ZlNGMuLjZm
NTBiNzAzZmJhOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmgN
Cj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmgNCj4gQEAgLTMwNSw4ICszMDUs
NyBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHU2NCBuYXRpdmVfcmVhZF9wbWMoaW50IGNv
dW50ZXIpDQo+ICAgCUVBWF9FRFhfREVDTEFSRV9BUkdTKHZhbCwgbG93LCBoaWdoKTsNCj4g
ICANCj4gICAJYXNtIHZvbGF0aWxlKCJyZHBtYyIgOiBFQVhfRURYX1JFVCh2YWwsIGxvdywg
aGlnaCkgOiAiYyIgKGNvdW50ZXIpKTsNCj4gLQlpZiAodHJhY2Vwb2ludF9lbmFibGVkKHJk
cG1jKSkNCj4gLQkJZG9fdHJhY2VfcmRwbWMoY291bnRlciwgRUFYX0VEWF9WQUwodmFsLCBs
b3csIGhpZ2gpLCAwKTsNCj4gKw0KPiAgIAlyZXR1cm4gRUFYX0VEWF9WQUwodmFsLCBsb3cs
IGhpZ2gpOw0KPiAgIH0NCj4gICANCj4gQEAgLTM0Myw3ICszNDIsNyBAQCBzdGF0aWMgX19h
bHdheXNfaW5saW5lIGludCB3cml0ZV9tc3Juc19zYWZlKHUzMiBtc3IsIHU2NCB2YWwpDQo+
ICAgCXJldHVybiBuYXRpdmVfd3Jtc3Juc19zYWZlKG1zciwgdmFsKTsNCj4gICB9DQo+ICAg
DQo+IC1zdGF0aWMgX19hbHdheXNfaW5saW5lIHU2NCByZHBtYyhpbnQgY291bnRlcikNCj4g
K3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdTY0IHJlYWRfcG1jKGludCBjb3VudGVyKQ0KPiAg
IHsNCj4gICAJcmV0dXJuIG5hdGl2ZV9yZWFkX3BtYyhjb3VudGVyKTsNCj4gICB9DQo+IEBA
IC00MTMsNiArNDEyLDE2IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgaW50IHdybXNybnNf
c2FmZSh1MzIgbXNyLCB1NjQgdmFsKQ0KPiAgIAlyZXR1cm4gZXJyOw0KPiAgIH0NCj4gICAN
Cj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdTY0IHJkcG1jKGludCBjb3VudGVyKQ0KPiAr
ew0KPiArCXU2NCB2YWwgPSByZWFkX3BtYyhjb3VudGVyKTsNCj4gKw0KPiArCWlmICh0cmFj
ZXBvaW50X2VuYWJsZWQocmRwbWMpKQ0KPiArCQlkb190cmFjZV9yZHBtYyhjb3VudGVyLCB2
YWwsIDApOw0KPiArDQo+ICsJcmV0dXJuIHZhbDsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBf
X2Fsd2F5c19pbmxpbmUgdm9pZCBzeW5jX2NwdV9hZnRlcl93cm1zcm5zKHZvaWQpDQo+ICAg
ew0KPiAgIAlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9XUk1TUk5TKSkN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0LW1zci5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQtbXNyLmgNCj4gaW5kZXggYmEzZWU2NDQ0
NmRiLi40NzIyMGJmMTZjZjMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3BhcmF2aXJ0LW1zci5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0
LW1zci5oDQo+IEBAIC0xNzIsNyArMTcyLDcgQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSBp
bnQgd3JpdGVfbXNybnNfc2FmZSh1MzIgbXNyLCB1NjQgdmFsKQ0KPiAgIAlyZXR1cm4gZXJy
ID8gLUVJTyA6IDA7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIF9fYWx3YXlzX2lubGluZSB1
NjQgcmRwbWMoaW50IGNvdW50ZXIpDQo+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIHU2NCBy
ZWFkX3BtYyhpbnQgY291bnRlcikNCj4gICB7DQo+ICAgCXJldHVybiBQVk9QX0NBTEwxKHU2
NCwgcHZfb3BzX21zciwgcmVhZF9wbWMsIGNvdW50ZXIpOw0KPiAgIH0NCj4gDQo+IA0KPiBJ
IGhhdmUgbm8gWGVuIFBWIGd1ZXN0LCBzbyB0aGF0IHBhdGggaXMgdW50ZXN0ZWQuIFdoYXQg
SSBkaWQgY2hlY2sgaXMgdGhhdA0KPiB0aGUgX190cmFjZXBvaW50X3JkcG1jIHJlbG9jYXRp
b24gc2hvd3MgdXAgaW4gYXJjaC94ODYvZXZlbnRzL2NvcmUubyB3aXRoDQo+IENPTkZJR19Q
QVJBVklSVF9YWEw9eSwgd2hlcmUgaXQgcHJldmlvdXNseSBkaWQgbm90LCBhbmQgdGhhdCB4
ODZfNjQNCj4gZGVmY29uZmlnIHN0aWxsIGJ1aWxkcyBjbGVhbiB3aXRoIGdjYyBhbmQgY2xh
bmcuDQoNCg0KSnVlcmdlbg0K
--------------6A9BMhW60Yidnn0G0XHNy8l6
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R3/CwO0EGAEIACAWIQSFEmdy6PYElKXQl/ew3p3W
KL8TLwUCWt3w0AIbAgCBCRCw3p3WKL8TL3YgBBkWCAAdFiEEUy2wekH2OPMeOLge
gFxhu0/YY74FAlrd8NAACgkQgFxhu0/YY75NiwD/fQf/RXpyv9ZX4n8UJrKDq422
bcwkujisT6jix2mOOwYBAKiip9+mAD6W5NPXdhk1XraECcIspcf2ff5kCAlG0DIN
aTUH/RIwNWzXDG58yQoLdD/UPcFgi8GWtNUp0Fhc/GeBxGipXYnvuWxwS+Qs1Qay
7/Nbal/v4/eZZaWs8wl2VtrHTS96/IF6q2o0qMey0dq2AxnZbQIULiEndgR625EF
RFg+IbO4ldSkB3trsF2ypYLij4ZObm2casLIP7iB8NKmQ5PndL8Y07TtiQ+Sb/wn
g4GgV+BJoKdDWLPCAlCMilwbZ88Ijb+HF/aipc9hsqvW/hnXC2GajJSAY3Qs9Mib
4Hm91jzbAjmp7243pQ4bJMfYHemFFBRaoLC7ayqQjcsttN2ufINlqLFPZPR/i3IX
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------6A9BMhW60Yidnn0G0XHNy8l6--

--------------NelZ0fzD6woPS0DUZIm6Q4Lz--

--------------iiBhoS9kLqdyghYbKwaF8gWa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmq2c9kFAwAAAAAACgkQsN6d1ii/Ey+w
HQf/S5suXrw/D3OPWt9G09ppfnEHld9MrxO4MMUTYMwjDksNaZHOQo4l8cHMHSzdtK8MxsH52JGq
f2ldmvSrldYyLjfq/cjwjwq3gLQ8ox2sZyfwMj2D7XTvMoS8n084y4iI4JlamFl3PdDyMQc4SiBD
jTcwffu5qsRjTW+v2cdWP91hUq46ExjP1D19ROifBh+fyz6DFmlPSaAXuZo0PE+gavcD/05zKmnm
bWvNoimw8OQMPQoFX9IItsB1msLU2kau2zQmm3Il6MkYIixSl+S0q2oJkGnUbwRA+NfCowWrk6TO
EUGleuP54Z9ptbpUpuw14Ux763yFV5TSZyxhTuaL7g==
=8pHm
-----END PGP SIGNATURE-----

--------------iiBhoS9kLqdyghYbKwaF8gWa--
