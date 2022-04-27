Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F061CC433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 09:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 835AB60DC2;
	Wed, 27 Apr 2022 09:27:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G4FQ-V-UqUjy; Wed, 27 Apr 2022 09:27:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1C0BB60EB8;
	Wed, 27 Apr 2022 09:27:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0B36C0032;
	Wed, 27 Apr 2022 09:27:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F02CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 09:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CE4340616
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 09:27:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hu2PjhBlnSiI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 09:27:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55380404DA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 09:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651051628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qGWMCBS7P4p9HHcQpZOrDgCGlZCMIEG3/HVfnBnSLI=;
 b=eTRcZS3GItUNnYv5Q8g0NRq0qPbLwh/6zJPTUhtj1Fj6egmKN0PHZRr+5eTZHSbs5D0K08
 AKl6YSQn4Bkf4oHxcfv1SRAQZ3SOOW6NIr2ovyxYxtwzY89uZ2wwzRSPrMw/lpDwVnGPZg
 FaFmkmEiiV31kyQMfmoYDhC+IuAtznQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-T24G6uPfO7OewlqHwZ9_pA-1; Wed, 27 Apr 2022 05:27:05 -0400
X-MC-Unique: T24G6uPfO7OewlqHwZ9_pA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC1722999B53;
 Wed, 27 Apr 2022 09:27:04 +0000 (UTC)
Received: from localhost (dhcp-192-194.str.redhat.com [10.33.192.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD406C44AE9;
 Wed, 27 Apr 2022 09:27:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <20220426124243-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Wed, 27 Apr 2022 11:27:03 +0200
Message-ID: <87ilqu7u6w.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
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

T24gVHVlLCBBcHIgMjYgMjAyMiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29t
PiB3cm90ZToKCj4gT24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMDU6NDc6MTdQTSArMDIwMCwgQ29y
bmVsaWEgSHVjayB3cm90ZToKPj4gT24gTW9uLCBBcHIgMjUgMjAyMiwgIk1pY2hhZWwgUy4gVHNp
cmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4gCj4+ID4gT24gTW9uLCBBcHIgMjUsIDIw
MjIgYXQgMTE6NTM6MjRQTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+PiA+PiBP
biBUdWUsIEFwciAyNiwgMjAyMiBhdCAxMTo0Mjo0NUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+PiA+PiA+IAo+PiA+PiA+IOWcqCAyMDIyLzQvMjYgMTE6MzgsIE1pY2hhZWwgUy4gVHNpcmtp
biDlhpnpgZM6Cj4+ID4+ID4gPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAxMTozNTo0MVBNIC0w
NDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+ID4+ID4gPiA+IE9uIFR1ZSwgQXByIDI2
LCAyMDIyIGF0IDA0OjI5OjExQU0gKzAyMDAsIEhhbGlsIFBhc2ljIHdyb3RlOgo+PiA+PiA+ID4g
PiA+IE9uIE1vbiwgMjUgQXByIDIwMjIgMDk6NTk6NTUgLTA0MDAKPj4gPj4gPiA+ID4gPiAiTWlj
aGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+PiA+PiA+ID4gPiA+IAo+
PiA+PiA+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTA6NTQ6MjRBTSArMDIwMCwg
Q29ybmVsaWEgSHVjayB3cm90ZToKPj4gPj4gPiA+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUgMjAy
MiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4gPj4gPiA+
ID4gPiA+ID4gPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAxMDo0NDoxNUFNICswODAwLCBKYXNv
biBXYW5nIHdyb3RlOgo+PiA+PiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCB0cmllcyB0byBp
bXBsZW1lbnQgdGhlIHN5bmNocm9uaXplX2NicygpIGZvciBjY3cuIEZvciB0aGUKPj4gPj4gPiA+
ID4gPiA+ID4gPiA+IHZyaW5nX2ludGVycnVwdCgpIHRoYXQgaXMgY2FsbGVkIHZpYSB2aXJ0aW9f
YWlycV9oYW5kbGVyKCksIHRoZQo+PiA+PiA+ID4gPiA+ID4gPiA+ID4gc3luY2hyb25pemF0aW9u
IGlzIHNpbXBseSBkb25lIHZpYSB0aGUgYWlycV9pbmZvJ3MgbG9jay4gRm9yIHRoZQo+PiA+PiA+
ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0KCkgdGhhdCBpcyBjYWxsZWQgdmlhIHZpcnRp
b19jY3dfaW50X2hhbmRsZXIoKSwgYSBwZXIKPj4gPj4gPiA+ID4gPiA+ID4gPiA+IGRldmljZSBz
cGlubG9jayBmb3IgaXJxIGlzIGludHJvZHVjZWQgYW5zIHVzZWQgaW4gdGhlIHN5bmNocm9uaXph
dGlvbgo+PiA+PiA+ID4gPiA+ID4gPiA+ID4gbWV0aG9kLgo+PiA+PiA+ID4gPiA+ID4gPiA+ID4g
Cj4+ID4+ID4gPiA+ID4gPiA+ID4gPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+Cj4+ID4+ID4gPiA+ID4gPiA+ID4gPiBDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPgo+PiA+PiA+ID4gPiA+ID4gPiA+ID4gQ2M6ICJQYXVsIEUuIE1jS2VubmV5
IiA8cGF1bG1ja0BrZXJuZWwub3JnPgo+PiA+PiA+ID4gPiA+ID4gPiA+ID4gQ2M6IE1hcmMgWnlu
Z2llciA8bWF6QGtlcm5lbC5vcmc+Cj4+ID4+ID4gPiA+ID4gPiA+ID4gPiBDYzogSGFsaWwgUGFz
aWMgPHBhc2ljQGxpbnV4LmlibS5jb20+Cj4+ID4+ID4gPiA+ID4gPiA+ID4gPiBDYzogQ29ybmVs
aWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+Cj4+ID4+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiA+PiA+ID4gPiA+ID4g
PiA+IAo+PiA+PiA+ID4gPiA+ID4gPiA+IFRoaXMgaXMgdGhlIG9ubHkgb25lIHRoYXQgaXMgZ2l2
aW5nIG1lIHBhdXNlLiBIYWxpbCwgQ29ybmVsaWEsCj4+ID4+ID4gPiA+ID4gPiA+ID4gc2hvdWxk
IHdlIGJlIGNvbmNlcm5lZCBhYm91dCB0aGUgcGVyZm9ybWFuY2UgaW1wYWN0IGhlcmU/Cj4+ID4+
ID4gPiA+ID4gPiA+ID4gQW55IGNoYW5jZSBpdCBjYW4gYmUgdGVzdGVkPwo+PiA+PiA+ID4gPiA+
ID4gPiBXZSBjYW4gaGF2ZSBhIGJ1bmNoIG9mIGRldmljZXMgdXNpbmcgdGhlIHNhbWUgYWlycSBz
dHJ1Y3R1cmUsIGFuZCB0aGUKPj4gPj4gPiA+ID4gPiA+ID4gc3luYyBjYiBjcmVhdGVzIGEgY2hv
a2UgcG9pbnQsIHNhbWUgYXMgcmVnaXN0ZXJpbmcvdW5yZWdpc3RlcmluZy4KPj4gPj4gPiA+ID4g
PiA+IEJUVyBjYW4gY2FsbGJhY2tzIGZvciBtdWx0aXBsZSBWUXMgcnVuIG9uIG11bHRpcGxlIENQ
VXMgYXQgdGhlIG1vbWVudD8KPj4gPj4gPiA+ID4gPiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5k
IHRoZSBxdWVzdGlvbi4KPj4gPj4gPiA+ID4gPiAKPj4gPj4gPiA+ID4gPiBJIGRvIHRoaW5rIHdl
IGNhbiBoYXZlIG11bHRpcGxlIENQVXMgdGhhdCBhcmUgZXhlY3V0aW5nIHNvbWUgcG9ydGlvbiBv
Zgo+PiA+PiA+ID4gPiA+IHZpcnRpb19jY3dfaW50X2hhbmRsZXIoKS4gU28gSSBndWVzcyB0aGUg
YW5zd2VyIGlzIHllcy4gQ29ubmllIHdoYXQgZG8geW91IHRoaW5rPwo+PiA+PiA+ID4gPiA+IAo+
PiA+PiA+ID4gPiA+IE9uIHRoZSBvdGhlciBoYW5kIHdlIGNvdWxkIGFsc28gZW5kIHVwIHNlcmlh
bGl6aW5nIHN5bmNocm9uaXplX2NicygpCj4+ID4+ID4gPiA+ID4gY2FsbHMgZm9yIGRpZmZlcmVu
dCBkZXZpY2VzIGlmIHRoZXkgaGFwcGVuIHRvIHVzZSB0aGUgc2FtZSBhaXJxX2luZm8uIEJ1dAo+
PiA+PiA+ID4gPiA+IHRoaXMgcHJvYmFibHkgd2FzIG5vdCB5b3VyIHF1ZXN0aW9uCj4+ID4+ID4g
PiA+IAo+PiA+PiA+ID4gPiBJIGFtIGxlc3MgY29uY2VybmVkIGFib3V0ICBzeW5jaHJvbml6ZV9j
YnMgYmVpbmcgc2xvdyBhbmQgbW9yZSBhYm91dAo+PiA+PiA+ID4gPiB0aGUgc2xvd2Rvd24gaW4g
aW50ZXJydXB0IHByb2Nlc3NpbmcgaXRzZWxmLgo+PiA+PiA+ID4gPiAKPj4gPj4gPiA+ID4gPiA+
IHRoaXMgcGF0Y2ggc2VyaWFsaXplcyB0aGVtIG9uIGEgc3BpbmxvY2suCj4+ID4+ID4gPiA+ID4g
PiAKPj4gPj4gPiA+ID4gPiBUaG9zZSBjb3VsZCB0aGVuIHBpbGUgdXAgb24gdGhlIG5ld2x5IGlu
dHJvZHVjZWQgc3BpbmxvY2suCj4+IAo+PiBIb3cgYmFkIHdvdWxkIHRoYXQgYmUgaW4gcHJhY3Rp
Y2U/IElJVUMsIHdlIGhpdCBvbiB0aGUgc3BpbmxvY2sgd2hlbgo+PiAtIGRvaW5nIHN5bmNocm9u
aXplX2NicyAoc2hvdWxkIGJlIHJhcmUpCj4+IC0gcHJvY2Vzc2luZyBxdWV1ZSBpbnRlcnJ1cHRz
IGZvciBkZXZpY2VzIHVzaW5nIHBlci1kZXZpY2UgaW5kaWNhdG9ycwo+PiAgICh3aGljaCBpcyB0
aGUgbm9uLXByZWZlcnJlZCBwYXRoLCB3aGljaCBJIHdvdWxkIGJhc2ljYWxseSBvbmx5IGV4cGVj
dAo+PiAgIHdoZW4gcnVubmluZyBvbiBhbiBhbmNpZW50IG9yIG5vbi1zdGFuZGFyZCBoeXBlcnZp
c29yKQo+Cj4gdGhpcyBvbmUgaXMgbXkgY29uY2Vybi4gSSBhbSB3b3JyaWVkIHNlcmlhbGl6aW5n
IGV2ZXJ5dGhpbmcgb24gYSBzaW5nbGUgbG9jawo+IHdpbGwgZHJhc3RpY2FsbHkgcmVncmVzcyBw
ZXJmb3JtYW5jZSBoZXJlLgoKWWVhaCwgdGhhdCBjYXNlIGNvdWxkIGdldCBtdWNoIHdvcnNlLiBP
VE9ILCBob3cgbGlrZWx5IGlzIGl0IHRoYXQgYW55CnNldHVwIHRoYXQgcnVucyBhIHJlY2VudCBr
ZXJuZWwgd2lsbCBhY3R1YWxseSBlbmQgdXAgd2l0aCBkZXZpY2VzIHVzaW5nCnBlci1kZXZpY2Ug
aW5kaWNhdG9ycz8gQW55dGhpbmcgcnVubmluZyB1bmRlciBhIFFFTVUgcmVsZWFzZWQgaW4gdGhl
Cmxhc3QgY291cGxlIG9mIHllYXJzIGlzIHVubGlrZWx5IHRvIG5vdCB1c2UgYWlycXMsIEkgdGhp
bmsuIEhhbGlsLCBkbwp5b3UgdGhpbmsgdGhhdCB0aGUgY2xhc3NpYyBpbmRpY2F0b3Igc2V0dXAg
d291bGQgYmUgbW9yZSBjb21tb24gb24gYW55Cm5vbi1RRU1VIGh5cGVydmlzb3JzPwoKSU9XLCBo
b3cgbXVjaCBlZmZvcnQgaXMgaXQgd29ydGggc3BlbmRpbmcgb24gb3B0aW1pemluZyB0aGlzIGNh
c2U/IFdlCmNlcnRhaW5seSBzaG91bGQgZXhwbG9yZSBhbnkgc2ltcGxlIHNvbHV0aW9ucywgYnV0
IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZAp0byB0d2lzdCBvdXJzZWx2ZXMgaW50byBwcmV0emVscyB0
byBzb2x2ZSBpdC4KCj4KPgo+PiAtIGNvbmZpZ3VyYXRpb24gY2hhbmdlIGludGVycnVwdHMgKHNo
b3VsZCBiZSByYXJlKQo+PiAtIGR1cmluZyBzZXR1cCwgcmVzZXQsIGV0Yy4gKHNob3VsZCBub3Qg
YmUgYSBjb25jZXJuKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
