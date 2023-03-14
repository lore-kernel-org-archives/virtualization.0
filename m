Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B73C6FD1F
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 09:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A9FD8139C;
	Tue, 14 Mar 2023 09:17:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A9FD8139C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kIekapRiuw-Q; Tue, 14 Mar 2023 09:17:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AAECF81384;
	Tue, 14 Mar 2023 09:17:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AAECF81384
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76DE8C0035;
	Tue, 14 Mar 2023 09:17:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77AE0C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 09:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5220461049
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 09:17:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5220461049
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EeWQAd1gqkKK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 09:17:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBC6C60A94
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBC6C60A94
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 09:17:15 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R651e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vdra4bZ_1678785430; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vdra4bZ_1678785430) by smtp.aliyun-inc.com;
 Tue, 14 Mar 2023 17:17:11 +0800
Message-ID: <1678785225.2361012-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 06/12] virtio_ring: split-indirect: support
 premapped
Date: Tue, 14 Mar 2023 17:13:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
 <20230308064443.50639-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEs0bGAVhawHLbR_f1NupAGJfVdo_jVSNx2i74b6Y4nJ=Q@mail.gmail.com>
In-Reply-To: <CACGkMEs0bGAVhawHLbR_f1NupAGJfVdo_jVSNx2i74b6Y4nJ=Q@mail.gmail.com>
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

T24gVHVlLCAxNCBNYXIgMjAyMyAxNTo1NzowNiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gV2VkLCBNYXIgOCwgMjAyMyBhdCAyOjQ04oCvUE0gWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gdmlydGlv
IGNvcmUgb25seSBzdXBwb3J0cyB2aXJ0dWFsIGFkZHJlc3NlcywgZG1hIGlzIGNvbXBsZXRlZCBp
biB2aXJ0aW8KPiA+IGNvcmUuCj4gPgo+ID4gSW4gc29tZSBzY2VuYXJpb3MgKHN1Y2ggYXMgdGhl
IEFGX1hEUCksIHRoZSBtZW1vcnkgaXMgYWxsb2NhdGVkCj4gPiBhbmQgRE1BIGlzIGNvbXBsZXRl
ZCBpbiBhZHZhbmNlLCBzbyBpdCBpcyBuZWNlc3NhcnkgZm9yIHVzIHRvIHN1cHBvcnQKPiA+IHBh
c3NpbmcgdGhlIERNQSBhZGRyZXNzIHRvIHZpcnRpbyBjb3JlLgo+ID4KPiA+IERyaXZlcyBjYW4g
dXNlIHNnLT5kbWFfYWRkcmVzcyB0byBwYXNzIHRoZSBtYXBwZWQgZG1hIGFkZHJlc3MgdG8gdmly
dGlvCj4gPiBjb3JlLiBJZiBvbmUgc2ctPmRtYV9hZGRyZXNzIGlzIHVzZWQgdGhlbiBhbGwgc2dz
IG11c3QgdXNlIHNnLT5kbWFfYWRkcmVzcywKPiA+IG90aGVyd2lzZSBhbGwgZG1hX2FkZHJlc3Mg
bXVzdCBiZSBudWxsLgo+ID4KPiA+IE9uIHRoZSBpbmRpcmVjdCBwYXRoLCBpZiBkbWFfYWRkcmVz
cyBpcyB1c2VkLCBkZXNjX3N0YXRlLmluZGlyX2Rlc2Mgd2lsbAo+ID4gYmUgbWl4ZWQgd2l0aCBW
UklOR19JTkRJUkVDVF9QUkVNQVBQRUQuIFNvIHdoZW4gZG8gdW5tYXAsIHdlIGNhbiBwYXNzIGl0
Lgo+Cj4gSXQncyBiZXR0ZXIgdG8gbWVudGlvbiB3aHkgaW5kaXJlY3QgZGVzY3JpcHRvcnMgY2Fu
J3QgYmUgZG9uZSBpbiB0aGUKPiBzYW1lIHdheSB3aXRoIGRpcmVjdCBkZXNjcmlwdG9ycy4KPgo+
IEJ0dywgaWYgd2UgY2hhbmdlIHRoZSBzZW1hbnRpY3Mgb2YgZGVzY19leHRyYS5kbWFfYWRkciBh
bmQKPiBkZXNjX3N0YXRlLmluZGlyX2Rlc2MsIHdlIHNob3VsZCBhZGQgY29tbWVudHMgdG8gZGVm
aW5pdGlvbnMgb2YgdGhvc2UKPiBzdHJ1Y3R1cmVzLgoKCldpbGwgZml4LgoKPgo+ID4KPiA+IFNp
Z25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAt
LS0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjggKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gaW5kZXggNjZhMDcxZTNiZGVm
Li4xMTgyN2QyZTU2YTggMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBAQCAtMjMxLDYg
KzIzMSwxOCBAQCBzdGF0aWMgdm9pZCB2cmluZ19mcmVlKHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7
Cj4gPiAgICogSGVscGVycy4KPiA+ICAgKi8KPiA+Cj4gPiArI2RlZmluZSBWUklOR19JTkRJUkVD
VF9QUkVNQVBQRUQgIEJJVCgwKQo+ID4gKwo+ID4gKyNkZWZpbmUgZGVzY19taXhfZG1hX21hcChk
b19tYXAsIGRlc2MpIFwKPiA+ICsgICAgICAgKGRvX21hcCA/IGRlc2MgOiAodHlwZW9mKGRlc2Mp
KSgodW5zaWduZWQgbG9uZykoZGVzYykgfCBWUklOR19JTkRJUkVDVF9QUkVNQVBQRUQpKQo+ID4g
Kwo+ID4gKyNkZWZpbmUgZGVzY19ybV9kbWFfbWFwKGRlc2MpIFwKPiA+ICsgICAgICAgKCh0eXBl
b2YoZGVzYykpKCh1bnNpZ25lZCBsb25nKShkZXNjKSAmIH5WUklOR19JTkRJUkVDVF9QUkVNQVBQ
RUQpKQo+ID4gKwo+ID4gKyNkZWZpbmUgZGVzY19tYXBfaW50ZXIoZGVzYykgXAo+ID4gKyAgICAg
ICAhKCh1bnNpZ25lZCBsb25nKShkZXNjKSAmIFZSSU5HX0lORElSRUNUX1BSRU1BUFBFRCkKPiA+
ICsKPiA+ICsKPiA+ICAjZGVmaW5lIHRvX3Z2cShfdnEpIGNvbnRhaW5lcl9vZihfdnEsIHN0cnVj
dCB2cmluZ192aXJ0cXVldWUsIHZxKQo+ID4KPiA+ICBzdGF0aWMgaW5saW5lIGJvb2wgdmlydHF1
ZXVlX3VzZV9pbmRpcmVjdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiA+IEBAIC03MjUs
NyArNzM3LDcgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3Qg
dmlydHF1ZXVlICpfdnEsCj4gPiAgICAgICAgIC8qIFN0b3JlIHRva2VuIGFuZCBpbmRpcmVjdCBi
dWZmZXIgc3RhdGUuICovCj4gPiAgICAgICAgIHZxLT5zcGxpdC5kZXNjX3N0YXRlW2hlYWRdLmRh
dGEgPSBkYXRhOwo+ID4gICAgICAgICBpZiAoaW5kaXJlY3QpCj4gPiAtICAgICAgICAgICAgICAg
dnEtPnNwbGl0LmRlc2Nfc3RhdGVbaGVhZF0uaW5kaXJfZGVzYyA9IGRlc2M7Cj4gPiArICAgICAg
ICAgICAgICAgdnEtPnNwbGl0LmRlc2Nfc3RhdGVbaGVhZF0uaW5kaXJfZGVzYyA9IGRlc2NfbWl4
X2RtYV9tYXAoZG9fbWFwLCBkZXNjKTsKPgo+IFNvIHVzaW5nIGluZGlyX2Rlc2MgaXMga2luZCBv
ZiBoYWNreSAoc2luY2Ugd2UgZG9uJ3QgdXNlIGluZGlyZWN0IGZvcgo+IHJ4IHdpdGggZXh0cmEg
Y29udGV4dCkuCj4KPiBCdXQgYXQgbGVhc3QgSSB0aGluayB3ZSBzaG91bGQgc2Vla2Egd2F5IHRv
IHVzZSB0aGUgc2FtZSBtZXRhZGF0YSBmb3IKPiBib3RoIGRpcmVjdCBhbmQgaW5kaXJlY3QgZGVz
Y3JpcHRvcnMuCj4KPiBFLmcgY2FuIHdlIG1ha2UgdGhlbSBhbGwgdG8gdXNlIGluZGlyX2Rlc2M/
CgpJIHRoaW5rIGl0IG1heSBub3QuIE15IG9yaWdpbmFsIGlkZWEgaXMgdG8gdXNlIGluZGlyX2Rl
c2MgdW5pZm9ybWx5LCBidXQKZm9yIHRoZSBzY2VuZSBvZiBzYXZpbmcgY3R4LCB3ZSBjYW5ub3Qg
Z3VhcmFudGVlIHRoYXQgdGhlIGN0eCBoYXMgc3BhY2UgZm9yIHVzLgoKVGhhbmtzLgoKPgo+IFRo
YW5rcwo+Cj4gPiAgICAgICAgIGVsc2UKPiA+ICAgICAgICAgICAgICAgICB2cS0+c3BsaXQuZGVz
Y19zdGF0ZVtoZWFkXS5pbmRpcl9kZXNjID0gY3R4Owo+ID4KPiA+IEBAIC04MjAsMjIgKzgzMiwy
NiBAQCBzdGF0aWMgdm9pZCBkZXRhY2hfYnVmX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUg
KnZxLCB1bnNpZ25lZCBpbnQgaGVhZCwKPiA+ICAgICAgICAgdnEtPnZxLm51bV9mcmVlKys7Cj4g
Pgo+ID4gICAgICAgICBpZiAodnEtPmluZGlyZWN0KSB7Cj4gPiAtICAgICAgICAgICAgICAgc3Ry
dWN0IHZyaW5nX2Rlc2MgKmluZGlyX2Rlc2MgPQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2cS0+c3BsaXQuZGVzY19zdGF0ZVtoZWFkXS5pbmRpcl9kZXNjOwo+ID4gKyAgICAg
ICAgICAgICAgIHN0cnVjdCB2cmluZ19kZXNjICptaXggPSB2cS0+c3BsaXQuZGVzY19zdGF0ZVto
ZWFkXS5pbmRpcl9kZXNjOwo+ID4gKyAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ19kZXNjICpp
bmRpcl9kZXNjOwo+ID4gICAgICAgICAgICAgICAgIHUzMiBsZW47Cj4gPgo+ID4gICAgICAgICAg
ICAgICAgIC8qIEZyZWUgdGhlIGluZGlyZWN0IHRhYmxlLCBpZiBhbnksIG5vdyB0aGF0IGl0J3Mg
dW5tYXBwZWQuICovCj4gPiAtICAgICAgICAgICAgICAgaWYgKCFpbmRpcl9kZXNjKQo+ID4gKyAg
ICAgICAgICAgICAgIGlmICghbWl4KQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
Owo+ID4KPiA+ICsgICAgICAgICAgICAgICBpbmRpcl9kZXNjID0gZGVzY19ybV9kbWFfbWFwKG1p
eCk7Cj4gPiArCj4gPiAgICAgICAgICAgICAgICAgbGVuID0gdnEtPnNwbGl0LmRlc2NfZXh0cmFb
aGVhZF0ubGVuOwo+ID4KPiA+ICAgICAgICAgICAgICAgICBCVUdfT04oISh2cS0+c3BsaXQuZGVz
Y19leHRyYVtoZWFkXS5mbGFncyAmCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFZSSU5HX0RFU0NfRl9JTkRJUkVDVCkpOwo+ID4gICAgICAgICAgICAgICAgIEJVR19PTihsZW4g
PT0gMCB8fCBsZW4gJSBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2MpKTsKPiA+Cj4gPiAtICAgICAg
ICAgICAgICAgZm9yIChqID0gMDsgaiA8IGxlbiAvIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzYyk7
IGorKykKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHZyaW5nX3VubWFwX29uZV9zcGxpdF9p
bmRpcmVjdCh2cSwgJmluZGlyX2Rlc2Nbal0pOwo+ID4gKyAgICAgICAgICAgICAgIGlmIChkZXNj
X21hcF9pbnRlcihtaXgpKSB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBmb3IgKGogPSAw
OyBqIDwgbGVuIC8gc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjKTsgaisrKQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB2cmluZ191bm1hcF9vbmVfc3BsaXRfaW5kaXJlY3QodnEs
ICZpbmRpcl9kZXNjW2pdKTsKPiA+ICsgICAgICAgICAgICAgICB9Cj4gPgo+ID4gICAgICAgICAg
ICAgICAgIGtmcmVlKGluZGlyX2Rlc2MpOwo+ID4gICAgICAgICAgICAgICAgIHZxLT5zcGxpdC5k
ZXNjX3N0YXRlW2hlYWRdLmluZGlyX2Rlc2MgPSBOVUxMOwo+ID4gLS0KPiA+IDIuMzIuMC4zLmcw
MTE5NWNmOWYKPiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
