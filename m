Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D6FC43381
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 09:39:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF8922482
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 09:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF8922482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A1FAC203ED;
	Tue,  5 Jan 2021 09:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7CY+O-1Uv+YF; Tue,  5 Jan 2021 09:39:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5FBB720495;
	Tue,  5 Jan 2021 09:39:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47A9FC0891;
	Tue,  5 Jan 2021 09:39:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D61D7C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 09:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D1EA887078
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 09:39:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id giaQGwjcr5IO
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 09:39:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CCF4986F97
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 09:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609839583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9GY3k7qYcAOAzWTuR5xc+9LJ5x2f7CmJLEuHkNfjAg=;
 b=QNHpBttqMUKVfyt+WFi0Wy0/tiUgOqR7OqtrlnfK2S+KjrblOFm2fTVJ6y2FJp9klrSSON
 /hPc0ivwcSxa0kNHM6PDAIKCokLaX1OhHipPDrpwFui548y0pghZJsjuYBrE64iwVfzeKS
 7uJO5v6aARkWXqlxA0GxTDU7YYBsrUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-J0kE12EeOROLHktCQJ6qww-1; Tue, 05 Jan 2021 04:39:39 -0500
X-MC-Unique: J0kE12EeOROLHktCQJ6qww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0EB0800D62;
 Tue,  5 Jan 2021 09:39:36 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28F0E60873;
 Tue,  5 Jan 2021 09:39:26 +0000 (UTC)
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To: Liang Li <liliang324@gmail.com>
References: <CA+2MQi_C-PTqyrqBprhtGBAiDBnPQBzwu6hvyuk+QiKy0L3sHw@mail.gmail.com>
 <96BB0656-F234-4634-853E-E2A747B6ECDB@redhat.com>
 <CA+2MQi_O47B8zOa_TwZqzRsS0LFoPS77+61mUV=yT1U3sa6xQw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <eea984f8-dbff-35d3-2c93-db8dc4b700c5@redhat.com>
Date: Tue, 5 Jan 2021 10:39:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+2MQi_O47B8zOa_TwZqzRsS0LFoPS77+61mUV=yT1U3sa6xQw@mail.gmail.com>
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

T24gMDUuMDEuMjEgMDM6MTQsIExpYW5nIExpIHdyb3RlOgo+Pj4+PiBJbiBvdXIgcHJvZHVjdGlv
biBlbnZpcm9ubWVudCwgdGhlcmUgYXJlIHRocmVlIG1haW4gYXBwbGljYXRpb25zIGhhdmUgc3Vj
aAo+Pj4+PiByZXF1aXJlbWVudCwgb25lIGlzIFFFTVUgW2NyZWF0aW5nIGEgVk0gd2l0aCBTUi1J
T1YgcGFzc3Rocm91Z2ggZGV2aWNlXSwKPj4+Pj4gYW50aGVyIG90aGVyIHR3byBhcmUgRFBESyBy
ZWxhdGVkIGFwcGxpY2F0aW9ucywgRFBESyBPVlMgYW5kIFNQREsgdmhvc3QsCj4+Pj4+IGZvciBi
ZXN0IHBlcmZvcm1hbmNlLCB0aGV5IHBvcHVsYXRlIG1lbW9yeSB3aGVuIHN0YXJ0aW5nIHVwLiBG
b3IgU1BESyB2aG9zdCwKPj4+Pj4gd2UgbWFrZSB1c2Ugb2YgdGhlIFZIT1NUX1VTRVJfR0VUL1NF
VF9JTkZMSUdIVF9GRCBmZWF0dXJlIGZvcgo+Pj4+PiB2aG9zdCAnbGl2ZScgdXBncmFkZSwgd2hp
Y2ggaXMgZG9uZSBieSBraWxsaW5nIHRoZSBvbGQgcHJvY2VzcyBhbmQKPj4+Pj4gc3RhcnRpbmcg
YSBuZXcKPj4+Pj4gb25lIHdpdGggdGhlIG5ldyBiaW5hcnkuIEluIHRoaXMgY2FzZSwgd2Ugd2Fu
dCB0aGUgbmV3IHByb2Nlc3Mgc3RhcnRlZCBhcyBxdWljawo+Pj4+PiBhcyBwb3NzaWJsZSB0byBz
aG9ydGVuIHRoZSBzZXJ2aWNlIGRvd250aW1lLiBXZSByZWFsbHkgZW5hYmxlIHRoaXMgZmVhdHVy
ZQo+Pj4+PiB0byBzcGVlZCB1cCBzdGFydHVwIHRpbWUgZm9yIHRoZW0gIDopCj4+Cj4+IEFtIEkg
d3Jvbmcgb3IgZG9lcyB1c2luZyBodWdlbHRiZnMvdG1wZnMgLi4uIGkuZS4sIGEgZmlsZSBub3Qt
ZGVsZXRlZCBiZXR3ZWVuIHNodXR0aW5nIGRvd24gdGhlIG9sZCBpbnN0YW5jZXMgYW5kIGZpcmlu
ZyB1cCB0aGUgbmV3IGluc3RhbmNlIGp1c3Qgc29sdmUgdGhpcyBpc3N1ZT8KPiAKPiBZb3UgYXJl
IHJpZ2h0LCBpdCB3b3JrcyBmb3IgdGhlIFNQREsgdmhvc3QgdXBncmFkZSBjYXNlLgo+IAo+Pgo+
Pj4+Cj4+Pj4gVGhhbmtzIGZvciBpbmZvIG9uIHRoZSB1c2UgY2FzZSEKPj4+Pgo+Pj4+IEFsbCBv
ZiB0aGVzZSB1c2UgY2FzZXMgZWl0aGVyIGFscmVhZHkgdXNlLCBvciBjb3VsZCB1c2UsIGh1Z2Ug
cGFnZXMKPj4+PiBJTUhPLiBJdCdzIG5vdCB5b3VyIG9yZGluYXJ5IHByb3ByaWV0YXJ5IGdhbWlu
ZyBhcHAgOikgVGhpcyBpcyB3aGVyZQo+Pj4+IHByZS16ZXJvaW5nIG9mIGh1Z2UgcGFnZXMgY291
bGQgYWxyZWFkeSBoZWxwLgo+Pj4KPj4+IFlvdSBhcmUgd2VsY29tZS4gIEZvciBzb21lIGhpc3Rv
cmljYWwgcmVhc29uLCBzb21lIG9mIG91ciBzZXJ2aWNlcyBhcmUKPj4+IG5vdCB1c2luZyBodWdl
dGxiZnMsIHRoYXQgaXMgd2h5IEkgZGlkbid0IHN0YXJ0IHdpdGggaHVnZXRsYmZzLgo+Pj4KPj4+
PiBKdXN0IHdvbmRlcmluZywgd291bGRuJ3QgaXQgYmUgcG9zc2libGUgdG8gdXNlIHRtcGZzL2h1
Z2V0bGJmcyAuLi4KPj4+PiBjcmVhdGluZyBhIGZpbGUgYW5kIHByZS16ZXJvaW5nIGl0IGZyb20g
YW5vdGhlciBwcm9jZXNzLCBvciBhbSBJIG1pc3NpbmcKPj4+PiBzb21ldGhpbmcgaW1wb3J0YW50
PyBBdCBsZWFzdCBmb3IgUUVNVSB0aGlzIHNob3VsZCB3b3JrIEFGQUlLLCB3aGVyZSB5b3UKPj4+
PiBjYW4ganVzdCBwYXNzIHRoZSBmaWxlIHRvIGJlIHVzZSB1c2luZyBtZW1vcnktYmFja2VuZC1m
aWxlLgo+Pj4+Cj4+PiBJZiB1c2luZyBhbm90aGVyIHByb2Nlc3MgdG8gY3JlYXRlIGEgZmlsZSwg
d2UgY2FuIG9mZmxvYWQgdGhlIG92ZXJoZWFkIHRvCj4+PiBhbm90aGVyIHByb2Nlc3MsIGFuZCB0
aGVyZSBpcyBubyBuZWVkIHRvIHByZS16ZXJvaW5nIGl0J3MgY29udGVudCwganVzdAo+Pj4gcG9w
dWxhdGluZyB0aGUgbWVtb3J5IGlzIGVub3VnaC4KPj4KPj4gUmlnaHQsIGlmIG5vbi16ZXJvIG1l
bW9yeSBjYW4gYmUgdG9sZXJhdGVkIChlLmcuLCBmb3Igdm1zIHVzdWFsbHkgaGFzIHRvKS4KPiAK
PiBJIG1lYW4gdGhlcmUgaXMgbm8gbmVlZCB0byBwcmUtemVyb2luZyB0aGUgZmlsZSBjb250ZW50
IG9idmlvdXNseSBpbiB1c2VyIHNwYWNlLAo+IHRoZSBrZXJuZWwgd2lsbCBkbyBpdCB3aGVuIHBv
cHVsYXRpbmcgdGhlIG1lbW9yeS4KPiAKPj4+IElmIHdlIGRvIGl0IHRoYXQgd2F5LCB0aGVuIGhv
dyB0byBkZXRlcm1pbmUgdGhlIHNpemUgb2YgdGhlIGZpbGU/IGl0IGRlcGVuZHMKPj4+IG9uIHRo
ZSBSQU0gc2l6ZSBvZiB0aGUgVk0gdGhlIGN1c3RvbWVyIGJ1eXMuCj4+PiBNYXliZSB3ZSBjYW4g
Y3JlYXRlIGEgZmlsZQo+Pj4gbGFyZ2UgZW5vdWdoIGluIGFkdmFuY2UgYW5kIHRydW5jYXRlIGl0
IHRvIHRoZSByaWdodCBzaXplIGp1c3QgYmVmb3JlIHRoZQo+Pj4gVk0gaXMgY3JlYXRlZC4gVGhl
biwgaG93IG1hbnkgbGFyZ2UgZmlsZXMgc2hvdWxkIGJlIGNyZWF0ZWQgb24gYSBob3N0Pwo+Pgo+
PiBUaGF04oCYcyBtb3N0bHkgYWxyZWFkeSBleGlzdGluZyBzY2hlZHVsaW5nIGxvZ2ljLCBubz8g
KEhvdyBtYW55IHZtcyBjYW4gSSBwdXQgb250byBhIHNwZWNpZmljIG1hY2hpbmUgZXZlbnR1YWxs
eSkKPiAKPiBJdCBkZXBlbmRzIG9uIGhvdyB0aGUgc2NoZWR1bGluZyBjb21wb25lbnQgaXMgZGVz
aWduZWQuIFllcywgeW91IGNhbiBwdXQKPiAxMCBWTXMgd2l0aCA0QzhHKDRDUFUsIDhHIFJBTSkg
b24gYSBob3N0IGFuZCAyMCBWTXMgd2l0aCAyQzRHIG9uCj4gYW5vdGhlciBvbmUuIEJ1dCBpZiBv
bmUgdHlwZSBvZiB0aGVtLCBlLmcuIDRDOEcgYXJlIHNvbGQgb3V0LCBjdXN0b21lcnMKPiBjYW4n
dCBieSBtb3JlIDRDOEcgVk0gd2hpbGUgdGhlcmUgYXJlIHNvbWUgZnJlZSAyQzRHIFZNcywgdGhl
IHJlc291cmNlCj4gcmVzZXJ2ZWQgZm9yIHRoZW0gY2FuIGJlIHByb3ZpZGVkIGFzIDRDOEcgVk1z
Cj4gCgoxLiBZb3UgY2FuLCBqdXN0IHRoZSBzdGFydHVwIHRpbWUgd2lsbCBiZSBhIGxpdHRsZSBz
bG93ZXI/IEUuZy4sIGdyb3cKcHJlLWFsbG9jYXRlZCA0RyBmaWxlIHRvIDhHLgoKMi4gT3IgbGV0
J3MgYmUgY3JlYXRpdmU6IHRlYWNoIFFFTVUgdG8gY29uc3RydWN0IGEgc2luZ2xlClJBTUJsb2Nr
L01lbW9yeVJlZ2lvbiBvdXQgb2YgbXVsdGlwbGUgdG1wZnMgZmlsZXMuIFdvcmtzIGFzIGxvbmcg
YXMgeW91CmRvbid0IGdvIGNyYXp5IG9uIGRpZmZlcmVudCBWTSBzaXplcyAvIHNpemUgZGlmZmVy
ZW5jZXMuCgozLiBJbiB5b3VyIGV4YW1wbGUgYWJvdmUsIHlvdSBjYW4gZHluYW1pY2FsbHkgcmVi
YWxhbmNlIGFzIFZNcyBhcmUKZ2V0dGluZyBzb2xkLCB0byBtYWtlIHN1cmUgeW91IGFsd2F5cyBo
YXZlICJiaWcgb25lcyIgbHlpbmcgYXJvdW5kIHlvdQpjYW4gc2hyaW5rIG9uIGRlbWFuZC4KCj4g
Cj4gWW91IG11c3Qga25vdyB0aGVyZSBhcmUgYSBsb3Qgb2YgZnVuY3Rpb25zIGluIHRoZSBrZXJu
ZWwgd2hpY2ggY2FuCj4gYmUgZG9uZSBpbiB1c2Vyc3BhY2UuIGUuZy4gU29tZSBvZiB0aGUgZGV2
aWNlIGVtdWxhdGlvbnMgbGlrZSBBUElDLAo+IHZob3N0LW5ldCBiYWNrZW5kIHdoaWNoIGhhcyB1
c2Vyc3BhY2UgaW1wbGVtZW50YXRpb24uICAgOikKPiBCYWQgb3Igbm90IGRlcGVuZHMgb24gdGhl
IGJlbmVmaXRzIHRoZSBzb2x1dGlvbiBicmluZ3MuCj4gRnJvbSB0aGUgdmlld3BvaW50IG9mIGEg
dXNlciBzcGFjZSBhcHBsaWNhdGlvbiwgdGhlIGtlcm5lbCBzaG91bGQKPiBwcm92aWRlIGhpZ2gg
cGVyZm9ybWFuY2UgbWVtb3J5IG1hbmFnZW1lbnQgc2VydmljZS4gVGhhdCdzIHdoeQo+IEkgdGhp
bmsgaXQgc2hvdWxkIGJlIGRvbmUgaW4gdGhlIGtlcm5lbC4KCkFzIEkgZXhwcmVzc2VkIGEgY291
cGxlIG9mIHRpbWVzIGFscmVhZHksIEkgZG9uJ3Qgc2VlIHdoeSB1c2luZwpodWdldGxiZnMgYW5k
IGltcGxlbWVudGluZyBzb21lIHNvcnQgb2YgcHJlLXplcm9pbmcgdGhlcmUgaXNuJ3Qgc3VmZmlj
aWVudC4KCldlIHJlYWxseSBkb24ndCAqd2FudCogY29tcGxpY2F0ZWQgdGhpbmdzIGRlZXAgZG93
biBpbiB0aGUgbW0gY29yZSBpZgp0aGVyZSBhcmUgcmVhc29uYWJsZSBhbHRlcm5hdGl2ZXMuCgot
LSAKVGhhbmtzLAoKRGF2aWQgLyBkaGlsZGVuYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
