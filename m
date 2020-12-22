Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E272CC433DB
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 08:47:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794BF2311D
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 08:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794BF2311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 04AC785EC0;
	Tue, 22 Dec 2020 08:47:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VDZM62HdvxzP; Tue, 22 Dec 2020 08:47:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2937385EB8;
	Tue, 22 Dec 2020 08:47:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF537C1825;
	Tue, 22 Dec 2020 08:47:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0450CC0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 08:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EA32721507
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 08:47:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iwz9DGpfaHN5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 08:47:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 38484203F6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608626861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMcP2wLii6Kjvj+3Y3lAFZyeOUTv8mMHwaZj9JwWr84=;
 b=aVgT3EffFwMcAXXOa2zt55gHnhJAqCveLFwspIVlidvb8/074KKLx6TwDajns69s9NVcwV
 N4QHmlD9mzN7E0w49+ufDo5csYX0+VTi5XnDq38KkyQ/fT8C7uh2V60SpeLDwW/gOsZ5/p
 UABnlIa47WuK1Fc9/caZ3FvBy2VRz6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-qwENkSFTNHmswTNiqYGdzw-1; Tue, 22 Dec 2020 03:47:39 -0500
X-MC-Unique: qwENkSFTNHmswTNiqYGdzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B73F107ACE8;
 Tue, 22 Dec 2020 08:47:37 +0000 (UTC)
Received: from [10.36.113.220] (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A2C75D9F8;
 Tue, 22 Dec 2020 08:47:27 +0000 (UTC)
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
 Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20201221162519.GA22504@open-light-1.localdomain>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7bf0e895-52d6-9e2d-294b-980c33cf08e4@redhat.com>
Date: Tue, 22 Dec 2020 09:47:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201221162519.GA22504@open-light-1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

T24gMjEuMTIuMjAgMTc6MjUsIExpYW5nIExpIHdyb3RlOgo+IFRoZSBmaXJzdCB2ZXJzaW9uIGNh
biBiZSBmb3VuZCBhdDogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNC8xMi80Mgo+IAo+IFpl
cm8gb3V0IHRoZSBwYWdlIGNvbnRlbnQgdXN1YWxseSBoYXBwZW5zIHdoZW4gYWxsb2NhdGluZyBw
YWdlcyB3aXRoCj4gdGhlIGZsYWcgb2YgX19HRlBfWkVSTywgdGhpcyBpcyBhIHRpbWUgY29uc3Vt
aW5nIG9wZXJhdGlvbiwgaXQgbWFrZXMKPiB0aGUgcG9wdWxhdGlvbiBvZiBhIGxhcmdlIHZtYSBh
cmVhIHZlcnkgc2xvd2x5LiBUaGlzIHBhdGNoIGludHJvZHVjZQo+IGEgbmV3IGZlYXR1cmUgZm9y
IHplcm8gb3V0IHBhZ2VzIGJlZm9yZSBwYWdlIGFsbG9jYXRpb24sIGl0IGNhbiBoZWxwCj4gdG8g
c3BlZWQgdXAgcGFnZSBhbGxvY2F0aW9uIHdpdGggX19HRlBfWkVSTy4KPiAKPiBNeSBvcmlnaW5h
bCBpbnRlbnRpb24gZm9yIGFkZGluZyB0aGlzIGZlYXR1cmUgaXMgdG8gc2hvcnRlbiBWTQo+IGNy
ZWF0aW9uIHRpbWUgd2hlbiBTUi1JT1YgZGV2aWNkZSBpcyBhdHRhY2hlZCwgaXQgd29ya3MgZ29v
ZCBhbmQgdGhlCj4gVk0gY3JlYXRpb24gdGltZSBpcyByZWR1Y2VkIGJ5IGFib3V0IDkwJS4KPiAK
PiBDcmVhdGluZyBhIFZNIFs2NEcgUkFNLCAzMiBDUFVzXSB3aXRoIEdQVSBwYXNzdGhyb3VnaAo+
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4g
UUVNVSB1c2UgNEsgcGFnZXMsIFRIUCBpcyBvZmYKPiAgICAgICAgICAgICAgICAgICByb3VuZDEg
ICAgICByb3VuZDIgICAgICByb3VuZDMKPiB3L28gdGhpcyBwYXRjaDogICAgMjMuNXMgICAgICAg
MjQuN3MgICAgICAgMjQuNnMKPiB3LyB0aGlzIHBhdGNoOiAgICAgMTAuMnMgICAgICAgMTAuM3Mg
ICAgICAgMTEuMnMKPiAKPiBRRU1VIHVzZSA0SyBwYWdlcywgVEhQIGlzIG9uCj4gICAgICAgICAg
ICAgICAgICAgcm91bmQxICAgICAgcm91bmQyICAgICAgcm91bmQzCj4gdy9vIHRoaXMgcGF0Y2g6
ICAgIDE3LjlzICAgICAgIDE0LjhzICAgICAgIDE0LjlzCj4gdy8gdGhpcyBwYXRjaDogICAgIDEu
OXMgICAgICAgIDEuOHMgICAgICAgIDEuOXMKPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQo+IAoKSSBhbSBzdGlsbCBub3QgY29udmluY2VzIHRo
YXQgd2Ugd2FudC9uZWVkIHRoaXMgZm9yIHRoaXMgKG1haW4pIHVzZQpjYXNlLiBXaHkgY2FuJ3Qg
d2UgdXNlIGh1Z2UgcGFnZXMgZm9yIHN1Y2ggdXNlIGNhc2VzICh0aGF0IHJlYWxseSBjYXJlCmFi
b3V0IFZNIGNyZWF0aW9uIHRpbWUpIGFuZCByYXRoZXIgZGVhbCB3aXRoIHByZS16ZXJvaW5nIG9m
IGh1Z2UgcGFnZXMKaW5zdGVhZD8KCklmIHBvc3NpYmxlLCBJJ2QgbGlrZSB0byBhdm9pZCBHRlBf
WkVSTyAoZm9yIHJlYXNvbnMgYWxyZWFkeSBkaXNjdXNzZWQpLgoKPiBPYnZpb3VzbHksIGl0IGNh
biBkbyBtb3JlIHRoYW4gdGhpcy4gV2UgY2FuIGJlbmVmaXQgZnJvbSB0aGlzIGZlYXR1cmUKPiBp
biB0aGUgZmxvd2luZyBjYXNlOgo+IAo+IEludGVyYWN0aXZlIHNlbmNlCj4gPT09PT09PT09PT09
PT09PT0KPiBTaG9ydGVuIGFwcGxpY2F0aW9uIGx1bmNoIHRpbWUgb24gZGVza3RvcCBvciBtb2Jp
bGUgcGhvbmUsIGl0IGNhbiBoZWxwCj4gdG8gaW1wcm92ZSB0aGUgdXNlciBleHBlcmllbmNlLiBU
ZXN0IHNob3dzIG9uIGEKPiBzZXJ2ZXIgW0ludGVsKFIpIFhlb24oUikgQ1BVIEU1LTI2MjAgdjMg
QCAyLjQwR0h6XSwgemVybyBvdXQgMUdCIFJBTSBieQo+IHRoZSBrZXJuZWwgd2lsbCB0YWtlIGFi
b3V0IDIwMG1zLCB3aGlsZSBzb21lIG1haW5seSB1c2VkIGFwcGxpY2F0aW9uCj4gbGlrZSBGaXJl
Zm94IGJyb3dzZXIsIE9mZmljZSB3aWxsIGNvbnN1bWUgMTAwIH4gMzAwIE1CIFJBTSBqdXN0IGFm
dGVyCj4gbGF1bmNoLCBieSBwcmUgemVybyBvdXQgZnJlZSBwYWdlcywgaXQgbWVhbnMgdGhlIGFw
cGxpY2F0aW9uIGxhdW5jaAo+IHRpbWUgd2lsbCBiZSByZWR1Y2VkIGFib3V0IDIwfjYwbXMgKGNh
biBiZSB2aXN1YWwgc2Vuc2VkPykuIE1heSBiZQo+IHdlIGNhbiBtYWtlIHVzZSBvZiB0aGlzIGZl
YXR1cmUgdG8gc3BlZWQgdXAgdGhlIGxhdW5jaCBvZiBBbmRvcmlkIEFQUAo+IChJIGRpZG4ndCBk
byBhbnkgdGVzdCBmb3IgQW5kcm9pZCkuCgpJIGFtIG5vdCByZWFsbHkgc3VyZSBpZiB5b3UgY2Fu
IGFjdHVhbGx5IHZpc3VhbGx5IHNlbnNlIGEgZGlmZmVyZW5jZSBpbgp5b3VyIGV4YW1wbGVzLiBT
dGFydHVwIHRpbWUgb2YgYW4gYXBwbGljYXRpb24gaXMgbm90IGp1c3QgbWVtb3J5CmFsbG9jYXRp
b24gKHBhZ2UgemVyb2luZykgdGltZS4gSXQgd291bGQgYmUgaW50ZXJlc3Rpbmcgb2YgbXVjaCBv
ZiBhCmRpZmZlcmVuY2UgdGhpcyBhY3R1YWxseSBtYWtlcyBpbiBwcmFjdGljZS4gKGUuZy4sIGZp
cmVmb3ggc3RhcnR1cCB0aW1lCmV0Yy4pCgo+IAo+IFZpcnR1bGl6YXRpb24KPiA9PT09PT09PT09
PT09Cj4gU3BlZWQgdXAgVk0gY3JlYXRpb24gYW5kIHNob3J0ZW4gZ3Vlc3QgYm9vdCB0aW1lLCBl
c3BlY2lhbGx5IGZvciBQQ0kKPiBTUi1JT1YgZGV2aWNlIHBhc3N0aHJvdWdoIHNjZW5hcmlvLiBD
b21wYXJlZCB3aXRoIHNvbWUgb2YgdGhlIHBhcmEKPiB2aXRhbGl6YXRpb24gc29sdXRpb25zLCBp
dCBpcyBlYXN5IHRvIGRlcGxveSBiZWNhdXNlIGl04oCZcyB0cmFuc3BhcmVudAo+IHRvIGd1ZXN0
IGFuZCBjYW4gaGFuZGxlIERNQSBwcm9wZXJseSBpbiBCSU9TIHN0YWdlLCB3aGlsZSB0aGUgcGFy
YQo+IHZpcnR1YWxpemF0aW9uIHNvbHV0aW9uIGNhbuKAmXQgaGFuZGxlIGl0IHdlbGwuCgpXaGF0
IGlzIHRoZSAicGFyYSB2aXJ0dWFsaXphdGlvbiIgYXBwcm9hY2ggeW91IGFyZSB0YWxraW5nIGFi
b3V0PwoKPiAKPiBJbXByb3ZlIGd1ZXN0IHBlcmZvcm1hbmNlIHdoZW4gdXNlIFZJUlRJT19CQUxM
T09OX0ZfUkVQT1JUSU5HIGZvciBtZW1vcnkKPiBvdmVyY29tbWl0LiBUaGUgVklSVElPX0JBTExP
T05fRl9SRVBPUlRJTkcgZmVhdHVyZSB3aWxsIHJlcG9ydCBndWVzdCBwYWdlCj4gdG8gdGhlIFZN
TSwgVk1NIHdpbGwgdW5tYXAgdGhlIGNvcnJlc3BvbmRpbmcgaG9zdCBwYWdlIGZvciByZWNsYWlt
LAo+IHdoZW4gZ3Vlc3QgYWxsb2NhdGUgYSBwYWdlIGp1c3QgcmVjbGFpbWVkLCBob3N0IHdpbGwg
YWxsb2NhdGUgYSBuZXcgcGFnZQo+IGFuZCB6ZXJvIGl0IG91dCBmb3IgZ3Vlc3QsIGluIHRoaXMg
Y2FzZSBwcmUgemVybyBvdXQgZnJlZSBwYWdlIHdpbGwgaGVscAo+IHRvIHNwZWVkIHVwIHRoZSBw
cm9jY2VzcyBvZiBmYXVsdCBpbiBhbmQgcmVkdWNlIHRoZSBwZXJmb3JtYW5jZSBpbXBhY3Rpb24u
CgpTdWNoIGZhdWx0cyBpbiB0aGUgVk1NIGFyZSBubyBkaWZmZXJlbnQgdG8gb3RoZXIgZmF1bHRz
LCB3aGVuIGZpcnN0CmFjY2Vzc2luZyBhIHBhZ2UgdG8gYmUgcG9wdWxhdGVkLiBBZ2FpbiwgSSB3
b25kZXIgaG93IG11Y2ggb2YgYQpkaWZmZXJlbmNlIGl0IGFjdHVhbGx5IG1ha2VzLgoKPiAKPiBT
cGVlZCB1cCBrZXJuZWwgcm91dGluZQo+ID09PT09PT09PT09PT09PT09PT09PT09Cj4gVGhpcyBj
YW7igJl0IGJlIGd1YXJhbnRlZWQgYmVjYXVzZSB3ZSBkb27igJl0IHByZSB6ZXJvIG91dCBhbGwg
dGhlIGZyZWUgcGFnZXMsCj4gYnV0IGlzIHRydWUgZm9yIG1vc3QgY2FzZS4gSXQgY2FuIGhlbHAg
dG8gc3BlZWQgdXAgc29tZSBpbXBvcnRhbnQgc3lzdGVtCj4gY2FsbCBqdXN0IGxpa2UgZm9yaywg
d2hpY2ggd2lsbCBhbGxvY2F0ZSB6ZXJvIHBhZ2VzIGZvciBidWlsZGluZyBwYWdlCj4gdGFibGUu
IEFuZCBzcGVlZCB1cCB0aGUgcHJvY2VzcyBvZiBwYWdlIGZhdWx0LCBlc3BlY2lhbGx5IGZvciBo
dWdlIHBhZ2UKPiBmYXVsdC4gVGhlIFBPQyBvZiBIdWdldGxiIGZyZWUgcGFnZSBwcmUgemVybyBv
dXQgaGFzIGJlZW4gZG9uZS4KCldvdWxkIGJlIGludGVyZXN0aW5nIHRvIGhhdmUgYW4gYWN0dWFs
IGV4YW1wbGUgd2l0aCBzb21lIG51bWJlcnMuCgo+IAo+IFNlY3VyaXR5Cj4gPT09PT09PT0KPiBU
aGlzIGlzIGEgd2VhayB2ZXJzaW9uIG9mICJpbnRyb2R1Y2UgaW5pdF9vbl9hbGxvYz0xIGFuZCBp
bml0X29uX2ZyZWU9MQo+IGJvb3Qgb3B0aW9ucyIsIHdoaWNoIHplcm8gb3V0IHBhZ2UgaW4gYSBh
c3luY2hyb25vdXMgd2F5LiBGb3IgdXNlcnMgY2FuJ3QKPiB0b2xlcmF0ZSB0aGUgaW1wYWN0aW9u
IG9mICdpbml0X29uX2FsbG9jPTEnIG9yICdpbml0X29uX2ZyZWU9MScgYnJpbmdzLAo+IHRoaXMg
ZmVhdXR1cmUgcHJvdmlkZSBhbm90aGVyIGNob2ljZS4KCiJ3ZSBkb27igJl0IHByZSB6ZXJvIG91
dCBhbGwgdGhlIGZyZWUgcGFnZXMiIHNvIHRoaXMgaXMgb2YgbGl0dGxlIGFjdHVhbCB1c2UuCgot
LSAKVGhhbmtzLAoKRGF2aWQgLyBkaGlsZGVuYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
