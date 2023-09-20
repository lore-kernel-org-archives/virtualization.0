Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0C0C04AAB
	for <virtualization@archiver.kernel.org>; Wed, 20 Sep 2023 15:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D64E483BB2;
	Wed, 20 Sep 2023 15:49:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D64E483BB2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=KgkmN0yW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rF1P-wbElo3y; Wed, 20 Sep 2023 15:49:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6D42783BB4;
	Wed, 20 Sep 2023 15:49:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D42783BB4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45BFDC0071;
	Wed, 20 Sep 2023 15:49:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64F60C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 15:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2781341FCE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 15:49:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2781341FCE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=KgkmN0yW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dolTAQb481Cd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 15:49:07 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC5F041EA3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 15:49:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC5F041EA3
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1427422070;
 Wed, 20 Sep 2023 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1695224944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xwmscEbu4Mg9p7LlGQ7SIxmKqR0eZYHrdLtjy0NQDoU=;
 b=KgkmN0yW2XqcmcnoHqHc38wgpkX66hulJvJ2J3aYResMUg52Tp6pRy+IXADoOfLC41/u01
 6sbS8ByWXyDL180SvS8q7J6smdvR/HO2xaC+JEWz1vSd7e+Fm9/rMO0xl1XKEBzfQs4Au8
 IrCuoD0WWVjSswN1QD2EGoshx33MMdM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA9841333E;
 Wed, 20 Sep 2023 15:49:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NjnqJ28UC2U1UQAAMHmgww
 (envelope-from <jgross@suse.com>); Wed, 20 Sep 2023 15:49:03 +0000
Message-ID: <e2d1157e-47cc-467d-a319-12bb07ef960c@suse.com>
Date: Wed, 20 Sep 2023 17:49:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
References: <20230608140333.4083-1-jgross@suse.com>
 <20230608140333.4083-4-jgross@suse.com>
 <20230920145222.GB6687@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20230920145222.GB6687@noisy.programming.kicks-ass.net>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Juergen Gross via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Juergen Gross <jgross@suse.com>
Content-Type: multipart/mixed; boundary="===============1578205197536359766=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1578205197536359766==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gAczc7bMggm6wsqpnF6QZbox"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gAczc7bMggm6wsqpnF6QZbox
Content-Type: multipart/mixed; boundary="------------7PxM014TwoOGFMgqnwnznIds";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Message-ID: <e2d1157e-47cc-467d-a319-12bb07ef960c@suse.com>
Subject: Re: [RFC PATCH 3/3] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
References: <20230608140333.4083-1-jgross@suse.com>
 <20230608140333.4083-4-jgross@suse.com>
 <20230920145222.GB6687@noisy.programming.kicks-ass.net>
In-Reply-To: <20230920145222.GB6687@noisy.programming.kicks-ass.net>

--------------7PxM014TwoOGFMgqnwnznIds
Content-Type: multipart/mixed; boundary="------------PgzWaZUw7MU1dTZ4rj1huxtd"

--------------PgzWaZUw7MU1dTZ4rj1huxtd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDkuMjMgMTY6NTIsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUaHUsIEp1
biAwOCwgMjAyMyBhdCAwNDowMzozM1BNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
Pj4gSW5zdGVhZCBvZiBzdGFja2luZyBhbHRlcm5hdGl2ZSBhbmQgcGFyYXZpcnQgcGF0Y2hp
bmcsIHVzZSB0aGUgbmV3DQo+PiBBTFRfRkxBR19DQUxMIGZsYWcgdG8gc3dpdGNoIHRob3Nl
IG1peGVkIGNhbGxzIHRvIHB1cmUgYWx0ZXJuYXRpdmUNCj4+IGhhbmRsaW5nLg0KPj4NCj4+
IFRoaXMgZWxpbWluYXRlcyB0aGUgbmVlZCB0byBiZSBjYXJlZnVsIHJlZ2FyZGluZyB0aGUg
c2VxdWVuY2Ugb2YNCj4+IGFsdGVybmF0aXZlIGFuZCBwYXJhdmlydCBwYXRjaGluZy4NCj4+
DQo+PiBGb3IgY2FsbCBkZXB0aCB0cmFja2luZyBjYWxsdGh1bmtzX3NldHVwKCkgbmVlZHMg
dG8gYmUgYWRhcHRlZCB0byBwYXRjaA0KPj4gY2FsbHMgYXQgYWx0ZXJuYXRpdmUgcGF0Y2hp
bmcgc2l0ZXMgaW5zdGVhZCBvZiBwYXJhdmlydCBjYWxscy4NCj4+DQo+PiBSZW1vdmUgdGhl
IG5vIGxvbmdlciBuZWVkZWQgcGFyYXZpcnQgcGF0Y2hpbmcgYW5kIHJlbGF0ZWQgY29kZS4N
Cj4gDQo+IEkgdGhpbmsgdGhpcyBiZWNvbWVzIGVhc2llciBpZiB5b3UgZmlyc3QgY29udmVy
dCB0aGUgcGFyYXZpcnQgc2l0ZXMgdG8NCj4gYWx0ZXJuYXRpdmVzLCBzdWNoIHRoYXQgLnBh
cmFpbnN0cnVjdGlvbnMgaXMgZW1wdHksIGFuZCB0aGVuIGluIGENCj4gc3Vic2VxdWVudCBw
YXRjaCByZW1vdmUgYWxsIHRoZSBwYXJhdmlydCBpbmZyYXN0cnVjdHVyZSB0aGF0IGlzIHVu
dXNlZC4NCg0KRmluZSB3aXRoIG1lLg0KDQpTcGVha2luZyBvZiBhZGRpdGlvbmFsIHBhdGNo
ZXM6IGFueSBpZGVhIGhvdyB0aGUgcmVsYXRlZCBvYmp0b29sIGNoYW5nZShzKQ0Kc2hvdWxk
IGxvb2sgbGlrZT8gSSBzdXNwZWN0IHRoZXkgYXJlIG5lZWRlZCAuLi4NCg0KPiANCj4gDQo+
PiArI2RlZmluZSBTQVZFX0ZMQUdTCUFMVEVSTkFUSVZFXzIgIlBBUkFfSVJRX3NhdmVfZmw7
IiwgQUxUX0NBTExfSU5TVFIsIFwNCj4+ICsJCQkJICAgICAgQUxUX0NBTExfQUxXQVlTLCAi
cHVzaGY7IHBvcCAlcmF4OyIsIFwNCj4+ICsJCQkJICAgICAgQUxUX05PVChYODZfRkVBVFVS
RV9YRU5QVikNCj4gDQo+IEkgZmluZCB0aGlzIG1vcmUgcmVhZGFibGUgd2hlbiB3cml0dGVu
IGFzOg0KPiANCj4gI2RlZmluZSBTQVZFX0ZMQUdTCUFMVEVSTkFUSVZFXzIgIlBBUkFfSVJR
X3NhdmVfZmw7IiwJCVwNCj4gCQkJCSAgICAgIEFMVF9DQUxMX0lOU1RSLCBBTFRfQ0FMTF9B
TFdBWVMsCVwNCj4gCQkJCSAgICAgICJwdXNoZjsgcG9wICVyYXg7IiwgQUxUX05PVChYODZf
RkVBVFVSRV9YRU5QVikNCj4gDQo+IChhbmQgcGVyaGFwcyBBTFRfTk9UX1hFTiBpcyBpbiBv
cmRlciwgdGhlcmUncyBhIHRvbiBvZiB0aG9zZSkNCg0KSSBsaWtlIGJvdGggc3VnZ2VzdGlv
bnMuDQoNCj4gDQo+IElmIHlvdSBiYXNlIHRoaXMgb24gdG9wIG9mIHRoZSBuZXN0ZWQgYWx0
ZXJuYXRpdmUgcGF0Y2hlcywgYW5vdGhlcg0KPiBoZWxwZXIgbWlnaHQgYmU6DQo+IA0KPiAj
ZGVmaW5lIF9fUFZfQUxURVJOQVRJVkUob2xkKSBfX0FMVEVSTkFUSVZFKG9sZCwgQUxUX0NB
TExfSU5TVFIsIEFMVF9DQUxMX0FMV0FZUykNCj4gDQo+IFNvIHRoYXQgeW91IGNhbiB0aGVu
IHdyaXRlOg0KPiANCj4gI2RlZmluZSBTQVZFX0ZMQUdTCV9fQUxURVJOQVRJVkUoX19QVl9B
TFRFUk5BVElWRSgiUEFSQV9JUlFfc2F2ZV9mbDsiKSwNCj4gCQkJCSAgICAgICJwdXNoZjsg
cG9wICVyYXg7IiwgQUxUX05PVF9YRU4pDQo+IA0KPiBCdXQgcGVyaGFwcyBJJ20gb3Zlci1j
b29raW5nIHRoaW5ncyBub3cuLg0KDQpJIGRvbid0IHRoaW5rIHRoaXMgaXMgbmVlZGVkIGZv
ciB0aGUgc2luZ2xlIGluc3RhbmNlIGl0IGlzIHVzZWZ1bCBmb3IuDQoNCg0KSnVlcmdlbg0K

--------------PgzWaZUw7MU1dTZ4rj1huxtd
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------PgzWaZUw7MU1dTZ4rj1huxtd--

--------------7PxM014TwoOGFMgqnwnznIds--

--------------gAczc7bMggm6wsqpnF6QZbox
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmULFG8FAwAAAAAACgkQsN6d1ii/Ey/+
zgf+LVCAhPASEItcGSjU3MHyY1pjAhmx9/8CXNPg4au+Hw4oQ0o3beh7ffj60Li06wKaC38ygrKE
gV+H3fwilPDOxC1LHYm3B72v+5qWQR6lFZtpMgDlX2ivClEayDhkLzvapR7k+DP9duycvUvwFFeV
ydzLI4rRpRcQyZpTR3wF8xxhwDUdg0jEuJudS6RLWR2JU6lFjoM/Ec1/gPiNj/46bmj6LO6PIqHS
DGqtSbt8s4366e2sLmPvCnJFDGoYSTzPvl3ErjYGj0Oy6TRh5lD7caue5ol3ogWRqssfx4hrMYPD
aXQ8M0CphvKnjCKslVIpL+8gcN/2OFO7r6CnD7z6ww==
=4fAN
-----END PGP SIGNATURE-----

--------------gAczc7bMggm6wsqpnF6QZbox--

--===============1578205197536359766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1578205197536359766==--
