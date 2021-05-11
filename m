Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887BCC433B4
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 08:43:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBF3613AF
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 08:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBF3613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AD8B60D5C;
	Tue, 11 May 2021 08:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XLK4oZG-PeGQ; Tue, 11 May 2021 08:43:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91AC160D57;
	Tue, 11 May 2021 08:43:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56034C000D;
	Tue, 11 May 2021 08:43:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DF5AC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08B03843DB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:43:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S8M4EJRJC4be
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:43:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DFB1843AD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620722599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VvW29x9kOh4HcSoVuHYOwNRxSG1C9s+951mnrkutiW4=;
 b=eqkbqwBXo/pvztSWR7kL0Dm0/04ABuoe79e4N1vyDi5QRq1IoZ6SoZRBRc09rSkp2voboc
 etrWI4bain/XNHJcZUl+1MXnOIKSNfT0LbH67+eh8opYV6h1IDJdt5dD0sR/EXO6cB/SOO
 S5qhfhJ+xMCfEMeKlfRRxpzWqrjT8HQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-OclGWrxOPymuS58r5XS-Tg-1; Tue, 11 May 2021 04:43:15 -0400
X-MC-Unique: OclGWrxOPymuS58r5XS-Tg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26CCF100961D;
 Tue, 11 May 2021 08:43:14 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 139821037F25;
 Tue, 11 May 2021 08:43:14 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id EB3761806D0E;
 Tue, 11 May 2021 08:43:13 +0000 (UTC)
Date: Tue, 11 May 2021 04:43:13 -0400 (EDT)
From: Jason Wang <jasowang@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <529543956.24692551.1620722593826.JavaMail.zimbra@redhat.com>
In-Reply-To: <3d5754f3-c012-67ad-5f01-fc16ec53df4e@redhat.com>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
 <20210412050730-mutt-send-email-mst@kernel.org>
 <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
 <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
 <20210421035331-mutt-send-email-mst@kernel.org>
 <3d5754f3-c012-67ad-5f01-fc16ec53df4e@redhat.com>
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
MIME-Version: 1.0
X-Originating-IP: [10.72.13.219, 10.4.195.19]
Thread-Topic: vdpa: mandate 1.0 device
Thread-Index: Ak3WMaSgPuUzh6USV7wv4CzqC9hgTg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: elic@nvidia.com, linux-kernel@vger.kernel.org,
 Lingshan Zhu <lingshan.zhu@intel.com>,
 virtualization@lists.linux-foundation.org
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

CgotLS0tLSDljp/lp4vpgq7ku7YgLS0tLS0KPiAKPiDlnKggMjAyMS80LzIxIOS4i+WNiDQ6MDMs
IE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiBPbiBXZWQsIEFwciAyMSwgMjAyMSBhdCAw
Mzo0MTozNlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4+IOWcqCAyMDIxLzQvMTIg5LiL
5Y2INToyMywgSmFzb24gV2FuZyDlhpnpgZM6Cj4gPj4+IOWcqCAyMDIxLzQvMTIg5LiL5Y2INTow
OSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+Pj4+IE9uIE1vbiwgQXByIDEyLCAyMDIx
IGF0IDAyOjM1OjA3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPj4+Pj4g5ZyoIDIwMjEv
NC8xMCDkuIrljYgxMjowNCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+Pj4+Pj4gT24g
RnJpLCBBcHIgMDksIDIwMjEgYXQgMTI6NDc6NTVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
PiA+Pj4+Pj4+IOWcqCAyMDIxLzQvOCDkuIvljYgxMTo1OSwgTWljaGFlbCBTLiBUc2lya2luIOWG
memBkzoKPiA+Pj4+Pj4+PiBPbiBUaHUsIEFwciAwOCwgMjAyMSBhdCAwNDoyNjo0OFBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4+Pj4+Pj4+PiBUaGlzIHBhdGNoIG1hbmRhdGVzIDEuMCBm
b3IgdkRQQSBkZXZpY2VzLiBUaGUgZ29hbCBpcyB0byBoYXZlIHRoZQo+ID4+Pj4+Pj4+PiBzZW1h
bnRpYyBvZiBub3JtYXRpdmUgc3RhdGVtZW50IGluIHRoZSB2aXJ0aW8KPiA+Pj4+Pj4+Pj4gc3Bl
YyBhbmQgZWxpbWluYXRlIHRoZQo+ID4+Pj4+Pj4+PiBidXJkZW4gb2YgdHJhbnNpdGlvbmFsIGRl
dmljZSBmb3IgYm90aCB2RFBBIGJ1cyBhbmQgdkRQQSBwYXJlbnQuCj4gPj4+Pj4+Pj4+Cj4gPj4+
Pj4+Pj4+IHVBUEkgc2VlbXMgZmluZSBzaW5jZSBhbGwgdGhlIHZEUEEgcGFyZW50IG1hbmRhdGVz
Cj4gPj4+Pj4+Pj4+IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSB3aGljaCBpbXBsaWVzIDEuMCBk
ZXZpY2VzLgo+ID4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+PiBGb3IgbGVnYWN5IGd1ZXN0cywgaXQgY2Fu
IHN0aWxsIHdvcmsgc2luY2UgUWVtdSB3aWxsIG1lZGlhdGUgd2hlbgo+ID4+Pj4+Pj4+PiBuZWNl
c3NhcnkgKGUuZyBkb2luZyB0aGUgZW5kaWFuIGNvbnZlcnNpb24pLgo+ID4+Pj4+Pj4+Pgo+ID4+
Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+
ID4+Pj4+Pj4+IEhtbS4gSWYgd2UgZG8gdGhpcywgZG9uJ3Qgd2Ugc3RpbGwgaGF2ZSBhIHByb2Js
ZW0gd2l0aAo+ID4+Pj4+Pj4+IGxlZ2FjeSBkcml2ZXJzIHdoaWNoIGRvbid0IGFjayAxLjA/Cj4g
Pj4+Pj4+PiBZZXMsIGJ1dCBpdCdzIG5vdCBzb21ldGhpbmcgdGhhdCBpcyBpbnRyb2R1Y2VkIGlu
IHRoaXMKPiA+Pj4+Pj4+IGNvbW1pdC4gVGhlIGxlZ2FjeQo+ID4+Pj4+Pj4gZHJpdmVyIG5ldmVy
IHdvcmsgLi4uCj4gPj4+Pj4+IE15IHBvaW50IGlzIHRoaXMgbmVpdGhlciBmaXhlcyBvciBwcmV2
ZW50cyB0aGlzLgo+ID4+Pj4+Pgo+ID4+Pj4+PiBTbyBteSBzdWdnZXN0aW9uIGlzIHRvIGZpbmFs
bHkgYWRkIGlvY3RscyBhbG9uZyB0aGUgbGluZXMKPiA+Pj4+Pj4gb2YgUFJPVE9DT0xfRkVBVFVS
RVMgb2Ygdmhvc3QtdXNlci4KPiA+Pj4+Pj4KPiA+Pj4+Pj4gVGhlbiB0aGF0IG9uZSBjYW4gaGF2
ZSBiaXRzIGZvciBsZWdhY3kgbGUsIGxlZ2FjeSBiZSBhbmQgbW9kZXJuLgo+ID4+Pj4+Pgo+ID4+
Pj4+PiBCVFcgSSBsb29rZWQgYXQgdmhvc3QtdXNlciBhbmQgaXQgZG9lcyBub3QgbG9vayBsaWtl
IHRoYXQKPiA+Pj4+Pj4gaGFzIGEgc29sdXRpb24gZm9yIHRoaXMgcHJvYmxlbSBlaXRoZXIsIHJp
Z2h0Pwo+ID4+Pj4+IFJpZ2h0Lgo+ID4+Pj4+Cj4gPj4+Pj4KPiA+Pj4+Pj4+PiBOb3RlIDEuMCBh
ZmZlY3RzIHJpbmcgZW5kaWFubmVzcyB3aGljaCBpcyBub3QgbWVkaWF0ZWQgaW4gUUVNVQo+ID4+
Pj4+Pj4+IHNvIFFFTVUgY2FuJ3QgcHJldGVuZCB0byBkZXZpY2UgZ3Vlc3QgaXMgMS4wLgo+ID4+
Pj4+Pj4gUmlnaHQsIEkgcGxhbiB0byBzZW5kIHBhdGNoZXMgdG8gZG8gbWVkaWF0aW9uIGluIHRo
ZQo+ID4+Pj4+Pj4gUWVtdSB0byB1bmJyZWFrIGxlZ2FjeQo+ID4+Pj4+Pj4gZHJpdmVycy4KPiA+
Pj4+Pj4+Cj4gPj4+Pj4+PiBUaGFua3MKPiA+Pj4+Pj4gSSBmcmFua2x5IHRoaW5rIHdlJ2xsIG5l
ZWQgUFJPVE9DT0xfRkVBVFVSRVMgYW55d2F5LCBpdCdzCj4gPj4+Pj4+IHRvbyB1c2VmdWwgLi4u
Cj4gPj4+Pj4+IHNvIHdoeSBub3QgdGVhY2ggZHJpdmVycyBhYm91dCBpdCBhbmQgYmUgZG9uZSB3
aXRoIGl0PyBZb3UKPiA+Pj4+Pj4gY2FuJ3QgZW11bGF0ZQo+ID4+Pj4+PiBsZWdhY3kgb24gbW9k
ZXJuIGluIGEgY3Jvc3MgZW5kaWFuIHNpdHVhdGlvbiBiZWNhdXNlIG9mIHZyaW5nCj4gPj4+Pj4+
IGVuZGlhbi1uZXNzIC4uLgo+ID4+Pj4+IFNvIHRoZSBwcm9ibGVtIHN0aWxsLiBUaGlzIGNhbiBv
bmx5IHdvcmsgd2hlbiB0aGUgaGFyZHdhcmUgY2FuIHN1cHBvcnQKPiA+Pj4+PiBsZWdhY3kgdnJp
bmcgZW5kaWFuLW5lc3MuCj4gPj4+Pj4KPiA+Pj4+PiBDb25zaWRlcjoKPiA+Pj4+Pgo+ID4+Pj4+
IDEpIHRoZSBsZWFnY3kgZHJpdmVyIHN1cHBvcnQgaXMgbm9uLW5vcm1hdGl2ZSBpbiB0aGUgc3Bl
Ywo+ID4+Pj4+IDIpIHN1cHBvcnQgYSB0cmFuc2l0aW9uYWwgZGV2aWNlIGluIHRoZSBrZW5yZWwg
bWF5IHJlcXVpcmVzIHRoZQo+ID4+Pj4+IGhhcmR3YXJlCj4gPj4+Pj4gc3VwcG9ydCBhbmQgYSBi
dXJkZW4gb2Yga2VybmVsIGNvZGVzCj4gPj4+Pj4KPiA+Pj4+PiBJJ2QgcmF0aGVyIHNpbXBseSBk
cm9wIHRoZSBsZWdhY3kgZHJpdmVyIHN1cHBvcnQKPiA+Pj4+IE15IHBvaW50IGlzIHRoaXMgcGF0
Y2ggZG9lcyBub3QgZHJvcCBsZWdhY3kgc3VwcG9ydC4gSXQgbWVyZWx5IG1hbmRhdGVzCj4gPj4+
PiBtb2Rlcm4gc3VwcG9ydC4KPiA+Pj4KPiA+Pj4gSSBhbSBub3Qgc3VyZSBJIGdldCBoZXJlLiBU
aGlzIHBhdGNoIGZhaWxzIHRoZSBzZXRfZmVhdHVyZSBpZiBWRVJTSU9OXzEKPiA+Pj4gaXMgbm90
IG5lZ290aWF0ZWQuIFRoaXMgbWVhbnM6Cj4gPj4+Cj4gPj4+IDEpIHZEUEEgcHJlc2VudHMgYSBt
b2Rlcm4gZGV2aWNlIGluc3RlYWQgb2YgdHJhbnNpdG9uYWwgZGV2aWNlCj4gPj4+IDIpIGxlZ2Fj
eSBkcml2ZXIgY2FuJ3QgYmUgcHJvYmVkCj4gPj4+Cj4gPj4+IFdoYXQgSSdtIG1pc3Npbmc/Cj4g
Pj4KPiA+PiBIaSBNaWNoYWVsOgo+ID4+Cj4gPj4gRG8geW91IGFncmVlIHRvIGZpbmQgdGhlIHdh
eSB0byBwcmVzZW50IG1vZGVybiBkZXZpY2U/IFdlIG5lZWQgYQo+ID4+IGNvbmNsdXNpb24KPiA+
PiB0byBtYWtlIHRoZSBuZXRsaW5rIEFQSSB3b3JrIHRvIG1vdmUgZm9yd2FyZC4KPiA+Pgo+ID4+
IFRoYW5rcwo+ID4gSSB0aGluayB3ZSBuZWVkIGEgd2F5IHRvIHN1cHBvcnQgbGVnYWN5IHdpdGgg
bm8gZGF0YSBwYXRoIG92ZXJoZWFkLiBxZW11Cj4gPiBzZXR0aW5nIFZFUlNJT05fMSBmb3IgYSBs
ZWdhY3kgZ3Vlc3QgYWZmZWN0cyB0aGUgcmluZyBmb3JtYXQgc28gaXQgZG9lcwo+ID4gbm90IHJl
YWxseSB3b3JrLiBUaGlzIHNlZW1zIHRvIHJ1bGUgb3V0IGVtdWxhdGluZyBjb25maWcgc3BhY2Ug
ZW50aXJlbHkKPiA+IGluIHVzZXJzcGFjZS4KPiAKPiAKPiBTbyBJJ2QgcmF0aGVyIGRyb3AgdGhl
IGxlZ2FjeSBzdXBwb3J0IGluIHRoaXMgY2FzZS4gSXQgbmV2ZXIgd29yayBmb3IKPiB2RFBBIGlu
IHRoZSBwYXN0IGFuZCB2aXJ0aW8tdkRQQSBkb2Vzbid0IGV2ZW4gbmVlZCB0aGF0LiBOb3RlIHRo
YXQKPiBBQ0NFU1NfUExBVEZPUk0gaXMgbWFuZGF0ZWQgZm9yIGFsbCB0aGUgdkRQQSBwYXJlbnRz
IHJpZ2h0IG5vdyB3aGljaAo+IGltcGxpZXMgbW9kZXJuIGRldmljZSBhbmQgTEUuIEkgd29uZGVy
IHdoYXQncyB0aGUgdmFsdWUgZm9yIHN1cHBvcnRpbmcKPiBsZWdhY3kgaW4gdGhpcyBjYXNlIG9y
IGRvIHdlIHJlYWxseSBlbmNvdXJhZ2UgdmVuZG9ycyB0byBzaGlwIGNhcmQgd2l0aAo+IGxlZ2Fj
eSBzdXBwb3J0IChlLmcgZW5kaWFuIHN1cHBvcnQgaW4gdGhlIGhhcmR3YXJlKT8KCkhpIE1pY2hh
ZWw6CgpBbnkgdGhvdWdodHMgb24gdGhpcyBhcHByb2FjaD8KCk15IHVuZGVyc3RhbmRpbmcgaXMg
dGhhdCBkcm9wcGluZyBsZWdhY3kgc3VwcG9ydCB3aWxsIHNpbXBsaWZ5IGEgbG90IG9mIHN0dWZm
cy4KClRoYW5rcwoKCj4gCj4gCj4gPgo+ID4gU28gSSB0aGluayB3ZSBzaG91bGQgYWRkIGFuIGlv
Y3RsIGFsb25nIHRoZSBsaW5lcyBvZgo+ID4gcHJvdG9jb2wgZmVhdHVyZXMuIFRoZW4gSSB0aGlu
ayB3ZSBjYW4gcmVzZXJ2ZSBmZWF0dXJlIGJpdHMKPiA+IGZvciBjb25maWcgc3BhY2UgZm9ybWF0
OiBsZWdhY3kgTEUsIGxlZ2FjeSBCRSwgbW9kZXJuLgo+IAo+IAo+IFdlIGhhZCBWSE9TVF9TRVRf
VlJJTkdfRU5ESUFOIGJ1dCB0aGlzIHdpbGwgY29tcGxpY2F0ZXMgYm90aCB0aGUgdkRQQQo+IHBh
cmVudCBhbmQgbWFuYWdlbWVudC4gV2hhdCdzIG1vcmUgaW1wb3J0YW50LCBsZWdhY3kgYmVoYXZp
b3VyIGlzIG5vdAo+IHJlc3RyaWN0aWVkIGJ5IHRoZSBzcGVjLgo+IAo+IAo+ID4KPiA+IFF1ZXJ5
aW5nIHRoZSBmZWF0dXJlIGJpdHMgd2lsbCBwcm92aWRlIHVzIHdpdGggaW5mbyBhYm91dAo+ID4g
d2hhdCBkb2VzIHRoZSBkZXZpY2Ugc3VwcG9ydC4gQWNraW5nIHRoZW0gd2lsbCB0ZWxsIGRldmlj
ZQo+ID4gd2hhdCBkb2VzIGd1ZXN0IG5lZWQuCj4gCj4gCj4gSSB0aGluayB0aGlzIGNhbiB3b3Jr
LCBidXQgSSB3b25kZXIgaG93IG11Y2ggd2UgY2FuIGdhaW4gZnJvbSBzdWNoCj4gY29tcGxleGl0
aXkuCj4gCj4gVGhhbmtzCj4gCj4gCj4gPgo+ID4KPiA+Cj4gPgo+ID4KPiA+Pj4KPiA+Pj4+PiB0
byBoYXZlIGEgc2ltcGxlIGFuZCBlYXN5Cj4gPj4+Pj4gYWJzdGFyY3Rpb24gaW4gdGhlIGtlbnJl
bC4gRm9yIGxlZ2FjeSBkcml2ZXIgaW4gdGhlIGd1ZXN0LAo+ID4+Pj4+IGh5cGVydmlzb3IgaXMg
aW4KPiA+Pj4+PiBjaGFyZ2Ugb2YgdGhlIG1lZGlhdGlvbjoKPiA+Pj4+Pgo+ID4+Pj4+IDEpIGNv
bmZpZyBzcGFjZSBhY2Nlc3MgZW5kaWFuIGNvbnZlcnNpb24KPiA+Pj4+PiAyKSB1c2luZyBzaGFk
b3cgdmlydHF1ZXVlIHRvIGNoYW5nZSB0aGUgZW5kaWFuIGluIHRoZSB2cmluZwo+ID4+Pj4+Cj4g
Pj4+Pj4gVGhhbmtzCj4gPj4+PiBJJ2QgbGlrZSB0byBhdm9pZCBzaGFkb3cgdmlydHF1ZXVlIGhh
Y2tzIGlmIGF0IGFsbCBwb3NzaWJsZS4KPiA+Pj4+IExhc3QgSSBjaGVja2VkIHBlcmZvcm1hbmNl
IHdhc24ndCBtdWNoIGJldHRlciB0aGFuIGp1c3QgZW11bGF0aW5nCj4gPj4+PiB2aXJ0aW8gaW4g
c29mdHdhcmUuCj4gPj4+Cj4gPj4+IEkgdGhpbmsgdGhlIGxlZ2FjeSBkcml2ZXIgc3VwcG9ydCBp
cyBqdXN0IGEgbmljZSB0byBoYXZlLiBPciBkbyB5b3Ugc2VlCj4gPj4+IGFueSB2YWx1ZSB0byB0
aGF0PyBJIGd1ZXNzIGZvciBtZWxsYW5veCBhbmQgaW50ZWwsIG9ubHkgbW9kZXJuIGRldmljZSBp
cwo+ID4+PiBzdXBwb3J0ZWQgaW4gdGhlIGhhcmR3YXJlLgo+ID4+Pgo+ID4+PiBUaGFua3MKPiA+
Pj4KPiA+Pj4KPiA+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+IC0tLQo+ID4+Pj4+Pj4+
PiAgwqDCoMKgIGluY2x1ZGUvbGludXgvdmRwYS5oIHwgNiArKysrKysKPiA+Pj4+Pj4+Pj4gIMKg
wqDCoCAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+
Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRw
YS5oCj4gPj4+Pj4+Pj4+IGluZGV4IDBmZWZlYjk3Njg3Ny4uY2ZkZTRlYzk5OWI0IDEwMDY0NAo+
ID4+Pj4+Pj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4+Pj4+Pj4+PiArKysgYi9p
bmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4+Pj4+Pj4+PiBAQCAtNiw2ICs2LDcgQEAKPiA+Pj4+Pj4+
Pj4gIMKgwqDCoCAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+Cj4gPj4+Pj4+Pj4+ICDCoMKgwqAg
I2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgo+ID4+Pj4+Pj4+PiAgwqDCoMKgICNpbmNsdWRl
IDxsaW51eC92aG9zdF9pb3RsYi5oPgo+ID4+Pj4+Pj4+PiArI2luY2x1ZGUgPHVhcGkvbGludXgv
dmlydGlvX2NvbmZpZy5oPgo+ID4+Pj4+Pj4+PiAgwqDCoMKgIC8qKgo+ID4+Pj4+Pj4+PiAgwqDC
oMKgwqAgKiB2RFBBIGNhbGxiYWNrIGRlZmluaXRpb24uCj4gPj4+Pj4+Pj4+IEBAIC0zMTcsNiAr
MzE4LDExIEBAIHN0YXRpYyBpbmxpbmUgaW50Cj4gPj4+Pj4+Pj4+IHZkcGFfc2V0X2ZlYXR1cmVz
KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0Cj4gPj4+Pj4+Pj4+IGZlYXR1cmVzKQo+ID4+
Pj4+Pj4+PiAgwqDCoMKgIHsKPiA+Pj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29u
c3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ID4+Pj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgLyogTWFuZGF0aW5nIDEuMCB0byBoYXZlIHNlbWFudGljcyBvZgo+
ID4+Pj4+Pj4+PiBub3JtYXRpdmUgc3RhdGVtZW50cyBpbgo+ID4+Pj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoCAqIHRoZSBzcGVjLiAqLwo+ID4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCEo
ZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX1ZFUlNJT05fMSkpKQo+ID4+Pj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4gPj4+Pj4+Pj4+ICsKPiA+Pj4+Pj4+Pj4gIMKg
wqDCoMKgwqDCoMKgIHZkZXYtPmZlYXR1cmVzX3ZhbGlkID0gdHJ1ZTsKPiA+Pj4+Pj4+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG9wcy0+c2V0X2ZlYXR1cmVzKHZkZXYsIGZlYXR1
cmVzKTsKPiA+Pj4+Pj4+Pj4gIMKgwqDCoCB9Cj4gPj4+Pj4+Pj4+IC0tCj4gPj4+Pj4+Pj4+IDIu
MjUuMQo+IAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
