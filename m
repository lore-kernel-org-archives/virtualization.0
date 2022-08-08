Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EBFC25B0C
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 12:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 172C760BF3;
	Mon,  8 Aug 2022 12:14:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 172C760BF3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EReaLd4y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rNH9P_NJ7A7m; Mon,  8 Aug 2022 12:14:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A56C1606A0;
	Mon,  8 Aug 2022 12:14:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A56C1606A0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89323C0033;
	Mon,  8 Aug 2022 12:14:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE90AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAD8040892
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:14:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAD8040892
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EReaLd4y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z6-J8ifEHD9E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:14:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A13DE40890
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A13DE40890
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659960853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DdZ8nPGu01RNMjwipZUjvN2eZPFJM8suhgA2+FpsgEk=;
 b=EReaLd4yXid83za0t+5xQTSi5og2pDFSRuTVhNUpwJQt2ocGN6ylsJkDPo071q2HDrqj55
 SuM7jrvYViISdLZ2IMFmwvNlhxmPzRxo+vnALvbSqM/7wSO8rt0//E8ZW7JxkCQnu5EtnG
 n7M0AwGE9Z3xBP2Z4Om4dR4yjNHDDqE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-yaN86KFiNjKcokbGURhygA-1; Mon, 08 Aug 2022 08:14:10 -0400
X-MC-Unique: yaN86KFiNjKcokbGURhygA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B504D801585;
 Mon,  8 Aug 2022 12:14:09 +0000 (UTC)
Received: from localhost (unknown [10.39.193.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67F1B9457F;
 Mon,  8 Aug 2022 12:14:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virtio: kerneldocs fixes and enhancements
In-Reply-To: <20220804105914.3707389-2-ricardo.canuelo@collabora.com>
Organization: Red Hat GmbH
References: <20220804105914.3707389-1-ricardo.canuelo@collabora.com>
 <20220804105914.3707389-2-ricardo.canuelo@collabora.com>
User-Agent: Notmuch/0.36 (https://notmuchmail.org)
Date: Mon, 08 Aug 2022 14:14:07 +0200
Message-ID: <87edxrdjao.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 bagasdotme@gmail.com, kernel@collabora.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBBdWcgMDQgMjAyMiwgUmljYXJkbyBDYcOxdWVsbyA8cmljYXJkby5jYW51ZWxvQGNv
bGxhYm9yYS5jb20+IHdyb3RlOgoKPiBGaXggdmFyaWFibGUgbmFtZXMgaW4gc29tZSBodG1sZG9j
cywgbmFtaW5nIGluIG90aGVycy4KPiBBZGQgaHRtbGRvY3MgZm9yIHN0cnVjdCB2cmluZ19kZXNj
IGFuZCB2cmluZ19pbnRlcnJ1cHQuCgpJc24ndCB0aGF0ICJrZXJuZWxkb2MiPyBCdXQgbWF5YmUg
SSdtIGEgYml0IGJlaGluZCBvbiB0aGUgY3VycmVudAp0ZXJtaW5vbG9neS4KCj4KPiBTaWduZWQt
b2ZmLWJ5OiBSaWNhcmRvIENhw7F1ZWxvIDxyaWNhcmRvLmNhbnVlbG9AY29sbGFib3JhLmNvbT4K
PiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyAgICAgfCAgOCArKysrKysrKwo+
ICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgICAgICB8ICA2ICsrKy0tLQo+ICBpbmNsdWRl
L2xpbnV4L3ZpcnRpb19jb25maWcuaCAgICB8ICA2ICsrKy0tLQo+ICBpbmNsdWRlL3VhcGkvbGlu
dXgvdmlydGlvX3JpbmcuaCB8IDE2ICsrKysrKysrKysrLS0tLS0KPiAgNCBmaWxlcyBjaGFuZ2Vk
LCAyNSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+
IGluZGV4IGE1ZWM3MjRjMDFkOC4uZTIwOTEzNDVjNWMyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
Cj4gQEAgLTIxNDcsNiArMjE0NywxNCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgbW9yZV91c2VkKGNv
bnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxKQo+ICAJcmV0dXJuIHZxLT5wYWNrZWRfcmlu
ZyA/IG1vcmVfdXNlZF9wYWNrZWQodnEpIDogbW9yZV91c2VkX3NwbGl0KHZxKTsKPiAgfQo+ICAK
PiArLyoqCj4gKyAqIHZyaW5nX2ludGVycnVwdCAtIG5vdGlmeSBhIHZpcnRxdWV1ZSBvbiBhbiBp
bnRlcnJ1cHQKPiArICogQGlycTogdGhlIElSUSBudW1iZXIKClRoaXMgaXMgYmVpbmcgaWdub3Jl
ZCwgaG93ZXZlci4gQXBwZW5kICIoaWdub3JlZCkiPwoKKEkgdGhpbmsgaXQgaXMgb25seSB0aGVy
ZSBzbyB0aGF0IHRoaXMgZnVuY3Rpb24gY2FuIGJlIHVzZWQgYXMgYW4KaXJxX2hhbmRsZXJfdC4p
Cgo+ICsgKiBAX3ZxOiB0aGUgc3RydWN0IHZpcnRxdWV1ZSB0byBub3RpZnkKPiArICoKPiArICog
Q2FsbHMgdGhlIGNhbGxiYWNrIGZ1bmN0aW9uIG9mIEBfdnEgdG8gcHJvY2VzcyB0aGUgdmlydHF1
ZXVlCj4gKyAqIG5vdGlmaWNhdGlvbi4KPiArICovCj4gIGlycXJldHVybl90IHZyaW5nX2ludGVy
cnVwdChpbnQgaXJxLCB2b2lkICpfdnEpCj4gIHsKPiAgCXN0cnVjdCB2cmluZ192aXJ0cXVldWUg
KnZxID0gdG9fdnZxKF92cSk7CgooLi4uKQoKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92
aXJ0aW9fY29uZmlnLmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+IGluZGV4IGI0
N2MyZTdlZDBlZS4uOTk3ODAxMDE4YWU0IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmly
dGlvX2NvbmZpZy5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiBAQCAt
MjI1LDcgKzIyNSw3IEBAIGludCB2aXJ0aW9fZmluZF92cXNfY3R4KHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2LCB1bnNpZ25lZCBudnFzLAo+ICAKPiAgLyoqCj4gICAqIHZpcnRpb19zeW5jaHJv
bml6ZV9jYnMgLSBzeW5jaHJvbml6ZSB3aXRoIHZpcnRxdWV1ZSBjYWxsYmFja3MKPiAtICogQHZk
ZXY6IHRoZSBkZXZpY2UKPiArICogQGRldjogdGhlIGRldmljZQoKQXMgeW91J3JlIHRvdWNoaW5n
IHRoaXMgYW55d2F5OiBtYXliZSBzL2RldmljZS92aXJ0aW8gZGV2aWNlLyA/Cgo+ICAgKi8KPiAg
c3RhdGljIGlubGluZQo+ICB2b2lkIHZpcnRpb19zeW5jaHJvbml6ZV9jYnMoc3RydWN0IHZpcnRp
b19kZXZpY2UgKmRldikKPiBAQCAtMjQ0LDcgKzI0NCw3IEBAIHZvaWQgdmlydGlvX3N5bmNocm9u
aXplX2NicyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KQo+ICAKPiAgLyoqCj4gICAqIHZpcnRp
b19kZXZpY2VfcmVhZHkgLSBlbmFibGUgdnEgdXNlIGluIHByb2JlIGZ1bmN0aW9uCj4gLSAqIEB2
ZGV2OiB0aGUgZGV2aWNlCj4gKyAqIEBkZXY6IHRoZSBkZXZpY2UKClNhbWUgaGVyZS4KCj4gICAq
Cj4gICAqIERyaXZlciBtdXN0IGNhbGwgdGhpcyB0byB1c2UgdnFzIGluIHRoZSBwcm9iZSBmdW5j
dGlvbi4KPiAgICoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
