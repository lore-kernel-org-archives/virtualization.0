Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30E8C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 03:01:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2902164FE9
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 03:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2902164FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5D1E843D4;
	Fri,  5 Mar 2021 03:01:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dykhSpjRFYX1; Fri,  5 Mar 2021 03:01:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56254844C4;
	Fri,  5 Mar 2021 03:01:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AC11C000A;
	Fri,  5 Mar 2021 03:01:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B625C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B0746FB57
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mNdxWAkHMCQq
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:01:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3AEA6F52F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 03:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614913298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbQG59Qwdexi2ZwJvCmGmQtYONrZ9WmAK6AGbLvhncs=;
 b=iX29yqrqfk1XDorVO7Xjda4dIk19SfXbiua8IqNJ+db+BtN4kgRt3s4NvIEPLjw4luHZDw
 OB6pxtMEncKzLhA+BzcOWNbH6a+WKBRoyZUszFtRd4bOvoisS/SvJLV3vi7xt32FnKaNT6
 NWvdsnpzsIqkjlUy81VLxUO/Z0bYvuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-73ev7NdUMN2VLu5qmYoVzg-1; Thu, 04 Mar 2021 22:01:34 -0500
X-MC-Unique: 73ev7NdUMN2VLu5qmYoVzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F43C80006E;
 Fri,  5 Mar 2021 03:01:33 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-196.pek2.redhat.com
 [10.72.13.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C9CD19D61;
 Fri,  5 Mar 2021 03:01:30 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
To: Cornelia Huck <cohuck@redhat.com>
References: <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
 <20210223115833.732d809c.cohuck@redhat.com>
 <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
 <20210224121234.0127ae4b.cohuck@redhat.com>
 <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
 <20210225135229-mutt-send-email-mst@kernel.org>
 <0f8eb381-cc98-9e05-0e35-ccdb1cbd6119@redhat.com>
 <20210228162306-mutt-send-email-mst@kernel.org>
 <cdd72199-ac7b-cc8d-2c40-81e43162c532@redhat.com>
 <20210302130812.6227f176.cohuck@redhat.com>
 <5f6972fe-7246-b622-958d-9cab8dd98e21@redhat.com>
 <20210303092905.677eb66c.cohuck@redhat.com>
 <1b5b3f9b-41d7-795c-c677-c45f1d5a774e@redhat.com>
 <20210304145000.149706ae.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <71fd3f74-00ba-f085-27e9-6a0d21c9a93f@redhat.com>
Date: Fri, 5 Mar 2021 11:01:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304145000.149706ae.cohuck@redhat.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>,
 elic@nvidia.com
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

Ck9uIDIwMjEvMy80IDk6NTAg5LiL5Y2ILCBDb3JuZWxpYSBIdWNrIHdyb3RlOgo+IE9uIFRodSwg
NCBNYXIgMjAyMSAxNjoyNDoxNiArMDgwMAo+IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4+IE9uIDIwMjEvMy8zIDQ6Mjkg5LiL5Y2ILCBDb3JuZWxpYSBIdWNrIHdy
b3RlOgo+Pj4gT24gV2VkLCAzIE1hciAyMDIxIDEyOjAxOjAxICswODAwCj4+PiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+ICAgCj4+Pj4gT24gMjAyMS8zLzIgODow
OCDkuIvljYgsIENvcm5lbGlhIEh1Y2sgd3JvdGU6Cj4+Pj4+IE9uIE1vbiwgMSBNYXIgMjAyMSAx
MTo1MTowOCArMDgwMAo+Pj4+PiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPj4+Pj4gICAgICAKPj4+Pj4+IE9uIDIwMjEvMy8xIDU6MjUg5LiK5Y2ILCBNaWNoYWVsIFMu
IFRzaXJraW4gd3JvdGU6Cj4+Pj4+Pj4gT24gRnJpLCBGZWIgMjYsIDIwMjEgYXQgMDQ6MTk6MTZQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Pj4gT24gMjAyMS8yLzI2IDI6NTMg5LiK
5Y2ILCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+Pj4+PiBDb25mdXNlZC4gV2hhdCBp
cyB3cm9uZyB3aXRoIHRoZSBhYm92ZT8gSXQgbmV2ZXIgcmVhZHMgdGhlCj4+Pj4+Pj4+PiBmaWVs
ZCB1bmxlc3MgdGhlIGZlYXR1cmUgaGFzIGJlZW4gb2ZmZXJlZCBieSBkZXZpY2UuCj4+Pj4+Pj4+
IFNvIHRoZSBzcGVjIHNhaWQ6Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+ICIKPj4+Pj4+Pj4KPj4+Pj4+Pj4g
VGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5IGZpZWxkLCBtYXhfdmlydHF1ZXVlX3BhaXJz
IG9ubHkgZXhpc3RzIGlmCj4+Pj4+Pj4+IFZJUlRJT19ORVRfRl9NUSBpcyBzZXQuCj4+Pj4+Pj4+
Cj4+Pj4+Pj4+ICIKPj4+Pj4+Pj4KPj4+Pj4+Pj4gSWYgSSByZWFkIHRoaXMgY29ycmVjdGx5LCB0
aGVyZSB3aWxsIGJlIG5vIG1heF92aXJ0cXVldWVfcGFpcnMgZmllbGQgaWYgdGhlCj4+Pj4+Pj4+
IFZJUlRJT19ORVRfRl9NUSBpcyBub3Qgb2ZmZXJlZCBieSBkZXZpY2U/IElmIHllcyB0aGUgb2Zm
c2V0b2YoKSB2aW9sYXRlcwo+Pj4+Pj4+PiB3aGF0IHNwZWMgc2FpZC4KPj4+Pj4+Pj4KPj4+Pj4+
Pj4gVGhhbmtzCj4+Pj4+Pj4gSSB0aGluayB0aGF0J3MgYSBtaXN1bmRlcnN0YW5kaW5nLiBUaGlz
IHRleHQgd2FzIG5ldmVyIGludGVuZGVkIHRvCj4+Pj4+Pj4gaW1wbHkgdGhhdCBmaWVsZCBvZmZz
ZXRzIGNoYW5nZSBiZWFzZWQgb24gZmVhdHVyZSBiaXRzLgo+Pj4+Pj4+IFdlIGhhZCB0aGlzIHBh
aW4gd2l0aCBsZWdhY3kgYW5kIHdlIG5ldmVyIHdhbnRlZCB0byBnbyBiYWNrIHRoZXJlLgo+Pj4+
Pj4+Cj4+Pj4+Pj4gVGhpcyBtZXJlbHkgaW1wbGllcyB0aGF0IHdpdGhvdXQgVklSVElPX05FVF9G
X01RIHRoZSBmaWVsZAo+Pj4+Pj4+IHNob3VsZCBub3QgYmUgYWNjZXNzZWQuIEV4aXN0cyBpbiB0
aGUgc2Vuc2UgImlzIGFjY2Vzc2libGUgdG8gZHJpdmVyIi4KPj4+Pj4+Pgo+Pj4+Pj4+IExldCdz
IGp1c3QgY2xhcmlmeSB0aGF0IGluIHRoZSBzcGVjLCBqb2IgZG9uZS4KPj4+Pj4+IE9rLCBhZ3Jl
ZS4gVGhhdCB3aWxsIG1ha2UgdGhpbmdzIG1vcmUgZWFpc2VyLgo+Pj4+PiBZZXMsIHRoYXQgbWFr
ZXMgbXVjaCBtb3JlIHNlbnNlLgo+Pj4+Pgo+Pj4+PiBXaGF0IGFib3V0IGFkZGluZyB0aGUgZm9s
bG93aW5nIHRvIHRoZSAiQmFzaWMgRmFjaWxpdGllcyBvZiBhIFZpcnRpbwo+Pj4+PiBEZXZpY2Uv
RGV2aWNlIENvbmZpZ3VyYXRpb24gU3BhY2UiIHNlY3Rpb24gb2YgdGhlIHNwZWM6Cj4+Pj4+Cj4+
Pj4+ICJJZiBhbiBvcHRpb25hbCBjb25maWd1cmF0aW9uIGZpZWxkIGRvZXMgbm90IGV4aXN0LCB0
aGUgY29ycmVzcG9uZGluZwo+Pj4+PiBzcGFjZSBpcyBzdGlsbCBwcmVzZW50LCBidXQgcmVzZXJ2
ZWQuIgo+Pj4+IFRoaXMgYmVjYW1lIGludGVyZXN0aW5nIGFmdGVyIHJlLXJlYWRpbmcgc29tZSBv
ZiB0aGUgcWVtdSBjb2Rlcy4KPj4+Pgo+Pj4+IEUuZyBpbiB2aXJ0aW8tbmV0LmMgd2UgaGFkOgo+
Pj4+Cj4+Pj4gKnN0YXRpYyBWaXJ0SU9GZWF0dXJlIGZlYXR1cmVfc2l6ZXNbXSA9IHsKPj4+PiAg
ICDCoMKgwqAgey5mbGFncyA9IDFVTEwgPDwgVklSVElPX05FVF9GX01BQywKPj4+PiAgICDCoMKg
wqDCoCAuZW5kID0gZW5kb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLCBtYWMpfSwKPj4+PiAg
ICDCoMKgwqAgey5mbGFncyA9IDFVTEwgPDwgVklSVElPX05FVF9GX1NUQVRVUywKPj4+PiAgICDC
oMKgwqDCoCAuZW5kID0gZW5kb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLCBzdGF0dXMpfSwK
Pj4+PiAgICDCoMKgwqAgey5mbGFncyA9IDFVTEwgPDwgVklSVElPX05FVF9GX01RLAo+Pj4+ICAg
IMKgwqDCoMKgIC5lbmQgPSBlbmRvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsIG1heF92aXJ0
cXVldWVfcGFpcnMpfSwKPj4+PiAgICDCoMKgwqAgey5mbGFncyA9IDFVTEwgPDwgVklSVElPX05F
VF9GX01UVSwKPj4+PiAgICDCoMKgwqDCoCAuZW5kID0gZW5kb2Yoc3RydWN0IHZpcnRpb19uZXRf
Y29uZmlnLCBtdHUpfSwKPj4+PiAgICDCoMKgwqAgey5mbGFncyA9IDFVTEwgPDwgVklSVElPX05F
VF9GX1NQRUVEX0RVUExFWCwKPj4+PiAgICDCoMKgwqDCoCAuZW5kID0gZW5kb2Yoc3RydWN0IHZp
cnRpb19uZXRfY29uZmlnLCBkdXBsZXgpfSwKPj4+PiAgICDCoMKgwqAgey5mbGFncyA9ICgxVUxM
IDw8IFZJUlRJT19ORVRfRl9SU1MpIHwgKDFVTEwgPDwKPj4+PiBWSVJUSU9fTkVUX0ZfSEFTSF9S
RVBPUlQpLAo+Pj4+ICAgIMKgwqDCoMKgIC5lbmQgPSBlbmRvZihzdHJ1Y3QgdmlydGlvX25ldF9j
b25maWcsIHN1cHBvcnRlZF9oYXNoX3R5cGVzKX0sCj4+Pj4gICAgwqDCoMKgIHt9Cj4+Pj4gfTsq
Cj4+Pj4KPj4+PiAqSXQgaGFzIGEgaW1wbGljdCBkZXBlbmRlbmN5IGNoYWluLiBFLmcgTVRVIGRv
ZXNuJ3QgcHJlc25ldCBpZgo+Pj4+IERVUExFWC9SU1MgaXMgbm90IG9mZmVyZWQgLi4uCj4+Pj4g
Kgo+Pj4gQnV0IEkgdGhpbmsgaXQgY292ZXJzIGV2ZXJ5dGhpbmcgdXAgdG8gdGhlIHJlbGV2YW50
IGZpZWxkLCBubz8gU28gTVRVCj4+PiBpcyBpbmNsdWRlZCBpZiB3ZSBoYXZlIHRoZSBmZWF0dXJl
IGJpdCwgZXZlbiBpZiB3ZSBkb24ndCBoYXZlCj4+PiBEVVBMRVgvUlNTLgo+Pj4KPj4+IEdpdmVu
IHRoYXQgYSBjb25maWcgc3BhY2UgbWF5IGJlIHNob3J0ZXIgKGJ1dCBtdXN0IG5vdCBjb2xsYXBz
ZQo+Pj4gbm9uLWV4aXN0aW5nIGZpZWxkcyksIG1heWJlIGEgYmV0dGVyIHdvcmRpbmcgd291bGQg
YmU6Cj4+Pgo+Pj4gIklmIGFuIG9wdGlvbmFsIGNvbmZpZ3VyYXRpb24gZmllbGQgZG9lcyBub3Qg
ZXhpc3QsIHRoZSBjb3JyZXNwb25kaW5nCj4+PiBzcGFjZSB3aWxsIHN0aWxsIGJlIHByZXNlbnQg
aWYgaXQgaXMgbm90IGF0IHRoZSBlbmQgb2YgdGhlCj4+PiBjb25maWd1cmF0aW9uIHNwYWNlIChp
LmUuLCBmdXJ0aGVyIGNvbmZpZ3VyYXRpb24gZmllbGRzIGV4aXN0LikKPj4KPj4gVGhpcyBzaG91
bGQgd29yayBidXQgSSB0aGluayB3ZSBuZWVkIHRvIGRlZmluZSB0aGUgZW5kIG9mIGNvbmZpZ3Vy
YXRpb24KPj4gc3BhY2UgZmlyc3Q/Cj4gV2hhdCBhYm91dCBzaWRlc3RlcHBpbmcgdGhpczoKPgo+
ICIuLi50aGUgY29ycmVzcG9uZGluZyBzcGFjZSB3aWxsIHN0aWxsIGJlIHByZXNlbnQsIHVubGVz
cyBubyBmdXJ0aGVyCj4gY29uZmlndXJhdGlvbiBmaWVsZHMgZXhpc3QuIgo+Cj4gPwoKCkl0IG1p
Z2h0IHdvcmsuIChJIHdvbmRlciBtYXliZSB3ZSBjYW4gZ2l2ZSBzb21lIGV4YW1wbGUgaW4gdGhl
IHNwZWMpLgoKVGhhbmtzCgoKPgo+Pj4gVGhpcwo+Pj4gaW1wbGllcyB0aGF0IGEgZ2l2ZW4gZmll
bGQsIGlmIGl0IGV4aXN0cywgaXMgYWx3YXlzIGF0IHRoZSBzYW1lIG9mZnNldAo+Pj4gZnJvbSB0
aGUgYmVnaW5uaW5nIG9mIHRoZSBjb25maWd1cmF0aW9uIHNwYWNlLiIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
