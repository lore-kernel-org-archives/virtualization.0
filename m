Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB60CC433DB
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 02:47:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAA52250E
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 02:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAA52250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C747885ADC;
	Mon, 18 Jan 2021 02:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ksy8p6Aghoh; Mon, 18 Jan 2021 02:47:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B1696853D3;
	Mon, 18 Jan 2021 02:47:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D5D4C0FA7;
	Mon, 18 Jan 2021 02:47:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 749E1C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 02:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 58221855D1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 02:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zyWIJkRFUOXJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 02:46:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0100F853D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 02:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610938017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x6ekTaCUkKdjepJubjr84NceoQSjqFD24PhaaJLdYi8=;
 b=X3jrm6aCp2fmHuVv4/5glyoku801RZqSXgCHfF0vQURec625XSoUPcHoumkkw5zVc9MOSy
 lUDH5V2VZzgzLEdEm785coWL7T1fXs2EY0ejB9A1ONPZeqbnovVS7MuZ8RKjGrZD2vRJx9
 SxapfmzK0QlTDidTDZaL/AaTa1eC+ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-HGDmO5YxNpSzg8ZGWPAqfQ-1; Sun, 17 Jan 2021 21:46:53 -0500
X-MC-Unique: HGDmO5YxNpSzg8ZGWPAqfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B343107ACE3;
 Mon, 18 Jan 2021 02:46:49 +0000 (UTC)
Received: from [10.72.13.12] (ovpn-13-12.pek2.redhat.com [10.72.13.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 466675C6AB;
 Mon, 18 Jan 2021 02:46:33 +0000 (UTC)
Subject: Re: [RFC PATCH 0/7] Support for virtio-net hash reporting
To: Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
 <CAOEp5OejaX4ZETThrj4-n8_yZoeTZs56CBPHbQqNsR2oni8dWw@mail.gmail.com>
 <CAOEp5Oc5qif_krU8oC6qhq6X0xRW-9GpWrBzWgPw0WevyhT8Mg@mail.gmail.com>
 <CA+FuTSfhBZfEf8+LKNUJQpSxt8c5h1wMpARupekqFKuei6YBsA@mail.gmail.com>
 <78bbc518-4b73-4629-68fb-2713250f8967@redhat.com>
 <CA+FuTSfJJhEYr6gXmjpjjXzg6Xm5wWa-dL1SEV-Zt7RcPXGztg@mail.gmail.com>
 <8ea218a8-a068-1ed9-929d-67ad30111c3c@redhat.com>
 <CAOEp5OfyHz2rXHmOeojNNE2wvrHMn_z1egr5aGQborEq829TLw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <65fe1a40-abc0-77ed-56df-3f0a70615016@redhat.com>
Date: Mon, 18 Jan 2021 10:46:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOEp5OfyHz2rXHmOeojNNE2wvrHMn_z1egr5aGQborEq829TLw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Song Liu <songliubraving@fb.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Yan Vugenfirer <yan@daynix.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, decui@microsoft.com,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
 Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Marco Elver <elver@google.com>, KP Singh <kpsingh@kernel.org>, cai@lca.pw,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Network Development <netdev@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
 Martin KaFai Lau <kafai@fb.com>
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

Ck9uIDIwMjEvMS8xNyDkuIvljYgzOjU3LCBZdXJpIEJlbmRpdG92aWNoIHdyb3RlOgo+IE9uIFRo
dSwgSmFuIDE0LCAyMDIxIGF0IDU6MzkgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4+Cj4+IE9uIDIwMjEvMS8xMyDkuIvljYgxMDozMywgV2lsbGVtIGRlIEJydWlq
biB3cm90ZToKPj4+IE9uIFR1ZSwgSmFuIDEyLCAyMDIxIGF0IDExOjExIFBNIEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+IE9uIDIwMjEvMS8xMyDkuIrljYg3OjQ3
LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+Pj4+PiBPbiBUdWUsIEphbiAxMiwgMjAyMSBhdCAz
OjI5IFBNIFl1cmkgQmVuZGl0b3ZpY2gKPj4+Pj4gPHl1cmkuYmVuZGl0b3ZpY2hAZGF5bml4LmNv
bT4gd3JvdGU6Cj4+Pj4+PiBPbiBUdWUsIEphbiAxMiwgMjAyMSBhdCA5OjQ5IFBNIFl1cmkgQmVu
ZGl0b3ZpY2gKPj4+Pj4+IDx5dXJpLmJlbmRpdG92aWNoQGRheW5peC5jb20+IHdyb3RlOgo+Pj4+
Pj4+IE9uIFR1ZSwgSmFuIDEyLCAyMDIxIGF0IDk6NDEgUE0gWXVyaSBCZW5kaXRvdmljaAo+Pj4+
Pj4+IDx5dXJpLmJlbmRpdG92aWNoQGRheW5peC5jb20+IHdyb3RlOgo+Pj4+Pj4+PiBFeGlzdGlu
ZyBUVU4gbW9kdWxlIGlzIGFibGUgdG8gdXNlIHByb3ZpZGVkICJzdGVlcmluZyBlQlBGIiB0bwo+
Pj4+Pj4+PiBjYWxjdWxhdGUgcGVyLXBhY2tldCBoYXNoIGFuZCBkZXJpdmUgdGhlIGRlc3RpbmF0
aW9uIHF1ZXVlIHRvCj4+Pj4+Pj4+IHBsYWNlIHRoZSBwYWNrZXQgdG8uIFRoZSBlQlBGIHVzZXMg
bWFwcGVkIGNvbmZpZ3VyYXRpb24gZGF0YQo+Pj4+Pj4+PiBjb250YWluaW5nIGEga2V5IGZvciBo
YXNoIGNhbGN1bGF0aW9uIGFuZCBpbmRpcmVjdGlvbiB0YWJsZQo+Pj4+Pj4+PiB3aXRoIGFycmF5
IG9mIHF1ZXVlcycgaW5kaWNlcy4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gVGhpcyBzZXJpZXMgb2YgcGF0
Y2hlcyBhZGRzIHN1cHBvcnQgZm9yIHZpcnRpby1uZXQgaGFzaCByZXBvcnRpbmcKPj4+Pj4+Pj4g
ZmVhdHVyZSBhcyBkZWZpbmVkIGluIHZpcnRpbyBzcGVjaWZpY2F0aW9uLiBJdCBleHRlbmRzIHRo
ZSBUVU4gbW9kdWxlCj4+Pj4+Pj4+IGFuZCB0aGUgInN0ZWVyaW5nIGVCUEYiIGFzIGZvbGxvd3M6
Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEV4dGVuZGVkIHN0ZWVyaW5nIGVCUEYgY2FsY3VsYXRlcyB0aGUg
aGFzaCB2YWx1ZSBhbmQgaGFzaCB0eXBlLCBrZWVwcwo+Pj4+Pj4+PiBoYXNoIHZhbHVlIGluIHRo
ZSBza2ItPmhhc2ggYW5kIHJldHVybnMgaW5kZXggb2YgZGVzdGluYXRpb24gdmlydHF1ZXVlCj4+
Pj4+Pj4+IGFuZCB0aGUgdHlwZSBvZiB0aGUgaGFzaC4gVFVOIG1vZHVsZSBrZWVwcyByZXR1cm5l
ZCBoYXNoIHR5cGUgaW4KPj4+Pj4+Pj4gKGN1cnJlbnRseSB1bnVzZWQpIGZpZWxkIG9mIHRoZSBz
a2IuCj4+Pj4+Pj4+IHNrYi0+X191bnVzZWQgcmVuYW1lZCB0byAnaGFzaF9yZXBvcnRfdHlwZScu
Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFdoZW4gVFVOIG1vZHVsZSBpcyBjYWxsZWQgbGF0ZXIgdG8gYWxs
b2NhdGUgYW5kIGZpbGwgdGhlIHZpcnRpby1uZXQKPj4+Pj4+Pj4gaGVhZGVyIGFuZCBwdXNoIGl0
IHRvIGRlc3RpbmF0aW9uIHZpcnRxdWV1ZSBpdCBwb3B1bGF0ZXMgdGhlIGhhc2gKPj4+Pj4+Pj4g
YW5kIHRoZSBoYXNoIHR5cGUgaW50byB2aXJ0aW8tbmV0IGhlYWRlci4KPj4+Pj4+Pj4KPj4+Pj4+
Pj4gVkhPU1QgZHJpdmVyIGlzIG1hZGUgYXdhcmUgb2YgcmVzcGVjdGl2ZSB2aXJ0aW8tbmV0IGZl
YXR1cmUgdGhhdAo+Pj4+Pj4+PiBleHRlbmRzIHRoZSB2aXJ0aW8tbmV0IGhlYWRlciB0byByZXBv
cnQgdGhlIGhhc2ggdmFsdWUgYW5kIGhhc2ggcmVwb3J0Cj4+Pj4+Pj4+IHR5cGUuCj4+Pj4+Pj4g
Q29tbWVudCBmcm9tIFdpbGxlbSBkZSBCcnVpam46Cj4+Pj4+Pj4KPj4+Pj4+PiBTa2J1ZmYgZmll
bGRzIGFyZSBpbiBzaG9ydCBzdXBwbHkuIEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0byBhZGQgb25l
Cj4+Pj4+Pj4ganVzdCBmb3IgdGhpcyBuYXJyb3cgcGF0aCBlbnRpcmVseSBpbnRlcm5hbCB0byB0
aGUgdHVuIGRldmljZS4KPj4+Pj4+Pgo+Pj4+Pj4gV2UgdW5kZXJzdGFuZCB0aGF0IGFuZCB0cnkg
dG8gbWluaW1pemUgdGhlIGltcGFjdCBieSB1c2luZyBhbiBhbHJlYWR5Cj4+Pj4+PiBleGlzdGlu
ZyB1bnVzZWQgZmllbGQgb2Ygc2tiLgo+Pj4+PiBOb3QgYW55bW9yZS4gSXQgd2FzIHJlcHVycG9z
ZWQgYXMgYSBmbGFncyBmaWVsZCB2ZXJ5IHJlY2VudGx5Lgo+Pj4+Pgo+Pj4+PiBUaGlzIHVzZSBj
YXNlIGlzIGFsc28gdmVyeSBuYXJyb3cgaW4gc2NvcGUuIEFuZCBhIHZlcnkgc2hvcnQgcGF0aCBm
cm9tCj4+Pj4+IGRhdGEgcHJvZHVjZXIgdG8gY29uc3VtZXIuIFNvIEkgZG9uJ3QgdGhpbmsgaXQg
bmVlZHMgdG8gY2xhaW0gc2NhcmNlCj4+Pj4+IGJpdHMgaW4gdGhlIHNrYi4KPj4+Pj4KPj4+Pj4g
dHVuX2VicGZfc2VsZWN0X3F1ZXVlIHN0b3JlcyB0aGUgZmllbGQsIHR1bl9wdXRfdXNlciByZWFk
cyBpdCBhbmQKPj4+Pj4gY29udmVydHMgaXQgdG8gdGhlIHZpcnRpb19uZXRfaGRyIGluIHRoZSBk
ZXNjcmlwdG9yLgo+Pj4+Pgo+Pj4+PiB0dW5fZWJwZl9zZWxlY3RfcXVldWUgaXMgY2FsbGVkIGZy
b20gLm5kb19zZWxlY3RfcXVldWUuICBTdG9yaW5nIHRoZQo+Pj4+PiBmaWVsZCBpbiBza2ItPmNi
IGlzIGZyYWdpbGUsIGFzIGluIHRoZW9yeSBzb21lIGNvZGUgY291bGQgb3ZlcndyaXRlCj4+Pj4+
IHRoYXQgYmV0d2VlbiBmaWVsZCBiZXR3ZWVuIG5kb19zZWxlY3RfcXVldWUgYW5kCj4+Pj4+IG5k
b19zdGFydF94bWl0L3R1bl9uZXRfeG1pdCwgZnJvbSB3aGljaCBwb2ludCBpdCBpcyBmdWxseSB1
bmRlciB0dW4KPj4+Pj4gY29udHJvbCBhZ2Fpbi4gQnV0IGluIHByYWN0aWNlLCBJIGRvbid0IGJl
bGlldmUgYW55dGhpbmcgZG9lcy4KPj4+Pj4KPj4+Pj4gQWx0ZXJuYXRpdmVseSBhbiBleGlzdGlu
ZyBza2IgZmllbGQgdGhhdCBpcyB1c2VkIG9ubHkgb24gZGlzam9pbnQKPj4+Pj4gZGF0YXBhdGhz
LCBzdWNoIGFzIGluZ3Jlc3Mtb25seSwgY291bGQgYmUgdmlhYmxlLgo+Pj4+IEEgcXVlc3Rpb24g
aGVyZS4gV2UgaGFkIG1ldGFkYXRhIHN1cHBvcnQgaW4gWERQIGZvciBjb29wZXJhdGlvbiBiZXR3
ZWVuCj4+Pj4gZUJQRiBwcm9ncmFtcy4gRG8gd2UgaGF2ZSBzb21ldGhpbmcgc2ltaWxhciBpbiB0
aGUgc2tiPwo+Pj4+Cj4+Pj4gRS5nIGluIHRoZSBSU1MsIGlmIHdlIHdhbnQgdG8gcGFzcyBzb21l
IG1ldGFkYXRhIGluZm9ybWF0aW9uIGJldHdlZW4KPj4+PiBlQlBGIHByb2dyYW0gYW5kIHRoZSBs
b2dpYyB0aGF0IGdlbmVyYXRlcyB0aGUgdm5ldCBoZWFkZXIgKGVpdGhlciBoYXJkCj4+Pj4gbG9n
aWMgaW4gdGhlIGtlcm5lbCBvciBhbm90aGVyIGVCUEYgcHJvZ3JhbSkuIElzIHRoZXJlIGFueSB3
YXkgdGhhdCBjYW4KPj4+PiBhdm9pZCB0aGUgcG9zc2libGUgY29uZmxpY3RzIG9mIHFkaXNjcz8K
Pj4+IE5vdCB0aGF0IEkgYW0gYXdhcmUgb2YuIFRoZSBjbG9zZXN0IHRoaW5nIGlzIGNiW10uCj4+
Pgo+Pj4gSXQnbGwgaGF2ZSB0byBhbGlhc2UgYSBmaWVsZCBsaWtlIHRoYXQsIHRoYXQgaXMga25v
d24gdW51c2VkIGZvciB0aGUgZ2l2ZW4gcGF0aC4KPj4KPj4gUmlnaHQsIHdlIG5lZWQgdG8gbWFr
ZSBzdXJlIGNiIGlzIG5vdCB1c2VkIGJ5IG90aGVyIG9uZXMuIEknbSBub3Qgc3VyZQo+PiBob3cg
aGFyZCB0byBhY2hpZXZlIHRoYXQgY29uc2lkZXIgUWVtdSBpbnN0YWxscyB0aGUgZUJQRiBwcm9n
cmFtIGJ1dCBpdAo+PiBkb2Vzbid0IGRlYWwgd2l0aCBuZXR3b3JraW5nIGNvbmZpZ3VyYXRpb25z
Lgo+Pgo+Pgo+Pj4gT25lIG90aGVyIGFwcHJvYWNoIHRoYXQgaGFzIGJlZW4gdXNlZCB3aXRoaW4g
bGluZWFyIGNhbGwgc3RhY2tzIGlzIG91dAo+Pj4gb2YgYmFuZC4gTGlrZSBwZXJjcHUgdmFyaWFi
bGVzIHNvZnRuZXRfZGF0YS54bWl0Lm1vcmUgYW5kCj4+PiBtaXJyZWRfcmVjX2xldmVsLiBCdXQg
dGhhdCBpcyBwZXJoYXBzIGEgYml0IG92ZXJ3cm91Z2h0IGZvciB0aGlzIHVzZQo+Pj4gY2FzZS4K
Pj4KPj4gWWVzLCBhbmQgaWYgd2UgZ28gdGhhdCB3YXkgdGhlbiBlQlBGIHR1cm5zIG91dCB0byBi
ZSBhIGJ1cmRlbiBzaW5jZSB3ZQo+PiBuZWVkIHRvIGludmVudCBoZWxwZXJzIHRvIGFjY2VzcyB0
aG9zZSBhdXhpbGlhcnkgZGF0YSBzdHJ1Y3R1cmUuIEl0Cj4+IHdvdWxkIGJlIGJldHRlciB0aGVu
IHRvIGhhcmQtY29kZWQgdGhlIFJTUyBpbiB0aGUga2VybmVsLgo+Pgo+Pgo+Pj4+Pj4+IEluc3Rl
YWQsIHlvdSBjb3VsZCBqdXN0IHJ1biB0aGUgZmxvd19kaXNzZWN0b3IgaW4gdHVuX3B1dF91c2Vy
IGlmIHRoZQo+Pj4+Pj4+IGZlYXR1cmUgaXMgbmVnb3RpYXRlZC4gSW5kZWVkLCB0aGUgZmxvdyBk
aXNzZWN0b3Igc2VlbXMgbW9yZSBhcHQgdG8gbWUKPj4+Pj4+PiB0aGFuIEJQRiBoZXJlLiBOb3Rl
IHRoYXQgdGhlIGZsb3cgZGlzc2VjdG9yIGludGVybmFsbHkgY2FuIGJlCj4+Pj4+Pj4gb3ZlcnJp
ZGRlbiBieSBhIEJQRiBwcm9ncmFtIGlmIHRoZSBhZG1pbiBzbyBjaG9vc2VzLgo+Pj4+Pj4+Cj4+
Pj4+PiBXaGVuIHRoaXMgc2V0IG9mIHBhdGNoZXMgaXMgcmVsYXRlZCB0byBoYXNoIGRlbGl2ZXJ5
IGluIHRoZSB2aXJ0aW8tbmV0Cj4+Pj4+PiBwYWNrZXQgaW4gZ2VuZXJhbCwKPj4+Pj4+IGl0IHdh
cyBwcmVwYXJlZCBpbiBjb250ZXh0IG9mIFJTUyBmZWF0dXJlIGltcGxlbWVudGF0aW9uIGFzIGRl
ZmluZWQgaW4KPj4+Pj4+IHZpcnRpbyBzcGVjIFsxXQo+Pj4+Pj4gSW4gY2FzZSBvZiBSU1MgaXQg
aXMgbm90IGVub3VnaCB0byBydW4gdGhlIGZsb3dfZGlzc2VjdG9yIGluIHR1bl9wdXRfdXNlcjoK
Pj4+Pj4+IGluIHR1bl9lYnBmX3NlbGVjdF9xdWV1ZSB0aGUgVFVOIGNhbGxzIGVCUEYgdG8gY2Fs
Y3VsYXRlIHRoZSBoYXNoLAo+Pj4+Pj4gaGFzaCB0eXBlIGFuZCBxdWV1ZSBpbmRleAo+Pj4+Pj4g
YWNjb3JkaW5nIHRvIHRoZSAobWFwcGVkKSBwYXJhbWV0ZXJzIChrZXksIGhhc2ggdHlwZXMsIGlu
ZGlyZWN0aW9uCj4+Pj4+PiB0YWJsZSkgcmVjZWl2ZWQgZnJvbSB0aGUgZ3Vlc3QuCj4+Pj4+IFRV
TlNFVFNURUVSSU5HRUJQRiB3YXMgYWRkZWQgdG8gc3VwcG9ydCBtb3JlIGRpdmVyc2UgcXVldWUg
c2VsZWN0aW9uCj4+Pj4+IHRoYW4gdGhlIGRlZmF1bHQgaW4gY2FzZSBvZiBtdWx0aXF1ZXVlIHR1
bi4gTm90IHN1cmUgd2hhdCB0aGUgZXhhY3QKPj4+Pj4gdXNlIGNhc2VzIGFyZS4KPj4+Pj4KPj4+
Pj4gQnV0IFJTUyBpcyBleGFjdGx5IHRoZSBwdXJwb3NlIG9mIHRoZSBmbG93IGRpc3NlY3Rvci4g
SXQgaXMgdXNlZCBmb3IKPj4+Pj4gdGhhdCBwdXJwb3NlIGluIHRoZSBzb2Z0d2FyZSB2YXJpYW50
IFJQUy4gVGhlIGZsb3cgZGlzc2VjdG9yCj4+Pj4+IGltcGxlbWVudHMgYSBzdXBlcnNldCBvZiB0
aGUgUlNTIHNwZWMsIGFuZCBjZXJ0YWlubHkgY29tcHV0ZXMgYQo+Pj4+PiBmb3VyLXR1cGxlIGZv
ciBUQ1AvSVB2Ni4gSW4gdGhlIGNhc2Ugb2YgUlBTLCBpdCBpcyBza2lwcGVkIGlmIHRoZSBOSUMK
Pj4+Pj4gaGFzIGFscmVhZHkgY29tcHV0ZWQgYSA0LXR1cGxlIGhhc2guCj4+Pj4+Cj4+Pj4+IFdo
YXQgaXQgZG9lcyBub3QgZ2l2ZSBpcyBhIHR5cGUgaW5kaWNhdGlvbiwgc3VjaCBhcwo+Pj4+PiBW
SVJUSU9fTkVUX0hBU0hfVFlQRV9UQ1B2Ni4gSSBkb24ndCB1bmRlcnN0YW5kIGhvdyB0aGlzIHdv
dWxkIGJlIHVzZWQuCj4+Pj4+IEluIGRhdGFwYXRocyB3aGVyZSB0aGUgTklDIGhhcyBhbHJlYWR5
IGNvbXB1dGVkIHRoZSBmb3VyLXR1cGxlIGhhc2gKPj4+Pj4gYW5kIHN0b3JlZCBpdCBpbiBza2It
Pmhhc2ggLS10aGUgY29tbW9uIGNhc2UgZm9yIHNlcnZlcnMtLSwgVGhhdCB0eXBlCj4+Pj4+IGZp
ZWxkIGlzIHRoZSBvbmx5IHJlYXNvbiB0byBoYXZlIHRvIGNvbXB1dGUgYWdhaW4uCj4+Pj4gVGhl
IHByb2JsZW0gaXMgdGhlcmUncyBubyBndWFyYW50ZWUgdGhhdCB0aGUgcGFja2V0IGNvbWVzIGZy
b20gdGhlIE5JQywKPj4+PiBpdCBjb3VsZCBiZSBhIHNpbXBsZSBWTTJWTSBvciBob3N0MlZNIHBh
Y2tldC4KPj4+Pgo+Pj4+IEFuZCBldmVuIGlmIHRoZSBwYWNrZXQgaXMgY29taW5nIGZyb20gdGhl
IE5JQyB0aGF0IGNhbGN1bGF0ZXMgdGhlIGhhc2gKPj4+PiB0aGVyZSdzIG5vIGd1YXJhbnRlZSB0
aGF0IGl0J3MgdGhlIGhhcyB0aGF0IGd1ZXN0IHdhbnQgKGd1ZXN0IG1heSB1c2UKPj4+PiBkaWZm
ZXJlbnQgUlNTIGtleXMpLgo+Pj4gQWggeWVzLCBvZiBjb3Vyc2UuCj4+Pgo+Pj4gSSB3b3VsZCBz
dGlsbCByZXZpc2l0IHRoZSBuZWVkIHRvIHN0b3JlIGEgZGV0YWlsZWQgaGFzaF90eXBlIGFsb25n
IHdpdGgKPj4+IHRoZSBoYXNoLCBhcyBhcyBmYXIgSSBjYW4gdGVsbCB0aGF0IGNvbnZleXMgbm8g
YWN0aW9uYWJsZSBpbmZvcm1hdGlvbgo+Pj4gdG8gdGhlIGd1ZXN0Lgo+Pgo+PiBZZXMsIG5lZWQg
dG8gZmlndXJlIG91dCBpdHMgdXNhZ2UuIEFjY29yZGluZyB0byBbMV0sIGl0IG9ubHkgbWVudGlv
bgo+PiB0aGF0IHN0b3JpbmcgaGFzIHR5cGUgaXMgYSBjaGFyZ2Ugb2YgZHJpdmVyLiBNYXliZSBZ
dXJpIGNhbiBhbnN3ZXIgdGhpcy4KPj4KPiBGb3IgdGhlIGNhc2Ugb2YgV2luZG93cyBWTSB3ZSBj
YW4ndCBrbm93IGhvdyBleGFjdGx5IHRoZSBuZXR3b3JrIHN0YWNrCj4gdXNlcyBwcm92aWRlZCBo
YXNoIGRhdGEgKGluY2x1ZGluZyBoYXNoIHR5cGUpLiBCdXQ6IGRpZmZlcmVudCByZWxlYXNlcwo+
IG9mIFdpbmRvd3MKPiBlbmFibGUgZGlmZmVyZW50IGhhc2ggdHlwZXMgKGZvciBleGFtcGxlIFVE
UCBoYXNoIGlzIGVuYWJsZWQgb25seSBvbgo+IFNlcnZlciAyMDE2IGFuZCB1cCkuCj4KPiBJbmRl
ZWQgdGhlIFdpbmRvd3MgcmVxdWlyZXMgYSBsaXR0bGUgbW9yZSBmcm9tIHRoZSBuZXR3b3JrIGFk
YXB0ZXIvZHJpdmVyCj4gdGhhbiBMaW51eCBkb2VzLgo+Cj4gVGhlIGFkZGl0aW9uIG9mIFJTUyBz
dXBwb3J0IHRvIHZpcnRpbyBzcGVjaWZpY2F0aW9uIHRha2VzIGluIGFjY291bnQKPiB0aGUgd2lk
ZXN0IHNldCBvZgo+IHJlcXVpcmVtZW50cyAoaS5lLiBXaW5kb3dzIG9uZSksIG91ciBpbml0aWFs
IGltcHJlc3Npb24gaXMgdGhhdCB0aGlzCj4gc2hvdWxkIGJlIGVub3VnaCBhbHNvIGZvciBMaW51
eC4KPgo+IFRoZSBORElTIHNwZWNpZmljYXRpb24gaW4gcGFydCBvZiBSU1MgaXMgX21hbmRhdG9y
eV8gYW5kIHRoZXJlIGFyZQo+IGNlcnRpZmljYXRpb24gdGVzdHMKPiB0aGF0IGNoZWNrIHRoYXQg
dGhlIGRyaXZlciBwcm92aWRlcyB0aGUgaGFzaCBkYXRhIGFzIGV4cGVjdGVkLiBBbGwgdGhlCj4g
aGlnaC1wZXJmb3JtYW5jZQo+IG5ldHdvcmsgYWRhcHRlcnMgaGF2ZSBzdWNoIFJTUyBmdW5jdGlv
bmFsaXR5IGluIHRoZSBoYXJkd2FyZS4KPiBXaXRoIHByZS1SU1MgUUVNVSAoaS5lLiB3aGVyZSB0
aGUgdmlydGlvLW5ldCBkZXZpY2UgZG9lcyBub3QgaW5kaWNhdGUKPiB0aGUgUlNTIHN1cHBvcnQp
Cj4gdGhlIHZpcnRpby1uZXQgZHJpdmVyIGZvciBXaW5kb3dzIGRvZXMgYWxsIHRoZSBqb2IgcmVs
YXRlZCB0byBSU1M6Cj4gLSBoYXNoIGNhbGN1bGF0aW9uCj4gLSBoYXNoL2hhc2hfdHlwZSBkZWxp
dmVyeQo+IC0gcmVwb3J0aW5nIGVhY2ggcGFja2V0IG9uIHRoZSBjb3JyZWN0IENQVSBhY2NvcmRp
bmcgdG8gUlNTIHNldHRpbmdzCj4KPiBXaXRoIFJTUyBzdXBwb3J0IGluIFFFTVUgYWxsIHRoZSBw
YWNrZXRzIGFsd2F5cyBjb21lIG9uIGEgcHJvcGVyIENQVSBhbmQKPiB0aGUgZHJpdmVyIG5ldmVy
IG5lZWRzIHRvIHJlc2NoZWR1bGUgdGhlbS4gVGhlIGRyaXZlciBzdGlsbCBuZWVkIHRvCj4gY2Fs
Y3VsYXRlIHRoZQo+IGhhc2ggYW5kIHJlcG9ydCBpdCB0byBXaW5kb3dzLiBJbiB0aGlzIGNhc2Ug
d2UgZG8gdGhlIHNhbWUgam9iIHR3aWNlOiB0aGUgZGV2aWNlCj4gKFFFTVUgb3IgZUJQRikgZG9l
cyBjYWxjdWxhdGUgdGhlIGhhc2ggYW5kIGdldCBwcm9wZXIgcXVldWUvQ1BVIHRvIGRlbGl2ZXIK
PiB0aGUgcGFja2V0LiBCdXQgdGhlIGhhc2ggaXMgbm90IGRlbGl2ZXJlZCBieSB0aGUgZGV2aWNl
LCBzbyB0aGUgZHJpdmVyIG5lZWRzIHRvCj4gcmVjYWxjdWxhdGUgaXQgYW5kIHJlcG9ydCB0byB0
aGUgV2luZG93cy4KPgo+IElmIHdlIGFkZCBIQVNIX1JFUE9SVCBzdXBwb3J0IChjdXJyZW50IHNl
dCBvZiBwYXRjaGVzKSBhbmQgdGhlIGRldmljZQo+IGluZGljYXRlcyB0aGlzCj4gZmVhdHVyZSB3
ZSBjYW4gYXZvaWQgaGFzaCByZWNhbGN1bGF0aW9uIGluIHRoZSBkcml2ZXIgYXNzdW1pbmcgd2UK
PiByZWNlaXZlIHRoZSBjb3JyZWN0IGhhc2gKPiB2YWx1ZSBhbmQgaGFzaCB0eXBlLiBPdGhlcndp
c2UgdGhlIGRyaXZlciBjYW4ndCBrbm93IHdoaWNoIGV4YWN0bHkKPiBoYXNoIHRoZSBkZXZpY2Ug
aGFzIGNhbGN1bGF0ZWQuCj4KPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBkaWQgbm90IGFuc3dl
ciB0aGUgcXVlc3Rpb24uCgoKSSB0aGluayBJIGdldCB5b3UuIFRoZSBoYXNoIHR5cGUgaXMgYWxz
byBhIGtpbmQgb2YgY2xhc3NpZmljYXRpb24gKGUuZyAKVENQIG9yIFVEUCkuIEFueSBwb3NzaWJp
bGl0eSB0aGF0IGl0IGNhbiBiZSBkZWR1Y2VkIGZyb20gdGhlIGRyaXZlcj8gKE9yIAppdCBjb3Vs
ZCBiZSB0b28gZXhwZW5zaXZlIHRvIGRvIHRoYXQpLgoKVGhhbmtzCgoKPgo+PiBUaGFua3MKPj4K
Pj4gWzFdCj4+IGh0dHBzOi8vZG9jcy5taWNyb3NvZnQuY29tL2VuLXVzL3dpbmRvd3MtaGFyZHdh
cmUvZHJpdmVycy9uZXR3b3JrL2luZGljYXRpbmctcnNzLXJlY2VpdmUtZGF0YQo+Pgo+PgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
