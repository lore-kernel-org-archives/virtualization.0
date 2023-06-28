Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB1EEB64D9
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 01:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56D6F81F90;
	Wed, 28 Jun 2023 01:34:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56D6F81F90
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KQLU2Dru6bhh; Wed, 28 Jun 2023 01:34:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 96ED681403;
	Wed, 28 Jun 2023 01:34:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96ED681403
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73F8AC007C;
	Wed, 28 Jun 2023 01:34:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EABD8C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 01:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1ADE4057B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 01:34:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1ADE4057B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wDe4aS-zWHZM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 01:34:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FB134054B
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FB134054B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 01:34:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R911e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vm7Wugg_1687916085; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vm7Wugg_1687916085) by smtp.aliyun-inc.com;
 Wed, 28 Jun 2023 09:34:46 +0800
Message-ID: <1687916061.7751381-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 02/10] virtio_ring: introduce
 virtqueue_set_premapped()
Date: Wed, 28 Jun 2023 09:34:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEt3xRvn5na+f4vHjFQoJJcPTvvE3Yd_bGxrDFo9owkqCA@mail.gmail.com>
 <1687855801.1280077-4-xuanzhuo@linux.alibaba.com>
 <20230627105503-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230627105503-mutt-send-email-mst@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCAyNyBKdW4gMjAyMyAxMDo1Njo1NCAtMDQwMCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIg
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUdWUsIEp1biAyNywgMjAyMyBhdCAwNDo1MDow
MVBNICswODAwLCBYdWFuIFpodW8gd3JvdGU6Cj4gPiBPbiBUdWUsIDI3IEp1biAyMDIzIDE2OjAz
OjIzICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4g
T24gRnJpLCBKdW4gMiwgMjAyMyBhdCA1OjIy4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBUaGlzIGhlbHBlciBhbGxvd3Mg
dGhlIGRyaXZlciBjaGFuZ2UgdGhlIGRtYSBtb2RlIHRvIHByZW1hcHBlZCBtb2RlLgo+ID4gPiA+
IFVuZGVyIHRoZSBwcmVtYXBwZWQgbW9kZSwgdGhlIHZpcnRpbyBjb3JlIGRvIG5vdCBkbyBkbWEg
bWFwcGluZwo+ID4gPiA+IGludGVybmFsbHkuCj4gPiA+ID4KPiA+ID4gPiBUaGlzIGp1c3Qgd29y
ayB3aGVuIHRoZSB1c2VfZG1hX2FwaSBpcyB0cnVlLiBJZiB0aGUgdXNlX2RtYV9hcGkgaXMgZmFs
c2UsCj4gPiA+ID4gdGhlIGRtYSBvcHRpb25zIGlzIG5vdCB0aHJvdWdoIHRoZSBETUEgQVBJcywg
dGhhdCBpcyBub3QgdGhlIHN0YW5kYXJkCj4gPiA+ID4gd2F5IG9mIHRoZSBsaW51eCBrZXJuZWwu
Cj4gPiA+ID4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jIHwgNDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiA+ID4g
IGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgfCAgMiArKwo+ID4gPiA+ICAyIGZpbGVzIGNo
YW5nZWQsIDQyIGluc2VydGlvbnMoKykKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+
ID4gPiA+IGluZGV4IDcyZWQwN2E2MDRkNC4uMmFmZGZiOWUzZTMwIDEwMDY0NAo+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gQEAgLTE3Miw2ICsxNzIsOSBAQCBzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlIHsKPiA+ID4gPiAgICAgICAgIC8qIEhvc3QgcHVibGlzaGVzIGF2YWlsIGV2
ZW50IGlkeCAqLwo+ID4gPiA+ICAgICAgICAgYm9vbCBldmVudDsKPiA+ID4gPgo+ID4gPiA+ICsg
ICAgICAgLyogRG8gRE1BIG1hcHBpbmcgYnkgZHJpdmVyICovCj4gPiA+ID4gKyAgICAgICBib29s
IHByZW1hcHBlZDsKPiA+ID4gPiArCj4gPiA+ID4gICAgICAgICAvKiBIZWFkIG9mIGZyZWUgYnVm
ZmVyIGxpc3QuICovCj4gPiA+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgZnJlZV9oZWFkOwo+ID4g
PiA+ICAgICAgICAgLyogTnVtYmVyIHdlJ3ZlIGFkZGVkIHNpbmNlIGxhc3Qgc3luYy4gKi8KPiA+
ID4gPiBAQCAtMjA1OSw2ICsyMDYyLDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5n
X2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+ID4gPiA+ICAgICAgICAgdnEtPnBhY2tlZF9yaW5n
ID0gdHJ1ZTsKPiA+ID4gPiAgICAgICAgIHZxLT5kbWFfZGV2ID0gZG1hX2RldjsKPiA+ID4gPiAg
ICAgICAgIHZxLT51c2VfZG1hX2FwaSA9IHZyaW5nX3VzZV9kbWFfYXBpKHZkZXYpOwo+ID4gPiA+
ICsgICAgICAgdnEtPnByZW1hcHBlZCA9IGZhbHNlOwo+ID4gPiA+Cj4gPiA+ID4gICAgICAgICB2
cS0+aW5kaXJlY3QgPSB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX1JJTkdfRl9JTkRJ
UkVDVF9ERVNDKSAmJgo+ID4gPiA+ICAgICAgICAgICAgICAgICAhY29udGV4dDsKPiA+ID4gPiBA
QCAtMjU0OCw2ICsyNTUyLDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3
X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiA+ID4gICNlbmRpZgo+ID4gPiA+ICAg
ICAgICAgdnEtPmRtYV9kZXYgPSBkbWFfZGV2Owo+ID4gPiA+ICAgICAgICAgdnEtPnVzZV9kbWFf
YXBpID0gdnJpbmdfdXNlX2RtYV9hcGkodmRldik7Cj4gPiA+ID4gKyAgICAgICB2cS0+cHJlbWFw
cGVkID0gZmFsc2U7Cj4gPiA+ID4KPiA+ID4gPiAgICAgICAgIHZxLT5pbmRpcmVjdCA9IHZpcnRp
b19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fUklOR19GX0lORElSRUNUX0RFU0MpICYmCj4gPiA+
ID4gICAgICAgICAgICAgICAgICFjb250ZXh0Owo+ID4gPiA+IEBAIC0yNjkxLDYgKzI2OTYsNDEg
QEAgaW50IHZpcnRxdWV1ZV9yZXNpemUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLCB1MzIgbnVtLAo+
ID4gPiA+ICB9Cj4gPiA+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9yZXNpemUpOwo+
ID4gPiA+Cj4gPiA+ID4gKy8qKgo+ID4gPiA+ICsgKiB2aXJ0cXVldWVfc2V0X3ByZW1hcHBlZCAt
IHNldCB0aGUgdnJpbmcgcHJlbWFwcGVkIG1vZGUKPiA+ID4gPiArICogQF92cTogdGhlIHN0cnVj
dCB2aXJ0cXVldWUgd2UncmUgdGFsa2luZyBhYm91dC4KPiA+ID4gPiArICoKPiA+ID4gPiArICog
RW5hYmxlIHRoZSBwcmVtYXBwZWQgbW9kZSBvZiB0aGUgdnEuCj4gPiA+ID4gKyAqCj4gPiA+ID4g
KyAqIFRoZSB2cmluZyBpbiBwcmVtYXBwZWQgbW9kZSBkb2VzIG5vdCBkbyBkbWEgaW50ZXJuYWxs
eSwgc28gdGhlIGRyaXZlciBtdXN0Cj4gPiA+ID4gKyAqIGRvIGRtYSBtYXBwaW5nIGluIGFkdmFu
Y2UuIFRoZSBkcml2ZXIgbXVzdCBwYXNzIHRoZSBkbWFfYWRkcmVzcyB0aHJvdWdoCj4gPiA+ID4g
KyAqIGRtYV9hZGRyZXNzIG9mIHNjYXR0ZXJsaXN0LiBXaGVuIHRoZSBkcml2ZXIgZ290IGEgdXNl
ZCBidWZmZXIgZnJvbQo+ID4gPiA+ICsgKiB0aGUgdnJpbmcsIGl0IGhhcyB0byB1bm1hcCB0aGUg
ZG1hIGFkZHJlc3MuIFNvIHRoZSBkcml2ZXIgbXVzdCBjYWxsCj4gPiA+ID4gKyAqIHZpcnRxdWV1
ZV9nZXRfYnVmX3ByZW1hcHBlZCgpL3ZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1Zl9wcmVtYXBw
ZWQoKS4KPiA+ID4gPiArICoKPiA+ID4gPiArICogVGhpcyBtdXN0IGJlIGNhbGxlZCBiZWZvcmUg
YWRkaW5nIGFueSBidWYgdG8gdnJpbmcuCj4gPiA+Cj4gPiA+IEFuZCBhbnkgb2xkIGJ1ZmZlciBz
aG91bGQgYmUgZGV0YWNoZWQ/Cj4gPgo+ID4gSSBtZWFuIHRoYXQgYmVmb3JlIGFkZGluZyBhbnkg
YnVmLCBTbyB0aGVyZSBhcmUgbm90IG9sZCBidWZmZXIuCj4gPgo+Cj4gT2guIFNvIHB1dCB0aGlz
IGluIHRoZSBzYW1lIHNlbnRlbmNlOgo+Cj4gCVRoaXMgZnVuY3Rpb24gbXVzdCBiZSBjYWxsZWQg
aW1tZWRpYXRlbHkgYWZ0ZXIgY3JlYXRpbmcgdGhlIHZxLAo+IAlvciBhZnRlciB2cSByZXNldCwg
YW5kIGJlZm9yZSBhZGRpbmcgYW55IGJ1ZmZlcnMgdG8gaXQuCgoKT0ssIHRoYW5rcy4KCj4KPgo+
ID4gPgo+ID4gPiA+ICsgKiBTbyB0aGlzIHNob3VsZCBiZSBjYWxsZWQgaW1tZWRpYXRlbHkgYWZ0
ZXIgaW5pdCB2cSBvciB2cSByZXNldC4KPgo+IERvIHlvdSByZWFsbHkgbmVlZCB0byBjYWxsIHRo
aXMgYWdhaW4gYWZ0ZXIgZWFjaCByZXNldD8KCllFUwoKClRoYW5rcy4KCgo+Cj4KPiA+ID4gQW55
IHdheSB0byBkZXRlY3QgYW5kIHdhcm4gaW4gdGhpcyBjYXNlPyAobm90IGEgbXVzdCBpZiBpdCdz
IHRvbwo+ID4gPiBleHBlbnNpdmUgdG8gZG8gdGhlIGNoZWNrKQo+ID4KPiA+Cj4gPiBJIGNhbiB0
cnkgdG8gY2hlY2sgd2hldGhlciB0aGUgcWV1ZXUgaXMgZW1wdHkuCj4gPgo+ID4KPiA+ID4KPiA+
ID4gPiArICoKPiA+ID4gPiArICogQ2FsbGVyIG11c3QgZW5zdXJlIHdlIGRvbid0IGNhbGwgdGhp
cyB3aXRoIG90aGVyIHZpcnRxdWV1ZSBvcGVyYXRpb25zCj4gPiA+ID4gKyAqIGF0IHRoZSBzYW1l
IHRpbWUgKGV4Y2VwdCB3aGVyZSBub3RlZCkuCj4gPiA+ID4gKyAqCj4gPiA+ID4gKyAqIFJldHVy
bnMgemVybyBvciBhIG5lZ2F0aXZlIGVycm9yLgo+ID4gPiA+ICsgKiAwOiBzdWNjZXNzLgo+ID4g
PiA+ICsgKiAtRUlOVkFMOiB2cmluZyBkb2VzIG5vdCB1c2UgdGhlIGRtYSBhcGksIHNvIHdlIGNh
biBub3QgZW5hYmxlIHByZW1hcHBlZCBtb2RlLgo+ID4gPiA+ICsgKi8KPiA+ID4gPiAraW50IHZp
cnRxdWV1ZV9zZXRfcHJlbWFwcGVkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPiA+ID4gPiArewo+
ID4gPiA+ICsgICAgICAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsK
PiA+ID4gPiArCj4gPiA+ID4gKyAgICAgICBpZiAoIXZxLT51c2VfZG1hX2FwaSkKPiA+ID4gPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICAgICAg
dnEtPnByZW1hcHBlZCA9IHRydWU7Cj4gPiA+Cj4gPiA+IEkgZ3Vlc3MgdGhlcmUgc2hvdWxkIGJl
IGEgd2F5IHRvIGRpc2FibGUgaXQuIFdvdWxkIGl0IGJlIHVzZWZ1bCBmb3IKPiA+ID4gdGhlIGNh
c2Ugd2hlbiBBRl9YRFAgc29ja2V0cyB3ZXJlIGRlc3Ryb3llZD8KPiA+Cj4gPiBZZXMuCj4gPgo+
ID4gV2hlbiB3ZSByZXNldCB0aGUgcXVldWUsIHRoZSB2cS0+cHJlbWFwcGVkIHdpbGwgYmUgc2V0
IHRvIDAuCj4gPgo+ID4gVGhlIGlzIGNhbGxlZCBhZnRlciBmaW5kX3ZxcyBvciByZXNldCB2cS4K
PiA+Cj4gPiBUaGFua3MuCj4gPgo+ID4KPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4gPgo+ID4g
Pgo+ID4gPiA+ICsKPiA+ID4gPiArICAgICAgIHJldHVybiAwOwo+ID4gPiA+ICt9Cj4gPiA+ID4g
K0VYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9zZXRfcHJlbWFwcGVkKTsKPiA+ID4gPiArCj4g
PiA+ID4gIC8qIE9ubHkgYXZhaWxhYmxlIGZvciBzcGxpdCByaW5nICovCj4gPiA+ID4gIHN0cnVj
dCB2aXJ0cXVldWUgKnZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IG51
bSwKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaCBiL2luY2x1ZGUv
bGludXgvdmlydGlvLmgKPiA+ID4gPiBpbmRleCBiOTMyMzhkYjk0ZTMuLjFmYzBlMTAyM2JkNCAx
MDA2NDQKPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiA+ID4gKysrIGIv
aW5jbHVkZS9saW51eC92aXJ0aW8uaAo+ID4gPiA+IEBAIC03OCw2ICs3OCw4IEBAIGJvb2wgdmly
dHF1ZXVlX2VuYWJsZV9jYihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gPiA+ID4KPiA+ID4gPiAg
dW5zaWduZWQgdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVwYXJlKHN0cnVjdCB2aXJ0cXVldWUgKnZx
KTsKPiA+ID4gPgo+ID4gPiA+ICtpbnQgdmlydHF1ZXVlX3NldF9wcmVtYXBwZWQoc3RydWN0IHZp
cnRxdWV1ZSAqX3ZxKTsKPiA+ID4gPiArCj4gPiA+ID4gIGJvb2wgdmlydHF1ZXVlX3BvbGwoc3Ry
dWN0IHZpcnRxdWV1ZSAqdnEsIHVuc2lnbmVkKTsKPiA+ID4gPgo+ID4gPiA+ICBib29sIHZpcnRx
dWV1ZV9lbmFibGVfY2JfZGVsYXllZChzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gPiA+ID4gLS0K
PiA+ID4gPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4gPiA+ID4KPiA+ID4KPgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
