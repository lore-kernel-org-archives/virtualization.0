Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E62AC433EF
	for <virtualization@archiver.kernel.org>; Wed,  4 May 2022 13:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D40BC61089;
	Wed,  4 May 2022 13:38:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7UBEGT3MNia8; Wed,  4 May 2022 13:38:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33DCA61083;
	Wed,  4 May 2022 13:38:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E448EC0039;
	Wed,  4 May 2022 13:38:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60487C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 13:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 379AB4011B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 13:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WQ82W9T_w4q5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 13:38:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0319F40104
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 13:38:50 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3BF19210DB;
 Wed,  4 May 2022 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1651671528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eW6F0+Z+Xn1wQB/poLHfm3GeAwUqjVJnz/oOXcqsve4=;
 b=K7bXA5J/jV9Yx9gVuZYUipN/g8FJnC/jhPHYKwxZplYW3eAoqCTPv2+RyWEyFDvCWKGseT
 1X8RRRPXXp4DK+g1fQlph8/BwCDs43vFKQ8EUQ4v/5cTtgT0PgUkpQxv7E9wRAgUMja8cE
 31a/BDWzqCuyhDtDVl2H5b+xXxfyirI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4433132C4;
 Wed,  4 May 2022 13:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KaRuMueBcmKVfgAAMHmgww
 (envelope-from <jgross@suse.com>); Wed, 04 May 2022 13:38:47 +0000
Message-ID: <c6689e42-e87c-0c0b-c7ff-40134406e080@suse.com>
Date: Wed, 4 May 2022 15:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] arm64: paravirt: Use RCU read locks to guard
 stolen_time
Content-Language: en-US
To: Will Deacon <will@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>
References: <20220428183536.2866667-1-quic_eberman@quicinc.com>
 <20220504094507.GA20305@willie-the-truck>
In-Reply-To: <20220504094507.GA20305@willie-the-truck>
Cc: Murali Nalajala <quic_mnalajal@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Alexey Makhalov <amakhalov@vmware.com>,
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
Content-Type: multipart/mixed; boundary="===============2511037028926163799=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2511037028926163799==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------y9m9gJLa5Vt4RDFFBGXh9Myf"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------y9m9gJLa5Vt4RDFFBGXh9Myf
Content-Type: multipart/mixed; boundary="------------e93tz0yKFx5YboU7p1j0iqO0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Will Deacon <will@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>
Cc: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
 Alexey Makhalov <amakhalov@vmware.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
 virtualization@lists.linux-foundation.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Murali Nalajala <quic_mnalajal@quicinc.com>, stable@vger.kernel.org
Message-ID: <c6689e42-e87c-0c0b-c7ff-40134406e080@suse.com>
Subject: Re: [PATCH v2] arm64: paravirt: Use RCU read locks to guard
 stolen_time
References: <20220428183536.2866667-1-quic_eberman@quicinc.com>
 <20220504094507.GA20305@willie-the-truck>
In-Reply-To: <20220504094507.GA20305@willie-the-truck>

--------------e93tz0yKFx5YboU7p1j0iqO0
Content-Type: multipart/mixed; boundary="------------Z8nd2zQdKOOgh6CZUzdBfhBO"

--------------Z8nd2zQdKOOgh6CZUzdBfhBO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDUuMjIgMTE6NDUsIFdpbGwgRGVhY29uIHdyb3RlOg0KPiBPbiBUaHUsIEFwciAy
OCwgMjAyMiBhdCAxMTozNTozNkFNIC0wNzAwLCBFbGxpb3QgQmVybWFuIHdyb3RlOg0KPj4g
RnJvbTogUHJha3J1dGhpIERlZXBhayBIZXJhZ3UgPHF1aWNfcGhlcmFndUBxdWljaW5jLmNv
bT4NCj4+DQo+PiBEdXJpbmcgaG90cGx1ZywgdGhlIHN0b2xlbiB0aW1lIGRhdGEgc3RydWN0
dXJlIGlzIHVubWFwcGVkIGFuZCBtZW1zZXQuDQo+PiBUaGVyZSBpcyBhIHBvc3NpYmlsaXR5
IG9mIHRoZSB0aW1lciBJUlEgYmVpbmcgdHJpZ2dlcmVkIGJlZm9yZSBtZW1zZXQNCj4+IGFu
ZCBzdG9sZW4gdGltZSBpcyBnZXR0aW5nIHVwZGF0ZWQgYXMgcGFydCBvZiB0aGlzIHRpbWVy
IElSUSBoYW5kbGVyLiBUaGlzDQo+PiBjYXVzZXMgdGhlIGJlbG93IGNyYXNoIGluIHRpbWVy
IGhhbmRsZXIgLQ0KPj4NCj4+ICAgIFsgMzQ1Ny40NzMxMzldWyAgICBDNV0gVW5hYmxlIHRv
IGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNzIGZmZmZm
ZmMwM2RmMDUxNDgNCj4+ICAgIC4uLg0KPj4gICAgWyAzNDU4LjE1NDM5OF1bICAgIEM1XSBD
YWxsIHRyYWNlOg0KPj4gICAgWyAzNDU4LjE1NzY0OF1bICAgIEM1XSAgcGFyYV9zdGVhbF9j
bG9jaysweDMwLzB4NTANCj4+ICAgIFsgMzQ1OC4xNjIzMTldWyAgICBDNV0gIGlycXRpbWVf
YWNjb3VudF9wcm9jZXNzX3RpY2srMHgzMC8weDE5NA0KPj4gICAgWyAzNDU4LjE2ODE0OF1b
ICAgIEM1XSAgYWNjb3VudF9wcm9jZXNzX3RpY2srMHgzYy8weDI4MA0KPj4gICAgWyAzNDU4
LjE3MzI3NF1bICAgIEM1XSAgdXBkYXRlX3Byb2Nlc3NfdGltZXMrMHg1Yy8weGY0DQo+PiAg
ICBbIDM0NTguMTc4MzExXVsgICAgQzVdICB0aWNrX3NjaGVkX3RpbWVyKzB4MTgwLzB4Mzg0
DQo+PiAgICBbIDM0NTguMTgzMTY0XVsgICAgQzVdICBfX3J1bl9ocnRpbWVyKzB4MTYwLzB4
NTdjDQo+PiAgICBbIDM0NTguMTg3NzQ0XVsgICAgQzVdICBocnRpbWVyX2ludGVycnVwdCsw
eDI1OC8weDY4NA0KPj4gICAgWyAzNDU4LjE5MjY5OF1bICAgIEM1XSAgYXJjaF90aW1lcl9o
YW5kbGVyX3ZpcnQrMHg1Yy8weGEwDQo+PiAgICBbIDM0NTguMTk4MDAyXVsgICAgQzVdICBo
YW5kbGVfcGVyY3B1X2RldmlkX2lycSsweGRjLzB4NDE0DQo+PiAgICBbIDM0NTguMjAzMzg1
XVsgICAgQzVdICBoYW5kbGVfZG9tYWluX2lycSsweGE4LzB4MTY4DQo+PiAgICBbIDM0NTgu
MjA4MjQxXVsgICAgQzVdICBnaWNfaGFuZGxlX2lycS4zNDQ5MysweDU0LzB4MjQ0DQo+PiAg
ICBbIDM0NTguMjEzMzU5XVsgICAgQzVdICBjYWxsX29uX2lycV9zdGFjaysweDQwLzB4NzAN
Cj4+ICAgIFsgMzQ1OC4yMTgxMjVdWyAgICBDNV0gIGRvX2ludGVycnVwdF9oYW5kbGVyKzB4
NjAvMHg5Yw0KPj4gICAgWyAzNDU4LjIyMzE1Nl1bICAgIEM1XSAgZWwxX2ludGVycnVwdCsw
eDM0LzB4NjQNCj4+ICAgIFsgMzQ1OC4yMjc1NjBdWyAgICBDNV0gIGVsMWhfNjRfaXJxX2hh
bmRsZXIrMHgxYy8weDJjDQo+PiAgICBbIDM0NTguMjMyNTAzXVsgICAgQzVdICBlbDFoXzY0
X2lycSsweDdjLzB4ODANCj4+ICAgIFsgMzQ1OC4yMzY3MzZdWyAgICBDNV0gIGZyZWVfdm1h
cF9hcmVhX25vZmx1c2grMHgxMDgvMHgzOWMNCj4+ICAgIFsgMzQ1OC4yNDIxMjZdWyAgICBD
NV0gIHJlbW92ZV92bV9hcmVhKzB4YmMvMHgxMTgNCj4+ICAgIFsgMzQ1OC4yNDY3MTRdWyAg
ICBDNV0gIHZtX3JlbW92ZV9tYXBwaW5ncysweDQ4LzB4MmE0DQo+PiAgICBbIDM0NTguMjUx
NjU2XVsgICAgQzVdICBfX3Z1bm1hcCsweDE1NC8weDI3OA0KPj4gICAgWyAzNDU4LjI1NTc5
Nl1bICAgIEM1XSAgc3RvbGVuX3RpbWVfY3B1X2Rvd25fcHJlcGFyZSsweGMwLzB4ZDgNCj4+
ICAgIFsgMzQ1OC4yNjE1NDJdWyAgICBDNV0gIGNwdWhwX2ludm9rZV9jYWxsYmFjaysweDI0
OC8weGMzNA0KPj4gICAgWyAzNDU4LjI2Njg0Ml1bICAgIEM1XSAgY3B1aHBfdGhyZWFkX2Z1
bisweDFjNC8weDI0OA0KPj4gICAgWyAzNDU4LjI3MTY5Nl1bICAgIEM1XSAgc21wYm9vdF90
aHJlYWRfZm4rMHgxYjAvMHg0MDANCj4+ICAgIFsgMzQ1OC4yNzY2MzhdWyAgICBDNV0gIGt0
aHJlYWQrMHgxN2MvMHgxZTANCj4+ICAgIFsgMzQ1OC4yODA2OTFdWyAgICBDNV0gIHJldF9m
cm9tX2ZvcmsrMHgxMC8weDIwDQo+Pg0KPj4gQXMgYSBmaXgsIGludHJvZHVjZSByY3UgbG9j
ayB0byB1cGRhdGUgc3RvbGVuIHRpbWUgc3RydWN0dXJlLg0KPj4NCj4+IEZpeGVzOiA3NWRm
NTI5YmVjOTEgKCJhcm02NDogcGFyYXZpcnQ6IEluaXRpYWxpemUgc3RlYWwgdGltZSB3aGVu
IGNwdSBpcyBvbmxpbmUiKQ0KPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IFNp
Z25lZC1vZmYtYnk6IFByYWtydXRoaSBEZWVwYWsgSGVyYWd1IDxxdWljX3BoZXJhZ3VAcXVp
Y2luYy5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBFbGxpb3QgQmVybWFuIDxxdWljX2ViZXJt
YW5AcXVpY2luYy5jb20+DQo+PiAtLS0NCj4+IENoYW5nZXMgc2luY2UgdjE6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDQyMDIwNDQxNy4xNTUxOTQtMS1xdWljX2ViZXJt
YW5AcXVpY2luYy5jb20vDQo+PiAgIC0gVXNlIFJDVSBpbnN0ZWFkIG9mIGRpc2FibGluZyBp
bnRlcnJ1cHRzDQo+Pg0KPj4gICBhcmNoL2FybTY0L2tlcm5lbC9wYXJhdmlydC5jIHwgMjQg
KysrKysrKysrKysrKysrKysrKy0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2tlcm5lbC9wYXJhdmlydC5jIGIvYXJjaC9hcm02NC9rZXJuZWwvcGFyYXZpcnQuYw0K
Pj4gaW5kZXggNzVmZWQ0NDYwNDA3Li5lNzI0ZWEzZDg2ZjAgMTAwNjQ0DQo+PiAtLS0gYS9h
cmNoL2FybTY0L2tlcm5lbC9wYXJhdmlydC5jDQo+PiArKysgYi9hcmNoL2FybTY0L2tlcm5l
bC9wYXJhdmlydC5jDQo+PiBAQCAtNTIsNyArNTIsOSBAQCBlYXJseV9wYXJhbSgibm8tc3Rl
YWwtYWNjIiwgcGFyc2Vfbm9fc3RlYWxhY2MpOw0KPj4gICAvKiByZXR1cm4gc3RvbGVuIHRp
bWUgaW4gbnMgYnkgYXNraW5nIHRoZSBoeXBlcnZpc29yICovDQo+PiAgIHN0YXRpYyB1NjQg
cGFyYV9zdGVhbF9jbG9jayhpbnQgY3B1KQ0KPj4gICB7DQo+PiArCXN0cnVjdCBwdmNsb2Nr
X3ZjcHVfc3RvbGVuX3RpbWUgKmthZGRyID0gTlVMTDsNCj4+ICAgCXN0cnVjdCBwdl90aW1l
X3N0b2xlbl90aW1lX3JlZ2lvbiAqcmVnOw0KPj4gKwl1NjQgcmV0ID0gMDsNCj4+ICAgDQo+
PiAgIAlyZWcgPSBwZXJfY3B1X3B0cigmc3RvbGVuX3RpbWVfcmVnaW9uLCBjcHUpOw0KPj4g
ICANCj4+IEBAIC02MSwyOCArNjMsMzggQEAgc3RhdGljIHU2NCBwYXJhX3N0ZWFsX2Nsb2Nr
KGludCBjcHUpDQo+PiAgIAkgKiBvbmxpbmUgbm90aWZpY2F0aW9uIGNhbGxiYWNrIHJ1bnMu
IFVudGlsIHRoZSBjYWxsYmFjaw0KPj4gICAJICogaGFzIHJ1biB3ZSBqdXN0IHJldHVybiB6
ZXJvLg0KPj4gICAJICovDQo+PiAtCWlmICghcmVnLT5rYWRkcikNCj4+ICsJcmN1X3JlYWRf
bG9jaygpOw0KPj4gKwlrYWRkciA9IHJjdV9kZXJlZmVyZW5jZShyZWctPmthZGRyKTsNCj4+
ICsJaWYgKCFrYWRkcikgew0KPj4gKwkJcmN1X3JlYWRfdW5sb2NrKCk7DQo+PiAgIAkJcmV0
dXJuIDA7DQo+PiArCX0NCj4+ICAgDQo+PiAtCXJldHVybiBsZTY0X3RvX2NwdShSRUFEX09O
Q0UocmVnLT5rYWRkci0+c3RvbGVuX3RpbWUpKTsNCj4+ICsJcmV0ID0gbGU2NF90b19jcHUo
UkVBRF9PTkNFKGthZGRyLT5zdG9sZW5fdGltZSkpOw0KPiANCj4gSXMgdGhpcyBSRUFEX09O
Q0UoKSBzdGlsbCByZXF1aXJlZCBub3c/DQoNClllcywgYXMgaXQgbWlnaHQgYmUgY2FsbGVk
IGZvciBhbm90aGVyIGNwdSB0aGFuIHRoZSBjdXJyZW50IG9uZS4NCnN0b2xlbl90aW1lIG1p
Z2h0IGp1c3QgYmUgdXBkYXRlZCwgc28geW91IHdhbnQgdG8gYXZvaWQgbG9hZCB0ZWFyaW5n
Lg0KDQoNCkp1ZXJnZW4NCg==
--------------Z8nd2zQdKOOgh6CZUzdBfhBO
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Z8nd2zQdKOOgh6CZUzdBfhBO--

--------------e93tz0yKFx5YboU7p1j0iqO0--

--------------y9m9gJLa5Vt4RDFFBGXh9Myf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJygecFAwAAAAAACgkQsN6d1ii/Ey/R
Hwf+NxZJQfciFlEObq6a4Lwl+SXgZn4bIazWw3uujhllZIVcLF4pPjm5JCEk3HdHXpQvsCA8XKys
o7hpVdGW7qt8RQEdRMEcs+wtPQFmDLn+HuZT1ZnPn2r+BNIKhxB6T91YncDMERzYoEI7OOgI5enG
7ijxHbkQnaR4ybfgJ6od/KSTw1H0dsPk6GOKcms9Etp3zv6TzdeM72V83Z3Ngy1Dvgyw/ScqezUW
EQiDJKnJth9J6Q9zqj2ayvdWRPZZ/fOi7BDF2QgtmYmfbD8EVkC5GjFF8wcQS1DhvBKfTOBvxGDV
7XX2YKUbBXaTusU3xeT83oRt1wfMzWRp0Gt7Qk2FUQ==
=5umt
-----END PGP SIGNATURE-----

--------------y9m9gJLa5Vt4RDFFBGXh9Myf--

--===============2511037028926163799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2511037028926163799==--
