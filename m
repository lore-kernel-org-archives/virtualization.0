Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685E289340
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576974; cv=none; b=joX0hbvHoCFm5cDeOpH8DvSok9z+vsGElpHH/hJXl7oS9lQ3oWCzJE1qUeDeUEAoolhd1cbAwAWrdlkA0iemVe8fayHoTaIUjHl5JdRvZJdZ4NU9wncNLt5VIqrwY7tVNvUWFQPR34yM7s2cUhMG+7137WgDkJRG/QYhV24CilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576974; c=relaxed/simple;
	bh=4l7yJXhIseTiqcGMgxSn/s1EUUXfuxcB16GDG5sfbh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKyqAIgh12PZxrcet6QCUuJHmye86kx5wvRI8isUugHfBx7aLDoTVX4LvsURr9QerShFHFtqivyaVnGyB1R/xWfUMqsE2HbWIb7qnStM1oYkRw5Pqch6c60aPmcmzfRIdtppi3GtUb5Xu/Rqsji7dm/hju5+Zq1NngrXJ293HhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F8gK9bdO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F8gK9bdO"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so2042862a12.1
        for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 12:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777576971; x=1778181771; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4l7yJXhIseTiqcGMgxSn/s1EUUXfuxcB16GDG5sfbh0=;
        b=F8gK9bdONCa3mmmlmJahbIs6mu4HNQ5yGRHD+i41W7J/jE8LZ88Z9SlyQpWdoQ0/vC
         C0ycZQXljpuUt6JtZByYlteRo3fZdg+c7/siHQZ6r0BBla6xrLgWj9omI030kwmwERRA
         FzR0NcfUK2Ox1lFd466W6ZcQ3dp4CcnDYl9TY+5nJIt778Nw5UUEf87V4GALyCInOgmA
         iqjcEBCXabKZnGJbrr6fLMaY6fAln4AQmuDnmEDapHs4OTfrg/eWvzUeVgZxbkoo3EME
         PZXXLkLjzVT4oOcGwtOvZ0e5Xcm4ERS3IeezjQSG6ge9oP/g5u/4ytr0qtsl3hV7GFC9
         vDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576971; x=1778181771;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4l7yJXhIseTiqcGMgxSn/s1EUUXfuxcB16GDG5sfbh0=;
        b=oMF9LeGyyoGOaFYjup6rS2HL6UXBTscUCPKZilpymtlwVDmgm6TEI/LJVgLpIAsdow
         fPMqwn3BRzN+TBV8Ag//OBWRs/oQAgJdjKBru/ZpsL62FCQehZudVuL3CuYdCWwYRooj
         Vj2sUZkTbA03PrxxpqGlhPqE1u0phWw841s4PCQHopq7xam/tD1w60It/F/qQ2iYOeGW
         OCqyQUvExPM3DOgyZQfCGWI9jU2/hYtL+PsY8VOC9oh9Vb3tgP2SJzx20rRjv8tKkTtR
         cKeokAvDph4Dr5r6UnLVgjxHZKipmsA4x4loywiphmRPXQ1ppIf1/zuC3+NojWxXnZ3Y
         ruOw==
X-Forwarded-Encrypted: i=1; AFNElJ+aMQYlLSOqP0nragVGTmiysEELCPVp7TKcfPhm3O8qen9DB2pG/qaE0IpUAQ/AQlwDyCaTRCkTwcpw39uzOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/hU5zFenzBPSLKm5XKMfgWtkMYKzVpRz26LgAX+r/iiEkbYDo
	6b4Y6OaT/OA/a0c/maizAO+XR2+9RsDdJiUJ3VOUSKg3F+Vc7dD+FI4J8SCV5E1wR8w=
X-Gm-Gg: AeBDietU/AGQAptFT0lUh8+5Y+9cAmObcg/+MZuzQkKItFm0YeJnKaNewzk2ykRiQCG
	J+85g62h1vDPyabWex25bbp9NePiolFYXEgWmm5M0NQsJNv4hwIp7CU6EQh0+ubHhdnSPrLjs9V
	57jL6hv+cdxmVvF06iF02jbckj763U07+U/Vb08mMzzM50i7YfybDeHRZTBz69jr+MU5lFV3Yw/
	ZwHrFzdyIYJM6DxHoVmK7XyyrTeUfGezIJdTckrjR+RFIQKdHbaBs6WvNJ8OsAKornPePe7riNa
	nlex24GlqGGK1VIGhqbx07/PAvGBEccLt50dSZys+Hfg62Nyg09goysGj4cMVvrqalp94KMUDbw
	ds3wgH2GkZaGcNTrNXLtTigtwJZrqI+8Z3qzH1mxKljYWqF+Rf5rxkgTB/JBQq9WJo/mP+dLLQd
	qhBeEMudtakoYlqQOLuWc5KvHP2sLH9keG0rKkc0N6OWycpOC61RYi5ZoVpW5i4NrN9tYoRNtZS
	R/gC4AfKvFT0EMsdNwoQ/7Q+daDMaCv3UxF/UKap9F3RvkKTMrCDOsxLEgKPkur
X-Received: by 2002:a05:6402:26d4:b0:678:a507:e837 with SMTP id 4fb4d7f45d1cf-67b5d7f0d84mr2149554a12.1.1777576970999;
        Thu, 30 Apr 2026 12:22:50 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b877d5ab2sm271423a12.14.2026.04.30.12.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 12:22:50 -0700 (PDT)
Message-ID: <4a772ebc-daf5-41c8-8419-03e0aad66a85@suse.com>
Date: Thu, 30 Apr 2026 21:22:50 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] x86/msr: Remove duplicate #include
To: Dave Hansen <dave.hansen@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 virtualization@lists.linux.dev
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <20260429184530.9FE585E8@davehans-spike.ostc.intel.com>
 <5bd029fe-35ee-4bbc-8e05-0df8c4125b6a@suse.com>
 <0037f910-2fee-4088-8ebd-c8a614f246b9@intel.com>
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
In-Reply-To: <0037f910-2fee-4088-8ebd-c8a614f246b9@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GxMGLNxVxvMqiHUuk55igbvR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------GxMGLNxVxvMqiHUuk55igbvR
Content-Type: multipart/mixed; boundary="------------GtYbbXXIOnHiuCI0E5Hbk9ZS";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Dave Hansen <dave.hansen@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 virtualization@lists.linux.dev
Message-ID: <4a772ebc-daf5-41c8-8419-03e0aad66a85@suse.com>
Subject: Re: [PATCH v2 8/8] x86/msr: Remove duplicate #include
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <20260429184530.9FE585E8@davehans-spike.ostc.intel.com>
 <5bd029fe-35ee-4bbc-8e05-0df8c4125b6a@suse.com>
 <0037f910-2fee-4088-8ebd-c8a614f246b9@intel.com>
In-Reply-To: <0037f910-2fee-4088-8ebd-c8a614f246b9@intel.com>

--------------GtYbbXXIOnHiuCI0E5Hbk9ZS
Content-Type: multipart/mixed; boundary="------------Gq1ovsTKmPtW9MAw04JeQA8k"

--------------Gq1ovsTKmPtW9MAw04JeQA8k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDQuMjYgMTk6NDIsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiBPbiA0LzMwLzI2IDAw
OjIwLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0KPj4gT24gMjkuMDQuMjYgMjA6NDUsIERhdmUg
SGFuc2VuIHdyb3RlOg0KPj4+IEZyb206IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51
eC5pbnRlbC5jb20+DQo+Pj4NCj4+PiBlcnJuby5oIGlzIGFscmVhZHkgaW5jbHVkZWQgZm9y
IEMgY29kZSBhdCB0aGUgdG9wIG9mIHRoZSBoZWFkZXIuDQo+Pg0KPj4gSSdtIHNlZWluZyBv
bmx5IGFzbS9lcnJuby5oIGJlaW5nIGluY2x1ZGVkLg0KPj4NCj4+IEkgZG9uJ3Qgc2F5IGxp
bnV4L2Vycm5vLmggaXMgbmVlZGVkLCBidXQgdGhlIHJlYXNvbmluZyBpcyBub3QgcmVhbGx5
DQo+PiBjb252aW5jaW5nLg0KPiANCj4gWWVzLCBjb21wbGV0ZWx5IGFncmVlLiBJIGdvb2Zl
ZCB0aGF0IG9uZSB3YXMgbGludXgvZXJybm8uaCBhbmQgdGhlIG90aGVyDQo+IHdhcyBhc20v
ZXJybm8uaC4gU28gdGhlIHJlYXNvbmluZyB3YXMgYm9ndXMuIEJ1dCBJIGRvIHRoaW5rIGl0
J3Mgc3RpbGwgYQ0KPiBnb29kIGlkZWEgZm9yIG90aGVyIHJlYXNvbnMuIEhvdyBhYm91dDoN
Cj4gDQo+IAlsaW51eC9lcnJuby5oIHdhcyBwcmVzdW1hYmx5IGJlaW5nIGluY2x1ZGVkIGhl
cmUgZm9yIHNvbWUgb2YNCj4gCXRoZSBNU1IgZnVuY3Rpb24gaW1wbGVtZW50YXRpb25zIGlu
c2lkZSB0aGUgI2ZpZGVmLiBCdXQsIGV2ZW4NCj4gCWJlZm9yZSB0aG9zZSB3ZXJlIG1vdmVk
IG91dCBvZiB0aGUgI2lmZGVmLCB0aGV5IHdlcmUgbm90IHVzaW5nDQo+IAlhbnl0aGluZyBm
cm9tIGVycm5vLmguIFRoZXJlIGRvZXMgbm90IGFwcGVhciB0byBiZSBhbnkgcmVhc29uIHRv
DQo+IAlpbmNsdWRlIGl0IGhlcmUuIEVzcGVjaWFsbHkgaW5zaWRlIHRoZSAocXVpdGUgc21h
bGwgbm93KSAjaWZkZWYuDQo+IA0KPiAJUmVtb3ZlIHRoZSAjaW5jbHVkZS4NCj4gDQo+ID8N
Cj4gDQoNCkZpbmUgd2l0aCBtZS4NCg0KDQpKdWVyZ2VuDQo=
--------------Gq1ovsTKmPtW9MAw04JeQA8k
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------Gq1ovsTKmPtW9MAw04JeQA8k--

--------------GtYbbXXIOnHiuCI0E5Hbk9ZS--

--------------GxMGLNxVxvMqiHUuk55igbvR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnzrAoFAwAAAAAACgkQsN6d1ii/Ey89
3Qf/aZcr9thopUVeqiC1Gzj5Py6RP24EMtlrRkyz4Y5slWwr4Dom2Wa+VUo/w4RFbVY9qjnr0u5N
AWgNbf6xFyBd/QVMnhURTa+n13nwFHbz/+0v5swWWjM2f5jX+Tpb19xGNUROMV6Xdp4P1eDqP7p+
jjFiGjz3NHE/HEnapvhzZqvVC71PW34TmLcMSx5fTN2gSrPldsxfli/EQ9EGeRn7pQYgPsBPMcEJ
mhxCs8f9NBFvsXXGNispe6wwxBMvTxu7qoVhcMFa6YOr1uRPoNMULExixSXvFjgCSmxTU9O0mDmf
uMhuTts9QKHy0nNBIW4S1uOpirQLbhjkJGchzvkrfw==
=GZGZ
-----END PGP SIGNATURE-----

--------------GxMGLNxVxvMqiHUuk55igbvR--
