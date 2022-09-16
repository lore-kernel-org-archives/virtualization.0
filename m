Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC62C54EE9
	for <virtualization@archiver.kernel.org>; Fri, 16 Sep 2022 10:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53C65418DF;
	Fri, 16 Sep 2022 10:36:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53C65418DF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=JZQAJKBz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qIKruFR7TCWk; Fri, 16 Sep 2022 10:36:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 879E8418BB;
	Fri, 16 Sep 2022 10:36:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 879E8418BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 698DFC0032;
	Fri, 16 Sep 2022 10:36:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64B18C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 10:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3690C418BF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 10:36:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3690C418BF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iL2DdwOOafEg
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 10:36:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCE1A418BB
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCE1A418BB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 10:36:18 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 531EF20111;
 Fri, 16 Sep 2022 10:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1663324576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Mr5B09ql4rgVwGgZnPJUijCE7uNJbt2AIvanYr8VAc=;
 b=JZQAJKBz9DRrIV8dGS4XRv9sMkc0XQKCaeqV1TknVjsst4u7/crLp1UKbNVuivTlOoerRe
 UjSulnaNFq6GKBctAYNAL9rAgnKCAnhlskgtGTTnljRCqhJWyItvbEtnuVu1t3hjLf7v8z
 jUwwxwakUTAeAX9cotciFzdhgFtk67k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E97F1346B;
 Fri, 16 Sep 2022 10:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rKkhCqBRJGPVdQAAMHmgww
 (envelope-from <jgross@suse.com>); Fri, 16 Sep 2022 10:36:16 +0000
Message-ID: <a7044036-1dd7-0a3c-6b60-392cb5f774dc@suse.com>
Date: Fri, 16 Sep 2022 12:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] jailhouse: Hold reference returned from of_find_xxx API
Content-Language: en-US
To: Liang He <windhl@126.com>, srivatsa@csail.mit.edu,
 virtualization@lists.linux-foundation.org
References: <20220916090051.4096328-1-windhl@126.com>
In-Reply-To: <20220916090051.4096328-1-windhl@126.com>
Cc: wangkelin2023@163.com
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
Content-Type: multipart/mixed; boundary="===============2761781261571837215=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2761781261571837215==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SHbyhcizx7HaLr6M7RDOiSj0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------SHbyhcizx7HaLr6M7RDOiSj0
Content-Type: multipart/mixed; boundary="------------H6n7TWS4S3Qph0H1vDolAmwo";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Liang He <windhl@126.com>, srivatsa@csail.mit.edu,
 virtualization@lists.linux-foundation.org
Cc: wangkelin2023@163.com
Message-ID: <a7044036-1dd7-0a3c-6b60-392cb5f774dc@suse.com>
Subject: Re: [PATCH v2] jailhouse: Hold reference returned from of_find_xxx
 API
References: <20220916090051.4096328-1-windhl@126.com>
In-Reply-To: <20220916090051.4096328-1-windhl@126.com>

--------------H6n7TWS4S3Qph0H1vDolAmwo
Content-Type: multipart/mixed; boundary="------------2TQ0X72MKOJj06wV5VoyOrkY"

--------------2TQ0X72MKOJj06wV5VoyOrkY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDkuMjIgMTE6MDAsIExpYW5nIEhlIHdyb3RlOg0KPiBJbiBqYWlsaG91c2VfcGFy
YXZpcnQoKSwgd2Ugc2hvdWxkIGhvbGQgdGhlIHJlZmVyZW5jZSByZXR1cm5lZCBmcm9tDQo+
IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKCkgd2hpY2ggaGFzIGluY3JlYXNlZCB0aGUgcmVm
Y291bnQgYW5kIHRoZW4NCj4gY2FsbCBvZl9ub2RlX3B1dCgpIHdpdGggaXQgd2hlbiBkb25l
Lg0KPiANCj4gRml4ZXM6IDYzMzM4YTM4ZGI5NSAoImphaWxob3VzZTogUHJvdmlkZSBkZXRl
Y3Rpb24gZm9yIG5vbi14ODYgc3lzdGVtcyIpDQo+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhl
IDx3aW5kaGxAMTI2LmNvbT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBLZWxpbiBXYW5nIDx3YW5n
a2VsaW4yMDIzQDE2My5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtlbGluIFdhbmcgPHdhbmdr
ZWxpbjIwMjNAMTYzLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9z
c0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQo=
--------------2TQ0X72MKOJj06wV5VoyOrkY
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------2TQ0X72MKOJj06wV5VoyOrkY--

--------------H6n7TWS4S3Qph0H1vDolAmwo--

--------------SHbyhcizx7HaLr6M7RDOiSj0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmMkUZ8FAwAAAAAACgkQsN6d1ii/Ey9e
/Af+NOU81SWyb/FpYxjQDH5NJYPx6rCCnHChqdv/iDDsvc9bhroVV6vjOAxu8AeSkrM0fGYd9KRA
h3wqUT4LvYe862eXXLz1EC9Dp8tr/N+I5KXjhq1/9a2MLkm4YqbqaIKv/F+FeMHS37Dhae12FHS7
YfAOwkolbQk62holM9Iw4SL6RMJ/vIY9fcLrQXPRrKGqHuGEF9tyYgnGfzJblDjd0tAzFvrRqX0k
SaqeEGTs2mzxIiH/+T+rnp+Yn5EnvkterR7o1wIt5tSvJrtS75fZJf8NcIey4PRibPYfjqDSjD1T
BOQcO1boiTxm2UZyY9+pHkok/6DAkrSRXkrJzyf1SQ==
=gIJp
-----END PGP SIGNATURE-----

--------------SHbyhcizx7HaLr6M7RDOiSj0--

--===============2761781261571837215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2761781261571837215==--
