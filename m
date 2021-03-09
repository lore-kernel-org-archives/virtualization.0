Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E41C433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 02:24:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECEEA6527B
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 02:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEEA6527B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6B6540157;
	Tue,  9 Mar 2021 02:24:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00JR2LhNSoaI; Tue,  9 Mar 2021 02:24:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6350D40155;
	Tue,  9 Mar 2021 02:24:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4984FC000B;
	Tue,  9 Mar 2021 02:24:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78815C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5AB1C60701
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VjsBFlG3m5LY
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:24:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A20BA605CC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615256684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMGDh/tM/ZzBGLY6JnLbTtw7r7X8XSbA7HZppr+O/eA=;
 b=AwZCumT3j6rwu+wZlUCnp+GkjhPWgwZkpNmQ5mkEl/g1ZqWynpqPAXS9DzSQc5bnorFYK0
 N/+8/MR15t7x2am5qGxT7CabqRTTpyrSbB3/gDaMsA6JMHnx/0TWyzy0AntfMH8IjAy/XG
 cbiLw+maUM1NkXT9PKlnHBvrRh0Snrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-80li3uNSOpSACzg98jN-JQ-1; Mon, 08 Mar 2021 21:24:43 -0500
X-MC-Unique: 80li3uNSOpSACzg98jN-JQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03B778042C3;
 Tue,  9 Mar 2021 02:24:42 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-202.pek2.redhat.com
 [10.72.13.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8159E5D9CD;
 Tue,  9 Mar 2021 02:24:36 +0000 (UTC)
Subject: Re: [PATCH V2 3/4] vDPA/ifcvf: rename original IFCVF dev ids to N3000
 ids
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com
References: <20210308083525.382514-1-lingshan.zhu@intel.com>
 <20210308083525.382514-4-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <75863302-b395-7551-6cb6-6ae327c6ce71@redhat.com>
Date: Tue, 9 Mar 2021 10:24:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210308083525.382514-4-lingshan.zhu@intel.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjEvMy84IDQ6MzUg5LiL5Y2ILCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4gSUZDVkYgZHJp
dmVyIHByb2JlcyBtdWx0aXBsZSB0eXBlcyBvZiBkZXZpY2VzIG5vdywKPiB0byBkaXN0aW5ndWlz
aCB0aGUgb3JpZ2luYWwgZGV2aWNlIGRyaXZlbiBieSBJRkNWRgo+IGZyb20gb3RoZXJzLCBpdCBp
cyByZW5hbWVkIGFzICJOMzAwMCIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxp
bmdzaGFuLnpodUBpbnRlbC5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+CgpZb3UgcHJvYmFibHkgbmVlZCB0byByZW5hbWUgdGhlIGRyaXZlci4KClRoYW5r
cwoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgOCArKysrLS0t
LQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDggKysrKy0tLS0KPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggYi9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5oCj4gaW5kZXggNzVkOWE4MDUyMDM5Li43OTRkMTUwNWQ4NTcgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+ICsrKyBiL2RyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBAQCAtMTgsMTAgKzE4LDEwIEBACj4gICAjaW5jbHVk
ZSA8dWFwaS9saW51eC92aXJ0aW9fY29uZmlnLmg+Cj4gICAjaW5jbHVkZSA8dWFwaS9saW51eC92
aXJ0aW9fcGNpLmg+Cj4gICAKPiAtI2RlZmluZSBJRkNWRl9WRU5ET1JfSUQJCTB4MUFGNAo+IC0j
ZGVmaW5lIElGQ1ZGX0RFVklDRV9JRAkJMHgxMDQxCj4gLSNkZWZpbmUgSUZDVkZfU1VCU1lTX1ZF
TkRPUl9JRAkweDgwODYKPiAtI2RlZmluZSBJRkNWRl9TVUJTWVNfREVWSUNFX0lECTB4MDAxQQo+
ICsjZGVmaW5lIE4zMDAwX1ZFTkRPUl9JRAkJMHgxQUY0Cj4gKyNkZWZpbmUgTjMwMDBfREVWSUNF
X0lECQkweDEwNDEKPiArI2RlZmluZSBOMzAwMF9TVUJTWVNfVkVORE9SX0lECTB4ODA4Ngo+ICsj
ZGVmaW5lIE4zMDAwX1NVQlNZU19ERVZJQ0VfSUQJMHgwMDFBCj4gICAKPiAgICNkZWZpbmUgQzUw
MDBYX1BMX1ZFTkRPUl9JRAkJMHgxQUY0Cj4gICAjZGVmaW5lIEM1MDAwWF9QTF9ERVZJQ0VfSUQJ
CTB4MTAwMAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGIv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IDI2YTJkYWI3Y2E2Ni4uZmQ1
YmVmYzVjYmNjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMK
PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gQEAgLTQ4MCwxMCArNDgw
LDEwIEBAIHN0YXRpYyB2b2lkIGlmY3ZmX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKPiAg
IH0KPiAgIAo+ICAgc3RhdGljIHN0cnVjdCBwY2lfZGV2aWNlX2lkIGlmY3ZmX3BjaV9pZHNbXSA9
IHsKPiAtCXsgUENJX0RFVklDRV9TVUIoSUZDVkZfVkVORE9SX0lELAo+IC0JCUlGQ1ZGX0RFVklD
RV9JRCwKPiAtCQlJRkNWRl9TVUJTWVNfVkVORE9SX0lELAo+IC0JCUlGQ1ZGX1NVQlNZU19ERVZJ
Q0VfSUQpIH0sCj4gKwl7IFBDSV9ERVZJQ0VfU1VCKE4zMDAwX1ZFTkRPUl9JRCwKPiArCQkJIE4z
MDAwX0RFVklDRV9JRCwKPiArCQkJIE4zMDAwX1NVQlNZU19WRU5ET1JfSUQsCj4gKwkJCSBOMzAw
MF9TVUJTWVNfREVWSUNFX0lEKSB9LAo+ICAgCXsgUENJX0RFVklDRV9TVUIoQzUwMDBYX1BMX1ZF
TkRPUl9JRCwKPiAgIAkJCSBDNTAwMFhfUExfREVWSUNFX0lELAo+ICAgCQkJIEM1MDAwWF9QTF9T
VUJTWVNfVkVORE9SX0lELAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
