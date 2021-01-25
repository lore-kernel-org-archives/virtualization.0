Return-Path: <SRS0=TROJ=G4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F16FC433E0
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 03:12:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD832085B
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 03:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD832085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6E7E685B0A;
	Mon, 25 Jan 2021 03:12:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m4_bevkF_Wgh; Mon, 25 Jan 2021 03:12:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B3D4185AF1;
	Mon, 25 Jan 2021 03:12:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83BD5C08A1;
	Mon, 25 Jan 2021 03:12:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDCF5C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 03:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B2251870C1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 03:12:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LyeWX7ZXHr9U
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 03:12:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CB80B870AC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 03:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611544341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wyqsE2ie42MN4KyFAEL6ikQv7mdclBjRKNwb4r3BNqA=;
 b=dYUOUxvz0cFoKfEzH0+vwQPLEwtQkyACKqdJTxXxnGvNCzqwxyVeDOxWgi9WiOakuogvGi
 ZalrzYYfOARCYvwJPuMx9vxMQEcgqmbPUHUpEssF/3qItslnWVBHQhPuqBF5WMUS6Tovzz
 hP5pIwslMOgImOT+Zqel9VliwM4ZMjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-HswSJKU1PvukQT_eyiencA-1; Sun, 24 Jan 2021 22:12:19 -0500
X-MC-Unique: HswSJKU1PvukQT_eyiencA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDF3E803623;
 Mon, 25 Jan 2021 03:12:17 +0000 (UTC)
Received: from [10.72.12.105] (ovpn-12-105.pek2.redhat.com [10.72.12.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7AD86F984;
 Mon, 25 Jan 2021 03:12:08 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] vhost scsi: alloc vhost_scsi with kvzalloc() to
 avoid delay
To: Dongli Zhang <dongli.zhang@oracle.com>,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
 netdev@vger.kernel.org
References: <20210123080853.4214-1-dongli.zhang@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <61ed58d6-052b-9065-361d-dc6010fc91ef@redhat.com>
Date: Mon, 25 Jan 2021 11:12:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210123080853.4214-1-dongli.zhang@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: aruna.ramakrishna@oracle.com, mst@redhat.com, joe.jin@oracle.com,
 linux-kernel@vger.kernel.org, stefanha@redhat.com, pbonzini@redhat.com
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

Ck9uIDIwMjEvMS8yMyDkuIvljYg0OjA4LCBEb25nbGkgWmhhbmcgd3JvdGU6Cj4gVGhlIHNpemUg
b2YgJ3N0cnVjdCB2aG9zdF9zY3NpJyBpcyBvcmRlci0xMCAofjIuM01CKS4gSXQgbWF5IHRha2Ug
bG9uZyB0aW1lCj4gZGVsYXkgYnkga3phbGxvYygpIHRvIGNvbXBhY3QgbWVtb3J5IHBhZ2VzIGJ5
IHJldHJ5aW5nIG11bHRpcGxlIHRpbWVzIHdoZW4KPiB0aGVyZSBpcyBhIGxhY2sgb2YgaGlnaC1v
cmRlciBwYWdlcy4gQXMgYSByZXN1bHQsIHRoZXJlIGlzIGxhdGVuY3kgdG8KPiBjcmVhdGUgYSBW
TSAod2l0aCB2aG9zdC1zY3NpKSBvciB0byBob3RhZGQgdmhvc3Qtc2NzaS1iYXNlZCBzdG9yYWdl
Lgo+Cj4gVGhlIHByaW9yIGNvbW1pdCA1OTVjYjc1NDk4M2QgKCJ2aG9zdC9zY3NpOiB1c2Ugdm1h
bGxvYyBmb3Igb3JkZXItMTAKPiBhbGxvY2F0aW9uIikgcHJlZmVycyB0byBmYWxsYmFjayBvbmx5
IHdoZW4gcmVhbGx5IG5lZWRlZCwgd2hpbGUgdGhpcyBwYXRjaAo+IGFsbG9jYXRlcyB3aXRoIGt2
emFsbG9jKCkgd2l0aCBfX0dGUF9OT1JFVFJZIGltcGxpY2l0bHkgc2V0IHRvIGF2b2lkCj4gcmV0
cnlpbmcgbWVtb3J5IHBhZ2VzIGNvbXBhY3QgZm9yIG11bHRpcGxlIHRpbWVzLgo+Cj4gVGhlIF9f
R0ZQX05PUkVUUlkgaXMgaW1wbGljaXRseSBzZXQgaWYgdGhlIHNpemUgdG8gYWxsb2NhdGUgaXMg
bW9yZSB0aGFuCj4gUEFHRV9TWklFIGFuZCB3aGVuIF9fR0ZQX1JFVFJZX01BWUZBSUwgaXMgbm90
IGV4cGxpY2l0bHkgc2V0Lgo+Cj4gQ2M6IEFydW5hIFJhbWFrcmlzaG5hIDxhcnVuYS5yYW1ha3Jp
c2huYUBvcmFjbGUuY29tPgo+IENjOiBKb2UgSmluIDxqb2UuamluQG9yYWNsZS5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogRG9uZ2xpIFpoYW5nIDxkb25nbGkuemhhbmdAb3JhY2xlLmNvbT4KPiAtLS0K
PiBDaGFuZ2VkIHNpbmNlIHYxOgo+ICAgIC0gVG8gY29tYmluZSBremFsbG9jKCkgYW5kIHZ6YWxs
b2MoKSBhcyBrdnphbGxvYygpCj4gICAgICAoc3VnZ2VzdGVkIGJ5IEphc29uIFdhbmcpCj4KPiAg
IGRyaXZlcnMvdmhvc3Qvc2NzaS5jIHwgOSArKystLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aG9zdC9zY3NpLmMgYi9kcml2ZXJzL3Zob3N0L3Njc2kuYwo+IGluZGV4IDRjZTlmMDBhZTEwZS4u
NWRlMjFhZDRiZDA1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvc2NzaS5jCj4gKysrIGIv
ZHJpdmVycy92aG9zdC9zY3NpLmMKPiBAQCAtMTgxNCwxMiArMTgxNCw5IEBAIHN0YXRpYyBpbnQg
dmhvc3Rfc2NzaV9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmKQo+ICAg
CXN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKip2cXM7Cj4gICAJaW50IHIgPSAtRU5PTUVNLCBpOwo+
ICAgCj4gLQl2cyA9IGt6YWxsb2Moc2l6ZW9mKCp2cyksIEdGUF9LRVJORUwgfCBfX0dGUF9OT1dB
Uk4gfCBfX0dGUF9SRVRSWV9NQVlGQUlMKTsKPiAtCWlmICghdnMpIHsKPiAtCQl2cyA9IHZ6YWxs
b2Moc2l6ZW9mKCp2cykpOwo+IC0JCWlmICghdnMpCj4gLQkJCWdvdG8gZXJyX3ZzOwo+IC0JfQo+
ICsJdnMgPSBrdnphbGxvYyhzaXplb2YoKnZzKSwgR0ZQX0tFUk5FTCk7Cj4gKwlpZiAoIXZzKQo+
ICsJCWdvdG8gZXJyX3ZzOwo+ICAgCj4gICAJdnFzID0ga21hbGxvY19hcnJheShWSE9TVF9TQ1NJ
X01BWF9WUSwgc2l6ZW9mKCp2cXMpLCBHRlBfS0VSTkVMKTsKPiAgIAlpZiAoIXZxcykKCgpBY2tl
ZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
