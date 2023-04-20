Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2037C77B72
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 09:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E08B84190;
	Thu, 20 Apr 2023 09:17:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E08B84190
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jg8ldA4b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lB9aFl2g1qJC; Thu, 20 Apr 2023 09:17:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 095B283EC2;
	Thu, 20 Apr 2023 09:17:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 095B283EC2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D23C4C0036;
	Thu, 20 Apr 2023 09:17:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E9F1C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 09:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3128342715
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 09:17:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3128342715
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=jg8ldA4b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4oYQ4VTniale
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 09:17:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D6DA40965
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D6DA40965
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 09:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1681982239; x=1713518239;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=0USKz9BxYKjlUDhRhk7pWrbGaUowBGgrtqOljgJPAgo=;
 b=jg8ldA4bfafXo3RznrwqddGOPXoSoGVzl5lmCUi2tRtYTpKR7COhc6Ix
 qsODVcoyFccAX97eXGHL0ZvGQadFSkrwSHsKv8djNso0kGVijJVOx0lwv
 jUOoq91wXMXWqjsYsf4uqiRmAIiH6sJT5rmP3p87x+rav1b/0AWGkzA+u
 V9lGkDXODCa0qpk512fVgx4JEgiMdu3JhRKlggXNJy4Pn/QfvYBxBvnF+
 ypFoG60hwfg3ntDdDKDJ0R9gm02sMxqkKPUYD5e3SWGI+QWtbMA8lIwLX
 jng1e8s2GBHxnJ4fXFG4FvtSKdj9ymR7CjI/OYADm0me0EGpYuWTIoOyF Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="431960450"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; d="scan'208";a="431960450"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2023 02:17:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="722304056"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; d="scan'208";a="722304056"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.254.215.23])
 ([10.254.215.23])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2023 02:17:18 -0700
Message-ID: <c939205a-adc3-75eb-de16-617d6d001e18@intel.com>
Date: Thu, 20 Apr 2023 17:17:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 0/5] vDPA/ifcvf: implement immediate initialization
 mechanism
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <CACGkMEstNJ1TJtTApniJLyN872gF9ZpAbj3hEKUw6yX3ZpPiFg@mail.gmail.com>
 <cf384aed-7ac4-02af-c2b5-b66c03a86aa9@intel.com>
In-Reply-To: <cf384aed-7ac4-02af-c2b5-b66c03a86aa9@intel.com>
Cc: virtualization@lists.linux-foundation.org
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

CgpPbiA0LzMvMjAyMyA2OjEwIFBNLCBaaHUsIExpbmdzaGFuIHdyb3RlOgo+Cj4KPiBPbiA0LzMv
MjAyMyAxOjI4IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBPbiBGcmksIE1hciAzMSwgMjAyMyBh
dCA4OjQ54oCvUE0gWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPiAKPj4gd3Jv
dGU6Cj4+PiBGb3JtZXJseSwgaWZjdmYgZHJpdmVyIGhhcyBpbXBsZW1lbnRlZCBhIGxhenktaW5p
dGlhbGl6YXRpb24gbWVjaGFuaXNtCj4+PiBmb3IgdGhlIHZpcnRxdWV1ZXMgYW5kIG90aGVyIGNv
bmZpZyBzcGFjZSBjb250ZW50cywKPj4+IGl0IHdvdWxkIHN0b3JlIGFsbCBjb25maWd1cmF0aW9u
cyB0aGF0IHBhc3NlZCBkb3duIGZyb20gdGhlIHVzZXJzcGFjZSwKPj4+IHRoZW4gbG9hZCB0aGVt
IHRvIHRoZSBkZXZpY2UgY29uZmlnIHNwYWNlIHVwb24gRFJJVkVSX09LLgo+Pj4KPj4+IFRoaXMg
Y2FuIG5vdCBzZXJ2ZSBsaXZlIG1pZ3JhdGlvbiwgc28gdGhpcyBzZXJpZXMgaW1wbGVtZW50IGFu
Cj4+PiBpbW1lZGlhdGUgaW5pdGlhbGl6YXRpb24gbWVjaGFuaXNtLCB3aGljaCBtZWFucyByYXRo
ZXIgdGhhbiB0aGUKPj4+IGZvcm1lciBzdG9yZS1sb2FkIHByb2Nlc3MsIHRoZSB2aXJ0aW8gb3Bl
cmF0aW9ucyBsaWtlIHZxIG9wcwo+Pj4gd291bGQgdGFrZSBpbW1lZGlhdGUgYWN0aW9ucyBieSBh
Y2Nlc3MgdGhlIHZpcnRpbyByZWdpc3RlcnMuCj4+IElzIHRoZXJlIGFueSBjaGFuY2UgdGhhdCBp
ZmN2ZiBjYW4gdXNlIHZpcnRpb19wY2lfbW9kZXJuX2RldiBsaWJyYXJ5Pwo+Pgo+PiBUaGVuIHdl
IGRvbid0IG5lZWQgdG8gZHVwbGljYXRlIHRoZSBjb2Rlcy4KPj4KPj4gTm90ZSB0aGF0IHBkc192
ZHBhIHdpbGwgYmUgdGhlIHNlY29uZCB1c2VyIGZvciB2aXJ0aW9fcGNpX21vZGVybl9kZXYKPj4g
bGlicmFyeSAoYW5kIHRoZSBmaXJzdCB2RFBBIHBhcmVudCB0byB1c2UgdGhhdCBsaWJyYXJ5KS4K
PiBZZXMgSSBhZ3JlZSB0aGlzIGxpYnJhcnkgY2FuIGhlbHAgYSBsb3QgZm9yIGEgc3RhbmRhcmQg
dmlydGlvIHBjaSBkZXZpY2UuCj4gQnV0IHRoaXMgY2hhbmdlIHdvdWxkIGJlIGh1Z2UsIGl0cyBs
aWtlIHJlcXVpcmUgdG8gY2hhbmdlIGV2ZXJ5IGxpbmUgb2YKPiB0aGUgZHJpdmVyLiBGb3IgZXhh
bXBsZSBjdXJyZW50IGRyaXZlciBmdW5jdGlvbnMgd29yayBvbiB0aGUgYWRhcHRlciBhbmQKPiBp
ZmN2Zl9odywgaWYgd2Ugd2FudHMgdG8gcmV1c2UgdGhlIGxpYiwgd2UgbmVlZCB0aGUgZHJpdmVy
IHdvcmsgb24gCj4gc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZS4KPiBBbG1vc3QgbmVl
ZCB0byByZS13cml0ZSB0aGUgZHJpdmVyLgo+Cj4gQ2FuIHdlIHBsYW4gdGhpcyBodWdlIGNoYW5n
ZSBpbiBmb2xsb3dpbmcgc2VyaWVzPwpwaW5nCj4KPiBUaGFua3MsCj4gWmh1IExpbmdzaGFuCj4+
Cj4+IFRoYW5rcwo+Pgo+Pj4gVGhpcyBzZXJpZXMgYWxzbyBpbXBsZW1lbnQgaXJxIHN5bmNocm9u
aXphdGlvbiBpbiB0aGUgcmVzZXQKPj4+IHJvdXRpbmUKPj4+Cj4+PiBaaHUgTGluZ3NoYW4gKDUp
Ogo+Pj4gwqDCoCB2aXJ0IHF1ZXVlIG9wcyB0YWtlIGltbWVkaWF0ZSBhY3Rpb25zCj4+PiDCoMKg
IGdldF9kcml2ZXJfZmVhdHVyZXMgZnJvbSB2aXJpdG8gcmVnaXN0ZXJzCj4+PiDCoMKgIHJldGly
ZSBpZmN2Zl9zdGFydF9kYXRhcGF0aCBhbmQgaWZjdmZfYWRkX3N0YXR1cwo+Pj4gwqDCoCBzeW5j
aHJvbml6ZSBpcnFzIGluIHRoZSByZXNldCByb3V0aW5lCj4+PiDCoMKgIGEgdmVuZG9yIGRyaXZl
ciBzaG91bGQgbm90IHNldCBfQ09ORklHX1NfRkFJTEVECj4+Pgo+Pj4gwqAgZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8IDE2MiAKPj4+ICsrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tCj4+PiDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHzCoCAxNiArKy0t
Cj4+PiDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHzCoCA5NyArKysrLS0tLS0t
LS0tLS0tLS0tCj4+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDEyMiBpbnNlcnRpb25zKCspLCAxNTMg
ZGVsZXRpb25zKC0pCj4+Pgo+Pj4gLS0gCj4+PiAyLjM5LjEKPj4+Cj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
