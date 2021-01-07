Return-Path: <SRS0=voLO=GK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FACC433E0
	for <virtualization@archiver.kernel.org>; Thu,  7 Jan 2021 04:16:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B431723100
	for <virtualization@archiver.kernel.org>; Thu,  7 Jan 2021 04:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B431723100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4A89D204A3;
	Thu,  7 Jan 2021 04:16:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fHwe42AmyABI; Thu,  7 Jan 2021 04:16:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 038D3203AA;
	Thu,  7 Jan 2021 04:16:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6231C0891;
	Thu,  7 Jan 2021 04:16:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B6C7C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 04:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 422E92048E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 04:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wnQd7Ph3pBTV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 04:16:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 040F8203AA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 04:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609992965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dos1Q591nOCwG8WlJAPmJhU7Mm8ZerxmXOCBcJyNvs4=;
 b=AfRxYiopwWSKsQVcv9NJxFhtdnrPXDkojo9RXzeyaiCrsR/euSTq2uToDbUGmkEkpOvFGK
 cHDbjgGpBxYhWQZl11SfL2uugOeqPU9TicyQyfGAfMo5+iZnxZtggYap8XkBb/rVIYKCzL
 I77pSCGgOjFEqWgSBePq6ciG+lxMHXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-jcuqMUzmPi2B4NMTwRptXg-1; Wed, 06 Jan 2021 23:16:04 -0500
X-MC-Unique: jcuqMUzmPi2B4NMTwRptXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABA8C10054FF;
 Thu,  7 Jan 2021 04:16:02 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B3C55C1D1;
 Thu,  7 Jan 2021 04:15:54 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Fix memory key MTT population
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20210106090557.GA170338@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2d16b2af-f25a-d786-7d24-da45c0dcefaa@redhat.com>
Date: Thu, 7 Jan 2021 12:15:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210106090557.GA170338@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: lulu@redhat.com
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

Ck9uIDIwMjEvMS82IOS4i+WNiDU6MDUsIEVsaSBDb2hlbiB3cm90ZToKPiBtYXBfZGlyZWN0X21y
KCkgYXNzdW1lZCB0aGF0IHRoZSBudW1iZXIgb2Ygc2NhdHRlci9nYXRoZXIgZW50cmllcwo+IHJl
dHVybmVkIGJ5IGRtYV9tYXBfc2dfYXR0cnMoKSB3YXMgZXF1YWwgdG8gdGhlIG51bWJlciBvZiBz
ZWdtZW50cyBpbgo+IHRoZSBzZ2wgbGlzdC4gVGhpcyBsZWQgdG8gd3JvbmcgcG9wdWxhdGlvbiBv
ZiB0aGUgbWtleSBvYmplY3QuIEZpeCB0aGlzCj4gYnkgcHJvcGVybHkgcmVmZXJyaW5nIHRvIHRo
ZSByZXR1cm5lZCB2YWx1ZS4KPgo+IEluIGFkZGl0aW9uLCBnZXQgcmlkIG9mIGZpbGxfc2coKSB3
aGppY2ggZWZmZWN0IGlzIG92ZXJ3cml0dGVuIGJ1Cj4gcG9wdWxhdGVfbXR0cygpLgoKClR5cG8u
CgoKPgo+IEZpeGVzOiA5NGFiYmNjZGYyOTEgKCJ2ZHBhL21seDU6IEFkZCBzaGFyZWQgbWVtb3J5
IHJlZ2lzdHJhdGlvbiBjb2RlIikKPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZp
ZGlhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmggfCAg
MSArCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgICAgICAgIHwgMjggKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCsp
LCAxNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3Jl
L21seDVfdmRwYS5oIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+IGluZGV4
IDVjOTJhNTc2ZWRhZS4uMDhmNzQyZmQyNDA5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9t
bHg1L2NvcmUvbWx4NV92ZHBhLmgKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVf
dmRwYS5oCj4gQEAgLTE1LDYgKzE1LDcgQEAgc3RydWN0IG1seDVfdmRwYV9kaXJlY3RfbXIgewo+
ICAgCXN0cnVjdCBzZ190YWJsZSBzZ19oZWFkOwo+ICAgCWludCBsb2dfc2l6ZTsKPiAgIAlpbnQg
bnNnOwo+ICsJaW50IG5lbnQ7Cj4gICAJc3RydWN0IGxpc3RfaGVhZCBsaXN0Owo+ICAgCXU2NCBv
ZmZzZXQ7Cj4gICB9Owo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMg
Yi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPiBpbmRleCA0YjYxOTU2NjZjNTguLmQzMDBm
Nzk5ZWZjZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPiArKysg
Yi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPiBAQCAtMjUsMTcgKzI1LDYgQEAgc3RhdGlj
IGludCBnZXRfb2N0b19sZW4odTY0IGxlbiwgaW50IHBhZ2Vfc2hpZnQpCj4gICAJcmV0dXJuIChu
cGFnZXMgKyAxKSAvIDI7Cj4gICB9Cj4gICAKPiAtc3RhdGljIHZvaWQgZmlsbF9zZyhzdHJ1Y3Qg
bWx4NV92ZHBhX2RpcmVjdF9tciAqbXIsIHZvaWQgKmluKQo+IC17Cj4gLQlzdHJ1Y3Qgc2NhdHRl
cmxpc3QgKnNnOwo+IC0JX19iZTY0ICpwYXM7Cj4gLQlpbnQgaTsKPiAtCj4gLQlwYXMgPSBNTFg1
X0FERFJfT0YoY3JlYXRlX21rZXlfaW4sIGluLCBrbG1fcGFzX210dCk7Cj4gLQlmb3JfZWFjaF9z
Zyhtci0+c2dfaGVhZC5zZ2wsIHNnLCBtci0+bnNnLCBpKQo+IC0JCSgqcGFzKSA9IGNwdV90b19i
ZTY0KHNnX2RtYV9hZGRyZXNzKHNnKSk7Cj4gLX0KPiAtCj4gICBzdGF0aWMgdm9pZCBtbHg1X3Nl
dF9hY2Nlc3NfbW9kZSh2b2lkICpta2MsIGludCBtb2RlKQo+ICAgewo+ICAgCU1MWDVfU0VUKG1r
YywgbWtjLCBhY2Nlc3NfbW9kZV8xXzAsIG1vZGUgJiAweDMpOwo+IEBAIC00NSwxMCArMzQsMTgg
QEAgc3RhdGljIHZvaWQgbWx4NV9zZXRfYWNjZXNzX21vZGUodm9pZCAqbWtjLCBpbnQgbW9kZSkK
PiAgIHN0YXRpYyB2b2lkIHBvcHVsYXRlX210dHMoc3RydWN0IG1seDVfdmRwYV9kaXJlY3RfbXIg
Km1yLCBfX2JlNjQgKm10dCkKPiAgIHsKPiAgIAlzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnOwo+ICsJ
aW50IG5zZyA9IG1yLT5uc2c7Cj4gKwl1NjQgZG1hX2FkZHI7Cj4gKwl1NjQgZG1hX2xlbjsKPiAr
CWludCBqID0gMDsKPiAgIAlpbnQgaTsKPiAgIAo+IC0JZm9yX2VhY2hfc2cobXItPnNnX2hlYWQu
c2dsLCBzZywgbXItPm5zZywgaSkKPiAtCQltdHRbaV0gPSBjcHVfdG9fYmU2NChzZ19kbWFfYWRk
cmVzcyhzZykpOwo+ICsJZm9yX2VhY2hfc2cobXItPnNnX2hlYWQuc2dsLCBzZywgbXItPm5lbnQs
IGkpIHsKPiArCQlmb3IgKGRtYV9hZGRyID0gc2dfZG1hX2FkZHJlc3Moc2cpLCBkbWFfbGVuID0g
c2dfZG1hX2xlbihzZyk7Cj4gKwkJICAgICBuc2cgJiYgZG1hX2xlbjsKPiArCQkgICAgIG5zZy0t
LCBkbWFfYWRkciArPSBCSVQobXItPmxvZ19zaXplKSwgZG1hX2xlbiAtPSBCSVQobXItPmxvZ19z
aXplKSkKPiArCQkJbXR0W2orK10gPSBjcHVfdG9fYmU2NChkbWFfYWRkcik7CgoKSXQgbG9va3Mg
dG8gbWUgdGhlIG10dCBlbnRyeSBpcyBhbHNvIGxpbWl0ZWQgYnkgbG9nX3NpemUuIEl0J3MgYmV0
dGVyIHRvIApleHBsYWluIHRoaXMgYSBsaXR0bGUgYml0IGluIHRoZSBjb21taXQgbG9nLgoKVGhh
bmtzCgoKPiArCX0KPiAgIH0KPiAgIAo+ICAgc3RhdGljIGludCBjcmVhdGVfZGlyZWN0X21yKHN0
cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IG1seDVfdmRwYV9kaXJlY3RfbXIgKm1y
KQo+IEBAIC02NCw3ICs2MSw2IEBAIHN0YXRpYyBpbnQgY3JlYXRlX2RpcmVjdF9tcihzdHJ1Y3Qg
bWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfZGlyZWN0Cj4gICAJCXJldHVy
biAtRU5PTUVNOwo+ICAgCj4gICAJTUxYNV9TRVQoY3JlYXRlX21rZXlfaW4sIGluLCB1aWQsIG12
ZGV2LT5yZXMudWlkKTsKPiAtCWZpbGxfc2cobXIsIGluKTsKPiAgIAlta2MgPSBNTFg1X0FERFJf
T0YoY3JlYXRlX21rZXlfaW4sIGluLCBtZW1vcnlfa2V5X21rZXlfZW50cnkpOwo+ICAgCU1MWDVf
U0VUKG1rYywgbWtjLCBsdywgISEobXItPnBlcm0gJiBWSE9TVF9NQVBfV08pKTsKPiAgIAlNTFg1
X1NFVChta2MsIG1rYywgbHIsICEhKG1yLT5wZXJtICYgVkhPU1RfTUFQX1JPKSk7Cj4gQEAgLTI3
Niw4ICsyNzIsOCBAQCBzdGF0aWMgaW50IG1hcF9kaXJlY3RfbXIoc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX2RpcmVjdF9tcgo+ICAgZG9uZToKPiAgIAltci0+
bG9nX3NpemUgPSBsb2dfZW50aXR5X3NpemU7Cj4gICAJbXItPm5zZyA9IG5zZzsKPiAtCWVyciA9
IGRtYV9tYXBfc2dfYXR0cnMoZG1hLCBtci0+c2dfaGVhZC5zZ2wsIG1yLT5uc2csIERNQV9CSURJ
UkVDVElPTkFMLCAwKTsKPiAtCWlmICghZXJyKQo+ICsJbXItPm5lbnQgPSBkbWFfbWFwX3NnX2F0
dHJzKGRtYSwgbXItPnNnX2hlYWQuc2dsLCBtci0+bnNnLCBETUFfQklESVJFQ1RJT05BTCwgMCk7
Cj4gKwlpZiAoIW1yLT5uZW50KQo+ICAgCQlnb3RvIGVycl9tYXA7Cj4gICAKPiAgIAllcnIgPSBj
cmVhdGVfZGlyZWN0X21yKG12ZGV2LCBtcik7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
