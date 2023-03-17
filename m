Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C3DC74A5B
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 05:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E2E97405FC;
	Fri, 17 Mar 2023 05:28:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2E97405FC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=HDkC/E6/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id etG1NwdEoeQg; Fri, 17 Mar 2023 05:28:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 527FA40129;
	Fri, 17 Mar 2023 05:28:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 527FA40129
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2004FC0035;
	Fri, 17 Mar 2023 05:28:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7143AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 05:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 458BF81261
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 05:28:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 458BF81261
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=HDkC/E6/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d02TPawYdZxl
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 05:28:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78B2481000
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78B2481000
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 05:28:45 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C08E21A5D;
 Fri, 17 Mar 2023 05:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1679030921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12JEE8bx76CztoU4pR1HoelmIo8ttSsri6NA/o8FJXw=;
 b=HDkC/E6/O6+tjagUz1cSQqaBPmcQYFcBlozlKdFhZdBDBP/9H98nY1OWMWAvcuQX0rjJzj
 ko4GzACga5PsfyNoXBSJjjls8HJHTwcCaFUZFZ12QxaYKKTezwUosJPmqiga5kcPe1DRPo
 42tsfLdD04exeSV+GYOH5InVTfJgsWc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C63013A18;
 Fri, 17 Mar 2023 05:28:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XzRKDYn6E2RNZAAAMHmgww
 (envelope-from <jgross@suse.com>); Fri, 17 Mar 2023 05:28:41 +0000
Message-ID: <58b6a3bf-5cb0-e803-097d-bc058a309412@suse.com>
Date: Fri, 17 Mar 2023 06:28:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] x86/paravirt: convert simple paravirt functions to asm
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
References: <20230308154210.18454-1-jgross@suse.com>
 <20230316201421.GA2060174@hirez.programming.kicks-ass.net>
In-Reply-To: <20230316201421.GA2060174@hirez.programming.kicks-ass.net>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Content-Type: multipart/mixed; boundary="===============0315355599037204457=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0315355599037204457==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------56O0ffVrZXvmdjwgvpDRxXSW"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------56O0ffVrZXvmdjwgvpDRxXSW
Content-Type: multipart/mixed; boundary="------------C3e78lHBnVu065oQG6MRfDHV";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org,
 "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <58b6a3bf-5cb0-e803-097d-bc058a309412@suse.com>
Subject: Re: [PATCH] x86/paravirt: convert simple paravirt functions to asm
References: <20230308154210.18454-1-jgross@suse.com>
 <20230316201421.GA2060174@hirez.programming.kicks-ass.net>
In-Reply-To: <20230316201421.GA2060174@hirez.programming.kicks-ass.net>

--------------C3e78lHBnVu065oQG6MRfDHV
Content-Type: multipart/mixed; boundary="------------xY0qXUuP2GBWana84Cl2VCCg"

--------------xY0qXUuP2GBWana84Cl2VCCg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDMuMjMgMjE6MTQsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBXZWQsIE1h
ciAwOCwgMjAyMyBhdCAwNDo0MjoxMFBNICswMTAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiANCj4+ICtERUZJTkVfUEFSQVZJUlRfQVNNKHB2X25hdGl2ZV9pcnFfZGlzYWJsZSwgImNs
aSIsIC50ZXh0KTsNCj4+ICtERUZJTkVfUEFSQVZJUlRfQVNNKHB2X25hdGl2ZV9pcnFfZW5h
YmxlLCAic3RpIiwgLnRleHQpOw0KPj4gK0RFRklORV9QQVJBVklSVF9BU00ocHZfbmF0aXZl
X3JlYWRfY3IyLCAibW92ICVjcjIsICVyYXgiLCAudGV4dCk7DQo+IA0KPiBwZXIgdGhlc2Ug
diwgdGhlIGFib3ZlIF4gc2hvdWxkIGJlIGluIC5ub2luc3RyLnRleHQNCg0KWWVzLCBhbmQg
SSdtIGluY2xpbmVkIHRvIGV2ZW4gcHV0IHB2X25hdGl2ZV9zYXZlX2ZsIGludG8gdGhlIG5v
aW5zdHINCnNlY3Rpb24uIEFmdGVyIHBhcmF2aXJ0IHBhdGNoaW5nIGl0IGlzbid0IGNhbGxl
ZCBhbnltb3JlIGFueXdheS4NCg0KDQpKdWVyZ2VuDQo=
--------------xY0qXUuP2GBWana84Cl2VCCg
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------xY0qXUuP2GBWana84Cl2VCCg--

--------------C3e78lHBnVu065oQG6MRfDHV--

--------------56O0ffVrZXvmdjwgvpDRxXSW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmQT+ogFAwAAAAAACgkQsN6d1ii/Ey8p
vggAkq9U4F7ThvAlEXHDoMzoyx88tcVs7UFkiDwlGyNgKqIM6yh49vPMxZYixbMHq3hhJYXy2Vqr
ezVSUaqwpgs7ESSqMltCbR/u7rdLxKVENs2OBEJAbM9EzUzAkzQMUUKyE6rGuqaBuj24570VK3Re
pjgJHXVbG/iVB8WhhurpkzNtOnsF2rO3sWEH5PVbz9RYxKPO0OXfZ11BpFVZ/jahSvf8q9RPbAkW
+l3bjYgggqcqTpxgw1JUawxkshy384AwEbYXxdFWcE3ciHtQVixo+AVUqwzVb4vborcjmZnPANI/
+xafWg0IRKsPs7v1lS0OGwSYbf+1dUbEe/Y4YlDY0g==
=CXaS
-----END PGP SIGNATURE-----

--------------56O0ffVrZXvmdjwgvpDRxXSW--

--===============0315355599037204457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0315355599037204457==--
