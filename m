Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C78C433E6
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 10:27:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6248C2250E
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 10:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6248C2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 19EF685D52;
	Tue,  5 Jan 2021 10:27:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O51eEtzYUNlY; Tue,  5 Jan 2021 10:27:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 94B8085D68;
	Tue,  5 Jan 2021 10:27:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C585C088B;
	Tue,  5 Jan 2021 10:27:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C26CCC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 10:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A9E3D85D52
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 10:27:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PwW_4j9B7--m
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 10:27:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F36F985313
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609842447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GnN5IEGJ/23g6PIWT40J6HpSWq+j0GIc1IYqRwgM3sQ=;
 b=NKn5uWKyeWsTMkyr4xrGKix6Mts/Q5mEGEVdxSVhmdc9OjdFD9hXpYcD5f1v0zIsEc5VUu
 Qn5QcswNvw/ozC0MUF1fzLPybv4rrRbnNso9E/H+qiXblFoqNEwOoytfK9qXp7Q7mRzpLD
 KxWGxMfT330takzEGy50a0TqXAHaL2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-OgiryqcPOmOX81V2EvMReg-1; Tue, 05 Jan 2021 05:27:24 -0500
X-MC-Unique: OgiryqcPOmOX81V2EvMReg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 162F71572B;
 Tue,  5 Jan 2021 10:27:22 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B72D770959;
 Tue,  5 Jan 2021 10:27:11 +0000 (UTC)
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To: Liang Li <liliang324@gmail.com>
References: <CA+2MQi_C-PTqyrqBprhtGBAiDBnPQBzwu6hvyuk+QiKy0L3sHw@mail.gmail.com>
 <96BB0656-F234-4634-853E-E2A747B6ECDB@redhat.com>
 <CA+2MQi_O47B8zOa_TwZqzRsS0LFoPS77+61mUV=yT1U3sa6xQw@mail.gmail.com>
 <eea984f8-dbff-35d3-2c93-db8dc4b700c5@redhat.com>
 <CA+2MQi9Qb5srEcx4qKNVWdphBGP0=HHV_h0hWghDMFKFmCOTMg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <85f16139-b499-dd02-f2bc-c3c42d57ccd8@redhat.com>
Date: Tue, 5 Jan 2021 11:27:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+2MQi9Qb5srEcx4qKNVWdphBGP0=HHV_h0hWghDMFKFmCOTMg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
 Liang Li <liliangleo@didiglobal.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>
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

T24gMDUuMDEuMjEgMTE6MjIsIExpYW5nIExpIHdyb3RlOgo+Pj4+IFRoYXTigJhzIG1vc3RseSBh
bHJlYWR5IGV4aXN0aW5nIHNjaGVkdWxpbmcgbG9naWMsIG5vPyAoSG93IG1hbnkgdm1zIGNhbiBJ
IHB1dCBvbnRvIGEgc3BlY2lmaWMgbWFjaGluZSBldmVudHVhbGx5KQo+Pj4KPj4+IEl0IGRlcGVu
ZHMgb24gaG93IHRoZSBzY2hlZHVsaW5nIGNvbXBvbmVudCBpcyBkZXNpZ25lZC4gWWVzLCB5b3Ug
Y2FuIHB1dAo+Pj4gMTAgVk1zIHdpdGggNEM4Ryg0Q1BVLCA4RyBSQU0pIG9uIGEgaG9zdCBhbmQg
MjAgVk1zIHdpdGggMkM0RyBvbgo+Pj4gYW5vdGhlciBvbmUuIEJ1dCBpZiBvbmUgdHlwZSBvZiB0
aGVtLCBlLmcuIDRDOEcgYXJlIHNvbGQgb3V0LCBjdXN0b21lcnMKPj4+IGNhbid0IGJ5IG1vcmUg
NEM4RyBWTSB3aGlsZSB0aGVyZSBhcmUgc29tZSBmcmVlIDJDNEcgVk1zLCB0aGUgcmVzb3VyY2UK
Pj4+IHJlc2VydmVkIGZvciB0aGVtIGNhbiBiZSBwcm92aWRlZCBhcyA0QzhHIFZNcwo+Pj4KPj4K
Pj4gMS4gWW91IGNhbiwganVzdCB0aGUgc3RhcnR1cCB0aW1lIHdpbGwgYmUgYSBsaXR0bGUgc2xv
d2VyPyBFLmcuLCBncm93Cj4+IHByZS1hbGxvY2F0ZWQgNEcgZmlsZSB0byA4Ry4KPj4KPj4gMi4g
T3IgbGV0J3MgYmUgY3JlYXRpdmU6IHRlYWNoIFFFTVUgdG8gY29uc3RydWN0IGEgc2luZ2xlCj4+
IFJBTUJsb2NrL01lbW9yeVJlZ2lvbiBvdXQgb2YgbXVsdGlwbGUgdG1wZnMgZmlsZXMuIFdvcmtz
IGFzIGxvbmcgYXMgeW91Cj4+IGRvbid0IGdvIGNyYXp5IG9uIGRpZmZlcmVudCBWTSBzaXplcyAv
IHNpemUgZGlmZmVyZW5jZXMuCj4+Cj4+IDMuIEluIHlvdXIgZXhhbXBsZSBhYm92ZSwgeW91IGNh
biBkeW5hbWljYWxseSByZWJhbGFuY2UgYXMgVk1zIGFyZQo+PiBnZXR0aW5nIHNvbGQsIHRvIG1h
a2Ugc3VyZSB5b3UgYWx3YXlzIGhhdmUgImJpZyBvbmVzIiBseWluZyBhcm91bmQgeW91Cj4+IGNh
biBzaHJpbmsgb24gZGVtYW5kLgo+Pgo+IFllcywgd2UgY2FuIGFsd2F5cyBjb21lIHVwIHdpdGgg
c29tZSB3YXlzIHRvIG1ha2UgdGhpbmdzIHdvcmsuCj4gaXQgd2lsbCBtYWtlIHRoZSBkZXZlbG9w
ZXIgb2YgdGhlIHVwcGVyIGxheWVyIGNvbXBvbmVudCBjcmF6eSA6KQoKSSdkIHNheSB0aGF0J3Mg
bGlmZSBpbiB1cHBlciBsYXllcnMgdG8gb3B0aW1pemUgc3BlY2lhbCAoISkgdXNlIGNhc2VzLiA6
KQoKPj4+Cj4+PiBZb3UgbXVzdCBrbm93IHRoZXJlIGFyZSBhIGxvdCBvZiBmdW5jdGlvbnMgaW4g
dGhlIGtlcm5lbCB3aGljaCBjYW4KPj4+IGJlIGRvbmUgaW4gdXNlcnNwYWNlLiBlLmcuIFNvbWUg
b2YgdGhlIGRldmljZSBlbXVsYXRpb25zIGxpa2UgQVBJQywKPj4+IHZob3N0LW5ldCBiYWNrZW5k
IHdoaWNoIGhhcyB1c2Vyc3BhY2UgaW1wbGVtZW50YXRpb24uICAgOikKPj4+IEJhZCBvciBub3Qg
ZGVwZW5kcyBvbiB0aGUgYmVuZWZpdHMgdGhlIHNvbHV0aW9uIGJyaW5ncy4KPj4+IEZyb20gdGhl
IHZpZXdwb2ludCBvZiBhIHVzZXIgc3BhY2UgYXBwbGljYXRpb24sIHRoZSBrZXJuZWwgc2hvdWxk
Cj4+PiBwcm92aWRlIGhpZ2ggcGVyZm9ybWFuY2UgbWVtb3J5IG1hbmFnZW1lbnQgc2VydmljZS4g
VGhhdCdzIHdoeQo+Pj4gSSB0aGluayBpdCBzaG91bGQgYmUgZG9uZSBpbiB0aGUga2VybmVsLgo+
Pgo+PiBBcyBJIGV4cHJlc3NlZCBhIGNvdXBsZSBvZiB0aW1lcyBhbHJlYWR5LCBJIGRvbid0IHNl
ZSB3aHkgdXNpbmcKPj4gaHVnZXRsYmZzIGFuZCBpbXBsZW1lbnRpbmcgc29tZSBzb3J0IG9mIHBy
ZS16ZXJvaW5nIHRoZXJlIGlzbid0IHN1ZmZpY2llbnQuCj4gCj4gRGlkIEkgbWlzcyBzb21ldGhp
bmcgYmVmb3JlPyBJIHRob3VnaHQgeW91IGRvdWJ0IHRoZSBuZWVkIGZvcgo+IGh1Z2V0bGJmcyBm
cmVlIHBhZ2UgcHJlIHplcm8gb3V0LiBIdWdldGxiZnMgaXMgYSBnb29kIGNob2ljZSBhbmQgaXMK
PiBzdWZmaWNpZW50LgoKSSByZW1lbWJlciBldmVuIHN1Z2dlc3RpbmcgdG8gZm9jdXMgb24gaHVn
ZXRsYmZzIGR1cmluZyB5b3VyIEtWTSB0YWxrCndoZW4gY2hhdHRpbmcuIE1heWJlIEkgd2FzIG5v
dCBjbGVhciBiZWZvcmUuCgo+IAo+PiBXZSByZWFsbHkgZG9uJ3QgKndhbnQqIGNvbXBsaWNhdGVk
IHRoaW5ncyBkZWVwIGRvd24gaW4gdGhlIG1tIGNvcmUgaWYKPj4gdGhlcmUgYXJlIHJlYXNvbmFi
bGUgYWx0ZXJuYXRpdmVzLgo+Pgo+IEkgdW5kZXJzdGFuZCB5b3VyIGNvbmNlcm4sIHdlIHNob3Vs
ZCBoYXZlIHN1ZmZpY2llbnQgcmVhc29uIHRvIGFkZCBhIG5ldwo+IGZlYXR1cmUgdG8gdGhlIGtl
cm5lbC4gQW5kIGZvciB0aGlzIG9uZSwgaXQncyBtb3N0IHZhbHVlIGlzIHRvIG1ha2UgdGhlCj4g
YXBwbGljYXRpb24ncyBsaWZlIGlzIGVhc2llci4gQW5kIGltcGxlbWVudGluZyBpdCBpbiBodWdl
dGxiZnMgY2FuIGF2b2lkCj4gYWRkaW5nIG1vcmUgY29tcGxleGl0eSB0byBjb3JlIE1NLgoKRXhh
Y3RseSwgdGhhdCdzIG15IHBvaW50LiBTb21lIHBlb3BsZSBtaWdodCBzdGlsbCBkaXNhZ3JlZSB3
aXRoIHRoZQpodWdldGxiZnMgYXBwcm9hY2gsIGJ1dCB0aGVyZSBpdCdzIGVhc2llciB0byBhZGQg
dHVuYWJsZXMgd2l0aG91dAphZmZlY3RpbmcgdGhlIG92ZXJhbGwgc3lzdGVtLgoKLS0gClRoYW5r
cywKCkRhdmlkIC8gZGhpbGRlbmIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
