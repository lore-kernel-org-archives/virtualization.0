Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C8C433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 03:18:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB04C64F8C
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 03:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB04C64F8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7FCB3872BE;
	Fri,  5 Feb 2021 03:18:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x1bBD3PBpDDd; Fri,  5 Feb 2021 03:18:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 08C0C872BA;
	Fri,  5 Feb 2021 03:18:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3A87C07FD;
	Fri,  5 Feb 2021 03:18:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6422C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A424E86990
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:18:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0UwBttnftbF3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:18:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B598F8697B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612495131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+OMUQChPI2nH7Skoc2akxJEI5HA3PfrfqiF984pQ/0=;
 b=KvYh1MrfCcAbpd+y9/QBpxJrYTlRv+xSkq1EOoyw04Xw0I/8DL1FUrXnwnvph4FLxdS148
 e4icKCzwnkDKMNxVUSQtwz8rtwdIIwYoHpBzSUXMOr/Tqv037HnBb4yNchkE0Es6C+aDt8
 AiXundIbZeovSvWmhr3wqM92lDFXWVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-Er2d2Fp0Pbuskmk1acdrAQ-1; Thu, 04 Feb 2021 22:18:47 -0500
X-MC-Unique: Er2d2Fp0Pbuskmk1acdrAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3E421020C20;
 Fri,  5 Feb 2021 03:18:46 +0000 (UTC)
Received: from [10.72.12.112] (ovpn-12-112.pek2.redhat.com [10.72.12.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4448D60BE2;
 Fri,  5 Feb 2021 03:18:37 +0000 (UTC)
Subject: Re: [PATCH v3 04/13] vringh: explain more about cleaning riov and wiov
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210204172230.85853-1-sgarzare@redhat.com>
 <20210204172230.85853-5-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4a4bf8ad-5853-c054-4d04-450f1966c9a2@redhat.com>
Date: Fri, 5 Feb 2021 11:18:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204172230.85853-5-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

Ck9uIDIwMjEvMi81IOS4iuWNiDE6MjIsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiByaW92
IGFuZCB3aW92IGNhbiBiZSByZXVzZWQgd2l0aCBzdWJzZXF1ZW50IGNhbGxzIG9mIHZyaW5naF9n
ZXRkZXNjXyooKS4KPgo+IExldCdzIGFkZCBhIHBhcmFncmFwaCBpbiB0aGUgZG9jdW1lbnRhdGlv
biBvZiB0aGVzZSBmdW5jdGlvbnMgdG8gYmV0dGVyCj4gZXhwbGFpbiB3aGVuIHJpb3YgYW5kIHdp
b3YgbmVlZCB0byBiZSBjbGVhbmVkIHVwLgo+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6
YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC92cmlu
Z2guYyB8IDE1ICsrKysrKysrKysrKy0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+CgoKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jIGIvZHJp
dmVycy92aG9zdC92cmluZ2guYwo+IGluZGV4IGJlZTYzZDY4MjAxYS4uMmE4OGUwODdhZmQ4IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0
L3ZyaW5naC5jCj4gQEAgLTY2Miw3ICs2NjIsMTAgQEAgRVhQT1JUX1NZTUJPTCh2cmluZ2hfaW5p
dF91c2VyKTsKPiAgICAqICpoZWFkIHdpbGwgYmUgdnJoLT52cmluZy5udW0uICBZb3UgbWF5IGJl
IGFibGUgdG8gaWdub3JlIGFuIGludmFsaWQKPiAgICAqIGRlc2NyaXB0b3IsIGJ1dCB0aGVyZSdz
IG5vdCBtdWNoIHlvdSBjYW4gZG8gd2l0aCBhbiBpbnZhbGlkIHJpbmcuCj4gICAgKgo+IC0gKiBO
b3RlIHRoYXQgeW91IG1heSBuZWVkIHRvIGNsZWFuIHVwIHJpb3YgYW5kIHdpb3YsIGV2ZW4gb24g
ZXJyb3IhCj4gKyAqIE5vdGUgdGhhdCB5b3UgY2FuIHJldXNlIHJpb3YgYW5kIHdpb3Ygd2l0aCBz
dWJzZXF1ZW50IGNhbGxzLiBDb250ZW50IGlzCj4gKyAqIG92ZXJ3cml0dGVuIGFuZCBtZW1vcnkg
cmVhbGxvY2F0ZWQgaWYgbW9yZSBzcGFjZSBpcyBuZWVkZWQuCj4gKyAqIFdoZW4geW91IGRvbid0
IGhhdmUgdG8gdXNlIHJpb3YgYW5kIHdpb3YgYW55bW9yZSwgeW91IHNob3VsZCBjbGVhbiB1cCB0
aGVtCj4gKyAqIGNhbGxpbmcgdnJpbmdoX2lvdl9jbGVhbnVwKCkgdG8gcmVsZWFzZSB0aGUgbWVt
b3J5LCBldmVuIG9uIGVycm9yIQo+ICAgICovCj4gICBpbnQgdnJpbmdoX2dldGRlc2NfdXNlcihz
dHJ1Y3QgdnJpbmdoICp2cmgsCj4gICAJCQlzdHJ1Y3QgdnJpbmdoX2lvdiAqcmlvdiwKPiBAQCAt
OTMyLDcgKzkzNSwxMCBAQCBFWFBPUlRfU1lNQk9MKHZyaW5naF9pbml0X2tlcm4pOwo+ICAgICog
KmhlYWQgd2lsbCBiZSB2cmgtPnZyaW5nLm51bS4gIFlvdSBtYXkgYmUgYWJsZSB0byBpZ25vcmUg
YW4gaW52YWxpZAo+ICAgICogZGVzY3JpcHRvciwgYnV0IHRoZXJlJ3Mgbm90IG11Y2ggeW91IGNh
biBkbyB3aXRoIGFuIGludmFsaWQgcmluZy4KPiAgICAqCj4gLSAqIE5vdGUgdGhhdCB5b3UgbWF5
IG5lZWQgdG8gY2xlYW4gdXAgcmlvdiBhbmQgd2lvdiwgZXZlbiBvbiBlcnJvciEKPiArICogTm90
ZSB0aGF0IHlvdSBjYW4gcmV1c2UgcmlvdiBhbmQgd2lvdiB3aXRoIHN1YnNlcXVlbnQgY2FsbHMu
IENvbnRlbnQgaXMKPiArICogb3ZlcndyaXR0ZW4gYW5kIG1lbW9yeSByZWFsbG9jYXRlZCBpZiBt
b3JlIHNwYWNlIGlzIG5lZWRlZC4KPiArICogV2hlbiB5b3UgZG9uJ3QgaGF2ZSB0byB1c2Ugcmlv
diBhbmQgd2lvdiBhbnltb3JlLCB5b3Ugc2hvdWxkIGNsZWFuIHVwIHRoZW0KPiArICogY2FsbGlu
ZyB2cmluZ2hfa2lvdl9jbGVhbnVwKCkgdG8gcmVsZWFzZSB0aGUgbWVtb3J5LCBldmVuIG9uIGVy
cm9yIQo+ICAgICovCj4gICBpbnQgdnJpbmdoX2dldGRlc2Nfa2VybihzdHJ1Y3QgdnJpbmdoICp2
cmgsCj4gICAJCQlzdHJ1Y3QgdnJpbmdoX2tpb3YgKnJpb3YsCj4gQEAgLTEyOTIsNyArMTI5OCwx
MCBAQCBFWFBPUlRfU1lNQk9MKHZyaW5naF9zZXRfaW90bGIpOwo+ICAgICogKmhlYWQgd2lsbCBi
ZSB2cmgtPnZyaW5nLm51bS4gIFlvdSBtYXkgYmUgYWJsZSB0byBpZ25vcmUgYW4gaW52YWxpZAo+
ICAgICogZGVzY3JpcHRvciwgYnV0IHRoZXJlJ3Mgbm90IG11Y2ggeW91IGNhbiBkbyB3aXRoIGFu
IGludmFsaWQgcmluZy4KPiAgICAqCj4gLSAqIE5vdGUgdGhhdCB5b3UgbWF5IG5lZWQgdG8gY2xl
YW4gdXAgcmlvdiBhbmQgd2lvdiwgZXZlbiBvbiBlcnJvciEKPiArICogTm90ZSB0aGF0IHlvdSBj
YW4gcmV1c2UgcmlvdiBhbmQgd2lvdiB3aXRoIHN1YnNlcXVlbnQgY2FsbHMuIENvbnRlbnQgaXMK
PiArICogb3ZlcndyaXR0ZW4gYW5kIG1lbW9yeSByZWFsbG9jYXRlZCBpZiBtb3JlIHNwYWNlIGlz
IG5lZWRlZC4KPiArICogV2hlbiB5b3UgZG9uJ3QgaGF2ZSB0byB1c2UgcmlvdiBhbmQgd2lvdiBh
bnltb3JlLCB5b3Ugc2hvdWxkIGNsZWFuIHVwIHRoZW0KPiArICogY2FsbGluZyB2cmluZ2hfa2lv
dl9jbGVhbnVwKCkgdG8gcmVsZWFzZSB0aGUgbWVtb3J5LCBldmVuIG9uIGVycm9yIQo+ICAgICov
Cj4gICBpbnQgdnJpbmdoX2dldGRlc2NfaW90bGIoc3RydWN0IHZyaW5naCAqdnJoLAo+ICAgCQkJ
IHN0cnVjdCB2cmluZ2hfa2lvdiAqcmlvdiwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
