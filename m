Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BC7C433EF
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 07:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7EE724036E;
	Mon, 10 Jan 2022 07:24:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3S0Ckh5X2uS9; Mon, 10 Jan 2022 07:24:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C094340004;
	Mon, 10 Jan 2022 07:24:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96628C0030;
	Mon, 10 Jan 2022 07:24:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7ECDBC001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5DFA84031D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:24:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zXzsFs8e_mx8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:24:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 069DC40004
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:24:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V1Mop9f_1641799449; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V1Mop9f_1641799449) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 10 Jan 2022 15:24:10 +0800
MIME-Version: 1.0
message-id: <1641799443.4270124-2-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 4/6] virtio: split: virtqueue_add_split() support dma
 address
date: Mon, 10 Jan 2022 15:24:03 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <768a05cc-16f7-b374-04a6-48fecfe1768b@redhat.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCAxMCBKYW4gMjAyMiAxNDo0NTo0MiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi8xLzcg5LiL5Y2IMjozMywgWHVhbiBaaHVv
IOWGmemBkzoKPiA+IHZpcnRxdWV1ZV9hZGRfc3BsaXQoKSBvbmx5IHN1cHBvcnRzIHZpcnR1YWwg
YWRkcmVzc2VzLCBkbWEgaXMgY29tcGxldGVkCj4gPiBpbiB2aXJ0cXVldWVfYWRkX3NwbGl0KCku
Cj4gPgo+ID4gSW4gc29tZSBzY2VuYXJpb3MgKHN1Y2ggYXMgdGhlIEFGX1hEUCBzY2VuYXJpbyks
IHRoZSBtZW1vcnkgaXMgYWxsb2NhdGVkCj4gPiBhbmQgRE1BIGlzIGNvbXBsZXRlZCBpbiBhZHZh
bmNlLCBzbyBpdCBpcyBuZWNlc3NhcnkgZm9yIHVzIHRvIHN1cHBvcnQKPiA+IHBhc3NpbmcgdGhl
IERNQSBhZGRyZXNzIHRvIHZpcnRxdWV1ZV9hZGRfc3BsaXQoKS4KPiA+Cj4gPiBUaGlzIHBhdGNo
IHN0aXB1bGF0ZXMgdGhhdCBpZiBzZy0+ZG1hX2FkZHJlc3MgaXMgbm90IE5VTEwsIHVzZSB0aGlz
Cj4gPiBhZGRyZXNzIGFzIHRoZSBETUEgYWRkcmVzcy4gQW5kIHJlY29yZCB0aGlzIGluZm9ybWF0
aW9uIGluIGV4dHJhLT5mbGFncywKPiA+IHdoaWNoIGNhbiBiZSBza2lwcGVkIHdoZW4gZXhlY3V0
aW5nIGRtYSB1bm1hcC4KPiA+Cj4gPiAgICAgIGV4dHJhLT5mbGFncyB8PSBWUklOR19ERVNDX0Zf
UFJFRE1BOwo+Cj4KPiBJIHRoaW5rIHdlIG5lZWQgYW5vdGhlciBuYW1lIG90aGVyIHRoYW4gdGhl
IFZSSU5HX0RFU0NfRiBwcmVmaXggc2luY2UKPiBpdCdzIGZvciB0aGUgZmxhZyBkZWZpbmVkIGlu
IHRoZSBzcGVjLiBNYXkgVklSVElPX0RFU0NfRl9QUkVETUEuCj4KCk9LLgoKPiBUaGFua3MKPgo+
Cj4gPgo+ID4gVGhpcyByZWxpZXMgb24gdGhlIHByZXZpb3VzIHBhdGNoLCBpbiB0aGUgaW5kaXJl
Y3Qgc2NlbmFyaW8sIGZvciBlYWNoCj4gPiBkZXNjIGFsbG9jYXRlZCwgYW4gZXh0cmEgaXMgYWxs
b2NhdGVkIGF0IHRoZSBzYW1lIHRpbWUuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVv
IDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+Cj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMKPiA+IGluZGV4IDc0MjA3NDFjYjc1MC4uYWRkODQzMGQ5Njc4IDEwMDY0
NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gKysrIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gQEAgLTY2LDYgKzY2LDkgQEAKPiA+ICAgI2RlZmlu
ZSBMQVNUX0FERF9USU1FX0lOVkFMSUQodnEpCj4gPiAgICNlbmRpZgo+ID4KPiA+ICsvKiBUaGlz
IG1lYW5zIHRoZSBidWZmZXIgZG1hIGlzIHByZS1hbGxvYy4gSnVzdCB1c2VkIGJ5IHZyaW5nX2Rl
c2NfZXh0cmEgKi8KPiA+ICsjZGVmaW5lIFZSSU5HX0RFU0NfRl9QUkVETUEJKDEgPDwgMTUpCj4g
PiArCj4gPiAgIHN0cnVjdCB2cmluZ19kZXNjX2V4dHJhIHsKPiA+ICAgCWRtYV9hZGRyX3QgYWRk
cjsJCS8qIERlc2NyaXB0b3IgRE1BIGFkZHIuICovCj4gPiAgIAl1MzIgbGVuOwkJCS8qIERlc2Ny
aXB0b3IgbGVuZ3RoLiAqLwo+ID4gQEAgLTMzNiwxMSArMzM5LDE5IEBAIHN0YXRpYyBpbmxpbmUg
c3RydWN0IGRldmljZSAqdnJpbmdfZG1hX2Rldihjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVl
ICp2cSkKPiA+ICAgCXJldHVybiB2cS0+dnEudmRldi0+ZGV2LnBhcmVudDsKPiA+ICAgfQo+ID4K
PiA+ICtzdGF0aWMgaW5saW5lIGJvb2wgc2dfaXNfcHJlZG1hKHN0cnVjdCBzY2F0dGVybGlzdCAq
c2cpCj4gPiArewo+ID4gKwlyZXR1cm4gISFzZy0+ZG1hX2FkZHJlc3M7Cj4gPiArfQo+ID4gKwo+
ID4gICAvKiBNYXAgb25lIHNnIGVudHJ5LiAqLwo+ID4gICBzdGF0aWMgZG1hX2FkZHJfdCB2cmlu
Z19tYXBfb25lX3NnKGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ID4gICAJCQkJ
ICAgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywKPiA+ICAgCQkJCSAgIGVudW0gZG1hX2RhdGFfZGly
ZWN0aW9uIGRpcmVjdGlvbikKPiA+ICAgewo+ID4gKwlpZiAoc2dfaXNfcHJlZG1hKHNnKSkKPiA+
ICsJCXJldHVybiBzZ19kbWFfYWRkcmVzcyhzZyk7Cj4gPiArCj4gPiAgIAlpZiAoIXZxLT51c2Vf
ZG1hX2FwaSkKPiA+ICAgCQlyZXR1cm4gKGRtYV9hZGRyX3Qpc2dfcGh5cyhzZyk7Cj4gPgo+ID4g
QEAgLTM5Niw2ICs0MDcsOSBAQCBzdGF0aWMgdW5zaWduZWQgaW50IHZyaW5nX3VubWFwX29uZV9z
cGxpdChjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiA+ICAgCQkJCSAoZmxhZ3Mg
JiBWUklOR19ERVNDX0ZfV1JJVEUpID8KPiA+ICAgCQkJCSBETUFfRlJPTV9ERVZJQ0UgOiBETUFf
VE9fREVWSUNFKTsKPiA+ICAgCX0gZWxzZSB7Cj4gPiArCQlpZiAoZmxhZ3MgJiBWUklOR19ERVND
X0ZfUFJFRE1BKQo+ID4gKwkJCWdvdG8gb3V0Owo+ID4gKwo+ID4gICAJCWRtYV91bm1hcF9wYWdl
KHZyaW5nX2RtYV9kZXYodnEpLAo+ID4gICAJCQkgICAgICAgZXh0cmEtPmFkZHIsCj4gPiAgIAkJ
CSAgICAgICBleHRyYS0+bGVuLAo+ID4gQEAgLTQ0MSw3ICs0NTUsOCBAQCBzdGF0aWMgaW5saW5l
IHVuc2lnbmVkIGludCB2aXJ0cXVldWVfYWRkX2Rlc2Nfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAq
dnEsCj4gPiAgIAkJCQkJCSAgICB1bnNpZ25lZCBpbnQgaSwKPiA+ICAgCQkJCQkJICAgIGRtYV9h
ZGRyX3QgYWRkciwKPiA+ICAgCQkJCQkJICAgIHVuc2lnbmVkIGludCBsZW4sCj4gPiAtCQkJCQkJ
ICAgIHUxNiBmbGFncykKPiA+ICsJCQkJCQkgICAgdTE2IGZsYWdzLAo+ID4gKwkJCQkJCSAgICBi
b29sIHByZWRtYSkKPiA+ICAgewo+ID4gICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnJpbmcg
PSB0b192dnEodnEpOwo+ID4gICAJc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKmV4dHJhOwo+ID4g
QEAgLTQ2OCw2ICs0ODMsOSBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCB2aXJ0cXVldWVf
YWRkX2Rlc2Nfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4gPiAgIAlleHRyYS0+bGVuID0g
bGVuOwo+ID4gICAJZXh0cmEtPmZsYWdzID0gZmxhZ3M7Cj4gPgo+ID4gKwlpZiAocHJlZG1hKQo+
ID4gKwkJZXh0cmEtPmZsYWdzIHw9IFZSSU5HX0RFU0NfRl9QUkVETUE7Cj4gPiArCj4gPiAgIAly
ZXR1cm4gbmV4dDsKPiA+ICAgfQo+ID4KPiA+IEBAIC01NDcsNyArNTY1LDggQEAgc3RhdGljIGlu
bGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiAg
IAkJCSAqIHRhYmxlIHNpbmNlIGl0IHVzZSBzdHJlYW0gRE1BIG1hcHBpbmcuCj4gPiAgIAkJCSAq
Lwo+ID4gICAJCQlpID0gdmlydHF1ZXVlX2FkZF9kZXNjX3NwbGl0KF92cSwgaW4sIGksIGFkZHIs
IHNnLT5sZW5ndGgsCj4gPiAtCQkJCQkJICAgICBWUklOR19ERVNDX0ZfTkVYVCk7Cj4gPiArCQkJ
CQkJICAgICBWUklOR19ERVNDX0ZfTkVYVCwKPiA+ICsJCQkJCQkgICAgIHNnX2lzX3ByZWRtYShz
ZykpOwo+ID4gICAJCX0KPiA+ICAgCX0KPiA+ICAgCWZvciAoOyBuIDwgKG91dF9zZ3MgKyBpbl9z
Z3MpOyBuKyspIHsKPiA+IEBAIC01NjMsNyArNTgyLDggQEAgc3RhdGljIGlubGluZSBpbnQgdmly
dHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiAgIAkJCWkgPSB2aXJ0
cXVldWVfYWRkX2Rlc2Nfc3BsaXQoX3ZxLCBpbiwgaSwgYWRkciwKPiA+ICAgCQkJCQkJICAgICBz
Zy0+bGVuZ3RoLAo+ID4gICAJCQkJCQkgICAgIFZSSU5HX0RFU0NfRl9ORVhUIHwKPiA+IC0JCQkJ
CQkgICAgIFZSSU5HX0RFU0NfRl9XUklURSk7Cj4gPiArCQkJCQkJICAgICBWUklOR19ERVNDX0Zf
V1JJVEUsCj4gPiArCQkJCQkJICAgICBzZ19pc19wcmVkbWEoc2cpKTsKPiA+ICAgCQl9Cj4gPiAg
IAl9Cj4gPiAgIAkvKiBMYXN0IG9uZSBkb2Vzbid0IGNvbnRpbnVlLiAqLwo+ID4gQEAgLTU4Miw3
ICs2MDIsNyBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2
aXJ0cXVldWUgKl92cSwKPiA+Cj4gPiAgIAkJdmlydHF1ZXVlX2FkZF9kZXNjX3NwbGl0KF92cSwg
TlVMTCwgaGVhZCwgYWRkciwKPiA+ICAgCQkJCQkgdG90YWxfc2cgKiBzaXplb2Yoc3RydWN0IHZy
aW5nX2Rlc2MpLAo+ID4gLQkJCQkJIFZSSU5HX0RFU0NfRl9JTkRJUkVDVCk7Cj4gPiArCQkJCQkg
VlJJTkdfREVTQ19GX0lORElSRUNULCBmYWxzZSk7Cj4gPiAgIAl9Cj4gPgo+ID4gICAJLyogV2Un
cmUgdXNpbmcgc29tZSBidWZmZXJzIGZyb20gdGhlIGZyZWUgbGlzdC4gKi8KPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
