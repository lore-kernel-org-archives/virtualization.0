Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCB0C54EAA
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 07:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 902E34155E;
	Mon, 30 Jan 2023 07:44:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 902E34155E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KU/jUBFy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H-Hsw1SAUgqZ; Mon, 30 Jan 2023 07:44:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E10CC4154A;
	Mon, 30 Jan 2023 07:44:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E10CC4154A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1A6EC0032;
	Mon, 30 Jan 2023 07:44:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC289C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 07:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9093D8175E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 07:44:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9093D8175E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KU/jUBFy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TnIUugJVs01I
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 07:44:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 013A08175A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 013A08175A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 07:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675064678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IfsxRwrwu42vZaiOw4wSj9ooVENnKFYCWw2J/v4KL84=;
 b=KU/jUBFy6W+zfX0LRIOSlS1608F6aRe+qOtEszk4g7Q5KS6NiYjtbt7m0AzjYC1IA+fd0Q
 Y7jOfXalAMMUk6rMOGKA9rTzB6RpUDrEfz2rtoNyDGmI1e9R8OfxCAJzXJeXYd4VyktdmN
 nLhAMtOqH+DNYMw8iFXkrBK16pC64HI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54-vpNqJxCLPBOeQksbXHiAgw-1; Mon, 30 Jan 2023 02:44:37 -0500
X-MC-Unique: vpNqJxCLPBOeQksbXHiAgw-1
Received: by mail-oi1-f197.google.com with SMTP id
 o206-20020acad7d7000000b00375c9d6b919so4351049oig.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 23:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IfsxRwrwu42vZaiOw4wSj9ooVENnKFYCWw2J/v4KL84=;
 b=VWtFBZwEZQcd1xAXDAu0cs8Y1KPWZFdbzP2R5JoAVSSZh+p7JPXUXKFnBoQXRD1tqh
 jPm9qlOyzC7KIMTXDp+3p9klGuhQSmFE08IQ0gQd+rtQAE/o2XhYYBZ5Pei09zGtZaMm
 NiosUqITjwzLvlLbWQkyBngDOtrWc5V0v2poMUbIA5vz7c7Y0f3ZfU0EBTTiSAmML3mR
 Aqr77831gqZagOwRIYufIqmSXVyIGO0ysxtwhgO6eYG4E/GWPE2/4XDoWGBBLsBWxupv
 7Q/MoPygaYbPcgESvoWAmJLkRwspllF5G/ZcGY5RGkYGtHa5NdsXlQ7eSJTY5Hi5SF72
 ik/g==
X-Gm-Message-State: AO0yUKXcGhJkgUQRNIA6WuqAwV4I+jsbN/rtFXE8phjgxbvHdLQUPLiA
 0qgWPencMkP1dmESMr5EsifK7Mgt1OCs4jxn+UWRitsJ/QQSUMS4YOuoSWuu0Doymecdap4KnP3
 y0RmAj4VZIZdCf8asuSC2gXWRZir8n/pMG5xjxYt9jgQEvfVRdC0LeJ2zfw==
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr296172oao.35.1675064675696; 
 Sun, 29 Jan 2023 23:44:35 -0800 (PST)
X-Google-Smtp-Source: AK7set+aQPAKyAPfHNJ0Xk76LMscbAi71N7VBp8BSAhSQ5QVi89w2CuqgyJztGEUVEEMiWNskmo6eTc++9HGfQU0UPw=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr296160oao.35.1675064675326; Sun, 29 Jan
 2023 23:44:35 -0800 (PST)
MIME-Version: 1.0
References: <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
 <20221229020553-mutt-send-email-mst@kernel.org>
 <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
 <20221229030633-mutt-send-email-mst@kernel.org>
 <CACGkMEukqZX=6yz1yCj+psHp5c+ZGVVuEYTUssfRCTQZgVWS6g@mail.gmail.com>
 <20230127053112-mutt-send-email-mst@kernel.org>
 <CACGkMEsZs=6TaeSUnu_9Rf+38uisi6ViHyM50=2+ut3Wze2S1g@mail.gmail.com>
 <20230129022809-mutt-send-email-mst@kernel.org>
 <CACGkMEuya+_2P8d4hokoyL_LKGdVzyCC1nDwOCdZb0=+2rjKPQ@mail.gmail.com>
 <20230130003334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230130003334-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 30 Jan 2023 15:44:24 +0800
Message-ID: <CACGkMEu0v-kbh2vKvcDRoMsRoXwidPnQhiFetYPY-tXOAVScsg@mail.gmail.com>
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

T24gTW9uLCBKYW4gMzAsIDIwMjMgYXQgMTo0MyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgSmFuIDMwLCAyMDIzIGF0IDEwOjUzOjU0QU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBTdW4sIEphbiAyOSwgMjAyMyBhdCAzOjMw
IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBTdW4sIEphbiAyOSwgMjAyMyBhdCAwMTo0ODo0OVBNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+IE9uIEZyaSwgSmFuIDI3LCAyMDIzIGF0IDY6MzUgUE0gTWljaGFlbCBTLiBU
c2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gRnJp
LCBEZWMgMzAsIDIwMjIgYXQgMTE6NDM6MDhBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+
ID4gPiA+ID4gT24gVGh1LCBEZWMgMjksIDIwMjIgYXQgNDoxMCBQTSBNaWNoYWVsIFMuIFRzaXJr
aW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE9u
IFRodSwgRGVjIDI5LCAyMDIyIGF0IDA0OjA0OjEzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIERlYyAyOSwgMjAyMiBhdCAzOjA3IFBNIE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiBPbiBXZWQsIERlYyAyOCwgMjAyMiBhdCAwNzo1MzowOFBNICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFdlZCwgRGVjIDI4LCAyMDIy
IGF0IDI6MzQgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IOWcqCAyMDIyLzEyLzI3IDE3OjM4LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIERlYyAyNywgMjAyMiBhdCAwNToxMjo1OFBNICsw
ODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4g5ZyoIDIwMjIv
MTIvMjcgMTU6MzMsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+Pj4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMTI6MzA6MzVQTSArMDgwMCwgSmFzb24g
V2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+IEJ1dCBkZXZpY2UgaXMgc3Rp
bGwgZ29pbmcgYW5kIHdpbGwgbGF0ZXIgdXNlIHRoZSBidWZmZXJzLgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPj4+Pj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+IFNhbWUgZm9yIHRpbWVvdXQg
cmVhbGx5Lgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+PiBBdm9pZGluZyBpbmZpbml0ZSB3YWl0
L3BvbGwgaXMgb25lIG9mIHRoZSBnb2FscywgYW5vdGhlciBpcyB0byBzbGVlcC4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4+Pj4gSWYgd2UgdGhpbmsgdGhlIHRpbWVvdXQgaXMgaGFyZCwgd2UgY2Fu
IHN0YXJ0IGZyb20gdGhlIHdhaXQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+Pj4+IFRoYW5rcwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+IElmIHRo
ZSBnb2FsIGlzIHRvIGF2b2lkIGRpc3J1cHRpbmcgdHJhZmZpYyB3aGlsZSBDVlEgaXMgaW4gdXNl
LAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+IHRoYXQgc291bmRzIG1vcmUgcmVhc29uYWJsZS4g
RS5nLiBzb21lb25lIGlzIHR1cm5pbmcgb24gcHJvbWlzYywKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4+PiBhIHNwaWtlIGluIENQVSB1c2FnZSBtaWdodCBiZSB1bndlbGNvbWUuCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4gWWVzLCB0aGlzIHdvdWxkIGJl
IG1vcmUgb2J2aW91cyBpcyBVUCBpcyB1c2VkLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gdGhpbmdzIHdl
IHNob3VsZCBiZSBjYXJlZnVsIHRvIGFkZHJlc3MgdGhlbjoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4+PiAxLSBkZWJ1Z2dpbmcuIEN1cnJlbnRseSBpdCdzIGVhc3kgdG8gc2VlIGEgd2FybmluZyBp
ZiBDUFUgaXMgc3R1Y2sKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAgIGluIGEgbG9vcCBm
b3IgYSB3aGlsZSwgYW5kIHdlIGFsc28gZ2V0IGEgYmFja3RyYWNlLgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPj4+ICAgICAgRS5nLiB3aXRoIHRoaXMgLSBob3cgZG8gd2Uga25vdyB3aG8gaGFzIHRo
ZSBSVE5MPwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgV2UgbmVlZCB0byBpbnRlZ3Jh
dGUgd2l0aCBrZXJuZWwvd2F0Y2hkb2cuYyBmb3IgZ29vZCByZXN1bHRzCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+Pj4gICAgICBhbmQgdG8gbWFrZSBzdXJlIHBvbGljeSBpcyBjb25zaXN0ZW50Lgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+IFRoYXQncyBm
aW5lLCB3aWxsIGNvbnNpZGVyIHRoaXMuCj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gPiBTbyBhZnRlciBzb21lIGludmVzdGlnYXRpb24sIGl0IHNlZW1zIHRoZSB3YXRjaGRv
Zy5jIGRvZXNuJ3QgaGVscC4gVGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gb25seSBleHBvcnQgaGVs
cGVyIGlzIHRvdWNoX3NvZnRsb2NrdXBfd2F0Y2hkb2coKSB3aGljaCB0cmllcyB0byBhdm9pZAo+
ID4gPiA+ID4gPiA+ID4gPiA+IHRyaWdnZXJpbmcgdGhlIGxvY2t1cHMgd2FybmluZyBmb3IgdGhl
IGtub3duIHNsb3cgcGF0aC4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gSSBu
ZXZlciBzYWlkIHlvdSBjYW4ganVzdCB1c2UgZXhpc3RpbmcgZXhwb3J0aW5nIEFQSXMuIFlvdSds
bCBoYXZlIHRvCj4gPiA+ID4gPiA+ID4gPiA+IHdyaXRlIG5ldyBvbmVzIDopCj4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gT2ssIEkgdGhvdWdodCB5b3Ugd2FudGVkIHRvIHRyaWdnZXIg
c2ltaWxhciB3YXJuaW5ncyBhcyBhIHdhdGNoZG9nLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+IEJ0dywgSSB3b25kZXIgd2hhdCBraW5kIG9mIGxvZ2ljIHlvdSB3YW50IGhlcmUuIElm
IHdlIHN3aXRjaCB0byB1c2luZwo+ID4gPiA+ID4gPiA+ID4gc2xlZXAsIHRoZXJlIHdvbid0IGJl
IHNvZnQgbG9ja3VwIGFueW1vcmUuIEEgc2ltcGxlIHdhaXQgKyB0aW1lb3V0ICsKPiA+ID4gPiA+
ID4gPiA+IHdhcm5pbmcgc2VlbXMgc3VmZmljaWVudD8KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEknZCBsaWtlIHRvIGF2
b2lkIG5lZWQgdG8gdGVhY2ggdXNlcnMgbmV3IEFQSXMuIFNvIHdhdGNoZG9nIHNldHVwIHRvIGFw
cGx5Cj4gPiA+ID4gPiA+ID4gdG8gdGhpcyBkcml2ZXIuIFRoZSB3YXJuaW5nIGNhbiBiZSBkaWZm
ZXJlbnQuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFJpZ2h0LCBzbyBpdCBsb29rcyB0byBtZSB0
aGUgb25seSBwb3NzaWJsZSBzZXR1cCBpcyB0aGUKPiA+ID4gPiA+ID4gd2F0Y2hkb2dfdGhyZXMu
IEkgcGxhbiB0byB0cmlnZ2VyIHRoZSB3YXJuaW5nIGV2ZXJ5IHdhdGNoZG9nX3RocmVzICogMgo+
ID4gPiA+ID4gPiBzZWNvbmQgKGFzIHNvZnRsb2NrdXAgZGlkKS4KPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gQW5kIEkgdGhpbmsgaXQgd291bGQgc3RpbGwgbWFrZSBzZW5zZSB0byBmYWlsLCB3ZSBj
YW4gc3RhcnQgd2l0aCBhCj4gPiA+ID4gPiA+IHZlcnkgbG9uZyB0aW1lb3V0IGxpa2UgMSBtaW51
dGVzIGFuZCBicmVhayB0aGUgZGV2aWNlLiBEb2VzIHRoaXMgbWFrZQo+ID4gPiA+ID4gPiBzZW5z
ZT8KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPgo+ID4gPiA+ID4gSSdk
IHNheSB3ZSBuZWVkIHRvIG1ha2UgdGhpcyBtYW5hZ2VhYmxlIHRoZW4uCj4gPiA+ID4KPiA+ID4g
PiBEaWQgeW91IG1lYW4gc29tZXRoaW5nIGxpa2Ugc3lzZnMgb3IgbW9kdWxlIHBhcmFtZXRlcnM/
Cj4gPiA+Cj4gPiA+IE5vIEknZCBzYXkgcGFzcyBpdCB3aXRoIGFuIGlvY3RsLgo+ID4gPgo+ID4g
PiA+ID4gQ2FuJ3Qgd2UgZG8gaXQgbm9ybWFsbHkKPiA+ID4gPiA+IGUuZy4gcmVhY3QgdG8gYW4g
aW50ZXJydXB0IHRvIHJldHVybiB0byB1c2Vyc3BhY2U/Cj4gPiA+ID4KPiA+ID4gPiBJIGRpZG4n
dCBnZXQgdGhlIG1lYW5pbmcgb2YgdGhpcy4gU29ycnkuCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MK
PiA+ID4KPiA+ID4gU3RhbmRhcmQgd2F5IHRvIGhhbmRsZSB0aGluZ3MgdGhhdCBjYW4gdGltZW91
dCBhbmQgd2hlcmUgdXNlcnNwYWNlCj4gPiA+IGRpZCBub3Qgc3VwcGx5IHRoZSB0aW1lIGlzIHRv
IGJsb2NrIHVudGlsIGFuIGludGVycnVwdAo+ID4gPiB0aGVuIHJldHVybiBFSU5UUi4KPiA+Cj4g
PiBXZWxsIHRoaXMgc2VlbXMgdG8gYmUgYSBodWdlIGNoYW5nZSwgaW9jdGwoMikgZG9lc24ndCBz
YXkgaXQgY2FuCj4gPiByZXR1cm4gRUlOVFIgbm93Lgo+Cj4gdGhlIG9uZSBvbiBmZWRvcmEgMzcg
ZG9lcyBub3QgYnV0IGl0IHNheXM6Cj4gICAgICAgIE5vIHNpbmdsZSBzdGFuZGFyZC4gIEFyZ3Vt
ZW50cywgcmV0dXJucywgYW5kIHNlbWFudGljcyBvZiBpb2N0bCgpIHZhcnkgYWNjb3JkaW5nIHRv
IHRoZSBkZXZpY2UgZHJpdmVyIGluIHF1ZXN0aW9uICh0aGUgY2FsbCAgaXMKPiAgICAgICAgdXNl
ZCBhcyBhIGNhdGNoLWFsbCBmb3Igb3BlcmF0aW9ucyB0aGF0IGRvbid0IGNsZWFubHkgZml0IHRo
ZSBVTklYIHN0cmVhbSBJL08gbW9kZWwpLgo+Cj4gc28gaXQgZGVwZW5kcyBvbiB0aGUgZGV2aWNl
IGUuZy4gZm9yIGEgc3RyZWFtcyBkZXZpY2UgaXQgZG9lczoKPiBodHRwczovL3B1YnMub3Blbmdy
b3VwLm9yZy9vbmxpbmVwdWJzLzk2OTk5MTk3OTkvZnVuY3Rpb25zL2lvY3RsLmh0bWwKPiBoYXMg
RUlOVFIuCgpPaywgSSBzYXcgc2lnbmFsKDcpIGFsc28gbWVudGlvbiBhYm91dCBFSU5UUiBmb3Ig
aW9jdGwoMik6CgoiIiIKICAgICAgIElmICBhICBibG9ja2VkIGNhbGwgdG8gb25lIG9mIHRoZSBm
b2xsb3dpbmcgaW50ZXJmYWNlcyBpcwppbnRlcnJ1cHRlZCBieSBhIHNpZ25hbCBoYW5kbGVyLCB0
aGVuIHRoZSBjYWxsIGlzIGF1dG9tYXRpY2FsbHkKcmVzdGFydGVkIGFmdGVyIHRoZSBzaWduYWwg
aGFuZGxlciByZeKAkAogICAgICAgdHVybnMgaWYgdGhlIFNBX1JFU1RBUlQgZmxhZyB3YXMgdXNl
ZDsgb3RoZXJ3aXNlIHRoZSBjYWxsIGZhaWxzCndpdGggdGhlIGVycm9yIEVJTlRSOgoKICAgICAg
ICogcmVhZCgyKSwgcmVhZHYoMiksIHdyaXRlKDIpLCB3cml0ZXYoMiksIGFuZCBpb2N0bCgyKSBj
YWxscyBvbgoic2xvdyIgZGV2aWNlcy4gIEEgInNsb3ciIGRldmljZSBpcyBvbmUgd2hlcmUgdGhl
IEkvTyBjYWxsIG1heSBibG9jawpmb3IgYW4gaW5kZWZpbml0ZSB0aW1lLCBmb3IKICAgICAgICAg
ZXhhbXBsZSwgIGEgIHRlcm1pbmFsLCAgcGlwZSwgb3Igc29ja2V0LiAgSWYgYW4gSS9PIGNhbGwg
b24gYQpzbG93IGRldmljZSBoYXMgYWxyZWFkeSB0cmFuc2ZlcnJlZCBzb21lIGRhdGEgYnkgdGhl
IHRpbWUgaXQgaXMKaW50ZXJydXB0ZWQgYnkgYSBzaWduYWwgaGFuZGxlciwKICAgICAgICAgdGhl
biB0aGUgY2FsbCB3aWxsIHJldHVybiBhIHN1Y2Nlc3Mgc3RhdHVzIChub3JtYWxseSwgdGhlCm51
bWJlciBvZiBieXRlcyB0cmFuc2ZlcnJlZCkuICBOb3RlIHRoYXQgYSAobG9jYWwpIGRpc2sgaXMg
bm90IGEgc2xvdwpkZXZpY2UgYWNjb3JkaW5nIHRvIHRoaXMgZGVmaeKAkAogICAgICAgICBuaXRp
b247IEkvTyBvcGVyYXRpb25zIG9uIGRpc2sgZGV2aWNlcyBhcmUgbm90IGludGVycnVwdGVkIGJ5
IHNpZ25hbHMuCiIiIgoKPgo+Cj4KPiA+IEFjdHVhbGx5LCBhIGRyaXZlciB0aW1lb3V0IGlzIHVz
ZWQgYnkgb3RoZXIgZHJpdmVycyB3aGVuIHVzaW5nCj4gPiBjb250cm9scS9hZG1pbnEgKGUuZyBp
NDBlKS4gU3RhcnRpbmcgZnJvbSBhIHNhbmUgdmFsdWUgKGUuZyAxIG1pbnV0ZXMKPiA+IHRvIGF2
b2lkIGZhbHNlIG5lZ2F0aXZlcykgc2VlbXMgdG8gYmUgYSBnb29kIGZpcnN0IHN0ZXAuCj4KPiBX
ZWxsIGJlY2F1c2UgaXQncyBzcGVjaWZpYyBoYXJkd2FyZSBzbyB0aW1lb3V0IG1hdGNoZXMgd2hh
dCBpdCBjYW4KPiBwcm9taXNlLiAgdmlydGlvIHNwZWMgZG9lcyBub3QgZ2l2ZSBndWFyYW50ZWVz
LiAgT25lIGlzc3VlIGlzIHdpdGgKPiBzb2Z0d2FyZSBpbXBsZW1lbnRhdGlvbnMuIEF0IHRoZSBt
b21lbnQgSSBjYW4gc2V0IGEgYnJlYWtwb2ludCBpbiBxZW11Cj4gb3Igdmhvc3QgdXNlciBiYWNr
ZW5kIGFuZCBub3RoaW5nIGJhZCBoYXBwZW5zIGluIGp1c3QgY29udGludWVzLgoKWWVzIGJ1dCBp
dCBzaG91bGQgYmUgbm8gZGlmZmVyZW5jZSBmcm9tIHVzaW5nIGEga2dkYiB0byBkZWJ1ZyBpNDBl
IGRyaXZlcnMuCgo+Cj4KPiA+ID4gVXNlcnNwYWNlIGNvbnRyb2xzIHRoZSB0aW1lb3V0IGJ5Cj4g
PiA+IHVzaW5nIGUuZy4gYWxhcm0oMikuCj4gPgo+ID4gTm90IHVzZWQgaW4gaXByb3V0ZTIgYWZ0
ZXIgYSBnaXQgZ3JlcC4KPiA+Cj4gPiBUaGFua3MKPgo+IE5vIG5lZWQgZm9yIGlwcm91dGUyIHRv
IGRvIGl0IHVzZXIgY2FuIGp1c3QgZG8gaXQgZnJvbSBzaGVsbC4gT3IgdXNlciBjYW4ganVzdCBw
cmVzcyBDVFJMLUMuCgpZZXMsIGJ1dCBpcHJvdXRlMiBuZWVkcyB0byBkZWFsIHdpdGggRUlOVFIs
IHRoYXQgaXMgdGhlIGNoYWxsZW5nZQpwYXJ0LCBpZiB3ZSBzaW1wbHkgcmV0dXJuIGFuIGVycm9y
LCB0aGUgbmV4dCBjdnEgY29tbWFuZCBtaWdodCBnZXQKY29uZnVzZWQuCgpUaGFua3MKCj4KPiA+
ID4KPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gQW5kIGJlZm9y
ZSB0aGUgcGF0Y2gsIHdlIGVuZCB1cCB3aXRoIGEgcmVhbCBpbmZpbml0ZSBsb29wIHdoaWNoIGNv
dWxkCj4gPiA+ID4gPiA+ID4gPiA+ID4gYmUgY2F1Z2h0IGJ5IFJDVSBzdGFsbCBkZXRlY3RvciB3
aGljaCBpcyBub3QgdGhlIGNhc2Ugb2YgdGhlIHNsZWVwLgo+ID4gPiA+ID4gPiA+ID4gPiA+IFdo
YXQgd2UgY2FuIGRvIGlzIHByb2JhYmx5IGRvIGEgcGVyaW9kaWMgbmV0ZGV2X2VycigpLgo+ID4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+IE9ubHkgd2l0aCBhIGJhZCBkZXZpY2UuCj4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAyLSBvdmVyaGVhZC4gSW4gYSB2ZXJ5IGNvbW1vbiBz
Y2VuYXJpbyB3aGVuIGRldmljZSBpcyBpbiBoeXBlcnZpc29yLAo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPj4+ICAgICAgcHJvZ3JhbW1pbmcgdGltZXJzIGV0YyBoYXMgYSB2ZXJ5IGhpZ2ggb3Zlcmhl
YWQsIGF0IGJvb3R1cAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgbG90cyBvZiBDVlEg
Y29tbWFuZHMgYXJlIHJ1biBhbmQgc2xvd2luZyBib290IGRvd24gaXMgbm90IG5pY2UuCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+Pj4gICAgICBsZXQncyBwb2xsIGZvciBhIGJpdCBiZWZvcmUgd2Fp
dGluZz8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiBU
aGVuIHdlIGdvIGJhY2sgdG8gdGhlIHF1ZXN0aW9uIG9mIGNob29zaW5nIGEgZ29vZCB0aW1lb3V0
IGZvciBwb2xsLiBBbmQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+IHBvbGwgc2VlbXMgcHJvYmxl
bWF0aWMgaW4gdGhlIGNhc2Ugb2YgVVAsIHNjaGVkdWxlciBtaWdodCBub3QgaGF2ZSB0aGUKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4+IGNoYW5jZSB0byBydW4uCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IFBvbGwganVzdCBhIGJpdCA6KSBTZXJpb3VzbHkgSSBkb24ndCBrbm93LCBidXQgYXQgbGVh
c3QgY2hlY2sgb25jZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhZnRlciBraWNrLgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBJIHRoaW5rIGl0IGlzIHdoYXQgdGhlIGN1cnJlbnQgY29kZSBkaWQgd2hlcmUgdGhlIGNvbmRp
dGlvbiB3aWxsIGJlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjaGVjayBiZWZvcmUgdHJ5aW5nIHRv
IHNsZWVwIGluIHRoZSB3YWl0X2V2ZW50KCkuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4+PiAzLSBzdXByaXNlIHJlbW92YWwuIG5lZWQgdG8gd2FrZSB1cCB0aHJlYWQgaW4gc29t
ZSB3YXkuIHdoYXQgYWJvdXQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAgIG90aGVyIGNh
c2VzIG9mIGRldmljZSBicmVha2FnZSAtIGlzIHRoZXJlIGEgY2hhbmNlIHRoaXMKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4+PiAgICAgIGludHJvZHVjZXMgbmV3IGJ1Z3MgYXJvdW5kIHRoYXQ/IGF0
IGxlYXN0IGVudW1lcmF0ZSB0aGVtIHBsZWFzZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+PiBUaGUgY3VycmVudCBjb2RlIGRpZDoKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiAxKSBjaGVjayBmb3IgdnEtPmJy
b2tlbgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4gMikgd2FrZXVwIGR1cmluZyBCQURfUklORygp
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4gU28gd2Ug
d29uJ3QgZW5kIHVwIHdpdGggYSBuZXZlciB3b2tlIHVwIHByb2Nlc3Mgd2hpY2ggc2hvdWxkIGJl
IGZpbmUuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4g
VGhhbmtzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEJU
VyBCQURfUklORyBvbiByZW1vdmFsIHdpbGwgdHJpZ2dlciBkZXZfZXJyLiBOb3Qgc3VyZSB0aGF0
IGlzIGEgZ29vZAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBpZGVhIC0gY2FuIGNhdXNlIGNyYXNo
ZXMgaWYga2VybmVsIHBhbmljcyBvbiBlcnJvci4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gWWVzLCBpdCdzIGJldHRlciB0
byB1c2UgX192aXJ0cXVldWVfYnJlYWsoKSBpbnN0ZWFkLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IEJ1dCBjb25zaWRlciB3ZSB3aWxsIHN0YXJ0IGZyb20gYSB3
YWl0IGZpcnN0LCBJIHdpbGwgbGltaXQgdGhlIGNoYW5nZXMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IGluIHZpcnRpby1uZXQgd2l0aG91dCBib3RoZXJpbmcgdmlydGlvIGNvcmUuCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4+Pgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPgo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
