Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1DCC2B9F4
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 05:58:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C3961241
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 05:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C3961241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEC8F83C85;
	Thu, 17 Jun 2021 05:58:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nnlo2jwuSJxy; Thu, 17 Jun 2021 05:58:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 44402839B8;
	Thu, 17 Jun 2021 05:58:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7144C000D;
	Thu, 17 Jun 2021 05:58:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A5F9C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70C24401F4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q3sYTYWK15sP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:58:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7AF6401C6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:58:28 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0UcgosrM_1623909504; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UcgosrM_1623909504) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Jun 2021 13:58:25 +0800
MIME-Version: 1.0
Message-Id: <1623909417.6591244-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 15/15] virtio-net: xsk zero copy xmit kick by
 threshold
Date: Thu, 17 Jun 2021 13:56:57 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <7dbdb429-edda-9f33-fbfa-bb128c5e3eca@redhat.com>
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

T24gVGh1LCAxNyBKdW4gMjAyMSAxMTowODozNCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMS82LzEwIOS4i+WNiDQ6MjIsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBBZnRlciB0ZXN0aW5nLCB0aGUgcGVyZm9ybWFuY2Ugb2YgY2FsbGluZyBr
aWNrIGV2ZXJ5IHRpbWUgaXMgbm90IHN0YWJsZS4KPiA+IEFuZCBpZiBhbGwgdGhlIHBhY2tldHMg
YXJlIHNlbnQgYW5kIGtpY2tlZCBhZ2FpbiwgdGhlIHBlcmZvcm1hbmNlIGlzIG5vdAo+ID4gZ29v
ZC4gU28gYWRkIGEgbW9kdWxlIHBhcmFtZXRlciB0byBzcGVjaWZ5IGhvdyBtYW55IHBhY2tldHMg
YXJlIHNlbnQgdG8KPiA+IGNhbGwgYSBraWNrLgo+ID4KPiA+IDggaXMgYSByZWxhdGl2ZWx5IHN0
YWJsZSB2YWx1ZSB3aXRoIHRoZSBiZXN0IHBlcmZvcm1hbmNlLgo+ID4KPiA+IEhlcmUgaXMgdGhl
IHBwcyBvZiB0aGUgdGVzdCBvZiB4c2tfa2lja190aHIgdW5kZXIgZGlmZmVyZW50IHZhbHVlcyAo
ZnJvbQo+ID4gMSB0byA2NCkuCj4gPgo+ID4gdGhyICBQUFMgICAgICAgICAgICAgdGhyIFBQUyAg
ICAgICAgICAgICB0aHIgUFBTCj4gPiAxICAgIDI5MjQxMTYuNzQyNDcgfCAyMyAgMzY4MzI2My4w
NDM0OCB8IDQ1ICAyNzc3OTA3LjIyOTYzCj4gPiAyICAgIDM0NDEwMTAuNTcxOTEgfCAyNCAgMzA3
ODg4MC4xMzA0MyB8IDQ2ICAyNzgxMzc2LjIxNzM5Cj4gPiAzICAgIDM2MzY3MjguNzIzNzggfCAy
NSAgMjg1OTIxOS41NzY1NiB8IDQ3ICAyNzc3MjcxLjkxMzA0Cj4gPiA0ICAgIDM2Mzc1MTguNjE0
NjggfCAyNiAgMjg1MTU1Ny45NTkzICB8IDQ4ICAyODAwMzIwLjU2NTc1Cj4gPiA1ICAgIDM2NTE3
MzguMTYyNTEgfCAyNyAgMjgzNDc4My41NDQwOCB8IDQ5ICAyODEzMDM5Ljg3NTk5Cj4gPiA2ICAg
IDM2NTIxNzYuNjkyMzEgfCAyOCAgMjg0NzAxMi40MTQ3MiB8IDUwICAzNDQ1MTQzLjAxODM5Cj4g
PiA3ICAgIDM2NjU0MTUuODA2MDIgfCAyOSAgMjg2MDYzMy45MTMwNCB8IDUxICAzNjY2OTE4LjAx
MjgxCj4gPiA4ICAgIDM2NjUwNDUuMTY1NTUgfCAzMCAgMjg1NzkwMy41Nzg2ICB8IDUyICAzMDU5
OTI5LjI3MDkKPgo+Cj4gSSB3b25kZXIgd2hhdCdzIHRoZSBudW1iZXIgZm9yIHRoZSBjYXNlIG9m
IG5vbiB6YyB4c2s/CgoKVGhlc2UgZGF0YSBhcmUgdXNlZCB0byBjb21wYXJlIHRoZSBzaXR1YXRp
b24gb2Ygc2VuZGluZyBkaWZmZXJlbnQgbnVtYmVycyBvZgpwYWNrZXRzIHRvIHZpcnRpbyBhdCBv
bmUgdGltZS4gSSB0aGluayBpdCBoYXMgbm90aGluZyB0byBkbyB3aXRoIG5vbi16ZXJvY29weQp4
c2suCgpUaGFua3MuCgo+Cj4gVGhhbmtzCj4KPgo+ID4gOSAgICAzNjcxMDIzLjI0MDEgIHwgMzEg
IDI4MzU1ODkuOTg5NjMgfCA1MyAgMjgzMTUxNS4yMTczOQo+ID4gMTAgICAzNjY5NTMyLjIzMjc0
IHwgMzIgIDI4NjI4MjcuODg3MDYgfCA1NCAgMzQ1MTgwNC4wNzIwNAo+ID4gMTEgICAzNjY2MTYw
LjM3NzQ5IHwgMzMgIDI4NzE4NTUuOTY2OTYgfCA1NSAgMzY1NDk3NS45MjM4NQo+ID4gMTIgICAz
Njc0OTUxLjQ0ODEzIHwgMzQgIDM0MzQ0NTYuNDQ4MTYgfCA1NiAgMzY3NjE5OC4zMTg4Cj4gPiAx
MyAgIDM2Njc0NDcuNTczMzEgfCAzNSAgMzY1NjkxOC41NDE3NyB8IDU3ICAzNjg0NzQwLjg1NjE5
Cj4gPiAxNCAgIDMwMTg4NDYuMDUwMyAgfCAzNiAgMzU5NjkyMS4xNjcyMiB8IDU4ICAzMDYwOTU4
Ljg1OTQKPiA+IDE1ICAgMjc5Mjc3My44NDUwNSB8IDM3ICAzNjAzNDYwLjYzOTAzIHwgNTkgIDI4
Mjg4NzQuNTcxOTEKPiA+IDE2ICAgMzQzMDU5Ni4zNjAyICB8IDM4ICAzNTk1NDEwLjg3NjY2IHwg
NjAgIDM0NTk5MjYuMTEwMjcKPiA+IDE3ICAgMzY2MDUyNS44NTgwNiB8IDM5ICAzNjA0MjUwLjE3
ODE5IHwgNjEgIDM2ODU0NDQuNDc1OTkKPiA+IDE4ICAgMzA0NTYyNy42OTA1NCB8IDQwICAzNTk2
NTQyLjI4NDI4IHwgNjIgIDMwNDk5NTkuMDgwOQo+ID4gMTkgICAyODQxNTQyLjk0MTc3IHwgNDEg
IDM2MDA3MDUuMTYwNTQgfCA2MyAgMjgwNjI4MC4wNDAxMwo+ID4gMjAgICAyODMwNDc1Ljk3MzQ4
IHwgNDIgIDMwMTk4MzMuNzExOTEgfCA2NCAgMzQ0ODQ5NC4zOTEzCj4gPiAyMSAgIDI4NDU2NTUu
NTU3ODkgfCA0MyAgMjc1Mjk1MS45MzI2NCB8Cj4gPiAyMiAgIDM0NTAzODkuODQzNjUgfCA0NCAg
Mjc1MzEwNy4yNzE2NCB8Cj4gPgo+ID4gSXQgY2FuIGJlIGZvdW5kIHRoYXQgd2hlbiB0aGUgdmFs
dWUgb2YgeHNrX2tpY2tfdGhyIGlzIHJlbGF0aXZlbHkgc21hbGwsCj4gPiB0aGUgcGVyZm9ybWFu
Y2UgaXMgbm90IGdvb2QsIGFuZCB3aGVuIGl0cyB2YWx1ZSBpcyBncmVhdGVyIHRoYW4gMTMsIHRo
ZQo+ID4gcGVyZm9ybWFuY2Ugd2lsbCBiZSBtb3JlIGlycmVndWxhciBhbmQgdW5zdGFibGUuIEl0
IGxvb2tzIHNpbWlsYXIgZnJvbSAzCj4gPiB0byAxMywgSSBjaG9zZSA4IGFzIHRoZSBkZWZhdWx0
IHZhbHVlLgo+ID4KPiA+IFRoZSB0ZXN0IGVudmlyb25tZW50IGlzIHFlbXUgKyB2aG9zdC1uZXQu
IEkgbW9kaWZpZWQgdmhvc3QtbmV0IHRvIGRyb3AKPiA+IHRoZSBwYWNrZXRzIHNlbnQgYnkgdm0g
ZGlyZWN0bHksIHNvIHRoYXQgdGhlIGNwdSBvZiB2bSBjYW4gcnVuIGhpZ2hlci4KPiA+IEJ5IGRl
ZmF1bHQsIHRoZSBwcm9jZXNzZXMgaW4gdGhlIHZtIGFuZCB0aGUgY3B1IG9mIHNvZnRpcnFkIGFy
ZSB0b28gbG93LAo+ID4gYW5kIHRoZXJlIGlzIG5vIG9idmlvdXMgZGlmZmVyZW5jZSBpbiB0aGUg
dGVzdCBkYXRhLgo+ID4KPiA+IER1cmluZyB0aGUgdGVzdCwgdGhlIGNwdSBvZiBzb2Z0aXJxIHJl
YWNoZWQgMTAwJS4gRWFjaCB4c2tfa2lja190aHIgd2FzCj4gPiBydW4gZm9yIDMwMHMsIHRoZSBw
cHMgb2YgZXZlcnkgc2Vjb25kIHdhcyByZWNvcmRlZCwgYW5kIHRoZSBhdmVyYWdlIG9mCj4gPiB0
aGUgcHBzIHdhcyBmaW5hbGx5IHRha2VuLiBUaGUgdmhvc3QgcHJvY2VzcyBjcHUgb24gdGhlIGhv
c3QgaGFzIGFsc28KPiA+IHJlYWNoZWQgMTAwJS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gUmV2aWV3ZWQtYnk6IER1c3Qg
TGkgPGR1c3QubGlAbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9uZXQv
dmlydGlvL3ZpcnRpb19uZXQuYyB8ICAxICsKPiA+ICAgZHJpdmVycy9uZXQvdmlydGlvL3hzay5j
ICAgICAgICB8IDE4ICsrKysrKysrKysrKysrKystLQo+ID4gICBkcml2ZXJzL25ldC92aXJ0aW8v
eHNrLmggICAgICAgIHwgIDIgKysKPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0
aW8vdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuYwo+ID4gaW5k
ZXggOTUwMzEzM2U3MWYwLi5kZmU1MDk5MzliNDUgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25l
dC92aXJ0aW8vdmlydGlvX25ldC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW8vdmlydGlv
X25ldC5jCj4gPiBAQCAtMTQsNiArMTQsNyBAQCBzdGF0aWMgYm9vbCBjc3VtID0gdHJ1ZSwgZ3Nv
ID0gdHJ1ZSwgbmFwaV90eCA9IHRydWU7Cj4gPiAgIG1vZHVsZV9wYXJhbShjc3VtLCBib29sLCAw
NDQ0KTsKPiA+ICAgbW9kdWxlX3BhcmFtKGdzbywgYm9vbCwgMDQ0NCk7Cj4gPiAgIG1vZHVsZV9w
YXJhbShuYXBpX3R4LCBib29sLCAwNjQ0KTsKPiA+ICttb2R1bGVfcGFyYW0oeHNrX2tpY2tfdGhy
LCBpbnQsIDA2NDQpOwo+ID4KPiA+ICAgLyogRklYTUU6IE1UVSBpbiBjb25maWcuICovCj4gPiAg
ICNkZWZpbmUgR09PRF9QQUNLRVRfTEVOIChFVEhfSExFTiArIFZMQU5fSExFTiArIEVUSF9EQVRB
X0xFTikKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMgYi9kcml2ZXJz
L25ldC92aXJ0aW8veHNrLmMKPiA+IGluZGV4IDM5NzNjODJkMWFkMi4uMmYzYmE2YWI0Nzk4IDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvL3hzay5jCj4gPiArKysgYi9kcml2ZXJz
L25ldC92aXJ0aW8veHNrLmMKPiA+IEBAIC01LDYgKzUsOCBAQAo+ID4KPiA+ICAgI2luY2x1ZGUg
InZpcnRpb19uZXQuaCIKPiA+Cj4gPiAraW50IHhza19raWNrX3RociA9IDg7Cj4gPiArCj4gPiAg
IHN0YXRpYyBzdHJ1Y3QgdmlydGlvX25ldF9oZHJfbXJnX3J4YnVmIHhza19oZHI7Cj4gPgo+ID4g
ICBzdGF0aWMgc3RydWN0IHZpcnRuZXRfeHNrX2N0eCAqdmlydG5ldF94c2tfY3R4X2dldChzdHJ1
Y3QgdmlydG5ldF94c2tfY3R4X2hlYWQgKmhlYWQpCj4gPiBAQCAtNDU1LDYgKzQ1Nyw3IEBAIHN0
YXRpYyBpbnQgdmlydG5ldF94c2tfeG1pdF9iYXRjaChzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsCj4g
PiAgIAlzdHJ1Y3QgeGRwX2Rlc2MgZGVzYzsKPiA+ICAgCWludCBlcnIsIHBhY2tldCA9IDA7Cj4g
PiAgIAlpbnQgcmV0ID0gLUVBR0FJTjsKPiA+ICsJaW50IG5lZWRfa2ljayA9IDA7Cj4gPgo+ID4g
ICAJd2hpbGUgKGJ1ZGdldC0tID4gMCkgewo+ID4gICAJCWlmIChzcS0+dnEtPm51bV9mcmVlIDwg
MiArIE1BWF9TS0JfRlJBR1MpIHsKPiA+IEBAIC00NzUsMTEgKzQ3OCwyMiBAQCBzdGF0aWMgaW50
IHZpcnRuZXRfeHNrX3htaXRfYmF0Y2goc3RydWN0IHNlbmRfcXVldWUgKnNxLAo+ID4gICAJCX0K
PiA+Cj4gPiAgIAkJKytwYWNrZXQ7Cj4gPiArCQkrK25lZWRfa2ljazsKPiA+ICsJCWlmIChuZWVk
X2tpY2sgPiB4c2tfa2lja190aHIpIHsKPiA+ICsJCQlpZiAodmlydHF1ZXVlX2tpY2tfcHJlcGFy
ZShzcS0+dnEpICYmCj4gPiArCQkJICAgIHZpcnRxdWV1ZV9ub3RpZnkoc3EtPnZxKSkKPiA+ICsJ
CQkJKytzdGF0cy0+a2lja3M7Cj4gPiArCj4gPiArCQkJbmVlZF9raWNrID0gMDsKPiA+ICsJCX0K
PiA+ICAgCX0KPiA+Cj4gPiAgIAlpZiAocGFja2V0KSB7Cj4gPiAtCQlpZiAodmlydHF1ZXVlX2tp
Y2tfcHJlcGFyZShzcS0+dnEpICYmIHZpcnRxdWV1ZV9ub3RpZnkoc3EtPnZxKSkKPiA+IC0JCQkr
K3N0YXRzLT5raWNrczsKPiA+ICsJCWlmIChuZWVkX2tpY2spIHsKPiA+ICsJCQlpZiAodmlydHF1
ZXVlX2tpY2tfcHJlcGFyZShzcS0+dnEpICYmCj4gPiArCQkJICAgIHZpcnRxdWV1ZV9ub3RpZnko
c3EtPnZxKSkKPiA+ICsJCQkJKytzdGF0cy0+a2lja3M7Cj4gPiArCQl9Cj4gPgo+ID4gICAJCSpk
b25lICs9IHBhY2tldDsKPiA+ICAgCQlzdGF0cy0+eGRwX3R4ICs9IHBhY2tldDsKPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmggYi9kcml2ZXJzL25ldC92aXJ0aW8veHNr
LmgKPiA+IGluZGV4IGZlMjJjZjc4ZDUwNS4uNGYwZjRmOWNmMjNiIDEwMDY0NAo+ID4gLS0tIGEv
ZHJpdmVycy9uZXQvdmlydGlvL3hzay5oCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW8veHNr
LmgKPiA+IEBAIC03LDYgKzcsOCBAQAo+ID4KPiA+ICAgI2RlZmluZSBWSVJUTkVUX1hTS19CVUZG
X0NUWCAgKCh2b2lkICopKHVuc2lnbmVkIGxvbmcpfjBMKQo+ID4KPiA+ICtleHRlcm4gaW50IHhz
a19raWNrX3RocjsKPiA+ICsKPiA+ICAgLyogV2hlbiB4c2sgZGlzYWJsZSwgdW5kZXIgbm9ybWFs
IGNpcmN1bXN0YW5jZXMsIHRoZSBuZXR3b3JrIGNhcmQgbXVzdCByZWNsYWltCj4gPiAgICAqIGFs
bCB0aGUgbWVtb3J5IHRoYXQgaGFzIGJlZW4gc2VudCBhbmQgdGhlIG1lbW9yeSBhZGRlZCB0byB0
aGUgcnEgcXVldWUgYnkKPiA+ICAgICogZGVzdHJveWluZyB0aGUgcXVldWUuCj4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
