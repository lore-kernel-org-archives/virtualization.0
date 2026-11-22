Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795347862;
	b=0VwyW6pHw00D634N+J96C9Yu1JaiYLpYqUZnsjapouwQix9jACbv/GO6pZ7uCGrz/6jo
	 DhXnSVOXteHrtly0vzIFk4HagLwn7Gzbl+YytciSMsXq62/FraXxetwtrb3VqJfMXJ1g+
	 IPkRtjyUjBMfHuMJM8+kkW3rr9xuyaoSD7+d57LKJ/nQeZ3UHGIBjKQu5Bs2HoJNRIPpy
	 u8V1z0a9aie3PL/Ri0KfVzCyNMowPALOaYMErJ/gRFFRacQCcgtRRLmjH5zJkKa3FuLLT
	 wKMllzVylxGi7dVG2b8IrR1tkSSYRrua9nUgYBvV1Q0esDVjMyuXPDzpM7CgQLQUN9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795347862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=mQojN/7bt9QymOFRQB3HdvvKBXR3fZUr/nS9E5JcK9E=;
	b=x1Bz7TbnSHA6eQa15S3hU/gJamkZ2QN/rCdPlhtFnBdqOYovr1/56HuPISvao97nqpeu
	 UpGaPsuh5t5C3PWil07qlt1SOSgw8ebdAXvLbX92iFWiyF0TTZMnvscIUvr+uWPb0vUgo
	 qLfKaSgFqwzZjVMZM3138CV/iGBmrP2x3IaRx6cKbPExc/ED955vmROGZ/X4kftWcPqV7
	 L6BwkSuaGgBssTw/9o5hTuujuKFVDC56CbYZ1FOP6ccx6DrMtF41O8KoHDxfm9musZwdl
	 Bz0zo2zxbjkO6asqh3SyRZigMB3nB36K5vl1AWus+vhjIjNguwK9M5vd0N/X3DceWXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="fUPZr/pK";
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41877606A331
	for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 11:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41877606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=fUPZr/pK
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d28f75d62so397433666b.0
        for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 03:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795347860; x=1795952660; darn=lists.linux.dev;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mQojN/7bt9QymOFRQB3HdvvKBXR3fZUr/nS9E5JcK9E=;
        b=fUPZr/pK0KgVJHVc68OUYe1xpSwBJc9ZmGaH7Cg0P1Xcs8yf0bYoM5VtjsRIVF0yXR
         CBaRxbC2U/YKRhTnJnco86IJm/t//8fdZ+joYqgt0SSVswZVSxr0hjmGD28DR20cXDPl
         TQgZeB0ikiNi1dmtB2qMRKu2xFylKqfeGUXDCJT6HYLT8pdvocjk7AfCYQfpXy+UATV1
         ioiH/07dS8rYDeCvrhW1ZQoIWHtlXUu0d1nVy//X2TAFI1Ud5nYNl17/raZkcJdczbso
         Uq7uN6N+PsXTWzagf65YQ/85RG0RCrdSM9TjRw6lz6v1lwES9YmpyQfK3eb8wHmK+u7G
         AqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795347860; x=1795952660;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mQojN/7bt9QymOFRQB3HdvvKBXR3fZUr/nS9E5JcK9E=;
        b=EguGAoZLLwvcjORWA5j8wUy9em3Nh7u4KeQAMmSymBA+0kw08zdjSIp1SgU24MGw+q
         S4K/q1FZb/owmFxgqQJE6leLczUB07doTLzvZ/iCvqMK2X43GMIaM9+qO1g/Rn4Y8F78
         G4EpdrtHBbJG+LKr6o4VArxJQv2+GrY4/2Z9tP/Kcdk0Hu/Ir7cN3zbBh3SHAqbtaiPp
         Ft7DdqAVsuVHESBmRd6TNwBbS0Gi4U9CsP/7swOLVCvZpZfvUKTijObDz3V5X9uI/CwX
         LkGeOTbhYf8Vgi9EUh0AdF+/S7LejUOwdJk9tzKkup6OLaqEtiJVTmyBWx/j6csWTrtb
         9MSA==
X-Forwarded-Encrypted: i=1; AL+hErEtgfuhTq9hJ8ypqSh9zcMV4sskHYNVr14Pb1rQGPVQ4QN4ec4fc7XaUY8VkT4a9Q3TK/Ygp/bITuklK4kkRA==@lists.linux.dev
X-Gm-Message-State: APuU4Z84crmlnmu9MIxMcWSISZyBcfr/f18mFl5c7Q09SCGvZUz7sHdz
	l1P3/ziReT8wFxm1We3mMBIjleTGYwXDSdcbXHEH7Wup6iAB+5DYZNCMlg7M0t2z/0k=
X-Gm-Gg: AZFdTZeVYa/Ah3epf/JXjlRR4YqqsRJn1/3+1p/BqC21A14r8TYN2Pgf5w8erNIuxRq
	fUsmwseobujbEnhm+i6fBrvWrxIJf/Lxypf82TaG2IhMjuwxC+ezgxIuXEaA/Y1rZXr37R90ezw
	zw5zdHzIs5a6YwH06kJZYSXLaLADVF5aTTTpOh24NsUfx/hP7oxLEzy6Z6E7IJlmcatocUeESSF
	M7qB+Q66Vn0kK3ALDGHt5fx9Wh0wg+DlYilK1Auysu3wrfMf+iJjMc0IrPhevMKYE9N2euU+P7m
	17m+fGDpzjPp3xSF44GHeI+IKRuVm4ylYKinW7DkuR4PcUB4j6gGUOMBCrsNsmXU3DDcL6YyEuC
	Pc0RqCVQNsEYrMT0IzFSK7Hfr/Csxsu1B9hhxD9i+aloqKJs71h6NEtqw/5Z0iM3jAVXV7jOeer
	/UG0HlZtBB41E/bDMXYPzftwr5IsASlK8TNwaXIrDH3NLiNnN2h+lcfmYm8kKCftB/dNvSpeUPb
	xsMhxDZk32MXHyj8A66jGsSmwgHeb36pWdeu0hlf1oraHbZy7gAClQpWMzh2mgZcv7mEiQPpi9K
	vRuoOY/CRIcR87mXG1AvGQ/9tgvcos1dl5Cl47H+a3oPU6JtMSn3anUG/Ml/K6Bo31OJLv1teaN
	N/1lxKV2V6mc1bVhI7rMIHalWIp6fYd22TTLC+gJ2CZSo2w0ceLstflV55wK2r8cpPdNZEr3w
X-Received: by 2002:a17:907:80c:b0:c31:7495:e57 with SMTP id a640c23a62f3a-c513acc24abmr724797766b.44.1795347860601;
        Sun, 22 Nov 2026 03:44:20 -0800 (PST)
Received: from ?IPV6:2a00:12d0:afa3:c01:92cc:e257:77ba:97a1? (2a00-12d0-afa3-c01-92cc-e257-77ba-97a1.ip.tng.de. [2a00:12d0:afa3:c01:92cc:e257:77ba:97a1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae661b3sm303834666b.16.2026.11.22.03.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 03:44:20 -0800 (PST)
Message-ID: <f9887bf3-6dad-4b21-ae7e-84c1cac1a821@suse.com>
Date: Sun, 22 Nov 2026 12:44:19 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/12] x86/msr: Remove rdmsr()
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <20261116150208.1572254-1-jgross@suse.com>
 <20261116150208.1572254-11-jgross@suse.com> <awLTXAT-amcgoRT7@gmail.com>
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
In-Reply-To: <awLTXAT-amcgoRT7@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pFP0w09H0SwzyOKQiBZSWQVy"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pFP0w09H0SwzyOKQiBZSWQVy
Content-Type: multipart/mixed; boundary="------------yQxnsU2t5ucXlaPv2BAfgj0W";
 protected-headers="v1"; hp="clear"
Message-ID: <f9887bf3-6dad-4b21-ae7e-84c1cac1a821@suse.com>
Date: Sun, 22 Nov 2026 12:44:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/12] x86/msr: Remove rdmsr()
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <20261116150208.1572254-1-jgross@suse.com>
 <20261116150208.1572254-11-jgross@suse.com> <awLTXAT-amcgoRT7@gmail.com>
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
In-Reply-To: <awLTXAT-amcgoRT7@gmail.com>

--------------yQxnsU2t5ucXlaPv2BAfgj0W
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMTEuMjYgMTI6MzQsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IHJkbXNyKCkgaGFzIG5v
IHVzZXJzIGxlZnQuIERlbGV0ZSBpdC4NCj4gDQo+IEhlcmUgdG9vIHdlIGhhdmUgYSBmZXcg
dXNlcyBsZWZ0IGluIGNvbW1lbnRzOg0KPiANCj4gICAgIyByZG1zcjoNCj4gICAgYXJjaC94
ODYvZXZlbnRzL2ludGVsL2xici5jOiAqIHZhbHVlIGZyb20gcmRtc3IoKSBtdXN0IGJlIGNv
bnZlcnRlZCB0byBoYXZlIGEgNjEgYml0cyBzaWduIGV4dGVuc2lvbiwNCj4gICAgYXJjaC94
ODYvaW5jbHVkZS9hc20vc2hhcmVkL21zci5oOiAqIFRoZSBrZXJuZWwgcHJvcGVyIGFscmVh
ZHkgZGVmaW5lcyByZG1zcigpL3dybXNyKCksIGJ1dCB0aGV5IGFyZSBub3QgZm9yIHRoZQ0K
PiAgICBhcmNoL3g4Ni9rZXJuZWwvY3B1L2ZlYXRfY3RsLmM6CSAqIFVzZSByYXcgcmRtc3Io
KSBmb3IgcHJpbWFyeSBwcm9jZXNzb3IgY29udHJvbHMgYW5kIHBpbiBjb250cm9scyBNU1Jz
DQo+IA0KPiBXaGljaCBjYW4gYmUgYWRkcmVzc2VkIGluIGEgZm9sbG93dXAgcGF0Y2guDQpJ
J2xsIHdyaXRlIGEgZm9sbG93dXAgcGF0Y2ggcmVwbGFjaW5nIHdybXNyKCkgYW5kIHJkbXNy
KCkgaW4gY29tbWVudHMgd2l0aA0KdGhlICpxKCkgb25lcy4NCg0KDQpKdWVyZ2VuDQo=

--------------yQxnsU2t5ucXlaPv2BAfgj0W--

--------------pFP0w09H0SwzyOKQiBZSWQVy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmsC1ZQFAwAAAAAACgkQsN6d1ii/Ey/B
PQgAoAC09b+7Cf2e+6oFqas7qN6U4Qi4/PmmYHsKQ+mjaJNHDTaoCgvsQOh1FlNHFlOkl+bS7H2t
JXe8C4tYQQXdV9ihMlMawaflcJf1M0MiI3HxEIpBjn0sYylLSchWpC+3UY3amHnKeukkG0yJCzHQ
8JdoMbpRebpe4So3Mj0JNXErpwEE0RGQVHq3r5qX2hjAv1RHczARDxHsSLtOVSt7Ej4lobhJVQs+
NT+i2o20kbJUyqxpfZFfAmRKjG+Drc3KNQpTapk6BjzIwNjLnNhj5sYbyzHGwGp1iCcXI2gTA3P1
4qZ4UPOw/LZ49YOZoPgB6+7r1Kbb0hJC71N4D/Bmeg==
=2EkH
-----END PGP SIGNATURE-----

--------------pFP0w09H0SwzyOKQiBZSWQVy--
