Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73268C4332F
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 08:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E47D280B86;
	Thu, 29 Dec 2022 08:04:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E47D280B86
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AsTHT1XG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ci9MtJg-38CY; Thu, 29 Dec 2022 08:04:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 38C4880B4D;
	Thu, 29 Dec 2022 08:04:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38C4880B4D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A9B9C0033;
	Thu, 29 Dec 2022 08:04:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE938C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 08:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B911A40179
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 08:04:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B911A40179
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AsTHT1XG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kSAwYIXJhcZK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 08:04:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AD4240122
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AD4240122
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 08:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672301067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vle3ibqeQcUc3o0c9rRrl2gAzdgVWVtbpb/9M/RDS4Q=;
 b=AsTHT1XGIRKj463Nf7Un8a8YVwu4dMN39IcB2RphMIpQCbnwy0X8F9aF77xqp4ERnEtPiK
 pPtGZ+FeoZ/fkZLJrIscNI49GAxOp11eYVj2t6kJVhTl9gDgxs1gPSWSPTBRzWevre4uJQ
 bZ3TsF+FSxMgTiXg9UJ0/3iB0NUrgnA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-232-ZgTPxAdkNieXgNxP9JQVtQ-1; Thu, 29 Dec 2022 03:04:25 -0500
X-MC-Unique: ZgTPxAdkNieXgNxP9JQVtQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-144a21f5c25so8346557fac.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 00:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vle3ibqeQcUc3o0c9rRrl2gAzdgVWVtbpb/9M/RDS4Q=;
 b=1LjrJOWY39yIDlrrkwvvyk+PrlwayI3Fc0nGKD5oMao60LSTBkxw6U+shIF0TC1sAS
 OmjxrbLQMQmiI286V2iaquCVSCjb3HD8lzSLNJ5lL54NpikzhrLk0xlsha9zDSoPnI/W
 Dtxx46/YvTv8VTB2UrQZVjxFAlgJuvaJ8ScMrGC2CRYbUs6OBS02XlR8VnOuyLmtCZvJ
 +u3rxfNLk6r/NWFgaphPXlM/q4oZTE1bIgb+hIaORqK8Sd80V7JHkzb3DRS3EaPf3Bv4
 GDxhhUmeiRH8j7xdse4sC7hugHiqmbCml6y1zNrlgoFxd7Hd2UegRQmakk9jGXjJ38M4
 sG2Q==
X-Gm-Message-State: AFqh2kqHu4Id+J1Zw8nT3H2SNREnRQq9ADycyQtVPtr4MkXai7qlbGzY
 7HM4y5QpTZie838qah2Tr/rxI0xxKwQanVktKaVtrLC/fgEN5Rjh9ex8/KMrHJ2ksr0CYFShB7d
 A9pTGL1L4hLOfhNZ+2CRo+yTQQhs/raYUfv1gbN2QOWYMXA7FpwaUrfXB9Q==
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr1472680oir.280.1672301065020; 
 Thu, 29 Dec 2022 00:04:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvP44RmCToT51pJfyvWSPl3P4STkPSA7vMDACFHHl+aDZ9sWlAE+dF2c1pbK85ZI5ctd6sscLzOaVLzM2bPnB0=
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr1472673oir.280.1672301064783; Thu, 29
 Dec 2022 00:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
 <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org>
 <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
 <20221229020553-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221229020553-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Dec 2022 16:04:13 +0800
Message-ID: <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
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

T24gVGh1LCBEZWMgMjksIDIwMjIgYXQgMzowNyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgRGVjIDI4LCAyMDIyIGF0IDA3OjUzOjA4UE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBXZWQsIERlYyAyOCwgMjAyMiBhdCAyOjM0
IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPgo+
ID4gPiDlnKggMjAyMi8xMi8yNyAxNzozOCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+
ID4gPiBPbiBUdWUsIERlYyAyNywgMjAyMiBhdCAwNToxMjo1OFBNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiA+PiDlnKggMjAyMi8xMi8yNyAxNTozMywgTWljaGFlbCBTLiBUc2lya2lu
IOWGmemBkzoKPiA+ID4gPj4+IE9uIFR1ZSwgRGVjIDI3LCAyMDIyIGF0IDEyOjMwOjM1UE0gKzA4
MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4+Pj4+IEJ1dCBkZXZpY2UgaXMgc3RpbGwgZ29p
bmcgYW5kIHdpbGwgbGF0ZXIgdXNlIHRoZSBidWZmZXJzLgo+ID4gPiA+Pj4+Pgo+ID4gPiA+Pj4+
PiBTYW1lIGZvciB0aW1lb3V0IHJlYWxseS4KPiA+ID4gPj4+PiBBdm9pZGluZyBpbmZpbml0ZSB3
YWl0L3BvbGwgaXMgb25lIG9mIHRoZSBnb2FscywgYW5vdGhlciBpcyB0byBzbGVlcC4KPiA+ID4g
Pj4+PiBJZiB3ZSB0aGluayB0aGUgdGltZW91dCBpcyBoYXJkLCB3ZSBjYW4gc3RhcnQgZnJvbSB0
aGUgd2FpdC4KPiA+ID4gPj4+Pgo+ID4gPiA+Pj4+IFRoYW5rcwo+ID4gPiA+Pj4gSWYgdGhlIGdv
YWwgaXMgdG8gYXZvaWQgZGlzcnVwdGluZyB0cmFmZmljIHdoaWxlIENWUSBpcyBpbiB1c2UsCj4g
PiA+ID4+PiB0aGF0IHNvdW5kcyBtb3JlIHJlYXNvbmFibGUuIEUuZy4gc29tZW9uZSBpcyB0dXJu
aW5nIG9uIHByb21pc2MsCj4gPiA+ID4+PiBhIHNwaWtlIGluIENQVSB1c2FnZSBtaWdodCBiZSB1
bndlbGNvbWUuCj4gPiA+ID4+Cj4gPiA+ID4+IFllcywgdGhpcyB3b3VsZCBiZSBtb3JlIG9idmlv
dXMgaXMgVVAgaXMgdXNlZC4KPiA+ID4gPj4KPiA+ID4gPj4KPiA+ID4gPj4+IHRoaW5ncyB3ZSBz
aG91bGQgYmUgY2FyZWZ1bCB0byBhZGRyZXNzIHRoZW46Cj4gPiA+ID4+PiAxLSBkZWJ1Z2dpbmcu
IEN1cnJlbnRseSBpdCdzIGVhc3kgdG8gc2VlIGEgd2FybmluZyBpZiBDUFUgaXMgc3R1Y2sKPiA+
ID4gPj4+ICAgICAgaW4gYSBsb29wIGZvciBhIHdoaWxlLCBhbmQgd2UgYWxzbyBnZXQgYSBiYWNr
dHJhY2UuCj4gPiA+ID4+PiAgICAgIEUuZy4gd2l0aCB0aGlzIC0gaG93IGRvIHdlIGtub3cgd2hv
IGhhcyB0aGUgUlROTD8KPiA+ID4gPj4+ICAgICAgV2UgbmVlZCB0byBpbnRlZ3JhdGUgd2l0aCBr
ZXJuZWwvd2F0Y2hkb2cuYyBmb3IgZ29vZCByZXN1bHRzCj4gPiA+ID4+PiAgICAgIGFuZCB0byBt
YWtlIHN1cmUgcG9saWN5IGlzIGNvbnNpc3RlbnQuCj4gPiA+ID4+Cj4gPiA+ID4+IFRoYXQncyBm
aW5lLCB3aWxsIGNvbnNpZGVyIHRoaXMuCj4gPgo+ID4gU28gYWZ0ZXIgc29tZSBpbnZlc3RpZ2F0
aW9uLCBpdCBzZWVtcyB0aGUgd2F0Y2hkb2cuYyBkb2Vzbid0IGhlbHAuIFRoZQo+ID4gb25seSBl
eHBvcnQgaGVscGVyIGlzIHRvdWNoX3NvZnRsb2NrdXBfd2F0Y2hkb2coKSB3aGljaCB0cmllcyB0
byBhdm9pZAo+ID4gdHJpZ2dlcmluZyB0aGUgbG9ja3VwcyB3YXJuaW5nIGZvciB0aGUga25vd24g
c2xvdyBwYXRoLgo+Cj4gSSBuZXZlciBzYWlkIHlvdSBjYW4ganVzdCB1c2UgZXhpc3RpbmcgZXhw
b3J0aW5nIEFQSXMuIFlvdSdsbCBoYXZlIHRvCj4gd3JpdGUgbmV3IG9uZXMgOikKCk9rLCBJIHRo
b3VnaHQgeW91IHdhbnRlZCB0byB0cmlnZ2VyIHNpbWlsYXIgd2FybmluZ3MgYXMgYSB3YXRjaGRv
Zy4KCkJ0dywgSSB3b25kZXIgd2hhdCBraW5kIG9mIGxvZ2ljIHlvdSB3YW50IGhlcmUuIElmIHdl
IHN3aXRjaCB0byB1c2luZwpzbGVlcCwgdGhlcmUgd29uJ3QgYmUgc29mdCBsb2NrdXAgYW55bW9y
ZS4gQSBzaW1wbGUgd2FpdCArIHRpbWVvdXQgKwp3YXJuaW5nIHNlZW1zIHN1ZmZpY2llbnQ/CgpU
aGFua3MKCj4KPiA+IEFuZCBiZWZvcmUgdGhlIHBhdGNoLCB3ZSBlbmQgdXAgd2l0aCBhIHJlYWwg
aW5maW5pdGUgbG9vcCB3aGljaCBjb3VsZAo+ID4gYmUgY2F1Z2h0IGJ5IFJDVSBzdGFsbCBkZXRl
Y3RvciB3aGljaCBpcyBub3QgdGhlIGNhc2Ugb2YgdGhlIHNsZWVwLgo+ID4gV2hhdCB3ZSBjYW4g
ZG8gaXMgcHJvYmFibHkgZG8gYSBwZXJpb2RpYyBuZXRkZXZfZXJyKCkuCj4gPgo+ID4gVGhhbmtz
Cj4KPiBPbmx5IHdpdGggYSBiYWQgZGV2aWNlLgo+Cj4gPiA+ID4+Cj4gPiA+ID4+Cj4gPiA+ID4+
PiAyLSBvdmVyaGVhZC4gSW4gYSB2ZXJ5IGNvbW1vbiBzY2VuYXJpbyB3aGVuIGRldmljZSBpcyBp
biBoeXBlcnZpc29yLAo+ID4gPiA+Pj4gICAgICBwcm9ncmFtbWluZyB0aW1lcnMgZXRjIGhhcyBh
IHZlcnkgaGlnaCBvdmVyaGVhZCwgYXQgYm9vdHVwCj4gPiA+ID4+PiAgICAgIGxvdHMgb2YgQ1ZR
IGNvbW1hbmRzIGFyZSBydW4gYW5kIHNsb3dpbmcgYm9vdCBkb3duIGlzIG5vdCBuaWNlLgo+ID4g
PiA+Pj4gICAgICBsZXQncyBwb2xsIGZvciBhIGJpdCBiZWZvcmUgd2FpdGluZz8KPiA+ID4gPj4K
PiA+ID4gPj4gVGhlbiB3ZSBnbyBiYWNrIHRvIHRoZSBxdWVzdGlvbiBvZiBjaG9vc2luZyBhIGdv
b2QgdGltZW91dCBmb3IgcG9sbC4gQW5kCj4gPiA+ID4+IHBvbGwgc2VlbXMgcHJvYmxlbWF0aWMg
aW4gdGhlIGNhc2Ugb2YgVVAsIHNjaGVkdWxlciBtaWdodCBub3QgaGF2ZSB0aGUKPiA+ID4gPj4g
Y2hhbmNlIHRvIHJ1bi4KPiA+ID4gPiBQb2xsIGp1c3QgYSBiaXQgOikgU2VyaW91c2x5IEkgZG9u
J3Qga25vdywgYnV0IGF0IGxlYXN0IGNoZWNrIG9uY2UKPiA+ID4gPiBhZnRlciBraWNrLgo+ID4g
Pgo+ID4gPgo+ID4gPiBJIHRoaW5rIGl0IGlzIHdoYXQgdGhlIGN1cnJlbnQgY29kZSBkaWQgd2hl
cmUgdGhlIGNvbmRpdGlvbiB3aWxsIGJlCj4gPiA+IGNoZWNrIGJlZm9yZSB0cnlpbmcgdG8gc2xl
ZXAgaW4gdGhlIHdhaXRfZXZlbnQoKS4KPiA+ID4KPiA+ID4KPiA+ID4gPgo+ID4gPiA+Pj4gMy0g
c3VwcmlzZSByZW1vdmFsLiBuZWVkIHRvIHdha2UgdXAgdGhyZWFkIGluIHNvbWUgd2F5LiB3aGF0
IGFib3V0Cj4gPiA+ID4+PiAgICAgIG90aGVyIGNhc2VzIG9mIGRldmljZSBicmVha2FnZSAtIGlz
IHRoZXJlIGEgY2hhbmNlIHRoaXMKPiA+ID4gPj4+ICAgICAgaW50cm9kdWNlcyBuZXcgYnVncyBh
cm91bmQgdGhhdD8gYXQgbGVhc3QgZW51bWVyYXRlIHRoZW0gcGxlYXNlLgo+ID4gPiA+Pgo+ID4g
PiA+PiBUaGUgY3VycmVudCBjb2RlIGRpZDoKPiA+ID4gPj4KPiA+ID4gPj4gMSkgY2hlY2sgZm9y
IHZxLT5icm9rZW4KPiA+ID4gPj4gMikgd2FrZXVwIGR1cmluZyBCQURfUklORygpCj4gPiA+ID4+
Cj4gPiA+ID4+IFNvIHdlIHdvbid0IGVuZCB1cCB3aXRoIGEgbmV2ZXIgd29rZSB1cCBwcm9jZXNz
IHdoaWNoIHNob3VsZCBiZSBmaW5lLgo+ID4gPiA+Pgo+ID4gPiA+PiBUaGFua3MKPiA+ID4gPgo+
ID4gPiA+IEJUVyBCQURfUklORyBvbiByZW1vdmFsIHdpbGwgdHJpZ2dlciBkZXZfZXJyLiBOb3Qg
c3VyZSB0aGF0IGlzIGEgZ29vZAo+ID4gPiA+IGlkZWEgLSBjYW4gY2F1c2UgY3Jhc2hlcyBpZiBr
ZXJuZWwgcGFuaWNzIG9uIGVycm9yLgo+ID4gPgo+ID4gPgo+ID4gPiBZZXMsIGl0J3MgYmV0dGVy
IHRvIHVzZSBfX3ZpcnRxdWV1ZV9icmVhaygpIGluc3RlYWQuCj4gPiA+Cj4gPiA+IEJ1dCBjb25z
aWRlciB3ZSB3aWxsIHN0YXJ0IGZyb20gYSB3YWl0IGZpcnN0LCBJIHdpbGwgbGltaXQgdGhlIGNo
YW5nZXMKPiA+ID4gaW4gdmlydGlvLW5ldCB3aXRob3V0IGJvdGhlcmluZyB2aXJ0aW8gY29yZS4K
PiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+Cj4gPiA+ID4KPiA+ID4gPj4+Cj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
