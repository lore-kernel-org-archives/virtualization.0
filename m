Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05070C76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 06:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19AB540293;
	Tue, 28 Mar 2023 06:08:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19AB540293
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fytJUEWA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W9PMlCnWVkwK; Tue, 28 Mar 2023 06:08:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F024D4015D;
	Tue, 28 Mar 2023 06:08:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F024D4015D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC7FBC0037;
	Tue, 28 Mar 2023 06:08:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29E76C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1035D417E8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:08:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1035D417E8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qkYRUQSzLPFc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:08:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C516141763
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C516141763
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679983681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0Vc6MylE0cQeMrB6SHC1KjX7fRlexD9+rdnaEldCZQ=;
 b=fytJUEWAwZxuIa4YkjnwYCzCfbRwShPeaQgwF/tvgMiRa1b5ss9ESjebglE4w2+tPjYZZf
 ELPD/2pQUys7zw4zZ36YWBrvPVKa9VMdu6V2VpteTGqQdtqNOxL9QEhUqmfOcwRHKx/Eim
 AjX6TIpLygN7mz2g4nvlqNxbnU6dXiI=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-vkOAcOoTOd2VLZyBCwCOFw-1; Tue, 28 Mar 2023 02:07:57 -0400
X-MC-Unique: vkOAcOoTOd2VLZyBCwCOFw-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-177b0f40c4eso6232565fac.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 23:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679983676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j0Vc6MylE0cQeMrB6SHC1KjX7fRlexD9+rdnaEldCZQ=;
 b=yL4AeqaO16EBSLEectuXI+4hbIJwmf4CU5U/juAWtmIu37g5SLjFXNbNzxx57/u84q
 +WlpZvzLSqA8+Al26D3Uxh0nWjymtHKgCBdvuvNFZluieGKOs4JHFOS8aDq4YCB0e99o
 4qKQxj3M9YQeh1cQ5M8YrW+hFDpKjHSPh5EwCP0k/XOXbcokg5d7BevUEoA06tk0i86W
 PfDu/k9FlpI8cVGzVYC4PYOpJoTlal3i0g+rdUxI9YWj8/km/rBiBT12wcMX3WvPNefM
 YnSDoMNDPCNeG3bonXV1Nb4mebvBvjLHeJQiZtgpbP/qxZNWzs5cQuScPa4w7Ec5hiUt
 W9Pg==
X-Gm-Message-State: AAQBX9eu14DFqWIcJccJtkhF59Fp8ZPruuws1ppbKsvpugyijgV7sCZv
 LRnBZoRJ5NSaIwsIh9cbCZlgHZi94O8UCd3EYp6xAo0mDCHPaWfe6b6PuT5acYVBDcZF75iSh6v
 vALweFDNo7ipbbudJqXqI3WNHaLUwL8B3SC9gViyOM80+5bM2kW6I7PU0CA==
X-Received: by 2002:a05:6808:f12:b0:389:4edd:deb8 with SMTP id
 m18-20020a0568080f1200b003894edddeb8mr741857oiw.9.1679983676294; 
 Mon, 27 Mar 2023 23:07:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350byREbJffOwxc746aJJUIjiY3s4O20O5cWDp8FTjfHkZLNpHWRedA1rifb7FpV0bXF4S8vgyh9U9DMpp9Gxv7w=
X-Received: by 2002:a05:6808:f12:b0:389:4edd:deb8 with SMTP id
 m18-20020a0568080f1200b003894edddeb8mr741851oiw.9.1679983676036; Mon, 27 Mar
 2023 23:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
 <CACycT3sm1P2qDQTNKp+RLmyd84+v8xwErf_g1SXqiaJDQO8LNg@mail.gmail.com>
 <CACGkMEvhXQ9ve4DQnmVu4hRRbCWM3oesR-=KaLisuyJ4-tyQxg@mail.gmail.com>
 <CACycT3uYbnrQDDbFmwdww8ukMU1t9RsAuutHsFT-UzK9_Mc=Kg@mail.gmail.com>
 <CACGkMEtRU3qeMazJ2j3u_RC1bUga75Oix0jRJeUJBUF=8QJMgQ@mail.gmail.com>
 <CACycT3vCqisBS0OyMsnyrw0i6kWTDqSZ4GQbdoycHz-L3=1Q7Q@mail.gmail.com>
In-Reply-To: <CACycT3vCqisBS0OyMsnyrw0i6kWTDqSZ4GQbdoycHz-L3=1Q7Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Mar 2023 14:07:44 +0800
Message-ID: <CACGkMEvAUPakxFEuZPTGTQXwkhoTsU+hwdnjeV-vzGRFK1Qygg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
To: Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMTI6MDXigK9QTSBZb25namkgWGllIDx4aWV5b25namlA
Ynl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIE1hciAyOCwgMjAyMyBhdCAxMTo0NOKA
r0FNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1
ZSwgTWFyIDI4LCAyMDIzIGF0IDExOjMz4oCvQU0gWW9uZ2ppIFhpZSA8eGlleW9uZ2ppQGJ5dGVk
YW5jZS5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBUdWUsIE1hciAyOCwgMjAyMyBhdCAxMTox
NOKAr0FNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4g
PiA+ID4gT24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMTE6MDPigK9BTSBZb25namkgWGllIDx4aWV5
b25namlAYnl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gRnJpLCBN
YXIgMjQsIDIwMjMgYXQgMjoyOOKAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPbiBUaHUsIE1hciAyMywgMjAyMyBhdCAx
OjMx4oCvUE0gWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+IHdyb3RlOgo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVG8gc3VwcG9ydCBpbnRlcnJ1cHQgYWZmaW5pdHkgc3By
ZWFkaW5nIG1lY2hhbmlzbSwKPiA+ID4gPiA+ID4gPiB0aGlzIG1ha2VzIHVzZSBvZiBncm91cF9j
cHVzX2V2ZW5seSgpIHRvIGNyZWF0ZQo+ID4gPiA+ID4gPiA+IGFuIGlycSBjYWxsYmFjayBhZmZp
bml0eSBtYXNrIGZvciBlYWNoIHZpcnRxdWV1ZQo+ID4gPiA+ID4gPiA+IG9mIHZkcGEgZGV2aWNl
LiBUaGVuIHdlIHdpbGwgdW5pZnkgc2V0X3ZxX2FmZmluaXR5Cj4gPiA+ID4gPiA+ID4gY2FsbGJh
Y2sgdG8gcGFzcyB0aGUgYWZmaW5pdHkgdG8gdGhlIHZkcGEgZGV2aWNlIGRyaXZlci4KPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdq
aUBieXRlZGFuY2UuY29tPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGlua2luZyBoYXJkIG9m
IGFsbCB0aGUgbG9naWNzLCBJIHRoaW5rIEkndmUgZm91bmQgc29tZXRoaW5nIGludGVyZXN0aW5n
Lgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBDb21taXQgYWQ3MTQ3M2Q5YzQzNyAoInZpcnRpb19i
bGs6IHVzZSB2aXJ0aW8gSVJRIGFmZmluaXR5IikgdHJpZXMgdG8KPiA+ID4gPiA+ID4gcGFzcyBp
cnFfYWZmaW5pdHkgdG8gdHJhbnNwb3J0IHNwZWNpZmljIGZpbmRfdnFzKCkuICBUaGlzIHNlZW1z
IGEKPiA+ID4gPiA+ID4gbGF5ZXIgdmlvbGF0aW9uIHNpbmNlIGRyaXZlciBoYXMgbm8ga25vd2xl
ZGdlIG9mCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IDEpIHdoZXRoZXIgb3Igbm90IHRoZSBjYWxs
YmFjayBpcyBiYXNlZCBvbiBhbiBJUlEKPiA+ID4gPiA+ID4gMikgd2hldGhlciBvciBub3QgdGhl
IGRldmljZSBpcyBhIFBDSSBvciBub3QgKHRoZSBkZXRhaWxzIGFyZSBoaWRlZCBieQo+ID4gPiA+
ID4gPiB0aGUgdHJhbnNwb3J0IGRyaXZlcikKPiA+ID4gPiA+ID4gMykgaG93IG1hbnkgdmVjdG9y
cyBjb3VsZCBiZSB1c2VkIGJ5IGEgZGV2aWNlCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoaXMg
bWVhbnMgdGhlIGRyaXZlciBjYW4ndCBhY3R1YWxseSBwYXNzIGEgcmVhbCBhZmZpbml0eSBtYXNr
cyBzbyB0aGUKPiA+ID4gPiA+ID4gY29tbWl0IHBhc3NlcyBhIHplcm8gaXJxIGFmZmluaXR5IHN0
cnVjdHVyZSBhcyBhIGhpbnQgaW4gZmFjdCwgc28gdGhlCj4gPiA+ID4gPiA+IFBDSSBsYXllciBj
YW4gYnVpbGQgYSBkZWZhdWx0IGFmZmluaXR5IGJhc2VkIHRoYXQgZ3JvdXBzIGNwdXMgZXZlbmx5
Cj4gPiA+ID4gPiA+IGJhc2VkIG9uIHRoZSBudW1iZXIgb2YgTVNJLVggdmVjdG9ycyAodGhlIGNv
cmUgbG9naWMgaXMgdGhlCj4gPiA+ID4gPiA+IGdyb3VwX2NwdXNfZXZlbmx5KS4gSSB0aGluayB3
ZSBzaG91bGQgZml4IHRoaXMgYnkgcmVwbGFjaW5nIHRoZQo+ID4gPiA+ID4gPiBpcnFfYWZmaW5p
dHkgc3RydWN0dXJlIHdpdGgKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gMSkgYSBib29sZWFuIGxp
a2UgYXV0b19jYl9zcHJlYWRpbmcKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gb3IKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gMikgcXVldWUgdG8gY3B1IG1hcHBpbmcKPiA+ID4gPiA+ID4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiBCdXQgb25seSB0aGUgZHJpdmVyIGtub3dzIHdoaWNoIHF1ZXVlcyBhcmUg
dXNlZCBpbiB0aGUgY29udHJvbCBwYXRoCj4gPiA+ID4gPiB3aGljaCBkb24ndCBuZWVkIHRoZSBh
dXRvbWF0aWMgaXJxIGFmZmluaXR5IGFzc2lnbm1lbnQuCj4gPiA+ID4KPiA+ID4gPiBJcyB0aGlz
IGtub3dsZWRnZSBhd2FyZGVkIGJ5IHRoZSB0cmFuc3BvcnQgZHJpdmVyIG5vdz8KPiA+ID4gPgo+
ID4gPgo+ID4gPiBUaGlzIGtub3dsZWRnZSBpcyBhd2FyZGVkIGJ5IHRoZSBkZXZpY2UgZHJpdmVy
IHJhdGhlciB0aGFuIHRoZSB0cmFuc3BvcnQgZHJpdmVyLgo+ID4gPgo+ID4gPiBFLmcuIHZpcnRp
by1zY3NpIHVzZXM6Cj4gPiA+Cj4gPiA+ICAgICBzdHJ1Y3QgaXJxX2FmZmluaXR5IGRlc2MgPSB7
IC5wcmVfdmVjdG9ycyA9IDIgfTsgLy8gdnEwIGlzIGNvbnRyb2wKPiA+ID4gcXVldWUsIHZxMSBp
cyBldmVudCBxdWV1ZQo+ID4KPiA+IE9rLCBidXQgaXQgb25seSB3b3JrcyBhcyBhIGhpbnQsIGl0
J3Mgbm90IGEgcmVhbCBhZmZpbml0eS4gQXMgcmVwbGllZCwKPiA+IHdlIGNhbiBwYXNzIGFuIGFy
cmF5IG9mIGJvb2xlYW4gaW4gdGhpcyBjYXNlIHRoZW4gdHJhbnNwb3J0IGRyaXZlcgo+ID4ga25v
d3MgaXQgZG9lc24ndCBuZWVkIHRvIHVzZSBhdXRvbWF0aWMgYWZmaW5pdHkgZm9yIHRoZSBmaXJz
dCB0d28KPiA+IHF1ZXVlcy4KPiA+Cj4KPiBCdXQgd2UgZG9uJ3Qga25vdyB3aGV0aGVyIHdlIHdv
dWxkIHVzZSBvdGhlciBmaWVsZHMgaW4gc3RydWN0dXJlCj4gaXJxX2FmZmluaXR5IGluIHRoZSBm
dXR1cmUuIFNvIGEgZnVsbCBzZXQgc2hvdWxkIGJlIGJldHRlcj8KCkdvb2QgcG9pbnQuIFNvIHRo
ZSBpc3N1ZSBpcyB0aGUgY2FsY19zZXRzKCkgYW5kIHdlIHByb2JhYmx5IG5lZWQgdGhhdAppZiB0
aGVyZSdzIGEgdmlydGlvIGRyaXZlciB0aGF0IG5lZWRzIG1vcmUgdGhhbiBvbmUgc2V0IG9mIHZl
Y3RvcnMKdGhhdCBuZWVkcyB0byBiZSBzcHJlYWRlZC4gVGVjaG5pY2FsbHksIHdlIGNvdWxkIGhh
dmUgYSB2aXJ0aW8gbGV2ZWwKYWJzdHJhY3Rpb24gZm9yIHRoaXMgYnV0IEkgYWdyZWUgaXQncyBw
cm9iYWJseSBub3Qgd29ydGggYm90aGVyaW5nCm5vdy4KCj4KPiA+ID4KPiA+ID4gPiBFLmcgdmly
dGlvLWJsayB1c2VzOgo+ID4gPiA+Cj4gPiA+ID4gICAgICAgICBzdHJ1Y3QgaXJxX2FmZmluaXR5
IGRlc2MgPSB7IDAsIH07Cj4gPiA+ID4KPiA+ID4gPiBBdGxlYXN0IHdlIGNhbiB0ZWxsIHRoZSB0
cmFuc3BvcnQgZHJpdmVyIHdoaWNoIHZxIHJlcXVpcmVzIGF1dG9tYXRpYwo+ID4gPiA+IGlycSBh
ZmZpbml0eS4KPiA+ID4gPgo+ID4gPgo+ID4gPiBJIHRoaW5rIHRoYXQgaXMgd2hhdCB0aGUgY3Vy
cmVudCBpbXBsZW1lbnRhdGlvbiBkb2VzLgo+ID4gPgo+ID4gPiA+ID4gU28gSSB0aGluayB0aGUK
PiA+ID4gPiA+IGlycV9hZmZpbml0eSBzdHJ1Y3R1cmUgY2FuIG9ubHkgYmUgY3JlYXRlZCBieSBk
ZXZpY2UgZHJpdmVycyBhbmQKPiA+ID4gPiA+IHBhc3NlZCB0byB0aGUgdmlydGlvLXBjaS92aXJ0
aW8tdmRwYSBkcml2ZXIuCj4gPiA+ID4KPiA+ID4gPiBUaGlzIGNvdWxkIGJlIG5vdCBlYXN5IHNp
bmNlIHRoZSBkcml2ZXIgZG9lc24ndCBldmVuIGtub3cgaG93IG1hbnkKPiA+ID4gPiBpbnRlcnJ1
cHRzIHdpbGwgYmUgdXNlZCBieSB0aGUgdHJhbnNwb3J0IGRyaXZlciwgc28gaXQgY2FuJ3QgYnVp
bHQgdGhlCj4gPiA+ID4gYWN0dWFsIGFmZmluaXR5IHN0cnVjdHVyZS4KPiA+ID4gPgo+ID4gPgo+
ID4gPiBUaGUgYWN0dWFsIGFmZmluaXR5IG1hc2sgaXMgYnVpbHQgYnkgdGhlIHRyYW5zcG9ydCBk
cml2ZXIsCj4gPgo+ID4gRm9yIFBDSSB5ZXMsIGl0IHRhbGtzIGRpcmVjdGx5IHRvIHRoZSBJUlEg
c3Vic3lzdGVtcy4KPiA+Cj4gPiA+IGRldmljZQo+ID4gPiBkcml2ZXIgb25seSBwYXNzZXMgYSBo
aW50IG9uIHdoaWNoIHF1ZXVlcyBkb24ndCBuZWVkIHRoZSBhdXRvbWF0aWMgaXJxCj4gPiA+IGFm
ZmluaXR5IGFzc2lnbm1lbnQuCj4gPgo+ID4gQnV0IG5vdCBmb3IgdmlydGlvLXZEUEEgc2luY2Ug
dGhlIElSUSBuZWVkcyB0byBiZSBkZWFsdCB3aXRoIGJ5IHRoZQo+ID4gcGFyZW50IGRyaXZlci4g
Rm9yIG91ciBjYXNlLCBpdCdzIHRoZSBWRFVTRSB3aGVyZSBpdCBkb2Vzbid0IG5lZWQgSVJRCj4g
PiBhdCBhbGwsIGEgcXVldWUgdG8gY3B1IG1hcHBpbmcgaXMgc3VmZmljaWVudC4KPiA+Cj4KPiBU
aGUgZGV2aWNlIGRyaXZlciBkb2Vzbid0IGtub3cgd2hldGhlciBpdCBpcyBiaW5kZWQgdG8gdmly
dGlvLXBjaSBvcgo+IHZpcnRpby12ZHBhLiBTbyBpdCBzaG91bGQgcGFzcyBhIGZ1bGwgc2V0IG5l
ZWRlZCBieSB0aGUgYXV0b21hdGljIGlycQo+IGFmZmluaXR5IGFzc2lnbm1lbnQgaW5zdGVhZCBv
ZiBhIHN1YnNldC4gVGhlbiB2aXJ0aW8tdmRwYSBjYW4gY2hvb3NlCj4gdG8gcGFzcyBhIHF1ZXVl
IHRvIGNwdSBtYXBwaW5nIHRvIFZEVVNFLCB3aGljaCBpcyB3aGF0IHdlIGRvIG5vdyAodXNlCj4g
c2V0X3ZxX2FmZmluaXR5KCkpLgoKWWVzLCBzbyBiYXNpY2FsbHkgdHdvIHdheXM6CgoxKSBhdXRv
bWF0aWMgSVJRIG1hbmFnZW1lbnQsIHBhc3NpbmcgYWZmZCB0byBmaW5kX3ZxcygpLCBhZmZpbml0
eSB3YXMKZGV0ZXJtaW5lZCBieSB0aGUgdHJhbnNwb3J0IChlLmcgdkRQQSkuCjIpIGFmZmluaXR5
IHRoYXQgaXMgdW5kZXIgdGhlIGNvbnRyb2wgb2YgdGhlIGRyaXZlciwgaXQgbmVlZHMgdG8gdXNl
CnNldF92cV9hZmZpbml0eSgpIGJ1dCBuZWVkIHRvIGRlYWwgd2l0aCBjcHUgaG90cGx1ZyBzdHVm
ZnMuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
