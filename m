Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E95C433EF
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 03:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56D26400FB;
	Mon, 18 Apr 2022 03:24:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x0o8N30Q9yee; Mon, 18 Apr 2022 03:24:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C99C440B77;
	Mon, 18 Apr 2022 03:24:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9729BC0033;
	Mon, 18 Apr 2022 03:24:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17A97C002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 03:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D639819BC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 03:24:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a63Y3T64A-GS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 03:24:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com
 [47.90.199.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 927008198A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 03:24:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0VAHFyW._1650252245; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAHFyW._1650252245) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 18 Apr 2022 11:24:06 +0800
Message-ID: <1650252077.7934203-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 31/32] virtio_net: support rx/tx queue resize
Date: Mon, 18 Apr 2022 11:21:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-32-xuanzhuo@linux.alibaba.com>
 <122008a6-1e79-14d3-1478-59f96464afc9@redhat.com>
In-Reply-To: <122008a6-1e79-14d3-1478-59f96464afc9@redhat.com>
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Heiko Carstens <hca@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCAxMyBBcHIgMjAyMiAxNjowMDoxOCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIHJlc2l6ZSBmdW5jdGlvbiBv
ZiB0aGUgcngsIHR4IHF1ZXVlcy4KPiA+IEJhc2VkIG9uIHRoaXMgZnVuY3Rpb24sIGl0IGlzIHBv
c3NpYmxlIHRvIG1vZGlmeSB0aGUgcmluZyBudW0gb2YgdGhlCj4gPiBxdWV1ZS4KPiA+Cj4gPiBU
aGVyZSBtYXkgYmUgYW4gZXhjZXB0aW9uIGR1cmluZyB0aGUgcmVzaXplIHByb2Nlc3MsIHRoZSBy
ZXNpemUgbWF5Cj4gPiBmYWlsLCBvciB0aGUgdnEgY2FuIG5vIGxvbmdlciBiZSB1c2VkLiBFaXRo
ZXIgd2F5LCB3ZSBtdXN0IGV4ZWN1dGUKPiA+IG5hcGlfZW5hYmxlKCkuIEJlY2F1c2UgbmFwaV9k
aXNhYmxlIGlzIHNpbWlsYXIgdG8gYSBsb2NrLCBuYXBpX2VuYWJsZQo+ID4gbXVzdCBiZSBjYWxs
ZWQgYWZ0ZXIgY2FsbGluZyBuYXBpX2Rpc2FibGUuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMgfCA4MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+ID4gaW5kZXggYjhiZjAwNTI1MTc3Li5iYTY4NTlmMzA1ZjcgMTAwNjQ0Cj4gPiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+ID4gQEAgLTI1MSw2ICsyNTEsOSBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiA+
ICAgCWNoYXIgcGFkZGluZ1s0XTsKPiA+ICAgfTsKPiA+Cj4gPiArc3RhdGljIHZvaWQgdmlydG5l
dF9zcV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4g
PiArc3RhdGljIHZvaWQgdmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1
ZSAqdnEsIHZvaWQgKmJ1Zik7Cj4gPiArCj4gPiAgIHN0YXRpYyBib29sIGlzX3hkcF9mcmFtZSh2
b2lkICpwdHIpCj4gPiAgIHsKPiA+ICAgCXJldHVybiAodW5zaWduZWQgbG9uZylwdHIgJiBWSVJU
SU9fWERQX0ZMQUc7Cj4gPiBAQCAtMTM2OSw2ICsxMzcyLDE1IEBAIHN0YXRpYyB2b2lkIHZpcnRu
ZXRfbmFwaV9lbmFibGUoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHN0cnVjdCBuYXBpX3N0cnVjdCAq
bmFwaSkKPiA+ICAgewo+ID4gICAJbmFwaV9lbmFibGUobmFwaSk7Cj4gPgo+ID4gKwkvKiBDaGVj
ayBpZiB2cSBpcyBpbiByZXNldCBzdGF0ZS4gVGhlIG5vcm1hbCByZXNldC9yZXNpemUgcHJvY2Vz
cyB3aWxsCj4gPiArCSAqIGJlIHByb3RlY3RlZCBieSBuYXBpLiBIb3dldmVyLCB0aGUgcHJvdGVj
dGlvbiBvZiBuYXBpIGlzIG9ubHkgZW5hYmxlZAo+ID4gKwkgKiBkdXJpbmcgdGhlIG9wZXJhdGlv
biwgYW5kIHRoZSBwcm90ZWN0aW9uIG9mIG5hcGkgd2lsbCBlbmQgYWZ0ZXIgdGhlCj4gPiArCSAq
IG9wZXJhdGlvbiBpcyBjb21wbGV0ZWQuIElmIHJlLWVuYWJsZSBmYWlscyBkdXJpbmcgdGhlIHBy
b2Nlc3MsIHZxCj4gPiArCSAqIHdpbGwgcmVtYWluIHVuYXZhaWxhYmxlIHdpdGggcmVzZXQgc3Rh
dGUuCj4gPiArCSAqLwo+ID4gKwlpZiAodnEtPnJlc2V0KQo+ID4gKwkJcmV0dXJuOwo+Cj4KPiBJ
IGRvbid0IGdldCB3aGVuIGNvdWxkIHdlIGhpdCB0aGlzIGNvbmRpdGlvbi4KPgo+Cj4gPiArCj4g
PiAgIAkvKiBJZiBhbGwgYnVmZmVycyB3ZXJlIGZpbGxlZCBieSBvdGhlciBzaWRlIGJlZm9yZSB3
ZSBuYXBpX2VuYWJsZWQsIHdlCj4gPiAgIAkgKiB3b24ndCBnZXQgYW5vdGhlciBpbnRlcnJ1cHQs
IHNvIHByb2Nlc3MgYW55IG91dHN0YW5kaW5nIHBhY2tldHMgbm93Lgo+ID4gICAJICogQ2FsbCBs
b2NhbF9iaF9lbmFibGUgYWZ0ZXIgdG8gdHJpZ2dlciBzb2Z0SVJRIHByb2Nlc3NpbmcuCj4gPiBA
QCAtMTQxMyw2ICsxNDI1LDE1IEBAIHN0YXRpYyB2b2lkIHJlZmlsbF93b3JrKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykKPiA+ICAgCQlzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEgPSAmdmktPnJx
W2ldOwo+ID4KPiA+ICAgCQluYXBpX2Rpc2FibGUoJnJxLT5uYXBpKTsKPiA+ICsKPiA+ICsJCS8q
IENoZWNrIGlmIHZxIGlzIGluIHJlc2V0IHN0YXRlLiBTZWUgbW9yZSBpbgo+ID4gKwkJICogdmly
dG5ldF9uYXBpX2VuYWJsZSgpCj4gPiArCQkgKi8KPiA+ICsJCWlmIChycS0+dnEtPnJlc2V0KSB7
Cj4gPiArCQkJdmlydG5ldF9uYXBpX2VuYWJsZShycS0+dnEsICZycS0+bmFwaSk7Cj4gPiArCQkJ
Y29udGludWU7Cj4gPiArCQl9Cj4KPgo+IENhbiB3ZSBkbyBzb21ldGhpbmcgc2ltaWxhciBpbiB2
aXJ0bmV0X2Nsb3NlKCkgYnkgY2FuY2VsaW5nIHRoZSB3b3JrPwo+Cj4KPiA+ICsKPiA+ICAgCQlz
dGlsbF9lbXB0eSA9ICF0cnlfZmlsbF9yZWN2KHZpLCBycSwgR0ZQX0tFUk5FTCk7Cj4gPiAgIAkJ
dmlydG5ldF9uYXBpX2VuYWJsZShycS0+dnEsICZycS0+bmFwaSk7Cj4gPgo+ID4gQEAgLTE1MjMs
NiArMTU0NCwxMCBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3QgcmVj
ZWl2ZV9xdWV1ZSAqcnEpCj4gPiAgIAlpZiAoIXNxLT5uYXBpLndlaWdodCB8fCBpc194ZHBfcmF3
X2J1ZmZlcl9xdWV1ZSh2aSwgaW5kZXgpKQo+ID4gICAJCXJldHVybjsKPiA+Cj4gPiArCS8qIENo
ZWNrIGlmIHZxIGlzIGluIHJlc2V0IHN0YXRlLiBTZWUgbW9yZSBpbiB2aXJ0bmV0X25hcGlfZW5h
YmxlKCkgKi8KPiA+ICsJaWYgKHNxLT52cS0+cmVzZXQpCj4gPiArCQlyZXR1cm47Cj4KPgo+IFdl
J3ZlIGRpc2FibGVkIFRYIG5hcGksIGFueSBjaGFuY2Ugd2UgY2FuIHN0aWxsIGhpdCB0aGlzPwoK
CnN0YXRpYyBpbnQgdmlydG5ldF9wb2xsKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1
ZGdldCkKewoJc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxID0KCQljb250YWluZXJfb2YobmFwaSwg
c3RydWN0IHJlY2VpdmVfcXVldWUsIG5hcGkpOwoJc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBy
cS0+dnEtPnZkZXYtPnByaXY7CglzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3E7Cgl1bnNpZ25lZCBpbnQg
cmVjZWl2ZWQ7Cgl1bnNpZ25lZCBpbnQgeGRwX3htaXQgPSAwOwoKCXZpcnRuZXRfcG9sbF9jbGVh
bnR4KHJxKTsKLi4uCn0KClRoaXMgaXMgY2FsbGVkIGJ5IHJ4IHBvbGwuIEFsdGhvdWdoIGl0IGlz
IHRoZSBsb2dpYyBvZiB0eCwgaXQgaXMgbm90IGRyaXZlbiBieQp0eCBuYXBpLCBidXQgaXMgY2Fs
bGVkIGluIHJ4IHBvbGwuCgpUaGFua3MuCgoKPgo+Cj4gPiArCj4gPiAgIAlpZiAoX19uZXRpZl90
eF90cnlsb2NrKHR4cSkpIHsKPiA+ICAgCQlkbyB7Cj4gPiAgIAkJCXZpcnRxdWV1ZV9kaXNhYmxl
X2NiKHNxLT52cSk7Cj4gPiBAQCAtMTc2OSw2ICsxNzk0LDYyIEBAIHN0YXRpYyBuZXRkZXZfdHhf
dCBzdGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYp
Cj4gPiAgIAlyZXR1cm4gTkVUREVWX1RYX09LOwo+ID4gICB9Cj4gPgo+ID4gK3N0YXRpYyBpbnQg
dmlydG5ldF9yeF9yZXNpemUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gPiArCQkJICAgICBz
dHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIHUzMiByaW5nX251bSkKPiA+ICt7Cj4gPiArCWludCBl
cnI7Cj4gPiArCj4gPiArCW5hcGlfZGlzYWJsZSgmcnEtPm5hcGkpOwo+ID4gKwo+ID4gKwllcnIg
PSB2aXJ0cXVldWVfcmVzaXplKHJxLT52cSwgcmluZ19udW0sIHZpcnRuZXRfcnFfZnJlZV91bnVz
ZWRfYnVmKTsKPiA+ICsJaWYgKGVycikKPiA+ICsJCWdvdG8gZXJyOwo+ID4gKwo+ID4gKwlpZiAo
IXRyeV9maWxsX3JlY3YodmksIHJxLCBHRlBfS0VSTkVMKSkKPiA+ICsJCXNjaGVkdWxlX2RlbGF5
ZWRfd29yaygmdmktPnJlZmlsbCwgMCk7Cj4gPiArCj4gPiArCXZpcnRuZXRfbmFwaV9lbmFibGUo
cnEtPnZxLCAmcnEtPm5hcGkpOwo+ID4gKwlyZXR1cm4gMDsKPiA+ICsKPiA+ICtlcnI6Cj4gPiAr
CW5ldGRldl9lcnIodmktPmRldiwKPiA+ICsJCSAgICJyZXNldCByeCByZXNldCB2cSBmYWlsOiBy
eCBxdWV1ZSBpbmRleDogJXRkIGVycjogJWRcbiIsCj4gPiArCQkgICBycSAtIHZpLT5ycSwgZXJy
KTsKPiA+ICsJdmlydG5ldF9uYXBpX2VuYWJsZShycS0+dnEsICZycS0+bmFwaSk7Cj4gPiArCXJl
dHVybiBlcnI7Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyBpbnQgdmlydG5ldF90eF9yZXNpemUo
c3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gPiArCQkJICAgICBzdHJ1Y3Qgc2VuZF9xdWV1ZSAq
c3EsIHUzMiByaW5nX251bSkKPiA+ICt7Cj4gPiArCXN0cnVjdCBuZXRkZXZfcXVldWUgKnR4cTsK
PiA+ICsJaW50IGVyciwgcWluZGV4Owo+ID4gKwo+ID4gKwlxaW5kZXggPSBzcSAtIHZpLT5zcTsK
PiA+ICsKPiA+ICsJdmlydG5ldF9uYXBpX3R4X2Rpc2FibGUoJnNxLT5uYXBpKTsKPiA+ICsKPiA+
ICsJdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2LCBxaW5kZXgpOwo+ID4gKwlfX25l
dGlmX3R4X2xvY2tfYmgodHhxKTsKPiA+ICsJbmV0aWZfc3RvcF9zdWJxdWV1ZSh2aS0+ZGV2LCBx
aW5kZXgpOwo+ID4gKwlfX25ldGlmX3R4X3VubG9ja19iaCh0eHEpOwo+ID4gKwo+ID4gKwllcnIg
PSB2aXJ0cXVldWVfcmVzaXplKHNxLT52cSwgcmluZ19udW0sIHZpcnRuZXRfc3FfZnJlZV91bnVz
ZWRfYnVmKTsKPiA+ICsJaWYgKGVycikKPiA+ICsJCWdvdG8gZXJyOwo+ID4gKwo+ID4gKwluZXRp
Zl9zdGFydF9zdWJxdWV1ZSh2aS0+ZGV2LCBxaW5kZXgpOwo+ID4gKwl2aXJ0bmV0X25hcGlfdHhf
ZW5hYmxlKHZpLCBzcS0+dnEsICZzcS0+bmFwaSk7Cj4gPiArCXJldHVybiAwOwo+ID4gKwo+ID4g
K2VycjoKPgo+Cj4gSSBndWVzcyB3ZSBjYW4gc3RpbGwgc3RhcnQgdGhlIHF1ZXVlIGluIHRoaXMg
Y2FzZT8gKFNpbmNlIHdlIGRvbid0Cj4gY2hhbmdlIHRoZSBxdWV1ZSBpZiByZXNpemUgZmFpbHMp
Lgo+Cj4KPiA+ICsJbmV0ZGV2X2Vycih2aS0+ZGV2LAo+ID4gKwkJICAgInJlc2V0IHR4IHJlc2V0
IHZxIGZhaWw6IHR4IHF1ZXVlIGluZGV4OiAldGQgZXJyOiAlZFxuIiwKPiA+ICsJCSAgIHNxIC0g
dmktPnNxLCBlcnIpOwo+ID4gKwl2aXJ0bmV0X25hcGlfdHhfZW5hYmxlKHZpLCBzcS0+dnEsICZz
cS0+bmFwaSk7Cj4gPiArCXJldHVybiBlcnI7Cj4gPiArfQo+ID4gKwo+ID4gICAvKgo+ID4gICAg
KiBTZW5kIGNvbW1hbmQgdmlhIHRoZSBjb250cm9sIHZpcnRxdWV1ZSBhbmQgY2hlY2sgc3RhdHVz
LiAgQ29tbWFuZHMKPiA+ICAgICogc3VwcG9ydGVkIGJ5IHRoZSBoeXBlcnZpc29yLCBhcyBpbmRp
Y2F0ZWQgYnkgZmVhdHVyZSBiaXRzLCBzaG91bGQKPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
