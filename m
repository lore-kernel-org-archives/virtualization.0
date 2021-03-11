Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC46C433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 04:21:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9520764F79
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 04:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9520764F79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F4ED83E1E;
	Thu, 11 Mar 2021 04:21:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i4Zv8tPRJJd6; Thu, 11 Mar 2021 04:21:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE49C83DA4;
	Thu, 11 Mar 2021 04:21:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB286C000A;
	Thu, 11 Mar 2021 04:21:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0FC1C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 04:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A4A44C51B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 04:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vnH8WnXqFlca
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 04:21:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A73094BA7C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 04:21:51 +0000 (UTC)
IronPort-SDR: zNa+rSqhgYeXhMWznAnWQ7ab3WBVmoVU7jBsCpoHIL4uIv88Xqg2iHJkKnuCO9Xm0H8k7tg3OH
 yYlWwSvJdp6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="208424774"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; d="scan'208";a="208424774"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 20:21:50 -0800
IronPort-SDR: 55TR9K9caS5NVQLkbSlzyZ3lHQOoazlWGFpZarFnzMTjZ9KbQwjDgIGXQWNDyxVz7Z70qQVMJU
 OaEJ8EA0Vsqw==
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; d="scan'208";a="410467824"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.249.170.224])
 ([10.249.170.224])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 20:21:48 -0800
Subject: Re: [PATCH V3 1/6] vDPA/ifcvf: get_vendor_id returns a device
 specific vendor id
To: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 mst@redhat.com, lulu@redhat.com, leonro@nvidia.com
References: <20210310090052.4762-1-lingshan.zhu@intel.com>
 <20210310090052.4762-2-lingshan.zhu@intel.com>
 <ff5fc8f9-f886-bd2a-60cc-771c628c6c4b@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <5f2d915f-e1b0-c9eb-9fc8-4b64f5d8cd0f@linux.intel.com>
Date: Thu, 11 Mar 2021 12:21:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ff5fc8f9-f886-bd2a-60cc-771c628c6c4b@redhat.com>
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

CgpPbiAzLzExLzIwMjEgMTE6MjMgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4KPiBPbiAyMDIxLzMv
MTAgNTowMCDkuIvljYgsIFpodSBMaW5nc2hhbiB3cm90ZToKPj4gSW4gdGhpcyBjb21taXQsIGlm
Y3ZmX2dldF92ZW5kb3JfaWQoKSB3aWxsIHJldHVybgo+PiBhIGRldmljZSBzcGVjaWZpYyB2ZW5k
b3IgaWQgb2YgdGhlIHByb2JlZCBwY2kgZGV2aWNlCj4+IHRoYW4gYSBoYXJkIGNvZGUuCj4+Cj4+
IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4g
LS0tCj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCA1ICsrKystCj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgCj4+IGIvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+PiBpbmRleCBmYTFhZjMwMWNmNTUuLmU1MDFlZTA3ZGUx
NyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+PiArKysg
Yi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+IEBAIC0zMjQsNyArMzI0LDEwIEBA
IHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9nZXRfZGV2aWNlX2lkKHN0cnVjdCAKPj4gdmRwYV9kZXZp
Y2UgKnZkcGFfZGV2KQo+PiDCoCDCoCBzdGF0aWMgdTMyIGlmY3ZmX3ZkcGFfZ2V0X3ZlbmRvcl9p
ZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+PiDCoCB7Cj4+IC3CoMKgwqAgcmV0dXJu
IElGQ1ZGX1NVQlNZU19WRU5ET1JfSUQ7Cj4+ICvCoMKgwqAgc3RydWN0IGlmY3ZmX2FkYXB0ZXIg
KmFkYXB0ZXIgPSB2ZHBhX3RvX2FkYXB0ZXIodmRwYV9kZXYpOwo+PiArwqDCoMKgIHN0cnVjdCBw
Y2lfZGV2ICpwZGV2ID0gYWRhcHRlci0+cGRldjsKPj4gKwo+PiArwqDCoMKgIHJldHVybiBwZGV2
LT5zdWJzeXN0ZW1fdmVuZG9yOwo+PiDCoCB9Cj4KPgo+IFdoaWxlIGF0IHRoaXMsIEkgd29uZGVy
IGlmIHdlIGNhbiBkbyBzb21ldGhpbmcgc2ltaWxhciBpbiAKPiBnZXRfZGV2aWNlX2lkKCkgaWYg
aXQgY291bGQgYmUgc2ltcGxlIGRlZHVjZWQgZnJvbSBzb21lIHNpbXBsZSBtYXRoIAo+IGZyb20g
dGhlIHBjaSBkZXZpY2UgaWQ/Cj4KPiBUaGFua3MKSGkgSmFzb24sCgpJTUhPLCB0aGlzIGltcGxl
bWVudGF0aW9uIGlzIGp1c3Qgc29tZSBtZW1vcnkgcmVhZCBvcHMsIEkgdGhpbmsgb3RoZXIgCmlt
cGxlbWVudGF0aW9ucyBtYXkgbm90IHNhdmUgbWFueSBjcHUgY3ljbGVzLCBhbiBpZiBjb3N0IGF0
IGxlYXN0IHRocmVlIApjcHUgY3ljbGVzLgoKVGhhbmtzIQo+Cj4KPj4gwqAgwqAgc3RhdGljIHUz
MiBpZmN2Zl92ZHBhX2dldF92cV9hbGlnbihzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
