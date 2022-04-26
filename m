Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09220C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 11:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A731F60B74;
	Tue, 26 Apr 2022 11:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ftYxWpM5cz9N; Tue, 26 Apr 2022 11:57:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3508A60FC4;
	Tue, 26 Apr 2022 11:57:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04E8DC0039;
	Tue, 26 Apr 2022 11:57:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C7DCC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 11:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1697341824
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 11:57:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GjiXMNjU3nxX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 11:57:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFD9B41821
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 11:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650974235;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FtGBciEbW3HrGbgfdt44SW/MAlLfJ/KV2/2Bj92AK+4=;
 b=aphI9mVPUMPPVScc0xQp4cwEy87ZxBR3A7T2KwxJ1/sPlTPU7+d5IBwe/S2x+FgXTGITBu
 NyDfiTD1TSf6R3lt3gPReDyBX600ZPY6kTqMIIhPjPipqKqWqGjLGLZwx8X+Udmwt8A64a
 C6QT6/ex2fujyEczKavOYPr1jzMexbs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-GDLsOS10NyK7qFRCVICpZg-1; Tue, 26 Apr 2022 07:57:11 -0400
X-MC-Unique: GDLsOS10NyK7qFRCVICpZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FF5C83395E;
 Tue, 26 Apr 2022 11:57:11 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E9440F9D40;
 Tue, 26 Apr 2022 11:57:08 +0000 (UTC)
Date: Tue, 26 Apr 2022 12:57:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v4 7/8] tests/crypto: Add test suite for crypto akcipher
Message-ID: <YmfeEaQHupPLBteU@redhat.com>
References: <20220411104327.197048-1-pizhenwei@bytedance.com>
 <20220411104327.197048-8-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220411104327.197048-8-pizhenwei@bytedance.com>
User-Agent: Mutt/2.1.5 (2021-12-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
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

T24gTW9uLCBBcHIgMTEsIDIwMjIgYXQgMDY6NDM6MjZQTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToKPiBGcm9tOiBsZWkgaGUgPGhlbGVpLnNpZzExQGJ5dGVkYW5jZS5jb20+Cj4gCj4gQWRkIHVu
aXQgdGVzdCBhbmQgYmVuY2htYXJrIHRlc3QgZm9yIGNyeXB0byBha2NpcGhlci4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBsZWkgaGUgPGhlbGVpLnNpZzExQGJ5dGVkYW5jZS5jb20+Cj4gU2lnbmVkLW9m
Zi1ieTogemhlbndlaSBwaSA8cGl6aGVud2VpQGJ5dGVkYW5jZS5jb20+Cj4gLS0tCj4gIHRlc3Rz
L2JlbmNoL2JlbmNobWFyay1jcnlwdG8tYWtjaXBoZXIuYyB8IDE2MSArKysrKysKPiAgdGVzdHMv
YmVuY2gvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgIHwgICA0ICsKPiAgdGVzdHMvYmVuY2gv
dGVzdF9ha2NpcGhlcl9rZXlzLmluYyAgICAgIHwgNTM3ICsrKysrKysrKysrKysrKysrKwo+ICB0
ZXN0cy91bml0L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ICB0ZXN0cy91
bml0L3Rlc3QtY3J5cHRvLWFrY2lwaGVyLmMgICAgICAgfCA3MDggKysrKysrKysrKysrKysrKysr
KysrKysrCj4gIDUgZmlsZXMgY2hhbmdlZCwgMTQxMSBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0cy9iZW5jaC9iZW5jaG1hcmstY3J5cHRvLWFrY2lwaGVyLmMKPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RzL2JlbmNoL3Rlc3RfYWtjaXBoZXJfa2V5cy5pbmMKPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3VuaXQvdGVzdC1jcnlwdG8tYWtjaXBoZXIuYwo+IAoKPiBk
aWZmIC0tZ2l0IGEvdGVzdHMvYmVuY2gvdGVzdF9ha2NpcGhlcl9rZXlzLmluYyBiL3Rlc3RzL2Jl
bmNoL3Rlc3RfYWtjaXBoZXJfa2V5cy5pbmMKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4
IDAwMDAwMDAwMDAuLjdhZGYyMTgxMzUKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvdGVzdHMvYmVu
Y2gvdGVzdF9ha2NpcGhlcl9rZXlzLmluYwo+IEBAIC0wLDAgKzEsNTM3IEBACj4gKy8qCj4gKyAq
IENvcHlyaWdodCAoYykgMjAyMiBCeXRlZGFuY2UsIGFuZC9vciBpdHMgYWZmaWxpYXRlcwo+ICsg
Kgo+ICsgKiBUaGlzIHdvcmsgaXMgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
R1BMLCB2ZXJzaW9uIDIgb3IgbGF0ZXIuCj4gKyAqIFNlZSB0aGUgQ09QWUlORyBmaWxlIGluIHRo
ZSB0b3AtbGV2ZWwgZGlyZWN0b3J5Lgo+ICsgKgo+ICsgKiBBdXRob3I6IGxlaSBoZSA8aGVsZWku
c2lnMTFAYnl0ZWRhbmNlLmNvbT4KPiArICovCj4gKwo+ICsvKiBSU0EgdGVzdCBrZXlzLCBnZW5l
cmF0ZWQgYnkgT3BlblNTTCAqLwo+ICtzdGF0aWMgY29uc3QgdWludDhfdCByc2ExMDI0X3ByaXZf
a2V5W10gPSB7Cj4gKyAgICAweDMwLCAweDgyLCAweDAyLCAweDVjLCAweDAyLCAweDAxLCAweDAw
LCAweDAyLAo+ICsJMHg4MSwgMHg4MSwgMHgwMCwgMHhlNiwgMHg0ZCwgMHg3NiwgMHg0ZiwgMHhi
MiwKCnNuaXAKCkZvciB0aGUgcGF0Y2ggYXMgaXM6CgogUmV2aWV3ZWQtYnk6IERhbmllbCBQLiBC
ZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+CgoKSXQgY291bGQgYmUgbmljZSB0byBhZGQg
YW5vdGhlciB0ZXN0IHdpdGggc29tZSBpbnRlbnRpb25hbGx5IGNvcnJ1cHQKUlNBIGtleXMgd2l0
aCBiYWQgREVSIGVuY29kaW5nLCBhcyBhIHdheSB0byBwcm92ZSB0aGF0IHdlJ3JlIGhhbmRsaW5n
CmVycm9ycyBpbiBERVIgZGVjb2RpbmcgY29ycmVjdGx5IHdoZW4gZmFjZWQgd2l0aCBtYWxpY291
cyBkYXRhIGZyb20gYQpiYWQgZ3Vlc3QuCgpXaXRoIHJlZ2FyZHMsCkRhbmllbAotLSAKfDogaHR0
cHM6Ly9iZXJyYW5nZS5jb20gICAgICAtby0gICAgaHR0cHM6Ly93d3cuZmxpY2tyLmNvbS9waG90
b3MvZGJlcnJhbmdlIDp8Cnw6IGh0dHBzOi8vbGlidmlydC5vcmcgICAgICAgICAtby0gICAgICAg
ICAgICBodHRwczovL2ZzdG9wMTM4LmJlcnJhbmdlLmNvbSA6fAp8OiBodHRwczovL2VudGFuZ2xl
LXBob3RvLm9yZyAgICAtby0gICAgaHR0cHM6Ly93d3cuaW5zdGFncmFtLmNvbS9kYmVycmFuZ2Ug
OnwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
