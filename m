Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F31332907
	for <virtualization@lists.linux.dev>; Fri, 22 May 2026 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443206; cv=none; b=a5sONI0YyP254MA4UbcVGtXAaTA6ECIlDHNl0HOEbF6BggjAgJwXexgIyvFjsYjhIIltdqAZD82DHtjt8LQ573uEAETRQ5el1LKa4fBx9QBMo6QGdhfS6MVpCtgS0QCNKaai4ReRs+A267yHLFiMnaqxuScZH/6nhlMfd9v15g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443206; c=relaxed/simple;
	bh=6wwIAvH2jnO7xDjqocr4Iro4XevWqw+im+DyTuVpoIw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pKAV5Nj+Nm4mdE2rJm+MkLetleIwrTRiWeQcZZQaNO4anow07CDRVViKMmA7Zs69bL3Va1e4jFnNPoD++zeMgsfzDUDW3Vf6kNuG8nahO44gC1Q9+IDwJo0RVd4/aRtxlNLa5P5IbLWA8LxDpsEz4XALvjROW2IeI7xHhmVnktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a/4+Yyg9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a/4+Yyg9"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so11870226a12.1
        for <virtualization@lists.linux.dev>; Fri, 22 May 2026 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779443203; x=1780048003; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6wwIAvH2jnO7xDjqocr4Iro4XevWqw+im+DyTuVpoIw=;
        b=a/4+Yyg9x4nablvwefzRh5zqiRES1PQJVPH/P963IFVXDnUpVFjOy1YEvBFS5I8kw5
         BNgOnBOOtg4heEvyY+PDSJGHzH/9tzUmz/kkGF6EtitZi9vNg7WgBZ2aNBQLcC0WUx2z
         PCoY7Su7kv+SE+jOXfwE1dm17kMhtaKhXTQ2ThKU78A7DqN5nppSbcg1RPcQTf6rl4vt
         whCmkFI77C73xVe71lXo71oyTE1Hcm0b4YTHSTUBt20RoodGE5csQqqeOqe+IL83hNRm
         XWAFmp5rPUlouUpUXUM3Z98MnvxV6A95km3Ius+11GOvC+5dzDw+8BS8cmNjzwe8VjUQ
         MyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779443203; x=1780048003;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wwIAvH2jnO7xDjqocr4Iro4XevWqw+im+DyTuVpoIw=;
        b=Sno6q8uQEFhJdfgQSN9vcgMguRZDOzFZoCA0QyVmv/IgOM56i/RvmTKpNtdn3t4ktF
         NATX9yaRAwcKcEEMAM+2ILOjnicJqGrqfFlDsCAurtKyo4U10IEmnpHisiLe0W6YBSOI
         siY6QNGrbt3WsNfBjI2QiKmv74luE1HBcY9WSTdhjnsbzAPkvgRRWTmYUCTmjzix2vEY
         vkou1RcjiBMxCS1rHZ7kC6tFb8VYiTTSv/myX6ImQvUYjgxXKqqBuydOLwMpm/TeTT8x
         ZjJ5mDG0mp//nn6gdwnKJ6QGiGxCdD4kCJGb5H48BmkawlHBps84YkDdYDvrM3VFHP13
         pC+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+8UVJWm3a81M/pgLk7jZDBPrmviPPIwlPvMS9S45vksX0KlK7lGoGrA613NocmI22RC1CMyRCV90W3SJrZAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyOzSJEe00Wj2HdD00PIyEc5g9cenAO5mRfopBBnxQj2cezt4G
	/q39vxXW+CiWMW+Xxm8CvyF53YLGomfWzfWvtlgLmDRObPb4GFEBt+Pd44Wn7ayJ/P8=
X-Gm-Gg: Acq92OE2EweJRjFfWZrAHA0VLMiiUZ731bqbFYeqHbS8mabejZmyBDaoBhAXm0etLJO
	JoAiEvGo0cSwBa/Gjukxq5Hp/knIHVnaymnD1nkKBt1HjyB17NfFnstGl/OK4sOBmvDR4Lmd78a
	u7SMwy2+lFn6O6dzFKRY8VRGFlZ1bM16lAxkHqJIwx5fDmoQEcns/REtkalP711Kyr9MDUySsGl
	AnTsxYBc1T3sJRK4NV++7Heeq8t44f8VbJTy0KKCRi/PscYQfVCZRB73/IYfLoWr5ApaFC/A8+u
	G0In3jqof4HfEK7MKDLvFTsPhw2DQhzLAvcjLXnMeVP1NqO1E+BAoYqjhL1SJkXtLQJAe0n9kNr
	8AYEXTY38KJBWg0+4z8m7WlLt6vh5MAJ2n0INihAFdiZhSKak+fmPNEtWe+xnfnAHJW0E+KLepp
	6vGQGzqnHf/Q8gtmM0T2NfQEM7hKo8ZCOz1bPZKd+olGG76Ts5gKBFxtrgBufSk+RmCzt18xkPh
	slIgTGaV58+5TWH1GNuUrUPmODsWAzU/ghSL6VxauhfN76CZ/QnOg==
X-Received: by 2002:a50:ee08:0:b0:671:9dec:ba3 with SMTP id 4fb4d7f45d1cf-6882efedec4mr1957355a12.13.1779443203421;
        Fri, 22 May 2026 02:46:43 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688baf1f0afsm462823a12.17.2026.05.22.02.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:46:42 -0700 (PDT)
Message-ID: <bfd86941-c01c-4f49-82d6-625be4eb680b@suse.com>
Date: Fri, 22 May 2026 11:46:42 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] x86/msr: Consolidate native/paravirt MSR functions
From: Juergen Gross <jgross@suse.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, virtualization@lists.linux.dev
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <e7c72dde-7e8e-457a-9f9f-c3799cbe28e2@suse.com>
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
In-Reply-To: <e7c72dde-7e8e-457a-9f9f-c3799cbe28e2@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------krSfOZnw0HrXQWjLkBxblFGF"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------krSfOZnw0HrXQWjLkBxblFGF
Content-Type: multipart/mixed; boundary="------------xUwUj0rAbP1Qf0BTK0G1G2pz";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, virtualization@lists.linux.dev
Message-ID: <bfd86941-c01c-4f49-82d6-625be4eb680b@suse.com>
Subject: Re: [PATCH v2 0/8] x86/msr: Consolidate native/paravirt MSR functions
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <e7c72dde-7e8e-457a-9f9f-c3799cbe28e2@suse.com>
In-Reply-To: <e7c72dde-7e8e-457a-9f9f-c3799cbe28e2@suse.com>

--------------xUwUj0rAbP1Qf0BTK0G1G2pz
Content-Type: multipart/mixed; boundary="------------eGPYmp2NV0a8L7LKCqTXHsA0"

--------------eGPYmp2NV0a8L7LKCqTXHsA0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDQuMjYgMDk6MjEsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+IE9uIDI5LjA0LjI2
IDIwOjQ1LCBEYXZlIEhhbnNlbiB3cm90ZToNCj4+IENoYW5nZXMgZnJvbSB2MToNCj4+IMKg
IC0gUmVtb3ZlICJyYXdfIiBuYW1lcy4gSnVzdCB1c2UgInBhcmF2aXJ0XyIgaW4gdGhlIGdl
bmVyaWMgY29kZS4NCj4+DQo+PiBJJ20gdGhpbmtpbmcgSSdsbCBqdXN0IGFwcGx5IHRoaXMg
aW4gdGhlIGNvbWluZyBkYXlzIGlmIG5vYm9keQ0KPj4gc2NyZWFtcyB0b28gbG91ZGx5Lg0K
Pj4NCj4+IC0tIA0KPj4NCj4+IFRoaXMgaXMgb2xkIGNydWZ0LCBidXQgaXQgYXBwZWFycyB0
aGF0IGhhdmluZyB0d28gY29waWVzIG9mIHRoZXNlDQo+PiBNU1IgZnVuY3Rpb25zIGlzIGVu
YWJsaW5nIHdhcm5pbmdzIHRvIGNyZWVwIGluWzFdLg0KPj4NCj4+IEkga25vdyB0aGVyZSdz
IGFsc28gYmVlbiBzb21lIHdvcmsgdG8gcGFyZSBkb3duIHRoZSBYWEwgY29kZSwgYnV0DQo+
PiBpdCdzIG9idmlvdXNseSBub3QgbWVyZ2VkIHlldCBhbmQgdGhpcyBpcyBhIGdvb2QgYmFi
eSBzdGVwLg0KPj4NCj4+IENyZWF0ZSBoZWxwZXJzIHRoYXQgYm90aCBwYXJhdmlydCBhbmQg
bmF0aXZlIGNhbiB1c2UgaW4gY29tbW9uIGNvZGUNCj4+IGFuZCByZW1vdmUgdGhlIHBhcmF2
aXJ0IGltcGxlbWVudGF0aW9ucyBvZiB0aGUgaGVscGVycy4gVGhpcyByZWR1Y2VzDQo+PiB0
aGUgYW1vdW50IG9mIGxvZ2ljIHRoYXQgaXMgZHVwbGljYXRlZCBpbiB0aGUgcGFyYXZpcnQg
Y29kZS4NCj4+DQo+PiBUaGUgd29ua3kgdGhpbmcgYWJvdXQgdGhpcyBzb2x1dGlvbiBpcyB0
aGF0IGl0IGhhcyB0aGUgY29tbW9uIGNvZGUNCj4+IGFsd2F5cyBtYWtlIGxpdGVyYWwgInBh
cmF2aXJ0XyIgY2FsbHMsIGV2ZW4gd2hlbiBwYXJhdmlydCBpcyBub3QgaW4NCj4+IHVzZSBm
b3IgTVNScy4gSW4gdGhhdCBjYXNlLCB0aGUgY2FsbHMganVzdCBnbyBkaXJlY3RseSB0byB0
aGUNCj4+ICJuYXRpdmVfIiBmdW5jdGlvbnMgdmlhICNkZWZpbmVzLg0KPj4NCj4+IENvbmNl
cHR1YWxseToNCj4+IMKgIC3CoMKgIG5hdGl2ZTogVGhlIGJhcmUtbWV0YWwgaW1wbGVtZW50
YXRpb24uIE1pZ2h0IG5vdCBiZSB1c2FibGUgdW5kZXINCj4+IMKgwqDCoMKgwqDCoMKgwqAg
cGFyYXZpcnQgWFhMLg0KPj4gwqAgLSBwYXJhdmlydDogQ2FsbCB0aGUgbmF0aXZlIHZlcnNp
b24gZGlyZWN0bHkgaWYgcGFyYXZpcnQgaXMgY29tcGlsZWQNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG91dC4gQ2FsbCBpbnRvIHBhcmF2aXJ0IG9wcyB3aGVuIGF2YWlsYWJsZSwgd2hp
Y2ggbWlnaHQNCj4+IMKgwqDCoMKgwqDCoMKgwqAgdWx0aW1hdGVseSBjYWxsIGEgbmF0aXZl
IGltcGxlbWVudGF0aW9uLg0KPj4NCj4+IDEuIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDI2MDMxOTE1MjIxMC4yMTA4NTQtMS1hbGRvY29udGVsa0BnbWFpbC5jb20vDQo+Pg0K
Pj4gwqAgbXNyLmjCoMKgwqDCoMKgIHzCoCAxMjQgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gwqAgcGFyYXZpcnQu
aCB8wqDCoCA0NCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IMKgIDIgZmlsZXMgY2hhbmdl
ZCwgNjUgaW5zZXJ0aW9ucygrKSwgMTAzIGRlbGV0aW9ucygtKQ0KPiANCj4gQXBhcnQgZnJv
bSB0aGUgY29tbWVudCBmb3IgcGF0Y2ggODoNCj4gDQo+IFJldmlld2VkLWJ5OiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCklzIHRoaXMgZ29pbmcgdG8gYmUgdGFrZW4g
aW4gbmVhciBmdXR1cmU/DQoNCkp1c3QgYXNraW5nIHRvIGtub3cgd2hldGhlciBJIHNob3Vs
ZCBiYXNlIHRoZSBNU1IgcGF0Y2hlcyBJJ20gd29ya2luZyBvbg0Kb24gY3VycmVudCBtYXN0
ZXIgb3Igb24gdGhlc2UgcGF0Y2hlcy4NCg0KDQpKdWVyZ2VuDQo=
--------------eGPYmp2NV0a8L7LKCqTXHsA0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------eGPYmp2NV0a8L7LKCqTXHsA0--

--------------xUwUj0rAbP1Qf0BTK0G1G2pz--

--------------krSfOZnw0HrXQWjLkBxblFGF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoQJgIFAwAAAAAACgkQsN6d1ii/Ey9w
bAf9GgkWoUMMVogP9bAM1sNIDEkh5qOtBP50CbtRJbHcpfLRPdIjhX/IgAz+OV30WMqFQvr+v4WC
lGHTPXFvLDL0gWvAGZHUAdeRGPvXsvn6Y4PGUuDqHijLvCkLagqNNBTjJ6zwVOK3XYjm8R5YWF43
5j3/JurowHiik+bes59/8c5YGEIUS2noBhOH6YKCQW7bAScmMMn0HKA31VB58JIhqqJPkITqXqgV
9x9HUZivGBb6vx2aH8ZVingrFUR2f5BZvO7s0Jag+W+2jdbgr2oifWZMJLF+sEReOUCG3W3QwiXv
2cBJnwC22MzJFxQrsnjTLd/sUpaOfieDUP5KQWY32w==
=0els
-----END PGP SIGNATURE-----

--------------krSfOZnw0HrXQWjLkBxblFGF--
