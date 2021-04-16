Return-Path: <SRS0=5KLU=JN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5103FC43462
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 02:42:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00206101B
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 02:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00206101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BAFE60DBE;
	Fri, 16 Apr 2021 02:42:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jaWfsERODm1A; Fri, 16 Apr 2021 02:42:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2644060DB0;
	Fri, 16 Apr 2021 02:42:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEDC9C000E;
	Fri, 16 Apr 2021 02:42:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC534C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A27C640E5E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W5MkkRYb2G14
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:42:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FE8440E9C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:42:36 +0000 (UTC)
IronPort-SDR: 5ejfyjxfsyX+vNsB/qRVfwb5TPdVy5F3BDCkVV++xEuLC5Pzj9upV6XqFwwSG6691Dla/XGdLd
 QO+J0kez17Lg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="174474290"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; d="scan'208";a="174474290"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 19:42:35 -0700
IronPort-SDR: oCpKOHXPVkd9xhaUJhOgUWuyrYg5UdcM4noz9G0FOIgZeej2MtyPEhRYDxhwGZNXi9v1E/cdiC
 sX/2BvZj+g6A==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; d="scan'208";a="418971473"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.254.208.190])
 ([10.254.208.190])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 19:42:32 -0700
Subject: Re: [PATCH V2 3/3] vDPA/ifcvf: get_config_size should return dev
 specific config size
To: Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
References: <20210415095336.4792-1-lingshan.zhu@intel.com>
 <20210415095336.4792-4-lingshan.zhu@intel.com>
 <20210415134838.3hn33estolycag4p@steredhat>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <e1abd531-d8f9-d9ba-3dfe-2eafcd75c58f@linux.intel.com>
Date: Fri, 16 Apr 2021 10:42:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415134838.3hn33estolycag4p@steredhat>
Content-Language: en-US
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CgpPbiA0LzE1LzIwMjEgOTo0OCBQTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IE9uIFRo
dSwgQXByIDE1LCAyMDIxIGF0IDA1OjUzOjM2UE0gKzA4MDAsIFpodSBMaW5nc2hhbiB3cm90ZToK
Pj4gZ2V0X2NvbmZpZ19zaXplKCkgc2hvdWxkIHJldHVybiB0aGUgc2l6ZSBiYXNlZCBvbiB0aGUg
ZGVjZWN0ZWQKPj4gZGV2aWNlIHR5cGUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hh
biA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4gLS0tCj4+IGRyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMgfCAxOCArKysrKysrKysrKysrKysrKy0KPj4gMSBmaWxlIGNoYW5nZWQsIDE3
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgCj4+IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21h
aW4uYwo+PiBpbmRleCBjZWExMzEzYjFhM2YuLjY4NDRjNDlmZTFkZSAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfbWFpbi5jCj4+IEBAIC0zNDcsNyArMzQ3LDIzIEBAIHN0YXRpYyB1MzIgaWZjdmZf
dmRwYV9nZXRfdnFfYWxpZ24oc3RydWN0IAo+PiB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4+Cj4+
IHN0YXRpYyBzaXplX3QgaWZjdmZfdmRwYV9nZXRfY29uZmlnX3NpemUoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZHBhX2RldikKPj4gewo+PiAtwqDCoMKgIHJldHVybiBzaXplb2Yoc3RydWN0IHZpcnRp
b19uZXRfY29uZmlnKTsKPj4gK8KgwqDCoCBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlciA9
IHZkcGFfdG9fYWRhcHRlcih2ZHBhX2Rldik7Cj4+ICvCoMKgwqAgc3RydWN0IGlmY3ZmX2h3ICp2
ZiA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+PiArwqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpwZGV2
ID0gYWRhcHRlci0+cGRldjsKPj4gK8KgwqDCoCBzaXplX3Qgc2l6ZTsKPj4gKwo+PiArwqDCoMKg
IGlmICh2Zi0+ZGV2X3R5cGUgPT0gVklSVElPX0lEX05FVCkKPj4gK8KgwqDCoMKgwqDCoMKgIHNp
emUgPSBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnKTsKPj4gKwo+PiArwqDCoMKgIGVs
c2UgaWYgKHZmLT5kZXZfdHlwZSA9PSBWSVJUSU9fSURfQkxPQ0spCj4+ICvCoMKgwqDCoMKgwqDC
oCBzaXplID0gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZyk7Cj4+ICsKPj4gK8KgwqDC
oCBlbHNlIHsKPj4gK8KgwqDCoMKgwqDCoMKgIHNpemUgPSAwOwo+PiArwqDCoMKgwqDCoMKgwqAg
SUZDVkZfRVJSKHBkZXYsICJWSVJUSU8gSUQgJXUgbm90IHN1cHBvcnRlZFxuIiwgdmYtPmRldl90
eXBlKTsKPj4gK8KgwqDCoCB9Cj4KPiBJIHNsaWdodGx5IHByZWZlciB0aGUgc3dpdGNoLCBidXQg
SSBkb24ndCBoYXZlIGEgc3Ryb25nIG9waW5pb24uCj4KPiBIb3dldmVyLCBpZiB3ZSB3YW50IHRv
IHVzZSBpZi9lbHNlLCB3ZSBzaG91bGQgZm9sbG93IAo+IGBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mv
Y29kaW5nLXN0eWxlLnJzdGAgbGluZSAxNjY6Cj4gwqDCoCBOb3RlIHRoYXQgdGhlIGNsb3Npbmcg
YnJhY2UgaXMgZW1wdHkgb24gYSBsaW5lIG9mIGl0cyBvd24sIAo+ICoqZXhjZXB0KiogaW4KPiDC
oMKgIHRoZSBjYXNlcyB3aGVyZSBpdCBpcyBmb2xsb3dlZCBieSBhIGNvbnRpbnVhdGlvbiBvZiB0
aGUgc2FtZSAKPiBzdGF0ZW1lbnQsCj4gwqDCoCBpZSBhIGBgd2hpbGVgYCBpbiBhIGRvLXN0YXRl
bWVudCBvciBhbiBgYGVsc2VgYCBpbiBhbiBpZi1zdGF0ZW1lbnQsIAo+IGxpa2UKPgo+IGFsc28g
YHNjcmlwdHMvY2hlY2twYXRjaC5wbCAtLXN0cmljdGAgY29tcGxhaW5zOgo+Cj4gwqDCoCBDSEVD
SzogYnJhY2VzIHt9IHNob3VsZCBiZSB1c2VkIG9uIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50
Cj4gwqDCoCAjMjA5OiBGSUxFOiBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jOjM1NToK
PiDCoMKgICvCoMKgwqAgaWYgKHZmLT5kZXZfdHlwZSA9PSBWSVJUSU9fSURfTkVUKQo+IMKgwqAg
Wy4uLl0KPiDCoMKgICvCoMKgwqAgZWxzZSBpZiAodmYtPmRldl90eXBlID09IFZJUlRJT19JRF9C
TE9DSykKPiDCoMKgIFsuLi5dCj4gwqDCoCArwqDCoMKgIGVsc2Ugewo+IMKgwqAgWy4uLl0KPgo+
IMKgwqAgQ0hFQ0s6IFVuYmFsYW5jZWQgYnJhY2VzIGFyb3VuZCBlbHNlIHN0YXRlbWVudAo+IMKg
wqAgIzIxNTogRklMRTogZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYzozNjE6Cj4gwqDC
oCArwqDCoMKgIGVsc2UgewpUaGFua3MgU3RlZmFubywgdGhlIHJlYXNvbiBpcyB3ZSBvbmx5IGhh
dmUgb25lIGxpbmUgY29kZSBhZnRlciBpZiwgc28gCmxvb2tzIGxpa2Uge30gaXMgdW5uZWNlc3Nh
cnksIEkgYWdyZWUgc3dpdGNoIGNhbiBjbGVhciB1cApjb2RlIHN0eWxlIGNvbmZ1c2lvbnMuIEkg
d2lsbCBhZGQgdGhpcyBpbiB2My4KClRoYW5rcyEKPgo+IFRoYW5rcywKPiBTdGVmYW5vCj4KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IFZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdAo+IFZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCj4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
