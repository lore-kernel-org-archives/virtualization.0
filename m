Return-Path: <SRS0=bDZb=GJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533ACC433E6
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 03:54:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E474022CB1
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 03:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E474022CB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 95C2085570;
	Wed,  6 Jan 2021 03:54:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ti0QmNy0I7UU; Wed,  6 Jan 2021 03:54:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EF4D4855CE;
	Wed,  6 Jan 2021 03:54:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5C1FC0891;
	Wed,  6 Jan 2021 03:54:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78221C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 03:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6D20D871D4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 03:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P9krHnImE8be
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 03:54:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C9A59871D2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 03:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609905286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OVA/p6Dm+RBVu73ubuD5HfRwhKe3wKe0AbtSSZXHXtA=;
 b=AYvj1EJzyKtYG2H/yL+3K/mqNA8J4+O8ZtIanb60rLm/UkrjhlKzOKtO0BnJ/vL0on2kda
 ESJBT3lOkQHfxvABFeLG8JaiL/aWYCxBpso3x0pOQqtTF1Eo3CZPN2kezQx/BS6hmf9YTB
 1XlWmFFhu0lrUH941DQ68kOd3aEf/B4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-cXuI3NPCMYmJkAxweS85JQ-1; Tue, 05 Jan 2021 22:54:42 -0500
X-MC-Unique: cXuI3NPCMYmJkAxweS85JQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 554A1107ACE3;
 Wed,  6 Jan 2021 03:54:40 +0000 (UTC)
Received: from [10.72.13.221] (ovpn-13-221.pek2.redhat.com [10.72.13.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1890D709A5;
 Wed,  6 Jan 2021 03:54:27 +0000 (UTC)
Subject: Re: [PATCH netdev 0/5] virtio-net support xdp socket zero copy xmit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1609901717.683732-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b5dee65c-2a0c-296c-56b4-1ed17f7aec38@redhat.com>
Date: Wed, 6 Jan 2021 11:54:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1609901717.683732-2-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Ck9uIDIwMjEvMS82IOS4iuWNiDEwOjU1LCBYdWFuIFpodW8gd3JvdGU6Cj4gT24gV2VkLCA2IEph
biAyMDIxIDEwOjQ2OjQzICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4gT24gMjAyMS8xLzUg5LiL5Y2IODo0MiwgWHVhbiBaaHVvIHdyb3RlOgo+Pj4gT24g
VHVlLCA1IEphbiAyMDIxIDE3OjMyOjE5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4+PiBPbiAyMDIxLzEvNSDkuIvljYg1OjExLCBYdWFuIFpodW8gd3Jv
dGU6Cj4+Pj4+IFRoZSBmaXJzdCBwYXRjaCBtYWRlIHNvbWUgYWRqdXN0bWVudHMgdG8geHNrLgo+
Pj4+IFRoYW5rcyBhIGxvdCBmb3IgdGhlIHdvcmsuIEl0J3MgcmF0aGVyIGludGVyZXN0aW5nLgo+
Pj4+Cj4+Pj4KPj4+Pj4gVGhlIHNlY29uZCBwYXRjaCBpdHNlbGYgY2FuIGJlIHVzZWQgYXMgYW4g
aW5kZXBlbmRlbnQgcGF0Y2ggdG8gc29sdmUgdGhlIHByb2JsZW0KPj4+Pj4gdGhhdCBYRFAgbWF5
IGZhaWwgdG8gbG9hZCB3aGVuIHRoZSBudW1iZXIgb2YgcXVldWVzIGlzIGluc3VmZmljaWVudC4K
Pj4+PiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gc2VuZCB0aGlzIGFzIGEgc2VwYXJhdGVkIHBhdGNo
LiBTZXZlcmFsIHBlb3BsZQo+Pj4+IGFza2VkIGZvciB0aGlzIGJlZm9yZS4KPj4+Pgo+Pj4+Cj4+
Pj4+IFRoZSB0aGlyZCB0byBsYXN0IHBhdGNoIGltcGxlbWVudHMgc3VwcG9ydCBmb3IgeHNrIGlu
IHZpcnRpby1uZXQuCj4+Pj4+Cj4+Pj4+IEEgcHJhY3RpY2FsIHByb2JsZW0gd2l0aCB2aXJ0aW8g
aXMgdGhhdCB0eCBpbnRlcnJ1cHRzIGFyZSBub3QgdmVyeSByZWxpYWJsZS4KPj4+Pj4gVGhlcmUg
d2lsbCBhbHdheXMgYmUgc29tZSBtaXNzaW5nIG9yIGRlbGF5ZWQgdHggaW50ZXJydXB0cy4gU28g
SSBzcGVjaWFsbHkgYWRkZWQKPj4+Pj4gYSBwb2ludCB0aW1lciB0byBzb2x2ZSB0aGlzIHByb2Js
ZW0uIE9mIGNvdXJzZSwgY29uc2lkZXJpbmcgcGVyZm9ybWFuY2UgaXNzdWVzLAo+Pj4+PiBUaGUg
dGltZXIgb25seSB0cmlnZ2VycyB3aGVuIHRoZSByaW5nIG9mIHRoZSBuZXR3b3JrIGNhcmQgaXMg
ZnVsbC4KPj4+PiBUaGlzIGlzIHN1Yi1vcHRpbWFsLiBXZSBuZWVkIGZpZ3VyZSBvdXQgdGhlIHJv
b3QgY2F1c2UuIFdlIGRvbid0IG1lZXQKPj4+PiBzdWNoIGlzc3VlIGJlZm9yZS4KPj4+Pgo+Pj4+
IFNldmVyYWwgcXVlc3Rpb25zOgo+Pj4+Cj4+Pj4gLSBpcyB0eCBpbnRlcnJ1cHQgZW5hYmxlZD8K
Pj4+PiAtIGNhbiB5b3Ugc3RpbGwgc2VlIHRoZSBpc3N1ZSBpZiB5b3UgZGlzYWJsZSBldmVudCBp
bmRleD8KPj4+PiAtIHdoYXQncyBiYWNrZW5kIGRpZCB5b3UgdXNlPyBxZW11IG9yIHZob3N0KHVz
ZXIpPwo+Pj4gU29ycnksIGl0IG1heSBqdXN0IGJlIGEgcHJvYmxlbSB3aXRoIHRoZSBiYWNrZW5k
IEkgdXNlZCBoZXJlLiBJIGp1c3QgdGVzdGVkIHRoZQo+Pj4gbGF0ZXN0IHFlbXUgYW5kIGl0IGRp
ZCBub3QgaGF2ZSB0aGlzIHByb2JsZW0uIEkgdGhpbmsgSSBzaG91bGQgZGVsZXRlIHRoZQo+Pj4g
dGltZXItcmVsYXRlZCBjb2RlPwo+Pgo+PiBZZXMsIHBsZWFzZS4KPj4KPj4KPj4+Pj4gUmVnYXJk
aW5nIHRoZSBpc3N1ZSBvZiB2aXJ0aW8tbmV0IHN1cHBvcnRpbmcgeHNrJ3MgemVybyBjb3B5IHJ4
LCBJIGFtIGFsc28KPj4+Pj4gZGV2ZWxvcGluZyBpdCwgYnV0IEkgZm91bmQgdGhhdCB0aGUgbW9k
aWZpY2F0aW9uIG1heSBiZSByZWxhdGl2ZWx5IGxhcmdlLCBzbyBJCj4+Pj4+IGNvbnNpZGVyIHRo
aXMgcGF0Y2ggc2V0IHRvIGJlIHNlcGFyYXRlZCBmcm9tIHRoZSBjb2RlIHJlbGF0ZWQgdG8geHNr
IHplcm8gY29weQo+Pj4+PiByeC4KPj4+PiBUaGF0J3MgZmluZSwgYnV0IGEgcXVlc3Rpb24gaGVy
ZS4KPj4+Pgo+Pj4+IEhvdyBpcyB0aGUgbXVsdGlldXF1ZSBiZWluZyBoYW5kbGVkIGhlcmUuIEkn
bSBhc2tpbmcgc2luY2UgdGhlcmUncyBubwo+Pj4+IHByb2dyYW1tYWJsZSBmaWx0ZXJzL2RpcmVj
dG9ycyBzdXBwb3J0IGluIHZpcnRpbyBzcGVjIG5vdy4KPj4+Pgo+Pj4+IFRoYW5rcwo+Pj4gSSBk
b24ndCByZWFsbHkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLiBJbiB0aGUgY2FzZSBvZiBtdWx0
aXBsZSBxdWV1ZXMsCj4+PiB0aGVyZSBpcyBubyBwcm9ibGVtLgo+Pgo+PiBTbyBjb25zaWRlciB3
ZSBiaW5kIHhzayB0byBxdWV1ZSA0LCBob3cgY2FuIHlvdSBtYWtlIHN1cmUgdGhlIHRyYWZmaWMg
dG8KPj4gYmUgZGlyZWN0ZWQgcXVldWUgND8gT25lIHBvc3NpYmxlIHNvbHV0aW9uIGlzIHRvIHVz
ZSBmaWx0ZXJzIGFzIHdoYXQKPj4gc3VnZ2VzdGVkIGluIGFmX3hkcC5yc3Q6Cj4+Cj4+ICAgwqDC
oMKgwqDCoCBldGh0b29sIC1OIHAzcDIgcngtZmxvdy1oYXNoIHVkcDQgZm4KPj4gICDCoMKgwqDC
oMKgIGV0aHRvb2wgLU4gcDNwMiBmbG93LXR5cGUgdWRwNCBzcmMtcG9ydCA0MjQyIGRzdC1wb3J0
IDQyNDIgXAo+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoCBhY3Rpb24gMTYKPj4gLi4uCj4+Cj4+IEJ1
dCB2aXJ0aW8tbmV0IGRvZXNuJ3QgaGF2ZSBhbnkgZmlsdGVycyB0aGF0IGNvdWxkIGJlIHByb2dy
YW1tZWQgZnJvbQo+PiB0aGUgZHJpdmVyLgo+Pgo+PiBBbnl0aGluZyBJIG1pc3NlZCBoZXJlPwo+
Pgo+PiBUaGFua3MKPiBJIHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbiwgdGhpcyBwcm9ibGVtIGRv
ZXMgZXhpc3QsIGFuZCBJIGVuY291bnRlcmVkIGl0IHdoZW4gSQo+IHRlc3RlZCBxZW11Lgo+Cj4g
Rmlyc3Qgb2YgYWxsLCB0aGlzIGlzIHRoYXQgdGhlIHByb2JsZW0gb25seSBhZmZlY3RzIHJlY3Yu
IFRoaXMgcGF0Y2ggaXMgZm9yCj4geG1pdC4gT2YgY291cnNlLCBvdXIgbm9ybWFsIGJ1c2luZXNz
IG11c3QgYWxzbyBoYXZlIHJlY3Ygc2NlbmFyaW9zLgo+Cj4gTXkgc29sdXRpb24gaW4gZGV2ZWxv
cGluZyB0aGUgdXBwZXItbGV2ZWwgYXBwbGljYXRpb24gaXMgdG8gYm9uZCBhbGwgdGhlIHF1ZXVl
cwo+IHRvIGVuc3VyZSB0aGF0IHdlIGNhbiByZWNlaXZlIHRoZSBwYWNrZXRzIHdlIHdhbnQuCgoK
SSdtIG5vdCBzdXJlIEkgZ2V0IHlvdSBoZXJlLiBOb3RlIHRoYXQuIG9uZSBhZHZhbnRhZ2Ugb2Yg
QUZfWERQIGlzIHRoYXQgCmlzIGFsbG93cyBYU0sgdG8gYmUgYm91bmQgdG8gYSBzcGVjaWZpYyBx
dWV1ZSBhbmQgdGhlIHJlc3QgY291bGQgc3RpbGwgCmJlIHVzZWQgYnkga2VybmVsLgoKCj4gICBB
bmQgSSB0aGluayBpbiB0aGUKPiBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgdXNlLCBldmVuIGlmIHRo
ZSBuZXR3b3JrIGNhcmQgc3VwcG9ydHMgZmlsdGVycywgd2Ugc2hvdWxkCj4gYWxzbyBib25kIGFs
bCB0aGUgcXVldWVzLCBiZWNhdXNlIHdlIGRvbid0IGtub3cgd2hpY2ggcXVldWUgdGhlIHRyYWZm
aWMgd2UgY2FyZQo+IGFib3V0IHdpbGwgYXJyaXZlIGZyb20uCgoKV2l0aCB0aGUgaGVscCBvZiBm
aWx0ZXJzIHRoZSBjYXJkIGNhbiBzZWxlY3QgYSBzcGVjaWZpYyBxdWV1ZSBiYXNlZCBvbiAKaGFz
aCBvciBuLXR1cGxlIHNvIGl0IHNob3VsZCB3b3JrPwoKCj4KPiBSZWdhcmRpbmcgdGhlIHByb2Js
ZW0gb2YgdmlydGlvLW5ldCwgSSB0aGluayBvdXIgY29yZSBxdWVzdGlvbiBpcyB3aGV0aGVyIHdl
Cj4gbmVlZCB0byBkZWFsIHdpdGggdGhpcyBwcm9ibGVtIGluIHRoZSBkcml2ZXIgb2YgdmlydGlv
LW5ldCwgSSBwZXJzb25hbGx5IHRoaW5rCj4gdGhhdCB3ZSBzaG91bGQgYWRkIHRoZSB2aXJ0aW8g
c3BlY2lmaWNhdGlvbiB0byBkZWZpbmUgdGhpcyBzY2VuYXJpby4KCgpZZXMsIHNvIGRvIHlvdSB3
YW50IHRvIGRvIHRoYXQ/IEl0IHdvdWxkIG1ha2UgdmlydGlvLW5ldCBtb3JlIHVzZXIgCmZyaWVu
ZGx5IHRvIEFGX1hEUC4gKE9yIGlmIHlvdSB3aXNoIEkgY2FuIHBvc3QgcGF0Y2ggdG8gZXh0ZW5k
IHRoZSBzcGVjKS4KCgo+Cj4gV2hlbiBJIHRlc3RlZCBpdCwgSSBmb3VuZCB0aGF0IHNvbWUgY2xv
dWQgdmVuZG9ycycgaW1wbGVtZW50YXRpb25zIGd1YXJhbnRlZQo+IHRoaXMgcXVldWUgc2VsZWN0
aW9uIGFsZ29yaXRobS4KCgpSaWdodCwgdGhvdWdoIHNwZWMgc3VnZ2VzdCBhIGF1dG9tYXRpYyBz
dGVlcmluZyBhbGdvcml0aG0gYnV0IGl0J3Mgbm90IAptYW5kYXRvcnkuIFZlbmRvciBjYW4gaW1w
bGVtZW50IHRoZWlyIG93bi4KCkJ1dCBoYXNoIG9yIG50dXBsZSBmaWx0ZXIgc2hvdWxkIGJlIHN0
aWxsIHVzZWZ1bC4KClRoYW5rcwoKCj4KPiBUaGFua3MhIQo+Cj4+Cj4+Pj4+IFh1YW4gWmh1byAo
NSk6Cj4+Pj4+ICAgICAgeHNrOiBzdXBwb3J0IGdldCBwYWdlIGZvciBkcnYKPj4+Pj4gICAgICB2
aXJ0aW8tbmV0OiBzdXBwb3J0IFhEUF9UWCB3aGVuIG5vdCBtb3JlIHF1ZXVlcwo+Pj4+PiAgICAg
IHZpcnRpby1uZXQsIHhzazogZGlzdGluZ3Vpc2ggWERQX1RYIGFuZCBYU0sgWE1JVCBjdHgKPj4+
Pj4gICAgICB4c2ssIHZpcnRpby1uZXQ6IHByZXBhcmUgZm9yIHN1cHBvcnQgeHNrCj4+Pj4+ICAg
ICAgdmlydGlvLW5ldCwgeHNrOiB2aXJ0aW8tbmV0IHN1cHBvcnQgeHNrIHplcm8gY29weSB0eAo+
Pj4+Pgo+Pj4+PiAgICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jICAgIHwgNjQzICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCj4+Pj4+ICAgICBpbmNsdWRlL2xp
bnV4L25ldGRldmljZS5oICAgfCAgIDEgKwo+Pj4+PiAgICAgaW5jbHVkZS9uZXQveGRwX3NvY2tf
ZHJ2LmggIHwgIDEwICsKPj4+Pj4gICAgIGluY2x1ZGUvbmV0L3hza19idWZmX3Bvb2wuaCB8ICAg
MSArCj4+Pj4+ICAgICBuZXQveGRwL3hza19idWZmX3Bvb2wuYyAgICAgfCAgMTAgKy0KPj4+Pj4g
ICAgIDUgZmlsZXMgY2hhbmdlZCwgNTk3IGluc2VydGlvbnMoKyksIDY4IGRlbGV0aW9ucygtKQo+
Pj4+Pgo+Pj4+PiAtLQo+Pj4+PiAxLjguMy4xCj4+Pj4+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
