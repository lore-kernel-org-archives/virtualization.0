Return-Path: <SRS0=N1kl=G6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4123EC433E0
	for <virtualization@archiver.kernel.org>; Wed, 27 Jan 2021 03:33:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA19205CA
	for <virtualization@archiver.kernel.org>; Wed, 27 Jan 2021 03:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA19205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2217E8681C;
	Wed, 27 Jan 2021 03:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UCjq9Rq2nW09; Wed, 27 Jan 2021 03:33:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 06CF5864C1;
	Wed, 27 Jan 2021 03:33:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD219C1786;
	Wed, 27 Jan 2021 03:33:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5328DC08A1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 03:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 23ECB86F8F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 03:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9k2Y9zgp97-g
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 03:33:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8BB9A86F7E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 03:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611718404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mP/fMR1bI+k0zNRDvvWBuMv6uUuCjAv3+TKblysN3yY=;
 b=gd37cK7MRRRKVGgyUc5sy0suDEUXMu1dK2h/fcllqOo2/jbmqzuxAlzA4Vm9jzRoPTZUEs
 cvQpXHjzy9/Od4bWm1gPKp34jAKTXzjOH2mvG2M/PB6rn/LWXSAbP6rQfgcjiVNeAplRE1
 yaMlgtbTHl/W+tvaYK7EKiD+ot6B/qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-h0jZK0l6NYKMj4AJ1_KZWg-1; Tue, 26 Jan 2021 22:33:19 -0500
X-MC-Unique: h0jZK0l6NYKMj4AJ1_KZWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36E2E10054FF;
 Wed, 27 Jan 2021 03:33:17 +0000 (UTC)
Received: from [10.72.13.33] (ovpn-13-33.pek2.redhat.com [10.72.13.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F0C26F92A;
 Wed, 27 Jan 2021 03:33:04 +0000 (UTC)
Subject: Re: [RFC v3 03/11] vdpa: Remove the restriction that only supports
 virtio-net devices
To: Stefano Garzarella <sgarzare@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-4-xieyongji@bytedance.com>
 <310d7793-e4ff-fba3-f358-418cb64c7988@redhat.com>
 <20210120110832.oijcmywq7pf7psg3@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1979cffc-240e-a9f9-b0ab-84a1f82ac81e@redhat.com>
Date: Wed, 27 Jan 2021 11:33:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210120110832.oijcmywq7pf7psg3@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org, mst@redhat.com,
 linux-aio@kvack.org, netdev@vger.kernel.org, rdunlap@infradead.org,
 willy@infradead.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, bob.liu@oracle.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org
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

Ck9uIDIwMjEvMS8yMCDkuIvljYg3OjA4LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24g
V2VkLCBKYW4gMjAsIDIwMjEgYXQgMTE6NDY6MzhBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4KPj4gT24gMjAyMS8xLzE5IOS4i+WNiDEyOjU5LCBYaWUgWW9uZ2ppIHdyb3RlOgo+Pj4gV2l0
aCBWRFVTRSwgd2Ugc2hvdWxkIGJlIGFibGUgdG8gc3VwcG9ydCBhbGwga2luZHMgb2YgdmlydGlv
IGRldmljZXMuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5
dGVkYW5jZS5jb20+Cj4+PiAtLS0KPj4+IMKgZHJpdmVycy92aG9zdC92ZHBhLmMgfCAyOSArKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAyNiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9z
dC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4gaW5kZXggMjllZDQxNzNmMDRlLi40
NDhiZTc4NzViNmQgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4gKysr
IGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+IEBAIC0yMiw2ICsyMiw3IEBACj4+PiDCoCNpbmNs
dWRlIDxsaW51eC9ub3NwZWMuaD4KPj4+IMKgI2luY2x1ZGUgPGxpbnV4L3Zob3N0Lmg+Cj4+PiDC
oCNpbmNsdWRlIDxsaW51eC92aXJ0aW9fbmV0Lmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRp
b19ibGsuaD4KPj4+IMKgI2luY2x1ZGUgInZob3N0LmgiCj4+PiBAQCAtMTg1LDI2ICsxODYsNiBA
QCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9zdGF0dXMoc3RydWN0IAo+Pj4gdmhvc3RfdmRw
YSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+Pj4gwqDCoMKgwqAgcmV0dXJuIDA7Cj4+PiDCoH0K
Pj4+IC1zdGF0aWMgaW50IHZob3N0X3ZkcGFfY29uZmlnX3ZhbGlkYXRlKHN0cnVjdCB2aG9zdF92
ZHBhICp2LAo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcgKmMpCj4+PiAtewo+Pj4gLcKgwqDCoCBsb25nIHNpemUg
PSAwOwo+Pj4gLQo+Pj4gLcKgwqDCoCBzd2l0Y2ggKHYtPnZpcnRpb19pZCkgewo+Pj4gLcKgwqDC
oCBjYXNlIFZJUlRJT19JRF9ORVQ6Cj4+PiAtwqDCoMKgwqDCoMKgwqAgc2l6ZSA9IHNpemVvZihz
dHJ1Y3QgdmlydGlvX25ldF9jb25maWcpOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4g
LcKgwqDCoCB9Cj4+PiAtCj4+PiAtwqDCoMKgIGlmIChjLT5sZW4gPT0gMCkKPj4+IC3CoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4+IC0KPj4+IC3CoMKgwqAgaWYgKGMtPmxlbiA+IHNp
emUgLSBjLT5vZmYpCj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FMkJJRzsKPj4+IC0KPj4+
IC3CoMKgwqAgcmV0dXJuIDA7Cj4+PiAtfQo+Pgo+Pgo+PiBJIHRoaW5rIHdlIHNob3VsZCB1c2Ug
YSBzZXBhcmF0ZSBwYXRjaCBmb3IgdGhpcy4KPgo+IEZvciB0aGUgdmRwYS1ibGsgc2ltdWxhdG9y
IEkgaGFkIHRoZSBzYW1lIGlzc3VlcyBhbmQgSSdtIGFkZGluZyBhIAo+IC5nZXRfY29uZmlnX3Np
emUoKSBjYWxsYmFjayB0byB2ZHBhIGRldmljZXMuCj4KPiBEbyB5b3UgdGhpbmsgbWFrZSBzZW5z
ZSBvciBpcyBiZXR0ZXIgdG8gcmVtb3ZlIHRoaXMgY2hlY2sgaW4gCj4gdmhvc3QvdmRwYSwgZGVs
ZWdhdGluZyB0aGUgYm91bmRhcmllcyBjaGVja3MgdG8gZ2V0X2NvbmZpZy9zZXRfY29uZmlnIAo+
IGNhbGxiYWNrcy4KCgpBIHF1ZXN0aW9uIGhlcmUuIEhvdyBtdWNoIHZhbHVlIGNvdWxkIHdlIGdh
aW4gZnJvbSBnZXRfY29uZmlnX3NpemUoKSAKY29uc2lkZXIgd2UgY2FuIGxldCB2RFBBIHBhcmVu
dCB0byB2YWxpZGF0ZSB0aGUgbGVuZ3RoIGluIGl0cyBnZXRfY29uZmlnKCkuCgpUaGFua3MKCgo+
Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
