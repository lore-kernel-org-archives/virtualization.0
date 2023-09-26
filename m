Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98180E81810
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 02:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DC6840268;
	Tue, 26 Sep 2023 02:35:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3DC6840268
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jRaybehM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s2rM7ZcNvE1R; Tue, 26 Sep 2023 02:35:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 34D8140275;
	Tue, 26 Sep 2023 02:35:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34D8140275
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BD95C0071;
	Tue, 26 Sep 2023 02:35:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA4EBC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF21240275
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:35:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF21240275
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PPKv3B1MSSET
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:35:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07F3140268
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:35:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07F3140268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695695705; x=1727231705;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=RQkJIbou+c0hSTlcipeunSEpz6AISxc5qlOk5hk+jP4=;
 b=jRaybehMpf2axrD+xPWhJ07Ox8mOz5IruT9l/YJS9CtYMiKgSn9/ABLd
 8rmMCKJx8rZJMNL36+WquJGWmpcDD1jsaI2ZbAT3QmHCfCUh0QpacS1ko
 YcJ4Xhsw4jbYxqFb2IsxymdrT5fjleVcRTfQYgQOmYKRaRURNAN+pIlDa
 U1st0DfOzl3k4NJu8D2ARh35Z12JJAzPHVJHLpM8BHThvyVZiaQmaXdJ9
 RtOprq2q0ict0iUKkhWhWmCf7jtFBxY4qjOgaCZmfN+ryJaiEKJItikps
 dZnsffABR7xye4Suk1tp1HC85Gq7H6oSCYjx2sgS6t5NH7YMVeqYgcHbA A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="385314245"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="385314245"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 19:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995638790"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="995638790"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.21.134])
 ([10.93.21.134])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 19:35:01 -0700
Message-ID: <ce58ea54-5fdb-00c5-0cbe-e1d93fd881f4@intel.com>
Date: Tue, 26 Sep 2023 10:34:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
References: <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuX5HJVBOw9E+skr=K=QzH3oyHK8gk-r0hAvi6Wm7OA7Q@mail.gmail.com>
 <PH0PR12MB5481ED78F7467EEB0740847EDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230925141713-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230925141713-mutt-send-email-mst@kernel.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

CgpPbiA5LzI2LzIwMjMgMjozNiBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIE1v
biwgU2VwIDI1LCAyMDIzIGF0IDA4OjI2OjMzQU0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToK
Pj4KPj4+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+PiBTZW50OiBN
b25kYXksIFNlcHRlbWJlciAyNSwgMjAyMyA4OjAwIEFNCj4+Pgo+Pj4gT24gRnJpLCBTZXAgMjIs
IDIwMjMgYXQgODoyNeKAr1BNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4gd3JvdGU6
Cj4+Pj4KPj4+Pj4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4KPj4+Pj4g
U2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjMgNTo1MyBQTQo+Pj4+Cj4+Pj4+PiBBbmQg
d2hhdCdzIG1vcmUsIHVzaW5nIE1NSU8gQkFSMCB0aGVuIGl0IGNhbiB3b3JrIGZvciBsZWdhY3ku
Cj4+Pj4+IE9oPyBIb3c/IE91ciB0ZWFtIGRpZG4ndCB0aGluayBzby4KPj4+PiBJdCBkb2VzIG5v
dC4gSXQgd2FzIGFscmVhZHkgZGlzY3Vzc2VkLgo+Pj4+IFRoZSBkZXZpY2UgcmVzZXQgaW4gbGVn
YWN5IGlzIG5vdCBzeW5jaHJvbm91cy4KPj4+IEhvdyBkbyB5b3Uga25vdyB0aGlzPwo+Pj4KPj4g
Tm90IHN1cmUgdGhlIG1vdGl2YXRpb24gb2Ygc2FtZSBkaXNjdXNzaW9uIGRvbmUgaW4gdGhlIE9B
U0lTIHdpdGggeW91IGFuZCBvdGhlcnMgaW4gcGFzdC4KPj4KPj4gQW55d2F5cywgcGxlYXNlIGZp
bmQgdGhlIGFuc3dlciBiZWxvdy4KPj4KPj4gQWJvdXQgcmVzZXQsCj4+IFRoZSBsZWdhY3kgZGV2
aWNlIHNwZWNpZmljYXRpb24gaGFzIG5vdCBlbmZvcmNlZCBiZWxvdyBjaXRlZCAxLjAgZHJpdmVy
IHJlcXVpcmVtZW50IG9mIDEuMC4KPj4KPj4gIlRoZSBkcml2ZXIgU0hPVUxEIGNvbnNpZGVyIGEg
ZHJpdmVyLWluaXRpYXRlZCByZXNldCBjb21wbGV0ZSB3aGVuIGl0IHJlYWRzIGRldmljZSBzdGF0
dXMgYXMgMC4iCj4+ICAgCj4+IFsxXSBodHRwczovL296bGFicy5vcmcvfnJ1c3R5L3ZpcnRpby1z
cGVjL3ZpcnRpby0wLjkuNS5wZGYKPiBCYXNpY2FsbHksIEkgdGhpbmsgYW55IGRyaXZlcnMgdGhh
dCBkaWQgbm90IHJlYWQgc3RhdHVzIChsaW51eCBwcmUgMjAxMSkKPiBiZWZvcmUgZnJlZWluZyBt
ZW1vcnkgdW5kZXIgRE1BIGhhdmUgYSByZXNldCBwYXRoIHRoYXQgaXMgcmFjeSB3cnQgRE1BLCBz
aW5jZQo+IG1lbW9yeSB3cml0ZXMgYXJlIHBvc3RlZCBhbmQgSU8gd3JpdGVzIHdoaWxlIG5vdCBw
b3N0ZWQgaGF2ZSBjb21wbGV0aW9uCj4gdGhhdCBkb2VzIG5vdCBvcmRlciBwb3N0ZWQgdHJhbnNh
Y3Rpb25zLCBlLmcuIGZyb20gcGNpIGV4cHJlc3Mgc3BlYzoKPiAgICAgICAgICBEMmIKPiAgICAg
ICAgICBBbiBJL08gb3IgQ29uZmlndXJhdGlvbiBXcml0ZSBDb21wbGV0aW9uIDM3IGlzIHBlcm1p
dHRlZCB0byBwYXNzIGEgUG9zdGVkIFJlcXVlc3QuCj4gaGF2aW5nIHNhaWQgdGhhdCB0aGVyZSB3
ZXJlIGEgdG9uIG9mIGRyaXZlciByYWNlcyBkaXNjb3ZlcmVkIG9uIHRoaXMKPiBwYXRoIGluIHRo
ZSB5ZWFycyBzaW5jZSwgSSBzdXNwZWN0IGlmIG9uZSBjYXJlcyBhYm91dCB0aGlzIHRoZW4KPiBq
dXN0IGF2b2lkaW5nIHN0cmVzcyBvbiByZXNldCBpcyB3aXNlLgo+Cj4KPgo+Pj4+IFRoZSBkcml2
ZXJzIGRvIG5vdCB3YWl0IGZvciByZXNldCB0byBjb21wbGV0ZTsgaXQgd2FzIHdyaXR0ZW4gZm9y
IHRoZSBzdwo+Pj4gYmFja2VuZC4KPj4+Cj4+PiBEbyB5b3Ugc2VlIHRoZXJlJ3MgYSBmbHVzaCBh
ZnRlciByZXNldCBpbiB0aGUgbGVnYWN5IGRyaXZlcj8KPj4+Cj4+IFllcy4gaXQgb25seSBmbHVz
aGVzIHRoZSB3cml0ZSBieSByZWFkaW5nIGl0LiBUaGUgZHJpdmVyIGRvZXMgbm90IGdldCBfd2Fp
dF8gZm9yIHRoZSByZXNldCB0byBjb21wbGV0ZSB3aXRoaW4gdGhlIGRldmljZSBsaWtlIGFib3Zl
Lgo+IE9uZSBjYW4gdGhpbmthYmx5IGRvIHRoYXQgd2FpdCBpbiBoYXJkd2FyZSwgdGhvdWdoLiBK
dXN0IGRlZmVyIGNvbXBsZXRpb24gdW50aWwKPiByZWFkIGlzIGRvbmUuCkkgYWdyZWUgd2l0aCBN
U1QuIEF0IGxlYXN0IEludGVsIGRldmljZXMgd29yayBmaW5lIHdpdGggdmZpby1wY2kgYW5kIAps
ZWdhY3kgZHJpdmVyIHdpdGhvdXQgYW55IGNoYW5nZXMuClNvIGZhciBzbyBnb29kLgoKVGhhbmtz
ClpodSBMaW5nc2hhbgo+Cj4+IFBsZWFzZSBzZWUgdGhlIHJlc2V0IGZsb3cgb2YgMS54IGRldmlj
ZSBhcyBiZWxvdy4KPj4gSW4gZmFjdCB0aGUgY29tbWVudCBvZiB0aGUgMS54IGRldmljZSBhbHNv
IG5lZWRzIHRvIGJlIHVwZGF0ZWQgdG8gaW5kaWNhdGUgdGhhdCBkcml2ZXIgbmVlZCB0byB3YWl0
IGZvciB0aGUgZGV2aWNlIHRvIGZpbmlzaCB0aGUgcmVzZXQuCj4+IEkgd2lsbCBzZW5kIHNlcGFy
YXRlIHBhdGNoIGZvciBpbXByb3ZpbmcgdGhpcyBjb21tZW50IG9mIHZwX3Jlc2V0KCkgdG8gbWF0
Y2ggdGhlIHNwZWMuCj4+Cj4+IHN0YXRpYyB2b2lkIHZwX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2KQo+PiB7Cj4+ICAgICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBf
ZGV2ID0gdG9fdnBfZGV2aWNlKHZkZXYpOwo+PiAgICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9t
b2Rlcm5fZGV2aWNlICptZGV2ID0gJnZwX2Rldi0+bWRldjsKPj4KPj4gICAgICAgICAgLyogMCBz
dGF0dXMgbWVhbnMgYSByZXNldC4gKi8KPj4gICAgICAgICAgdnBfbW9kZXJuX3NldF9zdGF0dXMo
bWRldiwgMCk7Cj4+ICAgICAgICAgIC8qIEFmdGVyIHdyaXRpbmcgMCB0byBkZXZpY2Vfc3RhdHVz
LCB0aGUgZHJpdmVyIE1VU1Qgd2FpdCBmb3IgYSByZWFkIG9mCj4+ICAgICAgICAgICAqIGRldmlj
ZV9zdGF0dXMgdG8gcmV0dXJuIDAgYmVmb3JlIHJlaW5pdGlhbGl6aW5nIHRoZSBkZXZpY2UuCj4+
ICAgICAgICAgICAqIFRoaXMgd2lsbCBmbHVzaCBvdXQgdGhlIHN0YXR1cyB3cml0ZSwgYW5kIGZs
dXNoIGluIGRldmljZSB3cml0ZXMsCj4+ICAgICAgICAgICAqIGluY2x1ZGluZyBNU0ktWCBpbnRl
cnJ1cHRzLCBpZiBhbnkuCj4+ICAgICAgICAgICAqLwo+PiAgICAgICAgICB3aGlsZSAodnBfbW9k
ZXJuX2dldF9zdGF0dXMobWRldikpCj4+ICAgICAgICAgICAgICAgICAgbXNsZWVwKDEpOwo+PiAg
ICAgICAgICAvKiBGbHVzaCBwZW5kaW5nIFZRL2NvbmZpZ3VyYXRpb24gY2FsbGJhY2tzLiAqLwo+
PiAgICAgICAgICB2cF9zeW5jaHJvbml6ZV92ZWN0b3JzKHZkZXYpOwo+PiB9Cj4+Cj4+Cj4+PiBz
dGF0aWMgdm9pZCB2cF9yZXNldChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikgewo+Pj4gICAg
ICAgICAgc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYgPSB0b192cF9kZXZpY2UodmRl
dik7Cj4+PiAgICAgICAgICAvKiAwIHN0YXR1cyBtZWFucyBhIHJlc2V0LiAqLwo+Pj4gICAgICAg
ICAgdnBfbGVnYWN5X3NldF9zdGF0dXMoJnZwX2Rldi0+bGRldiwgMCk7Cj4+PiAgICAgICAgICAv
KiBGbHVzaCBvdXQgdGhlIHN0YXR1cyB3cml0ZSwgYW5kIGZsdXNoIGluIGRldmljZSB3cml0ZXMs
Cj4+PiAgICAgICAgICAgKiBpbmNsdWRpbmcgTVNpLVggaW50ZXJydXB0cywgaWYgYW55LiAqLwo+
Pj4gICAgICAgICAgdnBfbGVnYWN5X2dldF9zdGF0dXMoJnZwX2Rldi0+bGRldik7Cj4+PiAgICAg
ICAgICAvKiBGbHVzaCBwZW5kaW5nIFZRL2NvbmZpZ3VyYXRpb24gY2FsbGJhY2tzLiAqLwo+Pj4g
ICAgICAgICAgdnBfc3luY2hyb25pemVfdmVjdG9ycyh2ZGV2KTsKPj4+IH0KPj4+Cj4+PiBUaGFu
a3MKPj4+Cj4+Pgo+Pj4KPj4+PiBIZW5jZSBNTUlPIEJBUjAgaXMgbm90IHRoZSBiZXN0IG9wdGlv
biBpbiByZWFsIGltcGxlbWVudGF0aW9ucy4KPj4+Pgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4g
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiBodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
