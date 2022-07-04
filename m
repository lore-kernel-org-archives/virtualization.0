Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5046C43334
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 02:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40A8982640;
	Mon,  4 Jul 2022 02:04:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40A8982640
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PNlmkhHe9sjF; Mon,  4 Jul 2022 02:04:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8913B826C1;
	Mon,  4 Jul 2022 02:04:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8913B826C1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A5E2C0032;
	Mon,  4 Jul 2022 02:04:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 054DFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C026540128
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:04:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C026540128
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 28c1NkrR-wKR
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:04:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 14945400F3
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14945400F3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:04:48 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R981e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VIDpTgv_1656900279; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VIDpTgv_1656900279) by smtp.aliyun-inc.com;
 Mon, 04 Jul 2022 10:04:40 +0800
Message-ID: <1656900267.44917-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 09/40] virtio_ring: split: extract the logic of alloc
 state and extra
Date: Mon, 4 Jul 2022 10:04:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-10-xuanzhuo@linux.alibaba.com>
 <c4d24e5c-1a3e-e577-462e-c9ebde90d659@redhat.com>
In-Reply-To: <c4d24e5c-1a3e-e577-462e-c9ebde90d659@redhat.com>
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

T24gRnJpLCAxIEp1bCAyMDIyIDE2OjU1OjA1ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiBTZXBhcmF0ZSB0aGUgbG9naWMgb2YgY3JlYXRpbmcgZGVzY19zdGF0ZSwgZGVzY19l
eHRyYSwgYW5kIHN1YnNlcXVlbnQKPiA+IHBhdGNoZXMgd2lsbCBjYWxsIGl0IGluZGVwZW5kZW50
bHkuCj4gPgo+ID4gU2luY2Ugb25seSB0aGUgc3RydWN0dXJlIHZyaW5nIGlzIHBhc3NlZCBpbnRv
IF9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSgpLAo+ID4gd2hlbiBjcmVhdGluZyB0aGUgZnVuY3Rpb24g
dnJpbmdfYWxsb2Nfc3RhdGVfZXh0cmFfc3BsaXQoKSwgd2UgcHJlZmVyIHRvCj4gPiB1c2UgdnJp
bmdfdmlydHF1ZXVlX3NwbGl0IGFzIGEgcGFyYW1ldGVyLCBhbmQgaXQgd2lsbCBiZSBtb3JlIGNv
bnZlbmllbnQKPiA+IHRvIHBhc3MgdnJpbmdfdmlydHF1ZXVlX3NwbGl0IHRvIHNvbWUgc3Vic2Vx
dWVudCBmdW5jdGlvbnMuCj4gPgo+ID4gU28gYSBuZXcgdnJpbmdfdmlydHF1ZXVlX3NwbGl0IHZh
cmlhYmxlIGlzIGFkZGVkIGluCj4gPiBfX3ZyaW5nX25ld192aXJ0cXVldWUoKS4KPiA+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4g
LS0tCj4gPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA1OCArKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlv
bnMoKyksIDE4IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gaW5kZXgg
YTljZWI5YzE2YzU0Li5jZWRkMzQwZDZkYjcgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4g
PiBAQCAtMjA0LDYgKzIwNCw3IEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ID4gICAjZW5k
aWYKPiA+ICAgfTsKPiA+Cj4gPiArc3RhdGljIHN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICp2cmlu
Z19hbGxvY19kZXNjX2V4dHJhKHVuc2lnbmVkIGludCBudW0pOwo+ID4KPiA+ICAgLyoKPiA+ICAg
ICogSGVscGVycy4KPiA+IEBAIC05MzksNiArOTQwLDMyIEBAIHN0YXRpYyB2b2lkICp2aXJ0cXVl
dWVfZGV0YWNoX3VudXNlZF9idWZfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ID4gICAJ
cmV0dXJuIE5VTEw7Cj4gPiAgIH0KPiA+Cj4gPiArc3RhdGljIGludCB2cmluZ19hbGxvY19zdGF0
ZV9leHRyYV9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlX3NwbGl0ICp2cmluZykKPiA+ICt7
Cj4gPiArCXN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0ICpzdGF0ZTsKPiA+ICsJc3RydWN0
IHZyaW5nX2Rlc2NfZXh0cmEgKmV4dHJhOwo+ID4gKwl1MzIgbnVtID0gdnJpbmctPnZyaW5nLm51
bTsKPiA+ICsKPiA+ICsJc3RhdGUgPSBrbWFsbG9jX2FycmF5KG51bSwgc2l6ZW9mKHN0cnVjdCB2
cmluZ19kZXNjX3N0YXRlX3NwbGl0KSwgR0ZQX0tFUk5FTCk7Cj4gPiArCWlmICghc3RhdGUpCj4g
PiArCQlnb3RvIGVycl9zdGF0ZTsKPiA+ICsKPiA+ICsJZXh0cmEgPSB2cmluZ19hbGxvY19kZXNj
X2V4dHJhKG51bSk7Cj4gPiArCWlmICghZXh0cmEpCj4gPiArCQlnb3RvIGVycl9leHRyYTsKPiA+
ICsKPiA+ICsJbWVtc2V0KHN0YXRlLCAwLCBudW0gKiBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2Nf
c3RhdGVfc3BsaXQpKTsKPiA+ICsKPiA+ICsJdnJpbmctPmRlc2Nfc3RhdGUgPSBzdGF0ZTsKPiA+
ICsJdnJpbmctPmRlc2NfZXh0cmEgPSBleHRyYTsKPiA+ICsJcmV0dXJuIDA7Cj4gPiArCj4gPiAr
ZXJyX2V4dHJhOgo+ID4gKwlrZnJlZShzdGF0ZSk7Cj4gPiArZXJyX3N0YXRlOgo+ID4gKwlyZXR1
cm4gLUVOT01FTTsKPiA+ICt9Cj4gPiArCj4gPiAgIHN0YXRpYyB2b2lkIHZyaW5nX2ZyZWVfc3Bs
aXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCAqdnJpbmcsCj4gPiAgIAkJCSAgICAgc3Ry
dWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiAgIHsKPiA+IEBAIC0yMjI0LDcgKzIyNTEsNyBA
QCBFWFBPUlRfU1lNQk9MX0dQTCh2cmluZ19pbnRlcnJ1cHQpOwo+ID4KPiA+ICAgLyogT25seSBh
dmFpbGFibGUgZm9yIHNwbGl0IHJpbmcgKi8KPiA+ICAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmlu
Z19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiA+IC0JCQkJCXN0cnVjdCB2cmlu
ZyB2cmluZywKPiA+ICsJCQkJCXN0cnVjdCB2cmluZyBfdnJpbmcsCj4gPiAgIAkJCQkJc3RydWN0
IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gPiAgIAkJCQkJYm9vbCB3ZWFrX2JhcnJpZXJzLAo+ID4g
ICAJCQkJCWJvb2wgY29udGV4dCwKPiA+IEBAIC0yMjMyLDcgKzIyNTksOSBAQCBzdHJ1Y3Qgdmly
dHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4gICAJ
CQkJCXZvaWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+ICAgCQkJCQljb25z
dCBjaGFyICpuYW1lKQo+ID4gICB7Cj4gPiArCXN0cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQg
dnJpbmcgPSB7fTsKPgo+Cj4gTml0OiB0byByZWR1Y2UgdGhlIGNoYW5nZS1zZXQsIGxldCdzIHVz
ZSB2cmluZ19zcGxpdCBoZXJlPwoKV2lsbCBmaXguCgpUaGFua3MuCgoKPgo+IE90aGVyIGxvb2tz
IGdvb2QuCj4KPiBUaGFua3MKPgo+Cj4gPiAgIAlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cTsK
PiA+ICsJaW50IGVycjsKPiA+Cj4gPiAgIAlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJ
UlRJT19GX1JJTkdfUEFDS0VEKSkKPiA+ICAgCQlyZXR1cm4gTlVMTDsKPiA+IEBAIC0yMjYxLDcg
KzIyOTAsNyBAQCBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWdu
ZWQgaW50IGluZGV4LAo+ID4gICAJdnEtPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0gMDsKPiA+ICAg
CXZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gMDsKPiA+Cj4gPiAtCXZxLT5zcGxpdC52
cmluZyA9IHZyaW5nOwo+ID4gKwl2cS0+c3BsaXQudnJpbmcgPSBfdnJpbmc7Cj4gPiAgIAl2cS0+
c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ID0gMDsKPiA+ICAgCXZxLT5zcGxpdC5hdmFpbF9pZHhf
c2hhZG93ID0gMDsKPiA+Cj4gPiBAQCAtMjI3MywzMCArMjMwMiwyMyBAQCBzdHJ1Y3QgdmlydHF1
ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4gICAJCQkJ
CXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cpOwo+ID4gICAJfQo+ID4KPiA+IC0JdnEtPnNw
bGl0LmRlc2Nfc3RhdGUgPSBrbWFsbG9jX2FycmF5KHZyaW5nLm51bSwKPiA+IC0JCQlzaXplb2Yo
c3RydWN0IHZyaW5nX2Rlc2Nfc3RhdGVfc3BsaXQpLCBHRlBfS0VSTkVMKTsKPiA+IC0JaWYgKCF2
cS0+c3BsaXQuZGVzY19zdGF0ZSkKPiA+IC0JCWdvdG8gZXJyX3N0YXRlOwo+ID4gKwl2cmluZy52
cmluZyA9IF92cmluZzsKPiA+Cj4gPiAtCXZxLT5zcGxpdC5kZXNjX2V4dHJhID0gdnJpbmdfYWxs
b2NfZGVzY19leHRyYSh2cmluZy5udW0pOwo+ID4gLQlpZiAoIXZxLT5zcGxpdC5kZXNjX2V4dHJh
KQo+ID4gLQkJZ290byBlcnJfZXh0cmE7Cj4gPiArCWVyciA9IHZyaW5nX2FsbG9jX3N0YXRlX2V4
dHJhX3NwbGl0KCZ2cmluZyk7Cj4gPiArCWlmIChlcnIpIHsKPiA+ICsJCWtmcmVlKHZxKTsKPiA+
ICsJCXJldHVybiBOVUxMOwo+ID4gKwl9Cj4gPgo+ID4gLQltZW1zZXQodnEtPnNwbGl0LmRlc2Nf
c3RhdGUsIDAsIHZyaW5nLm51bSAqCj4gPiAtCQkJc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0
YXRlX3NwbGl0KSk7Cj4gPiArCXZxLT5zcGxpdC5kZXNjX3N0YXRlID0gdnJpbmcuZGVzY19zdGF0
ZTsKPiA+ICsJdnEtPnNwbGl0LmRlc2NfZXh0cmEgPSB2cmluZy5kZXNjX2V4dHJhOwo+ID4KPiA+
IC0JdmlydHF1ZXVlX2luaXQodnEsIHZxLT5zcGxpdC52cmluZy5udW0pOwo+ID4gKwl2aXJ0cXVl
dWVfaW5pdCh2cSwgdnJpbmcudnJpbmcubnVtKTsKPiA+Cj4gPiAgIAlzcGluX2xvY2soJnZkZXYt
PnZxc19saXN0X2xvY2spOwo+ID4gICAJbGlzdF9hZGRfdGFpbCgmdnEtPnZxLmxpc3QsICZ2ZGV2
LT52cXMpOwo+ID4gICAJc3Bpbl91bmxvY2soJnZkZXYtPnZxc19saXN0X2xvY2spOwo+ID4gICAJ
cmV0dXJuICZ2cS0+dnE7Cj4gPiAtCj4gPiAtZXJyX2V4dHJhOgo+ID4gLQlrZnJlZSh2cS0+c3Bs
aXQuZGVzY19zdGF0ZSk7Cj4gPiAtZXJyX3N0YXRlOgo+ID4gLQlrZnJlZSh2cSk7Cj4gPiAtCXJl
dHVybiBOVUxMOwo+ID4gICB9Cj4gPiAgIEVYUE9SVF9TWU1CT0xfR1BMKF9fdnJpbmdfbmV3X3Zp
cnRxdWV1ZSk7Cj4gPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
