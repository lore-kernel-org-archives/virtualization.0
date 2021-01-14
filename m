Return-Path: <SRS0=VcnQ=GR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF10C433DB
	for <virtualization@archiver.kernel.org>; Thu, 14 Jan 2021 03:39:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211B423343
	for <virtualization@archiver.kernel.org>; Thu, 14 Jan 2021 03:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211B423343
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8F13586B74;
	Thu, 14 Jan 2021 03:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZakP2610s-Xn; Thu, 14 Jan 2021 03:39:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9F3B086A28;
	Thu, 14 Jan 2021 03:39:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C019C0893;
	Thu, 14 Jan 2021 03:39:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76EC2C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 03:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 66BB0872F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 03:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GP-Vp-jKU40k
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 03:39:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1616B872BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 03:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610595576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qtF1idSqCy5ua8Az2XtZ/1G+SswhJSq5w0eZMMNKzU8=;
 b=jWecqsOadZPzEyOtTJA7pjDYatlvo1kIZCJUd771oQ6mMbGkpg421V0SfPNe1k31zCtXwR
 ipRfUVXpubPQNpfGpuHCQDSNRI1loJXTInkQlxh2ozV6+rr4N4AZVR9mc8Su9Dwl3wTe50
 hrhcacw/VX1/E4uCW+5+8czppvO+foM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542--aJiRCZ_NrCYrBKuyUt_sg-1; Wed, 13 Jan 2021 22:39:34 -0500
X-MC-Unique: -aJiRCZ_NrCYrBKuyUt_sg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 638DB15720;
 Thu, 14 Jan 2021 03:39:30 +0000 (UTC)
Received: from [10.72.12.100] (ovpn-12-100.pek2.redhat.com [10.72.12.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C48760C0F;
 Thu, 14 Jan 2021 03:39:04 +0000 (UTC)
Subject: Re: [RFC PATCH 0/7] Support for virtio-net hash reporting
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
 <CAOEp5OejaX4ZETThrj4-n8_yZoeTZs56CBPHbQqNsR2oni8dWw@mail.gmail.com>
 <CAOEp5Oc5qif_krU8oC6qhq6X0xRW-9GpWrBzWgPw0WevyhT8Mg@mail.gmail.com>
 <CA+FuTSfhBZfEf8+LKNUJQpSxt8c5h1wMpARupekqFKuei6YBsA@mail.gmail.com>
 <78bbc518-4b73-4629-68fb-2713250f8967@redhat.com>
 <CA+FuTSfJJhEYr6gXmjpjjXzg6Xm5wWa-dL1SEV-Zt7RcPXGztg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8ea218a8-a068-1ed9-929d-67ad30111c3c@redhat.com>
Date: Thu, 14 Jan 2021 11:38:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+FuTSfJJhEYr6gXmjpjjXzg6Xm5wWa-dL1SEV-Zt7RcPXGztg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Song Liu <songliubraving@fb.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Yan Vugenfirer <yan@daynix.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, decui@microsoft.com,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
 Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Marco Elver <elver@google.com>, KP Singh <kpsingh@kernel.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, cai@lca.pw,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Network Development <netdev@vger.kernel.org>, rdunlap@infradead.org,
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

Ck9uIDIwMjEvMS8xMyDkuIvljYgxMDozMywgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiBPbiBU
dWUsIEphbiAxMiwgMjAyMSBhdCAxMToxMSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPj4KPj4gT24gMjAyMS8xLzEzIOS4iuWNiDc6NDcsIFdpbGxlbSBkZSBCcnVp
am4gd3JvdGU6Cj4+PiBPbiBUdWUsIEphbiAxMiwgMjAyMSBhdCAzOjI5IFBNIFl1cmkgQmVuZGl0
b3ZpY2gKPj4+IDx5dXJpLmJlbmRpdG92aWNoQGRheW5peC5jb20+IHdyb3RlOgo+Pj4+IE9uIFR1
ZSwgSmFuIDEyLCAyMDIxIGF0IDk6NDkgUE0gWXVyaSBCZW5kaXRvdmljaAo+Pj4+IDx5dXJpLmJl
bmRpdG92aWNoQGRheW5peC5jb20+IHdyb3RlOgo+Pj4+PiBPbiBUdWUsIEphbiAxMiwgMjAyMSBh
dCA5OjQxIFBNIFl1cmkgQmVuZGl0b3ZpY2gKPj4+Pj4gPHl1cmkuYmVuZGl0b3ZpY2hAZGF5bml4
LmNvbT4gd3JvdGU6Cj4+Pj4+PiBFeGlzdGluZyBUVU4gbW9kdWxlIGlzIGFibGUgdG8gdXNlIHBy
b3ZpZGVkICJzdGVlcmluZyBlQlBGIiB0bwo+Pj4+Pj4gY2FsY3VsYXRlIHBlci1wYWNrZXQgaGFz
aCBhbmQgZGVyaXZlIHRoZSBkZXN0aW5hdGlvbiBxdWV1ZSB0bwo+Pj4+Pj4gcGxhY2UgdGhlIHBh
Y2tldCB0by4gVGhlIGVCUEYgdXNlcyBtYXBwZWQgY29uZmlndXJhdGlvbiBkYXRhCj4+Pj4+PiBj
b250YWluaW5nIGEga2V5IGZvciBoYXNoIGNhbGN1bGF0aW9uIGFuZCBpbmRpcmVjdGlvbiB0YWJs
ZQo+Pj4+Pj4gd2l0aCBhcnJheSBvZiBxdWV1ZXMnIGluZGljZXMuCj4+Pj4+Pgo+Pj4+Pj4gVGhp
cyBzZXJpZXMgb2YgcGF0Y2hlcyBhZGRzIHN1cHBvcnQgZm9yIHZpcnRpby1uZXQgaGFzaCByZXBv
cnRpbmcKPj4+Pj4+IGZlYXR1cmUgYXMgZGVmaW5lZCBpbiB2aXJ0aW8gc3BlY2lmaWNhdGlvbi4g
SXQgZXh0ZW5kcyB0aGUgVFVOIG1vZHVsZQo+Pj4+Pj4gYW5kIHRoZSAic3RlZXJpbmcgZUJQRiIg
YXMgZm9sbG93czoKPj4+Pj4+Cj4+Pj4+PiBFeHRlbmRlZCBzdGVlcmluZyBlQlBGIGNhbGN1bGF0
ZXMgdGhlIGhhc2ggdmFsdWUgYW5kIGhhc2ggdHlwZSwga2VlcHMKPj4+Pj4+IGhhc2ggdmFsdWUg
aW4gdGhlIHNrYi0+aGFzaCBhbmQgcmV0dXJucyBpbmRleCBvZiBkZXN0aW5hdGlvbiB2aXJ0cXVl
dWUKPj4+Pj4+IGFuZCB0aGUgdHlwZSBvZiB0aGUgaGFzaC4gVFVOIG1vZHVsZSBrZWVwcyByZXR1
cm5lZCBoYXNoIHR5cGUgaW4KPj4+Pj4+IChjdXJyZW50bHkgdW51c2VkKSBmaWVsZCBvZiB0aGUg
c2tiLgo+Pj4+Pj4gc2tiLT5fX3VudXNlZCByZW5hbWVkIHRvICdoYXNoX3JlcG9ydF90eXBlJy4K
Pj4+Pj4+Cj4+Pj4+PiBXaGVuIFRVTiBtb2R1bGUgaXMgY2FsbGVkIGxhdGVyIHRvIGFsbG9jYXRl
IGFuZCBmaWxsIHRoZSB2aXJ0aW8tbmV0Cj4+Pj4+PiBoZWFkZXIgYW5kIHB1c2ggaXQgdG8gZGVz
dGluYXRpb24gdmlydHF1ZXVlIGl0IHBvcHVsYXRlcyB0aGUgaGFzaAo+Pj4+Pj4gYW5kIHRoZSBo
YXNoIHR5cGUgaW50byB2aXJ0aW8tbmV0IGhlYWRlci4KPj4+Pj4+Cj4+Pj4+PiBWSE9TVCBkcml2
ZXIgaXMgbWFkZSBhd2FyZSBvZiByZXNwZWN0aXZlIHZpcnRpby1uZXQgZmVhdHVyZSB0aGF0Cj4+
Pj4+PiBleHRlbmRzIHRoZSB2aXJ0aW8tbmV0IGhlYWRlciB0byByZXBvcnQgdGhlIGhhc2ggdmFs
dWUgYW5kIGhhc2ggcmVwb3J0Cj4+Pj4+PiB0eXBlLgo+Pj4+PiBDb21tZW50IGZyb20gV2lsbGVt
IGRlIEJydWlqbjoKPj4+Pj4KPj4+Pj4gU2tidWZmIGZpZWxkcyBhcmUgaW4gc2hvcnQgc3VwcGx5
LiBJIGRvbid0IHRoaW5rIHdlIG5lZWQgdG8gYWRkIG9uZQo+Pj4+PiBqdXN0IGZvciB0aGlzIG5h
cnJvdyBwYXRoIGVudGlyZWx5IGludGVybmFsIHRvIHRoZSB0dW4gZGV2aWNlLgo+Pj4+Pgo+Pj4+
IFdlIHVuZGVyc3RhbmQgdGhhdCBhbmQgdHJ5IHRvIG1pbmltaXplIHRoZSBpbXBhY3QgYnkgdXNp
bmcgYW4gYWxyZWFkeQo+Pj4+IGV4aXN0aW5nIHVudXNlZCBmaWVsZCBvZiBza2IuCj4+PiBOb3Qg
YW55bW9yZS4gSXQgd2FzIHJlcHVycG9zZWQgYXMgYSBmbGFncyBmaWVsZCB2ZXJ5IHJlY2VudGx5
Lgo+Pj4KPj4+IFRoaXMgdXNlIGNhc2UgaXMgYWxzbyB2ZXJ5IG5hcnJvdyBpbiBzY29wZS4gQW5k
IGEgdmVyeSBzaG9ydCBwYXRoIGZyb20KPj4+IGRhdGEgcHJvZHVjZXIgdG8gY29uc3VtZXIuIFNv
IEkgZG9uJ3QgdGhpbmsgaXQgbmVlZHMgdG8gY2xhaW0gc2NhcmNlCj4+PiBiaXRzIGluIHRoZSBz
a2IuCj4+Pgo+Pj4gdHVuX2VicGZfc2VsZWN0X3F1ZXVlIHN0b3JlcyB0aGUgZmllbGQsIHR1bl9w
dXRfdXNlciByZWFkcyBpdCBhbmQKPj4+IGNvbnZlcnRzIGl0IHRvIHRoZSB2aXJ0aW9fbmV0X2hk
ciBpbiB0aGUgZGVzY3JpcHRvci4KPj4+Cj4+PiB0dW5fZWJwZl9zZWxlY3RfcXVldWUgaXMgY2Fs
bGVkIGZyb20gLm5kb19zZWxlY3RfcXVldWUuICBTdG9yaW5nIHRoZQo+Pj4gZmllbGQgaW4gc2ti
LT5jYiBpcyBmcmFnaWxlLCBhcyBpbiB0aGVvcnkgc29tZSBjb2RlIGNvdWxkIG92ZXJ3cml0ZQo+
Pj4gdGhhdCBiZXR3ZWVuIGZpZWxkIGJldHdlZW4gbmRvX3NlbGVjdF9xdWV1ZSBhbmQKPj4+IG5k
b19zdGFydF94bWl0L3R1bl9uZXRfeG1pdCwgZnJvbSB3aGljaCBwb2ludCBpdCBpcyBmdWxseSB1
bmRlciB0dW4KPj4+IGNvbnRyb2wgYWdhaW4uIEJ1dCBpbiBwcmFjdGljZSwgSSBkb24ndCBiZWxp
ZXZlIGFueXRoaW5nIGRvZXMuCj4+Pgo+Pj4gQWx0ZXJuYXRpdmVseSBhbiBleGlzdGluZyBza2Ig
ZmllbGQgdGhhdCBpcyB1c2VkIG9ubHkgb24gZGlzam9pbnQKPj4+IGRhdGFwYXRocywgc3VjaCBh
cyBpbmdyZXNzLW9ubHksIGNvdWxkIGJlIHZpYWJsZS4KPj4KPj4gQSBxdWVzdGlvbiBoZXJlLiBX
ZSBoYWQgbWV0YWRhdGEgc3VwcG9ydCBpbiBYRFAgZm9yIGNvb3BlcmF0aW9uIGJldHdlZW4KPj4g
ZUJQRiBwcm9ncmFtcy4gRG8gd2UgaGF2ZSBzb21ldGhpbmcgc2ltaWxhciBpbiB0aGUgc2tiPwo+
Pgo+PiBFLmcgaW4gdGhlIFJTUywgaWYgd2Ugd2FudCB0byBwYXNzIHNvbWUgbWV0YWRhdGEgaW5m
b3JtYXRpb24gYmV0d2Vlbgo+PiBlQlBGIHByb2dyYW0gYW5kIHRoZSBsb2dpYyB0aGF0IGdlbmVy
YXRlcyB0aGUgdm5ldCBoZWFkZXIgKGVpdGhlciBoYXJkCj4+IGxvZ2ljIGluIHRoZSBrZXJuZWwg
b3IgYW5vdGhlciBlQlBGIHByb2dyYW0pLiBJcyB0aGVyZSBhbnkgd2F5IHRoYXQgY2FuCj4+IGF2
b2lkIHRoZSBwb3NzaWJsZSBjb25mbGljdHMgb2YgcWRpc2NzPwo+IE5vdCB0aGF0IEkgYW0gYXdh
cmUgb2YuIFRoZSBjbG9zZXN0IHRoaW5nIGlzIGNiW10uCj4KPiBJdCdsbCBoYXZlIHRvIGFsaWFz
ZSBhIGZpZWxkIGxpa2UgdGhhdCwgdGhhdCBpcyBrbm93biB1bnVzZWQgZm9yIHRoZSBnaXZlbiBw
YXRoLgoKClJpZ2h0LCB3ZSBuZWVkIHRvIG1ha2Ugc3VyZSBjYiBpcyBub3QgdXNlZCBieSBvdGhl
ciBvbmVzLiBJJ20gbm90IHN1cmUgCmhvdyBoYXJkIHRvIGFjaGlldmUgdGhhdCBjb25zaWRlciBR
ZW11IGluc3RhbGxzIHRoZSBlQlBGIHByb2dyYW0gYnV0IGl0IApkb2Vzbid0IGRlYWwgd2l0aCBu
ZXR3b3JraW5nIGNvbmZpZ3VyYXRpb25zLgoKCj4KPiBPbmUgb3RoZXIgYXBwcm9hY2ggdGhhdCBo
YXMgYmVlbiB1c2VkIHdpdGhpbiBsaW5lYXIgY2FsbCBzdGFja3MgaXMgb3V0Cj4gb2YgYmFuZC4g
TGlrZSBwZXJjcHUgdmFyaWFibGVzIHNvZnRuZXRfZGF0YS54bWl0Lm1vcmUgYW5kCj4gbWlycmVk
X3JlY19sZXZlbC4gQnV0IHRoYXQgaXMgcGVyaGFwcyBhIGJpdCBvdmVyd3JvdWdodCBmb3IgdGhp
cyB1c2UKPiBjYXNlLgoKClllcywgYW5kIGlmIHdlIGdvIHRoYXQgd2F5IHRoZW4gZUJQRiB0dXJu
cyBvdXQgdG8gYmUgYSBidXJkZW4gc2luY2Ugd2UgCm5lZWQgdG8gaW52ZW50IGhlbHBlcnMgdG8g
YWNjZXNzIHRob3NlIGF1eGlsaWFyeSBkYXRhIHN0cnVjdHVyZS4gSXQgCndvdWxkIGJlIGJldHRl
ciB0aGVuIHRvIGhhcmQtY29kZWQgdGhlIFJTUyBpbiB0aGUga2VybmVsLgoKCj4KPj4+Pj4gSW5z
dGVhZCwgeW91IGNvdWxkIGp1c3QgcnVuIHRoZSBmbG93X2Rpc3NlY3RvciBpbiB0dW5fcHV0X3Vz
ZXIgaWYgdGhlCj4+Pj4+IGZlYXR1cmUgaXMgbmVnb3RpYXRlZC4gSW5kZWVkLCB0aGUgZmxvdyBk
aXNzZWN0b3Igc2VlbXMgbW9yZSBhcHQgdG8gbWUKPj4+Pj4gdGhhbiBCUEYgaGVyZS4gTm90ZSB0
aGF0IHRoZSBmbG93IGRpc3NlY3RvciBpbnRlcm5hbGx5IGNhbiBiZQo+Pj4+PiBvdmVycmlkZGVu
IGJ5IGEgQlBGIHByb2dyYW0gaWYgdGhlIGFkbWluIHNvIGNob29zZXMuCj4+Pj4+Cj4+Pj4gV2hl
biB0aGlzIHNldCBvZiBwYXRjaGVzIGlzIHJlbGF0ZWQgdG8gaGFzaCBkZWxpdmVyeSBpbiB0aGUg
dmlydGlvLW5ldAo+Pj4+IHBhY2tldCBpbiBnZW5lcmFsLAo+Pj4+IGl0IHdhcyBwcmVwYXJlZCBp
biBjb250ZXh0IG9mIFJTUyBmZWF0dXJlIGltcGxlbWVudGF0aW9uIGFzIGRlZmluZWQgaW4KPj4+
PiB2aXJ0aW8gc3BlYyBbMV0KPj4+PiBJbiBjYXNlIG9mIFJTUyBpdCBpcyBub3QgZW5vdWdoIHRv
IHJ1biB0aGUgZmxvd19kaXNzZWN0b3IgaW4gdHVuX3B1dF91c2VyOgo+Pj4+IGluIHR1bl9lYnBm
X3NlbGVjdF9xdWV1ZSB0aGUgVFVOIGNhbGxzIGVCUEYgdG8gY2FsY3VsYXRlIHRoZSBoYXNoLAo+
Pj4+IGhhc2ggdHlwZSBhbmQgcXVldWUgaW5kZXgKPj4+PiBhY2NvcmRpbmcgdG8gdGhlIChtYXBw
ZWQpIHBhcmFtZXRlcnMgKGtleSwgaGFzaCB0eXBlcywgaW5kaXJlY3Rpb24KPj4+PiB0YWJsZSkg
cmVjZWl2ZWQgZnJvbSB0aGUgZ3Vlc3QuCj4+PiBUVU5TRVRTVEVFUklOR0VCUEYgd2FzIGFkZGVk
IHRvIHN1cHBvcnQgbW9yZSBkaXZlcnNlIHF1ZXVlIHNlbGVjdGlvbgo+Pj4gdGhhbiB0aGUgZGVm
YXVsdCBpbiBjYXNlIG9mIG11bHRpcXVldWUgdHVuLiBOb3Qgc3VyZSB3aGF0IHRoZSBleGFjdAo+
Pj4gdXNlIGNhc2VzIGFyZS4KPj4+Cj4+PiBCdXQgUlNTIGlzIGV4YWN0bHkgdGhlIHB1cnBvc2Ug
b2YgdGhlIGZsb3cgZGlzc2VjdG9yLiBJdCBpcyB1c2VkIGZvcgo+Pj4gdGhhdCBwdXJwb3NlIGlu
IHRoZSBzb2Z0d2FyZSB2YXJpYW50IFJQUy4gVGhlIGZsb3cgZGlzc2VjdG9yCj4+PiBpbXBsZW1l
bnRzIGEgc3VwZXJzZXQgb2YgdGhlIFJTUyBzcGVjLCBhbmQgY2VydGFpbmx5IGNvbXB1dGVzIGEK
Pj4+IGZvdXItdHVwbGUgZm9yIFRDUC9JUHY2LiBJbiB0aGUgY2FzZSBvZiBSUFMsIGl0IGlzIHNr
aXBwZWQgaWYgdGhlIE5JQwo+Pj4gaGFzIGFscmVhZHkgY29tcHV0ZWQgYSA0LXR1cGxlIGhhc2gu
Cj4+Pgo+Pj4gV2hhdCBpdCBkb2VzIG5vdCBnaXZlIGlzIGEgdHlwZSBpbmRpY2F0aW9uLCBzdWNo
IGFzCj4+PiBWSVJUSU9fTkVUX0hBU0hfVFlQRV9UQ1B2Ni4gSSBkb24ndCB1bmRlcnN0YW5kIGhv
dyB0aGlzIHdvdWxkIGJlIHVzZWQuCj4+PiBJbiBkYXRhcGF0aHMgd2hlcmUgdGhlIE5JQyBoYXMg
YWxyZWFkeSBjb21wdXRlZCB0aGUgZm91ci10dXBsZSBoYXNoCj4+PiBhbmQgc3RvcmVkIGl0IGlu
IHNrYi0+aGFzaCAtLXRoZSBjb21tb24gY2FzZSBmb3Igc2VydmVycy0tLCBUaGF0IHR5cGUKPj4+
IGZpZWxkIGlzIHRoZSBvbmx5IHJlYXNvbiB0byBoYXZlIHRvIGNvbXB1dGUgYWdhaW4uCj4+Cj4+
IFRoZSBwcm9ibGVtIGlzIHRoZXJlJ3Mgbm8gZ3VhcmFudGVlIHRoYXQgdGhlIHBhY2tldCBjb21l
cyBmcm9tIHRoZSBOSUMsCj4+IGl0IGNvdWxkIGJlIGEgc2ltcGxlIFZNMlZNIG9yIGhvc3QyVk0g
cGFja2V0Lgo+Pgo+PiBBbmQgZXZlbiBpZiB0aGUgcGFja2V0IGlzIGNvbWluZyBmcm9tIHRoZSBO
SUMgdGhhdCBjYWxjdWxhdGVzIHRoZSBoYXNoCj4+IHRoZXJlJ3Mgbm8gZ3VhcmFudGVlIHRoYXQg
aXQncyB0aGUgaGFzIHRoYXQgZ3Vlc3Qgd2FudCAoZ3Vlc3QgbWF5IHVzZQo+PiBkaWZmZXJlbnQg
UlNTIGtleXMpLgo+IEFoIHllcywgb2YgY291cnNlLgo+Cj4gSSB3b3VsZCBzdGlsbCByZXZpc2l0
IHRoZSBuZWVkIHRvIHN0b3JlIGEgZGV0YWlsZWQgaGFzaF90eXBlIGFsb25nIHdpdGgKPiB0aGUg
aGFzaCwgYXMgYXMgZmFyIEkgY2FuIHRlbGwgdGhhdCBjb252ZXlzIG5vIGFjdGlvbmFibGUgaW5m
b3JtYXRpb24KPiB0byB0aGUgZ3Vlc3QuCgoKWWVzLCBuZWVkIHRvIGZpZ3VyZSBvdXQgaXRzIHVz
YWdlLiBBY2NvcmRpbmcgdG8gWzFdLCBpdCBvbmx5IG1lbnRpb24gCnRoYXQgc3RvcmluZyBoYXMg
dHlwZSBpcyBhIGNoYXJnZSBvZiBkcml2ZXIuIE1heWJlIFl1cmkgY2FuIGFuc3dlciB0aGlzLgoK
VGhhbmtzCgpbMV0gCmh0dHBzOi8vZG9jcy5taWNyb3NvZnQuY29tL2VuLXVzL3dpbmRvd3MtaGFy
ZHdhcmUvZHJpdmVycy9uZXR3b3JrL2luZGljYXRpbmctcnNzLXJlY2VpdmUtZGF0YQoKCj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
