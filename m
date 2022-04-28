Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5FAC433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 03:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49B7D827DE;
	Thu, 28 Apr 2022 03:05:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5nP2hl0mGb5J; Thu, 28 Apr 2022 03:05:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A604B82E9C;
	Thu, 28 Apr 2022 03:05:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CE2FC0039;
	Thu, 28 Apr 2022 03:05:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5293C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 03:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD37E60FAB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 03:04:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lJWxq4eA21DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 03:04:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A8E960EE7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 03:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651115095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OgA3nNFGu0ZJlClNUFtGsmDCNPSPF05lYQrtZKmYE0Q=;
 b=gTK2rRMol7FWrM0JeAv7kw/QBPuLdjF0MfuRw/evHGaCdNODgZH67fLPT9kEcLGFqMAIUy
 guQiSk8gXJ46sR08XGaS8ZIzAaLiUBv04t6y+4+9+cA65NfLYh8EOUvt10EO0GALgvsyl6
 UFKt42IZgPzlTRjWxUmqpA2I+h4hmfg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-pygatcgTP2CrSXE9w0_CkA-1; Wed, 27 Apr 2022 23:04:54 -0400
X-MC-Unique: pygatcgTP2CrSXE9w0_CkA-1
Received: by mail-lj1-f199.google.com with SMTP id
 o11-20020a2e90cb000000b0024f24265fcfso1403441ljg.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 20:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OgA3nNFGu0ZJlClNUFtGsmDCNPSPF05lYQrtZKmYE0Q=;
 b=dbPa0MIvrgfxuWjNKe5ShKUgTLyea+07TBjl1lang28ieJF4xv2jDykkGFzY3v7gdt
 O7S/mAe50WT6DSXTQxWRbNCeMBC8ldDjPlp4x/YgjBSjW9p7rbZ5fZD3SmrSZ9q8yg/V
 fV6KiuG0MlL9h3PBMgqunC4P7O5jjl3WBzouCODsEPHGXSeT9J1i9ogEMxFb9Gl6ZfvN
 mLNpP+aO0raetX+7G9P6hGyaXoHa2KuhhwWjfa+eV/p3KZ6CCt+yzzw3Fk2qUKX/rMzu
 rwfyBjCdqudth7pr0FwjwjRpxGdccEtG/rUtaAZmHif1ZjLz6fYUDrfY+mysrGrT+76d
 4q3A==
X-Gm-Message-State: AOAM530Wi28zk0ZpGT3IP3MvyHBQLihR+X1AfmFCLWE+I1PU8NhRbSyU
 iisli6cWuV33DNJ3lMEftN/yuG8yKE7Nst1uJqyVns1ghV0Jw6SQGm43Y+thzvza7aI5TmcJEFt
 j0F2q0sdHgCopejllDDpQ8nViRQYVKBYBhKgFZUS7fAusmJxiCN3IULYAMA==
X-Received: by 2002:a05:6512:a8f:b0:471:948b:9b6b with SMTP id
 m15-20020a0565120a8f00b00471948b9b6bmr22939945lfu.471.1651115092966; 
 Wed, 27 Apr 2022 20:04:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv318AyjnLP/y/hcTzOsn3aF+A+3WOw3SOPem9I7/1/ocqp0MGXggZvWaraT4bzvOsaKf2zYT8nNekp2BCIew=
X-Received: by 2002:a05:6512:a8f:b0:471:948b:9b6b with SMTP id
 m15-20020a0565120a8f00b00471948b9b6bmr22939923lfu.471.1651115092770; Wed, 27
 Apr 2022 20:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com> <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com> <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com> <20220428044315.3945e660.pasic@linux.ibm.com>
In-Reply-To: <20220428044315.3945e660.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Apr 2022 11:04:41 +0800
Message-ID: <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To: Halil Pasic <pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

T24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMTA6NDMgQU0gSGFsaWwgUGFzaWMgPHBhc2ljQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCAyNyBBcHIgMjAyMiAxMToyNzowMyArMDIwMAo+
IENvcm5lbGlhIEh1Y2sgPGNvaHVja0ByZWRoYXQuY29tPiB3cm90ZToKPgo+ID4gT24gVHVlLCBB
cHIgMjYgMjAyMiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToK
PiA+Cj4gPiA+IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDA1OjQ3OjE3UE0gKzAyMDAsIENvcm5l
bGlhIEh1Y2sgd3JvdGU6Cj4gPiA+PiBPbiBNb24sIEFwciAyNSAyMDIyLCAiTWljaGFlbCBTLiBU
c2lya2luIiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPj4KPiA+ID4+ID4gT24gTW9uLCBB
cHIgMjUsIDIwMjIgYXQgMTE6NTM6MjRQTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gPj4gPj4gT24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMTE6NDI6NDVBTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPiA+ID4+ID4+ID4KPiA+ID4+ID4+ID4g5ZyoIDIwMjIvNC8yNiAxMToz
OCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4+ID4+ID4gPiBPbiBNb24sIEFwciAy
NSwgMjAyMiBhdCAxMTozNTo0MVBNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4g
PiA+PiA+PiA+ID4gPiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAwNDoyOToxMUFNICswMjAwLCBI
YWxpbCBQYXNpYyB3cm90ZToKPiA+ID4+ID4+ID4gPiA+ID4gT24gTW9uLCAyNSBBcHIgMjAyMiAw
OTo1OTo1NSAtMDQwMAo+ID4gPj4gPj4gPiA+ID4gPiAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPj4gPj4gPiA+ID4gPgo+ID4gPj4gPj4gPiA+ID4gPiA+
IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDEwOjU0OjI0QU0gKzAyMDAsIENvcm5lbGlhIEh1Y2sg
d3JvdGU6Cj4gPiA+PiA+PiA+ID4gPiA+ID4gPiBPbiBNb24sIEFwciAyNSAyMDIyLCAiTWljaGFl
bCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPj4gPj4gPiA+ID4gPiA+
ID4gPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAxMDo0NDoxNUFNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggdHJpZXMgdG8gaW1w
bGVtZW50IHRoZSBzeW5jaHJvbml6ZV9jYnMoKSBmb3IgY2N3LiBGb3IgdGhlCj4gPiA+PiA+PiA+
ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0KCkgdGhhdCBpcyBjYWxsZWQgdmlhIHZpcnRp
b19haXJxX2hhbmRsZXIoKSwgdGhlCj4gPiA+PiA+PiA+ID4gPiA+ID4gPiA+ID4gc3luY2hyb25p
emF0aW9uIGlzIHNpbXBseSBkb25lIHZpYSB0aGUgYWlycV9pbmZvJ3MgbG9jay4gRm9yIHRoZQo+
ID4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+IHZyaW5nX2ludGVycnVwdCgpIHRoYXQgaXMgY2FsbGVk
IHZpYSB2aXJ0aW9fY2N3X2ludF9oYW5kbGVyKCksIGEgcGVyCj4gPiA+PiA+PiA+ID4gPiA+ID4g
PiA+ID4gZGV2aWNlIHNwaW5sb2NrIGZvciBpcnEgaXMgaW50cm9kdWNlZCBhbnMgdXNlZCBpbiB0
aGUgc3luY2hyb25pemF0aW9uCj4gPiA+PiA+PiA+ID4gPiA+ID4gPiA+ID4gbWV0aG9kLgo+ID4g
Pj4gPj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+PiA+PiA+ID4gPiA+ID4gPiA+ID4gQ2M6IFRob21h
cyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+ID4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+
IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+Cj4gPiA+PiA+PiA+ID4g
PiA+ID4gPiA+ID4gQ2M6ICJQYXVsIEUuIE1jS2VubmV5IiA8cGF1bG1ja0BrZXJuZWwub3JnPgo+
ID4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+IENjOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3Jn
Pgo+ID4gPj4gPj4gPiA+ID4gPiA+ID4gPiA+IENjOiBIYWxpbCBQYXNpYyA8cGFzaWNAbGludXgu
aWJtLmNvbT4KPiA+ID4+ID4+ID4gPiA+ID4gPiA+ID4gPiBDYzogQ29ybmVsaWEgSHVjayA8Y29o
dWNrQHJlZGhhdC5jb20+Cj4gPiA+PiA+PiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4+ID4+ID4gPiA+ID4gPiA+ID4K
PiA+ID4+ID4+ID4gPiA+ID4gPiA+ID4gVGhpcyBpcyB0aGUgb25seSBvbmUgdGhhdCBpcyBnaXZp
bmcgbWUgcGF1c2UuIEhhbGlsLCBDb3JuZWxpYSwKPiA+ID4+ID4+ID4gPiA+ID4gPiA+ID4gc2hv
dWxkIHdlIGJlIGNvbmNlcm5lZCBhYm91dCB0aGUgcGVyZm9ybWFuY2UgaW1wYWN0IGhlcmU/Cj4g
PiA+PiA+PiA+ID4gPiA+ID4gPiA+IEFueSBjaGFuY2UgaXQgY2FuIGJlIHRlc3RlZD8KPiA+ID4+
ID4+ID4gPiA+ID4gPiA+IFdlIGNhbiBoYXZlIGEgYnVuY2ggb2YgZGV2aWNlcyB1c2luZyB0aGUg
c2FtZSBhaXJxIHN0cnVjdHVyZSwgYW5kIHRoZQo+ID4gPj4gPj4gPiA+ID4gPiA+ID4gc3luYyBj
YiBjcmVhdGVzIGEgY2hva2UgcG9pbnQsIHNhbWUgYXMgcmVnaXN0ZXJpbmcvdW5yZWdpc3Rlcmlu
Zy4KPiA+ID4+ID4+ID4gPiA+ID4gPiBCVFcgY2FuIGNhbGxiYWNrcyBmb3IgbXVsdGlwbGUgVlFz
IHJ1biBvbiBtdWx0aXBsZSBDUFVzIGF0IHRoZSBtb21lbnQ/Cj4gPiA+PiA+PiA+ID4gPiA+IEkn
bSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhlIHF1ZXN0aW9uLgo+ID4gPj4gPj4gPiA+ID4gPgo+
ID4gPj4gPj4gPiA+ID4gPiBJIGRvIHRoaW5rIHdlIGNhbiBoYXZlIG11bHRpcGxlIENQVXMgdGhh
dCBhcmUgZXhlY3V0aW5nIHNvbWUgcG9ydGlvbiBvZgo+ID4gPj4gPj4gPiA+ID4gPiB2aXJ0aW9f
Y2N3X2ludF9oYW5kbGVyKCkuIFNvIEkgZ3Vlc3MgdGhlIGFuc3dlciBpcyB5ZXMuIENvbm5pZSB3
aGF0IGRvIHlvdSB0aGluaz8KPiA+ID4+ID4+ID4gPiA+ID4KPiA+ID4+ID4+ID4gPiA+ID4gT24g
dGhlIG90aGVyIGhhbmQgd2UgY291bGQgYWxzbyBlbmQgdXAgc2VyaWFsaXppbmcgc3luY2hyb25p
emVfY2JzKCkKPiA+ID4+ID4+ID4gPiA+ID4gY2FsbHMgZm9yIGRpZmZlcmVudCBkZXZpY2VzIGlm
IHRoZXkgaGFwcGVuIHRvIHVzZSB0aGUgc2FtZSBhaXJxX2luZm8uIEJ1dAo+ID4gPj4gPj4gPiA+
ID4gPiB0aGlzIHByb2JhYmx5IHdhcyBub3QgeW91ciBxdWVzdGlvbgo+ID4gPj4gPj4gPiA+ID4K
PiA+ID4+ID4+ID4gPiA+IEkgYW0gbGVzcyBjb25jZXJuZWQgYWJvdXQgIHN5bmNocm9uaXplX2Ni
cyBiZWluZyBzbG93IGFuZCBtb3JlIGFib3V0Cj4gPiA+PiA+PiA+ID4gPiB0aGUgc2xvd2Rvd24g
aW4gaW50ZXJydXB0IHByb2Nlc3NpbmcgaXRzZWxmLgo+ID4gPj4gPj4gPiA+ID4KPiA+ID4+ID4+
ID4gPiA+ID4gPiB0aGlzIHBhdGNoIHNlcmlhbGl6ZXMgdGhlbSBvbiBhIHNwaW5sb2NrLgo+ID4g
Pj4gPj4gPiA+ID4gPiA+Cj4gPiA+PiA+PiA+ID4gPiA+IFRob3NlIGNvdWxkIHRoZW4gcGlsZSB1
cCBvbiB0aGUgbmV3bHkgaW50cm9kdWNlZCBzcGlubG9jay4KPiA+ID4+Cj4gPiA+PiBIb3cgYmFk
IHdvdWxkIHRoYXQgYmUgaW4gcHJhY3RpY2U/IElJVUMsIHdlIGhpdCBvbiB0aGUgc3BpbmxvY2sg
d2hlbgo+ID4gPj4gLSBkb2luZyBzeW5jaHJvbml6ZV9jYnMgKHNob3VsZCBiZSByYXJlKQo+ID4g
Pj4gLSBwcm9jZXNzaW5nIHF1ZXVlIGludGVycnVwdHMgZm9yIGRldmljZXMgdXNpbmcgcGVyLWRl
dmljZSBpbmRpY2F0b3JzCj4gPiA+PiAgICh3aGljaCBpcyB0aGUgbm9uLXByZWZlcnJlZCBwYXRo
LCB3aGljaCBJIHdvdWxkIGJhc2ljYWxseSBvbmx5IGV4cGVjdAo+ID4gPj4gICB3aGVuIHJ1bm5p
bmcgb24gYW4gYW5jaWVudCBvciBub24tc3RhbmRhcmQgaHlwZXJ2aXNvcikKPiA+ID4KPiA+ID4g
dGhpcyBvbmUgaXMgbXkgY29uY2Vybi4gSSBhbSB3b3JyaWVkIHNlcmlhbGl6aW5nIGV2ZXJ5dGhp
bmcgb24gYSBzaW5nbGUgbG9jawo+ID4gPiB3aWxsIGRyYXN0aWNhbGx5IHJlZ3Jlc3MgcGVyZm9y
bWFuY2UgaGVyZS4KPiA+Cj4gPiBZZWFoLCB0aGF0IGNhc2UgY291bGQgZ2V0IG11Y2ggd29yc2Uu
IE9UT0gsIGhvdyBsaWtlbHkgaXMgaXQgdGhhdCBhbnkKPiA+IHNldHVwIHRoYXQgcnVucyBhIHJl
Y2VudCBrZXJuZWwgd2lsbCBhY3R1YWxseSBlbmQgdXAgd2l0aCBkZXZpY2VzIHVzaW5nCj4gPiBw
ZXItZGV2aWNlIGluZGljYXRvcnM/IEFueXRoaW5nIHJ1bm5pbmcgdW5kZXIgYSBRRU1VIHJlbGVh
c2VkIGluIHRoZQo+ID4gbGFzdCBjb3VwbGUgb2YgeWVhcnMgaXMgdW5saWtlbHkgdG8gbm90IHVz
ZSBhaXJxcywgSSB0aGluay4gSGFsaWwsIGRvCj4gPiB5b3UgdGhpbmsgdGhhdCB0aGUgY2xhc3Np
YyBpbmRpY2F0b3Igc2V0dXAgd291bGQgYmUgbW9yZSBjb21tb24gb24gYW55Cj4gPiBub24tUUVN
VSBoeXBlcnZpc29ycz8KPiA+Cj4KPiBJIHJlYWxseSBkb24ndCBrbm93LiBNeSBvcGluaW9uIGlz
IHRoYXQsIHR3byBzdGFnZXMgaW5kaWNhdG9ycyBhcmUga2luZAo+IG9mIHJlY29tbWVuZGVkIGZv
ciBhbnlib2R5IHdobyBjYXJlcyBhYm91dCBub3RpZmljYXRpb25zIHBlcmZvcm1hbmNlLgo+Cj4g
PiBJT1csIGhvdyBtdWNoIGVmZm9ydCBpcyBpdCB3b3J0aCBzcGVuZGluZyBvbiBvcHRpbWl6aW5n
IHRoaXMgY2FzZT8gV2UKPiA+IGNlcnRhaW5seSBzaG91bGQgZXhwbG9yZSBhbnkgc2ltcGxlIHNv
bHV0aW9ucywgYnV0IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZAo+ID4gdG8gdHdpc3Qgb3Vyc2VsdmVz
IGludG8gcHJldHplbHMgdG8gc29sdmUgaXQuCj4gPgo+Cj4gRnJhbmtseSwgSSB3b3VsZCBiZSBm
aW5lIHdpdGggYW4gcndsb2NrIGJhc2VkIHNvbHV0aW9uIGFzIHByb3Bvc2VkIGJ5Cj4gSmFzb24u
IE15IHJhdGlvbmFsZSBpczogd2UgcmVjb21tZW5kIHR3byBzdGFnZSBpbmRpY2F0b3JzLCBhbmQg
dGhlIHR3bwo+IHN0YWdlIGluZGljYXRvcnMgYXJlIGFscmVhZHkgZW5jdW1iZXJlZCBieSBhbiBy
d2xvY2sgb24gdGhlIGludGVycnVwdAo+IHBhdGguIFllcywgdGhlIGNvYWxlc2NlbmNlIG9mIGFk
YXB0ZXIgaW50ZXJydXB0cyBpcyBhcmNoaXRlY3R1cmFsbHkKPiBkaWZmZXJlbnQsIGFuZCBzbyBp
dCBpcyB3aXRoIEdJU0EgKHdpdGhvdXQgR0lTQSwgSSdtIG5vdCBldmVuIHN1cmUpLCBzbwo+IHRo
aXMgcndsb2NrIGVuZCB1cCBiZWluZyB3b3JzZSB0aGFuIHRoZSBvbmUgZm9yIDIgc3RhZ2UuIEJ1
dCBteSBmZWVsaW5nCj4gaXMsIHRoYXQgaXQgc2hvdWxkIGJlIGZpbmUuIE9uIHRoZSBvdGhlciBo
YW5kLCBJIGRvbid0IGZlZWwgY29tZm9ydGFibGUKPiB3aXRoIHBsYWluIHNwaW5sb2NrLCBhbmQg
SSBhbSBjdXJpb3VzIGFib3V0IGEgbW9yZSBhZHZhbmNlZCBzb2x1dGlvbi4KClllcywgSSdtIHRy
eWluZyB0byB1c2UgKFMpUkNVLCBsZXQncyBzZWUgaWYgaXQgd29ya3MuCgo+IEJ1dCBteSBndWVz
cyBpcyB0aGF0IHJ3bG9jayArIHNvbWUgdGVzdGluZyBmb3IgdGhlIGxlZ2FjeSBpbmRpY2F0b3Ig
Y2FzZQo+IGp1c3QgdG8gZG91YmxlIGNoZWNrIGlmIHRoZXJlIGlzIGEgaGVhdnkgcmVncmVzc2lv
biBkZXNwaXRlIG9mIG91cgo+IGV4cGVjdGF0aW9ucyB0byBzZWUgbm9uZSBzaG91bGQgZG8gdGhl
IHRyaWNrLgoKSSBzdWdnZXN0IHRoaXMsIHJ3bG9jayAoZm9yIG5vdCBhaXJxKSBzZWVtcyBiZXR0
ZXIgdGhhbiBzcGlubG9jaywgYnV0CmF0IHdvcnN0IGNhc2UgaXQgd2lsbCBjYXVzZSBjYWNoZSBs
aW5lIGJvdW5jaW5nLiBCdXQgSSB3b25kZXIgaWYgaXQncwpub3RpY2VhYmxlIChhbnlob3cgaXQg
aGFzIGJlZW4gdXNlZCBmb3IgYWlycSkuCgpUaGFua3MKCj4KPiBSZWdhcmRzLAo+IEhhbGlsCj4K
PiA+ID4KPiA+ID4KPiA+ID4+IC0gY29uZmlndXJhdGlvbiBjaGFuZ2UgaW50ZXJydXB0cyAoc2hv
dWxkIGJlIHJhcmUpCj4gPiA+PiAtIGR1cmluZyBzZXR1cCwgcmVzZXQsIGV0Yy4gKHNob3VsZCBu
b3QgYmUgYSBjb25jZXJuKQo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
