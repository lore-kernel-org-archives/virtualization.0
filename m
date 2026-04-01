Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58A2E7F25
	for <virtualization@lists.linux.dev>; Wed,  1 Apr 2026 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775023973; cv=none; b=GefTOH7Lr+n5xEYy6iV3ce63h3v3MdsOtuFz1dU/gSsgGJ0sdgP2Mj7MGKevL+lqq5ifaWz7lUoa3skeib8Nvah6Z2EybIix4q90ARvpnRsy5w9erbLmx3bhAwB12ZshY8DUy2aeRNulFLgDSl5Ijl6MecMEAFCoxGlNC1q8Wow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775023973; c=relaxed/simple;
	bh=X26Wp79o6pE57pIUrqLSskRNxV/bmYQXvMpdVf9DIPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVk5W5Ov54pb/7xUAJvq8rU799XrdbupQbpusFviX8BvHLCp3WxBYCvtf+vrsKICl3Rt4IhNxwX8jGeXsXuMx+ERV2ImUv0IdSykYV1BIG5WrhACGygNQQtqTmZupSvB2pr9MGV1Mrc30BnJYhJHv3G/3sqy0TRcT9DFN7o4HRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eS6wMBuF; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eS6wMBuF"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so12264766a12.2
        for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 23:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775023971; x=1775628771; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X26Wp79o6pE57pIUrqLSskRNxV/bmYQXvMpdVf9DIPA=;
        b=eS6wMBuFNd197MTnLxWIM9Iux0eTSMxq91Xx+P/9WIctzvfDO2QzQOxd0Vcqgo+US7
         yLsUy8dNkjZbH+vS8LcIvNkUOfdkEwhDbRdW9xQ9tcoA0/Mob7YM2/SRBr8ALFdTfZs/
         tXN5q9otGeW3vRkow9Y3c83KyDFg+0/UpRfMwyZQVsk2cWHd3sqlu1nkqn9ZfUzrird+
         2OFqZw4pfpUJVKeJBDwdW7nWt1LQIxYDs1uhDXS3yOXJ+4I7iA4ngD1fMkO4345sQ44m
         9lMMk/FNolWf2XM/oJ+46ULAvb6RM47YZORxoUy8vCl1N/tZ4xIcYKD112WRu4pvBZFA
         sKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775023971; x=1775628771;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X26Wp79o6pE57pIUrqLSskRNxV/bmYQXvMpdVf9DIPA=;
        b=aPVbd7DnwoiBOy044VRZBmkUxfVwiNyAOZsdQo8ZYVaABCdOfmg64oJquQ/2bQjNOk
         0o+8XBzqD9kcsHDHMtd2wPfqIJktNOD+nODieyjV4xlNRQdQOeNw5GlCMrcMkiMGNNW3
         GGU2U2cEl2//SyANYlcMs8vY95ObUAZdAVUs786M7yhhk0vbxZ6bQ4PD4PGMHVf1BAYn
         OEeQjsWj3Pd+F3KIVOO+xglj81kCd1/6IANK6/rQGFUlUj4xHhHN8oBPi4cqaYwSirtc
         c9mdtJqApNyeBOaHsk+SRIR2rfTUWMeS4sodJHW7APmkvOgAMWkCe6OuohDPaEXhRbpv
         YpNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQymLbMpVT164mvQDHIvqrNfK2Pj1Tff2ayVfYIrrsLX2TBPYqjZilDEWARh6ewu4MKKfSgvXvEEnWdKCE8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyK9yYS1FLz0wWPUENLHeZ57tDRzAzuINQ9u7TD0410y59+opvP
	qoXl0lVIOcETYeRE1SE91TVVSTKhbVMkHm05akWo1yR20ItabC7ES6veGDxikyf0Osg=
X-Gm-Gg: ATEYQzwfx3gMPIJ8ibGI3wgt/MKtnqKXaJMuhv4GFk07xLLnjmJI+/bDSXV6Bg7b5nI
	i4HpUL2PXkzt9PVx96oOaAl1m+/W+QfNd2e3P90ioo38bTQQa8t71fwjwqxav4ImTjwROWrC2bl
	qnfq37ssuhoXKU1V5TwMhr7eWh00HK2EwyRaOCoYHjnCsAtk/T8s8jwV7sWFclmYUcPqa5daH1P
	WlXo4yiA07iQnpmnjy9dR2SaEqx5Fzq2JIAK3LR/zcMsCMMLlOWN7ToAc1asbzKCdE5TO0SBG7s
	X01s+yjGIokCJXtOSDrvkkbkXsVWP86IUuNRcuAO3zlKrTgOlfyH7A/JZxVf+fQvURhun2UMqHj
	wQAA5vs/PwT/gWKGpnA61pmM8m3kVVLNmCv14nxqipEHlw34tUWm2EjXaiPbS6VkUGSORAe05mJ
	pTOl6GC0aLWRhG/41AiltZY8gMoDENC5f2c3K7w17HUfXY0kZhHd7ptagsNSwtOIfJObaoOWJai
	Uivc+f+GhM8cSzm7BXcYK58ym3cNbSU8DXeH7q3OqaiWS26VppWnw==
X-Received: by 2002:a17:907:6c11:b0:b97:dc00:fbc5 with SMTP id a640c23a62f3a-b9c13b32317mr167342466b.36.1775023970830;
        Tue, 31 Mar 2026 23:12:50 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c29605870sm10506266b.37.2026.03.31.23.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 23:12:50 -0700 (PDT)
Message-ID: <29e40dbb-8baf-45fa-a7e8-30c4a2cc90d4@suse.com>
Date: Wed, 1 Apr 2026 08:12:49 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] x86/msr: Consolidate native/paravirt MSR functions
To: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 virtualization@lists.linux.dev
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
 <20260320233319.GZab3ZP1lTfxOmQ4YF@fat_crate.local>
 <4c26ba32-d15f-496f-9f83-211c51a58673@suse.com>
 <2c4f1284-77d2-4628-88bc-28677afd2238@intel.com>
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
In-Reply-To: <2c4f1284-77d2-4628-88bc-28677afd2238@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zI4TA6yipCcrvNJZI0dFM1ws"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zI4TA6yipCcrvNJZI0dFM1ws
Content-Type: multipart/mixed; boundary="------------MJaPaG1XPd90Svo1brX0662N";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 virtualization@lists.linux.dev
Message-ID: <29e40dbb-8baf-45fa-a7e8-30c4a2cc90d4@suse.com>
Subject: Re: [PATCH 0/8] x86/msr: Consolidate native/paravirt MSR functions
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
 <20260320233319.GZab3ZP1lTfxOmQ4YF@fat_crate.local>
 <4c26ba32-d15f-496f-9f83-211c51a58673@suse.com>
 <2c4f1284-77d2-4628-88bc-28677afd2238@intel.com>
In-Reply-To: <2c4f1284-77d2-4628-88bc-28677afd2238@intel.com>

--------------MJaPaG1XPd90Svo1brX0662N
Content-Type: multipart/mixed; boundary="------------DrvHAXTO3uLDWek0oJ4yW6Hd"

--------------DrvHAXTO3uLDWek0oJ4yW6Hd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDMuMjYgMjM6NDEsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiBPbiAzLzIwLzI2IDIz
OjIzLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0KPj4gSSB0aGluayB0aGlzIHNob3VsZCBiZSB0
aGUgZmlyc3Qgc3RlcCB0b3dhcmRzIGEgTVNSIGFjY2Vzcw0KPj4gY29uc29saWRhdGlvbiwg
YXMgaXQgYWxsb3dzIGFueSBpbnRlcm5hbCBvcHRpbWl6YXRpb25zIGFuZCBjaGFuZ2VzDQo+
PiB3aXRob3V0IGZ1cnRoZXIgYm90aGVyaW5nIG1vc3Qgb2YgdGhlIHVzZXJzLg0KPiBJJ20g
bm90IG9wcG9zZWQgdG8gc29tZXRoaW5nIG1vcmUgdGhvcm91Z2ggdGhhbiB0aGVzZSA4IHBh
dGNoZXMuIEJ1dCwNCj4gdGhlc2UgZG8gZml4IHJlYWwgcHJvYmxlbXMuIFdvdWxkIHRoZXkg
bWFrZSBzb21lIGZ1dHVyZSBlZmZvcnQgaGFyZGVyPw0KDQpJIHdvdWxkIG5lZWQgdG8gcmVi
YXNlIG15IHBhcmF2aXJ0IE1TUiBzZXJpZXMsIGJ1dCB0aGlzIGlzbid0IGEgYmxvY2tlci4N
Cg0KTWF5YmUgSSB3aWxsIG5lZWQgdG8gdW5kbyBzb21lIG9mIHlvdXIgY2hhbmdlcyBhbmQg
Zml4IHRoZSB1bmRlcmx5aW5nDQpwcm9ibGVtIGRpZmZlcmVudGx5LCBidXQgdGhpcyBpcyBm
aW5lIGZvciBtZS4gSW4gdGhlIGVuZCBJIGJlbGlldmUgeW91cg0Kc2VyaWVzIGFuZCB0aGUg
b25lIEkgd2FzIHByb3Bvc2luZyBhYm92ZSB3b3VsZG4ndCBpbnRlcmZlcmUgYSBsb3QuIEl0
IGlzDQp0aGUgbGF5ZXIgYmV0d2VlbiBib3RoIChteSBwYXJhdmlydCBNU1Igd29yaykgd2hp
Y2ggd291bGQgYmUgYWZmZWN0ZWQNCm1vc3QsIGJ1dCB0aGlzIHNlcmllcyBtaWdodCBuZWVk
IG1vcmUgd29yayBhbnl3YXkuDQoNCg0KSnVlcmdlbg0K
--------------DrvHAXTO3uLDWek0oJ4yW6Hd
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------DrvHAXTO3uLDWek0oJ4yW6Hd--

--------------MJaPaG1XPd90Svo1brX0662N--

--------------zI4TA6yipCcrvNJZI0dFM1ws
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnMt2IFAwAAAAAACgkQsN6d1ii/Ey94
RQf/a4QequMAwlYLzIJtjKQJ+L1XXA0SY6q5b5XV7XvCVHJSFXUQ+98/+nkhK0Eq1AiOKycGynD7
icG6wsWzlvccY1Xa8etLPMwCfbRYmz1ec5Huezp/uWODrZ0TmwaCBMNnfq7PdAhX/cJ4cPJ8sGyZ
/DZNsM4/bifQ7BzrKjslFOn5Kwz3lzZREp05EwNWJ4XsIf/KeNwnwKkAtGW82+3KD6yFU+VJqRh6
iaSbD9VLOhAd+pdtqk4ZUIVcEvwX90CxlkqIQtEAMYIjz+FgdJhPlzHYcfUR7BCuOe0FkTxEbRxT
URF82go/NhUtyvy/jEATt4ZoKXPoGlnUfTHS1xrPHA==
=YoV9
-----END PGP SIGNATURE-----

--------------zI4TA6yipCcrvNJZI0dFM1ws--
