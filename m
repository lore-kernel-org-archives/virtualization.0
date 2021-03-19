Return-Path: <SRS0=JY8S=IR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13B5C433DB
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 06:30:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C02464F6E
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 06:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C02464F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D7D04C419;
	Fri, 19 Mar 2021 06:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BI9FDgjP8IRX; Fri, 19 Mar 2021 06:30:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D65E4BD65;
	Fri, 19 Mar 2021 06:30:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 247D3C0010;
	Fri, 19 Mar 2021 06:30:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B007C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 06:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28FC94BD65
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 06:29:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3uiJKn0iwmRX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 06:29:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F15404B926
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 06:29:57 +0000 (UTC)
IronPort-SDR: 0EYebypzT0OhiKvUSM8YhFr4oBeDXmPrGPZ3oRKRy73RrnwLv4uA/tJIju9kj0sWFvLVzPB/20
 s5u1wYdSFIgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="209857807"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; d="scan'208";a="209857807"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 23:29:57 -0700
IronPort-SDR: Z+iU2LMcXO03I1DkvriMCElufQFjcq3JHzhwAtDue0CFb74BoeLOj/mXV8+dztJsWfySujgFT2
 YdDwv2g0MmxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; d="scan'208";a="591759461"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga005.jf.intel.com with ESMTP; 18 Mar 2021 23:29:51 -0700
Subject: Re: [PATCH v8] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <c193b92d8d22ba439bb1b260d26d4b76f57d4840.1615889867.git.jie.deng@intel.com>
 <20210316074409.2afwsaeqxuwvj7bd@vireshk-i7>
 <0dfff1ac-50bb-b5bc-72ea-880fd52ed60d@metux.net>
 <CAK8P3a3f9bKdOOMgrA9TfeObyEd+eeg8JcTVT8AyS1+s=X2AjQ@mail.gmail.com>
 <20210319035435.a4reve77hnvjdzwk@vireshk-i7>
 <b135b474-b167-67ad-588c-b0cfe8dc2998@intel.com>
 <20210319054035.47tn747lkagpip6v@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <834186be-71b1-a67c-8dee-b90527b459c8@intel.com>
Date: Fri, 19 Mar 2021 14:29:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210319054035.47tn747lkagpip6v@vireshk-i7>
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, yu1.wang@intel.com,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, virtualization@lists.linux-foundation.org,
 Arnd Bergmann <arnd@arndb.de>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Tali Perry <tali.perry1@gmail.com>, conghui.chen@intel.com,
 loic.poulain@linaro.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 jarkko.nikula@linux.intel.com, shuo.a.liu@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>
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

Ck9uIDIwMjEvMy8xOSAxMzo0MCwgVmlyZXNoIEt1bWFyIHdyb3RlOgo+IE9uIDE5LTAzLTIxLCAx
MzozMSwgSmllIERlbmcgd3JvdGU6Cj4+IE9uIDIwMjEvMy8xOSAxMTo1NCwgVmlyZXNoIEt1bWFy
IHdyb3RlOgo+Pj4gT24gMTgtMDMtMjEsIDE1OjUyLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+Pj4+
IEFsbG93aW5nIG11bHRpcGxlIHZpcnRpby1pMmMgY29udHJvbGxlcnMgaW4gb25lIHN5c3RlbSwg
YW5kIG11bHRpcGxlIGkyYwo+Pj4+IGRldmljZXMgYXR0YWNoZWQgdG8gZWFjaCBjb250cm9sbGVy
IGlzIGNsZWFybHkgc29tZXRoaW5nIHRoYXQgaGFzIHRvIHdvcmsuCj4+PiBHb29kLgo+Pj4KPj4+
PiBJIGRvbid0IGFjdHVhbGx5IHNlZSBhIGxpbWl0YXRpb24gdGhvdWdoLiBWaXJlc2gsIHdoYXQg
aXMgdGhlIHByb2JsZW0KPj4+PiB5b3Ugc2VlIGZvciBoYXZpbmcgbXVsdGlwbGUgY29udHJvbGxl
cnM/Cj4+PiBJIHRob3VnaHQgdGhpcyB3b3VsZCBiZSBhIHByb2JsZW0gaW4gdGhhdCBjYXNlIGFz
IHdlIGFyZSB1c2luZyB0aGUgZ2xvYmFsCj4+PiB2aXJ0aW9fYWRhcHRlciBoZXJlLgo+Pj4KPj4+
ICsgICAgICAgdmktPmFkYXAgPSAmdmlydGlvX2FkYXB0ZXI7Cj4+PiArICAgICAgIGkyY19zZXRf
YWRhcGRhdGEodmktPmFkYXAsIHZpKTsKPj4+Cj4+PiBNdWx0aXBsZSBjYWxscyB0byBwcm9iZSgp
IHdpbGwgZW5kIHVwIHVwZGF0aW5nIHRoZSBzYW1lIHBvaW50ZXIgaW5zaWRlIGFkYXAuCj4+Pgo+
Pj4gKyAgICAgICB2aS0+YWRhcC0+ZGV2LnBhcmVudCA9ICZ2ZGV2LT5kZXY7Cj4+Pgo+Pj4gU2Ft
ZSBoZXJlLCBvdmVyd3JpdGUuCj4+Pgo+Pj4gKyAgICAgICAvKiBTZXR1cCBBQ1BJIG5vZGUgZm9y
IGNvbnRyb2xsZWQgZGV2aWNlcyB3aGljaCB3aWxsIGJlIHByb2JlZCB0aHJvdWdoIEFDUEkgKi8K
Pj4+ICsgICAgICAgQUNQSV9DT01QQU5JT05fU0VUKCZ2aS0+YWRhcC0+ZGV2LCBBQ1BJX0NPTVBB
TklPTihwZGV2KSk7Cj4+PiArICAgICAgIHZpLT5hZGFwLT50aW1lb3V0ID0gSFogLyAxMDsKPj4+
Cj4+PiBUaGVzZSBtYXkgYmUgZmluZSwgYnV0IHN0aWxsIG5vdCBpZGVhbCBJIGJlbGlldmUuCj4+
Pgo+Pj4gKyAgICAgICByZXQgPSBpMmNfYWRkX2FkYXB0ZXIodmktPmFkYXApOwo+Pj4gaQo+Pj4g
VGhpcyBzaG91bGQgYmUgYSBwcm9ibGVtIGFzIHdlbGwsIHdlIG11c3QgYmUgYWRkaW5nIHRoaXMg
dG8gc29tZSBzb3J0IG9mIGxpc3QsCj4+PiBkb2luZyBzb21lIFJQTSBzdHVmZiwgZXRjID8KPj4+
Cj4+PiBKaWUsIHRoZSBzb2x1dGlvbiBpcyB0byBhbGxvY2F0ZSBtZW1vcnkgZm9yIGFkYXAgYXQg
cnVudGltZSBpbiBwcm9iZSBhbmQgcmVtb3ZlCj4+PiB0aGUgdmlydGlvX2FkYXB0ZXIgc3RydWN0
dXJlIGNvbXBsZXRlbHkuCj4+Cj4+IElmIHlvdSB3YW50IHRvIHN1cHBvcnQgdGhhdC4gVGhlbiBJ
IHRoaW5rIHdlIGRvbid0IG5lZWQgdG8gY2hhbmdlIHRoZQo+PiBmb2xsb3dpbmcgYXQgYWxsLgo+
Pgo+Pj4gK8KgwqDCoCAuYWxnbyA9ICZ2aXJ0aW9fYWxnb3JpdGhtLAo+Pj4gKwo+Pj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+PiArCj4+PiArwqDCoMKgIHZpLT5hZGFwID0gdmlydGlv
X2FkYXB0ZXI7Cj4+IFRoaXMgaXMgc3RyYW5nZSwgd2h5IGFyZSB5b3UgYWxsb2NhdGluZyBtZW1v
cnkgZm9yIGFkYXB0ZXIgdHdpY2UgPwo+PiBPbmNlIGZvciB2aXJ0aW9fYWRhcHRlciBhbmQgb25j
ZSBmb3IgdmktPmFkYXAgPyBFaXRoZXIgZmlsbCB0aGUgZmllbGRzCj4+IGRpcmVjdGx5IGZvciB2
LT5hZGFwIGhlcmUgYW5kIHJlbW92ZSB2aXJ0aW9fYWRhcHRlciBvciBtYWtlIHZpLT5hZGFwIGEK
Pj4gcG9pbnRlci4KPiBZZXMsIHlvdXIgcHJldmlvdXMgdmVyc2lvbiB3YXMgcGFydGx5IG9rYXkg
YnV0IHlvdSBkb24ndCBuZWVkIHRoZQo+IHZpcnRpb19hbGdvcml0aG0gc3RydWN0dXJlIHRvIGJl
IGFsbG9jYXRlZC4gVGhlcmUgYXJlIG9ubHkgNCBmaWVsZHMgeW91IGFyZQo+IHVwZGF0aW5nIGhl
cmUsIGp1c3QgZmlsbCB0aGVtIGRpcmVjdGx5IGluIHZpLT5hZGFwLgo+Cj4gKEZXSVcsIEkgYWxz
byBzdWdnZXN0ZWQgdGhlIHNhbWUgd2hlbiBJIHNhaWQKPiAiRWl0aGVyIGZpbGwgdGhlIGZpZWxk
cyBkaXJlY3RseSBmb3Igdi0+YWRhcCBoZXJlIGFuZCByZW1vdmUgdmlydGlvX2FkYXB0ZXIiLgo+
ICkKPgo+IFNlZSBob3cgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy12ZXJzYXRpbGUuYyBhbmQgbW9z
dCBvZiB0aGUgb3RoZXIgZHJpdmVycyBoYXZlCj4gZG9uZSBpdC4KSSBhbHNvIHNlZSBleGFtcGxl
IGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMteGlpYy5jLiBTb21lIHBlb3BsZSBtaWdodCAKdGhpbmsg
dGhpcyB3YXkgaXMgbW9yZSBjbGVhcmVyIHRoYW4KCnVwZGF0aW5nIGVhY2ggbWVtYmVyIGluIHBy
b2JlLiBCYXNpY2FsbHksIEkgdGhpbmsgaXQncyBqdXN0IGEgbWF0dGVyIG9mIApwZXJzb25hbCBw
cmVmZXJlbmNlIHdoaWNoIGRvZXNuJ3QKCnNvbHZlIGFueSBwcm9ibGVtcy4KCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
