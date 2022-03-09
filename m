Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFD0C43217
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:23:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9EAD41516;
	Wed,  9 Mar 2022 09:23:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5vpKfswvixfK; Wed,  9 Mar 2022 09:23:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F645410E0;
	Wed,  9 Mar 2022 09:23:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F21FC0012;
	Wed,  9 Mar 2022 09:23:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22EEAC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F263B60F53
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:23:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NJZa5OtiZRFu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:23:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CE1060C0D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:23:04 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V6iwYED_1646817777; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6iwYED_1646817777) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Mar 2022 17:22:58 +0800
Message-ID: <1646817741.6086373-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 08/26] virtio_ring: extract the logic of freeing vring
Date: Wed, 9 Mar 2022 17:22:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-9-xuanzhuo@linux.alibaba.com>
 <aa24df8c-787a-0db5-7b16-60adcb86ab0c@redhat.com>
In-Reply-To: <aa24df8c-787a-0db5-7b16-60adcb86ab0c@redhat.com>
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

T24gV2VkLCA5IE1hciAyMDIyIDE1OjUxOjEzICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gSW50cm9kdWNlIHZyaW5nX2ZyZWUoKSB0byBmcmVlIHRoZSB2cmluZyBvZiB2
cS4KPiA+Cj4gPiBQcmV2ZW50IGRvdWJsZSBmcmVlIGJ5IHNldHRpbmcgdnEtPnJlc2V0Lgo+ID4K
PiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+
Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI1ICsrKysrKysr
KysrKysrKysrKysrLS0tLS0KPiA+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICA4
ICsrKysrKysrCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IGluZGV4IGI1YTliZjRmNDViMy4u
ZTA0MjJjMDRjOTAzIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gQEAgLTI0NDIsMTQg
KzI0NDIsMTAgQEAgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25l
ZCBpbnQgaW5kZXgsCj4gPiAgIH0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwodnJpbmdfbmV3X3Zp
cnRxdWV1ZSk7Cj4gPgo+ID4gLXZvaWQgdnJpbmdfZGVsX3ZpcnRxdWV1ZShzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEpCj4gPiArc3RhdGljIHZvaWQgX192cmluZ19mcmVlKHN0cnVjdCB2aXJ0cXVldWUg
Kl92cSkKPiA+ICAgewo+ID4gICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEo
X3ZxKTsKPiA+Cj4gPiAtCXNwaW5fbG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xvY2spOwo+
ID4gLQlsaXN0X2RlbCgmX3ZxLT5saXN0KTsKPiA+IC0Jc3Bpbl91bmxvY2soJnZxLT52cS52ZGV2
LT52cXNfbGlzdF9sb2NrKTsKPiA+IC0KPiA+ICAgCWlmICh2cS0+d2Vfb3duX3JpbmcpIHsKPiA+
ICAgCQlpZiAodnEtPnBhY2tlZF9yaW5nKSB7Cj4gPiAgIAkJCXZyaW5nX2ZyZWVfcXVldWUodnEt
PnZxLnZkZXYsCj4gPiBAQCAtMjQ4MCw2ICsyNDc2LDI1IEBAIHZvaWQgdnJpbmdfZGVsX3ZpcnRx
dWV1ZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gPiAgIAkJa2ZyZWUodnEtPnNwbGl0LmRlc2Nf
c3RhdGUpOwo+ID4gICAJCWtmcmVlKHZxLT5zcGxpdC5kZXNjX2V4dHJhKTsKPiA+ICAgCX0KPiA+
ICt9Cj4gPiArCj4gPiArc3RhdGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICp2
cSkKPiA+ICt7Cj4gPiArCV9fdnJpbmdfZnJlZSh2cSk7Cj4gPiArCXZxLT5yZXNldCA9IFZJUlRJ
T19WUV9SRVNFVF9TVEVQX1ZSSU5HX1JFTEVBU0U7Cj4gPiArfQo+ID4gKwo+ID4gK3ZvaWQgdnJp
bmdfZGVsX3ZpcnRxdWV1ZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gPiArewo+ID4gKwlzdHJ1
Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gKwo+ID4gKwlzcGluX2xv
Y2soJnZxLT52cS52ZGV2LT52cXNfbGlzdF9sb2NrKTsKPiA+ICsJbGlzdF9kZWwoJl92cS0+bGlz
dCk7Cj4gPiArCXNwaW5fdW5sb2NrKCZ2cS0+dnEudmRldi0+dnFzX2xpc3RfbG9jayk7Cj4gPiAr
Cj4gPiArCWlmIChfdnEtPnJlc2V0ICE9IFZJUlRJT19WUV9SRVNFVF9TVEVQX1ZSSU5HX1JFTEVB
U0UpCj4gPiArCQlfX3ZyaW5nX2ZyZWUoX3ZxKTsKPiA+ICsKPiA+ICAgCWtmcmVlKHZxKTsKPiA+
ICAgfQo+ID4gICBFWFBPUlRfU1lNQk9MX0dQTCh2cmluZ19kZWxfdmlydHF1ZXVlKTsKPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8u
aAo+ID4gaW5kZXggZDU5YWRjNGJlMDY4Li5lMzcxNGU2ZGIzMzAgMTAwNjQ0Cj4gPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4g
PiBAQCAtMTAsNiArMTAsMTMgQEAKPiA+ICAgI2luY2x1ZGUgPGxpbnV4L21vZF9kZXZpY2V0YWJs
ZS5oPgo+ID4gICAjaW5jbHVkZSA8bGludXgvZ2ZwLmg+Cj4gPgo+ID4gK2VudW0gdmlydGlvX3Zx
X3Jlc2V0X3N0ZXAgewo+ID4gKwlWSVJUSU9fVlFfUkVTRVRfU1RFUF9OT05FLAo+ID4gKwlWSVJU
SU9fVlFfUkVTRVRfU1RFUF9ERVZJQ0UsCj4gPiArCVZJUlRJT19WUV9SRVNFVF9TVEVQX1ZSSU5H
X1JFTEVBU0UsCj4gPiArCVZJUlRJT19WUV9SRVNFVF9TVEVQX1ZSSU5HX0FUVEFDSCwKPiA+ICt9
Owo+Cj4KPiBUaGlzIHBhcnQgbG9va3Mgbm90IHJlbGF0ZWQgdG8gdGhlIHN1YmplY3QuCj4KPiBB
bmQgaXQgbmVlZHMgZGV0YWlsIGRvY3VtZW50YXRpb24gb24gdGhpcy4KPgo+IEJ1dCBJIHdvbmRl
ciBob3cgdXNlZnVsIGl0IGlzLCBhbnl3YXkgd2UgY2FuIGNoZWNrIHRoZSByZXNldCBzdGF0dXMg
dmlhCj4gdHJhbnNwb3J0IHNwZWNpZmljIHdheSBhbmQgaW4gdGhlIGZ1dHVyZSB3ZSBtYXkgd2Fu
dCB0byBkbyBtb3JlIHRoYW4KPiBqdXN0IHJlc2l6aW5nIChlLmcgUEFTSUQpLgoKCkkgd2lsbCB0
cnkgYW5kIHJlbW92ZSBpdCBmcm9tIGhlcmUuCgpUaGFua3MuCgo+Cj4gVGhhbmtzCj4KPgo+ID4g
Kwo+ID4gICAvKioKPiA+ICAgICogdmlydHF1ZXVlIC0gYSBxdWV1ZSB0byByZWdpc3RlciBidWZm
ZXJzIGZvciBzZW5kaW5nIG9yIHJlY2VpdmluZy4KPiA+ICAgICogQGxpc3Q6IHRoZSBjaGFpbiBv
ZiB2aXJ0cXVldWVzIGZvciB0aGlzIGRldmljZQo+ID4gQEAgLTMzLDYgKzQwLDcgQEAgc3RydWN0
IHZpcnRxdWV1ZSB7Cj4gPiAgIAl1bnNpZ25lZCBpbnQgbnVtX2ZyZWU7Cj4gPiAgIAl1bnNpZ25l
ZCBpbnQgbnVtX21heDsKPiA+ICAgCXZvaWQgKnByaXY7Cj4gPiArCWVudW0gdmlydGlvX3ZxX3Jl
c2V0X3N0ZXAgcmVzZXQ7Cj4gPiAgIH07Cj4gPgo+ID4gICBpbnQgdmlydHF1ZXVlX2FkZF9vdXRi
dWYoc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
