Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230E0C433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 08:15:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93756115B
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 08:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C93756115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8726D81801;
	Tue, 19 Oct 2021 08:15:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qAkAb1pvP8Cr; Tue, 19 Oct 2021 08:15:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DEE8581776;
	Tue, 19 Oct 2021 08:15:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B39E7C0011;
	Tue, 19 Oct 2021 08:15:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09016C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 879D64025D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:15:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iVJPt7xF3_Mg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:15:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86F7E404CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:15:12 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R671e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0UssiaTc_1634631308; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UssiaTc_1634631308) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 19 Oct 2021 16:15:08 +0800
MIME-Version: 1.0
message-id: <1634631199.0198228-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH] virtio: Introduce a new kick interface
 virtqueue_kick_try()
date: Tue, 19 Oct 2021 16:13:19 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <fdfca0e9-dd2c-13a2-39ed-b360f7bcb881@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCAzMSBNYXkgMjAyMSAxNDozNDoxNiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDDlMOaIDIwMjEvNS8xOSDDj8OCw47Dpzc6NDcsIFh1YW4g
Wmh1byDDkMK0wrXDgDoKPiA+IFVubGlrZSB2aXJ0cXVldWVfa2ljaygpLCB2aXJ0cXVldWVfa2lj
a190cnkoKSByZXR1cm5zIHRydWUgb25seSB3aGVuIHRoZQo+ID4ga2ljayBpcyBzdWNjZXNzZnVs
LiBJbiB2aXJ0aW8tbmV0LCB3ZSB3YW50IHRvIGNvdW50IHRoZSBudW1iZXIgb2Yga2lja3MuCj4g
PiBTbyB3ZSBuZWVkIGFuIGludGVyZmFjZSB0aGF0IGNhbiBwZXJjZWl2ZSB3aGV0aGVyIHRoZSBr
aWNrIGlzIGFjdHVhbGx5Cj4gPiBleGVjdXRlZC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+Cj4KPiBBY2tlZC1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCkhpLCB0aGlzIHBhdGNoIHNlZW1zIHRvIGhhdmUg
bm90IGJlZW4gbWVyZ2VkLCBpcyB0aGVyZSBzb21ldGhpbmcgd3Jvbmcgd2l0aCBtZT8KClRoYW5r
cy4KCj4KPiBUaGFua3MKPgo+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
ICAgICB8ICA4ICsrKystLS0tCj4gPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAy
MCArKysrKysrKysrKysrKysrKysrKwo+ID4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAg
IHwgIDIgKysKPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IGluZGV4IDliNmE0YTg3NWM1NS4uMTY3Njk3MDMw
Y2I2IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiArKysgYi9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IEBAIC02MTcsNyArNjE3LDcgQEAgc3RhdGljIGlu
dCB2aXJ0bmV0X3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiAgIAlyZXQgPSBu
eG1pdDsKPiA+Cj4gPiAgIAlpZiAoZmxhZ3MgJiBYRFBfWE1JVF9GTFVTSCkgewo+ID4gLQkJaWYg
KHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUoc3EtPnZxKSAmJiB2aXJ0cXVldWVfbm90aWZ5KHNxLT52
cSkpCj4gPiArCQlpZiAodmlydHF1ZXVlX2tpY2tfdHJ5KHNxLT52cSkpCj4gPiAgIAkJCWtpY2tz
ID0gMTsKPiA+ICAgCX0KPiA+ICAgb3V0Ogo+ID4gQEAgLTEzMjUsNyArMTMyNSw3IEBAIHN0YXRp
YyBib29sIHRyeV9maWxsX3JlY3Yoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCByZWNl
aXZlX3F1ZXVlICpycSwKPiA+ICAgCQlpZiAoZXJyKQo+ID4gICAJCQlicmVhazsKPiA+ICAgCX0g
d2hpbGUgKHJxLT52cS0+bnVtX2ZyZWUpOwo+ID4gLQlpZiAodmlydHF1ZXVlX2tpY2tfcHJlcGFy
ZShycS0+dnEpICYmIHZpcnRxdWV1ZV9ub3RpZnkocnEtPnZxKSkgewo+ID4gKwlpZiAodmlydHF1
ZXVlX2tpY2tfdHJ5KHJxLT52cSkpIHsKPiA+ICAgCQl1bnNpZ25lZCBsb25nIGZsYWdzOwo+ID4K
PiA+ICAgCQlmbGFncyA9IHU2NF9zdGF0c191cGRhdGVfYmVnaW5faXJxc2F2ZSgmcnEtPnN0YXRz
LnN5bmNwKTsKPiA+IEBAIC0xNTMzLDcgKzE1MzMsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9s
bChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4gPgo+ID4gICAJaWYgKHhk
cF94bWl0ICYgVklSVElPX1hEUF9UWCkgewo+ID4gICAJCXNxID0gdmlydG5ldF94ZHBfZ2V0X3Nx
KHZpKTsKPiA+IC0JCWlmICh2aXJ0cXVldWVfa2lja19wcmVwYXJlKHNxLT52cSkgJiYgdmlydHF1
ZXVlX25vdGlmeShzcS0+dnEpKSB7Cj4gPiArCQlpZiAodmlydHF1ZXVlX2tpY2tfdHJ5KHNxLT52
cSkpIHsKPiA+ICAgCQkJdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbigmc3EtPnN0YXRzLnN5bmNwKTsK
PiA+ICAgCQkJc3EtPnN0YXRzLmtpY2tzKys7Cj4gPiAgIAkJCXU2NF9zdGF0c191cGRhdGVfZW5k
KCZzcS0+c3RhdHMuc3luY3ApOwo+ID4gQEAgLTE3MTAsNyArMTcxMCw3IEBAIHN0YXRpYyBuZXRk
ZXZfdHhfdCBzdGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYpCj4gPiAgIAl9Cj4gPgo+ID4gICAJaWYgKGtpY2sgfHwgbmV0aWZfeG1pdF9zdG9wcGVk
KHR4cSkpIHsKPiA+IC0JCWlmICh2aXJ0cXVldWVfa2lja19wcmVwYXJlKHNxLT52cSkgJiYgdmly
dHF1ZXVlX25vdGlmeShzcS0+dnEpKSB7Cj4gPiArCQlpZiAodmlydHF1ZXVlX2tpY2tfdHJ5KHNx
LT52cSkpIHsKPiA+ICAgCQkJdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbigmc3EtPnN0YXRzLnN5bmNw
KTsKPiA+ICAgCQkJc3EtPnN0YXRzLmtpY2tzKys7Cj4gPiAgIAkJCXU2NF9zdGF0c191cGRhdGVf
ZW5kKCZzcS0+c3RhdHMuc3luY3ApOwo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBpbmRleCA3MWUx
NmI1M2U5YzEuLjE0NjJiZTc1Njg3NSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMKPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBA
IC0xODc0LDYgKzE4NzQsMjYgQEAgYm9vbCB2aXJ0cXVldWVfa2ljayhzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSkKPiA+ICAgfQo+ID4gICBFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfa2ljayk7Cj4g
Pgo+ID4gKy8qKgo+ID4gKyAqIHZpcnRxdWV1ZV9raWNrX3RyeSAtIHRyeSB1cGRhdGUgYWZ0ZXIg
YWRkX2J1Zgo+ID4gKyAqIEB2cTogdGhlIHN0cnVjdCB2aXJ0cXVldWUKPiA+ICsgKgo+ID4gKyAq
IEFmdGVyIG9uZSBvciBtb3JlIHZpcnRxdWV1ZV9hZGRfKiBjYWxscywgaW52b2tlIHRoaXMgdG8g
a2ljawo+ID4gKyAqIHRoZSBvdGhlciBzaWRlLgo+ID4gKyAqCj4gPiArICogQ2FsbGVyIG11c3Qg
ZW5zdXJlIHdlIGRvbid0IGNhbGwgdGhpcyB3aXRoIG90aGVyIHZpcnRxdWV1ZQo+ID4gKyAqIG9w
ZXJhdGlvbnMgYXQgdGhlIHNhbWUgdGltZSAoZXhjZXB0IHdoZXJlIG5vdGVkKS4KPiA+ICsgKgo+
ID4gKyAqIFJldHVybnMgdHJ1ZSBpZiBraWNrIHN1Y2Nlc3MsIG90aGVyd2lzZSBmYWxzZS4KPiA+
ICsgKi8KPiA+ICtib29sIHZpcnRxdWV1ZV9raWNrX3RyeShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkK
PiA+ICt7Cj4gPiArCWlmICh2aXJ0cXVldWVfa2lja19wcmVwYXJlKHZxKSAmJiB2aXJ0cXVldWVf
bm90aWZ5KHZxKSkKPiA+ICsJCXJldHVybiB0cnVlOwo+ID4gKwlyZXR1cm4gZmFsc2U7Cj4gPiAr
fQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9raWNrX3RyeSk7Cj4gPiArCj4gPiAg
IC8qKgo+ID4gICAgKiB2aXJ0cXVldWVfZ2V0X2J1ZiAtIGdldCB0aGUgbmV4dCB1c2VkIGJ1ZmZl
cgo+ID4gICAgKiBAX3ZxOiB0aGUgc3RydWN0IHZpcnRxdWV1ZSB3ZSdyZSB0YWxraW5nIGFib3V0
Lgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9pbmNsdWRlL2xpbnV4
L3ZpcnRpby5oCj4gPiBpbmRleCBiMTg5NGUwMzIzZmEuLjQ1Y2Q2YTBhZjI0ZCAxMDA2NDQKPiA+
IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmly
dGlvLmgKPiA+IEBAIC01OSw2ICs1OSw4IEBAIGludCB2aXJ0cXVldWVfYWRkX3NncyhzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSwKPiA+Cj4gPiAgIGJvb2wgdmlydHF1ZXVlX2tpY2soc3RydWN0IHZpcnRx
dWV1ZSAqdnEpOwo+ID4KPiA+ICtib29sIHZpcnRxdWV1ZV9raWNrX3RyeShzdHJ1Y3QgdmlydHF1
ZXVlICp2cSk7Cj4gPiArCj4gPiAgIGJvb2wgdmlydHF1ZXVlX2tpY2tfcHJlcGFyZShzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSk7Cj4gPgo+ID4gICBib29sIHZpcnRxdWV1ZV9ub3RpZnkoc3RydWN0IHZp
cnRxdWV1ZSAqdnEpOwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
