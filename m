Return-Path: <SRS0=rM6z=F4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4DCC433E0
	for <virtualization@archiver.kernel.org>; Thu, 24 Dec 2020 02:37:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96859207D8
	for <virtualization@archiver.kernel.org>; Thu, 24 Dec 2020 02:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96859207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3FE8C2E111;
	Thu, 24 Dec 2020 02:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1QQpZLIBaX3O; Thu, 24 Dec 2020 02:37:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8EE8A203B0;
	Thu, 24 Dec 2020 02:37:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A205C1787;
	Thu, 24 Dec 2020 02:37:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32BE2C0893
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D6B8E203B1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:37:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cn7WRJH+DW1M
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:37:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 7B75A203B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 02:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608777442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQ2p4ksHPTOq63DDyngHA9gf7FABh2CGteZ5vJN2Hj4=;
 b=ValuGKTXdGOIFmB3d0NdY9KO12PeZSwNyJ72adixZEClKJ8GXAFNP1QdyvqOAIcwIHwV7R
 UX5yHGP9fyK2rK6jZyEXZ8dHS0S23uUpKqawkjdbS2Pk5t5GhoIoXk7in88I79Oeepg75L
 /Z1njyNpNDJT6ogRrC/4g+9ZfKDJqyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-YqM85cXrO2aEDLgPJNwXEQ-1; Wed, 23 Dec 2020 21:37:18 -0500
X-MC-Unique: YqM85cXrO2aEDLgPJNwXEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1A4E802B40;
 Thu, 24 Dec 2020 02:37:15 +0000 (UTC)
Received: from [10.72.13.109] (ovpn-13-109.pek2.redhat.com [10.72.13.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8146D5D9C6;
 Thu, 24 Dec 2020 02:37:00 +0000 (UTC)
Subject: Re: [RFC v2 08/13] vdpa: Introduce process_iotlb_msg() in
 vdpa_config_ops
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
 <20201222145221.711-9-xieyongji@bytedance.com>
 <5b36bc51-1e19-2b59-6287-66aed435c8ed@redhat.com>
 <CACycT3tP8mgj043idjJW3BF12qmOhmHzYz8X5FyL8t5MbwLysw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4b13e574-d898-55cc-9ec6-78f28a7f2cd9@redhat.com>
Date: Thu, 24 Dec 2020 10:36:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3tP8mgj043idjJW3BF12qmOhmHzYz8X5FyL8t5MbwLysw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-aio@kvack.org,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org
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

Ck9uIDIwMjAvMTIvMjMg5LiL5Y2INzowNiwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBXZWQsIERl
YyAyMywgMjAyMCBhdCA0OjM3IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+PiBPbiAyMDIwLzEyLzIyIOS4i+WNiDEwOjUyLCBYaWUgWW9uZ2ppIHdyb3RlOgo+
Pj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgbmV3IG1ldGhvZCBpbiB0aGUgdmRwYV9jb25maWdf
b3BzIHRvCj4+PiBzdXBwb3J0IHByb2Nlc3NpbmcgdGhlIHJhdyB2aG9zdCBtZW1vcnkgbWFwcGlu
ZyBtZXNzYWdlIGluIHRoZQo+Pj4gdkRQQSBkZXZpY2UgZHJpdmVyLgo+Pj4KPj4+IFNpZ25lZC1v
ZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+Pj4gLS0tCj4+PiAg
ICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDUgKysrKy0KPj4+ICAgIGluY2x1ZGUvbGludXgvdmRw
YS5oIHwgNyArKysrKysrCj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMg
Yi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4gaW5kZXggNDQ4YmU3ODc1YjZkLi5jY2JiMzkxZTM4
YmUgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4gKysrIGIvZHJpdmVy
cy92aG9zdC92ZHBhLmMKPj4+IEBAIC03MjgsNiArNzI4LDkgQEAgc3RhdGljIGludCB2aG9zdF92
ZHBhX3Byb2Nlc3NfaW90bGJfbXNnKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPj4+ICAgICAgICBp
ZiAocikKPj4+ICAgICAgICAgICAgICAgIHJldHVybiByOwo+Pj4KPj4+ICsgICAgIGlmIChvcHMt
PnByb2Nlc3NfaW90bGJfbXNnKQo+Pj4gKyAgICAgICAgICAgICByZXR1cm4gb3BzLT5wcm9jZXNz
X2lvdGxiX21zZyh2ZHBhLCBtc2cpOwo+Pj4gKwo+Pj4gICAgICAgIHN3aXRjaCAobXNnLT50eXBl
KSB7Cj4+PiAgICAgICAgY2FzZSBWSE9TVF9JT1RMQl9VUERBVEU6Cj4+PiAgICAgICAgICAgICAg
ICByID0gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZSh2LCBtc2cpOwo+Pj4gQEAgLTc3
MCw3ICs3NzMsNyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfYWxsb2NfZG9tYWluKHN0cnVjdCB2
aG9zdF92ZHBhICp2KQo+Pj4gICAgICAgIGludCByZXQ7Cj4+Pgo+Pj4gICAgICAgIC8qIERldmlj
ZSB3YW50IHRvIGRvIERNQSBieSBpdHNlbGYgKi8KPj4+IC0gICAgIGlmIChvcHMtPnNldF9tYXAg
fHwgb3BzLT5kbWFfbWFwKQo+Pj4gKyAgICAgaWYgKG9wcy0+c2V0X21hcCB8fCBvcHMtPmRtYV9t
YXAgfHwgb3BzLT5wcm9jZXNzX2lvdGxiX21zZykKPj4+ICAgICAgICAgICAgICAgIHJldHVybiAw
Owo+Pj4KPj4+ICAgICAgICBidXMgPSBkbWFfZGV2LT5idXM7Cj4+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4gaW5kZXggNjU2ZmUy
NjQyMzRlLi43YmNjZWRmMjJmNGIgMTAwNjQ0Cj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEu
aAo+Pj4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+IEBAIC01LDYgKzUsNyBAQAo+Pj4g
ICAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgo+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2Rldmlj
ZS5oPgo+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgo+Pj4gKyNpbmNsdWRlIDxs
aW51eC92aG9zdF90eXBlcy5oPgo+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L3Zob3N0X2lvdGxiLmg+
Cj4+PiAgICAjaW5jbHVkZSA8bmV0L2dlbmV0bGluay5oPgo+Pj4KPj4+IEBAIC0xNzIsNiArMTcz
LDEwIEBAIHN0cnVjdCB2ZHBhX2lvdmFfcmFuZ2Ugewo+Pj4gICAgICogICAgICAgICAgICAgICAg
ICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+Pj4gICAgICogICAgICAgICAgICAgICAgICAg
ICAgICAgIFJldHVybnMgdGhlIGlvdmEgcmFuZ2Ugc3VwcG9ydGVkIGJ5Cj4+PiAgICAgKiAgICAg
ICAgICAgICAgICAgICAgICAgICAgdGhlIGRldmljZS4KPj4+ICsgKiBAcHJvY2Vzc19pb3RsYl9t
c2c6ICAgICAgICAgICAgICAgUHJvY2VzcyB2aG9zdCBtZW1vcnkgbWFwcGluZyBtZXNzYWdlIChv
cHRpb25hbCkKPj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgIE9ubHkgdXNlZCBmb3Ig
VkRVU0UgZGV2aWNlIG5vdwo+Pj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgQHZkZXY6
IHZkcGEgZGV2aWNlCj4+PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICBAbXNnOiB2aG9z
dCBtZW1vcnkgbWFwcGluZyBtZXNzYWdlCj4+PiAgICAgKiBAc2V0X21hcDogICAgICAgICAgICAg
ICAgICAgICAgICBTZXQgZGV2aWNlIG1lbW9yeSBtYXBwaW5nIChvcHRpb25hbCkKPj4+ICAgICAq
ICAgICAgICAgICAgICAgICAgICAgICAgICBOZWVkZWQgZm9yIGRldmljZSB0aGF0IHVzaW5nIGRl
dmljZQo+Pj4gICAgICogICAgICAgICAgICAgICAgICAgICAgICAgIHNwZWNpZmljIERNQSB0cmFu
c2xhdGlvbiAob24tY2hpcCBJT01NVSkKPj4+IEBAIC0yNDAsNiArMjQ1LDggQEAgc3RydWN0IHZk
cGFfY29uZmlnX29wcyB7Cj4+PiAgICAgICAgc3RydWN0IHZkcGFfaW92YV9yYW5nZSAoKmdldF9p
b3ZhX3JhbmdlKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+Pj4KPj4+ICAgICAgICAvKiBE
TUEgb3BzICovCj4+PiArICAgICBpbnQgKCpwcm9jZXNzX2lvdGxiX21zZykoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2LAo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2
aG9zdF9pb3RsYl9tc2cgKm1zZyk7Cj4+PiAgICAgICAgaW50ICgqc2V0X21hcCkoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2LCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiKTsKPj4+ICAgICAgICBp
bnQgKCpkbWFfbWFwKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBpb3ZhLCB1NjQgc2l6
ZSwKPj4+ICAgICAgICAgICAgICAgICAgICAgICB1NjQgcGEsIHUzMiBwZXJtKTsKPj4KPj4gSXMg
dGhlcmUgYW55IHJlYXNvbiB0aGF0IGl0IGNhbid0IGJlIGRvbmUgdmlhIGRtYV9tYXAvZG1hX3Vu
bWFwIG9yIHNldF9tYXA/Cj4+Cj4gVG8gZ2V0IHRoZSBzaG1mZCwgd2UgbmVlZCB0aGUgdm1hIHJh
dGhlciB0aGFuIHBoeXNpY2FsIGFkZHJlc3MuIEFuZAo+IGl0J3Mgbm90IG5lY2Vzc2FyeSB0byBw
aW4gdGhlIHVzZXIgcGFnZXMgaW4gVkRVU0UgY2FzZS4KCgpSaWdodCwgYWN0dWFsbHksIHZob3N0
LXZEUEEgaXMgcGxhbm5pbmcgdG8gc3VwcG9ydCBzaGFyZWQgdmlydHVhbCAKYWRkcmVzcyBzcGFj
ZS4KClNvIGxldCdzIHRyeSB0byByZXVzZSB0aGUgZXhpc3RpbmcgY29uZmlnIG9wcy4gSG93IGFi
b3V0IGp1c3QgaW50cm9kdWNlIAphbiBhdHRyaWJ1dGUgdG8gdmRwYSBkZXZpY2UgdGhhdCB0ZWxs
cyB0aGUgYnVzIHRlbGxzIHRoZSBidXMgaXQgY2FuIGRvIApzaGFyZWQgdmlydHVhbCBtZW1vcnku
IFRoZW4gd2hlbiB0aGUgZGV2aWNlIGlzIHByb2JlZCBieSB2aG9zdC12RFBBLCB1c2UgCnBhZ2Vz
IHdvbid0IGJlIHBpbm5lZCBhbmQgd2Ugd2lsbCBkbyBWQS0+VkEgbWFwcGluZyBhcyBJT1ZBLT5Q
QSBtYXBwaW5nIAppbiB0aGUgdmhvc3QgSU9UTEIgYW5kIHRoZSBjb25maWcgb3BzLiB2aG9zdCBJ
T1RMQiBuZWVkcyB0byBiZSBleHRlbmRlZCAKdG8gYWNjZXB0IG9wYXF1ZSBwb2ludGVyIHRvIHN0
b3JlIHRoZSBmaWxlLiBBbmQgdGhlIGZpbGUgd2FzIHBhc3MgdmlhIAp0aGUgY29uZmlnIG9wcyBh
cyB3ZWxsLgoKVGhhbmtzCgoKCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
