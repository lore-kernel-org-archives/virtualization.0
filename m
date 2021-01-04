Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D1BC433DB
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 23:00:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9511520784
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 23:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9511520784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6FCE92037C;
	Mon,  4 Jan 2021 23:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1OL8oqjJS5dM; Mon,  4 Jan 2021 23:00:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E8C9720387;
	Mon,  4 Jan 2021 23:00:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D00EAC0893;
	Mon,  4 Jan 2021 23:00:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34D40C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 23:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 27FC985785
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 23:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1iq86KLukNYg
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 23:00:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8955885784
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 23:00:34 +0000 (UTC)
IronPort-SDR: qxMP04AfXtTrUQk5syS+IJKF1p3inTJ3/aODQiIBmcPhtYcbxfcuLVfzDZNnHU8ggYc8Hh5soy
 C9APvedoqyuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156807288"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; d="scan'208";a="156807288"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2021 15:00:32 -0800
IronPort-SDR: JTaMZyP7Q0sshosrow166L8VPmv8ZKWyp8gfmqrng2XLqpCfzo0trq7fUfGEIEhuJWMH6ZxjiG
 1P8FsDgu0FnA==
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; d="scan'208";a="360940055"
Received: from trhudson-mobl.amr.corp.intel.com (HELO [10.213.162.49])
 ([10.213.162.49])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2021 15:00:31 -0800
Subject: Re: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page
 allocation for __GFP_ZERO
To: David Hildenbrand <david@redhat.com>
References: <a5ba7bdf-8510-d0a0-9c22-ec1b81019982@intel.com>
 <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <6bfcc500-7c11-f66a-26ea-e8b8bcc79e28@intel.com>
Date: Mon, 4 Jan 2021 15:00:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com>
Content-Language: en-US
Cc: Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Liang Li <liliangleo@didiglobal.com>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org,
 Mel Gorman <mgorman@techsingularity.net>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMS80LzIxIDEyOjExIFBNLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToKPj4gWWVhaCwgaXQg
Y2VydGFpbmx5IGNhbid0IGJlIHRoZSBkZWZhdWx0LCBidXQgaXQgKmlzKiB1c2VmdWwgZm9yCj4+
IHRoaW5nIHdoZXJlIHdlIGtub3cgdGhhdCB0aGVyZSBhcmUgbm8gY2FjaGUgYmVuZWZpdHMgdG8g
emVyb2luZwo+PiBjbG9zZSB0byB3aGVyZSB0aGUgbWVtb3J5IGlzIGFsbG9jYXRlZC4KPj4gCj4+
IFRoZSB0cmljayBpcyBvcHRpbmcgaW50byBpdCBzb21laG93LCBlaXRoZXIgaW4gYSBwcm9jZXNz
IG9yIGEgVk1BLgo+PiAKPiBUaGUgcGF0Y2ggc2V0IGlzIG1vc3RseSB0cnlpbmcgdG8gb3B0aW1p
emUgc3RhcnRpbmcgYSBuZXcgcHJvY2Vzcy4gU28KPiBwcm9jZXNzL3ZtYSBkb2VzbuKAmHQgcmVh
bGx5IHdvcmsuCgpMZXQncyBzYXkgeW91IGhhdmUgYSBzeXN0ZW0td2lkZSB0dW5hYmxlIHRoYXQg
c2F5czogcHJlLXplcm8gcGFnZXMgYW5kCmtlZXAgMTBHQiBvZiB0aGVtIGFyb3VuZC4gIFRoZW4s
IHlvdSBvcHQtaW4gYSBwcm9jZXNzIHRvIGJlaW5nIGFsbG93ZWQKdG8gZGlwIGludG8gdGhhdCBw
b29sIHdpdGggYSBwcm9jZXNzLXdpZGUgZmxhZyBvciBhbiBtYWR2aXNlKCkgY2FsbC4KWW91IGNv
dWxkIGV2ZW4gaGF2ZSB0aGUgZmxhZyBiZSBpbmhlcml0ZWQgYWNyb3NzIGV4ZWN2ZSgpIGlmIHlv
dSB3YW50ZWQKdG8gaGF2ZSBoZWxwZXIgYXBwcyBiZSBhYmxlIHRvIHNldCB0aGUgcG9saWN5IGFu
ZCBhY2Nlc3MgdGhlIHBvb2wgbGlrZQpob3cgbnVtYWN0bCB3b3Jrcy4KCkRhbiBtYWtlcyBhIHZl
cnkgZ29vZCBwb2ludCBhYm91dCB1c2luZyBmaWxlc3lzdGVtcyBmb3IgdGhpcywgdGhvdWdoLgpJ
dCB3b3VsZG4ndCBiZSByb2NrZXQgc2NpZW5jZSB0byBzZXQgdXAgYSBzcGVjaWFsIHRtcGZzIG1v
dW50IGp1c3QgZm9yClZNIG1lbW9yeSBhbmQgcHJlLXplcm8gaXQgZnJvbSB1c2Vyc3BhY2UuICBG
b3IgcWVtdSwgeW91J2QgbmVlZCB0byB0ZWFjaAp0aGUgbWFuYWdlbWVudCBsYXllciB0byBoYW5k
IG91dCB6ZXJvZWQgZmlsZXMgdmlhIG1lbS1wYXRoPS4gIEhlY2ssIGlmCnlvdSB0YXVnaHQgTUFE
Vl9GUkVFIGhvdyB0byBoYW5kbGUgdG1wZnMsIHlvdSBjb3VsZCBldmVuIHByZS16ZXJvICphbmQq
CmdldCB0aGUgbWVtb3J5IGJhY2sgcXVpY2tseSBpZiB0aG9zZSBmaWxlcyBlbmRlZCB1cCBvdmVy
LXNpemVkIHNvbWVob3cuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
