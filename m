Return-Path: <SRS0=9O9Z=CM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912F4C433E7
	for <virtualization@archiver.kernel.org>; Thu,  3 Sep 2020 07:19:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A127206EB
	for <virtualization@archiver.kernel.org>; Thu,  3 Sep 2020 07:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A127206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F045987355;
	Thu,  3 Sep 2020 07:19:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eXjBCxgSZXIp; Thu,  3 Sep 2020 07:19:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 55F4D87352;
	Thu,  3 Sep 2020 07:19:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 429BEC0052;
	Thu,  3 Sep 2020 07:19:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C616C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 07:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 684AE86B0B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 07:19:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l31LpCFVN6wr
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 07:19:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 85D8E86687
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 07:19:08 +0000 (UTC)
IronPort-SDR: C64J/D+tBvw5ntmUD3yn4/daETg6vGzWirfSc/dwFwtgJUkirpkwAAL8eMQ1UG+iSbAxv0fKsG
 m9/ZDPOiW4Hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="155036823"
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; d="scan'208";a="155036823"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 00:19:08 -0700
IronPort-SDR: fTo99JnhqCgFkBUut2syhSAtgp8nnudAzDtvy9C5FvzNlHqF0dG9gg8yaORwLKYvna9eRwj6/8
 Pp5RHPpGzBCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; d="scan'208";a="297946856"
Received: from unknown (HELO [10.239.154.46]) ([10.239.154.46])
 by orsmga003.jf.intel.com with ESMTP; 03 Sep 2020 00:19:03 -0700
Subject: Re: [PATCH] i2c: virtio: add a virtio i2c frontend driver
To: Jason Wang <jasowang@redhat.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <0efc2605c8c06b4b1bf68cbad5536c4a900dc019.1599110284.git.jie.deng@intel.com>
 <f3ab5d7d-cce5-b34c-5931-dd5d74f065e7@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <6517879c-15d4-6265-761c-626cba9c95d6@intel.com>
Date: Thu, 3 Sep 2020 15:19:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <f3ab5d7d-cce5-b34c-5931-dd5d74f065e7@redhat.com>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, mst@redhat.com, krzk@kernel.org,
 tali.perry1@gmail.com, wsa@kernel.org, wsa+renesas@sang-engineering.com,
 jarkko.nikula@linux.intel.com, rppt@kernel.org, shuo.a.liu@intel.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, jdelvare@suse.de
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

Ck9uIDIwMjAvOS8zIDE0OjEyLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAyMC85LzMg5LiL
5Y2IMTozNCwgSmllIERlbmcgd3JvdGU6Cj4+IEFkZCBhbiBJMkMgYnVzIGRyaXZlciBmb3Igdmly
dGlvIHBhcmEtdmlydHVhbGl6YXRpb24uCj4+Cj4+IFRoZSBjb250cm9sbGVyIGNhbiBiZSBlbXVs
YXRlZCBieSB0aGUgYmFja2VuZCBkcml2ZXIgaW4KPj4gYW55IGRldmljZSBtb2RlbCBzb2Z0d2Fy
ZSBieSBmb2xsb3dpbmcgdGhlIHZpcnRpbyBwcm90b2NvbC4KPj4KPj4gVGhpcyBkcml2ZXIgY29t
bXVuaWNhdGVzIHdpdGggdGhlIGJhY2tlbmQgZHJpdmVyIHRocm91Z2ggYQo+PiB2aXJ0aW8gSTJD
IG1lc3NhZ2Ugc3RydWN0dXJlIHdoaWNoIGluY2x1ZGVzIGZvbGxvd2luZyBwYXJ0czoKPj4KPj4g
LSBIZWFkZXI6IGkyY19tc2cgYWRkciwgZmxhZ3MsIGxlbi4KPj4gLSBEYXRhIGJ1ZmZlcjogdGhl
IHBvaW50ZXIgdG8gdGhlIGkyYyBtc2cgZGF0YS4KPj4gLSBTdGF0dXM6IHRoZSBwcm9jZXNzaW5n
IHJlc3VsdCBmcm9tIHRoZSBiYWNrZW5kLgo+Pgo+PiBQZW9wbGUgbWF5IGltcGxlbWVudCBkaWZm
ZXJlbnQgYmFja2VuZCBkcml2ZXJzIHRvIGVtdWxhdGUKPj4gZGlmZmVyZW50IGNvbnRyb2xsZXJz
IGFjY29yZGluZyB0byB0aGVpciBuZWVkcy4gQSBiYWNrZW5kCj4+IGV4YW1wbGUgY2FuIGJlIGZv
dW5kIGluIHRoZSBkZXZpY2UgbW9kZWwgb2YgdGhlIG9wZW4gc291cmNlCj4+IHByb2plY3QgQUNS
Ti4gRm9yIG1vcmUgaW5mb3JtYXRpb24sIHBsZWFzZSByZWZlciB0bwo+PiBodHRwczovL3Byb2pl
Y3RhY3JuLm9yZy4KPgo+Cj4gTWF5IEkga25vdyB0aGUgcmVhc29uIHdoeSBkb24ndCB5b3UgdXNl
IGkyYyBvciB2aXJ0aW8gZGlyZWN0bHk/Cj4KV2UgZG9uJ3Qgd2FudCB0byBhZGQgdmlydGlvIGRy
aXZlcnMgZm9yIGV2ZXJ5IEkyQyBkZXZpY2VzIGluIHRoZSBndWVzdHMuClRoaXMgYnVzIGRyaXZl
ciBpcyBkZXNpZ25lZCB0byBwcm92aWRlIGEgd2F5IHRvIGZsZXhpYmx5IGV4cG9zZSB0aGUgCnBo
eXNpY2FsCkkyQyBzbGF2ZSBkZXZpY2VzIHRvIHRoZSBndWVzdCB3aXRob3V0IGFkZGluZyBvciBj
aGFuZ2luZyB0aGUgZHJpdmVycyBvZiAKdGhlCkkyQyBzbGF2ZSBkZXZpY2VzIGluIHRoZSBndWVz
dCBPUy4KCgo+Cj4+Cj4+IFRoZSB2aXJ0aW8gZGV2aWNlIElEIDM0IGlzIHVzZWQgZm9yIHRoaXMg
STJDIGFkcHRlciBzaW5jZSBJRHMKPj4gYmVmb3JlIDM0IGhhdmUgYmVlbiByZXNlcnZlZCBieSBv
dGhlciB2aXJ0aW8gZGV2aWNlcy4KPgo+Cj4gSXMgdGhlcmUgYSBsaW5rIHRvIHRoZSBzcGVjIHBh
dGNoPwo+Cj4gVGhhbmtzCj4KSSBoYXZlbid0IHN1Ym1pdHRlZCB0aGUgcGF0Y2ggdG8gcmVzZXJ2
ZSB0aGUgSUQgaW4gc3BlYyB5ZXQuCkkgd3JpdGUgdGhlIElEIGhlcmUgYmVjYXVzZSBJIHdhbnQg
dG8gc2VlIHlvdXIgb3BpbmlvbnMgZmlyc3QuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
