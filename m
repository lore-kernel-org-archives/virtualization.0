Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F8FC433B4
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 02:29:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD561613AA
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 02:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD561613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 890104054F;
	Tue, 13 Apr 2021 02:29:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IoYNTg4GZmhm; Tue, 13 Apr 2021 02:29:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 39FCE40543;
	Tue, 13 Apr 2021 02:29:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 076CCC000B;
	Tue, 13 Apr 2021 02:29:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0020C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 02:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC8EF835D9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 02:29:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y4XfEaLtq4s5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 02:29:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F23C48376E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 02:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618280952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8gIr+fTrmvC/Op6pnrsHLt9kJsACORpFLy/++5dKA4=;
 b=bNLrMXfraBDN0SFuew2Vur2hAuovwhgwTZadljk9SMGmUUjkY2rCFDUWVvnnLma2t6Nb4c
 kPwm8HVW4xYj2l8jWTE0qzOGNGCoUMZ2Pc2nhYBiGqsw8s5reujCBAqodIQQhh4cF3twUv
 QrWRfpcfO3NfdNkWzpZK54VC75x6uFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-tYGXBqtFNQGi2eu0vdr95A-1; Mon, 12 Apr 2021 22:29:11 -0400
X-MC-Unique: tYGXBqtFNQGi2eu0vdr95A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E74DC107ACCA;
 Tue, 13 Apr 2021 02:29:09 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-128.pek2.redhat.com
 [10.72.13.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FAE619C46;
 Tue, 13 Apr 2021 02:29:05 +0000 (UTC)
Subject: Re: virtio-net: locking in tx napi
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210412175341-mutt-send-email-mst@kernel.org>
 <20210412183054-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cebebed3-7a92-5471-117f-774286731cf5@redhat.com>
Date: Tue, 13 Apr 2021 10:29:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210412183054-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Willem de Bruijn <willemb@google.com>,
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

CtTaIDIwMjEvNC8xMyDJz87nNjozMSwgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gT24gTW9u
LCBBcHIgMTIsIDIwMjEgYXQgMDY6MDM6NTBQTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdy
b3RlOgo+PiBJIHdhcyB3b3JraW5nIG9uIHRoZSBzcHVyaW9zIGludGVycnVwdCBwcm9ibGVtIGFu
ZAo+PiBJIG5vdGljZWQgc29tZXRoaW5nIHdlaXJkLgo+Pgo+PiBzdGF0aWMgaW50IHZpcnRuZXRf
cG9sbF90eChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4+IHsKPj4gICAg
ICAgICAgc3RydWN0IHNlbmRfcXVldWUgKnNxID0gY29udGFpbmVyX29mKG5hcGksIHN0cnVjdCBz
ZW5kX3F1ZXVlLCBuYXBpKTsKPj4gICAgICAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBz
cS0+dnEtPnZkZXYtPnByaXY7Cj4+ICAgICAgICAgIHVuc2lnbmVkIGludCBpbmRleCA9IHZxMnR4
cShzcS0+dnEpOwo+PiAgICAgICAgICBzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICp0eHE7Cj4+Cj4+ICAg
ICAgICAgIGlmICh1bmxpa2VseShpc194ZHBfcmF3X2J1ZmZlcl9xdWV1ZSh2aSwgaW5kZXgpKSkg
ewo+PiAgICAgICAgICAgICAgICAgIC8qIFdlIGRvbid0IG5lZWQgdG8gZW5hYmxlIGNiIGZvciBY
RFAgKi8KPj4gICAgICAgICAgICAgICAgICBuYXBpX2NvbXBsZXRlX2RvbmUobmFwaSwgMCk7Cj4+
ICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4+ICAgICAgICAgIH0KPj4KPj4gICAgICAgICAg
dHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2LCBpbmRleCk7Cj4+ICAgICAgICAgIF9f
bmV0aWZfdHhfbG9jayh0eHEsIHJhd19zbXBfcHJvY2Vzc29yX2lkKCkpOwo+PiAgICAgICAgICBm
cmVlX29sZF94bWl0X3NrYnMoc3EsIHRydWUpOwo+PiAgICAgICAgICBfX25ldGlmX3R4X3VubG9j
ayh0eHEpOwo+PiAgICAgICAgICAKPj4gICAgICAgICAgdmlydHF1ZXVlX25hcGlfY29tcGxldGUo
bmFwaSwgc3EtPnZxLCAwKTsKPj4gICAgICAgICAgCj4+ICAgICAgICAgIGlmIChzcS0+dnEtPm51
bV9mcmVlID49IDIgKyBNQVhfU0tCX0ZSQUdTKQo+PiAgICAgICAgICAgICAgICAgIG5ldGlmX3R4
X3dha2VfcXVldWUodHhxKTsKPj4gICAgICAgICAgCj4+ICAgICAgICAgIHJldHVybiAwOwo+PiB9
Cj4+Cj4+IFNvIHZpcnRxdWV1ZV9uYXBpX2NvbXBsZXRlIGlzIGNhbGxlZCB3aGVuIHR4cSBpcyBu
b3QgbG9ja2VkLAo+PiB0aGlua2FibHkgc3RhcnRfeG1pdCBjYW4gaGFwcGVuIHJpZ2h0PwoKClll
cywgSSB0aGluayBzby4KCgo+Pgo+PiBOb3cgdmlydHF1ZXVlX25hcGlfY29tcGxldGUKPj4KPj4g
c3RhdGljIHZvaWQgdmlydHF1ZXVlX25hcGlfY29tcGxldGUoc3RydWN0IG5hcGlfc3RydWN0ICpu
YXBpLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRx
dWV1ZSAqdnEsIGludCBwcm9jZXNzZWQpCj4+IHsKPj4gICAgICAgICAgaW50IG9wYXF1ZTsKPj4K
Pj4gICAgICAgICAgb3BhcXVlID0gdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVwYXJlKHZxKTsKPj4g
ICAgICAgICAgaWYgKG5hcGlfY29tcGxldGVfZG9uZShuYXBpLCBwcm9jZXNzZWQpKSB7Cj4+ICAg
ICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KHZpcnRxdWV1ZV9wb2xsKHZxLCBvcGFxdWUpKSkK
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRxdWV1ZV9uYXBpX3NjaGVkdWxlKG5hcGks
IHZxKTsKPj4gICAgICAgICAgfSBlbHNlIHsKPj4gICAgICAgICAgICAgICAgICB2aXJ0cXVldWVf
ZGlzYWJsZV9jYih2cSk7Cj4+ICAgICAgICAgIH0KPj4gfQo+Pgo+Pgo+PiBTbyBpdCBpcyBjYWxs
aW5nIHZpcnRxdWV1ZV9lbmFibGVfY2JfcHJlcGFyZSBidXQgdHggcXVldWUKPj4gY291bGQgYmUg
cnVubmluZyBhbmQgY2FuIHByb2Nlc3MgdGhpbmdzIGluIHBhcmFsbGVsIC4uLgo+PiBXaGF0IGdp
dmVzPyBJIHN1c3BlY3QgdGhpcyBjb3JydXB0cyB0aGUgcmluZywgYW5kIGV4cGxhaW5zCj4+IHdo
eSB3ZSBhcmUgc2VlaW5nIHdlaXJkIGhhbmdzIHdpdGggdmhvc3QgcGFja2VkIHJpbmcgLi4uCj4+
Cj4+IEphc29uPwoKCkl0IG1pZ2h0IGNhdXNlIHRoZSBpbnRlcnJ1cHQgdG8gYmUgZGlzYWJsZWQg
dW5leHBlY3RlZGx5IEkgdGhpbmsuCgoKPj4KPj4KPj4gLS0gCj4+IE1TVAo+IGFuZCB3b3VsZG4n
dCB0aGUgZm9sbG93aW5nIHVudGVzdGVkIHBhdGNoIG1ha2Ugc2Vuc2UgdGhlbj8KPgo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+IGluZGV4IDgyZTUyMGQyY2IxMi4uYzIzMzQxYjE4ZWI1IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+
IEBAIC0xNTA0LDYgKzE1MDUsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90eChzdHJ1Y3Qg
bmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4gICAJc3RydWN0IHZpcnRuZXRfaW5mbyAq
dmkgPSBzcS0+dnEtPnZkZXYtPnByaXY7Cj4gICAJdW5zaWduZWQgaW50IGluZGV4ID0gdnEydHhx
KHNxLT52cSk7Cj4gICAJc3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxOwo+ICsJaW50IG9wYXF1ZTsK
PiArCWJvb2wgZG9uZTsKPiAgIAo+ICAgCWlmICh1bmxpa2VseShpc194ZHBfcmF3X2J1ZmZlcl9x
dWV1ZSh2aSwgaW5kZXgpKSkgewo+ICAgCQkvKiBXZSBkb24ndCBuZWVkIHRvIGVuYWJsZSBjYiBm
b3IgWERQICovCj4gQEAgLTE1MTQsOSArMTUxNywyNiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9s
bF90eChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4gICAJdHhxID0gbmV0
ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2LCBpbmRleCk7Cj4gICAJX19uZXRpZl90eF9sb2NrKHR4
cSwgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSk7Cj4gICAJZnJlZV9vbGRfeG1pdF9za2JzKHNxLCB0
cnVlKTsKPiArCj4gKwlvcGFxdWUgPSB2aXJ0cXVldWVfZW5hYmxlX2NiX3ByZXBhcmUoc3EtPnZx
KTsKPiArCj4gKwlkb25lID0gbmFwaV9jb21wbGV0ZV9kb25lKG5hcGksIDApOwo+ICsKPiArCWlm
ICghZG9uZSkKPiArCQl2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+ICsKPiAgIAlfX25l
dGlmX3R4X3VubG9jayh0eHEpOwo+ICAgCj4gLQl2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZShuYXBp
LCBzcS0+dnEsIDApOwo+ICsJaWYgKGRvbmUpIHsKPiArCQlpZiAodW5saWtlbHkodmlydHF1ZXVl
X3BvbGwodnEsIG9wYXF1ZSkpKSB7Cj4gKwkJCWlmIChuYXBpX3NjaGVkdWxlX3ByZXAobmFwaSkp
IHsKPiArCQkJCV9fbmV0aWZfdHhfbG9jayh0eHEsIHJhd19zbXBfcHJvY2Vzc29yX2lkKCkpOwo+
ICsJCQkJdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiArCQkJCV9fbmV0aWZfdHhfdW5s
b2NrKHR4cSk7Cj4gKwkJCQlfX25hcGlfc2NoZWR1bGUobmFwaSk7Cj4gKwkJCX0KPiArCQl9Cj4g
Kwl9Cj4gICAKPiAgIAlpZiAoc3EtPnZxLT5udW1fZnJlZSA+PSAyICsgTUFYX1NLQl9GUkFHUykK
PiAgIAkJbmV0aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOwoKCkkgd29uZGVyIHdoeSBub3Qgc2ltcGx5
IHByb3RlY3QgdGhlIHdob2xlIHBvbGxfdHggd2l0aCB0eCBsb2NrIGluIHRoaXMgY2FzZT8KClRo
YW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
