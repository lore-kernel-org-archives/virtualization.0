Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236DAC433E0
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 11:58:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEEC224D4
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 11:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEEC224D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3957586A01;
	Tue, 22 Dec 2020 11:58:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U1AmA7SAw88w; Tue, 22 Dec 2020 11:58:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 02C26868AB;
	Tue, 22 Dec 2020 11:58:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C06CAC1787;
	Tue, 22 Dec 2020 11:58:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75F6AC0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 11:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 59F3C869F0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 11:58:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lwBo4HnHs63Z
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 11:58:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 08BB0868AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608638288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2qf5gIhcMVQKS3hR+V8X3H/dCp3GvNlzpFYpp+NKNs=;
 b=KWsIq3ETq7JinqnJVkQF2kCdpiMoD5BIp96GJ43HAkL+cWDAG+lYdbpEp52rgDjcK2YezO
 Qce44mlBM6hqpOF3J5RDxI/v51Z6Qxmiizp3WVxQwYGAVDdDl0w5wgsgqt/RL0/JVKMqlL
 952hUBnCyhyAdm3vK2Ws9pZUIGOLV7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-gXb2fMU9PgO7SaOF_AZm0g-1; Tue, 22 Dec 2020 06:58:04 -0500
X-MC-Unique: gXb2fMU9PgO7SaOF_AZm0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B30F1084C89;
 Tue, 22 Dec 2020 11:58:02 +0000 (UTC)
Received: from [10.36.113.220] (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FDC75E1B4;
 Tue, 22 Dec 2020 11:57:55 +0000 (UTC)
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To: Liang Li <liliang324@gmail.com>
References: <20201221162519.GA22504@open-light-1.localdomain>
 <7bf0e895-52d6-9e2d-294b-980c33cf08e4@redhat.com>
 <CA+2MQi89v=DZJZ7b-QaMsU2f42j4SRW47XcZvLtBj10YeqRGgQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <840ff69d-20d5-970a-1635-298000196f3e@redhat.com>
Date: Tue, 22 Dec 2020 12:57:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+2MQi89v=DZJZ7b-QaMsU2f42j4SRW47XcZvLtBj10YeqRGgQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
 Liang Li <liliangleo@didiglobal.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>,
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

PiAKPj4+Cj4+PiBWaXJ0dWxpemF0aW9uCj4+PiA9PT09PT09PT09PT09Cj4+PiBTcGVlZCB1cCBW
TSBjcmVhdGlvbiBhbmQgc2hvcnRlbiBndWVzdCBib290IHRpbWUsIGVzcGVjaWFsbHkgZm9yIFBD
SQo+Pj4gU1ItSU9WIGRldmljZSBwYXNzdGhyb3VnaCBzY2VuYXJpby4gQ29tcGFyZWQgd2l0aCBz
b21lIG9mIHRoZSBwYXJhCj4+PiB2aXRhbGl6YXRpb24gc29sdXRpb25zLCBpdCBpcyBlYXN5IHRv
IGRlcGxveSBiZWNhdXNlIGl04oCZcyB0cmFuc3BhcmVudAo+Pj4gdG8gZ3Vlc3QgYW5kIGNhbiBo
YW5kbGUgRE1BIHByb3Blcmx5IGluIEJJT1Mgc3RhZ2UsIHdoaWxlIHRoZSBwYXJhCj4+PiB2aXJ0
dWFsaXphdGlvbiBzb2x1dGlvbiBjYW7igJl0IGhhbmRsZSBpdCB3ZWxsLgo+Pgo+PiBXaGF0IGlz
IHRoZSAicGFyYSB2aXJ0dWFsaXphdGlvbiIgYXBwcm9hY2ggeW91IGFyZSB0YWxraW5nIGFib3V0
Pwo+IAo+IEkgcmVmZXIgdHdvIHRvcGljIGluIHRoZSBLVk0gZm9ydW0gMjAyMCwgdGhlIGRvYyBj
YW4gZ2l2ZSBtb3JlIGRldGFpbHMgOgo+IGh0dHBzOi8vc3RhdGljLnNjaGVkLmNvbS9ob3N0ZWRf
ZmlsZXMva3ZtZm9ydW0yMDIwLzQ4L2NvSU9NTVUucGRmCj4gaHR0cHM6Ly9zdGF0aWMuc2NoZWQu
Y29tL2hvc3RlZF9maWxlcy9rdm1mb3J1bTIwMjAvNTEvVGhlJTIwUHJhY3RpY2UlMjBNZXRob2Ql
MjB0byUyMFNwZWVkJTIwVXAlMjAxMHglMjBCb290LXVwJTIwVGltZSUyMGZvciUyMEd1ZXN0JTIw
aW4lMjBBbGliYWJhJTIwQ2xvdWQucGRmCj4gCj4gYW5kIHRoZSBmbG93aW5nIGxpbmsgaXMgbWlu
ZToKPiBodHRwczovL3N0YXRpYy5zY2hlZC5jb20vaG9zdGVkX2ZpbGVzL2t2bWZvcnVtMjAyMC85
MC9TcGVlZCUyMFVwJTIwQ3JlYXRpb24lMjBvZiUyMGElMjBWTSUyMFdpdGglMjBQYXNzdGhyb3Vn
aCUyMEdQVS5wZGYKClRoYW5rcyBmb3IgdGhlIHBvaW50ZXJzISBJIGFjdHVhbGx5IGRpZCB3YXRj
aCB5b3VyIHByZXNlbnRhdGlvbi4KCj4+Cj4+Pgo+Pj4gSW1wcm92ZSBndWVzdCBwZXJmb3JtYW5j
ZSB3aGVuIHVzZSBWSVJUSU9fQkFMTE9PTl9GX1JFUE9SVElORyBmb3IgbWVtb3J5Cj4+PiBvdmVy
Y29tbWl0LiBUaGUgVklSVElPX0JBTExPT05fRl9SRVBPUlRJTkcgZmVhdHVyZSB3aWxsIHJlcG9y
dCBndWVzdCBwYWdlCj4+PiB0byB0aGUgVk1NLCBWTU0gd2lsbCB1bm1hcCB0aGUgY29ycmVzcG9u
ZGluZyBob3N0IHBhZ2UgZm9yIHJlY2xhaW0sCj4+PiB3aGVuIGd1ZXN0IGFsbG9jYXRlIGEgcGFn
ZSBqdXN0IHJlY2xhaW1lZCwgaG9zdCB3aWxsIGFsbG9jYXRlIGEgbmV3IHBhZ2UKPj4+IGFuZCB6
ZXJvIGl0IG91dCBmb3IgZ3Vlc3QsIGluIHRoaXMgY2FzZSBwcmUgemVybyBvdXQgZnJlZSBwYWdl
IHdpbGwgaGVscAo+Pj4gdG8gc3BlZWQgdXAgdGhlIHByb2NjZXNzIG9mIGZhdWx0IGluIGFuZCBy
ZWR1Y2UgdGhlIHBlcmZvcm1hbmNlIGltcGFjdGlvbi4KPj4KPj4gU3VjaCBmYXVsdHMgaW4gdGhl
IFZNTSBhcmUgbm8gZGlmZmVyZW50IHRvIG90aGVyIGZhdWx0cywgd2hlbiBmaXJzdAo+PiBhY2Nl
c3NpbmcgYSBwYWdlIHRvIGJlIHBvcHVsYXRlZC4gQWdhaW4sIEkgd29uZGVyIGhvdyBtdWNoIG9m
IGEKPj4gZGlmZmVyZW5jZSBpdCBhY3R1YWxseSBtYWtlcy4KPj4KPiAKPiBJIGFtIG5vdCBqdXN0
IHJlZmVycmluZyB0byBmYXVsdHMgaW4gdGhlIFZNTSwgSSBtZWFuIHRoZSB3aG9sZSBwcm9jZXNz
Cj4gdGhhdCBoYW5kbGVzIGd1ZXN0IHBhZ2UgZmF1bHRzLgo+IHdpdGhvdXQgVklSVElPX0JBTExP
T05fRl9SRVBPUlRJTkcsIHBhZ2VzIHVzZWQgYnkgZ3Vlc3RzIHdpbGwgYmUgemVybwo+IG91dCBv
bmx5IG9uY2UgYnkgaG9zdC4gV2l0aCBWSVJUSU9fQkFMTE9PTl9GX1JFUE9SVElORywgZnJlZSBw
YWdlcyBhcmUKPiByZWNsYWltZWQgYnkgdGhlIGhvc3QgYW5kIG1heSByZXR1cm4gdG8gdGhlIGhv
c3QgYnVkZHkKPiBmcmVlIGxpc3QuIFdoZW4gdGhlIHBhZ2VzIGFyZSBnaXZlbiBiYWNrIHRvIHRo
ZSBndWVzdCwgdGhlIGhvc3Qga2VybmVsCj4gbmVlZHMgdG8gemVybyBvdXQgaXQgYWdhaW4uIEl0
IG1lYW5zCj4gd2l0aCBWSVJUSU9fQkFMTE9PTl9GX1JFUE9SVElORywgZ3Vlc3QgbWVtb3J5IHBl
cmZvcm1hbmNlIHdpbGwgYmUKPiBkZWdyYWRlZCBmb3IgZnJlcXVlbnRseQo+IHplcm8gb3V0IG9w
ZXJhdGlvbiBvbiBob3N0IHNpZGUuIFRoZSBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbiB3aWxsIGJl
Cj4gb2J2aW91cyBmb3IgaHVnZSBwYWdlIGNhc2UuIEZyZWUKPiBwYWdlIHByZSB6ZXJvIG91dCBj
YW4gaGVscCB0byBtYWtlIGd1ZXN0IG1lbW9yeSBwZXJmb3JtYW5jZSBhbG1vc3QgdGhlCj4gc2Ft
ZSBhcyB3aXRob3V0Cj4gVklSVElPX0JBTExPT05fRl9SRVBPUlRJTkcuCgpZZXMsIHdoYXQgSSBh
bSBzYXlpbmcgaXMgdGhhdCB0aGlzIGZhdWx0IGhhbmRsaW5nIGlzIG5vIGRpZmZlcmVudCB0bwpv
cmRpbmFyeSBmYXVsdHMgd2hlbiBhY2Nlc3NpbmcgYSB2aXJ0dWFsIG1lbW9yeSBsb2NhdGlvbiB0
aGUgZmlyc3QgdGltZQphbmQgcG9wdWxhdGluZyBhIHBhZ2UuIFRoZSBvbmx5IGRpZmZlcmVuY2Ug
aXMgdGhhdCBpdCBoYXBwZW5zCmNvbnRpbnVvdXNseSwgbm90IG9ubHkgdGhlIGZpcnN0IHRpbWUg
d2UgdG91Y2ggYSBwYWdlLgoKQW5kIHdlIG1pZ2h0IGJlIGFibGUgdG8gaW1wcm92ZSBoYW5kbGlu
ZyBpbiB0aGUgaHlwZXJ2aXNvciBpbiB0aGUKZnV0dXJlLiBXZSBoYXZlIGJlZW4gZGlzY3Vzc2lu
ZyB1c2luZyBNQURWX0ZSRUUgaW5zdGVhZCBvZiBNQURWX0RPTlRORUVECmluIFFFTVUgZm9yIGhh
bmRsaW5nIGZyZWUgcGFnZSByZXBvcnRpbmcuIFRoZW4sIGd1ZXN0IHJlcG9ydGVkIHBhZ2VzCndp
bGwgb25seSBnZXQgcmVjbGFpbWVkIGJ5IHRoZSBoeXBlcnZpc29yIHdoZW4gdGhlcmUgaXMgYWN0
dWFsIG1lbW9yeQpwcmVzc3VyZSBpbiB0aGUgaHlwZXJ2aXNvciAoZS5nLiwgd2hlbiBhYm91dCB0
byBzd2FwKS4gQW5kIHplcm9pbmcgYQpwYWdlIGlzIGFuIG9idmlvdXMgaW1wcm92ZW1lbnQgb3Zl
ciBnb2luZyB0byBzd2FwLiBUaGUgcHJpY2UgZm9yIHplcm9pbmcKcGFnZXMgaGFzIHRvIGJlIHBh
aWQgYXQgb25lIHBvaW50LgoKQWxzbyBub3RlIHRoYXQgd2UndmUgYmVlbiBkaXNjdXNzaW5nIGNh
Y2hlLXJlbGF0ZWQgdGhpbmdzIGFscmVhZHkuIElmCnlvdSB6ZXJvIG91dCBiZWZvcmUgZ2l2aW5n
IHRoZSBwYWdlIHRvIHRoZSBndWVzdCwgdGhlIHBhZ2Ugd2lsbCBhbHJlYWR5CmJlIGluIHRoZSBj
YWNoZSAtIHdoZXJlIHRoZSBndWVzdCBkaXJlY3RseSB3YW50cyB0byBhY2Nlc3MgaXQuCgpbLi4u
XQoKPj4+Cj4+PiBTZWN1cml0eQo+Pj4gPT09PT09PT0KPj4+IFRoaXMgaXMgYSB3ZWFrIHZlcnNp
b24gb2YgImludHJvZHVjZSBpbml0X29uX2FsbG9jPTEgYW5kIGluaXRfb25fZnJlZT0xCj4+PiBi
b290IG9wdGlvbnMiLCB3aGljaCB6ZXJvIG91dCBwYWdlIGluIGEgYXN5bmNocm9ub3VzIHdheS4g
Rm9yIHVzZXJzIGNhbid0Cj4+PiB0b2xlcmF0ZSB0aGUgaW1wYWN0aW9uIG9mICdpbml0X29uX2Fs
bG9jPTEnIG9yICdpbml0X29uX2ZyZWU9MScgYnJpbmdzLAo+Pj4gdGhpcyBmZWF1dHVyZSBwcm92
aWRlIGFub3RoZXIgY2hvaWNlLgo+PiAid2UgZG9u4oCZdCBwcmUgemVybyBvdXQgYWxsIHRoZSBm
cmVlIHBhZ2VzIiBzbyB0aGlzIGlzIG9mIGxpdHRsZSBhY3R1YWwgdXNlLgo+IAo+IE9LLiBJdCBz
ZWVtcyBub25lIG9mIHRoZSByZWFzb25zIGxpc3RlZCBhYm92ZSBpcyBzdHJvbmcgZW5vdWdoIGZv
cgoKSSB3YXMgcmF0aGVyIHNheWluZyB0aGF0IGZvciBzZWN1cml0eSBpdCdzIG9mIGxpdHRsZSB1
c2UgSU1ITy4KQXBwbGljYXRpb24vVk0gc3RhcnQgdXAgdGltZSBtaWdodCBiZSBpbXByb3ZlZCBi
eSB1c2luZyBodWdlIHBhZ2VzIChhbmQKcHJlLXplcm9pbmcgdGhlc2UpLiBGcmVlIHBhZ2UgcmVw
b3J0aW5nIG1pZ2h0IGJlIGltcHJvdmVkIGJ5IHVzaW5nCk1BRFZfRlJFRSBpbnN0ZWFkIG9mIE1B
RFZfRE9OVE5FRUQgaW4gdGhlIGh5cGVydmlzb3IuCgo+IHRoaXMgZmVhdHVyZSwgYWJvdmUgYWxs
IG9mIHRoZW0sIHdoaWNoIG9uZSBpcyBsaWtlbHkgdG8gYmVjb21lIHRoZQo+IG1vc3Qgc3Ryb25n
IG9uZT8gIEZyb20gdGhlIGltcGxlbWVudGF0aW9uLCB5b3Ugd2lsbCBmaW5kIGl0IGlzCj4gY29u
ZmlndXJhYmxlLCB1c2VycyBkb24ndCB3YW50IHRvIHVzZSBpdCBjYW4gdHVybiBpdCBvZmYuICBU
aGlzIGlzIG5vdAo+IGFuIG9wdGlvbj8KCldlbGwsIHdlIGhhdmUgdG8gbWFpbnRhaW4gdGhlIGZl
YXR1cmUgYW5kIHNhY3JpZmljZSBhIHBhZ2UgZmxhZy4gRm9yCmV4YW1wbGUsIGRvIHdlIGV4cGVj
dCBzb21lb25lIGV4cGxpY2l0bHkgZW5hYmxpbmcgdGhlIGZlYXR1cmUganVzdCB0bwpzcGVlZCB1
cCBzdGFydHVwIHRpbWUgb2YgYW4gYXBwIHRoYXQgY29uc3VtZXMgYSBsb3Qgb2YgbWVtb3J5PyBJ
IGhpZ2hseQpkb3VidCBpdC4KCkknZCBsb3ZlIHRvIGhlYXIgb3BpbmlvbnMgb2Ygb3RoZXIgcGVv
cGxlLiAoYSBsb3Qgb2YgcGVvcGxlIGFyZSBvZmZsaW5lCnVudGlsIGJlZ2lubmluZyBvZiBKYW51
YXJ5LCBpbmNsdWRpbmcsIHdlbGwsIGFjdHVhbGx5IG1lIDopICkKCi0tIApUaGFua3MsCgpEYXZp
ZCAvIGRoaWxkZW5iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
