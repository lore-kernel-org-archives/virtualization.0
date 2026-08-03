Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644203839B4
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766272; cv=none; b=G2CWnh1nwYlp2lflYxxN5cpAprudSCLE8ueH6WKPwwiAf0u5xTahZk1pyFxLjldolFhH2KOvqkrgssEYRxwYq8IwZVsUM3omgrWEEVvCrU80kljBcIa0aGdPzyzkCXtfkqziJpu7JsEzVSjhIV5DUKlSkS19lAcQ2dFxHCDR5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766272; c=relaxed/simple;
	bh=uuFRCL7uyGFk+NUBtcHerZxA349KsV1wcoysKkIK15g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnrbPHSYXsFc98xtHDb6zaCih6RuODl9TrhuBR40HcDfrOKcT8InpxBaq+uqDS2br9eScR/3Mn2Y1dg94ZOdWrEH4HlZuMvimS5GYyzTnAl/46WnoL7rXTpbXhhpw389dueYPNHUk6kGNq+UwqKMfAKiKg2XZ6ngpZz4034xIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DfDfF3rv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DfDfF3rv"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so5826803a12.1
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785766268; x=1786371068; darn=lists.linux.dev;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uuFRCL7uyGFk+NUBtcHerZxA349KsV1wcoysKkIK15g=;
        b=DfDfF3rvjSR3B7ptUkbLhSrfTNDA5n+cB9UhQUgcZ9EEqrf6/qW+VBrcN4D/VKmv+j
         YTx8U4KyWdl4+x23Kfu/F5+LWeASpbIhSimIL36ggzGUT8BApq+K5hXDNqqhjDkOH7ek
         FTE5D9aPBRHzANBZIiLeMF2DP0FK2C4VTscwA8zO0sg83ABmp/t+olG/qwyD0wjJMWUf
         /ZWBjPVqQEt9h5SLhX70OKxQZpPtlmeZ+BqrDZhHM5XsT412SG7hw7yCX0rUkSeI9Yiy
         xPrH5Iidr4Go2+LalWbaB+dDTz8pi3MH9ZqBvwHeMZAUXchs8sMPgxOBVwcCfcrHIF3S
         usAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766268; x=1786371068;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uuFRCL7uyGFk+NUBtcHerZxA349KsV1wcoysKkIK15g=;
        b=T0YJMd1JpFcByXHsAwzKFYUz1KoaglB0vpEZ71HwJj/W9uUULbkYX4iDYyhIn/iapa
         /XQDD9hWLsNIkOqdr8TPtfDs9S0NrjOoQi2hroUj+w6CHwCzFXg8mMLIKQiM6FO7YiaG
         QS6wvjmK6JcC4qdPM24EX+qUcC8aLNkdT+9J791VXBObH8Ub73U17qVvoodpbRhDWmqk
         AU7Bj8VDGKj7KSwDiO4ynvczksXqYpmsEuvwilkYJsDRR8p0ZYOqBwy7GwOhbJqHh2yM
         gevz6Vk3yEq3ngWp7/T6oRrM+a88D0WVYLeumxyCEszCmS1WVu7pz8/2WAZqdxKPjnUQ
         SUEw==
X-Forwarded-Encrypted: i=1; AHgh+RoQQQLpBxWDUE86saY2BXlwert9lRduCC/lziP1/PLm4TXeyx9OHFVPZ7Rle5xZlBO0SGUxgoCthd4zOkMsjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxotPKrEBrcEvXZt/j5Ns27oB6N4Ew5/kDOgUsmo6sCAuWgPfdH
	pdx+H/sTGqEvb1Ck4AciySVStgrtwv1aT34kk8q1mwIhNPvceSjQiFytHKiRAiYuGoA=
X-Gm-Gg: AR+sD10Mm0HbFWxlb1iUtZPynE4URVBRJ9pYi9jK8g8CADrGgMeFYSI/M2kl3DxFbmN
	PPGp9bVh4VzDt2pefr9NRGJQLP4K3RZBs1/3eb6IM39iCTZkNp+glP+VPStrNl6Tnmimp8H/63t
	BO6X6W5SX71t/46Sbx/fKQRpQ9lCMPmpVfuDxqeUWxVnFM16McgDSsLe+h99Mu3Nv85RPEgDpbC
	/TLy8bZILGFvUXfiIeO/95N1rcnny5ErwJK1etHn9WJjuyDt2gnEyvYxcqKFG7LNnsJgF7o+Mqn
	0pS6PRQRVRd6JNohopUMTpT1w7COxponbzNvYBgG5rirtexmqP3qXWWpOd5Y/fg+KDcz3g1BvA5
	OTp69S+TrA9sHB+J9D6sLMRoIDqMo0qg/qirfYEbgcj2Sg7iMWTDb+/aQ+iqatEL+rseSy9/dxk
	IVNW5+fUPCqzXf8bfy6KYnJEsAPTuvSmtiSZoXExKmYsTn89xCa+WJdtx7TXjpyWyRi2v61KUNn
	LzZ+fBgvWsq9iKJr1UX0yGOym4XwEHUqEJ41lVUt4czjTu6zJUGHrF44uZndz+EeYpC1H1x0PNB
	AOaLbBX7BzhPtMOEFQnr/sjlcQ==
X-Received: by 2002:a17:907:da15:b0:c16:2dc0:e1ef with SMTP id a640c23a62f3a-c1fe7ee26f5mr869611266b.14.1785766268469;
        Mon, 03 Aug 2026 07:11:08 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd466271csm586500966b.60.2026.08.03.07.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 07:11:08 -0700 (PDT)
Message-ID: <8b5d403c-e77a-45cb-9e3c-d6ccc8ea7a20@suse.com>
Date: Mon, 3 Aug 2026 16:11:07 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: privcmd: fix ioeventfd crash under PV domain
To: Val Packett <val@invisiblethingslab.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20260708082934.16038-1-val@invisiblethingslab.com>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
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
In-Reply-To: <20260708082934.16038-1-val@invisiblethingslab.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1AXnnEZdKSQIDXhChQCpZZ8V"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1AXnnEZdKSQIDXhChQCpZZ8V
Content-Type: multipart/mixed; boundary="------------jjPFIGwq8ny90GlEvD0bObib";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Val Packett <val@invisiblethingslab.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Message-ID: <8b5d403c-e77a-45cb-9e3c-d6ccc8ea7a20@suse.com>
Subject: Re: [PATCH] xen: privcmd: fix ioeventfd crash under PV domain
References: <20260708082934.16038-1-val@invisiblethingslab.com>
In-Reply-To: <20260708082934.16038-1-val@invisiblethingslab.com>

--------------jjPFIGwq8ny90GlEvD0bObib
Content-Type: multipart/mixed; boundary="------------3t26jS1XeIREdEEEzFWgOEUG"

--------------3t26jS1XeIREdEEEzFWgOEUG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDguMDcuMjYgMTA6MTgsIFZhbCBQYWNrZXR0IHdyb3RlOg0KPiBTdGFydGluZyBhIHZp
cnRpbyBiYWNrZW5kIGluIGEgUFYgZG9tYWluIHdvdWxkIHBhbmljIHRoZSBrZXJuZWwgaW4N
Cj4gYWxsb2NfaW9yZXEsIHRyeWluZyB0byBkZXJlZmVyZW5jZSB2bWEtPnZtX3ByaXZhdGVf
ZGF0YSBhcyBhIHBhZ2VzDQo+IHBvaW50ZXIgd2hlbiBpbiByZWFsaXR5IGl0IHN0YXllZCBh
cyBQUklWX1ZNQV9MT0NLRUQuDQo+IA0KPiBBdm9pZCBjcmFzaGluZyBieSBoYW5kbGluZyB0
aGUgUFJJVl9WTUFfTE9DS0VEIGNhc2UgaW4gYWxsb2NfaW9yZXEuDQo+IFBWIHN1cHBvcnQg
cmVxdWlyZXMgbWFwcGluZyB0aGUgdmlydGlvIGlvcmVxIHBhZ2UgZXhwbGljaXRseSBpbnRv
DQo+IHRoZSBrZXJuZWwncyBwYWdlIHRhYmxlcywgc28gZG8gaXQgb24tZGVtYW5kIHdoZW4g
UFJJVl9WTUFfTE9DS0VEDQo+IGlzIHNlZW4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWYWwg
UGFja2V0dCA8dmFsQGludmlzaWJsZXRoaW5nc2xhYi5jb20+DQoNClJldmlld2VkLWJ5OiBK
dWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K
--------------3t26jS1XeIREdEEEzFWgOEUG
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------3t26jS1XeIREdEEEzFWgOEUG--

--------------jjPFIGwq8ny90GlEvD0bObib--

--------------1AXnnEZdKSQIDXhChQCpZZ8V
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpwoXsFAwAAAAAACgkQsN6d1ii/Ey/U
DAgAmd+R/wiU6Lccg8jX9tw5WrYHgjVRd99YLcspiEseAHZsU4BLHRyV8hSKHyR/ATE6m4shUuly
OsgYSf32bvicsIHYOiDbJ4XGkF8w7KItltBOv9QUYImxtaT5iQ/FkC2vuGEzkbubqXPQ9glUnK3K
7Kbh2+FzdkDLPJi12zgYaUWh43Hcqs0vbx/3uYjU0Vv0TVSVoUUx+dbA4R2j7qQUK11hRY0PfpX3
8JErwCCGhoxGQrYQFSKRf/Cjjx1Ki9NGOpfGDSWmVYRnRgKFeGZG0ClYO5e4GPbRg+BeP3xCH5tQ
N9AAdG7HnOPj8UGJulZGa4TGD8X6BS8/fjE+hhKd1w==
=xYVH
-----END PGP SIGNATURE-----

--------------1AXnnEZdKSQIDXhChQCpZZ8V--
