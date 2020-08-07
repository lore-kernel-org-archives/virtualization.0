Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383ECC433E0
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:37:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120802086A
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/WafUrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120802086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C0404871F3;
	Fri,  7 Aug 2020 03:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OrfflJiZjk4B; Fri,  7 Aug 2020 03:37:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 78893871D0;
	Fri,  7 Aug 2020 03:37:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68598C0050;
	Fri,  7 Aug 2020 03:37:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3088C004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 99A0A88663
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cq-z7620eUbJ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:37:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E7FEC8865E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596771455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJmVwYKYH9OYU5nifyyFiwbUHIzwYs48cjjAmAqd4Ak=;
 b=D/WafUrZDE/FeyZO6hjOx9jIvJ0ZOr1KQ5E2w3Y9cdp9BCE6+tZ/t5XSH5UYwLq30lBNtT
 uykituP9V5VTZFvthnp/AaXbikgTpAWJGmiIOEHmxjrdZUO3BLHRF1R3x8s8jMShV3JOZw
 PjyOynnxXnbAGTuL/RX2gCROooRGL4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-3YYVa6ZLPMigqQOdgYyetg-1; Thu, 06 Aug 2020 23:37:34 -0400
X-MC-Unique: 3YYVa6ZLPMigqQOdgYyetg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA2B98017FB;
 Fri,  7 Aug 2020 03:37:32 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F27FC2DE8C;
 Fri,  7 Aug 2020 03:37:26 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Fix erroneous null pointer checks
To: Alex Dewar <alex.dewar90@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20200806191849.82189-1-alex.dewar90@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a1fb552a-bd5c-d7a2-7eae-d787cc61ec73@redhat.com>
Date: Fri, 7 Aug 2020 11:37:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806191849.82189-1-alex.dewar90@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjAvOC83IOS4iuWNiDM6MTgsIEFsZXggRGV3YXIgd3JvdGU6Cj4gSW4gYWxsb2NfaW5v
dXQoKSBpbiBuZXQvbWx4NV92bmV0LmMsIHRoZXJlIGFyZSBhIGZldyBwbGFjZXMgd2hlcmUgbWVt
b3J5Cj4gaXMgYWxsb2NhdGVkIHRvICppbiBhbmQgKm91dCwgYnV0IG9ubHkgdGhlIHZhbHVlcyBv
ZiBpbiBhbmQgb3V0IGFyZQo+IG51bGwtY2hlY2tlZCAoaS5lLiB0aGVyZSBpcyBhIG1pc3Npbmcg
ZGVyZWZlcmVuY2UpLiBGaXggdGhpcy4KPgo+IEFkZHJlc3Nlcy1Db3Zlcml0eTogKCJDSUQgMTQ5
NjYwMzogKFJFVkVSU0VfSU5VTEwpIikKPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1
OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmljZXMiKQo+IFNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV3YXIgPGFsZXguZGV3YXI5MEBnbWFpbC5jb20+CgoKQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYyB8IDggKysrKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
Cj4gaW5kZXggM2VjNDRhNGYwZTQ1Li5iY2I2NjAwYzI4MzkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jCj4gQEAgLTg2Nyw3ICs4NjcsNyBAQCBzdGF0aWMgdm9pZCBhbGxvY19pbm91
dChzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgaW50IGNtZCwgdm9pZCAqKmluLCBpbnQgKmlu
bAo+ICAgCQkqb3V0bGVuID0gTUxYNV9TVF9TWl9CWVRFUyhxcF8ycnN0X291dCk7Cj4gICAJCSpp
biA9IGt6YWxsb2MoKmlubGVuLCBHRlBfS0VSTkVMKTsKPiAgIAkJKm91dCA9IGt6YWxsb2MoKm91
dGxlbiwgR0ZQX0tFUk5FTCk7Cj4gLQkJaWYgKCFpbiB8fCAhb3V0KQo+ICsJCWlmICghKmluIHx8
ICEqb3V0KQo+ICAgCQkJZ290byBvdXRlcnI7Cj4gICAKPiAgIAkJTUxYNV9TRVQocXBfMnJzdF9p
biwgKmluLCBvcGNvZGUsIGNtZCk7Cj4gQEAgLTg3OSw3ICs4NzksNyBAQCBzdGF0aWMgdm9pZCBh
bGxvY19pbm91dChzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgaW50IGNtZCwgdm9pZCAqKmlu
LCBpbnQgKmlubAo+ICAgCQkqb3V0bGVuID0gTUxYNV9TVF9TWl9CWVRFUyhyc3QyaW5pdF9xcF9v
dXQpOwo+ICAgCQkqaW4gPSBremFsbG9jKCppbmxlbiwgR0ZQX0tFUk5FTCk7Cj4gICAJCSpvdXQg
PSBremFsbG9jKE1MWDVfU1RfU1pfQllURVMocnN0MmluaXRfcXBfb3V0KSwgR0ZQX0tFUk5FTCk7
Cj4gLQkJaWYgKCFpbiB8fCAhb3V0KQo+ICsJCWlmICghKmluIHx8ICEqb3V0KQo+ICAgCQkJZ290
byBvdXRlcnI7Cj4gICAKPiAgIAkJTUxYNV9TRVQocnN0MmluaXRfcXBfaW4sICppbiwgb3Bjb2Rl
LCBjbWQpOwo+IEBAIC04OTYsNyArODk2LDcgQEAgc3RhdGljIHZvaWQgYWxsb2NfaW5vdXQoc3Ry
dWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIGludCBjbWQsIHZvaWQgKippbiwgaW50ICppbmwKPiAg
IAkJKm91dGxlbiA9IE1MWDVfU1RfU1pfQllURVMoaW5pdDJydHJfcXBfb3V0KTsKPiAgIAkJKmlu
ID0ga3phbGxvYygqaW5sZW4sIEdGUF9LRVJORUwpOwo+ICAgCQkqb3V0ID0ga3phbGxvYyhNTFg1
X1NUX1NaX0JZVEVTKGluaXQycnRyX3FwX291dCksIEdGUF9LRVJORUwpOwo+IC0JCWlmICghaW4g
fHwgIW91dCkKPiArCQlpZiAoISppbiB8fCAhKm91dCkKPiAgIAkJCWdvdG8gb3V0ZXJyOwo+ICAg
Cj4gICAJCU1MWDVfU0VUKGluaXQycnRyX3FwX2luLCAqaW4sIG9wY29kZSwgY21kKTsKPiBAQCAt
OTE0LDcgKzkxNCw3IEBAIHN0YXRpYyB2b2lkIGFsbG9jX2lub3V0KHN0cnVjdCBtbHg1X3ZkcGFf
bmV0ICpuZGV2LCBpbnQgY21kLCB2b2lkICoqaW4sIGludCAqaW5sCj4gICAJCSpvdXRsZW4gPSBN
TFg1X1NUX1NaX0JZVEVTKHJ0cjJydHNfcXBfb3V0KTsKPiAgIAkJKmluID0ga3phbGxvYygqaW5s
ZW4sIEdGUF9LRVJORUwpOwo+ICAgCQkqb3V0ID0ga3phbGxvYyhNTFg1X1NUX1NaX0JZVEVTKHJ0
cjJydHNfcXBfb3V0KSwgR0ZQX0tFUk5FTCk7Cj4gLQkJaWYgKCFpbiB8fCAhb3V0KQo+ICsJCWlm
ICghKmluIHx8ICEqb3V0KQo+ICAgCQkJZ290byBvdXRlcnI7Cj4gICAKPiAgIAkJTUxYNV9TRVQo
cnRyMnJ0c19xcF9pbiwgKmluLCBvcGNvZGUsIGNtZCk7CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
