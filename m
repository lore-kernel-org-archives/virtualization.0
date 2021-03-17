Return-Path: <SRS0=tvPF=IP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FA4C433E0
	for <virtualization@archiver.kernel.org>; Wed, 17 Mar 2021 03:57:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AAE64F92
	for <virtualization@archiver.kernel.org>; Wed, 17 Mar 2021 03:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AAE64F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30151431DF;
	Wed, 17 Mar 2021 03:57:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bctma1w90UVL; Wed, 17 Mar 2021 03:57:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE2E24300A;
	Wed, 17 Mar 2021 03:57:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93FAFC000B;
	Wed, 17 Mar 2021 03:57:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96A76C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 03:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70FC5605B7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 03:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FO3PY93Ihl48
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 03:57:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98FFF60598
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 03:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615953471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9laViWHXxg7PRqj/pmoMOkbiM/RKp8I4VgNFTiTAsQ=;
 b=Jmx951VWyPhYcAidgz3rg302yURmY/iTQNAlRANJy6Exnv6cEPO8bDVz0ngR4qkzorjDpg
 CCNvAPwK5Wj/RK2pv19/1l3seVAAA8xkqiXdfr38q+xBKZa4/oSJGKErmrccREJDehSf+q
 Se+ZxrRqEGXKKhjf8PGEgAOiXvia9PE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-_DWUUqDrOBy6mp4INC2e9Q-1; Tue, 16 Mar 2021 23:57:49 -0400
X-MC-Unique: _DWUUqDrOBy6mp4INC2e9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22EAE363A1;
 Wed, 17 Mar 2021 03:57:48 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-188.pek2.redhat.com
 [10.72.12.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60E2560C13;
 Wed, 17 Mar 2021 03:57:41 +0000 (UTC)
Subject: Re: [PATCH V4 5/7] vDPA/ifcvf: fetch device feature bits when probe
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210315074501.15868-1-lingshan.zhu@intel.com>
 <20210315074501.15868-6-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9ab3f888-2201-54de-1390-6bc181316453@redhat.com>
Date: Wed, 17 Mar 2021 11:57:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315074501.15868-6-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMy8xNSDPws7nMzo0NCwgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
d291bGQgcmVhZCBhbmQgc3RvcmUgZGV2aWNlIGZlYXR1cmUKPiBiaXRzIHdoZW4gcHJvYmUuCj4K
PiByZW5hbWUgaWZjdmZfZ2V0X2ZlYXR1cmVzKCkgdG8gaWZjdmZfZ2V0X2h3X2ZlYXR1cmVzKCks
Cj4gaXQgcmVhZHMgYW5kIHN0b3JlcyBmZWF0dXJlcyBvZiB0aGUgcHJvYmVkIGRldmljZS4KPgo+
IG5ldyBpZmN2Zl9nZXRfZmVhdHVyZXMoKSBzaW1wbHkgcmV0dXJucyBzdG9yZWQKPiBmZWF0dXJl
IGJpdHMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRl
bC5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAt
LS0KPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMgfCAxMiArKysrKysrKysrLS0K
PiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggfCAgMiArKwo+ICAgZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8ICAyICsrCj4gICAzIGZpbGVzIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX2Jhc2UuYyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPiBp
bmRleCBmMmExMjhlNTZkZTUuLmVhNmE3ODc5MWM5YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jh
c2UuYwo+IEBAIC0yMDIsMTAgKzIwMiwxMSBAQCBzdGF0aWMgdm9pZCBpZmN2Zl9hZGRfc3RhdHVz
KHN0cnVjdCBpZmN2Zl9odyAqaHcsIHU4IHN0YXR1cykKPiAgIAlpZmN2Zl9nZXRfc3RhdHVzKGh3
KTsKPiAgIH0KPiAgIAo+IC11NjQgaWZjdmZfZ2V0X2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9odyAq
aHcpCj4gK3U2NCBpZmN2Zl9nZXRfaHdfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodykKPiAg
IHsKPiAgIAlzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnIF9faW9tZW0gKmNmZyA9IGh3LT5j
b21tb25fY2ZnOwo+ICAgCXUzMiBmZWF0dXJlc19sbywgZmVhdHVyZXNfaGk7Cj4gKwl1NjQgZmVh
dHVyZXM7Cj4gICAKPiAgIAlpZmNfaW93cml0ZTMyKDAsICZjZmctPmRldmljZV9mZWF0dXJlX3Nl
bGVjdCk7Cj4gICAJZmVhdHVyZXNfbG8gPSBpZmNfaW9yZWFkMzIoJmNmZy0+ZGV2aWNlX2ZlYXR1
cmUpOwo+IEBAIC0yMTMsNyArMjE0LDE0IEBAIHU2NCBpZmN2Zl9nZXRfZmVhdHVyZXMoc3RydWN0
IGlmY3ZmX2h3ICpodykKPiAgIAlpZmNfaW93cml0ZTMyKDEsICZjZmctPmRldmljZV9mZWF0dXJl
X3NlbGVjdCk7Cj4gICAJZmVhdHVyZXNfaGkgPSBpZmNfaW9yZWFkMzIoJmNmZy0+ZGV2aWNlX2Zl
YXR1cmUpOwo+ICAgCj4gLQlyZXR1cm4gKCh1NjQpZmVhdHVyZXNfaGkgPDwgMzIpIHwgZmVhdHVy
ZXNfbG87Cj4gKwlmZWF0dXJlcyA9ICgodTY0KWZlYXR1cmVzX2hpIDw8IDMyKSB8IGZlYXR1cmVz
X2xvOwo+ICsKPiArCXJldHVybiBmZWF0dXJlczsKPiArfQo+ICsKPiArdTY0IGlmY3ZmX2dldF9m
ZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ICt7Cj4gKwlyZXR1cm4gaHctPmh3X2ZlYXR1
cmVzOwo+ICAgfQo+ICAgCj4gICB2b2lkIGlmY3ZmX3JlYWRfbmV0X2NvbmZpZyhzdHJ1Y3QgaWZj
dmZfaHcgKmh3LCB1NjQgb2Zmc2V0LAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfYmFzZS5oIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+IGluZGV4IDc5
NGQxNTA1ZDg1Ny4uZGJiOGMxMGFhM2IxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9iYXNlLmgKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4g
QEAgLTgzLDYgKzgzLDcgQEAgc3RydWN0IGlmY3ZmX2h3IHsKPiAgIAl2b2lkIF9faW9tZW0gKm5v
dGlmeV9iYXNlOwo+ICAgCXUzMiBub3RpZnlfb2ZmX211bHRpcGxpZXI7Cj4gICAJdTY0IHJlcV9m
ZWF0dXJlczsKPiArCXU2NCBod19mZWF0dXJlczsKPiAgIAlzdHJ1Y3QgdmlydGlvX3BjaV9jb21t
b25fY2ZnIF9faW9tZW0gKmNvbW1vbl9jZmc7Cj4gICAJdm9pZCBfX2lvbWVtICpuZXRfY2ZnOwo+
ICAgCXN0cnVjdCB2cmluZ19pbmZvIHZyaW5nW0lGQ1ZGX01BWF9RVUVVRV9QQUlSUyAqIDJdOwo+
IEBAIC0xMjEsNiArMTIyLDcgQEAgdm9pZCBpZmN2Zl9zZXRfc3RhdHVzKHN0cnVjdCBpZmN2Zl9o
dyAqaHcsIHU4IHN0YXR1cyk7Cj4gICB2b2lkIGlvX3dyaXRlNjRfdHdvcGFydCh1NjQgdmFsLCB1
MzIgKmxvLCB1MzIgKmhpKTsKPiAgIHZvaWQgaWZjdmZfcmVzZXQoc3RydWN0IGlmY3ZmX2h3ICpo
dyk7Cj4gICB1NjQgaWZjdmZfZ2V0X2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9odyAqaHcpOwo+ICt1
NjQgaWZjdmZfZ2V0X2h3X2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9odyAqaHcpOwo+ICAgdTE2IGlm
Y3ZmX2dldF92cV9zdGF0ZShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkKTsKPiAgIGludCBp
ZmN2Zl9zZXRfdnFfc3RhdGUoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCwgdTE2IG51bSk7
Cj4gICBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqdmZfdG9fYWRhcHRlcihzdHJ1Y3QgaWZjdmZfaHcg
Kmh3KTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2Ry
aXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiBpbmRleCBjMzRlMWVlYzZiNmMuLjI1ZmI5
ZGZlMjNmMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4g
KysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IEBAIC00NTgsNiArNDU4LDgg
QEAgc3RhdGljIGludCBpZmN2Zl9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3Ry
dWN0IHBjaV9kZXZpY2VfaWQgKmlkKQo+ICAgCWZvciAoaSA9IDA7IGkgPCBJRkNWRl9NQVhfUVVF
VUVfUEFJUlMgKiAyOyBpKyspCj4gICAJCXZmLT52cmluZ1tpXS5pcnEgPSAtRUlOVkFMOwo+ICAg
Cj4gKwl2Zi0+aHdfZmVhdHVyZXMgPSBpZmN2Zl9nZXRfaHdfZmVhdHVyZXModmYpOwo+ICsKPiAg
IAlyZXQgPSB2ZHBhX3JlZ2lzdGVyX2RldmljZSgmYWRhcHRlci0+dmRwYSk7Cj4gICAJaWYgKHJl
dCkgewo+ICAgCQlJRkNWRl9FUlIocGRldiwgIkZhaWxlZCB0byByZWdpc3RlciBpZmN2ZiB0byB2
ZHBhIGJ1cyIpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
