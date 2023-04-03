Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EC6C761AF
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 04:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D310D81E79;
	Mon,  3 Apr 2023 04:11:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D310D81E79
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N5kvYcl-6H_3; Mon,  3 Apr 2023 04:11:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5131A81E76;
	Mon,  3 Apr 2023 04:11:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5131A81E76
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20CC0C0036;
	Mon,  3 Apr 2023 04:11:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82750C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 04:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63DBA60D58
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 04:11:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 63DBA60D58
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id km16tj7Yeefy
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 04:11:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 542CB60C34
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 542CB60C34
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 04:11:51 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VfB1fOn_1680495103; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VfB1fOn_1680495103) by smtp.aliyun-inc.com;
 Mon, 03 Apr 2023 12:11:44 +0800
Message-ID: <1680495091.0610447-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 1/8] virtio_net: mergeable xdp: put old page
 immediately
Date: Mon, 3 Apr 2023 12:11:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEseX1+oi+unZspnGzPduQc-tFkxpVg+9KfEhPSWWqCTrg@mail.gmail.com>
In-Reply-To: <CACGkMEseX1+oi+unZspnGzPduQc-tFkxpVg+9KfEhPSWWqCTrg@mail.gmail.com>
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

T24gRnJpLCAzMSBNYXIgMjAyMyAxNzowMTo1NCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgODowNOKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IEluIHRo
ZSB4ZHAgaW1wbGVtZW50YXRpb24gb2YgdmlydGlvLW5ldCBtZXJnZWFibGUsIGl0IGFsd2F5cyBj
aGVja3MKPiA+IHdoZXRoZXIgdHdvIHBhZ2UgaXMgdXNlZCBhbmQgYSBwYWdlIGlzIHNlbGVjdGVk
IHRvIHJlbGVhc2UuIFRoaXMgaXMKPiA+IGNvbXBsaWNhdGVkIGZvciB0aGUgcHJvY2Vzc2luZyBv
ZiBhY3Rpb24sIGFuZCBiZSBjYXJlZnVsLgo+ID4KPiA+IEluIHRoZSBlbnRpcmUgcHJvY2Vzcywg
d2UgaGF2ZSBzdWNoIHByaW5jaXBsZXM6Cj4gPiAqIElmIHhkcF9wYWdlIGlzIHVzZWQgKFBBU1Ms
IFRYLCBSZWRpcmVjdCksIHRoZW4gd2UgcmVsZWFzZSB0aGUgb2xkCj4gPiAgIHBhZ2UuCj4gPiAq
IElmIGl0IGlzIGEgZHJvcCBjYXNlLCB3ZSB3aWxsIHJlbGVhc2UgdHdvLiBUaGUgb2xkIHBhZ2Ug
b2J0YWluZWQgZnJvbQo+ID4gICBidWYgaXMgcmVsZWFzZSBpbnNpZGUgZXJyX3hkcCwgYW5kIHhk
cF9wYWdlIG5lZWRzIGJlIHJlbGFzZWQgYnkgdXMuCj4gPgo+ID4gQnV0IGluIGZhY3QsIHdoZW4g
d2UgYWxsb2NhdGUgYSBuZXcgcGFnZSwgd2UgY2FuIHJlbGVhc2UgdGhlIG9sZCBwYWdlCj4gPiBp
bW1lZGlhdGVseS4gVGhlbiBqdXN0IG9uZSBpcyB1c2luZywgd2UganVzdCBuZWVkIHRvIHJlbGVh
c2UgdGhlIG5ldwo+ID4gcGFnZSBmb3IgZHJvcCBjYXNlLiBPbiB0aGUgZHJvcCBwYXRoLCBlcnJf
eGRwIHdpbGwgcmVsZWFzZSB0aGUgdmFyaWFibGUKPiA+ICJwYWdlIiwgc28gd2Ugb25seSBuZWVk
IHRvIGxldCAicGFnZSIgcG9pbnQgdG8gdGhlIG5ldyB4ZHBfcGFnZSBpbgo+ID4gYWR2YW5jZS4K
PiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMTUgKysrKysrLS0t
LS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMo
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiBpbmRleCBlMjU2MGI2Zjc5ODAuLjRkMmJmMWNlMDczMCAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiBAQCAtMTI0NSw2ICsxMjQ1LDkgQEAgc3RhdGljIHN0cnVj
dCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCF4ZHBfcGFnZSkKPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZ290byBlcnJfeGRwOwo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgb2Zmc2V0ID0gVklSVElPX1hEUF9IRUFEUk9PTTsKPiA+ICsKPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHB1dF9wYWdlKHBhZ2UpOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcGFn
ZSA9IHhkcF9wYWdlOwo+ID4gICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAodW5saWtlbHkoaGVh
ZHJvb20gPCB2aXJ0bmV0X2dldF9oZWFkcm9vbSh2aSkpKSB7Cj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICB4ZHBfcm9vbSA9IFNLQl9EQVRBX0FMSUdOKFZJUlRJT19YRFBfSEVBRFJPT00gKwo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXpl
b2Yoc3RydWN0IHNrYl9zaGFyZWRfaW5mbykpOwo+ID4gQEAgLTEyNTksNiArMTI2Miw5IEBAIHN0
YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYWdlX2FkZHJlc3MocGFn
ZSkgKyBvZmZzZXQsIGxlbik7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBmcmFtZV9zeiA9
IFBBR0VfU0laRTsKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIG9mZnNldCA9IFZJUlRJT19Y
RFBfSEVBRFJPT007Cj4gPiArCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwdXRfcGFnZShw
YWdlKTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBhZ2UgPSB4ZHBfcGFnZTsKPiA+ICAg
ICAgICAgICAgICAgICB9IGVsc2Ugewo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgeGRwX3Bh
Z2UgPSBwYWdlOwo+ID4gICAgICAgICAgICAgICAgIH0KPgo+IFdoaWxlIGF0IHRoaXMgSSB3b3Vs
ZCBnbyBhIGxpdHRsZSBmdXJ0aGVyLCBqdXN0IHJlbW92ZSB0aGUgYWJvdmUKPiBhc3NpZ25tZW50
IHRoZW4gd2UgY2FuIHVzZToKPgo+ICAgICAgICAgICAgICAgICBkYXRhID0gcGFnZV9hZGRyZXNz
KHBhZ2UpICsgb2Zmc2V0Owo+Cj4gV2hpY2ggc2VlbXMgY2xlYW5lcj8KCkkgd2lsbCB0cnkuCgpU
aGFua3MuCgoKPgo+IFRoYW5rcwo+Cj4gPiBAQCAtMTI3OCw4ICsxMjg0LDYgQEAgc3RhdGljIHN0
cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KCFoZWFkX3NrYikpCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcF9mcmFnczsKPiA+Cj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoeGRwX3BhZ2UgIT0gcGFnZSkp
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB1dF9wYWdlKHBhZ2UpOwo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gaGVhZF9za2I7Cj4gPiAgICAgICAgICAgICAgICAgY2FzZSBY
RFBfVFg6Cj4gPiBAQCAtMTI5Nyw4ICsxMzAxLDYgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpy
ZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94ZHBfZnJhZ3M7Cj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICB9Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAqeGRwX3htaXQgfD0gVklS
VElPX1hEUF9UWDsKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSh4ZHBf
cGFnZSAhPSBwYWdlKSkKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHV0X3Bh
Z2UocGFnZSk7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsK
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8geGRwX3htaXQ7Cj4gPiAgICAgICAgICAg
ICAgICAgY2FzZSBYRFBfUkVESVJFQ1Q6Cj4gPiBAQCAtMTMwNyw4ICsxMzA5LDYgQEAgc3RhdGlj
IHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
LAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVycikKPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZ290byBlcnJfeGRwX2ZyYWdzOwo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgKnhkcF94bWl0IHw9IFZJUlRJT19YRFBfUkVESVI7Cj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICBpZiAodW5saWtlbHkoeGRwX3BhZ2UgIT0gcGFnZSkpCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHB1dF9wYWdlKHBhZ2UpOwo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBn
b3RvIHhkcF94bWl0Owo+ID4gICAgICAgICAgICAgICAgIGRlZmF1bHQ6Cj4gPiBAQCAtMTMyMSw5
ICsxMzIxLDYgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJf
eGRwX2ZyYWdzOwo+ID4gICAgICAgICAgICAgICAgIH0KPiA+ICBlcnJfeGRwX2ZyYWdzOgo+ID4g
LSAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSh4ZHBfcGFnZSAhPSBwYWdlKSkKPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgIF9fZnJlZV9wYWdlcyh4ZHBfcGFnZSwgMCk7Cj4gPiAtCj4gPiAg
ICAgICAgICAgICAgICAgaWYgKHhkcF9idWZmX2hhc19mcmFncygmeGRwKSkgewo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgc2hpbmZvID0geGRwX2dldF9zaGFyZWRfaW5mb19mcm9tX2J1ZmYo
JnhkcCk7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgc2hpbmZv
LT5ucl9mcmFnczsgaSsrKSB7Cj4gPiAtLQo+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4KPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
