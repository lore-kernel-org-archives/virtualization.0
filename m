Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D02C47092
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 01:56:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93881613DC
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 01:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93881613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A2B7404CF;
	Thu,  3 Jun 2021 01:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aYWfZ9R_Vj89; Thu,  3 Jun 2021 01:56:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id EAB4E400B9;
	Thu,  3 Jun 2021 01:56:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2203C000D;
	Thu,  3 Jun 2021 01:56:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D41FC0001;
 Thu,  3 Jun 2021 01:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57F29608A1;
 Thu,  3 Jun 2021 01:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nGtd2ky1FTCa; Thu,  3 Jun 2021 01:56:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE34260692;
 Thu,  3 Jun 2021 01:56:34 +0000 (UTC)
IronPort-SDR: UdFsKqfpgZfim5oXUtmO+BE+bC9mrAyHOkdhXV0OKpOBJNaqhJ0ZzwTBzNiF6EPh+e8yHDLaac
 k4fhB8yNZBMA==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="183622526"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="183622526"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 18:56:33 -0700
IronPort-SDR: C5MKCIFgSivqj4s0xMPWU5bJ61YOvmOkiOYqHbOXSTq5KqhrzVWVu5om4euFeO0TYD42KUMP+C
 3oyspki/GTFg==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="550518879"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.87.193])
 ([10.209.87.193])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 18:56:28 -0700
Subject: Re: Virtio hardening for TDX
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <63d01084-68d2-a8d5-931d-541a22b5f231@redhat.com>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <33504152-624a-45cc-51b3-10ce7aa2428f@linux.intel.com>
Date: Wed, 2 Jun 2021 18:56:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <63d01084-68d2-a8d5-931d-541a22b5f231@redhat.com>
Content-Language: en-US
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, jpoimboe@redhat.com, robin.murphy@arm.com,
 hch@lst.de, m.szyprowski@samsung.com
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

Cj4gTm90ZSB0aGF0IGl0J3MgcHJvYmFibHkgbmVlZGVkIGJ5IG90aGVyIGNhc2VzIGFzIHdlbGw6
Cj4KPiAxKSBPdGhlciBlbmNyeXB0ZWQgVk0gdGVjaG5vbG9neQo+IDIpIFZEVVNFWzFdCj4gMykg
U21hcnQgTklDcwoKUmlnaHQuIEkgZG9uJ3Qgc2VlIGFueSByZWFzb24gd2h5IHRoZXNlIHNob3Vs
ZG4ndCB3b3JrLiBZb3UgbWF5IGp1c3QgCm5lZWQgdG8gYWRkIHRoZSBlbmFibGUgZm9yIHRoZSBs
b2NrZG93biwgYnV0IHlvdSBjYW4gcmV1c2UgdGhlIGJhc2ljIAppbmZyYXN0cnVjdHVyZS4KCj4K
PiBXZSBoYXZlIGFscmVhZHkgaGFkIGRpc2N1c3Npb25zIGFuZCBzb21lIHBhdGNoZXMgaGF2ZSBi
ZWVuIAo+IHBvc3RlZFsyXVszXVs0XS4KClRoYW5rcy4KClllcyBbMl0gaXMgaW5kZWVkIGFuIGFs
dGVybmF0aXZlLiBXZSBjb25zaWRlcmVkIHRoaXMgYXQgc29tZSBwb2ludCwgYnV0IApzaW5jZSB3
ZSBkb24ndCBjYXJlIGFib3V0IERPUyBpbiBvdXIgY2FzZSBpdCBzZWVtZWQgc2ltcGxlciB0byBq
dXN0IApoYXJkZW4gdGhlIGV4aXN0aW5nIGNvZGUuwqAgQnV0IHllcyBpZiBpdCdzIHRoZXJlIGl0
J3MgdXNlZnVsIGZvciBURFggdG9vLgoKRldJVyBJIHdvdWxkIGFyZ3VlIHRoYXQgdGhlIGRlc2Ny
aXB0b3IgYm91bmRhcnkgY2hlY2tpbmcgc2hvdWxkIGJlIGFkZGVkIAppbiBhbnkgY2FzZSwgc2Vj
dXJpdHkgY2FzZSBvciBzZXBhcmF0ZWQgbWV0YWRhdGEgb3Igbm90LCBiZWNhdXNlIGl0IGNhbiAK
Y2F0Y2ggYnVncyBhbmQgaXMgdmVyeSBjaGVhcC4gQ2hlY2tpbmcgYm91bmRhcmllcyBpcyBnb29k
IHByYWN0aWNlLgoKWzRdIHdvdWxkIGJlIGFuIGluZGVwZW5kZW50IGlzc3VlLCB0aGF0J3Mgc29t
ZXRoaW5nIHdlIGRpZG4ndCBjYXRjaC4KCkFsc28gdGhlIHN3aW90bGIgaGFyZGVuaW5nIGltcGxl
bWVudGVkIGluIHRoaXMgcGF0Y2hraXQgZG9lc24ndCBzZWVtIHRvIApiZSBpbiBhbnkgb2YgdGhl
IG90aGVyIHBhdGNoZXMuCgpTbyBJIHdvdWxkIHNheSBteSBwYXRjaGVzIGFyZSBtb3N0bHkgb3J0
aG9nb25hbCB0byB0aGVzZSBwYXRjaGVzIGJlbG93IAphbmQgbm90IGNvbmZsaWN0aW5nLCBldmVu
IHRob3VnaCB0aGV5IGFkZHJlc3MgYSBzaW1pbGFyIHByb2JsZW0gc3BhY2UuCgotQW5kaQoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
