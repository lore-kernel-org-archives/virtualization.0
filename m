Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28918248896
	for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279348; cv=none; b=nLOegzr3hhBLwO3NzCFJOGmQdbgpAbYqRI9OAdFNo4uVdpJYlW+vGcC9t3w+Hf3YIvmNAi4+lChWw6vsQ6hmLNcww8FdfB2gWjAOs5Rw4IBocOqFAI+aZkHn+m94ATLqHdWhiq99zmYdHrtz/GhQ1DbBWyrKyPH7Zo/2U59lZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279348; c=relaxed/simple;
	bh=bktkDmgC+xkgdS//TiUTKsCNSJv1UtOSrUFAOgDIH7k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D2dGJEwd/ig0RNNkc2Ubs1T/rC1qT1/1FkJc/qDjj6BOCxgSmNdg/DBKlEQv/4tLYK97mqq6YZbg0FBAfv8jZbT/4Bda+0JpKRPU5QL5PanunagxZUio9Vv7GhEtrA0H1atpnzrNuKBaJjYPoRXUrd6L+578ZL7aLJ58CzSeKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VM8VFTs2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VM8VFTs2"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6644a3029b3so6672494a12.0
        for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774279345; x=1774884145; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bktkDmgC+xkgdS//TiUTKsCNSJv1UtOSrUFAOgDIH7k=;
        b=VM8VFTs2ebzIIWUNf/pDROc9kK+SrWFI3iaCQy5NWQmENfVrOxMkJ8kMZRCvJAs2MX
         BfaIiLbqE8G91pHwgMRFmc+Zbk26o9wzfwMH43kPn4tC1KgbVskSmz9QBvtzFB2/iZw8
         5ZnVJjmjPFVSxj5EKojH6yETjaLQL886yYrxvkaTzz5Ff3sQF6K9Pk1BzoCjgtCdOikS
         tSk6pQ0zNbhkFJbVD72xMr8tkLXp/fkew0QDYUh16AfuDZURK0zQOmqMTbGSV4Av/tYj
         2SU04ewqhkOyY8YWVOx/c8FoT/zpD0jjgo/mHecHmfZu+MT3KYfO+16A/JuaLHqtIWZi
         hF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279345; x=1774884145;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bktkDmgC+xkgdS//TiUTKsCNSJv1UtOSrUFAOgDIH7k=;
        b=BnmG8qPclNqn0eVKYg4LBP6GAAFj9c0UfAe31PB05PLXImS5qqtpajIYJNQVtE7v0G
         K8ti2J+HS6BtVUTXa4ioTXhwyC9aCH5tjnuEFtQEjXCjUB3kaxeB5NHno2mDFHvaIIJs
         W9Y8RuVs0xaNLDyJkWK87OumjmrMLJLjzf0Ka3WtsZUJAxVXyKbZDm+mz5/pUhkfBG+8
         btzxmCcapJmzwQbnjqBqiIO0a31fhVStFpmhxKjP1jaelI+Y+vF6tCHfokd+4+JW0Awh
         dpkdihKv+8N9XoglWnLuhg0HoEAFQ/NoCulUIok719R5unUHdPMoUaX0J+FRoaMYmlPr
         vXrg==
X-Forwarded-Encrypted: i=1; AJvYcCXPpSf7JKtAZkFLckuuKgzxKkd609bDc2jQeauCLKoUFoLHhhReflkc8akjaViFCZWYnoWN16qzrH2cFK0a8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPZo/l8KLMzSrKar79zQIwF+7dNGFDyew46f82T/Jda3lJQ8eq
	1P/iVAuiaSXK2Xa6kNQP8w1dK+msN/Y7FiWMUlnr/15VHRwlEDmQZxTZVFr6+OCM1os=
X-Gm-Gg: ATEYQzwSsjtTQ7ZKFfZbpmou5VOr/y+x2EAGU4iFKk79SQzYS3PjHVb4GcPDF+O0n5v
	1A3LGqva5vAjZ2CmRVnNfDHmDY+IfxnjykgboqHE5P/uAPAIG8yufZy8bT9NgJ/rjgqee+QcmvP
	fGc7mo5I38nzSTYPnLJLLOMO1ja0E/GibvxVBxSyNOEplFJ4OIH0F8kCVvMrkAOotSGdXUI2DtN
	I8+izECqdobfyCUHii3W898coRfdM13XPMv/iv18z3YbP7l1MrkfyCljvAaD42vY+mFDd3VMS0j
	kg32nLVdgkBb28LSewh7+PnL+JRd3w8IrvCPAuagh5+LGHvx54ue9O8oA0wJkfFLdx2CC7mQor+
	r/EJjrifOQgtK3+328xcApxvHmqkEzfOOtXouXS1fPAhUDtDwqOJIoKdfru8gpsfBOrmQ19rsZJ
	Pv9bmC2ETK+fYGF2bfYcTUSvR/7ouy5jwjLichQsxwkgoOwMkeWEQu8LcDS/K40qmu8nhVLkrX7
	rWGCem4E3tTr0xzDElsKNcDZsCj6w2SazbZ3S7Yiy4mtM4CFNsc2w==
X-Received: by 2002:a05:6402:52d4:b0:665:20dc:cb44 with SMTP id 4fb4d7f45d1cf-668c9930458mr8396581a12.29.1774279345353;
        Mon, 23 Mar 2026 08:22:25 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6694b45de66sm2433186a12.31.2026.03.23.08.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 08:22:25 -0700 (PDT)
Message-ID: <998670da-2d28-4850-bf25-ee66fea7267d@suse.com>
Date: Mon, 23 Mar 2026 16:22:24 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] x86/msr: Consolidate native/paravirt MSR functions
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 virtualization@lists.linux.dev
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
 <20260320233319.GZab3ZP1lTfxOmQ4YF@fat_crate.local>
 <4c26ba32-d15f-496f-9f83-211c51a58673@suse.com>
Content-Language: en-US
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
In-Reply-To: <4c26ba32-d15f-496f-9f83-211c51a58673@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------f0hjJ9r0ELBKvOB9nbOpeHTi"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------f0hjJ9r0ELBKvOB9nbOpeHTi
Content-Type: multipart/mixed; boundary="------------JsT7B7xdZVYOsfV0skJqY2dr";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 virtualization@lists.linux.dev
Message-ID: <998670da-2d28-4850-bf25-ee66fea7267d@suse.com>
Subject: Re: [PATCH 0/8] x86/msr: Consolidate native/paravirt MSR functions
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
 <20260320233319.GZab3ZP1lTfxOmQ4YF@fat_crate.local>
 <4c26ba32-d15f-496f-9f83-211c51a58673@suse.com>
In-Reply-To: <4c26ba32-d15f-496f-9f83-211c51a58673@suse.com>

--------------JsT7B7xdZVYOsfV0skJqY2dr
Content-Type: multipart/mixed; boundary="------------A97dO0l0qcqLHXIiTzy0qHjA"

--------------A97dO0l0qcqLHXIiTzy0qHjA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDMuMjYgMDc6MjMsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+IE9uIDIxLjAzLjI2
IDAwOjMzLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+PiBPbiBGcmksIE1hciAyMCwgMjAy
NiBhdCAxMjowMzozMFBNIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4+PiBUaGlzIGlz
IG9sZCBjcnVmdCwgYnV0IGl0IGFwcGVhcnMgdGhhdCBoYXZpbmcgdHdvIGNvcGllcyBvZiB0
aGVzZQ0KPj4+IE1TUiBmdW5jdGlvbnMgaXMgZW5hYmxpbmcgd2FybmluZ3MgdG8gY3JlZXAg
aW5bMV0uDQo+Pj4NCj4+PiBJIGtub3cgdGhlcmUncyBhbHNvIGJlZW4gc29tZSB3b3JrIHRv
IHBhcmUgZG93biB0aGUgWFhMIGNvZGUsIGJ1dA0KPj4+IGl0J3Mgb2J2aW91c2x5IG5vdCBt
ZXJnZWQgeWV0IGFuZCB0aGlzIGlzIGEgZ29vZCBiYWJ5IHN0ZXAuDQo+Pj4NCj4+PiBDcmVh
dGUgaGVscGVycyB0aGF0IGJvdGggcGFyYXZpcnQgYW5kIG5hdGl2ZSBjYW4gdXNlIGluIGNv
bW1vbiBjb2RlDQo+Pj4gYW5kIHJlbW92ZSB0aGUgcGFyYXZpcnQgaW1wbGVtZW50YXRpb25z
IG9mIHRoZSBoZWxwZXJzLiBUaGlzIHJlZHVjZXMNCj4+PiB0aGUgYW1vdW50IG9mIGxvZ2lj
IHRoYXQgaXMgZHVwbGljYXRlZCBpbiB0aGUgcGFyYXZpcnQgY29kZS4NCj4+Pg0KPj4+IFRo
ZSBvdGhlciB0aGluZyBJIHJlYWxseSBsaWtlIGFib3V0IHRoaXMgaXMgdGhhdCBpdCBwdXRz
IHRoZQ0KPj4+IHJhdz0+e25hdGl2ZSxwYXJhdmlydH0gc3dpdGNoIGluIG9uZSBjb21wYWN0
IHBsYWNlIGluIHRoZSBjb2RlLg0KPj4+DQo+Pj4gQ29uY2VwdHVhbGx5Og0KPj4+IMKgIC3C
oMKgIG5hdGl2ZTogVGhlIGJhcmUtbWV0YWwgaW1wbGVtZW50YXRpb24uIE1pZ2h0IG5vdCBi
ZSB1c2FibGUgdW5kZXINCj4+PiDCoMKgwqDCoMKgwqDCoMKgIHBhcmF2aXJ0IFhYTC4NCj4+
PiDCoCAtwqDCoMKgwqDCoCByYXc6IFRoZSBsb3dlc3QtbGV2ZWwgZnVuY3Rpb24gdGhhdCBp
cyBhbHdheXMgdXNhYmxlLiBNaWdodA0KPj4+IMKgwqDCoMKgwqDCoMKgwqAgYmUgbmF0aXZl
IG9yIHBhcmF2aXJ0IHVuZGVyIHRoZSBob29kLg0KPj4NCj4+IEkgd2VudCB0aHJvdWdoIHRo
ZSBwYXRjaHNldCB0d2ljZSBhbmQgSSBraW5kYSBnZXQgd2hhdCB5b3UncmUgdHJ5aW5nIHRv
IGRvIGJ1dA0KPj4gdGhlICJyYXciIHRoaW5nIGlzIGNvbmZ1c2luZyBhcyBoZWxsLg0KPj4N
Cj4+IFRvIG1lICJyYXciIG1lYW5zLCB0aGUgbG93ZXN0IGxldmVsIG9mIHRoZSBmdW5jdGlv
bmFsaXR5IC0gc29tZXRoaW5nIGxpa2UNCj4+IF9fPGZ1bmN0aW9uX25hbWU+IHdpdGggdGhl
IHR3byB1bmRlcnNjb3Jlcy4gT3IgdGhyZWUsIGRlcGVuZGluZyBvbiB0aGUNCj4+IGluZGly
ZWN0aW9uIGxldmVscy4NCj4+DQo+PiBBbmQgdGhvc2UgZG8gKm9ubHkqICpyYXcqIGluc3Ry
dWN0aW9ucyAtIG5vIG1vcmUgaW5kaXJlY3Rpb25zLg0KPj4NCj4+IEJ1dCB0aGVuIGhvdyBj
YW4gInJhdyIgYmUgdGhlIGxvd2VzdCBsZXZlbCBhbmQgdGhlbiBzdGlsbCBoYXZlIHNvbWV0
aGluZyBlbHNlDQo+PiB1bmRlcm5lYXRoIC0gbmF0aXZlXyBhbmQgcGFyYXZpcnRfPw0KPj4N
Cj4+IEkgKnRoaW5rKiB0aGlzIGlzIG9ubHkgYSBuYW1pbmcgaXNzdWUgYW5kIHdpdGggInJh
d18iIHlvdSBwcm9iYWJseSB3YW5uYSBzYXkNCj4+ICJuYXRpdmVfb3JfcGFyYXZpcnRfIiBk
ZXBlbmRpbmcgb24gdGhlIGlmZGVmZmVyeS4uLiBidXQgc2hvcnRlci4uLg0KPj4NCj4+IElm
IHNvLCBJIHdvdWxkbid0IGNhbGwgaXQgInJhdyIuIEknZCBzYXkNCj4+DQo+PiB4eF9yZWFk
X21zcigpDQo+PiB4eF93cml0ZV9tc3IoKQ0KPj4NCj4+IHRvIGRlbm90ZSB0aGF0IHRoZSAi
eHgiIHJlc29sdmVzIHRvIGVpdGhlciBvZiB0aGUgdHdvIHR5cGVzLiBCdXQgYSBiZXR0ZXIN
Cj4+IG5hbWUuIEkgY2FuJ3QgdGhpbmsgb2YgYSBnb29kIG9uZSBub3cgYnV0IEkga25vdyB0
aGF0ICJyYXciIGlzbid0IGl0Li4uDQo+Pg0KPj4gSG1tbS4NCj4+DQo+IA0KPiBJJ2QgbGlr
ZSB0byBzdWdnZXN0IHRvIGRvIGEgbWFqb3IgY2xlYW51cCBvZiB0aGUgTVNSIGludGVyZmFj
ZXMuIFdlIGhhdmUgdG9vDQo+IG1hbnkgb2YgdGhlbSBkb2luZyBzaW1pbGFyIHRoaW5ncy4g
U29tZSBhcmUgY2FwYWJsZSB0byBkbyB0cmFjaW5nLCBzb21lIGFyZW4ndC4NCj4gU29tZSBh
cmUgcGFyYXZpcnQgY2FwYWJsZSwgc29tZSBhcmVuJ3QuIEFuZCB0aGUgbmFtZXMgb2YgdGhv
c2UgZnVuY3Rpb25zIGRvbid0DQo+IHJlZmxlY3QgdGhhdCBhdCBhbGwuIFdlIGV2ZW4gaGF2
ZSBtdWx0aXBsZSBmdW5jdGlvbnMgb3IgbWFjcm9zIGRvaW5nIGV4YWN0bHkNCj4gdGhlIHNh
bWUgdGhpbmcsIGJ1dCBoYXZpbmcgZGlmZmVyZW50IG5hbWVzLg0KPiANCj4gQW5kIGluIGZ1
dHVyZSBpdCB3aWxsIGJlIGV2ZW4gbW9yZSBjb21wbGljYXRlZCBkdWUgdG8gdGhlIHdyaXRl
IE1TUiBpbnRlcmZhY2VzDQo+IG5lZWRpbmcgc2VyaWFsaXppbmcgYW5kIG5vbi1zZXJpYWxp
emluZyB2YXJpYW50cy4NCj4gDQo+IE15IGlkZWEgd291bGQgYmUgdG8gaGF2ZSBzb21ldGhp
bmcgbGlrZToNCj4gDQo+IG1zcl9yZWFkKCkNCj4gbXNyX3JlYWRfbm90cmFjZSgpDQo+IG1z
cl93cml0ZV9zeW5jKCkNCj4gbXNyX3dyaXRlX25vc3luYygpDQo+IG1zcl93cml0ZV9zeW5j
X25vdHJhY2UoKQ0KPiBtc3Jfd3JpdGVfbm9zeW5jX25vdHJhY2UoKQ0KDQpPaCwgSSBtaXNz
ZWQgdGhlICJzYWZlIiB2YXJpYW50cy4NCg0KQXQgdGhlIHNhbWUgdGltZSBtYXliZSB0aGUg
Im5vdHJhY2UiIHZhcmlhbnRzIGFyZW4ndCBldmVuIG5lZWRlZCBhdCB0aGlzDQpsZXZlbD8N
Cg0KPiANCj4gQWxsIG9mIHRob3NlIHNob3VsZCBiZSBwYXJhdmlydCBjYXBhYmxlIGFuZCB0
aGV5IHNob3VsZCBiZSB0aGUgb25seSAib2ZmaWNpYWwiDQo+IGludGVyZmFjZXMuIFRoZXkg
d2lsbCBkZXBlbmQgb24gbG93LWxldmVsIHByaW1pdGl2ZXMsIGJ1dCB0aG9zZSBzaG91bGQg
YmUgdXNlZA0KPiBvbmx5IGJ5IHRoZSBvZmZpY2lhbCBhY2Nlc3MgZnVuY3Rpb25zIGFuZCBt
YXliZSBpbiBzb21lIHZlcnkgc3BlY2lhbCBwbGFjZXMuDQo+IA0KPiBJIHRoaW5rIHRoaXMg
c2hvdWxkIGJlIHRoZSBmaXJzdCBzdGVwIHRvd2FyZHMgYSBNU1IgYWNjZXNzIGNvbnNvbGlk
YXRpb24sIGFzDQo+IGl0IGFsbG93cyBhbnkgaW50ZXJuYWwgb3B0aW1pemF0aW9ucyBhbmQg
Y2hhbmdlcyB3aXRob3V0IGZ1cnRoZXIgYm90aGVyaW5nIG1vc3QNCj4gb2YgdGhlIHVzZXJz
Lg0KPiANCj4gDQo+IEp1ZXJnZW4NCg0K
--------------A97dO0l0qcqLHXIiTzy0qHjA
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------A97dO0l0qcqLHXIiTzy0qHjA--

--------------JsT7B7xdZVYOsfV0skJqY2dr--

--------------f0hjJ9r0ELBKvOB9nbOpeHTi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnBWrAFAwAAAAAACgkQsN6d1ii/Ey/x
pQf8CMn0UiSIxI0HtxM4D7hb7YtIiziKSzNJWNuCV0fiK+nuQTZq8e5EToIh9wfRTPsfk2Z01gsS
3ml6wb7jmni4x3vLzVuLtebkErJGHKF2lLtXMNP4fqvMpN3qDqjhoMLJ/38cb58NhnvSBIgsa0j5
wyYNG1c0IbGZ/VgnuXu6g0yRO0+jvunuasrS+r0XRfyor3LhG08BbMSLsL+e+Mi2mB5S+6A8NIO6
F5MCbdaKeWTmlqd0c7FLB3uu3VerRWxIGpDdpKuyw6cXQxYN2uSAyj0OP9/eF6YAs5Ku0ksWBxbV
KVL3GbegxzWTxj87eb/H3bUUM+RhzCvMmWq0r4ozCg==
=2x0Q
-----END PGP SIGNATURE-----

--------------f0hjJ9r0ELBKvOB9nbOpeHTi--
