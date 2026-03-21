Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0B36DA05
	for <virtualization@lists.linux.dev>; Sat, 21 Mar 2026 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774074213; cv=none; b=KIhOE2CynrwW/+iXvdvDEInFJ5uuZ2F4caBc7C8nWHDmvDeKpih457Bh7RUDydzsrnsTm8iEdWv0B4ree/XAQtrlKliqTs1l28CegYh0O/xcgzT8nC0fTRN0ORLSRtOAXX3VsvI4hjM8udzQPWSXa0epYf0KjnDqfLDzYrjVuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774074213; c=relaxed/simple;
	bh=81tl9UfPBvtQWIWrhLh6LXG/mOlww3R54RFsOp+rLKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpnAQb/crWDpEGWROmoKQwenMW3PxxZ7YLZxOFlmxhj7aChRLb+H9/h+Q7SgT8LD+PDZ/zOT+cMshJ4seTyxq/Kk/FmWcv6jpG2jHFQINKWs/ebqRoFl98FzZkRcMB5wpkQldih/wp/BIK+S5LuBhA7dskPUhEH1NCRXg7MyF30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RdH3+l5O; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RdH3+l5O"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-668e55bd36bso1370793a12.3
        for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 23:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774074208; x=1774679008; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=81tl9UfPBvtQWIWrhLh6LXG/mOlww3R54RFsOp+rLKg=;
        b=RdH3+l5OCfTXAl88h55yAOCPjLSbEpUjrM2zgUTr/4FrPvC2L2LK+zKwz5tGawRhJq
         YixV5SgDQ9zPz5ogU/7l8kWfpsBFIbuoxinFtMwwnYxlOT5bvMxVC1uUTNuDg0hnzHys
         eA7wAhvsPyzabMf5XALqk7PewvBtJlUg7KeQVEwKMiRSj58nGx8zluEjv3kmL2cfM74c
         IkZoJa2mum1si4OARpfRucOJzUwoXSqAFFKlmwmqUZVkaMqi8Cn3qtK/DkvDJb7l9TMN
         tJQj6POL1FJRdVNvF05bcfDcO8UwY01yahmIQ5dyQU93+mG6DRHj1x7o9+35FNdM+eKb
         pIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774074208; x=1774679008;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81tl9UfPBvtQWIWrhLh6LXG/mOlww3R54RFsOp+rLKg=;
        b=PXogJRH/pr50MOO8pb82Ki7KUmncExC5FM2bQcXdHaKV6cGNplQuv/bPPg9efuZobS
         XFUaN/sTsgMMeBwehbNwqw+K58OMs4uOK0nEVnJso4MmiBfcIlE/jCXAEKwsqrR17yjM
         cfw161RQSyXFpmk1Fyab5bFYNAkxbFt6p+cYhQkErFbCRdr4fLpBpLkBYQqYC2+TAYTa
         3jMqz72ZKgO9/K0IqGjFc3R1emYYd3zVGSN7jhLcJUcE2BrT1PscCU4gYKF51KhZGMUg
         Q5Tdw8OSMAzXl7SHwpK4FJm2w9mSvAs4JDocdLHTgFFNk7KttMrXABXraOCvjr2Cc1gm
         l0zg==
X-Forwarded-Encrypted: i=1; AJvYcCVs4sTz6a45c0GH9ZqEDH+xBK2vud6Glb9GR4i750C6N5CAS3drJ3AAclmXLt7JGn92CleF6caXPAPnlIRZrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7BqVg+YoZZO6k1xZcoq5ajUhykLUwwDGIiNaokrG7fsKgQiMk
	oiolGgXfbCNUGk00Ghe++iDhgG+5oJ8+Q6K2tPWxpNJmIXE9Q5BRKsi+wZgEI2g5m+c=
X-Gm-Gg: ATEYQzzgtir9pohhQC7cn8HPgVn4GxJNo/YKEf59vpq222NUrqpQO4KNxAO5TLsXEKS
	OcNYMq6oYALbCAtfuWf/aykjeefZArw0Hq77l2A3hDsZSVjiuSlw0xZcMgk9NBldU81rY+s6svJ
	MhtNLL/rnTyJclTKjdD4ybNvz+z0RFnZJFSRkElYCNyXFk4wouWlGmgQCAmN7VQjDaqk3pwBDVR
	7KQlbq31HyjTInhPtTHptDVhK+9DL291gOl0FRYm9AbqQlAoA+N270c4ux2uZ0Na254prH9zPuZ
	Sr/4XmQk3KGL/x2x68Dr6xXTDpz7rEQ/jT0wTXC/ecS6UdHIdA0HWtuP+A73Y2d3sftbNjbTNE3
	gUz4vqifm2Qw8jNUCEBQs3ZEA4uxlBfYsUirjURwaQX30NbaatCaK5vKwUvSpkCBxdEa18JZqSS
	xOGI7DLO0/WHmpbL7xlTtYcZeCFW+ynT0mDPFhGhs8WzJnKM0ZT8hTCjQn413iYtwJrxo9I8KLB
	dV5Q0IwLWnDQMt7Q3nvJnLBs5w9R9JTdgBjhVlR2d8BbmAmoaqBZw==
X-Received: by 2002:a17:907:874f:b0:b98:4b8:103a with SMTP id a640c23a62f3a-b982f2ecf45mr347739166b.37.1774074208147;
        Fri, 20 Mar 2026 23:23:28 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f43b5csm239804766b.1.2026.03.20.23.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 23:23:27 -0700 (PDT)
Message-ID: <4c26ba32-d15f-496f-9f83-211c51a58673@suse.com>
Date: Sat, 21 Mar 2026 07:23:26 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] x86/msr: Consolidate native/paravirt MSR functions
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 virtualization@lists.linux.dev
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
 <20260320233319.GZab3ZP1lTfxOmQ4YF@fat_crate.local>
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
In-Reply-To: <20260320233319.GZab3ZP1lTfxOmQ4YF@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Z0lCcptd8xsbpYPWxCthSxku"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Z0lCcptd8xsbpYPWxCthSxku
Content-Type: multipart/mixed; boundary="------------MdcCrcEppjvG18b0Vyp3EQFp";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 virtualization@lists.linux.dev
Message-ID: <4c26ba32-d15f-496f-9f83-211c51a58673@suse.com>
Subject: Re: [PATCH 0/8] x86/msr: Consolidate native/paravirt MSR functions
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
 <20260320233319.GZab3ZP1lTfxOmQ4YF@fat_crate.local>
In-Reply-To: <20260320233319.GZab3ZP1lTfxOmQ4YF@fat_crate.local>

--------------MdcCrcEppjvG18b0Vyp3EQFp
Content-Type: multipart/mixed; boundary="------------xdUnzVYgEOIudBqHSRCCsleA"

--------------xdUnzVYgEOIudBqHSRCCsleA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDMuMjYgMDA6MzMsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gRnJpLCBN
YXIgMjAsIDIwMjYgYXQgMTI6MDM6MzBQTSAtMDcwMCwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+
PiBUaGlzIGlzIG9sZCBjcnVmdCwgYnV0IGl0IGFwcGVhcnMgdGhhdCBoYXZpbmcgdHdvIGNv
cGllcyBvZiB0aGVzZQ0KPj4gTVNSIGZ1bmN0aW9ucyBpcyBlbmFibGluZyB3YXJuaW5ncyB0
byBjcmVlcCBpblsxXS4NCj4+DQo+PiBJIGtub3cgdGhlcmUncyBhbHNvIGJlZW4gc29tZSB3
b3JrIHRvIHBhcmUgZG93biB0aGUgWFhMIGNvZGUsIGJ1dA0KPj4gaXQncyBvYnZpb3VzbHkg
bm90IG1lcmdlZCB5ZXQgYW5kIHRoaXMgaXMgYSBnb29kIGJhYnkgc3RlcC4NCj4+DQo+PiBD
cmVhdGUgaGVscGVycyB0aGF0IGJvdGggcGFyYXZpcnQgYW5kIG5hdGl2ZSBjYW4gdXNlIGlu
IGNvbW1vbiBjb2RlDQo+PiBhbmQgcmVtb3ZlIHRoZSBwYXJhdmlydCBpbXBsZW1lbnRhdGlv
bnMgb2YgdGhlIGhlbHBlcnMuIFRoaXMgcmVkdWNlcw0KPj4gdGhlIGFtb3VudCBvZiBsb2dp
YyB0aGF0IGlzIGR1cGxpY2F0ZWQgaW4gdGhlIHBhcmF2aXJ0IGNvZGUuDQo+Pg0KPj4gVGhl
IG90aGVyIHRoaW5nIEkgcmVhbGx5IGxpa2UgYWJvdXQgdGhpcyBpcyB0aGF0IGl0IHB1dHMg
dGhlDQo+PiByYXc9PntuYXRpdmUscGFyYXZpcnR9IHN3aXRjaCBpbiBvbmUgY29tcGFjdCBw
bGFjZSBpbiB0aGUgY29kZS4NCj4+DQo+PiBDb25jZXB0dWFsbHk6DQo+PiAgIC0gICBuYXRp
dmU6IFRoZSBiYXJlLW1ldGFsIGltcGxlbWVudGF0aW9uLiBNaWdodCBub3QgYmUgdXNhYmxl
IHVuZGVyDQo+PiAJICAgICBwYXJhdmlydCBYWEwuDQo+PiAgIC0gICAgICByYXc6IFRoZSBs
b3dlc3QtbGV2ZWwgZnVuY3Rpb24gdGhhdCBpcyBhbHdheXMgdXNhYmxlLiBNaWdodA0KPj4g
CSAgICAgYmUgbmF0aXZlIG9yIHBhcmF2aXJ0IHVuZGVyIHRoZSBob29kLg0KPiANCj4gSSB3
ZW50IHRocm91Z2ggdGhlIHBhdGNoc2V0IHR3aWNlIGFuZCBJIGtpbmRhIGdldCB3aGF0IHlv
dSdyZSB0cnlpbmcgdG8gZG8gYnV0DQo+IHRoZSAicmF3IiB0aGluZyBpcyBjb25mdXNpbmcg
YXMgaGVsbC4NCj4gDQo+IFRvIG1lICJyYXciIG1lYW5zLCB0aGUgbG93ZXN0IGxldmVsIG9m
IHRoZSBmdW5jdGlvbmFsaXR5IC0gc29tZXRoaW5nIGxpa2UNCj4gX188ZnVuY3Rpb25fbmFt
ZT4gd2l0aCB0aGUgdHdvIHVuZGVyc2NvcmVzLiBPciB0aHJlZSwgZGVwZW5kaW5nIG9uIHRo
ZQ0KPiBpbmRpcmVjdGlvbiBsZXZlbHMuDQo+IA0KPiBBbmQgdGhvc2UgZG8gKm9ubHkqICpy
YXcqIGluc3RydWN0aW9ucyAtIG5vIG1vcmUgaW5kaXJlY3Rpb25zLg0KPiANCj4gQnV0IHRo
ZW4gaG93IGNhbiAicmF3IiBiZSB0aGUgbG93ZXN0IGxldmVsIGFuZCB0aGVuIHN0aWxsIGhh
dmUgc29tZXRoaW5nIGVsc2UNCj4gdW5kZXJuZWF0aCAtIG5hdGl2ZV8gYW5kIHBhcmF2aXJ0
Xz8NCj4gDQo+IEkgKnRoaW5rKiB0aGlzIGlzIG9ubHkgYSBuYW1pbmcgaXNzdWUgYW5kIHdp
dGggInJhd18iIHlvdSBwcm9iYWJseSB3YW5uYSBzYXkNCj4gIm5hdGl2ZV9vcl9wYXJhdmly
dF8iIGRlcGVuZGluZyBvbiB0aGUgaWZkZWZmZXJ5Li4uIGJ1dCBzaG9ydGVyLi4uDQo+IA0K
PiBJZiBzbywgSSB3b3VsZG4ndCBjYWxsIGl0ICJyYXciLiBJJ2Qgc2F5DQo+IA0KPiB4eF9y
ZWFkX21zcigpDQo+IHh4X3dyaXRlX21zcigpDQo+IA0KPiB0byBkZW5vdGUgdGhhdCB0aGUg
Inh4IiByZXNvbHZlcyB0byBlaXRoZXIgb2YgdGhlIHR3byB0eXBlcy4gQnV0IGEgYmV0dGVy
DQo+IG5hbWUuIEkgY2FuJ3QgdGhpbmsgb2YgYSBnb29kIG9uZSBub3cgYnV0IEkga25vdyB0
aGF0ICJyYXciIGlzbid0IGl0Li4uDQo+IA0KPiBIbW1tLg0KPiANCg0KSSdkIGxpa2UgdG8g
c3VnZ2VzdCB0byBkbyBhIG1ham9yIGNsZWFudXAgb2YgdGhlIE1TUiBpbnRlcmZhY2VzLiBX
ZSBoYXZlIHRvbw0KbWFueSBvZiB0aGVtIGRvaW5nIHNpbWlsYXIgdGhpbmdzLiBTb21lIGFy
ZSBjYXBhYmxlIHRvIGRvIHRyYWNpbmcsIHNvbWUgYXJlbid0Lg0KU29tZSBhcmUgcGFyYXZp
cnQgY2FwYWJsZSwgc29tZSBhcmVuJ3QuIEFuZCB0aGUgbmFtZXMgb2YgdGhvc2UgZnVuY3Rp
b25zIGRvbid0DQpyZWZsZWN0IHRoYXQgYXQgYWxsLiBXZSBldmVuIGhhdmUgbXVsdGlwbGUg
ZnVuY3Rpb25zIG9yIG1hY3JvcyBkb2luZyBleGFjdGx5DQp0aGUgc2FtZSB0aGluZywgYnV0
IGhhdmluZyBkaWZmZXJlbnQgbmFtZXMuDQoNCkFuZCBpbiBmdXR1cmUgaXQgd2lsbCBiZSBl
dmVuIG1vcmUgY29tcGxpY2F0ZWQgZHVlIHRvIHRoZSB3cml0ZSBNU1IgaW50ZXJmYWNlcw0K
bmVlZGluZyBzZXJpYWxpemluZyBhbmQgbm9uLXNlcmlhbGl6aW5nIHZhcmlhbnRzLg0KDQpN
eSBpZGVhIHdvdWxkIGJlIHRvIGhhdmUgc29tZXRoaW5nIGxpa2U6DQoNCm1zcl9yZWFkKCkN
Cm1zcl9yZWFkX25vdHJhY2UoKQ0KbXNyX3dyaXRlX3N5bmMoKQ0KbXNyX3dyaXRlX25vc3lu
YygpDQptc3Jfd3JpdGVfc3luY19ub3RyYWNlKCkNCm1zcl93cml0ZV9ub3N5bmNfbm90cmFj
ZSgpDQoNCkFsbCBvZiB0aG9zZSBzaG91bGQgYmUgcGFyYXZpcnQgY2FwYWJsZSBhbmQgdGhl
eSBzaG91bGQgYmUgdGhlIG9ubHkgIm9mZmljaWFsIg0KaW50ZXJmYWNlcy4gVGhleSB3aWxs
IGRlcGVuZCBvbiBsb3ctbGV2ZWwgcHJpbWl0aXZlcywgYnV0IHRob3NlIHNob3VsZCBiZSB1
c2VkDQpvbmx5IGJ5IHRoZSBvZmZpY2lhbCBhY2Nlc3MgZnVuY3Rpb25zIGFuZCBtYXliZSBp
biBzb21lIHZlcnkgc3BlY2lhbCBwbGFjZXMuDQoNCkkgdGhpbmsgdGhpcyBzaG91bGQgYmUg
dGhlIGZpcnN0IHN0ZXAgdG93YXJkcyBhIE1TUiBhY2Nlc3MgY29uc29saWRhdGlvbiwgYXMN
Cml0IGFsbG93cyBhbnkgaW50ZXJuYWwgb3B0aW1pemF0aW9ucyBhbmQgY2hhbmdlcyB3aXRo
b3V0IGZ1cnRoZXIgYm90aGVyaW5nIG1vc3QNCm9mIHRoZSB1c2Vycy4NCg0KDQpKdWVyZ2Vu
DQo=
--------------xdUnzVYgEOIudBqHSRCCsleA
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------xdUnzVYgEOIudBqHSRCCsleA--

--------------MdcCrcEppjvG18b0Vyp3EQFp--

--------------Z0lCcptd8xsbpYPWxCthSxku
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmm+OV4FAwAAAAAACgkQsN6d1ii/Ey9R
QAf+PRCUl+Ym1J2LjQfa3l5f1IEkt6w9IVrN0hZhLCyjSrrPOzOMbRt9xjtCa8OHjwIyD9FERpyY
tlguiPskL0y7z1d1xbGZzGhnsM4aUo3d+ZLSvDba0yfhW0C15d/igDOE/EBDczjyPKYGJXajRUgC
qSszcOetXsxv6kCN1L8DsqC/D7/y9d5FDce+BiOhjZPL7Dzf0BNLWqPvTphUNF3Y8SV3G9OnkjJ7
XoUvxzBtIxQ7hANx7l3lXfuH3yLexOTh3a/aCViDcKQfl5lwc19Sqny385Cc87pmdkSL6jZOYIs7
dPCpQJdwXgcbTkJh3V2q/yWnUlomcIykQjItFwG0wQ==
=Sz4e
-----END PGP SIGNATURE-----

--------------Z0lCcptd8xsbpYPWxCthSxku--
