Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2BDC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 15:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E33BA40B4C;
	Tue, 26 Apr 2022 15:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bsRO5uwx3vIZ; Tue, 26 Apr 2022 15:47:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 69504408AE;
	Tue, 26 Apr 2022 15:47:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EF93C0039;
	Tue, 26 Apr 2022 15:47:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 935DBC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 15:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72C9B40B45
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 15:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vLpTqKo61HC3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 15:47:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA641408AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650988043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQyfBAK470BkIe91eWxfV625DXXdxAqPEYmtJsl5GSo=;
 b=a4GxUQx5eU2ubxGuSchFVXEBZ8e8U4uPY9J5ZcPJduLMoYclsOaZzYi8jR/Ox0xmYfjJ7G
 2wfu6MKagYCAfx1vGufPsPwFbcTpTL00sgBFVP0RS5VQb7nUFgDdt0lOZJjG5uWtGmqecB
 G9UBXSpWaCt25slbXdinC8jXXa0kguo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-UrofruDkPvq1p7pf4e_o-Q-1; Tue, 26 Apr 2022 11:47:19 -0400
X-MC-Unique: UrofruDkPvq1p7pf4e_o-Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AD258001EA;
 Tue, 26 Apr 2022 15:47:19 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FD6B54F8A1;
 Tue, 26 Apr 2022 15:47:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <20220425235415-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Tue, 26 Apr 2022 17:47:17 +0200
Message-ID: <87o80n7soq.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Cc: paulmck@kernel.org, lulu@redhat.com, peterz@infradead.org, maz@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>, eperezma@redhat.com, tglx@linutronix.de
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

T24gTW9uLCBBcHIgMjUgMjAyMiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29t
PiB3cm90ZToKCj4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTE6NTM6MjRQTSAtMDQwMCwgTWlj
aGFlbCBTLiBUc2lya2luIHdyb3RlOgo+PiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAxMTo0Mjo0
NUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiA+IAo+PiA+IOWcqCAyMDIyLzQvMjYgMTE6
MzgsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4+ID4gPiBPbiBNb24sIEFwciAyNSwgMjAy
MiBhdCAxMTozNTo0MVBNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+ID4gPiA+
IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDA0OjI5OjExQU0gKzAyMDAsIEhhbGlsIFBhc2ljIHdy
b3RlOgo+PiA+ID4gPiA+IE9uIE1vbiwgMjUgQXByIDIwMjIgMDk6NTk6NTUgLTA0MDAKPj4gPiA+
ID4gPiAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+PiA+ID4g
PiA+IAo+PiA+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTA6NTQ6MjRBTSArMDIw
MCwgQ29ybmVsaWEgSHVjayB3cm90ZToKPj4gPiA+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUgMjAy
MiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4gPiA+ID4g
PiA+ID4gPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAxMDo0NDoxNUFNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+PiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCB0cmllcyB0byBpbXBsZW1l
bnQgdGhlIHN5bmNocm9uaXplX2NicygpIGZvciBjY3cuIEZvciB0aGUKPj4gPiA+ID4gPiA+ID4g
PiA+IHZyaW5nX2ludGVycnVwdCgpIHRoYXQgaXMgY2FsbGVkIHZpYSB2aXJ0aW9fYWlycV9oYW5k
bGVyKCksIHRoZQo+PiA+ID4gPiA+ID4gPiA+ID4gc3luY2hyb25pemF0aW9uIGlzIHNpbXBseSBk
b25lIHZpYSB0aGUgYWlycV9pbmZvJ3MgbG9jay4gRm9yIHRoZQo+PiA+ID4gPiA+ID4gPiA+ID4g
dnJpbmdfaW50ZXJydXB0KCkgdGhhdCBpcyBjYWxsZWQgdmlhIHZpcnRpb19jY3dfaW50X2hhbmRs
ZXIoKSwgYSBwZXIKPj4gPiA+ID4gPiA+ID4gPiA+IGRldmljZSBzcGlubG9jayBmb3IgaXJxIGlz
IGludHJvZHVjZWQgYW5zIHVzZWQgaW4gdGhlIHN5bmNocm9uaXphdGlvbgo+PiA+ID4gPiA+ID4g
PiA+ID4gbWV0aG9kLgo+PiA+ID4gPiA+ID4gPiA+ID4gCj4+ID4gPiA+ID4gPiA+ID4gPiBDYzog
VGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+Cj4+ID4gPiA+ID4gPiA+ID4gPiBD
YzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPgo+PiA+ID4gPiA+ID4gPiA+
ID4gQ2M6ICJQYXVsIEUuIE1jS2VubmV5IiA8cGF1bG1ja0BrZXJuZWwub3JnPgo+PiA+ID4gPiA+
ID4gPiA+ID4gQ2M6IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+Cj4+ID4gPiA+ID4gPiA+
ID4gPiBDYzogSGFsaWwgUGFzaWMgPHBhc2ljQGxpbnV4LmlibS5jb20+Cj4+ID4gPiA+ID4gPiA+
ID4gPiBDYzogQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+Cj4+ID4gPiA+ID4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiA+
ID4gPiA+ID4gPiA+IAo+PiA+ID4gPiA+ID4gPiA+IFRoaXMgaXMgdGhlIG9ubHkgb25lIHRoYXQg
aXMgZ2l2aW5nIG1lIHBhdXNlLiBIYWxpbCwgQ29ybmVsaWEsCj4+ID4gPiA+ID4gPiA+ID4gc2hv
dWxkIHdlIGJlIGNvbmNlcm5lZCBhYm91dCB0aGUgcGVyZm9ybWFuY2UgaW1wYWN0IGhlcmU/Cj4+
ID4gPiA+ID4gPiA+ID4gQW55IGNoYW5jZSBpdCBjYW4gYmUgdGVzdGVkPwo+PiA+ID4gPiA+ID4g
PiBXZSBjYW4gaGF2ZSBhIGJ1bmNoIG9mIGRldmljZXMgdXNpbmcgdGhlIHNhbWUgYWlycSBzdHJ1
Y3R1cmUsIGFuZCB0aGUKPj4gPiA+ID4gPiA+ID4gc3luYyBjYiBjcmVhdGVzIGEgY2hva2UgcG9p
bnQsIHNhbWUgYXMgcmVnaXN0ZXJpbmcvdW5yZWdpc3RlcmluZy4KPj4gPiA+ID4gPiA+IEJUVyBj
YW4gY2FsbGJhY2tzIGZvciBtdWx0aXBsZSBWUXMgcnVuIG9uIG11bHRpcGxlIENQVXMgYXQgdGhl
IG1vbWVudD8KPj4gPiA+ID4gPiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBxdWVzdGlv
bi4KPj4gPiA+ID4gPiAKPj4gPiA+ID4gPiBJIGRvIHRoaW5rIHdlIGNhbiBoYXZlIG11bHRpcGxl
IENQVXMgdGhhdCBhcmUgZXhlY3V0aW5nIHNvbWUgcG9ydGlvbiBvZgo+PiA+ID4gPiA+IHZpcnRp
b19jY3dfaW50X2hhbmRsZXIoKS4gU28gSSBndWVzcyB0aGUgYW5zd2VyIGlzIHllcy4gQ29ubmll
IHdoYXQgZG8geW91IHRoaW5rPwo+PiA+ID4gPiA+IAo+PiA+ID4gPiA+IE9uIHRoZSBvdGhlciBo
YW5kIHdlIGNvdWxkIGFsc28gZW5kIHVwIHNlcmlhbGl6aW5nIHN5bmNocm9uaXplX2NicygpCj4+
ID4gPiA+ID4gY2FsbHMgZm9yIGRpZmZlcmVudCBkZXZpY2VzIGlmIHRoZXkgaGFwcGVuIHRvIHVz
ZSB0aGUgc2FtZSBhaXJxX2luZm8uIEJ1dAo+PiA+ID4gPiA+IHRoaXMgcHJvYmFibHkgd2FzIG5v
dCB5b3VyIHF1ZXN0aW9uCj4+ID4gPiA+IAo+PiA+ID4gPiBJIGFtIGxlc3MgY29uY2VybmVkIGFi
b3V0ICBzeW5jaHJvbml6ZV9jYnMgYmVpbmcgc2xvdyBhbmQgbW9yZSBhYm91dAo+PiA+ID4gPiB0
aGUgc2xvd2Rvd24gaW4gaW50ZXJydXB0IHByb2Nlc3NpbmcgaXRzZWxmLgo+PiA+ID4gPiAKPj4g
PiA+ID4gPiA+IHRoaXMgcGF0Y2ggc2VyaWFsaXplcyB0aGVtIG9uIGEgc3BpbmxvY2suCj4+ID4g
PiA+ID4gPiAKPj4gPiA+ID4gPiBUaG9zZSBjb3VsZCB0aGVuIHBpbGUgdXAgb24gdGhlIG5ld2x5
IGludHJvZHVjZWQgc3BpbmxvY2suCgpIb3cgYmFkIHdvdWxkIHRoYXQgYmUgaW4gcHJhY3RpY2U/
IElJVUMsIHdlIGhpdCBvbiB0aGUgc3BpbmxvY2sgd2hlbgotIGRvaW5nIHN5bmNocm9uaXplX2Ni
cyAoc2hvdWxkIGJlIHJhcmUpCi0gcHJvY2Vzc2luZyBxdWV1ZSBpbnRlcnJ1cHRzIGZvciBkZXZp
Y2VzIHVzaW5nIHBlci1kZXZpY2UgaW5kaWNhdG9ycwogICh3aGljaCBpcyB0aGUgbm9uLXByZWZl
cnJlZCBwYXRoLCB3aGljaCBJIHdvdWxkIGJhc2ljYWxseSBvbmx5IGV4cGVjdAogIHdoZW4gcnVu
bmluZyBvbiBhbiBhbmNpZW50IG9yIG5vbi1zdGFuZGFyZCBoeXBlcnZpc29yKQotIGNvbmZpZ3Vy
YXRpb24gY2hhbmdlIGludGVycnVwdHMgKHNob3VsZCBiZSByYXJlKQotIGR1cmluZyBzZXR1cCwg
cmVzZXQsIGV0Yy4gKHNob3VsZCBub3QgYmUgYSBjb25jZXJuKQoKPj4gPiA+ID4gPiAKPj4gPiA+
ID4gPiBSZWdhcmRzLAo+PiA+ID4gPiA+IEhhbGlsCj4+ID4gPiA+IEhtbSB5ZWEgLi4uIG5vdCBn
b29kLgo+PiA+ID4gSXMgdGhlcmUgYW55IG90aGVyIHdheSB0byBzeW5jaHJvbml6ZSB3aXRoIGFs
bCBjYWxsYmFja3M/Cj4+ID4gCj4+ID4gCj4+ID4gTWF5YmUgdXNpbmcgcndsb2NrIGFzIGFpcnEg
aGFuZGxlcj8KPj4gPiAKPj4gPiBUaGFua3MKPj4gPiAKPj4gCj4+IHJ3bG9jayBpcyBzdGlsbCBh
IHNoYXJlZCBjYWNoZWxpbmUgYm91bmNpbmcgYmV0d2VlbiBDUFVzIGFuZAo+PiBhIGJ1bmNoIG9m
IG9yZGVyaW5nIGluc3RydWN0aW9ucy4KPj4gTWF5YmUgc29tZXRoaW5nIHBlci1jcHUgKyBzb21l
IElQSXMgdG8gcnVuIHRoaW5ncyBvbiBhbGwgQ1BVcyBpbnN0ZWFkPwo+Cj4gLi4uIGFuZCBJIHRo
aW5rIGNsYXNzaWMgYW5kIGRldmljZSBpbnRlcnJ1cHRzIGFyZSBkaWZmZXJlbnQgZW5vdWdoCj4g
aGVyZSAuLi4KCllvdSBtZWFuIGNsYXNzaWMgKHBlci1kZXZpY2UpIGFuZCBhZGFwdGVyIGludGVy
cnVwdHMsIHJpZ2h0PwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
