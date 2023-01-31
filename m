Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EA3C636D3
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 03:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5F0A605F6;
	Tue, 31 Jan 2023 03:25:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5F0A605F6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KwrbKKU9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pMFdVSE9vPTm; Tue, 31 Jan 2023 03:25:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D5C3C605E0;
	Tue, 31 Jan 2023 03:25:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5C3C605E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94242C0032;
	Tue, 31 Jan 2023 03:25:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EE07C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 356CE400CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:25:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 356CE400CC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KwrbKKU9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g95oijiZxePp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:25:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 63358400B8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63358400B8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675135506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vr/XPJ17q7z7e/z/oXjbB8MrOAf0hopqLmOBio0dflk=;
 b=KwrbKKU9p9quiRdJvu7i6ylxIYxIqhltjnTI+z080olDLeHwhqW9PHQFPxLVVi0qnnkLUe
 1EtTDT1qb/tIHsaW8rsBxBo8shsyQ23bM4sYht0ByIDIcPEGFttNRcZ7r6CnGSBKkAITOu
 z4OT6LfINSzm4i7v/MSczsYYX4VB4wk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54--HnGEuHoOqWve0YY-dSz5w-1; Mon, 30 Jan 2023 22:25:05 -0500
X-MC-Unique: -HnGEuHoOqWve0YY-dSz5w-1
Received: by mail-ot1-f69.google.com with SMTP id
 bh27-20020a056830381b00b00686b0589045so6524303otb.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vr/XPJ17q7z7e/z/oXjbB8MrOAf0hopqLmOBio0dflk=;
 b=xnjke7druQjLXMdooRZC4LwezIDQmE3P9g6K29kvXBfc+P1NkQVWJZ2R3nJeLs42xC
 51OxZFgWQrS24A4zBsmCBDKqKP3AXwWmLWO6zUxnrtH91tNCaDfFnbd88OVFvu4qjjH6
 A68PJMkdiFML88OwTzNxeZd95medMIt6oInO1lK73uG+0PT/mwyC9K163/4qk6Tk+9Od
 Oc32EFir2a+nr1HEZH4O01Go3wqR0VAsacrJJku/11Ng7ASOnAJLRfq6dI4c5pDvCHLf
 MAcZ1bbVKgH1ScOqzih1zW2/RU7ltNhhEutA4NZbesHR0yC4ilIPCynlqreCsYOCCPFH
 pqXA==
X-Gm-Message-State: AO0yUKXJYTE1hIX/itbipWfDflI7uLvyrtuh6LLDz9cA/gF6qtwXyhzo
 qfjXaKaaQ9tHq+joHtbSyR4vLy39mtjksd0cMQO32fm1isH14qnOhqN2Y4+sUbCuMhZrmDIK4OK
 j3urak7vOYaQJGlPJ73GdK6Cjuvaocmf+pikc6/bOi9KqMxhPRSboTPGn4Q==
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr568149oao.35.1675135503909; 
 Mon, 30 Jan 2023 19:25:03 -0800 (PST)
X-Google-Smtp-Source: AK7set/VJiLIh/TubQIOMpyVamjgT72GTmyo0tvSLnBVw1r+/0Ig8xZ/jKP2by6xLPdeeXJwbkASAQGVMeFCu5J5COE=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr568140oao.35.1675135503638; Mon, 30 Jan
 2023 19:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20221229020553-mutt-send-email-mst@kernel.org>
 <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
 <20221229030633-mutt-send-email-mst@kernel.org>
 <CACGkMEukqZX=6yz1yCj+psHp5c+ZGVVuEYTUssfRCTQZgVWS6g@mail.gmail.com>
 <20230127053112-mutt-send-email-mst@kernel.org>
 <CACGkMEsZs=6TaeSUnu_9Rf+38uisi6ViHyM50=2+ut3Wze2S1g@mail.gmail.com>
 <20230129022809-mutt-send-email-mst@kernel.org>
 <CACGkMEuya+_2P8d4hokoyL_LKGdVzyCC1nDwOCdZb0=+2rjKPQ@mail.gmail.com>
 <20230130003334-mutt-send-email-mst@kernel.org>
 <CACGkMEu0v-kbh2vKvcDRoMsRoXwidPnQhiFetYPY-tXOAVScsg@mail.gmail.com>
 <20230130061437-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230130061437-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 Jan 2023 11:24:52 +0800
Message-ID: <CACGkMEsk92FSyP6uMheAzkAPbnGfdCsq387fL9XqhfF6Z=Xmew@mail.gmail.com>
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

T24gTW9uLCBKYW4gMzAsIDIwMjMgYXQgNzoxOCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgSmFuIDMwLCAyMDIzIGF0IDAzOjQ0OjI0UE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBNb24sIEphbiAzMCwgMjAyMyBhdCAxOjQz
IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBNb24sIEphbiAzMCwgMjAyMyBhdCAxMDo1Mzo1NEFNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+IE9uIFN1biwgSmFuIDI5LCAyMDIzIGF0IDM6MzAgUE0gTWljaGFlbCBTLiBU
c2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gU3Vu
LCBKYW4gMjksIDIwMjMgYXQgMDE6NDg6NDlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+
ID4gPiA+ID4gT24gRnJpLCBKYW4gMjcsIDIwMjMgYXQgNjozNSBQTSBNaWNoYWVsIFMuIFRzaXJr
aW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE9u
IEZyaSwgRGVjIDMwLCAyMDIyIGF0IDExOjQzOjA4QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIERlYyAyOSwgMjAyMiBhdCA0OjEwIFBNIE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiBPbiBUaHUsIERlYyAyOSwgMjAyMiBhdCAwNDowNDoxM1BNICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFRodSwgRGVjIDI5LCAyMDIy
IGF0IDM6MDcgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gV2VkLCBEZWMgMjgs
IDIwMjIgYXQgMDc6NTM6MDhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gT24gV2VkLCBEZWMgMjgsIDIwMjIgYXQgMjozNCBQTSBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g5ZyoIDIwMjIv
MTIvMjcgMTc6MzgsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBPbiBUdWUsIERlYyAyNywgMjAyMiBhdCAwNToxMjo1OFBNICswODAwLCBKYXNv
biBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+IOWcqCAyMDIyLzEyLzI3
IDE1OjMzLCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4+PiBPbiBUdWUsIERlYyAyNywgMjAyMiBhdCAxMjozMDozNVBNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+IEJ1dCBkZXZpY2UgaXMg
c3RpbGwgZ29pbmcgYW5kIHdpbGwgbGF0ZXIgdXNlIHRoZSBidWZmZXJzLgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4+Pj4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4gU2FtZSBm
b3IgdGltZW91dCByZWFsbHkuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+PiBBdm9pZGlu
ZyBpbmZpbml0ZSB3YWl0L3BvbGwgaXMgb25lIG9mIHRoZSBnb2FscywgYW5vdGhlciBpcyB0byBz
bGVlcC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+IElmIHdlIHRoaW5rIHRoZSB0aW1l
b3V0IGlzIGhhcmQsIHdlIGNhbiBzdGFydCBmcm9tIHRoZSB3YWl0Lgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4+Pj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+IFRoYW5rcwo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiBJZiB0aGUgZ29hbCBpcyB0byBhdm9pZCBkaXNydXB0
aW5nIHRyYWZmaWMgd2hpbGUgQ1ZRIGlzIGluIHVzZSwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Pj4gdGhhdCBzb3VuZHMgbW9yZSByZWFzb25hYmxlLiBFLmcuIHNvbWVvbmUgaXMgdHVybmlu
ZyBvbiBwcm9taXNjLAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiBhIHNwaWtlIGluIENQ
VSB1c2FnZSBtaWdodCBiZSB1bndlbGNvbWUuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiBZZXMsIHRoaXMgd291bGQgYmUgbW9yZSBvYnZp
b3VzIGlzIFVQIGlzIHVzZWQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiB0aGluZ3Mg
d2Ugc2hvdWxkIGJlIGNhcmVmdWwgdG8gYWRkcmVzcyB0aGVuOgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4+PiAxLSBkZWJ1Z2dpbmcuIEN1cnJlbnRseSBpdCdzIGVhc3kgdG8gc2VlIGEgd2Fy
bmluZyBpZiBDUFUgaXMgc3R1Y2sKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gICAgICBp
biBhIGxvb3AgZm9yIGEgd2hpbGUsIGFuZCB3ZSBhbHNvIGdldCBhIGJhY2t0cmFjZS4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gICAgICBFLmcuIHdpdGggdGhpcyAtIGhvdyBkbyB3ZSBr
bm93IHdobyBoYXMgdGhlIFJUTkw/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAg
V2UgbmVlZCB0byBpbnRlZ3JhdGUgd2l0aCBrZXJuZWwvd2F0Y2hkb2cuYyBmb3IgZ29vZCByZXN1
bHRzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgYW5kIHRvIG1ha2Ugc3VyZSBw
b2xpY3kgaXMgY29uc2lzdGVudC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4+IFRoYXQncyBmaW5lLCB3aWxsIGNvbnNpZGVyIHRoaXMuCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNvIGFmdGVyIHNv
bWUgaW52ZXN0aWdhdGlvbiwgaXQgc2VlbXMgdGhlIHdhdGNoZG9nLmMgZG9lc24ndCBoZWxwLiBU
aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gb25seSBleHBvcnQgaGVscGVyIGlzIHRvdWNoX3Nv
ZnRsb2NrdXBfd2F0Y2hkb2coKSB3aGljaCB0cmllcyB0byBhdm9pZAo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiB0cmlnZ2VyaW5nIHRoZSBsb2NrdXBzIHdhcm5pbmcgZm9yIHRoZSBrbm93biBzbG93
IHBhdGguCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSSBuZXZl
ciBzYWlkIHlvdSBjYW4ganVzdCB1c2UgZXhpc3RpbmcgZXhwb3J0aW5nIEFQSXMuIFlvdSdsbCBo
YXZlIHRvCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiB3cml0ZSBuZXcgb25lcyA6KQo+ID4gPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gT2ssIEkgdGhvdWdodCB5b3Ugd2FudGVkIHRv
IHRyaWdnZXIgc2ltaWxhciB3YXJuaW5ncyBhcyBhIHdhdGNoZG9nLgo+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gQnR3LCBJIHdvbmRlciB3aGF0IGtpbmQgb2YgbG9naWMg
eW91IHdhbnQgaGVyZS4gSWYgd2Ugc3dpdGNoIHRvIHVzaW5nCj4gPiA+ID4gPiA+ID4gPiA+ID4g
c2xlZXAsIHRoZXJlIHdvbid0IGJlIHNvZnQgbG9ja3VwIGFueW1vcmUuIEEgc2ltcGxlIHdhaXQg
KyB0aW1lb3V0ICsKPiA+ID4gPiA+ID4gPiA+ID4gPiB3YXJuaW5nIHNlZW1zIHN1ZmZpY2llbnQ/
Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gSSdkIGxpa2UgdG8gYXZvaWQgbmVlZCB0byB0ZWFj
aCB1c2VycyBuZXcgQVBJcy4gU28gd2F0Y2hkb2cgc2V0dXAgdG8gYXBwbHkKPiA+ID4gPiA+ID4g
PiA+ID4gdG8gdGhpcyBkcml2ZXIuIFRoZSB3YXJuaW5nIGNhbiBiZSBkaWZmZXJlbnQuCj4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gUmlnaHQsIHNvIGl0IGxvb2tzIHRvIG1lIHRoZSBv
bmx5IHBvc3NpYmxlIHNldHVwIGlzIHRoZQo+ID4gPiA+ID4gPiA+ID4gd2F0Y2hkb2dfdGhyZXMu
IEkgcGxhbiB0byB0cmlnZ2VyIHRoZSB3YXJuaW5nIGV2ZXJ5IHdhdGNoZG9nX3RocmVzICogMgo+
ID4gPiA+ID4gPiA+ID4gc2Vjb25kIChhcyBzb2Z0bG9ja3VwIGRpZCkuCj4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gQW5kIEkgdGhpbmsgaXQgd291bGQgc3RpbGwgbWFrZSBzZW5zZSB0
byBmYWlsLCB3ZSBjYW4gc3RhcnQgd2l0aCBhCj4gPiA+ID4gPiA+ID4gPiB2ZXJ5IGxvbmcgdGlt
ZW91dCBsaWtlIDEgbWludXRlcyBhbmQgYnJlYWsgdGhlIGRldmljZS4gRG9lcyB0aGlzIG1ha2UK
PiA+ID4gPiA+ID4gPiA+IHNlbnNlPwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFRo
YW5rcwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSSdkIHNheSB3ZSBuZWVkIHRvIG1ha2Ug
dGhpcyBtYW5hZ2VhYmxlIHRoZW4uCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IERpZCB5b3UgbWVh
biBzb21ldGhpbmcgbGlrZSBzeXNmcyBvciBtb2R1bGUgcGFyYW1ldGVycz8KPiA+ID4gPiA+Cj4g
PiA+ID4gPiBObyBJJ2Qgc2F5IHBhc3MgaXQgd2l0aCBhbiBpb2N0bC4KPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gQ2FuJ3Qgd2UgZG8gaXQgbm9ybWFsbHkKPiA+ID4gPiA+ID4gPiBlLmcuIHJlYWN0
IHRvIGFuIGludGVycnVwdCB0byByZXR1cm4gdG8gdXNlcnNwYWNlPwo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiBJIGRpZG4ndCBnZXQgdGhlIG1lYW5pbmcgb2YgdGhpcy4gU29ycnkuCj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4KPiA+ID4gPiA+IFN0YW5kYXJkIHdheSB0
byBoYW5kbGUgdGhpbmdzIHRoYXQgY2FuIHRpbWVvdXQgYW5kIHdoZXJlIHVzZXJzcGFjZQo+ID4g
PiA+ID4gZGlkIG5vdCBzdXBwbHkgdGhlIHRpbWUgaXMgdG8gYmxvY2sgdW50aWwgYW4gaW50ZXJy
dXB0Cj4gPiA+ID4gPiB0aGVuIHJldHVybiBFSU5UUi4KPiA+ID4gPgo+ID4gPiA+IFdlbGwgdGhp
cyBzZWVtcyB0byBiZSBhIGh1Z2UgY2hhbmdlLCBpb2N0bCgyKSBkb2Vzbid0IHNheSBpdCBjYW4K
PiA+ID4gPiByZXR1cm4gRUlOVFIgbm93Lgo+ID4gPgo+ID4gPiB0aGUgb25lIG9uIGZlZG9yYSAz
NyBkb2VzIG5vdCBidXQgaXQgc2F5czoKPiA+ID4gICAgICAgIE5vIHNpbmdsZSBzdGFuZGFyZC4g
IEFyZ3VtZW50cywgcmV0dXJucywgYW5kIHNlbWFudGljcyBvZiBpb2N0bCgpIHZhcnkgYWNjb3Jk
aW5nIHRvIHRoZSBkZXZpY2UgZHJpdmVyIGluIHF1ZXN0aW9uICh0aGUgY2FsbCAgaXMKPiA+ID4g
ICAgICAgIHVzZWQgYXMgYSBjYXRjaC1hbGwgZm9yIG9wZXJhdGlvbnMgdGhhdCBkb24ndCBjbGVh
bmx5IGZpdCB0aGUgVU5JWCBzdHJlYW0gSS9PIG1vZGVsKS4KPiA+ID4KPiA+ID4gc28gaXQgZGVw
ZW5kcyBvbiB0aGUgZGV2aWNlIGUuZy4gZm9yIGEgc3RyZWFtcyBkZXZpY2UgaXQgZG9lczoKPiA+
ID4gaHR0cHM6Ly9wdWJzLm9wZW5ncm91cC5vcmcvb25saW5lcHVicy85Njk5OTE5Nzk5L2Z1bmN0
aW9ucy9pb2N0bC5odG1sCj4gPiA+IGhhcyBFSU5UUi4KPiA+Cj4gPiBPaywgSSBzYXcgc2lnbmFs
KDcpIGFsc28gbWVudGlvbiBhYm91dCBFSU5UUiBmb3IgaW9jdGwoMik6Cj4gPgo+ID4gIiIiCj4g
PiAgICAgICAgSWYgIGEgIGJsb2NrZWQgY2FsbCB0byBvbmUgb2YgdGhlIGZvbGxvd2luZyBpbnRl
cmZhY2VzIGlzCj4gPiBpbnRlcnJ1cHRlZCBieSBhIHNpZ25hbCBoYW5kbGVyLCB0aGVuIHRoZSBj
YWxsIGlzIGF1dG9tYXRpY2FsbHkKPiA+IHJlc3RhcnRlZCBhZnRlciB0aGUgc2lnbmFsIGhhbmRs
ZXIgcmXigJAKPiA+ICAgICAgICB0dXJucyBpZiB0aGUgU0FfUkVTVEFSVCBmbGFnIHdhcyB1c2Vk
OyBvdGhlcndpc2UgdGhlIGNhbGwgZmFpbHMKPiA+IHdpdGggdGhlIGVycm9yIEVJTlRSOgo+ID4K
PiA+ICAgICAgICAqIHJlYWQoMiksIHJlYWR2KDIpLCB3cml0ZSgyKSwgd3JpdGV2KDIpLCBhbmQg
aW9jdGwoMikgY2FsbHMgb24KPiA+ICJzbG93IiBkZXZpY2VzLiAgQSAic2xvdyIgZGV2aWNlIGlz
IG9uZSB3aGVyZSB0aGUgSS9PIGNhbGwgbWF5IGJsb2NrCj4gPiBmb3IgYW4gaW5kZWZpbml0ZSB0
aW1lLCBmb3IKPiA+ICAgICAgICAgIGV4YW1wbGUsICBhICB0ZXJtaW5hbCwgIHBpcGUsIG9yIHNv
Y2tldC4gIElmIGFuIEkvTyBjYWxsIG9uIGEKPiA+IHNsb3cgZGV2aWNlIGhhcyBhbHJlYWR5IHRy
YW5zZmVycmVkIHNvbWUgZGF0YSBieSB0aGUgdGltZSBpdCBpcwo+ID4gaW50ZXJydXB0ZWQgYnkg
YSBzaWduYWwgaGFuZGxlciwKPiA+ICAgICAgICAgIHRoZW4gdGhlIGNhbGwgd2lsbCByZXR1cm4g
YSBzdWNjZXNzIHN0YXR1cyAobm9ybWFsbHksIHRoZQo+ID4gbnVtYmVyIG9mIGJ5dGVzIHRyYW5z
ZmVycmVkKS4gIE5vdGUgdGhhdCBhIChsb2NhbCkgZGlzayBpcyBub3QgYSBzbG93Cj4gPiBkZXZp
Y2UgYWNjb3JkaW5nIHRvIHRoaXMgZGVmaeKAkAo+ID4gICAgICAgICAgbml0aW9uOyBJL08gb3Bl
cmF0aW9ucyBvbiBkaXNrIGRldmljZXMgYXJlIG5vdCBpbnRlcnJ1cHRlZCBieSBzaWduYWxzLgo+
ID4gIiIiCj4KPgo+IEFuZCBub3RlIHRoYXQgaWYgeW91IGludGVycnVwdCB0aGVuIHlvdSBkb24n
dCBrbm93IHdoZXRoZXIgaW9jdGwKPiBjaGFuZ2VkIGRldmljZSBzdGF0ZSBvciBub3QgZ2VuZXJh
bGx5LgoKWWVzLgoKPiA+ID4KPiA+ID4KPiA+ID4KPiA+ID4gPiBBY3R1YWxseSwgYSBkcml2ZXIg
dGltZW91dCBpcyB1c2VkIGJ5IG90aGVyIGRyaXZlcnMgd2hlbiB1c2luZwo+ID4gPiA+IGNvbnRy
b2xxL2FkbWlucSAoZS5nIGk0MGUpLiBTdGFydGluZyBmcm9tIGEgc2FuZSB2YWx1ZSAoZS5nIDEg
bWludXRlcwo+ID4gPiA+IHRvIGF2b2lkIGZhbHNlIG5lZ2F0aXZlcykgc2VlbXMgdG8gYmUgYSBn
b29kIGZpcnN0IHN0ZXAuCj4gPiA+Cj4gPiA+IFdlbGwgYmVjYXVzZSBpdCdzIHNwZWNpZmljIGhh
cmR3YXJlIHNvIHRpbWVvdXQgbWF0Y2hlcyB3aGF0IGl0IGNhbgo+ID4gPiBwcm9taXNlLiAgdmly
dGlvIHNwZWMgZG9lcyBub3QgZ2l2ZSBndWFyYW50ZWVzLiAgT25lIGlzc3VlIGlzIHdpdGgKPiA+
ID4gc29mdHdhcmUgaW1wbGVtZW50YXRpb25zLiBBdCB0aGUgbW9tZW50IEkgY2FuIHNldCBhIGJy
ZWFrcG9pbnQgaW4gcWVtdQo+ID4gPiBvciB2aG9zdCB1c2VyIGJhY2tlbmQgYW5kIG5vdGhpbmcg
YmFkIGhhcHBlbnMgaW4ganVzdCBjb250aW51ZXMuCj4gPgo+ID4gWWVzIGJ1dCBpdCBzaG91bGQg
YmUgbm8gZGlmZmVyZW5jZSBmcm9tIHVzaW5nIGEga2dkYiB0byBkZWJ1ZyBpNDBlIGRyaXZlcnMu
Cj4KPiBFeGNlcHQgb25lIG9mIHRoZSByZWFzb25zIHBlb3BsZSBwcmVmZXIgcHJvZ3JhbW1pbmcg
aW4gdXNlcnNwYWNlIGlzCj4gYmVjYXVzZSBkZWJ1Z2dpbmcgaXMgc28gbXVjaCBsZXNzIHBhaW5m
dWwuIFNvbWVvbmUgdXNpbmcga2dkYgo+IGtub3dzIHdoYXQgZHJpdmVyIGlzIGRvaW5nIGFuZCBj
YW4gd29yayBhcm91bmQgdGhhdC4KCk9rLgoKPgo+ID4gPgo+ID4gPgo+ID4gPiA+ID4gVXNlcnNw
YWNlIGNvbnRyb2xzIHRoZSB0aW1lb3V0IGJ5Cj4gPiA+ID4gPiB1c2luZyBlLmcuIGFsYXJtKDIp
Lgo+ID4gPiA+Cj4gPiA+ID4gTm90IHVzZWQgaW4gaXByb3V0ZTIgYWZ0ZXIgYSBnaXQgZ3JlcC4K
PiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPgo+ID4gPiBObyBuZWVkIGZvciBpcHJvdXRlMiB0
byBkbyBpdCB1c2VyIGNhbiBqdXN0IGRvIGl0IGZyb20gc2hlbGwuIE9yIHVzZXIgY2FuIGp1c3Qg
cHJlc3MgQ1RSTC1DLgo+ID4KPiA+IFllcywgYnV0IGlwcm91dGUyIG5lZWRzIHRvIGRlYWwgd2l0
aCBFSU5UUiwgdGhhdCBpcyB0aGUgY2hhbGxlbmdlCj4gPiBwYXJ0LCBpZiB3ZSBzaW1wbHkgcmV0
dXJuIGFuIGVycm9yLCB0aGUgbmV4dCBjdnEgY29tbWFuZCBtaWdodCBnZXQKPiA+IGNvbmZ1c2Vk
Lgo+ID4KPiA+IFRoYW5rcwo+Cj4gWW91IG1lYW4gdGhpczoKPiAgICAgICAgIHN0YXJ0IGNvbW1h
bmQKPiAgICAgICAgIGludGVycnVwdAo+ICAgICAgICAgc3RhcnQgbmV4dCBjb21tYW5kCj4KPiA/
Cj4KPiBuZXh0IGNvbW1hbmQgaXMgY29uZnVzZWQ/Cj4gSSB0aGluayBpZiB5b3UgdHJ5IGEgbmV3
IGNvbW1hbmQgdW50aWwgcHJldmlvdXMKPiBvbmUgZmluaXNoZWQgaXQncyBvayB0byBqdXN0IHJl
dHVybiBFQlVTWS4KClRoYXQgd291bGQgYmUgZmluZS4KCkFuZCB3ZSBnbyBiYWNrIHRvIHNvbWVo
b3cgdGhlIGlkZWEgaGVyZToKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUNHa01FdlF3
aE9oZ0dXNkYyMiszdm1SNEFXOTBxWVhGK1pPNkJRWmd1VUYyeHQyU0FAbWFpbC5nbWFpbC5jb20v
VC8jbTJkYTYzOTMyZWFlNzc1ZDdkMDVkOTNkNDRjMmYxZDExNWZmYmNlZmUKCldpbGwgdHJ5IHRv
IGRvIHRoYXQgaW4gdGhlIG5leHQgdmVyc2lvbi4KClRoYW5rcwoKPgo+ID4gPgo+ID4gPiA+ID4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBBbmQgYmVmb3JlIHRoZSBwYXRjaCwgd2UgZW5kIHVwIHdpdGgg
YSByZWFsIGluZmluaXRlIGxvb3Agd2hpY2ggY291bGQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
YmUgY2F1Z2h0IGJ5IFJDVSBzdGFsbCBkZXRlY3RvciB3aGljaCBpcyBub3QgdGhlIGNhc2Ugb2Yg
dGhlIHNsZWVwLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXaGF0IHdlIGNhbiBkbyBpcyBwcm9i
YWJseSBkbyBhIHBlcmlvZGljIG5ldGRldl9lcnIoKS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gT25seSB3aXRoIGEgYmFkIGRldmljZS4KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAyLSBvdmVyaGVhZC4gSW4gYSB2
ZXJ5IGNvbW1vbiBzY2VuYXJpbyB3aGVuIGRldmljZSBpcyBpbiBoeXBlcnZpc29yLAo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAgIHByb2dyYW1taW5nIHRpbWVycyBldGMgaGFzIGEg
dmVyeSBoaWdoIG92ZXJoZWFkLCBhdCBib290dXAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
Pj4gICAgICBsb3RzIG9mIENWUSBjb21tYW5kcyBhcmUgcnVuIGFuZCBzbG93aW5nIGJvb3QgZG93
biBpcyBub3QgbmljZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gICAgICBsZXQncyBw
b2xsIGZvciBhIGJpdCBiZWZvcmUgd2FpdGluZz8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+IFRoZW4gd2UgZ28gYmFjayB0byB0aGUgcXVl
c3Rpb24gb2YgY2hvb3NpbmcgYSBnb29kIHRpbWVvdXQgZm9yIHBvbGwuIEFuZAo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4+IHBvbGwgc2VlbXMgcHJvYmxlbWF0aWMgaW4gdGhlIGNhc2Ugb2Yg
VVAsIHNjaGVkdWxlciBtaWdodCBub3QgaGF2ZSB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+PiBjaGFuY2UgdG8gcnVuLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gUG9sbCBqdXN0
IGEgYml0IDopIFNlcmlvdXNseSBJIGRvbid0IGtub3csIGJ1dCBhdCBsZWFzdCBjaGVjayBvbmNl
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhZnRlciBraWNrLgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBJIHRoaW5rIGl0IGlzIHdoYXQgdGhlIGN1cnJlbnQgY29kZSBkaWQgd2hlcmUgdGhlIGNv
bmRpdGlvbiB3aWxsIGJlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gY2hlY2sgYmVmb3JlIHRy
eWluZyB0byBzbGVlcCBpbiB0aGUgd2FpdF9ldmVudCgpLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+IDMtIHN1cHJpc2UgcmVtb3ZhbC4gbmVlZCB0
byB3YWtlIHVwIHRocmVhZCBpbiBzb21lIHdheS4gd2hhdCBhYm91dAo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4+PiAgICAgIG90aGVyIGNhc2VzIG9mIGRldmljZSBicmVha2FnZSAtIGlzIHRo
ZXJlIGEgY2hhbmNlIHRoaXMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gICAgICBpbnRy
b2R1Y2VzIG5ldyBidWdzIGFyb3VuZCB0aGF0PyBhdCBsZWFzdCBlbnVtZXJhdGUgdGhlbSBwbGVh
c2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+PiBUaGUgY3VycmVudCBjb2RlIGRpZDoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+IDEpIGNoZWNrIGZvciB2cS0+YnJva2VuCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4gMikgd2FrZXVwIGR1cmluZyBCQURfUklORygpCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiBTbyB3
ZSB3b24ndCBlbmQgdXAgd2l0aCBhIG5ldmVyIHdva2UgdXAgcHJvY2VzcyB3aGljaCBzaG91bGQg
YmUgZmluZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4+IFRoYW5rcwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IEJUVyBCQURfUklORyBvbiByZW1vdmFsIHdpbGwgdHJpZ2dlciBkZXZf
ZXJyLiBOb3Qgc3VyZSB0aGF0IGlzIGEgZ29vZAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
aWRlYSAtIGNhbiBjYXVzZSBjcmFzaGVzIGlmIGtlcm5lbCBwYW5pY3Mgb24gZXJyb3IuCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IFllcywgaXQncyBiZXR0ZXIgdG8gdXNlIF9fdmlydHF1ZXVlX2JyZWFr
KCkgaW5zdGVhZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IEJ1dCBjb25zaWRlciB3ZSB3aWxsIHN0YXJ0IGZyb20gYSB3YWl0IGZpcnN0LCBJIHdp
bGwgbGltaXQgdGhlIGNoYW5nZXMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBpbiB2aXJ0aW8t
bmV0IHdpdGhvdXQgYm90aGVyaW5nIHZpcnRpbyBjb3JlLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+Cj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
