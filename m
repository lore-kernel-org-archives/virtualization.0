Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7F0C433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 07:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D023E41B82;
	Thu, 21 Apr 2022 07:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MUwifRg2fQq8; Thu, 21 Apr 2022 07:44:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0DCA741B76;
	Thu, 21 Apr 2022 07:44:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7770C0033;
	Thu, 21 Apr 2022 07:44:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6218C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D30E041B82
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Et9xS5GoOuQg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:44:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B338041B76
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:44:32 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C44C01F752;
 Thu, 21 Apr 2022 07:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1650527069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dh2F+Vwxf+hsifUhcR02dLqCCZPXfLcmNwS/TLzgkqA=;
 b=rdH1YhtxbIUi1DkrudbNFO7ydapweGXXIEgXgnaDqpAn19ifa2IE/0F6BRc2R9ukXn8IGZ
 1TyNWL9Tl8e7StrqdsMOFn0B+GgFhu+3al/TN3zUVxvVZ0k5YerIphyNVRIJ1P96u6EWCx
 lu5pfUN/yOwG2L9/6nF3NtzU6nLGoBk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F70D13A84;
 Thu, 21 Apr 2022 07:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7SeXGV0LYWIEFgAAMHmgww
 (envelope-from <jgross@suse.com>); Thu, 21 Apr 2022 07:44:29 +0000
Message-ID: <0737998d-3006-5866-5ea1-dcfef0cfeb32@suse.com>
Date: Thu, 21 Apr 2022 09:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: Elliot Berman <quic_eberman@quicinc.com>,
 "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
 Alexey Makhalov <amakhalov@vmware.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20220420204417.155194-1-quic_eberman@quicinc.com>
Subject: Re: [PATCH] arm64: paravirt: Disable IRQs during
 stolen_time_cpu_down_prepare
In-Reply-To: <20220420204417.155194-1-quic_eberman@quicinc.com>
Cc: Murali Nalajala <quic_mnalajal@quicinc.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============9119567043912632956=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============9119567043912632956==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7aEmFWIe6tv5DKOKFo7EYOGI"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------7aEmFWIe6tv5DKOKFo7EYOGI
Content-Type: multipart/mixed; boundary="------------qKfA015FQnKvuS8o0VgFbD8Z";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Elliot Berman <quic_eberman@quicinc.com>,
 "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
 Alexey Makhalov <amakhalov@vmware.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
 virtualization@lists.linux-foundation.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Murali Nalajala <quic_mnalajal@quicinc.com>
Message-ID: <0737998d-3006-5866-5ea1-dcfef0cfeb32@suse.com>
Subject: Re: [PATCH] arm64: paravirt: Disable IRQs during
 stolen_time_cpu_down_prepare
References: <20220420204417.155194-1-quic_eberman@quicinc.com>
In-Reply-To: <20220420204417.155194-1-quic_eberman@quicinc.com>

--------------qKfA015FQnKvuS8o0VgFbD8Z
Content-Type: multipart/mixed; boundary="------------tMgOFIIt5XmTj75OSWHDTEip"

--------------tMgOFIIt5XmTj75OSWHDTEip
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAuMDQuMjIgMjI6NDQsIEVsbGlvdCBCZXJtYW4gd3JvdGU6DQo+IEZyb206IFByYWty
dXRoaSBEZWVwYWsgSGVyYWd1IDxxdWljX3BoZXJhZ3VAcXVpY2luYy5jb20+DQo+IA0KPiBE
dXJpbmcgaG90cGx1ZywgdGhlIHN0b2xlbiB0aW1lIGRhdGEgc3RydWN0dXJlIGlzIHVubWFw
cGVkIGFuZCBtZW1zZXQuDQo+IFRoZXJlIGlzIGEgcG9zc2liaWxpdHkgb2YgdGhlIHRpbWVy
IElSUSBiZWluZyB0cmlnZ2VyZWQgYmVmb3JlIG1lbXNldA0KPiBhbmQgc3RvbGVuIHRpbWUg
aXMgZ2V0dGluZyB1cGRhdGVkIGFzIHBhcnQgb2YgdGhpcyB0aW1lciBJUlEgaGFuZGxlci4g
VGhpcw0KPiBjYXVzZXMgdGhlIGJlbG93IGNyYXNoIGluIHRpbWVyIGhhbmRsZXIgLQ0KPiAN
Cj4gICAgWyAzNDU3LjQ3MzEzOV1bICAgIEM1XSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBw
YWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgZmZmZmZmYzAzZGYwNTE0OA0KPiAg
ICAuLi4NCj4gICAgWyAzNDU4LjE1NDM5OF1bICAgIEM1XSBDYWxsIHRyYWNlOg0KPiAgICBb
IDM0NTguMTU3NjQ4XVsgICAgQzVdICBwYXJhX3N0ZWFsX2Nsb2NrKzB4MzAvMHg1MA0KPiAg
ICBbIDM0NTguMTYyMzE5XVsgICAgQzVdICBpcnF0aW1lX2FjY291bnRfcHJvY2Vzc190aWNr
KzB4MzAvMHgxOTQNCj4gICAgWyAzNDU4LjE2ODE0OF1bICAgIEM1XSAgYWNjb3VudF9wcm9j
ZXNzX3RpY2srMHgzYy8weDI4MA0KPiAgICBbIDM0NTguMTczMjc0XVsgICAgQzVdICB1cGRh
dGVfcHJvY2Vzc190aW1lcysweDVjLzB4ZjQNCj4gICAgWyAzNDU4LjE3ODMxMV1bICAgIEM1
XSAgdGlja19zY2hlZF90aW1lcisweDE4MC8weDM4NA0KPiAgICBbIDM0NTguMTgzMTY0XVsg
ICAgQzVdICBfX3J1bl9ocnRpbWVyKzB4MTYwLzB4NTdjDQo+ICAgIFsgMzQ1OC4xODc3NDRd
WyAgICBDNV0gIGhydGltZXJfaW50ZXJydXB0KzB4MjU4LzB4Njg0DQo+ICAgIFsgMzQ1OC4x
OTI2OThdWyAgICBDNV0gIGFyY2hfdGltZXJfaGFuZGxlcl92aXJ0KzB4NWMvMHhhMA0KPiAg
ICBbIDM0NTguMTk4MDAyXVsgICAgQzVdICBoYW5kbGVfcGVyY3B1X2RldmlkX2lycSsweGRj
LzB4NDE0DQo+ICAgIFsgMzQ1OC4yMDMzODVdWyAgICBDNV0gIGhhbmRsZV9kb21haW5faXJx
KzB4YTgvMHgxNjgNCj4gICAgWyAzNDU4LjIwODI0MV1bICAgIEM1XSAgZ2ljX2hhbmRsZV9p
cnEuMzQ0OTMrMHg1NC8weDI0NA0KPiAgICBbIDM0NTguMjEzMzU5XVsgICAgQzVdICBjYWxs
X29uX2lycV9zdGFjaysweDQwLzB4NzANCj4gICAgWyAzNDU4LjIxODEyNV1bICAgIEM1XSAg
ZG9faW50ZXJydXB0X2hhbmRsZXIrMHg2MC8weDljDQo+ICAgIFsgMzQ1OC4yMjMxNTZdWyAg
ICBDNV0gIGVsMV9pbnRlcnJ1cHQrMHgzNC8weDY0DQo+ICAgIFsgMzQ1OC4yMjc1NjBdWyAg
ICBDNV0gIGVsMWhfNjRfaXJxX2hhbmRsZXIrMHgxYy8weDJjDQo+ICAgIFsgMzQ1OC4yMzI1
MDNdWyAgICBDNV0gIGVsMWhfNjRfaXJxKzB4N2MvMHg4MA0KPiAgICBbIDM0NTguMjM2NzM2
XVsgICAgQzVdICBmcmVlX3ZtYXBfYXJlYV9ub2ZsdXNoKzB4MTA4LzB4MzljDQo+ICAgIFsg
MzQ1OC4yNDIxMjZdWyAgICBDNV0gIHJlbW92ZV92bV9hcmVhKzB4YmMvMHgxMTgNCj4gICAg
WyAzNDU4LjI0NjcxNF1bICAgIEM1XSAgdm1fcmVtb3ZlX21hcHBpbmdzKzB4NDgvMHgyYTQN
Cj4gICAgWyAzNDU4LjI1MTY1Nl1bICAgIEM1XSAgX192dW5tYXArMHgxNTQvMHgyNzgNCj4g
ICAgWyAzNDU4LjI1NTc5Nl1bICAgIEM1XSAgc3RvbGVuX3RpbWVfY3B1X2Rvd25fcHJlcGFy
ZSsweGMwLzB4ZDgNCj4gICAgWyAzNDU4LjI2MTU0Ml1bICAgIEM1XSAgY3B1aHBfaW52b2tl
X2NhbGxiYWNrKzB4MjQ4LzB4YzM0DQo+ICAgIFsgMzQ1OC4yNjY4NDJdWyAgICBDNV0gIGNw
dWhwX3RocmVhZF9mdW4rMHgxYzQvMHgyNDgNCj4gICAgWyAzNDU4LjI3MTY5Nl1bICAgIEM1
XSAgc21wYm9vdF90aHJlYWRfZm4rMHgxYjAvMHg0MDANCj4gICAgWyAzNDU4LjI3NjYzOF1b
ICAgIEM1XSAga3RocmVhZCsweDE3Yy8weDFlMA0KPiAgICBbIDM0NTguMjgwNjkxXVsgICAg
QzVdICByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0KPiANCj4gQXMgYSBmaXgsIGRpc2FibGUg
dGhlIElSUXMgZHVyaW5nIGhvdHBsdWcgdW50aWwgd2UgdW5tYXAgYW5kIG1lbXNldCB0aGUN
Cj4gc3RvbGVuIHRpbWUgc3RydWN0dXJlLg0KDQpUaGlzIHdpbGwgd29yayBmb3IgdGhlIGNh
bGwgY2hhaW4gb2YgeW91ciBvYnNlcnZlZCBjcmFzaCwgYnV0IGFyZQ0KeW91IHN1cmUgdGhh
dCBwYXJhX3N0ZWFsX2Nsb2NrKCkgY2FuJ3QgYmUgY2FsbGVkIGZyb20gYW5vdGhlciBjcHUN
CmNvbmN1cnJlbnRseT8NCg0KSW4gY2FzZSB5b3UgdmVyaWZpZWQgdGhpcyBjYW4ndCBoYXBw
ZW4sIHlvdSBjYW4gYWRkIG15Og0KDQpSZXZpZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdy
b3NzQHN1c2UuY29tPg0KDQpPdGhlcndpc2UgeW91IGVpdGhlciBuZWVkIHRvIHVzZSBSQ1Ug
Zm9yIGRvaW5nIHRoZSBtZW11bm1hcCgpLCBvciBhDQpsb2NrIHRvIHByb3RlY3Qgc3RvbGVu
X3RpbWVfcmVnaW9uLg0KDQoNCkp1ZXJnZW4NCg==
--------------tMgOFIIt5XmTj75OSWHDTEip
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------tMgOFIIt5XmTj75OSWHDTEip--

--------------qKfA015FQnKvuS8o0VgFbD8Z--

--------------7aEmFWIe6tv5DKOKFo7EYOGI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJhC10FAwAAAAAACgkQsN6d1ii/Ey+h
wggAmCL55Mzc0nEMs5HctJWJTeCtFYOtL4lowDkPWeDlKQS1UXITvc1Ql9mEcBgtP/aa7s0aAbmp
twgmzohJgr6yjx9IyORysYq5hRI6VOfGXExCXDoPdobusfUqHPdLrciKtKlJaBT5ZBnfc4rIucdG
6GRqg5hnlpC9+/bjPsphRieLKfNxmxSO2LhsVeN9uc6oQspQ00AyUq/DSgK8nr1H8ZBa7p5355KR
EwCvLRvcviAwrv2RVmnVZ3ZCOqDliyi+a7/t48HJBV0RfCx7g8umpFFIxU23VKXrX4ZUi7P8QP5j
HPuHHJaTRsQT687kp9NDNzb8Dx7D1sSljMDLLC1Yzw==
=Ytw4
-----END PGP SIGNATURE-----

--------------7aEmFWIe6tv5DKOKFo7EYOGI--

--===============9119567043912632956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9119567043912632956==--
