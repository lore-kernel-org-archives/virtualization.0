Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5180C43334
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 02:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59EEC60EB4;
	Tue,  5 Jul 2022 02:23:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59EEC60EB4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vVMoSsGogrxY; Tue,  5 Jul 2022 02:23:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD5DF60EAB;
	Tue,  5 Jul 2022 02:23:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD5DF60EAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72AB9C0032;
	Tue,  5 Jul 2022 02:23:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA3E7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE253824DF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:23:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE253824DF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IO7691EwshqC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:23:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A679D8249E
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A679D8249E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:23:08 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VIPtdPZ_1656987780; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VIPtdPZ_1656987780) by smtp.aliyun-inc.com;
 Tue, 05 Jul 2022 10:23:01 +0800
Message-ID: <1656987177.3209145-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 08/40] virtio_ring: split: extract the logic of alloc
 queue
Date: Tue, 5 Jul 2022 10:12:57 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-9-xuanzhuo@linux.alibaba.com>
 <3e36e44f-1f37-ad02-eb89-833a0856ec4e@redhat.com>
 <1656665158.0036178-3-xuanzhuo@linux.alibaba.com>
 <6daca7fd-ae2a-cd0c-2030-3c6e503a3200@redhat.com>
In-Reply-To: <6daca7fd-ae2a-cd0c-2030-3c6e503a3200@redhat.com>
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

T24gTW9uLCA0IEp1bCAyMDIyIDExOjU5OjAzICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzcvMSAxNjo0NSwgWHVhbiBaaHVvIOWGmemB
kzoKPiA+IE9uIEZyaSwgMSBKdWwgMjAyMiAxNjoyNjoyNSArMDgwMCwgSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4g5ZyoIDIwMjIvNi8yOSAxNDo1NiwgWHVhbiBa
aHVvIOWGmemBkzoKPiA+Pj4gU2VwYXJhdGUgdGhlIGxvZ2ljIG9mIHNwbGl0IHRvIGNyZWF0ZSB2
cmluZyBxdWV1ZS4KPiA+Pj4KPiA+Pj4gVGhpcyBmZWF0dXJlIGlzIHJlcXVpcmVkIGZvciBzdWJz
ZXF1ZW50IHZpcnR1cXVldWUgcmVzZXQgdnJpbmcuCj4gPj4+Cj4gPj4+IFNpZ25lZC1vZmYtYnk6
IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPj4+IC0tLQo+ID4+PiAg
ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNjggKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCsp
LCAyNiBkZWxldGlvbnMoLSkKPiA+Pj4KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPj4+IGluZGV4
IDQ5ZDYxZTQxMmRjNi4uYTljZWI5YzE2YzU0IDEwMDY0NAo+ID4+PiAtLS0gYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jCj4gPj4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMKPiA+Pj4gQEAgLTk0OSwyOCArOTQ5LDE5IEBAIHN0YXRpYyB2b2lkIHZyaW5nX2ZyZWVfc3Bs
aXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCAqdnJpbmcsCj4gPj4+ICAgIAlrZnJlZSh2
cmluZy0+ZGVzY19leHRyYSk7Cj4gPj4+ICAgIH0KPiA+Pj4KPiA+Pj4gLXN0YXRpYyBzdHJ1Y3Qg
dmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ID4+PiAtCXVuc2lnbmVk
IGludCBpbmRleCwKPiA+Pj4gLQl1bnNpZ25lZCBpbnQgbnVtLAo+ID4+PiAtCXVuc2lnbmVkIGlu
dCB2cmluZ19hbGlnbiwKPiA+Pj4gLQlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiA+Pj4g
LQlib29sIHdlYWtfYmFycmllcnMsCj4gPj4+IC0JYm9vbCBtYXlfcmVkdWNlX251bSwKPiA+Pj4g
LQlib29sIGNvbnRleHQsCj4gPj4+IC0JYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAq
KSwKPiA+Pj4gLQl2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPj4+IC0J
Y29uc3QgY2hhciAqbmFtZSkKPiA+Pj4gK3N0YXRpYyBpbnQgdnJpbmdfYWxsb2NfcXVldWVfc3Bs
aXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCAqdnJpbmcsCj4gPj4+ICsJCQkJICAgc3Ry
dWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gPj4+ICsJCQkJICAgdTMyIG51bSwKPiA+Pj4gKwkJ
CQkgICB1bnNpZ25lZCBpbnQgdnJpbmdfYWxpZ24sCj4gPj4+ICsJCQkJICAgYm9vbCBtYXlfcmVk
dWNlX251bSkKPiA+Pj4gICAgewo+ID4+PiAtCXN0cnVjdCB2aXJ0cXVldWUgKnZxOwo+ID4+PiAg
ICAJdm9pZCAqcXVldWUgPSBOVUxMOwo+ID4+PiAgICAJZG1hX2FkZHJfdCBkbWFfYWRkcjsKPiA+
Pj4gLQlzaXplX3QgcXVldWVfc2l6ZV9pbl9ieXRlczsKPiA+Pj4gLQlzdHJ1Y3QgdnJpbmcgdnJp
bmc7Cj4gPj4+Cj4gPj4+ICAgIAkvKiBXZSBhc3N1bWUgbnVtIGlzIGEgcG93ZXIgb2YgMi4gKi8K
PiA+Pj4gICAgCWlmIChudW0gJiAobnVtIC0gMSkpIHsKPiA+Pj4gICAgCQlkZXZfd2FybigmdmRl
di0+ZGV2LCAiQmFkIHZpcnRxdWV1ZSBsZW5ndGggJXVcbiIsIG51bSk7Cj4gPj4+IC0JCXJldHVy
biBOVUxMOwo+ID4+PiArCQlyZXR1cm4gLUVJTlZBTDsKPiA+Pj4gICAgCX0KPiA+Pj4KPiA+Pj4g
ICAgCS8qIFRPRE86IGFsbG9jYXRlIGVhY2ggcXVldWUgY2h1bmsgaW5kaXZpZHVhbGx5ICovCj4g
Pj4+IEBAIC05ODEsMTEgKzk3MiwxMSBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdf
Y3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+Pj4gICAgCQlpZiAocXVldWUpCj4gPj4+ICAgIAkJ
CWJyZWFrOwo+ID4+PiAgICAJCWlmICghbWF5X3JlZHVjZV9udW0pCj4gPj4+IC0JCQlyZXR1cm4g
TlVMTDsKPiA+Pj4gKwkJCXJldHVybiAtRU5PTUVNOwo+ID4+PiAgICAJfQo+ID4+Pgo+ID4+PiAg
ICAJaWYgKCFudW0pCj4gPj4+IC0JCXJldHVybiBOVUxMOwo+ID4+PiArCQlyZXR1cm4gLUVOT01F
TTsKPiA+Pj4KPiA+Pj4gICAgCWlmICghcXVldWUpIHsKPiA+Pj4gICAgCQkvKiBUcnkgdG8gZ2V0
IGEgc2luZ2xlIHBhZ2UuIFlvdSBhcmUgbXkgb25seSBob3BlISAqLwo+ID4+PiBAQCAtOTkzLDIx
ICs5ODQsNDYgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVl
dWVfc3BsaXQoCj4gPj4+ICAgIAkJCQkJICAmZG1hX2FkZHIsIEdGUF9LRVJORUx8X19HRlBfWkVS
Tyk7Cj4gPj4+ICAgIAl9Cj4gPj4+ICAgIAlpZiAoIXF1ZXVlKQo+ID4+PiAtCQlyZXR1cm4gTlVM
TDsKPiA+Pj4gKwkJcmV0dXJuIC1FTk9NRU07Cj4gPj4+ICsKPiA+Pj4gKwl2cmluZ19pbml0KCZ2
cmluZy0+dnJpbmcsIG51bSwgcXVldWUsIHZyaW5nX2FsaWduKTsKPiA+Pj4KPiA+Pj4gLQlxdWV1
ZV9zaXplX2luX2J5dGVzID0gdnJpbmdfc2l6ZShudW0sIHZyaW5nX2FsaWduKTsKPiA+Pj4gLQl2
cmluZ19pbml0KCZ2cmluZywgbnVtLCBxdWV1ZSwgdnJpbmdfYWxpZ24pOwo+ID4+PiArCXZyaW5n
LT5xdWV1ZV9kbWFfYWRkciA9IGRtYV9hZGRyOwo+ID4+PiArCXZyaW5nLT5xdWV1ZV9zaXplX2lu
X2J5dGVzID0gdnJpbmdfc2l6ZShudW0sIHZyaW5nX2FsaWduKTsKPiA+Pj4gKwo+ID4+PiArCXJl
dHVybiAwOwo+ID4+PiArfQo+ID4+PiArCj4gPj4+ICtzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAq
dnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+Pj4gKwl1bnNpZ25lZCBpbnQgaW5kZXgs
Cj4gPj4+ICsJdW5zaWduZWQgaW50IG51bSwKPiA+Pj4gKwl1bnNpZ25lZCBpbnQgdnJpbmdfYWxp
Z24sCj4gPj4+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gPj4+ICsJYm9vbCB3ZWFr
X2JhcnJpZXJzLAo+ID4+PiArCWJvb2wgbWF5X3JlZHVjZV9udW0sCj4gPj4+ICsJYm9vbCBjb250
ZXh0LAo+ID4+PiArCWJvb2wgKCpub3RpZnkpKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPj4+ICsJ
dm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4+PiArCWNvbnN0IGNoYXIg
Km5hbWUpCj4gPj4+ICt7Cj4gPj4+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB2cmlu
ZyA9IHt9Owo+ID4+PiArCXN0cnVjdCB2aXJ0cXVldWUgKnZxOwo+ID4+PiArCWludCBlcnI7Cj4g
Pj4+ICsKPiA+Pj4gKwllcnIgPSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCgmdnJpbmcsIHZkZXYs
IG51bSwgdnJpbmdfYWxpZ24sCj4gPj4+ICsJCQkJICAgICAgbWF5X3JlZHVjZV9udW0pOwo+ID4+
PiArCWlmIChlcnIpCj4gPj4+ICsJCXJldHVybiBOVUxMOwo+ID4+Pgo+ID4+PiAtCXZxID0gX192
cmluZ19uZXdfdmlydHF1ZXVlKGluZGV4LCB2cmluZywgdmRldiwgd2Vha19iYXJyaWVycywgY29u
dGV4dCwKPiA+Pj4gLQkJCQkgICBub3RpZnksIGNhbGxiYWNrLCBuYW1lKTsKPiA+Pj4gKwl2cSA9
IF9fdnJpbmdfbmV3X3ZpcnRxdWV1ZShpbmRleCwgdnJpbmcudnJpbmcsIHZkZXYsIHdlYWtfYmFy
cmllcnMsCj4gPj4+ICsJCQkJICAgY29udGV4dCwgbm90aWZ5LCBjYWxsYmFjaywgbmFtZSk7Cj4g
Pj4+ICAgIAlpZiAoIXZxKSB7Cj4gPj4+IC0JCXZyaW5nX2ZyZWVfcXVldWUodmRldiwgcXVldWVf
c2l6ZV9pbl9ieXRlcywgcXVldWUsCj4gPj4+IC0JCQkJIGRtYV9hZGRyKTsKPiA+Pj4gKwkJdnJp
bmdfZnJlZV9zcGxpdCgmdnJpbmcsIHZkZXYpOwo+ID4+PiAgICAJCXJldHVybiBOVUxMOwo+ID4+
PiAgICAJfQo+ID4+Pgo+ID4+PiAtCXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0g
ZG1hX2FkZHI7Cj4gPj4+IC0JdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9
IHF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gPj4+ICsJdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfZG1h
X2FkZHIgPSB2cmluZy5xdWV1ZV9kbWFfYWRkcjsKPiA+Pgo+ID4+IE5pdDogaGF2aW5nIHR3byBx
dWV1ZV9kbWFfYWRkciBzZWVtcyByZWR1bmRhbnQgKHNvIGRpZCBxdWV1ZV9zaXplX2luX2J5dGVz
KS4KPiA+IHR3bz8KPiA+Cj4gPiBXaGVyZSBpcyB0aGUgcHJvYmxlbSBJIGRvbid0IHVuZGVyc3Rh
bmQ/Cj4gPgo+ID4gVGhhbmtzLgo+Cj4KPiBJIG1lYW50IHdlIGhhZDoKPgo+ICDCoMKgwqDCoMKg
wqDCoCB2cmluZy52cmluZyA9IF92cmluZzsKPgo+IGluIF9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSgp
Lgo+Cj4gVGhpcyBtZWFucyB3ZSdkIGJldHRlciBpbml0aWFsaXplIHZyaW5nIGZ1bGx5IGJlZm9y
ZSB0aGF0Pwo+Cj4gRS5nCj4KPiB2cmluZy5xdWV1ZV9kbWFfYWRkciA9IGRtYV9hZGRyOwo+Cj4g
Li4uCj4KPiBfX3ZyaW5nX25ld192aXJ0cXVldWUoKQoKb2gsIG15IGJhZCwgbWF5YmUgdGhlIHJl
cGVhdGVkIHVzZSBvZiB0aGUgbmFtZSAidnJpbmciIGxlZCB0byBhCm1pc3VuZGVyc3RhbmRpbmcu
CgpXaGF0IGlzIHBhc3NlZCB0byBfX3ZyaW5nX25ld192aXJ0cXVldWUgaXMgdGhlIHN0cnVjdHVy
ZSBzdHJ1Y3QgdnJpbmcKCnN0cnVjdCB2cmluZyB7Cgl1bnNpZ25lZCBpbnQgbnVtOwoKCXZyaW5n
X2Rlc2NfdCAqZGVzYzsKCgl2cmluZ19hdmFpbF90ICphdmFpbDsKCgl2cmluZ191c2VkX3QgKnVz
ZWQ7Cn07CgpBbmQgd2hhdCBjb250YWlucyBxdWV1ZV9kbWFfYWRkciBpcyBvdXIgbmV3bHkgc3Bs
aXQgc3RydWN0dXJlIHN0cnVjdAp2cmluZ192aXJ0cXVldWVfc3BsaXQKCnN0cnVjdCB2cmluZ192
aXJ0cXVldWVfc3BsaXQgewoJLyogQWN0dWFsIG1lbW9yeSBsYXlvdXQgZm9yIHRoaXMgcXVldWUu
ICovCglzdHJ1Y3QgdnJpbmcgdnJpbmc7CgoJLyogTGFzdCB3cml0dGVuIHZhbHVlIHRvIGF2YWls
LT5mbGFncyAqLwoJdTE2IGF2YWlsX2ZsYWdzX3NoYWRvdzsKCgkvKgoJICogTGFzdCB3cml0dGVu
IHZhbHVlIHRvIGF2YWlsLT5pZHggaW4KCSAqIGd1ZXN0IGJ5dGUgb3JkZXIuCgkgKi8KCXUxNiBh
dmFpbF9pZHhfc2hhZG93OwoKCS8qIFBlci1kZXNjcmlwdG9yIHN0YXRlLiAqLwoJc3RydWN0IHZy
aW5nX2Rlc2Nfc3RhdGVfc3BsaXQgKmRlc2Nfc3RhdGU7CglzdHJ1Y3QgdnJpbmdfZGVzY19leHRy
YSAqZGVzY19leHRyYTsKCgkvKiBETUEgYWRkcmVzcyBhbmQgc2l6ZSBpbmZvcm1hdGlvbiAqLwoJ
ZG1hX2FkZHJfdCBxdWV1ZV9kbWFfYWRkcjsKCXNpemVfdCBxdWV1ZV9zaXplX2luX2J5dGVzOwoK
CS8qCgkgKiBUaGUgcGFyYW1ldGVycyBmb3IgY3JlYXRpbmcgdnJpbmdzIGFyZSByZXNlcnZlZCBm
b3IgY3JlYXRpbmcgbmV3CgkgKiB2cmluZy4KCSAqLwoJdTMyIHZyaW5nX2FsaWduOwoJYm9vbCBt
YXlfcmVkdWNlX251bTsKfTsKCldlIGhhdmUgbm8gd2F5IHRvIHBhc3MgcXVldWVfZG1hX2FkZHIg
aW50byBfX3ZyaW5nX25ld192aXJ0cXVldWUuIEJ1dCBmb3IgdGhlCnVuaWZvcm1pdHkgb2YgdGhl
IGludGVyZmFjZSwgSSBjcmVhdGUgYSB0ZW1wb3Jhcnkgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9z
cGxpdAp2cmluZ19zcGxpdCh5b3VyIHN1Z2dlc3Rpb24pIGluIF9fdnJpbmdfbmV3X3ZpcnRxdWV1
ZS4gVGhlbiBhc3NpZ24gdGhlIHBhc3NlZAppbiBzdHJ1Y3QgdnJpbmcgdG8gaXQKCgl2cmluZy52
cmluZyA9IF92cmluZy4KClNvIGhlcmUgdnJpbmcgaXMgYW4gZW1wdHkgdGVtcG9yYXJ5IHZhcmlh
YmxlLgoKQXMgeW91IGhhdmUgcmVwbGllZCBpbiBvdGhlciBwYXRjaGVzLCBteSByZS11c2Ugb2Yg
dGhlIG5hbWUgdnJpbmcgaXMgYSBtaXN0YWtlLApJIHdpbGwgY2hhbmdlIHNvbWUgcGxhY2VzIHRv
IHZyaW5nX3NwbGl0IGFuZCB2cmluZ19wYWNrZWQuCgpUaGFua3MuCgoKPgo+IFRoYW5rcwo+Cj4K
PiA+Cj4gPj4gVGhhbmtzCj4gPj4KPiA+Pgo+ID4+PiArCXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVl
X3NpemVfaW5fYnl0ZXMgPSB2cmluZy5xdWV1ZV9zaXplX2luX2J5dGVzOwo+ID4+PiAgICAJdG9f
dnZxKHZxKS0+d2Vfb3duX3JpbmcgPSB0cnVlOwo+ID4+Pgo+ID4+PiAgICAJcmV0dXJuIHZxOwo+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
