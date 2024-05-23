Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAA13F42B
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458649; cv=none; b=B2gKYrImNF6KLHzSbSmTXYVgLQgiSRCDp5wmS6fg6GKj6ab6xdWVJFrvDE3WwyH47R1qGu33QvVDA2xyLe4s9DY87EGFJme/OoZRqDLUB/cWmY3Z33VjpVXACjqF4kAYgahD/q+K7ymN6omucEgeLY/myfOctilS4rlr1+wVlgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458649; c=relaxed/simple;
	bh=dQeI9DsT/b0l9Ykxmc9u+GSBpP88GDVxPhFt8oXBiGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=th7+FcIf6kEG4/ZW2dBs/x1UXuCilYYSSKEy1+O3Uh0RMFtHHoRzzpTSvsmPuZF0eVz5LeLea88TuQeZVcwNuDS7Ck1DjQVXkHdqxdFatMPtz2jjBiiKMySi9v9PzCX8d9R+sNqzbbDr7LLFkY2Hvg0/OVULlHTESAR409lcCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jXfzo2Bg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IuieDSAj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jXfzo2Bg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IuieDSAj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD52C200B4;
	Thu, 23 May 2024 10:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716458646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dQeI9DsT/b0l9Ykxmc9u+GSBpP88GDVxPhFt8oXBiGQ=;
	b=jXfzo2Bgho8D+CeRUwfOhRpR7KJ+DOeEbWpeIP9Aj61bEHG6LABvdWvdVSJTH1pTrS2c9x
	yADqe9MNcPe+mdFv7CLDcbGNUeBcgIm7v+/+f4j1FrM49EaJTvV5dVHVv1QnShmEtNdI3z
	Xw3HB5ckk+Bc5Gg0d3KrSIKI3THugJA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IuieDSAj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716458645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dQeI9DsT/b0l9Ykxmc9u+GSBpP88GDVxPhFt8oXBiGQ=;
	b=IuieDSAjGo3uu2lnlbsQsPjWwVoQiNR89aAkgryN+jM3iiVhPRd3q8k8kaLnp3o2m0v8Ub
	S1spk6WhRAd1ccPx+ZMptqbd51jB6FZeCzFlOjBKImdoBitcCH8BFvGofpCVnYzMQTnG7L
	Xtbq09iDpghsPchfkImG9ajCeTjEOOo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 604E313A6C;
	Thu, 23 May 2024 10:04:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JYbRFZUUT2YYFAAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 23 May 2024 10:04:05 +0000
Message-ID: <9d68a5e1-7880-4425-9a18-09c8e8b5ba26@suse.com>
Date: Thu, 23 May 2024 12:04:04 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/paravirt: Disable virt spinlock when
 CONFIG_PARAVIRT_SPINLOCKS disabled
To: Chen Yu <yu.c.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240516130244.893573-1-yu.c.chen@intel.com>
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
In-Reply-To: <20240516130244.893573-1-yu.c.chen@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NtDXiEQ6ollmBXprfwdzC7DU"
X-Spam-Level: 
X-Spamd-Result: default: False [-5.36 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.96)[86.73%];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CD52C200B4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.36

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------NtDXiEQ6ollmBXprfwdzC7DU
Content-Type: multipart/mixed; boundary="------------kJra0Ta0qBdARQabIDn11pcJ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Chen Yu <yu.c.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
Message-ID: <9d68a5e1-7880-4425-9a18-09c8e8b5ba26@suse.com>
Subject: Re: [PATCH] x86/paravirt: Disable virt spinlock when
 CONFIG_PARAVIRT_SPINLOCKS disabled
References: <20240516130244.893573-1-yu.c.chen@intel.com>
In-Reply-To: <20240516130244.893573-1-yu.c.chen@intel.com>

--------------kJra0Ta0qBdARQabIDn11pcJ
Content-Type: multipart/mixed; boundary="------------CWlaGWCoa9h3pz2K4YSOzAk0"

--------------CWlaGWCoa9h3pz2K4YSOzAk0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDUuMjQgMTU6MDIsIENoZW4gWXUgd3JvdGU6DQo+IFBlcmZvcm1hbmNlIGRyb3Ag
aXMgcmVwb3J0ZWQgd2hlbiBydW5uaW5nIGVuY29kZS9kZWNvZGUgd29ya2xvYWQgYW5kDQo+
IEJlbmNoU0VFIGNhY2hlIHN1Yi13b3JrbG9hZC4NCj4gQmlzZWN0IHBvaW50cyB0byBjb21t
aXQgY2UwYTFiNjA4YmZjICgieDg2L3BhcmF2aXJ0OiBTaWxlbmNlIHVudXNlZA0KPiBuYXRp
dmVfcHZfbG9ja19pbml0KCkgZnVuY3Rpb24gd2FybmluZyIpLiBXaGVuIENPTkZJR19QQVJB
VklSVF9TUElOTE9DS1MNCj4gaXMgZGlzYWJsZWQgdGhlIHZpcnRfc3Bpbl9sb2NrX2tleSBp
cyBzZXQgdG8gdHJ1ZSBvbiBiYXJlLW1ldGFsLg0KPiBUaGUgcXNwaW5sb2NrIGRlZ2VuZXJh
dGVzIHRvIHRlc3QtYW5kLXNldCBzcGlubG9jaywgd2hpY2ggZGVjcmVhc2UgdGhlDQo+IHBl
cmZvcm1hbmNlIG9uIGJhcmUtbWV0YWwuDQo+IA0KPiBGaXggdGhpcyBieSBkaXNhYmxpbmcg
dmlydF9zcGluX2xvY2tfa2V5IGlmIENPTkZJR19QQVJBVklSVF9TUElOTE9DS1MNCj4gaXMg
bm90IHNldCwgb3IgaXQgaXMgb24gYmFyZS1tZXRhbC4NCj4gDQo+IEZpeGVzOiBjZTBhMWI2
MDhiZmMgKCJ4ODYvcGFyYXZpcnQ6IFNpbGVuY2UgdW51c2VkIG5hdGl2ZV9wdl9sb2NrX2lu
aXQoKSBmdW5jdGlvbiB3YXJuaW5nIikNCj4gU3VnZ2VzdGVkLWJ5OiBRaXV4dSBaaHVvIDxx
aXV4dS56aHVvQGludGVsLmNvbT4NCj4gUmVwb3J0ZWQtYnk6IFByZW0gTmF0aCBEZXkgPHBy
ZW0ubmF0aC5kZXlAaW50ZWwuY29tPg0KPiBSZXBvcnRlZC1ieTogWGlhb3BpbmcgWmhvdSA8
eGlhb3BpbmcuemhvdUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENoZW4gWXUgPHl1
LmMuY2hlbkBpbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0KDQo+IC0tLQ0KPiAgIGFyY2gveDg2L2tlcm5l
bC9wYXJhdmlydC5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9w
YXJhdmlydC5jIGIvYXJjaC94ODYva2VybmVsL3BhcmF2aXJ0LmMNCj4gaW5kZXggNTM1OGQ0
Mzg4NmFkLi5lZTUxYzA5NDllZDggMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9w
YXJhdmlydC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9wYXJhdmlydC5jDQo+IEBAIC01
NSw3ICs1NSw3IEBAIERFRklORV9TVEFUSUNfS0VZX1RSVUUodmlydF9zcGluX2xvY2tfa2V5
KTsNCj4gICANCj4gICB2b2lkIF9faW5pdCBuYXRpdmVfcHZfbG9ja19pbml0KHZvaWQpDQo+
ICAgew0KPiAtCWlmIChJU19FTkFCTEVEKENPTkZJR19QQVJBVklSVF9TUElOTE9DS1MpICYm
DQo+ICsJaWYgKCFJU19FTkFCTEVEKENPTkZJR19QQVJBVklSVF9TUElOTE9DS1MpIHx8DQo+
ICAgCSAgICAhYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IpKQ0KPiAgIAkJ
c3RhdGljX2JyYW5jaF9kaXNhYmxlKCZ2aXJ0X3NwaW5fbG9ja19rZXkpOw0KPiAgIH0NCg0K

--------------CWlaGWCoa9h3pz2K4YSOzAk0
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------CWlaGWCoa9h3pz2K4YSOzAk0--

--------------kJra0Ta0qBdARQabIDn11pcJ--

--------------NtDXiEQ6ollmBXprfwdzC7DU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmZPFJQFAwAAAAAACgkQsN6d1ii/Ey+P
KggAnmtylD8fesXD7PqixEFEpFIlBPLcwz6raAVqa7l4wWjWkPDuy+EMBVYwuBNQeUcm808VnppT
2u4g4kglK9aKHONCx7Ss8CKxb1HWe0Xocfp6DdjcNSgrMjMs1bnIraGb6HnIGVx9fuDoe4VyKj6C
zCgJaDc4j36lhLaDHhBDd59yRJwo7n0AYxT6KLylsLe2TtLmkB8eKrNmqN7oVxX1jhQUIarxmO74
zH9BtkkThouMxA+ma5+lb42VWb3ynqn0vdqTlSV/pRuRwa9GH35tNhdmCPlu2DxdOvqhKLoUH7nv
viRCwIv2Ny97kWbPqyOLJbH0iciyo/ieCrjZIkpuTw==
=5s+3
-----END PGP SIGNATURE-----

--------------NtDXiEQ6ollmBXprfwdzC7DU--
