Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D6AC433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 08:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45A044101D;
	Thu, 24 Mar 2022 08:28:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cvj_V0JVMnH9; Thu, 24 Mar 2022 08:28:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9F9DF400CB;
	Thu, 24 Mar 2022 08:28:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7828AC001A;
	Thu, 24 Mar 2022 08:28:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 769B6C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64564405CD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GiqI3zVXTRqB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:28:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C1D1A400CB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:28:29 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V847Q1e_1648110503; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V847Q1e_1648110503) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Mar 2022 16:28:24 +0800
Message-ID: <1648110488.2137656-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v8 07/16] virtio_ring: split: extract the logic of alloc
 state and extra
Date: Thu, 24 Mar 2022 16:28:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-8-xuanzhuo@linux.alibaba.com>
 <910406b9-2693-c52e-4214-7a47f40100f7@redhat.com>
In-Reply-To: <910406b9-2693-c52e-4214-7a47f40100f7@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCAyMiBNYXIgMjAyMiAxNDozMzozNCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi8zLzE0IOS4i+WNiDU6MzQsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBTZXBhcmF0ZSB0aGUgbG9naWMgb2YgY3JlYXRpbmcgZGVzY19zdGF0ZSwg
ZGVzY19leHRyYSwgYW5kIHN1YnNlcXVlbnQKPiA+IHBhdGNoZXMgd2lsbCBjYWxsIGl0IGluZGVw
ZW5kZW50bHkuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
IHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPiA+IGluZGV4IGQ3NjY3Zjc0YzQyYi4uOWI4NTAxODhjMzhlIDEwMDY0NAo+ID4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gKysrIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+ID4gQEAgLTIxODYsNiArMjE4NiwzMyBAQCBpcnFyZXR1cm5fdCB2
cmluZ19pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqX3ZxKQo+ID4gICB9Cj4gPiAgIEVYUE9SVF9T
WU1CT0xfR1BMKHZyaW5nX2ludGVycnVwdCk7Cj4gPgo+ID4gK3N0YXRpYyBpbnQgX192cmluZ19h
bGxvY19zdGF0ZV9leHRyYV9zcGxpdCh1MzIgbnVtLAo+ID4gKwkJCQkJICAgc3RydWN0IHZyaW5n
X2Rlc2Nfc3RhdGVfc3BsaXQgKipkZXNjX3N0YXRlLAo+ID4gKwkJCQkJICAgc3RydWN0IHZyaW5n
X2Rlc2NfZXh0cmEgKipkZXNjX2V4dHJhKQo+Cj4KPiBBIG5pdCBoZXJlOiBJIHRoaW5rIHdlIGNh
biBzaW1wbHkgcmVtb3ZlIHRoZSAiX18iIHByZWZpeCBzaW5jZToKPgo+IDEpIFdlIGhhdmVuJ3Qg
aGFkIGEgdmVyc2lvbiBvZiBoZWxwZXIgd2l0aG91dCAiX18iCj4KPiAyKSBUaGVyZSdyZSBvdGhl
ciBpbnRlcm5hbCBoZWxwZXJzIHRoYXQgZG9lc24ndCB1c2UgIl9fIgoKT0suCgpUaGFua3MuCgo+
Cj4gVGhhbmtzCj4KPgo+ID4gK3sKPiA+ICsJc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQg
KnN0YXRlOwo+ID4gKwlzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqZXh0cmE7Cj4gPiArCj4gPiAr
CXN0YXRlID0ga21hbGxvY19hcnJheShudW0sIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0
ZV9zcGxpdCksIEdGUF9LRVJORUwpOwo+ID4gKwlpZiAoIXN0YXRlKQo+ID4gKwkJZ290byBlcnJf
c3RhdGU7Cj4gPiArCj4gPiArCWV4dHJhID0gdnJpbmdfYWxsb2NfZGVzY19leHRyYShudW0pOwo+
ID4gKwlpZiAoIWV4dHJhKQo+ID4gKwkJZ290byBlcnJfZXh0cmE7Cj4gPiArCj4gPiArCW1lbXNl
dChzdGF0ZSwgMCwgbnVtICogc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSk7
Cj4gPiArCj4gPiArCSpkZXNjX3N0YXRlID0gc3RhdGU7Cj4gPiArCSpkZXNjX2V4dHJhID0gZXh0
cmE7Cj4gPiArCXJldHVybiAwOwo+ID4gKwo+ID4gK2Vycl9leHRyYToKPiA+ICsJa2ZyZWUoc3Rh
dGUpOwo+ID4gK2Vycl9zdGF0ZToKPiA+ICsJcmV0dXJuIC1FTk9NRU07Cj4gPiArfQo+ID4gKwo+
ID4gICAvKiBPbmx5IGF2YWlsYWJsZSBmb3Igc3BsaXQgcmluZyAqLwo+ID4gICBzdHJ1Y3Qgdmly
dHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4gICAJ
CQkJCXN0cnVjdCB2cmluZyB2cmluZywKPiA+IEBAIC0yMTk2LDcgKzIyMjMsMTAgQEAgc3RydWN0
IHZpcnRxdWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiA+
ICAgCQkJCQl2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiAgIAkJCQkJ
Y29uc3QgY2hhciAqbmFtZSkKPiA+ICAgewo+ID4gKwlzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9z
cGxpdCAqc3RhdGU7Cj4gPiArCXN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICpleHRyYTsKPiA+ICAg
CXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxOwo+ID4gKwlpbnQgZXJyOwo+ID4KPiA+ICAgCWlm
ICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0ZfUklOR19QQUNLRUQpKQo+ID4gICAJ
CXJldHVybiBOVUxMOwo+ID4gQEAgLTIyNDYsMzAgKzIyNzYsMjIgQEAgc3RydWN0IHZpcnRxdWV1
ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiA+ICAgCQkJCQl2
cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93KTsKPiA+ICAgCX0KPiA+Cj4gPiAtCXZxLT5zcGxp
dC5kZXNjX3N0YXRlID0ga21hbGxvY19hcnJheSh2cmluZy5udW0sCj4gPiAtCQkJc2l6ZW9mKHN0
cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSwgR0ZQX0tFUk5FTCk7Cj4gPiAtCWlmICghdnEt
PnNwbGl0LmRlc2Nfc3RhdGUpCj4gPiAtCQlnb3RvIGVycl9zdGF0ZTsKPiA+ICsJZXJyID0gX192
cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdCh2cmluZy5udW0sICZzdGF0ZSwgJmV4dHJhKTsK
PiA+ICsJaWYgKGVycikgewo+ID4gKwkJa2ZyZWUodnEpOwo+ID4gKwkJcmV0dXJuIE5VTEw7Cj4g
PiArCX0KPiA+Cj4gPiAtCXZxLT5zcGxpdC5kZXNjX2V4dHJhID0gdnJpbmdfYWxsb2NfZGVzY19l
eHRyYSh2cmluZy5udW0pOwo+ID4gLQlpZiAoIXZxLT5zcGxpdC5kZXNjX2V4dHJhKQo+ID4gLQkJ
Z290byBlcnJfZXh0cmE7Cj4gPiArCXZxLT5zcGxpdC5kZXNjX3N0YXRlID0gc3RhdGU7Cj4gPiAr
CXZxLT5zcGxpdC5kZXNjX2V4dHJhID0gZXh0cmE7Cj4gPgo+ID4gICAJLyogUHV0IGV2ZXJ5dGhp
bmcgaW4gZnJlZSBsaXN0cy4gKi8KPiA+ICAgCXZxLT5mcmVlX2hlYWQgPSAwOwo+ID4gLQltZW1z
ZXQodnEtPnNwbGl0LmRlc2Nfc3RhdGUsIDAsIHZyaW5nLm51bSAqCj4gPiAtCQkJc2l6ZW9mKHN0
cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSk7Cj4gPgo+ID4gICAJc3Bpbl9sb2NrKCZ2ZGV2
LT52cXNfbGlzdF9sb2NrKTsKPiA+ICAgCWxpc3RfYWRkX3RhaWwoJnZxLT52cS5saXN0LCAmdmRl
di0+dnFzKTsKPiA+ICAgCXNwaW5fdW5sb2NrKCZ2ZGV2LT52cXNfbGlzdF9sb2NrKTsKPiA+ICAg
CXJldHVybiAmdnEtPnZxOwo+ID4gLQo+ID4gLWVycl9leHRyYToKPiA+IC0Ja2ZyZWUodnEtPnNw
bGl0LmRlc2Nfc3RhdGUpOwo+ID4gLWVycl9zdGF0ZToKPiA+IC0Ja2ZyZWUodnEpOwo+ID4gLQly
ZXR1cm4gTlVMTDsKPiA+ICAgfQo+ID4gICBFWFBPUlRfU1lNQk9MX0dQTChfX3ZyaW5nX25ld192
aXJ0cXVldWUpOwo+ID4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
