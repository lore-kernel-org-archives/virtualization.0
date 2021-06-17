Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22ADC2B9F4
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 05:56:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554B361245
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 05:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554B361245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C7A360757;
	Thu, 17 Jun 2021 05:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1DuaR9b6XOvK; Thu, 17 Jun 2021 05:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A670360761;
	Thu, 17 Jun 2021 05:56:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79F13C000D;
	Thu, 17 Jun 2021 05:56:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE8D4C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BEF5660761
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vEvAICNc6lgU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:56:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C09EF60757
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 05:56:29 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R991e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0Uch4uwz_1623909386; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Uch4uwz_1623909386) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Jun 2021 13:56:26 +0800
MIME-Version: 1.0
Message-Id: <1623909331.6403847-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 14/15] virtio-net: xsk direct xmit inside xsk
 wakeup
Date: Thu, 17 Jun 2021 13:55:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <c5d955f5-6c8b-03df-9e16-56b700aa9f22@redhat.com>
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

T24gVGh1LCAxNyBKdW4gMjAyMSAxMTowNzoxNyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMS82LzEwIOS4i+WNiDQ6MjIsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBDYWxsaW5nIHZpcnRxdWV1ZV9uYXBpX3NjaGVkdWxlKCkgaW4gd2FrZXVw
IHJlc3VsdHMgaW4gbmFwaSBydW5uaW5nIG9uCj4gPiB0aGUgY3VycmVudCBjcHUuIElmIHRoZSBh
cHBsaWNhdGlvbiBpcyBub3QgYnVzeSwgdGhlbiB0aGVyZSBpcyBubwo+ID4gcHJvYmxlbS4gQnV0
IGlmIHRoZSBhcHBsaWNhdGlvbiBpdHNlbGYgaXMgYnVzeSwgaXQgd2lsbCBjYXVzZSBhIGxvdCBv
Zgo+ID4gc2NoZWR1bGluZy4KPiA+Cj4gPiBJZiB0aGUgYXBwbGljYXRpb24gaXMgY29udGludW91
c2x5IHNlbmRpbmcgZGF0YSBwYWNrZXRzLCBkdWUgdG8gdGhlCj4gPiBjb250aW51b3VzIHNjaGVk
dWxpbmcgYmV0d2VlbiB0aGUgYXBwbGljYXRpb24gYW5kIG5hcGksIHRoZSBkYXRhIHBhY2tldAo+
ID4gdHJhbnNtaXNzaW9uIHdpbGwgbm90IGJlIHNtb290aCwgYW5kIHRoZXJlIHdpbGwgYmUgYW4g
b2J2aW91cyBkZWxheSBpbgo+ID4gdGhlIHRyYW5zbWlzc2lvbiAoeW91IGNhbiB1c2UgdGNwZHVt
cCB0byBzZWUgaXQpLiBXaGVuIHByZXNzaW5nIGEKPiA+IGNoYW5uZWwgdG8gMTAwJSAodmhvc3Qg
cmVhY2hlcyAxMDAlKSwgdGhlIGNwdSB3aGVyZSB0aGUgYXBwbGljYXRpb24gaXMKPiA+IGxvY2F0
ZWQgcmVhY2hlcyAxMDAlLgo+ID4KPiA+IFRoaXMgcGF0Y2ggc2VuZHMgYSBzbWFsbCBhbW91bnQg
b2YgZGF0YSBkaXJlY3RseSBpbiB3YWtldXAuIFRoZSBwdXJwb3NlCj4gPiBvZiB0aGlzIGlzIHRv
IHRyaWdnZXIgdGhlIHR4IGludGVycnVwdC4gVGhlIHR4IGludGVycnVwdCB3aWxsIGJlCj4gPiBh
d2FrZW5lZCBvbiB0aGUgY3B1IG9mIGl0cyBhZmZpbml0eSwgYW5kIHRoZW4gdHJpZ2dlciB0aGUg
b3BlcmF0aW9uIG9mCj4gPiB0aGUgbmFwaSBtZWNoYW5pc20sIG5hcGkgY2FuIGNvbnRpbnVlIHRv
IGNvbnN1bWUgdGhlIHhzayB0eCBxdWV1ZS4gVHdvCj4gPiBjcHVzIGFyZSBydW5uaW5nLCBjcHUw
IGlzIHJ1bm5pbmcgYXBwbGljYXRpb25zLCBjcHUxIGV4ZWN1dGVzCj4gPiBuYXBpIGNvbnN1bXB0
aW9uIGRhdGEuIFRoZSBzYW1lIGlzIHRvIHByZXNzIGEgY2hhbm5lbCB0byAxMDAlLCBidXQgdGhl
Cj4gPiB1dGlsaXphdGlvbiByYXRlIG9mIGNwdTAgaXMgMTIuNyUgYW5kIHRoZSB1dGlsaXphdGlv
biByYXRlIG9mIGNwdTEgaXMKPiA+IDIuOSUuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBa
aHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL25l
dC92aXJ0aW8veHNrLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMgYi9kcml2ZXJzL25ldC92aXJ0aW8v
eHNrLmMKPiA+IGluZGV4IDM2Y2RhMmRjZjhlNy4uMzk3M2M4MmQxYWQyIDEwMDY0NAo+ID4gLS0t
IGEvZHJpdmVycy9uZXQvdmlydGlvL3hzay5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW8v
eHNrLmMKPiA+IEBAIC01NDcsNiArNTQ3LDcgQEAgaW50IHZpcnRuZXRfeHNrX3dha2V1cChzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2LCB1MzIgcWlkLCB1MzIgZmxhZykKPiA+ICAgewo+ID4gICAJc3Ry
dWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYpOwo+ID4gICAJc3RydWN0IHhz
a19idWZmX3Bvb2wgKnBvb2w7Cj4gPiArCXN0cnVjdCBuZXRkZXZfcXVldWUgKnR4cTsKPiA+ICAg
CXN0cnVjdCBzZW5kX3F1ZXVlICpzcTsKPiA+Cj4gPiAgIAlpZiAoIW5ldGlmX3J1bm5pbmcoZGV2
KSkKPiA+IEBAIC01NTksMTEgKzU2MCwyOCBAQCBpbnQgdmlydG5ldF94c2tfd2FrZXVwKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYsIHUzMiBxaWQsIHUzMiBmbGFnKQo+ID4KPiA+ICAgCXJjdV9yZWFk
X2xvY2soKTsKPiA+ICAgCXBvb2wgPSByY3VfZGVyZWZlcmVuY2Uoc3EtPnhzay5wb29sKTsKPiA+
IC0JaWYgKHBvb2wpIHsKPiA+IC0JCWxvY2FsX2JoX2Rpc2FibGUoKTsKPiA+IC0JCXZpcnRxdWV1
ZV9uYXBpX3NjaGVkdWxlKCZzcS0+bmFwaSwgc3EtPnZxKTsKPiA+IC0JCWxvY2FsX2JoX2VuYWJs
ZSgpOwo+ID4gLQl9Cj4gPiArCWlmICghcG9vbCkKPiA+ICsJCWdvdG8gZW5kOwo+ID4gKwo+ID4g
KwlpZiAobmFwaV9pZl9zY2hlZHVsZWRfbWFya19taXNzZWQoJnNxLT5uYXBpKSkKPiA+ICsJCWdv
dG8gZW5kOwo+ID4gKwo+ID4gKwl0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKGRldiwgcWlkKTsK
PiA+ICsKPiA+ICsJX19uZXRpZl90eF9sb2NrX2JoKHR4cSk7Cj4gPiArCj4gPiArCS8qIFNlbmQg
cGFydCBvZiB0aGUgcGFja2V0IGRpcmVjdGx5IHRvIHJlZHVjZSB0aGUgZGVsYXkgaW4gc2VuZGlu
ZyB0aGUKPiA+ICsJICogcGFja2V0LCBhbmQgdGhpcyBjYW4gYWN0aXZlbHkgdHJpZ2dlciB0aGUg
dHggaW50ZXJydXB0cy4KPiA+ICsJICoKPiA+ICsJICogSWYgbm8gcGFja2V0IGlzIHNlbnQgb3V0
LCB0aGUgcmluZyBvZiB0aGUgZGV2aWNlIGlzIGZ1bGwuIEluIHRoaXMKPiA+ICsJICogY2FzZSwg
d2Ugd2lsbCBzdGlsbCBnZXQgYSB0eCBpbnRlcnJ1cHQgcmVzcG9uc2UuIFRoZW4gd2Ugd2lsbCBk
ZWFsCj4gPiArCSAqIHdpdGggdGhlIHN1YnNlcXVlbnQgcGFja2V0IHNlbmRpbmcgd29yay4KPiA+
ICsJICovCj4gPiArCXZpcnRuZXRfeHNrX3J1bihzcSwgcG9vbCwgc3EtPm5hcGkud2VpZ2h0LCBm
YWxzZSk7Cj4KPgo+IFRoaXMgbG9va3MgdHJpY2t5LCBhbmQgaXQgd29uJ3QgYmUgZWZmaWNpZW50
IHNpbmNlIHRoZXJlIGNvdWxkIGJlIHNvbWUKPiBjb250ZW50aW9uIG9uIHRoZSB0eCBsb2NrLgo+
Cj4gSSB3b25kZXIgaWYgd2UgY2FuIHNpbXVsYXRlIHRoZSBpbnRlcnJ1cHQgdmlhIElQSSBsaWtl
IHdoYXQgUlBTIGRpZC4KCkxldCBtZSB0cnkuCgo+Cj4gSW4gdGhlIGxvbmcgcnVuLCB3ZSBtYXkg
d2FudCB0byBleHRlbmQgdGhlIHNwZWMgdG8gc3VwcG9ydCBpbnRlcnJ1cHQKPiB0cmlnZ2VyIHRo
b3VnaCBkcml2ZXIuCgpDYW4gd2Ugc3VibWl0IHRoaXMgd2l0aCByZXNldCBxdWV1ZT8KClRoYW5r
cy4KCj4KPiBUaGFua3MKPgo+Cj4gPiArCj4gPiArCV9fbmV0aWZfdHhfdW5sb2NrX2JoKHR4cSk7
Cj4gPiArCj4gPiArZW5kOgo+ID4gICAJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gPiAgIAlyZXR1cm4g
MDsKPiA+ICAgfQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
