Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F55C433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 07:08:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B466564DEC
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 07:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B466564DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BE956F56B;
	Fri,  5 Mar 2021 07:08:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23ncrCy-yYZ4; Fri,  5 Mar 2021 07:08:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADE066F510;
	Fri,  5 Mar 2021 07:08:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F571C000A;
	Fri,  5 Mar 2021 07:08:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02F48C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D12216F555
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aVqsPWvnh1Wg
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:08:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE9E86F510
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614928120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NEKrOKBQjNeh6xpfaaDnnWjqElQJhMWyC0KTnixxBgY=;
 b=HBPr5sODzX8TAag4Ykd/AtJbiVdpjrN8u/7wkXPjYMnY7oz//cJRLGnMCCvz1stV3yXEjI
 LJOi6Y7t98FBQxXbAMCLkxeCUa6Qquph3eM0+GVK7kERtDUsnkgqyULUUv6n0rN+NciyZ9
 NJmy/9pNvAfAWNjcX9WoHyLUeWZzQow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-djdlyYmFP6OzVYBOTlM1Ew-1; Fri, 05 Mar 2021 02:08:38 -0500
X-MC-Unique: djdlyYmFP6OzVYBOTlM1Ew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8B2457;
 Fri,  5 Mar 2021 07:08:36 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-165.pek2.redhat.com
 [10.72.12.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 049F25D9C0;
 Fri,  5 Mar 2021 07:08:28 +0000 (UTC)
Subject: Re: [PATCH v5 net-next] virtio-net: support XDP when not more queues
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <1614568959-107464-1-git-send-email-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7010e921-dd66-dc6c-220b-09144800d9d5@redhat.com>
Date: Fri, 5 Mar 2021 15:08:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1614568959-107464-1-git-send-email-xuanzhuo@linux.alibaba.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

Ck9uIDIwMjEvMy8xIDExOjIyIOS4iuWNiCwgWHVhbiBaaHVvIHdyb3RlOgo+IFRoZSBudW1iZXIg
b2YgcXVldWVzIGltcGxlbWVudGVkIGJ5IG1hbnkgdmlydGlvIGJhY2tlbmRzIGlzIGxpbWl0ZWQs
Cj4gZXNwZWNpYWxseSBzb21lIG1hY2hpbmVzIGhhdmUgYSBsYXJnZSBudW1iZXIgb2YgQ1BVcy4g
SW4gdGhpcyBjYXNlLCBpdAo+IGlzIG9mdGVuIGltcG9zc2libGUgdG8gYWxsb2NhdGUgYSBzZXBh
cmF0ZSBxdWV1ZSBmb3IKPiBYRFBfVFgvWERQX1JFRElSRUNULCB0aGVuIHhkcCBjYW5ub3QgYmUg
bG9hZGVkIHRvIHdvcmssIGV2ZW4geGRwIGRvZXMKPiBub3QgdXNlIHRoZSBYRFBfVFgvWERQX1JF
RElSRUNULgo+Cj4gVGhpcyBwYXRjaCBhbGxvd3MgWERQX1RYL1hEUF9SRURJUkVDVCB0byBydW4g
YnkgcmV1c2UgdGhlIGV4aXN0aW5nIFNRCj4gd2l0aCBfX25ldGlmX3R4X2xvY2soKSBob2xkIHdo
ZW4gdGhlcmUgYXJlIG5vdCBlbm91Z2ggcXVldWVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBa
aHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiBSZXZpZXdlZC1ieTogRHVzdCBMaSA8
ZHVzdC5saUBsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiB2NTogY2hhbmdlIHN1YmplY3QgZnJv
bSAnc3VwcG9ydCBYRFBfVFggd2hlbiBub3QgbW9yZSBxdWV1ZXMnCj4KPiB2NDogbWFrZSBzcGFy
c2UgaGFwcHkKPiAgICAgIHN1Z2dlc3RlZCBieSBKYWt1YiBLaWNpbnNraQo+Cj4gdjM6IGFkZCB3
YXJuaW5nIHdoZW4gbm8gbW9yZSBxdWV1ZXMKPiAgICAgIHN1Z2dlc3RlZCBieSBKZXNwZXIgRGFu
Z2FhcmQgQnJvdWVyCj4KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDUzICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDQ0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXgg
YmE4ZTYzNy4uNTVmMWRkMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMTk1LDYgKzE5NSw5IEBAIHN0
cnVjdCB2aXJ0bmV0X2luZm8gewo+ICAgCS8qICMgb2YgWERQIHF1ZXVlIHBhaXJzIGN1cnJlbnRs
eSB1c2VkIGJ5IHRoZSBkcml2ZXIgKi8KPiAgIAl1MTYgeGRwX3F1ZXVlX3BhaXJzOwo+Cj4gKwkv
KiB4ZHBfcXVldWVfcGFpcnMgbWF5IGJlIDAsIHdoZW4geGRwIGlzIGFscmVhZHkgbG9hZGVkLiBT
byBhZGQgdGhpcy4gKi8KPiArCWJvb2wgeGRwX2VuYWJsZWQ7Cj4gKwo+ICAgCS8qIEkgbGlrZS4u
LiBiaWcgcGFja2V0cyBhbmQgSSBjYW5ub3QgbGllISAqLwo+ICAgCWJvb2wgYmlnX3BhY2tldHM7
Cj4KPiBAQCAtNDgxLDE0ICs0ODQsNDIgQEAgc3RhdGljIGludCBfX3ZpcnRuZXRfeGRwX3htaXRf
b25lKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgCXJldHVybiAwOwo+ICAgfQo+Cj4gLXN0
YXRpYyBzdHJ1Y3Qgc2VuZF9xdWV1ZSAqdmlydG5ldF94ZHBfc3Eoc3RydWN0IHZpcnRuZXRfaW5m
byAqdmkpCj4gK3N0YXRpYyBzdHJ1Y3Qgc2VuZF9xdWV1ZSAqdmlydG5ldF9nZXRfeGRwX3NxKHN0
cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ICsJX19hY3F1aXJlcyhsb2NrKQo+ICAgewo+ICsJc3Ry
dWN0IG5ldGRldl9xdWV1ZSAqdHhxOwo+ICAgCXVuc2lnbmVkIGludCBxcDsKPgo+IC0JcXAgPSB2
aS0+Y3Vycl9xdWV1ZV9wYWlycyAtIHZpLT54ZHBfcXVldWVfcGFpcnMgKyBzbXBfcHJvY2Vzc29y
X2lkKCk7Cj4gKwlpZiAodmktPmN1cnJfcXVldWVfcGFpcnMgPiBucl9jcHVfaWRzKSB7Cj4gKwkJ
cXAgPSB2aS0+Y3Vycl9xdWV1ZV9wYWlycyAtIHZpLT54ZHBfcXVldWVfcGFpcnMgKyBzbXBfcHJv
Y2Vzc29yX2lkKCk7Cj4gKwo+ICsJCS8qIHRlbGwgc3BhcnNlIHdlIHRvb2sgdGhlIGxvY2ssIGJ1
dCBkb24ndCByZWFsbHkgdGFrZSBpdCAqLwo+ICsJCV9fYWNxdWlyZShsb2NrKTsKCgpUaGUgY29k
ZSBjYW4gZXhwbGFpbiBpdHNlbGYgYnV0IHlvdSBuZWVkIHRvIGV4cGxhaW4gd2h5IHdlIGRvbid0
IG5lZWQgdG8gCmhvbGQgdHggbG9jayBoZXJlLgoKQW5kIGl0IGxvb2tzIHRvIG1lIHdlIHNob3Vs
ZCB1c2UgX19uZXRpZl90eF9hY3F1aXJlKCkvX19uZXRpZl90eF9yZWxlYXNlKCk/CgpCdHcsIGlz
IGl0IGJldHRlciB0byByZWZhY3RvciB0aGUgY29kZSB0aGVuIHdlIGNhbiBhbm5vdGUgdGhlIGNv
ZGUgd2l0aCAKc29tZXRoaW5nIGxpa2UgX19hY3F1aXJlKHR4cS0+eG1pdF9sb2NrKT8KClRoYW5r
cwoKCgo+ICsJfSBlbHNlIHsKPiArCQlxcCA9IHNtcF9wcm9jZXNzb3JfaWQoKSAlIHZpLT5jdXJy
X3F1ZXVlX3BhaXJzOwo+ICsJCXR4cSA9IG5ldGRldl9nZXRfdHhfcXVldWUodmktPmRldiwgcXAp
Owo+ICsJCV9fbmV0aWZfdHhfbG9jayh0eHEsIHJhd19zbXBfcHJvY2Vzc29yX2lkKCkpOwo+ICsJ
fQo+ICsKPiAgIAlyZXR1cm4gJnZpLT5zcVtxcF07Cj4gICB9Cj4KPiArc3RhdGljIHZvaWQgdmly
dG5ldF9wdXRfeGRwX3NxKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3Qgc2VuZF9xdWV1
ZSAqc3EpCj4gKwlfX3JlbGVhc2VzKGxvY2spCj4gK3sKPiArCXN0cnVjdCBuZXRkZXZfcXVldWUg
KnR4cTsKPiArCXVuc2lnbmVkIGludCBxcDsKPiArCj4gKwlpZiAodmktPmN1cnJfcXVldWVfcGFp
cnMgPD0gbnJfY3B1X2lkcykgewo+ICsJCXFwID0gc3EgLSB2aS0+c3E7Cj4gKwkJdHhxID0gbmV0
ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2LCBxcCk7Cj4gKwkJX19uZXRpZl90eF91bmxvY2sodHhx
KTsKPiArCX0gZWxzZSB7Cj4gKwkJLyogbWFrZSBzcGFyc2UgaGFwcHkgKi8KPiArCQlfX3JlbGVh
c2UobG9jayk7Cj4gKwl9Cj4gK30KPiArCj4gICBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX3htaXQo
c3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAkJCSAgICBpbnQgbiwgc3RydWN0IHhkcF9mcmFt
ZSAqKmZyYW1lcywgdTMyIGZsYWdzKQo+ICAgewo+IEBAIC01MTIsNyArNTQzLDcgQEAgc3RhdGlj
IGludCB2aXJ0bmV0X3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAJaWYgKCF4
ZHBfcHJvZykKPiAgIAkJcmV0dXJuIC1FTlhJTzsKPgo+IC0Jc3EgPSB2aXJ0bmV0X3hkcF9zcSh2
aSk7Cj4gKwlzcSA9IHZpcnRuZXRfZ2V0X3hkcF9zcSh2aSk7Cj4KPiAgIAlpZiAodW5saWtlbHko
ZmxhZ3MgJiB+WERQX1hNSVRfRkxBR1NfTUFTSykpIHsKPiAgIAkJcmV0ID0gLUVJTlZBTDsKPiBA
QCAtNTYwLDEyICs1OTEsMTMgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF94bWl0KHN0cnVjdCBu
ZXRfZGV2aWNlICpkZXYsCj4gICAJc3EtPnN0YXRzLmtpY2tzICs9IGtpY2tzOwo+ICAgCXU2NF9z
dGF0c191cGRhdGVfZW5kKCZzcS0+c3RhdHMuc3luY3ApOwo+Cj4gKwl2aXJ0bmV0X3B1dF94ZHBf
c3EodmksIHNxKTsKPiAgIAlyZXR1cm4gcmV0Owo+ICAgfQo+Cj4gICBzdGF0aWMgdW5zaWduZWQg
aW50IHZpcnRuZXRfZ2V0X2hlYWRyb29tKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ICAgewo+
IC0JcmV0dXJuIHZpLT54ZHBfcXVldWVfcGFpcnMgPyBWSVJUSU9fWERQX0hFQURST09NIDogMDsK
PiArCXJldHVybiB2aS0+eGRwX2VuYWJsZWQgPyBWSVJUSU9fWERQX0hFQURST09NIDogMDsKPiAg
IH0KPgo+ICAgLyogV2UgY29weSB0aGUgcGFja2V0IGZvciBYRFAgaW4gdGhlIGZvbGxvd2luZyBj
YXNlczoKPiBAQCAtMTQ1NywxMiArMTQ4OSwxMyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbChz
dHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4gICAJCXhkcF9kb19mbHVzaCgp
Owo+Cj4gICAJaWYgKHhkcF94bWl0ICYgVklSVElPX1hEUF9UWCkgewo+IC0JCXNxID0gdmlydG5l
dF94ZHBfc3EodmkpOwo+ICsJCXNxID0gdmlydG5ldF9nZXRfeGRwX3NxKHZpKTsKPiAgIAkJaWYg
KHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUoc3EtPnZxKSAmJiB2aXJ0cXVldWVfbm90aWZ5KHNxLT52
cSkpIHsKPiAgIAkJCXU2NF9zdGF0c191cGRhdGVfYmVnaW4oJnNxLT5zdGF0cy5zeW5jcCk7Cj4g
ICAJCQlzcS0+c3RhdHMua2lja3MrKzsKPiAgIAkJCXU2NF9zdGF0c191cGRhdGVfZW5kKCZzcS0+
c3RhdHMuc3luY3ApOwo+ICAgCQl9Cj4gKwkJdmlydG5ldF9wdXRfeGRwX3NxKHZpLCBzcSk7Cj4g
ICAJfQo+Cj4gICAJcmV0dXJuIHJlY2VpdmVkOwo+IEBAIC0yNDE3LDEwICsyNDUwLDkgQEAgc3Rh
dGljIGludCB2aXJ0bmV0X3hkcF9zZXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IGJw
Zl9wcm9nICpwcm9nLAo+Cj4gICAJLyogWERQIHJlcXVpcmVzIGV4dHJhIHF1ZXVlcyBmb3IgWERQ
X1RYICovCj4gICAJaWYgKGN1cnJfcXAgKyB4ZHBfcXAgPiB2aS0+bWF4X3F1ZXVlX3BhaXJzKSB7
Cj4gLQkJTkxfU0VUX0VSUl9NU0dfTU9EKGV4dGFjaywgIlRvbyBmZXcgZnJlZSBUWCByaW5ncyBh
dmFpbGFibGUiKTsKPiAtCQluZXRkZXZfd2FybihkZXYsICJyZXF1ZXN0ICVpIHF1ZXVlcyBidXQg
bWF4IGlzICVpXG4iLAo+ICsJCW5ldGRldl93YXJuKGRldiwgIlhEUCByZXF1ZXN0ICVpIHF1ZXVl
cyBidXQgbWF4IGlzICVpLiBYRFBfVFggYW5kIFhEUF9SRURJUkVDVCB3aWxsIG9wZXJhdGUgaW4g
YSBzbG93ZXIgbG9ja2VkIHR4IG1vZGUuXG4iLAo+ICAgCQkJICAgIGN1cnJfcXAgKyB4ZHBfcXAs
IHZpLT5tYXhfcXVldWVfcGFpcnMpOwo+IC0JCXJldHVybiAtRU5PTUVNOwo+ICsJCXhkcF9xcCA9
IDA7Cj4gICAJfQo+Cj4gICAJb2xkX3Byb2cgPSBydG5sX2RlcmVmZXJlbmNlKHZpLT5ycVswXS54
ZHBfcHJvZyk7Cj4gQEAgLTI0NTQsMTEgKzI0ODYsMTQgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hk
cF9zZXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IGJwZl9wcm9nICpwcm9nLAo+ICAg
CXZpLT54ZHBfcXVldWVfcGFpcnMgPSB4ZHBfcXA7Cj4KPiAgIAlpZiAocHJvZykgewo+ICsJCXZp
LT54ZHBfZW5hYmxlZCA9IHRydWU7Cj4gICAJCWZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVl
X3BhaXJzOyBpKyspIHsKPiAgIAkJCXJjdV9hc3NpZ25fcG9pbnRlcih2aS0+cnFbaV0ueGRwX3By
b2csIHByb2cpOwo+ICAgCQkJaWYgKGkgPT0gMCAmJiAhb2xkX3Byb2cpCj4gICAJCQkJdmlydG5l
dF9jbGVhcl9ndWVzdF9vZmZsb2Fkcyh2aSk7Cj4gICAJCX0KPiArCX0gZWxzZSB7Cj4gKwkJdmkt
PnhkcF9lbmFibGVkID0gZmFsc2U7Cj4gICAJfQo+Cj4gICAJZm9yIChpID0gMDsgaSA8IHZpLT5t
YXhfcXVldWVfcGFpcnM7IGkrKykgewo+IEBAIC0yNTI2LDcgKzI1NjEsNyBAQCBzdGF0aWMgaW50
IHZpcnRuZXRfc2V0X2ZlYXR1cmVzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAJaW50IGVy
cjsKPgo+ICAgCWlmICgoZGV2LT5mZWF0dXJlcyBeIGZlYXR1cmVzKSAmIE5FVElGX0ZfTFJPKSB7
Cj4gLQkJaWYgKHZpLT54ZHBfcXVldWVfcGFpcnMpCj4gKwkJaWYgKHZpLT54ZHBfZW5hYmxlZCkK
PiAgIAkJCXJldHVybiAtRUJVU1k7Cj4KPiAgIAkJaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9MUk8p
Cj4gLS0KPiAxLjguMy4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
