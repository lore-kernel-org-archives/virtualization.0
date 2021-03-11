Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114B0C433E0
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 05:59:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBDE64FA3
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 05:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBDE64FA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0EFAD4300C;
	Thu, 11 Mar 2021 05:59:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ycVhdey2pi-Q; Thu, 11 Mar 2021 05:59:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id A3D25400C3;
	Thu, 11 Mar 2021 05:59:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71546C000A;
	Thu, 11 Mar 2021 05:59:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73782C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 05:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5997F414FF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 05:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RwElsaxwwcFC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 05:59:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DF99400C3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 05:59:51 +0000 (UTC)
IronPort-SDR: yrobrCOMj7wndz4iRj+xX8AinrZF4ula7Z6lPzJpgAYAS+5hz/LuigarMFTK/VDcEL6JXkpY7v
 vx96d1Fkzu3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="185261793"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; d="scan'208";a="185261793"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 21:59:50 -0800
IronPort-SDR: du9lyukxeF00i+Ix2NYJrOSRrhlfdBckq7UR+OhFYQ6il5kUCXljzaM2Uv5W/lpYr6TQzAI03b
 RQEWJrNe20xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; d="scan'208";a="603404106"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2021 21:59:43 -0800
Subject: Re: [PATCH v6] i2c: virtio: add a virtio i2c frontend driver
To: Arnd Bergmann <arnd@arndb.de>, Jason Wang <jasowang@redhat.com>
References: <9a2086f37c0a62069b67c39a3f75941b78a0039c.1614749417.git.jie.deng@intel.com>
 <43b0842b-8b0f-1979-ed07-d6124e3a6b79@redhat.com>
 <db9350b3-b847-8f54-546f-9a0bdec425d4@intel.com>
 <a3d4ce55-db25-5f96-ff44-5b76edfe9e08@redhat.com>
 <CAK8P3a04u9Xv15K06zrsOtzZF18+1wDpJbBHUU3wYwU--Hdz5A@mail.gmail.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <c6538bba-9217-d707-9a16-72b550c7f76f@intel.com>
Date: Thu, 11 Mar 2021 13:59:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a04u9Xv15K06zrsOtzZF18+1wDpJbBHUU3wYwU--Hdz5A@mail.gmail.com>
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

Ck9uIDIwMjEvMy8xMCAxNjoyNywgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBPbiBXZWQsIE1hciAx
MCwgMjAyMSBhdCA0OjU5IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3Rl
Ogo+PiBPbiAyMDIxLzMvMTAgMTA6MjIg5LiK5Y2ILCBKaWUgRGVuZyB3cm90ZToKPj4+IE9uIDIw
MjEvMy80IDE3OjE1LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Cj4+Pj4+ICsgICAgICAgIH0KPj4+
Pj4gKwo+Pj4+PiArICAgICAgICBpZiAobXNnc1tpXS5mbGFncyAmIEkyQ19NX1JEKQo+Pj4+PiAr
ICAgICAgICAgICAgbWVtY3B5KG1zZ3NbaV0uYnVmLCByZXEtPmJ1ZiwgbXNnc1tpXS5sZW4pOwo+
Pj4+Cj4+Pj4gU29ycnkgaWYgSSBoYWQgYXNrZWQgdGhpcyBiZWZvcmUgYnV0IGFueSByYXNvbiBu
b3QgdG8gdXNlIG1zZ1tpXS5idWYKPj4+PiBkaXJlY3RseT8KPj4+Pgo+Pj4+Cj4+PiBUaGUgbXNn
W2ldLmJ1ZiBpcyBwYXNzZWQgYnkgdGhlIEkyQyBjb3JlLiBJIGp1c3Qgbm90aWNlZCB0aGF0IHRo
ZXNlCj4+PiBidWZzIGFyZSBub3QKPj4+IGFsd2F5cyBhbGxvY2F0ZWQgYnkga21hbGxvYy4gVGhl
eSBtYXkgY29tZSBmcm9tIHRoZSBzdGFjaywgd2hpY2ggbWF5Cj4+PiBjYXVzZQo+Pj4gdGhlIGNo
ZWNrICJzZ19pbml0X29uZSAtPiBzZ19zZXRfYnVmIC0+IHZpcnRfYWRkcl92YWxpZCIgIHRvIGZh
aWwuCj4+PiBUaGVyZWZvcmUgdGhlCj4+PiBtc2dbaV0uYnVmIGlzIG5vdCBzdWl0YWJsZSBmb3Ig
ZGlyZWN0IHVzZSBoZXJlLgo+PiBSaWdodCwgc3RhY2sgaXMgdmlydHVhbGx5IG1hcHBlZC4KPiBN
YXliZSB0aGVyZSBpcyAob3Igc2hvdWxkIGJlKSBhIHdheSB0byBsZXQgdGhlIGkyYyBjb3JlIGNv
ZGUgaGFuZGxlCj4gdGhlIGJvdW5jZSBidWZmZXJpbmcgaW4gdGhpcyBjYXNlLiBUaGlzIGlzIHN1
cmVseSBub3QgYSBwcm9ibGVtIHRoYXQKPiBpcyB1bmlxdWUgdG8gdGhpcyBkcml2ZXIsIGFuZCBJ
J20gc3VyZSBpdCBoYXMgY29tZSB1cCBtYW55IHRpbWVzIGluCj4gdGhlIHBhc3QuCj4KPiBJIHNl
ZSB0aGF0IHRoZXJlIGlzIGEgaTJjX2dldF9kbWFfc2FmZV9tc2dfYnVmKCkgaGVscGVyIGZvciB0
aGlzCj4gcHVycG9zZSwgYnV0IGl0IGhhcyB0byBiZSBjYWxsZWQgYnkgdGhlIGRyaXZlciByYXRo
ZXIgdGhhbiB0aGUgY29yZSwKPiBzbyB0aGUgZHJpdmVyIHN0aWxsIG5lZWRzIHRvIGtlZXAgdHJh
Y2sgb2YgZWFjaCBhZGRyZXNzIHdoZW4gaXQKPiBzZW5kcyBtdWx0aXBsZSBpMmNfbXNnIGF0IG9u
Y2UsIGJ1dCBtYXliZSBpdCBjYW4gYWxsIGJlIGRvbmUKPiBpbnNpZGUgdGhlIHNnX3RhYmxlIGlu
c3RlYWQgb2YgeWV0IGFub3RoZXIgc3RydWN0dXJlLgo+Cj4gQXQgbGVhc3QgdGhpcyBvbmUgYXZv
aWRzIGNvcHlpbmcgZGF0YSB0aGF0IGlzIG1hcmtlZCB3aXRoIHRoZQo+IEkyQ19NX0RNQV9TQUZF
IGZsYWcuCj4KPiAgICAgICAgIEFybmQKCk1ha2Ugc2Vuc2UuIFRoYW5rcyBBcm5kLiBJIHdpbGwg
dHJ5IHRvIHVzZSB0aG9zZSBoZWxwZXIgZnVuY3Rpb25zLgoKUmVnYXJkcywKSmllCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
