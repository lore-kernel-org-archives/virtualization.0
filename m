Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6327AC05027
	for <virtualization@archiver.kernel.org>; Sun, 29 Jan 2023 05:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD30C41751;
	Sun, 29 Jan 2023 05:49:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD30C41751
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VFw2cw+q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xcLjGntHjvQx; Sun, 29 Jan 2023 05:49:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB31541748;
	Sun, 29 Jan 2023 05:49:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB31541748
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D8D0C0033;
	Sun, 29 Jan 2023 05:49:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49814C002B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16F1D40159
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:49:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16F1D40159
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VFw2cw+q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LdSs05SvejGt
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:49:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21B5640150
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 21B5640150
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674971344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/JqQvkfYmpECZlGXQBcNM/6Zavf+3AMGSMqsORLXLY=;
 b=VFw2cw+qzbamZhvB2xLsIJJXl4iTJ4+zj6s4op7Yx6NiTAZr1jHPgJv8oU2WYt3Uq69wPD
 XjO/eLgt0vy9lYa08UQY3DUfdmTQOIo4U52SxtQDVJxVWxizOfeNf3AAUydtZ2643oS36o
 Dc9/5iQCCf+VBwMASIwBIVorVh3wZ18=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-166-eegaSG4zPbWkA49fZT-7VQ-1; Sun, 29 Jan 2023 00:49:01 -0500
X-MC-Unique: eegaSG4zPbWkA49fZT-7VQ-1
Received: by mail-oo1-f69.google.com with SMTP id
 b17-20020a056820135100b00517667097ffso76355oow.12
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Jan 2023 21:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/JqQvkfYmpECZlGXQBcNM/6Zavf+3AMGSMqsORLXLY=;
 b=JiuMot73M6cIzhZWi7UhsCQojiBxCFmVwgvReFKs0yaKx2ZXoxlureac9Z29EzaQkh
 tB5TXX6WGVXKl88F/6KD1duygSPJbxC3RDzaoOKZ2lLMVWzwRws7hs7wEVOXk7Hp78QK
 GdTwLp3g/SwGzNYJXva5LNaJw9WcoIiLM9IYNPxXf2unW2RhdTNQ+Td62E9lQXoVh2BR
 lfWSMzh+NgQZGn5yMwwKVjX3yyiYiIaeabOQ78Q8j8P64liao5Hs+py1ZooLGW1OjSe/
 NtRp8xaDRn/zwJIfWPQynEglZq40WqQOFiKCVEQtYglDGIzu0YEUzzxOVelhRRYrMtso
 bl7g==
X-Gm-Message-State: AFqh2kqGw+oK2usrneQghWQ7XB3iMxCGJo5Lzj55QzQKmKKi6QeDSaTk
 rot1i3g1yL5Vey+d0KMXxzzGolSWg8/2NdhsHJ+FskhjggQMWjhyLs81uhb2REnPZ2EHgFB4PzH
 z+7QLDqWJxvlzKclIUBB65ySSUkEQXpAkWmFjyLaAVWK7J99ip71sJdNHTQ==
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr3701900oab.280.1674971340767; 
 Sat, 28 Jan 2023 21:49:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsY8GrgffCnTLZZkxvDGxQQI39DxhaTkYBL757UooQVj0vRieclaFLm0dBs/b3Ed5SX/SbZEXdYdiLyT5qVIfA=
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr3701888oab.280.1674971340445; Sat, 28
 Jan 2023 21:49:00 -0800 (PST)
MIME-Version: 1.0
References: <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
 <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org>
 <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
 <20221229020553-mutt-send-email-mst@kernel.org>
 <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
 <20221229030633-mutt-send-email-mst@kernel.org>
 <CACGkMEukqZX=6yz1yCj+psHp5c+ZGVVuEYTUssfRCTQZgVWS6g@mail.gmail.com>
 <20230127053112-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230127053112-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 29 Jan 2023 13:48:49 +0800
Message-ID: <CACGkMEsZs=6TaeSUnu_9Rf+38uisi6ViHyM50=2+ut3Wze2S1g@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gRnJpLCBKYW4gMjcsIDIwMjMgYXQgNjozNSBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgRGVjIDMwLCAyMDIyIGF0IDExOjQzOjA4QU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUaHUsIERlYyAyOSwgMjAyMiBhdCA0OjEw
IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBUaHUsIERlYyAyOSwgMjAyMiBhdCAwNDowNDoxM1BNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+IE9uIFRodSwgRGVjIDI5LCAyMDIyIGF0IDM6MDcgUE0gTWljaGFlbCBTLiBU
c2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gV2Vk
LCBEZWMgMjgsIDIwMjIgYXQgMDc6NTM6MDhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+
ID4gPiA+ID4gT24gV2VkLCBEZWMgMjgsIDIwMjIgYXQgMjozNCBQTSBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4g5ZyoIDIwMjIvMTIvMjcgMTc6MzgsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6
Cj4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIERlYyAyNywgMjAyMiBhdCAwNToxMjo1OFBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4+IOWcqCAyMDIyLzEyLzI3IDE1OjMz
LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4gPiA+ID4gPiA+ID4+PiBPbiBUdWUsIERl
YyAyNywgMjAyMiBhdCAxMjozMDozNVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+
ID4gPiA+ID4+Pj4+IEJ1dCBkZXZpY2UgaXMgc3RpbGwgZ29pbmcgYW5kIHdpbGwgbGF0ZXIgdXNl
IHRoZSBidWZmZXJzLgo+ID4gPiA+ID4gPiA+ID4+Pj4+Cj4gPiA+ID4gPiA+ID4gPj4+Pj4gU2Ft
ZSBmb3IgdGltZW91dCByZWFsbHkuCj4gPiA+ID4gPiA+ID4gPj4+PiBBdm9pZGluZyBpbmZpbml0
ZSB3YWl0L3BvbGwgaXMgb25lIG9mIHRoZSBnb2FscywgYW5vdGhlciBpcyB0byBzbGVlcC4KPiA+
ID4gPiA+ID4gPiA+Pj4+IElmIHdlIHRoaW5rIHRoZSB0aW1lb3V0IGlzIGhhcmQsIHdlIGNhbiBz
dGFydCBmcm9tIHRoZSB3YWl0Lgo+ID4gPiA+ID4gPiA+ID4+Pj4KPiA+ID4gPiA+ID4gPiA+Pj4+
IFRoYW5rcwo+ID4gPiA+ID4gPiA+ID4+PiBJZiB0aGUgZ29hbCBpcyB0byBhdm9pZCBkaXNydXB0
aW5nIHRyYWZmaWMgd2hpbGUgQ1ZRIGlzIGluIHVzZSwKPiA+ID4gPiA+ID4gPiA+Pj4gdGhhdCBz
b3VuZHMgbW9yZSByZWFzb25hYmxlLiBFLmcuIHNvbWVvbmUgaXMgdHVybmluZyBvbiBwcm9taXNj
LAo+ID4gPiA+ID4gPiA+ID4+PiBhIHNwaWtlIGluIENQVSB1c2FnZSBtaWdodCBiZSB1bndlbGNv
bWUuCj4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+PiBZZXMsIHRoaXMgd291bGQgYmUg
bW9yZSBvYnZpb3VzIGlzIFVQIGlzIHVzZWQuCj4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4g
PiA+Pgo+ID4gPiA+ID4gPiA+ID4+PiB0aGluZ3Mgd2Ugc2hvdWxkIGJlIGNhcmVmdWwgdG8gYWRk
cmVzcyB0aGVuOgo+ID4gPiA+ID4gPiA+ID4+PiAxLSBkZWJ1Z2dpbmcuIEN1cnJlbnRseSBpdCdz
IGVhc3kgdG8gc2VlIGEgd2FybmluZyBpZiBDUFUgaXMgc3R1Y2sKPiA+ID4gPiA+ID4gPiA+Pj4g
ICAgICBpbiBhIGxvb3AgZm9yIGEgd2hpbGUsIGFuZCB3ZSBhbHNvIGdldCBhIGJhY2t0cmFjZS4K
PiA+ID4gPiA+ID4gPiA+Pj4gICAgICBFLmcuIHdpdGggdGhpcyAtIGhvdyBkbyB3ZSBrbm93IHdo
byBoYXMgdGhlIFJUTkw/Cj4gPiA+ID4gPiA+ID4gPj4+ICAgICAgV2UgbmVlZCB0byBpbnRlZ3Jh
dGUgd2l0aCBrZXJuZWwvd2F0Y2hkb2cuYyBmb3IgZ29vZCByZXN1bHRzCj4gPiA+ID4gPiA+ID4g
Pj4+ICAgICAgYW5kIHRvIG1ha2Ugc3VyZSBwb2xpY3kgaXMgY29uc2lzdGVudC4KPiA+ID4gPiA+
ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4+IFRoYXQncyBmaW5lLCB3aWxsIGNvbnNpZGVyIHRoaXMu
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFNvIGFmdGVyIHNvbWUgaW52ZXN0aWdhdGlvbiwgaXQg
c2VlbXMgdGhlIHdhdGNoZG9nLmMgZG9lc24ndCBoZWxwLiBUaGUKPiA+ID4gPiA+ID4gb25seSBl
eHBvcnQgaGVscGVyIGlzIHRvdWNoX3NvZnRsb2NrdXBfd2F0Y2hkb2coKSB3aGljaCB0cmllcyB0
byBhdm9pZAo+ID4gPiA+ID4gPiB0cmlnZ2VyaW5nIHRoZSBsb2NrdXBzIHdhcm5pbmcgZm9yIHRo
ZSBrbm93biBzbG93IHBhdGguCj4gPiA+ID4gPgo+ID4gPiA+ID4gSSBuZXZlciBzYWlkIHlvdSBj
YW4ganVzdCB1c2UgZXhpc3RpbmcgZXhwb3J0aW5nIEFQSXMuIFlvdSdsbCBoYXZlIHRvCj4gPiA+
ID4gPiB3cml0ZSBuZXcgb25lcyA6KQo+ID4gPiA+Cj4gPiA+ID4gT2ssIEkgdGhvdWdodCB5b3Ug
d2FudGVkIHRvIHRyaWdnZXIgc2ltaWxhciB3YXJuaW5ncyBhcyBhIHdhdGNoZG9nLgo+ID4gPiA+
Cj4gPiA+ID4gQnR3LCBJIHdvbmRlciB3aGF0IGtpbmQgb2YgbG9naWMgeW91IHdhbnQgaGVyZS4g
SWYgd2Ugc3dpdGNoIHRvIHVzaW5nCj4gPiA+ID4gc2xlZXAsIHRoZXJlIHdvbid0IGJlIHNvZnQg
bG9ja3VwIGFueW1vcmUuIEEgc2ltcGxlIHdhaXQgKyB0aW1lb3V0ICsKPiA+ID4gPiB3YXJuaW5n
IHNlZW1zIHN1ZmZpY2llbnQ/Cj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4gSSdk
IGxpa2UgdG8gYXZvaWQgbmVlZCB0byB0ZWFjaCB1c2VycyBuZXcgQVBJcy4gU28gd2F0Y2hkb2cg
c2V0dXAgdG8gYXBwbHkKPiA+ID4gdG8gdGhpcyBkcml2ZXIuIFRoZSB3YXJuaW5nIGNhbiBiZSBk
aWZmZXJlbnQuCj4gPgo+ID4gUmlnaHQsIHNvIGl0IGxvb2tzIHRvIG1lIHRoZSBvbmx5IHBvc3Np
YmxlIHNldHVwIGlzIHRoZQo+ID4gd2F0Y2hkb2dfdGhyZXMuIEkgcGxhbiB0byB0cmlnZ2VyIHRo
ZSB3YXJuaW5nIGV2ZXJ5IHdhdGNoZG9nX3RocmVzICogMgo+ID4gc2Vjb25kIChhcyBzb2Z0bG9j
a3VwIGRpZCkuCj4gPgo+ID4gQW5kIEkgdGhpbmsgaXQgd291bGQgc3RpbGwgbWFrZSBzZW5zZSB0
byBmYWlsLCB3ZSBjYW4gc3RhcnQgd2l0aCBhCj4gPiB2ZXJ5IGxvbmcgdGltZW91dCBsaWtlIDEg
bWludXRlcyBhbmQgYnJlYWsgdGhlIGRldmljZS4gRG9lcyB0aGlzIG1ha2UKPiA+IHNlbnNlPwo+
ID4KPiA+IFRoYW5rcwo+Cj4gSSdkIHNheSB3ZSBuZWVkIHRvIG1ha2UgdGhpcyBtYW5hZ2VhYmxl
IHRoZW4uCgpEaWQgeW91IG1lYW4gc29tZXRoaW5nIGxpa2Ugc3lzZnMgb3IgbW9kdWxlIHBhcmFt
ZXRlcnM/Cgo+IENhbid0IHdlIGRvIGl0IG5vcm1hbGx5Cj4gZS5nLiByZWFjdCB0byBhbiBpbnRl
cnJ1cHQgdG8gcmV0dXJuIHRvIHVzZXJzcGFjZT8KCkkgZGlkbid0IGdldCB0aGUgbWVhbmluZyBv
ZiB0aGlzLiBTb3JyeS4KClRoYW5rcwoKPgo+Cj4KPiA+ID4KPiA+ID4KPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+IEFuZCBiZWZvcmUgdGhlIHBhdGNoLCB3ZSBlbmQgdXAgd2l0aCBhIHJlYWwgaW5maW5p
dGUgbG9vcCB3aGljaCBjb3VsZAo+ID4gPiA+ID4gPiBiZSBjYXVnaHQgYnkgUkNVIHN0YWxsIGRl
dGVjdG9yIHdoaWNoIGlzIG5vdCB0aGUgY2FzZSBvZiB0aGUgc2xlZXAuCj4gPiA+ID4gPiA+IFdo
YXQgd2UgY2FuIGRvIGlzIHByb2JhYmx5IGRvIGEgcGVyaW9kaWMgbmV0ZGV2X2VycigpLgo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbmx5IHdpdGgg
YSBiYWQgZGV2aWNlLgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4+
Cj4gPiA+ID4gPiA+ID4gPj4+IDItIG92ZXJoZWFkLiBJbiBhIHZlcnkgY29tbW9uIHNjZW5hcmlv
IHdoZW4gZGV2aWNlIGlzIGluIGh5cGVydmlzb3IsCj4gPiA+ID4gPiA+ID4gPj4+ICAgICAgcHJv
Z3JhbW1pbmcgdGltZXJzIGV0YyBoYXMgYSB2ZXJ5IGhpZ2ggb3ZlcmhlYWQsIGF0IGJvb3R1cAo+
ID4gPiA+ID4gPiA+ID4+PiAgICAgIGxvdHMgb2YgQ1ZRIGNvbW1hbmRzIGFyZSBydW4gYW5kIHNs
b3dpbmcgYm9vdCBkb3duIGlzIG5vdCBuaWNlLgo+ID4gPiA+ID4gPiA+ID4+PiAgICAgIGxldCdz
IHBvbGwgZm9yIGEgYml0IGJlZm9yZSB3YWl0aW5nPwo+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4g
PiA+ID4gPj4gVGhlbiB3ZSBnbyBiYWNrIHRvIHRoZSBxdWVzdGlvbiBvZiBjaG9vc2luZyBhIGdv
b2QgdGltZW91dCBmb3IgcG9sbC4gQW5kCj4gPiA+ID4gPiA+ID4gPj4gcG9sbCBzZWVtcyBwcm9i
bGVtYXRpYyBpbiB0aGUgY2FzZSBvZiBVUCwgc2NoZWR1bGVyIG1pZ2h0IG5vdCBoYXZlIHRoZQo+
ID4gPiA+ID4gPiA+ID4+IGNoYW5jZSB0byBydW4uCj4gPiA+ID4gPiA+ID4gPiBQb2xsIGp1c3Qg
YSBiaXQgOikgU2VyaW91c2x5IEkgZG9uJ3Qga25vdywgYnV0IGF0IGxlYXN0IGNoZWNrIG9uY2UK
PiA+ID4gPiA+ID4gPiA+IGFmdGVyIGtpY2suCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+IEkgdGhpbmsgaXQgaXMgd2hhdCB0aGUgY3VycmVudCBjb2RlIGRpZCB3aGVy
ZSB0aGUgY29uZGl0aW9uIHdpbGwgYmUKPiA+ID4gPiA+ID4gPiBjaGVjayBiZWZvcmUgdHJ5aW5n
IHRvIHNsZWVwIGluIHRoZSB3YWl0X2V2ZW50KCkuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Pj4gMy0gc3VwcmlzZSByZW1vdmFsLiBu
ZWVkIHRvIHdha2UgdXAgdGhyZWFkIGluIHNvbWUgd2F5LiB3aGF0IGFib3V0Cj4gPiA+ID4gPiA+
ID4gPj4+ICAgICAgb3RoZXIgY2FzZXMgb2YgZGV2aWNlIGJyZWFrYWdlIC0gaXMgdGhlcmUgYSBj
aGFuY2UgdGhpcwo+ID4gPiA+ID4gPiA+ID4+PiAgICAgIGludHJvZHVjZXMgbmV3IGJ1Z3MgYXJv
dW5kIHRoYXQ/IGF0IGxlYXN0IGVudW1lcmF0ZSB0aGVtIHBsZWFzZS4KPiA+ID4gPiA+ID4gPiA+
Pgo+ID4gPiA+ID4gPiA+ID4+IFRoZSBjdXJyZW50IGNvZGUgZGlkOgo+ID4gPiA+ID4gPiA+ID4+
Cj4gPiA+ID4gPiA+ID4gPj4gMSkgY2hlY2sgZm9yIHZxLT5icm9rZW4KPiA+ID4gPiA+ID4gPiA+
PiAyKSB3YWtldXAgZHVyaW5nIEJBRF9SSU5HKCkKPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4g
PiA+ID4+IFNvIHdlIHdvbid0IGVuZCB1cCB3aXRoIGEgbmV2ZXIgd29rZSB1cCBwcm9jZXNzIHdo
aWNoIHNob3VsZCBiZSBmaW5lLgo+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPj4gVGhh
bmtzCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gQlRXIEJBRF9SSU5HIG9uIHJlbW92
YWwgd2lsbCB0cmlnZ2VyIGRldl9lcnIuIE5vdCBzdXJlIHRoYXQgaXMgYSBnb29kCj4gPiA+ID4g
PiA+ID4gPiBpZGVhIC0gY2FuIGNhdXNlIGNyYXNoZXMgaWYga2VybmVsIHBhbmljcyBvbiBlcnJv
ci4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gWWVzLCBpdCdzIGJl
dHRlciB0byB1c2UgX192aXJ0cXVldWVfYnJlYWsoKSBpbnN0ZWFkLgo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gQnV0IGNvbnNpZGVyIHdlIHdpbGwgc3RhcnQgZnJvbSBhIHdhaXQgZmlyc3Qs
IEkgd2lsbCBsaW1pdCB0aGUgY2hhbmdlcwo+ID4gPiA+ID4gPiA+IGluIHZpcnRpby1uZXQgd2l0
aG91dCBib3RoZXJpbmcgdmlydGlvIGNvcmUuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBU
aGFua3MKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4+Pgo+ID4gPiA+ID4KPiA+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
