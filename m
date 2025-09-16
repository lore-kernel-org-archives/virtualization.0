Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95857101F2
	for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758002453; cv=none; b=X4nm9KqFpWrhcYz48/SYFg795eHWmzUI+2Nez45oP92b7s2tyfoehi3nN5nFu03DmxdyDWxLNB3oc0jXMEu5obxgFZORoWsaeOoAai9tCRKBzgIyfjsi1zICCMgEsTo8+WLa4l5THF/4kCpK1891O2xLz8K8g/HLWNvm4yd7m0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758002453; c=relaxed/simple;
	bh=030uGPjbT2oNUrw2Fy/laSMaTqPvnjc4pmUbuy324tQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=W6hXAqJ1w+OUcRFpczxP0hcSDSLbhh+1ULpLBay8mSIafTc5/vllAdkve9+LoxNPwwbXDKDjI4958wGgOLLCafUWQzMBR3v076jZOBB+33ZU4KAgCCSDAXBGYVA2I3krB3MvpOcqpKNHY1mVX26ol4PK/CIpDzK0w8JytyLAZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BytHbkUG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BytHbkUG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso37912445e9.0
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 23:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758002449; x=1758607249; darn=lists.linux.dev;
        h=autocrypt:subject:from:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=030uGPjbT2oNUrw2Fy/laSMaTqPvnjc4pmUbuy324tQ=;
        b=BytHbkUGbufg0JjnTW99W9WLn0OMZpu+q9LjA1EA/J0Xu5vD0sml7yukaeUZbdcKvM
         hMRHn2bc5rPVXy8HQhSi+MlirDBSesK4CCCVgsSx6/rIbKlQ/+In1BPZ+zxqpVV2mWdh
         CvcBeQJYwNXDMH+XbM/6tNVqzhTC7D/PwTtkivVW6Vf3ECPIJpxHOv4xv2h5ueuFk9z+
         1e398ZYkHq5TDFVjfKFKZuKxOyXWRsLlRuAdqGj16jh3bwHnPuXmKMXtxp4dIPOS0zKD
         hHfOjZ6xNUCWSWclz4aqANzHGzKxECGmgayxErSifVRbiDGYiY4sPfSDa+Lggln8AMRO
         r4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758002449; x=1758607249;
        h=autocrypt:subject:from:cc:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=030uGPjbT2oNUrw2Fy/laSMaTqPvnjc4pmUbuy324tQ=;
        b=Q9vCuKecPvmwSTnm4SIS4kQ1M3TOBy/X3q+VcWc2WiFU5QbxrQ+lWAaTuJV2X8txwn
         4eGg8RzMjZJ7zwNpyqSMLYz5pGDbqUAOS3M7bysgEnoGRiWA/duB2uJtFFZnhlGt9uU9
         hW4glDNVDO1+RFiZB+tsc7fQl0gbJfzVy7f+jWz9SVnNexd5GSTRH64vxntq/ErKKRoE
         6vvzX873iftKg8KNduFFEhRoBYQKLSXtgm59F7Rt0a0X89Wi8hExb2mF2T9VKflBNTV9
         L5vNmn2jHizUW7ybOXDNdOpm4FYAaYMJNJozinZG1YD4vbCT0qgbcB8GpG17I9FEzI+q
         t3Cg==
X-Gm-Message-State: AOJu0YwohJNvGMRTLvbiPv9nclN/D/tA5VLPcGLpSgV8YAGPmaFl/2f7
	51ZqONk7xlcTh29W0TElX6usYoiPV4U2PkcqyzoO5i6aJD2Q4x+FoHfK7c+S6/3ibWx27QUBLbt
	TeawF
X-Gm-Gg: ASbGncsSyvyox1knSqcbM/XpZeKiG/EFGGEnEIEUEKv0MtlAicD/51SqvJQ3xCbfIAQ
	RoDtxnclAEOPdh4cr/fabi/7giMqcbzcEATqXIy71r1YHhjKIDYT7Zs3hPVHycdUue0XlDrSMDJ
	lh9Ai3tzbuMKIz53J5gG+yBAjQq5Y6GOC7G/4eT8SQtkPKdzKN6NhEjeY4tTj122FdKc0RhHbWd
	gwMFPMGcylxe98ppj19C4AlXHUtxveIkXQsCQUi3pdWeFRkFPyLcx9vYCPwvcw7tEGJdfGoL1eu
	EGRNkyGcmFJ1bqpAiO3AJQw0F8AcyyJfS984yllIwBJlQoHKWXF9VXkLWRJxi/iF2PU8eov3Tax
	jvv+6owRrGH7wKboS6WnmXCUkGgr0zxqYcNpaT8fVzA1bi07mQ7YCMzuDVaioBhtG80vUZ6NNQ/
	hX5NktByPj5MXOib5ua1xxDpIaA/FnkthK622QDpHq+68P
X-Google-Smtp-Source: AGHT+IEpSrTQb5d6875K3FMmJJVOhSzSCxd8wK+J88IPM23SXXSHlweeO7FHRz/ZaiZIF93fkbkXxQ==
X-Received: by 2002:a05:600c:a30f:b0:45d:d86b:b386 with SMTP id 5b1f17b1804b1-45f32d54496mr6723735e9.14.1758002448720;
        Mon, 15 Sep 2025 23:00:48 -0700 (PDT)
Received: from ?IPV6:2003:e5:873d:be00:c26:b971:1ba7:9d8b? (p200300e5873dbe000c26b9711ba79d8b.dip0.t-ipconnect.de. [2003:e5:873d:be00:c26:b971:1ba7:9d8b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f2a65e1b5sm105427545e9.4.2025.09.15.23.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 23:00:48 -0700 (PDT)
Message-ID: <ff2b81b0-04ba-49b7-8a4e-089f1c875744@suse.com>
Date: Tue, 16 Sep 2025 08:00:46 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: virtualization@lists.linux.dev
Cc: Stefano Garzarella <sgarzare@redhat.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: virtio backends in guests
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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------v05I3sXF2hS802SAWHBbi4UZ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------v05I3sXF2hS802SAWHBbi4UZ
Content-Type: multipart/mixed; boundary="------------Hx19ysuVrZc9WKgqIMsgtAR0";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: virtualization@lists.linux.dev
Cc: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <ff2b81b0-04ba-49b7-8a4e-089f1c875744@suse.com>
Subject: virtio backends in guests

--------------Hx19ysuVrZc9WKgqIMsgtAR0
Content-Type: multipart/mixed; boundary="------------bCEXNgqpX9znAwWeLcD5xBUO"

--------------bCEXNgqpX9znAwWeLcD5xBUO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

VG9kYXkgdmlydGlvIGJhY2tlbmRzIGFyZSBtb3N0bHkgbGl2aW5nIG9uIHRoZSBob3N0LiBB
dCBLVk0tRm9ydW0gMjAyNQ0KU3RlZmFubyBkaWQgYSBwcmVzZW50YXRpb24gWzFdIGluIHdo
aWNoIGhlIG1lbnRpb25lZCB0aGUgaWRlYSB0byBoYXZlDQp2aXJ0aW8gZGV2aWNlcyBiZXR3
ZWVuIGEgQ29jbyBndWVzdCBhbmQgdGhlIGFzc29jaWF0ZWQgU1ZTTS4gT25lIHByb2JsZW0N
CmlzIHRvIGhhdmUgYSBzaW1wbGUgd2F5IHRvIGNvbm5lY3QgdGhlIHZpcnRpbyBkZXZpY2Vz
JyBmcm9udGVuZHMgYW5kDQpiYWNrZW5kcyBpbiBhIHNpbXBsZSB3YXkuDQoNCkEgc2ltaWxh
ciBwcm9ibGVtIGlzIGV4aXN0aW5nIHdoZW4gdXNpbmcgdmlydGlvIGluIGEgWGVuIGVudmly
b25tZW50Og0KWGVuIGFsbG93cyB0byB1c2UgZHJpdmVyIGRvbWFpbnMsIHNvIHRoZSBiYWNr
ZW5kcyBjYW4gbGl2ZSBpbiBhIG1vc3RseQ0KdW5wcml2aWxlZ2VkIGd1ZXN0ICh0aGlzIGd1
ZXN0IHdpbGwgcHJvYmFibHkgbmVlZCBhY2Nlc3MgdG8gYSBwaHlzaWNhbA0KZGV2aWNlIGxp
a2UgbmV0d29yaywgdGhvdWdoKS4NCg0KV2l0aCBYZW4gaXQgaXMgcG9zc2libGUgdG8gdXNl
IFhlbnN0b3JlIHRvIGNvbW11bmljYXRlIHRoZSBjb25maWd1cmF0aW9uDQpvZiB0aGUgdmly
dGlvIGRldmljZTogVGhlIFhlbiB0b29sc3RhY2sgd2lsbCB3cml0ZSB0aGUgY29uZmlndXJh
dGlvbg0KcmVsYXRlZCBkYXRhIHRvIHRoZSBiYWNrZW5kLSBhbmQgZnJvbnRlbmQtc3BlY2lm
aWMgcGF0aHMgaW4gWGVuc3RvcmUgZm9yDQp0aGUgYWZmZWN0ZWQgZ3Vlc3RzIHRvIHBpY2sg
dGhlbSB1cC4NCg0KV2l0aCBTVlNNIGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRvIGNvbW11bmlj
YXRlIHRoZSBjb25maWd1cmF0aW9uIHZpYQ0KU1ZTTS1jYWxscywgYnV0IEkgYmVsaWV2ZSB3
ZSBjYW4gZG8gYmV0dGVyLg0KDQpJIGJlbGlldmUgaXQgd291bGQgYmUgaW50ZXJlc3Rpbmcg
dG8gYWRkIHRoZSBjb25jZXB0IG9mIGRyaXZlciBndWVzdHMNCnRvIEtWTSwgc2ltaWxhciB0
byB0aGUgZHJpdmVyIGRvbWFpbnMgb2YgWGVuLiBUaGlzIHdvdWxkIGFkZCBhbm90aGVyDQpz
Y2VuYXJpbyB3aGVyZSB2aXJ0aW8gcGFyYW1ldGVycyBuZWVkIHRvIGJlIGNvbW11bmljYXRl
ZCB0byBndWVzdHMuIEhlcmUNCmhvdHBsdWcgKGJvdGggc2lkZXMsIGZyb250ZW5kIGFuZCBi
YWNrZW5kKSBuZWVkcyB0byBiZSBjb25zaWRlcmVkLCB0b28uDQoNCldpdGggdGhlIGludHJv
ZHVjdGlvbiBvZiBhIHZpcnRpbyBjb25maWcgZGV2aWNlIG1vc3QgcmVxdWlyZW1lbnRzIGNv
dWxkDQpiZSBzYXRpc2ZpZWQ6IGl0IGNvdWxkIGVudW1lcmF0ZSBhdmFpbGFibGUgdmlydGlv
IGRldmljZXMsIHJldHVybiBjb25maWcNCnBhcmFtZXRlcnMgb2YgYSBkZXZpY2UgKGJhY2tl
bmQgYW5kIGZyb250ZW5kIHNpZGUpLCBzaWduYWwgaG90cGx1Z2dpbmcgb2YNCm5ldyBkZXZp
Y2VzLg0KDQpGb3IgdGhlIGNvbmNlcHQgb2YgZHJpdmVyIGd1ZXN0cyB0aG9zZSBndWVzdHMg
d291bGQgbmVlZCBhIHdheSB0byBhY2Nlc3MNCkkvTy1idWZmZXJzIG9mIHRoZSBmcm9udGVu
ZCBzaWRlLiBYZW4gaGFzIHRoZSBjb25jZXB0IG9mIGdyYW50cyBmb3IgdGhpcw0KcHVycG9z
ZSwgd2hpY2ggaXMgc2ltaWxhciB0byBhIHB2LUlPTU1VLiBJdCB3b3VsZCBiZSBuYXR1cmFs
IHRvIHVzZSB0aGUNCnZpcnRpbyBJT01NVSBkZXZpY2UgZm9yIHRoaXMgcHVycG9zZSB1bmRl
ciBLVk0sIHByb2JhYmx5IHdpdGggc29tZSBleHRlbnNpb25zDQpmb3Igbm9uLXN0YXRpYyB1
c2UgY2FzZXMuDQoNClRoaXMgaXMgb25seSBhIHJvdWdoIG91dGxpbmUgb2YgdGhlIGdlbmVy
YWwgaWRlYS4gSSdkIGJlIGludGVyZXN0ZWQgaW4gYW55DQpmZWVkYmFjay4gSWYgdGhlcmUg
aXMgc29tZSBpbnRlcmVzdCBvZiB0aGlzIGNvbmNlcHQsIEknZCBiZSBoYXBweSB0byBzdGFy
dA0Kd29ya2luZyBvbiBhIHByb3RvdHlwZSBmb3IgZHJpdmVyIGd1ZXN0cy4NCg0KDQpKdWVy
Z2VuDQoNClsxXTogDQpodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L2t2bS1mb3J1
bS8tL3Jhdy9tYWluL19hdHRhY2htZW50cy8yMDI1L0tWTUZvcnVtXzIwX2xsR0Y4REgucGRm
DQo=
--------------bCEXNgqpX9znAwWeLcD5xBUO
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------bCEXNgqpX9znAwWeLcD5xBUO--

--------------Hx19ysuVrZc9WKgqIMsgtAR0--

--------------v05I3sXF2hS802SAWHBbi4UZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjI/Q4FAwAAAAAACgkQsN6d1ii/Ey+y
4Af/RwTWYorsxZNc0cSjQUUP18E71GrR/GKuYb15y4ABVNYWWI5DVrZ+d/iX6xIRQJR/FmSITEPI
alpnzTZo8xVQhpqjH8W7TC1iWtJkZxbqFQFuufwDDljPEb9/QQIrD/X6M2U3W6WQskPViH2SgIMP
C+C4NKuLWqEjNniSG8CFm4nujV4k1XlhV8GGAkXmb7rw1y9OxJ+AKmP4jW/973RdazQxUN27w+WZ
B2xoJ86JVMRB/t5KwWpuDsce7Ul8smiB26DOD03Aka0pQgVIa05hUEe9VCXX3OZfDMkwmo+C9qo3
5GibU4pV+rVTvYkRVINO7mAG95P/vP53KRar2ZiUsg==
=Ow1n
-----END PGP SIGNATURE-----

--------------v05I3sXF2hS802SAWHBbi4UZ--
