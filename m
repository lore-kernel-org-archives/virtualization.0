Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A28C433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 03:06:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6952564F5D
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 03:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6952564F5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 95070272F7;
	Thu,  4 Feb 2021 03:06:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dA6t0ruVNj3o; Thu,  4 Feb 2021 03:06:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3FB4A272DF;
	Thu,  4 Feb 2021 03:06:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2071EC0174;
	Thu,  4 Feb 2021 03:06:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C6D8C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9205D86B8B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:06:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tdl2QFMRpFsM
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:06:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8B1BE86AFF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612407970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VP2C7mfebrEmwVn94wtq4kLWLgP8Sp1nVsZO1XYRiLY=;
 b=MIY1nvR5GOu42MRiBPMMz9kfMBrLtJJ3aHJBS9WqvlYctu/bktL/gb0TLAztrm1Kr0DSu+
 AX99d4UaHfo4ATzgu1JQP7ftGj4VQQgxn2AqThvbiGtak70AekfARTohJFq/V81X7up4L/
 s9nZiwEzP2FEcr91OEG16fAUhLdOWV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-te9GeJ2CMHCLm2hLyOpPNw-1; Wed, 03 Feb 2021 22:06:07 -0500
X-MC-Unique: te9GeJ2CMHCLm2hLyOpPNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EB34107ACE6;
 Thu,  4 Feb 2021 03:06:06 +0000 (UTC)
Received: from [10.72.14.1] (ovpn-14-1.pek2.redhat.com [10.72.14.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0E946091B;
 Thu,  4 Feb 2021 03:06:03 +0000 (UTC)
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20210129002136.70865-1-weiwan@google.com>
 <a0b2cb8d-eb8f-30fb-2a22-678e6dd2f58f@redhat.com>
 <CAF=yD-+aPBF2RaCR8L5orTM37bf7Z4Z8Qko2D2LZjOz0khHTUg@mail.gmail.com>
 <3a3e005d-f9b2-c16a-5ada-6e04242c618e@redhat.com>
 <CAF=yD-+NVKiwS6P2=cS=gk2nLcsWP1anMyy4ghdPiNrhOmLRDw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9b0b8f2a-8476-697e-9002-e9947e3eab63@redhat.com>
Date: Thu, 4 Feb 2021 11:06:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-+NVKiwS6P2=cS=gk2nLcsWP1anMyy4ghdPiNrhOmLRDw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Willem de Bruijn <willemb@google.com>,
 Network Development <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

Ck9uIDIwMjEvMi80IOS4iuWNiDI6MjgsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gT24gV2Vk
LCBGZWIgMywgMjAyMSBhdCAxMjozMyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4KPj4gT24gMjAyMS8yLzIg5LiL5Y2IMTA6MzcsIFdpbGxlbSBkZSBCcnVpam4g
d3JvdGU6Cj4+PiBPbiBNb24sIEZlYiAxLCAyMDIxIGF0IDEwOjA5IFBNIEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+IE9uIDIwMjEvMS8yOSDkuIrljYg4OjIxLCBX
ZWkgV2FuZyB3cm90ZToKPj4+Pj4gV2l0aCB0aGUgaW1wbGVtZW50YXRpb24gb2YgbmFwaS10eCBp
biB2aXJ0aW8gZHJpdmVyLCB3ZSBjbGVhbiB0eAo+Pj4+PiBkZXNjcmlwdG9ycyBmcm9tIHJ4IG5h
cGkgaGFuZGxlciwgZm9yIHRoZSBwdXJwb3NlIG9mIHJlZHVjaW5nIHR4Cj4+Pj4+IGNvbXBsZXRl
IGludGVycnVwdHMuIEJ1dCB0aGlzIGNvdWxkIGludHJvZHVjZSBhIHJhY2Ugd2hlcmUgdHggY29t
cGxldGUKPj4+Pj4gaW50ZXJydXB0IGhhcyBiZWVuIHJhaXNlZCwgYnV0IHRoZSBoYW5kbGVyIGZv
dW5kIHRoZXJlIGlzIG5vIHdvcmsgdG8gZG8KPj4+Pj4gYmVjYXVzZSB3ZSBoYXZlIGRvbmUgdGhl
IHdvcmsgaW4gdGhlIHByZXZpb3VzIHJ4IGludGVycnVwdCBoYW5kbGVyLgo+Pj4+PiBUaGlzIGNv
dWxkIGxlYWQgdG8gdGhlIGZvbGxvd2luZyB3YXJuaW5nIG1zZzoKPj4+Pj4gWyAzNTg4LjAxMDc3
OF0gaXJxIDM4OiBub2JvZHkgY2FyZWQgKHRyeSBib290aW5nIHdpdGggdGhlCj4+Pj4+ICJpcnFw
b2xsIiBvcHRpb24pCj4+Pj4+IFsgMzU4OC4wMTc5MzhdIENQVTogNCBQSUQ6IDAgQ29tbTogc3dh
cHBlci80IE5vdCB0YWludGVkCj4+Pj4+IDUuMy4wLTE5LWdlbmVyaWMgIzIwfjE4LjA0LjItVWJ1
bnR1Cj4+Pj4+IFsgMzU4OC4wMTc5NDBdIENhbGwgVHJhY2U6Cj4+Pj4+IFsgMzU4OC4wMTc5NDJd
ICA8SVJRPgo+Pj4+PiBbIDM1ODguMDE3OTUxXSAgZHVtcF9zdGFjaysweDYzLzB4ODUKPj4+Pj4g
WyAzNTg4LjAxNzk1M10gIF9fcmVwb3J0X2JhZF9pcnErMHgzNS8weGMwCj4+Pj4+IFsgMzU4OC4w
MTc5NTVdICBub3RlX2ludGVycnVwdCsweDI0Yi8weDJhMAo+Pj4+PiBbIDM1ODguMDE3OTU2XSAg
aGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHg1NC8weDgwCj4+Pj4+IFsgMzU4OC4wMTc5NTddICBo
YW5kbGVfaXJxX2V2ZW50KzB4M2IvMHg2MAo+Pj4+PiBbIDM1ODguMDE3OTU4XSAgaGFuZGxlX2Vk
Z2VfaXJxKzB4ODMvMHgxYTAKPj4+Pj4gWyAzNTg4LjAxNzk2MV0gIGhhbmRsZV9pcnErMHgyMC8w
eDMwCj4+Pj4+IFsgMzU4OC4wMTc5NjRdICBkb19JUlErMHg1MC8weGUwCj4+Pj4+IFsgMzU4OC4w
MTc5NjZdICBjb21tb25faW50ZXJydXB0KzB4Zi8weGYKPj4+Pj4gWyAzNTg4LjAxNzk2Nl0gIDwv
SVJRPgo+Pj4+PiBbIDM1ODguMDE3OTg5XSBoYW5kbGVyczoKPj4+Pj4gWyAzNTg4LjAyMDM3NF0g
WzwwMDAwMDAwMDFiOWYxZGE4Pl0gdnJpbmdfaW50ZXJydXB0Cj4+Pj4+IFsgMzU4OC4wMjUwOTld
IERpc2FibGluZyBJUlEgIzM4Cj4+Pj4+Cj4+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhIG5ldyBwYXJh
bSB0byBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlLCBhbmQgd2Ugc2V0IGl0IGZvcgo+Pj4+PiB0eCB2
aXJ0cXVldWVzIGlmIG5hcGktdHggaXMgZW5hYmxlZCwgdG8gc3VwcHJlc3MgdGhlIHdhcm5pbmcg
aW4gc3VjaAo+Pj4+PiBjYXNlLgo+Pj4+Pgo+Pj4+PiBGaXhlczogN2IwNDExZWY0YWE2ICgidmly
dGlvLW5ldDogY2xlYW4gdHggZGVzY3JpcHRvcnMgZnJvbSByeCBuYXBpIikKPj4+Pj4gUmVwb3J0
ZWQtYnk6IFJpY2sgSm9uZXMgPGpvbmVzcmlja0Bnb29nbGUuY29tPgo+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBXZWkgV2FuZyA8d2Vpd2FuQGdvb2dsZS5jb20+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFdp
bGxlbSBkZSBCcnVpam4gPHdpbGxlbWJAZ29vZ2xlLmNvbT4KPj4+PiBQbGVhc2UgdXNlIGdldF9t
YWludGFpbmVyLnBsIHRvIG1ha2Ugc3VyZSBNaWNoYWVsIGFuZCBtZSB3ZXJlIGNjZWQuCj4+PiBX
aWxsIGRvLiBTb3JyeSBhYm91dCB0aGF0LiBJIHN1Z2dlc3RlZCBqdXN0IHRoZSB2aXJ0dWFsaXph
dGlvbiBsaXN0LCBteSBiYWQuCj4+Pgo+Pj4+PiAtLS0KPj4+Pj4gICAgIGRyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyAgICAgfCAxOSArKysrKysrKysrKysrKy0tLS0tCj4+Pj4+ICAgICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTYgKysrKysrKysrKysrKysrKwo+Pj4+PiAgICAgaW5j
bHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAyICsrCj4+Pj4+ICAgICAzIGZpbGVzIGNoYW5n
ZWQsIDMyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
Pj4+Pj4gaW5kZXggNTA4NDA4ZmJlNzhmLi5lOWEzZjMwODY0ZTggMTAwNjQ0Cj4+Pj4+IC0tLSBh
L2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPj4+Pj4gQEAgLTEzMDMsMTMgKzEzMDMsMjIgQEAgc3RhdGljIHZvaWQgdmlydG5ldF9u
YXBpX3R4X2VuYWJsZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPj4+Pj4gICAgICAgICAgICAg
ICAgIHJldHVybjsKPj4+Pj4gICAgICAgICB9Cj4+Pj4+Cj4+Pj4+ICsgICAgIC8qIFdpdGggbmFw
aV90eCBlbmFibGVkLCBmcmVlX29sZF94bWl0X3NrYnMoKSBjb3VsZCBiZSBjYWxsZWQgZnJvbQo+
Pj4+PiArICAgICAgKiByeCBuYXBpIGhhbmRsZXIuIFNldCB3b3JrX3N0ZWFsIHRvIHN1cHByZXNz
IGJhZCBpcnEgd2FybmluZyBmb3IKPj4+Pj4gKyAgICAgICogSVJRX05PTkUgY2FzZSBmcm9tIHR4
IGNvbXBsZXRlIGludGVycnVwdCBoYW5kbGVyLgo+Pj4+PiArICAgICAgKi8KPj4+Pj4gKyAgICAg
dmlydHF1ZXVlX3NldF93b3JrX3N0ZWFsKHZxLCB0cnVlKTsKPj4+Pj4gKwo+Pj4+PiAgICAgICAg
IHJldHVybiB2aXJ0bmV0X25hcGlfZW5hYmxlKHZxLCBuYXBpKTsKPj4+PiBEbyB3ZSBuZWVkIHRv
IGZvcmNlIHRoZSBvcmRlcmluZyBiZXR3ZWVuIHN0ZWFsIHNldCBhbmQgbmFwaSBlbmFibGU/Cj4+
PiBUaGUgd2FybmluZyBvbmx5IG9jY3VycyBhZnRlciBvbmUgaHVuZHJlZCBzcHVyaW91cyBpbnRl
cnJ1cHRzLCBzbyBub3QKPj4+IHJlYWxseS4KPj4KPj4gT2ssIHNvIGl0IGxvb2tzIGxpa2UgYSBo
aW50LiBUaGVuIEkgd29uZGVyIGhvdyBtdWNoIHZhbHVlIGRvIHdlIG5lZWQgdG8KPj4gaW50cm9k
dWNlIGhlbHBlciBsaWtlIHZpcnRxdWV1ZV9zZXRfd29ya19zdGVhbCgpIHRoYXQgYWxsb3dzIHRo
ZSBjYWxsZXIKPj4gdG8gdG9nZ2xlLiBIb3cgYWJvdXQgZGlzYWJsZSB0aGUgY2hlY2sgZm9yZXZl
ciBkdXJpbmcgdmlydHF1ZXVlCj4+IGluaXRpYWxpemF0aW9uPwo+IFllcywgdGhhdCBpcyBldmVu
IHNpbXBsZXIuCj4KPiBXZSBzdGlsbCBuZWVkIHRoZSBoZWxwZXIsIGFzIHRoZSBpbnRlcm5hbCB2
YXJpYWJsZXMgb2YgdnJpbmdfdmlydHF1ZXVlCj4gYXJlIG5vdCBhY2Nlc3NpYmxlIGZyb20gdmly
dGlvLW5ldC4gQW4gZWFybGllciBwYXRjaCBhZGRlZCB0aGUKPiB2YXJpYWJsZSB0byB2aXJ0cXVl
dWUgaXRzZWxmLCBidXQgSSB0aGluayBpdCBiZWxvbmdzIGluCj4gdnJpbmdfdmlydHF1ZXVlLiBB
bmQgdGhlIGhlbHBlciBpcyBub3QgYSBsb3Qgb2YgY29kZS4KCgpJdCdzIGJldHRlciB0byBkbyB0
aGlzIGJlZm9yZSB0aGUgYWxsb2NhdGluZyB0aGUgaXJxLiBCdXQgaXQgbG9va3Mgbm90IAplYXN5
IHVubGVzcyB3ZSBleHRlbmQgZmluZF92cXMoKS4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
