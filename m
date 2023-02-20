Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B96C636CC
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 14:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2051C81B01;
	Mon, 20 Feb 2023 14:22:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2051C81B01
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Iyn/H30X;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ag0OK4/P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a2M0hQECKb_3; Mon, 20 Feb 2023 14:22:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8EDF681570;
	Mon, 20 Feb 2023 14:22:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EDF681570
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62E50C0032;
	Mon, 20 Feb 2023 14:22:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90FE2C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 14:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 576BB410A8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 14:22:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 576BB410A8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Iyn/H30X; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ag0OK4/P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PzHoMDek5P_w
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 14:22:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 445E2408D0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 445E2408D0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 14:22:07 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05C67203E1;
 Mon, 20 Feb 2023 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676902924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=usq2J/A02vvXu+D3dj5S2uYZKeTAbNVbciu3CO0eiEw=;
 b=Iyn/H30XD9cJIrf0ikAp7FcWKtx0Cvtwfu/XZ4MVpqzC138dOouySwusuOuaFeKMiMz/gG
 C1j88F79yAbXuwqBnspJdxX2pjbEcaMILL756C5IpLKJIB1duXDruat2toT82JY37iXwWI
 PXgnB9x/MmXTJcHAfurhduYSmciJNiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676902924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=usq2J/A02vvXu+D3dj5S2uYZKeTAbNVbciu3CO0eiEw=;
 b=ag0OK4/Pexe3qUqIWsQ9rF9d1qwqgidytqC4p3yO714nprAYGzcwGfp2fZOfMgu7yBhjpf
 OxZk2N9Hx2assoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5545139DB;
 Mon, 20 Feb 2023 14:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b1oNMwuC82PzLwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 20 Feb 2023 14:22:03 +0000
Message-ID: <edafc067-f8f1-e45b-9b0b-da0f1cabac4b@suse.de>
Date: Mon, 20 Feb 2023 15:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 17/17] drm/cirrus: Use VGA macro constants to unblank
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20230215161517.5113-1-tzimmermann@suse.de>
 <20230215161517.5113-18-tzimmermann@suse.de>
 <20230216113330.rmzmkdvpxdqk2nrd@sirius.home.kraxel.org>
From: Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230216113330.rmzmkdvpxdqk2nrd@sirius.home.kraxel.org>
Cc: airlied@redhat.com, sam@ravnborg.org, javierm@redhat.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============7236157228233009833=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7236157228233009833==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7gXLJSRR3CZNUIuU32SQhT0T"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------7gXLJSRR3CZNUIuU32SQhT0T
Content-Type: multipart/mixed; boundary="------------0BWpDwiySRfk7ruJQ1dQXzG0";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: javierm@redhat.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, airlied@redhat.com,
 sam@ravnborg.org
Message-ID: <edafc067-f8f1-e45b-9b0b-da0f1cabac4b@suse.de>
Subject: Re: [PATCH 17/17] drm/cirrus: Use VGA macro constants to unblank
References: <20230215161517.5113-1-tzimmermann@suse.de>
 <20230215161517.5113-18-tzimmermann@suse.de>
 <20230216113330.rmzmkdvpxdqk2nrd@sirius.home.kraxel.org>
In-Reply-To: <20230216113330.rmzmkdvpxdqk2nrd@sirius.home.kraxel.org>

--------------0BWpDwiySRfk7ruJQ1dQXzG0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTYuMDIuMjMgdW0gMTI6MzMgc2NocmllYiBHZXJkIEhvZmZtYW5uOg0KPiBP
biBXZWQsIEZlYiAxNSwgMjAyMyBhdCAwNToxNToxN1BNICswMTAwLCBUaG9tYXMgWmltbWVy
bWFubiB3cm90ZToNCj4+IFNldCB0aGUgVkdBIGJpdCBmb3IgdW5ibGFua2luZyB3aXRoIG1h
Y3JvIGNvbnN0YW50cyBpbnN0ZWFkIG9mIG1hZ2ljDQo+PiB2YWx1ZXMuIE5vIGZ1bmN0aW9u
YWwgY2hhbmdlcy4NCj4gDQo+IGJsYW5rL3VuYmxhbmsgc2hvdWxkIHdvcmsgc2ltbGlhciB0
byBib2NocyAoc2VlIGNvbW1pdCAyNTBlNzQzOTE1ZDQpLA0KPiB0aGF0IGlzIG1heWJlIGEg
bmljZSB0aGluZyB0byBhZGQgb2YgeW91IG1vZGVybml6ZSB0aGUgZHJpdmVyIGFueXdheS4N
Cj4gDQo+IHRha2UgY2FyZSwNCj4gICAgR2VyZA0KPiANCg0KRG8geW91IGhhdmUgY29tbWVu
dHMgb24gdGhlIG90aGVyIHBhdGNoZXM/DQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCi0t
IA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KTWF4ZmVsZHN0ci4gNSwgOTA0MDkg
TsO8cm5iZXJnLCBHZXJtYW55DQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHZXNjaMOk
ZnRzZsO8aHJlcjogSXZvIFRvdGV2DQo=

--------------0BWpDwiySRfk7ruJQ1dQXzG0--

--------------7gXLJSRR3CZNUIuU32SQhT0T
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmPzggsFAwAAAAAACgkQlh/E3EQov+C5
wA/+O1d2tfCvQgNMsri96mX7NyZ+d7B8d61CHLnf88JgtpPk2r9Tuy2yNKDv8dXLP26L6INx0v5i
FOY1MqBIJJUYfGlml7CoELqWPO+PSk0YXLwX4VocqgJkAz5GPa8oz5j/38emUbf9USVDT6YJKDbl
VRzQBJQg23L1zINO2DyP4IpNa8rz2ScWgC05kWjHltdHnQ5KRDFzynx3BI6bgufV4lw6QVDacrAp
LROfE2Ul1jCKxK3LhvHsw01Ecz5wqA7KEvkDaAxlQPabnVuIBV24guP8wCcXyHDB6WYIT2ZkF6om
0sRLZUOd3AA1Y+dOb9fs1zmdWKpL6AQBRBPG3DPeJdjZDOHe3P+j4JHDnQn+nNQVNVZbEN8Au1c2
XXZyDyua+yLNxDqqyf/hBt36ldOHI4ayrCkl5LnL6GvvtCXlZxXwusEm8kEUlsa1DX8H7OatXaJY
CjBflw5Xvig037q6FGpRt64N1WDrPXHRCnazVPiAZcLgkcHY5wVIgv66LMQ57ARt1HoFGC+f2Hbz
SdjPtzxyK1QSFRqOdkevaUkKa2OG9Tcpb17EdbxMDVfAQUVlOSSCU4+5p2HHuIJsPNj6JCa4/8wd
YuuuG+ZfcjR4Ohvlthcf07MaTFVQmSADDA4SkcEqszR8CjFWCPyWSE4AOmFOIsoX2v5dF6gJBouG
+xI=
=FlQa
-----END PGP SIGNATURE-----

--------------7gXLJSRR3CZNUIuU32SQhT0T--

--===============7236157228233009833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7236157228233009833==--
