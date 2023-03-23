Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F97C6FD1F
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 01:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C32794032F;
	Thu, 23 Mar 2023 01:43:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C32794032F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IoO9kL5Mhzdp; Thu, 23 Mar 2023 01:43:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DA921402F4;
	Thu, 23 Mar 2023 01:43:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA921402F4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC3EDC0035;
	Thu, 23 Mar 2023 01:43:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93C4BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 01:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 669454032C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 01:43:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 669454032C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YtAidYB8FLai
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 01:43:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05D5E402F4
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05D5E402F4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 01:43:17 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R481e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VeSP1eG_1679535791; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeSP1eG_1679535791) by smtp.aliyun-inc.com;
 Thu, 23 Mar 2023 09:43:12 +0800
Message-ID: <1679535365.5410192-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 1/8] virtio_net: mergeable xdp: put old page
 immediately
Date: Thu, 23 Mar 2023 09:36:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230322030308.16046-2-xuanzhuo@linux.alibaba.com>
 <4bd07874-b1ad-336b-b15e-ba56a10182e9@huawei.com>
In-Reply-To: <4bd07874-b1ad-336b-b15e-ba56a10182e9@huawei.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

T24gV2VkLCAyMiBNYXIgMjAyMyAxNjoyMjoxOCArMDgwMCwgWXVuc2hlbmcgTGluIDxsaW55dW5z
aGVuZ0BodWF3ZWkuY29tPiB3cm90ZToKPiBPbiAyMDIzLzMvMjIgMTE6MDMsIFh1YW4gWmh1byB3
cm90ZToKPiA+IEluIHRoZSB4ZHAgaW1wbGVtZW50YXRpb24gb2YgdmlydGlvLW5ldCBtZXJnZWFi
bGUsIGl0IGFsd2F5cyBjaGVja3MKPiA+IHdoZXRoZXIgdHdvIHBhZ2UgaXMgdXNlZCBhbmQgYSBw
YWdlIGlzIHNlbGVjdGVkIHRvIHJlbGVhc2UuIFRoaXMgaXMKPiA+IGNvbXBsaWNhdGVkIGZvciB0
aGUgcHJvY2Vzc2luZyBvZiBhY3Rpb24sIGFuZCBiZSBjYXJlZnVsLgo+ID4KPiA+IEluIHRoZSBl
bnRpcmUgcHJvY2Vzcywgd2UgaGF2ZSBzdWNoIHByaW5jaXBsZXM6Cj4gPiAqIElmIHhkcF9wYWdl
IGlzIHVzZWQgKFBBU1MsIFRYLCBSZWRpcmVjdCksIHRoZW4gd2UgcmVsZWFzZSB0aGUgb2xkCj4g
PiAgIHBhZ2UuCj4gPiAqIElmIGl0IGlzIGEgZHJvcCBjYXNlLCB3ZSB3aWxsIHJlbGVhc2UgdHdv
LiBUaGUgb2xkIHBhZ2Ugb2J0YWluZWQgZnJvbQo+ID4gICBidWYgaXMgcmVsZWFzZSBpbnNpZGUg
ZXJyX3hkcCwgYW5kIHhkcF9wYWdlIG5lZWRzIGJlIHJlbGFzZWQgYnkgdXMuCj4gPgo+ID4gQnV0
IGluIGZhY3QsIHdoZW4gd2UgYWxsb2NhdGUgYSBuZXcgcGFnZSwgd2UgY2FuIHJlbGVhc2UgdGhl
IG9sZCBwYWdlCj4gPiBpbW1lZGlhdGVseS4gVGhlbiBqdXN0IG9uZSBpcyB1c2luZywgd2UganVz
dCBuZWVkIHRvIHJlbGVhc2UgdGhlIG5ldwo+ID4gcGFnZSBmb3IgZHJvcCBjYXNlLiBPbiB0aGUg
ZHJvcCBwYXRoLCBlcnJfeGRwIHdpbGwgcmVsZWFzZSB0aGUgdmFyaWFibGUKPiA+ICJwYWdlIiwg
c28gd2Ugb25seSBuZWVkIHRvIGxldCAicGFnZSIgcG9pbnQgdG8gdGhlIG5ldyB4ZHBfcGFnZSBp
bgo+ID4gYWR2YW5jZS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVv
QGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IHwgMTUgKysrKysrLS0tLS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBpbmRleCBlMjU2MGI2Zjc5ODAu
LjRkMmJmMWNlMDczMCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+
ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBAQCAtMTI0NSw2ICsxMjQ1LDkg
QEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2LAo+ID4gIAkJCWlmICgheGRwX3BhZ2UpCj4gPiAgCQkJCWdvdG8gZXJyX3hkcDsK
PiA+ICAJCQlvZmZzZXQgPSBWSVJUSU9fWERQX0hFQURST09NOwo+ID4gKwo+ID4gKwkJCXB1dF9w
YWdlKHBhZ2UpOwo+Cj4gdGhlIGVycm9yIGhhbmRsaW5nIG9mIHhkcF9saW5lYXJpemVfcGFnZSgp
IGRvZXMgbm90IHNlZW1zIHNlbGYgY29udGFpbmVkLgo+IERvZXMgaXQgbm90IHNlZW0gYmV0dGVy
77yaCj4gMS4gaWYgeGRwX2xpbmVhcml6ZV9wYWdlKCkgc3VjY2VzZWQsIGNhbGwgcHV0X3BhZ2Uo
KSBmb3IgZmlyc3QgYnVmZmVyIGp1c3QKPiAgICBhcyBwdXRfcGFnZSgpIGlzIGNhbGwgZm9yIG90
aGVyIGJ1ZmZlcgo+IDIuIG9yIGNhbGwgdmlydHF1ZXVlX2dldF9idWYoKSBhbmQgcHV0X3BhZ2Uo
KSBmb3IgYWxsIHRoZSBidWZmZXIgb2YgdGhlIHBhY2tldAo+ICAgIHNvIHRoZSBlcnJvciBoYW5k
bGluZyBpcyBub3QgbmVlZGVkIG91dHNpZGUgdGhlIHZpcnRxdWV1ZV9nZXRfYnVmKCkuCj4KPiBJ
biB0aGF0IGNhc2UsIGl0IHNlZW1zIHdlIGNhbiBqdXN0IGRvIGJlbG93IHdpdGhvdXQgeGRwX3Bh
Z2U6Cj4gcGFnZSA9IHhkcF9saW5lYXJpemVfcGFnZShycSwgbnVtX2J1ZiwgcGFnZSwgLi4uKTsK
CgpUaGlzIGRvZXMgbG9vayBiZXR0ZXIuCgpJbiBmYWN0LCB3ZSBhbHJlYWR5IGhhdmUgdnEgcmVz
ZXQsIHdlIGNhbiBsb2FkIFhEUCBiYXNlZCBvbiB2cSByZXNldC4KSW4gdGhpcyB3YXksIHdlIGNh
biBydW4gd2l0aG91dCB4ZHBfbGluZWFyaXplX3BhZ2UuCgoKPgo+Cj4gPiArCQkJcGFnZSA9IHhk
cF9wYWdlOwo+ID4gIAkJfSBlbHNlIGlmICh1bmxpa2VseShoZWFkcm9vbSA8IHZpcnRuZXRfZ2V0
X2hlYWRyb29tKHZpKSkpIHsKPiA+ICAJCQl4ZHBfcm9vbSA9IFNLQl9EQVRBX0FMSUdOKFZJUlRJ
T19YRFBfSEVBRFJPT00gKwo+ID4gIAkJCQkJCSAgc2l6ZW9mKHN0cnVjdCBza2Jfc2hhcmVkX2lu
Zm8pKTsKPiA+IEBAIC0xMjU5LDYgKzEyNjIsOSBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJl
Y2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiAgCQkJICAgICAgIHBh
Z2VfYWRkcmVzcyhwYWdlKSArIG9mZnNldCwgbGVuKTsKPiA+ICAJCQlmcmFtZV9zeiA9IFBBR0Vf
U0laRTsKPiA+ICAJCQlvZmZzZXQgPSBWSVJUSU9fWERQX0hFQURST09NOwo+ID4gKwo+ID4gKwkJ
CXB1dF9wYWdlKHBhZ2UpOwo+ID4gKwkJCXBhZ2UgPSB4ZHBfcGFnZTsKPgo+IEl0IHNlZW1zIHdl
IGNhbiBsaW1pdCB0aGUgc2NvcGUgb2YgeGRwX3BhZ2UgaW4gdGhpcyAiZWxzZSBpZiIgYmxvY2su
Cj4KPiA+ICAJCX0gZWxzZSB7Cj4gPiAgCQkJeGRwX3BhZ2UgPSBwYWdlOwo+ID4gIAkJfQo+Cj4g
SXQgc2VlbXMgdGhlIGFib3ZlIGVsc2UgYmxvY2sgaXMgbm90IG5lZWRlZCBhbnltb3JlLgoKWWVz
LCB0aGUgZm9sbG93LXVwIHBhdGNoIGhhcyB0aGlzIG9wdGltaXphdGlvbi4KCgo+Cj4gPiBAQCAt
MTI3OCw4ICsxMjg0LDYgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJs
ZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gIAkJCWlmICh1bmxpa2VseSghaGVhZF9za2Ip
KQo+ID4gIAkJCQlnb3RvIGVycl94ZHBfZnJhZ3M7Cj4gPgo+ID4gLQkJCWlmICh1bmxpa2VseSh4
ZHBfcGFnZSAhPSBwYWdlKSkKPiA+IC0JCQkJcHV0X3BhZ2UocGFnZSk7Cj4gPiAgCQkJcmN1X3Jl
YWRfdW5sb2NrKCk7Cj4gPiAgCQkJcmV0dXJuIGhlYWRfc2tiOwo+ID4gIAkJY2FzZSBYRFBfVFg6
Cj4gPiBAQCAtMTI5Nyw4ICsxMzAxLDYgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZl
X21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gIAkJCQlnb3RvIGVycl94ZHBf
ZnJhZ3M7Cj4gPiAgCQkJfQo+ID4gIAkJCSp4ZHBfeG1pdCB8PSBWSVJUSU9fWERQX1RYOwo+ID4g
LQkJCWlmICh1bmxpa2VseSh4ZHBfcGFnZSAhPSBwYWdlKSkKPiA+IC0JCQkJcHV0X3BhZ2UocGFn
ZSk7Cj4gPiAgCQkJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gPiAgCQkJZ290byB4ZHBfeG1pdDsKPiA+
ICAJCWNhc2UgWERQX1JFRElSRUNUOgo+ID4gQEAgLTEzMDcsOCArMTMwOSw2IEBAIHN0YXRpYyBz
dHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwK
PiA+ICAJCQlpZiAoZXJyKQo+ID4gIAkJCQlnb3RvIGVycl94ZHBfZnJhZ3M7Cj4gPiAgCQkJKnhk
cF94bWl0IHw9IFZJUlRJT19YRFBfUkVESVI7Cj4gPiAtCQkJaWYgKHVubGlrZWx5KHhkcF9wYWdl
ICE9IHBhZ2UpKQo+ID4gLQkJCQlwdXRfcGFnZShwYWdlKTsKPiA+ICAJCQlyY3VfcmVhZF91bmxv
Y2soKTsKPiA+ICAJCQlnb3RvIHhkcF94bWl0Owo+ID4gIAkJZGVmYXVsdDoKPiA+IEBAIC0xMzIx
LDkgKzEzMjEsNiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0
cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiAgCQkJZ290byBlcnJfeGRwX2ZyYWdzOwo+ID4gIAkJ
fQo+ID4gIGVycl94ZHBfZnJhZ3M6Cj4gPiAtCQlpZiAodW5saWtlbHkoeGRwX3BhZ2UgIT0gcGFn
ZSkpCj4gPiAtCQkJX19mcmVlX3BhZ2VzKHhkcF9wYWdlLCAwKTsKPgo+IEl0IHNlZW1zIF9fZnJl
ZV9wYWdlcygpIGFuZCBwdXRfcGFnZSgpIGlzIHVzZWQgaW50ZXJjaGFuZ2VhYmx5IGhlcmUuCj4g
UGVyaGFwcyB1c2luZyBfX2ZyZWVfcGFnZXMoKSBoYXZlIHBlcmZvcm1hbmNlIHJlYXNvbj8gQXMg
dGhlIGNvbW1lbnQgYmVsb3c6Cj4KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92
Ni4zLXJjMy9zb3VyY2UvbmV0L2NvcmUvcGFnZV9wb29sLmMjTDUwMAoKClllcywgYnV0IG5vdyB3
ZSBkb24ndCBzZWVtIHRvIGJlIHZlcnkgZ29vZCB0byBkaXN0aW5ndWlzaCBpdC4gQnV0IEkgdGhp
bmsKaXQgZG9lc24ndCBtYXR0ZXIuIFRoaXMgbG9naWMgaXMgcmFyZSB1bmRlciBhY3R1YWwgc2l0
dWF0aW9uLgoKVGhhbmtzLgoKCj4KPiA+IC0KPiA+ICAJCWlmICh4ZHBfYnVmZl9oYXNfZnJhZ3Mo
JnhkcCkpIHsKPiA+ICAJCQlzaGluZm8gPSB4ZHBfZ2V0X3NoYXJlZF9pbmZvX2Zyb21fYnVmZigm
eGRwKTsKPiA+ICAJCQlmb3IgKGkgPSAwOyBpIDwgc2hpbmZvLT5ucl9mcmFnczsgaSsrKSB7Cj4g
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
