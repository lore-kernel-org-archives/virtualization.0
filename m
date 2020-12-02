Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61971C64E8A
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 05:51:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A340C221FC
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 05:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A340C221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0672B2E20A;
	Wed,  2 Dec 2020 05:51:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TtQnC+F2KZS6; Wed,  2 Dec 2020 05:51:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A24732E202;
	Wed,  2 Dec 2020 05:51:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 789CFC163C;
	Wed,  2 Dec 2020 05:51:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BB56C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 05:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 51806877EF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 05:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TGgw2ADd6jdK
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 05:51:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 62215877E7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 05:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606888300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFNrxlfJJuhhi00J7j2KUdF0PQdEfquJMmeof7OL03I=;
 b=fM9pdRw0L7Gd/PNbNbN0W/h9NWrBwx+wjlLv8dqNXC+nmDfyLisT54ML7JpVyoJiJB8bKB
 Qi3ZwBfwK71QYZOEYYmDJy4Zblx9wB8/Z2Vpj2/Nr9jKT2b+8tySgrxPz8ZzlspiMPSJMx
 ZA6z/IGYBrM1CEW7if3Xm/CC+2smuhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-Wo0SWSAAPmu0ji6cCiaN2Q-1; Wed, 02 Dec 2020 00:51:38 -0500
X-MC-Unique: Wo0SWSAAPmu0ji6cCiaN2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B64D1817B8C;
 Wed,  2 Dec 2020 05:51:36 +0000 (UTC)
Received: from [10.72.13.145] (ovpn-13-145.pek2.redhat.com [10.72.13.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 726EC5B4A0;
 Wed,  2 Dec 2020 05:51:30 +0000 (UTC)
Subject: Re: [External] Re: [PATCH 0/7] Introduce vdpa management tool
To: Parav Pandit <parav@nvidia.com>, Yongji Xie <xieyongji@bytedance.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <5b2235f6-513b-dbc9-3670-e4c9589b4d1f@redhat.com>
 <CACycT3sYScObb9nN3g7L3cesjE7sCZWxZ5_5R1usGU9ePZEeqA@mail.gmail.com>
 <182708df-1082-0678-49b2-15d0199f20df@redhat.com>
 <CACycT3votu2eyacKg+w12xZ_ujEOgTY0f8A7qcpbM-fwTpjqAw@mail.gmail.com>
 <7f80eeed-f5d3-8c6f-1b8c-87b7a449975c@redhat.com>
 <CACycT3uw6KJgTo+dBzSj07p2P_PziD+WBfX4yWVX-nDNUD2M3A@mail.gmail.com>
 <DM6PR12MB4330173AF4BA08FE12F68B5BDCF40@DM6PR12MB4330.namprd12.prod.outlook.com>
 <CACycT3tTCmEzY37E5196Q2mqME2v+KpAp7Snn8wK4XtRKHEqEw@mail.gmail.com>
 <BY5PR12MB4322C80FB3C76B85A2D095CCDCF40@BY5PR12MB4322.namprd12.prod.outlook.com>
 <CACycT3vNXvNVUP+oqzv-MMgtzneeeZUoMaDVtEws7VizH0V+mA@mail.gmail.com>
 <BY5PR12MB4322446CDB07B3CC5603F7D1DCF30@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3d91bf80-1a35-9f79-dbca-596358acc0a7@redhat.com>
Date: Wed, 2 Dec 2020 13:51:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4322446CDB07B3CC5603F7D1DCF30@BY5PR12MB4322.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

Ck9uIDIwMjAvMTIvMiDkuIvljYgxMjo1MywgUGFyYXYgUGFuZGl0IHdyb3RlOgo+Cj4+IEZyb206
IFlvbmdqaSBYaWUgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+PiBTZW50OiBXZWRuZXNkYXks
IERlY2VtYmVyIDIsIDIwMjAgOTowMCBBTQo+Pgo+PiBPbiBUdWUsIERlYyAxLCAyMDIwIGF0IDEx
OjU5IFBNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4gd3JvdGU6Cj4+Pgo+Pj4KPj4+
PiBGcm9tOiBZb25namkgWGllIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPj4+PiBTZW50OiBU
dWVzZGF5LCBEZWNlbWJlciAxLCAyMDIwIDc6NDkgUE0KPj4+Pgo+Pj4+IE9uIFR1ZSwgRGVjIDEs
IDIwMjAgYXQgNzozMiBQTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+IHdyb3RlOgo+
Pj4+Pgo+Pj4+Pgo+Pj4+Pj4gRnJvbTogWW9uZ2ppIFhpZSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5j
b20+Cj4+Pj4+PiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxLCAyMDIwIDM6MjYgUE0KPj4+Pj4+
Cj4+Pj4+PiBPbiBUdWUsIERlYyAxLCAyMDIwIGF0IDI6MjUgUE0gSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KPj4+PiB3cm90ZToKPj4+Pj4+Pgo+Pj4+Pj4+IE9uIDIwMjAvMTEvMzAg
5LiL5Y2IMzowNywgWW9uZ2ppIFhpZSB3cm90ZToKPj4+Pj4+Pj4+PiBUaGFua3MgZm9yIGFkZGlu
ZyBtZSwgSmFzb24hCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBOb3cgSSdtIHdvcmtpbmcgb24gYSB2
MiBwYXRjaHNldCBmb3IgVkRVU0UgKHZEUEEgRGV2aWNlIGluCj4+Pj4+Pj4+Pj4gVXNlcnNwYWNl
KSBbMV0uIFRoaXMgdG9vbCBpcyB2ZXJ5IHVzZWZ1bCBmb3IgdGhlIHZkdXNlIGRldmljZS4KPj4+
Pj4+Pj4+PiBTbyBJJ20gY29uc2lkZXJpbmcgaW50ZWdyYXRpbmcgdGhpcyBpbnRvIG15IHYyIHBh
dGNoc2V0Lgo+Pj4+Pj4+Pj4+IEJ1dCB0aGVyZSBpcyBvbmUgcHJvYmxlbe+8mgo+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4gSW4gdGhpcyB0b29sLCB2ZHBhIGRldmljZSBjb25maWcgYWN0aW9uIGFuZCBl
bmFibGUgYWN0aW9uCj4+Pj4+Pj4+Pj4gYXJlIGNvbWJpbmVkIGludG8gb25lIG5ldGxpbmsgbXNn
OiBWRFBBX0NNRF9ERVZfTkVXLiBCdXQKPj4+Pj4+Pj4+PiBpbgo+Pj4+IHZkdXNlCj4+Pj4+Pj4+
Pj4gY2FzZSwgaXQgbmVlZHMgdG8gYmUgc3BsaXR0ZWQgYmVjYXVzZSBhIGNoYXJkZXYgc2hvdWxk
IGJlCj4+Pj4+Pj4+Pj4gY3JlYXRlZCBhbmQgb3BlbmVkIGJ5IGEgdXNlcnNwYWNlIHByb2Nlc3Mg
YmVmb3JlIHdlIGVuYWJsZQo+Pj4+Pj4+Pj4+IHRoZSB2ZHBhIGRldmljZSAoY2FsbCB2ZHBhX3Jl
Z2lzdGVyX2RldmljZSgpKS4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IFNvIEknZCBsaWtlIHRvIGtu
b3cgd2hldGhlciBpdCdzIHBvc3NpYmxlIChvciBoYXZlIHNvbWUKPj4+Pj4+Pj4+PiBwbGFucykg
dG8gYWRkIHR3byBuZXcgbmV0bGluayBtc2dzIHNvbWV0aGluZyBsaWtlOgo+Pj4+Pj4+Pj4+IFZE
UEFfQ01EX0RFVl9FTkFCTEUKPj4+Pj4+IGFuZAo+Pj4+Pj4+Pj4+IFZEUEFfQ01EX0RFVl9ESVNB
QkxFIHRvIG1ha2UgdGhlIGNvbmZpZyBwYXRoIG1vcmUgZmxleGlibGUuCj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+IEFjdHVhbGx5LCB3ZSd2ZSBkaXNjdXNzZWQgc3VjaCBpbnRlcm1lZGlhdGUgc3RlcCBp
biBzb21lCj4+Pj4+Pj4+PiBlYXJseSBkaXNjdXNzaW9uLiBJdCBsb29rcyB0byBtZSBWRFVTRSBj
b3VsZCBiZSBvbmUgb2YgdGhlIHVzZXJzIG9mCj4+IHRoaXMuCj4+Pj4+Pj4+PiBPciBJIHdvbmRl
ciB3aGV0aGVyIHdlIGNhbiBzd2l0Y2ggdG8gdXNlIGFub255bW91cwo+Pj4+Pj4+Pj4gaW5vZGUo
ZmQpIGZvciBWRFVTRSB0aGVuIGZldGNoaW5nIGl0IHZpYSBhbiBWRFVTRV9HRVRfREVWSUNFX0ZE
Cj4+IGlvY3RsPwo+Pj4+Pj4+PiBZZXMsIHdlIGNhbi4gQWN0dWFsbHkgdGhlIGN1cnJlbnQgaW1w
bGVtZW50YXRpb24gaW4gVkRVU0UgaXMKPj4+Pj4+Pj4gbGlrZSB0aGlzLiAgQnV0IHNlZW1zIGxp
a2UgdGhpcyBpcyBzdGlsbCBhIGludGVybWVkaWF0ZSBzdGVwLgo+Pj4+Pj4+PiBUaGUgZmQgc2hv
dWxkIGJlIGJpbmRlZCB0byBhIG5hbWUgb3Igc29tZXRoaW5nIGVsc2Ugd2hpY2gKPj4+Pj4+Pj4g
bmVlZCB0byBiZSBjb25maWd1cmVkIGJlZm9yZS4KPj4+Pj4+Pgo+Pj4+Pj4+IFRoZSBuYW1lIGNv
dWxkIGJlIHNwZWNpZmllZCB2aWEgdGhlIG5ldGxpbmsuIEl0IGxvb2tzIHRvIG1lCj4+Pj4+Pj4g
dGhlIHJlYWwgaXNzdWUgaXMgdGhhdCB1bnRpbCB0aGUgZGV2aWNlIGlzIGNvbm5lY3RlZCB3aXRo
IGEKPj4+Pj4+PiB1c2Vyc3BhY2UsIGl0IGNhbid0IGJlIHVzZWQuIFNvIHdlIGFsc28gbmVlZCB0
byBmYWlsIHRoZQo+Pj4+Pj4+IGVuYWJsaW5nIGlmIGl0IGRvZXNuJ3QKPj4+PiBvcGVuZWQuCj4+
Pj4+PiBZZXMsIHRoYXQncyB0cnVlLiBTbyB5b3UgbWVhbiB3ZSBjYW4gZmlyc3RseSB0cnkgdG8g
ZmV0Y2ggdGhlIGZkCj4+Pj4+PiBiaW5kZWQgdG8gYSBuYW1lL3ZkdXNlX2lkIHZpYSBhbiBWRFVT
RV9HRVRfREVWSUNFX0ZELCB0aGVuIHVzZQo+Pj4+Pj4gdGhlIG5hbWUvdmR1c2VfaWQgYXMgYSBh
dHRyaWJ1dGUgdG8gY3JlYXRlIHZkcGEgZGV2aWNlPyBJdCBsb29rcyBmaW5lIHRvCj4+IG1lLgo+
Pj4+PiBJIHByb2JhYmx5IGRvIG5vdCB3ZWxsIHVuZGVyc3RhbmQuIEkgdHJpZWQgcmVhZGluZyBw
YXRjaCBbMV0gYW5kCj4+Pj4+IGZldyB0aGluZ3MKPj4+PiBkbyBub3QgbG9vayBjb3JyZWN0IGFz
IGJlbG93Lgo+Pj4+PiBDcmVhdGluZyB0aGUgdmRwYSBkZXZpY2Ugb24gdGhlIGJ1cyBkZXZpY2Ug
YW5kIGRlc3Ryb3lpbmcgdGhlCj4+Pj4+IGRldmljZSBmcm9tCj4+Pj4gdGhlIHdvcmtxdWV1ZSBz
ZWVtcyB1bm5lY2Vzc2FyeSBhbmQgcmFjeS4KPj4+Pj4gSXQgc2VlbXMgdmR1c2UgZHJpdmVyIG5l
ZWRzCj4+Pj4+IFRoaXMgaXMgc29tZXRoaW5nIHNob3VsZCBiZSBkb25lIGFzIHBhcnQgb2YgdGhl
IHZkcGEgZGV2IGFkZAo+Pj4+PiBjb21tYW5kLAo+Pj4+IGluc3RlYWQgb2YgY29ubmVjdGluZyB0
d28gc2lkZXMgc2VwYXJhdGVseSBhbmQgZW5zdXJpbmcgcmFjZSBmcmVlCj4+Pj4gYWNjZXNzIHRv
IGl0Lgo+Pj4+PiBTbyBWRFVTRV9ERVZfU1RBUlQgYW5kIFZEVVNFX0RFVl9TVE9QIHNob3VsZCBw
b3NzaWJseSBiZSBhdm9pZGVkLgo+Pj4+Pgo+Pj4+IFllcywgd2UgY2FuIGF2b2lkIHRoZXNlIHR3
byBpb2N0bHMgd2l0aCB0aGUgaGVscCBvZiB0aGUgbWFuYWdlbWVudCB0b29sLgo+Pj4+Cj4+Pj4+
ICQgdmRwYSBkZXYgYWRkIHBhcmVudGRldiB2ZHVzZV9tZ210ZGV2IHR5cGUgbmV0IG5hbWUgZm9v
Mgo+Pj4+Pgo+Pj4+PiBXaGVuIGFib3ZlIGNvbW1hbmQgaXMgZXhlY3V0ZWQgaXQgY3JlYXRlcyBu
ZWNlc3NhcnkgdmRwYSBkZXZpY2UKPj4+Pj4gZm9vMgo+Pj4+IG9uIHRoZSBidXMuCj4+Pj4+IFdo
ZW4gdXNlciBiaW5kcyBmb28yIGRldmljZSB3aXRoIHRoZSB2ZHVzZSBkcml2ZXIsIGluIHRoZSBw
cm9iZSgpLAo+Pj4+PiBpdAo+Pj4+IGNyZWF0ZXMgcmVzcGVjdGl2ZSBjaGFyIGRldmljZSB0byBh
Y2Nlc3MgaXQgZnJvbSB1c2VyIHNwYWNlLgo+Pj4+Cj4+PiBJIHNlZS4gU28gdmR1c2UgY2Fubm90
IHdvcmsgd2l0aCBhbnkgZXhpc3RpbmcgdmRwYSBkZXZpY2VzIGxpa2UgaWZjLCBtbHg1IG9yCj4+
IG5ldGRldnNpbS4KPj4+IEl0IGhhcyBpdHMgb3duIGltcGxlbWVudGF0aW9uIHNpbWlsYXIgdG8g
ZnVzZSB3aXRoIGl0cyBvd24gYmFja2VuZCBvZiBjaG9pY2UuCj4+PiBNb3JlIGJlbG93Lgo+Pj4K
Pj4+PiBCdXQgdmR1c2UgZHJpdmVyIGlzIG5vdCBhIHZkcGEgYnVzIGRyaXZlci4gSXQgd29ya3Mg
bGlrZSB2ZHBhc2ltCj4+Pj4gZHJpdmVyLCBidXQgb2ZmbG9hZHMgdGhlIGRhdGEgcGxhbmUgYW5k
IGNvbnRyb2wgcGxhbmUgdG8gYSB1c2VyIHNwYWNlIHByb2Nlc3MuCj4+PiBJbiB0aGF0IGNhc2Ug
dG8gZHJhdyBwYXJhbGxlbCBsaW5lcywKPj4+Cj4+PiAxLiBuZXRkZXZzaW06Cj4+PiAoYSkgY3Jl
YXRlIHJlc291cmNlcyBpbiBrZXJuZWwgc3cKPj4+IChiKSBkYXRhcGF0aCBzaW11bGF0ZXMgaW4g
a2VybmVsCj4+Pgo+Pj4gMi4gaWZjICsgbWx4NSB2ZHBhIGRldjoKPj4+IChhKSBjcmVhdGVzIHJl
c291cmNlIGluIGh3Cj4+PiAoYikgZGF0YSBwYXRoIGlzIGluIGh3Cj4+Pgo+Pj4gMy4gdmR1c2U6
Cj4+PiAoYSkgY3JlYXRlcyByZXNvdXJjZXMgaW4gdXNlcnNwYWNlIHN3Cj4+PiAoYikgZGF0YSBw
YXRoIGlzIGluIHVzZXIgc3BhY2UuCj4+PiBoZW5jZSBjcmVhdGVzIGRhdGEgcGF0aCByZXNvdXJj
ZXMgZm9yIHVzZXIgc3BhY2UuCj4+PiBTbyBjaGFyIGRldmljZSBpcyBjcmVhdGVkLCByZW1vdmVk
IGFzIHJlc3VsdCBvZiB2ZHBhIGRldmljZSBjcmVhdGlvbi4KPj4+Cj4+PiBGb3IgZXhhbXBsZSwK
Pj4+ICQgdmRwYSBkZXYgYWRkIHBhcmVudGRldiB2ZHVzZV9tZ210ZGV2IHR5cGUgbmV0IG5hbWUg
Zm9vMgo+Pj4KPj4+IEFib3ZlIGNvbW1hbmQgd2lsbCBjcmVhdGUgY2hhciBkZXZpY2UgZm9yIHVz
ZXIgc3BhY2UuCj4+Pgo+Pj4gU2ltaWxhciBjb21tYW5kIGZvciBpZmMvbWx4NSB3b3VsZCBoYXZl
IGNyZWF0ZWQgc2ltaWxhciBjaGFubmVsIGZvciByZXN0IG9mCj4+IHRoZSBjb25maWcgY29tbWFu
ZHMgaW4gaHcuCj4+PiB2ZHVzZSBjaGFubmVsID0gY2hhciBkZXZpY2UsIGV2ZW50ZmQgZXRjLgo+
Pj4gaWZjL21seDUgaHcgY2hhbm5lbCA9IGJhciwgaXJxLCBjb21tYW5kIGludGVyZmFjZSBldGMg
TmV0ZGV2IHNpbQo+Pj4gY2hhbm5lbCA9IHN3IGRpcmVjdCBjYWxscwo+Pj4KPj4+IERvZXMgaXQg
bWFrZSBzZW5zZT8KPj4gSW4gbXkgdW5kZXJzdGFuZGluZywgdG8gbWFrZSB2ZHBhIHdvcmssIHdl
IG5lZWQgYSBiYWNrZW5kIChkYXRhcGF0aAo+PiByZXNvdXJjZXMpIGFuZCBhIGZyb250ZW5kIChh
IHZkcGEgZGV2aWNlIGF0dGFjaGVkIHRvIGEgdmRwYSBidXMpLiBJbiB0aGUgYWJvdmUKPj4gZXhh
bXBsZSwgaXQgbG9va3MgbGlrZSB3ZSB1c2UgdGhlIGNvbW1hbmQgInZkcGEgZGV2IGFkZCAuLi4i
Cj4+ICAgdG8gY3JlYXRlIGEgYmFja2VuZCwgc28gZG8gd2UgbmVlZCBhbm90aGVyIGNvbW1hbmQg
dG8gY3JlYXRlIGEgZnJvbnRlbmQ/Cj4+Cj4gRm9yIGJsb2NrIGRldmljZSB0aGVyZSBpcyBjZXJ0
YWlubHkgc29tZSBiYWNrZW5kIHRvIHByb2Nlc3MgdGhlIElPcy4KPiBTb21ldGltZXMgYmFja2Vu
ZCB0byBiZSBzZXR1cCBmaXJzdCwgYmVmb3JlIGl0cyBmcm9udCBlbmQgaXMgZXhwb3NlZC4KPiAi
dmRwYSBkZXYgYWRkIiBpcyB0aGUgZnJvbnQgZW5kIGNvbW1hbmQgd2hvIGNvbm5lY3RzIHRvIHRo
ZSBiYWNrZW5kIChpbXBsaWNpdGx5KSBmb3IgbmV0d29yayBkZXZpY2UuCj4KPiB2aG9zdC0+dmRw
YV9ibG9ja19kZXZpY2UtPmJhY2tlbmRfaW9fcHJvY2Vzc29yICh1c3IsaHcsa2VybmVsKS4KPgo+
IEFuZCBpdCBuZWVkcyBhIHdheSB0byBjb25uZWN0IHRvIGJhY2tlbmQgd2hlbiBleHBsaWNpdGx5
IHNwZWNpZmllZCBkdXJpbmcgY3JlYXRpb24gdGltZS4KPiBTb21ldGhpbmcgbGlrZSwKPiAkIHZk
cGEgZGV2IGFkZCBwYXJlbnRkZXYgdmRwYV92ZHVzZSB0eXBlIGJsb2NrIG5hbWUgZm9vMyBoYW5k
bGUgPHV1aWQ+Cj4gSW4gYWJvdmUgZXhhbXBsZSBzb21lIHZlbmRvciBkZXZpY2Ugc3BlY2lmaWMg
dW5pcXVlIGhhbmRsZSBpcyBwYXNzZWQgYmFzZWQgb24gYmFja2VuZCBzZXR1cCBpbiBoYXJkd2Fy
ZS91c2VyIHNwYWNlLgo+Cj4gSW4gYmVsb3cgMyBleGFtcGxlcywgdmRwYSBibG9jayBzaW11bGF0
b3IgaXMgY29ubmVjdGluZyB0byBiYWNrZW5kIGJsb2NrIG9yIGZpbGUuCj4KPiAkIHZkcGEgZGV2
IGFkZCBwYXJlbnRkZXYgdmRwYV9ibG9ja3NpbSB0eXBlIGJsb2NrIG5hbWUgZm9vNCBibG9ja2Rl
diAvZGV2L3plcm8KPgo+ICQgdmRwYSBkZXYgYWRkIHBhcmVudGRldiB2ZHBhX2Jsb2Nrc2ltIHR5
cGUgYmxvY2sgbmFtZSBmb281IGJsb2NrZGV2IC9kZXYvc2RhMiBzaXplPTEwME0gb2Zmc2V0PTEw
TQo+Cj4gJCB2ZHBhIGRldiBhZGQgcGFyZW50ZGV2IHZkcGFfYmxvY2sgZmlsZWJhY2tlbmRfc2lt
IHR5cGUgYmxvY2sgbmFtZSBmb282IGZpbGUgL3Jvb3QvZmlsZV9iYWNrZW5kLnR4dAo+Cj4gT3Ig
bWF5IGJlIGJhY2tlbmQgY29ubmVjdHMgdG8gdGhlIGNyZWF0ZWQgdmRwYSBkZXZpY2UgaXMgYm91
bmQgdG8gdGhlIGRyaXZlci4KPiBDYW4gdmR1c2UgYXR0YWNoIHRvIHRoZSBjcmVhdGVkIHZkcGEg
YmxvY2sgZGV2aWNlIHRocm91Z2ggdGhlIGNoYXIgZGV2aWNlIGFuZCBlc3RhYmxpc2ggdGhlIGNo
YW5uZWwgdG8gcmVjZWl2ZSBJT3MsIGFuZCB0byBzZXR1cCB0aGUgYmxvY2sgY29uZmlnIHNwYWNl
PwoKCkkgdGhpbmsgaXQgY2FuIHdvcmsuCgpBbm90aGVyIHRoaW5nIEkgd29uZGVyIGl0IHRoYXQs
IGRvIHdlIGNvbnNpZGVyIG1vcmUgdGhhbiBvbmUgVkRVU0UgCnBhcmVudGRldihvciBtYW5hZ2Vt
ZW50IGRldik/IFRoaXMgYWxsb3dzIHVzIHRvIGhhdmUgc2VwYXJhdGVkIGRldmljZXMgCmltcGxl
bWVudGVkIHZpYSBkaWZmZXJlbnQgcHJvY2Vzc2VzLgoKSWYgeWVzLCBWRFVTRSBpb2N0bCBuZWVk
cyB0byBiZSBleHRlbmRlZCB0byByZWdpc3Rlci91bnJlZ2lzdGVyIHBhcmVudGRldi4KClRoYW5r
cwoKCj4KPj4gVGhhbmtzLAo+PiBZb25namkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
