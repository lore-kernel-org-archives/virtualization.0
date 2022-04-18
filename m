Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5C3C433F5
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 08:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C051161215;
	Mon, 18 Apr 2022 08:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uLqTGwP0bqUT; Mon, 18 Apr 2022 08:54:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A9AB60FBC;
	Mon, 18 Apr 2022 08:54:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D92C6C002F;
	Mon, 18 Apr 2022 08:54:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54560C002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 08:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49D8141DC7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 08:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tRdkRsSaRwPc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 08:54:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB36841DC1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 08:54:53 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R231e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0VALaedj_1650272086; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VALaedj_1650272086) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 18 Apr 2022 16:54:48 +0800
Message-ID: <1650271705.1503067-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 31/32] virtio_net: support rx/tx queue resize
Date: Mon, 18 Apr 2022 16:48:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-32-xuanzhuo@linux.alibaba.com>
 <122008a6-1e79-14d3-1478-59f96464afc9@redhat.com>
 <1650252077.7934203-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtZOJ2PCsJidDcFKL57Q6oLHk4TH7xtewrLCTFhrbXSAA@mail.gmail.com>
In-Reply-To: <CACGkMEtZOJ2PCsJidDcFKL57Q6oLHk4TH7xtewrLCTFhrbXSAA@mail.gmail.com>
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm <kvm@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCAxOCBBcHIgMjAyMiAxNTo0OToyOSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBBcHIgMTgsIDIwMjIgYXQgMTE6MjQgQU0gWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gV2Vk
LCAxMyBBcHIgMjAyMiAxNjowMDoxOCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IOWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBa
aHVvIOWGmemBkzoKPiA+ID4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIHJlc2l6ZSBmdW5j
dGlvbiBvZiB0aGUgcngsIHR4IHF1ZXVlcy4KPiA+ID4gPiBCYXNlZCBvbiB0aGlzIGZ1bmN0aW9u
LCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRoZQo+ID4gPiA+IHF1
ZXVlLgo+ID4gPiA+Cj4gPiA+ID4gVGhlcmUgbWF5IGJlIGFuIGV4Y2VwdGlvbiBkdXJpbmcgdGhl
IHJlc2l6ZSBwcm9jZXNzLCB0aGUgcmVzaXplIG1heQo+ID4gPiA+IGZhaWwsIG9yIHRoZSB2cSBj
YW4gbm8gbG9uZ2VyIGJlIHVzZWQuIEVpdGhlciB3YXksIHdlIG11c3QgZXhlY3V0ZQo+ID4gPiA+
IG5hcGlfZW5hYmxlKCkuIEJlY2F1c2UgbmFwaV9kaXNhYmxlIGlzIHNpbWlsYXIgdG8gYSBsb2Nr
LCBuYXBpX2VuYWJsZQo+ID4gPiA+IG11c3QgYmUgY2FsbGVkIGFmdGVyIGNhbGxpbmcgbmFwaV9k
aXNhYmxlLgo+ID4gPiA+Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1
b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4gPiAgIGRyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyB8IDgxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspCj4gPiA+ID4KPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gPiA+ID4gaW5kZXggYjhiZjAwNTI1MTc3Li5iYTY4NTlmMzA1ZjcgMTAwNjQ0
Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gKysrIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gQEAgLTI1MSw2ICsyNTEsOSBAQCBzdHJ1Y3Qg
cGFkZGVkX3ZuZXRfaGRyIHsKPiA+ID4gPiAgICAgY2hhciBwYWRkaW5nWzRdOwo+ID4gPiA+ICAg
fTsKPiA+ID4gPgo+ID4gPiA+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3NxX2ZyZWVfdW51c2VkX2J1
ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiA+ID4gPiArc3RhdGljIHZvaWQg
dmlydG5ldF9ycV9mcmVlX3VudXNlZF9idWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1
Zik7Cj4gPiA+ID4gKwo+ID4gPiA+ICAgc3RhdGljIGJvb2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0
cikKPiA+ID4gPiAgIHsKPiA+ID4gPiAgICAgcmV0dXJuICh1bnNpZ25lZCBsb25nKXB0ciAmIFZJ
UlRJT19YRFBfRkxBRzsKPiA+ID4gPiBAQCAtMTM2OSw2ICsxMzcyLDE1IEBAIHN0YXRpYyB2b2lk
IHZpcnRuZXRfbmFwaV9lbmFibGUoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHN0cnVjdCBuYXBpX3N0
cnVjdCAqbmFwaSkKPiA+ID4gPiAgIHsKPiA+ID4gPiAgICAgbmFwaV9lbmFibGUobmFwaSk7Cj4g
PiA+ID4KPiA+ID4gPiArICAgLyogQ2hlY2sgaWYgdnEgaXMgaW4gcmVzZXQgc3RhdGUuIFRoZSBu
b3JtYWwgcmVzZXQvcmVzaXplIHByb2Nlc3Mgd2lsbAo+ID4gPiA+ICsgICAgKiBiZSBwcm90ZWN0
ZWQgYnkgbmFwaS4gSG93ZXZlciwgdGhlIHByb3RlY3Rpb24gb2YgbmFwaSBpcyBvbmx5IGVuYWJs
ZWQKPiA+ID4gPiArICAgICogZHVyaW5nIHRoZSBvcGVyYXRpb24sIGFuZCB0aGUgcHJvdGVjdGlv
biBvZiBuYXBpIHdpbGwgZW5kIGFmdGVyIHRoZQo+ID4gPiA+ICsgICAgKiBvcGVyYXRpb24gaXMg
Y29tcGxldGVkLiBJZiByZS1lbmFibGUgZmFpbHMgZHVyaW5nIHRoZSBwcm9jZXNzLCB2cQo+ID4g
PiA+ICsgICAgKiB3aWxsIHJlbWFpbiB1bmF2YWlsYWJsZSB3aXRoIHJlc2V0IHN0YXRlLgo+ID4g
PiA+ICsgICAgKi8KPiA+ID4gPiArICAgaWYgKHZxLT5yZXNldCkKPiA+ID4gPiArICAgICAgICAg
ICByZXR1cm47Cj4gPiA+Cj4gPiA+Cj4gPiA+IEkgZG9uJ3QgZ2V0IHdoZW4gY291bGQgd2UgaGl0
IHRoaXMgY29uZGl0aW9uLgo+ID4gPgo+ID4gPgo+ID4gPiA+ICsKPiA+ID4gPiAgICAgLyogSWYg
YWxsIGJ1ZmZlcnMgd2VyZSBmaWxsZWQgYnkgb3RoZXIgc2lkZSBiZWZvcmUgd2UgbmFwaV9lbmFi
bGVkLCB3ZQo+ID4gPiA+ICAgICAgKiB3b24ndCBnZXQgYW5vdGhlciBpbnRlcnJ1cHQsIHNvIHBy
b2Nlc3MgYW55IG91dHN0YW5kaW5nIHBhY2tldHMgbm93Lgo+ID4gPiA+ICAgICAgKiBDYWxsIGxv
Y2FsX2JoX2VuYWJsZSBhZnRlciB0byB0cmlnZ2VyIHNvZnRJUlEgcHJvY2Vzc2luZy4KPiA+ID4g
PiBAQCAtMTQxMyw2ICsxNDI1LDE1IEBAIHN0YXRpYyB2b2lkIHJlZmlsbF93b3JrKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yaykKPiA+ID4gPiAgICAgICAgICAgICBzdHJ1Y3QgcmVjZWl2ZV9xdWV1
ZSAqcnEgPSAmdmktPnJxW2ldOwo+ID4gPiA+Cj4gPiA+ID4gICAgICAgICAgICAgbmFwaV9kaXNh
YmxlKCZycS0+bmFwaSk7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICAgICAgICAgIC8qIENoZWNrIGlm
IHZxIGlzIGluIHJlc2V0IHN0YXRlLiBTZWUgbW9yZSBpbgo+ID4gPiA+ICsgICAgICAgICAgICAq
IHZpcnRuZXRfbmFwaV9lbmFibGUoKQo+ID4gPiA+ICsgICAgICAgICAgICAqLwo+ID4gPiA+ICsg
ICAgICAgICAgIGlmIChycS0+dnEtPnJlc2V0KSB7Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICB2aXJ0bmV0X25hcGlfZW5hYmxlKHJxLT52cSwgJnJxLT5uYXBpKTsKPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgIGNvbnRpbnVlOwo+ID4gPiA+ICsgICAgICAgICAgIH0KPiA+ID4KPiA+ID4K
PiA+ID4gQ2FuIHdlIGRvIHNvbWV0aGluZyBzaW1pbGFyIGluIHZpcnRuZXRfY2xvc2UoKSBieSBj
YW5jZWxpbmcgdGhlIHdvcms/Cj4gPiA+Cj4gPiA+Cj4gPiA+ID4gKwo+ID4gPiA+ICAgICAgICAg
ICAgIHN0aWxsX2VtcHR5ID0gIXRyeV9maWxsX3JlY3YodmksIHJxLCBHRlBfS0VSTkVMKTsKPiA+
ID4gPiAgICAgICAgICAgICB2aXJ0bmV0X25hcGlfZW5hYmxlKHJxLT52cSwgJnJxLT5uYXBpKTsK
PiA+ID4gPgo+ID4gPiA+IEBAIC0xNTIzLDYgKzE1NDQsMTAgQEAgc3RhdGljIHZvaWQgdmlydG5l
dF9wb2xsX2NsZWFudHgoc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxKQo+ID4gPiA+ICAgICBpZiAo
IXNxLT5uYXBpLndlaWdodCB8fCBpc194ZHBfcmF3X2J1ZmZlcl9xdWV1ZSh2aSwgaW5kZXgpKQo+
ID4gPiA+ICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gPgo+ID4gPiA+ICsgICAvKiBDaGVjayBp
ZiB2cSBpcyBpbiByZXNldCBzdGF0ZS4gU2VlIG1vcmUgaW4gdmlydG5ldF9uYXBpX2VuYWJsZSgp
ICovCj4gPiA+ID4gKyAgIGlmIChzcS0+dnEtPnJlc2V0KQo+ID4gPiA+ICsgICAgICAgICAgIHJl
dHVybjsKPiA+ID4KPiA+ID4KPiA+ID4gV2UndmUgZGlzYWJsZWQgVFggbmFwaSwgYW55IGNoYW5j
ZSB3ZSBjYW4gc3RpbGwgaGl0IHRoaXM/Cj4gPgo+ID4KPiA+IHN0YXRpYyBpbnQgdmlydG5ldF9w
b2xsKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiA+IHsKPiA+ICAgICAg
ICAgc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxID0KPiA+ICAgICAgICAgICAgICAgICBjb250YWlu
ZXJfb2YobmFwaSwgc3RydWN0IHJlY2VpdmVfcXVldWUsIG5hcGkpOwo+ID4gICAgICAgICBzdHJ1
Y3QgdmlydG5ldF9pbmZvICp2aSA9IHJxLT52cS0+dmRldi0+cHJpdjsKPiA+ICAgICAgICAgc3Ry
dWN0IHNlbmRfcXVldWUgKnNxOwo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgcmVjZWl2ZWQ7Cj4g
PiAgICAgICAgIHVuc2lnbmVkIGludCB4ZHBfeG1pdCA9IDA7Cj4gPgo+ID4gICAgICAgICB2aXJ0
bmV0X3BvbGxfY2xlYW50eChycSk7Cj4gPiAuLi4KPiA+IH0KPiA+Cj4gPiBUaGlzIGlzIGNhbGxl
ZCBieSByeCBwb2xsLiBBbHRob3VnaCBpdCBpcyB0aGUgbG9naWMgb2YgdHgsIGl0IGlzIG5vdCBk
cml2ZW4gYnkKPiA+IHR4IG5hcGksIGJ1dCBpcyBjYWxsZWQgaW4gcnggcG9sbC4KPgo+IE9rLCBi
dXQgd2UgbmVlZCBndWFyYW50ZWUgdGhlIG1lbW9yeSBvcmRlcmluZyBpbiB0aGlzIGNhc2UuIERp
c2FibGUgUlgKPiBuYXBpIGNvdWxkIGJlIGEgc29sdXRpb24gZm9yIHRoaXMuCgpZZXMsIEkgaGF2
ZSByZWFsaXplZCB0aGlzIHRvby4gSSBoYXZlIHR3byBzb2x1dGlvbnMsIGRpc2FibGUgcnggbmFw
aSBvciB0aGUKZm9sbG93aW5nLgoKVGhhbmtzLgoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKaW5kZXggOWJmMWI2NTMwYjM4
Li43NzY0ZDFkY2I4MzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYworKysg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKQEAgLTEzNSw2ICsxMzUsNyBAQCBzdHJ1Y3Qgc2Vu
ZF9xdWV1ZSB7CiAJc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3RhdHM7CgogCXN0cnVjdCBuYXBp
X3N0cnVjdCBuYXBpOworCWJvb2wgcmVzZXQ7CiB9OwoKIC8qIEludGVybmFsIHJlcHJlc2VudGF0
aW9uIG9mIGEgcmVjZWl2ZSB2aXJ0cXVldWUgKi8KQEAgLTE1ODMsNiArMTU4NywxMSBAQCBzdGF0
aWMgdm9pZCB2aXJ0bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEpCiAJ
CXJldHVybjsKCiAJaWYgKF9fbmV0aWZfdHhfdHJ5bG9jayh0eHEpKSB7CisJCWlmIChzcS0+cmVz
ZXQpIHsKKwkJCV9fbmV0aWZfdHhfdW5sb2NrKHR4cSk7CisJCQlyZXR1cm47CisJCX0KKwogCQlk
byB7CiAJCQl2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwogCQkJZnJlZV9vbGRfeG1pdF9z
a2JzKHNxLCB0cnVlKTsKQEAgLTE4MjgsNiArMTgzNyw1NiBAQCBzdGF0aWMgbmV0ZGV2X3R4X3Qg
c3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQog
CXJldHVybiBORVRERVZfVFhfT0s7CiB9Cgorc3RhdGljIGludCB2aXJ0bmV0X3R4X3Jlc2l6ZShz
dHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKKwkJCSAgICAgc3RydWN0IHNlbmRfcXVldWUgKnNxLCB1
MzIgcmluZ19udW0pCit7CisJc3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxOworCWludCBlcnIsIHFp
bmRleDsKKworCXFpbmRleCA9IHNxIC0gdmktPnNxOworCisJdmlydG5ldF9uYXBpX3R4X2Rpc2Fi
bGUoJnNxLT5uYXBpKTsKKworCXR4cSA9IG5ldGRldl9nZXRfdHhfcXVldWUodmktPmRldiwgcWlu
ZGV4KTsKKworCV9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOworCW5ldGlmX3N0b3Bfc3VicXVldWUo
dmktPmRldiwgcWluZGV4KTsKKwlzcS0+cmVzZXQgPSB0cnVlOworCV9fbmV0aWZfdHhfdW5sb2Nr
X2JoKHR4cSk7CisKKwllcnIgPSB2aXJ0cXVldWVfcmVzaXplKHNxLT52cSwgcmluZ19udW0sIHZp
cnRuZXRfc3FfZnJlZV91bnVzZWRfYnVmKTsKKwlpZiAoZXJyKQorCQluZXRkZXZfZXJyKHZpLT5k
ZXYsICJyZXNpemUgdHggZmFpbDogdHggcXVldWUgaW5kZXg6ICVkIGVycjogJWRcbiIsIHFpbmRl
eCwgZXJyKTsKKworCV9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOworCXNxLT5yZXNldCA9IGZhbHNl
OworCW5ldGlmX3N0YXJ0X3N1YnF1ZXVlKHZpLT5kZXYsIHFpbmRleCk7CisJX19uZXRpZl90eF91
bmxvY2tfYmgodHhxKTsKKworCXZpcnRuZXRfbmFwaV90eF9lbmFibGUodmksIHNxLT52cSwgJnNx
LT5uYXBpKTsKKwlyZXR1cm4gZXJyOworfQorCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
