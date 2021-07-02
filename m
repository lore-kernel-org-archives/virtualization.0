Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4483CC11F6A
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 03:36:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C22613F4
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 03:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C22613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD0C183D4D;
	Fri,  2 Jul 2021 03:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kkqePbHIMOom; Fri,  2 Jul 2021 03:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 69D1D83D4A;
	Fri,  2 Jul 2021 03:36:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FE16C001A;
	Fri,  2 Jul 2021 03:36:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4E5FC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 03:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB31383D4D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 03:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sUPDlMKXHhZN
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 03:36:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B08E83D4A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 03:36:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="208619754"
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; d="scan'208";a="208619754"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2021 20:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; d="scan'208";a="409162472"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by orsmga006.jf.intel.com with ESMTP; 01 Jul 2021 20:36:45 -0700
Subject: Re: [PATCH v11] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <510c876952efa693339ab0d6cc78ba7be9ef6897.1625104206.git.jie.deng@intel.com>
 <20210701040436.p7kega6rzeqz5tlm@vireshk-i7>
 <cb35472d-f79e-f3f8-405f-35c699d897a1@intel.com>
 <20210701061846.7u4zorimzpmb66v7@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <34092cb2-03f9-231d-8769-4e45ed51c30f@intel.com>
Date: Fri, 2 Jul 2021 11:36:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210701061846.7u4zorimzpmb66v7@vireshk-i7>
Content-Language: en-US
Cc: yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
 stefanha@redhat.com, shuo.a.liu@intel.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com
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

Ck9uIDIwMjEvNy8xIDE0OjE4LCBWaXJlc2ggS3VtYXIgd3JvdGU6Cj4gT24gMDEtMDctMjEsIDE0
OjEwLCBKaWUgRGVuZyB3cm90ZToKPj4gSSB0aGluayBhIGZpeGVkIG51bWJlciBvZiBzZ3Mgd2ls
bCBtYWtlIHRoaW5ncyBlYXNpZXIgdG8gZGV2ZWxvcCBiYWNrZW5kLgo+IFllYWgsIGJ1dCBpdCBs
b29rcyBhd2t3YXJkIHRvIHNlbmQgYSBtZXNzYWdlIGJ1ZmZlciB3aGljaCBpc24ndCB1c2VkCj4g
YXQgYWxsLiBGcm9tIHByb3RvY29sJ3MgcG9pbnQgb2YgdmlldywgaXQganVzdCBsb29rcyB3cm9u
Zy9idWdneS4KPgo+IFRoZSBiYWNrZW5kIGNhbiBqdXN0IGxvb2sgYXQgdGhlIG51bWJlciBvZiBl
bGVtZW50cyByZWNlaXZlZCwgdGhleQo+IGNhbiBlaXRoZXIgYmUgMiAoaW4gY2FzZSBvZiB6ZXJv
LWxlbmd0aCkgdHJhbnNmZXIsIG9yIDMgKGZvcgo+IHJlYWQvd3JpdGUpIGFuZCBhbnkgb3RoZXIg
bnVtYmVyIGlzIGludmFsaWQuCj4KCk9LLiBMZXQncyBhZGQgdGhlIGZvbGxvd2luZyB0d28gbGlu
ZXMgdG8gbWFrZSBzdXJlIHRoYXQgbXNnX2J1ZiBpcyBvbmx5CnNlbnQgd2hlbiB0aGUgbXNncyBs
ZW4gaXMgbm90IHplcm8uIEFuZCBiYWNrZW5kIGp1ZGdlcyB3aGV0aGVyIGl0IGlzCmEgemVyby1s
ZW5ndGggcmVxdWVzdCBieSBjaGVja2luZyB0aGUgbnVtYmVyIG9mIGVsZW1lbnRzIHJlY2VpdmVk
LgoKIMKgKyBpZiAobXNnc1tpXS5sZW4pIHsKIMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcXNbaV0u
YnVmID0gaTJjX2dldF9kbWFfc2FmZV9tc2dfYnVmKCZtc2dzW2ldLCAxKTsKIMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmICghcmVxc1tpXS5idWYpCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnJlYWs7CgogwqDCoMKgwqDCoMKgwqDCoMKgIHNnX2luaXRfb25lKCZtc2dfYnVm
LCByZXFzW2ldLmJ1ZiwgbXNnc1tpXS5sZW4pOwoKIMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobXNn
c1tpXS5mbGFncyAmIEkyQ19NX1JEKQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzZ3Nbb3V0Y250ICsgaW5jbnQrK10gPSAmbXNnX2J1ZjsKIMKgwqDCoMKgwqDCoMKgwqDCoCBl
bHNlCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNnc1tvdXRjbnQrK10gPSAm
bXNnX2J1ZjsKK30KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
