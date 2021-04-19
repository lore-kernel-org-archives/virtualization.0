Return-Path: <SRS0=J9So=JQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A3EC433ED
	for <virtualization@archiver.kernel.org>; Mon, 19 Apr 2021 03:17:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7726100A
	for <virtualization@archiver.kernel.org>; Mon, 19 Apr 2021 03:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7726100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9E1D834F6;
	Mon, 19 Apr 2021 03:17:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JMZxGbfqBR1M; Mon, 19 Apr 2021 03:16:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4567834FE;
	Mon, 19 Apr 2021 03:16:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98B16C000E;
	Mon, 19 Apr 2021 03:16:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 909BAC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 03:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 725B440124
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 03:16:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wola1NzbW6XY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 03:16:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7383A400C0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 03:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618802211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngjLvfqraclHl1dSfqaoWbo+wa4rNwfdo8glbMm71to=;
 b=IYOtNGHRyLbDvHybmBtmp/B8btZHfSyjSVIEO0Ic8JlHkmRhw020ROzNtzbeb3t0qpg7un
 GT9jIze/CiuaheJ9bkXschThDD37JcbceWt3F/NuqulLX2T5D+scURuKyIBXWYMOAwVfi3
 dDO9PaSpfAIcoW2+5WnOpP3x9ghEPU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-x3xdpjwoMEGg9q0LOEIJaA-1; Sun, 18 Apr 2021 23:16:47 -0400
X-MC-Unique: x3xdpjwoMEGg9q0LOEIJaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 751CB18B63A8;
 Mon, 19 Apr 2021 03:16:46 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-157.pek2.redhat.com
 [10.72.12.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A51C219809;
 Mon, 19 Apr 2021 03:16:40 +0000 (UTC)
Subject: Re: [PATCH V3 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-block
 for vDPA
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 sgarzare@redhat.com
References: <20210416071628.4984-1-lingshan.zhu@intel.com>
 <20210416071628.4984-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4cce68b5-9cca-1ccd-f219-fb66c50a4f75@redhat.com>
Date: Mon, 19 Apr 2021 11:16:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210416071628.4984-3-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

CtTaIDIwMjEvNC8xNiDPws7nMzoxNiwgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
ZW5hYmxlZCBJbnRlbCBGUEdBIFNtYXJ0TklDIEM1MDAwWC1QTCB2aXJ0aW8tYmxvY2sKPiBmb3Ig
dkRQQS4KPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVs
LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0t
LQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8ICA4ICsrKysrKystCj4gICBk
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgMTkgKysrKysrKysrKysrKysrKysrLQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggYi9kcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gaW5kZXggMWMwNGNkMjU2ZmE3Li4wMTExYmZkZWIzNDIg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+ICsrKyBiL2Ry
aXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBAQCAtMTUsNiArMTUsNyBAQAo+ICAgI2lu
Y2x1ZGUgPGxpbnV4L3BjaV9yZWdzLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvdmRwYS5oPgo+ICAg
I2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX25ldC5oPgo+ICsjaW5jbHVkZSA8dWFwaS9saW51
eC92aXJ0aW9fYmxrLmg+Cj4gICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fY29uZmlnLmg+
Cj4gICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fcGNpLmg+Cj4gICAKPiBAQCAtMjgsNyAr
MjksMTIgQEAKPiAgICNkZWZpbmUgQzUwMDBYX1BMX1NVQlNZU19WRU5ET1JfSUQJMHg4MDg2Cj4g
ICAjZGVmaW5lIEM1MDAwWF9QTF9TVUJTWVNfREVWSUNFX0lECTB4MDAwMQo+ICAgCj4gLSNkZWZp
bmUgSUZDVkZfU1VQUE9SVEVEX0ZFQVRVUkVTIFwKPiArI2RlZmluZSBDNTAwMFhfUExfQkxLX1ZF
TkRPUl9JRAkJMHgxQUY0Cj4gKyNkZWZpbmUgQzUwMDBYX1BMX0JMS19ERVZJQ0VfSUQJCTB4MTAw
MQo+ICsjZGVmaW5lIEM1MDAwWF9QTF9CTEtfU1VCU1lTX1ZFTkRPUl9JRAkweDgwODYKPiArI2Rl
ZmluZSBDNTAwMFhfUExfQkxLX1NVQlNZU19ERVZJQ0VfSUQJMHgwMDAyCj4gKwo+ICsjZGVmaW5l
IElGQ1ZGX05FVF9TVVBQT1JURURfRkVBVFVSRVMgXAo+ICAgCQkoKDFVTEwgPDwgVklSVElPX05F
VF9GX01BQykJCQl8IFwKPiAgIAkJICgxVUxMIDw8IFZJUlRJT19GX0FOWV9MQVlPVVQpCQkJfCBc
Cj4gICAJCSAoMVVMTCA8PCBWSVJUSU9fRl9WRVJTSU9OXzEpCQkJfCBcCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZj
dmZfbWFpbi5jCj4gaW5kZXggNDY5YTliNTczN2I3Li4zNzZiMjAxNDkxNmEgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9tYWluLmMKPiBAQCAtMTY4LDEwICsxNjgsMjMgQEAgc3RhdGljIHN0cnVjdCBp
ZmN2Zl9odyAqdmRwYV90b192ZihzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+ICAgCj4g
ICBzdGF0aWMgdTY0IGlmY3ZmX3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRwYV9kZXYpCj4gICB7Cj4gKwlzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlciA9IHZkcGFf
dG9fYWRhcHRlcih2ZHBhX2Rldik7Cj4gICAJc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9f
dmYodmRwYV9kZXYpOwo+ICsJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSBhZGFwdGVyLT5wZGV2Owo+
ICsKPiAgIAl1NjQgZmVhdHVyZXM7Cj4gICAKPiAtCWZlYXR1cmVzID0gaWZjdmZfZ2V0X2ZlYXR1
cmVzKHZmKSAmIElGQ1ZGX1NVUFBPUlRFRF9GRUFUVVJFUzsKPiArCXN3aXRjaCAodmYtPmRldl90
eXBlKSB7Cj4gKwljYXNlIFZJUlRJT19JRF9ORVQ6Cj4gKwkJZmVhdHVyZXMgPSBpZmN2Zl9nZXRf
ZmVhdHVyZXModmYpICYgSUZDVkZfTkVUX1NVUFBPUlRFRF9GRUFUVVJFUzsKPiArCQlicmVhazsK
PiArCWNhc2UgVklSVElPX0lEX0JMT0NLOgo+ICsJCWZlYXR1cmVzID0gaWZjdmZfZ2V0X2ZlYXR1
cmVzKHZmKTsKPiArCQlicmVhazsKPiArCWRlZmF1bHQ6Cj4gKwkJZmVhdHVyZXMgPSAwOwo+ICsJ
CUlGQ1ZGX0VSUihwZGV2LCAiVklSVElPIElEICV1IG5vdCBzdXBwb3J0ZWRcbiIsIHZmLT5kZXZf
dHlwZSk7Cj4gKwl9Cj4gICAKPiAgIAlyZXR1cm4gZmVhdHVyZXM7Cj4gICB9Cj4gQEAgLTUxNyw2
ICs1MzAsMTAgQEAgc3RhdGljIHN0cnVjdCBwY2lfZGV2aWNlX2lkIGlmY3ZmX3BjaV9pZHNbXSA9
IHsKPiAgIAkJCSBDNTAwMFhfUExfREVWSUNFX0lELAo+ICAgCQkJIEM1MDAwWF9QTF9TVUJTWVNf
VkVORE9SX0lELAo+ICAgCQkJIEM1MDAwWF9QTF9TVUJTWVNfREVWSUNFX0lEKSB9LAo+ICsJeyBQ
Q0lfREVWSUNFX1NVQihDNTAwMFhfUExfQkxLX1ZFTkRPUl9JRCwKPiArCQkJIEM1MDAwWF9QTF9C
TEtfREVWSUNFX0lELAo+ICsJCQkgQzUwMDBYX1BMX0JMS19TVUJTWVNfVkVORE9SX0lELAo+ICsJ
CQkgQzUwMDBYX1BMX0JMS19TVUJTWVNfREVWSUNFX0lEKSB9LAo+ICAgCj4gICAJeyAwIH0sCj4g
ICB9OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
