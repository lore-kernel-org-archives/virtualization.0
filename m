Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27999C678D5
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 06:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BEC6F40439;
	Tue,  7 Mar 2023 06:57:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BEC6F40439
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNVtWhGPCkF9; Tue,  7 Mar 2023 06:57:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48547402F3;
	Tue,  7 Mar 2023 06:57:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48547402F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23CD3C0035;
	Tue,  7 Mar 2023 06:57:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2E56C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9228E4036A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:57:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9228E4036A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aG0Vu9QK0s0O
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:57:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 595F5402F3
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 595F5402F3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:57:54 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VdKH3p1_1678172270; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VdKH3p1_1678172270) by smtp.aliyun-inc.com;
 Tue, 07 Mar 2023 14:57:51 +0800
Message-ID: <1678172249.9158993-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v1 04/12] virtio_ring: packed: separate prepare code
 from virtuque_add_indirect_packed()
Date: Tue, 7 Mar 2023 14:57:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
 <20230302115908.1461-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEtY7L1jFRXdkFVtYAbk6dzQZRJ-eaG8w-NthNBcu42A_w@mail.gmail.com>
In-Reply-To: <CACGkMEtY7L1jFRXdkFVtYAbk6dzQZRJ-eaG8w-NthNBcu42A_w@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCA3IE1hciAyMDIzIDE0OjQzOjQ1ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUaHUsIE1hciAyLCAyMDIzIGF0IDc6NTnigK9QTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBTZXBhcmF0
aW5nIHRoZSBsb2dpYyBvZiBhbGxvY2F0aW5nIGluZGlyZWN0IGRlc2MgYW5kIGNoZWNraW5nIHF1
ZXVlCj4gPiBzdGF0dXMgdG8gdGhlIHVwcGVyIGxheWVyIGZ1bmN0aW9uLgo+Cj4gTm90ZSB0aGF0
IGl0IGxvb2tzIHRvIG1lIGl0J3Mgbm90IGxvZ2ljIHNlcGFyYXRpb24gYnV0IGEgc2ltcGxlIG1v
dmluZy4KCgpJIHdpbGwgZml4IHRoZSBjb21taXQgbG9nLgoKVGhhbmtzLgoKCj4KPgo+ID4KPiA+
IFRoZSBwcm9wb3NhbCBvZiB0aGlzIGlzIGNvbnZlbmllbnQgdG8gcmVmYWN0b3IgdmlydHF1ZXVl
X2FkZF9wYWNrZWQoKQo+ID4gZm9yIHByZW1hcHBlZC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI5ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQo+
ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gaW5kZXggNWIxODZjZTczZDM1Li4xNzhlZGYxMTcx
ZTIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBAQCAtMTM0OCwyNSArMTM0OCwxNCBA
QCBzdGF0aWMgaW50IHZpcnRxdWV1ZV9hZGRfaW5kaXJlY3RfcGFja2VkKHN0cnVjdCB2cmluZ192
aXJ0cXVldWUgKnZxLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1bnNpZ25lZCBpbnQgb3V0X3NncywKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaW50IGluX3NncywKPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0YSwKPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ2ZwX3QgZ2ZwKQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2MgKmRlc2MpCj4gPiAg
ewo+ID4gLSAgICAgICBzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2MgKmRlc2M7Cj4gPiAgICAgICAg
IHN0cnVjdCBzY2F0dGVybGlzdCAqc2c7Cj4gPiAgICAgICAgIHVuc2lnbmVkIGludCBpLCBuLCBl
cnJfaWR4Owo+ID4gICAgICAgICB1MTYgaGVhZCwgaWQ7Cj4gPiAgICAgICAgIGRtYV9hZGRyX3Qg
YWRkcjsKPiA+Cj4gPiAgICAgICAgIGhlYWQgPSB2cS0+cGFja2VkLm5leHRfYXZhaWxfaWR4Owo+
ID4gLSAgICAgICBkZXNjID0gYWxsb2NfaW5kaXJlY3RfcGFja2VkKHRvdGFsX3NnLCBnZnApOwo+
ID4gLSAgICAgICBpZiAoIWRlc2MpCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07
Cj4gPiAtCj4gPiAtICAgICAgIGlmICh1bmxpa2VseSh2cS0+dnEubnVtX2ZyZWUgPCAxKSkgewo+
ID4gLSAgICAgICAgICAgICAgIHByX2RlYnVnKCJDYW4ndCBhZGQgYnVmIGxlbiAxIC0gYXZhaWwg
PSAwXG4iKTsKPiA+IC0gICAgICAgICAgICAgICBrZnJlZShkZXNjKTsKPiA+IC0gICAgICAgICAg
ICAgICBFTkRfVVNFKHZxKTsKPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVOT1NQQzsKPiA+
IC0gICAgICAgfQo+ID4KPiA+ICAgICAgICAgaSA9IDA7Cj4gPiAgICAgICAgIGlkID0gdnEtPmZy
ZWVfaGVhZDsKPiA+IEBAIC0xNDg4LDExICsxNDc3LDE3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZp
cnRxdWV1ZV9hZGRfcGFja2VkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiA+ICAgICAgICAgQlVH
X09OKHRvdGFsX3NnID09IDApOwo+ID4KPiA+ICAgICAgICAgaWYgKHZpcnRxdWV1ZV91c2VfaW5k
aXJlY3QodnEsIHRvdGFsX3NnKSkgewo+ID4gLSAgICAgICAgICAgICAgIGVyciA9IHZpcnRxdWV1
ZV9hZGRfaW5kaXJlY3RfcGFja2VkKHZxLCBzZ3MsIHRvdGFsX3NnLCBvdXRfc2dzLAo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluX3Nncywg
ZGF0YSwgZ2ZwKTsKPiA+IC0gICAgICAgICAgICAgICBpZiAoZXJyICE9IC1FTk9NRU0pIHsKPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgIEVORF9VU0UodnEpOwo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIGVycjsKPiA+ICsgICAgICAgICAgICAgICBkZXNjID0gYWxsb2NfaW5k
aXJlY3RfcGFja2VkKHRvdGFsX3NnLCBnZnApOwo+ID4gKyAgICAgICAgICAgICAgIGlmIChkZXNj
KSB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkodnEtPnZxLm51bV9m
cmVlIDwgMSkpIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJfZGVidWco
IkNhbid0IGFkZCBidWYgbGVuIDEgLSBhdmFpbCA9IDBcbiIpOwo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBrZnJlZShkZXNjKTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRU5EX1VTRSh2cSk7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAtRU5PU1BDOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfQo+ID4gKwo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHZpcnRxdWV1ZV9hZGRfaW5kaXJlY3RfcGFj
a2VkKHZxLCBzZ3MsIHRvdGFsX3NnLCBvdXRfc2dzLAo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluX3NncywgZGF0YSwgZGVz
Yyk7Cj4gPiAgICAgICAgICAgICAgICAgfQo+ID4KPiA+ICAgICAgICAgICAgICAgICAvKiBmYWxs
IGJhY2sgb24gZGlyZWN0ICovCj4gPiAtLQo+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4KPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
