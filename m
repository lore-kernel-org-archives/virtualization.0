Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB4BC433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 06:29:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D6F8D4029B;
	Wed, 27 Apr 2022 06:29:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id esBX71etUKxp; Wed, 27 Apr 2022 06:29:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5FA8140017;
	Wed, 27 Apr 2022 06:29:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1767CC0032;
	Wed, 27 Apr 2022 06:29:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38918C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 06:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2EC594029B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 06:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wzS4P9m1dOaP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 06:29:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51ED540017
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 06:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651040947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZxvLlCVIbPp4swwXiDKmSMELQTP9l85QUsuRNDye7qY=;
 b=ixgaqSHzslEcPRHzYrQOtyVOZ5TTCh5rs/AHR/dIC9BfJkr2ZxZPhOhNkZrXlIF++d1tlD
 oea9XAX/GuY8hY7Z6oXKKbPe5tvXOVCHINxUMf5h+rgKfalYa+YEZZ9wE+jwVheoidee7R
 VoyVK2qOwOoObOcFZqhwdSoYZudZy2U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-Xw6BdfQhM0aNJKGL9EMOsw-1; Wed, 27 Apr 2022 02:29:06 -0400
X-MC-Unique: Xw6BdfQhM0aNJKGL9EMOsw-1
Received: by mail-wr1-f70.google.com with SMTP id
 h61-20020adf9043000000b002079bbaa5d3so337920wrh.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 23:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ZxvLlCVIbPp4swwXiDKmSMELQTP9l85QUsuRNDye7qY=;
 b=Nc1dX9Ke7/1CUXgO6iIKevKclVkZtzoDEf7D/DJgkWyhl530WdcwICHnVTNtXsGrw1
 LYSYyiw1KSAiH90UF5FodVjPX0vwkMZLUFj/hWyoummMPMScUNbW42l1yY+LiTsIKoV7
 2TsoECAAxvR0BDmYq6wrlEKoh438bq7PbkHM7M8NpbzOUy0iMMCTMbwbYe/WS6sEeh9r
 PdUdTPrWKbDT1ND2N2Whr4R0pW761N99/VGYYumFiLoN7GXhyL9xICj8jzCAD1weEOqN
 59BZyNGqbvZLfneqTDFXmApeHN1yu+H7hA6vR7Q3xaprjzrYTYwP05QzJlKj9DWPPWwH
 3LiQ==
X-Gm-Message-State: AOAM531OsL4r3NDE1ayXfwvNF8i8ZhoD813CWxiop+URP/w7vFreYpSb
 JxWENEJDyEP4Z1B1UE3ScT5JAlvVDcTwR1hVzn2dDFP8iw0fPj7GYD5S0mUJo0iwmEHkoIKYpbQ
 w9Wu8yvTj+zouRHPCPJF/hywS9VJ7vkuynkEt+fs7gg==
X-Received: by 2002:a05:6000:1acf:b0:20a:9c20:c769 with SMTP id
 i15-20020a0560001acf00b0020a9c20c769mr22279943wry.467.1651040945166; 
 Tue, 26 Apr 2022 23:29:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyIvazlULlqCBEf77oMMwcbw3dwk01MwREF6SF13p4XynswDJqRkL5C38HxCm1OcYfiqs1DQ==
X-Received: by 2002:a05:6000:1acf:b0:20a:9c20:c769 with SMTP id
 i15-20020a0560001acf00b0020a9c20c769mr22279929wry.467.1651040944951; 
 Tue, 26 Apr 2022 23:29:04 -0700 (PDT)
Received: from redhat.com ([2.53.18.16]) by smtp.gmail.com with ESMTPSA id
 m41-20020a05600c3b2900b00393e6f6c130sm850563wms.42.2022.04.26.23.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Apr 2022 23:29:03 -0700 (PDT)
Date: Wed, 27 Apr 2022 02:28:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220427022634-mutt-send-email-mst@kernel.org>
References: <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
 <20220426022420-mutt-send-email-mst@kernel.org>
 <CACGkMEtt8irvYVx482Zc4vkjtDANXFvUYHGFoCh=C-Xf3C2JUg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtt8irvYVx482Zc4vkjtDANXFvUYHGFoCh=C-Xf3C2JUg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

T24gV2VkLCBBcHIgMjcsIDIwMjIgYXQgMTE6NTM6MjVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAyOjMwIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDEy
OjA3OjM5UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgQXByIDI2LCAy
MDIyIGF0IDExOjU1IEFNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3Rl
Ogo+ID4gPiA+Cj4gPiA+ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTE6NTM6MjRQTSAtMDQw
MCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gT24gVHVlLCBBcHIgMjYsIDIw
MjIgYXQgMTE6NDI6NDVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4g5ZyoIDIwMjIvNC8yNiAxMTozOCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoK
PiA+ID4gPiA+ID4gPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAxMTozNTo0MVBNIC0wNDAwLCBN
aWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIEFwciAyNiwg
MjAyMiBhdCAwNDoyOToxMUFNICswMjAwLCBIYWxpbCBQYXNpYyB3cm90ZToKPiA+ID4gPiA+ID4g
PiA+ID4gT24gTW9uLCAyNSBBcHIgMjAyMiAwOTo1OTo1NSAtMDQwMAo+ID4gPiA+ID4gPiA+ID4g
PiAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDEwOjU0
OjI0QU0gKzAyMDAsIENvcm5lbGlhIEh1Y2sgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBP
biBNb24sIEFwciAyNSAyMDIyLCAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+
IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAx
MDo0NDoxNUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IFRoaXMgcGF0Y2ggdHJpZXMgdG8gaW1wbGVtZW50IHRoZSBzeW5jaHJvbml6ZV9jYnMoKSBm
b3IgY2N3LiBGb3IgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0
KCkgdGhhdCBpcyBjYWxsZWQgdmlhIHZpcnRpb19haXJxX2hhbmRsZXIoKSwgdGhlCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gc3luY2hyb25pemF0aW9uIGlzIHNpbXBseSBkb25lIHZpYSB0aGUg
YWlycV9pbmZvJ3MgbG9jay4gRm9yIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHZyaW5n
X2ludGVycnVwdCgpIHRoYXQgaXMgY2FsbGVkIHZpYSB2aXJ0aW9fY2N3X2ludF9oYW5kbGVyKCks
IGEgcGVyCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZGV2aWNlIHNwaW5sb2NrIGZvciBpcnEg
aXMgaW50cm9kdWNlZCBhbnMgdXNlZCBpbiB0aGUgc3luY2hyb25pemF0aW9uCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gbWV0aG9kLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRl
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6ICJQYXVsIEUuIE1jS2Vu
bmV5IiA8cGF1bG1ja0BrZXJuZWwub3JnPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IENjOiBN
YXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IENj
OiBIYWxpbCBQYXNpYyA8cGFzaWNAbGludXguaWJtLmNvbT4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBDYzogQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBp
cyB0aGUgb25seSBvbmUgdGhhdCBpcyBnaXZpbmcgbWUgcGF1c2UuIEhhbGlsLCBDb3JuZWxpYSwK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gc2hvdWxkIHdlIGJlIGNvbmNlcm5lZCBhYm91dCB0aGUg
cGVyZm9ybWFuY2UgaW1wYWN0IGhlcmU/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEFueSBjaGFu
Y2UgaXQgY2FuIGJlIHRlc3RlZD8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdlIGNhbiBoYXZlIGEg
YnVuY2ggb2YgZGV2aWNlcyB1c2luZyB0aGUgc2FtZSBhaXJxIHN0cnVjdHVyZSwgYW5kIHRoZQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gc3luYyBjYiBjcmVhdGVzIGEgY2hva2UgcG9pbnQsIHNhbWUg
YXMgcmVnaXN0ZXJpbmcvdW5yZWdpc3RlcmluZy4KPiA+ID4gPiA+ID4gPiA+ID4gPiBCVFcgY2Fu
IGNhbGxiYWNrcyBmb3IgbXVsdGlwbGUgVlFzIHJ1biBvbiBtdWx0aXBsZSBDUFVzIGF0IHRoZSBt
b21lbnQ/Cj4gPiA+ID4gPiA+ID4gPiA+IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhlIHF1
ZXN0aW9uLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBJIGRvIHRoaW5rIHdl
IGNhbiBoYXZlIG11bHRpcGxlIENQVXMgdGhhdCBhcmUgZXhlY3V0aW5nIHNvbWUgcG9ydGlvbiBv
Zgo+ID4gPiA+ID4gPiA+ID4gPiB2aXJ0aW9fY2N3X2ludF9oYW5kbGVyKCkuIFNvIEkgZ3Vlc3Mg
dGhlIGFuc3dlciBpcyB5ZXMuIENvbm5pZSB3aGF0IGRvIHlvdSB0aGluaz8KPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gT24gdGhlIG90aGVyIGhhbmQgd2UgY291bGQgYWxzbyBl
bmQgdXAgc2VyaWFsaXppbmcgc3luY2hyb25pemVfY2JzKCkKPiA+ID4gPiA+ID4gPiA+ID4gY2Fs
bHMgZm9yIGRpZmZlcmVudCBkZXZpY2VzIGlmIHRoZXkgaGFwcGVuIHRvIHVzZSB0aGUgc2FtZSBh
aXJxX2luZm8uIEJ1dAo+ID4gPiA+ID4gPiA+ID4gPiB0aGlzIHByb2JhYmx5IHdhcyBub3QgeW91
ciBxdWVzdGlvbgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEkgYW0gbGVzcyBjb25j
ZXJuZWQgYWJvdXQgIHN5bmNocm9uaXplX2NicyBiZWluZyBzbG93IGFuZCBtb3JlIGFib3V0Cj4g
PiA+ID4gPiA+ID4gPiB0aGUgc2xvd2Rvd24gaW4gaW50ZXJydXB0IHByb2Nlc3NpbmcgaXRzZWxm
Lgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiB0aGlzIHBhdGNoIHNlcmlhbGl6
ZXMgdGhlbSBvbiBhIHNwaW5sb2NrLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+IFRob3NlIGNvdWxkIHRoZW4gcGlsZSB1cCBvbiB0aGUgbmV3bHkgaW50cm9kdWNlZCBzcGlu
bG9jay4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gUmVnYXJkcywKPiA+ID4g
PiA+ID4gPiA+ID4gSGFsaWwKPiA+ID4gPiA+ID4gPiA+IEhtbSB5ZWEgLi4uIG5vdCBnb29kLgo+
ID4gPiA+ID4gPiA+IElzIHRoZXJlIGFueSBvdGhlciB3YXkgdG8gc3luY2hyb25pemUgd2l0aCBh
bGwgY2FsbGJhY2tzPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBNYXliZSB1
c2luZyByd2xvY2sgYXMgYWlycSBoYW5kbGVyPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFu
a3MKPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiByd2xvY2sgaXMgc3RpbGwgYSBzaGFy
ZWQgY2FjaGVsaW5lIGJvdW5jaW5nIGJldHdlZW4gQ1BVcyBhbmQKPiA+ID4gPiA+IGEgYnVuY2gg
b2Ygb3JkZXJpbmcgaW5zdHJ1Y3Rpb25zLgo+ID4gPgo+ID4gPiBZZXMsIGJ1dCBpdCBzaG91bGQg
YmUgZmFzdGVyIHRoYW4gc3BpbmxvY2tzIGFueWhvdy4KPiA+ID4KPiA+ID4gPiA+IE1heWJlIHNv
bWV0aGluZyBwZXItY3B1ICsgc29tZSBJUElzIHRvIHJ1biB0aGluZ3Mgb24gYWxsIENQVXMgaW5z
dGVhZD8KPiA+ID4KPiA+ID4gSXMgdGhpcyBzb21ldGhpbmcgbGlrZSBhIGN1c3RvbWl6ZWQgdmVy
c2lvbiBvZiBzeW5jaHJvbnppZV9yY3VfZXhwZWRpdGVkKCk/Cj4gPgo+ID4gV2l0aCBpbnRlcnJ1
cHRzIHJ1bm5pbmcgaW4gYW4gUkNVIHJlYWQgc2l6ZSBjcml0aWNhbCBzZWN0aW9uPwo+IAo+IEZv
ciB2cmluZ19pbnRlcnJ1cHQoKSwgeWVzLgo+IAo+IAo+ID4gUXVpdGUgcG9zc2libHkgdGhhdCBp
cyBhbHNvIGFuIG9wdGlvbi4KPiA+IFRoaXMgd2lsbCBuZWVkIGEgYnVuY2ggb2YgZG9jdW1lbnRh
dGlvbiBzaW5jZSB0aGlzIGlzIG5vdAo+ID4gYSBzdGFuZGFyZCB1c2Ugb2YgUkNVLAo+IAo+IEFj
Y29yZGluZyB0byBEb2N1bWVudGF0aW9uL1JDVS9yZXF1aXJlbWVudHMucnN0LCBpdCBsb29rcyBs
aWtlIGEgbGVnYWwgY2FzZToKPiAKPiAiCj4gVGhlIExpbnV4IGtlcm5lbCBoYXMgaW50ZXJydXB0
cywgYW5kIFJDVSByZWFkLXNpZGUgY3JpdGljYWwgc2VjdGlvbnMgYXJlCj4gbGVnYWwgd2l0aGlu
IGludGVycnVwdCBoYW5kbGVycyBhbmQgd2l0aGluIGludGVycnVwdC1kaXNhYmxlZCByZWdpb25z
IG9mCj4gY29kZSwgYXMgYXJlIGludm9jYXRpb25zIG9mIGNhbGxfcmN1KCkuCj4gIgo+IAo+IEFu
ZCBhcyBkaXNjdXNzZWQsIHN5bmNocm9uaXplX3JjdV9leHBlZGl0ZWQoKSBpcyBub3QgZnJpZW5k
bHkgdG8gcmVhbAo+IHRpbWUgd29ya2xvYWQuCgpJIGFtIG5vdCBzdXJlIGhvdHBsdWcgcmVtb3Zh
bCBpcyByZWxldmFudCBmb3IgcmVhbHRpbWUgYW55d2F5IHRob3VnaC4KCj4gSSB0aGluayB3ZSBj
YW4gc2ltcGx5Cj4gCj4gMSkgcHJvdGVjdCB2cmluZ19pbnRlcnJ1cHQoKSB3aXRoIHJjdV9yZWFk
X2xvY2soKQo+IDIpIHVzZSBzeW5jaHJvbml6ZV9yY3UoKSBpbiBzeW5jaHJvbml6ZV9jYnMgZm9y
IGNjdwo+IAo+IEFuZCBpZiB3ZSBjYXJlIGFib3V0IHRoZSBsb25nIGRlbGF5IHdlIGNhbiB1c2Ug
cGVyIGRldmljZSBzcmN1IHRvIHJlZHVjZSB0aGF0Pwo+IAo+IFRoYW5rcwoKTWF5YmUgLi4uCgo+
ID4gYW5kIHByb2JhYmx5IGdldCBhIGNvbmZpcm1hdGlvbgo+ID4gZnJvbSBSQ1UgbWFpbnRhaW5l
cnMgdGhhdCB3aGF0ZXZlciBhc3N1bXB0aW9ucyB3ZSBtYWtlCj4gPiBhcmUgZ3VhcmFudGVlZCB0
byBob2xkIGRvd24gdGhlIHJvYWQuCj4gPgo+ID4gPiA+Cj4gPiA+ID4gLi4uIGFuZCBJIHRoaW5r
IGNsYXNzaWMgYW5kIGRldmljZSBpbnRlcnJ1cHRzIGFyZSBkaWZmZXJlbnQgZW5vdWdoCj4gPiA+
ID4gaGVyZSAuLi4KPiA+ID4KPiA+ID4gWWVzLgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+
ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiAtLQo+ID4gPiA+ID4gPiA+ID4gTVNU
Cj4gPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
