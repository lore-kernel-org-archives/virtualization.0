Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA02C433E0
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 04:23:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E61864F99
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 04:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E61864F99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF67683DAB;
	Thu, 11 Mar 2021 04:23:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9NXAt_McEF_S; Thu, 11 Mar 2021 04:23:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5568983E34;
	Thu, 11 Mar 2021 04:23:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C6C3C000A;
	Thu, 11 Mar 2021 04:23:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB5C3C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 04:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8540A43008
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 04:23:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eoF21oQCywCb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 04:23:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F0E1043002
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 04:23:52 +0000 (UTC)
IronPort-SDR: aFSCHXyNZ77321E/iikKrw/LmJUOnlrgs2wTeICUs+85qk90bZHViSiL4EKxTW/J/bKPf2HdpW
 jVD9mPMFUiyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="187975104"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; d="scan'208";a="187975104"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 20:23:52 -0800
IronPort-SDR: fEmxznOusV/EE//0QLoDz7Fhmh9dS9730zuo/CNMC2b1gT+6vjt1Gr1uWtlus2v/69m3+HqoFB
 0WpLbgNgCLig==
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; d="scan'208";a="410468138"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.249.170.224])
 ([10.249.170.224])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 20:23:49 -0800
Subject: Re: [PATCH V3 3/6] vDPA/ifcvf: rename original IFCVF dev ids to N3000
 ids
To: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 mst@redhat.com, lulu@redhat.com, leonro@nvidia.com
References: <20210310090052.4762-1-lingshan.zhu@intel.com>
 <20210310090052.4762-4-lingshan.zhu@intel.com>
 <5e2b22cc-7faa-2987-a30a-ce32f10099b6@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <4472d8f3-ef44-37a0-8ee1-82caa4a0a843@linux.intel.com>
Date: Thu, 11 Mar 2021 12:23:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <5e2b22cc-7faa-2987-a30a-ce32f10099b6@redhat.com>
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

CgpPbiAzLzExLzIwMjEgMTE6MjUgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4KPiBPbiAyMDIxLzMv
MTAgNTowMCDkuIvljYgsIFpodSBMaW5nc2hhbiB3cm90ZToKPj4gSUZDVkYgZHJpdmVyIHByb2Jl
cyBtdWx0aXBsZSB0eXBlcyBvZiBkZXZpY2VzIG5vdywKPj4gdG8gZGlzdGluZ3Vpc2ggdGhlIG9y
aWdpbmFsIGRldmljZSBkcml2ZW4gYnkgSUZDVkYKPj4gZnJvbSBvdGhlcnMsIGl0IGlzIHJlbmFt
ZWQgYXMgIk4zMDAwIi4KPj4KPj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hh
bi56aHVAaW50ZWwuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jh
c2UuaCB8IDggKysrKy0tLS0KPj4gwqAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8
IDggKysrKy0tLS0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFz
ZS5oIAo+PiBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4gaW5kZXggNzVkOWE4
MDUyMDM5Li43OTRkMTUwNWQ4NTcgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9iYXNlLmgKPj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+PiBA
QCAtMTgsMTAgKzE4LDEwIEBACj4+IMKgICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19jb25m
aWcuaD4KPj4gwqAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX3BjaS5oPgo+PiDCoCAtI2Rl
ZmluZSBJRkNWRl9WRU5ET1JfSUTCoMKgwqDCoMKgwqDCoCAweDFBRjQKPj4gLSNkZWZpbmUgSUZD
VkZfREVWSUNFX0lEwqDCoMKgwqDCoMKgwqAgMHgxMDQxCj4+IC0jZGVmaW5lIElGQ1ZGX1NVQlNZ
U19WRU5ET1JfSUTCoMKgwqAgMHg4MDg2Cj4+IC0jZGVmaW5lIElGQ1ZGX1NVQlNZU19ERVZJQ0Vf
SUTCoMKgwqAgMHgwMDFBCj4+ICsjZGVmaW5lIE4zMDAwX1ZFTkRPUl9JRMKgwqDCoMKgwqDCoMKg
IDB4MUFGNAo+PiArI2RlZmluZSBOMzAwMF9ERVZJQ0VfSUTCoMKgwqDCoMKgwqDCoCAweDEwNDEK
Pj4gKyNkZWZpbmUgTjMwMDBfU1VCU1lTX1ZFTkRPUl9JRMKgwqDCoCAweDgwODYKPj4gKyNkZWZp
bmUgTjMwMDBfU1VCU1lTX0RFVklDRV9JRMKgwqDCoCAweDAwMUEKPj4gwqAgwqAgI2RlZmluZSBD
NTAwMFhfUExfVkVORE9SX0lEwqDCoMKgwqDCoMKgwqAgMHgxQUY0Cj4+IMKgICNkZWZpbmUgQzUw
MDBYX1BMX0RFVklDRV9JRMKgwqDCoMKgwqDCoMKgIDB4MTAwMAo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyAKPj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZj
dmZfbWFpbi5jCj4+IGluZGV4IDI2YTJkYWI3Y2E2Ni4uZmQ1YmVmYzVjYmNjIDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+ICsrKyBiL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4gQEAgLTQ4MCwxMCArNDgwLDEwIEBAIHN0YXRpYyB2b2lk
IGlmY3ZmX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKPj4gwqAgfQo+PiDCoCDCoCBzdGF0
aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQgaWZjdmZfcGNpX2lkc1tdID0gewo+PiAtwqDCoMKgIHsg
UENJX0RFVklDRV9TVUIoSUZDVkZfVkVORE9SX0lELAo+PiAtwqDCoMKgwqDCoMKgwqAgSUZDVkZf
REVWSUNFX0lELAo+PiAtwqDCoMKgwqDCoMKgwqAgSUZDVkZfU1VCU1lTX1ZFTkRPUl9JRCwKPj4g
LcKgwqDCoMKgwqDCoMKgIElGQ1ZGX1NVQlNZU19ERVZJQ0VfSUQpIH0sCj4+ICvCoMKgwqAgeyBQ
Q0lfREVWSUNFX1NVQihOMzAwMF9WRU5ET1JfSUQsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgTjMwMDBfREVWSUNFX0lELAo+Cj4KPiBJIGFtIG5vdCBzdXJlIHRoZSBwbGFuIGZvciBJbnRl
bCBidXQgSSB3b25kZXIgaWYgd2UgY2FuIHNpbXBseSB1c2UgCj4gUENJX0FOWV9JRCBmb3IgZGV2
aWNlIGlkIGhlcmUuIE90aGVyZXdpc2UgeW91IG5lZWQgdG8gbWFpbnRhaW4gYSB2ZXJ5IAo+IGxv
bmcgbGlzdCBvZiBpZHMgaGVyZS4KPgo+IFRoYW5rcwpIaSBKYXNvbiwKClRoYW5rcyEgYnV0IG1h
eWJlIGlmIHdlIHByZXNlbnQgYSB2ZXJ5IHNpbXBsZSBhbmQgY2xlYXIgbGlzdCBsaWtlIHdoYXQg
CmUxMDAwIGRvZXMgY2FuIGhlbHAgdGhlIHVzZXJzIHVuZGVyc3RhbmQgd2hhdCB3ZSBzdXBwb3J0
IGVhc2lseS4KClRoYW5rcyEKPgo+Cj4+ICsgTjMwMDBfU1VCU1lTX1ZFTkRPUl9JRCwKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOMzAwMF9TVUJTWVNfREVWSUNFX0lEKSB9LAo+PiDCoMKg
wqDCoMKgIHsgUENJX0RFVklDRV9TVUIoQzUwMDBYX1BMX1ZFTkRPUl9JRCwKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBDNTAwMFhfUExfREVWSUNFX0lELAo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEM1MDAwWF9QTF9TVUJTWVNfVkVORE9SX0lELAo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
