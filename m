Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F041BC433DB
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 05:53:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D52614A7
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 05:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D52614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1348A42FB5;
	Mon, 15 Mar 2021 05:53:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7zLF3ei_LnW9; Mon, 15 Mar 2021 05:53:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4A6D430A3;
	Mon, 15 Mar 2021 05:53:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87AA4C000A;
	Mon, 15 Mar 2021 05:53:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AF5CC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 05:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 536D16F513
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 05:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0h8sKbBFwaTZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 05:53:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94D7A605E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 05:53:01 +0000 (UTC)
IronPort-SDR: mL3vCSIbWt3dHC/yPYD9fxZGy2HR9JxcYPFJQb8xn0b7rB2tnMiTISi7aN6bJD18n6g+CXUVuL
 Wqbv3ztMWhXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="274081700"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; d="scan'208";a="274081700"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2021 22:53:00 -0700
IronPort-SDR: Vbn6tI6GeandlErHLWZ2Q0OMzbleTZHw1ExsM5qz1JDna29LuzmP1mXar3JCw9pqCGXbdan6KS
 qlSar8SGB75Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; d="scan'208";a="601313453"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by fmsmga006.fm.intel.com with ESMTP; 14 Mar 2021 22:52:54 -0700
Subject: Re: [PATCH v7] i2c: virtio: add a virtio i2c frontend driver
To: Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>
References: <cd3b0c9138824b0a5fad9d3bc872d8836e829946.1615554673.git.jie.deng@intel.com>
 <CAK8P3a0zQG3pH91emqAUsaRx4AZeuOEvSrPzXP9w_XhjU6w3ng@mail.gmail.com>
 <8070f03d-8233-636b-5ea9-395e723f7a2c@intel.com>
 <503b88c9-1e82-a3a3-0536-d710ddc834a5@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <e388b344-a815-aed3-c076-3651b18c39d1@intel.com>
Date: Mon, 15 Mar 2021 13:52:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <503b88c9-1e82-a3a3-0536-d710ddc834a5@redhat.com>
Content-Language: en-US
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>, yu1.wang@intel.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 shuo.a.liu@intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Paolo Bonzini <pbonzini@redhat.com>, jarkko.nikula@linux.intel.com,
 Linux I2C <linux-i2c@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 conghui.chen@intel.com, Mike Rapoport <rppt@kernel.org>
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

Ck9uIDIwMjEvMy8xNSAxMToxMywgSmFzb24gV2FuZyB3cm90ZToKPgo+IE9uIDIwMjEvMy8xNSA5
OjE0IOS4iuWNiCwgSmllIERlbmcgd3JvdGU6Cj4+Cj4+IE9uIDIwMjEvMy8xMiAxNjo1OCwgQXJu
ZCBCZXJnbWFubiB3cm90ZToKPj4+IE9uIEZyaSwgTWFyIDEyLCAyMDIxIGF0IDI6MzMgUE0gSmll
IERlbmcgPGppZS5kZW5nQGludGVsLmNvbT4gd3JvdGU6Cj4+Pgo+Pj4+ICsKPj4+PiArLyoqCj4+
Pj4gKyAqIHN0cnVjdCB2aXJ0aW9faTJjX3JlcSAtIHRoZSB2aXJ0aW8gSTJDIHJlcXVlc3Qgc3Ry
dWN0dXJlCj4+Pj4gKyAqIEBvdXRfaGRyOiB0aGUgT1VUIGhlYWRlciBvZiB0aGUgdmlydGlvIEky
QyBtZXNzYWdlCj4+Pj4gKyAqIEBidWY6IHRoZSBidWZmZXIgaW50byB3aGljaCBkYXRhIGlzIHJl
YWQsIG9yIGZyb20gd2hpY2ggaXQncyAKPj4+PiB3cml0dGVuCj4+Pj4gKyAqIEBpbl9oZHI6IHRo
ZSBJTiBoZWFkZXIgb2YgdGhlIHZpcnRpbyBJMkMgbWVzc2FnZQo+Pj4+ICsgKi8KPj4+PiArc3Ry
dWN0IHZpcnRpb19pMmNfcmVxIHsKPj4+PiArwqDCoMKgwqDCoMKgIHN0cnVjdCB2aXJ0aW9faTJj
X291dF9oZHIgb3V0X2hkcjsKPj4+PiArwqDCoMKgwqDCoMKgIHVpbnQ4X3QgKmJ1ZjsKPj4+PiAr
wqDCoMKgwqDCoMKgIHN0cnVjdCB2aXJ0aW9faTJjX2luX2hkciBpbl9oZHI7Cj4+Pj4gK307Cj4+
PiBUaGUgc2ltcGxlciByZXF1ZXN0IHN0cnVjdHVyZSBjbGVhcmx5IGxvb2tzIGJldHRlciB0aGFu
IHRoZSBwcmV2aW91cyAKPj4+IHZlcnNpb24sCj4+PiBidXQgSSB0aGluayBJIGZvdW5kIGFub3Ro
ZXIgcHJvYmxlbSBoZXJlLCBhdCBsZWFzdCBhIHRoZW9yZXRpY2FsIG9uZToKPj4+Cj4+PiBXaGVu
IHlvdSBtYXAgdGhlIGhlYWRlcnMgaW50byB0aGUgRE1BIGFkZHJlc3Mgc3BhY2UsIHRoZXkgc2hv
dWxkCj4+PiBiZSBpbiBzZXBhcmF0ZSBjYWNoZSBsaW5lcywgdG8gYWxsb3cgdGhlIERNQSBtYXBw
aW5nIGludGVyZmFjZXMgdG8KPj4+IHBlcmZvcm0gY2FjaGUgbWFuYWdlbWVudCBvbiBlYWNoIG9u
ZSB3aXRob3V0IGFjY2lkZW50YWxseSBjbG9iYmVyaW5nCj4+PiBhbm90aGVyIG1lbWJlci4KPj4+
Cj4+PiBTbyBmYXIgSSB0aGluayB0aGVyZSBpcyBhbiBhc3N1bXB0aW9uIHRoYXQgdmlydGlvIGJ1
ZmZlcnMgYXJlIGFsd2F5cwo+Pj4gb24gY2FjaGUtY29oZXJlbnQgZGV2aWNlcywgYnV0IGlmIHlv
dSBldmVyIGhhdmUgYSB2aXJ0aW8taTJjIGRldmljZQo+Pj4gYmFja2VuZCBvbiBhIHBoeXNpY2Fs
IGludGVyY29ubmVjdCB0aGF0IGlzIG5vdCBjYWNoZSBjb2hlcmVudCAoZS5nLiBhCj4+PiBtaWNy
b2NvbnRyb2xsZXIgdGhhdCBzaGFyZXMgdGhlIG1lbW9yeSBidXMpLCB0aGlzIGJyZWFrcyBkb3du
Lgo+Pj4KPj4+IFlvdSBjb3VsZCBhdm9pZCB0aGlzIGJ5IGVpdGhlciBhbGxvY2F0aW5nIGFycmF5
cyBvZiBlYWNoIHR5cGUgCj4+PiBzZXBhcmF0ZWx5LAo+Pj4gb3IgYnkgbWFya2luZyBlYWNoIG1l
bWJlciB0aGF0IHlvdSBwYXNzIHRvIHRoZSBkZXZpY2UgYXMKPj4+IF9fX19jYWNoZWxpbmVfYWxp
Z25lZC4KPj4+Cj4+PiDCoMKgwqDCoMKgwqAgQXJuZAo+PiBUaGUgdmlydGlvIGRldmljZXMgYXJl
IHNvZnR3YXJlIGVtdWxhdGVkLgo+Cj4KPiBUaGlzIGlzIG5vdCBjb3JyZWN0LiBUaGVyZSdyZSBh
bHJlYWR5IGEgYnJ1bmNoIGhhcmR3YXJlIHZpcnRpbyBkZXZpY2VzLgo+Cj4gVGhhbmtzCj4KVGhl
biBkbyB5b3UgdGhpbmsgaXQgaXMgbmVjZXNzYXJ5IHRvIG1hcmsgdGhlIHZpcnRpbyBidWZzIHdp
dGggCl9fX19jYWNoZWxpbmVfYWxpZ25lZCA/CgpJIGhhdmVuJ3Qgc2VlbiBhbnkgdmlydGlvIGlu
dGVyZmFjZSBiZWluZyBtYXJrZWQgeWV0LiBJZiB0aGlzIGlzIGEgCnByb2JsZW0sIEkgYmVsaWV2
ZSBpdAoKc2hvdWxkwqAgYmUgY29tbW9uIGZvciBhbGwgdmlydGlvIGRldmljZXMsIHJpZ2h0ID8K
ClRoYW5rcy4KCgo+Cj4+IFRoZSBiYWNrZW5kIHNvZnR3YXJlIG1heSBuZWVkIHRvCj4+IGNvbnNp
ZGVyIHRoaXMgc2luY2UgaXQgbWF5IGV4Y2hhbmdlIGRhdGEgd2l0aCBwaHlzaWNhbCBkZXZpY2Vz
LiBCdXQgSSAKPj4gZG9uJ3QgdGhpbmsKPj4gd2UgbmVlZCBpdCBmb3IgdGhpcyBpbnRlcmZhY2Us
IGJlY2F1c2Ugbm8gRE1BIG9wZXJhdGlvbiBpcyBpbnZvbHZlZCAKPj4gYmV0d2VlbiB0aGUKPj4g
ZnJvbnRlbmQgZHJpdmVyIGFuZCBiYWNrZW5kIGRyaXZlci4KPj4KPj4gUmVnYXJkcywKPj4KPj4g
SmllCj4+Cj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
