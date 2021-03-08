Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE0DC433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 02:53:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B28650E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 02:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B28650E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE554839BB;
	Mon,  8 Mar 2021 02:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P1zf7Ntk-Ttd; Mon,  8 Mar 2021 02:53:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7505B835EF;
	Mon,  8 Mar 2021 02:53:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E1E9C000A;
	Mon,  8 Mar 2021 02:53:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BFFFC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 02:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 88032606EF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 02:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DwgAf5_us86h
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 02:53:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7686606E9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 02:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615172015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWTExvkpL3xvnU71XBjAtEuJZDgLR8SWFyWHBwfA6EQ=;
 b=VkkWw5YKE0uMMMWKMBP5iclf7yKHesVLyE4uD+9J9OR1usNzKUgoZysMDeV4VVDvArx1wb
 U3lBvLoxyRLVnd6EE+1rBgR+ck+BkZQczPCo0/0/B5wqbFDS9biG5Zrti1AlMPCZUA7aYH
 /o5RRsSFQv5/9fzhjiT7y2E3KVCDX5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-lX5C2eSqOmOk0EQ0k1P4LQ-1; Sun, 07 Mar 2021 21:53:33 -0500
X-MC-Unique: lX5C2eSqOmOk0EQ0k1P4LQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56770100CF64;
 Mon,  8 Mar 2021 02:53:32 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-193.pek2.redhat.com
 [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A45766F988;
 Mon,  8 Mar 2021 02:53:26 +0000 (UTC)
Subject: Re: [PATCH 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-net for vDPA
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com
References: <20210305142000.18521-1-lingshan.zhu@intel.com>
 <20210305142000.18521-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e36ac9d6-2fd9-44fe-3477-ef6ddf22429a@redhat.com>
Date: Mon, 8 Mar 2021 10:53:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210305142000.18521-3-lingshan.zhu@intel.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMy81IDEwOjE5IOS4i+WNiCwgWmh1IExpbmdzaGFuIHdyb3RlOgo+IFRoaXMgY29t
bWl0IGVuYWJsZWQgSW50ZWwgRlBHQSBTbWFydE5JQyBDNTAwMFgtUEwgdmlydGlvLW5ldAo+IGZv
ciB2RFBBLgo+IEM1MDAwWC1QTCB2ZW5kb3IgaWQgMHgxQUY0LCBkZXZpY2UgaWQgMHgxMDAwLAo+
IHN1YnZlbmRvciBpZCAweDgwODYsIHN1YiBkZXZpY2UgaWQgMHgwMDAxCj4KPiBUbyBkaXN0aW5n
dWlzaCBDNTAwMFgtUEwgZnJvbSBvdGhlciBpZmN2ZiBkcml2ZW4gZGV2aWNlcywKPiB0aGUgb3Jp
Z2luYWwgaWZjdmYgZGV2aWNlIGlzIG5hbWVkICJOMzAwMCIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBa
aHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgMTMgKysrKysrKysrLS0tLQo+ICAgZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX21haW4uYyB8IDEzICsrKysrKysrKy0tLS0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMTggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jh
c2UuaAo+IGluZGV4IDY0Njk2ZDYzZmUwNy4uNzk0ZDE1MDVkODU3IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfYmFzZS5oCj4gQEAgLTE4LDEwICsxOCwxNSBAQAo+ICAgI2luY2x1ZGUgPHVhcGkvbGlu
dXgvdmlydGlvX2NvbmZpZy5oPgo+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX3BjaS5o
Pgo+ICAgCj4gLSNkZWZpbmUgSUZDVkZfVkVORE9SX0lECQkweDFBRjQKPiAtI2RlZmluZSBJRkNW
Rl9ERVZJQ0VfSUQJCTB4MTA0MQo+IC0jZGVmaW5lIElGQ1ZGX1NVQlNZU19WRU5ET1JfSUQJMHg4
MDg2Cj4gLSNkZWZpbmUgSUZDVkZfU1VCU1lTX0RFVklDRV9JRAkweDAwMUEKPiArI2RlZmluZSBO
MzAwMF9WRU5ET1JfSUQJCTB4MUFGNAo+ICsjZGVmaW5lIE4zMDAwX0RFVklDRV9JRAkJMHgxMDQx
Cj4gKyNkZWZpbmUgTjMwMDBfU1VCU1lTX1ZFTkRPUl9JRAkweDgwODYKPiArI2RlZmluZSBOMzAw
MF9TVUJTWVNfREVWSUNFX0lECTB4MDAxQQoKClBhdGNoIGxvb2tzIGdvb2QsIEkgd29uZGVyIGlm
IGl0J3MgYmV0dGVyIHRvIGRvIHRoZSByZW5hbWUgc2VwYXJhdGVseS4KClRoYW5rcwoKCj4gKwo+
ICsjZGVmaW5lIEM1MDAwWF9QTF9WRU5ET1JfSUQJCTB4MUFGNAo+ICsjZGVmaW5lIEM1MDAwWF9Q
TF9ERVZJQ0VfSUQJCTB4MTAwMAo+ICsjZGVmaW5lIEM1MDAwWF9QTF9TVUJTWVNfVkVORE9SX0lE
CTB4ODA4Ngo+ICsjZGVmaW5lIEM1MDAwWF9QTF9TVUJTWVNfREVWSUNFX0lECTB4MDAwMQo+ICAg
Cj4gICAjZGVmaW5lIElGQ1ZGX1NVUFBPUlRFRF9GRUFUVVJFUyBcCj4gICAJCSgoMVVMTCA8PCBW
SVJUSU9fTkVUX0ZfTUFDKQkJCXwgXAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IGU1
MDFlZTA3ZGUxNy4uZmQ1YmVmYzVjYmNjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4g
QEAgLTQ4MCwxMCArNDgwLDE1IEBAIHN0YXRpYyB2b2lkIGlmY3ZmX3JlbW92ZShzdHJ1Y3QgcGNp
X2RldiAqcGRldikKPiAgIH0KPiAgIAo+ICAgc3RhdGljIHN0cnVjdCBwY2lfZGV2aWNlX2lkIGlm
Y3ZmX3BjaV9pZHNbXSA9IHsKPiAtCXsgUENJX0RFVklDRV9TVUIoSUZDVkZfVkVORE9SX0lELAo+
IC0JCUlGQ1ZGX0RFVklDRV9JRCwKPiAtCQlJRkNWRl9TVUJTWVNfVkVORE9SX0lELAo+IC0JCUlG
Q1ZGX1NVQlNZU19ERVZJQ0VfSUQpIH0sCj4gKwl7IFBDSV9ERVZJQ0VfU1VCKE4zMDAwX1ZFTkRP
Ul9JRCwKPiArCQkJIE4zMDAwX0RFVklDRV9JRCwKPiArCQkJIE4zMDAwX1NVQlNZU19WRU5ET1Jf
SUQsCj4gKwkJCSBOMzAwMF9TVUJTWVNfREVWSUNFX0lEKSB9LAo+ICsJeyBQQ0lfREVWSUNFX1NV
QihDNTAwMFhfUExfVkVORE9SX0lELAo+ICsJCQkgQzUwMDBYX1BMX0RFVklDRV9JRCwKPiArCQkJ
IEM1MDAwWF9QTF9TVUJTWVNfVkVORE9SX0lELAo+ICsJCQkgQzUwMDBYX1BMX1NVQlNZU19ERVZJ
Q0VfSUQpIH0sCj4gKwo+ICAgCXsgMCB9LAo+ICAgfTsKPiAgIE1PRFVMRV9ERVZJQ0VfVEFCTEUo
cGNpLCBpZmN2Zl9wY2lfaWRzKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
