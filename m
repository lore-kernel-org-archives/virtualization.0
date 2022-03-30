Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26110C433EF
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 06:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC29984559;
	Wed, 30 Mar 2022 06:14:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MCTdxLICA1X0; Wed, 30 Mar 2022 06:14:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E48784524;
	Wed, 30 Mar 2022 06:14:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF5A7C002C;
	Wed, 30 Mar 2022 06:14:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2381C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF64440C9A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:14:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PWS0uxQZ_ZGA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:14:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19B65400FD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:14:49 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V8cVqb._1648620884; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V8cVqb._1648620884) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 30 Mar 2022 14:14:45 +0800
Message-ID: <1648620828.6202424-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v8 10/16] virtio_ring: split: implement
 virtqueue_resize_split()
Date: Wed, 30 Mar 2022 14:13:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-11-xuanzhuo@linux.alibaba.com>
 <a75ecf24-6d00-b790-4da8-602205381b1d@redhat.com>
 <1648111444.337551-4-xuanzhuo@linux.alibaba.com>
 <53a42ba3-8111-dd14-40d4-1c1ae077268a@redhat.com>
In-Reply-To: <53a42ba3-8111-dd14-40d4-1c1ae077268a@redhat.com>
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

T24gV2VkLCAzMCBNYXIgMjAyMiAxMTo0ODoyOSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi8zLzI0IOS4i+WNiDQ6NDQsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBPbiBUdWUsIDIyIE1hciAyMDIyIDE0OjMwOjI5ICswODAwLCBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+PiDlnKggMjAyMi8zLzE0IOS4i+WN
iDU6MzQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPj4+IHZpcnRpbyByaW5nIHNwbGl0IHN1cHBvcnRz
IHJlc2l6ZS4KPiA+Pj4KPiA+Pj4gT25seSBhZnRlciB0aGUgbmV3IHZyaW5nIGlzIHN1Y2Nlc3Nm
dWxseSBhbGxvY2F0ZWQgYmFzZWQgb24gdGhlIG5ldyBudW0sCj4gPj4+IHdlIHdpbGwgcmVsZWFz
ZSB0aGUgb2xkIHZyaW5nLiBJbiBhbnkgY2FzZSwgYW4gZXJyb3IgaXMgcmV0dXJuZWQsCj4gPj4+
IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3RpbGwgcG9pbnRzIHRvIHRoZSBvbGQgdnJpbmcu
IEluIHRoZSBjYXNlIG9mCj4gPj4+IGFuIGVycm9yLCB3ZSB3aWxsIHJlLWluaXRpYWxpemUgdGhl
IHN0YXRlIG9mIHRoZSB2cmluZyB0byBlbnN1cmUgdGhhdAo+ID4+PiB0aGUgdnJpbmcgY2FuIGJl
IHVzZWQuCj4gPj4+Cj4gPj4+IEluIGFkZGl0aW9uLCB2cmluZ19hbGlnbiwgbWF5X3JlZHVjZV9u
dW0gYXJlIG5lY2Vzc2FyeSBmb3IgcmVhbGxvY2F0aW5nCj4gPj4+IHZyaW5nLCBzbyB0aGV5IGFy
ZSByZXRhaW5lZCBmb3IgY3JlYXRpbmcgdnEuCj4gPj4+Cj4gPj4+IFNpZ25lZC1vZmYtYnk6IFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPj4+IC0tLQo+ID4+PiAgICBk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNjIgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspCj4g
Pj4+Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4+PiBpbmRleCA4MWJiZmQ2NTQxMWUuLmExNTg2
OTUxNDE0NiAxMDA2NDQKPiA+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+
ID4+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPj4+IEBAIC0xMzksNiAr
MTM5LDEyIEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ID4+PiAgICAJCQkvKiBETUEgYWRk
cmVzcyBhbmQgc2l6ZSBpbmZvcm1hdGlvbiAqLwo+ID4+PiAgICAJCQlkbWFfYWRkcl90IHF1ZXVl
X2RtYV9hZGRyOwo+ID4+PiAgICAJCQlzaXplX3QgcXVldWVfc2l6ZV9pbl9ieXRlczsKPiA+Pj4g
Kwo+ID4+PiArCQkJLyogVGhlIHBhcmFtZXRlcnMgZm9yIGNyZWF0aW5nIHZyaW5ncyBhcmUgcmVz
ZXJ2ZWQgZm9yCj4gPj4+ICsJCQkgKiBjcmVhdGluZyBuZXcgdnJpbmdzIHdoZW4gZW5hYmxpbmcg
cmVzZXQgcXVldWUuCj4gPj4+ICsJCQkgKi8KPiA+Pj4gKwkJCXUzMiB2cmluZ19hbGlnbjsKPiA+
Pj4gKwkJCWJvb2wgbWF5X3JlZHVjZV9udW07Cj4gPj4+ICAgIAkJfSBzcGxpdDsKPiA+Pj4KPiA+
Pj4gICAgCQkvKiBBdmFpbGFibGUgZm9yIHBhY2tlZCByaW5nICovCj4gPj4+IEBAIC0xOTgsNiAr
MjA0LDE2IEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ID4+PiAgICAjZW5kaWYKPiA+Pj4g
ICAgfTsKPiA+Pj4KPiA+Pj4gK3N0YXRpYyB2b2lkIF9fdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEpOwo+ID4+PiArc3RhdGljIHZvaWQgX192cmluZ192aXJ0cXVldWVfaW5pdF9zcGxp
dChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiA+Pj4gKwkJCQkJIHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICp2ZGV2KTsKPiA+Pj4gK3N0YXRpYyB2b2lkIF9fdnJpbmdfdmlydHF1ZXVlX2F0dGFj
aF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiA+Pj4gKwkJCQkJICAgc3RydWN0
IHZyaW5nIHZyaW5nLAo+ID4+PiArCQkJCQkgICBzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxp
dCAqZGVzY19zdGF0ZSwKPiA+Pj4gKwkJCQkJICAgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKmRl
c2NfZXh0cmEpOwo+ID4+PiArc3RhdGljIGludCBfX3ZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3Nw
bGl0KHUzMiBudW0sCj4gPj4+ICsJCQkJCSAgIHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0
ICoqZGVzY19zdGF0ZSwKPiA+Pj4gKwkJCQkJICAgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKipk
ZXNjX2V4dHJhKTsKPiA+Pj4KPiA+Pj4gICAgLyoKPiA+Pj4gICAgICogSGVscGVycy4KPiA+Pj4g
QEAgLTk5MSw2ICsxMDA3LDggQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0
ZV92aXJ0cXVldWVfc3BsaXQoCj4gPj4+ICAgIAkJcmV0dXJuIE5VTEw7Cj4gPj4+ICAgIAl9Cj4g
Pj4+Cj4gPj4+ICsJdG9fdnZxKHZxKS0+c3BsaXQudnJpbmdfYWxpZ24gPSB2cmluZ19hbGlnbjsK
PiA+Pj4gKwl0b192dnEodnEpLT5zcGxpdC5tYXlfcmVkdWNlX251bSA9IG1heV9yZWR1Y2VfbnVt
Owo+ID4+PiAgICAJdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSBkbWFfYWRkcjsK
PiA+Pj4gICAgCXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSBxdWV1ZV9z
aXplX2luX2J5dGVzOwo+ID4+PiAgICAJdG9fdnZxKHZxKS0+d2Vfb3duX3JpbmcgPSB0cnVlOwo+
ID4+PiBAQCAtOTk4LDYgKzEwMTYsNTAgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5n
X2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4gPj4+ICAgIAlyZXR1cm4gdnE7Cj4gPj4+ICAgIH0K
PiA+Pj4KPiA+Pj4gK3N0YXRpYyBpbnQgdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChzdHJ1Y3Qgdmly
dHF1ZXVlICpfdnEsIHUzMiBudW0pCj4gPj4+ICt7Cj4gPj4+ICsJc3RydWN0IHZyaW5nX3ZpcnRx
dWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiA+Pj4gKwlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
diA9IF92cS0+dmRldjsKPiA+Pj4gKwlzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCAqc3Rh
dGU7Cj4gPj4+ICsJc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKmV4dHJhOwo+ID4+PiArCXNpemVf
dCBxdWV1ZV9zaXplX2luX2J5dGVzOwo+ID4+PiArCWRtYV9hZGRyX3QgZG1hX2FkZHI7Cj4gPj4+
ICsJc3RydWN0IHZyaW5nIHZyaW5nOwo+ID4+PiArCWludCBlcnIgPSAtRU5PTUVNOwo+ID4+PiAr
CXZvaWQgKnF1ZXVlOwo+ID4+PiArCj4gPj4+ICsJQlVHX09OKCF2cS0+d2Vfb3duX3JpbmcpOwo+
ID4+Cj4gPj4gSSBkb24ndCBzZWUgYW55IGNoZWNrcyBpbiB2aXJ0cXVldWVfcmVzaXplKCkuIFNv
IEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8KPiA+PiBlaXRoZXIKPiA+Pgo+ID4+IDEpIHJldHVybiAt
RUlOVkFMIGhlcmUKPiA+Pgo+ID4+IG9yCj4gPj4KPiA+PiAyKSBhZGQgYSBjaGVjayBpbiB2aXJ0
cXVldWVfcmVzaXplIGFuZCBmYWlsIHRoZXJlCj4gPj4KPiA+Pgo+ID4+PiArCj4gPj4+ICsJcXVl
dWUgPSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCh2ZGV2LCAmZG1hX2FkZHIsICZudW0sCj4gPj4+
ICsJCQkJCXZxLT5zcGxpdC52cmluZ19hbGlnbiwKPiA+Pj4gKwkJCQkJdnEtPndlYWtfYmFycmll
cnMsCj4gPj4+ICsJCQkJCXZxLT5zcGxpdC5tYXlfcmVkdWNlX251bSk7Cj4gPj4+ICsJaWYgKCFx
dWV1ZSkKPiA+Pj4gKwkJZ290byBpbml0Owo+ID4+PiArCj4gPj4+ICsJcXVldWVfc2l6ZV9pbl9i
eXRlcyA9IHZyaW5nX3NpemUobnVtLCB2cS0+c3BsaXQudnJpbmdfYWxpZ24pOwo+ID4+PiArCj4g
Pj4+ICsJZXJyID0gX192cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdChudW0sICZzdGF0ZSwg
JmV4dHJhKTsKPiA+Pj4gKwlpZiAoZXJyKSB7Cj4gPj4+ICsJCXZyaW5nX2ZyZWVfcXVldWUodmRl
diwgcXVldWVfc2l6ZV9pbl9ieXRlcywgcXVldWUsIGRtYV9hZGRyKTsKPiA+Pj4gKwkJZ290byBp
bml0Owo+ID4+PiArCX0KPiA+Pj4gKwo+ID4+PiArCV9fdnJpbmdfZnJlZSgmdnEtPnZxKTsKPiA+
Pj4gKwo+ID4+PiArCXZyaW5nX2luaXQoJnZyaW5nLCBudW0sIHF1ZXVlLCB2cS0+c3BsaXQudnJp
bmdfYWxpZ24pOwo+ID4+PiArCV9fdnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9zcGxpdCh2cSwgdnJp
bmcsIHN0YXRlLCBleHRyYSk7Cj4gPj4KPiA+PiBJIHdvbmRlciBpZiB3ZSBuZWVkIGEgc3ltbWV0
cmljIHZpcnRxdWV1ZV9yZXNpemVfZGV0YWNoKCkgaW50ZXJuYWwgaGVscGVyLgo+ID4gSSB0aGlu
ayBfX3ZyaW5nX2ZyZWUoKSBpcyBzb21ld2hhdCBzaW1pbGFyIHRvIHdoYXQgeW91IHNhaWQgYWJv
dXQKPiA+IHZpcnRxdWV1ZV9yZXNpemVfZGV0YWNoKCkgLgo+Cj4KPiBTbyBmcm9tIHdoYXQgSSdt
IHVuZGVyc3RhbmRpbmcgdGhlIGNvZGUsIHRoZSBrZXkgcG9pbnQgZm9yIGF0dGFjaGluZyBpczoK
Pgo+ICDCoMKgwqDCoMKgwqDCoCB2cS0+c3BsaXQudnJpbmcgPSB2cmluZzsKPgo+IEJ1dCB0aGlz
IGlzIG5vdCB3aGF0IF9fdnJpbmdfZnJlZSgpIGRpZCwgaXQganVzdCBmcmVlIHRoZSByZXNvdXJj
ZXMuCgpPSy4KCj4KPgo+ID4KPiA+Pgo+ID4+PiArCXZxLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9
IGRtYV9hZGRyOwo+ID4+PiArCXZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gcXVldWVf
c2l6ZV9pbl9ieXRlczsKPiA+Pj4gKwo+ID4+PiArCWVyciA9IDA7Cj4gPj4+ICsKPiA+Pj4gK2lu
aXQ6Cj4gPj4+ICsJX192cmluZ192aXJ0cXVldWVfaW5pdF9zcGxpdCh2cSwgdmRldik7Cj4gPj4+
ICsJdnEtPndlX293bl9yaW5nID0gdHJ1ZTsKPiA+Pgo+ID4+IFRoZW4gd2UgY2FuIGxlYXZlIHRo
aXMgdW5jaGFuZ2VkLgo+ID4gSSB0aGluayB5b3UgbWVhbiAidnEtPndlX293bl9yaW5nID0gdHJ1
ZSI7Cj4gPgo+ID4gVGhlIHJlYXNvbiBmb3IgbW9kaWZ5aW5nIHdlX293bl9yaW5nIGFsb25lIGlz
IHRoYXQgaW4gdGhlIGdlbmVyYWwgcHJvY2VzcyBvZgo+ID4gY3JlYXRpbmcgYSByaW5nLCBfX3Zy
aW5nX3ZpcnRxdWV1ZV9pbml0X3NwbGl0IGlzIGNhbGxlZCBpbgo+ID4gX192cmluZ19uZXdfdmly
dHF1ZXVlLiBBdCB0aGlzIHRpbWUsIHdlX293bl9yaW5nIGlzIGZhbHNlLgo+ID4gdnJpbmdfY3Jl
YXRlX3ZpcnRxdWV1ZV9zcGxpdCB3aWxsIGNoYW5nZSBpdCB0byB0cnVlLiBTbyBhZnRlciBjYWxs
aW5nCj4gPiBfX3ZyaW5nX3ZpcnRxdWV1ZV9pbml0X3NwbGl0IGFsb25lLCB3ZV9vd25fcmluZyBp
cyBmYWxzZS4KPiA+Cj4gPiBJIHRoaW5rIGl0J3MgcG9zc2libGUgdG8gd3JhcCBfX3ZyaW5nX3Zp
cnRxdWV1ZV9pbml0X3NwbGl0KCkgYWdhaW4KPiA+Cj4gPiBzdGF0aWMgdm9pZCB2cmluZ192aXJ0
cXVldWVfaW5pdF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiA+IAkJCQkJIHN0
cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gewo+ID4gCV9fdnJpbmdfdmlydHF1ZXVlX2lu
aXRfc3BsaXQodnEsIHZkZXYpOwo+ID4gCXZxLT53ZV9vd25fcmluZyA9IHRydWU7Cj4gPiB9Cj4g
Pgo+ID4gSXMgdGhpcyB3aGF0IHlvdSB3YW50Pwo+Cj4KPiBOb3BlLCBJIG1lYW50IHRoZXJlIGFy
ZSBzb21lIHRyYW5zcG9ydHMgdGhhdCBhbGxvY2F0ZSB0aGUgdnJpbmcgYnkKPiB0aGVtc2VsdmVz
LCB3ZSBjYW4ndCByZXNpemUgdGhvc2UgdnJpbmcuCj4KPiBTZWUgdGhlIGNhbGxlcnMgb2YgdnJp
bmdfbmV3X3ZpcnRxdWV1ZSgpCgpTbywgeW91IG1lYW4sIGRvIG5vdCBpbXBsZW1lbnQgcmVzaXpl
IGZvciB3ZV9vd25fcmluZyBpcyBmYWxzZS4KClRoYW5rcy4KCj4KPiBUaGFua3MKPgo+Cj4gPgo+
ID4gVGhhbmtzLgo+ID4KPiA+Cj4gPj4gVGhhbmtzCj4gPj4KPiA+Pgo+ID4+PiArCXJldHVybiBl
cnI7Cj4gPj4+ICt9Cj4gPj4+ICsKPiA+Pj4KPiA+Pj4gICAgLyoKPiA+Pj4gICAgICogUGFja2Vk
IHJpbmcgc3BlY2lmaWMgZnVuY3Rpb25zIC0gKl9wYWNrZWQoKS4KPgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
