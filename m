Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5EDC433DB
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 09:30:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDEA2222A
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 09:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDEA2222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7351D8666A;
	Tue,  5 Jan 2021 09:30:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MZ9+VlU7jWRF; Tue,  5 Jan 2021 09:30:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B7067864DA;
	Tue,  5 Jan 2021 09:30:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C628C0891;
	Tue,  5 Jan 2021 09:30:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00D76C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 09:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E2F2A86667
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 09:29:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gMjhvhJc4m04
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 09:29:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 233C8864DA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 09:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609838996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tuu9jZl4ygMZucY8oUdrOoGRv8r43O0YhW/HHyjwp4=;
 b=VkM0ldvzz2R/52MF2P6WNnbiQo3ctpbh2IJq8wUaoAyrksRWmIE+cRbyKoqg2yeM7Duin1
 3DwELFjuisJGOrIXsr/aRZdnyUQ6Ioge7Vm1zx4fyDLXhAXTTRLUu3G4lwEkbMJAYcWi56
 iS9DmfCZzHz0LrK/OczMb6Xj60GfSJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-G9p_NeVKNDeNlGFrnBl8nA-1; Tue, 05 Jan 2021 04:29:55 -0500
X-MC-Unique: G9p_NeVKNDeNlGFrnBl8nA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C564107ACE3;
 Tue,  5 Jan 2021 09:29:53 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C45531002382;
 Tue,  5 Jan 2021 09:29:46 +0000 (UTC)
Subject: Re: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page
 allocation for __GFP_ZERO
To: Michal Hocko <mhocko@suse.com>, Dave Hansen <dave.hansen@intel.com>
References: <a5ba7bdf-8510-d0a0-9c22-ec1b81019982@intel.com>
 <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com>
 <6bfcc500-7c11-f66a-26ea-e8b8bcc79e28@intel.com>
 <20210105092037.GY13207@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <71953119-06ff-0bb8-1879-09e24bf80446@redhat.com>
Date: Tue, 5 Jan 2021 10:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210105092037.GY13207@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Andrea Arcangeli <aarcange@redhat.com>,
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

T24gMDUuMDEuMjEgMTA6MjAsIE1pY2hhbCBIb2NrbyB3cm90ZToKPiBPbiBNb24gMDQtMDEtMjEg
MTU6MDA6MzEsIERhdmUgSGFuc2VuIHdyb3RlOgo+PiBPbiAxLzQvMjEgMTI6MTEgUE0sIERhdmlk
IEhpbGRlbmJyYW5kIHdyb3RlOgo+Pj4+IFllYWgsIGl0IGNlcnRhaW5seSBjYW4ndCBiZSB0aGUg
ZGVmYXVsdCwgYnV0IGl0ICppcyogdXNlZnVsIGZvcgo+Pj4+IHRoaW5nIHdoZXJlIHdlIGtub3cg
dGhhdCB0aGVyZSBhcmUgbm8gY2FjaGUgYmVuZWZpdHMgdG8gemVyb2luZwo+Pj4+IGNsb3NlIHRv
IHdoZXJlIHRoZSBtZW1vcnkgaXMgYWxsb2NhdGVkLgo+Pj4+Cj4+Pj4gVGhlIHRyaWNrIGlzIG9w
dGluZyBpbnRvIGl0IHNvbWVob3csIGVpdGhlciBpbiBhIHByb2Nlc3Mgb3IgYSBWTUEuCj4+Pj4K
Pj4+IFRoZSBwYXRjaCBzZXQgaXMgbW9zdGx5IHRyeWluZyB0byBvcHRpbWl6ZSBzdGFydGluZyBh
IG5ldyBwcm9jZXNzLiBTbwo+Pj4gcHJvY2Vzcy92bWEgZG9lc27igJh0IHJlYWxseSB3b3JrLgo+
Pgo+PiBMZXQncyBzYXkgeW91IGhhdmUgYSBzeXN0ZW0td2lkZSB0dW5hYmxlIHRoYXQgc2F5czog
cHJlLXplcm8gcGFnZXMgYW5kCj4+IGtlZXAgMTBHQiBvZiB0aGVtIGFyb3VuZC4gIFRoZW4sIHlv
dSBvcHQtaW4gYSBwcm9jZXNzIHRvIGJlaW5nIGFsbG93ZWQKPj4gdG8gZGlwIGludG8gdGhhdCBw
b29sIHdpdGggYSBwcm9jZXNzLXdpZGUgZmxhZyBvciBhbiBtYWR2aXNlKCkgY2FsbC4KPj4gWW91
IGNvdWxkIGV2ZW4gaGF2ZSB0aGUgZmxhZyBiZSBpbmhlcml0ZWQgYWNyb3NzIGV4ZWN2ZSgpIGlm
IHlvdSB3YW50ZWQKPj4gdG8gaGF2ZSBoZWxwZXIgYXBwcyBiZSBhYmxlIHRvIHNldCB0aGUgcG9s
aWN5IGFuZCBhY2Nlc3MgdGhlIHBvb2wgbGlrZQo+PiBob3cgbnVtYWN0bCB3b3Jrcy4KPiAKPiBX
aGlsZSBwb3NzaWJsZSwgaXQgc291bmRzIHF1aXRlIGhlYXZ5IHdlaWdodCB0byBtZS4gUGFnZSBh
bGxvY2F0b3Igd291bGQKPiBoYXZlIHRvIHNvbWVob3cgbWFpbnRhaW4gdGhvc2UgcHJlLXplcm9l
ZCBwYWdlcy4gVGhpcyBwb29sIHdpbGwgYWxzbwo+IGJlY29tZSBhIHZlcnkgc2NhcmNlIHJlc291
cmNlIHZlcnkgc29vbiBiZWNhdXNlIGV2ZXJ5Ym9keSBqdXN0IHdhbnQgdG8KPiBydW4gZmFzdGVy
LiBTbyB0aGlzIHdvdWxkIG9wZW4gbWFueSBtb3JlIGludGVyZXN0aW5nIHF1ZXN0aW9ucy4KCkFn
cmVlZC4KCj4gCj4gQSBnbG9iYWwga25vYiB3aXRoIGFsbCBvciBub3RoaW5nIHNvdW5kcyBsaWtl
IGFuIGVhc2llciB0byB1c2UgYW5kCj4gbWFpbnRhaW4gc29sdXRpb24gdG8gbWUuCgpJIG1lYW4s
IHRoYXQgYnJpbmdzIG1lIGJhY2sgdG8gbXkgb3JpZ2luYWwgc3VnZ2VzdGlvbjoganVzdCB1c2UK
aHVnZXRsYmZzIGFuZCBpbXBsZW1lbnQgc29tZSBzb3J0IG9mIHByZS16ZXJvaW5nIHRoZXJlICh3
b3JrZXIgdGhyZWFkLAp3aGF0c29ldmVyKS4gTW9zdCB2ZmlvIHVzZXJzIHNob3VsZCBhbHJlYWR5
IGJlIGJldHRlciBvZiB1c2luZyBodWdlcGFnZXMuCgpJdCdzIGEgInBvb2wgb2YgcGFnZXMiIGFs
cmVhZHkuIFNlbGVjdGVkIHVzZXJzIHVzZSBpdC4gSSByZWFsbHkgZG9uJ3QKc2VlIGEgbmVlZCB0
byBleHRlbmQgdGhlIGJ1ZGR5IHdpdGggc29tZXRoaW5nIGxpa2UgdGhhdC4KCi0tIApUaGFua3Ms
CgpEYXZpZCAvIGRoaWxkZW5iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
