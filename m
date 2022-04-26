Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C28C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 16:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B478141834;
	Tue, 26 Apr 2022 16:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r15cnVJzl-CC; Tue, 26 Apr 2022 16:43:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E8FB34182E;
	Tue, 26 Apr 2022 16:43:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B592EC0032;
	Tue, 26 Apr 2022 16:43:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 348D8C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 16:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1430641834
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 16:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1RNRZdeDTJq3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 16:43:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E645C4182E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650991426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AmBHiCcZSCU3IlknPjgefbwYr8sHQGYFZPAAiy3Pw/w=;
 b=AQSSwwqtSx4xI0pIWgvN+njfs7WzdXIK3VN/Ve1VplC1L7scYwazZIhMM6pa6Dpl5JN4SA
 n13odDxC/7CXIkdXrEIDvndV2Z1WpzD+mT8OJ95P2xdZUpbXCw2KrS961oyY1NrhCOHFoU
 BEKTZ1odqCnl4hvN46h/xO1GmWRzC9Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-345nIgeAMiWleGRK-MVLrg-1; Tue, 26 Apr 2022 12:43:43 -0400
X-MC-Unique: 345nIgeAMiWleGRK-MVLrg-1
Received: by mail-wm1-f72.google.com with SMTP id
 y11-20020a7bc18b000000b0038eac019fc0so1085250wmi.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 09:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AmBHiCcZSCU3IlknPjgefbwYr8sHQGYFZPAAiy3Pw/w=;
 b=JPreUkyDYTyFfJFD+gL47qvFA/Um2AuN9JiPisqrihFOFNRZ2DL4bff4gSgpNMtSO4
 8oYW1EbxO3RzKgI50/fE4OvVf471ql7xHALyIlLdz1bMsqjBS2ya+T+GDT2vf0fNjyY3
 7Blj4yL70XhZ2uFY94JVC8bC73ROyds+xIdbTtaYJdpd0TruUmSOK69t7bbZK22pFnvY
 +nCYg9OiXq5GHTuPCAzKEWMhCHQ+LXKeOAB2NPICiYW44VvNav8HzxLEgCl3GmtVEqmb
 pP7saGDtr/AgKYpDVrbnVHXD0ChYw9VXGNx9QJ+m9ATdzovGqT0eGHOtJ8LpqP6UtEL+
 wYGw==
X-Gm-Message-State: AOAM533U6IcPA8p2FR7qSwPAHCf0x124YAZV94ywNz3OBIueTp22/G7n
 j6JzcVWgE3HqrG4gVZ068WfROV1DRe/bkk+i9OQit7m1gj8o78H5EGqJtnwjz0UDuBt4SYqHvBR
 5YsbumvQmgMcOMj0oQ1Hb894siKJ2DcvkHcOtG+wbzw==
X-Received: by 2002:a05:6000:1789:b0:20a:9f94:1620 with SMTP id
 e9-20020a056000178900b0020a9f941620mr19657175wrg.640.1650991422039; 
 Tue, 26 Apr 2022 09:43:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfz8Pkmw51eFwJVdP+dK0w5CxNhoIuOiCngJvaJLdcwbMbc4dFPtCwPPtxxnWRU6Y78qqrvw==
X-Received: by 2002:a05:6000:1789:b0:20a:9f94:1620 with SMTP id
 e9-20020a056000178900b0020a9f941620mr19657161wrg.640.1650991421834; 
 Tue, 26 Apr 2022 09:43:41 -0700 (PDT)
Received: from redhat.com ([2.53.22.137]) by smtp.gmail.com with ESMTPSA id
 z6-20020a05600c0a0600b00393d831bf15sm10346194wmp.46.2022.04.26.09.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Apr 2022 09:43:41 -0700 (PDT)
Date: Tue, 26 Apr 2022 12:43:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220426124243-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <87o80n7soq.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMDU6NDc6MTdQTSArMDIwMCwgQ29ybmVsaWEgSHVjayB3
cm90ZToKPiBPbiBNb24sIEFwciAyNSAyMDIyLCAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJl
ZGhhdC5jb20+IHdyb3RlOgo+IAo+ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTE6NTM6MjRQ
TSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4+IE9uIFR1ZSwgQXByIDI2LCAy
MDIyIGF0IDExOjQyOjQ1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPj4gPiAKPiA+PiA+
IOWcqCAyMDIyLzQvMjYgMTE6MzgsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPj4gPiA+
IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDExOjM1OjQxUE0gLTA0MDAsIE1pY2hhZWwgUy4gVHNp
cmtpbiB3cm90ZToKPiA+PiA+ID4gPiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAwNDoyOToxMUFN
ICswMjAwLCBIYWxpbCBQYXNpYyB3cm90ZToKPiA+PiA+ID4gPiA+IE9uIE1vbiwgMjUgQXByIDIw
MjIgMDk6NTk6NTUgLTA0MDAKPiA+PiA+ID4gPiA+ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4gPiA+ID4gPiAKPiA+PiA+ID4gPiA+ID4gT24gTW9uLCBB
cHIgMjUsIDIwMjIgYXQgMTA6NTQ6MjRBTSArMDIwMCwgQ29ybmVsaWEgSHVjayB3cm90ZToKPiA+
PiA+ID4gPiA+ID4gPiBPbiBNb24sIEFwciAyNSAyMDIyLCAiTWljaGFlbCBTLiBUc2lya2luIiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUs
IDIwMjIgYXQgMTA6NDQ6MTVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+PiA+ID4gPiA+
ID4gPiA+ID4gVGhpcyBwYXRjaCB0cmllcyB0byBpbXBsZW1lbnQgdGhlIHN5bmNocm9uaXplX2Ni
cygpIGZvciBjY3cuIEZvciB0aGUKPiA+PiA+ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0
KCkgdGhhdCBpcyBjYWxsZWQgdmlhIHZpcnRpb19haXJxX2hhbmRsZXIoKSwgdGhlCj4gPj4gPiA+
ID4gPiA+ID4gPiA+IHN5bmNocm9uaXphdGlvbiBpcyBzaW1wbHkgZG9uZSB2aWEgdGhlIGFpcnFf
aW5mbydzIGxvY2suIEZvciB0aGUKPiA+PiA+ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0
KCkgdGhhdCBpcyBjYWxsZWQgdmlhIHZpcnRpb19jY3dfaW50X2hhbmRsZXIoKSwgYSBwZXIKPiA+
PiA+ID4gPiA+ID4gPiA+ID4gZGV2aWNlIHNwaW5sb2NrIGZvciBpcnEgaXMgaW50cm9kdWNlZCBh
bnMgdXNlZCBpbiB0aGUgc3luY2hyb25pemF0aW9uCj4gPj4gPiA+ID4gPiA+ID4gPiA+IG1ldGhv
ZC4KPiA+PiA+ID4gPiA+ID4gPiA+ID4gCj4gPj4gPiA+ID4gPiA+ID4gPiA+IENjOiBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPiA+PiA+ID4gPiA+ID4gPiA+ID4gQ2M6IFBl
dGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4KPiA+PiA+ID4gPiA+ID4gPiA+ID4g
Q2M6ICJQYXVsIEUuIE1jS2VubmV5IiA8cGF1bG1ja0BrZXJuZWwub3JnPgo+ID4+ID4gPiA+ID4g
PiA+ID4gPiBDYzogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4KPiA+PiA+ID4gPiA+ID4g
PiA+ID4gQ2M6IEhhbGlsIFBhc2ljIDxwYXNpY0BsaW51eC5pYm0uY29tPgo+ID4+ID4gPiA+ID4g
PiA+ID4gPiBDYzogQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+Cj4gPj4gPiA+ID4g
PiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
Cj4gPj4gPiA+ID4gPiA+ID4gPiAKPiA+PiA+ID4gPiA+ID4gPiA+IFRoaXMgaXMgdGhlIG9ubHkg
b25lIHRoYXQgaXMgZ2l2aW5nIG1lIHBhdXNlLiBIYWxpbCwgQ29ybmVsaWEsCj4gPj4gPiA+ID4g
PiA+ID4gPiBzaG91bGQgd2UgYmUgY29uY2VybmVkIGFib3V0IHRoZSBwZXJmb3JtYW5jZSBpbXBh
Y3QgaGVyZT8KPiA+PiA+ID4gPiA+ID4gPiA+IEFueSBjaGFuY2UgaXQgY2FuIGJlIHRlc3RlZD8K
PiA+PiA+ID4gPiA+ID4gPiBXZSBjYW4gaGF2ZSBhIGJ1bmNoIG9mIGRldmljZXMgdXNpbmcgdGhl
IHNhbWUgYWlycSBzdHJ1Y3R1cmUsIGFuZCB0aGUKPiA+PiA+ID4gPiA+ID4gPiBzeW5jIGNiIGNy
ZWF0ZXMgYSBjaG9rZSBwb2ludCwgc2FtZSBhcyByZWdpc3RlcmluZy91bnJlZ2lzdGVyaW5nLgo+
ID4+ID4gPiA+ID4gPiBCVFcgY2FuIGNhbGxiYWNrcyBmb3IgbXVsdGlwbGUgVlFzIHJ1biBvbiBt
dWx0aXBsZSBDUFVzIGF0IHRoZSBtb21lbnQ/Cj4gPj4gPiA+ID4gPiBJJ20gbm90IHN1cmUgSSB1
bmRlcnN0YW5kIHRoZSBxdWVzdGlvbi4KPiA+PiA+ID4gPiA+IAo+ID4+ID4gPiA+ID4gSSBkbyB0
aGluayB3ZSBjYW4gaGF2ZSBtdWx0aXBsZSBDUFVzIHRoYXQgYXJlIGV4ZWN1dGluZyBzb21lIHBv
cnRpb24gb2YKPiA+PiA+ID4gPiA+IHZpcnRpb19jY3dfaW50X2hhbmRsZXIoKS4gU28gSSBndWVz
cyB0aGUgYW5zd2VyIGlzIHllcy4gQ29ubmllIHdoYXQgZG8geW91IHRoaW5rPwo+ID4+ID4gPiA+
ID4gCj4gPj4gPiA+ID4gPiBPbiB0aGUgb3RoZXIgaGFuZCB3ZSBjb3VsZCBhbHNvIGVuZCB1cCBz
ZXJpYWxpemluZyBzeW5jaHJvbml6ZV9jYnMoKQo+ID4+ID4gPiA+ID4gY2FsbHMgZm9yIGRpZmZl
cmVudCBkZXZpY2VzIGlmIHRoZXkgaGFwcGVuIHRvIHVzZSB0aGUgc2FtZSBhaXJxX2luZm8uIEJ1
dAo+ID4+ID4gPiA+ID4gdGhpcyBwcm9iYWJseSB3YXMgbm90IHlvdXIgcXVlc3Rpb24KPiA+PiA+
ID4gPiAKPiA+PiA+ID4gPiBJIGFtIGxlc3MgY29uY2VybmVkIGFib3V0ICBzeW5jaHJvbml6ZV9j
YnMgYmVpbmcgc2xvdyBhbmQgbW9yZSBhYm91dAo+ID4+ID4gPiA+IHRoZSBzbG93ZG93biBpbiBp
bnRlcnJ1cHQgcHJvY2Vzc2luZyBpdHNlbGYuCj4gPj4gPiA+ID4gCj4gPj4gPiA+ID4gPiA+IHRo
aXMgcGF0Y2ggc2VyaWFsaXplcyB0aGVtIG9uIGEgc3BpbmxvY2suCj4gPj4gPiA+ID4gPiA+IAo+
ID4+ID4gPiA+ID4gVGhvc2UgY291bGQgdGhlbiBwaWxlIHVwIG9uIHRoZSBuZXdseSBpbnRyb2R1
Y2VkIHNwaW5sb2NrLgo+IAo+IEhvdyBiYWQgd291bGQgdGhhdCBiZSBpbiBwcmFjdGljZT8gSUlV
Qywgd2UgaGl0IG9uIHRoZSBzcGlubG9jayB3aGVuCj4gLSBkb2luZyBzeW5jaHJvbml6ZV9jYnMg
KHNob3VsZCBiZSByYXJlKQo+IC0gcHJvY2Vzc2luZyBxdWV1ZSBpbnRlcnJ1cHRzIGZvciBkZXZp
Y2VzIHVzaW5nIHBlci1kZXZpY2UgaW5kaWNhdG9ycwo+ICAgKHdoaWNoIGlzIHRoZSBub24tcHJl
ZmVycmVkIHBhdGgsIHdoaWNoIEkgd291bGQgYmFzaWNhbGx5IG9ubHkgZXhwZWN0Cj4gICB3aGVu
IHJ1bm5pbmcgb24gYW4gYW5jaWVudCBvciBub24tc3RhbmRhcmQgaHlwZXJ2aXNvcikKCnRoaXMg
b25lIGlzIG15IGNvbmNlcm4uIEkgYW0gd29ycmllZCBzZXJpYWxpemluZyBldmVyeXRoaW5nIG9u
IGEgc2luZ2xlIGxvY2sKd2lsbCBkcmFzdGljYWxseSByZWdyZXNzIHBlcmZvcm1hbmNlIGhlcmUu
CgoKPiAtIGNvbmZpZ3VyYXRpb24gY2hhbmdlIGludGVycnVwdHMgKHNob3VsZCBiZSByYXJlKQo+
IC0gZHVyaW5nIHNldHVwLCByZXNldCwgZXRjLiAoc2hvdWxkIG5vdCBiZSBhIGNvbmNlcm4pCj4g
Cj4gPj4gPiA+ID4gPiAKPiA+PiA+ID4gPiA+IFJlZ2FyZHMsCj4gPj4gPiA+ID4gPiBIYWxpbAo+
ID4+ID4gPiA+IEhtbSB5ZWEgLi4uIG5vdCBnb29kLgo+ID4+ID4gPiBJcyB0aGVyZSBhbnkgb3Ro
ZXIgd2F5IHRvIHN5bmNocm9uaXplIHdpdGggYWxsIGNhbGxiYWNrcz8KPiA+PiA+IAo+ID4+ID4g
Cj4gPj4gPiBNYXliZSB1c2luZyByd2xvY2sgYXMgYWlycSBoYW5kbGVyPwo+ID4+ID4gCj4gPj4g
PiBUaGFua3MKPiA+PiA+IAo+ID4+IAo+ID4+IHJ3bG9jayBpcyBzdGlsbCBhIHNoYXJlZCBjYWNo
ZWxpbmUgYm91bmNpbmcgYmV0d2VlbiBDUFVzIGFuZAo+ID4+IGEgYnVuY2ggb2Ygb3JkZXJpbmcg
aW5zdHJ1Y3Rpb25zLgo+ID4+IE1heWJlIHNvbWV0aGluZyBwZXItY3B1ICsgc29tZSBJUElzIHRv
IHJ1biB0aGluZ3Mgb24gYWxsIENQVXMgaW5zdGVhZD8KPiA+Cj4gPiAuLi4gYW5kIEkgdGhpbmsg
Y2xhc3NpYyBhbmQgZGV2aWNlIGludGVycnVwdHMgYXJlIGRpZmZlcmVudCBlbm91Z2gKPiA+IGhl
cmUgLi4uCj4gCj4gWW91IG1lYW4gY2xhc3NpYyAocGVyLWRldmljZSkgYW5kIGFkYXB0ZXIgaW50
ZXJydXB0cywgcmlnaHQ/CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
