Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1530C43334
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 11:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7147084068;
	Tue, 26 Jul 2022 11:15:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7147084068
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J3OINQH7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ULrfXbmK8Yg4; Tue, 26 Jul 2022 11:15:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CCA5D8404A;
	Tue, 26 Jul 2022 11:15:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCA5D8404A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B312FC0035;
	Tue, 26 Jul 2022 11:15:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F4D7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 11:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEFCD60EDF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 11:15:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEFCD60EDF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=J3OINQH7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ru8qoJapw3Mg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 11:15:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6CCD60EB1
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6CCD60EB1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 11:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1658834148; x=1690370148;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=eE9rDwaM01yNWT3Q/JfhpPsmbwN+c+tZOwPT610OkfU=;
 b=J3OINQH7lISc8sJRfh/22bYliJWC4MaPRbI1vwXG3bsZQqZ3J/BH8QE4
 PUfJwRxYSziOpcSv4O3KxVeE+pEr/FlJq/I4+xEf56qerPaGeEbozUNI4
 1FSd8z8svGFxF3/zXAfVgAtR6lHPNe6+f8Aqki5prWPbHbMOEsdWJYPAl
 gCeyhSqZuWSt5zKLz+/jByHhj78xsw5r2s3zRYYZsMer6sI7kfSnzgV6P
 pTIm3Xc6+NqNZw1dzauCYxSb83pkErCB9jUXhKkPuFjQpY3vgzGsddYch
 E6St28LTyTyxfgFPekZcoCwnaFL66ZvFHMAHq1eCzgZ7S0Wow3xElfsZR A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="349628336"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; d="scan'208";a="349628336"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2022 04:15:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; d="scan'208";a="658640836"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.172.186])
 ([10.249.172.186])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2022 04:15:09 -0700
Message-ID: <11d64542-09e7-8de3-7997-37e3648f3637@linux.intel.com>
Date: Tue, 26 Jul 2022 19:15:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH V4 3/6] vDPA: allow userspace to query features of a vDPA
 device
Content-Language: en-US
To: virtualization@lists.linux-foundation.org
References: <20220722115309.82746-1-lingshan.zhu@intel.com>
 <20220722115309.82746-4-lingshan.zhu@intel.com>
 <PH0PR12MB548193156AFCA04F58B01A3CDC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <6dc2229c-f2f3-017f-16fa-4611e53c774e@intel.com>
 <PH0PR12MB5481D9BBC9C249840E4CDF7EDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9d9d6022-5d49-6f6e-a1ff-562d088ad03c@intel.com>
 <PH0PR12MB548133788748EF91F959C143DC949@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
In-Reply-To: <PH0PR12MB548133788748EF91F959C143DC949@PH0PR12MB5481.namprd12.prod.outlook.com>
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

CgpPbiA3LzI2LzIwMjIgNzowNiBQTSwgUGFyYXYgUGFuZGl0IHZpYSBWaXJ0dWFsaXphdGlvbiB3
cm90ZToKPj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4g
U2VudDogVHVlc2RheSwgSnVseSAyNiwgMjAyMiA3OjAzIEFNCj4+Cj4+IE9uIDcvMjQvMjAyMiAx
MToyMSBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+Pj4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxp
bmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+Pj4gU2VudDogU2F0dXJkYXksIEp1bHkgMjMsIDIwMjIg
NzoyNCBBTQo+Pj4+Cj4+Pj4KPj4+PiBPbiA3LzIyLzIwMjIgOToxMiBQTSwgUGFyYXYgUGFuZGl0
IHdyb3RlOgo+Pj4+Pj4gRnJvbTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29t
Pgo+Pj4+Pj4gU2VudDogRnJpZGF5LCBKdWx5IDIyLCAyMDIyIDc6NTMgQU0KPj4+Pj4+Cj4+Pj4+
PiBUaGlzIGNvbW1pdCBhZGRzIGEgbmV3IHZEUEEgbmV0bGluayBhdHRyaWJ1dGlvbgo+Pj4+Pj4g
VkRQQV9BVFRSX1ZEUEFfREVWX1NVUFBPUlRFRF9GRUFUVVJFUy4gVXNlcnNwYWNlIGNhbgo+PiBx
dWVyeQo+Pj4+IGZlYXR1cmVzCj4+Pj4+PiBvZiB2RFBBIGRldmljZXMgdGhyb3VnaCB0aGlzIG5l
dyBhdHRyLgo+Pj4+Pj4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3No
YW4uemh1QGludGVsLmNvbT4KPj4+Pj4+IC0tLQo+Pj4+Pj4gICAgIGRyaXZlcnMvdmRwYS92ZHBh
LmMgICAgICAgfCAxMyArKysrKysrKystLS0tCj4+Pj4+PiAgICAgaW5jbHVkZS91YXBpL2xpbnV4
L3ZkcGEuaCB8ICAxICsKPj4+Pj4+ICAgICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCj4+Pj4+Pgo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jIGluZGV4Cj4+Pj4+PiBlYmYyZjM2M2ZiZTcu
LjliMGUzOWIyZjAyMiAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+
Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+Pj4+IEBAIC04MTUsNyArODE1LDcgQEAg
c3RhdGljIGludCB2ZHBhX2Rldl9uZXRfbXFfY29uZmlnX2ZpbGwoc3RydWN0Cj4+Pj4+PiB2ZHBh
X2RldmljZSAqdmRldiwgIHN0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X2NvbmZpZ19maWxsKHN0cnVj
dAo+Pj4+Pj4gdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdCBza19idWZmICptc2cpICB7Cj4+Pj4+
PiAgICAgCXN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7fTsKPj4+Pj4+IC0JdTY0
IGZlYXR1cmVzOwo+Pj4+Pj4gKwl1NjQgZmVhdHVyZXNfZGV2aWNlLCBmZWF0dXJlc19kcml2ZXI7
Cj4+Pj4+PiAgICAgCXUxNiB2YWxfdTE2Owo+Pj4+Pj4KPj4+Pj4+ICAgICAJdmRwYV9nZXRfY29u
ZmlnX3VubG9ja2VkKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihjb25maWcpKTsgQEAKPj4+Pj4+
IC0KPj4+Pj4+IDgzMiwxMiArODMyLDE3IEBAIHN0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X2NvbmZp
Z19maWxsKHN0cnVjdAo+Pj4+Pj4gdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdCBza19idWZmICpt
cwo+Pj4+Pj4gICAgIAlpZiAobmxhX3B1dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdf
TVRVLCB2YWxfdTE2KSkKPj4+Pj4+ICAgICAJCXJldHVybiAtRU1TR1NJWkU7Cj4+Pj4+Pgo+Pj4+
Pj4gLQlmZWF0dXJlcyA9IHZkZXYtPmNvbmZpZy0+Z2V0X2RyaXZlcl9mZWF0dXJlcyh2ZGV2KTsK
Pj4+Pj4+IC0JaWYgKG5sYV9wdXRfdTY0XzY0Yml0KG1zZywKPj4+Pj4+IFZEUEFfQVRUUl9ERVZf
TkVHT1RJQVRFRF9GRUFUVVJFUywgZmVhdHVyZXMsCj4+Pj4+PiArCWZlYXR1cmVzX2RyaXZlciA9
IHZkZXYtPmNvbmZpZy0+Z2V0X2RyaXZlcl9mZWF0dXJlcyh2ZGV2KTsKPj4+Pj4+ICsJaWYgKG5s
YV9wdXRfdTY0XzY0Yml0KG1zZywKPj4+Pj4+IFZEUEFfQVRUUl9ERVZfTkVHT1RJQVRFRF9GRUFU
VVJFUywgZmVhdHVyZXNfZHJpdmVyLAo+Pj4+Pj4gKwkJCSAgICAgIFZEUEFfQVRUUl9QQUQpKQo+
Pj4+Pj4gKwkJcmV0dXJuIC1FTVNHU0laRTsKPj4+Pj4+ICsKPj4+Pj4+ICsJZmVhdHVyZXNfZGV2
aWNlID0gdmRldi0+Y29uZmlnLT5nZXRfZGV2aWNlX2ZlYXR1cmVzKHZkZXYpOwo+Pj4+Pj4gKwlp
ZiAobmxhX3B1dF91NjRfNjRiaXQobXNnLAo+Pj4+Pj4gVkRQQV9BVFRSX1ZEUEFfREVWX1NVUFBP
UlRFRF9GRUFUVVJFUywKPj4+Pj4+ICtmZWF0dXJlc19kZXZpY2UsCj4+Pj4+PiAgICAgCQkJICAg
ICAgVkRQQV9BVFRSX1BBRCkpCj4+Pj4+PiAgICAgCQlyZXR1cm4gLUVNU0dTSVpFOwo+Pj4+Pj4K
Pj4+Pj4+IC0JcmV0dXJuIHZkcGFfZGV2X25ldF9tcV9jb25maWdfZmlsbCh2ZGV2LCBtc2csIGZl
YXR1cmVzLCAmY29uZmlnKTsKPj4+Pj4+ICsJcmV0dXJuIHZkcGFfZGV2X25ldF9tcV9jb25maWdf
ZmlsbCh2ZGV2LCBtc2csIGZlYXR1cmVzX2RyaXZlciwKPj4+Pj4+ICsmY29uZmlnKTsKPj4+Pj4+
ICAgICB9Cj4+Pj4+Pgo+Pj4+Pj4gICAgIHN0YXRpYyBpbnQKPj4+Pj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL3VhcGkvbGludXgvdmRwYS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZkcGEuaAo+Pj4+
Pj4gaW5kZXgKPj4+Pj4+IDI1YzU1Y2FiM2Q3Yy4uMzlmMWMzZDdjMTEyIDEwMDY0NAo+Pj4+Pj4g
LS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZkcGEuaAo+Pj4+Pj4gKysrIGIvaW5jbHVkZS91YXBp
L2xpbnV4L3ZkcGEuaAo+Pj4+Pj4gQEAgLTQ3LDYgKzQ3LDcgQEAgZW51bSB2ZHBhX2F0dHIgewo+
Pj4+Pj4gICAgIAlWRFBBX0FUVFJfREVWX05FR09USUFURURfRkVBVFVSRVMsCS8qIHU2NCAqLwo+
Pj4+Pj4gICAgIAlWRFBBX0FUVFJfREVWX01HTVRERVZfTUFYX1ZRUywJCS8qIHUzMiAqLwo+Pj4+
Pj4gICAgIAlWRFBBX0FUVFJfREVWX1NVUFBPUlRFRF9GRUFUVVJFUywJLyogdTY0ICovCj4+Pj4+
PiArCVZEUEFfQVRUUl9WRFBBX0RFVl9TVVBQT1JURURfRkVBVFVSRVMsCS8qIHU2NCAqLwo+Pj4+
Pj4KPj4+Pj4gSSBoYXZlIGFuc3dlcmVkIGluIHByZXZpb3VzIGVtYWlscy4KPj4+Pj4gSSBkaXNh
Z3JlZSB3aXRoIHRoZSBjaGFuZ2UuCj4+Pj4+IFBsZWFzZSByZXVzZSBWRFBBX0FUVFJfREVWX1NV
UFBPUlRFRF9GRUFUVVJFUy4KPj4+PiBJIGJlbGlldmUgd2UgaGF2ZSBhbHJlYWR5IGRpc2N1c3Nl
ZCB0aGlzIGJlZm9yZSBpbiB0aGUgVjMgdGhyZWFkLgo+Pj4+IEkgaGF2ZSB0b2xkIHlvdSB0aGF0
IHJldXNpbmcgdGhpcyBhdHRyIHdpbGwgbGVhZCB0byBhIG5ldyByYWNlIGNvbmRpdGlvbi4KPj4+
Pgo+Pj4gUmV0dXJuaW5nIGF0dHJpYnV0ZSBjYW5ub3QgbGVhZCB0byBhbnkgcmFjZSBjb25kaXRp
b24uCj4+IFBsZWFzZSByZWZlciB0byBvdXIgZGlzY3Vzc2lvbiBpbiB0aGUgVjMgc2VyaWVzLCBJ
IGhhdmUgZXhwbGFpbmVkIGlmIHJlLXVzZSB0aGlzCj4+IGF0dHIsIGl0IHdpbGwgYmUgYSBtdWx0
aXBsZSBjb25zdW1lcnMgYW5kIG11bHRpcGxlIHByb2R1Y2VzIG1vZGVsLCBpdCBpcyBhCj4+IHR5
cGljYWwgcmFjaW5nIGNvbmRpdGlvbi4KPiBJIHJlYWQgdGhlIGVtYWlscyB3aXRoIHN1YmplY3Qg
PSAiIFJlOiBbUEFUQ0ggVjMgMy82XSB2RFBBOiBhbGxvdyB1c2Vyc3BhY2UgdG8gcXVlcnkgZmVh
dHVyZXMgb2YgYSB2RFBBIGRldmljZSIKPiBJIGNvdWxkbuKAmXQgZmluZCBtdWx0aXBsZSBjb25z
dW1lcnMgbXVsdGlwbGUgcHJvZHVjZXJzIHdvcmtpbmcgb24gc2FtZSBubGEgbWVzc2FnZS4Kd2hh
dCBpZiB0d28gb3IgbW9yZSBpcHJvdXRlMiBpbnN0YW5jZSBvciBvdGhlciB1c2Vyc3BhY2UgdG9v
bHMgcXVlcnlpbmcgCnRoZSBmZWF0dXJlcyBvZiB0aGUgbWFuYWdlbWVudCBkZXZpY2UgYW5kIHRo
ZSB2RFBBIGRldmljZQpzaW11bHRhbmVvdXNseT8gSW4gc3VjaCBhIGNhc2UsIHRoZXJlIGFyZSBt
dWx0aXBsZSBjb25zdW1lcnMgaW4gdGhlIAp1c2Vyc3BhY2UsIGFuZCB0aGUga2VybmVsIGZ1bmN0
aW9ucyh0byBmaWxsIG1hbmFnZW1lbnQgZGV2aWNlCmZlYXR1cmVzIGFuZCB2RFBBIGRldmljZSBm
ZWF0dXJlcykgYXJlIHRoZSBtdWx0aXBsZSBwcm9kdWNlcnMuIEFuZCB0aGVyZSAKYXJlIG5vIGxv
Y2tzLgoKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IFZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdAo+IFZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCj4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
