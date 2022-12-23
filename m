Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8248C3DA6E
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 05:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20D2840154;
	Fri, 23 Dec 2022 05:56:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20D2840154
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CClDrvdI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bYoZkp0DFcg1; Fri, 23 Dec 2022 05:56:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9D2764023B;
	Fri, 23 Dec 2022 05:56:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D2764023B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3619C007E;
	Fri, 23 Dec 2022 05:56:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24630C0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E656A40201
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E656A40201
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3EuFrD9RQ2TN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 492D740193
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 492D740193
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671774958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xglbcwBtHUzE7Svvg1D0riaViqFayLrBuEpuMnhx0Os=;
 b=CClDrvdIV+YmT7lsEXlmAEjMUz6HZnJgQthxt20ZvwoHKN3vqZowhZfiXQfDRCCGjAvFg1
 b5bM4gDP+Xnmn8TLDT8MQq3xFyEel/Uaec6Vq9TSWRg/xEhvqgnrJX8rnJF75Oidg2HN+u
 6Q036eRMtFrmukHSUgpBv9/PbHsLZ4A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-9wZ9O01HPuOwAkPNvArVfw-1; Fri, 23 Dec 2022 00:55:57 -0500
X-MC-Unique: 9wZ9O01HPuOwAkPNvArVfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2C1518811F4;
 Fri, 23 Dec 2022 05:55:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-204.pek2.redhat.com
 [10.72.12.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30D0D40C2064;
 Fri, 23 Dec 2022 05:55:53 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V3 1/4] vdpa_sim: switch to use __vdpa_alloc_device()
Date: Fri, 23 Dec 2022 13:55:45 +0800
Message-Id: <20221223055548.27810-2-jasowang@redhat.com>
In-Reply-To: <20221223055548.27810-1-jasowang@redhat.com>
References: <20221223055548.27810-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

VGhpcyBhbGxvd3MgdXMgdG8gY29udHJvbCB0aGUgYWxsb2NhdGlvbiBzaXplIG9mIHRoZSBzdHJ1
Y3R1cmUuCgpSZXZpZXdlZC1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQu
Y29tPgpBY2tlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy92
ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgfCAxMyArKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
LmMKaW5kZXggY2I4ODg5MWI0NGE4Li4xMThkYmM4ZTVkNjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
dmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCisrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbS5jCkBAIC0yNDksNiArMjQ5LDcgQEAgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW1fY3JlYXRl
KHN0cnVjdCB2ZHBhc2ltX2Rldl9hdHRyICpkZXZfYXR0ciwKIAkJCSAgICAgICBjb25zdCBzdHJ1
Y3QgdmRwYV9kZXZfc2V0X2NvbmZpZyAqY29uZmlnKQogewogCWNvbnN0IHN0cnVjdCB2ZHBhX2Nv
bmZpZ19vcHMgKm9wczsKKwlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGE7CiAJc3RydWN0IHZkcGFz
aW0gKnZkcGFzaW07CiAJc3RydWN0IGRldmljZSAqZGV2OwogCWludCBpLCByZXQgPSAtRU5PTUVN
OwpAQCAtMjY2LDE0ICsyNjcsMTYgQEAgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW1fY3JlYXRlKHN0
cnVjdCB2ZHBhc2ltX2Rldl9hdHRyICpkZXZfYXR0ciwKIAllbHNlCiAJCW9wcyA9ICZ2ZHBhc2lt
X2NvbmZpZ19vcHM7CiAKLQl2ZHBhc2ltID0gdmRwYV9hbGxvY19kZXZpY2Uoc3RydWN0IHZkcGFz
aW0sIHZkcGEsIE5VTEwsIG9wcywKLQkJCQkgICAgZGV2X2F0dHItPm5ncm91cHMsIGRldl9hdHRy
LT5uYXMsCi0JCQkJICAgIGRldl9hdHRyLT5uYW1lLCBmYWxzZSk7Ci0JaWYgKElTX0VSUih2ZHBh
c2ltKSkgewotCQlyZXQgPSBQVFJfRVJSKHZkcGFzaW0pOworCXZkcGEgPSBfX3ZkcGFfYWxsb2Nf
ZGV2aWNlKE5VTEwsIG9wcywKKwkJCQkgICBkZXZfYXR0ci0+bmdyb3VwcywgZGV2X2F0dHItPm5h
cywKKwkJCQkgICBzaXplb2Yoc3RydWN0IHZkcGFzaW0pLAorCQkJCSAgIGRldl9hdHRyLT5uYW1l
LCBmYWxzZSk7CisJaWYgKElTX0VSUih2ZHBhKSkgeworCQlyZXQgPSBQVFJfRVJSKHZkcGEpOwog
CQlnb3RvIGVycl9hbGxvYzsKIAl9CiAKKwl2ZHBhc2ltID0gdmRwYV90b19zaW0odmRwYSk7CiAJ
dmRwYXNpbS0+ZGV2X2F0dHIgPSAqZGV2X2F0dHI7CiAJSU5JVF9XT1JLKCZ2ZHBhc2ltLT53b3Jr
LCBkZXZfYXR0ci0+d29ya19mbik7CiAJc3Bpbl9sb2NrX2luaXQoJnZkcGFzaW0tPmxvY2spOwot
LSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
