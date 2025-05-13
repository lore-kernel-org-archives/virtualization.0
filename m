Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605CA1BEF9B
	for <virtualization@lists.linux.dev>; Tue, 13 May 2025 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747116369; cv=none; b=YQg5NywHXUYeYLr5rb3wQjjoDiUMhb5ntM0ef/wv6h6xhZpxRysBnUR+6EgrijUykqiYZaa3OAYhG8iPDelHqtSzlS/tfccgOhho3/lv8XcFuHQJEQJ08oyDLr7NitKBJCXvfVY/qFFcm4wHJBdhouc+79WU89rpXfvy1vWDNBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747116369; c=relaxed/simple;
	bh=DGtCLplKUKXbSKQt37ymuwbot4atAEF9v2Sf5XSpTlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iofE6rNDER96s2PCe5McgEirST1sUlLsDNc4ssBUNVmGgFNJHU5BNiWgRXJ7PmB8Xl+WWc3t4eAGsyFDZdi1Fzcz8w/FDPhLpe+oJC8ZYsNAzN9tRS45wEuCy3Ig52lMXBd4BjnGnCa001yIaXYbIdydelw7ncFogcv4mqIzqQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Id5u1Gka; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Id5u1Gka"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a20257c815so2338799f8f.3
        for <virtualization@lists.linux.dev>; Mon, 12 May 2025 23:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747116365; x=1747721165; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DGtCLplKUKXbSKQt37ymuwbot4atAEF9v2Sf5XSpTlc=;
        b=Id5u1GkaiUtj+MnK3+JoY3ezVuujd2wd+NzQYGjCnp0yPFKhpmFdUnaWrS3eiNSs45
         mh7qOiM3fej3o/bn5hdPr/96JSjNNRdL8MzlmJObJtZ0sm5HFOKVmTOMMiE3C3ovGem+
         JIvf/Un52sj6zE4JquP92GDWSNbhjGxuS8Tc4xy0sGW2/wE9k2i0ik21ShvryuYQ8r77
         MdTGhE2VfOxUWAak4BPXMwCfOKzROlXlfewTo5C+WTbejYsxDqh/FOgrFbg4Y1C89tWy
         GiI+rxsmUrjsCQiXfi1Izt62p9a8l1He/Isz6eOwXRxLfd7qRe+2r0iv4DnQc7oRRhra
         FILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747116365; x=1747721165;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGtCLplKUKXbSKQt37ymuwbot4atAEF9v2Sf5XSpTlc=;
        b=R5gPQckaTnVU6zLvy//7Mfd+et3DHlT2KpApUmgd+G3COw4cz1M1d9+rRdxVKJgzti
         BLCvvV71YcdHiR71lRHCGB5+V8f3r2nhwIY0G08MsotUPQugarrgHbw7mraIZbINSRwG
         GqHZuRofo3qJIcxcF01mWAZ0txa2oofWiWCjocqEAcmsFXphNmButeD5i+HKs439YAjX
         4hyVMD8cjDVoh99ojI8gCqApay93c4F07HeFyCWqxpEN7ZckVP608XqL2wgFp+jzIizk
         OtvHWzVroAWJT8vlydY2orreh8Yi/V1mlKCbK6kU65Iol2d3OyleXs6NDM+CR2q7qiWS
         M+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPJElRfMQ9uGPYQhMgEEotDzdUSqkCFPJQ03cLZ8wdhTHvueRyJ8jZTxaxxkPQBi9UpkWdPToVRpEz62lvHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+3QlkI4od3wGTpKkaBBOFf1a5p+KumzGITQg0DSzZ7W7jrGp+
	iE1udFbmvP2ocr9O7z/e+HOWY4py88RSHxUKbShRyr32EzDsIjneW5nmMiujbUk=
X-Gm-Gg: ASbGncv6Xars8gyFcuu5DdGJg4S9janWGJkm4XJBDcR9AUMbdwC+gjDWoblqES0fWTX
	mEEz7gfBvgtk2Eu1gWbs1YhUbu8u9Z6/bu2RfjWHK+54ATfFGmE0PTC1eSzrbG80qBsuBISoBcd
	BB/YdN3k5sx4CdVoNhH+3gX+mfDrZzHFerQ06JbcMeCcZbHTtKjlTewBgA+Lj0nUc/C/zwYnVgc
	tyham02ar8cS6yo37jTTZDJAxvn6mVeL9b1u15TpUofIWqZsJQZPgJO+JPe8KJ5WVWtyuGI5Yl4
	dqQOKprNe7lOfsA1YndIaNe9vHAUZw1+e9vgX773meuZAynrHEG2vJLppnxbGkmjyTUfMxKcwz/
	SjVJ17fyk/bb3Hn4bOtPtsa48K1qyfsRnwj18pLEvPOai4TcdfgtLdwtKePVhKdOyLbO7dGM3ig
	==
X-Google-Smtp-Source: AGHT+IEv3x6OnuUD8tSlxO0X21jPh7ofLW3oGg6Tf2SOgLYrIsn3YKIAIsv43QpDxgYcarE+2u6gGA==
X-Received: by 2002:a5d:588a:0:b0:3a0:b2ff:fb00 with SMTP id ffacd0b85a97d-3a1f64b4557mr10829757f8f.44.1747116364662;
        Mon, 12 May 2025 23:06:04 -0700 (PDT)
Received: from ?IPV6:2003:e5:8712:700:7979:a587:7535:c0a5? (p200300e5871207007979a5877535c0a5.dip0.t-ipconnect.de. [2003:e5:8712:700:7979:a587:7535:c0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57de0ddsm14628826f8f.7.2025.05.12.23.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 23:06:04 -0700 (PDT)
Message-ID: <6cc20ef6-d8e5-4c74-89d9-6a949c84b397@suse.com>
Date: Tue, 13 May 2025 08:06:02 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] x86/paravirt: Switch MSR access pv_ops functions to
 instruction interfaces
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org
References: <20250506092015.1849-1-jgross@suse.com>
 <20250506092015.1849-6-jgross@suse.com>
 <722f5b30-20e9-4540-98e4-d211d7c44cbe@zytor.com>
 <9f4e33d5-9cb3-4079-b764-87a15265fd52@suse.com>
 <ff567466-a46a-4f66-935a-8fae1140c1a2@suse.com>
 <eb077393-ea95-4ac0-9479-980e227f7bff@zytor.com>
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
In-Reply-To: <eb077393-ea95-4ac0-9479-980e227f7bff@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------KVDs0RSTYDoV4udMXyJ1ZgMA"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------KVDs0RSTYDoV4udMXyJ1ZgMA
Content-Type: multipart/mixed; boundary="------------037X61wSMbHMyK1zL5Bo0Gqo";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org
Message-ID: <6cc20ef6-d8e5-4c74-89d9-6a949c84b397@suse.com>
Subject: Re: [PATCH 5/6] x86/paravirt: Switch MSR access pv_ops functions to
 instruction interfaces
References: <20250506092015.1849-1-jgross@suse.com>
 <20250506092015.1849-6-jgross@suse.com>
 <722f5b30-20e9-4540-98e4-d211d7c44cbe@zytor.com>
 <9f4e33d5-9cb3-4079-b764-87a15265fd52@suse.com>
 <ff567466-a46a-4f66-935a-8fae1140c1a2@suse.com>
 <eb077393-ea95-4ac0-9479-980e227f7bff@zytor.com>
In-Reply-To: <eb077393-ea95-4ac0-9479-980e227f7bff@zytor.com>

--------------037X61wSMbHMyK1zL5Bo0Gqo
Content-Type: multipart/mixed; boundary="------------vjdcwKn490L7VqapiJAC214g"

--------------vjdcwKn490L7VqapiJAC214g
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDUuMjUgMDc6NTUsIFhpbiBMaSB3cm90ZToNCj4gT24gNS8xMi8yMDI1IDQ6MjQg
QU0sIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiBOb3cgd2l0aCB0aGUgbWVudGlvbmVkIHBh
dGNoIHJlYWxseSBhdHRhY2hlZC4gOi0pDQo+Pg0KPiANCj4gRG9lcyBpdCBhbGxvdyBwYXRj
aGluZyB3aXRoIGFuIGluc3RydWN0aW9uIG1vcmUgdGhhbiA2IGJ5dGVzIGxvbmc/DQo+IA0K
PiBUaGUgaW1tZWRpYXRlIGZvcm0gTVNSIGluc3RydWN0aW9ucyBhcmUgOSBieXRlcyBsb25n
Lg0KDQpZZXMsIHNob3VsZG4ndCBiZSBhIHByb2JsZW0uDQoNCg0KSnVlcmdlbg0K
--------------vjdcwKn490L7VqapiJAC214g
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------vjdcwKn490L7VqapiJAC214g--

--------------037X61wSMbHMyK1zL5Bo0Gqo--

--------------KVDs0RSTYDoV4udMXyJ1ZgMA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmgi4UoFAwAAAAAACgkQsN6d1ii/Ey/j
8AgAi5+zla5tcvAhgYRt4I5XHYB13eK8ZpXiaiXLjgkYMVuC16ud/Vge0rsHwl6ehyQtB1zXh14a
YOTKFJq4oHvzFGa6DPaHuGa9BgtRzYy5ttVWOW9qSG50rrKdEq9YMU3MfqW2yx9StBk/Q3fvfZ/u
4OsOkCYaYPlx5TY5/bchG6e+kpU7wdMH9l+yqM283YkG5Pr6Q1VRb9eeB3dJyxMPTtzksP/kfKSL
UwPInCVoTHCqkoOaOjdVjQLWHnZ/rAAtIwgjg5W+4OGQX1P0R+6IR8/YkD2Zn1l0cYY2ktfFcEoq
TVrq0MxOEULofUPFxDQr4aqRDKpcd18YIFAXxn7PYw==
=m7ZK
-----END PGP SIGNATURE-----

--------------KVDs0RSTYDoV4udMXyJ1ZgMA--
