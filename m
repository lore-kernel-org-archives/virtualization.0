Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEE6C2B9F4
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 06:44:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC120613D5
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 06:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC120613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DB3F83DA7;
	Thu, 17 Jun 2021 06:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VgvidqgOYnHX; Thu, 17 Jun 2021 06:44:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2525783D65;
	Thu, 17 Jun 2021 06:44:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01FFAC000E;
	Thu, 17 Jun 2021 06:44:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04E23C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E631F404F5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:44:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mvn5tPn_qNHm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:44:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A86F40150
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:44:31 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R581e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0UchRO0z_1623912267; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UchRO0z_1623912267) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Jun 2021 14:44:27 +0800
MIME-Version: 1.0
Message-Id: <1623912182.5295095-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 15/15] virtio-net: xsk zero copy xmit kick by
 threshold
Date: Thu, 17 Jun 2021 14:43:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <3a7142e0-e4d7-e6c3-a7c0-02df891f42a5@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust.li" <dust.li@linux.alibaba.com>,
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

T24gVGh1LCAxNyBKdW4gMjAyMSAxNDowMDo0MCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMS82LzE3IOS4i+WNiDE6NTYsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBPbiBUaHUsIDE3IEp1biAyMDIxIDExOjA4OjM0ICswODAwLCBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+PiDlnKggMjAyMS82LzEwIOS4i+WN
iDQ6MjIsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPj4+IEFmdGVyIHRlc3RpbmcsIHRoZSBwZXJmb3Jt
YW5jZSBvZiBjYWxsaW5nIGtpY2sgZXZlcnkgdGltZSBpcyBub3Qgc3RhYmxlLgo+ID4+PiBBbmQg
aWYgYWxsIHRoZSBwYWNrZXRzIGFyZSBzZW50IGFuZCBraWNrZWQgYWdhaW4sIHRoZSBwZXJmb3Jt
YW5jZSBpcyBub3QKPiA+Pj4gZ29vZC4gU28gYWRkIGEgbW9kdWxlIHBhcmFtZXRlciB0byBzcGVj
aWZ5IGhvdyBtYW55IHBhY2tldHMgYXJlIHNlbnQgdG8KPiA+Pj4gY2FsbCBhIGtpY2suCj4gPj4+
Cj4gPj4+IDggaXMgYSByZWxhdGl2ZWx5IHN0YWJsZSB2YWx1ZSB3aXRoIHRoZSBiZXN0IHBlcmZv
cm1hbmNlLgo+ID4+Pgo+ID4+PiBIZXJlIGlzIHRoZSBwcHMgb2YgdGhlIHRlc3Qgb2YgeHNrX2tp
Y2tfdGhyIHVuZGVyIGRpZmZlcmVudCB2YWx1ZXMgKGZyb20KPiA+Pj4gMSB0byA2NCkuCj4gPj4+
Cj4gPj4+IHRociAgUFBTICAgICAgICAgICAgIHRociBQUFMgICAgICAgICAgICAgdGhyIFBQUwo+
ID4+PiAxICAgIDI5MjQxMTYuNzQyNDcgfCAyMyAgMzY4MzI2My4wNDM0OCB8IDQ1ICAyNzc3OTA3
LjIyOTYzCj4gPj4+IDIgICAgMzQ0MTAxMC41NzE5MSB8IDI0ICAzMDc4ODgwLjEzMDQzIHwgNDYg
IDI3ODEzNzYuMjE3MzkKPiA+Pj4gMyAgICAzNjM2NzI4LjcyMzc4IHwgMjUgIDI4NTkyMTkuNTc2
NTYgfCA0NyAgMjc3NzI3MS45MTMwNAo+ID4+PiA0ICAgIDM2Mzc1MTguNjE0NjggfCAyNiAgMjg1
MTU1Ny45NTkzICB8IDQ4ICAyODAwMzIwLjU2NTc1Cj4gPj4+IDUgICAgMzY1MTczOC4xNjI1MSB8
IDI3ICAyODM0NzgzLjU0NDA4IHwgNDkgIDI4MTMwMzkuODc1OTkKPiA+Pj4gNiAgICAzNjUyMTc2
LjY5MjMxIHwgMjggIDI4NDcwMTIuNDE0NzIgfCA1MCAgMzQ0NTE0My4wMTgzOQo+ID4+PiA3ICAg
IDM2NjU0MTUuODA2MDIgfCAyOSAgMjg2MDYzMy45MTMwNCB8IDUxICAzNjY2OTE4LjAxMjgxCj4g
Pj4+IDggICAgMzY2NTA0NS4xNjU1NSB8IDMwICAyODU3OTAzLjU3ODYgIHwgNTIgIDMwNTk5Mjku
MjcwOQo+ID4+Cj4gPj4gSSB3b25kZXIgd2hhdCdzIHRoZSBudW1iZXIgZm9yIHRoZSBjYXNlIG9m
IG5vbiB6YyB4c2s/Cj4gPgo+ID4gVGhlc2UgZGF0YSBhcmUgdXNlZCB0byBjb21wYXJlIHRoZSBz
aXR1YXRpb24gb2Ygc2VuZGluZyBkaWZmZXJlbnQgbnVtYmVycyBvZgo+ID4gcGFja2V0cyB0byB2
aXJ0aW8gYXQgb25lIHRpbWUuIEkgdGhpbmsgaXQgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCBub24t
emVyb2NvcHkKPiA+IHhzay4KPgo+Cj4gWWVzLCBidXQgaXQgd291bGQgYmUgaGVscGZ1bCB0byBz
ZWUgaG93IG11Y2ggd2UgY2FuIGdhaW4gZnJvbSB6ZXJvY29weS4KCk9rYXksIEkgd2lsbCBhZGQg
dGhlIHBlcmZvcm1hbmNlIGRhdGEgb2Ygbm8temVyb2NvcHkgeHNrIGluIHRoZSBuZXh0IHBhdGNo
IHNldC4KClRoYW5rcy4KCj4KPiBUaGFua3MKPgo+Cj4gPgo+ID4gVGhhbmtzLgo+ID4KPiA+PiBU
aGFua3MKPiA+Pgo+ID4+Cj4gPj4+IDkgICAgMzY3MTAyMy4yNDAxICB8IDMxICAyODM1NTg5Ljk4
OTYzIHwgNTMgIDI4MzE1MTUuMjE3MzkKPiA+Pj4gMTAgICAzNjY5NTMyLjIzMjc0IHwgMzIgIDI4
NjI4MjcuODg3MDYgfCA1NCAgMzQ1MTgwNC4wNzIwNAo+ID4+PiAxMSAgIDM2NjYxNjAuMzc3NDkg
fCAzMyAgMjg3MTg1NS45NjY5NiB8IDU1ICAzNjU0OTc1LjkyMzg1Cj4gPj4+IDEyICAgMzY3NDk1
MS40NDgxMyB8IDM0ICAzNDM0NDU2LjQ0ODE2IHwgNTYgIDM2NzYxOTguMzE4OAo+ID4+PiAxMyAg
IDM2Njc0NDcuNTczMzEgfCAzNSAgMzY1NjkxOC41NDE3NyB8IDU3ICAzNjg0NzQwLjg1NjE5Cj4g
Pj4+IDE0ICAgMzAxODg0Ni4wNTAzICB8IDM2ICAzNTk2OTIxLjE2NzIyIHwgNTggIDMwNjA5NTgu
ODU5NAo+ID4+PiAxNSAgIDI3OTI3NzMuODQ1MDUgfCAzNyAgMzYwMzQ2MC42MzkwMyB8IDU5ICAy
ODI4ODc0LjU3MTkxCj4gPj4+IDE2ICAgMzQzMDU5Ni4zNjAyICB8IDM4ICAzNTk1NDEwLjg3NjY2
IHwgNjAgIDM0NTk5MjYuMTEwMjcKPiA+Pj4gMTcgICAzNjYwNTI1Ljg1ODA2IHwgMzkgIDM2MDQy
NTAuMTc4MTkgfCA2MSAgMzY4NTQ0NC40NzU5OQo+ID4+PiAxOCAgIDMwNDU2MjcuNjkwNTQgfCA0
MCAgMzU5NjU0Mi4yODQyOCB8IDYyICAzMDQ5OTU5LjA4MDkKPiA+Pj4gMTkgICAyODQxNTQyLjk0
MTc3IHwgNDEgIDM2MDA3MDUuMTYwNTQgfCA2MyAgMjgwNjI4MC4wNDAxMwo+ID4+PiAyMCAgIDI4
MzA0NzUuOTczNDggfCA0MiAgMzAxOTgzMy43MTE5MSB8IDY0ICAzNDQ4NDk0LjM5MTMKPiA+Pj4g
MjEgICAyODQ1NjU1LjU1Nzg5IHwgNDMgIDI3NTI5NTEuOTMyNjQgfAo+ID4+PiAyMiAgIDM0NTAz
ODkuODQzNjUgfCA0NCAgMjc1MzEwNy4yNzE2NCB8Cj4gPj4+Cj4gPj4+IEl0IGNhbiBiZSBmb3Vu
ZCB0aGF0IHdoZW4gdGhlIHZhbHVlIG9mIHhza19raWNrX3RociBpcyByZWxhdGl2ZWx5IHNtYWxs
LAo+ID4+PiB0aGUgcGVyZm9ybWFuY2UgaXMgbm90IGdvb2QsIGFuZCB3aGVuIGl0cyB2YWx1ZSBp
cyBncmVhdGVyIHRoYW4gMTMsIHRoZQo+ID4+PiBwZXJmb3JtYW5jZSB3aWxsIGJlIG1vcmUgaXJy
ZWd1bGFyIGFuZCB1bnN0YWJsZS4gSXQgbG9va3Mgc2ltaWxhciBmcm9tIDMKPiA+Pj4gdG8gMTMs
IEkgY2hvc2UgOCBhcyB0aGUgZGVmYXVsdCB2YWx1ZS4KPiA+Pj4KPiA+Pj4gVGhlIHRlc3QgZW52
aXJvbm1lbnQgaXMgcWVtdSArIHZob3N0LW5ldC4gSSBtb2RpZmllZCB2aG9zdC1uZXQgdG8gZHJv
cAo+ID4+PiB0aGUgcGFja2V0cyBzZW50IGJ5IHZtIGRpcmVjdGx5LCBzbyB0aGF0IHRoZSBjcHUg
b2Ygdm0gY2FuIHJ1biBoaWdoZXIuCj4gPj4+IEJ5IGRlZmF1bHQsIHRoZSBwcm9jZXNzZXMgaW4g
dGhlIHZtIGFuZCB0aGUgY3B1IG9mIHNvZnRpcnFkIGFyZSB0b28gbG93LAo+ID4+PiBhbmQgdGhl
cmUgaXMgbm8gb2J2aW91cyBkaWZmZXJlbmNlIGluIHRoZSB0ZXN0IGRhdGEuCj4gPj4+Cj4gPj4+
IER1cmluZyB0aGUgdGVzdCwgdGhlIGNwdSBvZiBzb2Z0aXJxIHJlYWNoZWQgMTAwJS4gRWFjaCB4
c2tfa2lja190aHIgd2FzCj4gPj4+IHJ1biBmb3IgMzAwcywgdGhlIHBwcyBvZiBldmVyeSBzZWNv
bmQgd2FzIHJlY29yZGVkLCBhbmQgdGhlIGF2ZXJhZ2Ugb2YKPiA+Pj4gdGhlIHBwcyB3YXMgZmlu
YWxseSB0YWtlbi4gVGhlIHZob3N0IHByb2Nlc3MgY3B1IG9uIHRoZSBob3N0IGhhcyBhbHNvCj4g
Pj4+IHJlYWNoZWQgMTAwJS4KPiA+Pj4KPiA+Pj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4
dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+Pj4gUmV2aWV3ZWQtYnk6IER1c3QgTGkgPGR1
c3QubGlAbGludXguYWxpYmFiYS5jb20+Cj4gPj4+IC0tLQo+ID4+PiAgICBkcml2ZXJzL25ldC92
aXJ0aW8vdmlydGlvX25ldC5jIHwgIDEgKwo+ID4+PiAgICBkcml2ZXJzL25ldC92aXJ0aW8veHNr
LmMgICAgICAgIHwgMTggKysrKysrKysrKysrKysrKy0tCj4gPj4+ICAgIGRyaXZlcnMvbmV0L3Zp
cnRpby94c2suaCAgICAgICAgfCAgMiArKwo+ID4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDE5IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPj4+Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC92aXJ0aW8vdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19u
ZXQuYwo+ID4+PiBpbmRleCA5NTAzMTMzZTcxZjAuLmRmZTUwOTkzOWI0NSAxMDA2NDQKPiA+Pj4g
LS0tIGEvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuYwo+ID4+PiArKysgYi9kcml2ZXJz
L25ldC92aXJ0aW8vdmlydGlvX25ldC5jCj4gPj4+IEBAIC0xNCw2ICsxNCw3IEBAIHN0YXRpYyBi
b29sIGNzdW0gPSB0cnVlLCBnc28gPSB0cnVlLCBuYXBpX3R4ID0gdHJ1ZTsKPiA+Pj4gICAgbW9k
dWxlX3BhcmFtKGNzdW0sIGJvb2wsIDA0NDQpOwo+ID4+PiAgICBtb2R1bGVfcGFyYW0oZ3NvLCBi
b29sLCAwNDQ0KTsKPiA+Pj4gICAgbW9kdWxlX3BhcmFtKG5hcGlfdHgsIGJvb2wsIDA2NDQpOwo+
ID4+PiArbW9kdWxlX3BhcmFtKHhza19raWNrX3RociwgaW50LCAwNjQ0KTsKPiA+Pj4KPiA+Pj4g
ICAgLyogRklYTUU6IE1UVSBpbiBjb25maWcuICovCj4gPj4+ICAgICNkZWZpbmUgR09PRF9QQUNL
RVRfTEVOIChFVEhfSExFTiArIFZMQU5fSExFTiArIEVUSF9EQVRBX0xFTikKPiA+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpby94c2suYyBiL2RyaXZlcnMvbmV0L3ZpcnRpby94c2su
Ywo+ID4+PiBpbmRleCAzOTczYzgyZDFhZDIuLjJmM2JhNmFiNDc5OCAxMDA2NDQKPiA+Pj4gLS0t
IGEvZHJpdmVycy9uZXQvdmlydGlvL3hzay5jCj4gPj4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRp
by94c2suYwo+ID4+PiBAQCAtNSw2ICs1LDggQEAKPiA+Pj4KPiA+Pj4gICAgI2luY2x1ZGUgInZp
cnRpb19uZXQuaCIKPiA+Pj4KPiA+Pj4gK2ludCB4c2tfa2lja190aHIgPSA4Owo+ID4+PiArCj4g
Pj4+ICAgIHN0YXRpYyBzdHJ1Y3QgdmlydGlvX25ldF9oZHJfbXJnX3J4YnVmIHhza19oZHI7Cj4g
Pj4+Cj4gPj4+ICAgIHN0YXRpYyBzdHJ1Y3QgdmlydG5ldF94c2tfY3R4ICp2aXJ0bmV0X3hza19j
dHhfZ2V0KHN0cnVjdCB2aXJ0bmV0X3hza19jdHhfaGVhZCAqaGVhZCkKPiA+Pj4gQEAgLTQ1NSw2
ICs0NTcsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeHNrX3htaXRfYmF0Y2goc3RydWN0IHNlbmRf
cXVldWUgKnNxLAo+ID4+PiAgICAJc3RydWN0IHhkcF9kZXNjIGRlc2M7Cj4gPj4+ICAgIAlpbnQg
ZXJyLCBwYWNrZXQgPSAwOwo+ID4+PiAgICAJaW50IHJldCA9IC1FQUdBSU47Cj4gPj4+ICsJaW50
IG5lZWRfa2ljayA9IDA7Cj4gPj4+Cj4gPj4+ICAgIAl3aGlsZSAoYnVkZ2V0LS0gPiAwKSB7Cj4g
Pj4+ICAgIAkJaWYgKHNxLT52cS0+bnVtX2ZyZWUgPCAyICsgTUFYX1NLQl9GUkFHUykgewo+ID4+
PiBAQCAtNDc1LDExICs0NzgsMjIgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hza194bWl0X2JhdGNo
KHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwKPiA+Pj4gICAgCQl9Cj4gPj4+Cj4gPj4+ICAgIAkJKytw
YWNrZXQ7Cj4gPj4+ICsJCSsrbmVlZF9raWNrOwo+ID4+PiArCQlpZiAobmVlZF9raWNrID4geHNr
X2tpY2tfdGhyKSB7Cj4gPj4+ICsJCQlpZiAodmlydHF1ZXVlX2tpY2tfcHJlcGFyZShzcS0+dnEp
ICYmCj4gPj4+ICsJCQkgICAgdmlydHF1ZXVlX25vdGlmeShzcS0+dnEpKQo+ID4+PiArCQkJCSsr
c3RhdHMtPmtpY2tzOwo+ID4+PiArCj4gPj4+ICsJCQluZWVkX2tpY2sgPSAwOwo+ID4+PiArCQl9
Cj4gPj4+ICAgIAl9Cj4gPj4+Cj4gPj4+ICAgIAlpZiAocGFja2V0KSB7Cj4gPj4+IC0JCWlmICh2
aXJ0cXVldWVfa2lja19wcmVwYXJlKHNxLT52cSkgJiYgdmlydHF1ZXVlX25vdGlmeShzcS0+dnEp
KQo+ID4+PiAtCQkJKytzdGF0cy0+a2lja3M7Cj4gPj4+ICsJCWlmIChuZWVkX2tpY2spIHsKPiA+
Pj4gKwkJCWlmICh2aXJ0cXVldWVfa2lja19wcmVwYXJlKHNxLT52cSkgJiYKPiA+Pj4gKwkJCSAg
ICB2aXJ0cXVldWVfbm90aWZ5KHNxLT52cSkpCj4gPj4+ICsJCQkJKytzdGF0cy0+a2lja3M7Cj4g
Pj4+ICsJCX0KPiA+Pj4KPiA+Pj4gICAgCQkqZG9uZSArPSBwYWNrZXQ7Cj4gPj4+ICAgIAkJc3Rh
dHMtPnhkcF90eCArPSBwYWNrZXQ7Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0
aW8veHNrLmggYi9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmgKPiA+Pj4gaW5kZXggZmUyMmNmNzhk
NTA1Li40ZjBmNGY5Y2YyM2IgMTAwNjQ0Cj4gPj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpby94
c2suaAo+ID4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmgKPiA+Pj4gQEAgLTcsNiAr
Nyw4IEBACj4gPj4+Cj4gPj4+ICAgICNkZWZpbmUgVklSVE5FVF9YU0tfQlVGRl9DVFggICgodm9p
ZCAqKSh1bnNpZ25lZCBsb25nKX4wTCkKPiA+Pj4KPiA+Pj4gK2V4dGVybiBpbnQgeHNrX2tpY2tf
dGhyOwo+ID4+PiArCj4gPj4+ICAgIC8qIFdoZW4geHNrIGRpc2FibGUsIHVuZGVyIG5vcm1hbCBj
aXJjdW1zdGFuY2VzLCB0aGUgbmV0d29yayBjYXJkIG11c3QgcmVjbGFpbQo+ID4+PiAgICAgKiBh
bGwgdGhlIG1lbW9yeSB0aGF0IGhhcyBiZWVuIHNlbnQgYW5kIHRoZSBtZW1vcnkgYWRkZWQgdG8g
dGhlIHJxIHF1ZXVlIGJ5Cj4gPj4+ICAgICAqIGRlc3Ryb3lpbmcgdGhlIHF1ZXVlLgo+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
