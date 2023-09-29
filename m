Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F296CE7B1F
	for <virtualization@archiver.kernel.org>; Fri, 29 Sep 2023 09:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E212D82741;
	Fri, 29 Sep 2023 09:08:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E212D82741
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gqJktrIc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TVwcoXvH2t0O; Fri, 29 Sep 2023 09:08:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 68E858237D;
	Fri, 29 Sep 2023 09:08:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68E858237D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44561C0039;
	Fri, 29 Sep 2023 09:08:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D1E6C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 09:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 069BE417B6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 09:08:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 069BE417B6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gqJktrIc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vMHDCwcygbn2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 09:08:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B877C4188D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 09:08:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B877C4188D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695978495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0YwDJJKdQQtZNICAcr7E2f6PUBVKHV+uHDC6bNQc4g=;
 b=gqJktrIcMX33srq4UB0YeOnql7DAjjK+8DT+/YXXhaw4kpjE0U0FLvdLpUYWKAvaR/SK3r
 rUoCTJexeHXe3ikkW4BxwxWr/JeSBgd5Gj6ij0A9oX1+b5XHV/wDDZdOF1kWMzULHRy31a
 01+E8IYSsRTVvKbrkdxLve9C2VsSVWM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-EXB0zdH6NZ6A7976Vy4WvQ-1; Fri, 29 Sep 2023 05:08:11 -0400
X-MC-Unique: EXB0zdH6NZ6A7976Vy4WvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E79829AA3B9;
 Fri, 29 Sep 2023 09:08:11 +0000 (UTC)
Received: from [10.39.208.41] (unknown [10.39.208.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A70BC15BB8;
 Fri, 29 Sep 2023 09:08:09 +0000 (UTC)
Message-ID: <6c4cd924-0d44-582e-13a4-791f38d10fe8@redhat.com>
Date: Fri, 29 Sep 2023 11:08:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>
References: <20230912030008.3599514-1-lulu@redhat.com>
 <20230912030008.3599514-5-lulu@redhat.com>
 <CACGkMEtCYG8-Pt+V-OOwUV7fYFp_cnxU68Moisfxju9veJ-=qw@mail.gmail.com>
 <CACLfguW3NS_4+YhqTtGqvQb70mVazGVfheryHx4aCBn+=Skf9w@mail.gmail.com>
 <CACGkMEt-m9bOh9YnqLw0So5wqbZ69D0XRVBbfG73Oh7Q8qTJsQ@mail.gmail.com>
Content-Language: en-US
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [RFC v2 4/4] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
In-Reply-To: <CACGkMEt-m9bOh9YnqLw0So5wqbZ69D0XRVBbfG73Oh7Q8qTJsQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com
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

CgpPbiA5LzI1LzIzIDA0OjU3LCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIFRodSwgU2VwIDIxLCAy
MDIzIGF0IDEwOjA34oCvUE0gQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+
IE9uIE1vbiwgU2VwIDE4LCAyMDIzIGF0IDQ6NDnigK9QTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPj4+Cj4+PiBPbiBUdWUsIFNlcCAxMiwgMjAyMyBhdCAxMTowMeKA
r0FNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Cj4+Pj4gSW4gVkRVU0Vf
R0VUX1JFQ09OTkVDVF9JTkZPLCB0aGUgVXNlcnNwYWNlIEFwcCBjYW4gZ2V0IHRoZSBtYXAgc2l6
ZQo+Pj4+IGFuZCBUaGUgbnVtYmVyIG9mIG1hcHBpbmcgbWVtb3J5IHBhZ2VzIGZyb20gdGhlIGtl
cm5lbC4gVGhlIHVzZXJzcGFjZQo+Pj4+IEFwcCBjYW4gdXNlIHRoaXMgaW5mb3JtYXRpb24gdG8g
bWFwIHRoZSBwYWdlcy4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IENpbmR5IEx1IDxsdWx1QHJl
ZGhhdC5jb20+Cj4+Pj4gLS0tCj4+Pj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rl
di5jIHwgMTUgKysrKysrKysrKysrKysrCj4+Pj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmR1c2Uu
aCAgICAgICAgIHwgMTUgKysrKysrKysrKysrKysrCj4+Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDMw
IGluc2VydGlvbnMoKykKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV91
c2VyL3ZkdXNlX2Rldi5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+Pj4+
IGluZGV4IDY4MGIyM2RiZGRlMi4uYzk5Zjk5ODkyYjVjIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZl
cnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvdmRw
YV91c2VyL3ZkdXNlX2Rldi5jCj4+Pj4gQEAgLTEzNjgsNiArMTM2OCwyMSBAQCBzdGF0aWMgbG9u
ZyB2ZHVzZV9kZXZfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGludCBjbWQsCj4+
Pj4gICAgICAgICAgICAgICAgICByZXQgPSAwOwo+Pj4+ICAgICAgICAgICAgICAgICAgYnJlYWs7
Cj4+Pj4gICAgICAgICAgfQo+Pj4+ICsgICAgICAgY2FzZSBWRFVTRV9HRVRfUkVDT05ORUNUX0lO
Rk86IHsKPj4+PiArICAgICAgICAgICAgICAgc3RydWN0IHZkdXNlX3JlY29ubmVjdF9tbWFwX2lu
Zm8gaW5mbzsKPj4+PiArCj4+Pj4gKyAgICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7Cj4+Pj4g
KyAgICAgICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmaW5mbywgYXJncCwgc2l6ZW9mKGlu
Zm8pKSkKPj4+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPj4+PiArCj4+Pj4gKyAg
ICAgICAgICAgICAgIGluZm8uc2l6ZSA9IFBBR0VfU0laRTsKPj4+PiArICAgICAgICAgICAgICAg
aW5mby5tYXhfaW5kZXggPSBkZXYtPnZxX251bSArIDE7Cj4+Pj4gKwo+Pj4+ICsgICAgICAgICAg
ICAgICBpZiAoY29weV90b191c2VyKGFyZ3AsICZpbmZvLCBzaXplb2YoaW5mbykpKQo+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+Pj4+ICsgICAgICAgICAgICAgICByZXQgPSAw
Owo+Pj4+ICsgICAgICAgICAgICAgICBicmVhazsKPj4+PiArICAgICAgIH0KPj4+PiAgICAgICAg
ICBkZWZhdWx0Ogo+Pj4+ICAgICAgICAgICAgICAgICAgcmV0ID0gLUVOT0lPQ1RMQ01EOwo+Pj4+
ICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9s
aW51eC92ZHVzZS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmgKPj4+PiBpbmRleCBkNTg1
NDI1ODAzZmQuLmNlNTVlMzRmNjNkNyAxMDA2NDQKPj4+PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGlu
dXgvdmR1c2UuaAo+Pj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92ZHVzZS5oCj4+Pj4gQEAg
LTM1Niw0ICszNTYsMTkgQEAgc3RydWN0IHZob3N0X3JlY29ubmVjdF92cmluZyB7Cj4+Pj4gICAg
ICAgICAgX0Jvb2wgYXZhaWxfd3JhcF9jb3VudGVyOwo+Pj4+ICAgfTsKPj4+Pgo+Pj4+ICsvKioK
Pj4+PiArICogc3RydWN0IHZkdXNlX3JlY29ubmVjdF9tbWFwX2luZm8KPj4+PiArICogQHNpemU6
IG1hcHBpbmcgbWVtb3J5IHNpemUsIGFsd2F5cyBwYWdlX3NpemUgaGVyZQo+Pj4+ICsgKiBAbWF4
X2luZGV4OiB0aGUgbnVtYmVyIG9mIHBhZ2VzIGFsbG9jYXRlZCBpbiBrZXJuZWwsanVzdAo+Pj4+
ICsgKiB1c2UgZm9yIGNoZWNrCj4+Pj4gKyAqLwo+Pj4+ICsKPj4+PiArc3RydWN0IHZkdXNlX3Jl
Y29ubmVjdF9tbWFwX2luZm8gewo+Pj4+ICsgICAgICAgX191MzIgc2l6ZTsKPj4+PiArICAgICAg
IF9fdTMyIG1heF9pbmRleDsKPj4+PiArfTsKPj4+Cj4+PiBPbmUgdGhpbmcgSSBkaWRuJ3QgdW5k
ZXJzdGFuZCBpcyB0aGF0LCBhcmVuJ3QgdGhlIHRoaW5ncyB3ZSB1c2VkIHRvCj4+PiBzdG9yZSBj
b25uZWN0aW9uIGluZm8gYmVsb25nIHRvIHVBUEk/IElmIG5vdCwgaG93IGNhbiB3ZSBtYWtlIHN1
cmUgdGhlCj4+PiBjb25uZWN0aW9ucyB3b3JrIGFjcm9zcyBkaWZmZXJlbnQgdmVuZG9ycy9pbXBs
ZW1lbnRhdGlvbnMuIElmIHllcywKPj4+IHdoZXJlPwo+Pj4KPj4+IFRoYW5rcwo+Pj4KPj4gVGhl
IHByb2Nlc3MgZm9yIHRoaXMgcmVjb25uZWN0dGlvbiAgaXMKPj4gQS5UaGUgZmlyc3QtdGltZSBj
b25uZWN0aW9uCj4+IDE+IFRoZSB1c2VybGFuZCBhcHAgY2hlY2tzIGlmIHRoZSBkZXZpY2UgZXhp
c3RzCj4+IDI+ICB1c2UgdGhlIGlvY3RsIHRvIGNyZWF0ZSB0aGUgdmR1c2UgZGV2aWNlCj4+IDM+
IE1hcHBpbmcgdGhlIGtlcm5lbCBwYWdlIHRvIHVzZXJsYW5kIGFuZCBzYXZlIHRoZQo+PiBBcHAt
dmVyc2lvbi9mZWF0dXJlcy9vdGhlciBpbmZvcm1hdGlvbiB0byB0aGlzIHBhZ2UKPj4gND4gIGlm
IHRoZSBVc2VybGFuZCBhcHAgbmVlZHMgdG8gZXhpdCwgdGhlbiB0aGUgVXNlcmxhbmQgYXBwIHdp
bGwgb25seQo+PiB1bm1hcCB0aGUgcGFnZSBhbmQgdGhlbiBleGl0Cj4+Cj4+IEIsIHRoZSByZS1j
b25uZWN0aW9uCj4+IDE+IHRoZSB1c2VybGFuZCBhcHAgZmluZHMgdGhlIGRldmljZSBpcyBleGlz
dGluZwo+PiAyPiBNYXBwaW5nIHRoZSBrZXJuZWwgcGFnZSB0byB1c2VybGFuZAo+PiAzPiBjaGVj
ayBpZiB0aGUgaW5mb3JtYXRpb24gaW4gc2hhcmVkIG1lbW9yeSBpcyBzYXRpc2ZpZWQgdG8KPj4g
cmVjb25uZWN0LGlmIG9rIHRoZW4gY29udGludWUgdG8gcmVjb25uZWN0Cj4+IDQ+IGNvbnRpbnVl
IHdvcmtpbmcKPj4KPj4gICBGb3Igbm93IHRoZXNlIGluZm9ybWF0aW9uIGFyZSBhbGwgZnJvbSB1
c2VybGFuZCxTbyBoZXJlIHRoZSBwYWdlIHdpbGwKPj4gYmUgbWFpbnRhaW5lZCBieSB0aGUgdXNl
cmxhbmQgQXBwCj4+IGluIHRoZSBwcmV2aW91cyBjb2RlIHdlIG9ubHkgc2F2ZWQgdGhlIGFwaS12
ZXJzaW9uIGJ5IHVBUEkgLiAgaWYgIHdlCj4+IG5lZWQgdG8gc3VwcG9ydCByZWNvbm5lY3Rpb24g
bWF5YmUgd2UgbmVlZCB0byBhZGQgMiBuZXcgdUFQSSBmb3IgdGhpcywKPj4gb25lIG9mIHRoZSB1
QVBJIGlzIHRvIHNhdmUgdGhlIHJlY29ubmVjdCAgaW5mb3JtYXRpb24gYW5kIGFub3RoZXIgaXMK
Pj4gdG8gZ2V0IHRoZSBpbmZvcm1hdGlvbgo+Pgo+PiBtYXliZSBzb21ldGhpbmcgbGlrZQo+Pgo+
PiBzdHJ1Y3Qgdmhvc3RfcmVjb25uZWN0X2RhdGEgewo+PiB1aW50MzJfdCB2ZXJzaW9uOwo+PiB1
aW50NjRfdCBmZWF0dXJlczsKPj4gdWludDhfdCBzdGF0dXM7Cj4+IHN0cnVjdCB2aXJ0aW9fbmV0
X2NvbmZpZyBjb25maWc7Cj4+IHVpbnQzMl90IG5yX3ZyaW5nczsKPj4gfTsKPiAKPiBQcm9iYWJs
eSwgdGhlbiB3ZSBjYW4gbWFrZSBzdXJlIHRoZSByZS1jb25uZWN0aW9uIHdvcmtzIGFjcm9zcwo+
IGRpZmZlcmVudCB2ZHVzZS1kYWVtb24gaW1wbGVtZW50YXRpb25zLgoKKzEsIHdlIG5lZWQgdG8g
aGF2ZSB0aGlzIGRlZmluZWQgaW4gdGhlIHVBUEkgdG8gc3VwcG9ydCBpbnRlcm9wZXJhYmlsaXR5
CmFjcm9zcyBkaWZmZXJlbnQgVkRVU0UgdXNlcnNwYWNlIGltcGxlbWVudGF0aW9ucy4KCj4gCj4+
Cj4+ICNkZWZpbmUgVkRVU0VfR0VUX1JFQ09OTkVDVF9JTkZPIF9JT1IgKFZEVVNFX0JBU0UsIDB4
MWMsIHN0cnVjdAo+PiB2aG9zdF9yZWNvbm5lY3RfZGF0YSkKPj4KPj4gI2RlZmluZSBWRFVTRV9T
RVRfUkVDT05ORUNUX0lORk8gIF9JT1dSKFZEVVNFX0JBU0UsIDB4MWQsIHN0cnVjdAo+PiB2aG9z
dF9yZWNvbm5lY3RfZGF0YSkKPiAKPiBOb3Qgc3VyZSBJIGdldCB0aGlzLCBidXQgdGhlIGlkZWEg
aXMgdG8gbWFwIHRob3NlIHBhZ2VzIHRvIHVzZXIgc3BhY2UsCj4gYW55IHJlYXNvbiB3ZSBuZWVk
IHRoaXMgdUFQST8KCkl0IHNob3VsZCBub3QgYmUgbmVjZXNzYXJ5IGlmIHRoZSBtbWFwcGVkIGxh
eW91dCBpcyBwcm9wZXJseSBkZWZpbmVkLgoKVGhhbmtzLApNYXhpbWUKCj4gVGhhbmtzCj4gCj4+
Cj4+IFRoYW5rcwo+PiBDaW5keQo+Pgo+Pgo+Pgo+Pgo+Pj4+ICsKPj4+PiArI2RlZmluZSBWRFVT
RV9HRVRfUkVDT05ORUNUX0lORk8gXAo+Pj4+ICsgICAgICAgX0lPV1IoVkRVU0VfQkFTRSwgMHgx
Yiwgc3RydWN0IHZkdXNlX3JlY29ubmVjdF9tbWFwX2luZm8pCj4+Pj4gKwo+Pj4+ICAgI2VuZGlm
IC8qIF9VQVBJX1ZEVVNFX0hfICovCj4+Pj4gLS0KPj4+PiAyLjM0LjMKPj4+Pgo+Pj4KPj4KPiAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
