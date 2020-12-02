Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CCBC64E7C
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 07:56:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C132065C
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 07:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C132065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5042C881E9;
	Wed,  2 Dec 2020 07:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dl-uTy1JbbYz; Wed,  2 Dec 2020 07:56:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 60EFC86A11;
	Wed,  2 Dec 2020 07:56:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ACEFC0859;
	Wed,  2 Dec 2020 07:56:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10F34C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 07:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F1B96881E9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 07:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HXMtPiIcIAOU
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 07:56:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 79B8C86A11
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 07:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606895763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HBrsTkIw6oLpANM5sUvCMswDJ1TEwQMY1RdAELPPQM=;
 b=GyXhumFzPL3S10K76Kb5QNXnHpfjxCs7iPeiJRjV1tIJs2xOJxH5HjBe8Ts2rKA8guz+k3
 er4nAe15WS3VeNW2N4NK1Ll3YItV4UcJ91mgbh9x82Gqrv4/zRml3smQ8jn4ARVgDKZmZs
 Jeip9OUxn4AyuvNBw0WsM4zEwV7il2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-3xTdCzRGPe-s9hxfgM1nrg-1; Wed, 02 Dec 2020 02:56:01 -0500
X-MC-Unique: 3xTdCzRGPe-s9hxfgM1nrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FD40803F4C;
 Wed,  2 Dec 2020 07:56:00 +0000 (UTC)
Received: from [10.72.13.145] (ovpn-13-145.pek2.redhat.com [10.72.13.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06A2060C6A;
 Wed,  2 Dec 2020 07:55:53 +0000 (UTC)
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
 <3d91bf80-1a35-9f79-dbca-596358acc0a7@redhat.com>
 <BY5PR12MB432217EEF5D58C1757BB620DDCF30@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8d9694aa-382b-0eeb-a8d1-e23d33fea650@redhat.com>
Date: Wed, 2 Dec 2020 15:55:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB432217EEF5D58C1757BB620DDCF30@BY5PR12MB4322.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Ck9uIDIwMjAvMTIvMiDkuIvljYgyOjI0LCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4KPj4gRnJvbTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4gU2VudDogV2VkbmVzZGF5LCBEZWNl
bWJlciAyLCAyMDIwIDExOjIxIEFNCj4+Cj4+IE9uIDIwMjAvMTIvMiDkuIvljYgxMjo1MywgUGFy
YXYgUGFuZGl0IHdyb3RlOgo+Pj4+IEZyb206IFlvbmdqaSBYaWUgPHhpZXlvbmdqaUBieXRlZGFu
Y2UuY29tPgo+Pj4+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMiwgMjAyMCA5OjAwIEFNCj4+
Pj4KPj4+PiBPbiBUdWUsIERlYyAxLCAyMDIwIGF0IDExOjU5IFBNIFBhcmF2IFBhbmRpdCA8cGFy
YXZAbnZpZGlhLmNvbT4gd3JvdGU6Cj4+Pj4+Cj4+Pj4+PiBGcm9tOiBZb25namkgWGllIDx4aWV5
b25namlAYnl0ZWRhbmNlLmNvbT4KPj4+Pj4+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDEsIDIw
MjAgNzo0OSBQTQo+Pj4+Pj4KPj4+Pj4+IE9uIFR1ZSwgRGVjIDEsIDIwMjAgYXQgNzozMiBQTSBQ
YXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+Cj4+IHdyb3RlOgo+Pj4+Pj4+Cj4+Pj4+Pj4+
IEZyb206IFlvbmdqaSBYaWUgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+Pj4+Pj4+PiBTZW50
OiBUdWVzZGF5LCBEZWNlbWJlciAxLCAyMDIwIDM6MjYgUE0KPj4+Pj4+Pj4KPj4+Pj4+Pj4gT24g
VHVlLCBEZWMgMSwgMjAyMCBhdCAyOjI1IFBNIEphc29uIFdhbmcKPj4gPGphc293YW5nQHJlZGhh
dC5jb20+Cj4+Pj4+PiB3cm90ZToKPj4+Pj4+Pj4+IE9uIDIwMjAvMTEvMzAg5LiL5Y2IMzowNywg
WW9uZ2ppIFhpZSB3cm90ZToKPj4+Pj4+Pj4+Pj4+IFRoYW5rcyBmb3IgYWRkaW5nIG1lLCBKYXNv
biEKPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBOb3cgSSdtIHdvcmtpbmcgb24gYSB2MiBwYXRj
aHNldCBmb3IgVkRVU0UgKHZEUEEgRGV2aWNlIGluCj4+Pj4+Pj4+Pj4+PiBVc2Vyc3BhY2UpIFsx
XS4gVGhpcyB0b29sIGlzIHZlcnkgdXNlZnVsIGZvciB0aGUgdmR1c2UgZGV2aWNlLgo+Pj4+Pj4+
Pj4+Pj4gU28gSSdtIGNvbnNpZGVyaW5nIGludGVncmF0aW5nIHRoaXMgaW50byBteSB2MiBwYXRj
aHNldC4KPj4+Pj4+Pj4+Pj4+IEJ1dCB0aGVyZSBpcyBvbmUgcHJvYmxlbe+8mgo+Pj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4+IEluIHRoaXMgdG9vbCwgdmRwYSBkZXZpY2UgY29uZmlnIGFjdGlvbiBh
bmQgZW5hYmxlIGFjdGlvbiBhcmUKPj4+Pj4+Pj4+Pj4+IGNvbWJpbmVkIGludG8gb25lIG5ldGxp
bmsgbXNnOiBWRFBBX0NNRF9ERVZfTkVXLiBCdXQgaW4KPj4+Pj4+IHZkdXNlCj4+Pj4+Pj4+Pj4+
PiBjYXNlLCBpdCBuZWVkcyB0byBiZSBzcGxpdHRlZCBiZWNhdXNlIGEgY2hhcmRldiBzaG91bGQg
YmUKPj4+Pj4+Pj4+Pj4+IGNyZWF0ZWQgYW5kIG9wZW5lZCBieSBhIHVzZXJzcGFjZSBwcm9jZXNz
IGJlZm9yZSB3ZSBlbmFibGUKPj4+Pj4+Pj4+Pj4+IHRoZSB2ZHBhIGRldmljZSAoY2FsbCB2ZHBh
X3JlZ2lzdGVyX2RldmljZSgpKS4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBTbyBJJ2QgbGlr
ZSB0byBrbm93IHdoZXRoZXIgaXQncyBwb3NzaWJsZSAob3IgaGF2ZSBzb21lCj4+Pj4+Pj4+Pj4+
PiBwbGFucykgdG8gYWRkIHR3byBuZXcgbmV0bGluayBtc2dzIHNvbWV0aGluZyBsaWtlOgo+Pj4+
Pj4+Pj4+Pj4gVkRQQV9DTURfREVWX0VOQUJMRQo+Pj4+Pj4+PiBhbmQKPj4+Pj4+Pj4+Pj4+IFZE
UEFfQ01EX0RFVl9ESVNBQkxFIHRvIG1ha2UgdGhlIGNvbmZpZyBwYXRoIG1vcmUKPj4gZmxleGli
bGUuCj4+Pj4+Pj4+Pj4+IEFjdHVhbGx5LCB3ZSd2ZSBkaXNjdXNzZWQgc3VjaCBpbnRlcm1lZGlh
dGUgc3RlcCBpbiBzb21lIGVhcmx5Cj4+Pj4+Pj4+Pj4+IGRpc2N1c3Npb24uIEl0IGxvb2tzIHRv
IG1lIFZEVVNFIGNvdWxkIGJlIG9uZSBvZiB0aGUgdXNlcnMgb2YKPj4+PiB0aGlzLgo+Pj4+Pj4+
Pj4+PiBPciBJIHdvbmRlciB3aGV0aGVyIHdlIGNhbiBzd2l0Y2ggdG8gdXNlIGFub255bW91cwo+
Pj4+Pj4+Pj4+PiBpbm9kZShmZCkgZm9yIFZEVVNFIHRoZW4gZmV0Y2hpbmcgaXQgdmlhIGFuCj4+
Pj4+Pj4+Pj4+IFZEVVNFX0dFVF9ERVZJQ0VfRkQKPj4+PiBpb2N0bD8KPj4+Pj4+Pj4+PiBZZXMs
IHdlIGNhbi4gQWN0dWFsbHkgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaW4gVkRVU0UgaXMK
Pj4+Pj4+Pj4+PiBsaWtlIHRoaXMuICBCdXQgc2VlbXMgbGlrZSB0aGlzIGlzIHN0aWxsIGEgaW50
ZXJtZWRpYXRlIHN0ZXAuCj4+Pj4+Pj4+Pj4gVGhlIGZkIHNob3VsZCBiZSBiaW5kZWQgdG8gYSBu
YW1lIG9yIHNvbWV0aGluZyBlbHNlIHdoaWNoIG5lZWQKPj4+Pj4+Pj4+PiB0byBiZSBjb25maWd1
cmVkIGJlZm9yZS4KPj4+Pj4+Pj4+IFRoZSBuYW1lIGNvdWxkIGJlIHNwZWNpZmllZCB2aWEgdGhl
IG5ldGxpbmsuIEl0IGxvb2tzIHRvIG1lIHRoZQo+Pj4+Pj4+Pj4gcmVhbCBpc3N1ZSBpcyB0aGF0
IHVudGlsIHRoZSBkZXZpY2UgaXMgY29ubmVjdGVkIHdpdGggYQo+Pj4+Pj4+Pj4gdXNlcnNwYWNl
LCBpdCBjYW4ndCBiZSB1c2VkLiBTbyB3ZSBhbHNvIG5lZWQgdG8gZmFpbCB0aGUKPj4+Pj4+Pj4+
IGVuYWJsaW5nIGlmIGl0IGRvZXNuJ3QKPj4+Pj4+IG9wZW5lZC4KPj4+Pj4+Pj4gWWVzLCB0aGF0
J3MgdHJ1ZS4gU28geW91IG1lYW4gd2UgY2FuIGZpcnN0bHkgdHJ5IHRvIGZldGNoIHRoZSBmZAo+
Pj4+Pj4+PiBiaW5kZWQgdG8gYSBuYW1lL3ZkdXNlX2lkIHZpYSBhbiBWRFVTRV9HRVRfREVWSUNF
X0ZELCB0aGVuCj4+IHVzZQo+Pj4+Pj4+PiB0aGUgbmFtZS92ZHVzZV9pZCBhcyBhIGF0dHJpYnV0
ZSB0byBjcmVhdGUgdmRwYSBkZXZpY2U/IEl0IGxvb2tzCj4+Pj4+Pj4+IGZpbmUgdG8KPj4+PiBt
ZS4KPj4+Pj4+PiBJIHByb2JhYmx5IGRvIG5vdCB3ZWxsIHVuZGVyc3RhbmQuIEkgdHJpZWQgcmVh
ZGluZyBwYXRjaCBbMV0gYW5kCj4+Pj4+Pj4gZmV3IHRoaW5ncwo+Pj4+Pj4gZG8gbm90IGxvb2sg
Y29ycmVjdCBhcyBiZWxvdy4KPj4+Pj4+PiBDcmVhdGluZyB0aGUgdmRwYSBkZXZpY2Ugb24gdGhl
IGJ1cyBkZXZpY2UgYW5kIGRlc3Ryb3lpbmcgdGhlCj4+Pj4+Pj4gZGV2aWNlIGZyb20KPj4+Pj4+
IHRoZSB3b3JrcXVldWUgc2VlbXMgdW5uZWNlc3NhcnkgYW5kIHJhY3kuCj4+Pj4+Pj4gSXQgc2Vl
bXMgdmR1c2UgZHJpdmVyIG5lZWRzCj4+Pj4+Pj4gVGhpcyBpcyBzb21ldGhpbmcgc2hvdWxkIGJl
IGRvbmUgYXMgcGFydCBvZiB0aGUgdmRwYSBkZXYgYWRkCj4+Pj4+Pj4gY29tbWFuZCwKPj4+Pj4+
IGluc3RlYWQgb2YgY29ubmVjdGluZyB0d28gc2lkZXMgc2VwYXJhdGVseSBhbmQgZW5zdXJpbmcg
cmFjZSBmcmVlCj4+Pj4+PiBhY2Nlc3MgdG8gaXQuCj4+Pj4+Pj4gU28gVkRVU0VfREVWX1NUQVJU
IGFuZCBWRFVTRV9ERVZfU1RPUCBzaG91bGQgcG9zc2libHkgYmUKPj4gYXZvaWRlZC4KPj4+Pj4+
IFllcywgd2UgY2FuIGF2b2lkIHRoZXNlIHR3byBpb2N0bHMgd2l0aCB0aGUgaGVscCBvZiB0aGUg
bWFuYWdlbWVudAo+PiB0b29sLgo+Pj4+Pj4+ICQgdmRwYSBkZXYgYWRkIHBhcmVudGRldiB2ZHVz
ZV9tZ210ZGV2IHR5cGUgbmV0IG5hbWUgZm9vMgo+Pj4+Pj4+Cj4+Pj4+Pj4gV2hlbiBhYm92ZSBj
b21tYW5kIGlzIGV4ZWN1dGVkIGl0IGNyZWF0ZXMgbmVjZXNzYXJ5IHZkcGEgZGV2aWNlCj4+Pj4+
Pj4gZm9vMgo+Pj4+Pj4gb24gdGhlIGJ1cy4KPj4+Pj4+PiBXaGVuIHVzZXIgYmluZHMgZm9vMiBk
ZXZpY2Ugd2l0aCB0aGUgdmR1c2UgZHJpdmVyLCBpbiB0aGUgcHJvYmUoKSwKPj4+Pj4+PiBpdAo+
Pj4+Pj4gY3JlYXRlcyByZXNwZWN0aXZlIGNoYXIgZGV2aWNlIHRvIGFjY2VzcyBpdCBmcm9tIHVz
ZXIgc3BhY2UuCj4+Pj4+Pgo+Pj4+PiBJIHNlZS4gU28gdmR1c2UgY2Fubm90IHdvcmsgd2l0aCBh
bnkgZXhpc3RpbmcgdmRwYSBkZXZpY2VzIGxpa2UgaWZjLAo+Pj4+PiBtbHg1IG9yCj4+Pj4gbmV0
ZGV2c2ltLgo+Pj4+PiBJdCBoYXMgaXRzIG93biBpbXBsZW1lbnRhdGlvbiBzaW1pbGFyIHRvIGZ1
c2Ugd2l0aCBpdHMgb3duIGJhY2tlbmQgb2YKPj4gY2hvaWNlLgo+Pj4+PiBNb3JlIGJlbG93Lgo+
Pj4+Pgo+Pj4+Pj4gQnV0IHZkdXNlIGRyaXZlciBpcyBub3QgYSB2ZHBhIGJ1cyBkcml2ZXIuIEl0
IHdvcmtzIGxpa2UgdmRwYXNpbQo+Pj4+Pj4gZHJpdmVyLCBidXQgb2ZmbG9hZHMgdGhlIGRhdGEg
cGxhbmUgYW5kIGNvbnRyb2wgcGxhbmUgdG8gYSB1c2VyIHNwYWNlCj4+IHByb2Nlc3MuCj4+Pj4+
IEluIHRoYXQgY2FzZSB0byBkcmF3IHBhcmFsbGVsIGxpbmVzLAo+Pj4+Pgo+Pj4+PiAxLiBuZXRk
ZXZzaW06Cj4+Pj4+IChhKSBjcmVhdGUgcmVzb3VyY2VzIGluIGtlcm5lbCBzdwo+Pj4+PiAoYikg
ZGF0YXBhdGggc2ltdWxhdGVzIGluIGtlcm5lbAo+Pj4+Pgo+Pj4+PiAyLiBpZmMgKyBtbHg1IHZk
cGEgZGV2Ogo+Pj4+PiAoYSkgY3JlYXRlcyByZXNvdXJjZSBpbiBodwo+Pj4+PiAoYikgZGF0YSBw
YXRoIGlzIGluIGh3Cj4+Pj4+Cj4+Pj4+IDMuIHZkdXNlOgo+Pj4+PiAoYSkgY3JlYXRlcyByZXNv
dXJjZXMgaW4gdXNlcnNwYWNlIHN3Cj4+Pj4+IChiKSBkYXRhIHBhdGggaXMgaW4gdXNlciBzcGFj
ZS4KPj4+Pj4gaGVuY2UgY3JlYXRlcyBkYXRhIHBhdGggcmVzb3VyY2VzIGZvciB1c2VyIHNwYWNl
Lgo+Pj4+PiBTbyBjaGFyIGRldmljZSBpcyBjcmVhdGVkLCByZW1vdmVkIGFzIHJlc3VsdCBvZiB2
ZHBhIGRldmljZSBjcmVhdGlvbi4KPj4+Pj4KPj4+Pj4gRm9yIGV4YW1wbGUsCj4+Pj4+ICQgdmRw
YSBkZXYgYWRkIHBhcmVudGRldiB2ZHVzZV9tZ210ZGV2IHR5cGUgbmV0IG5hbWUgZm9vMgo+Pj4+
Pgo+Pj4+PiBBYm92ZSBjb21tYW5kIHdpbGwgY3JlYXRlIGNoYXIgZGV2aWNlIGZvciB1c2VyIHNw
YWNlLgo+Pj4+Pgo+Pj4+PiBTaW1pbGFyIGNvbW1hbmQgZm9yIGlmYy9tbHg1IHdvdWxkIGhhdmUg
Y3JlYXRlZCBzaW1pbGFyIGNoYW5uZWwgZm9yCj4+Pj4+IHJlc3Qgb2YKPj4+PiB0aGUgY29uZmln
IGNvbW1hbmRzIGluIGh3Lgo+Pj4+PiB2ZHVzZSBjaGFubmVsID0gY2hhciBkZXZpY2UsIGV2ZW50
ZmQgZXRjLgo+Pj4+PiBpZmMvbWx4NSBodyBjaGFubmVsID0gYmFyLCBpcnEsIGNvbW1hbmQgaW50
ZXJmYWNlIGV0YyBOZXRkZXYgc2ltCj4+Pj4+IGNoYW5uZWwgPSBzdyBkaXJlY3QgY2FsbHMKPj4+
Pj4KPj4+Pj4gRG9lcyBpdCBtYWtlIHNlbnNlPwo+Pj4+IEluIG15IHVuZGVyc3RhbmRpbmcsIHRv
IG1ha2UgdmRwYSB3b3JrLCB3ZSBuZWVkIGEgYmFja2VuZCAoZGF0YXBhdGgKPj4+PiByZXNvdXJj
ZXMpIGFuZCBhIGZyb250ZW5kIChhIHZkcGEgZGV2aWNlIGF0dGFjaGVkIHRvIGEgdmRwYSBidXMp
LiBJbgo+Pj4+IHRoZSBhYm92ZSBleGFtcGxlLCBpdCBsb29rcyBsaWtlIHdlIHVzZSB0aGUgY29t
bWFuZCAidmRwYSBkZXYgYWRkIC4uLiIKPj4+PiAgICB0byBjcmVhdGUgYSBiYWNrZW5kLCBzbyBk
byB3ZSBuZWVkIGFub3RoZXIgY29tbWFuZCB0byBjcmVhdGUgYQo+PiBmcm9udGVuZD8KPj4+IEZv
ciBibG9jayBkZXZpY2UgdGhlcmUgaXMgY2VydGFpbmx5IHNvbWUgYmFja2VuZCB0byBwcm9jZXNz
IHRoZSBJT3MuCj4+PiBTb21ldGltZXMgYmFja2VuZCB0byBiZSBzZXR1cCBmaXJzdCwgYmVmb3Jl
IGl0cyBmcm9udCBlbmQgaXMgZXhwb3NlZC4KPj4+ICJ2ZHBhIGRldiBhZGQiIGlzIHRoZSBmcm9u
dCBlbmQgY29tbWFuZCB3aG8gY29ubmVjdHMgdG8gdGhlIGJhY2tlbmQKPj4gKGltcGxpY2l0bHkp
IGZvciBuZXR3b3JrIGRldmljZS4KPj4+IHZob3N0LT52ZHBhX2Jsb2NrX2RldmljZS0+YmFja2Vu
ZF9pb19wcm9jZXNzb3IgKHVzcixodyxrZXJuZWwpLgo+Pj4KPj4+IEFuZCBpdCBuZWVkcyBhIHdh
eSB0byBjb25uZWN0IHRvIGJhY2tlbmQgd2hlbiBleHBsaWNpdGx5IHNwZWNpZmllZCBkdXJpbmcK
Pj4gY3JlYXRpb24gdGltZS4KPj4+IFNvbWV0aGluZyBsaWtlLAo+Pj4gJCB2ZHBhIGRldiBhZGQg
cGFyZW50ZGV2IHZkcGFfdmR1c2UgdHlwZSBibG9jayBuYW1lIGZvbzMgaGFuZGxlCj4+IDx1dWlk
Pgo+Pj4gSW4gYWJvdmUgZXhhbXBsZSBzb21lIHZlbmRvciBkZXZpY2Ugc3BlY2lmaWMgdW5pcXVl
IGhhbmRsZSBpcyBwYXNzZWQKPj4gYmFzZWQgb24gYmFja2VuZCBzZXR1cCBpbiBoYXJkd2FyZS91
c2VyIHNwYWNlLgo+Pj4gSW4gYmVsb3cgMyBleGFtcGxlcywgdmRwYSBibG9jayBzaW11bGF0b3Ig
aXMgY29ubmVjdGluZyB0byBiYWNrZW5kIGJsb2NrCj4+IG9yIGZpbGUuCj4+PiAkIHZkcGEgZGV2
IGFkZCBwYXJlbnRkZXYgdmRwYV9ibG9ja3NpbSB0eXBlIGJsb2NrIG5hbWUgZm9vNCBibG9ja2Rl
dgo+Pj4gL2Rldi96ZXJvCj4+Pgo+Pj4gJCB2ZHBhIGRldiBhZGQgcGFyZW50ZGV2IHZkcGFfYmxv
Y2tzaW0gdHlwZSBibG9jayBuYW1lIGZvbzUgYmxvY2tkZXYKPj4+IC9kZXYvc2RhMiBzaXplPTEw
ME0gb2Zmc2V0PTEwTQo+Pj4KPj4+ICQgdmRwYSBkZXYgYWRkIHBhcmVudGRldiB2ZHBhX2Jsb2Nr
IGZpbGViYWNrZW5kX3NpbSB0eXBlIGJsb2NrIG5hbWUKPj4+IGZvbzYgZmlsZSAvcm9vdC9maWxl
X2JhY2tlbmQudHh0Cj4+Pgo+Pj4gT3IgbWF5IGJlIGJhY2tlbmQgY29ubmVjdHMgdG8gdGhlIGNy
ZWF0ZWQgdmRwYSBkZXZpY2UgaXMgYm91bmQgdG8gdGhlCj4+IGRyaXZlci4KPj4+IENhbiB2ZHVz
ZSBhdHRhY2ggdG8gdGhlIGNyZWF0ZWQgdmRwYSBibG9jayBkZXZpY2UgdGhyb3VnaCB0aGUgY2hh
ciBkZXZpY2UKPj4gYW5kIGVzdGFibGlzaCB0aGUgY2hhbm5lbCB0byByZWNlaXZlIElPcywgYW5k
IHRvIHNldHVwIHRoZSBibG9jayBjb25maWcgc3BhY2U/Cj4+Cj4+Cj4+IEkgdGhpbmsgaXQgY2Fu
IHdvcmsuCj4+Cj4+IEFub3RoZXIgdGhpbmcgSSB3b25kZXIgaXQgdGhhdCwgZG8gd2UgY29uc2lk
ZXIgbW9yZSB0aGFuIG9uZSBWRFVTRQo+PiBwYXJlbnRkZXYob3IgbWFuYWdlbWVudCBkZXYpPyBU
aGlzIGFsbG93cyB1cyB0byBoYXZlIHNlcGFyYXRlZCBkZXZpY2VzCj4+IGltcGxlbWVudGVkIHZp
YSBkaWZmZXJlbnQgcHJvY2Vzc2VzLgo+IE11bHRpcGxlIHBhcmVudGRldiBzaG91bGQgYmUgcG9z
c2libGUgcGVyIG9uZSBkcml2ZXIuIGZvciBleGFtcGxlIG1seDVfdmRwYS5rbyB3aWxsIGNyZWF0
ZSBtdWx0aXBsZSBwYXJlbnQgZGV2LCBvbmUgZm9yIGVhY2ggUENJIFZGcywgU0ZzLgo+IHZkcGEg
ZGV2IGFkZCBjYW4gY2VydGFpbmx5IHVzZSBvbmUgcGFyZW50L21nbXQgZGV2IHRvIGNyZWF0ZSBt
dWx0aXBsZSB2ZHBhIGRldmljZXMuCj4gTm90IHN1cmUgd2h5IGRvIHdlIG5lZWQgdG8gY3JlYXRl
IG11bHRpcGxlIHBhcmVudCBkZXYgZm9yIHRoYXQuCj4gSSBndWVzcyB0aGVyZSBpcyBqdXN0IG9u
ZSBwYXJlbnQvbWdtdC4gZGV2IGZvciBWRFVTRS4gV2hhdCB3aWxsIGVhY2ggbWdtdGRldiBkbyBk
aWZmZXJlbnRseT8KPiBEZW11eCBvZiBJT3MsIGV2ZW50cyB3aWxsIGJlIHBlciBpbmRpdmlkdWFs
IGNoYXIgZGV2IGxldmVsPwoKCkl0IGNvdWxkIGJlIHNvbWV0aGluZyBsaWtlIGhvdyBpdCB3b3Jr
cyBmb3IgZGlmZmVyZW50IGhhcmR3YXJlIHZlbmRvcnMuIApFLmcgSUZDVkYgYW5kIG1seDUgd2ls
bCByZWdpc3RlciBkaWZmZXJlbnQgcGFyZW50ZGV2cy4gRm9yIHVzZXJzcGFjZSwgd2UgCm5lZWQg
dG8gYWxsb3cgZGlmZmVyZW50IHNvZnR3YXJlIHZlbmRvcnMgdG8gbWFuYWdlIHRoZWlyIGluc3Rh
bmNlcyAKaW5kaXZpZHVhbGx5LgoKVGhhbmtzCgoKPgo+PiBJZiB5ZXMsIFZEVVNFIGlvY3RsIG5l
ZWRzIHRvIGJlIGV4dGVuZGVkIHRvIHJlZ2lzdGVyL3VucmVnaXN0ZXIgcGFyZW50ZGV2Lgo+Pgo+
PiBUaGFua3MKPj4KPj4KPj4+PiBUaGFua3MsCj4+Pj4gWW9uZ2ppCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
