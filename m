Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A4CC433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 08:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41863843B4;
	Thu, 24 Mar 2022 08:38:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1HwZ48jrbIjR; Thu, 24 Mar 2022 08:38:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DAD96843B1;
	Thu, 24 Mar 2022 08:38:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83C89C001A;
	Thu, 24 Mar 2022 08:38:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92689C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70A374027B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:38:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j3V8-Mi5rpSf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:38:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 395954021E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:38:20 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R771e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V84A2yB_1648111097; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V84A2yB_1648111097) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Mar 2022 16:38:17 +0800
Message-ID: <1648110896.1444745-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v8 16/16] virtio_ring: introduce virtqueue_resize()
Date: Thu, 24 Mar 2022 16:34:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-17-xuanzhuo@linux.alibaba.com>
 <e61a9ff4-621b-e7ec-b819-1b4c7e38fa67@redhat.com>
In-Reply-To: <e61a9ff4-621b-e7ec-b819-1b4c7e38fa67@redhat.com>
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

T24gVHVlLCAyMiBNYXIgMjAyMiAxNDowMjo0NyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi8zLzE0IOS4i+WNiDU6MzQsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBJbnRyb2R1Y2UgdmlydHF1ZXVlX3Jlc2l6ZSgpIHRvIGltcGxlbWVudCB0
aGUgcmVzaXplIG9mIHZyaW5nLgo+ID4gQmFzZWQgb24gdGhlc2UsIHRoZSBkcml2ZXIgY2FuIGR5
bmFtaWNhbGx5IGFkanVzdCB0aGUgc2l6ZSBvZiB0aGUgdnJpbmcuCj4gPiBGb3IgZXhhbXBsZTog
ZXRodG9vbCAtRy4KPiA+Cj4gPiB2aXJ0cXVldWVfcmVzaXplKCkgaW1wbGVtZW50cyByZXNpemUg
YmFzZWQgb24gdGhlIHZxIHJlc2V0IGZ1bmN0aW9uLiBJbgo+ID4gY2FzZSBvZiBmYWlsdXJlIHRv
IGFsbG9jYXRlIGEgbmV3IHZyaW5nLCBpdCB3aWxsIGdpdmUgdXAgcmVzaXplIGFuZCB1c2UKPiA+
IHRoZSBvcmlnaW5hbCB2cmluZy4KPiA+Cj4gPiBEdXJpbmcgdGhpcyBwcm9jZXNzLCBpZiB0aGUg
cmUtZW5hYmxlIHJlc2V0IHZxIGZhaWxzLCB0aGUgdnEgY2FuIG5vCj4gPiBsb25nZXIgYmUgdXNl
ZC4gQWx0aG91Z2ggdGhlIHByb2JhYmlsaXR5IG9mIHRoaXMgc2l0dWF0aW9uIGlzIG5vdCBoaWdo
Lgo+ID4KPiA+IFRoZSBwYXJhbWV0ZXIgcmVjeWNsZSBpcyB1c2VkIHRvIHJlY3ljbGUgdGhlIGJ1
ZmZlciB0aGF0IGlzIG5vIGxvbmdlcgo+ID4gdXNlZC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKPiA+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAzICsrCj4gPiAg
IDIgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gaW5kZXggZmIwYWJmOWEyZjU3Li5iMWRkZTA4NmE4YTQgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jCj4gPiBAQCAtMjUyOCw2ICsyNTI4LDczIEBAIHN0cnVjdCB2aXJ0cXVldWUgKnZy
aW5nX2NyZWF0ZV92aXJ0cXVldWUoCj4gPiAgIH0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwodnJp
bmdfY3JlYXRlX3ZpcnRxdWV1ZSk7Cj4gPgo+ID4gKy8qKgo+ID4gKyAqIHZpcnRxdWV1ZV9yZXNp
emUgLSByZXNpemUgdGhlIHZyaW5nIG9mIHZxCj4gPiArICogQHZxOiB0aGUgc3RydWN0IHZpcnRx
dWV1ZSB3ZSdyZSB0YWxraW5nIGFib3V0Lgo+ID4gKyAqIEBudW06IG5ldyByaW5nIG51bQo+ID4g
KyAqIEByZWN5Y2xlOiBjYWxsYmFjayBmb3IgcmVjeWNsZSB0aGUgdXNlbGVzcyBidWZmZXIKPiA+
ICsgKgo+ID4gKyAqIFdoZW4gaXQgaXMgcmVhbGx5IG5lY2Vzc2FyeSB0byBjcmVhdGUgYSBuZXcg
dnJpbmcsIGl0IHdpbGwgc2V0IHRoZSBjdXJyZW50IHZxCj4gPiArICogaW50byB0aGUgcmVzZXQg
c3RhdGUuIFRoZW4gY2FsbCB0aGUgcGFzc2VkIGNiIHRvIHJlY3ljbGUgdGhlIGJ1ZmZlciB0aGF0
IGlzCj4gPiArICogbm8gbG9uZ2VyIHVzZWQuIE9ubHkgYWZ0ZXIgdGhlIG5ldyB2cmluZyBpcyBz
dWNjZXNzZnVsbHkgY3JlYXRlZCwgdGhlIG9sZAo+ID4gKyAqIHZyaW5nIHdpbGwgYmUgcmVsZWFz
ZWQuCj4gPiArICoKPiA+ICsgKiBDYWxsZXIgbXVzdCBlbnN1cmUgd2UgZG9uJ3QgY2FsbCB0aGlz
IHdpdGggb3RoZXIgdmlydHF1ZXVlIG9wZXJhdGlvbnMKPiA+ICsgKiBhdCB0aGUgc2FtZSB0aW1l
IChleGNlcHQgd2hlcmUgbm90ZWQpLgo+ID4gKyAqCj4gPiArICogUmV0dXJucyB6ZXJvIG9yIGEg
bmVnYXRpdmUgZXJyb3IuCj4gPiArICogLUVOT01FTTogY3JlYXRlIG5ldyB2cmluZyBmYWlsLiBC
dXQgdnEgY2FuIHN0aWxsIHdvcmsKPiA+ICsgKiAtRUJVU1k6ICByZXNldC9yZS1lbmFibGUgdnEg
ZmFpbC4gdnEgbWF5IGNhbm5vdCB3b3JrCj4gPiArICogLUVOT0VOVDogbm90IHN1cHBvcnQgcmVz
aXplCj4gPiArICogLUUyQklHLy1FSU5WQUw6IHBhcmFtIG51bSBlcnJvcgo+ID4gKyAqLwo+ID4g
K2ludCB2aXJ0cXVldWVfcmVzaXplKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB1MzIgbnVtLAo+ID4g
KwkJICAgICB2b2lkICgqcmVjeWNsZSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zikp
Cj4gPiArewo+ID4gKwlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IHZxLT52ZGV2Owo+ID4g
Kwl2b2lkICpidWY7Cj4gPiArCWludCBlcnI7Cj4gPiArCj4gPiArCWlmIChudW0gPiB2cS0+bnVt
X21heCkKPiA+ICsJCXJldHVybiAtRTJCSUc7Cj4gPiArCj4gPiArCWlmICghbnVtKQo+ID4gKwkJ
cmV0dXJuIC1FSU5WQUw7Cj4gPiArCj4gPiArCWlmICh0b192dnEodnEpLT5wYWNrZWQudnJpbmcu
bnVtID09IG51bSkKPiA+ICsJCXJldHVybiAwOwo+Cj4KPiBBbnkgcmVhc29uIHdlIG5lZWQgdG8g
Y2hlY2sgYSBwYWNrZWQgc3BlY2lmaWMgYXR0cmlidXRlIGhlcmU/CgpUaGlzIGlzIGEgbWlzdGFr
ZS4gU29ycnkgZm9yIHRoaXMuCgo+Cj4KPiA+ICsKPiA+ICsJaWYgKCF2cS0+dmRldi0+Y29uZmln
LT5yZXNldF92cSkKPiA+ICsJCXJldHVybiAtRU5PRU5UOwo+ID4gKwo+ID4gKwlpZiAoIXZxLT52
ZGV2LT5jb25maWctPmVuYWJsZV9yZXNldF92cSkKPiA+ICsJCXJldHVybiAtRU5PRU5UOwo+ID4g
Kwo+ID4gKwllcnIgPSB2cS0+dmRldi0+Y29uZmlnLT5yZXNldF92cSh2cSk7Cj4gPiArCWlmIChl
cnIpIHsKPiA+ICsJCWlmIChlcnIgIT0gLUVOT0VOVCkKPiA+ICsJCQllcnIgPSAtRUJVU1k7Cj4g
PiArCQlyZXR1cm4gZXJyOwo+ID4gKwl9Cj4gPiArCj4gPiArCXdoaWxlICgoYnVmID0gdmlydHF1
ZXVlX2RldGFjaF91bnVzZWRfYnVmKHZxKSkgIT0gTlVMTCkKPiA+ICsJCXJlY3ljbGUodnEsIGJ1
Zik7Cj4gPiArCj4gPiArCWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0ZfUklO
R19QQUNLRUQpKQo+ID4gKwkJZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZV9wYWNrZWQodnEsIG51bSk7
Cj4gPiArCWVsc2UKPiA+ICsJCWVyciA9IHZpcnRxdWV1ZV9yZXNpemVfc3BsaXQodnEsIG51bSk7
Cj4gPiArCj4gPiArCWlmIChlcnIpCj4gPiArCQllcnIgPSAtRU5PTUVNOwo+Cj4KPiBTbyB0aGlz
IGFzc3VtZXMgdGhhdCB0aGUgLUVOT01FTSBpcyB0aGUgb25seSBwb3NzaWJsZSBlcnJvciB2YWx1
ZSBmb3IKPiB2aXJ0cXVldWVfcmVzaXplX3h4eCgpLiBJcyB0aGlzIHRydWU/IChFLmcgd3Jvbmcg
c2l6ZSkKClllcywgSSB3YW50IHRoZSB1c2VyIHRvIGtub3cgYXQgd2hpY2ggc3RlcCB0aGUgZXJy
b3IgaXMgcmV0dXJuZWQuCgo+Cj4KPiA+ICsKPiA+ICsJaWYgKHZxLT52ZGV2LT5jb25maWctPmVu
YWJsZV9yZXNldF92cSh2cSkpCj4gPiArCQlyZXR1cm4gLUVCVVNZOwo+ID4gKwo+ID4gKwlyZXR1
cm4gZXJyOwo+ID4gK30KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfcmVzaXplKTsK
PiA+ICsKPiA+ICAgLyogT25seSBhdmFpbGFibGUgZm9yIHNwbGl0IHJpbmcgKi8KPiA+ICAgc3Ry
dWN0IHZpcnRxdWV1ZSAqdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4g
PiAgIAkJCQkgICAgICB1bnNpZ25lZCBpbnQgbnVtLAo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiBpbmRleCBkNTlhZGM0
YmUwNjguLmM4NmZmMDJlMGNhMCAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlv
LmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+IEBAIC05MSw2ICs5MSw5IEBA
IGRtYV9hZGRyX3QgdmlydHF1ZXVlX2dldF9kZXNjX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAqdnEp
Owo+ID4gICBkbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfYXZhaWxfYWRkcihzdHJ1Y3QgdmlydHF1
ZXVlICp2cSk7Cj4gPiAgIGRtYV9hZGRyX3QgdmlydHF1ZXVlX2dldF91c2VkX2FkZHIoc3RydWN0
IHZpcnRxdWV1ZSAqdnEpOwo+ID4KPiA+ICtpbnQgdmlydHF1ZXVlX3Jlc2l6ZShzdHJ1Y3Qgdmly
dHF1ZXVlICp2cSwgdTMyIG51bSwKPiA+ICsJCSAgICAgdm9pZCAoKnJlY3ljbGUpKHN0cnVjdCB2
aXJ0cXVldWUgKnZxLCB2b2lkICpidWYpKTsKPgo+Cj4gSSB3b25kZXIgd2hhdCdzIHRoZSBhZHZh
bnRhZ2VzIG9mIGNvdXBsaW5nIHZpcnRxdWV1ZV9yZXNldCBpbgo+IHZpcnRxdWV1ZV9yZXNpemUo
KS4KClRoaXMgaXMgTWljaGFlbCdzIGNvbW1lbnQgb24gdGhlIHByZXZpb3VzIHZlcnNpb24KCj4K
PiBJdCBsb29rcyB0byBtZSBpdCB3b2xkIGJlIG1vcmUgZmxleGlibGUgdG8gbGV0IHRoZSBkcml2
ZXIgZG86Cj4KPiByZXN0KCkKPgo+IGRldGFjaCgpCj4KPiByZXNpemUoKQo+Cj4gZW5hYmxlX3Jl
c2V0KCkKPgo+IE9uZSByZWFzb24gaXMgdGhhdCBpbiB0aGUgZnV0dXJlIHdlIG1heSB3YW50IHRv
IGFkZCBtb3JlIGZ1bmN0aW9uYWxpdHkKPiBlLmcgc3dpdGNoaW5nIFBBU0lEIGR1cmluZyB2aXJ0
cXVldWUgcmVzZXQuCgpNaWNoYWVsLCBmcm9tIEphc29uIFdhbmcncyBwbGFuLCBzaG91bGQgd2Ug
Z28gYmFjayB0byB0aGUgb3JpZ2luYWwgNCBhcGkgbW9kZWw/CgpUaGFua3MuCgoKPgo+IFRoYW5r
cwo+Cj4KPiA+ICsKPiA+ICAgLyoqCj4gPiAgICAqIHZpcnRpb19kZXZpY2UgLSByZXByZXNlbnRh
dGlvbiBvZiBhIGRldmljZSB1c2luZyB2aXJ0aW8KPiA+ICAgICogQGluZGV4OiB1bmlxdWUgcG9z
aXRpb24gb24gdGhlIHZpcnRpbyBidXMKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
