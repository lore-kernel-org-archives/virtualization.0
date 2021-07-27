Return-Path: <SRS0=8N1b=MT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2797AC4338F
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 02:15:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF71E60FE3
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 02:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF71E60FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 814E082B34;
	Tue, 27 Jul 2021 02:15:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ty4ssahWiyDr; Tue, 27 Jul 2021 02:15:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D72F82611;
	Tue, 27 Jul 2021 02:15:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C39CC0010;
	Tue, 27 Jul 2021 02:15:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12003C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 02:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1719826F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 02:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KB2yyNn4pfu5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 02:15:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 41FA182611
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 02:15:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="276141140"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; d="scan'208";a="276141140"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2021 19:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; d="scan'208";a="505286256"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2021 19:15:17 -0700
Subject: Re: [PATCH v15] i2c: virtio: add a virtio i2c frontend driver
To: Arnd Bergmann <arnd@arndb.de>
References: <bcf2fb9bbe965862213f27e05f87ffc91283c0c5.1627018061.git.jie.deng@intel.com>
 <CAK8P3a1=TpKLGMzvoLafjxtmoBbDL+sBMb8ZiEmTjW91Yr-cYw@mail.gmail.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <a65f32f6-6068-951c-c080-9ae27915b288@intel.com>
Date: Tue, 27 Jul 2021 10:15:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1=TpKLGMzvoLafjxtmoBbDL+sBMb8ZiEmTjW91Yr-cYw@mail.gmail.com>
Content-Language: en-US
Cc: Vincent Guittot <vincent.guittot@linaro.org>, yu1.wang@intel.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 jiedeng@alumni.sjtu.edu.cn,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 gregkh <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, conghui.chen@intel.com
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

Ck9uIDIwMjEvNy8yMyAxNzowMywgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBPbiBGcmksIEp1bCAy
MywgMjAyMSBhdCA3OjQ0IEFNIEppZSBEZW5nIDxqaWUuZGVuZ0BpbnRlbC5jb20+IHdyb3RlOgo+
Cj4+ICsKPj4gKyAgICAgICByZXQgPSB2aXJ0aW9faTJjX3NldHVwX3Zxcyh2aSk7Cj4+ICsgICAg
ICAgaWYgKHJldCkKPj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7Cj4+ICsKPj4gKyAgICAg
ICB2aS0+YWRhcC5vd25lciA9IFRISVNfTU9EVUxFOwo+PiArICAgICAgIHNucHJpbnRmKHZpLT5h
ZGFwLm5hbWUsIHNpemVvZih2aS0+YWRhcC5uYW1lKSwKPj4gKyAgICAgICAgICAgICAgICAiaTJj
X3ZpcnRpbyBhdCB2aXJ0aW8gYnVzICVkIiwgdmRldi0+aW5kZXgpOwo+PiArICAgICAgIHZpLT5h
ZGFwLmFsZ28gPSAmdmlydGlvX2FsZ29yaXRobTsKPj4gKyAgICAgICB2aS0+YWRhcC5xdWlya3Mg
PSAmdmlydGlvX2kyY19xdWlya3M7Cj4+ICsgICAgICAgdmktPmFkYXAuZGV2LnBhcmVudCA9ICZ2
ZGV2LT5kZXY7Cj4+ICsgICAgICAgaTJjX3NldF9hZGFwZGF0YSgmdmktPmFkYXAsIHZpKTsKPj4g
Kwo+PiArICAgICAgIC8qCj4+ICsgICAgICAgICogU2V0dXAgQUNQSSBub2RlIGZvciBjb250cm9s
bGVkIGRldmljZXMgd2hpY2ggd2lsbCBiZSBwcm9iZWQgdGhyb3VnaAo+PiArICAgICAgICAqIEFD
UEkuCj4+ICsgICAgICAgICovCj4+ICsgICAgICAgQUNQSV9DT01QQU5JT05fU0VUKCZ2aS0+YWRh
cC5kZXYsIEFDUElfQ09NUEFOSU9OKHBkZXYpKTsKPiBTaW5jZSB0aGVyZSBpcyBub3cgYSBnZW5l
cmljIHdheSBmb3IgdmlydGlvIGRyaXZlcnMgdG8gbGluayB1cCB3aXRoIE9GCj4gZGV2aWNlIG5v
ZGVzLCBtYXliZSB0aGlzIHNob3VsZCBiZSBoYW5kbGVkIHRoZSBzYW1lIHdheSBpbiB0aGUKPiB2
aXJ0aW8gY29yZSByYXRoZXIgdGhhbiB0aGUgZHJpdmVyPwoKCkknbSBjdXJyZW50bHkgYmFzZWQg
b24gdGhlIEkyQyB0cmVlLiBIYXMgdGhhdCBwYXRjaCBiZWVuIGFscmVhZHkgbWVyZ2VkIO+8nwoK
QW55d2F5LCBJIHRoaW5rIHdlIGNhbiBzZW5kIGFuIGFkZGl0aW9uYWwgcGF0Y2ggdG8gcmVtb3Zl
IHRoaXMgbGluZSBvbmNlIAp0aGF0CgoiZ2VuZXJpYyB3YXkiIHBhdGNoIGlzIG1lcmdlZC4KClJl
Z2FyZHMsCgpKaWUKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
