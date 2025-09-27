Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F32E0B69
	for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758982952; cv=none; b=Fu6M52BOD7aA/raTqyjDjsHvWMDrQwdSJlDPdbjvSf1jMfuWxUXUpEivkpoRcgI36vGMRy+HSDitBX/5nzvNL5Y4or01Nmd8GHdLdxzbxUw0cyTC8lZpGV1NmbPMA5lWJlBM5ZUDaTzAMubTWbOmcUnmYwXJ54qJc11mk9+LfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758982952; c=relaxed/simple;
	bh=2fIBwTIAdKpwRItFyJzhDhGr+KGeVYoEgNwbRczrq5Q=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=YQmuA7X8dDzJivu3JuZKjEjOR9ATy7ISf+x7y1Dhm7sa7zMlZGhUuyWwbprr1JuPRNPUU4QEUmH6imKYRU5UyfzBI7qi3AoPHLQtUvlZpvM6js5X5ZwLNpy37y+fleP+pAfxIs5/n82xJvhoCUvHT/7kTNUtVSaBwi5J7HOJPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKyVEGka; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKyVEGka"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee12807d97so3103644f8f.0
        for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758982948; x=1759587748; darn=lists.linux.dev;
        h=cc:autocrypt:subject:to:content-language:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fIBwTIAdKpwRItFyJzhDhGr+KGeVYoEgNwbRczrq5Q=;
        b=aKyVEGkaMBUv0qGKzabG9BbFf/ZveQZWlqlS8qXIqQ9zloFegYHTGaJnYH09j0ZXlS
         SWyND9x/OJCJV6e5DYU/fLrNOgxCrunxmmMoKmZNyU2Un/Bp73UzRIVwWAqkySUzIcIz
         KS2bwmZXa5ko+LOlHwJp6gCf0BHZC6vlU1j5BDkECYNeFsp6Rmyc1QN8awvl2MYRurSE
         UpTFJ0Ah3bKF6COulAqpjAm/awvEESt/6BRAl6O9vLu/UUeWOfGhWbD/mvDK1Re+1rN7
         qFI8ifS+fgzIjYATpzuqVGbUukMk0OT80UOEz2FffHXnH39cLVJRMZ/o+mkbNuOLd10H
         FWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758982948; x=1759587748;
        h=cc:autocrypt:subject:to:content-language:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2fIBwTIAdKpwRItFyJzhDhGr+KGeVYoEgNwbRczrq5Q=;
        b=IvGwbgLgCuHHQoeuQMGWqTtbY0moWI/IeaRSGElSxfZO09m1ACy9/BvbW4hu1sTdDq
         DM63WdPMtsuq1UhEzWZiCjI3dYzoYEh/G/Q6fKcpAHU4DlVHznlXZdA8Ffs1/6uK0O9f
         QgRsdfzhQ27DhbYxQVgaY4wGDFT6DWnWI3CYa+nG1hUQJt3hJEW0mEwU1HbyIgCtfZBK
         /bzI94Sn0w+A4kqw7PFC+L0fn49mqVxP1PEwrPYCd/CJiSNiuHlfqfGcSun1IJMyDd1J
         CEAFeIvXWM7MySNxYutCZRa+e2apFyG7UkG3mt4sEN5Ax/S9Pfoo7ISCQVjvU2DEQD5c
         Mbpg==
X-Forwarded-Encrypted: i=1; AJvYcCUen2iFnPMBorkZ3o8QkQNxPUY5Gre9Mr2xc1Wk2v8bhTy3hks7onXMhe6+KQTUVKxA66yP2HP+9b3nRMPKYg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2LoJ7HcxWx4ATl2Smqb9HQ22kcW0kBueNTtraErIl7bTlHNqF
	97nPYgZdDA7C3aV9fnRriDYGrNgBIZAblRd8vkP84Id3J+aeARo9u5z4
X-Gm-Gg: ASbGncv8KsmhjSdmnDZLcalawcekQnyyUenTO3F9rhPszAa+28ZxG/z0XxL0kD9oh+/
	V/DCE75z45vvfxih+CuLQVzgrAboZodQVfxMBQRy11su4ljU/9Q/IgvxAg10HGmWXD82s/aQDR/
	6z8HKwrdfjLncjt03IqaUfhmPSxDdOPLgie0n+1jRsBmbKu+mZqsSf8fFP1WpRflFEkI4hlINbP
	nYNb8e6uURpQBqo7SjnKbDrpPxBo+evB5TcGa/DqS9Do4aURIgWTzr7QLdWxr0gYkpP6BvhvlYJ
	NdXg5f8aRFFWkQV/XQpH01jyPpx1+6LF/bm5HLuu9HBc7R0J4uGZe250dQfbCleBefkL5GRacEw
	Hb/XpKEhPf2wxgPVKt/SGosOsEWgBMQFGXUbKTBYw45KqpHKbHsY=
X-Google-Smtp-Source: AGHT+IEpOOtUsXy1a2J8cAC10855T8BcYAtnqNdNrhFnYjaT6Sw0kAWyfa3Zxp9LbAWmQT2R4aOT0A==
X-Received: by 2002:a05:6000:2304:b0:3ec:d926:329c with SMTP id ffacd0b85a97d-40e4dabefffmr10800578f8f.56.1758982947778;
        Sat, 27 Sep 2025 07:22:27 -0700 (PDT)
Received: from [192.168.1.201] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fb9d26ef7sm11287422f8f.26.2025.09.27.07.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 07:22:26 -0700 (PDT)
Message-ID: <52c76446-117d-4953-9b33-32199f782b90@gmail.com>
Date: Sat, 27 Sep 2025 15:21:37 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: re: vduse: add vq group support
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UP5kxYwVcrdQMC9dvc243P9G"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UP5kxYwVcrdQMC9dvc243P9G
Content-Type: multipart/mixed; boundary="------------niaEsC8j9PJOksJIc3X3icG2";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <52c76446-117d-4953-9b33-32199f782b90@gmail.com>
Subject: re: vduse: add vq group support

--------------niaEsC8j9PJOksJIc3X3icG2
Content-Type: multipart/mixed; boundary="------------UeCn0MP0PaDM7niHeJ6H0PT2"

--------------UeCn0MP0PaDM7niHeJ6H0PT2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNClN0YXRpYyBhbmFseXNpcyBvbiBsaW51eC1uZXh0IGhhcyBmb3VuZCBhbiBpc3N1
ZSB3aXRoIHRoZSBmb2xsb3dpbmcgY29tbWl0Og0KDQpjb21taXQgZmZjMzYzNGI2Njk2NzQ0
NWYzMzY4YzNiNTNhNDJiY2NjNTJiMmM3Zg0KQXV0aG9yOiBFdWdlbmlvIFDDqXJleiA8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4NCkRhdGU6ICAgVGh1IFNlcCAyNSAxMToxMzozMiAyMDI1ICsw
MjAwDQoNCiAgICAgdmR1c2U6IGFkZCB2cSBncm91cCBzdXBwb3J0DQoNCg0KVGhpcyBpc3N1
ZSBpcyBhcyBmb2xsb3dzIGluIGZ1bmN0aW9uIHZob3N0X3ZkcGFfdnJpbmdfaW9jdDoNCg0K
ICAgICAgICAgY2FzZSBWSE9TVF9WRFBBX0dFVF9WUklOR19HUk9VUDogew0KICAgICAgICAg
ICAgICAgICB1NjQgZ3JvdXA7DQoNCiAgICAgICAgICAgICAgICAgaWYgKCFvcHMtPmdldF92
cV9ncm91cCkNCiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7
DQogICAgICAgICAgICAgICAgIHMuaW5kZXggPSBpZHg7DQogICAgICAgICAgICAgICAgIGdy
b3VwID0gb3BzLT5nZXRfdnFfZ3JvdXAodmRwYSwgaWR4KTsNCiAgICAgICAgICAgICAgICAg
aWYgKGdyb3VwID49IHZkcGEtPm5ncm91cHMgfHwgZ3JvdXAgPiBVMzJfTUFYIHx8IGdyb3Vw
IDwgMCkNCiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsNCiAgICAgICAg
ICAgICAgICAgZWxzZSBpZiAoY29weV90b191c2VyKGFyZ3AsICZzLCBzaXplb2YocykpKQ0K
ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KICAgICAgICAgICAg
ICAgICBzLm51bSA9IGdyb3VwOw0KICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCiAgICAg
ICAgIH0NCg0KDQpUaGUgY29weV90b191c2VyIG9mIHN0cnVjdCBzIGlzIGNvcHlpbmcgYSBw
YXJ0aWFsbHkgaW5pdGlhbGl6ZWQgc3RydWN0IA0KcywgZmllbGQgcy5udW0gY29udGFpbnMg
Z2FyYmFnZSBkYXRhIGZyb20gdGhlIHN0YWNrIGFuZCB0aGlzIGlzIGJlaW5nIA0KY29waWVk
IGJhY2sgdG8gdXNlciBzcGFjZS4gRmllbGQgcy5udW0gc2hvdWxkIGJlIGFzc2lnbmVkIHNv
bWUgdmFsdWUgDQpiZWZvcmUgdGhlIGNvcHlfdG9fdXNlciBjYWxsIHRvIGF2b2lkIHVuaW5p
dGlhbGl6ZWQgZGF0YSBmcm9tIHRoZSBzdGFjayANCmJlaW5nIGxlYWtlZCB0byB1c2VyIHNw
YWNlLg0KDQpDb2xpbg0KDQo=
--------------UeCn0MP0PaDM7niHeJ6H0PT2
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------UeCn0MP0PaDM7niHeJ6H0PT2--

--------------niaEsC8j9PJOksJIc3X3icG2--

--------------UP5kxYwVcrdQMC9dvc243P9G
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmjX8vEFAwAAAAAACgkQaMKH38aoAibl
tQ/+JR6EYEZVjrMaKvRhqX+ESldrtOXt4cAlOJFgfk6pBzueaLd3Bricu72HiP42MD7/ibOoRVRY
J/1nmxWue6Maumxle5f7kYqKySF4jLg5GduRuG4Fif8h1vtiu+UBGxJhACOYhgrVgvSJo95cdpPi
t0LBE949VgxR4ctRlPNB6wRH5ZAzqGMjsob5NQFoSAI6y3aWnU57/J2a6WfO1BlkuCHcVmJ9r6GS
KRhN+J4GgyrZ3tX5G9EwucrDR5rwn11t6Cvyr3rpSwyYzvkBeY68qtVTH4HRID2PE8Z+yPFzDj7F
sLNAPqX+99yKnhERwnLWoLwW7rl9R9gxyisYXYT18JUCb53npsH5ZmFtZrAh4DwfsMbXFFZrveJ8
vb+oB2+578hWI4N8LpES7C2f5f8T5/QLZeWNNP4i3khgOi3npSkh+wpFTxl2eZRhoEYCx/wO8E1W
+yii1zO47b6AefoYhQuhwqhyj2x1y3s4TBKO8rz0LOawWSddpqgGASRpu3y34F8nKccD82iNIGsh
yLcmaCqbFtzl50QE52IZmRjmRcZIk9Tx9gSEJIzXqaMfb0k2pPjSPAQJ80BKTgrL6e9gUcN2RAyr
urg2SlRvWDM9qxXe4uMT4pAmamz7Z0cTVdr5cp+yLEd7fJ1M1jDYnLYelNN4OmtAABP+NBW9NRsi
gB0=
=PJW8
-----END PGP SIGNATURE-----

--------------UP5kxYwVcrdQMC9dvc243P9G--
