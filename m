Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8E0C77B72
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 09:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 257014270E;
	Thu, 20 Apr 2023 09:11:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 257014270E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gtjbtzTfyxvQ; Thu, 20 Apr 2023 09:11:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 350C74270D;
	Thu, 20 Apr 2023 09:11:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 350C74270D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03A31C0036;
	Thu, 20 Apr 2023 09:11:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04868C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 09:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D398540320
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 09:11:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D398540320
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jDMGHILytCFF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 09:11:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 88E15400C5
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88E15400C5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 09:11:17 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VgYINEN_1681981870; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgYINEN_1681981870) by smtp.aliyun-inc.com;
 Thu, 20 Apr 2023 17:11:11 +0800
Message-ID: <1681981800.3300662-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 08/14] virtio_net: auto release xdp shinfo
Date: Thu, 20 Apr 2023 17:10:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEuNxh-YC6A=nyt682ReSbujbgepABgwX0Y+WW30XgFktA@mail.gmail.com>
In-Reply-To: <CACGkMEuNxh-YC6A=nyt682ReSbujbgepABgwX0Y+WW30XgFktA@mail.gmail.com>
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

T24gVGh1LCAyMCBBcHIgMjAyMyAxMzo1OTozMCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgMjo1M+KAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IHZpcnRu
ZXRfYnVpbGRfeGRwX2J1ZmZfbXJnKCkgYW5kIHZpcnRuZXRfeGRwX2hhbmRsZXIoKSBhdXRvCj4g
PiByZWxlYXNlIHhkcCBzaGluZm8gdGhlbiB0aGUgY2FsbGVyIG5vIG5lZWQgdG8gY2FyZWZ1bCB0
aGUgeGRwIHNoaW5mby4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVv
QGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IHwgMjkgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MTcgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gaW5k
ZXggZTJlYWRlODdkMmQ0Li4yNjZjMTY3MGJlZGEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gQEAg
LTgzNCw3ICs4MzQsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX2hhbmRsZXIoc3RydWN0IGJw
Zl9wcm9nICp4ZHBfcHJvZywgc3RydWN0IHhkcF9idWZmICp4ZHAsCj4gPiAgICAgICAgICAgICAg
ICAgeGRwZiA9IHhkcF9jb252ZXJ0X2J1ZmZfdG9fZnJhbWUoeGRwKTsKPiA+ICAgICAgICAgICAg
ICAgICBpZiAodW5saWtlbHkoIXhkcGYpKSB7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBu
ZXRkZXZfZGJnKGRldiwgImNvbnZlcnQgYnVmZiB0byBmcmFtZSBmYWlsZWQgZm9yIHhkcFxuIik7
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gVklSVE5FVF9YRFBfUkVTX0RST1A7
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGRyb3A7Cj4gPiAgICAgICAgICAgICAg
ICAgfQo+ID4KPiA+ICAgICAgICAgICAgICAgICBlcnIgPSB2aXJ0bmV0X3hkcF94bWl0KGRldiwg
MSwgJnhkcGYsIDApOwo+ID4gQEAgLTg0Miw3ICs4NDIsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRf
eGRwX2hhbmRsZXIoc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZywgc3RydWN0IHhkcF9idWZmICp4
ZHAsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB4ZHBfcmV0dXJuX2ZyYW1lX3J4X25hcGko
eGRwZik7Cj4gPiAgICAgICAgICAgICAgICAgfSBlbHNlIGlmICh1bmxpa2VseShlcnIgPCAwKSkg
ewo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgdHJhY2VfeGRwX2V4Y2VwdGlvbihkZXYsIHhk
cF9wcm9nLCBhY3QpOwo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFZJUlRORVRf
WERQX1JFU19EUk9QOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBkcm9wOwo+ID4g
ICAgICAgICAgICAgICAgIH0KPiA+Cj4gPiAgICAgICAgICAgICAgICAgKnhkcF94bWl0IHw9IFZJ
UlRJT19YRFBfVFg7Cj4gPiBAQCAtODUyLDcgKzg1Miw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94
ZHBfaGFuZGxlcihzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLCBzdHJ1Y3QgeGRwX2J1ZmYgKnhk
cCwKPiA+ICAgICAgICAgICAgICAgICBzdGF0cy0+eGRwX3JlZGlyZWN0cysrOwo+ID4gICAgICAg
ICAgICAgICAgIGVyciA9IHhkcF9kb19yZWRpcmVjdChkZXYsIHhkcCwgeGRwX3Byb2cpOwo+ID4g
ICAgICAgICAgICAgICAgIGlmIChlcnIpCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gVklSVE5FVF9YRFBfUkVTX0RST1A7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3Rv
IGRyb3A7Cj4gPgo+ID4gICAgICAgICAgICAgICAgICp4ZHBfeG1pdCB8PSBWSVJUSU9fWERQX1JF
RElSOwo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBWSVJUTkVUX1hEUF9SRVNfQ09OU1VNRUQ7
Cj4gPiBAQCAtODY0LDggKzg2NCwxMiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX2hhbmRsZXIo
c3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZywgc3RydWN0IHhkcF9idWZmICp4ZHAsCj4gPiAgICAg
ICAgICAgICAgICAgdHJhY2VfeGRwX2V4Y2VwdGlvbihkZXYsIHhkcF9wcm9nLCBhY3QpOwo+ID4g
ICAgICAgICAgICAgICAgIGZhbGx0aHJvdWdoOwo+ID4gICAgICAgICBjYXNlIFhEUF9EUk9QOgo+
ID4gLSAgICAgICAgICAgICAgIHJldHVybiBWSVJUTkVUX1hEUF9SRVNfRFJPUDsKPiA+ICsgICAg
ICAgICAgICAgICBicmVhazsKPiA+ICAgICAgICAgfQo+ID4gKwo+ID4gK2Ryb3A6Cj4gPiArICAg
ICAgIHB1dF94ZHBfZnJhZ3MoeGRwKTsKPiA+ICsgICAgICAgcmV0dXJuIFZJUlRORVRfWERQX1JF
U19EUk9QOwo+ID4gIH0KPgo+IFBhdGNoIGxvb2tzIGNvcnJlY3QgYnV0IHdlIGVuZCB1cCBzb21l
IGluY29uc2lzdGVuY3kgaGVyZS4KPgo+IGZyYWdzIGFyZSBhdXRvbWF0aWNhbGx5IHJlbGVhc2Vk
Lgo+Cj4gYnV0IHRoZSBwYWdlIHN0aWxsIG5lZWRzIHRvIGJlIGZyZWVkIGJ5IHRoZSBjYWxsZXI/
CgoKWWVzLgoKRG8geW91IHdhbnQgdG8gYXV0byBmcmVlIHBhZ2U/CgpUaGFua3MuCgoKCj4KPiBU
aGFua3MKPgo+Cj4gPgo+ID4gIHN0YXRpYyB1bnNpZ25lZCBpbnQgdmlydG5ldF9nZXRfaGVhZHJv
b20oc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiBAQCAtMTIwMSw3ICsxMjA1LDcgQEAgc3Rh
dGljIGludCB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
LAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2LT5uYW1lLCAqbnVtX2J1
ZiwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRpbzE2X3RvX2NwdSh2
aS0+dmRldiwgaGRyLT5udW1fYnVmZmVycykpOwo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ZGV2LT5zdGF0cy5yeF9sZW5ndGhfZXJyb3JzKys7Cj4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyOwo+
ID4gICAgICAgICAgICAgICAgIH0KPiA+Cj4gPiAgICAgICAgICAgICAgICAgc3RhdHMtPmJ5dGVz
ICs9IGxlbjsKPiA+IEBAIC0xMjIwLDcgKzEyMjQsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfYnVp
bGRfeGRwX2J1ZmZfbXJnKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBwcl9kZWJ1ZygiJXM6IHJ4IGVycm9yOiBsZW4gJXUgZXhjZWVkcyB0cnVlc2l6
ZSAlbHVcbiIsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXYtPm5hbWUs
IGxlbiwgKHVuc2lnbmVkIGxvbmcpKHRydWVzaXplIC0gcm9vbSkpOwo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgZGV2LT5zdGF0cy5yeF9sZW5ndGhfZXJyb3JzKys7Cj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGdvdG8gZXJyOwo+ID4gICAgICAgICAgICAgICAgIH0KPiA+Cj4gPiAgICAgICAgICAgICAgICAg
ZnJhZyA9ICZzaGluZm8tPmZyYWdzW3NoaW5mby0+bnJfZnJhZ3MrK107Cj4gPiBAQCAtMTIzNSw2
ICsxMjM5LDEwIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9idWlsZF94ZHBfYnVmZl9tcmcoc3RydWN0
IG5ldF9kZXZpY2UgKmRldiwKPiA+Cj4gPiAgICAgICAgICp4ZHBfZnJhZ3NfdHJ1ZXNpemUgPSB4
ZHBfZnJhZ3NfdHJ1ZXN6Owo+ID4gICAgICAgICByZXR1cm4gMDsKPiA+ICsKPiA+ICtlcnI6Cj4g
PiArICAgICAgIHB1dF94ZHBfZnJhZ3MoeGRwKTsKPiA+ICsgICAgICAgcmV0dXJuIC1FSU5WQUw7
Cj4gPiAgfQo+ID4KPiA+ICBzdGF0aWMgdm9pZCAqbWVyZ2VhYmxlX3hkcF9wcmVwYXJlKHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gQEAgLTEzNjQsNyArMTM3Miw3IEBAIHN0YXRpYyBzdHJ1
Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiA+
ICAgICAgICAgICAgICAgICBlcnIgPSB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZyhkZXYsIHZp
LCBycSwgJnhkcCwgZGF0YSwgbGVuLCBmcmFtZV9zeiwKPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbnVtX2J1ZiwgJnhkcF9mcmFnc190cnVlc3os
IHN0YXRzKTsKPiA+ICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoZXJyKSkKPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcF9mcmFnczsKPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gZXJyX3hkcDsKPiA+Cj4gPiAgICAgICAgICAgICAgICAgYWN0ID0gdmly
dG5ldF94ZHBfaGFuZGxlcih4ZHBfcHJvZywgJnhkcCwgZGV2LCB4ZHBfeG1pdCwgc3RhdHMpOwo+
ID4KPiA+IEBAIC0xMzcyLDcgKzEzODAsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2Vp
dmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiAgICAgICAgICAgICAgICAg
Y2FzZSBWSVJUTkVUX1hEUF9SRVNfUEFTUzoKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGhl
YWRfc2tiID0gYnVpbGRfc2tiX2Zyb21feGRwX2J1ZmYoZGV2LCB2aSwgJnhkcCwgeGRwX2ZyYWdz
X3RydWVzeik7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoIWhlYWRf
c2tiKSkKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfeGRwX2Zy
YWdzOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94ZHA7Cj4g
Pgo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gaGVhZF9za2I7Cj4gPiBAQCAtMTM4MiwxMSArMTM5
MCw4IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0IG5l
dF9kZXZpY2UgKmRldiwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8geGRwX3htaXQ7
Cj4gPgo+ID4gICAgICAgICAgICAgICAgIGNhc2UgVklSVE5FVF9YRFBfUkVTX0RST1A6Cj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGdvdG8gZXJyX3hkcDsKPiA+ICAgICAgICAgICAgICAgICB9Cj4gPiAtZXJyX3hkcF9mcmFnczoK
PiA+IC0gICAgICAgICAgICAgICBwdXRfeGRwX2ZyYWdzKCZ4ZHApOwo+ID4gLSAgICAgICAgICAg
ICAgIGdvdG8gZXJyX3hkcDsKPiA+ICAgICAgICAgfQo+ID4gICAgICAgICByY3VfcmVhZF91bmxv
Y2soKTsKPiA+Cj4gPiAtLQo+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4KPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
