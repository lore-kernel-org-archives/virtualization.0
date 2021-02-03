Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83454C433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 05:33:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5AB64F67
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 05:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5AB64F67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 44B358709F;
	Wed,  3 Feb 2021 05:33:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UKoj4BIQt7hy; Wed,  3 Feb 2021 05:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BBE028584C;
	Wed,  3 Feb 2021 05:33:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F9D2C0FA8;
	Wed,  3 Feb 2021 05:33:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75E5AC0174
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 05:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1949D86225
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 05:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PeKeHCYasBdR
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 05:33:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A96F28620B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 05:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612330401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7esztaqzpOGAAI18gsF8qUEx5go7znlIB5z7sLa2fys=;
 b=gKUPHDwbwuyL8eks2lkOlQZ2adxWjQzBUDH0/pxlAe87tr3kY1iui1546RdfVuRkUxoUn7
 wwFu6o+/8CGyVGB9nK5qrTPfFlgHFTeA2nOzG3LI0s/m/gxEP8r7F8zWnk6uDgakkHLMmC
 soBMpKSJF8siE9or0ioTJZE6Nil6cPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372--D-u0sMQOJ6J46_YSwRflA-1; Wed, 03 Feb 2021 00:33:18 -0500
X-MC-Unique: -D-u0sMQOJ6J46_YSwRflA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 281C119611A3;
 Wed,  3 Feb 2021 05:33:17 +0000 (UTC)
Received: from [10.72.13.97] (ovpn-13-97.pek2.redhat.com [10.72.13.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C343100AE2D;
 Wed,  3 Feb 2021 05:33:14 +0000 (UTC)
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20210129002136.70865-1-weiwan@google.com>
 <a0b2cb8d-eb8f-30fb-2a22-678e6dd2f58f@redhat.com>
 <CAF=yD-+aPBF2RaCR8L5orTM37bf7Z4Z8Qko2D2LZjOz0khHTUg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3a3e005d-f9b2-c16a-5ada-6e04242c618e@redhat.com>
Date: Wed, 3 Feb 2021 13:33:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-+aPBF2RaCR8L5orTM37bf7Z4Z8Qko2D2LZjOz0khHTUg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Willem de Bruijn <willemb@google.com>,
 Network Development <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

Ck9uIDIwMjEvMi8yIOS4i+WNiDEwOjM3LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+IE9uIE1v
biwgRmViIDEsIDIwMjEgYXQgMTA6MDkgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4+Cj4+IE9uIDIwMjEvMS8yOSDkuIrljYg4OjIxLCBXZWkgV2FuZyB3cm90ZToK
Pj4+IFdpdGggdGhlIGltcGxlbWVudGF0aW9uIG9mIG5hcGktdHggaW4gdmlydGlvIGRyaXZlciwg
d2UgY2xlYW4gdHgKPj4+IGRlc2NyaXB0b3JzIGZyb20gcnggbmFwaSBoYW5kbGVyLCBmb3IgdGhl
IHB1cnBvc2Ugb2YgcmVkdWNpbmcgdHgKPj4+IGNvbXBsZXRlIGludGVycnVwdHMuIEJ1dCB0aGlz
IGNvdWxkIGludHJvZHVjZSBhIHJhY2Ugd2hlcmUgdHggY29tcGxldGUKPj4+IGludGVycnVwdCBo
YXMgYmVlbiByYWlzZWQsIGJ1dCB0aGUgaGFuZGxlciBmb3VuZCB0aGVyZSBpcyBubyB3b3JrIHRv
IGRvCj4+PiBiZWNhdXNlIHdlIGhhdmUgZG9uZSB0aGUgd29yayBpbiB0aGUgcHJldmlvdXMgcngg
aW50ZXJydXB0IGhhbmRsZXIuCj4+PiBUaGlzIGNvdWxkIGxlYWQgdG8gdGhlIGZvbGxvd2luZyB3
YXJuaW5nIG1zZzoKPj4+IFsgMzU4OC4wMTA3NzhdIGlycSAzODogbm9ib2R5IGNhcmVkICh0cnkg
Ym9vdGluZyB3aXRoIHRoZQo+Pj4gImlycXBvbGwiIG9wdGlvbikKPj4+IFsgMzU4OC4wMTc5Mzhd
IENQVTogNCBQSUQ6IDAgQ29tbTogc3dhcHBlci80IE5vdCB0YWludGVkCj4+PiA1LjMuMC0xOS1n
ZW5lcmljICMyMH4xOC4wNC4yLVVidW50dQo+Pj4gWyAzNTg4LjAxNzk0MF0gQ2FsbCBUcmFjZToK
Pj4+IFsgMzU4OC4wMTc5NDJdICA8SVJRPgo+Pj4gWyAzNTg4LjAxNzk1MV0gIGR1bXBfc3RhY2sr
MHg2My8weDg1Cj4+PiBbIDM1ODguMDE3OTUzXSAgX19yZXBvcnRfYmFkX2lycSsweDM1LzB4YzAK
Pj4+IFsgMzU4OC4wMTc5NTVdICBub3RlX2ludGVycnVwdCsweDI0Yi8weDJhMAo+Pj4gWyAzNTg4
LjAxNzk1Nl0gIGhhbmRsZV9pcnFfZXZlbnRfcGVyY3B1KzB4NTQvMHg4MAo+Pj4gWyAzNTg4LjAx
Nzk1N10gIGhhbmRsZV9pcnFfZXZlbnQrMHgzYi8weDYwCj4+PiBbIDM1ODguMDE3OTU4XSAgaGFu
ZGxlX2VkZ2VfaXJxKzB4ODMvMHgxYTAKPj4+IFsgMzU4OC4wMTc5NjFdICBoYW5kbGVfaXJxKzB4
MjAvMHgzMAo+Pj4gWyAzNTg4LjAxNzk2NF0gIGRvX0lSUSsweDUwLzB4ZTAKPj4+IFsgMzU4OC4w
MTc5NjZdICBjb21tb25faW50ZXJydXB0KzB4Zi8weGYKPj4+IFsgMzU4OC4wMTc5NjZdICA8L0lS
UT4KPj4+IFsgMzU4OC4wMTc5ODldIGhhbmRsZXJzOgo+Pj4gWyAzNTg4LjAyMDM3NF0gWzwwMDAw
MDAwMDFiOWYxZGE4Pl0gdnJpbmdfaW50ZXJydXB0Cj4+PiBbIDM1ODguMDI1MDk5XSBEaXNhYmxp
bmcgSVJRICMzOAo+Pj4KPj4+IFRoaXMgcGF0Y2ggYWRkcyBhIG5ldyBwYXJhbSB0byBzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlLCBhbmQgd2Ugc2V0IGl0IGZvcgo+Pj4gdHggdmlydHF1ZXVlcyBpZiBu
YXBpLXR4IGlzIGVuYWJsZWQsIHRvIHN1cHByZXNzIHRoZSB3YXJuaW5nIGluIHN1Y2gKPj4+IGNh
c2UuCj4+Pgo+Pj4gRml4ZXM6IDdiMDQxMWVmNGFhNiAoInZpcnRpby1uZXQ6IGNsZWFuIHR4IGRl
c2NyaXB0b3JzIGZyb20gcnggbmFwaSIpCj4+PiBSZXBvcnRlZC1ieTogUmljayBKb25lcyA8am9u
ZXNyaWNrQGdvb2dsZS5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBXZWkgV2FuZyA8d2Vpd2FuQGdv
b2dsZS5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBXaWxsZW0gZGUgQnJ1aWpuIDx3aWxsZW1iQGdv
b2dsZS5jb20+Cj4+Cj4+IFBsZWFzZSB1c2UgZ2V0X21haW50YWluZXIucGwgdG8gbWFrZSBzdXJl
IE1pY2hhZWwgYW5kIG1lIHdlcmUgY2NlZC4KPiBXaWxsIGRvLiBTb3JyeSBhYm91dCB0aGF0LiBJ
IHN1Z2dlc3RlZCBqdXN0IHRoZSB2aXJ0dWFsaXphdGlvbiBsaXN0LCBteSBiYWQuCj4KPj4+IC0t
LQo+Pj4gICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jICAgICB8IDE5ICsrKysrKysrKysrKysr
LS0tLS0KPj4+ICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxNiArKysrKysrKysr
KysrKysrCj4+PiAgICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgIHwgIDIgKysKPj4+ICAg
IDMgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPj4+Cj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4+PiBpbmRleCA1MDg0MDhmYmU3OGYuLmU5YTNmMzA4NjRlOCAxMDA2NDQKPj4+
IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4+PiBAQCAtMTMwMywxMyArMTMwMywyMiBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0
X25hcGlfdHhfZW5hYmxlKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+Pj4gICAgICAgICAgICAg
ICAgcmV0dXJuOwo+Pj4gICAgICAgIH0KPj4+Cj4+PiArICAgICAvKiBXaXRoIG5hcGlfdHggZW5h
YmxlZCwgZnJlZV9vbGRfeG1pdF9za2JzKCkgY291bGQgYmUgY2FsbGVkIGZyb20KPj4+ICsgICAg
ICAqIHJ4IG5hcGkgaGFuZGxlci4gU2V0IHdvcmtfc3RlYWwgdG8gc3VwcHJlc3MgYmFkIGlycSB3
YXJuaW5nIGZvcgo+Pj4gKyAgICAgICogSVJRX05PTkUgY2FzZSBmcm9tIHR4IGNvbXBsZXRlIGlu
dGVycnVwdCBoYW5kbGVyLgo+Pj4gKyAgICAgICovCj4+PiArICAgICB2aXJ0cXVldWVfc2V0X3dv
cmtfc3RlYWwodnEsIHRydWUpOwo+Pj4gKwo+Pj4gICAgICAgIHJldHVybiB2aXJ0bmV0X25hcGlf
ZW5hYmxlKHZxLCBuYXBpKTsKPj4KPj4gRG8gd2UgbmVlZCB0byBmb3JjZSB0aGUgb3JkZXJpbmcg
YmV0d2VlbiBzdGVhbCBzZXQgYW5kIG5hcGkgZW5hYmxlPwo+IFRoZSB3YXJuaW5nIG9ubHkgb2Nj
dXJzIGFmdGVyIG9uZSBodW5kcmVkIHNwdXJpb3VzIGludGVycnVwdHMsIHNvIG5vdAo+IHJlYWxs
eS4KCgpPaywgc28gaXQgbG9va3MgbGlrZSBhIGhpbnQuIFRoZW4gSSB3b25kZXIgaG93IG11Y2gg
dmFsdWUgZG8gd2UgbmVlZCB0byAKaW50cm9kdWNlIGhlbHBlciBsaWtlIHZpcnRxdWV1ZV9zZXRf
d29ya19zdGVhbCgpIHRoYXQgYWxsb3dzIHRoZSBjYWxsZXIgCnRvIHRvZ2dsZS4gSG93IGFib3V0
IGRpc2FibGUgdGhlIGNoZWNrIGZvcmV2ZXIgZHVyaW5nIHZpcnRxdWV1ZSAKaW5pdGlhbGl6YXRp
b24/CgoKPgo+Pj4gICAgfQo+Pj4KPj4+IC1zdGF0aWMgdm9pZCB2aXJ0bmV0X25hcGlfdHhfZGlz
YWJsZShzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGkpCj4+PiArc3RhdGljIHZvaWQgdmlydG5ldF9u
YXBpX3R4X2Rpc2FibGUoc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpKQo+Pj4gICAgewo+Pj4g
LSAgICAgaWYgKG5hcGktPndlaWdodCkKPj4+ICsgICAgIGlmIChuYXBpLT53ZWlnaHQpIHsKPj4+
ICAgICAgICAgICAgICAgIG5hcGlfZGlzYWJsZShuYXBpKTsKPj4+ICsgICAgICAgICAgICAgdmly
dHF1ZXVlX3NldF93b3JrX3N0ZWFsKHZxLCBmYWxzZSk7Cj4+PiArICAgICB9Cj4+PiAgICB9Cj4+
Pgo+Pj4gICAgc3RhdGljIHZvaWQgcmVmaWxsX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3Jr
KQo+Pj4gQEAgLTE4MzUsNyArMTg0NCw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9jbG9zZShzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2KQo+Pj4gICAgICAgIGZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1
ZXVlX3BhaXJzOyBpKyspIHsKPj4+ICAgICAgICAgICAgICAgIHhkcF9yeHFfaW5mb191bnJlZygm
dmktPnJxW2ldLnhkcF9yeHEpOwo+Pj4gICAgICAgICAgICAgICAgbmFwaV9kaXNhYmxlKCZ2aS0+
cnFbaV0ubmFwaSk7Cj4+PiAtICAgICAgICAgICAgIHZpcnRuZXRfbmFwaV90eF9kaXNhYmxlKCZ2
aS0+c3FbaV0ubmFwaSk7Cj4+PiArICAgICAgICAgICAgIHZpcnRuZXRfbmFwaV90eF9kaXNhYmxl
KHZpLT5zcVtpXS52cSwgJnZpLT5zcVtpXS5uYXBpKTsKPj4+ICAgICAgICB9Cj4+Pgo+Pj4gICAg
ICAgIHJldHVybiAwOwo+Pj4gQEAgLTIzMTUsNyArMjMyNCw3IEBAIHN0YXRpYyB2b2lkIHZpcnRu
ZXRfZnJlZXplX2Rvd24oc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+PiAgICAgICAgaWYg
KG5ldGlmX3J1bm5pbmcodmktPmRldikpIHsKPj4+ICAgICAgICAgICAgICAgIGZvciAoaSA9IDA7
IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgbmFwaV9kaXNhYmxlKCZ2aS0+cnFbaV0ubmFwaSk7Cj4+PiAtICAgICAgICAgICAgICAgICAg
ICAgdmlydG5ldF9uYXBpX3R4X2Rpc2FibGUoJnZpLT5zcVtpXS5uYXBpKTsKPj4+ICsgICAgICAg
ICAgICAgICAgICAgICB2aXJ0bmV0X25hcGlfdHhfZGlzYWJsZSh2aS0+c3FbaV0udnEsICZ2aS0+
c3FbaV0ubmFwaSk7Cj4+PiAgICAgICAgICAgICAgICB9Cj4+PiAgICAgICAgfQo+Pj4gICAgfQo+
Pj4gQEAgLTI0NDAsNyArMjQ0OSw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfc2V0KHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYsIHN0cnVjdCBicGZfcHJvZyAqcHJvZywKPj4+ICAgICAgICBpZiAo
bmV0aWZfcnVubmluZyhkZXYpKSB7Cj4+PiAgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwg
dmktPm1heF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4+PiAgICAgICAgICAgICAgICAgICAgICAgIG5h
cGlfZGlzYWJsZSgmdmktPnJxW2ldLm5hcGkpOwo+Pj4gLSAgICAgICAgICAgICAgICAgICAgIHZp
cnRuZXRfbmFwaV90eF9kaXNhYmxlKCZ2aS0+c3FbaV0ubmFwaSk7Cj4+PiArICAgICAgICAgICAg
ICAgICAgICAgdmlydG5ldF9uYXBpX3R4X2Rpc2FibGUodmktPnNxW2ldLnZxLCAmdmktPnNxW2ld
Lm5hcGkpOwo+Pj4gICAgICAgICAgICAgICAgfQo+Pj4gICAgICAgIH0KPj4+Cj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPj4+IGluZGV4IDcxZTE2YjUzZTljMS4uZjdjNWQ2OTdjMzAyIDEwMDY0NAo+Pj4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+Pj4gKysrIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+Pj4gQEAgLTEwNSw2ICsxMDUsOSBAQCBzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlIHsKPj4+ICAgICAgICAvKiBIb3N0IHB1Ymxpc2hlcyBhdmFpbCBldmVudCBpZHggKi8K
Pj4+ICAgICAgICBib29sIGV2ZW50Owo+Pj4KPj4+ICsgICAgIC8qIFR4IHNpZGUgbmFwaSB3b3Jr
IGNvdWxkIGJlIGRvbmUgZnJvbSByeCBzaWRlLiAqLwo+Pj4gKyAgICAgYm9vbCB3b3JrX3N0ZWFs
Owo+Pgo+PiBTbyB2cmluZ192cml0cXVldWUgaXMgYSBnZW5lcmFsIHN0cnVjdHVyZSwgbGV0J3Mg
YXZvaWQgbWVudGlvbmluZwo+PiBuZXR3b3JrIHNwZWNpZmljIHN0dWZmcyBoZXJlLiBBbmQgd2Ug
bmVlZCBhIGJldHRlciBuYW1lIGxpa2UKPj4gIm5vX2ludGVycnVwdF9jaGVjayI/Cj4+Cj4+IEFu
ZCB3ZSBuZWVkIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHZpcnRpbyBjb3JlIGNoYW5nZXMuCj4gQWNr
LiBXaWxsIGNoYW5nZS4KPgo+Pj4gKwo+Pj4gICAgICAgIC8qIEhlYWQgb2YgZnJlZSBidWZmZXIg
bGlzdC4gKi8KPj4+ICAgICAgICB1bnNpZ25lZCBpbnQgZnJlZV9oZWFkOwo+Pj4gICAgICAgIC8q
IE51bWJlciB3ZSd2ZSBhZGRlZCBzaW5jZSBsYXN0IHN5bmMuICovCj4+PiBAQCAtMTYwNCw2ICsx
NjA3LDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVf
cGFja2VkKAo+Pj4gICAgICAgIHZxLT5ub3RpZnkgPSBub3RpZnk7Cj4+PiAgICAgICAgdnEtPndl
YWtfYmFycmllcnMgPSB3ZWFrX2JhcnJpZXJzOwo+Pj4gICAgICAgIHZxLT5icm9rZW4gPSBmYWxz
ZTsKPj4+ICsgICAgIHZxLT53b3JrX3N0ZWFsID0gZmFsc2U7Cj4+PiAgICAgICAgdnEtPmxhc3Rf
dXNlZF9pZHggPSAwOwo+Pj4gICAgICAgIHZxLT5udW1fYWRkZWQgPSAwOwo+Pj4gICAgICAgIHZx
LT5wYWNrZWRfcmluZyA9IHRydWU7Cj4+PiBAQCAtMjAzOCw2ICsyMDQyLDkgQEAgaXJxcmV0dXJu
X3QgdnJpbmdfaW50ZXJydXB0KGludCBpcnEsIHZvaWQgKl92cSkKPj4+Cj4+PiAgICAgICAgaWYg
KCFtb3JlX3VzZWQodnEpKSB7Cj4+PiAgICAgICAgICAgICAgICBwcl9kZWJ1ZygidmlydHF1ZXVl
IGludGVycnVwdCB3aXRoIG5vIHdvcmsgZm9yICVwXG4iLCB2cSk7Cj4+Cj4+IERvIHdlIHN0aWxs
IG5lZWQgdG8ga2VlcCB0aGlzIHdhcm5pbmc/Cj4gQ29tZSB0byB0aGluayBvZiBpdCwgSSB3b3Vs
ZCBzYXkgbm8sIGluIHRoaXMgY2FzZS4KPgo+Pgo+Pj4gKyAgICAgICAgICAgICBpZiAodnEtPndv
cmtfc3RlYWwpCj4+PiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIElSUV9IQU5ETEVEOwo+
Pgo+PiBTbyBJIHdvbmRlciBpbnN0ZWFkIG9mIGRvaW5nIHRyaWNrIGxpa2UgdGhpcywgbWF5YmUg
aXQncyB0aW1lIHRvIHVuaWZ5Cj4+IFRYL1JYIE5BUEkgd2l0aCB0aGUgaGVscCBvZlsxXSAodmly
dGlvLW5ldCB1c2UgcXVldWUgcGFpcnMpLgo+Pgo+PiBUaGFua3MKPj4KPj4gWzFdIGh0dHBzOi8v
bGttbC5vcmcvbGttbC8yMDE0LzEyLzI1LzE2OQo+IEludGVyZXN0aW5nIGlkZWEuIEl0IGRvZXMg
c291bmQgbGlrZSBhIGdvb2QgZml0IGZvciB0aGlzIG1vZGVsLiBUaGUKPiBwYXRjaCBpbiB0aGUg
Rml4ZXMgbGluZSBwcm92ZWQgZWZmZWN0aXZlIGF0IHN1cHByZXNzaW5nIHVubmVjZXNzYXJ5IFRY
Cj4gaW50ZXJydXB0cyB3aGVuIHByb2Nlc3NpbmcgaW4gUlggaW50ZXJydXB0IGhhbmRsZXIuIFNv
IG5vdCBzdXJlIGhvdwo+IG11Y2ggd2lsbCBoZWxwIGluIHByYWN0aWNlLiBNaWdodCBiZSBhIG5p
Y2UgcHJvamVjdCB0byBldmFsdWF0ZQo+IHNlcGFyYXRlIGZvciBuZXQtbmV4dCBhdCBzb21lIHBv
aW50LgoKClJpZ2h0LCBiYXNpY2FsbHkgdGhlIGlkZWEgaXMgdGhhdCBpZiBhbiBpcnEgaXMgc2hh
cmVkIGFtb25nIHNldmVyYWwgCnZpcnRxdWV1ZXMsIHRoZXJlJ3Mgbm8gbmVlZCB0byBjaGVjayBm
b3IgbW9yZV91c2VkKCkgdGhlcmUuCgpZZXMsIHdlIGNhbiB0cnkgc29tZXRpbWUgaW4gdGhlIGZ1
dHVyZS4gKE9yIGUuZyB3ZSBoYXZlIG1vcmUgdGhhbiAxMjggCnF1ZXVlIHBhaXJzKS4KClRoYW5r
cwoKCj4KPiBUaGFua3MgZm9yIHRoZSByZXZpZXchCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
