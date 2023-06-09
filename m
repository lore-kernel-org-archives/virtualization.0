Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09661C7EE25
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 15:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 73126419E1;
	Fri,  9 Jun 2023 15:11:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73126419E1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=JX6vU5Bg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dXtvDeg9VCth; Fri,  9 Jun 2023 15:11:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0DAC340151;
	Fri,  9 Jun 2023 15:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DAC340151
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D77A9C0037;
	Fri,  9 Jun 2023 15:11:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4044C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 15:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B18E3615EC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 15:11:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B18E3615EC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=JX6vU5Bg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8k3ZFM0-nXjk
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 15:11:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7E3F60C07
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7E3F60C07
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 15:11:46 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 53C3721A39;
 Fri,  9 Jun 2023 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1686323504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JvrAIVLACWf1tcdLt7whiGHuBK/i8TnV61MJCsBdZJk=;
 b=JX6vU5Bg9I7iokUtsGLDHaDZMUmrGHv+aFI5GzFNiuDf8SrOblSWkX8zswwD1dT0D4Ycxo
 WqsxYeU2Mt51h7NDx4RpHcVlWk3exAbQYI0J0H98ZiWRs7yErmG5jZMFzlZOOFfK7MHR8M
 jOL98Pz8JVzTnglpQogJKO9AVVucBBY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E21D113A47;
 Fri,  9 Jun 2023 15:11:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nPivNS9Bg2TxfQAAMHmgww
 (envelope-from <jgross@suse.com>); Fri, 09 Jun 2023 15:11:43 +0000
Message-ID: <38485310-ae84-0d02-73dc-36da8b902d25@suse.com>
Date: Fri, 9 Jun 2023 17:11:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] x86/paravirt: Make the struct paravirt_patch_site
 packed
Content-Language: en-US
To: Hou Wenlong <houwenlong.hwl@antgroup.com>, linux-kernel@vger.kernel.org
References: <9e6053107fbaabc0d33e5d2865c5af2c67ec9925.1686301237.git.houwenlong.hwl@antgroup.com>
 <6dcb20159ded36586c5f7f2ae159e4e030256627.1686301237.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <6dcb20159ded36586c5f7f2ae159e4e030256627.1686301237.git.houwenlong.hwl@antgroup.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Lai Jiangshan <jiangshan.ljs@antgroup.com>,
 virtualization@lists.linux-foundation.org, Ajay Kaher <akaher@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
 Alexey Makhalov <amakhalov@vmware.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>
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
Content-Type: multipart/mixed; boundary="===============0225247245125172239=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0225247245125172239==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dz87378lXt0BbZejNLEynHLD"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dz87378lXt0BbZejNLEynHLD
Content-Type: multipart/mixed; boundary="------------rrzfTcg00e00B3d1hFL8Z1yp";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>, linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, Nadav Amit
 <namit@vmware.com>, Ajay Kaher <akaher@vmware.com>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 virtualization@lists.linux-foundation.org
Message-ID: <38485310-ae84-0d02-73dc-36da8b902d25@suse.com>
Subject: Re: [PATCH 2/2] x86/paravirt: Make the struct paravirt_patch_site
 packed
References: <9e6053107fbaabc0d33e5d2865c5af2c67ec9925.1686301237.git.houwenlong.hwl@antgroup.com>
 <6dcb20159ded36586c5f7f2ae159e4e030256627.1686301237.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <6dcb20159ded36586c5f7f2ae159e4e030256627.1686301237.git.houwenlong.hwl@antgroup.com>

--------------rrzfTcg00e00B3d1hFL8Z1yp
Content-Type: multipart/mixed; boundary="------------n2W6vR1GryZ0wSC4V0C0nQOO"

--------------n2W6vR1GryZ0wSC4V0C0nQOO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkuMDYuMjMgMTE6NDUsIEhvdSBXZW5sb25nIHdyb3RlOg0KPiBTaW1pbGFyIHRvIHN0
cnVjdCBhbHRfaW5zdHIsIG1ha2UgdGhlIHN0cnVjdCBwYXJhdmlydF9wYXRjaF9zaXRlIHBh
Y2tlZA0KPiBhbmQgZ2V0IHJpZCBvZiBhbGwgdGhlIC5hbGlnbiBkaXJlY3RpdmVzLiBUaGlz
IGNvdWxkIHNhdmUgMiBieXRlcyBmb3INCj4gb25lIGVudHJ5IG9uIFg4Nl82NC4NCj4gDQo+
IFN1Z2dlc3RlZC1ieTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogSG91IFdlbmxvbmcgPGhvdXdlbmxvbmcuaHdsQGFudGdyb3VwLmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpKdWVy
Z2VuDQo=
--------------n2W6vR1GryZ0wSC4V0C0nQOO
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------n2W6vR1GryZ0wSC4V0C0nQOO--

--------------rrzfTcg00e00B3d1hFL8Z1yp--

--------------dz87378lXt0BbZejNLEynHLD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSDQS8FAwAAAAAACgkQsN6d1ii/Ey+/
egf/ZPWJTw2x3KBGFsQN7qBUGMVuw+x9pqVmDF/p+1+Ygkx14246JGY1W4gG/RZJcDQPpWy58DlZ
uP33LLWbr4RfUfPAmLCGUuz8MdYcykrn1gOBK7FhbF1GtETVk5wOuso5HNYYythvkGvxi9/GzQ3w
LZo0nOqSl6F3JY0krt+zMZGRCe6xRFIHG6G+/Q67BSnwmjM+4W9w0aY6yXI7O9hkvqRXUDhQn8A1
V2Y7FGOG4027lCP25zuKR91ImVriiljCpA20GJTeZ7xfmgk8/tQIkpqBYMf9K/p5nfi1zcEaGFAC
lCjVJAD05JE1JOhtMPtI5RrsEh3yy0HEulnEP27zAg==
=doMf
-----END PGP SIGNATURE-----

--------------dz87378lXt0BbZejNLEynHLD--

--===============0225247245125172239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0225247245125172239==--
