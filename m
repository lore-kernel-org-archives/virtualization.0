Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2DEC433DB
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 06:29:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE25229C7
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 06:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE25229C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2F24B8704A;
	Mon, 18 Jan 2021 06:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XU2C2p+Vkd1Q; Mon, 18 Jan 2021 06:29:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E5458704D;
	Mon, 18 Jan 2021 06:29:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CFEEC088B;
	Mon, 18 Jan 2021 06:29:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B6C4C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 06:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0C92B2037A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 06:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C6vqRZP0+dSI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 06:29:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 1677420111
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 06:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610951342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEXqRrmhe5TS1HeLniFVF/d1Z+5aM2lLZ+VPrEdE2SQ=;
 b=KQgqqX1QWU66JF7IQyMYnkN4ykGEXxH/wDCas9J67OBMoqyx3OX7JTAR3m+bdcYJhfZ0ji
 xy8TkgROaviTbeiR8TxIXDolM6Cw0TuIbRcyk4L4PSbCiRRg3LOXbhOKljE3rjEfyZqF5i
 6dPqvD69RTCtH5T7IQWMhqlc0/WOYco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-0UL6bPaDO5iHb8DFFTh7MA-1; Mon, 18 Jan 2021 01:28:58 -0500
X-MC-Unique: 0UL6bPaDO5iHb8DFFTh7MA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67F32100F35D;
 Mon, 18 Jan 2021 06:28:55 +0000 (UTC)
Received: from [10.72.13.12] (ovpn-13-12.pek2.redhat.com [10.72.13.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94C716D029;
 Mon, 18 Jan 2021 06:28:44 +0000 (UTC)
Subject: Re: [PATCH net-next v2 0/7] virtio-net support xdp socket zero copy
 xmit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <cover.1609837120.git.xuanzhuo@linux.alibaba.com>
 <cover.1610765285.git.xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b41ab0f0-4537-74b5-d7c3-b20ce082bdd6@redhat.com>
Date: Mon, 18 Jan 2021 14:28:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1610765285.git.xuanzhuo@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMS8xNiDkuIrljYgxMDo1OSwgWHVhbiBaaHVvIHdyb3RlOgo+IFhEUCBzb2NrZXQg
aXMgYW4gZXhjZWxsZW50IGJ5IHBhc3Mga2VybmVsIG5ldHdvcmsgdHJhbnNtaXNzaW9uIGZyYW1l
d29yay4gVGhlCj4gemVybyBjb3B5IGZlYXR1cmUgb2YgeHNrIChYRFAgc29ja2V0KSBuZWVkcyB0
byBiZSBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4gVGhlCj4gcGVyZm9ybWFuY2Ugb2YgemVybyBj
b3B5IGlzIHZlcnkgZ29vZC4gbWx4NSBhbmQgaW50ZWwgaXhnYmUgYWxyZWFkeSBzdXBwb3J0IHRo
aXMKPiBmZWF0dXJlLCBUaGlzIHBhdGNoIHNldCBhbGxvd3MgdmlydGlvLW5ldCB0byBzdXBwb3J0
IHhzaydzIHplcm9jb3B5IHhtaXQKPiBmZWF0dXJlLgo+Cj4gQW5kIHhzaydzIHplcm9jb3B5IHJ4
IGhhcyBtYWRlIG1ham9yIGNoYW5nZXMgdG8gdmlydGlvLW5ldCwgYW5kIEkgaG9wZSB0byBzdWJt
aXQKPiBpdCBhZnRlciB0aGlzIHBhdGNoIHNldCBhcmUgcmVjZWl2ZWQuCj4KPiBDb21wYXJlZCB3
aXRoIG90aGVyIGRyaXZlcnMsIHZpcnRpby1uZXQgZG9lcyBub3QgZGlyZWN0bHkgb2J0YWluIHRo
ZSBkbWEKPiBhZGRyZXNzLCBzbyBJIGZpcnN0IG9idGFpbiB0aGUgeHNrIHBhZ2UsIGFuZCB0aGVu
IHBhc3MgdGhlIHBhZ2UgdG8gdmlydGlvLgo+Cj4gV2hlbiByZWN5Y2xpbmcgdGhlIHNlbnQgcGFj
a2V0cywgd2UgaGF2ZSB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIHNrYiBhbmQgeGRwLgo+IE5vdyB3
ZSBoYXZlIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gc2tiLCB4ZHAsIHhzay4gU28gdGhlIHNlY29u
ZCBwYXRjaCBzb2x2ZXMKPiB0aGlzIHByb2JsZW0gZmlyc3QuCj4KPiBUaGUgbGFzdCBmb3VyIHBh
dGNoZXMgYXJlIHVzZWQgdG8gc3VwcG9ydCB4c2sgemVyb2NvcHkgaW4gdmlydGlvLW5ldDoKPgo+
ICAgMS4gc3VwcG9ydCB4c2sgZW5hYmxlL2Rpc2FibGUKPiAgIDIuIHJlYWxpemUgdGhlIGZ1bmN0
aW9uIG9mIHhzayBwYWNrZXQgc2VuZGluZwo+ICAgMy4gaW1wbGVtZW50IHhzayB3YWtldXAgY2Fs
bGJhY2sKPiAgIDQuIHNldCB4c2sgY29tcGxldGVkIHdoZW4gcGFja2V0IHNlbnQgZG9uZQo+Cj4K
PiAtLS0tLS0tLS0tLS0tLS0tIFBlcmZvcm1hbmNlIFRlc3RpbmcgLS0tLS0tLS0tLS0tCj4KPiBU
aGUgdWRwIHBhY2thZ2UgdG9vbCBpbXBsZW1lbnRlZCBieSB0aGUgaW50ZXJmYWNlIG9mIHhzayB2
cyBzb2NrcGVyZihrZXJuZWwgdWRwKQo+IGZvciBwZXJmb3JtYW5jZSB0ZXN0aW5nOgo+Cj4geHNr
IHplcm8gY29weSBpbiB2aXJ0aW8tbmV0Ogo+IENQVSAgICAgICAgUFBTICAgICAgICAgTVNHU0la
RQo+IDI4LjclICAgICAgMzgzMzg1NyAgICAgNjQKPiAzOC41JSAgICAgIDM2ODk0OTEgICAgIDUx
Mgo+IDM4LjklICAgICAgMjc4NzA5NiAgICAgMTQ1NgoKClNvbWUgcXVlc3Rpb25zIG9uIHRoZSBy
ZXN1bHRzOgoKMSkgV2hhdCdzIHRoZSBzZXR1cCBvbiB0aGUgdmhvc3Q/CjIpIFdoYXQncyB0aGUg
c2V0dXAgb2YgdGhlIG1pdGlnYXRpb24gaW4gYm90aCBob3N0IGFuZCBndWVzdD8KMykgQW55IGFu
YWx5emUgb24gdGhlIHBvc3NpYmxlIGJvdHRsZW5lY2sgdmlhIHBlcmYgb3Igb3RoZXIgdG9vbHM/
CgpUaGFua3MKCgo+Cj4geHNrIHdpdGhvdXQgemVybyBjb3B5IGluIHZpcnRpby1uZXQ6Cj4gQ1BV
ICAgICAgICBQUFMgICAgICAgICBNU0dTSVpFCj4gMTAwJSAgICAgICAxOTE2NzQ3ICAgICA2NAo+
IDEwMCUgICAgICAgMTc3NTk4OCAgICAgNTEyCj4gMTAwJSAgICAgICAxNDQwMDU0ICAgICAxNDU2
Cj4KPiBzb2NrcGVyZjoKPiBDUFUgICAgICAgIFBQUyAgICAgICAgIE1TR1NJWkUKPiAxMDAlICAg
ICAgIDcxMzI3NCAgICAgIDY0Cj4gMTAwJSAgICAgICA3MDEwMjQgICAgICA1MTIKPiAxMDAlICAg
ICAgIDY5NTgzMiAgICAgIDE0NTYKPgo+IFh1YW4gWmh1byAoNyk6Cj4gICAgeHNrOiBzdXBwb3J0
IGdldCBwYWdlIGZvciBkcnYKPiAgICB2aXJ0aW8tbmV0LCB4c2s6IGRpc3Rpbmd1aXNoIFhEUF9U
WCBhbmQgWFNLIFhNSVQgY3R4Cj4gICAgeHNrLCB2aXJ0aW8tbmV0OiBwcmVwYXJlIGZvciBzdXBw
b3J0IHhzayB6ZXJvY29weSB4bWl0Cj4gICAgdmlydGlvLW5ldCwgeHNrOiBzdXBwb3J0IHhzayBl
bmFibGUvZGlzYWJsZQo+ICAgIHZpcnRpby1uZXQsIHhzazogcmVhbGl6ZSB0aGUgZnVuY3Rpb24g
b2YgeHNrIHBhY2tldCBzZW5kaW5nCj4gICAgdmlydGlvLW5ldCwgeHNrOiBpbXBsZW1lbnQgeHNr
IHdha2V1cCBjYWxsYmFjawo+ICAgIHZpcnRpby1uZXQsIHhzazogc2V0IHhzayBjb21wbGV0ZWQg
d2hlbiBwYWNrZXQgc2VudCBkb25lCj4KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyAgICB8
IDU1OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQo+ICAgaW5j
bHVkZS9saW51eC9uZXRkZXZpY2UuaCAgIHwgICAxICsKPiAgIGluY2x1ZGUvbmV0L3hkcF9zb2Nr
X2Rydi5oICB8ICAxMCArCj4gICBpbmNsdWRlL25ldC94c2tfYnVmZl9wb29sLmggfCAgIDEgKwo+
ICAgbmV0L3hkcC94c2tfYnVmZl9wb29sLmMgICAgIHwgIDEwICstCj4gICA1IGZpbGVzIGNoYW5n
ZWQsIDUyMyBpbnNlcnRpb25zKCspLCA1OCBkZWxldGlvbnMoLSkKPgo+IC0tCj4gMS44LjMuMQo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
