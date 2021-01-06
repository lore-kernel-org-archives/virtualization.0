Return-Path: <SRS0=bDZb=GJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A964C433E0
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 02:47:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0874F22D50
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 02:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0874F22D50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 79A3C86AF0;
	Wed,  6 Jan 2021 02:47:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jChU8Loa+m62; Wed,  6 Jan 2021 02:47:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EA4D386AED;
	Wed,  6 Jan 2021 02:47:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA783C088B;
	Wed,  6 Jan 2021 02:47:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7070C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 02:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BF88986AEF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 02:47:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 35MXsU14eiNu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 02:47:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B386486AED
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 02:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609901227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGSEn9q3RMopoKalaky8zmG8K4EWEIZy2nW74+H0arI=;
 b=RmTAkEeXj1TWjP/MF9h6ZvdJB3CiMSeTfoMDMukkJNvboI2i4g07FSnL149bdDTV6T7uDn
 g5LeudVhutx8tOpv0Zjhq5e9KGX0GMjd5DgTfvJEQWh0fseTmB2VLuJ/DizwOC/F2Gw8HP
 mqtWfKg/UxvI6ahuAykrMWW8KrdKJUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-bHkpLFKCPGuhlqwUfh6t8Q-1; Tue, 05 Jan 2021 21:47:05 -0500
X-MC-Unique: bHkpLFKCPGuhlqwUfh6t8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2C21800D62;
 Wed,  6 Jan 2021 02:47:02 +0000 (UTC)
Received: from [10.72.13.221] (ovpn-13-221.pek2.redhat.com [10.72.13.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 640BB50DD5;
 Wed,  6 Jan 2021 02:46:51 +0000 (UTC)
Subject: Re: [PATCH netdev 0/5] virtio-net support xdp socket zero copy xmit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1609850555.8687568-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b1895acf-9366-ba9a-4265-7e871b351872@redhat.com>
Date: Wed, 6 Jan 2021 10:46:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1609850555.8687568-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 open list <linux-kernel@vger.kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 VIRTIO CORE AND NET DRIVERS <virtualization@lists.linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
 dust.li@linux.alibaba.com, Jonathan Lemon <jonathan.lemon@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "XDP SOCKETS \(AF_XDP\)" <bpf@vger.kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 tonylu@linux.alibaba.com, "David S. Miller" <davem@davemloft.net>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMS81IOS4i+WNiDg6NDIsIFh1YW4gWmh1byB3cm90ZToKPiBPbiBUdWUsIDUgSmFu
IDIwMjEgMTc6MzI6MTkgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+PiBPbiAyMDIxLzEvNSDkuIvljYg1OjExLCBYdWFuIFpodW8gd3JvdGU6Cj4+PiBUaGUg
Zmlyc3QgcGF0Y2ggbWFkZSBzb21lIGFkanVzdG1lbnRzIHRvIHhzay4KPj4KPj4gVGhhbmtzIGEg
bG90IGZvciB0aGUgd29yay4gSXQncyByYXRoZXIgaW50ZXJlc3RpbmcuCj4+Cj4+Cj4+PiBUaGUg
c2Vjb25kIHBhdGNoIGl0c2VsZiBjYW4gYmUgdXNlZCBhcyBhbiBpbmRlcGVuZGVudCBwYXRjaCB0
byBzb2x2ZSB0aGUgcHJvYmxlbQo+Pj4gdGhhdCBYRFAgbWF5IGZhaWwgdG8gbG9hZCB3aGVuIHRo
ZSBudW1iZXIgb2YgcXVldWVzIGlzIGluc3VmZmljaWVudC4KPj4KPj4gSXQgd291bGQgYmUgYmV0
dGVyIHRvIHNlbmQgdGhpcyBhcyBhIHNlcGFyYXRlZCBwYXRjaC4gU2V2ZXJhbCBwZW9wbGUKPj4g
YXNrZWQgZm9yIHRoaXMgYmVmb3JlLgo+Pgo+Pgo+Pj4gVGhlIHRoaXJkIHRvIGxhc3QgcGF0Y2gg
aW1wbGVtZW50cyBzdXBwb3J0IGZvciB4c2sgaW4gdmlydGlvLW5ldC4KPj4+Cj4+PiBBIHByYWN0
aWNhbCBwcm9ibGVtIHdpdGggdmlydGlvIGlzIHRoYXQgdHggaW50ZXJydXB0cyBhcmUgbm90IHZl
cnkgcmVsaWFibGUuCj4+PiBUaGVyZSB3aWxsIGFsd2F5cyBiZSBzb21lIG1pc3Npbmcgb3IgZGVs
YXllZCB0eCBpbnRlcnJ1cHRzLiBTbyBJIHNwZWNpYWxseSBhZGRlZAo+Pj4gYSBwb2ludCB0aW1l
ciB0byBzb2x2ZSB0aGlzIHByb2JsZW0uIE9mIGNvdXJzZSwgY29uc2lkZXJpbmcgcGVyZm9ybWFu
Y2UgaXNzdWVzLAo+Pj4gVGhlIHRpbWVyIG9ubHkgdHJpZ2dlcnMgd2hlbiB0aGUgcmluZyBvZiB0
aGUgbmV0d29yayBjYXJkIGlzIGZ1bGwuCj4+Cj4+IFRoaXMgaXMgc3ViLW9wdGltYWwuIFdlIG5l
ZWQgZmlndXJlIG91dCB0aGUgcm9vdCBjYXVzZS4gV2UgZG9uJ3QgbWVldAo+PiBzdWNoIGlzc3Vl
IGJlZm9yZS4KPj4KPj4gU2V2ZXJhbCBxdWVzdGlvbnM6Cj4+Cj4+IC0gaXMgdHggaW50ZXJydXB0
IGVuYWJsZWQ/Cj4+IC0gY2FuIHlvdSBzdGlsbCBzZWUgdGhlIGlzc3VlIGlmIHlvdSBkaXNhYmxl
IGV2ZW50IGluZGV4Pwo+PiAtIHdoYXQncyBiYWNrZW5kIGRpZCB5b3UgdXNlPyBxZW11IG9yIHZo
b3N0KHVzZXIpPwo+IFNvcnJ5LCBpdCBtYXkganVzdCBiZSBhIHByb2JsZW0gd2l0aCB0aGUgYmFj
a2VuZCBJIHVzZWQgaGVyZS4gSSBqdXN0IHRlc3RlZCB0aGUKPiBsYXRlc3QgcWVtdSBhbmQgaXQg
ZGlkIG5vdCBoYXZlIHRoaXMgcHJvYmxlbS4gSSB0aGluayBJIHNob3VsZCBkZWxldGUgdGhlCj4g
dGltZXItcmVsYXRlZCBjb2RlPwoKClllcywgcGxlYXNlLgoKCj4KPj4KPj4+IFJlZ2FyZGluZyB0
aGUgaXNzdWUgb2YgdmlydGlvLW5ldCBzdXBwb3J0aW5nIHhzaydzIHplcm8gY29weSByeCwgSSBh
bSBhbHNvCj4+PiBkZXZlbG9waW5nIGl0LCBidXQgSSBmb3VuZCB0aGF0IHRoZSBtb2RpZmljYXRp
b24gbWF5IGJlIHJlbGF0aXZlbHkgbGFyZ2UsIHNvIEkKPj4+IGNvbnNpZGVyIHRoaXMgcGF0Y2gg
c2V0IHRvIGJlIHNlcGFyYXRlZCBmcm9tIHRoZSBjb2RlIHJlbGF0ZWQgdG8geHNrIHplcm8gY29w
eQo+Pj4gcnguCj4+Cj4+IFRoYXQncyBmaW5lLCBidXQgYSBxdWVzdGlvbiBoZXJlLgo+Pgo+PiBI
b3cgaXMgdGhlIG11bHRpZXVxdWUgYmVpbmcgaGFuZGxlZCBoZXJlLiBJJ20gYXNraW5nIHNpbmNl
IHRoZXJlJ3Mgbm8KPj4gcHJvZ3JhbW1hYmxlIGZpbHRlcnMvZGlyZWN0b3JzIHN1cHBvcnQgaW4g
dmlydGlvIHNwZWMgbm93Lgo+Pgo+PiBUaGFua3MKPiBJIGRvbid0IHJlYWxseSB1bmRlcnN0YW5k
IHdoYXQgeW91IG1lYW4uIEluIHRoZSBjYXNlIG9mIG11bHRpcGxlIHF1ZXVlcywKPiB0aGVyZSBp
cyBubyBwcm9ibGVtLgoKClNvIGNvbnNpZGVyIHdlIGJpbmQgeHNrIHRvIHF1ZXVlIDQsIGhvdyBj
YW4geW91IG1ha2Ugc3VyZSB0aGUgdHJhZmZpYyB0byAKYmUgZGlyZWN0ZWQgcXVldWUgND8gT25l
IHBvc3NpYmxlIHNvbHV0aW9uIGlzIHRvIHVzZSBmaWx0ZXJzIGFzIHdoYXQgCnN1Z2dlc3RlZCBp
biBhZl94ZHAucnN0OgoKIMKgwqDCoMKgwqAgZXRodG9vbCAtTiBwM3AyIHJ4LWZsb3ctaGFzaCB1
ZHA0IGZuCiDCoMKgwqDCoMKgIGV0aHRvb2wgLU4gcDNwMiBmbG93LXR5cGUgdWRwNCBzcmMtcG9y
dCA0MjQyIGRzdC1wb3J0IDQyNDIgXAogwqDCoMKgwqDCoMKgwqDCoMKgIGFjdGlvbiAxNgouLi4K
CkJ1dCB2aXJ0aW8tbmV0IGRvZXNuJ3QgaGF2ZSBhbnkgZmlsdGVycyB0aGF0IGNvdWxkIGJlIHBy
b2dyYW1tZWQgZnJvbSAKdGhlIGRyaXZlci4KCkFueXRoaW5nIEkgbWlzc2VkIGhlcmU/CgpUaGFu
a3MKCgo+Cj4+Cj4+PiBYdWFuIFpodW8gKDUpOgo+Pj4gICAgIHhzazogc3VwcG9ydCBnZXQgcGFn
ZSBmb3IgZHJ2Cj4+PiAgICAgdmlydGlvLW5ldDogc3VwcG9ydCBYRFBfVFggd2hlbiBub3QgbW9y
ZSBxdWV1ZXMKPj4+ICAgICB2aXJ0aW8tbmV0LCB4c2s6IGRpc3Rpbmd1aXNoIFhEUF9UWCBhbmQg
WFNLIFhNSVQgY3R4Cj4+PiAgICAgeHNrLCB2aXJ0aW8tbmV0OiBwcmVwYXJlIGZvciBzdXBwb3J0
IHhzawo+Pj4gICAgIHZpcnRpby1uZXQsIHhzazogdmlydGlvLW5ldCBzdXBwb3J0IHhzayB6ZXJv
IGNvcHkgdHgKPj4+Cj4+PiAgICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgICAgfCA2NDMgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KPj4+ICAgIGluY2x1ZGUv
bGludXgvbmV0ZGV2aWNlLmggICB8ICAgMSArCj4+PiAgICBpbmNsdWRlL25ldC94ZHBfc29ja19k
cnYuaCAgfCAgMTAgKwo+Pj4gICAgaW5jbHVkZS9uZXQveHNrX2J1ZmZfcG9vbC5oIHwgICAxICsK
Pj4+ICAgIG5ldC94ZHAveHNrX2J1ZmZfcG9vbC5jICAgICB8ICAxMCArLQo+Pj4gICAgNSBmaWxl
cyBjaGFuZ2VkLCA1OTcgaW5zZXJ0aW9ucygrKSwgNjggZGVsZXRpb25zKC0pCj4+Pgo+Pj4gLS0K
Pj4+IDEuOC4zLjEKPj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
