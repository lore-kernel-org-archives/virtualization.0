Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784E3C4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 04:19:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76C72376F
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 04:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76C72376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E4687873B0;
	Thu, 17 Dec 2020 04:19:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PKOv1jOf3Dsz; Thu, 17 Dec 2020 04:19:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 39EAB8737B;
	Thu, 17 Dec 2020 04:19:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2467BC088E;
	Thu, 17 Dec 2020 04:19:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8064BC013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 04:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6F61F877BB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 04:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EiMEQHmpeAst
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 04:19:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 81FF4877BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 04:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608178770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bzTNk5bDUSJEvcEg1c5/7YlqZc+r6yeV/f6+tlgG7tU=;
 b=f+JbCRCXrLo6lYJI4WIcWLw3rHQ4X0q7RhU8KJxfy1X3MKwv+74MjJWJKnSUJsXfv7x8bP
 5+IyOaf1g1/UrW+kfYTREJQf2DwkDSt8E1gaLyyc+wGN2K79SJ2WGzZgokW+w/NiLy09wL
 hXtsivezntZo17kjFI2F7ItB5PjtlQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-LJe17YaDOnuHYm7bbv-XcQ-1; Wed, 16 Dec 2020 23:19:28 -0500
X-MC-Unique: LJe17YaDOnuHYm7bbv-XcQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81393107ACE4;
 Thu, 17 Dec 2020 04:19:26 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3641B18222;
 Thu, 17 Dec 2020 04:19:17 +0000 (UTC)
Subject: Re: swiotlb/virtio: unchecked device dma address and length
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
 <20201214214950.GC18103@char.us.oracle.com>
 <c3629a27-3590-1d9f-211b-c0b7be152b32@redhat.com>
 <20201215142755.GB28810@char.us.oracle.com>
 <1330503106.36174346.1608098013639.JavaMail.zimbra@redhat.com>
 <613214145.36646222.1608100908658.JavaMail.zimbra@redhat.com>
 <2CCB61BD-19F0-48A3-A8D2-0D22E51D3677@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <44650cf2-a56c-43e2-7041-5ea3c3f2a202@redhat.com>
Date: Thu, 17 Dec 2020 12:19:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2CCB61BD-19F0-48A3-A8D2-0D22E51D3677@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: ashish kalra <ashish.kalra@amd.com>,
 Felicitas Hetzelt <file@sect.tu-berlin.de>,
 Martin Radev <martin.radev@aisec.fraunhofer.de>,
 david kaplan <david.kaplan@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Robert Buhren <robert@sect.tu-berlin.de>, iommu@lists.linux-foundation.org,
 Mathias Morbitzer <mathias.morbitzer@aisec.fraunhofer.de>, hch@lst.de
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

Ck9uIDIwMjAvMTIvMTYg5LiL5Y2IOTowNCwgS29ucmFkIFJ6ZXN6dXRlayBXaWxrIHdyb3RlOgo+
IE9uIERlY2VtYmVyIDE2LCAyMDIwIDE6NDE6NDggQU0gRVNULCBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToKPj4KPj4gLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+
Pj4KPj4+IC0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0KPj4+PiAuc25pcC4KPj4+Pj4+PiBU
aGlzIHJhaXNlcyB0d28gaXNzdWVzOgo+Pj4+Pj4+IDEpIHN3aW90bGJfdGxiX3VubWFwX3Npbmds
ZSBmYWlscyB0byBjaGVjayB3aGV0aGVyIHRoZSBpbmRleAo+Pj4+Pj4+IGdlbmVyYXRlZAo+Pj4+
Pj4+IGZyb20gdGhlIGRtYV9hZGRyIGlzIGluIHJhbmdlIG9mIHRoZSBpb190bGJfb3JpZ19hZGRy
IGFycmF5Lgo+Pj4+Pj4gVGhhdCBpcyBmYWlybHkgc2ltcGxlIHRvIGltcGxlbWVudCBJIHdvdWxk
IHRoaW5rLiBUaGF0IGlzIGl0Cj4+IGNhbiBjaGVjawo+Pj4+Pj4gdGhhdCB0aGUgZG1hX2FkZHIg
aXMgZnJvbSB0aGUgUEEgaW4gdGhlIGlvX3RsYiBwb29sIHdoZW4KPj4gU1dJT1RMQj1mb3JjZQo+
Pj4+Pj4gaXMgdXNlZC4KPj4+Pj4KPj4+Pj4gSSdtIG5vdCBzdXJlIHRoaXMgY2FuIGZpeCBhbGwg
dGhlIGNhc2VzLiBJdCBsb29rcyB0byBtZSB3ZSBzaG91bGQKPj4gbWFwCj4+Pj4+IGRlc2NyaXB0
b3IgY29oZXJlbnQgYnV0IHJlYWRvbmx5ICh3aGljaCBpcyBub3Qgc3VwcG9ydGVkIGJ5Cj4+IGN1
cnJlbnQgRE1BCj4+Pj4+IEFQSSkuCj4+Pj4gSSB0aGluayBJIGFtIG1pc3Npbmcgc29tZXRoaW5n
IG9idmlvdXMgaGVyZS4gVGhlIGF0dGFja2VyIGlzIHRoZQo+Pj4+IGh5cGVydmlzb3IsCj4+Pj4g
YWthCj4+Pj4gdGhlIG93bmVyIG9mIHRoZSBWaXJ0SU8gZGV2aWNlIChyaW5nMCkuIFRoZSBhdHRh
Y2tlciBpcyB0aGUgb25lCj4+IHRoYXQKPj4+PiBwcm92aWRlcyB0aGUgYWRkci9sZW4gLSBoYXZp
bmcgdGhhdCByZWFkb25seSBmcm9tIGEgZ3Vlc3QKPj4gcGVyc3BlY3RpdmUKPj4+PiBkb2VzIG5v
dCBjaGFuZ2UgdGhlIGZhY3QgdGhhdCB0aGUgaHlwZXJ2aXNvciBjYW4gbW9kaWZ5IHRoZSBtZW1v
cnkKPj4gcmFuZ2UKPj4+PiBieSBtYXBwaW5nIGl0IHZpYSBhIGRpZmZlcmVudCB2aXJ0dWFsIGFk
ZHJlc3MgaW4gdGhlIGh5cGVydmlzb3I/Cj4+IChha2EKPj4+PiBhbGlhc2luZyBpdCkuCj4+PiBS
aWdodCwgYnV0IGlmIHdlIGFsbG93IGh5cGVydmlzb3IgdG8gcHJvdmlkZSBhcmJpdHJhcnkgYWRk
ci9sZW4sIGRvZXMKPj4+IGl0IG1lYW4gaHlwZXJ2aXNvciBjYW4gcmVhZCBlbmNyeXB0ZWQgY29u
dGVudCBvZiBlbmNyeXB0ZWQgbWVtb3J5IG9mCj4+PiBndWVzdCB0aHJvdWdoIHN3aW90bGI/Cj4g
WWVzIC4KPj4+IFRoYW5rcwo+PiBBY3R1YWxseSBub3QuIEkgdGhpbmsgeW91J3JlIHJpZ2h0Lgo+
Cj4gWW91ciBzZW50ZW5jZSBpcyB2ZXJ5IGNvbmZ1c2luZy4KCgpTb3JyeSBmb3LCoCBiZWluZyB1
bmNsZWFyLiBUaGlzIGlzIGFsbCBhIHJlcGx5IHRvIHlvdXIgc3VnZ2VzdGlvbiBvZiAKYWRkaW5n
IGNoZWNrcyBpbiB0aGUgc3dpb3RsYi4KCgo+Cj4gT24gYSBETUEgdW5tYXAgU1dJT1RMQiAod2hl
biBmb3JjZSBpcyB1c2VkKSBpdCB0cnVzdHMgdGhlIGRyaXZlciBmcm9tIHByb3ZpZGluZyB0aGUg
Y29ycmVjdCBETUEgYWRkcmVzcyBhbmQgbGVuZ3RoIHdoaWNoIFNXSU9UTEIgdXNlcyB0byBtYXRj
aCB0byBpdHMgYXNzb2NpYXRlZCBvcmlnaW5hbCBQQSBhZGRyZXNzLgo+Cj4gVGhpbmsgb3JpZ2lu
YWwgUEEgaGF2aW5nIGEgbWFwcGluZyB0byBhIFBBIGluIHRoZSBTV0lPVExCIHBvb2wuCj4KPgo+
IFRoZSBsZW5ndGggaXMgbm90IGNoZWNrZWQgc28gdGhlIGF0dGFja2VyIGNhbiBtb2RpZnkgdGhh
dCB0byBzYXkgYSBodWdlIG51bWJlciBhbmQgY2F1c2UgU1dJT1RMQiBib3VuY2UgY29kZSB0byB3
cml0ZSBvciByZWFkIGRhdGEgZnJvbSBub24gU1dJT1RMQiBQQSBpbnRvIHRoZSBTV0lPVExCIFBB
IHBvb2wuCgoKSG93IGNhbiB3ZSByZWFkIGluIHRoaXMgY2FzZT8gSXQgbG9va3MgdG8gbWUgd2Ug
ZG9uJ3QgdHJ5IHRvIHJlYWQgZHVyaW5nIApkbWFfdW5tYXAoKS4KClRoYW5rcwoKCj4KPgo+Cj4K
Pj4gVGhhbmtzCj4+Cj4+Pj4+IE90aGVyd2lzZSwgZGV2aWNlIGNhbiBtb2RpZnkgdGhlIGRlc2Nb
aV0uYWRkci9kZXNjW2ldLmxlbiBhdCBhbnkKPj4gdGltZSB0bwo+Pj4+PiBwcmV0ZW5kIGEgdmFs
aWQgbWFwcGluZy4KPj4+PiBXaXRoIHRoZSBzd2lvdGxiPWZvcmNlIGFzIGxvbmcgYXMgYWRkci9s
ZW4gYXJlIHdpdGhpbiB0aGUgUEEKPj4gYm91bmRhcmllcwo+Pj4+IHdpdGhpbiB0aGUgU1dJT1RM
QiBwb29sIHRoaXMgc2hvdWxkIGJlIE9LPwo+Pj4+Cj4+Pj4gQWZ0ZXIgYWxsIHRoYXQgd2hvbGUg
YXJlYSBpcyBpbiBjbGVhcnRleHQgYW5kIHZpc2libGUgdG8gdGhlCj4+IGF0dGFja2VyLgo+Pj4+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
