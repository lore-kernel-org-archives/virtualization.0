Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2755EC05027
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 02:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A24B081819;
	Mon, 30 Jan 2023 02:54:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A24B081819
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dnjzlpuy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MkOZ4JcaJCph; Mon, 30 Jan 2023 02:54:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7DA3817EB;
	Mon, 30 Jan 2023 02:54:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7DA3817EB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C547DC0032;
	Mon, 30 Jan 2023 02:54:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAD59C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 02:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB04660B3D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 02:54:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB04660B3D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dnjzlpuy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cWTSygQaeeMl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 02:54:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73AA760B06
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73AA760B06
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 02:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675047248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AoWdEZ/yaqGT1OqdQO6pBxjycLMtTjr9F9A+c/G6+CA=;
 b=DnjzlpuyrWmeqyejEH5bHakhxhgcjGOflPAKS0bpNZjFpfYdUOnDl5gtI75OF3ah4nCb8w
 D9L2PpOSgrN4nxlbovMs5J1NVRoGS46F/lJxU6hM4VURLfsrQyaEDiIeUWUg7XIB4P91dh
 dz2mKM/vLGsg9C0xnwEVfVs6pnUtHq8=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-318-f_r5Gc9wMt6nAD8jBdwHnw-1; Sun, 29 Jan 2023 21:54:06 -0500
X-MC-Unique: f_r5Gc9wMt6nAD8jBdwHnw-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1635c250efeso3178628fac.19
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 18:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AoWdEZ/yaqGT1OqdQO6pBxjycLMtTjr9F9A+c/G6+CA=;
 b=7kjFh3LyEAE65qgm6LQLWgnhL4mB+0vDngjiY75Xz4R60x7O8e9tztxJuBmITB6WiR
 cFM7pYPNKFAIzoxTfJ7s/mJvy3uH6QAV9n1WSOoi3jHFZptxwNYXWOAjhDR/mqpqFS7Y
 MyypuOaXHwaC4NtDrRFJDxlK0+6iEExI6GcfYHbWlmS/vJAaOeNPAacByuq3jlOInf6h
 2cS3JgbuoYDkrCpEswGbENK31ad29jz0NFx2A53jWed6kknyjNSkdkGaCc4Bw0MxGCI6
 vJlwwDs5q9yBiT733POGGweui4323RDW4DmAGNcxpLeDfAvkWfiFRVq/WL2Ani1rAXgQ
 f5Gg==
X-Gm-Message-State: AFqh2kp9PT5yO5ffEdAo9sw9QPLKhYpOYE8SLavALvtCVT80Dgcl2qaa
 rHNPxr0O78kzZdg6n0A+cAOunB8wng3jOjJANUsGHK0IGk88p5aEi8lcmX7lWhNLFxPffClCKp3
 ntQ8sadiXOMjXCIl+aHh4SZ6RToeE0nhQbhK9ABN1AM85IB8CY6IjytLamA==
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr3924713oab.280.1675047246065; 
 Sun, 29 Jan 2023 18:54:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsSDrlerEmQE1VEMn77eC3aqReXKoMWvV9fgiOn+UzniPxIf7XVG7PGoMpqj9eTq8Xhc6S1kAzs4zktcxe9SuY=
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr3924703oab.280.1675047245754; Sun, 29
 Jan 2023 18:54:05 -0800 (PST)
MIME-Version: 1.0
References: <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org>
 <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
 <20221229020553-mutt-send-email-mst@kernel.org>
 <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
 <20221229030633-mutt-send-email-mst@kernel.org>
 <CACGkMEukqZX=6yz1yCj+psHp5c+ZGVVuEYTUssfRCTQZgVWS6g@mail.gmail.com>
 <20230127053112-mutt-send-email-mst@kernel.org>
 <CACGkMEsZs=6TaeSUnu_9Rf+38uisi6ViHyM50=2+ut3Wze2S1g@mail.gmail.com>
 <20230129022809-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230129022809-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 30 Jan 2023 10:53:54 +0800
Message-ID: <CACGkMEuya+_2P8d4hokoyL_LKGdVzyCC1nDwOCdZb0=+2rjKPQ@mail.gmail.com>
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

T24gU3VuLCBKYW4gMjksIDIwMjMgYXQgMzozMCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFN1biwgSmFuIDI5LCAyMDIzIGF0IDAxOjQ4OjQ5UE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBGcmksIEphbiAyNywgMjAyMyBhdCA2OjM1
IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBGcmksIERlYyAzMCwgMjAyMiBhdCAxMTo0MzowOEFNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+IE9uIFRodSwgRGVjIDI5LCAyMDIyIGF0IDQ6MTAgUE0gTWljaGFlbCBTLiBU
c2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gVGh1
LCBEZWMgMjksIDIwMjIgYXQgMDQ6MDQ6MTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+
ID4gPiA+ID4gT24gVGh1LCBEZWMgMjksIDIwMjIgYXQgMzowNyBQTSBNaWNoYWVsIFMuIFRzaXJr
aW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE9u
IFdlZCwgRGVjIDI4LCAyMDIyIGF0IDA3OjUzOjA4UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4gPiA+ID4gPiA+ID4gPiBPbiBXZWQsIERlYyAyOCwgMjAyMiBhdCAyOjM0IFBNIEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiDlnKggMjAyMi8xMi8yNyAxNzozOCwgTWljaGFl
bCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIERlYyAyNywg
MjAyMiBhdCAwNToxMjo1OFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+
ID4gPiA+PiDlnKggMjAyMi8xMi8yNyAxNTozMywgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoK
PiA+ID4gPiA+ID4gPiA+ID4gPj4+IE9uIFR1ZSwgRGVjIDI3LCAyMDIyIGF0IDEyOjMwOjM1UE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+IEJ1dCBkZXZp
Y2UgaXMgc3RpbGwgZ29pbmcgYW5kIHdpbGwgbGF0ZXIgdXNlIHRoZSBidWZmZXJzLgo+ID4gPiA+
ID4gPiA+ID4gPiA+Pj4+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+PiBTYW1lIGZvciB0aW1lb3V0
IHJlYWxseS4KPiA+ID4gPiA+ID4gPiA+ID4gPj4+PiBBdm9pZGluZyBpbmZpbml0ZSB3YWl0L3Bv
bGwgaXMgb25lIG9mIHRoZSBnb2FscywgYW5vdGhlciBpcyB0byBzbGVlcC4KPiA+ID4gPiA+ID4g
PiA+ID4gPj4+PiBJZiB3ZSB0aGluayB0aGUgdGltZW91dCBpcyBoYXJkLCB3ZSBjYW4gc3RhcnQg
ZnJvbSB0aGUgd2FpdC4KPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+
Pj4+IFRoYW5rcwo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gSWYgdGhlIGdvYWwgaXMgdG8gYXZvaWQg
ZGlzcnVwdGluZyB0cmFmZmljIHdoaWxlIENWUSBpcyBpbiB1c2UsCj4gPiA+ID4gPiA+ID4gPiA+
ID4+PiB0aGF0IHNvdW5kcyBtb3JlIHJlYXNvbmFibGUuIEUuZy4gc29tZW9uZSBpcyB0dXJuaW5n
IG9uIHByb21pc2MsCj4gPiA+ID4gPiA+ID4gPiA+ID4+PiBhIHNwaWtlIGluIENQVSB1c2FnZSBt
aWdodCBiZSB1bndlbGNvbWUuCj4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+
ID4+IFllcywgdGhpcyB3b3VsZCBiZSBtb3JlIG9idmlvdXMgaXMgVVAgaXMgdXNlZC4KPiA+ID4g
PiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPj4+
IHRoaW5ncyB3ZSBzaG91bGQgYmUgY2FyZWZ1bCB0byBhZGRyZXNzIHRoZW46Cj4gPiA+ID4gPiA+
ID4gPiA+ID4+PiAxLSBkZWJ1Z2dpbmcuIEN1cnJlbnRseSBpdCdzIGVhc3kgdG8gc2VlIGEgd2Fy
bmluZyBpZiBDUFUgaXMgc3R1Y2sKPiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgaW4gYSBsb29w
IGZvciBhIHdoaWxlLCBhbmQgd2UgYWxzbyBnZXQgYSBiYWNrdHJhY2UuCj4gPiA+ID4gPiA+ID4g
PiA+ID4+PiAgICAgIEUuZy4gd2l0aCB0aGlzIC0gaG93IGRvIHdlIGtub3cgd2hvIGhhcyB0aGUg
UlROTD8KPiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgV2UgbmVlZCB0byBpbnRlZ3JhdGUgd2l0
aCBrZXJuZWwvd2F0Y2hkb2cuYyBmb3IgZ29vZCByZXN1bHRzCj4gPiA+ID4gPiA+ID4gPiA+ID4+
PiAgICAgIGFuZCB0byBtYWtlIHN1cmUgcG9saWN5IGlzIGNvbnNpc3RlbnQuCj4gPiA+ID4gPiA+
ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4+IFRoYXQncyBmaW5lLCB3aWxsIGNvbnNpZGVy
IHRoaXMuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gU28gYWZ0ZXIgc29tZSBpbnZl
c3RpZ2F0aW9uLCBpdCBzZWVtcyB0aGUgd2F0Y2hkb2cuYyBkb2Vzbid0IGhlbHAuIFRoZQo+ID4g
PiA+ID4gPiA+ID4gb25seSBleHBvcnQgaGVscGVyIGlzIHRvdWNoX3NvZnRsb2NrdXBfd2F0Y2hk
b2coKSB3aGljaCB0cmllcyB0byBhdm9pZAo+ID4gPiA+ID4gPiA+ID4gdHJpZ2dlcmluZyB0aGUg
bG9ja3VwcyB3YXJuaW5nIGZvciB0aGUga25vd24gc2xvdyBwYXRoLgo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gSSBuZXZlciBzYWlkIHlvdSBjYW4ganVzdCB1c2UgZXhpc3RpbmcgZXhwb3J0
aW5nIEFQSXMuIFlvdSdsbCBoYXZlIHRvCj4gPiA+ID4gPiA+ID4gd3JpdGUgbmV3IG9uZXMgOikK
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gT2ssIEkgdGhvdWdodCB5b3Ugd2FudGVkIHRvIHRyaWdn
ZXIgc2ltaWxhciB3YXJuaW5ncyBhcyBhIHdhdGNoZG9nLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiBCdHcsIEkgd29uZGVyIHdoYXQga2luZCBvZiBsb2dpYyB5b3Ugd2FudCBoZXJlLiBJZiB3ZSBz
d2l0Y2ggdG8gdXNpbmcKPiA+ID4gPiA+ID4gc2xlZXAsIHRoZXJlIHdvbid0IGJlIHNvZnQgbG9j
a3VwIGFueW1vcmUuIEEgc2ltcGxlIHdhaXQgKyB0aW1lb3V0ICsKPiA+ID4gPiA+ID4gd2Fybmlu
ZyBzZWVtcyBzdWZmaWNpZW50Pwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4g
PiA+Cj4gPiA+ID4gPiBJJ2QgbGlrZSB0byBhdm9pZCBuZWVkIHRvIHRlYWNoIHVzZXJzIG5ldyBB
UElzLiBTbyB3YXRjaGRvZyBzZXR1cCB0byBhcHBseQo+ID4gPiA+ID4gdG8gdGhpcyBkcml2ZXIu
IFRoZSB3YXJuaW5nIGNhbiBiZSBkaWZmZXJlbnQuCj4gPiA+ID4KPiA+ID4gPiBSaWdodCwgc28g
aXQgbG9va3MgdG8gbWUgdGhlIG9ubHkgcG9zc2libGUgc2V0dXAgaXMgdGhlCj4gPiA+ID4gd2F0
Y2hkb2dfdGhyZXMuIEkgcGxhbiB0byB0cmlnZ2VyIHRoZSB3YXJuaW5nIGV2ZXJ5IHdhdGNoZG9n
X3RocmVzICogMgo+ID4gPiA+IHNlY29uZCAoYXMgc29mdGxvY2t1cCBkaWQpLgo+ID4gPiA+Cj4g
PiA+ID4gQW5kIEkgdGhpbmsgaXQgd291bGQgc3RpbGwgbWFrZSBzZW5zZSB0byBmYWlsLCB3ZSBj
YW4gc3RhcnQgd2l0aCBhCj4gPiA+ID4gdmVyeSBsb25nIHRpbWVvdXQgbGlrZSAxIG1pbnV0ZXMg
YW5kIGJyZWFrIHRoZSBkZXZpY2UuIERvZXMgdGhpcyBtYWtlCj4gPiA+ID4gc2Vuc2U/Cj4gPiA+
ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4gSSdkIHNheSB3ZSBuZWVkIHRvIG1ha2UgdGhp
cyBtYW5hZ2VhYmxlIHRoZW4uCj4gPgo+ID4gRGlkIHlvdSBtZWFuIHNvbWV0aGluZyBsaWtlIHN5
c2ZzIG9yIG1vZHVsZSBwYXJhbWV0ZXJzPwo+Cj4gTm8gSSdkIHNheSBwYXNzIGl0IHdpdGggYW4g
aW9jdGwuCj4KPiA+ID4gQ2FuJ3Qgd2UgZG8gaXQgbm9ybWFsbHkKPiA+ID4gZS5nLiByZWFjdCB0
byBhbiBpbnRlcnJ1cHQgdG8gcmV0dXJuIHRvIHVzZXJzcGFjZT8KPiA+Cj4gPiBJIGRpZG4ndCBn
ZXQgdGhlIG1lYW5pbmcgb2YgdGhpcy4gU29ycnkuCj4gPgo+ID4gVGhhbmtzCj4KPiBTdGFuZGFy
ZCB3YXkgdG8gaGFuZGxlIHRoaW5ncyB0aGF0IGNhbiB0aW1lb3V0IGFuZCB3aGVyZSB1c2Vyc3Bh
Y2UKPiBkaWQgbm90IHN1cHBseSB0aGUgdGltZSBpcyB0byBibG9jayB1bnRpbCBhbiBpbnRlcnJ1
cHQKPiB0aGVuIHJldHVybiBFSU5UUi4KCldlbGwgdGhpcyBzZWVtcyB0byBiZSBhIGh1Z2UgY2hh
bmdlLCBpb2N0bCgyKSBkb2Vzbid0IHNheSBpdCBjYW4KcmV0dXJuIEVJTlRSIG5vdy4KCkFjdHVh
bGx5LCBhIGRyaXZlciB0aW1lb3V0IGlzIHVzZWQgYnkgb3RoZXIgZHJpdmVycyB3aGVuIHVzaW5n
CmNvbnRyb2xxL2FkbWlucSAoZS5nIGk0MGUpLiBTdGFydGluZyBmcm9tIGEgc2FuZSB2YWx1ZSAo
ZS5nIDEgbWludXRlcwp0byBhdm9pZCBmYWxzZSBuZWdhdGl2ZXMpIHNlZW1zIHRvIGJlIGEgZ29v
ZCBmaXJzdCBzdGVwLgoKPiBVc2Vyc3BhY2UgY29udHJvbHMgdGhlIHRpbWVvdXQgYnkKPiB1c2lu
ZyBlLmcuIGFsYXJtKDIpLgoKTm90IHVzZWQgaW4gaXByb3V0ZTIgYWZ0ZXIgYSBnaXQgZ3JlcC4K
ClRoYW5rcwoKPgo+Cj4gPiA+Cj4gPiA+Cj4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gQW5kIGJlZm9yZSB0aGUgcGF0Y2gsIHdlIGVuZCB1cCB3
aXRoIGEgcmVhbCBpbmZpbml0ZSBsb29wIHdoaWNoIGNvdWxkCj4gPiA+ID4gPiA+ID4gPiBiZSBj
YXVnaHQgYnkgUkNVIHN0YWxsIGRldGVjdG9yIHdoaWNoIGlzIG5vdCB0aGUgY2FzZSBvZiB0aGUg
c2xlZXAuCj4gPiA+ID4gPiA+ID4gPiBXaGF0IHdlIGNhbiBkbyBpcyBwcm9iYWJseSBkbyBhIHBl
cmlvZGljIG5ldGRldl9lcnIoKS4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBUaGFu
a3MKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE9ubHkgd2l0aCBhIGJhZCBkZXZpY2UuCj4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+
ID4gPiA+ID4gPiA+ID4gPj4+IDItIG92ZXJoZWFkLiBJbiBhIHZlcnkgY29tbW9uIHNjZW5hcmlv
IHdoZW4gZGV2aWNlIGlzIGluIGh5cGVydmlzb3IsCj4gPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAg
IHByb2dyYW1taW5nIHRpbWVycyBldGMgaGFzIGEgdmVyeSBoaWdoIG92ZXJoZWFkLCBhdCBib290
dXAKPiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgbG90cyBvZiBDVlEgY29tbWFuZHMgYXJlIHJ1
biBhbmQgc2xvd2luZyBib290IGRvd24gaXMgbm90IG5pY2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4+
PiAgICAgIGxldCdzIHBvbGwgZm9yIGEgYml0IGJlZm9yZSB3YWl0aW5nPwo+ID4gPiA+ID4gPiA+
ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+PiBUaGVuIHdlIGdvIGJhY2sgdG8gdGhlIHF1ZXN0
aW9uIG9mIGNob29zaW5nIGEgZ29vZCB0aW1lb3V0IGZvciBwb2xsLiBBbmQKPiA+ID4gPiA+ID4g
PiA+ID4gPj4gcG9sbCBzZWVtcyBwcm9ibGVtYXRpYyBpbiB0aGUgY2FzZSBvZiBVUCwgc2NoZWR1
bGVyIG1pZ2h0IG5vdCBoYXZlIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+PiBjaGFuY2UgdG8gcnVu
Lgo+ID4gPiA+ID4gPiA+ID4gPiA+IFBvbGwganVzdCBhIGJpdCA6KSBTZXJpb3VzbHkgSSBkb24n
dCBrbm93LCBidXQgYXQgbGVhc3QgY2hlY2sgb25jZQo+ID4gPiA+ID4gPiA+ID4gPiA+IGFmdGVy
IGtpY2suCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+IEkgdGhpbmsgaXQgaXMgd2hhdCB0aGUgY3VycmVudCBjb2RlIGRpZCB3aGVyZSB0aGUgY29u
ZGl0aW9uIHdpbGwgYmUKPiA+ID4gPiA+ID4gPiA+ID4gY2hlY2sgYmVmb3JlIHRyeWluZyB0byBz
bGVlcCBpbiB0aGUgd2FpdF9ldmVudCgpLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4+PiAzLSBzdXByaXNl
IHJlbW92YWwuIG5lZWQgdG8gd2FrZSB1cCB0aHJlYWQgaW4gc29tZSB3YXkuIHdoYXQgYWJvdXQK
PiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgb3RoZXIgY2FzZXMgb2YgZGV2aWNlIGJyZWFrYWdl
IC0gaXMgdGhlcmUgYSBjaGFuY2UgdGhpcwo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gICAgICBpbnRy
b2R1Y2VzIG5ldyBidWdzIGFyb3VuZCB0aGF0PyBhdCBsZWFzdCBlbnVtZXJhdGUgdGhlbSBwbGVh
c2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4+IFRoZSBjdXJyZW50
IGNvZGUgZGlkOgo+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+PiAxKSBj
aGVjayBmb3IgdnEtPmJyb2tlbgo+ID4gPiA+ID4gPiA+ID4gPiA+PiAyKSB3YWtldXAgZHVyaW5n
IEJBRF9SSU5HKCkKPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPj4gU28g
d2Ugd29uJ3QgZW5kIHVwIHdpdGggYSBuZXZlciB3b2tlIHVwIHByb2Nlc3Mgd2hpY2ggc2hvdWxk
IGJlIGZpbmUuCj4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4+IFRoYW5r
cwo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gQlRXIEJBRF9SSU5HIG9u
IHJlbW92YWwgd2lsbCB0cmlnZ2VyIGRldl9lcnIuIE5vdCBzdXJlIHRoYXQgaXMgYSBnb29kCj4g
PiA+ID4gPiA+ID4gPiA+ID4gaWRlYSAtIGNhbiBjYXVzZSBjcmFzaGVzIGlmIGtlcm5lbCBwYW5p
Y3Mgb24gZXJyb3IuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiA+IFllcywgaXQncyBiZXR0ZXIgdG8gdXNlIF9fdmlydHF1ZXVlX2JyZWFrKCkgaW5z
dGVhZC4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gQnV0IGNvbnNpZGVyIHdl
IHdpbGwgc3RhcnQgZnJvbSBhIHdhaXQgZmlyc3QsIEkgd2lsbCBsaW1pdCB0aGUgY2hhbmdlcwo+
ID4gPiA+ID4gPiA+ID4gPiBpbiB2aXJ0aW8tbmV0IHdpdGhvdXQgYm90aGVyaW5nIHZpcnRpbyBj
b3JlLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+Pj4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4KPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
