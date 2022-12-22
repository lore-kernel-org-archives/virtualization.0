Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA14FC4332F
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 05:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19310610C9;
	Thu, 22 Dec 2022 05:44:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19310610C9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KklO2TLw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RonzPf2ZJgfo; Thu, 22 Dec 2022 05:44:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9068960BA4;
	Thu, 22 Dec 2022 05:44:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9068960BA4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7500BC0071;
	Thu, 22 Dec 2022 05:44:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 609FEC0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D8CD402E5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:44:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D8CD402E5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KklO2TLw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4RA-r2h6W6Va
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:44:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08E3A4029F
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08E3A4029F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671687890; x=1703223890;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=0ZfvVW/+NlOTTS2iA3zsErh8LbKIbJdHw6iRjUvQJJA=;
 b=KklO2TLw2Ik3Qy/z2nJ78Qh6/SqekgcaFWakCuOKwKSexBQZVnh5RKLo
 JJ/Xg75Rq7DCcvFjfr6EptkYrcAamMzvsBQInqxbfzYFASEZ7e6h6E9Im
 QeDbaXjsBag0P1ZXl+T580p9sM0i6yjMKCrYvlwVZnfB/+ptJ7P5MLUFR
 tKuOKFdrkanYjkEaYuGbKJlA5xusU2XibqrgFk1QLR59UKrI4a4OpnJtV
 BRVtNJ36CTncgZEHlmNgvjNvpgcYcA67rCHbcpTWdRsxvoRdXvO8gqKJf
 f82r42G2ttD3C+4S7VOwwmI4WKvAyLYZSQEI0Mv6G5oA55zDQEkSNAyeI w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="317687239"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; d="scan'208";a="317687239"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2022 21:44:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="651660810"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; d="scan'208";a="651660810"
Received: from linxie-mobl1.ccr.corp.intel.com (HELO [10.249.201.163])
 ([10.249.201.163])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2022 21:44:48 -0800
Message-ID: <c59014af-86e2-9c7e-3636-66792e814135@intel.com>
Date: Thu, 22 Dec 2022 13:44:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH V2 00/12] ifcvf/vDPA implement features provisioning
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
To: Jason Wang <jasowang@redhat.com>
References: <20221125145724.1129962-1-lingshan.zhu@intel.com>
 <CACGkMEvEwutEZT4UyosOZmTcKjvhhS6covy6FgyMWm4nmtKn8w@mail.gmail.com>
 <845d9829-a766-3a07-83bb-1d764ace604d@intel.com>
Content-Language: en-US
In-Reply-To: <845d9829-a766-3a07-83bb-1d764ace604d@intel.com>
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

CgpPbiAxMi8xMy8yMDIyIDI6NTcgUE0sIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4KPgo+IE9uIDEy
LzYvMjAyMiA0OjI1IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBPbiBGcmksIE5vdiAyNSwgMjAy
MiBhdCAxMTowNiBQTSBaaHUgTGluZ3NoYW4gCj4+IDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPiB3
cm90ZToKPj4+IFRoaXMgc2VyaWVzIGltcGxlbWVudHMgZmVhdHVyZXMgcHJvdmlzaW9uaW5nIGZv
ciBpZmN2Zi4KPj4+IEJ5IGFwcGx5aW5nIHRoaXMgc2VyaWVzLCB3ZSBhbGxvdyB1c2Vyc3BhY2Ug
dG8gY3JlYXRlCj4+PiBhIHZEUEEgZGV2aWNlIHdpdGggc2VsZWN0ZWQgKG1hbmFnZW1lbnQgZGV2
aWNlIHN1cHBvcnRlZCkKPj4+IGZlYXR1cmUgYml0cyBhbmQgbWFzayBvdXQgb3RoZXJzLgo+Pj4K
Pj4+IEV4YW1wbGVzOgo+Pj4gYSlUaGUgbWFuYWdlbWVudCBkZXZpY2Ugc3VwcG9ydGVkIGZlYXR1
cmVzOgo+Pj4gJCB2ZHBhIG1nbXRkZXYgc2hvdyBwY2kvMDAwMDowMTowMC41Cj4+PiBwY2kvMDAw
MDowMTowMC41Ogo+Pj4gwqDCoCBzdXBwb3J0ZWRfY2xhc3NlcyBuZXQKPj4+IMKgwqAgbWF4X3N1
cHBvcnRlZF92cXMgOQo+Pj4gwqDCoCBkZXZfZmVhdHVyZXMgTVRVIE1BQyBNUkdfUlhCVUYgQ1RS
TF9WUSBNUSBBTllfTEFZT1VUIFZFUlNJT05fMSAKPj4+IEFDQ0VTU19QTEFURk9STQo+Pj4KPj4+
IGIpUHJvdmlzaW9uIGEgdkRQQSBkZXZpY2Ugd2l0aCBhbGwgc3VwcG9ydGVkIGZlYXR1cmVzOgo+
Pj4gJCB2ZHBhIGRldiBhZGQgbmFtZSB2ZHBhMCBtZ210ZGV2IHBjaS8wMDAwOjAxOjAwLjUKPj4+
ICQgdmRwYS92ZHBhIGRldiBjb25maWcgc2hvdyB2ZHBhMAo+Pj4gdmRwYTA6IG1hYyAwMDplODpj
YToxMTpiZTowNSBsaW5rIHVwIGxpbmtfYW5ub3VuY2UgZmFsc2UgCj4+PiBtYXhfdnFfcGFpcnMg
NCBtdHUgMTUwMAo+Pj4gwqDCoCBuZWdvdGlhdGVkX2ZlYXR1cmVzIE1SR19SWEJVRiBDVFJMX1ZR
IE1RIFZFUlNJT05fMSBBQ0NFU1NfUExBVEZPUk0KPj4+Cj4+PiBjKVByb3Zpc2lvbiBhIHZEUEEg
ZGV2aWNlIHdpdGggYSBzdWJzZXQgb2YgdGhlIHN1cHBvcnRlZCBmZWF0dXJlczoKPj4+ICQgdmRw
YSBkZXYgYWRkIG5hbWUgdmRwYTAgbWdtdGRldiBwY2kvMDAwMDowMTowMC41IGRldmljZV9mZWF0
dXJlcyAKPj4+IDB4MzAwMDIwMDIwCj4+PiAkIHZkcGEgZGV2IGNvbmZpZyBzaG93IHZkcGEwCj4+
PiBtYWMgMDA6ZTg6Y2E6MTE6YmU6MDUgbGluayB1cCBsaW5rX2Fubm91bmNlIGZhbHNlCj4+PiDC
oMKgIG5lZ290aWF0ZWRfZmVhdHVyZXMgQ1RSTF9WUSBWRVJTSU9OXzEgQUNDRVNTX1BMQVRGT1JN
Cj4+Pgo+Pj4gUGxlYXNlIGhlbHAgcmV2aWV3Cj4+Pgo+Pj4gVGhhbmtzCj4+Pgo+Pj4gQ2hhbmdl
cyBmcm9tIFYxOgo+Pj4gc3BsaXQgb3JpZ2luYWwgcGF0Y2ggMSB+IHBhdGNoIDMgdG8gc21hbGwg
cGF0Y2hlcyB0aGF0IGFyZSBsZXNzCj4+PiB0aGFuIDEwMCBsaW5lcywKPj4gVHJ1ZSBidXQuCj4+
Cj4+PiBzbyB0aGV5IGNhbiBiZSBhcHBsaWVkIHRvIHN0YWxiZSBrZXJuZWwoSmFzb24pCj4+Pgo+
PiBJdCByZXF1aXJlcyBlYWNoIHBhdGNoIGZpeGVzIGEgcmVhbCBpc3N1ZSBzbyBJIHRoaW5rIHRo
b3NlIGNhbiBub3QgZ28KPj4gdG8gLXN0YWJsZS4KPj4KPj4gQnR3LCBsb29raW5nIGF0IGdpdCBo
aXN0b3J5IHdoYXQgeW91IHdhbnQgdG8gZGVjb3VwbGUgaXMgYmFzaWNhbGx5Cj4+IGZ1bmN0aW9u
YWwgZXF1aXZhbGVudCB0byBhIHBhcnRpYWwgcmV2ZXJ0IG9mIHRoaXMgY29tbWl0Ogo+Pgo+PiBj
b21taXQgMzc4YjJlOTU2ODIwZmY1YzA4MmQwNWY0MjgyOGJhZGNmYmFiYjYxNAo+PiBBdXRob3I6
IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4gRGF0ZTrCoMKgIEZyaSBK
dWwgMjIgMTk6NTM6MDUgMjAyMiArMDgwMAo+Pgo+PiDCoMKgwqDCoCB2RFBBL2lmY3ZmOiBzdXBw
b3J0IHVzZXJzcGFjZSB0byBxdWVyeSBmZWF0dXJlcyBhbmQgTVEgb2YgYQo+PiBtYW5hZ2VtZW50
IGRldmljZQo+Pgo+PiDCoMKgwqDCoCBBZGFwdGluZyB0byBjdXJyZW50IG5ldGxpbmsgaW50ZXJm
YWNlcywgdGhpcyBjb21taXQgYWxsb3dzIAo+PiB1c2Vyc3BhY2UKPj4gwqDCoMKgwqAgdG8gcXVl
cnkgZmVhdHVyZSBiaXRzIGFuZCBNUSBjYXBhYmlsaXR5IG9mIGEgbWFuYWdlbWVudCBkZXZpY2Uu
Cj4+Cj4+IMKgwqDCoMKgIEN1cnJlbnRseSBib3RoIHRoZSB2RFBBIGRldmljZSBhbmQgdGhlIG1h
bmFnZW1lbnQgZGV2aWNlIGFyZSB0aGUgCj4+IFZGIGl0c2VsZiwKPj4gwqDCoMKgwqAgdGh1cyB0
aGlzIGlmY3ZmIHNob3VsZCBpbml0aWFsaXplIHRoZSB2aXJ0aW8gY2FwYWJpbGl0aWVzIGluIAo+
PiBwcm9iZSgpIGJlZm9yZQo+PiDCoMKgwqDCoCBzZXR0aW5nIHVwIHRoZSBzdHJ1Y3QgdmRwYV9t
Z210X2Rldi4KPj4KPj4gwqDCoMKgwqAgU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5n
c2hhbi56aHVAaW50ZWwuY29tPgo+PiDCoMKgwqDCoCBNZXNzYWdlLUlkOiA8MjAyMjA3MjIxMTUz
MDkuODI3NDYtMy1saW5nc2hhbi56aHVAaW50ZWwuY29tPgo+PiDCoMKgwqDCoCBTaWduZWQtb2Zm
LWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+Pgo+PiBCZWZvcmUgdGhp
cyBjb21taXQuIGFkYXB0ZXIgd2FzIGFsbG9jYXRlZC9mcmVlZCBpbiBkZXZpY2VfYWRkL2RlbAo+
PiB3aGljaCBzaG91bGQgYmUgZmluZS4KPj4KPj4gQ2FuIHdlIGdvIGJhY2sgdG8gZG9pbmcgdGhp
bmdzIHRoYXQgd2F5Pwo+IEhpIEphc29uCj4KPiBUaGFua3MgZm9yIHlvdXIgYWR2aWNlLCBteSBj
b25jZXJuIGlzLCBldmVuIHJldmVydCB0aGlzIGNvbW1pdCAzNzhiMmU5NSwKPiB3ZSBzdGlsbCBu
ZWVkIHRvIHJlLWltcGxlbWVudCB0aGUgZmVhdHVyZSAic3VwcG9ydCB1c2Vyc3BhY2UgdG8gcXVl
cnkgCj4gZmVhdHVyZXMgYW5kIE1RIG9mIGEgbWFuYWdlbWVudCBkZXZpY2UiCj4gaW4gc3RhYmxl
IGtlcm5lbChzdGlsbCBub3QgYSBwYXRjaCBmaXggc29tZXRoaW5nIGJ1dCBpbXBsZW1lbnQgCj4g
c29tZXRoaW5nKSwgb3Igd2UgcmVtb3ZlIGEgZmVhdHVyZSBpbiB0aGUgc3RhYmxlIGtlcm5lbC4K
PiBBbmQgdGhlcmUgbWF5IHN0aWxsIG5lZWQgdG8gc3BsaXQgcGF0Y2hlcyB0byBtZWV0IHRoZSA8
MTAwIGxpbmVzIAo+IHJlcXVpcmVtZW50Cj4KPiBUaGUgcmVhc29uIHdoeSBJIHBsYWNlIHRoZSBh
ZGFwdGVyIGFsbG9jYXRpb24gaW4gcHJvYmUgaXMgdGhhdCAKPiBjdXJyZW50bHkgdGhlIG1hbmFn
ZW1lbnQgZGV2aWNlIGlzIHRoZSBWRiBpdHNlbGYsCj4gbW92ZSBpdCBmcm9tIGRldl9hZGQgdG8g
cHJvYmUgY2FuIGxpZ2h0ZW4gdGhlIG9yZ2FuaXphdGlvbiBvZiBkYXRhIAo+IHN0cnVjdHVyZXMs
IGl0IGlzIG5vdCBhIGdvb2QgZGVzaWduIGFueXdheSwKPiBzbyB0aGlzIHNlcmllcyB0cmllcyB0
byBmaXggdGhlbSBhcyB3ZWxsLgo+Cj4gTWF5YmUgbm90IHRvIHRvIHNhYmxlCj4KPiBUaGFua3MK
SGkgSmFzb24sCgpQaW5nLAoKc2hhbGwgSSBkcm9wIHRoZSAiY2Mgc3RhYmxlIiB0YWcgYW5kIHJl
c2VuZD8KTWF5YmUgc3F1YXNoIHRoZSBwYXRjaGVzIGJlY2F1c2UgdGhleSBhcmUgbm90IGdvaW5n
IHRvIHN0YWJsZSB0cmVlPwoKVGhhbmtzCj4+Cj4+IFRoYW5rcwo+Pgo+Pj4gWmh1IExpbmdzaGFu
ICgxMik6Cj4+PiDCoMKgIHZEUEEvaWZjdmY6IGRlY291cGxlIGh3IGZlYXR1cmVzIG1hbmlwdWxh
dG9ycyBmcm9tIHRoZSBhZGFwdGVyCj4+PiDCoMKgIHZEUEEvaWZjdmY6IGRlY291cGxlIGNvbmZp
ZyBzcGFjZSBvcHMgZnJvbSB0aGUgYWRhcHRlcgo+Pj4gwqDCoCB2RFBBL2lmY3ZmOiBhbGxvYyB0
aGUgbWdtdF9kZXYgYmVmb3JlIHRoZSBhZGFwdGVyCj4+PiDCoMKgIHZEUEEvaWZjdmY6IGRlY291
cGxlIHZxIElSUSByZWxlYXNlcnMgZnJvbSB0aGUgYWRhcHRlcgo+Pj4gwqDCoCB2RFBBL2lmY3Zm
OiBkZWNvdXBsZSBjb25maWcgSVJRIHJlbGVhc2VyIGZyb20gdGhlIGFkYXB0ZXIKPj4+IMKgwqAg
dkRQQS9pZmN2ZjogZGVjb3VwbGUgdnEgaXJxIHJlcXVlc3RlciBmcm9tIHRoZSBhZGFwdGVyCj4+
PiDCoMKgIHZEUEEvaWZjdmY6IGRlY291cGxlIGNvbmZpZy9kZXYgSVJRIHJlcXVlc3RlciBhbmQg
dmVjdG9ycyBhbGxvY2F0b3IKPj4+IMKgwqDCoMKgIGZyb20gdGhlIGFkYXB0ZXIKPj4+IMKgwqAg
dkRQQS9pZmN2ZjogaWZjdmZfcmVxdWVzdF9pcnEgd29ya3Mgb24gaWZjdmZfaHcKPj4+IMKgwqAg
dkRQQS9pZmN2ZjogbWFuYWdlIGlmY3ZmX2h3IGluIHRoZSBtZ210X2Rldgo+Pj4gwqDCoCB2RFBB
L2lmY3ZmOiBhbGxvY2F0ZSB0aGUgYWRhcHRlciBpbiBkZXZfYWRkKCkKPj4+IMKgwqAgdkRQQS9p
ZmN2ZjogcmV0aXJlIGlmY3ZmX3ByaXZhdGVfdG9fdmYKPj4+IMKgwqAgdkRQQS9pZmN2ZjogaW1w
bGVtZW50IGZlYXR1cmVzIHByb3Zpc2lvbmluZwo+Pj4KPj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9iYXNlLmMgfMKgIDMyICsrLS0tLS0KPj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9iYXNlLmggfMKgIDEwICstCj4+PiDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jIHwgMTYyIAo+Pj4gKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KPj4+IMKgIDMg
ZmlsZXMgY2hhbmdlZCwgOTEgaW5zZXJ0aW9ucygrKSwgMTEzIGRlbGV0aW9ucygtKQo+Pj4KPj4+
IC0tIAo+Pj4gMi4zMS4xCj4+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
