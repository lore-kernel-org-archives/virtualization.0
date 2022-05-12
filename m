Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0B9C433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 10:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEC0F419D3;
	Thu, 12 May 2022 10:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1qM1Opw-dLEa; Thu, 12 May 2022 10:05:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 40A6F41737;
	Thu, 12 May 2022 10:05:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E7DCC0032;
	Thu, 12 May 2022 10:05:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53221C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 10:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C74D83EDB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 10:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E7CkEUSLj8gC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 10:05:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47B9483E4E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652349923;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZQZZr9GX6q77pDkTASbX7SqttFBcQsXJ17/Aanrbuc=;
 b=RfVsfXiVliO9iHFIVl8lcnJ4TXZpbr848mSZoizvbhHu/wSxg8PFjV1GslUayA7qiy29oH
 2dcM7uA6f4HX3Xz0W+9UEVGaEOvhArWieY1LdnbQR8RBVdeZ2k7MoJVXl8mFzd6QV3lkmh
 KAZJO54C+Jrake4ZR4z5gA/j1H6C4f8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-83Lelki5OuC4Xj43ANXsZw-1; Thu, 12 May 2022 06:05:18 -0400
X-MC-Unique: 83Lelki5OuC4Xj43ANXsZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEAC63C19033;
 Thu, 12 May 2022 10:05:17 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E0102166B26;
 Thu, 12 May 2022 10:04:53 +0000 (UTC)
Date: Thu, 12 May 2022 11:04:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v5 3/9] crypto: Introduce akcipher crypto class
Message-ID: <Ynzbwq1f+KgMO5LW@redhat.com>
References: <20220428135943.178254-1-pizhenwei@bytedance.com>
 <20220428135943.178254-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220428135943.178254-4-pizhenwei@bytedance.com>
User-Agent: Mutt/2.2.1 (2022-02-19)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Cc: helei.sig11@bytedance.com, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMDk6NTk6MzdQTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToKPiBJbnRyb2R1Y2UgbmV3IGFrY2lwaGVyIGNyeXB0byBjbGFzcyAnUUNyeXB0b0FrQ0lwaGVy
Jywgd2hpY2ggc3VwcG9ydHMKPiBiYXNpYyBhc3ltbWV0cmljIG9wZXJhdGlvbnM6IGVuY3J5cHQs
IGRlY3J5cHQsIHNpZ24gYW5kIHZlcmlmeS4KPiAKPiBTdWdnZXN0ZWQgYnkgRGFuaWVsIFAuIEJl
cnJhbmfDqSwgYWxzbyBhZGQgYXV0b3B0ciBjbGVhbnVwIGZvciB0aGUgbmV3Cj4gY2xhc3MuIFRo
YW5rcyB0byBEYW5pZWwhCj4gCj4gQ28tZGV2ZWxvcGVkLWJ5OiBsZWkgaGUgPGhlbGVpLnNpZzEx
QGJ5dGVkYW5jZS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogbGVpIGhlIDxoZWxlaS5zaWcxMUBieXRl
ZGFuY2UuY29tPgo+IFNpZ25lZC1vZmYtYnk6IHpoZW53ZWkgcGkgPHBpemhlbndlaUBieXRlZGFu
Y2UuY29tPgo+IC0tLQo+ICBjcnlwdG8vYWtjaXBoZXIuYyAgICAgICAgIHwgMTAyICsrKysrKysr
KysrKysrKysrKysrKysrKwo+ICBjcnlwdG8vYWtjaXBoZXJwcml2LmggICAgIHwgIDU1ICsrKysr
KysrKysrKysKPiAgY3J5cHRvL21lc29uLmJ1aWxkICAgICAgICB8ICAgMSArCj4gIGluY2x1ZGUv
Y3J5cHRvL2FrY2lwaGVyLmggfCAxNTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKPiAgNCBmaWxlcyBjaGFuZ2VkLCAzMTYgaW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgY3J5cHRvL2FrY2lwaGVyLmMKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGNyeXB0by9h
a2NpcGhlcnByaXYuaAo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9jcnlwdG8vYWtjaXBo
ZXIuaAoKUmV2aWV3ZWQtYnk6IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5j
b20+CgoKV2l0aCByZWdhcmRzLApEYW5pZWwKLS0gCnw6IGh0dHBzOi8vYmVycmFuZ2UuY29tICAg
ICAgLW8tICAgIGh0dHBzOi8vd3d3LmZsaWNrci5jb20vcGhvdG9zL2RiZXJyYW5nZSA6fAp8OiBo
dHRwczovL2xpYnZpcnQub3JnICAgICAgICAgLW8tICAgICAgICAgICAgaHR0cHM6Ly9mc3RvcDEz
OC5iZXJyYW5nZS5jb20gOnwKfDogaHR0cHM6Ly9lbnRhbmdsZS1waG90by5vcmcgICAgLW8tICAg
IGh0dHBzOi8vd3d3Lmluc3RhZ3JhbS5jb20vZGJlcnJhbmdlIDp8CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
