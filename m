Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A3BC433FE
	for <virtualization@archiver.kernel.org>; Thu, 24 Nov 2022 10:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F7CE60BA4;
	Thu, 24 Nov 2022 10:19:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F7CE60BA4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=Lth4PKmQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6rKkbosV8Cl; Thu, 24 Nov 2022 10:18:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9458860A99;
	Thu, 24 Nov 2022 10:18:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9458860A99
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76AA3C0032;
	Thu, 24 Nov 2022 10:18:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B533C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 10:18:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53C2C60AB2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 10:18:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53C2C60AB2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PB5NYtwXaz4R
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 10:18:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60B7A60A99
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60B7A60A99
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 10:18:56 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC31C1F38D;
 Thu, 24 Nov 2022 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1669285133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=97S4ahK6c6GndTkyMp+ciaDHona2WsuMNuBousGbepQ=;
 b=Lth4PKmQEXVOx7hCwmjqe1fGrbi9hhUrfoXUJ/Ok2pC6WaPogh6r0SDH0o5RUCgi81QWIX
 A6SPadfcmrrmj99dwIA+nGSQf8t0LlRnKHzb8mkbdJBONSNqW1Noyhk/VJNjACa0XUZne5
 f3Q9DfHXNiKGBqsyLDwuglVLZWYZOJc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3078313488;
 Thu, 24 Nov 2022 10:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d5xPCg1Ff2NuPQAAMHmgww
 (envelope-from <jgross@suse.com>); Thu, 24 Nov 2022 10:18:53 +0000
Message-ID: <aa4c49a6-65f2-d04c-ee0d-afb9e1262dea@suse.com>
Date: Thu, 24 Nov 2022 11:18:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Hou Wenlong <houwenlong.hwl@antgroup.com>, linux-kernel@vger.kernel.org
References: <d0fb2176864ed7883b0e53353b663158df2f61d6.1669279198.git.houwenlong.hwl@antgroup.com>
Subject: Re: [PATCH] x86/paravirt: Use relative reference for original
 instruction
In-Reply-To: <d0fb2176864ed7883b0e53353b663158df2f61d6.1669279198.git.houwenlong.hwl@antgroup.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alexey Makhalov <amakhalov@vmware.com>, Nadav Amit <namit@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============9132185596937661742=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============9132185596937661742==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3ifzZ7rl0JstlqL3mi0euoCZ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3ifzZ7rl0JstlqL3mi0euoCZ
Content-Type: multipart/mixed; boundary="------------eLhx0QDCutmQdIPRWPkjhd5n";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>, linux-kernel@vger.kernel.org
Cc: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
 Nadav Amit <namit@vmware.com>, virtualization@lists.linux-foundation.org
Message-ID: <aa4c49a6-65f2-d04c-ee0d-afb9e1262dea@suse.com>
Subject: Re: [PATCH] x86/paravirt: Use relative reference for original
 instruction
References: <d0fb2176864ed7883b0e53353b663158df2f61d6.1669279198.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <d0fb2176864ed7883b0e53353b663158df2f61d6.1669279198.git.houwenlong.hwl@antgroup.com>

--------------eLhx0QDCutmQdIPRWPkjhd5n
Content-Type: multipart/mixed; boundary="------------9DgS8yNYLkxlYXvTfp04VtoY"

--------------9DgS8yNYLkxlYXvTfp04VtoY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjIgMDk6NTEsIEhvdSBXZW5sb25nIHdyb3RlOg0KPiBTaW1pbGFyIHRvIHRo
ZSBhbHRlcm5hdGl2ZSBwYXRjaGluZywgdXNlIHJlbGF0aXZlIHJlZmVyZW5jZSBmb3Igb3Jp
Z2luYWwNCj4gaW5zdHJ1Y3Rpb24gcmF0aGVyIHRoYW4gYWJzb2x1dGUgb25lLCB3aGljaCBz
YXZlcyA4IGJ5dGVzIGZvciBvbmUgZW50cnkNCj4gb24geDg2XzY0LiAgQW5kIGl0IGNvdWxk
IGdlbmVyYXRlIFJfWDg2XzY0X1BDMzIgcmVsb2NhdGlvbiBpbnN0ZWFkIG9mDQoNCjggYnl0
ZXMgc2F2ZWQ/IEkgdGhpbmsgdGhvc2UgYXJlIDQgYnl0ZXMgb25seS4NCg0KPiBSX1g4Nl82
NF82NCByZWxvY2F0aW9uLCB3aGljaCBhbHNvIHJlZHVjZXMgcmVsb2NhdGlvbiBtZXRhZGF0
YSBvbg0KPiByZWxvY2F0YWJsZSBidWlsZHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIb3Ug
V2VubG9uZyA8aG91d2VubG9uZy5od2xAYW50Z3JvdXAuY29tPg0KPiAtLS0NCj4gICBhcmNo
L3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydC5oICAgICAgIHwgNiArKystLS0NCj4gICBhcmNo
L3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydF90eXBlcy5oIHwgNCArKy0tDQo+ICAgYXJjaC94
ODYva2VybmVsL2FsdGVybmF0aXZlLmMgICAgICAgICB8IDggKysrKystLS0NCj4gICAzIGZp
bGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaCBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3BhcmF2aXJ0LmgNCj4gaW5kZXggMjg1MWJjMjMzOWQ1Li4yY2JlOWI2
NGUxMDMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0LmgN
Cj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaA0KPiBAQCAtNzM1LDEz
ICs3MzUsMTMgQEAgZXh0ZXJuIHZvaWQgZGVmYXVsdF9iYW5uZXIodm9pZCk7DQo+ICAgDQo+
ICAgI2Vsc2UgIC8qIF9fQVNTRU1CTFlfXyAqLw0KPiAgIA0KPiAtI2RlZmluZSBfUFZTSVRF
KHB0eXBlLCBvcHMsIHdvcmQsIGFsZ24pCQlcDQo+ICsjZGVmaW5lIF9QVlNJVEUocHR5cGUs
IG9wcywgYWxnbikJCVwNCg0KV291bGQgeW91IHBsZWFzZSBkcm9wIHRoZSBhbGduIHBhcmFt
ZXRlciwgdG9vPyBJdCBpc24ndCBuZWVkZWQgYW55bW9yZQ0KYXMgdGhlIGFsaWdubWVudCBj
YW4gYmUgaGFyZCBjb2RlZCB0byBiZSA0IG5vdy4gVGhpcyB3b3VsZCBuZWVkIHRvIGJlDQph
ZGp1c3RlZCBpbiB0aGUgX3BhcmF2aXJ0X2FsdCgpIG1hY3JvLCB0b28uDQoNCj4gICA3NzE6
OwkJCQkJCVwNCj4gICAJb3BzOwkJCQkJXA0KPiAgIDc3Mjo7CQkJCQkJXA0KPiAgIAkucHVz
aHNlY3Rpb24gLnBhcmFpbnN0cnVjdGlvbnMsImEiOwlcDQo+ICAgCSAuYWxpZ24JYWxnbjsJ
CQkJXA0KPiAtCSB3b3JkIDc3MWI7CQkJCVwNCj4gKwkgLmxvbmcgNzcxYi0uOwkJCQlcDQo+
ICAgCSAuYnl0ZSBwdHlwZTsJCQkJXA0KPiAgIAkgLmJ5dGUgNzcyYi03NzFiOwkJCVwNCj4g
ICAJIF9BU01fQUxJR047CQkJCVwNCj4gQEAgLTc1Miw3ICs3NTIsNyBAQCBleHRlcm4gdm9p
ZCBkZWZhdWx0X2Jhbm5lcih2b2lkKTsNCj4gICAjaWZkZWYgQ09ORklHX1BBUkFWSVJUX1hY
TA0KPiAgIA0KPiAgICNkZWZpbmUgUEFSQV9QQVRDSChvZmYpCQkoKG9mZikgLyA4KQ0KPiAt
I2RlZmluZSBQQVJBX1NJVEUocHR5cGUsIG9wcykJX1BWU0lURShwdHlwZSwgb3BzLCAucXVh
ZCwgOCkNCj4gKyNkZWZpbmUgUEFSQV9TSVRFKHB0eXBlLCBvcHMpCV9QVlNJVEUocHR5cGUs
IG9wcywgOCkNCj4gICAjZGVmaW5lIFBBUkFfSU5ESVJFQ1QoYWRkcikJKmFkZHIoJXJpcCkN
Cj4gICANCj4gICAjaWZkZWYgQ09ORklHX0RFQlVHX0VOVFJZDQo+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydF90eXBlcy5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vcGFyYXZpcnRfdHlwZXMuaA0KPiBpbmRleCA4YzFkYTQxOTI2MGYuLjE5ZjcwOWNm
N2RmOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnRfdHlw
ZXMuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydF90eXBlcy5oDQo+
IEBAIC01LDcgKzUsNyBAQA0KPiAgICNpZm5kZWYgX19BU1NFTUJMWV9fDQo+ICAgLyogVGhl
c2UgYWxsIHNpdCBpbiB0aGUgLnBhcmFpbnN0cnVjdGlvbnMgc2VjdGlvbiB0byB0ZWxsIHVz
IHdoYXQgdG8gcGF0Y2guICovDQo+ICAgc3RydWN0IHBhcmF2aXJ0X3BhdGNoX3NpdGUgew0K
PiAtCXU4ICppbnN0cjsJCS8qIG9yaWdpbmFsIGluc3RydWN0aW9ucyAqLw0KPiArCXMzMiBp
bnN0cl9vZmZzZXQ7CS8qIG9yaWdpbmFsIGluc3RydWN0aW9ucyAqLw0KPiAgIAl1OCB0eXBl
OwkJLyogdHlwZSBvZiB0aGlzIGluc3RydWN0aW9uICovDQo+ICAgCXU4IGxlbjsJCQkvKiBs
ZW5ndGggb2Ygb3JpZ2luYWwgaW5zdHJ1Y3Rpb24gKi8NCj4gICB9Ow0KPiBAQCAtMjc0LDcg
KzI3NCw3IEBAIGV4dGVybiBzdHJ1Y3QgcGFyYXZpcnRfcGF0Y2hfdGVtcGxhdGUgcHZfb3Bz
Ow0KPiAgIAkiNzcxOlxuXHQiIGluc25fc3RyaW5nICJcbiIgIjc3MjpcbiIJCVwNCj4gICAJ
Ii5wdXNoc2VjdGlvbiAucGFyYWluc3RydWN0aW9ucyxcImFcIlxuIglcDQo+ICAgCV9BU01f
QUxJR04gIlxuIgkJCQkJXA0KPiAtCV9BU01fUFRSICIgNzcxYlxuIgkJCQlcDQo+ICsJIiAg
LmxvbmcgNzcxYi0uXG4iCQkJCVwNCj4gICAJIiAgLmJ5dGUgIiB0eXBlICJcbiIJCQkJXA0K
PiAgIAkiICAuYnl0ZSA3NzJiLTc3MWJcbiIJCQkJXA0KPiAgIAlfQVNNX0FMSUdOICJcbiIJ
CQkJCVwNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jIGIv
YXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMNCj4gaW5kZXggMTExYjgwOWYwYWMyLi42
ZWVhNTYzYTA5OGQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2
ZS5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+IEBAIC0xMjMy
LDIwICsxMjMyLDIyIEBAIHZvaWQgX19pbml0X29yX21vZHVsZSBhcHBseV9wYXJhdmlydChz
dHJ1Y3QgcGFyYXZpcnRfcGF0Y2hfc2l0ZSAqc3RhcnQsDQo+ICAgew0KPiAgIAlzdHJ1Y3Qg
cGFyYXZpcnRfcGF0Y2hfc2l0ZSAqcDsNCj4gICAJY2hhciBpbnNuX2J1ZmZbTUFYX1BBVENI
X0xFTl07DQo+ICsJdTggKmluc3RyOw0KPiAgIA0KPiAgIAlmb3IgKHAgPSBzdGFydDsgcCA8
IGVuZDsgcCsrKSB7DQo+ICAgCQl1bnNpZ25lZCBpbnQgdXNlZDsNCj4gICANCj4gKwkJaW5z
dHIgPSAodTggKikmcC0+aW5zdHJfb2Zmc2V0ICsgcC0+aW5zdHJfb2Zmc2V0Ow0KPiAgIAkJ
QlVHX09OKHAtPmxlbiA+IE1BWF9QQVRDSF9MRU4pOw0KPiAgIAkJLyogcHJlcCB0aGUgYnVm
ZmVyIHdpdGggdGhlIG9yaWdpbmFsIGluc3RydWN0aW9ucyAqLw0KPiAtCQltZW1jcHkoaW5z
bl9idWZmLCBwLT5pbnN0ciwgcC0+bGVuKTsNCj4gLQkJdXNlZCA9IHBhcmF2aXJ0X3BhdGNo
KHAtPnR5cGUsIGluc25fYnVmZiwgKHVuc2lnbmVkIGxvbmcpcC0+aW5zdHIsIHAtPmxlbik7
DQo+ICsJCW1lbWNweShpbnNuX2J1ZmYsIGluc3RyLCBwLT5sZW4pOw0KPiArCQl1c2VkID0g
cGFyYXZpcnRfcGF0Y2gocC0+dHlwZSwgaW5zbl9idWZmLCAodW5zaWduZWQgbG9uZylpbnN0
ciwgcC0+bGVuKTsNCj4gICANCj4gICAJCUJVR19PTih1c2VkID4gcC0+bGVuKTsNCj4gICAN
Cj4gICAJCS8qIFBhZCB0aGUgcmVzdCB3aXRoIG5vcHMgKi8NCj4gICAJCWFkZF9ub3BzKGlu
c25fYnVmZiArIHVzZWQsIHAtPmxlbiAtIHVzZWQpOw0KPiAtCQl0ZXh0X3Bva2VfZWFybHko
cC0+aW5zdHIsIGluc25fYnVmZiwgcC0+bGVuKTsNCj4gKwkJdGV4dF9wb2tlX2Vhcmx5KGlu
c3RyLCBpbnNuX2J1ZmYsIHAtPmxlbik7DQo+ICAgCX0NCj4gICB9DQo+ICAgZXh0ZXJuIHN0
cnVjdCBwYXJhdmlydF9wYXRjaF9zaXRlIF9fc3RhcnRfcGFyYWluc3RydWN0aW9uc1tdLA0K
DQoNCkp1ZXJnZW4NCg==
--------------9DgS8yNYLkxlYXvTfp04VtoY
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------9DgS8yNYLkxlYXvTfp04VtoY--

--------------eLhx0QDCutmQdIPRWPkjhd5n--

--------------3ifzZ7rl0JstlqL3mi0euoCZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmN/RQwFAwAAAAAACgkQsN6d1ii/Ey9d
Ggf/XTHWYiL2BGFHbxethMBbinnZI4vYIXQvPGhew5MskoXBGS3Gq7cf2NiM7oDEMqwTH/yxV38Z
jatxJeAgrMAtuRZeLH/dNZEHvvkjl0r2id6dZw/7hgOBI+AZxHymBVee+/9/0ypcWb3fM8l1O2j5
ggK741igoG9zO+I2VImF4xKaSdlIaWJxhm6ozJy/eocj6wL0Sy6tfMX38CDCJm1/MGfp/yn47T7D
cGNyE2nImSIqxAIenodB7sjejn33ryhVALhFF/jXFo+LmgOmtAeKk/n2WTCeBfSmhd97h61e9gOm
y4a/VKL/xzrPBZJzb898rT8mjM14sZuoRp/fjTebRQ==
=vKCV
-----END PGP SIGNATURE-----

--------------3ifzZ7rl0JstlqL3mi0euoCZ--

--===============9132185596937661742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9132185596937661742==--
