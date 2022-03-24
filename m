Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AB5C433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 08:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E55B54049D;
	Thu, 24 Mar 2022 08:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ppFgjhtHGW2V; Thu, 24 Mar 2022 08:52:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DBE86400CB;
	Thu, 24 Mar 2022 08:51:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91CAAC001A;
	Thu, 24 Mar 2022 08:51:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD285C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8617660A79
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kj1xx8W2ZBQB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:51:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E197605B1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:51:56 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R931e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V84DpjC_1648111913; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V84DpjC_1648111913) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Mar 2022 16:51:53 +0800
Message-ID: <1648111444.337551-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v8 10/16] virtio_ring: split: implement
 virtqueue_resize_split()
Date: Thu, 24 Mar 2022 16:44:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-11-xuanzhuo@linux.alibaba.com>
 <a75ecf24-6d00-b790-4da8-602205381b1d@redhat.com>
In-Reply-To: <a75ecf24-6d00-b790-4da8-602205381b1d@redhat.com>
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

T24gVHVlLCAyMiBNYXIgMjAyMiAxNDozMDoyOSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi8zLzE0IOS4i+WNiDU6MzQsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiB2aXJ0aW8gcmluZyBzcGxpdCBzdXBwb3J0cyByZXNpemUuCj4gPgo+ID4g
T25seSBhZnRlciB0aGUgbmV3IHZyaW5nIGlzIHN1Y2Nlc3NmdWxseSBhbGxvY2F0ZWQgYmFzZWQg
b24gdGhlIG5ldyBudW0sCj4gPiB3ZSB3aWxsIHJlbGVhc2UgdGhlIG9sZCB2cmluZy4gSW4gYW55
IGNhc2UsIGFuIGVycm9yIGlzIHJldHVybmVkLAo+ID4gaW5kaWNhdGluZyB0aGF0IHRoZSB2cmlu
ZyBzdGlsbCBwb2ludHMgdG8gdGhlIG9sZCB2cmluZy4gSW4gdGhlIGNhc2Ugb2YKPiA+IGFuIGVy
cm9yLCB3ZSB3aWxsIHJlLWluaXRpYWxpemUgdGhlIHN0YXRlIG9mIHRoZSB2cmluZyB0byBlbnN1
cmUgdGhhdAo+ID4gdGhlIHZyaW5nIGNhbiBiZSB1c2VkLgo+ID4KPiA+IEluIGFkZGl0aW9uLCB2
cmluZ19hbGlnbiwgbWF5X3JlZHVjZV9udW0gYXJlIG5lY2Vzc2FyeSBmb3IgcmVhbGxvY2F0aW5n
Cj4gPiB2cmluZywgc28gdGhleSBhcmUgcmV0YWluZWQgZm9yIGNyZWF0aW5nIHZxLgo+ID4KPiA+
IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4g
PiAtLS0KPiA+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDYyICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0
aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gaW5kZXggODFiYmZkNjU0MTFlLi5h
MTU4Njk1MTQxNDYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
Cj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBAQCAtMTM5LDYgKzEz
OSwxMiBAQCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlIHsKPiA+ICAgCQkJLyogRE1BIGFkZHJlc3Mg
YW5kIHNpemUgaW5mb3JtYXRpb24gKi8KPiA+ICAgCQkJZG1hX2FkZHJfdCBxdWV1ZV9kbWFfYWRk
cjsKPiA+ICAgCQkJc2l6ZV90IHF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gPiArCj4gPiArCQkJLyog
VGhlIHBhcmFtZXRlcnMgZm9yIGNyZWF0aW5nIHZyaW5ncyBhcmUgcmVzZXJ2ZWQgZm9yCj4gPiAr
CQkJICogY3JlYXRpbmcgbmV3IHZyaW5ncyB3aGVuIGVuYWJsaW5nIHJlc2V0IHF1ZXVlLgo+ID4g
KwkJCSAqLwo+ID4gKwkJCXUzMiB2cmluZ19hbGlnbjsKPiA+ICsJCQlib29sIG1heV9yZWR1Y2Vf
bnVtOwo+ID4gICAJCX0gc3BsaXQ7Cj4gPgo+ID4gICAJCS8qIEF2YWlsYWJsZSBmb3IgcGFja2Vk
IHJpbmcgKi8KPiA+IEBAIC0xOTgsNiArMjA0LDE2IEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUg
ewo+ID4gICAjZW5kaWYKPiA+ICAgfTsKPiA+Cj4gPiArc3RhdGljIHZvaWQgX192cmluZ19mcmVl
KHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7Cj4gPiArc3RhdGljIHZvaWQgX192cmluZ192aXJ0cXVl
dWVfaW5pdF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiA+ICsJCQkJCSBzdHJ1
Y3QgdmlydGlvX2RldmljZSAqdmRldik7Cj4gPiArc3RhdGljIHZvaWQgX192cmluZ192aXJ0cXVl
dWVfYXR0YWNoX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ID4gKwkJCQkJICAg
c3RydWN0IHZyaW5nIHZyaW5nLAo+ID4gKwkJCQkJICAgc3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVf
c3BsaXQgKmRlc2Nfc3RhdGUsCj4gPiArCQkJCQkgICBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAq
ZGVzY19leHRyYSk7Cj4gPiArc3RhdGljIGludCBfX3ZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3Nw
bGl0KHUzMiBudW0sCj4gPiArCQkJCQkgICBzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCAq
KmRlc2Nfc3RhdGUsCj4gPiArCQkJCQkgICBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqKmRlc2Nf
ZXh0cmEpOwo+ID4KPiA+ICAgLyoKPiA+ICAgICogSGVscGVycy4KPiA+IEBAIC05OTEsNiArMTAw
Nyw4IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3Nw
bGl0KAo+ID4gICAJCXJldHVybiBOVUxMOwo+ID4gICAJfQo+ID4KPiA+ICsJdG9fdnZxKHZxKS0+
c3BsaXQudnJpbmdfYWxpZ24gPSB2cmluZ19hbGlnbjsKPiA+ICsJdG9fdnZxKHZxKS0+c3BsaXQu
bWF5X3JlZHVjZV9udW0gPSBtYXlfcmVkdWNlX251bTsKPiA+ICAgCXRvX3Z2cSh2cSktPnNwbGl0
LnF1ZXVlX2RtYV9hZGRyID0gZG1hX2FkZHI7Cj4gPiAgIAl0b192dnEodnEpLT5zcGxpdC5xdWV1
ZV9zaXplX2luX2J5dGVzID0gcXVldWVfc2l6ZV9pbl9ieXRlczsKPiA+ICAgCXRvX3Z2cSh2cSkt
PndlX293bl9yaW5nID0gdHJ1ZTsKPiA+IEBAIC05OTgsNiArMTAxNiw1MCBAQCBzdGF0aWMgc3Ry
dWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+ICAgCXJldHVy
biB2cTsKPiA+ICAgfQo+ID4KPiA+ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9yZXNpemVfc3BsaXQo
c3RydWN0IHZpcnRxdWV1ZSAqX3ZxLCB1MzIgbnVtKQo+ID4gK3sKPiA+ICsJc3RydWN0IHZyaW5n
X3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiA+ICsJc3RydWN0IHZpcnRpb19kZXZpY2Ug
KnZkZXYgPSBfdnEtPnZkZXY7Cj4gPiArCXN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0ICpz
dGF0ZTsKPiA+ICsJc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKmV4dHJhOwo+ID4gKwlzaXplX3Qg
cXVldWVfc2l6ZV9pbl9ieXRlczsKPiA+ICsJZG1hX2FkZHJfdCBkbWFfYWRkcjsKPiA+ICsJc3Ry
dWN0IHZyaW5nIHZyaW5nOwo+ID4gKwlpbnQgZXJyID0gLUVOT01FTTsKPiA+ICsJdm9pZCAqcXVl
dWU7Cj4gPiArCj4gPiArCUJVR19PTighdnEtPndlX293bl9yaW5nKTsKPgo+Cj4gSSBkb24ndCBz
ZWUgYW55IGNoZWNrcyBpbiB2aXJ0cXVldWVfcmVzaXplKCkuIFNvIEkgdGhpbmsgaXQncyBiZXR0
ZXIgdG8KPiBlaXRoZXIKPgo+IDEpIHJldHVybiAtRUlOVkFMIGhlcmUKPgo+IG9yCj4KPiAyKSBh
ZGQgYSBjaGVjayBpbiB2aXJ0cXVldWVfcmVzaXplIGFuZCBmYWlsIHRoZXJlCj4KPgo+ID4gKwo+
ID4gKwlxdWV1ZSA9IHZyaW5nX2FsbG9jX3F1ZXVlX3NwbGl0KHZkZXYsICZkbWFfYWRkciwgJm51
bSwKPiA+ICsJCQkJCXZxLT5zcGxpdC52cmluZ19hbGlnbiwKPiA+ICsJCQkJCXZxLT53ZWFrX2Jh
cnJpZXJzLAo+ID4gKwkJCQkJdnEtPnNwbGl0Lm1heV9yZWR1Y2VfbnVtKTsKPiA+ICsJaWYgKCFx
dWV1ZSkKPiA+ICsJCWdvdG8gaW5pdDsKPiA+ICsKPiA+ICsJcXVldWVfc2l6ZV9pbl9ieXRlcyA9
IHZyaW5nX3NpemUobnVtLCB2cS0+c3BsaXQudnJpbmdfYWxpZ24pOwo+ID4gKwo+ID4gKwllcnIg
PSBfX3ZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3NwbGl0KG51bSwgJnN0YXRlLCAmZXh0cmEpOwo+
ID4gKwlpZiAoZXJyKSB7Cj4gPiArCQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHF1ZXVlX3NpemVf
aW5fYnl0ZXMsIHF1ZXVlLCBkbWFfYWRkcik7Cj4gPiArCQlnb3RvIGluaXQ7Cj4gPiArCX0KPiA+
ICsKPiA+ICsJX192cmluZ19mcmVlKCZ2cS0+dnEpOwo+ID4gKwo+ID4gKwl2cmluZ19pbml0KCZ2
cmluZywgbnVtLCBxdWV1ZSwgdnEtPnNwbGl0LnZyaW5nX2FsaWduKTsKPiA+ICsJX192cmluZ192
aXJ0cXVldWVfYXR0YWNoX3NwbGl0KHZxLCB2cmluZywgc3RhdGUsIGV4dHJhKTsKPgo+Cj4gSSB3
b25kZXIgaWYgd2UgbmVlZCBhIHN5bW1ldHJpYyB2aXJ0cXVldWVfcmVzaXplX2RldGFjaCgpIGlu
dGVybmFsIGhlbHBlci4KCkkgdGhpbmsgX192cmluZ19mcmVlKCkgaXMgc29tZXdoYXQgc2ltaWxh
ciB0byB3aGF0IHlvdSBzYWlkIGFib3V0CnZpcnRxdWV1ZV9yZXNpemVfZGV0YWNoKCkgLgoKPgo+
Cj4gPiArCXZxLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9IGRtYV9hZGRyOwo+ID4gKwl2cS0+c3Bs
aXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IHF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gPiArCj4gPiAr
CWVyciA9IDA7Cj4gPiArCj4gPiAraW5pdDoKPiA+ICsJX192cmluZ192aXJ0cXVldWVfaW5pdF9z
cGxpdCh2cSwgdmRldik7Cj4gPiArCXZxLT53ZV9vd25fcmluZyA9IHRydWU7Cj4KPgo+IFRoZW4g
d2UgY2FuIGxlYXZlIHRoaXMgdW5jaGFuZ2VkLgoKSSB0aGluayB5b3UgbWVhbiAidnEtPndlX293
bl9yaW5nID0gdHJ1ZSI7CgpUaGUgcmVhc29uIGZvciBtb2RpZnlpbmcgd2Vfb3duX3JpbmcgYWxv
bmUgaXMgdGhhdCBpbiB0aGUgZ2VuZXJhbCBwcm9jZXNzIG9mCmNyZWF0aW5nIGEgcmluZywgX192
cmluZ192aXJ0cXVldWVfaW5pdF9zcGxpdCBpcyBjYWxsZWQgaW4KX192cmluZ19uZXdfdmlydHF1
ZXVlLiBBdCB0aGlzIHRpbWUsIHdlX293bl9yaW5nIGlzIGZhbHNlLgp2cmluZ19jcmVhdGVfdmly
dHF1ZXVlX3NwbGl0IHdpbGwgY2hhbmdlIGl0IHRvIHRydWUuIFNvIGFmdGVyIGNhbGxpbmcKX192
cmluZ192aXJ0cXVldWVfaW5pdF9zcGxpdCBhbG9uZSwgd2Vfb3duX3JpbmcgaXMgZmFsc2UuCgpJ
IHRoaW5rIGl0J3MgcG9zc2libGUgdG8gd3JhcCBfX3ZyaW5nX3ZpcnRxdWV1ZV9pbml0X3NwbGl0
KCkgYWdhaW4KCnN0YXRpYyB2b2lkIHZyaW5nX3ZpcnRxdWV1ZV9pbml0X3NwbGl0KHN0cnVjdCB2
cmluZ192aXJ0cXVldWUgKnZxLAoJCQkJCSBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKewoJ
X192cmluZ192aXJ0cXVldWVfaW5pdF9zcGxpdCh2cSwgdmRldik7Cgl2cS0+d2Vfb3duX3Jpbmcg
PSB0cnVlOwp9CgpJcyB0aGlzIHdoYXQgeW91IHdhbnQ/CgpUaGFua3MuCgoKPgo+IFRoYW5rcwo+
Cj4KPiA+ICsJcmV0dXJuIGVycjsKPiA+ICt9Cj4gPiArCj4gPgo+ID4gICAvKgo+ID4gICAgKiBQ
YWNrZWQgcmluZyBzcGVjaWZpYyBmdW5jdGlvbnMgLSAqX3BhY2tlZCgpLgo+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
