Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85DF3A169C
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533698; cv=none; b=bpJqP0kbFdt84x6hgn8sRXuezVEBHyMatMwqcAk4DFzOm9hJ8++Ype64ncwbuPRQ1uZfvxr9zBN4cnhV/XAfZ0iB7cI3KzwQ0eTQM/fl524p9lsfHXYhz/6d00Fn1Nqt38L6hZpYfZj+ozvXvy8rDEP7YQJd8Sar0xQeW4EkJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533698; c=relaxed/simple;
	bh=koCIkbLuEpYk7sgKuWw7WuOQwUgoC8m1LjvBSNVIa70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fx6JNnensoIjKSG8LiRV9mi8crkgl8/YIK8Gv1PH6ZWePcC7KmURB7vmJxIeJTKzrtGVyvY8PWHYV9fKaiKxbTIGlwI1p/f6AclSCqttOB3rPwIDtqJNeqq9eqypQKxJfm+drzW25lCOGfIgMpk+XvMEGU7SvXT4xe6P4DuWs0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MLMc3YRR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MLMc3YRR"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67b6a6bd7b8so272718a12.0
        for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 00:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777533695; x=1778138495; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=koCIkbLuEpYk7sgKuWw7WuOQwUgoC8m1LjvBSNVIa70=;
        b=MLMc3YRRp7DLy2LtoiqPo6B11zsTagWWHNarZ0YPHo8GwW8sWt2BezkmzQRgjPNRf3
         RtTXcOQvQzQZuq8KworhXaimQSDrWI1e+jZJlU1LgUvh+DZIC3bLLG5DCSwkVQhtZ2lC
         JgzCKvVpA3lbFCie4pIuCCSRLo9F7/j2M/j0VWa+t3TXmPCQy/cIzrOONIJG+IKux3QQ
         XimlrXrc+M6VUwtPp9/tUIyivh0d10Qovjj2ceYtf/STEdgX8+9nk2tt+rwnHj3U+pV/
         IXDKuOnm0b3Pq3rnJyo/B66JPMa3ypiYpQsbIacaO1SFQik80KgFDcwdmcjkKJLnRw6a
         5HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777533695; x=1778138495;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koCIkbLuEpYk7sgKuWw7WuOQwUgoC8m1LjvBSNVIa70=;
        b=UoDhK9CXtaKKwQLmLm1RZsLDmye87w1xX/9SEDXQZq/hiEJ6YtybKwoCrTVq5GI7D+
         moBb0iiNSvagFlMA1vZGwMAx6JkPfp0WwTHsPsxfp9M2AaoN6djXc7SBGyJIqR59H5sw
         tXRaTQvbLEOSH/cP/4Qm36FY7cd0nizCNQbqG5LCJ4Gr8++MfOnm1pC30/T38wgFRgJd
         tmUjPK0B3QxKVCBlvF18iPZSnLuA2/kWbiyuZA+mrjGSEqq7//tUl1f3Vrz0rwS2pHtp
         epYAHAqyRYWohY1/X1g5Oa+FZoFEpNEgwcoTBghw6l+M8FN+G+y/Zq8wuHw+ug91G1Xw
         lNdw==
X-Forwarded-Encrypted: i=1; AFNElJ/g0b+lwOQTFMS1JOzyIDz2MEr8+42cwD1TJK5Igh+QcaJ1sFnkUixwoa45SciBn2PyMYdeXIX0+hfRouyK7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YweodjtfznE57wax05H8Q1OAxgEi+jsFnBp2iP2rsZ8vpnZI3OQ
	o1308xApxe1azMqELu1E0ae2iIe64R/MkcrxwCpbrcx3yYssM0w6MpAJVgmmbX4SPQQ=
X-Gm-Gg: AeBDievx0UTs6wB3j403HBQ9i3g8bjbcTGLxX/5E6kWdf1z4OKx2p0sCuT7+NQvRja6
	qxi12t+HhGSkiy4dNTfVbBhQDChfIkL+5KuX4QUvdfy1Y8zQEhjDUQsuPJvqxWQJffeAkjH8Vr4
	vyYVUL1VNlFPTGgNS1HTaHwC7LcgKV+kvMFK7rpYJg+1+hXOUIMQozjqCNq2oYrHPkWQm5GL9A1
	KOTaA8zxP2jBw6D0DJb4TuAB6xRXz3ORy4a56qyNCwXZ0Z7hg7e2HJpN7xKxIWD2/k8yIrjK2H3
	M/a4e0TNcti08YSWsSnpAuA/xiqM+5rC3KniPeOODQP4SyFptOOEIf0Sojqpyh/rMyMBUHc/ODs
	dBlGEo0hXn3DhpDHwtX3nrbCnAc+ctTLjC8dfAkeCiu1hAFgR2lRmbAwhx1gNFhF+SPthnfpSb8
	NQIOXcjgZwIAxe8KJCQiUnc84RlOxxy6FuNhLr9mxFjpNFXeoSTMA349kYR+tUeXubAdzmUmlRq
	ybCGbEMuJ+zgwuwcIBIgykfxjQpSobVGRQhzH0HXSItPuSBSR3xfQboewpC3plf
X-Received: by 2002:a05:6402:a506:20b0:67b:6ab4:e86c with SMTP id 4fb4d7f45d1cf-67b6ab4e9abmr167225a12.11.1777533695197;
        Thu, 30 Apr 2026 00:21:35 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b728271fesm25957a12.20.2026.04.30.00.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 00:21:34 -0700 (PDT)
Message-ID: <e7c72dde-7e8e-457a-9f9f-c3799cbe28e2@suse.com>
Date: Thu, 30 Apr 2026 09:21:34 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] x86/msr: Consolidate native/paravirt MSR functions
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 virtualization@lists.linux.dev
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
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
In-Reply-To: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ajXt4V2D1cCi576vBW2won0O"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ajXt4V2D1cCi576vBW2won0O
Content-Type: multipart/mixed; boundary="------------Qt89ZWDNipr0IK9Pl3hFeDas";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 virtualization@lists.linux.dev
Message-ID: <e7c72dde-7e8e-457a-9f9f-c3799cbe28e2@suse.com>
Subject: Re: [PATCH v2 0/8] x86/msr: Consolidate native/paravirt MSR functions
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
In-Reply-To: <20260429184517.7E078510@davehans-spike.ostc.intel.com>

--------------Qt89ZWDNipr0IK9Pl3hFeDas
Content-Type: multipart/mixed; boundary="------------x008UZ98YNTjXhVfPnfNywds"

--------------x008UZ98YNTjXhVfPnfNywds
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDQuMjYgMjA6NDUsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiBDaGFuZ2VzIGZyb20g
djE6DQo+ICAgLSBSZW1vdmUgInJhd18iIG5hbWVzLiBKdXN0IHVzZSAicGFyYXZpcnRfIiBp
biB0aGUgZ2VuZXJpYyBjb2RlLg0KPiANCj4gSSdtIHRoaW5raW5nIEknbGwganVzdCBhcHBs
eSB0aGlzIGluIHRoZSBjb21pbmcgZGF5cyBpZiBub2JvZHkNCj4gc2NyZWFtcyB0b28gbG91
ZGx5Lg0KPiANCj4gLS0NCj4gDQo+IFRoaXMgaXMgb2xkIGNydWZ0LCBidXQgaXQgYXBwZWFy
cyB0aGF0IGhhdmluZyB0d28gY29waWVzIG9mIHRoZXNlDQo+IE1TUiBmdW5jdGlvbnMgaXMg
ZW5hYmxpbmcgd2FybmluZ3MgdG8gY3JlZXAgaW5bMV0uDQo+IA0KPiBJIGtub3cgdGhlcmUn
cyBhbHNvIGJlZW4gc29tZSB3b3JrIHRvIHBhcmUgZG93biB0aGUgWFhMIGNvZGUsIGJ1dA0K
PiBpdCdzIG9idmlvdXNseSBub3QgbWVyZ2VkIHlldCBhbmQgdGhpcyBpcyBhIGdvb2QgYmFi
eSBzdGVwLg0KPiANCj4gQ3JlYXRlIGhlbHBlcnMgdGhhdCBib3RoIHBhcmF2aXJ0IGFuZCBu
YXRpdmUgY2FuIHVzZSBpbiBjb21tb24gY29kZQ0KPiBhbmQgcmVtb3ZlIHRoZSBwYXJhdmly
dCBpbXBsZW1lbnRhdGlvbnMgb2YgdGhlIGhlbHBlcnMuIFRoaXMgcmVkdWNlcw0KPiB0aGUg
YW1vdW50IG9mIGxvZ2ljIHRoYXQgaXMgZHVwbGljYXRlZCBpbiB0aGUgcGFyYXZpcnQgY29k
ZS4NCj4gDQo+IFRoZSB3b25reSB0aGluZyBhYm91dCB0aGlzIHNvbHV0aW9uIGlzIHRoYXQg
aXQgaGFzIHRoZSBjb21tb24gY29kZQ0KPiBhbHdheXMgbWFrZSBsaXRlcmFsICJwYXJhdmly
dF8iIGNhbGxzLCBldmVuIHdoZW4gcGFyYXZpcnQgaXMgbm90IGluDQo+IHVzZSBmb3IgTVNS
cy4gSW4gdGhhdCBjYXNlLCB0aGUgY2FsbHMganVzdCBnbyBkaXJlY3RseSB0byB0aGUNCj4g
Im5hdGl2ZV8iIGZ1bmN0aW9ucyB2aWEgI2RlZmluZXMuDQo+IA0KPiBDb25jZXB0dWFsbHk6
DQo+ICAgLSAgIG5hdGl2ZTogVGhlIGJhcmUtbWV0YWwgaW1wbGVtZW50YXRpb24uIE1pZ2h0
IG5vdCBiZSB1c2FibGUgdW5kZXINCj4gCSAgICAgcGFyYXZpcnQgWFhMLg0KPiAgIC0gcGFy
YXZpcnQ6IENhbGwgdGhlIG5hdGl2ZSB2ZXJzaW9uIGRpcmVjdGx5IGlmIHBhcmF2aXJ0IGlz
IGNvbXBpbGVkDQo+ICAgCSAgICAgb3V0LiBDYWxsIGludG8gcGFyYXZpcnQgb3BzIHdoZW4g
YXZhaWxhYmxlLCB3aGljaCBtaWdodA0KPiAJICAgICB1bHRpbWF0ZWx5IGNhbGwgYSBuYXRp
dmUgaW1wbGVtZW50YXRpb24uDQo+IA0KPiAxLiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyNjAzMTkxNTIyMTAuMjEwODU0LTEtYWxkb2NvbnRlbGtAZ21haWwuY29tLw0KPiAN
Cj4gICBtc3IuaCAgICAgIHwgIDEyNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgcGFyYXZpcnQuaCB8ICAgNDQg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2NSBpbnNlcnRp
b25zKCspLCAxMDMgZGVsZXRpb25zKC0pDQoNCkFwYXJ0IGZyb20gdGhlIGNvbW1lbnQgZm9y
IHBhdGNoIDg6DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5j
b20+DQoNCg0KSnVlcmdlbg0K
--------------x008UZ98YNTjXhVfPnfNywds
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------x008UZ98YNTjXhVfPnfNywds--

--------------Qt89ZWDNipr0IK9Pl3hFeDas--

--------------ajXt4V2D1cCi576vBW2won0O
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmnzAv4FAwAAAAAACgkQsN6d1ii/Ey8v
Ogf/YavOW7aNqahAc2zgB9My+NSLym0ds8fC3N0SOeWdlam6U7SOuyt0TYgzMZIHfpFNO2tkHPFZ
xHfF/hkV4qc/A/3nBYifm7w/FInt9J6hkcmvDoCN1pmb7Vb8WdFdKoX/tsUx3y31igxnNwI6PrH/
Cplrg/TOdsPgj5aFXiovpoedJTh9UQ3IBF0aI147dcoydk+wFz3Rixwc/FZzjXK1c37IKAubTxYG
fJ8Uro4dGvvNexlFkl0SfBKMYKdZa1C3BszCNV8N7cQmnUksi7kfmOvGroIa7JRPdOe31p7fiuVX
8u2qOR/OGIFv24M7JEgs8r0Lk47Q1hSh0xQfwCJRfw==
=scSp
-----END PGP SIGNATURE-----

--------------ajXt4V2D1cCi576vBW2won0O--
