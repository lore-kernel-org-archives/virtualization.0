Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114A121FF48
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028045; cv=none; b=JcIycWuHqXhwi/56+zKqcRpZfZmoAcR/SIgHvVwBi+phKWRnHhFjLdvVk7AsMavd5eYFY6LN7SAYn1/blgByjFLrcIpmPJ9n+Sus73+WamDnP2IRCDEMrxOFltYGTjuoZ1VhPUNgLN+FsBG/+MhYAgutJv1JN2dgtrkdxQdLJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028045; c=relaxed/simple;
	bh=l+3o+MHKL82BTRKdVCIUQ3bcYUyRbNh1DNTmf0Cc978=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szeCKS8grFZjdyxepmm7qizvw2xku1ZeTi6J6UM0Hi9vGkjjkcx+011/UQtya1HNra767LIeEtcx47vj9zO1yy7ayJDqfCxGzcP9NPR69Jdqw2NFvKSNjwtyV6WueSgNFUU3T7M/9Rl10phYa4zl0gighBvYvygYRpWDQ1YzHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lz/i0BC+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lz/i0BC+"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b885e8c679bso661505066b.1
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 02:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770028041; x=1770632841; darn=lists.linux.dev;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l+3o+MHKL82BTRKdVCIUQ3bcYUyRbNh1DNTmf0Cc978=;
        b=Lz/i0BC+X2I9UVQ9x4OvKctVPMNoJMPt8V3S7V/SbIDw7AfcCA9pyda0DnWX1L8C+C
         PcsgPbMQtUiOUBzPtM6I5t92lZuaoXGU5Ew7mOEfEypYwLk72ZhbwWLLZujrx+D2l1Ba
         DMjHaDcLnwFnHjaZcQ3slnJ8WH+4ZkY3nlIAb6C881x17SluXRw4/w+ve2L7OhtXOoJA
         aw0yqDUshAHKRhpMuesL5KECjlHTflMwgkxfYxgfk4o3Xm8zamLlEbMx8OX4YMqbSDmo
         Ly3T3ao08K94tBa6uIaCzfACxD8Udds46E25h5H3fXwoR8Qg6/q5yTsZoitG+29xJfw7
         dfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770028041; x=1770632841;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+3o+MHKL82BTRKdVCIUQ3bcYUyRbNh1DNTmf0Cc978=;
        b=FNV/xHMHVrtDi+3S7Sbf+rOW0CkC9Y4aXi0HiQKNxydFgcn1ktzArNB3F8dseEh4VX
         QA9ME2fJWwGypNMsS9fF05+uOtHCqJ4hJTgQjE5w3sjPw94F+75pn+hV4PlbF8+DkxsD
         dI+4/Kt/EUqRJOHXAU7VP+o6OunUE6goTcxvUtxhtFhalrq/mWmSRN7Ae7HFgTgMffiA
         TO0h2bEHeXXavUhv8lnzC7bnLRiw1eKtxbGOw4EUJuKviXESoaRPzn1qUJiBuf01KB3B
         VZqWwEPdp15qQpYtRoGbE0j/kydbk61VGZCsQCih73negAM0xy17Mdk3WkM5YHXMIVCo
         ZJow==
X-Forwarded-Encrypted: i=1; AJvYcCWDpl801aYb5krQhGbLdikRVOhUgikvYz/ZR4NMITNAuqh4E1YIrOKwRqbHGoBBGtczwjMpPpR5xzk9zfDHCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzT6mrE95yde/ELNnFNNuVFUn9dSdkXeZ3X1xKg6jzjUL4L99uq
	JMpQlqu2JMNmueyhpLfYYxtnEsmVtKH5r7wSZ8lKRiv1dbvWzjz7HW+qlttf82xHqtA=
X-Gm-Gg: AZuq6aKe/AuX48Llsna+dVJjm+udCqpPdoZJhbmnJK+w1Xq8CvC3+cweWfUAYjPfEBg
	M94va0RXM//kd4V5obpFDLZNG3CTvrsUEQ4yx867NzEZ8dykyol4mqCyi1Z11XEMTOIp+H5dacR
	hMT7EDm1zKimZao64lC+3PFN+Mj5h19zgS1EGlS3Db41ylhvJFAHgEMwqU/GEM0HOC6Z3Ld/xj2
	lmkgTLeQb8WrzdzvaLkhSF6Q2jW1/EI8xpTcH//x2/7WY8hXkPEddwDp8saxB1qeowPJLLrp+bi
	qNEGRgs8UQvoREU92EtGf2QDt/lhQSHDA3689CjU4KCaDWoTagQbIsQHsgcJh2Muzpm7tHurvrk
	TN8AUNraVb5hKGWwXpof3NFqmzjbl7wjppwrjULPbT8mHxuxSQuzfzhEi/jC2F0PNrQU99wtxCC
	Eg6B7fc0R3TrWekeX0dQHYiIWRN2l5pWyybztLrxvy7Lbs2hCnPrGXRVvbtm99ttsoDJeDbDM24
	h7CFGfEHGKx3cqTgcFwFuE+V3x3ZV2HaXjxFw==
X-Received: by 2002:a17:906:d54e:b0:b87:6af7:c186 with SMTP id a640c23a62f3a-b8dff8674d3mr755283566b.54.1770028041362;
        Mon, 02 Feb 2026 02:27:21 -0800 (PST)
Received: from ?IPV6:2a00:12d0:af5b:2f01:4042:c03:ce4d:a5a1? (2a00-12d0-af5b-2f01-4042-c03-ce4d-a5a1.ip.tng.de. [2a00:12d0:af5b:2f01:4042:c03:ce4d:a5a1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8de3d734aesm688456966b.7.2026.02.02.02.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:27:21 -0800 (PST)
Message-ID: <0afb8dc5-6ab9-4f61-af3a-8424835386e4@suse.com>
Date: Mon, 2 Feb 2026 11:27:20 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] x86: Cleanups around slow_down_io()
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Denis Efremov <efremov@linux.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20260119182632.596369-1-jgross@suse.com>
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
In-Reply-To: <20260119182632.596369-1-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EFFtuyAw2mxdAKPsAqPioBPH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EFFtuyAw2mxdAKPsAqPioBPH
Content-Type: multipart/mixed; boundary="------------DPiBTuW4WhK0KFF1cKCxJjmg";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Denis Efremov <efremov@linux.com>,
 Jens Axboe <axboe@kernel.dk>
Message-ID: <0afb8dc5-6ab9-4f61-af3a-8424835386e4@suse.com>
Subject: Re: [PATCH v4 0/6] x86: Cleanups around slow_down_io()
References: <20260119182632.596369-1-jgross@suse.com>
In-Reply-To: <20260119182632.596369-1-jgross@suse.com>

--------------DPiBTuW4WhK0KFF1cKCxJjmg
Content-Type: multipart/mixed; boundary="------------liiRpZ2LGHl5C0gioM2bJdPR"

--------------liiRpZ2LGHl5C0gioM2bJdPR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UGluZz8NCg0KT24gMTkuMDEuMjYgMTk6MjYsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IFdo
aWxlIGxvb2tpbmcgYXQgcGFyYXZpcnQgY2xlYW51cHMgSSBzdHVtYmxlZCBvdmVyIHNsb3df
ZG93bl9pbygpIGFuZA0KPiB0aGUgcmVsYXRlZCBSRUFMTFlfU0xPV19JTyBkZWZpbmUuDQo+
IA0KPiBEbyBzZXZlcmFsIGNsZWFudXBzLCByZXN1bHRpbmcgaW4gYSBkZWxldGlvbiBvZiBS
RUFMTFlfU0xPV19JTyBhbmQgdGhlDQo+IGlvX2RlbGF5KCkgcGFyYXZpcnQgZnVuY3Rpb24g
aG9vay4NCj4gDQo+IFBhdGNoIDQgaXMgcmVtb3ZpbmcgdGhlIGNvbmZpZyBvcHRpb25zIGZv
ciBzZWxlY3RpbmcgdGhlIGRlZmF1bHQgZGVsYXkNCj4gbWVjaGFuaXNtIGFuZCBzZXRzIHRo
ZSBkZWZhdWx0IHRvICJubyBkZWxheSIuIFRoaXMgaXMgaW4gcHJlcGFyYXRpb24gb2YNCj4g
cmVtb3ZpbmcgdGhlIGlvX2RlbGF5KCkgZnVuY3Rpb25hbGl0eSBjb21wbGV0ZWx5LCBhcyBz
dWdnZXN0ZWQgYnkgSW5nbw0KPiBNb2xuYXIuDQo+IA0KPiBQYXRjaCA1IGlzIGFkZGluZyBh
biBhZGRpdGlvbmFsIGNvbmZpZyBvcHRpb24gYWxsb3dpbmcgdG8gYXZvaWQNCj4gYnVpbGRp
bmcgaW9fZGVsYXkuYyAoZGVmYXVsdCBpcyBzdGlsbCB0byBidWlsZCBpdCkuDQo+IA0KPiBD
aGFuZ2VzIGluIFYyOg0KPiAtIHBhdGNoZXMgMiBhbmQgMyBvZiBWMSBoYXZlIGJlZW4gYXBw
bGllZA0KPiAtIG5ldyBwYXRjaGVzIDQgYW5kIDUNCj4gDQo+IENoYW5nZXMgaW4gVjM6DQo+
IC0gcmViYXNlIHRvIHRpcC9tYXN0ZXIga2VybmVsIGJyYW5jaA0KPiANCj4gQ2hhbmdlcyBp
biBWNDoNCj4gLSBhZGQgcGF0Y2ggMSBhcyBwcmVyZXEgcGF0Y2ggdG8gdGhlIHNlcmllcw0K
PiANCj4gSnVlcmdlbiBHcm9zcyAoNik6DQo+ICAgIHg4Ni9pcnFmbGFnczogRml4IGJ1aWxk
IGZhaWx1cmUNCj4gICAgeDg2L3BhcmF2aXJ0OiBSZXBsYWNlIGlvX2RlbGF5KCkgaG9vayB3
aXRoIGEgYm9vbA0KPiAgICBibG9jay9mbG9wcHk6IERvbid0IHVzZSBSRUFMTFlfU0xPV19J
TyBmb3IgZGVsYXlzDQo+ICAgIHg4Ni9pbzogUmVtb3ZlIFJFQUxMWV9TTE9XX0lPIGhhbmRs
aW5nDQo+ICAgIHg4Ni9pb19kZWxheTogU3dpdGNoIGlvX2RlbGF5KCkgZGVmYXVsdCBtZWNo
YW5pc20gdG8gIm5vbmUiDQo+ICAgIHg4Ni9pb19kZWxheTogQWRkIGNvbmZpZyBvcHRpb24g
Zm9yIGNvbnRyb2xsaW5nIGJ1aWxkIG9mIGlvX2RlbGF5Lg0KPiANCj4gICBhcmNoL3g4Ni9L
Y29uZmlnICAgICAgICAgICAgICAgICAgICAgIHwgIDggKysrDQo+ICAgYXJjaC94ODYvS2Nv
bmZpZy5kZWJ1ZyAgICAgICAgICAgICAgICB8IDMwIC0tLS0tLS0tLS0NCj4gICBhcmNoL3g4
Ni9pbmNsdWRlL2FzbS9mbG9wcHkuaCAgICAgICAgIHwgMzEgKysrKysrKystLQ0KPiAgIGFy
Y2gveDg2L2luY2x1ZGUvYXNtL2lvLmggICAgICAgICAgICAgfCAxOSArKysrLS0tDQo+ICAg
YXJjaC94ODYvaW5jbHVkZS9hc20vaXJxZmxhZ3MuaCAgICAgICB8ICA2ICstDQo+ICAgYXJj
aC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQtYmFzZS5oICB8ICA2ICsrDQo+ICAgYXJjaC94
ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaCAgICAgICB8IDExIC0tLS0NCj4gICBhcmNoL3g4
Ni9pbmNsdWRlL2FzbS9wYXJhdmlydF90eXBlcy5oIHwgIDIgLQ0KPiAgIGFyY2gveDg2L2tl
cm5lbC9NYWtlZmlsZSAgICAgICAgICAgICAgfCAgMyArLQ0KPiAgIGFyY2gveDg2L2tlcm5l
bC9jcHUvdm13YXJlLmMgICAgICAgICAgfCAgMiArLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC9p
b19kZWxheS5jICAgICAgICAgICAgfCA4MSArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gICBhcmNoL3g4Ni9rZXJuZWwva3ZtLmMgICAgICAgICAgICAgICAgIHwgIDggKy0tDQo+
ICAgYXJjaC94ODYva2VybmVsL3BhcmF2aXJ0LmMgICAgICAgICAgICB8ICAzICstDQo+ICAg
YXJjaC94ODYva2VybmVsL3NldHVwLmMgICAgICAgICAgICAgICB8ICA0ICstDQo+ICAgYXJj
aC94ODYveGVuL2VubGlnaHRlbl9wdi5jICAgICAgICAgICB8ICA2ICstDQo+ICAgZHJpdmVy
cy9ibG9jay9mbG9wcHkuYyAgICAgICAgICAgICAgICB8ICAyIC0NCj4gICAxNiBmaWxlcyBj
aGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspLCAxNTkgZGVsZXRpb25zKC0pDQo+IA0KDQo=
--------------liiRpZ2LGHl5C0gioM2bJdPR
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R3/CwO0EGAEIACAWIQSFEmdy6PYElKXQl/ew3p3W
KL8TLwUCWt3w0AIbAgCBCRCw3p3WKL8TL3YgBBkWCAAdFiEEUy2wekH2OPMeOLge
gFxhu0/YY74FAlrd8NAACgkQgFxhu0/YY75NiwD/fQf/RXpyv9ZX4n8UJrKDq422
bcwkujisT6jix2mOOwYBAKiip9+mAD6W5NPXdhk1XraECcIspcf2ff5kCAlG0DIN
aTUH/RIwNWzXDG58yQoLdD/UPcFgi8GWtNUp0Fhc/GeBxGipXYnvuWxwS+Qs1Qay
7/Nbal/v4/eZZaWs8wl2VtrHTS96/IF6q2o0qMey0dq2AxnZbQIULiEndgR625EF
RFg+IbO4ldSkB3trsF2ypYLij4ZObm2casLIP7iB8NKmQ5PndL8Y07TtiQ+Sb/wn
g4GgV+BJoKdDWLPCAlCMilwbZ88Ijb+HF/aipc9hsqvW/hnXC2GajJSAY3Qs9Mib
4Hm91jzbAjmp7243pQ4bJMfYHemFFBRaoLC7ayqQjcsttN2ufINlqLFPZPR/i3IX
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------liiRpZ2LGHl5C0gioM2bJdPR--

--------------DPiBTuW4WhK0KFF1cKCxJjmg--

--------------EFFtuyAw2mxdAKPsAqPioBPH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmmAfAgFAwAAAAAACgkQsN6d1ii/Ey/2
zAf+IkVIvbIONVNOIsFijpcb0ksuCVfDZvIq2cPAb9rfEt4SV/Fv87G1BkwNCtKbrpMKsTjK2E8V
YxPglU6me8lcaWM/t2j74OrYLM0B0yfhTzS6I5AbtpGIMsQxiITsr//ZP64nl5N5/YvNKpLhvAkG
rqdkNYFQh4GB5FgSl079/ebN9POZERI4nOBDWTiJ69297xhtHXPambNil4kLLpNyi+I0vETf6+05
0pPWs7hQsNqqHWfyCdehYqc+H8ZZkY2Jg0uanT5Qv1kWieoCWahhlRcpKyz9tMoIofilTuPuAkGu
XnCl3azsTfUBNhgwDBPjw50R1tSidPTjMLavCd43jA==
=T21t
-----END PGP SIGNATURE-----

--------------EFFtuyAw2mxdAKPsAqPioBPH--
