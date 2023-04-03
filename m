Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F01CC76196
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 04:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 215418133A;
	Mon,  3 Apr 2023 04:18:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 215418133A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cTVAtQoVYZVm; Mon,  3 Apr 2023 04:18:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F79B80C83;
	Mon,  3 Apr 2023 04:18:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F79B80C83
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D466C0037;
	Mon,  3 Apr 2023 04:18:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AF45C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 04:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4545080C83
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 04:18:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4545080C83
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tSjkAX7tjcrG
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 04:18:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B056F80BEB
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B056F80BEB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 04:18:30 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R651e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VfBvNta_1680495504; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VfBvNta_1680495504) by smtp.aliyun-inc.com;
 Mon, 03 Apr 2023 12:18:24 +0800
Message-ID: <1680495473.7526932-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 6/8] virtio_net: auto release xdp shinfo
Date: Mon, 3 Apr 2023 12:17:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-7-xuanzhuo@linux.alibaba.com>
 <5f48c497-1831-40cf-a4b5-5d283204d7a6@redhat.com>
In-Reply-To: <5f48c497-1831-40cf-a4b5-5d283204d7a6@redhat.com>
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

T24gTW9uLCAzIEFwciAyMDIzIDExOjE4OjAyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIzLzMvMjggMjA6MDQsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZygpIGFuZCB2aXJ0bmV0X3hkcF9oYW5k
bGVyKCkgYXV0bwo+Cj4KPiBJIHRoaW5rIHlvdSBtZWFudCB2aXJ0bmV0X3hkcF9oYW5kbGVyKCkg
YWN0dWFsbHk/Cj4KPgo+ID4gcmVsZWFzZSB4ZHAgc2hpbmZvIHRoZW4gdGhlIGNhbGxlciBubyBu
ZWVkIHRvIGNhcmVmdWwgdGhlIHhkcCBzaGluZm8uCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMgfCAyOSArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ID4gaW5kZXggYTNmMmJjYjNkYjI3Li4xMzYxMzFhNzg2OGEgMTAwNjQ0Cj4g
PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ID4gQEAgLTgzMywxNCArODMzLDE0IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94
ZHBfaGFuZGxlcihzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLCBzdHJ1Y3QgeGRwX2J1ZmYgKnhk
cCwKPiA+ICAgCQlzdGF0cy0+eGRwX3R4Kys7Cj4gPiAgIAkJeGRwZiA9IHhkcF9jb252ZXJ0X2J1
ZmZfdG9fZnJhbWUoeGRwKTsKPiA+ICAgCQlpZiAodW5saWtlbHkoIXhkcGYpKQo+ID4gLQkJCXJl
dHVybiBWSVJUTkVUX1hEUF9SRVNfRFJPUDsKPiA+ICsJCQlnb3RvIGRyb3A7Cj4gPgo+ID4gICAJ
CWVyciA9IHZpcnRuZXRfeGRwX3htaXQoZGV2LCAxLCAmeGRwZiwgMCk7Cj4gPiAgIAkJaWYgKHVu
bGlrZWx5KCFlcnIpKSB7Cj4gPiAgIAkJCXhkcF9yZXR1cm5fZnJhbWVfcnhfbmFwaSh4ZHBmKTsK
PiA+ICAgCQl9IGVsc2UgaWYgKHVubGlrZWx5KGVyciA8IDApKSB7Cj4gPiAgIAkJCXRyYWNlX3hk
cF9leGNlcHRpb24oZGV2LCB4ZHBfcHJvZywgYWN0KTsKPiA+IC0JCQlyZXR1cm4gVklSVE5FVF9Y
RFBfUkVTX0RST1A7Cj4gPiArCQkJZ290byBkcm9wOwo+ID4gICAJCX0KPiA+Cj4gPiAgIAkJKnhk
cF94bWl0IHw9IFZJUlRJT19YRFBfVFg7Cj4gPiBAQCAtODUwLDcgKzg1MCw3IEBAIHN0YXRpYyBp
bnQgdmlydG5ldF94ZHBfaGFuZGxlcihzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLCBzdHJ1Y3Qg
eGRwX2J1ZmYgKnhkcCwKPiA+ICAgCQlzdGF0cy0+eGRwX3JlZGlyZWN0cysrOwo+ID4gICAJCWVy
ciA9IHhkcF9kb19yZWRpcmVjdChkZXYsIHhkcCwgeGRwX3Byb2cpOwo+ID4gICAJCWlmIChlcnIp
Cj4gPiAtCQkJcmV0dXJuIFZJUlRORVRfWERQX1JFU19EUk9QOwo+ID4gKwkJCWdvdG8gZHJvcDsK
PiA+Cj4gPiAgIAkJKnhkcF94bWl0IHw9IFZJUlRJT19YRFBfUkVESVI7Cj4gPiAgIAkJcmV0dXJu
IFZJUlRORVRfWERQX1JFU19DT05TVU1FRDsKPiA+IEBAIC04NjIsOCArODYyLDEyIEBAIHN0YXRp
YyBpbnQgdmlydG5ldF94ZHBfaGFuZGxlcihzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLCBzdHJ1
Y3QgeGRwX2J1ZmYgKnhkcCwKPiA+ICAgCQl0cmFjZV94ZHBfZXhjZXB0aW9uKGRldiwgeGRwX3By
b2csIGFjdCk7Cj4gPiAgIAkJZmFsbHRocm91Z2g7Cj4gPiAgIAljYXNlIFhEUF9EUk9QOgo+ID4g
LQkJcmV0dXJuIFZJUlRORVRfWERQX1JFU19EUk9QOwo+ID4gKwkJZ290byBkcm9wOwo+Cj4KPiBU
aGlzIGdvdG8gaXMga2luZCBvZiBtZWFuaW5nbGVzcy4KCldpbGwgZml4LgoKVGhhbmtzLgoKCj4K
PiBUaGFua3MKPgo+Cj4gPiAgIAl9Cj4gPiArCj4gPiArZHJvcDoKPiA+ICsJcHV0X3hkcF9mcmFn
cyh4ZHApOwo+ID4gKwlyZXR1cm4gVklSVE5FVF9YRFBfUkVTX0RST1A7Cj4gPiAgIH0KPiA+Cj4g
PiAgIHN0YXRpYyB1bnNpZ25lZCBpbnQgdmlydG5ldF9nZXRfaGVhZHJvb20oc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmkpCj4gPiBAQCAtMTE5OSw3ICsxMjAzLDcgQEAgc3RhdGljIGludCB2aXJ0bmV0
X2J1aWxkX3hkcF9idWZmX21yZyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gICAJCQkJIGRl
di0+bmFtZSwgKm51bV9idWYsCj4gPiAgIAkJCQkgdmlydGlvMTZfdG9fY3B1KHZpLT52ZGV2LCBo
ZHItPm51bV9idWZmZXJzKSk7Cj4gPiAgIAkJCWRldi0+c3RhdHMucnhfbGVuZ3RoX2Vycm9ycysr
Owo+ID4gLQkJCXJldHVybiAtRUlOVkFMOwo+ID4gKwkJCWdvdG8gZXJyOwo+ID4gICAJCX0KPiA+
Cj4gPiAgIAkJc3RhdHMtPmJ5dGVzICs9IGxlbjsKPiA+IEBAIC0xMjE4LDcgKzEyMjIsNyBAQCBz
dGF0aWMgaW50IHZpcnRuZXRfYnVpbGRfeGRwX2J1ZmZfbXJnKHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYsCj4gPiAgIAkJCXByX2RlYnVnKCIlczogcnggZXJyb3I6IGxlbiAldSBleGNlZWRzIHRydWVz
aXplICVsdVxuIiwKPiA+ICAgCQkJCSBkZXYtPm5hbWUsIGxlbiwgKHVuc2lnbmVkIGxvbmcpKHRy
dWVzaXplIC0gcm9vbSkpOwo+ID4gICAJCQlkZXYtPnN0YXRzLnJ4X2xlbmd0aF9lcnJvcnMrKzsK
PiA+IC0JCQlyZXR1cm4gLUVJTlZBTDsKPiA+ICsJCQlnb3RvIGVycjsKPiA+ICAgCQl9Cj4gPgo+
ID4gICAJCWZyYWcgPSAmc2hpbmZvLT5mcmFnc1tzaGluZm8tPm5yX2ZyYWdzKytdOwo+ID4gQEAg
LTEyMzMsNiArMTIzNywxMCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfYnVpbGRfeGRwX2J1ZmZfbXJn
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPgo+ID4gICAJKnhkcF9mcmFnc190cnVlc2l6ZSA9
IHhkcF9mcmFnc190cnVlc3o7Cj4gPiAgIAlyZXR1cm4gMDsKPiA+ICsKPiA+ICtlcnI6Cj4gPiAr
CXB1dF94ZHBfZnJhZ3MoeGRwKTsKPiA+ICsJcmV0dXJuIC1FSU5WQUw7Cj4gPiAgIH0KPiA+Cj4g
PiAgIHN0YXRpYyB2b2lkICptZXJnZWFibGVfeGRwX3ByZXBhcmUoc3RydWN0IHZpcnRuZXRfaW5m
byAqdmksCj4gPiBAQCAtMTM2MSw3ICsxMzY5LDcgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpy
ZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gICAJCWVyciA9IHZp
cnRuZXRfYnVpbGRfeGRwX2J1ZmZfbXJnKGRldiwgdmksIHJxLCAmeGRwLCBkYXRhLCBsZW4sIGZy
YW1lX3N6LAo+ID4gICAJCQkJCQkgJm51bV9idWYsICZ4ZHBfZnJhZ3NfdHJ1ZXN6LCBzdGF0cyk7
Cj4gPiAgIAkJaWYgKHVubGlrZWx5KGVycikpCj4gPiAtCQkJZ290byBlcnJfeGRwX2ZyYWdzOwo+
ID4gKwkJCWdvdG8gZXJyX3hkcDsKPiA+Cj4gPiAgIAkJYWN0ID0gdmlydG5ldF94ZHBfaGFuZGxl
cih4ZHBfcHJvZywgJnhkcCwgZGV2LCB4ZHBfeG1pdCwgc3RhdHMpOwo+ID4KPiA+IEBAIC0xMzY5
LDcgKzEzNzcsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0
cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiAgIAkJY2FzZSBWSVJUTkVUX1hEUF9SRVNfUEFTUzoK
PiA+ICAgCQkJaGVhZF9za2IgPSBidWlsZF9za2JfZnJvbV94ZHBfYnVmZihkZXYsIHZpLCAmeGRw
LCB4ZHBfZnJhZ3NfdHJ1ZXN6KTsKPiA+ICAgCQkJaWYgKHVubGlrZWx5KCFoZWFkX3NrYikpCj4g
PiAtCQkJCWdvdG8gZXJyX3hkcF9mcmFnczsKPiA+ICsJCQkJZ290byBlcnJfeGRwOwo+ID4KPiA+
ICAgCQkJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gPiAgIAkJCXJldHVybiBoZWFkX3NrYjsKPiA+IEBA
IC0xMzc5LDExICsxMzg3LDggQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdl
YWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gICAJCQlnb3RvIHhkcF94bWl0Owo+ID4K
PiA+ICAgCQljYXNlIFZJUlRORVRfWERQX1JFU19EUk9QOgo+ID4gLQkJCWdvdG8gZXJyX3hkcF9m
cmFnczsKPiA+ICsJCQlnb3RvIGVycl94ZHA7Cj4gPiAgIAkJfQo+ID4gLWVycl94ZHBfZnJhZ3M6
Cj4gPiAtCQlwdXRfeGRwX2ZyYWdzKCZ4ZHApOwo+ID4gLQkJZ290byBlcnJfeGRwOwo+ID4gICAJ
fQo+ID4gICAJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gPgo+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
