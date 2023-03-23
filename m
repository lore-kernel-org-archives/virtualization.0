Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75DAC6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 03:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F8A2820E6;
	Thu, 23 Mar 2023 03:46:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F8A2820E6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 335Yvh2g7GFc; Thu, 23 Mar 2023 03:46:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 788238198A;
	Thu, 23 Mar 2023 03:46:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 788238198A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FA3CC0035;
	Thu, 23 Mar 2023 03:46:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5203AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E7E481C93
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:46:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E7E481C93
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k4YfwO42Rs37
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:46:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 930AC8198A
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 930AC8198A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:46:26 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R231e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VeShdPK_1679543179; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeShdPK_1679543179) by smtp.aliyun-inc.com;
 Thu, 23 Mar 2023 11:46:19 +0800
Message-ID: <1679543111.9544318-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 1/8] virtio_net: mergeable xdp: put old page
 immediately
Date: Thu, 23 Mar 2023 11:45:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230322030308.16046-2-xuanzhuo@linux.alibaba.com>
 <4bd07874-b1ad-336b-b15e-ba56a10182e9@huawei.com>
 <1679535365.5410192-1-xuanzhuo@linux.alibaba.com>
 <941a16c5-ba64-ca49-9af9-68d9615dca00@huawei.com>
In-Reply-To: <941a16c5-ba64-ca49-9af9-68d9615dca00@huawei.com>
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

T24gVGh1LCAyMyBNYXIgMjAyMyAxMTozODozNCArMDgwMCwgWXVuc2hlbmcgTGluIDxsaW55dW5z
aGVuZ0BodWF3ZWkuY29tPiB3cm90ZToKPiBPbiAyMDIzLzMvMjMgOTozNiwgWHVhbiBaaHVvIHdy
b3RlOgo+ID4gT24gV2VkLCAyMiBNYXIgMjAyMyAxNjoyMjoxOCArMDgwMCwgWXVuc2hlbmcgTGlu
IDxsaW55dW5zaGVuZ0BodWF3ZWkuY29tPiB3cm90ZToKPiA+PiBPbiAyMDIzLzMvMjIgMTE6MDMs
IFh1YW4gWmh1byB3cm90ZToKPiA+Pj4gSW4gdGhlIHhkcCBpbXBsZW1lbnRhdGlvbiBvZiB2aXJ0
aW8tbmV0IG1lcmdlYWJsZSwgaXQgYWx3YXlzIGNoZWNrcwo+ID4+PiB3aGV0aGVyIHR3byBwYWdl
IGlzIHVzZWQgYW5kIGEgcGFnZSBpcyBzZWxlY3RlZCB0byByZWxlYXNlLiBUaGlzIGlzCj4gPj4+
IGNvbXBsaWNhdGVkIGZvciB0aGUgcHJvY2Vzc2luZyBvZiBhY3Rpb24sIGFuZCBiZSBjYXJlZnVs
Lgo+ID4+Pgo+ID4+PiBJbiB0aGUgZW50aXJlIHByb2Nlc3MsIHdlIGhhdmUgc3VjaCBwcmluY2lw
bGVzOgo+ID4+PiAqIElmIHhkcF9wYWdlIGlzIHVzZWQgKFBBU1MsIFRYLCBSZWRpcmVjdCksIHRo
ZW4gd2UgcmVsZWFzZSB0aGUgb2xkCj4gPj4+ICAgcGFnZS4KPiA+Pj4gKiBJZiBpdCBpcyBhIGRy
b3AgY2FzZSwgd2Ugd2lsbCByZWxlYXNlIHR3by4gVGhlIG9sZCBwYWdlIG9idGFpbmVkIGZyb20K
PiA+Pj4gICBidWYgaXMgcmVsZWFzZSBpbnNpZGUgZXJyX3hkcCwgYW5kIHhkcF9wYWdlIG5lZWRz
IGJlIHJlbGFzZWQgYnkgdXMuCj4gPj4+Cj4gPj4+IEJ1dCBpbiBmYWN0LCB3aGVuIHdlIGFsbG9j
YXRlIGEgbmV3IHBhZ2UsIHdlIGNhbiByZWxlYXNlIHRoZSBvbGQgcGFnZQo+ID4+PiBpbW1lZGlh
dGVseS4gVGhlbiBqdXN0IG9uZSBpcyB1c2luZywgd2UganVzdCBuZWVkIHRvIHJlbGVhc2UgdGhl
IG5ldwo+ID4+PiBwYWdlIGZvciBkcm9wIGNhc2UuIE9uIHRoZSBkcm9wIHBhdGgsIGVycl94ZHAg
d2lsbCByZWxlYXNlIHRoZSB2YXJpYWJsZQo+ID4+PiAicGFnZSIsIHNvIHdlIG9ubHkgbmVlZCB0
byBsZXQgInBhZ2UiIHBvaW50IHRvIHRoZSBuZXcgeGRwX3BhZ2UgaW4KPiA+Pj4gYWR2YW5jZS4K
PiA+Pj4KPiA+Pj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGli
YWJhLmNvbT4KPiA+Pj4gLS0tCj4gPj4+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAxNSAr
KysrKystLS0tLS0tLS0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDkg
ZGVsZXRpb25zKC0pCj4gPj4+Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+Pj4gaW5kZXggZTI1NjBiNmY3OTgw
Li40ZDJiZjFjZTA3MzAgMTAwNjQ0Cj4gPj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+ID4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+Pj4gQEAgLTEyNDUsNiAr
MTI0NSw5IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0
IG5ldF9kZXZpY2UgKmRldiwKPiA+Pj4gIAkJCWlmICgheGRwX3BhZ2UpCj4gPj4+ICAJCQkJZ290
byBlcnJfeGRwOwo+ID4+PiAgCQkJb2Zmc2V0ID0gVklSVElPX1hEUF9IRUFEUk9PTTsKPiA+Pj4g
Kwo+ID4+PiArCQkJcHV0X3BhZ2UocGFnZSk7Cj4gPj4KPiA+PiB0aGUgZXJyb3IgaGFuZGxpbmcg
b2YgeGRwX2xpbmVhcml6ZV9wYWdlKCkgZG9lcyBub3Qgc2VlbXMgc2VsZiBjb250YWluZWQuCj4g
Pj4gRG9lcyBpdCBub3Qgc2VlbSBiZXR0ZXLvvJoKPiA+PiAxLiBpZiB4ZHBfbGluZWFyaXplX3Bh
Z2UoKSBzdWNjZXNlZCwgY2FsbCBwdXRfcGFnZSgpIGZvciBmaXJzdCBidWZmZXIganVzdAo+ID4+
ICAgIGFzIHB1dF9wYWdlKCkgaXMgY2FsbCBmb3Igb3RoZXIgYnVmZmVyCj4gPj4gMi4gb3IgY2Fs
bCB2aXJ0cXVldWVfZ2V0X2J1ZigpIGFuZCBwdXRfcGFnZSgpIGZvciBhbGwgdGhlIGJ1ZmZlciBv
ZiB0aGUgcGFja2V0Cj4gPj4gICAgc28gdGhlIGVycm9yIGhhbmRsaW5nIGlzIG5vdCBuZWVkZWQg
b3V0c2lkZSB0aGUgdmlydHF1ZXVlX2dldF9idWYoKS4KPiA+Pgo+ID4+IEluIHRoYXQgY2FzZSwg
aXQgc2VlbXMgd2UgY2FuIGp1c3QgZG8gYmVsb3cgd2l0aG91dCB4ZHBfcGFnZToKPiA+PiBwYWdl
ID0geGRwX2xpbmVhcml6ZV9wYWdlKHJxLCBudW1fYnVmLCBwYWdlLCAuLi4pOwo+ID4KPiA+Cj4g
PiBUaGlzIGRvZXMgbG9vayBiZXR0ZXIuCj4gPgo+ID4gSW4gZmFjdCwgd2UgYWxyZWFkeSBoYXZl
IHZxIHJlc2V0LCB3ZSBjYW4gbG9hZCBYRFAgYmFzZWQgb24gdnEgcmVzZXQuCj4gPiBJbiB0aGlz
IHdheSwgd2UgY2FuIHJ1biB3aXRob3V0IHhkcF9saW5lYXJpemVfcGFnZS4KPgo+IEZvciBjb21w
YXRpYmlsaXR5LCBpdCBpcyBzdGlsbCBuZWVkZWQsIHJpZ2h0PwoKWWVzCgoKPgo+ID4KPiA+Cj4g
Pj4KPiA+Pgo+ID4+PiArCQkJcGFnZSA9IHhkcF9wYWdlOwo+ID4+PiAgCQl9IGVsc2UgaWYgKHVu
bGlrZWx5KGhlYWRyb29tIDwgdmlydG5ldF9nZXRfaGVhZHJvb20odmkpKSkgewo+ID4+PiAgCQkJ
eGRwX3Jvb20gPSBTS0JfREFUQV9BTElHTihWSVJUSU9fWERQX0hFQURST09NICsKPiA+Pj4gIAkJ
CQkJCSAgc2l6ZW9mKHN0cnVjdCBza2Jfc2hhcmVkX2luZm8pKTsKPiA+Pj4gQEAgLTEyNTksNiAr
MTI2Miw5IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0
IG5ldF9kZXZpY2UgKmRldiwKPiA+Pj4gIAkJCSAgICAgICBwYWdlX2FkZHJlc3MocGFnZSkgKyBv
ZmZzZXQsIGxlbik7Cj4gPj4+ICAJCQlmcmFtZV9zeiA9IFBBR0VfU0laRTsKPiA+Pj4gIAkJCW9m
ZnNldCA9IFZJUlRJT19YRFBfSEVBRFJPT007Cj4gPj4+ICsKPiA+Pj4gKwkJCXB1dF9wYWdlKHBh
Z2UpOwo+ID4+PiArCQkJcGFnZSA9IHhkcF9wYWdlOwo+ID4+Cj4gPj4gSXQgc2VlbXMgd2UgY2Fu
IGxpbWl0IHRoZSBzY29wZSBvZiB4ZHBfcGFnZSBpbiB0aGlzICJlbHNlIGlmIiBibG9jay4KPiA+
Pgo+ID4+PiAgCQl9IGVsc2Ugewo+ID4+PiAgCQkJeGRwX3BhZ2UgPSBwYWdlOwo+ID4+PiAgCQl9
Cj4gPj4KPiA+PiBJdCBzZWVtcyB0aGUgYWJvdmUgZWxzZSBibG9jayBpcyBub3QgbmVlZGVkIGFu
eW1vcmUuCj4gPgo+ID4gWWVzLCB0aGUgZm9sbG93LXVwIHBhdGNoIGhhcyB0aGlzIG9wdGltaXph
dGlvbi4KPgo+IElzbid0IHJlZm9jdG9yIHBhdGNoIHN1cHBvc2VkIHRvIGJlIHNlbGYtY29udGlh
bmVkIHRvbywgaW5zdGVhZCBvZgo+IGRlcGVuZGluZyBvbiBmb2xsb3ctdXAgcGF0Y2g/CgoKSSBt
ZWFuIHRoYXQgdGhlICMyIHBhdGNoIGRvIHRoaXMuCgpUaGFua3MuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
