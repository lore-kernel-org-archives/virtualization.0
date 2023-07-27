Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364BEEB64DD
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 05:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AADBF60E5B;
	Thu, 27 Jul 2023 05:24:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AADBF60E5B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=myHTM2Rh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rISpf0G7QoZh; Thu, 27 Jul 2023 05:24:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2C88060E5D;
	Thu, 27 Jul 2023 05:24:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C88060E5D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0507BC0072;
	Thu, 27 Jul 2023 05:24:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6120EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 05:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2EF7960E5D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 05:23:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2EF7960E5D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 968SR7Pkn3fP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 05:23:56 +0000 (UTC)
X-Greylist: delayed 564 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 27 Jul 2023 05:23:55 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD16160E5B
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD16160E5B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 05:23:55 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B4741F383;
 Thu, 27 Jul 2023 05:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1690434868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTdHiNQcaCZE78fGeClmYN0Gm2fXFHfS4a+GD564Hu0=;
 b=myHTM2Rhzyxpy1H5Kex389WmVZshtWc7iSQ99qhW/mjupBGZA033+zb/Qt5y73J2sJMnpl
 Zi5b1iHln/QgIHVy/3SolO0gT1NvjTmnBoMOq5ph7pF7OvjhNucaNqJjO5RsnvVBrI289S
 cxWQrm46qyRlmcOOV8faN7rKzDg0SWY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B287138E5;
 Thu, 27 Jul 2023 05:14:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v2g3ATT9wWQ6eAAAMHmgww
 (envelope-from <jgross@suse.com>); Thu, 27 Jul 2023 05:14:28 +0000
Message-ID: <3d363767-3960-7ed9-8dce-c46fa5445b51@suse.com>
Date: Thu, 27 Jul 2023 07:14:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] x86/paravirt: Fix tlb_remove_table function callback
 prototype warning
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
References: <20230726231139.never.601-kees@kernel.org>
In-Reply-To: <20230726231139.never.601-kees@kernel.org>
Cc: x86@kernel.org, kernel test robot <lkp@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Ajay Kaher <akaher@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, linux-hardening@vger.kernel.org,
 Sami Tolvanen <samitolvanen@google.com>,
 Alexey Makhalov <amakhalov@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
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
Content-Type: multipart/mixed; boundary="===============0675837491465580505=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0675837491465580505==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BLDac3cN9XMDOl1400k3wyYK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------BLDac3cN9XMDOl1400k3wyYK
Content-Type: multipart/mixed; boundary="------------0MQ0mNlwNh22tS7tBfV8UZJW";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Ajay Kaher <akaher@vmware.com>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Message-ID: <3d363767-3960-7ed9-8dce-c46fa5445b51@suse.com>
Subject: Re: [PATCH] x86/paravirt: Fix tlb_remove_table function callback
 prototype warning
References: <20230726231139.never.601-kees@kernel.org>
In-Reply-To: <20230726231139.never.601-kees@kernel.org>

--------------0MQ0mNlwNh22tS7tBfV8UZJW
Content-Type: multipart/mixed; boundary="------------PFivGCtLbQJW6OwguXOkv0PR"

--------------PFivGCtLbQJW6OwguXOkv0PR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDcuMjMgMDE6MTEsIEtlZXMgQ29vayB3cm90ZToNCj4gVW5kZXIgVz0xLCB0aGlz
IHdhcm5pbmcgaXMgdmlzaWJsZSBpbiBDbGFuZyAxNiBhbmQgbmV3ZXI6DQo+IA0KPiBhcmNo
L3g4Ni9rZXJuZWwvcGFyYXZpcnQuYzozMzc6NDogd2FybmluZzogY2FzdCBmcm9tICd2b2lk
ICgqKShzdHJ1Y3QgbW11X2dhdGhlciAqLCBzdHJ1Y3QgcGFnZSAqKScgdG8gJ3ZvaWQgKCop
KHN0cnVjdCBtbXVfZ2F0aGVyICosIHZvaWQgKiknIGNvbnZlcnRzIHRvIGluY29tcGF0aWJs
ZSBmdW5jdGlvbiB0eXBlIFstV2Nhc3QtZnVuY3Rpb24tdHlwZS1zdHJpY3RdDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAodm9pZCAoKikoc3RydWN0IG1tdV9nYXRoZXIgKiwg
dm9pZCAqKSl0bGJfcmVtb3ZlX3BhZ2UsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4NCj4gDQo+IEFkZCBhIGRpcmVjdCB3cmFwcGVyIGluc3RlYWQsIHdoaWNoIHdpbGwgbWFr
ZSB0aGlzIHdhcm5pbmcgKGFuZA0KPiBwb3RlbnRpYWwgS0NGSSBmYWlsdXJlcykgZ28gYXdh
eS4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNv
bT4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIw
MjMwNzI2MDMzMi5wSm50V1I2by1sa3BAaW50ZWwuY29tLw0KPiBDYzogSnVlcmdlbiBHcm9z
cyA8amdyb3NzQHN1c2UuY29tPg0KPiBDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPg0KPiBDYzogU2FtaSBUb2x2YW5lbiA8c2FtaXRvbHZhbmVuQGdvb2dsZS5j
b20+DQo+IENjOiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0aGFuQGtlcm5lbC5vcmc+DQo+IENj
OiBBamF5IEthaGVyIDxha2FoZXJAdm13YXJlLmNvbT4NCj4gQ2M6IEFsZXhleSBNYWtoYWxv
diA8YW1ha2hhbG92QHZtd2FyZS5jb20+DQo+IENjOiBWTXdhcmUgUFYtRHJpdmVycyBSZXZp
ZXdlcnMgPHB2LWRyaXZlcnNAdm13YXJlLmNvbT4NCj4gQ2M6IFRob21hcyBHbGVpeG5lciA8
dGdseEBsaW51dHJvbml4LmRlPg0KPiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5j
b20+DQo+IENjOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gQ2M6IERhdmUg
SGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+IENjOiB2aXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBLZWVz
IENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4g
R3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQoNCg==
--------------PFivGCtLbQJW6OwguXOkv0PR
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------PFivGCtLbQJW6OwguXOkv0PR--

--------------0MQ0mNlwNh22tS7tBfV8UZJW--

--------------BLDac3cN9XMDOl1400k3wyYK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTB/TMFAwAAAAAACgkQsN6d1ii/Ey9r
AAf+PvD92wMKH9/SWZ0mRYuLdayuTWzEYugdwQkKjyGBR6O+Ff0ereIZOraCf+yFftG5iy2ntIvN
VNZodzdG4qkn406WscGnoqBlHpwcZT9QeRP5EvGE2oxapmFPu5SwWN+JMNQ8rna/P947rTYZdh/h
SeIshf18Mi8RGtNx7D29DAZPSr8fTayyd+uVSKMkkZEjDq7BQtZp99QWYmTPb/4Co8kXfebi+H2x
dL0DE4PHvteYKAAxJZ85uBu41vt3c2lXLc7zBGkLkNAChIAUExlqSQYIzHWq0tCkgLvMkyAQt7Y3
mNjsTE/NxFvDEwx8SLaubpBfzkP4DO+3At6jfqTaWg==
=OMjt
-----END PGP SIGNATURE-----

--------------BLDac3cN9XMDOl1400k3wyYK--

--===============0675837491465580505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0675837491465580505==--
