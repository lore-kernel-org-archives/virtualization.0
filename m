Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FEEC433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 09:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 421D360F39;
	Thu, 12 May 2022 09:39:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GbpvNLZu7E0H; Thu, 12 May 2022 09:39:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CF2D96063B;
	Thu, 12 May 2022 09:39:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A33FBC0039;
	Thu, 12 May 2022 09:39:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47E02C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 09:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 359FE41980
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 09:39:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nk8Jze_0ltPp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 09:39:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1E2B41913
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652348347;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLKLgA7d5d1qjLjAxbAiC2y0ZsRTe2UXXmSPURXjo2c=;
 b=C1UmPh1XKfKhuOy4UgMk3erHP5EaBMX69mmjjVhupK2kxtLEuD+peBzR6cHcEm547H+mxZ
 zA5lEuglsCj20d4xc2EwpvM64nHV1z5N5gR0sDdu7UVbHFAe4cuLFLhJ+nq3SQ+XkmF7e/
 MZtCFgl+m1TNNSYWqz6BLXGYEl05lHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-XsdZg6wLObCxVseVbxSDLQ-1; Thu, 12 May 2022 05:39:04 -0400
X-MC-Unique: XsdZg6wLObCxVseVbxSDLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB30585A5BE;
 Thu, 12 May 2022 09:39:03 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B1E34010A13;
 Thu, 12 May 2022 09:39:00 +0000 (UTC)
Date: Thu, 12 May 2022 10:38:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v5 7/9] test/crypto: Add test suite for crypto akcipher
Message-ID: <YnzVsRW9DiyhbuIm@redhat.com>
References: <20220428135943.178254-1-pizhenwei@bytedance.com>
 <20220428135943.178254-8-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220428135943.178254-8-pizhenwei@bytedance.com>
User-Agent: Mutt/2.2.1 (2022-02-19)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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

T24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMDk6NTk6NDFQTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToKPiBGcm9tOiBMZWkgSGUgPGhlbGVpLnNpZzExQGJ5dGVkYW5jZS5jb20+Cj4gCj4gQWRkIHVu
aXQgdGVzdCBhbmQgYmVuY2htYXJrIHRlc3QgZm9yIGNyeXB0byBha2NpcGhlci4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBsZWkgaGUgPGhlbGVpLnNpZzExQGJ5dGVkYW5jZS5jb20+Cj4gU2lnbmVkLW9m
Zi1ieTogemhlbndlaSBwaSA8cGl6aGVud2VpQGJ5dGVkYW5jZS5jb20+Cj4gUmV2aWV3ZWQtYnk6
IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+Cj4gLS0tCj4gIHRlc3Rz
L2JlbmNoL2JlbmNobWFyay1jcnlwdG8tYWtjaXBoZXIuYyB8IDE1NyArKysrKysKPiAgdGVzdHMv
YmVuY2gvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgIHwgICA0ICsKPiAgdGVzdHMvYmVuY2gv
dGVzdF9ha2NpcGhlcl9rZXlzLmluYyAgICAgIHwgNTM3ICsrKysrKysrKysrKysrKysrKwo+ICB0
ZXN0cy91bml0L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ICB0ZXN0cy91
bml0L3Rlc3QtY3J5cHRvLWFrY2lwaGVyLmMgICAgICAgfCA3MTEgKysrKysrKysrKysrKysrKysr
KysrKysrCj4gIDUgZmlsZXMgY2hhbmdlZCwgMTQxMCBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0cy9iZW5jaC9iZW5jaG1hcmstY3J5cHRvLWFrY2lwaGVyLmMKPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RzL2JlbmNoL3Rlc3RfYWtjaXBoZXJfa2V5cy5pbmMKPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3VuaXQvdGVzdC1jcnlwdG8tYWtjaXBoZXIuYwoKCj4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL2JlbmNoL21lc29uLmJ1aWxkIGIvdGVzdHMvYmVuY2gvbWVzb24uYnVp
bGQKPiBpbmRleCAwMGIzYzIwOWRjLi5mNzkzZDk3MmI2IDEwMDY0NAo+IC0tLSBhL3Rlc3RzL2Jl
bmNoL21lc29uLmJ1aWxkCj4gKysrIGIvdGVzdHMvYmVuY2gvbWVzb24uYnVpbGQKPiBAQCAtMjMs
NiArMjMsMTAgQEAgaWYgaGF2ZV9ibG9jawo+ICAgIH0KPiAgZW5kaWYKPiAgCj4gK2JlbmNocyAr
PSB7Cj4gKyAgICAnYmVuY2htYXJrLWNyeXB0by1ha2NpcGhlcic6IFtjcnlwdG9dLAo+ICt9CgpU
aGlzIG5lZWRzIHRvIG1vdmVkIGFib3ZlIGEgYml0IHRvIGJlIGluY2x1ZGUgdGhlICdpZiBoYXZl
X2Jsb2NrJwpzZWN0aW9uIGFib3ZlLCBvdGhlcndpc2UgaXQgYnJlYWtzIHRoZSBidWlsZCB3aGVu
IHVzaW5nIC0tZGlzYWJsZS1zeXN0ZW0KCgpXaXRoIHJlZ2FyZHMsCkRhbmllbAotLSAKfDogaHR0
cHM6Ly9iZXJyYW5nZS5jb20gICAgICAtby0gICAgaHR0cHM6Ly93d3cuZmxpY2tyLmNvbS9waG90
b3MvZGJlcnJhbmdlIDp8Cnw6IGh0dHBzOi8vbGlidmlydC5vcmcgICAgICAgICAtby0gICAgICAg
ICAgICBodHRwczovL2ZzdG9wMTM4LmJlcnJhbmdlLmNvbSA6fAp8OiBodHRwczovL2VudGFuZ2xl
LXBob3RvLm9yZyAgICAtby0gICAgaHR0cHM6Ly93d3cuaW5zdGFncmFtLmNvbS9kYmVycmFuZ2Ug
OnwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
