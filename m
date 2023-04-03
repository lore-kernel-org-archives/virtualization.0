Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87856C76196
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 10:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCBD181E77;
	Mon,  3 Apr 2023 10:10:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCBD181E77
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UKFKtvf7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Yst7YoCq2fV; Mon,  3 Apr 2023 10:10:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4313481E58;
	Mon,  3 Apr 2023 10:10:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4313481E58
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2402BC0036;
	Mon,  3 Apr 2023 10:10:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46BEBC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 10:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F67D4094F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 10:10:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F67D4094F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UKFKtvf7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17P3vuZqX8eW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 10:10:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 270CF40949
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 270CF40949
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680516640; x=1712052640;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=biJSCKpJcByAmhxMD8Wu8Zc2TlAZ11zSKqKSG2rL0zw=;
 b=UKFKtvf7oM29xeLSRd/y7Hy83KFIOlybfOY3cpamPJwCuexrM5/Lr/7f
 QlrR10USq3Gkxd5T8u8bk8XHwnUptL10hUbdYtQcWjJOiwUDsfT0zLHBN
 Y7tbYZZ3nTWeRrDYZdlqBpiImDj/Nhvqwfoz+pZZBISkc+B/H3S7Bj6k9
 /3l842knAD624wt/TSTMKYXmkXQBTYXHTV/iAwh5kUR0BcF5MamQR/spd
 3wNcHQuWeUmkPlZ5Lrirlm7+c8nBbEE06XBMSpkZTiowlutKPJJJTi7fP
 aSSeDvY2rC+BWMQEUtccxM2hV++N1j0+4Qqk1cAk24jqR9bnGr/ROZRGu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="322253237"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; d="scan'208";a="322253237"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2023 03:10:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="829507424"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; d="scan'208";a="829507424"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.255.28.123])
 ([10.255.28.123])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2023 03:10:38 -0700
Message-ID: <cf384aed-7ac4-02af-c2b5-b66c03a86aa9@intel.com>
Date: Mon, 3 Apr 2023 18:10:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH 0/5] vDPA/ifcvf: implement immediate initialization
 mechanism
To: Jason Wang <jasowang@redhat.com>
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <CACGkMEstNJ1TJtTApniJLyN872gF9ZpAbj3hEKUw6yX3ZpPiFg@mail.gmail.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEstNJ1TJtTApniJLyN872gF9ZpAbj3hEKUw6yX3ZpPiFg@mail.gmail.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

CgpPbiA0LzMvMjAyMyAxOjI4IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIEZyaSwgTWFyIDMx
LCAyMDIzIGF0IDg6NDnigK9QTSBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+
IHdyb3RlOgo+PiBGb3JtZXJseSwgaWZjdmYgZHJpdmVyIGhhcyBpbXBsZW1lbnRlZCBhIGxhenkt
aW5pdGlhbGl6YXRpb24gbWVjaGFuaXNtCj4+IGZvciB0aGUgdmlydHF1ZXVlcyBhbmQgb3RoZXIg
Y29uZmlnIHNwYWNlIGNvbnRlbnRzLAo+PiBpdCB3b3VsZCBzdG9yZSBhbGwgY29uZmlndXJhdGlv
bnMgdGhhdCBwYXNzZWQgZG93biBmcm9tIHRoZSB1c2Vyc3BhY2UsCj4+IHRoZW4gbG9hZCB0aGVt
IHRvIHRoZSBkZXZpY2UgY29uZmlnIHNwYWNlIHVwb24gRFJJVkVSX09LLgo+Pgo+PiBUaGlzIGNh
biBub3Qgc2VydmUgbGl2ZSBtaWdyYXRpb24sIHNvIHRoaXMgc2VyaWVzIGltcGxlbWVudCBhbgo+
PiBpbW1lZGlhdGUgaW5pdGlhbGl6YXRpb24gbWVjaGFuaXNtLCB3aGljaCBtZWFucyByYXRoZXIg
dGhhbiB0aGUKPj4gZm9ybWVyIHN0b3JlLWxvYWQgcHJvY2VzcywgdGhlIHZpcnRpbyBvcGVyYXRp
b25zIGxpa2UgdnEgb3BzCj4+IHdvdWxkIHRha2UgaW1tZWRpYXRlIGFjdGlvbnMgYnkgYWNjZXNz
IHRoZSB2aXJ0aW8gcmVnaXN0ZXJzLgo+IElzIHRoZXJlIGFueSBjaGFuY2UgdGhhdCBpZmN2ZiBj
YW4gdXNlIHZpcnRpb19wY2lfbW9kZXJuX2RldiBsaWJyYXJ5Pwo+Cj4gVGhlbiB3ZSBkb24ndCBu
ZWVkIHRvIGR1cGxpY2F0ZSB0aGUgY29kZXMuCj4KPiBOb3RlIHRoYXQgcGRzX3ZkcGEgd2lsbCBi
ZSB0aGUgc2Vjb25kIHVzZXIgZm9yIHZpcnRpb19wY2lfbW9kZXJuX2Rldgo+IGxpYnJhcnkgKGFu
ZCB0aGUgZmlyc3QgdkRQQSBwYXJlbnQgdG8gdXNlIHRoYXQgbGlicmFyeSkuClllcyBJIGFncmVl
IHRoaXMgbGlicmFyeSBjYW4gaGVscCBhIGxvdCBmb3IgYSBzdGFuZGFyZCB2aXJ0aW8gcGNpIGRl
dmljZS4KQnV0IHRoaXMgY2hhbmdlIHdvdWxkIGJlIGh1Z2UsIGl0cyBsaWtlIHJlcXVpcmUgdG8g
Y2hhbmdlIGV2ZXJ5IGxpbmUgb2YKdGhlIGRyaXZlci4gRm9yIGV4YW1wbGUgY3VycmVudCBkcml2
ZXIgZnVuY3Rpb25zIHdvcmsgb24gdGhlIGFkYXB0ZXIgYW5kCmlmY3ZmX2h3LCBpZiB3ZSB3YW50
cyB0byByZXVzZSB0aGUgbGliLCB3ZSBuZWVkIHRoZSBkcml2ZXIgd29yayBvbiAKc3RydWN0IHZp
cnRpb19wY2lfbW9kZXJuX2RldmljZS4KQWxtb3N0IG5lZWQgdG8gcmUtd3JpdGUgdGhlIGRyaXZl
ci4KCkNhbiB3ZSBwbGFuIHRoaXMgaHVnZSBjaGFuZ2UgaW4gZm9sbG93aW5nIHNlcmllcz8KClRo
YW5rcywKWmh1IExpbmdzaGFuCj4KPiBUaGFua3MKPgo+PiBUaGlzIHNlcmllcyBhbHNvIGltcGxl
bWVudCBpcnEgc3luY2hyb25pemF0aW9uIGluIHRoZSByZXNldAo+PiByb3V0aW5lCj4+Cj4+IFpo
dSBMaW5nc2hhbiAoNSk6Cj4+ICAgIHZpcnQgcXVldWUgb3BzIHRha2UgaW1tZWRpYXRlIGFjdGlv
bnMKPj4gICAgZ2V0X2RyaXZlcl9mZWF0dXJlcyBmcm9tIHZpcml0byByZWdpc3RlcnMKPj4gICAg
cmV0aXJlIGlmY3ZmX3N0YXJ0X2RhdGFwYXRoIGFuZCBpZmN2Zl9hZGRfc3RhdHVzCj4+ICAgIHN5
bmNocm9uaXplIGlycXMgaW4gdGhlIHJlc2V0IHJvdXRpbmUKPj4gICAgYSB2ZW5kb3IgZHJpdmVy
IHNob3VsZCBub3Qgc2V0IF9DT05GSUdfU19GQUlMRUQKPj4KPj4gICBkcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5jIHwgMTYyICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCj4+
ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8ICAxNiArKy0tCj4+ICAgZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8ICA5NyArKysrLS0tLS0tLS0tLS0tLS0tCj4+ICAg
MyBmaWxlcyBjaGFuZ2VkLCAxMjIgaW5zZXJ0aW9ucygrKSwgMTUzIGRlbGV0aW9ucygtKQo+Pgo+
PiAtLQo+PiAyLjM5LjEKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
