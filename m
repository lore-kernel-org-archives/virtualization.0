Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB23C54EAA
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 11:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9513260B21;
	Mon, 30 Jan 2023 11:18:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9513260B21
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y4ysw+Wu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BoOIXaMfWmIw; Mon, 30 Jan 2023 11:18:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 870B760EFE;
	Mon, 30 Jan 2023 11:18:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 870B760EFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61AB4C0032;
	Mon, 30 Jan 2023 11:18:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E98FDC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3ED760EFE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:18:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3ED760EFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rjqy9H-UCCc7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:18:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5274B60B21
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5274B60B21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675077522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uuwxhmjWIAN3v39gRLVBeac9rDc0P4cxVL+DwOXcc6U=;
 b=Y4ysw+WuBzRvR0eOv1sVdTaRA4H4OCwZASyOc6US4mi3QPl0yFwrlzfnY+MbeKPf94mrHH
 MihulrtXrjbZ8sWRlku0KhuW322V7j/4ja5WMZTn1KBkV5dkOpJ66tByqvIZCO4yHc3feD
 64IuaKgvuMvq4uakHeGDU5pt3QpXL8w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-4JZrmDc3Pm-ho965EtlXoA-1; Mon, 30 Jan 2023 06:18:40 -0500
X-MC-Unique: 4JZrmDc3Pm-ho965EtlXoA-1
Received: by mail-wr1-f72.google.com with SMTP id
 u10-20020a5d6daa000000b002bfc2f61048so1846022wrs.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 03:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uuwxhmjWIAN3v39gRLVBeac9rDc0P4cxVL+DwOXcc6U=;
 b=zTaiK7VVyhzwH3BQ26ckAMVgVZgOzh0hBHJe9GEc/W1RZY0l0+/bNAe6xaX5VUyFla
 i7d1t6aOppZO0epKwblD1ZW+eGO2YQYMcPGMirgSuUY8hdQcjDu8FqIVvsQk8h3QuUJX
 xAJO4VC+ExF/Kli9IKzXzmE3M3eSdxXpdOa2iJsE9ddG/eT8KqQNyDZp2PoIq9PrEa+Q
 xoVnS3ycDtNHdLJf9baGkBR4vHtWwSfnKUrE1eArqggBT97aGWTFvcJuSAtCxeTbNP3e
 sRz0H9ncV7TEfRCrzubXFe51dnV6krRSknAdzp4yW5uw8qkeQUtkkg5o7qYtdTmlWYY6
 1WEA==
X-Gm-Message-State: AFqh2kqm1PlfFsZzLKuHfZOAk/YGTQx6QN+eCI9xzc38IuSqHpLT2PVw
 zT5hPmrEzKaV9XE9gznHNMmFqxF0s4QiIxL6OqLwQqAWI/iXycn3FSpUXi9Zan29jIyN5ISL960
 kuPmv6YbuL7pbJjtbEujvqbBnW+w2qkX5MgxgSKDwpw==
X-Received: by 2002:a1c:6a10:0:b0:3da:f665:5b66 with SMTP id
 f16-20020a1c6a10000000b003daf6655b66mr52243122wmc.6.1675077518880; 
 Mon, 30 Jan 2023 03:18:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt+t1LRVdTlv287q42Qivh7SsCezdlogXmrqsEUH3G2u/ZO2WZs98t1J3QnaD2f+l4Rzybnng==
X-Received: by 2002:a1c:6a10:0:b0:3da:f665:5b66 with SMTP id
 f16-20020a1c6a10000000b003daf6655b66mr52243095wmc.6.1675077518600; 
 Mon, 30 Jan 2023 03:18:38 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 y21-20020a05600c341500b003da28dfdedcsm6645556wmp.5.2023.01.30.03.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jan 2023 03:18:38 -0800 (PST)
Date: Mon, 30 Jan 2023 06:18:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20230130061437-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <CACGkMEu0v-kbh2vKvcDRoMsRoXwidPnQhiFetYPY-tXOAVScsg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gTW9uLCBKYW4gMzAsIDIwMjMgYXQgMDM6NDQ6MjRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIEphbiAzMCwgMjAyMyBhdCAxOjQzIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgSmFuIDMwLCAyMDIzIGF0IDEw
OjUzOjU0QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIFN1biwgSmFuIDI5LCAy
MDIzIGF0IDM6MzAgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4KPiA+ID4gPiBPbiBTdW4sIEphbiAyOSwgMjAyMyBhdCAwMTo0ODo0OVBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gT24gRnJpLCBKYW4gMjcsIDIwMjMgYXQgNjoz
NSBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gT24gRnJpLCBEZWMgMzAsIDIwMjIgYXQgMTE6NDM6MDhBTSArMDgwMCwg
SmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBUaHUsIERlYyAyOSwgMjAyMiBhdCA0
OjEwIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE9uIFRodSwgRGVjIDI5LCAyMDIyIGF0IDA0OjA0OjEz
UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIFRodSwgRGVj
IDI5LCAyMDIyIGF0IDM6MDcgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBXZWQsIERl
YyAyOCwgMjAyMiBhdCAwNzo1MzowOFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gT24gV2VkLCBEZWMgMjgsIDIwMjIgYXQgMjozNCBQTSBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g5ZyoIDIwMjIvMTIv
MjcgMTc6MzgsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMDU6MTI6NThQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4g5ZyoIDIwMjIvMTIvMjcgMTU6MzMs
IE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiBP
biBUdWUsIERlYyAyNywgMjAyMiBhdCAxMjozMDozNVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+PiBCdXQgZGV2aWNlIGlzIHN0aWxsIGdvaW5n
IGFuZCB3aWxsIGxhdGVyIHVzZSB0aGUgYnVmZmVycy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
Pj4+Pj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4gU2FtZSBmb3IgdGltZW91dCByZWFs
bHkuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4gQXZvaWRpbmcgaW5maW5pdGUgd2FpdC9w
b2xsIGlzIG9uZSBvZiB0aGUgZ29hbHMsIGFub3RoZXIgaXMgdG8gc2xlZXAuCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4+Pj4gSWYgd2UgdGhpbmsgdGhlIHRpbWVvdXQgaXMgaGFyZCwgd2UgY2Fu
IHN0YXJ0IGZyb20gdGhlIHdhaXQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPj4+PiBUaGFua3MKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+
IElmIHRoZSBnb2FsIGlzIHRvIGF2b2lkIGRpc3J1cHRpbmcgdHJhZmZpYyB3aGlsZSBDVlEgaXMg
aW4gdXNlLAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gdGhhdCBzb3VuZHMgbW9yZSByZWFz
b25hYmxlLiBFLmcuIHNvbWVvbmUgaXMgdHVybmluZyBvbiBwcm9taXNjLAo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+Pj4gYSBzcGlrZSBpbiBDUFUgdXNhZ2UgbWlnaHQgYmUgdW53ZWxjb21lLgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiBZZXMs
IHRoaXMgd291bGQgYmUgbW9yZSBvYnZpb3VzIGlzIFVQIGlzIHVzZWQuCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4+PiB0aGluZ3Mgd2Ugc2hvdWxkIGJlIGNhcmVmdWwgdG8gYWRkcmVzcyB0aGVuOgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gMS0gZGVidWdnaW5nLiBDdXJyZW50bHkgaXQncyBl
YXN5IHRvIHNlZSBhIHdhcm5pbmcgaWYgQ1BVIGlzIHN0dWNrCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4+PiAgICAgIGluIGEgbG9vcCBmb3IgYSB3aGlsZSwgYW5kIHdlIGFsc28gZ2V0IGEgYmFj
a3RyYWNlLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gICAgICBFLmcuIHdpdGggdGhpcyAt
IGhvdyBkbyB3ZSBrbm93IHdobyBoYXMgdGhlIFJUTkw/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4+PiAgICAgIFdlIG5lZWQgdG8gaW50ZWdyYXRlIHdpdGgga2VybmVsL3dhdGNoZG9nLmMgZm9y
IGdvb2QgcmVzdWx0cwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gICAgICBhbmQgdG8gbWFr
ZSBzdXJlIHBvbGljeSBpcyBjb25zaXN0ZW50Lgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiBUaGF0J3MgZmluZSwgd2lsbCBjb25zaWRlciB0aGlz
Lgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNvIGFmdGVyIHNv
bWUgaW52ZXN0aWdhdGlvbiwgaXQgc2VlbXMgdGhlIHdhdGNoZG9nLmMgZG9lc24ndCBoZWxwLiBU
aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG9ubHkgZXhwb3J0IGhlbHBlciBpcyB0b3VjaF9zb2Z0
bG9ja3VwX3dhdGNoZG9nKCkgd2hpY2ggdHJpZXMgdG8gYXZvaWQKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IHRyaWdnZXJpbmcgdGhlIGxvY2t1cHMgd2FybmluZyBmb3IgdGhlIGtub3duIHNsb3cgcGF0
aC4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IEkgbmV2ZXIgc2FpZCB5
b3UgY2FuIGp1c3QgdXNlIGV4aXN0aW5nIGV4cG9ydGluZyBBUElzLiBZb3UnbGwgaGF2ZSB0bwo+
ID4gPiA+ID4gPiA+ID4gPiA+IHdyaXRlIG5ldyBvbmVzIDopCj4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+IE9rLCBJIHRob3VnaHQgeW91IHdhbnRlZCB0byB0cmlnZ2VyIHNpbWls
YXIgd2FybmluZ3MgYXMgYSB3YXRjaGRvZy4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gQnR3LCBJIHdvbmRlciB3aGF0IGtpbmQgb2YgbG9naWMgeW91IHdhbnQgaGVyZS4gSWYg
d2Ugc3dpdGNoIHRvIHVzaW5nCj4gPiA+ID4gPiA+ID4gPiA+IHNsZWVwLCB0aGVyZSB3b24ndCBi
ZSBzb2Z0IGxvY2t1cCBhbnltb3JlLiBBIHNpbXBsZSB3YWl0ICsgdGltZW91dCArCj4gPiA+ID4g
PiA+ID4gPiA+IHdhcm5pbmcgc2VlbXMgc3VmZmljaWVudD8KPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gSSdk
IGxpa2UgdG8gYXZvaWQgbmVlZCB0byB0ZWFjaCB1c2VycyBuZXcgQVBJcy4gU28gd2F0Y2hkb2cg
c2V0dXAgdG8gYXBwbHkKPiA+ID4gPiA+ID4gPiA+IHRvIHRoaXMgZHJpdmVyLiBUaGUgd2Fybmlu
ZyBjYW4gYmUgZGlmZmVyZW50Lgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gUmlnaHQsIHNv
IGl0IGxvb2tzIHRvIG1lIHRoZSBvbmx5IHBvc3NpYmxlIHNldHVwIGlzIHRoZQo+ID4gPiA+ID4g
PiA+IHdhdGNoZG9nX3RocmVzLiBJIHBsYW4gdG8gdHJpZ2dlciB0aGUgd2FybmluZyBldmVyeSB3
YXRjaGRvZ190aHJlcyAqIDIKPiA+ID4gPiA+ID4gPiBzZWNvbmQgKGFzIHNvZnRsb2NrdXAgZGlk
KS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEFuZCBJIHRoaW5rIGl0IHdvdWxkIHN0aWxs
IG1ha2Ugc2Vuc2UgdG8gZmFpbCwgd2UgY2FuIHN0YXJ0IHdpdGggYQo+ID4gPiA+ID4gPiA+IHZl
cnkgbG9uZyB0aW1lb3V0IGxpa2UgMSBtaW51dGVzIGFuZCBicmVhayB0aGUgZGV2aWNlLiBEb2Vz
IHRoaXMgbWFrZQo+ID4gPiA+ID4gPiA+IHNlbnNlPwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gVGhhbmtzCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEknZCBzYXkgd2UgbmVlZCB0byBtYWtl
IHRoaXMgbWFuYWdlYWJsZSB0aGVuLgo+ID4gPiA+ID4KPiA+ID4gPiA+IERpZCB5b3UgbWVhbiBz
b21ldGhpbmcgbGlrZSBzeXNmcyBvciBtb2R1bGUgcGFyYW1ldGVycz8KPiA+ID4gPgo+ID4gPiA+
IE5vIEknZCBzYXkgcGFzcyBpdCB3aXRoIGFuIGlvY3RsLgo+ID4gPiA+Cj4gPiA+ID4gPiA+IENh
bid0IHdlIGRvIGl0IG5vcm1hbGx5Cj4gPiA+ID4gPiA+IGUuZy4gcmVhY3QgdG8gYW4gaW50ZXJy
dXB0IHRvIHJldHVybiB0byB1c2Vyc3BhY2U/Cj4gPiA+ID4gPgo+ID4gPiA+ID4gSSBkaWRuJ3Qg
Z2V0IHRoZSBtZWFuaW5nIG9mIHRoaXMuIFNvcnJ5Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5r
cwo+ID4gPiA+Cj4gPiA+ID4gU3RhbmRhcmQgd2F5IHRvIGhhbmRsZSB0aGluZ3MgdGhhdCBjYW4g
dGltZW91dCBhbmQgd2hlcmUgdXNlcnNwYWNlCj4gPiA+ID4gZGlkIG5vdCBzdXBwbHkgdGhlIHRp
bWUgaXMgdG8gYmxvY2sgdW50aWwgYW4gaW50ZXJydXB0Cj4gPiA+ID4gdGhlbiByZXR1cm4gRUlO
VFIuCj4gPiA+Cj4gPiA+IFdlbGwgdGhpcyBzZWVtcyB0byBiZSBhIGh1Z2UgY2hhbmdlLCBpb2N0
bCgyKSBkb2Vzbid0IHNheSBpdCBjYW4KPiA+ID4gcmV0dXJuIEVJTlRSIG5vdy4KPiA+Cj4gPiB0
aGUgb25lIG9uIGZlZG9yYSAzNyBkb2VzIG5vdCBidXQgaXQgc2F5czoKPiA+ICAgICAgICBObyBz
aW5nbGUgc3RhbmRhcmQuICBBcmd1bWVudHMsIHJldHVybnMsIGFuZCBzZW1hbnRpY3Mgb2YgaW9j
dGwoKSB2YXJ5IGFjY29yZGluZyB0byB0aGUgZGV2aWNlIGRyaXZlciBpbiBxdWVzdGlvbiAodGhl
IGNhbGwgIGlzCj4gPiAgICAgICAgdXNlZCBhcyBhIGNhdGNoLWFsbCBmb3Igb3BlcmF0aW9ucyB0
aGF0IGRvbid0IGNsZWFubHkgZml0IHRoZSBVTklYIHN0cmVhbSBJL08gbW9kZWwpLgo+ID4KPiA+
IHNvIGl0IGRlcGVuZHMgb24gdGhlIGRldmljZSBlLmcuIGZvciBhIHN0cmVhbXMgZGV2aWNlIGl0
IGRvZXM6Cj4gPiBodHRwczovL3B1YnMub3Blbmdyb3VwLm9yZy9vbmxpbmVwdWJzLzk2OTk5MTk3
OTkvZnVuY3Rpb25zL2lvY3RsLmh0bWwKPiA+IGhhcyBFSU5UUi4KPiAKPiBPaywgSSBzYXcgc2ln
bmFsKDcpIGFsc28gbWVudGlvbiBhYm91dCBFSU5UUiBmb3IgaW9jdGwoMik6Cj4gCj4gIiIiCj4g
ICAgICAgIElmICBhICBibG9ja2VkIGNhbGwgdG8gb25lIG9mIHRoZSBmb2xsb3dpbmcgaW50ZXJm
YWNlcyBpcwo+IGludGVycnVwdGVkIGJ5IGEgc2lnbmFsIGhhbmRsZXIsIHRoZW4gdGhlIGNhbGwg
aXMgYXV0b21hdGljYWxseQo+IHJlc3RhcnRlZCBhZnRlciB0aGUgc2lnbmFsIGhhbmRsZXIgcmXi
gJAKPiAgICAgICAgdHVybnMgaWYgdGhlIFNBX1JFU1RBUlQgZmxhZyB3YXMgdXNlZDsgb3RoZXJ3
aXNlIHRoZSBjYWxsIGZhaWxzCj4gd2l0aCB0aGUgZXJyb3IgRUlOVFI6Cj4gCj4gICAgICAgICog
cmVhZCgyKSwgcmVhZHYoMiksIHdyaXRlKDIpLCB3cml0ZXYoMiksIGFuZCBpb2N0bCgyKSBjYWxs
cyBvbgo+ICJzbG93IiBkZXZpY2VzLiAgQSAic2xvdyIgZGV2aWNlIGlzIG9uZSB3aGVyZSB0aGUg
SS9PIGNhbGwgbWF5IGJsb2NrCj4gZm9yIGFuIGluZGVmaW5pdGUgdGltZSwgZm9yCj4gICAgICAg
ICAgZXhhbXBsZSwgIGEgIHRlcm1pbmFsLCAgcGlwZSwgb3Igc29ja2V0LiAgSWYgYW4gSS9PIGNh
bGwgb24gYQo+IHNsb3cgZGV2aWNlIGhhcyBhbHJlYWR5IHRyYW5zZmVycmVkIHNvbWUgZGF0YSBi
eSB0aGUgdGltZSBpdCBpcwo+IGludGVycnVwdGVkIGJ5IGEgc2lnbmFsIGhhbmRsZXIsCj4gICAg
ICAgICAgdGhlbiB0aGUgY2FsbCB3aWxsIHJldHVybiBhIHN1Y2Nlc3Mgc3RhdHVzIChub3JtYWxs
eSwgdGhlCj4gbnVtYmVyIG9mIGJ5dGVzIHRyYW5zZmVycmVkKS4gIE5vdGUgdGhhdCBhIChsb2Nh
bCkgZGlzayBpcyBub3QgYSBzbG93Cj4gZGV2aWNlIGFjY29yZGluZyB0byB0aGlzIGRlZmnigJAK
PiAgICAgICAgICBuaXRpb247IEkvTyBvcGVyYXRpb25zIG9uIGRpc2sgZGV2aWNlcyBhcmUgbm90
IGludGVycnVwdGVkIGJ5IHNpZ25hbHMuCj4gIiIiCgoKQW5kIG5vdGUgdGhhdCBpZiB5b3UgaW50
ZXJydXB0IHRoZW4geW91IGRvbid0IGtub3cgd2hldGhlciBpb2N0bApjaGFuZ2VkIGRldmljZSBz
dGF0ZSBvciBub3QgZ2VuZXJhbGx5Lgo+ID4KPiA+Cj4gPgo+ID4gPiBBY3R1YWxseSwgYSBkcml2
ZXIgdGltZW91dCBpcyB1c2VkIGJ5IG90aGVyIGRyaXZlcnMgd2hlbiB1c2luZwo+ID4gPiBjb250
cm9scS9hZG1pbnEgKGUuZyBpNDBlKS4gU3RhcnRpbmcgZnJvbSBhIHNhbmUgdmFsdWUgKGUuZyAx
IG1pbnV0ZXMKPiA+ID4gdG8gYXZvaWQgZmFsc2UgbmVnYXRpdmVzKSBzZWVtcyB0byBiZSBhIGdv
b2QgZmlyc3Qgc3RlcC4KPiA+Cj4gPiBXZWxsIGJlY2F1c2UgaXQncyBzcGVjaWZpYyBoYXJkd2Fy
ZSBzbyB0aW1lb3V0IG1hdGNoZXMgd2hhdCBpdCBjYW4KPiA+IHByb21pc2UuICB2aXJ0aW8gc3Bl
YyBkb2VzIG5vdCBnaXZlIGd1YXJhbnRlZXMuICBPbmUgaXNzdWUgaXMgd2l0aAo+ID4gc29mdHdh
cmUgaW1wbGVtZW50YXRpb25zLiBBdCB0aGUgbW9tZW50IEkgY2FuIHNldCBhIGJyZWFrcG9pbnQg
aW4gcWVtdQo+ID4gb3Igdmhvc3QgdXNlciBiYWNrZW5kIGFuZCBub3RoaW5nIGJhZCBoYXBwZW5z
IGluIGp1c3QgY29udGludWVzLgo+IAo+IFllcyBidXQgaXQgc2hvdWxkIGJlIG5vIGRpZmZlcmVu
Y2UgZnJvbSB1c2luZyBhIGtnZGIgdG8gZGVidWcgaTQwZSBkcml2ZXJzLgoKRXhjZXB0IG9uZSBv
ZiB0aGUgcmVhc29ucyBwZW9wbGUgcHJlZmVyIHByb2dyYW1taW5nIGluIHVzZXJzcGFjZSBpcwpi
ZWNhdXNlIGRlYnVnZ2luZyBpcyBzbyBtdWNoIGxlc3MgcGFpbmZ1bC4gU29tZW9uZSB1c2luZyBr
Z2RiCmtub3dzIHdoYXQgZHJpdmVyIGlzIGRvaW5nIGFuZCBjYW4gd29yayBhcm91bmQgdGhhdC4K
Cj4gPgo+ID4KPiA+ID4gPiBVc2Vyc3BhY2UgY29udHJvbHMgdGhlIHRpbWVvdXQgYnkKPiA+ID4g
PiB1c2luZyBlLmcuIGFsYXJtKDIpLgo+ID4gPgo+ID4gPiBOb3QgdXNlZCBpbiBpcHJvdXRlMiBh
ZnRlciBhIGdpdCBncmVwLgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+Cj4gPiBObyBuZWVkIGZvciBp
cHJvdXRlMiB0byBkbyBpdCB1c2VyIGNhbiBqdXN0IGRvIGl0IGZyb20gc2hlbGwuIE9yIHVzZXIg
Y2FuIGp1c3QgcHJlc3MgQ1RSTC1DLgo+IAo+IFllcywgYnV0IGlwcm91dGUyIG5lZWRzIHRvIGRl
YWwgd2l0aCBFSU5UUiwgdGhhdCBpcyB0aGUgY2hhbGxlbmdlCj4gcGFydCwgaWYgd2Ugc2ltcGx5
IHJldHVybiBhbiBlcnJvciwgdGhlIG5leHQgY3ZxIGNvbW1hbmQgbWlnaHQgZ2V0Cj4gY29uZnVz
ZWQuCj4gCj4gVGhhbmtzCgpZb3UgbWVhbiB0aGlzOgoJc3RhcnQgY29tbWFuZAoJaW50ZXJydXB0
CglzdGFydCBuZXh0IGNvbW1hbmQKCj8KCm5leHQgY29tbWFuZCBpcyBjb25mdXNlZD8KSSB0aGlu
ayBpZiB5b3UgdHJ5IGEgbmV3IGNvbW1hbmQgdW50aWwgcHJldmlvdXMKb25lIGZpbmlzaGVkIGl0
J3Mgb2sgdG8ganVzdCByZXR1cm4gRUJVU1kuCgo+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQW5kIGJlZm9yZSB0
aGUgcGF0Y2gsIHdlIGVuZCB1cCB3aXRoIGEgcmVhbCBpbmZpbml0ZSBsb29wIHdoaWNoIGNvdWxk
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBiZSBjYXVnaHQgYnkgUkNVIHN0YWxsIGRldGVjdG9yIHdo
aWNoIGlzIG5vdCB0aGUgY2FzZSBvZiB0aGUgc2xlZXAuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBX
aGF0IHdlIGNhbiBkbyBpcyBwcm9iYWJseSBkbyBhIHBlcmlvZGljIG5ldGRldl9lcnIoKS4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IE9ubHkgd2l0aCBhIGJhZCBkZXZpY2UuCj4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+IDItIG92ZXJoZWFkLiBJ
biBhIHZlcnkgY29tbW9uIHNjZW5hcmlvIHdoZW4gZGV2aWNlIGlzIGluIGh5cGVydmlzb3IsCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAgIHByb2dyYW1taW5nIHRpbWVycyBldGMgaGFz
IGEgdmVyeSBoaWdoIG92ZXJoZWFkLCBhdCBib290dXAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
Pj4+ICAgICAgbG90cyBvZiBDVlEgY29tbWFuZHMgYXJlIHJ1biBhbmQgc2xvd2luZyBib290IGRv
d24gaXMgbm90IG5pY2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAgIGxldCdzIHBv
bGwgZm9yIGEgYml0IGJlZm9yZSB3YWl0aW5nPwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiBUaGVuIHdlIGdvIGJhY2sgdG8gdGhlIHF1ZXN0aW9u
IG9mIGNob29zaW5nIGEgZ29vZCB0aW1lb3V0IGZvciBwb2xsLiBBbmQKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPj4gcG9sbCBzZWVtcyBwcm9ibGVtYXRpYyBpbiB0aGUgY2FzZSBvZiBVUCwgc2No
ZWR1bGVyIG1pZ2h0IG5vdCBoYXZlIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiBjaGFu
Y2UgdG8gcnVuLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFBvbGwganVzdCBhIGJpdCA6KSBT
ZXJpb3VzbHkgSSBkb24ndCBrbm93LCBidXQgYXQgbGVhc3QgY2hlY2sgb25jZQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IGFmdGVyIGtpY2suCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgdGhpbmsgaXQgaXMg
d2hhdCB0aGUgY3VycmVudCBjb2RlIGRpZCB3aGVyZSB0aGUgY29uZGl0aW9uIHdpbGwgYmUKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gY2hlY2sgYmVmb3JlIHRyeWluZyB0byBzbGVlcCBpbiB0aGUg
d2FpdF9ldmVudCgpLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+
PiAzLSBzdXByaXNlIHJlbW92YWwuIG5lZWQgdG8gd2FrZSB1cCB0aHJlYWQgaW4gc29tZSB3YXku
IHdoYXQgYWJvdXQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgb3RoZXIgY2FzZXMg
b2YgZGV2aWNlIGJyZWFrYWdlIC0gaXMgdGhlcmUgYSBjaGFuY2UgdGhpcwo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+Pj4gICAgICBpbnRyb2R1Y2VzIG5ldyBidWdzIGFyb3VuZCB0aGF0PyBhdCBs
ZWFzdCBlbnVtZXJhdGUgdGhlbSBwbGVhc2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+IFRoZSBjdXJyZW50IGNvZGUgZGlkOgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiAxKSBjaGVjayBmb3Ig
dnEtPmJyb2tlbgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiAyKSB3YWtldXAgZHVyaW5nIEJB
RF9SSU5HKCkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPj4gU28gd2Ugd29uJ3QgZW5kIHVwIHdpdGggYSBuZXZlciB3b2tlIHVwIHByb2Nlc3Mgd2hp
Y2ggc2hvdWxkIGJlIGZpbmUuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4+IFRoYW5rcwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gQlRXIEJBRF9SSU5HIG9uIHJlbW92YWwgd2lsbCB0cmlnZ2VyIGRl
dl9lcnIuIE5vdCBzdXJlIHRoYXQgaXMgYSBnb29kCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
aWRlYSAtIGNhbiBjYXVzZSBjcmFzaGVzIGlmIGtlcm5lbCBwYW5pY3Mgb24gZXJyb3IuCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IFllcywgaXQncyBiZXR0ZXIgdG8gdXNlIF9fdmlydHF1ZXVlX2JyZWFrKCkgaW5z
dGVhZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQnV0
IGNvbnNpZGVyIHdlIHdpbGwgc3RhcnQgZnJvbSBhIHdhaXQgZmlyc3QsIEkgd2lsbCBsaW1pdCB0
aGUgY2hhbmdlcwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBpbiB2aXJ0aW8tbmV0IHdpdGhvdXQg
Ym90aGVyaW5nIHZpcnRpbyBjb3JlLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+Pj4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4K
PiA+ID4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
