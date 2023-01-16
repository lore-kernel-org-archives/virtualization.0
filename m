Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0971CC54EBE
	for <virtualization@archiver.kernel.org>; Mon, 16 Jan 2023 06:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C9E24031B;
	Mon, 16 Jan 2023 06:43:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C9E24031B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=P2wXriVI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id myXnl0hhQuDX; Mon, 16 Jan 2023 06:43:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6964940292;
	Mon, 16 Jan 2023 06:43:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6964940292
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B81CC0032;
	Mon, 16 Jan 2023 06:43:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A64EAC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 06:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B71781516
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 06:43:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B71781516
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=P2wXriVI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rTFz8tDOPuZI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 06:43:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C7D4814BB
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C7D4814BB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 06:43:29 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA01C34E8C;
 Mon, 16 Jan 2023 06:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1673851406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqQqkkW8vDqXYBwySLpMuxVJV9a63KYmU1amJWZzGc4=;
 b=P2wXriVIfUN3At+wL+o1ULRQl7N/2JdPYEOOoKn4IkbYr7aJqKzEAr2DR7fxmzyIWpjuZZ
 YQUJbqqMFE8so695aDnsbRO0ClAdncmMWZK3pZyfq2ngtcbcuXFdRg+rbAwJJJ31qlnVf6
 hv0iVP0TVetu/KwwIg71uWDVuXR8TCU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C10B139C2;
 Mon, 16 Jan 2023 06:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /f+PHA7yxGOZXgAAMHmgww
 (envelope-from <jgross@suse.com>); Mon, 16 Jan 2023 06:43:26 +0000
Message-ID: <27d08d32-1a17-0959-203f-39e769f555d1@suse.com>
Date: Mon, 16 Jan 2023 07:43:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/paravirt: merge activate_mm and dup_mmap callbacks
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org
References: <20230112152132.4399-1-jgross@suse.com>
 <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>
Content-Language: en-US
In-Reply-To: <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alexey Makhalov <amakhalov@vmware.com>,
 xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============7441362035169232892=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7441362035169232892==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------f2QYQmcp7oyhJ0GflGkKSPBI"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------f2QYQmcp7oyhJ0GflGkKSPBI
Content-Type: multipart/mixed; boundary="------------PYYImwLJ6duLYMmgfXqX04GL";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org
Message-ID: <27d08d32-1a17-0959-203f-39e769f555d1@suse.com>
Subject: Re: [PATCH] x86/paravirt: merge activate_mm and dup_mmap callbacks
References: <20230112152132.4399-1-jgross@suse.com>
 <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>
In-Reply-To: <3fcb5078-852e-0886-c084-7fb0cfa5b757@csail.mit.edu>

--------------PYYImwLJ6duLYMmgfXqX04GL
Content-Type: multipart/mixed; boundary="------------0z6dtOJSlYZ8eWZSil6wUXCH"

--------------0z6dtOJSlYZ8eWZSil6wUXCH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMDEuMjMgMDU6MjcsIFNyaXZhdHNhIFMuIEJoYXQgd3JvdGU6DQo+IA0KPiBIaSBK
dWVyZ2VuLA0KPiANCj4gT24gMS8xMi8yMyA3OjIxIEFNLCBKdWVyZ2VuIEdyb3NzIHdyb3Rl
Og0KPj4gVGhlIHR3byBwYXJhdmlydCBjYWxsYmFja3MgLm1tdS5hY3RpdmF0ZV9tbSBhbmQg
Lm1tdS5kdXBfbW1hcCBhcmUNCj4+IHNoYXJpbmcgdGhlIHNhbWUgaW1wbGVtZW50YXRpb25z
IGluIGFsbCBjYXNlczogZm9yIFhlbiBQViBndWVzdHMgdGhleQ0KPj4gYXJlIHBpbm5pbmcg
dGhlIFBHRCBvZiB0aGUgbmV3IG1tX3N0cnVjdCwgYW5kIGZvciBhbGwgb3RoZXIgY2FzZXMN
Cj4+IHRoZXkgYXJlIGEgTk9QLg0KPj4NCj4gDQo+IEkgd2FzIGV4cGVjdGluZyB0aGF0IHRo
ZSBkdXBsaWNhdGVkIGZ1bmN0aW9ucyB4ZW5fYWN0aXZhdGVfbW0oKSBhbmQNCj4geGVuX2R1
cF9tbWFwKCkgd291bGQgYmUgbWVyZ2VkIGludG8gYSBjb21tb24gb25lLCBhbmQgdGhhdCBi
b3RoDQo+IC5tbXUuYWN0aXZhdGVfbW0gYW5kIC5tbXUuZHVwX21tYXAgY2FsbGJhY2tzIHdv
dWxkIGJlIG1hcHBlZCB0byB0aGF0DQo+IGNvbW1vbiBpbXBsZW1lbnRhdGlvbiBmb3IgWGVu
IFBWLg0KPiANCj4+IFNvIG1lcmdlIHRoZW0gdG8gYSBjb21tb24gY2FsbGJhY2sgLm1tdS5l
bnRlcl9tbWFwIChpbiBjb250cmFzdCB0byB0aGUNCj4+IGNvcnJlc3BvbmRpbmcgYWxyZWFk
eSBleGlzdGluZyAubW11LmV4aXRfbW1hcCkuDQo+Pg0KPiANCj4gSW5zdGVhZCwgdGhpcyBw
YXRjaCBzZWVtcyB0byBiZSBtZXJnaW5nIHRoZSBjYWxsYmFja3MgdGhlbXNlbHZlcy4uLg0K
PiANCj4gSSBzZWUgdGhhdCdzIG5vdCBhbiBpc3N1ZSByaWdodCBub3cgc2luY2UgdGhlcmUg
aXMgbm8gb3RoZXIgYWN0dWFsDQo+IHVzZXIgZm9yIHRoZXNlIGNhbGxiYWNrcy4gQnV0IGFy
ZSB3ZSBzdXJlIHRoYXQgbWVyZ2luZyB0aGUgY2FsbGJhY2tzDQo+IGp1c3QgYmVjYXVzZSB0
aGUgY3VycmVudCB1c2VyIChYZW4gUFYpIGhhcyB0aGUgc2FtZSBpbXBsZW1lbnRhdGlvbiBm
b3INCj4gYm90aCBpcyBhIGdvb2QgaWRlYT8gVGhlIGNhbGxiYWNrcyBhcmUgaW52b2tlZCBh
dCBkaXN0aW5jdCBwb2ludHMgZnJvbQ0KPiBmb3JrL2V4ZWMsIHNvIHdvdWxkbid0IGl0IGJl
IHZhbHVhYmxlIHRvIHJldGFpbiB0aGF0IGRpc3RpbmN0aW9uIGluDQo+IHNlbWFudGljcyBp
biB0aGUgY2FsbGJhY2tzIGFzIHdlbGw/DQo+IA0KPiBIb3dldmVyLCBpZiB5b3UgYmVsaWV2
ZSB0aGF0IHR3byBzZXBhcmF0ZSBjYWxsYmFja3MgYXJlIG5vdCByZWFsbHkNCj4gcmVxdWly
ZWQgaGVyZSAoYmVjYXVzZSB0aGVyZSBpcyBubyBzaWduaWZpY2FudCBkaWZmZXJlbmNlIGlu
IHdoYXQgdGhleQ0KPiBtZWFuLCByYXRoZXIgdGhhbiBiZWNhdXNlIHRoZWlyIGNhbGxiYWNr
IGltcGxlbWVudGF0aW9ucyBoYXBwZW4gdG8gYmUNCj4gdGhlIHNhbWUgcmlnaHQgbm93KSwg
dGhlbiBjb3VsZCB5b3UgcGxlYXNlIGV4cGFuZCBvbiB0aGlzIGFuZCBjYWxsIGl0DQo+IG91
dCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsIHBsZWFzZT8NCg0KV291bGQgeW91IGJlIGZpbmUg
d2l0aDoNCg0KICAgSW4gdGhlIGVuZCBib3RoIGNhbGxiYWNrcyBhcmUgbWVhbnQgdG8gcmVn
aXN0ZXIgYW4gYWRkcmVzcyBzcGFjZSB3aXRoIHRoZQ0KICAgdW5kZXJseWluZyBoeXBlcnZp
c29yLCBzbyB0aGVyZSBuZWVkcyB0byBiZSBvbmx5IGEgc2luZ2xlIGNhbGxiYWNrIGZvciB0
aGF0DQogICBwdXJwb3NlLg0KDQoNCkp1ZXJnZW4NCg==
--------------0z6dtOJSlYZ8eWZSil6wUXCH
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0z6dtOJSlYZ8eWZSil6wUXCH--

--------------PYYImwLJ6duLYMmgfXqX04GL--

--------------f2QYQmcp7oyhJ0GflGkKSPBI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPE8g0FAwAAAAAACgkQsN6d1ii/Ey8t
Ngf/d6OpWFNSFigpwYK7Kc+TkmGV5RqwiPEJMARDOsmaX6zjIzYvRHgoC6x2XUwznZlE8lTWf1gV
EfFTLU3ZqmW3RwxZJp8Be1GKpDJwHlVtIiuK5PUV44QPQbiCWlaqHZtMZ/UV8n5ToaFL8ocXG/sl
vWEgWlgZps0DvwculC02JvVYmhV4+oiaO48Ko796E5XpXskYzd72e3IP9TuLo+gH6uDPKRaU3fmc
1QBVa4Da7mcD/JIQ8++Lt5L/DtaApmTFlgk6jqUUjo0xKJumtDzyuoTsV8o/kGXP4PFEgLfKJZy4
KM8/GTRX4GVomox/Ate31wf6jZCRkibNzLebhhUnIQ==
=EPIp
-----END PGP SIGNATURE-----

--------------f2QYQmcp7oyhJ0GflGkKSPBI--

--===============7441362035169232892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7441362035169232892==--
