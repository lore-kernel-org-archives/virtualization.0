Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAECC433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 02:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 745204097E;
	Tue,  5 Jul 2022 02:00:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 745204097E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0QkPU2uyH1Fl; Tue,  5 Jul 2022 02:00:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E702640131;
	Tue,  5 Jul 2022 02:00:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E702640131
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA513C0032;
	Tue,  5 Jul 2022 02:00:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37C65C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2094C60BF9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:00:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2094C60BF9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pVWEKO0JWt_1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:00:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8326760BE9
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8326760BE9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:00:31 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VIPVpyX_1656986422; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VIPVpyX_1656986422) by smtp.aliyun-inc.com;
 Tue, 05 Jul 2022 10:00:23 +0800
Message-ID: <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
Date: Tue, 5 Jul 2022 09:59:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com>
 <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
In-Reply-To: <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
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

T24gTW9uLCA0IEp1bCAyMDIyIDExOjQ0OjEyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIHJlc2l6ZSBmdW5jdGlvbiBvZiB0aGUg
cnggcXVldWVzLgo+ID4gQmFzZWQgb24gdGhpcyBmdW5jdGlvbiwgaXQgaXMgcG9zc2libGUgdG8g
bW9kaWZ5IHRoZSByaW5nIG51bSBvZiB0aGUKPiA+IHF1ZXVlLgo+ID4KPiA+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAg
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKwo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IGlu
ZGV4IDlmZTIyMmEzNjYzYS4uNmFiMTZmZDE5M2U1IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IEBA
IC0yNzgsNiArMjc4LDggQEAgc3RydWN0IHBhZGRlZF92bmV0X2hkciB7Cj4gPiAgIAljaGFyIHBh
ZGRpbmdbMTJdOwo+ID4gICB9Owo+ID4KPiA+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3JxX2ZyZWVf
dW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiA+ICsKPiA+ICAg
c3RhdGljIGJvb2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0cikKPiA+ICAgewo+ID4gICAJcmV0dXJu
ICh1bnNpZ25lZCBsb25nKXB0ciAmIFZJUlRJT19YRFBfRkxBRzsKPiA+IEBAIC0xODQ2LDYgKzE4
NDgsMjYgQEAgc3RhdGljIG5ldGRldl90eF90IHN0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNr
Yiwgc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ICAgCXJldHVybiBORVRERVZfVFhfT0s7Cj4g
PiAgIH0KPiA+Cj4gPiArc3RhdGljIGludCB2aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5l
dF9pbmZvICp2aSwKPiA+ICsJCQkgICAgIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwgdTMyIHJp
bmdfbnVtKQo+ID4gK3sKPiA+ICsJaW50IGVyciwgcWluZGV4Owo+ID4gKwo+ID4gKwlxaW5kZXgg
PSBycSAtIHZpLT5ycTsKPiA+ICsKPiA+ICsJbmFwaV9kaXNhYmxlKCZycS0+bmFwaSk7Cj4KPgo+
IERvIHdlIG5lZWQgdG8gY2FuY2VsIHRoZSByZWZpbGwgd29yayBoZXJlPwoKCkkgdGhpbmsgbm8s
IG5hcGlfZGlzYWJsZSBpcyBtdXR1YWxseSBleGNsdXNpdmUsIHdoaWNoIGVuc3VyZXMgdGhhdCB0
aGVyZSB3aWxsIGJlCm5vIGNvbmZsaWN0cyBiZXR3ZWVuIHRoZW0uCgpUaGFua3MuCgo+Cj4gVGhh
bmtzCj4KPgo+ID4gKwo+ID4gKwllcnIgPSB2aXJ0cXVldWVfcmVzaXplKHJxLT52cSwgcmluZ19u
dW0sIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKTsKPiA+ICsJaWYgKGVycikKPiA+ICsJCW5l
dGRldl9lcnIodmktPmRldiwgInJlc2l6ZSByeCBmYWlsOiByeCBxdWV1ZSBpbmRleDogJWQgZXJy
OiAlZFxuIiwgcWluZGV4LCBlcnIpOwo+ID4gKwo+ID4gKwlpZiAoIXRyeV9maWxsX3JlY3Yodmks
IHJxLCBHRlBfS0VSTkVMKSkKPiA+ICsJCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygmdmktPnJlZmls
bCwgMCk7Cj4gPiArCj4gPiArCXZpcnRuZXRfbmFwaV9lbmFibGUocnEtPnZxLCAmcnEtPm5hcGkp
Owo+ID4gKwlyZXR1cm4gZXJyOwo+ID4gK30KPiA+ICsKPiA+ICAgLyoKPiA+ICAgICogU2VuZCBj
b21tYW5kIHZpYSB0aGUgY29udHJvbCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1h
bmRzCj4gPiAgICAqIHN1cHBvcnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgYXMgaW5kaWNhdGVkIGJ5
IGZlYXR1cmUgYml0cywgc2hvdWxkCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
