Return-Path: <SRS0=TROJ=G4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE413C433E0
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 03:16:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53FCA21D79
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 03:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FCA21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0A9EF85B73;
	Mon, 25 Jan 2021 03:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id verEku59WY8M; Mon, 25 Jan 2021 03:16:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BE69854A7;
	Mon, 25 Jan 2021 03:16:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 494BCC08A1;
	Mon, 25 Jan 2021 03:16:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71BB6C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 03:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 57D4B87085
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 03:16:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3VQe6aaziI7b
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 03:16:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 819E28707F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 03:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611544606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQlIKnWX05Xi/5RErZApghH+PFmHdjO65B3IKtiO0Xk=;
 b=LsQiyrrkhxIrtU9wGg38AA5EeR3tMw2XC5c4/vgE76DFc+KC3mLmZVWSBKDe5JBD1795va
 nVS8A3NtIM3vj9m0XVRVAOeoewkD2WY490kCTnhOqwfLhqk934BbdtsUqb/1VdVQAQZQgu
 tJGFrdsecc6tJptDVUekqnqOLyFbt7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-xK_3t1Q6OUSIheIP5bwhbw-1; Sun, 24 Jan 2021 22:16:43 -0500
X-MC-Unique: xK_3t1Q6OUSIheIP5bwhbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDB37107ACE4;
 Mon, 25 Jan 2021 03:16:41 +0000 (UTC)
Received: from [10.72.12.105] (ovpn-12-105.pek2.redhat.com [10.72.12.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 985E310013C0;
 Mon, 25 Jan 2021 03:16:31 +0000 (UTC)
Subject: Re: [PATCH 21/21] vdpasim: control virtqueue support
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216064818.48239-22-jasowang@redhat.com>
 <20210111122601.GA172492@mtl-vdi-166.wap.labs.mlnx>
 <da50981b-6bbc-ee61-b5b1-a57a09da8e93@redhat.com>
 <CAJaqyWcRirQgz+n63rU2nYVH2RKqjQfwHGFLzOG=H46qRWuTog@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9be0b845-4d59-05fc-5575-347a03c5da52@redhat.com>
Date: Mon, 25 Jan 2021 11:16:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcRirQgz+n63rU2nYVH2RKqjQfwHGFLzOG=H46qRWuTog@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Cindy Lu <lulu@redhat.com>, kvm list <kvm@vger.kernel.org>,
 Michael Tsirkin <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eli Cohen <elic@nvidia.com>, lingshan.zhu@intel.com,
 Rob Miller <rob.miller@broadcom.com>
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

Ck9uIDIwMjEvMS8yMyDkuIrljYgzOjQzLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToKPiBP
biBUdWUsIEphbiAxMiwgMjAyMSBhdCA0OjEyIEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Pgo+PiBPbiAyMDIxLzEvMTEg5LiL5Y2IODoyNiwgRWxpIENvaGVuIHdy
b3RlOgo+Pj4gT24gV2VkLCBEZWMgMTYsIDIwMjAgYXQgMDI6NDg6MThQTSArMDgwMCwgSmFzb24g
V2FuZyB3cm90ZToKPj4+PiBUaGlzIHBhdGNoIGludHJvZHVjZXMgdGhlIGNvbnRyb2wgdmlydHF1
ZXVlIHN1cHBvcnQgZm9yIHZEUEEKPj4+PiBzaW11bGF0b3IuIFRoaXMgaXMgYSByZXF1aXJlbWVu
dCBmb3Igc3VwcG9ydGluZyBhZHZhbmNlZCBmZWF0dXJlcyBsaWtlCj4+Pj4gbXVsdGlxdWV1ZS4K
Pj4+Pgo+Pj4+IEEgcmVxdWlyZW1lbnQgZm9yIGNvbnRyb2wgdmlydHF1ZXVlIGlzIHRvIGlzb2xh
dGUgaXRzIG1lbW9yeSBhY2Nlc3MKPj4+PiBmcm9tIHRoZSByeC90eCB2aXJ0cXVldWVzLiBUaGlz
IGlzIGJlY2F1c2Ugd2hlbiB1c2luZyB2RFBBIGRldmljZQo+Pj4+IGZvciBWTSwgdGhlIGNvbnRy
b2wgdmlycXVldWUgaXMgbm90IGRpcmVjdGx5IGFzc2lnbmVkIHRvIFZNLiBVc2Vyc3BhY2UKPj4+
PiAoUWVtdSkgd2lsbCBwcmVzZW50IGEgc2hhZG93IGNvbnRyb2wgdmlydHF1ZXVlIHRvIGNvbnRy
b2wgZm9yCj4+Pj4gcmVjb3JkaW5nIHRoZSBkZXZpY2Ugc3RhdGVzLgo+Pj4+Cj4+Pj4gVGhlIGlz
b2xhdGlvbiBpcyBkb25lIHZpYSB0aGUgdmlydHF1ZXVlIGdyb3VwcyBhbmQgQVNJRCBzdXBwb3J0
IGluCj4+Pj4gdkRQQSB0aHJvdWdoIHZob3N0LXZkcGEuIFRoZSBzaW11bGF0b3IgaXMgZXh0ZW5k
ZWQgdG8gaGF2ZToKPj4+Pgo+Pj4+IDEpIHRocmVlIHZpcnRxdWV1ZXM6IFJYVlEsIFRYVlEgYW5k
IENWUSAoY29udHJvbCB2aXJ0cXVldWUpCj4+Pj4gMikgdHdvIHZpcnRxdWV1ZSBncm91cHM6IGdy
b3VwIDAgY29udGFpbnMgUlhWUSBhbmQgVFhWUTsgZ3JvdXAgMQo+Pj4+ICAgICAgY29udGFpbnMg
Q1ZRCj4+Pj4gMykgdHdvIGFkZHJlc3Mgc3BhY2VzIGFuZCB0aGUgc2ltdWxhdG9yIHNpbXBseSBp
bXBsZW1lbnRzIHRoZSBhZGRyZXNzCj4+Pj4gICAgICBzcGFjZXMgYnkgbWFwcGluZyBpdCAxOjEg
dG8gSU9UTEIuCj4+Pj4KPj4+PiBGb3IgdGhlIFZNIHVzZSBjYXNlcywgdXNlcnNwYWNlKFFlbXUp
IG1heSBzZXQgQVMgMCB0byBncm91cCAwIGFuZCBBUyAxCj4+Pj4gdG8gZ3JvdXAgMS4gU28gd2Ug
aGF2ZToKPj4+Pgo+Pj4+IDEpIFRoZSBJT1RMQiBmb3IgdmlydHF1ZXVlIGdyb3VwIDAgY29udGFp
bnMgdGhlIG1hcHBpbmdzIG9mIGd1ZXN0LCBzbwo+Pj4+ICAgICAgUlggYW5kIFRYIGNhbiBiZSBh
c3NpZ25lZCB0byBndWVzdCBkaXJlY3RseS4KPj4+PiAyKSBUaGUgSU9UTEIgZm9yIHZpcnRxdWV1
ZSBncm91cCAxIGNvbnRhaW5zIHRoZSBtYXBwaW5ncyBvZiBDVlEgd2hpY2gKPj4+PiAgICAgIGlz
IHRoZSBidWZmZXJzIHRoYXQgYWxsb2NhdGVkIGFuZCBtYW5hZ2VkIGJ5IFZNTSBvbmx5LiBTbyBD
VlEgb2YKPj4+PiAgICAgIHZob3N0LXZkcGEgaXMgdmlzaWJsZSB0byBWTU0gb25seS4gQW5kIEd1
ZXN0IGNhbiBub3QgYWNjZXNzIHRoZSBDVlEKPj4+PiAgICAgIG9mIHZob3N0LXZkcGEuCj4+Pj4K
Pj4+PiBGb3IgdGhlIG90aGVyIHVzZSBjYXNlcywgc2luY2UgQVMgMCBpcyBhc3NvY2lhdGVkIHRv
IGFsbCB2aXJ0cXVldWUKPj4+PiBncm91cHMgYnkgZGVmYXVsdC4gQWxsIHZpcnRxdWV1ZXMgc2hh
cmUgdGhlIHNhbWUgbWFwcGluZyBieSBkZWZhdWx0Lgo+Pj4+Cj4+Pj4gVG8gZGVtb25zdHJhdGUg
dGhlIGZ1bmN0aW9uLCBWSVJJVE9fTkVUX0ZfQ1RSTF9NQUNBRERSIGlzCj4+Pj4gaW1wbGVtZW50
ZWQgaW4gdGhlIHNpbXVsYXRvciBmb3IgdGhlIGRyaXZlciB0byBzZXQgbWFjIGFkZHJlc3MuCj4+
Pj4KPj4+IEhpIEphc29uLAo+Pj4KPj4+IGlzIHRoZXJlIGFueSB2ZXJzaW9uIG9mIHFlbXUvbGli
dmlydCBhdmFpbGFibGUgdGhhdCBJIGNhbiBzZWUgdGhlCj4+PiBjb250cm9sIHZpcnRxdWV1ZSB3
b3JraW5nIGluIGFjdGlvbj8KPj4KPj4gTm90IHlldCwgdGhlIHFlbXUgcGFydCBkZXBlbmRzIG9u
IHRoZSBzaGFkb3cgdmlydHF1ZXVlIHdvcmsgb2YgRXVnZW5pby4KPj4gQnV0IGl0IHdpbGwgd29y
ayBhczoKPj4KPj4gMSkgcWVtdSB3aWxsIHVzZSBhIHNlcGFyYXRlZCBhZGRyZXNzIHNwYWNlIGZv
ciB0aGUgY29udHJvbCB2aXJ0cXVldWUKPj4gKHNoYWRvdykgZXhwb3NlZCB0aHJvdWdoIHZob3N0
LXZEUEEKPj4gMikgdGhlIGNvbW1hbmRzIHNlbnQgdGhyb3VnaCBjb250cm9sIHZpcnRxdWV1ZSBi
eSBndWVzdCBkcml2ZXIgd2lsbAo+PiBpbnRlcmNlcHQgYnkgcWVtdQo+PiAzKSBRZW11IHdpbGwg
c2VuZCB0aG9zZSBjb21tYW5kcyB0byB0aGUgc2hhZG93IGNvbnRyb2wgdmlydHF1ZXVlCj4+Cj4+
IEV1Z2VuaW8sIGFueSBFVEEgZm9yIHRoZSBuZXcgdmVyc2lvbiBvZiBzaGFkb3cgdmlydHF1ZXVl
IHN1cHBvcnQgaW4gUWVtdT8KPj4KPiBIaSBKYXNvbi4gU29ycnkgZm9yIHRoZSBsYXRlIHJlc3Bv
bnNlLgo+Cj4gRm9yIHRoZSBub3RpZmljYXRpb24gcGFydCBJIGhhdmUgYWRkcmVzc2VkIGFsbCB0
aGUgaXNzdWVzIG9mIHRoZSBSRkMKPiBbMV0sIGV4Y2VwdCB0aGUgcG90ZW50aWFsIHJhY2UgY29u
ZGl0aW9ucyBTdGVmYW4gcG9pbnRlZCwgYW5kIHRlc3RlZAo+IHdpdGggdmRwYSBkZXZpY2VzLiBZ
b3UgY2FuIGZpbmQgYXQKPiBodHRwczovL2dpdGh1Yi5jb20vZXVncGVybWFyL3FlbXUvdHJlZS92
ZHBhX3N3X2xpdmVfbWlncmF0aW9uLmQvbm90aWZpY2F0aW9ucy5yZmMKPiAuIFNpbmNlIHRoZSBz
aGFkb3cgcGF0aCBpcyBhY3RpdmF0ZWQgb25seSB0aHJvdWdoIFFNUCBhbmQgZG9lcyBub3QKPiBp
bnRlcmZlcmUgd2l0aCByZWd1bGFyIG9wZXJhdGlvbiwgSSBjb3VsZCBwb3N0IHRvIHRoZSBxZW11
IGxpc3QgaWYgeW91Cj4gcHJlZmVyLiBUaGUgc2VyaWVzIHdpbGwgYmUgc21hbGxlciBpZiBtZXJn
ZWQgaW4gc3RlcHMuCgoKU3VyZS4gUGxlYXNlIHBvc3QgdGhlbS4KCgo+Cj4gQWRkaW5nIHRoZSBi
dWZmZXIgZm9yd2FyZGluZyBvbiB0b3Agc2hvdWxkIG5vdCB0YWtlIGxvbmcuCj4KPiBbMV0gaHR0
cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvOS8yMy8xMjQzCj4KPiBUaGFua3MhCgoKVGhhbmtzCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
