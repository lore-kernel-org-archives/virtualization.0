Return-Path: <SRS0=He06=CN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012CFC433E2
	for <virtualization@archiver.kernel.org>; Fri,  4 Sep 2020 13:21:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD29C206F2
	for <virtualization@archiver.kernel.org>; Fri,  4 Sep 2020 13:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD29C206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 56E13204C2;
	Fri,  4 Sep 2020 13:21:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q9jfius4fVkS; Fri,  4 Sep 2020 13:21:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9B25A20373;
	Fri,  4 Sep 2020 13:21:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8842AC0052;
	Fri,  4 Sep 2020 13:21:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79C7EC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 56B5F20382
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GrF8U6WEMBwY
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:21:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id 3439C20373
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:21:38 +0000 (UTC)
IronPort-SDR: Na8RJZ41+M9N3meGE+c9AKpwljOZZRgIKxxMXIL5TbV4nni2YKkKDgkDYBAgBQvDheKvX4lyL6
 aMKeoD8CjdgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="158715321"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; d="scan'208";a="158715321"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2020 06:21:32 -0700
IronPort-SDR: GVEmm+AS0LUgCFVWnMaPUMTwypXJhlRmQz6ETS/DmQMqwHPgCMjahAIqYl98J7tCXF5xoK5ZLy
 KVRU5NE9fMTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; d="scan'208";a="334883693"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.215.253.127])
 ([10.215.253.127])
 by fmsmga002.fm.intel.com with ESMTP; 04 Sep 2020 06:21:12 -0700
Subject: Re: [PATCH] i2c: virtio: add a virtio i2c frontend driver
To: Jason Wang <jasowang@redhat.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <0efc2605c8c06b4b1bf68cbad5536c4a900dc019.1599110284.git.jie.deng@intel.com>
 <18828d17-c3ac-31bd-2dcf-ecdbd4ad844e@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <e63a96bf-65d2-ed03-dadc-42d1d8808c9d@intel.com>
Date: Fri, 4 Sep 2020 21:21:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <18828d17-c3ac-31bd-2dcf-ecdbd4ad844e@redhat.com>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, mst@redhat.com, krzk@kernel.org,
 tali.perry1@gmail.com, wsa@kernel.org, wsa+renesas@sang-engineering.com,
 jarkko.nikula@linux.intel.com, rppt@kernel.org, shuo.a.liu@intel.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, jdelvare@suse.de
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

Ck9uIDIwMjAvOS80IDEyOjA2LCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2kyYy9idXNzZXMvS2NvbmZpZyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9LY29uZmlnCj4+
IGluZGV4IDI5M2U3YTAuLjcwYzhlMzAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nl
cy9LY29uZmlnCj4+ICsrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9LY29uZmlnCj4+IEBAIC0yMSw2
ICsyMSwxNyBAQCBjb25maWcgSTJDX0FMSTE1MzUKPj4gwqDCoMKgwqDCoMKgwqAgVGhpcyBkcml2
ZXIgY2FuIGFsc28gYmUgYnVpbHQgYXMgYSBtb2R1bGUuwqAgSWYgc28sIHRoZSBtb2R1bGUKPj4g
wqDCoMKgwqDCoMKgwqAgd2lsbCBiZSBjYWxsZWQgaTJjLWFsaTE1MzUuCj4+IMKgICtjb25maWcg
STJDX1ZJUlRJTwo+PiArwqDCoMKgIHRyaXN0YXRlICJWaXJ0aW8gSTJDIEFkYXB0ZXIiCj4+ICvC
oMKgwqAgZGVwZW5kcyBvbiBWSVJUSU8KPgo+Cj4gSSBndWVzcyBpdCBzaG91bGQgZGVwZW5kIG9u
IHNvbWUgSTJDIG1vZHVsZSBoZXJlLgo+ClRoZSBkZXBlbmRlbmN5IG9mIEkyQyBpcyBpbmNsdWRl
ZCBpbiB0aGUgS2NvbmZpZyBpbiBpdHMgcGFyZW50IGRpcmVjdG9yeS4KU28gdGhlcmUgaXMgbm90
aGluZyBzcGVjaWFsIHRvIGFkZCBoZXJlLgoKCj4KPj4KPj4gK3N0cnVjdCB2aXJ0aW9faTJjX21z
ZyB7Cj4+ICvCoMKgwqAgc3RydWN0IHZpcnRpb19pMmNfaGRyIGhkcjsKPj4gK8KgwqDCoCBjaGFy
ICpidWY7Cj4+ICvCoMKgwqAgdTggc3RhdHVzOwo+Cj4KPiBBbnkgcmVhc29uIGZvciBzZXBhcmF0
aW5nIHN0YXR1cyBvdXQgb2YgdmlydGlvX2kyY19oZHI/Cj4KVGhlIHN0YXR1cyBpcyBub3QgZnJv
bSBpMmNfbXNnLiBTbyBJIHB1dCBpdCBvdXQgb2YgdmlydGlvX2kyY19oZHIuCgo+Cj4+ICt9Owo+
PiArCj4+ICsvKioKPj4gKyAqIHN0cnVjdCB2aXJ0aW9faTJjIC0gdmlydGlvIEkyQyBkYXRhCj4+
ICsgKiBAdmRldjogdmlydGlvIGRldmljZSBmb3IgdGhpcyBjb250cm9sbGVyCj4+ICsgKiBAY29t
cGxldGlvbjogY29tcGxldGlvbiBvZiB2aXJ0aW8gSTJDIG1lc3NhZ2UKPj4gKyAqIEBhZGFwOiBJ
MkMgYWRhcHRlciBmb3IgdGhpcyBjb250cm9sbGVyCj4+ICsgKiBAaTJjX2xvY2s6IGxvY2sgZm9y
IHZpcnRxdWV1ZSBwcm9jZXNzaW5nCj4+ICsgKiBAdnE6IHRoZSB2aXJ0aW8gdmlydHF1ZXVlIGZv
ciBjb21tdW5pY2F0aW9uCj4+ICsgKi8KPj4gK3N0cnVjdCB2aXJ0aW9faTJjIHsKPj4gK8KgwqDC
oCBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldjsKPj4gK8KgwqDCoCBzdHJ1Y3QgY29tcGxldGlv
biBjb21wbGV0aW9uOwo+PiArwqDCoMKgIHN0cnVjdCBpMmNfYWRhcHRlciBhZGFwOwo+PiArwqDC
oMKgIHN0cnVjdCBtdXRleCBpMmNfbG9jazsKPj4gK8KgwqDCoCBzdHJ1Y3QgdmlydHF1ZXVlICp2
cTsKPj4gK307Cj4+ICsKPj4gK3N0YXRpYyB2b2lkIHZpcnRpb19pMmNfbXNnX2RvbmUoc3RydWN0
IHZpcnRxdWV1ZSAqdnEpCj4+ICt7Cj4+ICvCoMKgwqAgc3RydWN0IHZpcnRpb19pMmMgKnZpID0g
dnEtPnZkZXYtPnByaXY7Cj4+ICsKPj4gK8KgwqDCoCBjb21wbGV0ZSgmdmktPmNvbXBsZXRpb24p
Owo+PiArfQo+PiArCj4+ICtzdGF0aWMgaW50IHZpcnRpb19pMmNfYWRkX21zZyhzdHJ1Y3Qgdmly
dHF1ZXVlICp2cSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0
IHZpcnRpb19pMmNfbXNnICp2bXNnLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgaTJjX21zZyAqbXNnKQo+PiArewo+PiArwqDCoMKgIHN0cnVjdCBzY2F0dGVy
bGlzdCAqc2dzWzNdLCBoZHIsIGJvdXQsIGJpbiwgc3RhdHVzOwo+PiArwqDCoMKgIGludCBvdXRj
bnQgPSAwLCBpbmNudCA9IDA7Cj4+ICsKPj4gK8KgwqDCoCBpZiAoIW1zZy0+bGVuKQo+PiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+ICsKPj4gK8KgwqDCoCB2bXNnLT5oZHIuYWRk
ciA9IG1zZy0+YWRkcjsKPj4gK8KgwqDCoCB2bXNnLT5oZHIuZmxhZ3MgPSBtc2ctPmZsYWdzOwo+
PiArwqDCoMKgIHZtc2ctPmhkci5sZW4gPSBtc2ctPmxlbjsKPgo+Cj4gTWlzc2luZyBlbmRpYW4g
Y29udmVyc2lvbj8KPgpZb3UgYXJlIHJpZ2h0LiBOZWVkIGNvbnZlcnNpb24gaGVyZS4KPgo+PiAr
Cj4+ICvCoMKgwqAgdm1zZy0+YnVmID0ga3phbGxvYyh2bXNnLT5oZHIubGVuLCBHRlBfS0VSTkVM
KTsKPj4gK8KgwqDCoCBpZiAoIXZtc2ctPmJ1ZikKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAt
RU5PTUVNOwo+PiArCj4+ICvCoMKgwqAgc2dfaW5pdF9vbmUoJmhkciwgJnZtc2ctPmhkciwgc2l6
ZW9mKHN0cnVjdCB2aXJ0aW9faTJjX2hkcikpOwo+PiArwqDCoMKgIHNnc1tvdXRjbnQrK10gPSAm
aGRyOwo+PiArwqDCoMKgIGlmICh2bXNnLT5oZHIuZmxhZ3MgJiBJMkNfTV9SRCkgewo+PiArwqDC
oMKgwqDCoMKgwqAgc2dfaW5pdF9vbmUoJmJpbiwgdm1zZy0+YnVmLCBtc2ctPmxlbik7Cj4+ICvC
oMKgwqDCoMKgwqDCoCBzZ3Nbb3V0Y250ICsgaW5jbnQrK10gPSAmYmluOwo+PiArwqDCoMKgIH0g
ZWxzZSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBtZW1jcHkodm1zZy0+YnVmLCBtc2ctPmJ1ZiwgbXNn
LT5sZW4pOwo+PiArwqDCoMKgwqDCoMKgwqAgc2dfaW5pdF9vbmUoJmJvdXQsIHZtc2ctPmJ1Ziwg
bXNnLT5sZW4pOwo+PiArwqDCoMKgwqDCoMKgwqAgc2dzW291dGNudCsrXSA9ICZib3V0Owo+PiAr
wqDCoMKgIH0KPj4gK8KgwqDCoCBzZ19pbml0X29uZSgmc3RhdHVzLCAmdm1zZy0+c3RhdHVzLCBz
aXplb2Yodm1zZy0+c3RhdHVzKSk7Cj4+ICvCoMKgwqAgc2dzW291dGNudCArIGluY250KytdID0g
JnN0YXR1czsKPj4gKwo+PiArwqDCoMKgIHJldHVybiB2aXJ0cXVldWVfYWRkX3Nncyh2cSwgc2dz
LCBvdXRjbnQsIGluY250LCB2bXNnLCBHRlBfS0VSTkVMKTsKPj4gK30KPj4gKwo+PiArc3RhdGlj
IGludCB2aXJ0aW9faTJjX3hmZXIoc3RydWN0IGkyY19hZGFwdGVyICphZGFwLCBzdHJ1Y3QgaTJj
X21zZyAKPj4gKm1zZ3MsIGludCBudW0pCj4+ICt7Cj4+ICvCoMKgwqAgc3RydWN0IHZpcnRpb19p
MmMgKnZpID0gaTJjX2dldF9hZGFwZGF0YShhZGFwKTsKPj4gK8KgwqDCoCBzdHJ1Y3QgdmlydGlv
X2kyY19tc2cgKnZtc2dfbywgKnZtc2dfaTsKPj4gK8KgwqDCoCBzdHJ1Y3QgdmlydHF1ZXVlICp2
cSA9IHZpLT52cTsKPj4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIHRpbWVfbGVmdDsKPj4gK8KgwqDC
oCBpbnQgbGVuLCBpLCByZXQgPSAwOwo+PiArCj4+ICvCoMKgwqAgdm1zZ19vID0ga3phbGxvYyhz
aXplb2YoKnZtc2dfbyksIEdGUF9LRVJORUwpOwo+PiArwqDCoMKgIGlmICghdm1zZ19vKQo+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07Cj4KPgo+IEl0IGxvb2tzIHRvIG1lIHdlIGNh
biBhdm9pZCB0aGUgYWxsb2NhdGlvbiBieSBlbWJlZGRpbmcgdmlydGlvX2kyY19tc2cgCj4gaW50
byBzdHJ1Y3QgdmlydGlvX2kyYzsKPgpZZWFoLi4uIFRoYXQncyBiZXR0ZXIuIFRoYW5rcy4KCgo+
Cj4+ICsKPj4gK8KgwqDCoCBtdXRleF9sb2NrKCZ2aS0+aTJjX2xvY2spOwo+PiArwqDCoMKgIHZt
c2dfby0+YnVmID0gTlVMTDsKPj4gK8KgwqDCoCBmb3IgKGkgPSAwOyBpIDwgbnVtOyBpKyspIHsK
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IHZpcnRpb19pMmNfYWRkX21zZyh2cSwgdm1zZ19vLCAm
bXNnc1tpXSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocmV0KSB7Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRldl9lcnIoJmFkYXAtPmRldiwgImZhaWxlZCB0byBhZGQgbXNnWyVkXSB0byAK
Pj4gdmlydHF1ZXVlLlxuIiwgaSk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJy
X3VubG9ja19mcmVlOwo+PiArwqDCoMKgwqDCoMKgwqAgfQo+PiArCj4+ICvCoMKgwqDCoMKgwqDC
oCB2aXJ0cXVldWVfa2ljayh2cSk7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIHRpbWVfbGVmdCA9
IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmdmktPmNvbXBsZXRpb24sIAo+PiBhZGFwLT50
aW1lb3V0KTsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghdGltZV9sZWZ0KSB7Cj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoJmFkYXAtPmRldiwgIm1zZ1slZF06IGFkZHI9MHgleCB0
aW1lb3V0LlxuIiwgaSwgCj4+IG1zZ3NbaV0uYWRkcik7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldCA9IGk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX3VubG9ja19m
cmVlOwo+PiArwqDCoMKgwqDCoMKgwqAgfQo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoCB2bXNnX2kg
PSAoc3RydWN0IHZpcnRpb19pMmNfbXNnICopdmlydHF1ZXVlX2dldF9idWYodnEsICZsZW4pOwo+
PiArwqDCoMKgwqDCoMKgwqAgaWYgKHZtc2dfaSkgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAvKiB2bXNnX2kgc2hvdWxkIHBvaW50IHRvIHRoZSBzYW1lIGFkZHJlc3Mgd2l0aCB2bXNnX28g
Ki8KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHZtc2dfaSAhPSB2bXNnX28pIHsKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKCZhZGFwLT5kZXYsICJtc2db
JWRdOiBhZGRyPTB4JXggdmlydHF1ZXVlIAo+PiBlcnJvci5cbiIsCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpLCB2bXNnX2ktPmhkci5hZGRyKTsKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdvdG8gZXJyX3VubG9ja19mcmVlOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9Cj4KPgo+IERvZXMgdGhpcyBpbXBseSBpbiBvcmRlciBjb21wbGV0aW9uIG9mIGkyYyBk
ZXZpY2U/wqAgKEUuZyB3aGF0IGhhcHBlbnMgCj4gaWYgbXVsdGlwbGUgdmlydGlvIGkyYyByZXF1
ZXN0cyBhcmUgc3VibWl0dGVkKQo+Cj4gQnR3LCB0aGlzIGFsd2F5cyB1c2UgYSBzaW5nbGUgZGVz
Y3JpcHRvciBvbmNlIGEgdGltZSB3aGljaCBtYWtlcyBtZSAKPiBzdXNwZWN0IGlmIGEgdmlydHF1
ZXVlKHZpcnRpbykgaXMgcmVhbGx5IG5lZWRlZC4gSXQgbG9va3MgdG8gbWUgd2UgY2FuIAo+IHV0
aWxpemUgdGhlIHZpcnRxdWV1ZSBieSBzdWJtaXQgdGhlIHJlcXVlc3QgaW4gYSBiYXRjaC4KPgpJ
J20gYWZyYWlkIG5vdCBhbGwgcGh5c2ljYWwgZGV2aWNlcyBzdXBwb3J0IGJhdGNoLiBJJ2QgbGlr
ZSB0byBrZWVwIHRoZSAKY3VycmVudCBkZXNpZ24gYW5kIGNvbnNpZGVyCnlvdXIgc3VnZ2VzdGlv
biBhcyBhIHBvc3NpYmxlIG9wdGltaXphdGlvbiBpbiB0aGUgZnV0dXJlLgoKVGhhbmtzLgoKCj4+
Cj4+ICt9Cj4+ICsKPj4gK3N0YXRpYyB2b2lkIHZpcnRpb19pMmNfZGVsX3ZxcyhzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldikKPj4gK3sKPj4gK8KgwqDCoCB2ZGV2LT5jb25maWctPnJlc2V0KHZk
ZXYpOwo+Cj4KPiBXaHkgbmVlZCByZXNldCBoZXJlPwo+Cj4gVGhhbmtzCj4KSSdtIGZvbGxvd2lu
ZyB3aGF0IG90aGVyIHZpcnRpbyBkcml2ZXJzIGRvLgpUaGV5IHJlc2V0IHRoZSBkZXZpY2VzIGJl
Zm9yZSB0aGV5IGNsZWFuIHVwIHRoZSBxdWV1ZXMuCgoKPgo+PiArwqDCoMKgIHZkZXYtPmNvbmZp
Zy0+ZGVsX3Zxcyh2ZGV2KTsKPj4gK30KPj4gKwo+PiArc3RhdGljIGludCB2aXJ0aW9faTJjX3Nl
dHVwX3ZxcyhzdHJ1Y3QgdmlydGlvX2kyYyAqdmkpCj4+ICt7Cj4+ICvCoMKgwqAgc3RydWN0IHZp
cnRpb19kZXZpY2UgKnZkZXYgPSB2aS0+dmRldjsKPj4gKwo+PiArwqDCoMKgIHZpLT52cSA9IHZp
cnRpb19maW5kX3NpbmdsZV92cSh2ZGV2LCB2aXJ0aW9faTJjX21zZ19kb25lLCAKPj4gImkyYy1t
c2ciKTsKPgo+Cj4gV2UndmUgaW4gdGhlIHNjb3BlIG9mIGljMiwgc28gIm1zZyIgc2hvdWxkIGJl
IHN1ZmZpY2llbnQuCj4KPgpPSy4gV2lsbCBjaGFuZ2UgdGhpcyBuYW1lLiBUaGFua3MuCgoKPj4g
K8KgwqDCoCByZXR1cm4gUFRSX0VSUl9PUl9aRVJPKHZpLT52cSk7Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
