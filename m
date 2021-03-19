Return-Path: <SRS0=JY8S=IR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35CFC433E0
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 05:31:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7819164E86
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 05:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7819164E86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBD7A83A77;
	Fri, 19 Mar 2021 05:31:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 43h0pX1dl5tI; Fri, 19 Mar 2021 05:31:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FD6383A6B;
	Fri, 19 Mar 2021 05:31:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55AD1C000B;
	Fri, 19 Mar 2021 05:31:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED512C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 05:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E172040107
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 05:31:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FsOHyOhbhO3f
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 05:31:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 374A9400FC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 05:31:41 +0000 (UTC)
IronPort-SDR: WaVleskSSqcrkwhsZKOS2vva0dXjCDzrGF2WqzUpkJnLWEVCbCEhgOswKa/lKQn5HvICYkMEL4
 zhKg+MoMkZdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="186481635"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; d="scan'208";a="186481635"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 22:31:40 -0700
IronPort-SDR: dXFG2bQZSZ9t+2XLd6fS7oSesFueKUxpbXN/Rrt78E48wlYb5JrAd6ivXaPu6U1r8KwIENuh6x
 +w9BxKUimsLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; d="scan'208";a="591744750"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga005.jf.intel.com with ESMTP; 18 Mar 2021 22:31:34 -0700
Subject: Re: [PATCH v8] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>
References: <c193b92d8d22ba439bb1b260d26d4b76f57d4840.1615889867.git.jie.deng@intel.com>
 <20210316074409.2afwsaeqxuwvj7bd@vireshk-i7>
 <0dfff1ac-50bb-b5bc-72ea-880fd52ed60d@metux.net>
 <CAK8P3a3f9bKdOOMgrA9TfeObyEd+eeg8JcTVT8AyS1+s=X2AjQ@mail.gmail.com>
 <20210319035435.a4reve77hnvjdzwk@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <b135b474-b167-67ad-588c-b0cfe8dc2998@intel.com>
Date: Fri, 19 Mar 2021 13:31:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210319035435.a4reve77hnvjdzwk@vireshk-i7>
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, yu1.wang@intel.com,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, virtualization@lists.linux-foundation.org,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Tali Perry <tali.perry1@gmail.com>,
 conghui.chen@intel.com, loic.poulain@linaro.org,
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

Ck9uIDIwMjEvMy8xOSAxMTo1NCwgVmlyZXNoIEt1bWFyIHdyb3RlOgo+IE9uIDE4LTAzLTIxLCAx
NTo1MiwgQXJuZCBCZXJnbWFubiB3cm90ZToKPj4gQWxsb3dpbmcgbXVsdGlwbGUgdmlydGlvLWky
YyBjb250cm9sbGVycyBpbiBvbmUgc3lzdGVtLCBhbmQgbXVsdGlwbGUgaTJjCj4+IGRldmljZXMg
YXR0YWNoZWQgdG8gZWFjaCBjb250cm9sbGVyIGlzIGNsZWFybHkgc29tZXRoaW5nIHRoYXQgaGFz
IHRvIHdvcmsuCj4gR29vZC4KPgo+PiBJIGRvbid0IGFjdHVhbGx5IHNlZSBhIGxpbWl0YXRpb24g
dGhvdWdoLiBWaXJlc2gsIHdoYXQgaXMgdGhlIHByb2JsZW0KPj4geW91IHNlZSBmb3IgaGF2aW5n
IG11bHRpcGxlIGNvbnRyb2xsZXJzPwo+IEkgdGhvdWdodCB0aGlzIHdvdWxkIGJlIGEgcHJvYmxl
bSBpbiB0aGF0IGNhc2UgYXMgd2UgYXJlIHVzaW5nIHRoZSBnbG9iYWwKPiB2aXJ0aW9fYWRhcHRl
ciBoZXJlLgo+Cj4gKyAgICAgICB2aS0+YWRhcCA9ICZ2aXJ0aW9fYWRhcHRlcjsKPiArICAgICAg
IGkyY19zZXRfYWRhcGRhdGEodmktPmFkYXAsIHZpKTsKPgo+IE11bHRpcGxlIGNhbGxzIHRvIHBy
b2JlKCkgd2lsbCBlbmQgdXAgdXBkYXRpbmcgdGhlIHNhbWUgcG9pbnRlciBpbnNpZGUgYWRhcC4K
Pgo+ICsgICAgICAgdmktPmFkYXAtPmRldi5wYXJlbnQgPSAmdmRldi0+ZGV2Owo+Cj4gU2FtZSBo
ZXJlLCBvdmVyd3JpdGUuCj4KPiArICAgICAgIC8qIFNldHVwIEFDUEkgbm9kZSBmb3IgY29udHJv
bGxlZCBkZXZpY2VzIHdoaWNoIHdpbGwgYmUgcHJvYmVkIHRocm91Z2ggQUNQSSAqLwo+ICsgICAg
ICAgQUNQSV9DT01QQU5JT05fU0VUKCZ2aS0+YWRhcC0+ZGV2LCBBQ1BJX0NPTVBBTklPTihwZGV2
KSk7Cj4gKyAgICAgICB2aS0+YWRhcC0+dGltZW91dCA9IEhaIC8gMTA7Cj4KPiBUaGVzZSBtYXkg
YmUgZmluZSwgYnV0IHN0aWxsIG5vdCBpZGVhbCBJIGJlbGlldmUuCj4KPiArICAgICAgIHJldCA9
IGkyY19hZGRfYWRhcHRlcih2aS0+YWRhcCk7Cj4gaQo+IFRoaXMgc2hvdWxkIGJlIGEgcHJvYmxl
bSBhcyB3ZWxsLCB3ZSBtdXN0IGJlIGFkZGluZyB0aGlzIHRvIHNvbWUgc29ydCBvZiBsaXN0LAo+
IGRvaW5nIHNvbWUgUlBNIHN0dWZmLCBldGMgPwo+Cj4gSmllLCB0aGUgc29sdXRpb24gaXMgdG8g
YWxsb2NhdGUgbWVtb3J5IGZvciBhZGFwIGF0IHJ1bnRpbWUgaW4gcHJvYmUgYW5kIHJlbW92ZQo+
IHRoZSB2aXJ0aW9fYWRhcHRlciBzdHJ1Y3R1cmUgY29tcGxldGVseS4KCgpJZiB5b3Ugd2FudCB0
byBzdXBwb3J0IHRoYXQuIFRoZW4gSSB0aGluayB3ZSBkb24ndCBuZWVkIHRvIGNoYW5nZSB0aGUg
CmZvbGxvd2luZyBhdCBhbGwuCgo+ICvCoMKgwqAgLmFsZ28gPSAmdmlydGlvX2FsZ29yaXRobSwK
PiArCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gKwo+ICvCoMKgwqAgdmktPmFkYXAg
PSB2aXJ0aW9fYWRhcHRlcjsKVGhpcyBpcyBzdHJhbmdlLCB3aHkgYXJlIHlvdSBhbGxvY2F0aW5n
IG1lbW9yeSBmb3IgYWRhcHRlciB0d2ljZSA/Ck9uY2UgZm9yIHZpcnRpb19hZGFwdGVyIGFuZCBv
bmNlIGZvciB2aS0+YWRhcCA/IEVpdGhlciBmaWxsIHRoZSBmaWVsZHMKZGlyZWN0bHkgZm9yIHYt
PmFkYXAgaGVyZSBhbmQgcmVtb3ZlIHZpcnRpb19hZGFwdGVyIG9yIG1ha2UgdmktPmFkYXAgYQpw
b2ludGVyLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
