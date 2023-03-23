Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690E8C6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 11:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFD2C61524;
	Thu, 23 Mar 2023 11:12:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFD2C61524
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ePa22-AFyywd; Thu, 23 Mar 2023 11:12:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9290461521;
	Thu, 23 Mar 2023 11:12:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9290461521
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66523C0071;
	Thu, 23 Mar 2023 11:12:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D052C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1796361524
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:12:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1796361524
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Net6xuiptR8k
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:12:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17D4B61521
Received: from out30-100.freemail.mail.aliyun.com
 (out30-100.freemail.mail.aliyun.com [115.124.30.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 17D4B61521
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:12:06 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R431e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VeU4xLz_1679569919; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeU4xLz_1679569919) by smtp.aliyun-inc.com;
 Thu, 23 Mar 2023 19:12:00 +0800
Message-ID: <1679569460.0714788-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 2/8] virtio_net: mergeable xdp: introduce
 mergeable_xdp_prepare
Date: Thu, 23 Mar 2023 19:04:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230322030308.16046-3-xuanzhuo@linux.alibaba.com>
 <c7749936-c154-da51-ccfb-f16150d19c62@huawei.com>
 <1679535924.6219428-2-xuanzhuo@linux.alibaba.com>
 <215e791d-1802-2419-ff59-49476bcdcd02@huawei.com>
 <CACGkMEv=0gt6LS0HSgKELQqnWfQ2UdFgAKdvh=CLaAPLeNytww@mail.gmail.com>
 <00509559-f3b6-2914-76f4-39e9e96f37c1@huawei.com>
In-Reply-To: <00509559-f3b6-2914-76f4-39e9e96f37c1@huawei.com>
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

T24gVGh1LCAyMyBNYXIgMjAyMyAxNToyNDozOCArMDgwMCwgWXVuc2hlbmcgTGluIDxsaW55dW5z
aGVuZ0BodWF3ZWkuY29tPiB3cm90ZToKPiBPbiAyMDIzLzMvMjMgMTM6NDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPj4+Cj4gPj4+Pgo+ID4+Pj4gQWxzbywgaXQgc2VlbXMgYmV0dGVyIHRvIHNwbGl0
IHRoZSB4ZHBfbGluZWFyaXplX3BhZ2UoKSB0byB0d28gZnVuY3Rpb25zCj4gPj4+PiBhcyBwc2ti
X2V4cGFuZF9oZWFkKCkgYW5kIF9fc2tiX2xpbmVhcml6ZSgpIGRvLCBvbmUgdG8gZXhwYW5kIHRo
ZSBoZWFkcm9vbSwKPiA+Pj4+IHRoZSBvdGhlciBvbmUgdG8gZG8gdGhlIGxpbmVhcml6aW5nLgo+
ID4+Pgo+ID4+PiBObyBza2IgaGVyZS4KPiA+Pgo+ID4+IEkgbWVhbnMgZm9sbG93aW5nIHRoZSBz
ZW1hbnRpY3Mgb2YgcHNrYl9leHBhbmRfaGVhZCgpIGFuZCBfX3NrYl9saW5lYXJpemUoKSwKPiA+
PiBub3QgdG8gY29tYmluZSB0aGUgaGVhZHJvb20gZXhwYW5kaW5nIGFuZCBsaW5lYXJpemluZyBp
bnRvIG9uZSBmdW5jdGlvbiBhcwo+ID4+IHhkcF9saW5lYXJpemVfcGFnZSgpIGRvZXMgbm93IGlm
IHdlIHdhbnQgYSBiZXR0ZXIgcmVmb2N0b3IgcmVzdWx0Lgo+ID4KPiA+IE5vdCBzdXJlIGl0J3Mg
d29ydGggaXQsIHNpbmNlIHRoZSB1c2UgaXMgdmVyeSBzcGVjaWZpYyB1bmxlc3Mgd2UgY291bGQK
PiA+IGZpbmQgYSBjYXNlIHRoYXQgd2FudHMgb25seSBvbmUgb2YgdGhlbS4KPgo+IEl0IHNlZW1z
IHJlY2VpdmVfc21hbGwoKSBvbmx5IG5lZWQgdGhlIGhlYWRyb29tIGV4cGFuZGluZyBvbmUuCj4g
Rm9yIHJlY2VpdmVfbWVyZ2VhYmxlKCksIGl0IHNlZW1zIHdlIGNhbiBzcGxpdCBpbnRvIHRoZSBi
ZWxvdyBjYXNlczoKPiAxLiAiICgheGRwX3Byb2ctPmF1eC0+eGRwX2hhc19mcmFncyAmJiAobnVt
X2J1ZiA+IDEgfHwgaGVhZHJvb20gPCB2aXJ0bmV0X2dldF9oZWFkcm9vbSh2aSkpKSIKPiAgICBj
YXNlIG9ubHkgbmVlZCBsaW5lYXJpemluZy4KPiAyLiBvdGhlciBjYXNlcyBvbmx5IG5lZWQgaGVh
ZHJvb20vdGFpbHJvb20gZXhwYW5kaW5nLgo+Cj4gQW55d2F5LCBpdCBpcyB5b3VyIGNhbGwgdG8g
ZGVjaWRlIGlmIHlvdSB3YW50IHRvIHRha2UgdGhpcwo+IG9wcG9ydHVuaXR5IGRvIGEgYmV0dGVy
IHJlZm9jdG9yaW5nIHRvIHZpcnRpb19uZXQuCgpDb21wYXJlZCB0byB0aGUgY2hhb3RpYyBzdGF0
ZSBvZiB0aGUgdmlydGlvLW5ldCBYRFAsIHRoaXMgaXMgYSBzbWFsbCBwb2ludC4KQW5kIEkgZG9u
4oCZdCB0aGluayB0aGlzIGJyaW5ncyBhbnkgcHJhY3RpY2FsIG9wdGltaXphdGlvbi4gSWYgeW91
IHRoaW5rIHRoaXMKZGl2aXNpb24gaXMgYmV0dGVyLiBZb3UgY2FuIHN1Ym1pdCBhIG5ldyBwYXRj
aCBvbiB0aGUgdG9wIG9mIHRoaXMgcGF0Y2ggc2V0LgpJIHRoaW5rIHRoZSBjb2RlIGNhbiBiZSBj
bGVhcmVyLgoKVGhhbmtzLgoKPgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+Pgo+ID4+Pgo+ID4+Pgo+
ID4+Pj4KPiA+Pgo+ID4KPiA+Cj4gPiAuCj4gPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
