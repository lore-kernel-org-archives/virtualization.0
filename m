Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29EBC49EA2
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 09:16:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985ED61175
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 09:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985ED61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47AE94157D;
	Fri, 18 Jun 2021 09:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id orxHDfhiIKj7; Fri, 18 Jun 2021 09:16:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6D2440661;
	Fri, 18 Jun 2021 09:16:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 809FCC000D;
	Fri, 18 Jun 2021 09:16:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BD7DC000B;
 Fri, 18 Jun 2021 09:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68AF940661;
 Fri, 18 Jun 2021 09:16:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rq0wcLv2sy6j; Fri, 18 Jun 2021 09:16:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFCDF40623;
 Fri, 18 Jun 2021 09:16:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BF711424;
 Fri, 18 Jun 2021 02:16:26 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2FDE3F694;
 Fri, 18 Jun 2021 02:16:23 -0700 (PDT)
Subject: Re: [PATCH v4 2/6] ACPI: Move IOMMU setup code out of IORT
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-3-jean-philippe@linaro.org>
 <2c53c9cf-43e6-11c2-6ee3-530ad1f87aec@redhat.com> <YMxOOq8YIBhRhzQM@myrica>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ff35c106-6254-1a6f-4b95-32a25bbccb96@arm.com>
Date: Fri, 18 Jun 2021 10:16:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMxOOq8YIBhRhzQM@myrica>
Content-Language: en-GB
Cc: mst@redhat.com, catalin.marinas@arm.com, guohanjun@huawei.com,
 rjw@rjwysocki.net, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, sudeep.holla@arm.com, will@kernel.org,
 dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

T24gMjAyMS0wNi0xOCAwODo0MSwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+IEhpIEVy
aWMsCj4gCj4gT24gV2VkLCBKdW4gMTYsIDIwMjEgYXQgMTE6MzU6MTNBTSArMDIwMCwgRXJpYyBB
dWdlciB3cm90ZToKPj4+IC1jb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICppb3J0X2lvbW11X2NvbmZp
Z3VyZV9pZChzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+PiAtCQkJCQkJY29uc3QgdTMyICppZF9pbikK
Pj4+ICtpbnQgaW9ydF9pb21tdV9jb25maWd1cmVfaWQoc3RydWN0IGRldmljZSAqZGV2LCBjb25z
dCB1MzIgKmlkX2luKQo+Pj4gICB7Cj4+PiAgIAlzdHJ1Y3QgYWNwaV9pb3J0X25vZGUgKm5vZGU7
Cj4+PiAtCWNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wczsKPj4+ICsJY29uc3Qgc3RydWN0IGlv
bW11X29wcyAqb3BzID0gTlVMTDsKPiAKPiBPb3BzLCBJIG5lZWQgdG8gcmVtb3ZlIHRoaXMgKGFu
ZCBhZGQgLVdlcnJvciB0byBteSB0ZXN0cy4pCj4gCj4gCj4+PiArc3RhdGljIGNvbnN0IHN0cnVj
dCBpb21tdV9vcHMgKmFjcGlfaW9tbXVfY29uZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwK
Pj4+ICsJCQkJCQkgICAgICAgY29uc3QgdTMyICppZF9pbikKPj4+ICt7Cj4+PiArCWludCBlcnI7
Cj4+PiArCWNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wczsKPj4+ICsKPj4+ICsJLyoKPj4+ICsJ
ICogSWYgd2UgYWxyZWFkeSB0cmFuc2xhdGVkIHRoZSBmd3NwZWMgdGhlcmUgaXMgbm90aGluZyBs
ZWZ0IHRvIGRvLAo+Pj4gKwkgKiByZXR1cm4gdGhlIGlvbW11X29wcy4KPj4+ICsJICovCj4+PiAr
CW9wcyA9IGFjcGlfaW9tbXVfZndzcGVjX29wcyhkZXYpOwo+Pj4gKwlpZiAob3BzKQo+Pj4gKwkJ
cmV0dXJuIG9wczsKPj4+ICsKPj4+ICsJZXJyID0gaW9ydF9pb21tdV9jb25maWd1cmVfaWQoZGV2
LCBpZF9pbik7Cj4+PiArCj4+PiArCS8qCj4+PiArCSAqIElmIHdlIGhhdmUgcmVhc29uIHRvIGJl
bGlldmUgdGhlIElPTU1VIGRyaXZlciBtaXNzZWQgdGhlIGluaXRpYWwKPj4+ICsJICogYWRkX2Rl
dmljZSBjYWxsYmFjayBmb3IgZGV2LCByZXBsYXkgaXQgdG8gZ2V0IHRoaW5ncyBpbiBvcmRlci4K
Pj4+ICsJICovCj4+PiArCWlmICghZXJyICYmIGRldi0+YnVzICYmICFkZXZpY2VfaW9tbXVfbWFw
cGVkKGRldikpCj4+PiArCQllcnIgPSBpb21tdV9wcm9iZV9kZXZpY2UoZGV2KTsKPj4gUHJldmlv
dXNseSB3ZSBoYWQ6Cj4+ICDCoMKgwqAgaWYgKCFlcnIpIHsKPj4gIMKgwqDCoCDCoMKgwqAgb3Bz
ID0gaW9ydF9md3NwZWNfaW9tbXVfb3BzKGRldik7Cj4+ICDCoMKgwqAgwqDCoMKgIGVyciA9IGlv
cnRfYWRkX2RldmljZV9yZXBsYXkoZGV2KTsKPj4gIMKgwqDCoCB9Cj4+Cj4+IFBsZWFzZSBjYW4g
eW91IGV4cGxhaW4gdGhlIHRyYW5zZm9ybT8gSSBzZWUgdGhlCj4+Cj4+IGFjcGlfaW9tbXVfZndz
cGVjX29wcyBjYWxsIGJlbG93IGJ1dCBpcyBpdCBub3Qgc3RyYWlnaHRmb3J3YXJkIHRvIG1lLgo+
IAo+IEkgZmlndXJlZCB0aGF0IGlvcnRfYWRkX2RldmljZV9yZXBsYXkoKSBpcyBvbmx5IHVzZWQg
b25jZSBhbmQgaXMKPiBzdWZmaWNpZW50bHkgc2ltcGxlIHRvIGJlIGlubGluZWQgbWFudWFsbHkg
KHNhdmluZyAxMCBsaW5lcykuIFRoZW4gSQo+IHJlcGxhY2VkIHRoZSBvcHMgYXNzaWdubWVudCB3
aXRoIHJldHVybnMsIHdoaWNoIHNhdmVzIGFub3RoZXIgbGluZSBhbmQgbWF5Cj4gYmUgc2xpZ2h0
bHkgY2xlYXJlcj8gIEkgZ3Vlc3MgaXQncyBtb3N0bHkgYSBtYXR0ZXIgb2YgdGFzdGUsIHRoZSBi
ZWhhdmlvcgo+IHNob3VsZCBiZSBleGFjdGx5IHRoZSBzYW1lLgoKUmlnaHQsIElJUkMgdGhlIG11
bHRpcGxlIGFzc2lnbm1lbnRzIHRvIG9wcyB3ZXJlIG1vcmUgb2YgYSBoYXBoYXphcmQgCmV2b2x1
dGlvbiBpbmhlcml0ZWQgZnJvbSB0aGUgRFQgdmVyc2lvbiwgYW5kIGxvb2tpbmcgYXQgaXQgbm93
IEkgdGhpbmsgCnRoZSBtdWx0aXBsZS1yZXR1cm4gaXMgaW5kZWVkIGEgYml0IG5pY2VyLgoKU2lt
aWxhcmx5LCBpdCBsb29rcyBsaWtlIHRoZSBmYWN0b3Jpbmcgb3V0IG9mIGlvcnRfYWRkX2Rldmlj
ZV9yZXBsYXkoKSAKd2FzIG9yaWdpbmFsbHkgYW4gYXR0ZW1wdCB0byBlbmNhcHN1bGF0ZSB0aGUg
SU9NTVVfQVBJIGRlcGVuZGVuY3ksIGJ1dCAKdGhpbmdzIGhhdmUgbW92ZWQgYXJvdW5kIGEgbG90
IHNpbmNlIHRoZW4sIHNvIHRoYXQgc2VlbXMgbGlrZSBhIHNlbnNpYmxlIApzaW1wbGlmaWNhdGlv
biB0byBtYWtlIHRvby4KClJvYmluLgoKPiAKPj4gQWxzbyB0aGUgY29tbWVudCBtZW50aW9ucyBy
ZXBsYXkuIFVuc3VyZSBpZiBpdCBpcyBzdGlsbCBPSy4KPiAKPiBUaGUgInJlcGxheSIgcGFydCBp
cywgYnV0ICJhZGRfZGV2aWNlIiBpc24ndCBhY2N1cmF0ZSBiZWNhdXNlIGl0IGhhcyBzaW5jZQo+
IGJlZW4gcmVwbGFjZWQgYnkgcHJvYmVfZGV2aWNlLiBJJ2xsIHJlZnJlc2ggdGhlIGNvbW1lbnQu
Cj4gCj4gVGhhbmtzLAo+IEplYW4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+IGlvbW11IG1haWxpbmcgbGlzdAo+IGlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCj4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXUKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
