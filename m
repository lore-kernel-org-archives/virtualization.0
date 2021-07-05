Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0278EC07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 07:13:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84752613F6
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 07:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84752613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 46567402E7;
	Mon,  5 Jul 2021 07:13:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1_PQOxzYojB8; Mon,  5 Jul 2021 07:13:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A67F4400B5;
	Mon,  5 Jul 2021 07:13:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8149CC001A;
	Mon,  5 Jul 2021 07:13:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7D87C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 07:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B48878316F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 07:13:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TCcZO8wdExdB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 07:13:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 564E883145
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 07:13:37 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="196219105"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; d="scan'208";a="196219105"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2021 00:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; d="scan'208";a="562446643"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2021 00:13:26 -0700
Subject: Re: [PATCH v12] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
 <20210705024056.ndth2bwn2itii5g3@vireshk-i7>
 <332af2be-0fb0-a846-8092-49d496fe8b6b@intel.com>
 <20210705043841.zujwo672nfdndpg2@vireshk-i7>
 <6aabc877-673a-e2bc-da2d-ec6741b4159b@intel.com>
 <20210705063003.a45ic3wn74nre6xe@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <273be5a6-c45f-8f12-361f-65caf0c3d08b@intel.com>
Date: Mon, 5 Jul 2021 15:13:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210705063003.a45ic3wn74nre6xe@vireshk-i7>
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

T24gMjAyMS83LzUgMTQ6MzAsIFZpcmVzaCBLdW1hciB3cm90ZToKCj4+Cj4+IFRoaXMgaXMgc3Rp
bGwgbm90IGVub3VnaCB0byBjb252aW5jZSBtZS7CoCBTbyBJIHdvbid0IGNoYW5nZSB0aGVtIGZv
ciBub3cKPj4gdW50aWwgSSBzZWUgaXQKPj4KPj4gaXMgdGhlIGNvbnNlbnN1cyBvZiB0aGUgbWFq
b3JpdHkuCj4gRG8geW91IHNlZSByZXFzW2ldIHRvIGV2ZXIgYmUgTlVMTCBoZXJlID8gSWYgbm90
LCB0aGVuIGlmIChyZXEpIGlzIGxpa2UgaWYKPiAodHJ1ZSkuCj4KPiBXaHkgd291bGQgeW91IHdh
bnQgdG8gaGF2ZSBzb21ldGhpbmcgbGlrZSB0aGF0ID8KCk5vLiBDdXJyZW50bHksIHZpcnRpb19p
MmNfY29tcGxldGVfcmVxcyBpcyBvbmx5IGNhbGxlZCBieSAKdmlydGlvX2kyY194ZmVyLCB0aHVz
IHdlIGRvbid0CgpoYXZlIHJlcXNbaV0gdG8gYmUgTlVMTC4gQnV0IEkgdGhpbmsgInZpcnRpb19p
MmNfY29tcGxldGVfcmVxcyIgYXMgYW4gCmluZGVwZW5kZW50IGZ1bmN0aW9uCgpzaG91bGQgY29u
c2lkZXIgdGhpcyBmcm9tIGEgY2FsbGVlIHBlcnNwZWN0aXZlLgoKQW55d2F5LCBpZiB5b3UgcmVh
bGx5IHRoaW5rIGl0IHNob3VsZCBiZSBjaGFuZ2VkLCBpdCBjYW4gYmUgZml4ZWQgCmluY3JlbWVu
dGFsbHkgYXMgV29sZnJhbSBzYWlkLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
