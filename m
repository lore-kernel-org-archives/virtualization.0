Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAF6C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 03:53:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5A764ED5
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 03:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5A764ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 27FE820109;
	Tue,  2 Feb 2021 03:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bQTQ1l22qo0F; Tue,  2 Feb 2021 03:53:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 023B720338;
	Tue,  2 Feb 2021 03:53:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E525CC0174;
	Tue,  2 Feb 2021 03:53:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BD12C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E6A9A20338
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AgtuHIYvsTb8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:53:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id AD80820109
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612238001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cafQreaiV+gjtqgE/Nu7o5K5at0fIjvGIgZ0VeRpg0M=;
 b=U8zR6gm6POxy8C4bRL/jgSUE+sUVemezMEsIVo0nwp/I452YEl8bJMHmEfiNF4XCd9pOpv
 MKbOmEY/o2f2lxCIw4nlvf0aA7fXH9JYiWejPPNEECJzDtpkh8fIhZDhlfP5KycBRQKUsY
 mlofHfkMiyCeYe5ETD5D8k7gCaxr/w4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-dlb4eWRFMS-DZiIYryNZwA-1; Mon, 01 Feb 2021 22:53:16 -0500
X-MC-Unique: dlb4eWRFMS-DZiIYryNZwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 433711800D50;
 Tue,  2 Feb 2021 03:53:12 +0000 (UTC)
Received: from [10.72.13.250] (ovpn-13-250.pek2.redhat.com [10.72.13.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3723627C24;
 Tue,  2 Feb 2021 03:53:06 +0000 (UTC)
Subject: Re: [PATCH V3 00/19] vDPA driver for virtio-pci device
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20210104065503.199631-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <21d3cd67-0e5d-a202-2dc1-bf7f4907f180@redhat.com>
Date: Tue, 2 Feb 2021 11:53:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104065503.199631-1-jasowang@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com, rdunlap@infradead.org, lulu@redhat.com
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

Ck9uIDIwMjEvMS80IOS4i+WNiDI6NTQsIEphc29uIFdhbmcgd3JvdGU6Cj4gSGkgYWxsOgo+Cj4g
VGhpcyBzZXJpZXMgdHJpZXMgdG8gaW1wbGVtZW50IGEgdkRQQSBkcml2ZXIgZm9yIHZpcnRpby1w
Y2kgZGV2aWNlCj4gd2hpY2ggd2lsbCBicmlkZ2UgYmV0d2VlbiB2RFBBIGJ1cyBhbmQgdmlydGlv
LXBjaSBkZXZpY2UuCj4KPiBUaGlzIGNvdWxkIGJlIHVzZWQgZm9yIGZ1dHVyZSBmZWF0dXJlIHBy
b3RvdHlwaW5nIGFuZCB0ZXN0aW5nLgo+Cj4gUGxlYXNlIHJldmlldwo+Cj4gQ2hhbmdlcyBzaW5j
ZSBWMjoKPgo+IC0gdHdlYWsgY29uZmlnIHByb21wdAo+IC0gc3dpdGNoIGZyb20gJ2NiJyB0byAn
Y29uZmlnX2NiJyBmb3IgdnBfdmRwYSBjb25maWcgaW50ZXJydXB0Cj4gLSB1c2UgYSBtYWNybyBm
b3IgdnBfdmRwYSBtc2l4IG5hbWUgbGVuZ3RoCgoKSGkgTWljaGFlbDoKCkFueSBjb21tZW50cyBv
biB0aGlzIHNlcmllcz8KClRoYW5rcwoKCj4KPiBDaGFuZ2VzIHNpbmNlIFYxOgo+Cj4gLSBkb24n
dCB0cnkgdG8gdXNlIGRldnJlcyBmb3IgdmlydGlvLXBjaSBjb3JlCj4gLSB0d2VhayB0aGUgY29t
bWl0IGxvZwo+IC0gc3BsaXQgdGhlIHBhdGNoZXMgZnVydGhlcmx5IHRvIGVhc2UgdGhlIHJldmll
d2luZwo+Cj4gQ2hhbmdlcyBzaW5jZSBSRkM6Cj4KPiAtIFNwbGl0IGNvbW1vbiBjb2RlcyBmcm9t
IHZpcml0by1wY2kgYW5kIHNoYXJlIGl0IHdpdGggdkRQQSBkcml2ZXIKPiAtIFVzZSBkeW5hbWlj
IGlkIGluIG9yZGVyIHRvIGJlIGxlc3MgY29uZnVzaW5nIHdpdGggdmlydGlvLXBjaSBkcml2ZXIK
PiAtIE5vIGZlYXR1cmUgd2hpdGVsaXN0LCBzdXBwb3J0aW5nIGFueSBmZWF0dXJlcyAobXEsIGNv
bmZpZyBldGMpCj4KPiBUaGFua3MKPgo+IEphc29uIFdhbmcgKDE5KToKPiAgICB2aXJ0aW8tcGNp
OiBkbyBub3QgYWNjZXNzIGlvbWVtIHZpYSBzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgZGlyZWN0
bHkKPiAgICB2aXJ0aW8tcGNpOiBzcGxpdCBvdXQgbW9kZXJuIGRldmljZQo+ICAgIHZpcnRpby1w
Y2ktbW9kZXJuOiBmYWN0b3Igb3V0IG1vZGVybiBkZXZpY2UgaW5pdGlhbGl6YXRpb24gbG9naWMK
PiAgICB2aXJ0aW8tcGNpLW1vZGVybjogaW50cm9kdWNlIHZwX21vZGVybl9yZW1vdmUoKQo+ICAg
IHZpcnRpby1wY2ktbW9kZXJuOiBpbnRyb2R1Y2UgaGVscGVyIHRvIHNldCBjb25maWcgdmVjdG9y
Cj4gICAgdmlydGlvLXBjaS1tb2Rlcm46IGludHJvZHVjZSBoZWxwZXJzIGZvciBzZXR0aW5nIGFu
ZCBnZXR0aW5nIHN0YXR1cwo+ICAgIHZpcnRpby1wY2ktbW9kZXJuOiBpbnRyb2R1Y2UgaGVscGVy
cyBmb3Igc2V0dGluZyBhbmQgZ2V0dGluZyBmZWF0dXJlcwo+ICAgIHZpcnRpby1wY2ktbW9kZXJu
OiBpbnRyb2R1Y2UgdnBfbW9kZXJuX2dlbmVyYXRpb24oKQo+ICAgIHZpcnRpby1wY2ktbW9kZXJu
OiBpbnRyb2R1Y2UgdnBfbW9kZXJuX3NldF9xdWV1ZV92ZWN0b3IoKQo+ICAgIHZpcnRpby1wY2kt
bW9kZXJuOiBpbnRyb2R1Y2UgdnBfbW9kZXJuX3F1ZXVlX2FkZHJlc3MoKQo+ICAgIHZpcnRpby1w
Y2ktbW9kZXJuOiBpbnRyb2R1Y2UgaGVscGVyIHRvIHNldC9nZXQgcXVldWVfZW5hYmxlCj4gICAg
dmlydGlvLXBjaS1tb2Rlcm46IGludHJvZHVjZSBoZWxwZXIgZm9yIHNldHRpbmcvZ2V0aW5nIHF1
ZXVlIHNpemUKPiAgICB2aXJ0aW8tcGNpLW1vZGVybjogaW50cm9kdWNlIGhlbHBlciBmb3IgZ2V0
dGluZyBxdWV1ZSBudW1zCj4gICAgdmlydGlvLXBjaS1tb2Rlcm46IGludHJvZHVjZSBoZWxwZXIg
dG8gZ2V0IG5vdGlmaWNhdGlvbiBvZmZzZXQKPiAgICB2aXJpdG8tcGNpLW1vZGVybjogcmVuYW1l
IG1hcF9jYXBhYmlsaXR5KCkgdG8KPiAgICAgIHZwX21vZGVybl9tYXBfY2FwYWJpbGl0eSgpCj4g
ICAgdmlydGlvLXBjaTogaW50cm9kdWNlIG1vZGVybiBkZXZpY2UgbW9kdWxlCj4gICAgdmRwYTog
c2V0IHRoZSB2aXJ0cXVldWUgbnVtIGR1cmluZyByZWdpc3Rlcgo+ICAgIHZpcnRpb192ZHBhOiBk
b24ndCB3YXJuIHdoZW4gZmFpbCB0byBkaXNhYmxlIHZxCj4gICAgdmRwYTogaW50cm9kdWNlIHZp
cnRpbyBwY2kgZHJpdmVyCj4KPiAgIGRyaXZlcnMvdmRwYS9LY29uZmlnICAgICAgICAgICAgICAg
ICAgIHwgICA2ICsKPiAgIGRyaXZlcnMvdmRwYS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgIHwg
ICAxICsKPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgICAgICAgIHwgICA1ICst
Cj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgICAgICB8ICAgNSArLQo+ICAg
ZHJpdmVycy92ZHBhL3ZkcGEuYyAgICAgICAgICAgICAgICAgICAgfCAgIDggKy0KPiAgIGRyaXZl
cnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jICAgICAgIHwgICA0ICstCj4gICBkcml2ZXJzL3Zk
cGEvdmlydGlvX3BjaS9NYWtlZmlsZSAgICAgICB8ICAgMiArCj4gICBkcml2ZXJzL3ZkcGEvdmly
dGlvX3BjaS92cF92ZHBhLmMgICAgICB8IDQ1NiArKysrKysrKysrKysrKysrKysrCj4gICBkcml2
ZXJzL3ZpcnRpby9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAxMCArLQo+ICAgZHJpdmVycy92
aXJ0aW8vTWFrZWZpbGUgICAgICAgICAgICAgICAgfCAgIDEgKwo+ICAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9jb21tb24uaCAgICAgfCAgMjIgKy0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfbW9kZXJuLmMgICAgIHwgNTA2ICsrKy0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgfCA1OTkgKysrKysrKysrKysrKysrKysr
KysrKysrKwo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyAgICAgICAgICAgfCAgIDMg
Ky0KPiAgIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgICAgICAgICAgIHwgICA3ICstCj4g
ICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmggICAgICB8IDExMSArKysrKwo+ICAg
MTYgZmlsZXMgY2hhbmdlZCwgMTI3NCBpbnNlcnRpb25zKCspLCA0NzIgZGVsZXRpb25zKC0pCj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvTWFrZWZpbGUKPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybl9kZXYu
Ywo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4u
aAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
