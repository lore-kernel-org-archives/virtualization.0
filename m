Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C648C433ED
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 06:17:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905BD611F1
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 06:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905BD611F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46D4A60D72;
	Thu, 15 Apr 2021 06:17:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fagKMWozw7kI; Thu, 15 Apr 2021 06:17:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2B4260BAE;
	Thu, 15 Apr 2021 06:17:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6C39C000C;
	Thu, 15 Apr 2021 06:17:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A11B7C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 954E3844FE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ymi9Jid7882x
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:17:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 464FB844F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:17:35 +0000 (UTC)
IronPort-SDR: wdAuOTN6KTH8CAbQnjgpgLFjV/FJBnQeFStDXvlSN+GWlvXH0BZbYcvPamccjLddBdp5xPjq8W
 qBqIJMNgU1yg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="194818128"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="194818128"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 23:17:35 -0700
IronPort-SDR: jfymEUlDuAOZaCeFkyDtjgDMtuKU8aEiS9vVzcybf0lefXJn6TJtlvC23SrG5YvRAZiBtyz9RZ
 pF/zENCjWssQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="421585736"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.55])
 ([10.239.154.55])
 by orsmga007.jf.intel.com with ESMTP; 14 Apr 2021 23:17:29 -0700
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Jason Wang <jasowang@redhat.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <eb6011cd-9bd1-0ad4-e95b-aa814f29cb79@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <c8229883-3988-b9f4-189c-7b685bc462b3@intel.com>
Date: Thu, 15 Apr 2021 14:17:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <eb6011cd-9bd1-0ad4-e95b-aa814f29cb79@redhat.com>
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

Ck9uIDIwMjEvNC8xNSAxMTo1MSwgSmFzb24gV2FuZyB3cm90ZToKPgo+PiArwqDCoMKgIGZvciAo
aSA9IDA7IGkgPCBucjsgaSsrKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBEZXRhY2ggdGhlIGl0
aCByZXF1ZXN0IGZyb20gdGhlIHZxICovCj4+ICvCoMKgwqDCoMKgwqDCoCByZXEgPSB2aXJ0cXVl
dWVfZ2V0X2J1Zih2cSwgJmxlbik7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4+ICvCoMKg
wqDCoMKgwqDCoMKgICogQ29uZGl0aW9uIChyZXEgJiYgcmVxID09ICZyZXFzW2ldKSBzaG91bGQg
YWx3YXlzIG1lZXQgc2luY2UKPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiB3ZSBoYXZlIHRvdGFsIG5y
IHJlcXVlc3RzIGluIHRoZSB2cS4KPgo+Cj4gU28gdGhpcyBhc3N1bWVzIHRoZSByZXF1ZXN0cyBh
cmUgY29tcGxldGVkIGluIG9yZGVyLiBJcyB0aGlzIG1hbmRhdGVkIAo+IGluIHRoZSBzcGVjPwo+
Cj4KClRoaXMgaXMgYSBtYW5kYXRvcnkgZGV2aWNlIHJlcXVpcmVtZW50cyBpbiBzcGVjLgoKCj4+
ICvCoMKgwqDCoMKgwqDCoMKgICovCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWZhaWxlZCAmJiAo
V0FSTl9PTighKHJlcSAmJiByZXEgPT0gJnJlcXNbaV0pKSB8fAo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAocmVxLT5pbl9oZHIuc3RhdHVzICE9IFZJUlRJT19JMkNfTVNHX09LKSkpCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhaWxlZCA9IHRydWU7Cj4+ICsKPj4gK8KgwqDCoMKgwqDC
oMKgIGkyY19wdXRfZG1hX3NhZmVfbXNnX2J1ZihyZXFzW2ldLmJ1ZiwgJm1zZ3NbaV0sICFmYWls
ZWQpOwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFmYWlsZWQpCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICsrajsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCByZXR1cm4gKHRpbWVvdXQg
PyAtRVRJTUVET1VUIDogaik7Cj4KPgo+IENoZWNraW5nIHRpbWVvdXQgaXMgZnJhZ2lsZSwgd2hh
dCBoYXBwZW5zIGlmIHRoZSByZXF1ZXN0IGFyZSBjb21wbGV0ZWQgCj4gYWZ0ZXIgd2FpdF9mb3Jf
Y29tcGxldGlvbigpIGJ1dCBiZWZvcmUgdmlydGlvX2kyY19jb21wbGV0ZV9yZXFzKCk/Cj4KV2Ug
aGF2ZSBkaXNjdXNzZWQgdGhpcyBiZWZvcmUgaW4gdjYuIApodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvcGlwZXJtYWlsL3ZpcnR1YWxpemF0aW9uLzIwMjEtTWFyY2gvMDUzMDkzLmh0
bWwuCgpJZiB0aW1lb3V0IGhhcHBlbnMsIHdlIGRvbid0IG5lZWQgdG8gY2FyZSBhYm91dCB0aGUg
cmVxdWVzdHMgd2hldGhlciAKcmVhbGx5IGNvbXBsZXRlZCBieSAiSFciIG9yIG5vdC4KCkp1c3Qg
cmV0dXJuIGVycm9yIGFuZCBsZXQgdGhlIGkyYyBjb3JlIHRvIGRlY2lkZSB3aGV0aGVyIHRvIHJl
c2VuZC4gQW5kIApjdXJyZW50bHksIHRoZSB0aW1lb3V0IGlzIHN0YXRpY2FsbHkgY29uZmlndXJl
ZCBpbiBkcml2ZXIuCgpXZSBtYXkgZXh0ZW5kIGEgZGV2aWNlIHRpbWVvdXQgdmFsdWUgY29uZmln
dXJhdGlvbiBpbiBzcGVjIGZvciBkcml2ZXIgdG8gCnVzZSBpZiB0aGVyZSBpcyBhY3R1YWwgbmVl
ZCBpbiB0aGUgZnV0dXJlLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
