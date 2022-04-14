Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91CBC433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Apr 2022 06:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6DFBC4063E;
	Thu, 14 Apr 2022 06:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZffOsGb3xmGB; Thu, 14 Apr 2022 06:25:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F09B340157;
	Thu, 14 Apr 2022 06:25:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C11B1C0033;
	Thu, 14 Apr 2022 06:25:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAA61C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 06:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A295C4063E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 06:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wUVkfMWQTrcF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 06:24:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A5F140157
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 06:24:58 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0VA0zc-G_1649917489; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VA0zc-G_1649917489) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 14 Apr 2022 14:24:51 +0800
Message-ID: <1649917349.6242197-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 22/32] virtio_pci: queue_reset: extract the logic of
 active vq for modern pci
Date: Thu, 14 Apr 2022 14:22:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-23-xuanzhuo@linux.alibaba.com>
 <d228a41f-a3a1-029d-f259-d4fbab822e78@redhat.com>
In-Reply-To: <d228a41f-a3a1-029d-f259-d4fbab822e78@redhat.com>
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

T24gVHVlLCAxMiBBcHIgMjAyMiAxNDo1ODoxOSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBJbnRyb2R1Y2UgdnBfYWN0aXZlX3ZxKCkgdG8gY29uZmlndXJlIHZyaW5n
IHRvIGJhY2tlbmQgYWZ0ZXIgdnEgYXR0YWNoCj4gPiB2cmluZy4gQW5kIGNvbmZpZ3VyZSB2cSB2
ZWN0b3IgaWYgbmVjZXNzYXJ5Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVh
bnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9tb2Rlcm4uYyB8IDQ2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jCj4gPiBpbmRleCA4NmQzMDFmMjcyYjguLjQ5
YTQ0OTM3MzJjZiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9k
ZXJuLmMKPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiA+IEBA
IC0xNzYsNiArMTc2LDI5IEBAIHN0YXRpYyB2b2lkIHZwX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2KQo+ID4gICAJdnBfZGlzYWJsZV9jYnModmRldik7Cj4gPiAgIH0KPiA+Cj4gPiAr
c3RhdGljIGludCB2cF9hY3RpdmVfdnEoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHUxNiBtc2l4X3Zl
YykKPiA+ICt7Cj4gPiArCXN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBf
ZGV2aWNlKHZxLT52ZGV2KTsKPiA+ICsJc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAq
bWRldiA9ICZ2cF9kZXYtPm1kZXY7Cj4gPiArCXVuc2lnbmVkIGxvbmcgaW5kZXg7Cj4gPiArCj4g
PiArCWluZGV4ID0gdnEtPmluZGV4Owo+ID4gKwo+ID4gKwkvKiBhY3RpdmF0ZSB0aGUgcXVldWUg
Ki8KPiA+ICsJdnBfbW9kZXJuX3NldF9xdWV1ZV9zaXplKG1kZXYsIGluZGV4LCB2aXJ0cXVldWVf
Z2V0X3ZyaW5nX3NpemUodnEpKTsKPiA+ICsJdnBfbW9kZXJuX3F1ZXVlX2FkZHJlc3MobWRldiwg
aW5kZXgsIHZpcnRxdWV1ZV9nZXRfZGVzY19hZGRyKHZxKSwKPiA+ICsJCQkJdmlydHF1ZXVlX2dl
dF9hdmFpbF9hZGRyKHZxKSwKPiA+ICsJCQkJdmlydHF1ZXVlX2dldF91c2VkX2FkZHIodnEpKTsK
PiA+ICsKPiA+ICsJaWYgKG1zaXhfdmVjICE9IFZJUlRJT19NU0lfTk9fVkVDVE9SKSB7Cj4gPiAr
CQltc2l4X3ZlYyA9IHZwX21vZGVybl9xdWV1ZV92ZWN0b3IobWRldiwgaW5kZXgsIG1zaXhfdmVj
KTsKPiA+ICsJCWlmIChtc2l4X3ZlYyA9PSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikKPiA+ICsJCQly
ZXR1cm4gLUVCVVNZOwo+ID4gKwl9Cj4gPiArCj4gPiArCXJldHVybiAwOwo+ID4gK30KPiA+ICsK
PiA+ICAgc3RhdGljIHUxNiB2cF9jb25maWdfdmVjdG9yKHN0cnVjdCB2aXJ0aW9fcGNpX2Rldmlj
ZSAqdnBfZGV2LCB1MTYgdmVjdG9yKQo+ID4gICB7Cj4gPiAgIAlyZXR1cm4gdnBfbW9kZXJuX2Nv
bmZpZ192ZWN0b3IoJnZwX2Rldi0+bWRldiwgdmVjdG9yKTsKPiA+IEBAIC0yMjAsMzIgKzI0Mywx
OSBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqc2V0dXBfdnEoc3RydWN0IHZpcnRpb19wY2lf
ZGV2aWNlICp2cF9kZXYsCj4gPgo+ID4gICAJdnEtPm51bV9tYXggPSBudW07Cj4gPgo+ID4gLQkv
KiBhY3RpdmF0ZSB0aGUgcXVldWUgKi8KPiA+IC0JdnBfbW9kZXJuX3NldF9xdWV1ZV9zaXplKG1k
ZXYsIGluZGV4LCB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUodnEpKTsKPiA+IC0JdnBfbW9kZXJu
X3F1ZXVlX2FkZHJlc3MobWRldiwgaW5kZXgsIHZpcnRxdWV1ZV9nZXRfZGVzY19hZGRyKHZxKSwK
PiA+IC0JCQkJdmlydHF1ZXVlX2dldF9hdmFpbF9hZGRyKHZxKSwKPiA+IC0JCQkJdmlydHF1ZXVl
X2dldF91c2VkX2FkZHIodnEpKTsKPiA+ICsJZXJyID0gdnBfYWN0aXZlX3ZxKHZxLCBtc2l4X3Zl
Yyk7Cj4gPiArCWlmIChlcnIpCj4gPiArCQlnb3RvIGVycjsKPiA+Cj4gPiAgIAl2cS0+cHJpdiA9
ICh2b2lkIF9fZm9yY2UgKil2cF9tb2Rlcm5fbWFwX3ZxX25vdGlmeShtZGV2LCBpbmRleCwgTlVM
TCk7Cj4gPiAgIAlpZiAoIXZxLT5wcml2KSB7Cj4gPiAgIAkJZXJyID0gLUVOT01FTTsKPiA+IC0J
CWdvdG8gZXJyX21hcF9ub3RpZnk7Cj4gPiAtCX0KPiA+IC0KPiA+IC0JaWYgKG1zaXhfdmVjICE9
IFZJUlRJT19NU0lfTk9fVkVDVE9SKSB7Cj4gPiAtCQltc2l4X3ZlYyA9IHZwX21vZGVybl9xdWV1
ZV92ZWN0b3IobWRldiwgaW5kZXgsIG1zaXhfdmVjKTsKPiA+IC0JCWlmIChtc2l4X3ZlYyA9PSBW
SVJUSU9fTVNJX05PX1ZFQ1RPUikgewo+ID4gLQkJCWVyciA9IC1FQlVTWTsKPiA+IC0JCQlnb3Rv
IGVycl9hc3NpZ25fdmVjdG9yOwo+ID4gLQkJfQo+ID4gKwkJZ290byBlcnI7Cj4gPiAgIAl9Cj4g
Pgo+ID4gICAJcmV0dXJuIHZxOwo+ID4KPiA+IC1lcnJfYXNzaWduX3ZlY3RvcjoKPiA+IC0JaWYg
KCFtZGV2LT5ub3RpZnlfYmFzZSkKPiA+IC0JCXBjaV9pb3VubWFwKG1kZXYtPnBjaV9kZXYsICh2
b2lkIF9faW9tZW0gX19mb3JjZSAqKXZxLT5wcml2KTsKPgo+Cj4gV2UgbmVlZCBrZWVwIHRoaXMg
b3IgYW55dGhpbmcgSSBtaXNzZWQ/CgpJIHRoaW5rIHNvLCBhZnRlciBtb2RpZmljYXRpb24sIHZw
X21vZGVybl9tYXBfdnFfbm90aWZ5IGlzIHRoZSBsYXN0IHN0ZXAgYmVmb3JlCnJldHVybmluZyB2
cS4gSWYgaXQgZmFpbHMsIHRoZW4gdnEtPnByaXYgaXMgZXF1YWwgdG8gTlVMTCwgc28gdGhlcmUg
aXMgbm8gbmVlZAp0byBleGVjdXRlIHBjaV9pb3VubWFwLgoKRGlkIEkgbWlzcyBzb21ldGhpbmc/
CgpUaGFua3MuCgo+Cj4gVGhhbmtzCj4KPgo+ID4gLWVycl9tYXBfbm90aWZ5Ogo+ID4gK2VycjoK
PiA+ICAgCXZyaW5nX2RlbF92aXJ0cXVldWUodnEpOwo+ID4gICAJcmV0dXJuIEVSUl9QVFIoZXJy
KTsKPiA+ICAgfQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
