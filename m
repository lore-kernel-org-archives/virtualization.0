Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3CBC4361B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 03:13:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1E522CA0
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 03:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1E522CA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 615BD877B4;
	Mon,  7 Dec 2020 03:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oy6qb35lI63w; Mon,  7 Dec 2020 03:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10CB986E4E;
	Mon,  7 Dec 2020 03:13:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D83C3C0FA7;
	Mon,  7 Dec 2020 03:13:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFEB4C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C42FF86E4E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b5Vv66M4ciVe
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:13:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8B3BD86E57
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 03:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607310788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tyqx0n2wiRk01BnAx7gZU3drnJqHx5Dd1+WachDCKXM=;
 b=CqQrThmf3y2pb3hZXllTZbvvaqIHwSmgymOK8S+1AlwoWbXQfu2J5ugIMVlZnyCSe5Nuar
 RgLi8MSeWbAgp4i1ljmkfbP1oZaZTkyFTY6fScT4dH0xwMgzZQPEvoTnACiLd+hBz9Z4+9
 ajmTWfUz5JbI99+G+Hy0ICJmzAR1pok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-RAZE5x0oNVqj6l6BR1IHaQ-1; Sun, 06 Dec 2020 22:13:05 -0500
X-MC-Unique: RAZE5x0oNVqj6l6BR1IHaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 316AB858183;
 Mon,  7 Dec 2020 03:13:03 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B38E91002382;
 Mon,  7 Dec 2020 03:12:51 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] drivers: gpio: add virtio-gpio guest driver
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <8209ce55-a4aa-f256-b9b9-f7eb3cac877b@redhat.com>
 <96aca1e6-2d5a-deb1-2444-88f938c7a9de@metux.net>
 <20201205142218-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <842519cc-94ca-3c11-ddd6-543e5a89c998@redhat.com>
Date: Mon, 7 Dec 2020 11:12:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201205142218-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: stefanha@redhat.com, linux-doc@vger.kernel.org, linus.walleij@linaro.org,
 corbet@lwn.net, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, bgolaszewski@baylibre.com,
 linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org, msuchanek@suse.de,
 "Enrico Weigelt, metux IT consult" <info@metux.net>
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

Ck9uIDIwMjAvMTIvNiDkuIrljYgzOjMyLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
U2F0LCBEZWMgMDUsIDIwMjAgYXQgMDg6NTk6NTVBTSArMDEwMCwgRW5yaWNvIFdlaWdlbHQsIG1l
dHV4IElUIGNvbnN1bHQgd3JvdGU6Cj4+IE9uIDA0LjEyLjIwIDA0OjM1LCBKYXNvbiBXYW5nIHdy
b3RlOgo+Pgo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3Bpby9LY29uZmlnCj4+Pj4gKysrIGIvZHJpdmVy
cy9ncGlvL0tjb25maWcKPj4+PiBAQCAtMTYxNSw2ICsxNjE1LDE1IEBAIGNvbmZpZyBHUElPX01P
Q0tVUAo+Pj4+IMOCwqDDgsKgw4LCoMOCwqDDgsKgw4LCoMOCwqAgdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvZ3Bpby9ncGlvLW1vY2t1cC5zaC4gUmVmZXJlbmNlIHRoZQo+Pj4+IHVzYWdlIGluCj4+
Pj4gw4LCoMOCwqDDgsKgw4LCoMOCwqDDgsKgw4LCoCBpdC4KPj4+PiDDgsKgICtjb25maWcgR1BJ
T19WSVJUSU8KPj4+PiArw4LCoMOCwqDDgsKgIHRyaXN0YXRlICJWaXJ0SU8gR1BJTyBzdXBwb3J0
Igo+Pj4+ICvDgsKgw4LCoMOCwqAgZGVwZW5kcyBvbiBWSVJUSU8KPj4+Cj4+PiBMZXQncyB1c2Ug
c2VsZWN0LCBzaW5jZSB0aGVyZSdzIG5vIHByb21wdCBmb3IgVklSVElPIGFuZCBpdCBkb2Vzbid0
IGhhdmUKPj4+IGFueSBkZXBlbmRlbmNpZXMuCj4+IHdob29wcywgaXQncyBub3QgdGhhdCBzaW1w
bGU6Cj4+Cj4+IG1ha2U6IEVudGVyaW5nIGRpcmVjdG9yeSAnL2hvbWUvbmVrcmFkL3NyYy9hcHUy
LWRldi9wa2cva2VybmVsLmFwdTIuZ2l0Jwo+PiBtYWtlWzFdOiBFbnRlcmluZyBkaXJlY3RvcnkK
Pj4gJy9ob21lL25la3JhZC9zcmMvZGsvRGlzdHJvS2l0L3BsYXRmb3JtLXg4Nl82NC9idWlsZC10
YXJnZXQvbGludXgtNS44LjktYnVpbGQnCj4+ICAgIEdFTiAgICAgTWFrZWZpbGUKPj4gZHJpdmVy
cy9ncHUvZHJtL0tjb25maWc6NzQ6ZXJyb3I6IHJlY3Vyc2l2ZSBkZXBlbmRlbmN5IGRldGVjdGVk
IQo+PiBkcml2ZXJzL2dwdS9kcm0vS2NvbmZpZzo3NDoJc3ltYm9sIERSTV9LTVNfSEVMUEVSIGlz
IHNlbGVjdGVkIGJ5Cj4+IERSTV9WSVJUSU9fR1BVCj4+IGRyaXZlcnMvZ3B1L2RybS92aXJ0aW8v
S2NvbmZpZzoyOglzeW1ib2wgRFJNX1ZJUlRJT19HUFUgZGVwZW5kcyBvbiBWSVJUSU8KPj4gZHJp
dmVycy92aXJ0aW8vS2NvbmZpZzoyOglzeW1ib2wgVklSVElPIGlzIHNlbGVjdGVkIGJ5IEdQSU9f
VklSVElPCj4+IGRyaXZlcnMvZ3Bpby9LY29uZmlnOjE2MTg6CXN5bWJvbCBHUElPX1ZJUlRJTyBk
ZXBlbmRzIG9uIEdQSU9MSUIKPj4gZHJpdmVycy9ncGlvL0tjb25maWc6MTQ6CXN5bWJvbCBHUElP
TElCIGlzIHNlbGVjdGVkIGJ5IEkyQ19NVVhfTFRDNDMwNgo+PiBkcml2ZXJzL2kyYy9tdXhlcy9L
Y29uZmlnOjQ3OglzeW1ib2wgSTJDX01VWF9MVEM0MzA2IGRlcGVuZHMgb24gSTJDCj4+IGRyaXZl
cnMvaTJjL0tjb25maWc6ODoJc3ltYm9sIEkyQyBpcyBzZWxlY3RlZCBieSBGQl9EREMKPj4gZHJp
dmVycy92aWRlby9mYmRldi9LY29uZmlnOjYzOglzeW1ib2wgRkJfRERDIGRlcGVuZHMgb24gRkIK
Pj4gZHJpdmVycy92aWRlby9mYmRldi9LY29uZmlnOjEyOglzeW1ib2wgRkIgaXMgc2VsZWN0ZWQg
YnkgRFJNX0tNU19GQl9IRUxQRVIKPj4gZHJpdmVycy9ncHUvZHJtL0tjb25maWc6ODA6CXN5bWJv
bCBEUk1fS01TX0ZCX0hFTFBFUiBkZXBlbmRzIG9uCj4+IERSTV9LTVNfSEVMUEVSCj4+Cj4+IFNl
ZW1zIHRoYXQgd2UgY2FuIG9ubHkgZGVwZW5kIG9uIG9yIHNlbGVjdCBzb21lIHN5bWJvbCAtIHdl
IHJ1biBpbnRvCj4+IGh1Z2UgdHJvdWJsZSBpZiB0aGF0cyBtaXhlZC4gSnVzdCBjaGFuZ2VkIERS
TV9WSVJUSU9fR1BVIHRvIGp1c3Qgc2VsZWN0Cj4+IFZJUklPIGluc3RlYWQgb2YgZGVwZW5kaW5n
IG9uIGl0LCBhbmQgbm93IGl0IHdvcmtzLgo+Pgo+PiBJJ3ZlIHBvc3RlZCBhbm90aGVyIHBhdGNo
IGZvciBmaXhpbmcgZHJpdmVycy9ncHUvZHJtL3ZpcnRpby9LY29uZmlnCj4+IHRvIHVzZSAnc2Vs
ZWN0JyBpbnN0ZWFkIG9mICdkZXBlbmRzIG9uJy4KPiBJdCBzZWVtcyBhIGJpdCBvZiBhIG1lc3Ms
IGF0IHRoaXMgcG9pbnQgSSdtIG5vdCBlbnRpcmVseSBzdXJlIHdoZW4KPiBzaG91bGQgZHJpdmVy
cyBzZWxlY3QgVklSVElPIGFuZCB3aGVuIGRlcGVuZCBvbiBpdC4KPgo+IFRoZSB0ZXh0IG5lYXIg
aXQgc2F5czoKPgo+ICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQo+IGNv
bmZpZyBWSVJUSU8KPiAgICAgICAgICB0cmlzdGF0ZQo+ICAgICAgICAgIGhlbHAKPiAgICAgICAg
ICAgIFRoaXMgb3B0aW9uIGlzIHNlbGVjdGVkIGJ5IGFueSBkcml2ZXIgd2hpY2ggaW1wbGVtZW50
cyB0aGUgdmlydGlvCj4gICAgICAgICAgICBidXMsIHN1Y2ggYXMgQ09ORklHX1ZJUlRJT19QQ0ks
IENPTkZJR19WSVJUSU9fTU1JTywgQ09ORklHX1JQTVNHCj4gICAgICAgICAgICBvciBDT05GSUdf
UzM5MF9HVUVTVC4KPgo+IFdoaWNoIHNlZW1zIGNsZWFyIGVub3VnaCBhbmQgd291bGQgaW5kaWNh
dGUgZHJpdmVycyBmb3IgZGV2aWNlcyAqYmVoaW5kKgo+IHRoZSBidXMgc2hvdWxkIG5vdCBzZWxl
Y3QgVklSVElPIGFuZCB0aHVzIHByZXN1bWFibHkgc2hvdWxkICJkZXBlbmQgb24iIGl0Lgo+IFRo
aXMgaXMgdmlvbGF0ZWQgaW4gdmlydGlvIGNvbnNvbGUgYW5kIHZpcnRpbyBmcyBkcml2ZXJzLgo+
Cj4gRm9yIGNvbnNvbGUgaXQgc2F5czoKPgo+IGNvbW1pdCA5ZjMwZWIyOWM1MTQ1ODllMTZmMjk5
OWVhMDcwNTk4NTgzZDFmNmVjCj4gQXV0aG9yOiBNaWNoYWwgU3VjaGFuZWsgPG1zdWNoYW5la0Bz
dXNlLmRlPgo+IERhdGU6ICAgTW9uIEF1ZyAzMSAxODo1ODo1MCAyMDIwICswMjAwCj4KPiAgICAg
IGNoYXI6IHZpcnRpbzogU2VsZWN0IFZJUlRJTyBmcm9tIFZJUlRJT19DT05TT0xFLgo+ICAgICAg
Cj4gICAgICBNYWtlIGl0IHBvc3NpYmxlIHRvIGhhdmUgdmlydGlvIGNvbnNvbGUgYnVpbHQtaW4g
d2hlbgo+ICAgICAgb3RoZXIgdmlydGlvIGRyaXZlcnMgYXJlIG1vZHVsYXIuCj4gICAgICAKPiAg
ICAgIFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBTdWNoYW5layA8bXN1Y2hhbmVrQHN1c2UuZGU+Cj4g
ICAgICBSZXZpZXdlZC1ieTogQW1pdCBTaGFoIDxhbWl0QGtlcm5lbC5vcmc+Cj4gICAgICBMaW5r
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjAwODMxMTY1ODUwLjI2MTYzLTEtbXN1Y2hh
bmVrQHN1c2UuZGUKPiAgICAgIFNpZ25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+Cj4KPiB3aGljaCBzZWVtcyBraW5kIG9mIGJvZ3VzIC0g
d2h5IGRvIHdlIGNhcmUgYWJvdXQgYWxsb3dpbmcgYSBidWlsdGluCj4gdmlydGlvIGNvbnNvbGUg
ZHJpdmVyIGlmIHRoZSBwY2kgdmlydGlvIGJ1cyBkcml2ZXIgaXMgYSBtb2R1bGU/Cj4gVGhlcmUg
d29uJ3QgYmUgYW55IGRldmljZXMgb24gdGhlIGJ1cyB0byBhdHRhY2ggdG8gLi4uCgoKRm9yIHRl
c3RpbmcgbGlrZSBzd2l0Y2hpbmcgYnVzIGZyb20gcGNpIHRvIE1NSU8/CgoKPiBBbmQgZm9yIHZp
cnRpbyBmcyBpdCB3YXMgbGlrZSB0aGlzIGZyb20gdGhlIGJlZ2lubmluZy4KPgo+IEkgYW0gaW5j
bGluZWQgdG8gZml4IGNvbnNvbGUgYW5kIHZpcnRpbyBmcyB0byBkZXBlbmQgb24gVklSVElPOgo+
IHNlbGVjdCBpcyBoYXJkZXIgdG8gdXNlIGNvcnJlY3RseSAuLi4KPgo+IEphc29uPwoKCkkgdGhp
bmsgaXQgd29ya3MsIGJ1dCB3ZSBuZWVkIGEgcHJvbXB0IGZvciBWSVJUSU8gb3RoZXJ3aXNlIHRo
ZXJlJ3Mgbm8gCndheSB0byBlbmFibGUgaXQuCgpUaGFua3MKCgo+Cj4KPj4gLS0gCj4+IC0tLQo+
PiBIaW53ZWlzOiB1bnZlcnNjaGzDg8K8c3NlbHRlIEUtTWFpbHMga8ODwrZubmVuIGxlaWNodCBh
YmdlaMODwrZydCB1bmQgbWFuaXB1bGllcnQKPj4gd2VyZGVuICEgRsODwrxyIGVpbmUgdmVydHJh
dWxpY2hlIEtvbW11bmlrYXRpb24gc2VuZGVuIFNpZSBiaXR0ZSBpaHJlbgo+PiBHUEcvUEdQLVNj
aGzDg8K8c3NlbCB6dS4KPj4gLS0tCj4+IEVucmljbyBXZWlnZWx0LCBtZXR1eCBJVCBjb25zdWx0
Cj4+IEZyZWUgc29mdHdhcmUgYW5kIExpbnV4IGVtYmVkZGVkIGVuZ2luZWVyaW5nCj4+IGluZm9A
bWV0dXgubmV0IC0tICs0OS0xNTEtMjc1NjUyODcKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
