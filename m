Return-Path: <SRS0=SHSW=II=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EC0C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 02:22:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A974164E6F
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 02:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A974164E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A69143145;
	Wed, 10 Mar 2021 02:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c2QZjM3t5kRN; Wed, 10 Mar 2021 02:22:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 171F9430F9;
	Wed, 10 Mar 2021 02:22:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC65AC000A;
	Wed, 10 Mar 2021 02:22:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD3D8C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 02:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B3A76F621
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 02:22:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YIq_2--sC_3E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 02:22:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4C226F48A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 02:22:37 +0000 (UTC)
IronPort-SDR: aGoqib9Y5knoArfx/cmKz7SolssbRmlr7lTvYV427PgWaerL7W4KNJju8zjUFkKiDeo9szleSe
 U4VgyuF6f+Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188467559"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; d="scan'208";a="188467559"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2021 18:22:35 -0800
IronPort-SDR: 4hb4GTO/VCURjcsMMoLIhUgrPjxB6ULiRRKXoeTZE+siy3Iy3gYkSIer46ao1JOZ1k65tnpHD7
 gglQM2RcKfaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; d="scan'208";a="376770074"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2021 18:22:30 -0800
Subject: Re: [PATCH v6] i2c: virtio: add a virtio i2c frontend driver
To: Jason Wang <jasowang@redhat.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <9a2086f37c0a62069b67c39a3f75941b78a0039c.1614749417.git.jie.deng@intel.com>
 <43b0842b-8b0f-1979-ed07-d6124e3a6b79@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <db9350b3-b847-8f54-546f-9a0bdec425d4@intel.com>
Date: Wed, 10 Mar 2021 10:22:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <43b0842b-8b0f-1979-ed07-d6124e3a6b79@redhat.com>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 viresh.kumar@linaro.org, shuo.a.liu@intel.com, tali.perry1@gmail.com,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, pbonzini@redhat.com,
 jarkko.nikula@linux.intel.com, stefanha@redhat.com,
 u.kleine-koenig@pengutronix.de, kblaiech@mellanox.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, rppt@kernel.org
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

Ck9uIDIwMjEvMy80IDE3OjE1LCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4KPj4gK8KgwqDCoMKgwqDC
oMKgIH0KPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKG1zZ3NbaV0uZmxhZ3MgJiBJMkNfTV9S
RCkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVtY3B5KG1zZ3NbaV0uYnVmLCByZXEtPmJ1
ZiwgbXNnc1tpXS5sZW4pOwo+Cj4KPiBTb3JyeSBpZiBJIGhhZCBhc2tlZCB0aGlzIGJlZm9yZSBi
dXQgYW55IHJhc29uIG5vdCB0byB1c2UgbXNnW2ldLmJ1ZiAKPiBkaXJlY3RseT8KPgo+ClRoZSBt
c2dbaV0uYnVmIGlzIHBhc3NlZCBieSB0aGUgSTJDIGNvcmUuIEkganVzdCBub3RpY2VkIHRoYXQg
dGhlc2UgYnVmcyAKYXJlIG5vdAphbHdheXMgYWxsb2NhdGVkIGJ5IGttYWxsb2MuIFRoZXkgbWF5
IGNvbWUgZnJvbSB0aGUgc3RhY2ssIHdoaWNoIG1heSBjYXVzZQp0aGUgY2hlY2sgInNnX2luaXRf
b25lIC0+IHNnX3NldF9idWYgLT4gdmlydF9hZGRyX3ZhbGlkIsKgIHRvIGZhaWwuIApUaGVyZWZv
cmUgdGhlCm1zZ1tpXS5idWYgaXMgbm90IHN1aXRhYmxlIGZvciBkaXJlY3QgdXNlIGhlcmUuCgpS
ZWdhcmRzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
