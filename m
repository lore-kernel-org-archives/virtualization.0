Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7606DC8300C
	for <virtualization@archiver.kernel.org>; Mon, 12 Jun 2023 05:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D87E540352;
	Mon, 12 Jun 2023 05:27:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D87E540352
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Ypj3sVWE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A3U-tYGaGyz1; Mon, 12 Jun 2023 05:27:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 47BEC400A6;
	Mon, 12 Jun 2023 05:27:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47BEC400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D498C0037;
	Mon, 12 Jun 2023 05:27:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93E34C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 05:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 59FB88212C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 05:27:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 59FB88212C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=Ypj3sVWE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yuS67hAfQZWf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 05:27:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A05682127
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A05682127
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 05:27:33 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A9872203E0;
 Mon, 12 Jun 2023 05:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1686547650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F2nQeuKIoTdQ46edr+Fv7GnCIbjUUdRzQs4BphAaLS8=;
 b=Ypj3sVWE5GUj/P/XiR8Vl+kqMTD+M73Kq3ri3awbjF9zaCEonk5tXuhz6JMp4bzGIYdZmv
 IwNdp5ZogNAEsD3gQo7rMB9sPuavF9VTkljDpJ6Fiq0NejwcG8gQ9ckOfwtgIXAW+X8VYv
 Cxv8sOlqJ9xSMjcSvZL+eZzjxY6Dl8I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E94B1357F;
 Mon, 12 Jun 2023 05:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CaO0FcKshmTUOwAAMHmgww
 (envelope-from <jgross@suse.com>); Mon, 12 Jun 2023 05:27:30 +0000
Message-ID: <2dc52f2c-1fd0-8f89-1975-92f7c1de6b16@suse.com>
Date: Mon, 12 Jun 2023 07:27:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Documentation: virt: clean up paravirt_ops doc.
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20230610054310.6242-1-rdunlap@infradead.org>
In-Reply-To: <20230610054310.6242-1-rdunlap@infradead.org>
Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, x86@kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>,
 virtualization@lists.linux-foundation.org, Ajay Kaher <akaher@vmware.com>,
 Alexey Makhalov <amakhalov@vmware.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
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
Content-Type: multipart/mixed; boundary="===============1124188248069750465=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1124188248069750465==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zzULCniiyy6MvmFef0FAqdJJ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zzULCniiyy6MvmFef0FAqdJJ
Content-Type: multipart/mixed; boundary="------------eFxpLWZGQJEETj9Y4rExBOg0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 virtualization@lists.linux-foundation.org, x86@kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>,
 Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <2dc52f2c-1fd0-8f89-1975-92f7c1de6b16@suse.com>
Subject: Re: [PATCH] Documentation: virt: clean up paravirt_ops doc.
References: <20230610054310.6242-1-rdunlap@infradead.org>
In-Reply-To: <20230610054310.6242-1-rdunlap@infradead.org>

--------------eFxpLWZGQJEETj9Y4rExBOg0
Content-Type: multipart/mixed; boundary="------------zCIFB6ELLfs4RSJyCfzkh0Px"

--------------zCIFB6ELLfs4RSJyCfzkh0Px
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAuMDYuMjMgMDc6NDMsIFJhbmR5IER1bmxhcCB3cm90ZToNCj4gQ2xhcmlmeSBsYW5n
dWFnZS4gQ2xlYW4gdXAgZ3JhbW1hci4gSHlwaGVuYXRlIHNvbWUgd29yZHMuDQo+IA0KPiBD
aGFuZ2UgImxvdy1vcHMiIHRvICJsb3ctbGV2ZWwiIHNpbmNlICJsb3ctb3BzIiBpc24ndCBk
ZWZpbmVkIG9yIGV2ZW4NCj4gbWVudGlvbmVkIGFueXdoZXJlIGVsc2UgaW4gdGhlIGtlcm5l
bCBzb3VyY2UgdHJlZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1
bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBDYzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2Uu
Y29tPg0KPiBDYzogQWpheSBLYWhlciA8YWthaGVyQHZtd2FyZS5jb20+DQo+IENjOiBBbGV4
ZXkgTWFraGFsb3YgPGFtYWtoYWxvdkB2bXdhcmUuY29tPg0KPiBDYzogVk13YXJlIFBWLURy
aXZlcnMgUmV2aWV3ZXJzIDxwdi1kcml2ZXJzQHZtd2FyZS5jb20+DQo+IENjOiB2aXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KPiBDYzogeDg2QGtlcm5lbC5v
cmcNCj4gQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+IENjOiAi
THVrZSBOb3dha293c2tpLUtyaWpnZXIiIDxsbm93YWtvd0BlbmcudWNzZC5lZHU+DQo+IENj
OiBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4NCg0KQWNrZWQtYnk6IEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQoNCg==
--------------zCIFB6ELLfs4RSJyCfzkh0Px
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------zCIFB6ELLfs4RSJyCfzkh0Px--

--------------eFxpLWZGQJEETj9Y4rExBOg0--

--------------zzULCniiyy6MvmFef0FAqdJJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSGrMEFAwAAAAAACgkQsN6d1ii/Ey/a
8gf/THOimDQMxgVh677LMnxJFF+v7hy0y5tFGmYfCe2vaUX+4CzkecYDFRXgGHxhVZ3loeOMe6Dj
GRPTUvtx+UBXVz2yTrAL0gJxOteWtBunH0c6A994DVHDa1FkUkw72QL/XJz9p2ep39uF8zSxPqIQ
sq7UNG56UE3yTqKGi16vpC1jZPfBur2KixJSvvfvtJS8mb81aWAh4siOoqtLrWkpZUon8KUzNRHT
xJnQqxTr/88JOY9B/t3CxZ4NV9eT+kerYPCFMiRWmdNT9NYIqJAD4CQ6yVqtVv7QR5kp2ZC1mXUW
NVxBdvOVajwGYzM1xgT78lMbvceJyeKY9a/KBEK6aw==
=Eum5
-----END PGP SIGNATURE-----

--------------zzULCniiyy6MvmFef0FAqdJJ--

--===============1124188248069750465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1124188248069750465==--
