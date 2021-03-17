Return-Path: <SRS0=tvPF=IP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812F8C4361B
	for <virtualization@archiver.kernel.org>; Wed, 17 Mar 2021 02:25:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E88F64F99
	for <virtualization@archiver.kernel.org>; Wed, 17 Mar 2021 02:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E88F64F99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B52388364F;
	Wed, 17 Mar 2021 02:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f2s8ryBO9LRp; Wed, 17 Mar 2021 02:25:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4398F83A7E;
	Wed, 17 Mar 2021 02:25:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00204C000C;
	Wed, 17 Mar 2021 02:25:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F4A6C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 02:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0623842FB6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 02:25:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E3Bus0PwYREW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 02:25:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 255D641468
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 02:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615947928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8GMje+fkgQdNG6jh0ujf3b/8nRhqfEJkA1xHCSteqI=;
 b=UQiYpLtPF+4GFSts+9WKF629LQHEevFneWpwWFQKKIsgkU/Qc4b+Bx2evfGZGOorheSjd4
 QEl1z1t7wEOtaMgGbzqxnBLl2south9NthRhOytk75XRl0eLkBEHwEYMMt1Ytk9CRI48da
 2qzUzRXVoPzQAr2N8mM+tnG5qkH3vmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-V0YpjDyfPSq8T5ypNbMdwQ-1; Tue, 16 Mar 2021 22:25:24 -0400
X-MC-Unique: V0YpjDyfPSq8T5ypNbMdwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 678C61015C8C;
 Wed, 17 Mar 2021 02:25:22 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-188.pek2.redhat.com
 [10.72.12.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E3CA5D9DC;
 Wed, 17 Mar 2021 02:25:12 +0000 (UTC)
Subject: Re: [RFC v2 10/13] vhost: add vhost_kernel_set_vring_enable
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20210315194842.277740-1-eperezma@redhat.com>
 <20210315194842.277740-11-eperezma@redhat.com>
 <98916095-ac78-7deb-5086-ee0adf39dcf5@redhat.com>
 <CAJaqyWcFQQQg1YS14NY3JDfHcjEnhvim3TzxV0FEPyKqhf0nrg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c7206893-729a-0c67-e903-faab9ea98b94@redhat.com>
Date: Wed, 17 Mar 2021 10:25:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcFQQQg1YS14NY3JDfHcjEnhvim3TzxV0FEPyKqhf0nrg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Guru Prasad <guru.prasad@broadcom.com>, qemu-level <qemu-devel@nongnu.org>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>,
 Jim Harford <jim.harford@broadcom.com>, Rob Miller <rob.miller@broadcom.com>
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

CuWcqCAyMDIxLzMvMTYg5LiL5Y2INjo0MywgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
IE9uIFR1ZSwgTWFyIDE2LCAyMDIxIGF0IDg6MzAgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IOWcqCAyMDIxLzMvMTYg5LiK5Y2IMzo0OCwgRXVnZW5pbyBQ
w6lyZXog5YaZ6YGTOgo+Pj4gVGhpcyBtZXRob2QgaXMgYWxyZWFkeSBwcmVzZW50IGluIHZob3N0
LXVzZXIuIFRoaXMgY29tbWl0IGFkYXB0cyBpdCB0bwo+Pj4gdmhvc3QtbmV0LCBzbyBTVlEgY2Fu
IHVzZS4KPj4+Cj4+PiB2aG9zdF9rZXJuZWxfc2V0X2VuYWJsZSBzdG9wcyB0aGUgZGV2aWNlLCBz
byBxZW11IGNhbiBhc2sgZm9yIGl0cyBzdGF0dXMKPj4+IChuZXh0IGF2YWlsYWJsZSBpZHggdGhl
IGRldmljZSB3YXMgZ29pbmcgdG8gY29uc3VtZSkuIFdoZW4gU1ZRIHN0YXJ0cyBpdAo+Pj4gY2Fu
IHJlc3VtZSBjb25zdW1pbmcgdGhlIGd1ZXN0J3MgZHJpdmVyIHJpbmcsIHdpdGhvdXQgbm90aWNl
IGZyb20gdGhlCj4+PiBsYXR0ZXIuIE5vdCBzdG9wcGluZyB0aGUgZGV2aWNlIGJlZm9yZSBvZiB0
aGUgc3dhcHBpbmcgY291bGQgaW1wbHkgdGhhdAo+Pj4gaXQgcHJvY2VzcyBtb3JlIGJ1ZmZlcnMg
dGhhbiByZXBvcnRlZCwgd2hhdCB3b3VsZCBkdXBsaWNhdGUgdGhlIGRldmljZQo+Pj4gYWN0aW9u
Lgo+Pgo+PiBOb3RlIHRoYXQgaXQgbWlnaHQgbm90IGJlIHRoZSBjYXNlIG9mIHZEUEEgKHZpcnRp
bykgb3IgYXQgbGVhc3QgdmlydGlvCj4+IG5lZWRzIHNvbWUgZXh0ZW5zaW9uIHRvIGFjaGlldmUg
c29tZXRoaW5nIHNpbWlsYXIgbGlrZSB0aGlzLiBPbmUgZXhhbXBsZQo+PiBpcyB2aXJ0aW8tcGNp
IHdoaWNoIGZvcmJpZHMgMCB0byBiZSB3cm90ZSB0byBxdWV1ZV9lbmFibGUuCj4+Cj4+IFRoaXMg
aXMgYW5vdGhlciByZWFzb24gdG8gc3RhcnQgZnJvbSB2aG9zdC12RFBBLgo+Pgo+Pgo+Pj4gU2ln
bmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4+PiAtLS0K
Pj4+ICAgIGh3L3ZpcnRpby92aG9zdC1iYWNrZW5kLmMgfCAyOSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykKPj4+Cj4+
PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LWJhY2tlbmQuYyBiL2h3L3ZpcnRpby92aG9z
dC1iYWNrZW5kLmMKPj4+IGluZGV4IDMxYjMzYmRlMzcuLjFhYzVjNTc0YTkgMTAwNjQ0Cj4+PiAt
LS0gYS9ody92aXJ0aW8vdmhvc3QtYmFja2VuZC5jCj4+PiArKysgYi9ody92aXJ0aW8vdmhvc3Qt
YmFja2VuZC5jCj4+PiBAQCAtMjAxLDYgKzIwMSwzNCBAQCBzdGF0aWMgaW50IHZob3N0X2tlcm5l
bF9nZXRfdnFfaW5kZXgoc3RydWN0IHZob3N0X2RldiAqZGV2LCBpbnQgaWR4KQo+Pj4gICAgICAg
IHJldHVybiBpZHggLSBkZXYtPnZxX2luZGV4Owo+Pj4gICAgfQo+Pj4KPj4+ICtzdGF0aWMgaW50
IHZob3N0X2tlcm5lbF9zZXRfdnFfZW5hYmxlKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdW5zaWdu
ZWQgaWR4LAo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBl
bmFibGUpCj4+PiArewo+Pj4gKyAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfZmlsZSBmaWxlID0gewo+
Pj4gKyAgICAgICAgLmluZGV4ID0gaWR4LAo+Pj4gKyAgICB9Owo+Pj4gKwo+Pj4gKyAgICBpZiAo
IWVuYWJsZSkgewo+Pj4gKyAgICAgICAgZmlsZS5mZCA9IC0xOyAvKiBQYXNzIC0xIHRvIHVuYmlu
ZCBmcm9tIGZpbGUuICovCj4+PiArICAgIH0gZWxzZSB7Cj4+PiArICAgICAgICBzdHJ1Y3Qgdmhv
c3RfbmV0ICp2bl9kZXYgPSBjb250YWluZXJfb2YoZGV2LCBzdHJ1Y3Qgdmhvc3RfbmV0LCBkZXYp
Owo+Pj4gKyAgICAgICAgZmlsZS5mZCA9IHZuX2Rldi0+YmFja2VuZDsKPj4KPj4gVGhpcyBjYW4g
b25seSB3b3JrIHdpdGggdmhvc3QtbmV0IGRldmljZXMgYnV0IG5vdCB2c29jay9zY3NpIGV0Yy4K
Pj4KPiBSaWdodC4gU2hhZG93IHZpcnRxdWV1ZSBjb2RlIHNob3VsZCBhbHNvIGNoZWNrIHRoZSBy
ZXR1cm4gdmFsdWUgb2YgdGhlCj4gdmhvc3Rfc2V0X3ZyaW5nX2VuYWJsZSBjYWxsLgo+Cj4gSSdt
IG5vdCBzdXJlIGhvdyB0byBzb2x2ZSBpdCB3aXRob3V0IHJlc29ydGluZyB0byBzb21lIGlmZWxz
ZS9zd2l0Y2gKPiBjaGFpbiwgY2hlY2tpbmcgZm9yIHNwZWNpZmljIG5ldC92c29jay8uLi4gZmVh
dHVyZXMsIG9yIHJlbGF5aW5nIG9uCj4gc29tZSBvdGhlciBxZW11IGNsYXNzIGZhY2lsaXRpZXMu
IEhvd2V2ZXIsIHNpbmNlIHRoZSBtYWluIHVzZSBjYXNlIGlzCj4gdkRQQSBsaXZlIG1pZ3JhdGlv
biwgdGhpcyBjb21taXQgY291bGQgYmUgbGVmdCBvdXQgYW5kIFNWUSBvcGVyYXRpb24KPiB3b3Vs
ZCBvbmx5IGJlIHZhbGlkIGZvciB2aG9zdC12ZHBhIGFuZCB2aG9zdC11c2VyLgoKClllcywgdGhh
dCdzIHdoeSBJIHRoaW5rIHdlIGNhbiBzdGFydCB3aXRoIHZob3N0LXZEUEEgZmlyc3QuCgpUaGFu
a3MKCgo+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4gKyAgICB9Cj4+PiArCj4+PiArICAgIHJldHVybiB2
aG9zdF9rZXJuZWxfbmV0X3NldF9iYWNrZW5kKGRldiwgJmZpbGUpOwo+Pj4gK30KPj4+ICsKPj4+
ICtzdGF0aWMgaW50IHZob3N0X2tlcm5lbF9zZXRfdnJpbmdfZW5hYmxlKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldiwgaW50IGVuYWJsZSkKPj4+ICt7Cj4+PiArICAgIGludCBpOwo+Pj4gKwo+Pj4gKyAg
ICBmb3IgKGkgPSAwOyBpIDwgZGV2LT5udnFzOyArK2kpIHsKPj4+ICsgICAgICAgIHZob3N0X2tl
cm5lbF9zZXRfdnFfZW5hYmxlKGRldiwgaSwgZW5hYmxlKTsKPj4+ICsgICAgfQo+Pj4gKwo+Pj4g
KyAgICByZXR1cm4gMDsKPj4+ICt9Cj4+PiArCj4+PiAgICAjaWZkZWYgQ09ORklHX1ZIT1NUX1ZT
T0NLCj4+PiAgICBzdGF0aWMgaW50IHZob3N0X2tlcm5lbF92c29ja19zZXRfZ3Vlc3RfY2lkKHN0
cnVjdCB2aG9zdF9kZXYgKmRldiwKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDY0X3QgZ3Vlc3RfY2lkKQo+Pj4gQEAgLTMxNyw2ICszNDUsNyBA
QCBzdGF0aWMgY29uc3QgVmhvc3RPcHMga2VybmVsX29wcyA9IHsKPj4+ICAgICAgICAgICAgLnZo
b3N0X3NldF9vd25lciA9IHZob3N0X2tlcm5lbF9zZXRfb3duZXIsCj4+PiAgICAgICAgICAgIC52
aG9zdF9yZXNldF9kZXZpY2UgPSB2aG9zdF9rZXJuZWxfcmVzZXRfZGV2aWNlLAo+Pj4gICAgICAg
ICAgICAudmhvc3RfZ2V0X3ZxX2luZGV4ID0gdmhvc3Rfa2VybmVsX2dldF92cV9pbmRleCwKPj4+
ICsgICAgICAgIC52aG9zdF9zZXRfdnJpbmdfZW5hYmxlID0gdmhvc3Rfa2VybmVsX3NldF92cmlu
Z19lbmFibGUsCj4+PiAgICAjaWZkZWYgQ09ORklHX1ZIT1NUX1ZTT0NLCj4+PiAgICAgICAgICAg
IC52aG9zdF92c29ja19zZXRfZ3Vlc3RfY2lkID0gdmhvc3Rfa2VybmVsX3Zzb2NrX3NldF9ndWVz
dF9jaWQsCj4+PiAgICAgICAgICAgIC52aG9zdF92c29ja19zZXRfcnVubmluZyA9IHZob3N0X2tl
cm5lbF92c29ja19zZXRfcnVubmluZywKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
