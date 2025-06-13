Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737F7DA6C
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749801676; cv=none; b=nKcetncDxcOEJsFm8Iw8OX22SL7WuCItDpf4Vx9rSIAlbswC56XoI7aaftYom7sZan/0lT60DX0PUDpBm3cJnH4s+SHgJI+XTFkef3esEJObsyMuhnOpNKYDnyeUE7uRtoGr8DddMJNfQA9AcbtoccA0r/iE8+ajzXLE61dzhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749801676; c=relaxed/simple;
	bh=oVkBrK/A0vLvhoTA8U0y8twjRvHkjlMpOpc6rdFuRs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7vLnOhtJ8Fzje5pNjcHK53jH4/gBEGseq1HgShHQ73uw6F8zQgyDnYmy/mMG88o93Q3ckTjf2snY+cY/Ljdh8bI3tfR9Y6uI9AAd9uY8uDSjKr6BqKA3b5f9PiNqr9LRDoJe9Z5IC5huk0Zo1HZIy3ocNMNUTutd0+NvH/YcU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gMrWJh66; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gMrWJh66"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-441ab63a415so20175425e9.3
        for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 01:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749801672; x=1750406472; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oVkBrK/A0vLvhoTA8U0y8twjRvHkjlMpOpc6rdFuRs4=;
        b=gMrWJh66p5yEzQeVAhrn6o1rcbClsgTx//iTBGr0l6B+MJt3/Jmj/chw5UaVUI1xQC
         F/unm8R0OlrEZz7wigJ0YNhmi99bmqiV6KLtwEokm2O/cL2YlUcQ5xs3B6vbzWqywjf6
         Mzfkd5/VGu4Cjc9LGK8ddTkqUQHmHoVC2s47BjbyeZgmjq9Qn3y0vHVtj/2WP9gH001k
         W5MyUvin4dZGQ5mveqzamvQOBAtKpL1kGq5gfofTUTX9ztoIqN9hGHjEiEyrWElAipXl
         nIHy5Yi6vmPBvHp+GF4oP3vIAUSpOmCqj+lw6q8rJnyjeQbau1C1FbGujWQ1ffuaylYg
         44QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749801672; x=1750406472;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVkBrK/A0vLvhoTA8U0y8twjRvHkjlMpOpc6rdFuRs4=;
        b=H33X3YfW8H/Hpp9Ur8H9ms0EliSDI00+PpNK4G4Z+8Qyt0vi4L4mIqPnI161CrWwKw
         hiZeeXOy2NGPbM4g3DJQNzU/yj7X6FENQXu3hQ+HrkbobK2LILt2OQjfXhTwUjKMM7IZ
         ZHxJ6Juc87fkpP7h5lmBuDMG1uYWLz1skxiXZAZfwvdPlC77X4wWoxyrqiixvTGTT0Vv
         SwdrC4/w8BwcnouFieyHYjPHM4WPSzxBgfq3OZuam4E3u0ZyBLb5KqR8KiN8XRsUpsW6
         nZ3p+ucmwjSA7XswlDKLk4w6GMhJkhKfhbdg3Svrry6Wcj7QtAmOD5QmsTfmaR7lm+d5
         BKiA==
X-Forwarded-Encrypted: i=1; AJvYcCVDxHG2dzZvHQASAAQpeNjCCbr2kJ4ngDFfyuLDl1sB4xl3Ass8wKGm8zoF+F+hpp4sVxzJMJ1vq4XqVD7dXw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz4qX2q8BL2AxUrkCo8T1GmNpayMCMqOWDltLaaFGMDORgy9az
	FQHxPuU/jmr+yE0/mFbAZGffPrxdYUC/Mr4c8d3w4G0YdALmGJA2NR35i3HwZsvIUxQ=
X-Gm-Gg: ASbGncvaUQuFXgB7VDC3aRnxwqBy0LBenwpq2dHm3stv+Kw9K7qt71PQJOyPhWVta5L
	7zVmfWqf/t3gpcrHm0GcCnf19q8gqv6rKT/r7sR2NfjCsJbuRJS0jV+y+ULpJDOpOCE3B73Fd0c
	wKhJqAhk1SNfKWgL5C6dg32C+bulXBGy3e8ycS5D1xk8SM2FEGQpBiVbgsioeM9wmQU/H/kXnLg
	fFR4QhkJj1ZQlL9PzaMZl0WCzh7+20jKJKCSInJF/fdmU326bHhe+ugbZK+uth3DDN31/ixFd8Z
	QefHYzj8rmWdnIPb1F54Yh/kNg+ZrhT/YpwQABIoRuqOvgqlYwpzCOHKoo84I/iXUUgQPIeBr7M
	85+kwaioG0yoHFgsWYmTBQeIycFxQ5vrF9D4vwfAJFRqUQZWYxDJtPzhLOvloaiJBzPdLtUCLtX
	fjP5nI+2Fg95U=
X-Google-Smtp-Source: AGHT+IFMe7wbeTc0LOBRSkO3BDuKqUyRIhs/5ZGTQ8wq12AaIc2cDx4+sbER33SEbuRIuacSzKv0ag==
X-Received: by 2002:a05:600c:4e02:b0:442:e147:bea6 with SMTP id 5b1f17b1804b1-45334a7fce4mr17323885e9.11.1749801671116;
        Fri, 13 Jun 2025 01:01:11 -0700 (PDT)
Received: from ?IPV6:2003:e5:872a:8800:5c7b:1ac1:4fa0:423b? (p200300e5872a88005c7b1ac14fa0423b.dip0.t-ipconnect.de. [2003:e5:872a:8800:5c7b:1ac1:4fa0:423b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224cb2sm46051975e9.5.2025.06.13.01.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 01:01:10 -0700 (PDT)
Message-ID: <bd565df5-b87c-42b1-a717-9ed1267df0c2@suse.com>
Date: Fri, 13 Jun 2025 10:01:09 +0200
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
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Andrew Cooper <andrew.cooper3@citrix.com>
References: <20250506092015.1849-1-jgross@suse.com>
 <20250506092015.1849-6-jgross@suse.com>
 <722f5b30-20e9-4540-98e4-d211d7c44cbe@zytor.com>
 <9f4e33d5-9cb3-4079-b764-87a15265fd52@suse.com>
 <2365af70-d36f-4663-b819-59d886936ef5@zytor.com>
 <8a82946a-6c3e-41d1-b3bd-be164dc6eeba@suse.com>
 <0c2dab1d-9b5c-4d34-af0e-8a14907d7335@zytor.com>
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
In-Reply-To: <0c2dab1d-9b5c-4d34-af0e-8a14907d7335@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------STIfmqOdBFBaxqvTwNHJSgls"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------STIfmqOdBFBaxqvTwNHJSgls
Content-Type: multipart/mixed; boundary="------------tCGUA4CXW29PV7rMp3vv2bed";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <bd565df5-b87c-42b1-a717-9ed1267df0c2@suse.com>
Subject: Re: [PATCH 5/6] x86/paravirt: Switch MSR access pv_ops functions to
 instruction interfaces
References: <20250506092015.1849-1-jgross@suse.com>
 <20250506092015.1849-6-jgross@suse.com>
 <722f5b30-20e9-4540-98e4-d211d7c44cbe@zytor.com>
 <9f4e33d5-9cb3-4079-b764-87a15265fd52@suse.com>
 <2365af70-d36f-4663-b819-59d886936ef5@zytor.com>
 <8a82946a-6c3e-41d1-b3bd-be164dc6eeba@suse.com>
 <0c2dab1d-9b5c-4d34-af0e-8a14907d7335@zytor.com>
In-Reply-To: <0c2dab1d-9b5c-4d34-af0e-8a14907d7335@zytor.com>

--------------tCGUA4CXW29PV7rMp3vv2bed
Content-Type: multipart/mixed; boundary="------------5Uu5knDZMhxHDHh1wwEwuctw"

--------------5Uu5knDZMhxHDHh1wwEwuctw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDYuMjUgMDk6MzEsIFhpbiBMaSB3cm90ZToNCj4gT24gNi8xMS8yMDI1IDU6NTgg
QU0sIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4gSGVyZSBpcyBhIHBhdGNoIEkgY29va2Vk
LsKgIEkgYWRkZWQgYW4gQUxURVJOQVRJVkUoKSBoYWNrIGJlY2F1c2UgdGhlIG5ldyANCj4+
PiBpbnN0cnVjdGlvbnMgY2FuJ3QgYmUgbW9yZSB0aGFuIDYgYnl0ZXMgbG9uZy7CoCBCdXQg
d2l0aCB0aGUgcGF0Y2ggeW91DQo+Pj4ganVzdCBzZW50LCBpdCBzaG91bGRuJ3QgYmUgbmVl
ZGVkLg0KPj4NCj4+IEkgaGF2ZSBtZWFud2hpbGUgZHJvcHBlZCB0aGUgcGF0Y2ggY29weWlu
ZyB0aGUgb3JpZ2luYWwgaW5kaXJlY3QgY2FsbC4NCj4+DQo+PiBSZWFzb24gaXMgdGhhdCBJ
J20gc2VlaW5nIGEgcG90ZW50aWFsIHJpc2sgd2l0aCBjdXJyZW50IGFsdGVybmF0aXZlDQo+
PiBwYXRjaGluZyB3aGVuIHVzaW5nIEFMVEVSTkFUSVZFX1syM10oKTogZGVwZW5kaW5nIG9u
IHRoZSB0ZXN0ZWQgZmVhdHVyZXMNCj4+IGl0IG1pZ2h0IGhhcHBlbiB0aGF0IGFuIGluc3Ry
dWN0aW9uIHNlcXVlbmNlIG5vdCBzdWl0YWJsZSBmb3IgdGhlIGN1cnJlbnQNCj4+IHJ1bnRp
bWUgZW52aXJvbm1lbnQgaXMgcGF0Y2hlZCBpbiBhcyBhbiBpbnRlcm1lZGlhdGUgc3RlcC4g
SW4gY2FzZSB0aGVyZQ0KPj4gaXMgYW4gaW50ZXJydXB0IGhhcHBlbmluZyBqdXN0IHRoZW4g
QU5EIHRoZSBoYW5kbGluZyBvZiB0aGUgaW50ZXJydXB0IGlzDQo+PiB1c2luZyB0aGUgcGF0
Y2ggc2l0ZSwgdGhpcyBjb3VsZCByZXN1bHQgaW4gY3Jhc2hlcyBvciB1bmRlZmluZWQgYmVo
YXZpb3IuDQo+IA0KPiBPaCwgSSBoYWQgYXNzdW1lZCB0aGF0IExpbnV4IGRpc2FibGVzIGlu
dGVycnVwdHMgZHVyaW5nIHRoZSBwYXRjaGluZw0KPiBwcm9jZXNzLiBKdXN0IG91dCBvZiBj
dXJpb3NpdHksIHdoeSBhcmUgaW50ZXJydXB0cyBhbGxvd2VkIGluIHRoaXMgY2FzZT8NCg0K
SW50ZXJydXB0cyBhcmUgZGlzYWJsZWQgd2l0aGluIHRleHRfcG9rZV9lYXJseSgpIHdoaWxl
IHBhdGNoaW5nIGEgc2luZ2xlDQppbnN0YW5jZS4NCg0KSSBndWVzcyBrZWVwaW5nIGludGVy
cnVwdHMgZGlzYWJsZWQgZHVyaW5nIHRoZSBjb21wbGV0ZSBhcHBseV9hbHRlcm5hdGl2ZXMo
KQ0KaGFuZGxpbmcgd291bGQgcG90ZW50aWFsbHkgcmVzdWx0IGluIGEgdG9vIGxvbmcgcGVy
aW9kIHdpdGhvdXQgaGFuZGxpbmcgYW55DQppbnRlcnJ1cHRzLg0KDQoNCkp1ZXJnZW4NCg==

--------------5Uu5knDZMhxHDHh1wwEwuctw
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------5Uu5knDZMhxHDHh1wwEwuctw--

--------------tCGUA4CXW29PV7rMp3vv2bed--

--------------STIfmqOdBFBaxqvTwNHJSgls
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmhL2sUFAwAAAAAACgkQsN6d1ii/Ey8T
6wf+Lx95IbfTTKOQJFyx7WrMg/Jq+6GRUWowQjPiHr/aJ2NgIXbtQnBkykc8J89EMOvdqAW8C0Cc
bd5sVr161doZhvg+ZCIT6a65ziNnm559DTq1iXGc5k9VtqKRaooC7JJ8qvvVdAGBeCYBCTC/2UXc
MfiH8EaqL3YxPMhmEKEi5LU7LN6Ylfw93GkrpTbNu/lAMrGytCb4/rKcBMrT+steHNkWmcDqi1XB
xew917zFd74V70INHfo0/vp+Lic341GI4JJOSi1UzZ2a38QQNV8dOMG4DWvN62EipkMCNu8EkVWC
lQriuZk/bV7jOnAacKD6QzbwJVQIn9650sn/u5gBQQ==
=g6uR
-----END PGP SIGNATURE-----

--------------STIfmqOdBFBaxqvTwNHJSgls--
