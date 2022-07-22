Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09B5C43334
	for <virtualization@archiver.kernel.org>; Fri, 22 Jul 2022 03:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32CB841507;
	Fri, 22 Jul 2022 03:57:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32CB841507
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gomlwWEwDX9Z; Fri, 22 Jul 2022 03:57:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4C7AA403C7;
	Fri, 22 Jul 2022 03:57:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C7AA403C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A75AC0033;
	Fri, 22 Jul 2022 03:57:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7AECC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 03:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B95C683F70
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 03:57:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B95C683F70
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5qehKBau9JRp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 03:57:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E200083F65
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E200083F65
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 03:57:53 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=36; SR=0; TI=SMTPD_---0VK3SFm4_1658462266; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VK3SFm4_1658462266) by smtp.aliyun-inc.com;
 Fri, 22 Jul 2022 11:57:47 +0800
Message-ID: <1658461678.632858-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v12 08/40] virtio_ring: split: extract the logic of alloc
 queue
Date: Fri, 22 Jul 2022 11:47:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-9-xuanzhuo@linux.alibaba.com>
 <0b3c985d-d479-a554-4fe2-bfe94fc74070@redhat.com>
In-Reply-To: <0b3c985d-d479-a554-4fe2-bfe94fc74070@redhat.com>
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

T24gVGh1LCAyMSBKdWwgMjAyMiAxNzoxMzo0OSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi83LzIwIDExOjA0LCBYdWFuIFpodW8g5YaZ
6YGTOgo+ID4gU2VwYXJhdGUgdGhlIGxvZ2ljIG9mIHNwbGl0IHRvIGNyZWF0ZSB2cmluZyBxdWV1
ZS4KPiA+Cj4gPiBUaGlzIGZlYXR1cmUgaXMgcmVxdWlyZWQgZm9yIHN1YnNlcXVlbnQgdmlydHVx
dWV1ZSByZXNldCB2cmluZy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56
aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgfCA2OCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQo+ID4KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+ID4gaW5kZXggYzk0YzU0NjFlNzAyLi5jNzk3MTQzOGJiMmMgMTAw
NjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBAQCAtOTUwLDI4ICs5NTAsMTkgQEAgc3RhdGlj
IHZvaWQgdnJpbmdfZnJlZV9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlX3NwbGl0ICp2cmlu
Z19zcGxpdCwKPiA+ICAgCWtmcmVlKHZyaW5nX3NwbGl0LT5kZXNjX2V4dHJhKTsKPiA+ICAgfQo+
ID4KPiA+IC1zdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9z
cGxpdCgKPiA+IC0JdW5zaWduZWQgaW50IGluZGV4LAo+ID4gLQl1bnNpZ25lZCBpbnQgbnVtLAo+
ID4gLQl1bnNpZ25lZCBpbnQgdnJpbmdfYWxpZ24sCj4gPiAtCXN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2LAo+ID4gLQlib29sIHdlYWtfYmFycmllcnMsCj4gPiAtCWJvb2wgbWF5X3JlZHVjZV9u
dW0sCj4gPiAtCWJvb2wgY29udGV4dCwKPiA+IC0JYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRx
dWV1ZSAqKSwKPiA+IC0Jdm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4g
LQljb25zdCBjaGFyICpuYW1lKQo+ID4gK3N0YXRpYyBpbnQgdnJpbmdfYWxsb2NfcXVldWVfc3Bs
aXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCAqdnJpbmdfc3BsaXQsCj4gPiArCQkJCSAg
IHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4gKwkJCQkgICB1MzIgbnVtLAo+ID4gKwkJ
CQkgICB1bnNpZ25lZCBpbnQgdnJpbmdfYWxpZ24sCj4gPiArCQkJCSAgIGJvb2wgbWF5X3JlZHVj
ZV9udW0pCj4gPiAgIHsKPiA+IC0Jc3RydWN0IHZpcnRxdWV1ZSAqdnE7Cj4gPiAgIAl2b2lkICpx
dWV1ZSA9IE5VTEw7Cj4gPiAgIAlkbWFfYWRkcl90IGRtYV9hZGRyOwo+ID4gLQlzaXplX3QgcXVl
dWVfc2l6ZV9pbl9ieXRlczsKPiA+IC0Jc3RydWN0IHZyaW5nIHZyaW5nOwo+ID4KPiA+ICAgCS8q
IFdlIGFzc3VtZSBudW0gaXMgYSBwb3dlciBvZiAyLiAqLwo+ID4gICAJaWYgKG51bSAmIChudW0g
LSAxKSkgewo+ID4gICAJCWRldl93YXJuKCZ2ZGV2LT5kZXYsICJCYWQgdmlydHF1ZXVlIGxlbmd0
aCAldVxuIiwgbnVtKTsKPiA+IC0JCXJldHVybiBOVUxMOwo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7
Cj4gPiAgIAl9Cj4gPgo+ID4gICAJLyogVE9ETzogYWxsb2NhdGUgZWFjaCBxdWV1ZSBjaHVuayBp
bmRpdmlkdWFsbHkgKi8KPiA+IEBAIC05ODIsMTEgKzk3MywxMSBAQCBzdGF0aWMgc3RydWN0IHZp
cnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+ICAgCQlpZiAocXVldWUp
Cj4gPiAgIAkJCWJyZWFrOwo+ID4gICAJCWlmICghbWF5X3JlZHVjZV9udW0pCj4gPiAtCQkJcmV0
dXJuIE5VTEw7Cj4gPiArCQkJcmV0dXJuIC1FTk9NRU07Cj4gPiAgIAl9Cj4gPgo+ID4gICAJaWYg
KCFudW0pCj4gPiAtCQlyZXR1cm4gTlVMTDsKPiA+ICsJCXJldHVybiAtRU5PTUVNOwo+ID4KPiA+
ICAgCWlmICghcXVldWUpIHsKPiA+ICAgCQkvKiBUcnkgdG8gZ2V0IGEgc2luZ2xlIHBhZ2UuIFlv
dSBhcmUgbXkgb25seSBob3BlISAqLwo+ID4gQEAgLTk5NCwyMSArOTg1LDQ2IEBAIHN0YXRpYyBz
dHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ID4gICAJCQkJ
CSAgJmRtYV9hZGRyLCBHRlBfS0VSTkVMfF9fR0ZQX1pFUk8pOwo+ID4gICAJfQo+ID4gICAJaWYg
KCFxdWV1ZSkKPiA+IC0JCXJldHVybiBOVUxMOwo+ID4gKwkJcmV0dXJuIC1FTk9NRU07Cj4gPiAr
Cj4gPiArCXZyaW5nX2luaXQoJnZyaW5nX3NwbGl0LT52cmluZywgbnVtLCBxdWV1ZSwgdnJpbmdf
YWxpZ24pOwo+ID4KPiA+IC0JcXVldWVfc2l6ZV9pbl9ieXRlcyA9IHZyaW5nX3NpemUobnVtLCB2
cmluZ19hbGlnbik7Cj4gPiAtCXZyaW5nX2luaXQoJnZyaW5nLCBudW0sIHF1ZXVlLCB2cmluZ19h
bGlnbik7Cj4gPiArCXZyaW5nX3NwbGl0LT5xdWV1ZV9kbWFfYWRkciA9IGRtYV9hZGRyOwo+ID4g
Kwl2cmluZ19zcGxpdC0+cXVldWVfc2l6ZV9pbl9ieXRlcyA9IHZyaW5nX3NpemUobnVtLCB2cmlu
Z19hbGlnbik7Cj4gPiArCj4gPiArCXJldHVybiAwOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMg
c3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+ICsJdW5z
aWduZWQgaW50IGluZGV4LAo+ID4gKwl1bnNpZ25lZCBpbnQgbnVtLAo+ID4gKwl1bnNpZ25lZCBp
bnQgdnJpbmdfYWxpZ24sCj4gPiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4gKwli
b29sIHdlYWtfYmFycmllcnMsCj4gPiArCWJvb2wgbWF5X3JlZHVjZV9udW0sCj4gPiArCWJvb2wg
Y29udGV4dCwKPiA+ICsJYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+ICsJ
dm9pZCAoKmNhbGxiYWNrKShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4gKwljb25zdCBjaGFyICpu
YW1lKQo+ID4gK3sKPiA+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB2cmluZ19zcGxp
dCA9IHt9Owo+ID4gKwlzdHJ1Y3QgdmlydHF1ZXVlICp2cTsKPiA+ICsJaW50IGVycjsKPiA+ICsK
PiA+ICsJZXJyID0gdnJpbmdfYWxsb2NfcXVldWVfc3BsaXQoJnZyaW5nX3NwbGl0LCB2ZGV2LCBu
dW0sIHZyaW5nX2FsaWduLAo+ID4gKwkJCQkgICAgICBtYXlfcmVkdWNlX251bSk7Cj4gPiArCWlm
IChlcnIpCj4gPiArCQlyZXR1cm4gTlVMTDsKPiA+Cj4gPiAtCXZxID0gX192cmluZ19uZXdfdmly
dHF1ZXVlKGluZGV4LCB2cmluZywgdmRldiwgd2Vha19iYXJyaWVycywgY29udGV4dCwKPiA+IC0J
CQkJICAgbm90aWZ5LCBjYWxsYmFjaywgbmFtZSk7Cj4gPiArCXZxID0gX192cmluZ19uZXdfdmly
dHF1ZXVlKGluZGV4LCB2cmluZ19zcGxpdC52cmluZywgdmRldiwgd2Vha19iYXJyaWVycywKPiA+
ICsJCQkJICAgY29udGV4dCwgbm90aWZ5LCBjYWxsYmFjaywgbmFtZSk7Cj4gPiAgIAlpZiAoIXZx
KSB7Cj4gPiAtCQl2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHF1ZXVlX3NpemVfaW5fYnl0ZXMsIHF1
ZXVlLAo+ID4gLQkJCQkgZG1hX2FkZHIpOwo+ID4gKwkJdnJpbmdfZnJlZV9zcGxpdCgmdnJpbmdf
c3BsaXQsIHZkZXYpOwo+ID4gICAJCXJldHVybiBOVUxMOwo+ID4gICAJfQo+ID4KPiA+IC0JdG9f
dnZxKHZxKS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSBkbWFfYWRkcjsKPiA+IC0JdG9fdnZxKHZx
KS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IHF1ZXVlX3NpemVfaW5fYnl0ZXM7Cj4gPiAr
CXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0gdnJpbmdfc3BsaXQucXVldWVfZG1h
X2FkZHI7Cj4gPiArCXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSB2cmlu
Z19zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzOwo+Cj4KPiBUaGlzIHN0aWxsIHNlZW1zIGEgbGl0
dGxlIGJpdCByZWR1bmRhbnQgc2luY2UgdGhlIGN1cnJlbnQgbG9naWMgaXMgYQo+IGxpdHRsZSBi
aXQgY29tcGxpY2F0ZWQgc2luY2UgdGhlIHZxLT5zcGxpdCBpcyBub3QgaW5pdGlhbGl6ZWQgaW4g
YQo+IHNpbmdsZSBwbGFjZS4KPgo+IEkgd29uZGVyIGlmIGl0J3MgYmV0dGVyIHRvOgo+Cj4gdnJp
bmdfYWxsb2NfcXVldWVfc3BsaXQoKQo+IHZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEoKSAocmVvcmRl
ciB0byBtYWtlIHBhdGNoIDkgY29tZSBmaXJzdCkKPgo+IHRoZW4gd2UgY2FuIHNpbXBseSBhc3Np
Z24gdnJpbmdfc3BsaXQgdG8gdnEtPnNwbGl0IGluCj4gX192cmluZ19uZXdfdmlydHF1ZXVlKCkg
c2luY2UgaXQgaGFzOgo+Cj4gIMKgwqDCoCB2cS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSAwOwo+
ICDCoMKgIMKgdnEtPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSAwOwo+Cj4gIMKgwqDCoCB2
cS0+c3BsaXQudnJpbmcgPSB2cmluZzsKPiAgwqDCoMKgIHZxLT5zcGxpdC5hdmFpbF9mbGFnc19z
aGFkb3cgPSAwOwo+ICDCoMKgwqAgdnEtPnNwbGl0LmF2YWlsX2lkeF9zaGFkb3cgPSAwOwo+Cj4g
VGhpcyBzZWVtcyB0byBzaW1wbGlmeSB0aGUgbG9naWMgYW5kIHRhc2sgb2YgZS5nCj4gdmlydHF1
ZXVlX3ZyaW5nX2F0dGFjaF9zcGxpdCgpIHRvIGEgc2ltcGxlOgo+Cj4gdnEtPnNwbGl0PSB2cmlu
Z19zcGxpdDsKClRoaXMgZG9lcyBsb29rIHNpbXBsZXIuIFRoZSByZWFzb24gZm9yIG5vdCBkb2lu
ZyB0aGlzIGlzIHRoYXQgdGhlIGFyZ3VtZW50CmFjY2VwdGVkIGJ5IF9fdnJpbmdfbmV3X3ZpcnRx
dWV1ZSgpIGlzICJzdHJ1Y3QgdnJpbmciLCBhbmQKX192cmluZ19uZXdfdmlydHF1ZXVlKCkgaXMg
YW4gZXhwb3J0IHN5bWJvbC4KCkkgdG9vayBhIGxvb2ssIGFuZCB0aGUgb25seSBleHRlcm5hbCBk
aXJlY3QgY2FsbCB0byBfX3ZyaW5nX25ld192aXJ0cXVldWUgaXMKaGVyZS4KCgl0b29scy92aXJ0
aW8vdmlydGlvX3Rlc3QuYwoJc3RhdGljIHZvaWQgdnFfcmVzZXQoc3RydWN0IHZxX2luZm8gKmlu
Zm8sIGludCBudW0sIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQoJewoJCWlmIChpbmZvLT52
cSkKCQkJdnJpbmdfZGVsX3ZpcnRxdWV1ZShpbmZvLT52cSk7CgoJCW1lbXNldChpbmZvLT5yaW5n
LCAwLCB2cmluZ19zaXplKG51bSwgNDA5NikpOwoJCXZyaW5nX2luaXQoJmluZm8tPnZyaW5nLCBu
dW0sIGluZm8tPnJpbmcsIDQwOTYpOwoJCWluZm8tPnZxID0gX192cmluZ19uZXdfdmlydHF1ZXVl
KGluZm8tPmlkeCwgaW5mby0+dnJpbmcsIHZkZXYsIHRydWUsCgkJCQkJCSBmYWxzZSwgdnFfbm90
aWZ5LCB2cV9jYWxsYmFjaywgInRlc3QiKTsKCQlhc3NlcnQoaW5mby0+dnEpOwoJCWluZm8tPnZx
LT5wcml2ID0gaW5mbzsKCX0KCkkgdGhpbmsgdGhpcyBjb3VsZCBiZSByZXBsYWNlZCB3aXRoIHZy
aW5nX25ld192aXJ0cXVldWUoKSBzbyB0aGF0IHdlIGRvbid0IG5lZWQKdG8gbWFrZSBfX3ZyaW5n
X25ld192aXJ0cXVldWUgYXMgYW4gZXhwb3J0IGZ1bmN0aW9uIHNvIHdlIGNhbiBtYWtlIHNvbWUK
bW9kaWZpY2F0aW9ucyB0byBpdC4KCm5pdDogdnJpbmdfYWxsb2NfZGVzY19leHRyYSgpIHNob3Vs
ZCBub3QgaGF2ZSB0byBiZSBleHRyYWN0IGZyb20KX192cmluZ19uZXdfdmlydHF1ZXVlKCkgLgoK
VGhhbmtzLgoKPgo+IEFuZCBpZiB0aGlzIG1ha2VzIHNlbnNlLCB3ZSBjYW4gZG8gc29tZXRoaW5n
IHNpbWlsYXIgdG8gcGFja2VkIHJpbmcuCj4KPiBUaGFua3MKPgo+Cj4gPiAgIAl0b192dnEodnEp
LT53ZV9vd25fcmluZyA9IHRydWU7Cj4gPgo+ID4gICAJcmV0dXJuIHZxOwo+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
