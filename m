Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9A2C433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 02:16:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206E265012
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 02:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206E265012
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA0246059F;
	Tue, 16 Mar 2021 02:15:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ng9gBmbpTNPa; Tue, 16 Mar 2021 02:15:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 712296059C;
	Tue, 16 Mar 2021 02:15:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43361C000B;
	Tue, 16 Mar 2021 02:15:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F16A7C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 02:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C90F96059F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 02:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dQJfhhukIBf8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 02:15:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3C7A6059C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 02:15:55 +0000 (UTC)
IronPort-SDR: M9D2NaFvPOABdPpE1lJwEVn+s0Ym0rHIqa+lp3Ev/JiV4doN3VFnaseSAZTpdRjI+B5IWWBAVG
 bGDFEOl8+hVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="189277648"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="189277648"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 19:15:54 -0700
IronPort-SDR: oTD9KtMZ1jjPn6HxxlOF7zsOZemh5Z32NM5g4Up6ZSwF7Ji3sjGKsLHH8syDq4M9M9HH0NvotD
 zELrdGYi2vyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="432855368"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2021 19:15:49 -0700
Subject: Re: [PATCH v7] i2c: virtio: add a virtio i2c frontend driver
To: Arnd Bergmann <arnd@arndb.de>
References: <cd3b0c9138824b0a5fad9d3bc872d8836e829946.1615554673.git.jie.deng@intel.com>
 <CAK8P3a0zQG3pH91emqAUsaRx4AZeuOEvSrPzXP9w_XhjU6w3ng@mail.gmail.com>
 <8070f03d-8233-636b-5ea9-395e723f7a2c@intel.com>
 <503b88c9-1e82-a3a3-0536-d710ddc834a5@redhat.com>
 <e388b344-a815-aed3-c076-3651b18c39d1@intel.com>
 <CAK8P3a0LjcSs7gvU-jRdZJCFrfxQcSUWqL_fgH_71VjC027M0w@mail.gmail.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <770332a7-f34d-fe26-f708-830b587a98d5@intel.com>
Date: Tue, 16 Mar 2021 10:15:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0LjcSs7gvU-jRdZJCFrfxQcSUWqL_fgH_71VjC027M0w@mail.gmail.com>
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, yu1.wang@intel.com,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Tali Perry <tali.perry1@gmail.com>,
 conghui.chen@intel.com, loic.poulain@linaro.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

Ck9uIDIwMjEvMy8xNSAxNTo1MiwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBPbiBNb24sIE1hciAx
NSwgMjAyMSBhdCA2OjU0IEFNIEppZSBEZW5nIDxqaWUuZGVuZ0BpbnRlbC5jb20+IHdyb3RlOgo+
PiBPbiAyMDIxLzMvMTUgMTE6MTMsIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBPbiAyMDIxLzMvMTUg
OToxNCDkuIrljYgsIEppZSBEZW5nIHdyb3RlOgo+Pj4+IE9uIDIwMjEvMy8xMiAxNjo1OCwgQXJu
ZCBCZXJnbWFubiB3cm90ZToKPj4gVGhlbiBkbyB5b3UgdGhpbmsgaXQgaXMgbmVjZXNzYXJ5IHRv
IG1hcmsgdGhlIHZpcnRpbyBidWZzIHdpdGgKPj4gX19fX2NhY2hlbGluZV9hbGlnbmVkID8KPiBJ
IHRoaW5rIHNvLCB5ZXMuCj4KPj4gSSBoYXZlbid0IHNlZW4gYW55IHZpcnRpbyBpbnRlcmZhY2Ug
YmVpbmcgbWFya2VkIHlldC4gSWYgdGhpcyBpcyBhCj4+IHByb2JsZW0sIEkgYmVsaWV2ZSBpdCBz
aG91bGQgIGJlIGNvbW1vbiBmb3IgYWxsIHZpcnRpbyBkZXZpY2VzLCByaWdodCA/Cj4gWWVzLCBi
dXQgaXQncyBub3QgYSBwcm9ibGVtIGlmIHRoZSBidWZmZXJzIGFyZSBhbGxvY2F0ZWQgc2VwYXJh
dGVseQo+IGJlY2F1c2Uga21hbGxvYyBwcm92aW5jZXMgYSBjYWNoZWxpbmVuIGFsaWduZWQgYnVm
ZmVyIG9uIGFyY2hpdGVjdHVyZXMKPiB0aGF0IG5lZWQgaXQuCj4KPiBJdCdzIG9ubHkgYSBwcm9i
bGVtIGhlcmUgYmVjYXVzZSB0aGVyZSBpcyBhIHNpbmdsZSBhbGxvY2F0aW9uIGZvciB0aHJlZQo+
IG9iamVjdHMgdGhhdCBoYXZlIGRpZmZlcmVudCBvd25lcnNoaXAgc3RhdGVzIGR1cmluZyB0aGUg
RE1BIChkZXZpY2UKPiBvd25lZCB0by1kZXZpY2UsIGNwdS1vd25lZCwgZGV2aWNlIG93bmVkIHRv
LWNwdSkuCj4KPiAgICAgICAgIEFybmQKSSdtIG5vdCBzdXJlIGlmIHRoaXMgd2lsbCBhY3R1YWxs
eSBjYXVzZSBhIHByb2JsZW0uIEJ1dCBJJ20gT0sgdG8gbWFyayAKdGhlIGl0ZW1zCmluIHN0cnVj
dCB2aXJ0aW9faTJjX3JlcSB3aXRowqAgX19fX2NhY2hlbGluZV9hbGlnbmVkIHRvIGF2b2lkIHBv
dGVudGlhbCAKcHJvYmxlbQphcyB5b3Ugc2FpZC4KClRoYW5rIHlvdS4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
