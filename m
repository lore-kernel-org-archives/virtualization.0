Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0502AC43217
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 99521401D8;
	Wed,  9 Mar 2022 09:36:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NkRudZFpEoSk; Wed,  9 Mar 2022 09:36:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D21544002B;
	Wed,  9 Mar 2022 09:36:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1690C0012;
	Wed,  9 Mar 2022 09:36:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72E15C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5497341604
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:36:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W0bwmuRrtfK5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:36:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E0E0415F5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:36:26 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V6j1lsR_1646818580; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6j1lsR_1646818580) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Mar 2022 17:36:21 +0800
Message-ID: <1646818559.1648765-11-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 25/26] virtio_net: set the default max ring size by
 find_vqs()
Date: Wed, 9 Mar 2022 17:35:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-26-xuanzhuo@linux.alibaba.com>
 <d7ec6eed-d692-091b-a438-1ae1cc5ee614@redhat.com>
In-Reply-To: <d7ec6eed-d692-091b-a438-1ae1cc5ee614@redhat.com>
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

T24gV2VkLCA5IE1hciAyMDIyIDE3OjI4OjIxICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gVXNlIHZpcnRpb19maW5kX3Zxc19jdHhfc2l6ZSgpIHRvIHNwZWNpZnkgdGhl
IG1heGltdW0gcmluZyBzaXplIG9mIHR4LAo+ID4gcnggYXQgdGhlIHNhbWUgdGltZS4KPiA+Cj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgcngvdHggcmluZyBzaXplCj4gPiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiBzcGVlZCA9PSBVTktOT1dO
IG9yIDwgMTBHfCAxMDI0Cj4gPiBzcGVlZCA8IDQwRyAgICAgICAgICAgICAgfCA0MDk2Cj4gPiBz
cGVlZCA+PSA0MEcgICAgICAgICAgICAgfCA4MTkyCj4gPgo+ID4gQ2FsbCB2aXJ0bmV0X3VwZGF0
ZV9zZXR0aW5ncygpIG9uY2UgYmVmb3JlIGNhbGxpbmcgaW5pdF92cXMoKSB0byB1cGRhdGUKPiA+
IHNwZWVkLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXgu
YWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNDIg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4g
PiBpbmRleCBmZmZmMzIzZGNlZjAuLmYxYmRjNmNlMjFjMyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4g
PiBAQCAtMjk3Nyw2ICsyOTc3LDI5IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbWVyZ2VhYmxlX21p
bl9idWZfbGVuKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3QgdmlydHF1Cj4gPiAgIAkJ
ICAgKHVuc2lnbmVkIGludClHT09EX1BBQ0tFVF9MRU4pOwo+ID4gICB9Cj4gPgo+ID4gK3N0YXRp
YyB2b2lkIHZpcnRuZXRfY29uZmlnX3NpemVzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCB1MzIg
KnNpemVzKQo+ID4gK3sKPiA+ICsJdTMyIGksIHJ4X3NpemUsIHR4X3NpemU7Cj4gPiArCj4gPiAr
CWlmICh2aS0+c3BlZWQgPT0gU1BFRURfVU5LTk9XTiB8fCB2aS0+c3BlZWQgPCBTUEVFRF8xMDAw
MCkgewo+ID4gKwkJcnhfc2l6ZSA9IDEwMjQ7Cj4gPiArCQl0eF9zaXplID0gMTAyNDsKPiA+ICsK
PiA+ICsJfSBlbHNlIGlmICh2aS0+c3BlZWQgPCBTUEVFRF80MDAwMCkgewo+ID4gKwkJcnhfc2l6
ZSA9IDEwMjQgKiA0Owo+ID4gKwkJdHhfc2l6ZSA9IDEwMjQgKiA0Owo+ID4gKwo+ID4gKwl9IGVs
c2Ugewo+ID4gKwkJcnhfc2l6ZSA9IDEwMjQgKiA4Owo+ID4gKwkJdHhfc2l6ZSA9IDEwMjQgKiA4
Owo+ID4gKwl9Cj4gPiArCj4gPiArCWZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJz
OyBpKyspIHsKPiA+ICsJCXNpemVzW3J4cTJ2cShpKV0gPSByeF9zaXplOwo+ID4gKwkJc2l6ZXNb
dHhxMnZxKGkpXSA9IHR4X3NpemU7Cj4gPiArCX0KPiA+ICt9Cj4gPiArCj4gPiAgIHN0YXRpYyBp
bnQgdmlydG5ldF9maW5kX3ZxcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiA+ICAgewo+ID4g
ICAJdnFfY2FsbGJhY2tfdCAqKmNhbGxiYWNrczsKPiA+IEBAIC0yOTg0LDYgKzMwMDcsNyBAQCBz
dGF0aWMgaW50IHZpcnRuZXRfZmluZF92cXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiAg
IAlpbnQgcmV0ID0gLUVOT01FTTsKPiA+ICAgCWludCBpLCB0b3RhbF92cXM7Cj4gPiAgIAljb25z
dCBjaGFyICoqbmFtZXM7Cj4gPiArCXUzMiAqc2l6ZXM7Cj4gPiAgIAlib29sICpjdHg7Cj4gPgo+
ID4gICAJLyogV2UgZXhwZWN0IDEgUlggdmlydHF1ZXVlIGZvbGxvd2VkIGJ5IDEgVFggdmlydHF1
ZXVlLCBmb2xsb3dlZCBieQo+ID4gQEAgLTMwMTEsMTAgKzMwMzUsMTUgQEAgc3RhdGljIGludCB2
aXJ0bmV0X2ZpbmRfdnFzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ID4gICAJCWN0eCA9IE5V
TEw7Cj4gPiAgIAl9Cj4gPgo+ID4gKwlzaXplcyA9IGttYWxsb2NfYXJyYXkodG90YWxfdnFzLCBz
aXplb2YoKnNpemVzKSwgR0ZQX0tFUk5FTCk7Cj4gPiArCWlmICghc2l6ZXMpCj4gPiArCQlnb3Rv
IGVycl9zaXplczsKPiA+ICsKPiA+ICAgCS8qIFBhcmFtZXRlcnMgZm9yIGNvbnRyb2wgdmlydHF1
ZXVlLCBpZiBhbnkgKi8KPiA+ICAgCWlmICh2aS0+aGFzX2N2cSkgewo+ID4gICAJCWNhbGxiYWNr
c1t0b3RhbF92cXMgLSAxXSA9IE5VTEw7Cj4gPiAgIAkJbmFtZXNbdG90YWxfdnFzIC0gMV0gPSAi
Y29udHJvbCI7Cj4gPiArCQlzaXplc1t0b3RhbF92cXMgLSAxXSA9IDA7Cj4KPgo+IE5pdDogRG8g
d2UgbmVlZCBhIHNhbmUgdmFsdWUgZm9yIHRoZSBjb250cm9sIHZxPyAoZS5nIDY0KQoKCkkgdGhp
bmsgaXQgY2FuLgoKVGhhbmtzLgoKPgo+IFRoYW5rcwo+Cj4KPiA+ICAgCX0KPiA+Cj4gPiAgIAkv
KiBBbGxvY2F0ZS9pbml0aWFsaXplIHBhcmFtZXRlcnMgZm9yIHNlbmQvcmVjZWl2ZSB2aXJ0cXVl
dWVzICovCj4gPiBAQCAtMzAyOSw4ICszMDU4LDEwIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9maW5k
X3ZxcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiA+ICAgCQkJY3R4W3J4cTJ2cShpKV0gPSB0
cnVlOwo+ID4gICAJfQo+ID4KPiA+IC0JcmV0ID0gdmlydGlvX2ZpbmRfdnFzX2N0eCh2aS0+dmRl
diwgdG90YWxfdnFzLCB2cXMsIGNhbGxiYWNrcywKPiA+IC0JCQkJICBuYW1lcywgY3R4LCBOVUxM
KTsKPiA+ICsJdmlydG5ldF9jb25maWdfc2l6ZXModmksIHNpemVzKTsKPiA+ICsKPiA+ICsJcmV0
ID0gdmlydGlvX2ZpbmRfdnFzX2N0eF9zaXplKHZpLT52ZGV2LCB0b3RhbF92cXMsIHZxcywgY2Fs
bGJhY2tzLAo+ID4gKwkJCQkgICAgICAgbmFtZXMsIGN0eCwgTlVMTCwgc2l6ZXMpOwo+ID4gICAJ
aWYgKHJldCkKPiA+ICAgCQlnb3RvIGVycl9maW5kOwo+ID4KPiA+IEBAIC0zMDUwLDYgKzMwODEs
OCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfZmluZF92cXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkp
Cj4gPgo+ID4KPiA+ICAgZXJyX2ZpbmQ6Cj4gPiArCWtmcmVlKHNpemVzKTsKPiA+ICtlcnJfc2l6
ZXM6Cj4gPiAgIAlrZnJlZShjdHgpOwo+ID4gICBlcnJfY3R4Ogo+ID4gICAJa2ZyZWUobmFtZXMp
Owo+ID4gQEAgLTMzNjgsNiArMzQwMSw5IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wcm9iZShzdHJ1
Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ICAgCQl2aS0+Y3Vycl9xdWV1ZV9wYWlycyA9IG51
bV9vbmxpbmVfY3B1cygpOwo+ID4gICAJdmktPm1heF9xdWV1ZV9wYWlycyA9IG1heF9xdWV1ZV9w
YWlyczsKPiA+Cj4gPiArCXZpcnRuZXRfaW5pdF9zZXR0aW5ncyhkZXYpOwo+ID4gKwl2aXJ0bmV0
X3VwZGF0ZV9zZXR0aW5ncyh2aSk7Cj4gPiArCj4gPiAgIAkvKiBBbGxvY2F0ZS9pbml0aWFsaXpl
IHRoZSByeC90eCBxdWV1ZXMsIGFuZCBpbnZva2UgZmluZF92cXMgKi8KPiA+ICAgCWVyciA9IGlu
aXRfdnFzKHZpKTsKPiA+ICAgCWlmIChlcnIpCj4gPiBAQCAtMzM4MCw4ICszNDE2LDYgQEAgc3Rh
dGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gICAJ
bmV0aWZfc2V0X3JlYWxfbnVtX3R4X3F1ZXVlcyhkZXYsIHZpLT5jdXJyX3F1ZXVlX3BhaXJzKTsK
PiA+ICAgCW5ldGlmX3NldF9yZWFsX251bV9yeF9xdWV1ZXMoZGV2LCB2aS0+Y3Vycl9xdWV1ZV9w
YWlycyk7Cj4gPgo+ID4gLQl2aXJ0bmV0X2luaXRfc2V0dGluZ3MoZGV2KTsKPiA+IC0KPiA+ICAg
CWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX1NUQU5EQlkpKSB7Cj4g
PiAgIAkJdmktPmZhaWxvdmVyID0gbmV0X2ZhaWxvdmVyX2NyZWF0ZSh2aS0+ZGV2KTsKPiA+ICAg
CQlpZiAoSVNfRVJSKHZpLT5mYWlsb3ZlcikpIHsKPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
