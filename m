Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41421380FD5
	for <virtualization@lists.linux-foundation.org>; Tue,  6 Oct 2026 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791264527; cv=fail; b=J7p7JzTMj9pP/KYHIL7m5AKbTBLzA1ws0dP2eUhJ0myHsvp14mdRN9f8/1oWlne0wTB37sfJdTWFeCHiYOoGLe3biJiF+qN1g2RLxS+cwhsnVvUYWGgHUoWDew5DfhNAwwxvFOPUPMhRFjBGYv5RFZ8jy0rtT0GDvG78J6+THG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791264527; c=relaxed/simple;
	bh=9HNEAgZBFHcYTLoKgcMQRxKJGpiWOAr0xe/pxActPcc=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=UkO2Xz4p+tgsAUJELBqsfP+6PfTRSam2qqh3YdciOGEN31CCfYhs50KxSRkyteUth+kgFTPGNceQQQHJe5VeBnZ+HMEcqwXbgFdltmlErU6utPFx9IA5GnHGQfd9p1VXFTSe00astasZ6FQ5Xd4SfEaDolLx/E9znpYCXCol8H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMFUhD4Y; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMFUhD4Y"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA396400D6
	for <virtualization@lists.linux-foundation.org>; Tue,  6 Oct 2026 05:28:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.348
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xYuJvBdF_YmO for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Oct 2026 05:28:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E94924009D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b132"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791264525;
	b=CiNNx8+Q1GtaWKsqqQ/CXYqULZc8PlDo3KOe83EXLx9qAJdkBBQUH3m05ZJ36kvuojCn
	 ZlS0c25RbasUp7q1xfD8rSAk393WCfiMLFyWUppIgccG2L7YufBQ6zahlAt9V/xpfOc+B
	 AIpDzqUl1ioFocnDrPM99FIejG4zUkhddalghIzjwNu+QrVe5nTUMTWnCIh85Tp7TCvek
	 xjYN6Dg+5Gdb3vFoSybe9dBJaA58Vdsa3p/xkZrECGW7E1PhPRNRv2WC7KlX3sNHV3R6w
	 fpKF6bCaj2WjHC+5TrfSnXPllHlnXglWZHaxGoGe7NgD6roUw70jwFlGOXq/5ZPaB0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791264525;
	h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:From:
	 Autocrypt:Cc:Subject:Content-Type;
	bh=+nCX8wsQF62S5gcqdhMgMojOzeuu0tFrTa4f41qQVqw=;
	b=P6MFIa05ZEKWUUDNXbYJeWHQJSrIuoyhWuRuaT33Cbm7PVl0nzrgafthgOFUE7kQC/hS
	 1GT/h9KlL72pPHad8qLTtzP6oLiLTgrdH2T/m/HLwIj5Rjnb3Kia4Deh7Ws/op/H8Yqth
	 Mfn+lkoNOmZblDVyWtb0wG5eB2R0UHxlt/PoMh+rebhQ44BUd1IuANA+sG+6be0wqEWvo
	 inpj7vKo07Af6tqL/pe9VKuv4r1FyLW1ZrRMdoe1nRQJFRGskY8CiPwSNPQ0G2bTNIBIP
	 MkWQt1iSja3af3CZNtXNaWPzgOIN4iH3krNSBngVJQuJqKeAFLW0EyReyOT7tJcUrZQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XMFUhD4Y;
	arc=none smtp.remote-ip="2607:f8b0:4864:20::b132"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=demiobenour@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XMFUhD4Y
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com [IPv6:2607:f8b0:4864:20::b132])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E94924009D
	for <virtualization@lists.linux-foundation.org>; Tue,  6 Oct 2026 05:28:44 +0000 (UTC)
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-677c1fc082bso1976992d50.3
        for <virtualization@lists.linux-foundation.org>; Mon, 05 Oct 2026 22:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791264523; x=1791869323; darn=lists.linux-foundation.org;
        h=content-type:subject:cc:autocrypt:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+nCX8wsQF62S5gcqdhMgMojOzeuu0tFrTa4f41qQVqw=;
        b=XMFUhD4Y/FM/3JOYJMCM/UQnb7zz8rkLidtNjcwtepcdVdlziDT0oisstYwJfNSP07
         jrmPKo4jV2pal1/61So0M0JnTJTxgXEc87F4SvrvW73ocnMBKz8heuAYnLWSRbvKLAjQ
         DaX0EGyQcsIQP6FjCdlip1zK3NVJsAIUtnZeP5319A16X2Q61/OXMHXVKHhDFcVAByIq
         wy+RgNC7x0V6V/QhsIHCpo+aNaA3Z5Ui1ewL/eI9A/8vpkq0o/ViIEF864Qw1LKVp44C
         GOQnjAGm3svjY3mz9Ze90OafeXjyce684VJ6nZcBG0sTmsH21ztqxMfE40ajkfF/JZqW
         uVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791264523; x=1791869323;
        h=content-type:subject:cc:autocrypt:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+nCX8wsQF62S5gcqdhMgMojOzeuu0tFrTa4f41qQVqw=;
        b=MJlw//26hN4qbgUqsw5YBr1rTy/fsxI8UhYNh+fhk2ZMaO98L2FB4qexFJGz7U+58M
         BZV6hq8Spo7e/0ZaqBPWMXoVu+nEKuRChWXJMu7QrV4e+EcI0HhdptvpNNQbVN/xFn+L
         CzO3MajFSdFeZUE7mNBZLHMvRQXSu09uK/OlMwjU5HC8rvltr4K4vF3KGI2d6AvDLqj0
         E4b4VM/IaZSj1eo69ZHovfyP95SaFCxNOPqQ0ikgSbu7lSR06y3d6gMJ77UYtz0OVXnR
         OGMVS8Z2YFBqpksC50gzEuwEnhyYqTJ1InEyug0D5GRMqBekJZOpnRHBKIC+v9xO8hpd
         4rbA==
X-Forwarded-Encrypted: i=1; AKwUvByYpW6RtjUuDPfaB504CxjfkP5P4iIy/uuQ5MUIsKhSAtiaGnJEpCAMb2QAUtho3tBwj3ncSm5aKrO44rLZRQ==@lists.linux-foundation.org
X-Gm-Message-State: AFq9FYJ4IcfocJXLN4Wdhkl1cjCWpaM8OwZ8SwWklZXzoOXjF1uLF7Er
	felewzOMPIKgfjllZPIIzQWBqElH1XHKT2mcbrDRvjpmQ0ZOkQAL0533
X-Gm-Gg: AYBFou30RaLzJI4rPY3pCHZ9gNhEyMT0BpKQPtZInnDRFhj96W7MwARoGtX1Q5se1W1
	IkcFDd9QZR5JqKrn1YvahSyVsFcEJZqVHrQUW1yXfGop/ahG5oCYinIfrjGdx7yjq8MSIr+8t8/
	gcGdsPWWy2HnKNf0fhzIRaL3lhHjlld8GroO+/S3rl5ghUYQeaXLGKnzG8X+YO1kVyg2iAmCAdS
	1ICD+Iqm9Abq93gcxbxhXe8KwHI4ICxRsedjQg1vr8MHm+al5UaA66AQaxxA7QHeAaDyZ1XPMQt
	PtZm8eWMgB7VKyTamuKxdaH2vawt7zfY+/EqOSrMkejJlCfKzL6YJ71MLEcO68FXiqbDeQ7AjkK
	mSCG7O+TJ/bv2z2QsRbSBn2arazMV1192eV+BvADB6jqwXWRxq7hLwbJAsNqnRc0vv0XcpF6wC+
	lNauFFXs+ICSdf8bFufhwFFOIxjYW16LTYGfkRsNqBn8N0QLvxyi4P2kE5ZmW14D3Cg1HE6EUFp
	g==
X-Received: by 2002:a05:690e:1242:b0:678:fa71:2ff1 with SMTP id 956f58d0204a3-678fa713bb5mr304997d50.14.1791264523102;
        Mon, 05 Oct 2026 22:28:43 -0700 (PDT)
Received: from [10.138.10.6] ([185.98.168.8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae3011f3f7sm48018747b3.3.2026.10.05.22.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 22:28:42 -0700 (PDT)
Message-ID: <b16fede3-97a5-45cb-80b1-6e080af84235@gmail.com>
Date: Tue, 6 Oct 2026 01:28:38 -0400
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kernel KVM virtualization development <kvm@vger.kernel.org>,
 Linux virtualization list <virtualization@lists.linux-foundation.org>,
 Linux IOMMU Development <iommu@lists.linux-foundation.org>
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
Cc: Alyssa Ross <hi@alyssa.is>
Subject: Recovering from IOMMU and/or KVM MMU faults
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0LUY9lfAwgYbsudM0Elh00H0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0LUY9lfAwgYbsudM0Elh00H0
Content-Type: multipart/mixed; boundary="------------F0HqGzIso2ZZMnzZ7vvq5Rop";
 protected-headers="v1"; hp="clear"
Message-ID: <b16fede3-97a5-45cb-80b1-6e080af84235@gmail.com>
Date: Tue, 6 Oct 2026 01:28:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kernel KVM virtualization development <kvm@vger.kernel.org>,
 Linux virtualization list <virtualization@lists.linux-foundation.org>,
 Linux IOMMU Development <iommu@lists.linux-foundation.org>
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
Cc: Alyssa Ross <hi@alyssa.is>
Subject: Recovering from IOMMU and/or KVM MMU faults

--------------F0HqGzIso2ZZMnzZ7vvq5Rop
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'm designing a new type of virtio device (vhost-guest, was virtio vhost-=
user), and I'm running into an interesting design question.

Specifically, the frontend (a vhost-user client) can ask the device (a vh=
ost-user server) to ummap memory.  This is handled by replacing the mappi=
ng with a PROT_NONE one.  However, the guest might be accessing that memo=
ry.  Furthermore, that memory might also be mapped into the IOVA of a VFI=
O device for zero-copy I/O.

If the guest is accessing the memory, KVM will get a fault.  If the PCI d=
evice is accessing it, there will be an IOMMU fault.  Is it possible to r=
ecover from this?

If not, then the only option is to wait for the guest to release the memo=
ry itself.  If it does not do so, that's a memory leak (host denial of se=
rvice).
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)

--------------F0HqGzIso2ZZMnzZ7vvq5Rop--

--------------0LUY9lfAwgYbsudM0Elh00H0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmrEhwcACgkQszaHOrMp
8lOmuA/9E4DWi9cLz8/J86RGWiqaoWZLSBgrEwCkeTlCp+JLhR0lxMn6F1gk0Vme
+EJ86q8PkdJntreE5wauaGQofRtNWBH5duYcACmzmVTVJ/xcY/2RwKrpqSTOQBNz
Sy432cCFP37xKMO1cNgfDk4SZoZMAMvnRcHKCWr+HRvSn4JZ06ddhI9uQVdxPrjr
3Z0LKOA6rkiQgnztgOtZ4E9SiA7xCEKpmJZCpVmrgtQmccRLRjoN3sfY/XxwaN8c
SZ6ks4shJqYNF/dAstru5VXAkPDFxZW9I18qxYp1uQIMuvFd3lOsyMweltulUfY7
2hY//INXhRIJ9hyAyXAbSR2qmrUUrbpRiqwbljZ+hVzD4g4dDySwimzHb2Eyx0Jr
Tx8t9/PDB4VzJu3/yaBErBsQnWCxTl9grB7Hvp6X/gkOMxZkA1pcXSvSXdS2vZvk
f9QluxhINzjyRiRLvp3mbrrCzaeAFF21PgCN1r7dQuM1ImcEF26QoE7FpT6fql5g
sNBiVKbqDeybVdDBtErbK/nFlATXMeCO5ncM1Fz7UgIdMP5Rs3kVpHNUAyYCCUCj
H8pgxRapQ9GkGwSrz7la1E7EOTxoQrMMFfKJm3V/+nLX3xRzoyD3ox0dxz6ngUgE
j/VUGhr3pv6RblxXD+A0ejvQ7+8MhVtV81GELeMEOygg1vH3igc=
=3SGs
-----END PGP SIGNATURE-----

--------------0LUY9lfAwgYbsudM0Elh00H0--
