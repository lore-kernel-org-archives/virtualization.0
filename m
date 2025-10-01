Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F023313E
	for <virtualization@lists.linux.dev>; Wed,  1 Oct 2025 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759297724; cv=none; b=h8TC38ztzlB340/vgxFXCaZEDsKvEnuG5mlk+iNKdLKUY4IDKbKrZ8Zkc/2sAXCrH63k223hLM2/SzeLVMSCOP2JmWA2F93J25GDcToAx5xxlUwlXvEqKO8rGrqhoJF91wJHpnGVUT7H7pSHzCmPj14h4Q/gwXoMQx0p8AWcCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759297724; c=relaxed/simple;
	bh=4DQAUi0WJMJ6qbtQA/mAZOs1ErFx37l9lKnV34IplE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+5FO6ILZT8Yhbn7IDvnFHCWJ2YqIDOcpF81rFA7evLJlZD8FMF5VffBZ1BNFD/dq9LmWR5Cm/URIkjvs7htogHfIbanrGUiHjDm/5jSb5aTS63hAX3E38Cvr9Tli3k3UXeZFNF1tLK2eLaCJS9sRrHt1SoLXvlE/VnKVxt/kJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W+14kP0B; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W+14kP0B"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso12457568a12.0
        for <virtualization@lists.linux.dev>; Tue, 30 Sep 2025 22:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759297720; x=1759902520; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4DQAUi0WJMJ6qbtQA/mAZOs1ErFx37l9lKnV34IplE4=;
        b=W+14kP0BYmfs4sVO83AYahs5ncq5U6fPwNj2cSLLXr5PbGdGp96wzSC+J3/tiy4YLB
         k4mS1aWZ/X72Co2cEo+efZELEH0/dVuHzZcBhKEc9hdhcvBLaJuQCWtj6+5ezEwd8BwX
         XTMpQCJZMVlMhxdEag3OzQ8XkfuAh5nytwFpklfFI+9h6olWkqOUAT9KivH9qXj9JUuU
         GICfQ5PIZz0dZ+Ilu1Wc/vAPM0hT75/QhbkXaqUevqJvtw7kBuwXwUxls1BflDj4pG5e
         /BOaWBGVFQ0tlwGJVCwgifPJtLbgml5xF18MRmUu2iVMeB4/ybHKPTmn3PX3+RV3uzeW
         kwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759297720; x=1759902520;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DQAUi0WJMJ6qbtQA/mAZOs1ErFx37l9lKnV34IplE4=;
        b=Nb902JfAPmNO7wj/xMnJ3Wr2Iu3KZBax10Uj93R8PC0jnVKIC4t17ZjrxxPaMNXBd5
         iBXawbMJfGXcqJQqervLuQWeQa19RX0zhYp4reTzeLxY3lLN5SUG5IGi8xedW7AcszcT
         4+EvQcRY/EcZW0DSDGBy6paylGvWn1oTfFjrZ1Ih4mGzM2zjm9RCRBFToEYRmhRKMcOB
         IDNd336Xa95IvuGmNOXDGgYnv05Jpz8jwRUF8F9C3GhqgR/GbNGvDOa4YaZ194DkXMot
         yxNqq+/9/YDnv9kpmH4CNtEMegO1rlw46rEHrp6SwJ5P6eguOel8Adg1sUwgYY8vGwwl
         8iFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUitvfgJC0jzvPH82K4BEYcvcb/CAFFED8hD8JKLAhLGI0iYkgdql5qDwUa0i8+RfEa4rgc96z793iLPK+tbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEMwcC4177ig9lQHssgz9viUBwjpBddR0DPFv6axvfwmnNrdfN
	XkzmQtTW1+WKvQPP+lPhAuNO7y1tpYcTMf6hr+iBoFVUE92f8cxdEEFngAxaECIqcmg=
X-Gm-Gg: ASbGncuhlvH/YDewi9TMTcGl+CHMDob7S6MSOkgsqE412rGb1KIoRU9gnWmSn+ZL/c4
	iSxUvJshk9Ccjy5/u5H3LXr59XT1BGXqpC7u5wWyH5KGVO41T6a43OMAj6ZG5EOhrxQFYFbooV7
	JQtqAYwJAFjL6x4V2joXj+oaweyZlmjimoExZ4TQl0MESHLFeNJ+mJTR+fArJXuDiW7ZIt6+Nqe
	cpR5D2AA+HLRErRMol9gwZ4aqhm999S/vwuGzcTGAkwTe+/hT9TNzQmIvSzqsDxq+v5PKibp3GD
	h9P9nhrj1qUUDtPROd0y4yJZJ9TQoTeriyVEwDaaL6j/seftfuls09d5AHGdJyXykT19m2z8ZdL
	a8cJiNITcIYNnM5pDmplrYXIz5ZXUusnVYHwvV6wigeFvoewMwj9Kie+KYtbAw+/Lb0xqPpXeBE
	PNKn382moQu7RIo2zlwaGJWDv87WKXVxO4JE1wv8aw0W2uSV8y5o5a5tRHDXmaGveNrJuG
X-Google-Smtp-Source: AGHT+IE/17b2UUzfXlD1t/DLm5DVVKaqJxK80m0nHtzrA+dBmOcZIvDnf8hqsrkxUUQ7m0SMeAvPmQ==
X-Received: by 2002:a05:6402:34c1:b0:629:3f9d:b06c with SMTP id 4fb4d7f45d1cf-63678d01890mr2562619a12.33.1759297719591;
        Tue, 30 Sep 2025 22:48:39 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae2cd7sm11345129a12.31.2025.09.30.22.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 22:48:39 -0700 (PDT)
Message-ID: <8c99285f-3268-49b5-a7c3-028761f7ada4@suse.com>
Date: Wed, 1 Oct 2025 07:48:38 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] x86/paravirt: Don't use pv_ops vector for MSR
 access functions
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, xin@zytor.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org
References: <20250930070356.30695-12-jgross@suse.com>
 <202510010555.InsgYDTd-lkp@intel.com>
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
In-Reply-To: <202510010555.InsgYDTd-lkp@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qwD3EhbmEV4miglMzzQiWUdE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qwD3EhbmEV4miglMzzQiWUdE
Content-Type: multipart/mixed; boundary="------------cht0KJsh0UXplkShlKz4mmR0";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, xin@zytor.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org
Message-ID: <8c99285f-3268-49b5-a7c3-028761f7ada4@suse.com>
Subject: Re: [PATCH v2 11/12] x86/paravirt: Don't use pv_ops vector for MSR
 access functions
References: <20250930070356.30695-12-jgross@suse.com>
 <202510010555.InsgYDTd-lkp@intel.com>
In-Reply-To: <202510010555.InsgYDTd-lkp@intel.com>

--------------cht0KJsh0UXplkShlKz4mmR0
Content-Type: multipart/mixed; boundary="------------79lqUm0t09DO937HXCfwgzdf"

--------------79lqUm0t09DO937HXCfwgzdf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzAuMDkuMjUgMjM6MjcsIGtlcm5lbCB0ZXN0IHJvYm90IHdyb3RlOg0KPiBIaSBKdWVy
Z2VuLA0KPiANCj4ga2VybmVsIHRlc3Qgcm9ib3Qgbm90aWNlZCB0aGUgZm9sbG93aW5nIGJ1
aWxkIGVycm9yczoNCj4gDQo+IFthdXRvIGJ1aWxkIHRlc3QgRVJST1Igb24gdGlwL3g4Ni9j
b3JlXQ0KPiBbYWxzbyBidWlsZCB0ZXN0IEVSUk9SIG9uIGxpbnVzL21hc3RlciB2Ni4xN10N
Cj4gW2Nhbm5vdCBhcHBseSB0byBrdm0vcXVldWUga3ZtL25leHQgdGlwL21hc3RlciBrdm0v
bGludXgtbmV4dCB0aXAvYXV0by1sYXRlc3QgbmV4dC0yMDI1MDkyOV0NCj4gW0lmIHlvdXIg
cGF0Y2ggaXMgYXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIGtpbmRseSBkcm9wIHVz
IGEgbm90ZS4NCj4gQW5kIHdoZW4gc3VibWl0dGluZyBwYXRjaCwgd2Ugc3VnZ2VzdCB0byB1
c2UgJy0tYmFzZScgYXMgZG9jdW1lbnRlZCBpbg0KPiBodHRwczovL2dpdC1zY20uY29tL2Rv
Y3MvZ2l0LWZvcm1hdC1wYXRjaCNfYmFzZV90cmVlX2luZm9ybWF0aW9uXQ0KPiANCj4gdXJs
OiAgICBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwtbGFiLWxrcC9saW51eC9jb21taXRzL0p1
ZXJnZW4tR3Jvc3MvY29jby10ZHgtUmVuYW1lLU1TUi1hY2Nlc3MtaGVscGVycy8yMDI1MDkz
MC0xNTA3NTMNCj4gYmFzZTogICB0aXAveDg2L2NvcmUNCj4gcGF0Y2ggbGluazogICAgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDkzMDA3MDM1Ni4zMDY5NS0xMi1qZ3Jvc3Ml
NDBzdXNlLmNvbQ0KPiBwYXRjaCBzdWJqZWN0OiBbUEFUQ0ggdjIgMTEvMTJdIHg4Ni9wYXJh
dmlydDogRG9uJ3QgdXNlIHB2X29wcyB2ZWN0b3IgZm9yIE1TUiBhY2Nlc3MgZnVuY3Rpb25z
DQo+IGNvbmZpZzogeDg2XzY0LWJ1aWxkb25seS1yYW5kY29uZmlnLTAwMS0yMDI1MTAwMSAo
aHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjUxMDAxLzIwMjUx
MDAxMDU1NS5JbnNnWURUZC1sa3BAaW50ZWwuY29tL2NvbmZpZykNCj4gY29tcGlsZXI6IGNs
YW5nIHZlcnNpb24gMjAuMS44IChodHRwczovL2dpdGh1Yi5jb20vbGx2bS9sbHZtLXByb2pl
Y3QgODdmMDIyN2NiNjAxNDdhMjZhMWVlYjRmYjA2ZTNiNTA1ZTljNzI2MSkNCj4gcmVwcm9k
dWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKTogKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBk
YXktY2kvYXJjaGl2ZS8yMDI1MTAwMS8yMDI1MTAwMTA1NTUuSW5zZ1lEVGQtbGtwQGludGVs
LmNvbS9yZXByb2R1Y2UpDQo+IA0KPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSBpbiBhIHNlcGFy
YXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhIG5ldyB2ZXJzaW9uIG9mDQo+IHRo
ZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZ3MNCj4gfCBS
ZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IHwgQ2xv
c2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjUxMDAxMDU1
NS5JbnNnWURUZC1sa3BAaW50ZWwuY29tLw0KPiANCj4gQWxsIGVycm9ycyAobmV3IG9uZXMg
cHJlZml4ZWQgYnkgPj4pOg0KPiANCj4gICAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBhcmNo
L3g4Ni9rZXJuZWwvYXNtLW9mZnNldHMuYzo5Og0KPiAgICAgSW4gZmlsZSBpbmNsdWRlZCBm
cm9tIGluY2x1ZGUvbGludXgvY3J5cHRvLmg6MTg6DQo+ICAgICBJbiBmaWxlIGluY2x1ZGVk
IGZyb20gaW5jbHVkZS9saW51eC9zbGFiLmg6MTY6DQo+ICAgICBJbiBmaWxlIGluY2x1ZGVk
IGZyb20gaW5jbHVkZS9saW51eC9nZnAuaDo3Og0KPiAgICAgSW4gZmlsZSBpbmNsdWRlZCBm
cm9tIGluY2x1ZGUvbGludXgvbW16b25lLmg6MjI6DQo+ICAgICBJbiBmaWxlIGluY2x1ZGVk
IGZyb20gaW5jbHVkZS9saW51eC9tbV90eXBlcy5oOjE2Og0KPiAgICAgSW4gZmlsZSBpbmNs
dWRlZCBmcm9tIGluY2x1ZGUvbGludXgvdXByb2Jlcy5oOjE4Og0KPiAgICAgSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIGluY2x1ZGUvbGludXgvdGltZXIuaDo2Og0KPiAgICAgSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIGluY2x1ZGUvbGludXgva3RpbWUuaDoyNToNCj4gICAgIEluIGZpbGUg
aW5jbHVkZWQgZnJvbSBpbmNsdWRlL2xpbnV4L2ppZmZpZXMuaDoxMDoNCj4gICAgIEluIGZp
bGUgaW5jbHVkZWQgZnJvbSBpbmNsdWRlL2xpbnV4L3RpbWUuaDo2MDoNCj4gICAgIEluIGZp
bGUgaW5jbHVkZWQgZnJvbSBpbmNsdWRlL2xpbnV4L3RpbWUzMi5oOjEzOg0KPiAgICAgSW4g
ZmlsZSBpbmNsdWRlZCBmcm9tIGluY2x1ZGUvbGludXgvdGltZXguaDo2NzoNCj4gICAgIElu
IGZpbGUgaW5jbHVkZWQgZnJvbSBhcmNoL3g4Ni9pbmNsdWRlL2FzbS90aW1leC5oOjY6DQo+
ICAgICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gYXJjaC94ODYvaW5jbHVkZS9hc20vdHNjLmg6
MTE6DQo+Pj4gYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmg6MzI3OjEwOiBmYXRhbCBlcnJv
cjogJ2FzbS94ZW4vbXNyLmgnIGZpbGUgbm90IGZvdW5kDQo+ICAgICAgIDMyNyB8ICNpbmNs
dWRlIDxhc20veGVuL21zci5oPg0KPiAgICAgICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+
fn5+fn4NCj4gICAgIDEgZXJyb3IgZ2VuZXJhdGVkLg0KPiAgICAgbWFrZVszXTogKioqIFtz
Y3JpcHRzL01ha2VmaWxlLmJ1aWxkOjE4MjogYXJjaC94ODYva2VybmVsL2FzbS1vZmZzZXRz
LnNdIEVycm9yIDEgc2h1ZmZsZT0zNDcxNDk1Mjg4DQo+ICAgICBtYWtlWzNdOiBUYXJnZXQg
J3ByZXBhcmUnIG5vdCByZW1hZGUgYmVjYXVzZSBvZiBlcnJvcnMuDQo+ICAgICBtYWtlWzJd
OiAqKiogW01ha2VmaWxlOjEyODI6IHByZXBhcmUwXSBFcnJvciAyIHNodWZmbGU9MzQ3MTQ5
NTI4OA0KPiAgICAgbWFrZVsyXTogVGFyZ2V0ICdwcmVwYXJlJyBub3QgcmVtYWRlIGJlY2F1
c2Ugb2YgZXJyb3JzLg0KPiAgICAgbWFrZVsxXTogKioqIFtNYWtlZmlsZToyNDg6IF9fc3Vi
LW1ha2VdIEVycm9yIDIgc2h1ZmZsZT0zNDcxNDk1Mjg4DQo+ICAgICBtYWtlWzFdOiBUYXJn
ZXQgJ3ByZXBhcmUnIG5vdCByZW1hZGUgYmVjYXVzZSBvZiBlcnJvcnMuDQo+ICAgICBtYWtl
OiAqKiogW01ha2VmaWxlOjI0ODogX19zdWItbWFrZV0gRXJyb3IgMiBzaHVmZmxlPTM0NzE0
OTUyODgNCj4gICAgIG1ha2U6IFRhcmdldCAncHJlcGFyZScgbm90IHJlbWFkZSBiZWNhdXNl
IG9mIGVycm9ycy4NCj4gDQo+IA0KPiB2aW0gKzMyNyBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9t
c3IuaA0KPiANCj4gICAgIDMyNQkNCj4gICAgIDMyNgkjaWZkZWYgQ09ORklHX1hFTl9QVg0K
PiAgID4gMzI3CSNpbmNsdWRlIDxhc20veGVuL21zci5oPg0KPiAgICAgMzI4CQ0KPiANCg0K
VWgsIEkgZm9yZ290IHRvICJnaXQgYWRkIiB0aGF0IG5ldyBoZWFkZXIgZmlsZS4gV2lsbCBi
ZSBjb3JyZWN0ZWQgaW4gVjMuDQoNCg0KSnVlcmdlbg0K
--------------79lqUm0t09DO937HXCfwgzdf
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------79lqUm0t09DO937HXCfwgzdf--

--------------cht0KJsh0UXplkShlKz4mmR0--

--------------qwD3EhbmEV4miglMzzQiWUdE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjcwLYFAwAAAAAACgkQsN6d1ii/Ey+V
zggAiGGv9dwzqk1bPEe3rdx0CuLqy6A6t7w9ay8FUfx76po9ul5QWLGJwMiu0wGNg6lT52S5oZ5q
YOzgmDy9UGCWfIdcR4sMAtXjoVxlmN/4l5j50CzQub9rB50qIIqq9gw9Yipg6iLoC2w/8IPV2GXt
rN7k4l5+XJIk+s6WiWwROlNh34CY5kinTjn7DHZrVx43UlXrXt66zHORYdFCDgLb2Yxmz3DALkvS
kgAwGheqtlr52QLY0jKN3JndClF0Kp4jpkVigwRvWJW49tHBOpnbCIbrO2f/GxYwN359WXw7Q/tD
SLJOWOjd9gXXHQHOAnkWnNyTo+/lPVcO6JYWYqP/XA==
=4wxD
-----END PGP SIGNATURE-----

--------------qwD3EhbmEV4miglMzzQiWUdE--
