Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E459C433EF
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 08:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B3F34184F;
	Fri,  1 Jul 2022 08:47:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B3F34184F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ul4bMzoRrs7B; Fri,  1 Jul 2022 08:47:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 65BC341847;
	Fri,  1 Jul 2022 08:47:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 65BC341847
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A371C0032;
	Fri,  1 Jul 2022 08:47:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CD76C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DDAE182D45
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:47:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDAE182D45
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PtoT28vPUhQW
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F9E582A0B
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F9E582A0B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:46:59 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R261e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VI.FZu2_1656665211; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VI.FZu2_1656665211) by smtp.aliyun-inc.com;
 Fri, 01 Jul 2022 16:46:52 +0800
Message-ID: <1656665158.0036178-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 08/40] virtio_ring: split: extract the logic of alloc
 queue
Date: Fri, 1 Jul 2022 16:45:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-9-xuanzhuo@linux.alibaba.com>
 <3e36e44f-1f37-ad02-eb89-833a0856ec4e@redhat.com>
In-Reply-To: <3e36e44f-1f37-ad02-eb89-833a0856ec4e@redhat.com>
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

T24gRnJpLCAxIEp1bCAyMDIyIDE2OjI2OjI1ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiBTZXBhcmF0ZSB0aGUgbG9naWMgb2Ygc3BsaXQgdG8gY3JlYXRlIHZyaW5nIHF1ZXVl
Lgo+ID4KPiA+IFRoaXMgZmVhdHVyZSBpcyByZXF1aXJlZCBmb3Igc3Vic2VxdWVudCB2aXJ0dXF1
ZXVlIHJlc2V0IHZyaW5nLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYyB8IDY4ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCj4gPgo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gPiBpbmRleCA0OWQ2MWU0MTJkYzYuLmE5Y2ViOWMxNmM1NCAxMDA2
NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ICsrKyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBAIC05NDksMjggKzk0OSwxOSBAQCBzdGF0aWMg
dm9pZCB2cmluZ19mcmVlX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgKnZyaW5n
LAo+ID4gICAJa2ZyZWUodnJpbmctPmRlc2NfZXh0cmEpOwo+ID4gICB9Cj4gPgo+ID4gLXN0YXRp
YyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ID4gLQl1
bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiAtCXVuc2lnbmVkIGludCBudW0sCj4gPiAtCXVuc2lnbmVk
IGludCB2cmluZ19hbGlnbiwKPiA+IC0Jc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gPiAt
CWJvb2wgd2Vha19iYXJyaWVycywKPiA+IC0JYm9vbCBtYXlfcmVkdWNlX251bSwKPiA+IC0JYm9v
bCBjb250ZXh0LAo+ID4gLQlib29sICgqbm90aWZ5KShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4g
LQl2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiAtCWNvbnN0IGNoYXIg
Km5hbWUpCj4gPiArc3RhdGljIGludCB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdChzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlX3NwbGl0ICp2cmluZywKPiA+ICsJCQkJICAgc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYsCj4gPiArCQkJCSAgIHUzMiBudW0sCj4gPiArCQkJCSAgIHVuc2lnbmVkIGludCB2
cmluZ19hbGlnbiwKPiA+ICsJCQkJICAgYm9vbCBtYXlfcmVkdWNlX251bSkKPiA+ICAgewo+ID4g
LQlzdHJ1Y3QgdmlydHF1ZXVlICp2cTsKPiA+ICAgCXZvaWQgKnF1ZXVlID0gTlVMTDsKPiA+ICAg
CWRtYV9hZGRyX3QgZG1hX2FkZHI7Cj4gPiAtCXNpemVfdCBxdWV1ZV9zaXplX2luX2J5dGVzOwo+
ID4gLQlzdHJ1Y3QgdnJpbmcgdnJpbmc7Cj4gPgo+ID4gICAJLyogV2UgYXNzdW1lIG51bSBpcyBh
IHBvd2VyIG9mIDIuICovCj4gPiAgIAlpZiAobnVtICYgKG51bSAtIDEpKSB7Cj4gPiAgIAkJZGV2
X3dhcm4oJnZkZXYtPmRldiwgIkJhZCB2aXJ0cXVldWUgbGVuZ3RoICV1XG4iLCBudW0pOwo+ID4g
LQkJcmV0dXJuIE5VTEw7Cj4gPiArCQlyZXR1cm4gLUVJTlZBTDsKPiA+ICAgCX0KPiA+Cj4gPiAg
IAkvKiBUT0RPOiBhbGxvY2F0ZSBlYWNoIHF1ZXVlIGNodW5rIGluZGl2aWR1YWxseSAqLwo+ID4g
QEAgLTk4MSwxMSArOTcyLDExIEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVh
dGVfdmlydHF1ZXVlX3NwbGl0KAo+ID4gICAJCWlmIChxdWV1ZSkKPiA+ICAgCQkJYnJlYWs7Cj4g
PiAgIAkJaWYgKCFtYXlfcmVkdWNlX251bSkKPiA+IC0JCQlyZXR1cm4gTlVMTDsKPiA+ICsJCQly
ZXR1cm4gLUVOT01FTTsKPiA+ICAgCX0KPiA+Cj4gPiAgIAlpZiAoIW51bSkKPiA+IC0JCXJldHVy
biBOVUxMOwo+ID4gKwkJcmV0dXJuIC1FTk9NRU07Cj4gPgo+ID4gICAJaWYgKCFxdWV1ZSkgewo+
ID4gICAJCS8qIFRyeSB0byBnZXQgYSBzaW5nbGUgcGFnZS4gWW91IGFyZSBteSBvbmx5IGhvcGUh
ICovCj4gPiBAQCAtOTkzLDIxICs5ODQsNDYgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZy
aW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4gPiAgIAkJCQkJICAmZG1hX2FkZHIsIEdGUF9L
RVJORUx8X19HRlBfWkVSTyk7Cj4gPiAgIAl9Cj4gPiAgIAlpZiAoIXF1ZXVlKQo+ID4gLQkJcmV0
dXJuIE5VTEw7Cj4gPiArCQlyZXR1cm4gLUVOT01FTTsKPiA+ICsKPiA+ICsJdnJpbmdfaW5pdCgm
dnJpbmctPnZyaW5nLCBudW0sIHF1ZXVlLCB2cmluZ19hbGlnbik7Cj4gPgo+ID4gLQlxdWV1ZV9z
aXplX2luX2J5dGVzID0gdnJpbmdfc2l6ZShudW0sIHZyaW5nX2FsaWduKTsKPiA+IC0JdnJpbmdf
aW5pdCgmdnJpbmcsIG51bSwgcXVldWUsIHZyaW5nX2FsaWduKTsKPiA+ICsJdnJpbmctPnF1ZXVl
X2RtYV9hZGRyID0gZG1hX2FkZHI7Cj4gPiArCXZyaW5nLT5xdWV1ZV9zaXplX2luX2J5dGVzID0g
dnJpbmdfc2l6ZShudW0sIHZyaW5nX2FsaWduKTsKPiA+ICsKPiA+ICsJcmV0dXJuIDA7Cj4gPiAr
fQo+ID4gKwo+ID4gK3N0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1
ZXVlX3NwbGl0KAo+ID4gKwl1bnNpZ25lZCBpbnQgaW5kZXgsCj4gPiArCXVuc2lnbmVkIGludCBu
dW0sCj4gPiArCXVuc2lnbmVkIGludCB2cmluZ19hbGlnbiwKPiA+ICsJc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYsCj4gPiArCWJvb2wgd2Vha19iYXJyaWVycywKPiA+ICsJYm9vbCBtYXlfcmVk
dWNlX251bSwKPiA+ICsJYm9vbCBjb250ZXh0LAo+ID4gKwlib29sICgqbm90aWZ5KShzdHJ1Y3Qg
dmlydHF1ZXVlICopLAo+ID4gKwl2b2lkICgqY2FsbGJhY2spKHN0cnVjdCB2aXJ0cXVldWUgKiks
Cj4gPiArCWNvbnN0IGNoYXIgKm5hbWUpCj4gPiArewo+ID4gKwlzdHJ1Y3QgdnJpbmdfdmlydHF1
ZXVlX3NwbGl0IHZyaW5nID0ge307Cj4gPiArCXN0cnVjdCB2aXJ0cXVldWUgKnZxOwo+ID4gKwlp
bnQgZXJyOwo+ID4gKwo+ID4gKwllcnIgPSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCgmdnJpbmcs
IHZkZXYsIG51bSwgdnJpbmdfYWxpZ24sCj4gPiArCQkJCSAgICAgIG1heV9yZWR1Y2VfbnVtKTsK
PiA+ICsJaWYgKGVycikKPiA+ICsJCXJldHVybiBOVUxMOwo+ID4KPiA+IC0JdnEgPSBfX3ZyaW5n
X25ld192aXJ0cXVldWUoaW5kZXgsIHZyaW5nLCB2ZGV2LCB3ZWFrX2JhcnJpZXJzLCBjb250ZXh0
LAo+ID4gLQkJCQkgICBub3RpZnksIGNhbGxiYWNrLCBuYW1lKTsKPiA+ICsJdnEgPSBfX3ZyaW5n
X25ld192aXJ0cXVldWUoaW5kZXgsIHZyaW5nLnZyaW5nLCB2ZGV2LCB3ZWFrX2JhcnJpZXJzLAo+
ID4gKwkJCQkgICBjb250ZXh0LCBub3RpZnksIGNhbGxiYWNrLCBuYW1lKTsKPiA+ICAgCWlmICgh
dnEpIHsKPiA+IC0JCXZyaW5nX2ZyZWVfcXVldWUodmRldiwgcXVldWVfc2l6ZV9pbl9ieXRlcywg
cXVldWUsCj4gPiAtCQkJCSBkbWFfYWRkcik7Cj4gPiArCQl2cmluZ19mcmVlX3NwbGl0KCZ2cmlu
ZywgdmRldik7Cj4gPiAgIAkJcmV0dXJuIE5VTEw7Cj4gPiAgIAl9Cj4gPgo+ID4gLQl0b192dnEo
dnEpLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9IGRtYV9hZGRyOwo+ID4gLQl0b192dnEodnEpLT5z
cGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gcXVldWVfc2l6ZV9pbl9ieXRlczsKPiA+ICsJdG9f
dnZxKHZxKS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSB2cmluZy5xdWV1ZV9kbWFfYWRkcjsKPgo+
Cj4gTml0OiBoYXZpbmcgdHdvIHF1ZXVlX2RtYV9hZGRyIHNlZW1zIHJlZHVuZGFudCAoc28gZGlk
IHF1ZXVlX3NpemVfaW5fYnl0ZXMpLgoKdHdvPwoKV2hlcmUgaXMgdGhlIHByb2JsZW0gSSBkb24n
dCB1bmRlcnN0YW5kPwoKVGhhbmtzLgoKPgo+IFRoYW5rcwo+Cj4KPiA+ICsJdG9fdnZxKHZxKS0+
c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IHZyaW5nLnF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4g
PiAgIAl0b192dnEodnEpLT53ZV9vd25fcmluZyA9IHRydWU7Cj4gPgo+ID4gICAJcmV0dXJuIHZx
Owo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
