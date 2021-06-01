Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7731C4708F
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 06:03:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5032961263
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 06:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5032961263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1006E60603;
	Tue,  1 Jun 2021 06:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hz71qhlPwpIg; Tue,  1 Jun 2021 06:03:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86EE06069D;
	Tue,  1 Jun 2021 06:03:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58415C000E;
	Tue,  1 Jun 2021 06:03:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65081C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A669403F5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:03:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OM4vV2eZVm0l
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:03:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CED85403F3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:03:30 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0UarnsKu_1622527406; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UarnsKu_1622527406) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 01 Jun 2021 14:03:27 +0800
MIME-Version: 1.0
Message-Id: <1622527177.2087624-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 2/2] virtio-net: get build_skb() buf by data ptr
Date: Tue, 01 Jun 2021 13:59:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <93f79b8b-62c3-60f0-b401-0908e3e6325f@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCAxIEp1biAyMDIxIDExOjI3OjEyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIxLzYvMSDkuIrljYgxMTowOCwgWHVhbiBaaHVv
IOWGmemBkzoKPiA+IE9uIFR1ZSwgMSBKdW4gMjAyMSAxMTowMzozNyArMDgwMCwgSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4g5ZyoIDIwMjEvNS8zMSDkuIvljYg2
OjU4LCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4+PiBPbiBNb24sIDMxIE1heSAyMDIxIDE0OjEwOjU1
ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Pj4+IOWc
qCAyMDIxLzUvMTQg5LiL5Y2IMTE6MTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPj4+Pj4gSW4gdGhl
IGNhc2Ugb2YgbWVyZ2UsIHRoZSBwYWdlIHBhc3NlZCBpbnRvIHBhZ2VfdG9fc2tiKCkgbWF5IGJl
IGEgaGVhZAo+ID4+Pj4+IHBhZ2UsIG5vdCB0aGUgcGFnZSB3aGVyZSB0aGUgY3VycmVudCBkYXRh
IGlzIGxvY2F0ZWQuCj4gPj4+PiBJIGRvbid0IGdldCBob3cgdGhpcyBjYW4gaGFwcGVuPwo+ID4+
Pj4KPiA+Pj4+IE1heWJlIHlvdSBjYW4gZXhwbGFpbiBhIGxpdHRsZSBiaXQgbW9yZT8KPiA+Pj4+
Cj4gPj4+PiByZWNlaXZlX21lcmdlYWJsZSgpIGNhbGwgcGFnZV90b19za2IoKSBpbiB0d28gcGxh
Y2VzOgo+ID4+Pj4KPiA+Pj4+IDEpIFhEUF9QQVNTIGZvciBsaW5lYXJpemVkIHBhZ2UgLCBpbiB0
aGlzIGNhc2Ugd2UgdXNlIHhkcF9wYWdlCj4gPj4+PiAyKSBwYWdlX3RvX3NrYigpIGZvciAibm9y
bWFsIiBwYWdlLCBpbiB0aGlzIGNhc2UgdGhlIHBhZ2UgY29udGFpbnMgdGhlIGRhdGEKPiA+Pj4g
VGhlIG9mZnNldCBtYXkgYmUgZ3JlYXRlciB0aGFuIFBBR0VfU0laRSwgYmVjYXVzZSBwYWdlIGlz
IG9idGFpbmVkIGJ5Cj4gPj4+IHZpcnRfdG9faGVhZF9wYWdlKCksIG5vdCB0aGUgcGFnZSB3aGVy
ZSBidWYgaXMgbG9jYXRlZC4gQW5kICJvZmZzZXQiIGlzIHRoZSBvZmZzZXQKPiA+Pj4gb2YgYnVm
IHJlbGF0aXZlIHRvIHBhZ2UuCj4gPj4+Cj4gPj4+IAl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVu
IC0gb2Zmc2V0Owo+ID4+Pgo+ID4+PiBJbiB0aGlzIGNhc2UsIHRoZSB0YWlscm9vbSBtdXN0IGJl
IGxlc3MgdGhhbiAwLiBBbHRob3VnaCB0aGVyZSBtYXkgYmUgZW5vdWdoCj4gPj4+IGNvbnRlbnQg
b24gdGhpcyBwYWdlIHRvIHNhdmUgc2tiX3NoYXJlZF9pbmZvLgo+ID4+Cj4gPj4gSW50ZXJlc3Rp
bmcsIEkgdGhpbmsgd2UgZG9uJ3QgdXNlIGNvbXBvdW5kIHBhZ2VzIGZvciB2aXJ0aW8tbmV0LiAo
V2UKPiA+PiBkb24ndCBkZWZpbmUgU0tCX0ZSQUdfUEFHRV9PUkRFUikuCj4gPj4KPiA+PiBBbSBJ
IHdyb25nPwo+ID4KPiA+IEl0IHNlZW1zIHRvIG1lIHRoYXQgaXQgc2VlbXMgdG8gYmUgYSBmaXhl
ZCBzZXR0aW5nLCBub3QgZm9yIHVzIHRvIGNvbmZpZ3VyZQo+ID4gaW5kZXBlbmRlbnRseQo+Cj4K
PiBMb29rcyBsaWtlIHlvdSBhcmUgcmlnaHQuCj4KPiBTZWUgY29tbWVudHMgYmVsb3cuCj4KPgo+
ID4KPiA+IFRoYW5rcy4KPiA+Cj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KPiA+Cj4gPiBuZXQvc29jay5jCj4gPgo+ID4gI2RlZmluZSBTS0JfRlJBR19QQUdF
X09SREVSCWdldF9vcmRlcigzMjc2OCkKPiA+IERFRklORV9TVEFUSUNfS0VZX0ZBTFNFKG5ldF9o
aWdoX29yZGVyX2FsbG9jX2Rpc2FibGVfa2V5KTsKPiA+Cj4gPiAvKioKPiA+ICAgKiBza2JfcGFn
ZV9mcmFnX3JlZmlsbCAtIGNoZWNrIHRoYXQgYSBwYWdlX2ZyYWcgY29udGFpbnMgZW5vdWdoIHJv
b20KPiA+ICAgKiBAc3o6IG1pbmltdW0gc2l6ZSBvZiB0aGUgZnJhZ21lbnQgd2Ugd2FudCB0byBn
ZXQKPiA+ICAgKiBAcGZyYWc6IHBvaW50ZXIgdG8gcGFnZV9mcmFnCj4gPiAgICogQGdmcDogcHJp
b3JpdHkgZm9yIG1lbW9yeSBhbGxvY2F0aW9uCj4gPiAgICoKPiA+ICAgKiBOb3RlOiBXaGlsZSB0
aGlzIGFsbG9jYXRvciB0cmllcyB0byB1c2UgaGlnaCBvcmRlciBwYWdlcywgdGhlcmUgaXMKPiA+
ICAgKiBubyBndWFyYW50ZWUgdGhhdCBhbGxvY2F0aW9ucyBzdWNjZWVkLiBUaGVyZWZvcmUsIEBz
eiBNVVNUIGJlCj4gPiAgICogbGVzcyBvciBlcXVhbCB0aGFuIFBBR0VfU0laRS4KPiA+ICAgKi8K
PiA+IGJvb2wgc2tiX3BhZ2VfZnJhZ19yZWZpbGwodW5zaWduZWQgaW50IHN6LCBzdHJ1Y3QgcGFn
ZV9mcmFnICpwZnJhZywgZ2ZwX3QgZ2ZwKQo+ID4gewo+ID4gCWlmIChwZnJhZy0+cGFnZSkgewo+
ID4gCQlpZiAocGFnZV9yZWZfY291bnQocGZyYWctPnBhZ2UpID09IDEpIHsKPiA+IAkJCXBmcmFn
LT5vZmZzZXQgPSAwOwo+ID4gCQkJcmV0dXJuIHRydWU7Cj4gPiAJCX0KPiA+IAkJaWYgKHBmcmFn
LT5vZmZzZXQgKyBzeiA8PSBwZnJhZy0+c2l6ZSkKPiA+IAkJCXJldHVybiB0cnVlOwo+ID4gCQlw
dXRfcGFnZShwZnJhZy0+cGFnZSk7Cj4gPiAJfQo+ID4KPiA+IAlwZnJhZy0+b2Zmc2V0ID0gMDsK
PiA+IAlpZiAoU0tCX0ZSQUdfUEFHRV9PUkRFUiAmJgo+ID4gCSAgICAhc3RhdGljX2JyYW5jaF91
bmxpa2VseSgmbmV0X2hpZ2hfb3JkZXJfYWxsb2NfZGlzYWJsZV9rZXkpKSB7Cj4gPiAJCS8qIEF2
b2lkIGRpcmVjdCByZWNsYWltIGJ1dCBhbGxvdyBrc3dhcGQgdG8gd2FrZSAqLwo+ID4gCQlwZnJh
Zy0+cGFnZSA9IGFsbG9jX3BhZ2VzKChnZnAgJiB+X19HRlBfRElSRUNUX1JFQ0xBSU0pIHwKPiA+
IAkJCQkJICBfX0dGUF9DT01QIHwgX19HRlBfTk9XQVJOIHwKPiA+IAkJCQkJICBfX0dGUF9OT1JF
VFJZLAo+ID4gCQkJCQkgIFNLQl9GUkFHX1BBR0VfT1JERVIpOwo+ID4gCQlpZiAobGlrZWx5KHBm
cmFnLT5wYWdlKSkgewo+ID4gCQkJcGZyYWctPnNpemUgPSBQQUdFX1NJWkUgPDwgU0tCX0ZSQUdf
UEFHRV9PUkRFUjsKPiA+IAkJCXJldHVybiB0cnVlOwo+ID4gCQl9Cj4gPiAJfQo+ID4gCXBmcmFn
LT5wYWdlID0gYWxsb2NfcGFnZShnZnApOwo+ID4gCWlmIChsaWtlbHkocGZyYWctPnBhZ2UpKSB7
Cj4gPiAJCXBmcmFnLT5zaXplID0gUEFHRV9TSVpFOwo+ID4gCQlyZXR1cm4gdHJ1ZTsKPiA+IAl9
Cj4gPiAJcmV0dXJuIGZhbHNlOwo+ID4gfQo+ID4gRVhQT1JUX1NZTUJPTChza2JfcGFnZV9mcmFn
X3JlZmlsbCk7Cj4gPgo+ID4KPiA+PiBUaGFua3MKPiA+Pgo+ID4+Cj4gPj4+IFRoYW5rcy4KPiA+
Pj4KPiA+Pj4+IFRoYW5rcwo+ID4+Pj4KPiA+Pj4+Cj4gPj4+Pj4gU28gd2hlbiB0cnlpbmcgdG8K
PiA+Pj4+PiBnZXQgdGhlIGJ1ZiB3aGVyZSB0aGUgZGF0YSBpcyBsb2NhdGVkLCB5b3Ugc2hvdWxk
IGRpcmVjdGx5IHVzZSB0aGUKPiA+Pj4+PiBwb2ludGVyKHApIHRvIGdldCB0aGUgYWRkcmVzcyBj
b3JyZXNwb25kaW5nIHRvIHRoZSBwYWdlLgo+ID4+Pj4+Cj4gPj4+Pj4gQXQgdGhlIHNhbWUgdGlt
ZSwgdGhlIG9mZnNldCBvZiB0aGUgZGF0YSBpbiB0aGUgcGFnZSBzaG91bGQgYWxzbyBiZQo+ID4+
Pj4+IG9idGFpbmVkIHVzaW5nIG9mZnNldF9pbl9wYWdlKCkuCj4gPj4+Pj4KPiA+Pj4+PiBUaGlz
IHBhdGNoIHNvbHZlcyB0aGlzIHByb2JsZW0uIEJ1dCBpZiB5b3UgZG9u4oCZdCB1c2UgdGhpcyBw
YXRjaCwgdGhlCj4gPj4+Pj4gb3JpZ2luYWwgY29kZSBjYW4gYWxzbyBydW4sIGJlY2F1c2UgaWYg
dGhlIHBhZ2UgaXMgbm90IHRoZSBwYWdlIG9mIHRoZQo+ID4+Pj4+IGN1cnJlbnQgZGF0YSwgdGhl
IGNhbGN1bGF0ZWQgdGFpbHJvb20gd2lsbCBiZSBsZXNzIHRoYW4gMCwgYW5kIHdpbGwgbm90Cj4g
Pj4+Pj4gZW50ZXIgdGhlIGxvZ2ljIG9mIGJ1aWxkX3NrYigpIC4gVGhlIHNpZ25pZmljYW5jZSBv
ZiB0aGlzIHBhdGNoIGlzIHRvCj4gPj4+Pj4gbW9kaWZ5IHRoaXMgbG9naWNhbCBwcm9ibGVtLCBh
bGxvd2luZyBtb3JlIHNpdHVhdGlvbnMgdG8gdXNlCj4gPj4+Pj4gYnVpbGRfc2tiKCkuCj4gPj4+
Pj4KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPgo+ID4+Pj4+IEFja2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPgo+ID4+Pj4+IC0tLQo+ID4+Pj4+ICAgICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA4
ICsrKysrKy0tCj4gPj4+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4gPj4+Pj4KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPj4+Pj4gaW5kZXggM2U0NmMx
MmRkZTA4Li4wNzNmZWM0YzBkZjEgMTAwNjQ0Cj4gPj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gPj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPj4+Pj4g
QEAgLTQwNyw4ICs0MDcsMTIgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpwYWdlX3RvX3NrYihz
dHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiA+Pj4+PiAgICAgCQkgKiBzZWUgYWRkX3JlY3ZidWZf
bWVyZ2VhYmxlKCkgKyBnZXRfbWVyZ2VhYmxlX2J1Zl9sZW4oKQo+ID4+Pj4+ICAgICAJCSAqLwo+
ID4+Pj4+ICAgICAJCXRydWVzaXplID0gUEFHRV9TSVpFOwo+ID4+Pj4+IC0JCXRhaWxyb29tID0g
dHJ1ZXNpemUgLSBsZW4gLSBvZmZzZXQ7Cj4gPj4+Pj4gLQkJYnVmID0gcGFnZV9hZGRyZXNzKHBh
Z2UpOwo+ID4+Pj4+ICsKPiA+Pj4+PiArCQkvKiBwYWdlIG1heWJlIGhlYWQgcGFnZSwgc28gd2Ug
c2hvdWxkIGdldCB0aGUgYnVmIGJ5IHAsIG5vdCB0aGUKPiA+Pj4+PiArCQkgKiBwYWdlCj4gPj4+
Pj4gKwkJICovCj4gPj4+Pj4gKwkJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbiAtIG9mZnNldF9p
bl9wYWdlKHApOwo+Cj4KPiBJIHdvbmRlciB3aHkgb2Zmc2V0X2luX3BhZ2UocCkgaXMgY29ycmVj
dD8gSSBndWVzcyBpdCBzaG91bGQgYmU6Cj4KPiB0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0g
aGVhZHJvb207Cj4KPiBUaGUgcmVhc29uIGlzIHRoYXQgdGhlIGJ1ZmZlciBpcyBub3QgbmVjZXNz
YXJpbHkgYWxsb2NhdGVkIGF0IHRoZSBwYWdlCj4gYm91bmRhcnkuCgpJbiBteSB1bmRlcnN0YW5k
aW5nLCBvZmZzZXRfaW5fcGFnZShwKSBpcyB0aGUgb2Zmc2V0IG9mIHAgaW4gdGhlIHBhZ2Ugd2hl
cmUgaXQKaXMgbG9jYXRlZC4gSW4gdGhpcyBjYXNlLCB0aGUgdHdvIHNob3VsZCBiZSBlcXVhbC4g
VGhpcyBoYXMgbm90aGluZyB0byBkbyB3aXRoCndoaWNoIHBhZ2UgaXMgYWxsb2NhdGVkLgoKT2Yg
Y291cnNlIEkgdGhpbmsgdXNpbmcgaGVhZHJvb20gaXMgYSBnb29kIGlkZWEsIGFuZCBpdCBpcyBz
ZW1hbnRpY2FsbHkgYmV0dGVyLgoKVGhhbmtzLgoKPgo+IFRoYW5rcwo+Cj4KPiA+Pj4+PiArCQli
dWYgPSAoY2hhciAqKSgodW5zaWduZWQgbG9uZylwICYgUEFHRV9NQVNLKTsKPiA+Pj4+PiAgICAg
CX0gZWxzZSB7Cj4gPj4+Pj4gICAgIAkJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbjsKPiA+Pj4+
PiAgICAgCQlidWYgPSBwOwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
