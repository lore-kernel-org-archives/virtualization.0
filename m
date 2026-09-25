Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECD4908C5
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331940; cv=none; b=JjVk7S+F5tOD6y/jLelvQblvE/8sATuubWNojogKyUwZSiamBpiVlhCO1K67WlaSjbg+Ihr1/pWrs34VKJ/cQenUKz4nfJVNhG0DgQ5xxhfZw9Xa8No7hU2/djViy4phd6J5YiIrZ4P8/QUR9MzadHNytV3ZH+FsYHqqcLqBhnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331940; c=relaxed/simple;
	bh=ZWNYdM3K5LHNSvq4KmxGNNLfg/K9DprEEpObZs9aw3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frgtmWWz2JeaHSJvMkuhXr2VPqlxuOQzJn+IrdThBnBhvyNDe99HpEQ8cZ9G+s5HD8+CxmHxqRa8bL7+s5hbPZ0WKOGTPuYhDVcdJCy+AaCj3bcC2wUaYhTvT3SYx0uz6D3IJhTThqwaXArePcdi0FoVP55P7Fa9xuk7k85LreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Psb2XvWl; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Psb2XvWl"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99391ffb2so1270319a12.0
        for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790331937; x=1790936737; darn=lists.linux.dev;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZWNYdM3K5LHNSvq4KmxGNNLfg/K9DprEEpObZs9aw3I=;
        b=Psb2XvWlEKHbUSqmmF9d9zQHqFHq4RXsPRGS7SumWzAmAKlRVcSd0AzHuV8VPbC6LP
         dNitsiQn9PIsYXK3TibfrxvxaZ9r5EmhZAyjLDweIPr6BgMqawKM0ExW+35ICJ/wDDmM
         QmG0q9JXjvs/Y5GozWkjk8U/IegiK1yvTYcOz4/9lXmhKtFAg6umKPYnlZcvcJ9oWyBe
         FPT1ScsxM2PTqttb+P86JxdNKO/BoSK/5ncVi3VW8+Q4sQu9TkdhOgEC219AGhbu2hy6
         9rOpAJ4VxyMHYXzQNbNGaYUtSX80ZBoxX+LZ5AbzsQXxGrsLDFGOB74zETuV+OE+KbM9
         96vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790331937; x=1790936737;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZWNYdM3K5LHNSvq4KmxGNNLfg/K9DprEEpObZs9aw3I=;
        b=UTiQ1yt7HAuOH2soOdPYlFC3mlqxe/idoLDOTOPqh1vio2LXvTfph3HSUY5eGmiy3d
         +/EMoVcwOsFQGMWWRXOvl6TA/4qSdy0O9UbSYzjvEbOaRYq9Ys9gVniOueybMa2dZsfT
         hcbdEwLuk7tdmfRp0m6GbyD8RtqDryedvvElm/6J21kn4gkmcttOrcDwT5dQnYpMTFDP
         1fz2wb/IRGPvmImRQBq1uToEG6iBcWHsSQnyC0qzmyQ5VcbmI8IKmtc0keP3jJfWB+Dt
         Jo9ypuCDkZj0OhGOMNQ+/GD1y8T1SL6HUxvSd5nkQemZHULfVoS4+y2Z+b6mKQKsj/OW
         k2VA==
X-Forwarded-Encrypted: i=1; AKwUvBxArWaLt/wFOmji39lbvicSBfVOf20n52UEr6C1LYNaxk7D+g4GPn1BUgpnqYkx7qPV4dnHdOaS1v4SCrSQrA==@lists.linux.dev
X-Gm-Message-State: AFuF++kBoNWG9YAo41eS8BdYhytcB+WEDiVta9+6FlDZx8WhmotktpFv
	fx5yDobgb5vdnV3SFBJNBitM3wdGQay59ew315eWYjfsfWl0vosv+HzdZy16P05iYNQ=
X-Gm-Gg: AYBFou2YUiJw1w812W3uyD2qREDa8glFeUSQ5x7uTO8w0/OOOpBRYquoS6vxqigasoI
	xlL087dnRlo51LdMP9Oig6HaVWk2iGgyf+tpNPNPrsjUpOMg6kY+Qh89v9wAKjYvMauWtJjglBn
	h2+ONfpaNNZYFGEfEgnIFvOpXU3iVVh0dUrkyxhWUDfmwmz61J7CqtKtuktwiQe0xrwsDd0jRL7
	tTTUL4nhcj24asDLOv7fiFzuhHH1O9rmVfvl1I0E5/SNpZjAKHzWBo4Sa3E/Iw6hbIM2Q1qGVfw
	OfeT/4hJJ+Q/EXY+x1DhiniXlheAjL9ij9cfxa8PuFUrHJps5lEbDASCsmt3E15ZOZVXDhRXEo9
	FCg5mp7l/eWJl1mLigXqpYDKRjXa+Pn5jy3pn/yM7VEb/oH8GQDVGEZRGYDBx6ooC05Vpd4tqoW
	FjPIYq7e8mf5Gol34MYrXxDukY6ORuYsvUqNqgcQDCl4HGvKcPpBcOWoZ25mupC38ZNGjviK5aC
	AmVvrgHhFHmhkfwFFXocyC6eO0ngX7XGVYWEmCmDgO0OqpmySvfMVOTFmpL+PRfOWgnsaDMaRM0
	Zmh27+xQSm9gkmqGScVFDhM5SF7HBYeCrsM=
X-Received: by 2002:a05:6402:3251:b0:6aa:a3bd:c6a1 with SMTP id 4fb4d7f45d1cf-6aae8f66ad6mr1177208a12.40.1790331936607;
        Fri, 25 Sep 2026 03:25:36 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dd78e1sm830540a12.18.2026.09.25.03.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 03:25:35 -0700 (PDT)
Message-ID: <a5c73733-af28-4c74-b7e1-c64b5e3232c4@suse.com>
Date: Fri, 25 Sep 2026 12:25:34 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/17] x86/msr: Inline rdmsr/wrmsr instructions
To: Shreshth Srivastava <shreshth.srivastava@intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, llvm@lists.linux.dev
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, xin@zytor.com,
 nathan@kernel.org, ndesaulniers@google.com, jpoimboe@kernel.org,
 peterz@infradead.org, boris.ostrovsky@oracle.com,
 xen-devel@lists.xenproject.org
References: <20260911084211.3149957-1-jgross@suse.com>
 <20260923193619.1408940-1-shreshth.srivastava@intel.com>
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
In-Reply-To: <20260923193619.1408940-1-shreshth.srivastava@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FcahRLIPpkidr0MhRok6l1Ai"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FcahRLIPpkidr0MhRok6l1Ai
Content-Type: multipart/mixed; boundary="------------1vAieXh0bKe5ArCEjlp9QPsZ";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Shreshth Srivastava <shreshth.srivastava@intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, llvm@lists.linux.dev
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, xin@zytor.com,
 nathan@kernel.org, ndesaulniers@google.com, jpoimboe@kernel.org,
 peterz@infradead.org, boris.ostrovsky@oracle.com,
 xen-devel@lists.xenproject.org
Message-ID: <a5c73733-af28-4c74-b7e1-c64b5e3232c4@suse.com>
Subject: Re: [PATCH v5 00/17] x86/msr: Inline rdmsr/wrmsr instructions
References: <20260911084211.3149957-1-jgross@suse.com>
 <20260923193619.1408940-1-shreshth.srivastava@intel.com>
In-Reply-To: <20260923193619.1408940-1-shreshth.srivastava@intel.com>

--------------1vAieXh0bKe5ArCEjlp9QPsZ
Content-Type: multipart/mixed; boundary="------------Mkl0Q8jWZxLmkvShEj9On0ww"

--------------Mkl0Q8jWZxLmkvShEj9On0ww
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjMuMDkuMjYgMjE6MzYsIFNocmVzaHRoIFNyaXZhc3RhdmEgd3JvdGU6DQo+IE9uIDEx
LjA5LjI2IDEwOjQxLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gV2hlbiBidWlsZGluZyBh
IGtlcm5lbCB3aXRoIENPTkZJR19QQVJBVklSVF9YWEwgdGhlIHBhcmF2aXJ0DQo+PiBpbmZy
YXN0cnVjdHVyZSB3aWxsIGFsd2F5cyB1c2UgZnVuY3Rpb25zIGZvciByZWFkaW5nIG9yIHdy
aXRpbmcgTVNScywNCj4+IGV2ZW4gd2hlbiBydW5uaW5nIG9uIGJhcmUgbWV0YWwuDQo+IA0K
PiBIaSBKdWVyZ2VuLA0KPiANCj4gVGhpcyBkb2Vzbid0IGJ1aWxkIHdpdGggQ09ORklHX1BB
UkFWSVJUX1hYTD15LiAxNi8xNyBhbmQgMTcvMTcgYXJlIHdoZXJlDQo+IGl0IGJyZWFrcywg
YnV0IHRoZSBjYXVzZSBpcyB0aGUgLmJ5dGUgZmFsbGJhY2tzOiBBU01fV1JNU1JOU19JTU0g
ZnJvbQ0KPiAwOC8xNyBhbmQgQVNNX1JETVNSX0lNTSBmcm9tIDEwLzE3IGRvbid0IGVuZCBp
biBhIHNlcGFyYXRvciwgdW5saWtlIHRoZQ0KPiAuaW5zbiB2YXJpYW50cyBhYm92ZSB0aGVt
Lg0KPiANCj4gICAgI2RlZmluZSBBU01fUkRNU1JfSU1NCQkJCVwNCj4gCSIgLmJ5dGUgMHhj
NCwweGU3LDB4N2IsMHhmNiwweGMwOyAubG9uZyAlY1ttc3JdIg0KPiANCj4gVGhhdCB3b3Jr
ZWQgd2hpbGUgdGhleSB3ZXJlIG9ubHkgZXZlciB0aGUgbGFzdCBhcmd1bWVudCBvZiBhbg0K
PiBBTFRFUk5BVElWRSgpLCB3aGljaCBhcHBlbmRzIGl0cyBvd24gbmV3bGluZS4gMTYvMTcg
Y29uY2F0ZW5hdGVzIHRoZW0NCj4gd2l0aCBBU01fQ0xSRVJSOg0KPiANCj4gCUFTTV9SRE1T
Ul9JTU0gQVNNX0NMUkVSUiwgWDg2X0ZFQVRVUkVfTVNSX0lNTSwJXA0KPiANCj4gc28gdGhl
IC5sb25nIG9wZXJhbmQgcnVucyBpbnRvIHRoZSB4b3IuIEZyb20NCj4gbWFrZSBhcmNoL3g4
Ni9rZXJuZWwvY3B1L2NvbW1vbi5zOg0KPiANCj4gCS5ieXRlIDB4YzQsMHhlNywweDdiLDB4
ZjYsMHhjMDsgLmxvbmcgMjY2eG9yICVyZHgsJXJkeA0KPiANCj4gICAgcGFyYXZpcnQtbXNy
Lmg6MTY1OiBFcnJvcjoganVuayBhdCBlbmQgb2YgbGluZSwgZmlyc3QgdW5yZWNvZ25pemVk
IGNoYXJhY3RlciBpcyBgeCcNCj4gDQo+IGNsYW5nIHJlcG9ydHMgImVycm9yOiB1bmV4cGVj
dGVkIHRva2VuIiBpbiB0aGUgc2FtZSBwbGFjZS4gNzEgb2JqZWN0cw0KPiBmYWlsLCB0aGUg
c2FtZSA3MSBlaXRoZXIgd2F5LCBubyB2bWxpbnV4Lg0KPiANCj4gbXNyLmggY2hvb3NlcyBi
ZXR3ZWVuIHRoZSAuaW5zbiBmb3JtIGFuZCB0aGUgLmJ5dGUgZmFsbGJhY2sgd2l0aDoNCj4g
DQo+IAkjaWYgZGVmaW5lZChDT05GSUdfQVNfSVNfR05VKSAmJiBDT05GSUdfQVNfVkVSU0lP
TiA+PSAyNDEwMA0KPiANCj4gVHdvIGtpbmRzIG9mIHRvb2xjaGFpbiBlbmQgdXAgb24gdGhl
IC5ieXRlIHNpZGUgb2YgdGhhdCB0ZXN0Og0KPiANCj4gICAgLSBHTlUgYXMgb2xkZXIgdGhh
biAyLjQxLiBSSEVMIDkgYW5kIENlbnRPUyBTdHJlYW0gOSBzaGlwIDIuMzUsIGFuZA0KPiAg
ICAgIERvY3VtZW50YXRpb24vcHJvY2Vzcy9jaGFuZ2VzLnJzdCBzZXRzIHRoZSBtaW5pbXVt
IGF0IDIuMzAsIHNvIHRoaXMNCj4gICAgICBpcyBhIHN1cHBvcnRlZCBjb25maWd1cmF0aW9u
IHJhdGhlciB0aGFuIGFuIG9sZCBvdXRsaWVyLg0KPiAgICAtIGNsYW5nLCBhbnkgdmVyc2lv
bi4gQ09ORklHX0FTX0lTX0dOVSBpcyBuZXZlciBzZXQgZm9yIGNsYW5nLCBzbyB0aGUNCj4g
ICAgICAmJiBzaG9ydC1jaXJjdWl0cyBhbmQgdGhlIHZlcnNpb24gY29tcGFyaXNvbiBpcyBu
ZXZlciByZWFjaGVkLiBZb3VyDQo+ICAgICAgMDgvMTcgY29tbWVudCBhbHJlYWR5IG5vdGVz
IHRoYXQgY2xhbmcgaGFzIG5vIC5pbnNuIHN1cHBvcnQuDQo+IA0KPiBnY2Mgd2l0aCBiaW51
dGlscyAyLjQxIG9yIG5ld2VyIHRha2VzIHRoZSAuaW5zbiBwYXRoLCB3aGVyZSBib3RoIG1h
Y3Jvcw0KPiBkbyBlbmQgaW4gYSBzZXBhcmF0b3IsIGFuZCBpcyB1bmFmZmVjdGVkLg0KPiAN
Cj4gUmVwcm9kdWNlZCBvbiB2Ny4zLXJjMiB3aXRoIHlvdXIgdjMgMDAvMTMsIHYyIDAvNSBh
bmQgdjUgMDAvMTcgYXBwbGllZCBpbg0KPiB0aGF0IG9yZGVyLCB4ODZfNjQgZGVmY29uZmln
IHBsdXMgSFlQRVJWSVNPUl9HVUVTVCwgUEFSQVZJUlQsIFhFTiBhbmQNCj4gWEVOX1BWLiBn
Y2MgMTEuNS4wIHdpdGggR05VIGFzIDIuMzUuMiwgYW5kIGNsYW5nIDIxLjEuNy4NCj4gDQo+
IFRlcm1pbmF0aW5nIGJvdGggZmFsbGJhY2tzIGZpeGVzIGl0LCBhbmQgYm90aCB0b29sY2hh
aW5zIHRoZW4gYnVpbGQNCj4gdm1saW51eCB3aXRoIG5vIGVycm9ycyBvciB3YXJuaW5nczoN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3IuaCBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL21zci5oDQo+IGluZGV4IGViYTMyNWVjZmU0Yy4uNTI5YzEzNTUz
YzYzIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3IuaA0KPiArKysg
Yi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3IuaA0KPiBAQCAtNzgsOSArNzgsOSBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgZG9fdHJhY2VfcmRwbWModTMyIG1zciwgdTY0IHZhbCwgaW50IGZh
aWxlZCkge30NCj4gICAgKiBmb3JtIE1TUiBhY2Nlc3MgaW5zdHJ1Y3Rpb25zIHJlZmVyZW5j
ZSAlcmF4IGFzIHRoZSByZWdpc3RlciBvcGVyYW5kLg0KPiAgICAqLw0KPiAgICNkZWZpbmUg
QVNNX1JETVNSX0lNTQkJCQlcDQo+IC0JIiAuYnl0ZSAweGM0LDB4ZTcsMHg3YiwweGY2LDB4
YzA7IC5sb25nICVjW21zcl0iDQo+ICsJIiAuYnl0ZSAweGM0LDB4ZTcsMHg3YiwweGY2LDB4
YzA7IC5sb25nICVjW21zcl1cblx0Ig0KPiAgICNkZWZpbmUgQVNNX1dSTVNSTlNfSU1NCQkJ
CVwNCj4gLQkiIC5ieXRlIDB4YzQsMHhlNywweDdhLDB4ZjYsMHhjMDsgLmxvbmcgJWNbbXNy
XSINCj4gKwkiIC5ieXRlIDB4YzQsMHhlNywweDdhLDB4ZjYsMHhjMDsgLmxvbmcgJWNbbXNy
XVxuXHQiDQo+ICAgI2VuZGlmDQo+IA0KPiAgICNkZWZpbmUgUkRNU1JfQU5EX1NBVkVfUkVT
VUxUCQkJXA0KPiANCj4gQVNNX1dSTVNSTlMgbmVlZHMgbm8gY2hhbmdlLCBfQVNNX0JZVEVT
KCkgYWxyZWFkeSBlbWl0cyBhIHNlbWljb2xvbi4NCj4gDQo+IFRoZSBXUk1TUk5TIGxpbmUg
YmVsb25ncyBpbiAwOC8xNyBhbmQgdGhlIFJETVNSIGxpbmUgaW4gMTAvMTcuDQoNClRoYW5r
cywgd2lsbCBiZSBmaXhlZCBpbiBWNi4NCg0KDQpKdWVyZ2VuDQo=
--------------Mkl0Q8jWZxLmkvShEj9On0ww
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------Mkl0Q8jWZxLmkvShEj9On0ww--

--------------1vAieXh0bKe5ArCEjlp9QPsZ--

--------------FcahRLIPpkidr0MhRok6l1Ai
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmq2TB4FAwAAAAAACgkQsN6d1ii/Ey91
vAf/VB+YAt/VPKDUyX+XUcDHENA9JuLl63VStLAndnBlPvr4goo4TbR55SP/Qw5MebGF5z9/QwTQ
K/pEituZVgrW3mJueIxCaZ7XKdV1u9wnRnZsnvp08rdk8272iHSVOL+jtRpKzCJPlpSUt86d+nnm
bEvk3ZvR0mz3ZmI9oJ/xFqQMOcZilP72lbGJ31q2ZPsiaG+AUa3lGF9uTIsxPurfiXZ3Xp7EJJFu
zG84GsYboJta2BfMbomQc1hEgXd7sTDienp3bd66xNxIrGwyDuw5/WicTPgEZSqnl6f7eQSRu54G
AKbTona4G4ZvUXLUd3ZffjeBXaAZ1fwMJxrGKDVODw==
=TEAR
-----END PGP SIGNATURE-----

--------------FcahRLIPpkidr0MhRok6l1Ai--
