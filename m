Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A40C6FD18
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 09:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 67066402E0;
	Wed, 29 Mar 2023 09:53:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67066402E0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HW0qiRxfzAWX; Wed, 29 Mar 2023 09:53:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C50A040153;
	Wed, 29 Mar 2023 09:53:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C50A040153
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B226C0036;
	Wed, 29 Mar 2023 09:53:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A7F5C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 09:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6885D402CD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 09:53:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6885D402CD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J74b3nqRrpgA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 09:53:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 695294021E
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 695294021E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 09:53:06 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R481e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0VewN.CU_1680083580; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VewN.CU_1680083580) by smtp.aliyun-inc.com;
 Wed, 29 Mar 2023 17:53:01 +0800
Message-ID: <1680083360.7413719-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [External] Re: [PATCH v3] virtio_ring: interrupt disable flag
 updated to vq even with event_triggered is set
Date: Wed, 29 Mar 2023 17:49:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: =?utf-8?b?6buE5p2w?= <huangjie.albert@bytedance.com>
References: <20230329072841.45304-1-huangjie.albert@bytedance.com>
 <1680082024.6148505-2-xuanzhuo@linux.alibaba.com>
 <CABKxMyNXm4W+-yECstbnqy6U4_GYoOtfZ7h6+v3URzmVaJLOBQ@mail.gmail.com>
In-Reply-To: <CABKxMyNXm4W+-yECstbnqy6U4_GYoOtfZ7h6+v3URzmVaJLOBQ@mail.gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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

T24gV2VkLCAyOSBNYXIgMjAyMyAxNzozMzoyMyArMDgwMCwgPT91dGYtOD9iPzZidUU1cDJ3Pz0g
PGh1YW5namllLmFsYmVydEBieXRlZGFuY2UuY29tPiB3cm90ZToKPiBYdWFuIFpodW8gPHh1YW56
aHVvQGxpbnV4LmFsaWJhYmEuY29tPiDkuo4yMDIz5bm0M+aciDI55pel5ZGo5LiJIDE3OjI35YaZ
6YGT77yaCj4gPgo+ID4gT24gV2VkLCAyOSBNYXIgMjAyMyAxNToyODo0MSArMDgwMCwgQWxiZXJ0
IEh1YW5nIDxodWFuZ2ppZS5hbGJlcnRAYnl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4gPiA+IEZyb206
ICJodWFuZ2ppZS5hbGJlcnQiIDxodWFuZ2ppZS5hbGJlcnRAYnl0ZWRhbmNlLmNvbT4KPiA+ID4K
PiA+ID4gaW4gdmlydGlvX25ldCwgaWYgd2UgZGlzYWJsZSB0aGUgbmFwaV90eCwgd2hlbiB3ZSB0
cmlnZXIgYSB0eCBpbnRlcnJ1cHQsCj4gPiA+IHRoZSB2cS0+ZXZlbnRfdHJpZ2dlcmVkIHdpbGwg
YmUgc2V0IHRvIHRydWUuIEl0IHdpbGwgbm8gbG9uZ2VyIGJlIHNldCB0bwo+ID4gPiBmYWxzZS4g
VW5sZXNzIHdlIGV4cGxpY2l0bHkgY2FsbCB2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQgb3IK
PiA+ID4gdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVwYXJlLgo+ID4gPgo+ID4gPiBJZiB3ZSBkaXNh
YmxlIHRoZSBuYXBpX3R4LCBpdCB3aWxsIG9ubHkgYmUgY2FsbGVkIHdoZW4gdGhlIHR4IHJpbmcK
PiA+ID4gYnVmZmVyIGlzIHJlbGF0aXZlbHkgc21hbGwuCj4gPiA+Cj4gPiA+IEJlY2F1c2UgZXZl
bnRfdHJpZ2dlcmVkIGlzIHRydWUuIFRoZXJlZm9yZSwgVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJV
UFQgb3IKPiA+ID4gVlJJTkdfUEFDS0VEX0VWRU5UX0ZMQUdfRElTQUJMRSB3aWxsIG5vdCBiZSBz
ZXQuIFNvIHdlIHVwZGF0ZQo+ID4gPiB2cmluZ191c2VkX2V2ZW50KCZ2cS0+c3BsaXQudnJpbmcp
IG9yIHZxLT5wYWNrZWQudnJpbmcuZHJpdmVyLT5vZmZfd3JhcAo+ID4gPiBldmVyeSB0aW1lIHdl
IGNhbGwgdmlydHF1ZXVlX2dldF9idWZfY3R4LlRoaXMgYnJpbmcgbW9yZSBpbnRlcnJ1cHRpb25z
Lgo+ID4gPgo+ID4gPiBUbyBzdW1tYXJpemU6Cj4gPiA+IDEpIGV2ZW50X3RyaWdnZXJlZCB3YXMg
c2V0IHRvIHRydWUgaW4gdnJpbmdfaW50ZXJydXB0KCkKPiA+ID4gMikgYWZ0ZXIgdGhpcyBub3Ro
aW5nIHdpbGwgaGFwcGVuIGZvciB2aXJ0cXVldWVfZGlzYWJsZV9jYigpIHNvCj4gPiA+ICAgIFZS
SU5HX0FWQUlMX0ZfTk9fSU5URVJSVVBUIGlzIG5vdCBzZXQgaW4gYXZhaWxfZmxhZ3Nfc2hhZG93
Cj4gPiA+IDMpIHZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9zcGxpdCgpIHdpbGwgc3RpbGwgdGhpbmsg
dGhlIGNiIGlzIGVuYWJsZWQKPiA+ID4gICAgdGhlbiBpdCB0cmllcyB0byBwdWJsaXNoIG5ldyBl
dmVudAo+ID4gPgo+ID4gPiBUbyBmaXg6Cj4gPiA+IHVwZGF0ZSBWUklOR19BVkFJTF9GX05PX0lO
VEVSUlVQVCBvciBWUklOR19QQUNLRURfRVZFTlRfRkxBR19ESVNBQkxFIHRvIHZxCj4gPiA+IHdo
ZW4gd2UgY2FsbCB2aXJ0cXVldWVfZGlzYWJsZV9jYiBldmVuIHRoZSBldmVudF90cmlnZ2VyZWQg
aXMgc2V0IHRvIHRydWUuCj4gPiA+Cj4gPiA+IFRlc3RlZCB3aXRoIGlwZXJmOgo+ID4gPiBpcGVy
ZjMgdGNwIHN0cmVhbToKPiA+ID4gdm0xIC0tLS0tLS0tLS0tLS0tLS0tPiB2bTIKPiA+ID4gdm0y
IGp1c3QgcmVjZWl2ZXMgdGNwIGRhdGEgc3RyZWFtIGZyb20gdm0xLCBhbmQgc2VuZHMgdGhlIGFj
ayB0byB2bTEsCj4gPiA+IHRoZXJlIGFyZSBtYW55IHR4IGludGVycnVwdHMgaW4gdm0yLgo+ID4g
PiBidXQgd2l0aG91dCBldmVudF90cmlnZ2VyZWQgdGhlcmUgYXJlIGp1c3QgYSBmZXcgdHggaW50
ZXJydXB0cy4KPiA+ID4KPiA+ID4gdjItPnYzOgo+ID4gPiAtdXBkYXRlIHRoZSBpbnRlcnJ1cHQg
ZGlzYWJsZSBmbGFnIGV2ZW4gd2l0aCB0aGUgZXZlbnRfdHJpZ2dlcmVkIGlzIHNldCwKPiA+ID4g
LWluc3RlYWQgb2YgY2hlY2tpbmcgd2hldGhlciBldmVudF90cmlnZ2VyZWQgaXMgc2V0IGluCj4g
PiA+IC12aXJ0cXVldWVfZ2V0X2J1Zl9jdHhfe3BhY2tlZC9zcGxpdH0sIHdpbGwgY2F1c2UgdGhl
IGRyaXZlcnMgIHdoaWNoIGhhdmUKPiA+ID4gLW5vdCBjYWxsZWQgdmlydHF1ZXVlX3tlbmFibGUv
ZGlzYWJsZX1fY2IgdG8gbWlzcyBub3RpZmljYXRpb25zLgo+ID4gPgo+ID4gPiBGaXhlczogOGQ2
MjJkMjFkMjQ4ICgidmlydGlvOiBmaXggdXAgdmlydGlvX2Rpc2FibGVfY2IiKQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBodWFuZ2ppZS5hbGJlcnQgPGh1YW5namllLmFsYmVydEBieXRlZGFuY2UuY29t
Pgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
Pgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+
ID4gPiAtLS0KPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAyNCArKysrKysr
KysrKysrKysrKy0tLS0tLS0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gaW5kZXgg
MzA3ZTEzOWNiMTFkLi5hZDc0NDYzYTQ4ZWUgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gPiBAQCAtODEyLDYgKzgxMiwxNCBAQCBzdGF0aWMgdm9pZCB2aXJ0cXVldWVfZGlzYWJs
ZV9jYl9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gPiA+Cj4gPiA+ICAgICAgIGlmICgh
KHZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cgJiBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQ
VCkpIHsKPiA+ID4gICAgICAgICAgICAgICB2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93IHw9
IFZSSU5HX0FWQUlMX0ZfTk9fSU5URVJSVVBUOwo+ID4gPiArCj4gPiA+ICsgICAgICAgICAgICAg
LyoKPiA+ID4gKyAgICAgICAgICAgICAgKiBJZiBkZXZpY2UgdHJpZ2dlcmVkIGFuIGV2ZW50IGFs
cmVhZHkgaXQgd29uJ3QgdHJpZ2dlciBvbmUgYWdhaW46Cj4gPiA+ICsgICAgICAgICAgICAgICog
bm8gbmVlZCB0byBkaXNhYmxlLgo+ID4gPiArICAgICAgICAgICAgICAqLwo+ID4gPiArICAgICAg
ICAgICAgIGlmICh2cS0+ZXZlbnRfdHJpZ2dlcmVkKQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuOwo+ID4gPiArCj4gPiA+ICAgICAgICAgICAgICAgaWYgKHZxLT5ldmVudCkKPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgIC8qIFRPRE86IHRoaXMgaXMgYSBoYWNrLiBGaWd1cmUg
b3V0IGEgY2xlYW5lciB2YWx1ZSB0byB3cml0ZS4gKi8KPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgIHZyaW5nX3VzZWRfZXZlbnQoJnZxLT5zcGxpdC52cmluZykgPSAweDA7Cj4gPiA+IEBAIC0x
NTQ0LDggKzE1NTIsMTYgQEAgc3RhdGljIHZvaWQgdmlydHF1ZXVlX2Rpc2FibGVfY2JfcGFja2Vk
KHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiA+ID4gIHsKPiA+ID4gICAgICAgc3RydWN0IHZyaW5n
X3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiA+ID4KPiA+ID4gLSAgICAgaWYgKHZxLT5w
YWNrZWQuZXZlbnRfZmxhZ3Nfc2hhZG93ICE9IFZSSU5HX1BBQ0tFRF9FVkVOVF9GTEFHX0RJU0FC
TEUpIHsKPiA+ID4gKyAgICAgaWYgKCEodnEtPnBhY2tlZC5ldmVudF9mbGFnc19zaGFkb3cgJiBW
UklOR19QQUNLRURfRVZFTlRfRkxBR19ESVNBQkxFKSkgewo+ID4KPiA+IFRoaXMgc2VlbXMgdG8g
YmUgYW5vdGhlciBwcm9ibGVtLgo+ID4KPiA+IFRoYW5rcy4KPiA+Cj4KPiBIZXJlLCB3ZSBhcmUg
b25seSBtYWtpbmcgdGhpcyBjaGFuZ2UgdG8gbWFpbnRhaW4gY29uc2lzdGVuY3kgd2l0aAo+IHZp
cnRxdWV1ZV9kaXNhYmxlX2NiX3NwbGl0Lgo+IElzIHRoZXJlIGFueSBjb25jZXJuIHdpdGggZG9p
bmcgc28/CgpJJ20gbm90IHN1cmUgd2h5IHRoZSB1c2VfZmxhZ3Nfc2hhZG93IHVzZSAiIT0iIHRv
IGp1ZGdlLCBidXQgaXQgc2VlbXMKdGhhdCBhbGwgcGxhY2VzIGFyZSB1c2VkIGxpa2UgdGhpcy4g
U28gd2UnZCBiZXR0ZXIga2VlcCB0aGUgb3JpZ2luYWwuIElmIGl0IGlzCm5lY2Vzc2FyeSB0byBt
b2RpZnkgaXQgaGVyZSwgSSB0aGluayBhIHNlcGFyYXRlIGNvbW1pdCBzaG91bGQgYmUgcG9zdGVk
LgpFdmVuIGlmIGl0IGlzIGp1c3QgdG8ga2VlcCBpdCBjb25zaXN0ZW50IHdpdGggc3BsaXQuCgoK
VGhhbmtzLgoKCgo+Cj4gVGhhbmtzLgo+Cj4gPgo+ID4gPiAgICAgICAgICAgICAgIHZxLT5wYWNr
ZWQuZXZlbnRfZmxhZ3Nfc2hhZG93ID0gVlJJTkdfUEFDS0VEX0VWRU5UX0ZMQUdfRElTQUJMRTsK
PiA+ID4gKwo+ID4gPiArICAgICAgICAgICAgIC8qCj4gPiA+ICsgICAgICAgICAgICAgICogSWYg
ZGV2aWNlIHRyaWdnZXJlZCBhbiBldmVudCBhbHJlYWR5IGl0IHdvbid0IHRyaWdnZXIgb25lIGFn
YWluOgo+ID4gPiArICAgICAgICAgICAgICAqIG5vIG5lZWQgdG8gZGlzYWJsZS4KPiA+ID4gKyAg
ICAgICAgICAgICAgKi8KPiA+ID4gKyAgICAgICAgICAgICBpZiAodnEtPmV2ZW50X3RyaWdnZXJl
ZCkKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gKwo+ID4gPiAgICAg
ICAgICAgICAgIHZxLT5wYWNrZWQudnJpbmcuZHJpdmVyLT5mbGFncyA9Cj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICBjcHVfdG9fbGUxNih2cS0+cGFja2VkLmV2ZW50X2ZsYWdzX3NoYWRvdyk7
Cj4gPiA+ICAgICAgIH0KPiA+ID4gQEAgLTIwNjMsMTIgKzIwNzksNiBAQCB2b2lkIHZpcnRxdWV1
ZV9kaXNhYmxlX2NiKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiA+ID4gIHsKPiA+ID4gICAgICAg
c3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiA+ID4KPiA+ID4gLSAg
ICAgLyogSWYgZGV2aWNlIHRyaWdnZXJlZCBhbiBldmVudCBhbHJlYWR5IGl0IHdvbid0IHRyaWdn
ZXIgb25lIGFnYWluOgo+ID4gPiAtICAgICAgKiBubyBuZWVkIHRvIGRpc2FibGUuCj4gPiA+IC0g
ICAgICAqLwo+ID4gPiAtICAgICBpZiAodnEtPmV2ZW50X3RyaWdnZXJlZCkKPiA+ID4gLSAgICAg
ICAgICAgICByZXR1cm47Cj4gPiA+IC0KPiA+ID4gICAgICAgaWYgKHZxLT5wYWNrZWRfcmluZykK
PiA+ID4gICAgICAgICAgICAgICB2aXJ0cXVldWVfZGlzYWJsZV9jYl9wYWNrZWQoX3ZxKTsKPiA+
ID4gICAgICAgZWxzZQo+ID4gPiAtLQo+ID4gPiAyLjMxLjEKPiA+ID4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
