Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F886C38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 07:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C72F606F2;
	Tue, 31 Jan 2023 07:33:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C72F606F2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NFIoFlDH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yGgIpq1OPsTm; Tue, 31 Jan 2023 07:33:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 435F560592;
	Tue, 31 Jan 2023 07:33:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 435F560592
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F27D5C0032;
	Tue, 31 Jan 2023 07:33:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 644D7C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 07:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30E144010C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 07:33:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30E144010C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NFIoFlDH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ex1K2IzGy579
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 07:33:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90203400DD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90203400DD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 07:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675150381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vcjI8WcyEgNSwCwt0JBLFv7jmWpAvBsD9wjCRPmPHk=;
 b=NFIoFlDHRKBlBkJCxsjpevOJfyzrSPmI9tmzF3IX1m3BaCkfH2qNlQXWwuYkzpJyS0EuFs
 vkGWVZewx7WlrF64G4N7+N9kB+6zkF3A5AzMmaQd66ZvE3hTCiCG7hma4ejFwmLkLRYWHX
 qycj+0c7oCzSHPzbl3WequbnEEmVUtY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-d7lj1sLHMF6DccGfIn9kLw-1; Tue, 31 Jan 2023 02:33:00 -0500
X-MC-Unique: d7lj1sLHMF6DccGfIn9kLw-1
Received: by mail-ed1-f69.google.com with SMTP id
 w3-20020a056402268300b00487e0d9b53fso10026038edd.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 23:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3vcjI8WcyEgNSwCwt0JBLFv7jmWpAvBsD9wjCRPmPHk=;
 b=bVkg+o32O9MAL7iGuIioTWY83awSOrxzHjKvlbzLRDQhN/zDGtYdmBNGQLK4i/eP57
 fc/lUzjbo1mJcS2QV0ov5V9HHjK6KfiDhFI0p9BXpRFr0ZVb4LsrrcvnvU+eUU/G+w+T
 RdxLxl4iMof5boLQZWu4s/dmxKQiZDWTGt+7jdDLF/6Gwz4EZP0bmD6fpPivSEkpb14D
 3fkTLcY+6S/e4o+Zpj9mQCbyL4ug1Hx2K9Gx61fwxmGD1zZxyFDwrk0Gz0uy2P2l4zA3
 dFoBJ4KGwHjVBIW5AdGeT9H99USRJSDFzYBt7VgvZ3JgZghjfCUB67Z8xaMasT56kvAH
 JLVg==
X-Gm-Message-State: AO0yUKUlfOmmmOMo3ungX5/iKwwQ6DunXUQqJK5+LGKmcU6aqve//F6p
 zm6ULSYMQl5YXTUaTM19LcaoiQeBt+vOZhotMF5ebqyQGP+vLf7W9II3JkUeCUh4VwEUszjCU0+
 HngPy+YObjdAge4d/h4Xj0ZsUYTx5yNdDVWAdeuOMLg==
X-Received: by 2002:a17:906:8d88:b0:888:bb84:7a73 with SMTP id
 ry8-20020a1709068d8800b00888bb847a73mr2323041ejc.56.1675150377825; 
 Mon, 30 Jan 2023 23:32:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8i6aT+JNkLxIkaZoJxfephCymJE0AQYUUlT4wDejMlAXZ2t/hRXrlfU1iUYbUgmYFzVOWRBg==
X-Received: by 2002:a17:906:8d88:b0:888:bb84:7a73 with SMTP id
 ry8-20020a1709068d8800b00888bb847a73mr2323024ejc.56.1675150377507; 
 Mon, 30 Jan 2023 23:32:57 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 y14-20020a17090668ce00b0084d3bf4498csm8129202ejr.140.2023.01.30.23.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jan 2023 23:32:56 -0800 (PST)
Date: Tue, 31 Jan 2023 02:32:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20230131023204-mutt-send-email-mst@kernel.org>
References: <20221229030633-mutt-send-email-mst@kernel.org>
 <CACGkMEukqZX=6yz1yCj+psHp5c+ZGVVuEYTUssfRCTQZgVWS6g@mail.gmail.com>
 <20230127053112-mutt-send-email-mst@kernel.org>
 <CACGkMEsZs=6TaeSUnu_9Rf+38uisi6ViHyM50=2+ut3Wze2S1g@mail.gmail.com>
 <20230129022809-mutt-send-email-mst@kernel.org>
 <CACGkMEuya+_2P8d4hokoyL_LKGdVzyCC1nDwOCdZb0=+2rjKPQ@mail.gmail.com>
 <20230130003334-mutt-send-email-mst@kernel.org>
 <CACGkMEu0v-kbh2vKvcDRoMsRoXwidPnQhiFetYPY-tXOAVScsg@mail.gmail.com>
 <20230130061437-mutt-send-email-mst@kernel.org>
 <CACGkMEsk92FSyP6uMheAzkAPbnGfdCsq387fL9XqhfF6Z=Xmew@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsk92FSyP6uMheAzkAPbnGfdCsq387fL9XqhfF6Z=Xmew@mail.gmail.com>
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

T24gVHVlLCBKYW4gMzEsIDIwMjMgYXQgMTE6MjQ6NTJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIEphbiAzMCwgMjAyMyBhdCA3OjE4IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgSmFuIDMwLCAyMDIzIGF0IDAz
OjQ0OjI0UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIE1vbiwgSmFuIDMwLCAy
MDIzIGF0IDE6NDMgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4KPiA+ID4gPiBPbiBNb24sIEphbiAzMCwgMjAyMyBhdCAxMDo1Mzo1NEFNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gT24gU3VuLCBKYW4gMjksIDIwMjMgYXQgMzoz
MCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gT24gU3VuLCBKYW4gMjksIDIwMjMgYXQgMDE6NDg6NDlQTSArMDgwMCwg
SmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBGcmksIEphbiAyNywgMjAyMyBhdCA2
OjM1IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE9uIEZyaSwgRGVjIDMwLCAyMDIyIGF0IDExOjQzOjA4
QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIFRodSwgRGVj
IDI5LCAyMDIyIGF0IDQ6MTAgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIERl
YyAyOSwgMjAyMiBhdCAwNDowNDoxM1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gT24gVGh1LCBEZWMgMjksIDIwMjIgYXQgMzowNyBQTSBNaWNoYWVsIFMu
IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gV2VkLCBEZWMgMjgsIDIwMjIgYXQgMDc6NTM6MDhQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBX
ZWQsIERlYyAyOCwgMjAyMiBhdCAyOjM0IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiDlnKggMjAyMi8xMi8yNyAxNzoz
OCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMDU6MTI6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+IOWcqCAyMDIyLzEyLzI3IDE1OjMz
LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
Pj4+IE9uIFR1ZSwgRGVjIDI3LCAyMDIyIGF0IDEyOjMwOjM1UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+PiBCdXQgZGV2aWNlIGlzIHN0
aWxsIGdvaW5nIGFuZCB3aWxsIGxhdGVyIHVzZSB0aGUgYnVmZmVycy4KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4+Pj4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+PiBTYW1l
IGZvciB0aW1lb3V0IHJlYWxseS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4gQXZv
aWRpbmcgaW5maW5pdGUgd2FpdC9wb2xsIGlzIG9uZSBvZiB0aGUgZ29hbHMsIGFub3RoZXIgaXMg
dG8gc2xlZXAuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+IElmIHdlIHRoaW5rIHRo
ZSB0aW1lb3V0IGlzIGhhcmQsIHdlIGNhbiBzdGFydCBmcm9tIHRoZSB3YWl0Lgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPj4+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+PiBU
aGFua3MKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiBJZiB0aGUgZ29hbCBpcyB0byBh
dm9pZCBkaXNydXB0aW5nIHRyYWZmaWMgd2hpbGUgQ1ZRIGlzIGluIHVzZSwKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4+PiB0aGF0IHNvdW5kcyBtb3JlIHJlYXNvbmFibGUuIEUuZy4gc29t
ZW9uZSBpcyB0dXJuaW5nIG9uIHByb21pc2MsCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
Pj4gYSBzcGlrZSBpbiBDUFUgdXNhZ2UgbWlnaHQgYmUgdW53ZWxjb21lLgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+IFllcywgdGhp
cyB3b3VsZCBiZSBtb3JlIG9idmlvdXMgaXMgVVAgaXMgdXNlZC4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPj4+IHRoaW5ncyB3ZSBzaG91bGQgYmUgY2FyZWZ1bCB0byBhZGRyZXNz
IHRoZW46Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gMS0gZGVidWdnaW5nLiBDdXJy
ZW50bHkgaXQncyBlYXN5IHRvIHNlZSBhIHdhcm5pbmcgaWYgQ1BVIGlzIHN0dWNrCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+Pj4gICAgICBpbiBhIGxvb3AgZm9yIGEgd2hpbGUsIGFuZCB3
ZSBhbHNvIGdldCBhIGJhY2t0cmFjZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAg
ICAgIEUuZy4gd2l0aCB0aGlzIC0gaG93IGRvIHdlIGtub3cgd2hvIGhhcyB0aGUgUlROTD8KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAgIFdlIG5lZWQgdG8gaW50ZWdyYXRlIHdp
dGgga2VybmVsL3dhdGNoZG9nLmMgZm9yIGdvb2QgcmVzdWx0cwo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPj4+ICAgICAgYW5kIHRvIG1ha2Ugc3VyZSBwb2xpY3kgaXMgY29uc2lzdGVudC4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+PiBUaGF0J3MgZmluZSwgd2lsbCBjb25zaWRlciB0aGlzLgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU28gYWZ0ZXIgc29tZSBpbnZlc3RpZ2F0
aW9uLCBpdCBzZWVtcyB0aGUgd2F0Y2hkb2cuYyBkb2Vzbid0IGhlbHAuIFRoZQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IG9ubHkgZXhwb3J0IGhlbHBlciBpcyB0b3VjaF9zb2Z0bG9ja3VwX3dh
dGNoZG9nKCkgd2hpY2ggdHJpZXMgdG8gYXZvaWQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB0
cmlnZ2VyaW5nIHRoZSBsb2NrdXBzIHdhcm5pbmcgZm9yIHRoZSBrbm93biBzbG93IHBhdGguCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEkgbmV2ZXIgc2Fp
ZCB5b3UgY2FuIGp1c3QgdXNlIGV4aXN0aW5nIGV4cG9ydGluZyBBUElzLiBZb3UnbGwgaGF2ZSB0
bwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB3cml0ZSBuZXcgb25lcyA6KQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9rLCBJIHRob3VnaHQgeW91IHdhbnRlZCB0
byB0cmlnZ2VyIHNpbWlsYXIgd2FybmluZ3MgYXMgYSB3YXRjaGRvZy4KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBCdHcsIEkgd29uZGVyIHdoYXQga2luZCBvZiBs
b2dpYyB5b3Ugd2FudCBoZXJlLiBJZiB3ZSBzd2l0Y2ggdG8gdXNpbmcKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IHNsZWVwLCB0aGVyZSB3b24ndCBiZSBzb2Z0IGxvY2t1cCBhbnltb3JlLiBBIHNpbXBs
ZSB3YWl0ICsgdGltZW91dCArCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiB3YXJuaW5nIHNlZW1zIHN1
ZmZpY2llbnQ/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhh
bmtzCj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBJJ2QgbGlrZSB0byBh
dm9pZCBuZWVkIHRvIHRlYWNoIHVzZXJzIG5ldyBBUElzLiBTbyB3YXRjaGRvZyBzZXR1cCB0byBh
cHBseQo+ID4gPiA+ID4gPiA+ID4gPiA+IHRvIHRoaXMgZHJpdmVyLiBUaGUgd2FybmluZyBjYW4g
YmUgZGlmZmVyZW50Lgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBSaWdodCwg
c28gaXQgbG9va3MgdG8gbWUgdGhlIG9ubHkgcG9zc2libGUgc2V0dXAgaXMgdGhlCj4gPiA+ID4g
PiA+ID4gPiA+IHdhdGNoZG9nX3RocmVzLiBJIHBsYW4gdG8gdHJpZ2dlciB0aGUgd2FybmluZyBl
dmVyeSB3YXRjaGRvZ190aHJlcyAqIDIKPiA+ID4gPiA+ID4gPiA+ID4gc2Vjb25kIChhcyBzb2Z0
bG9ja3VwIGRpZCkuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IEFuZCBJIHRo
aW5rIGl0IHdvdWxkIHN0aWxsIG1ha2Ugc2Vuc2UgdG8gZmFpbCwgd2UgY2FuIHN0YXJ0IHdpdGgg
YQo+ID4gPiA+ID4gPiA+ID4gPiB2ZXJ5IGxvbmcgdGltZW91dCBsaWtlIDEgbWludXRlcyBhbmQg
YnJlYWsgdGhlIGRldmljZS4gRG9lcyB0aGlzIG1ha2UKPiA+ID4gPiA+ID4gPiA+ID4gc2Vuc2U/
Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+IEknZCBzYXkgd2UgbmVlZCB0byBtYWtlIHRoaXMgbWFuYWdlYWJs
ZSB0aGVuLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gRGlkIHlvdSBtZWFuIHNvbWV0aGlu
ZyBsaWtlIHN5c2ZzIG9yIG1vZHVsZSBwYXJhbWV0ZXJzPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiBObyBJJ2Qgc2F5IHBhc3MgaXQgd2l0aCBhbiBpb2N0bC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+IENhbid0IHdlIGRvIGl0IG5vcm1hbGx5Cj4gPiA+ID4gPiA+ID4gPiBlLmcuIHJlYWN0
IHRvIGFuIGludGVycnVwdCB0byByZXR1cm4gdG8gdXNlcnNwYWNlPwo+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gSSBkaWRuJ3QgZ2V0IHRoZSBtZWFuaW5nIG9mIHRoaXMuIFNvcnJ5Lgo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFN0
YW5kYXJkIHdheSB0byBoYW5kbGUgdGhpbmdzIHRoYXQgY2FuIHRpbWVvdXQgYW5kIHdoZXJlIHVz
ZXJzcGFjZQo+ID4gPiA+ID4gPiBkaWQgbm90IHN1cHBseSB0aGUgdGltZSBpcyB0byBibG9jayB1
bnRpbCBhbiBpbnRlcnJ1cHQKPiA+ID4gPiA+ID4gdGhlbiByZXR1cm4gRUlOVFIuCj4gPiA+ID4g
Pgo+ID4gPiA+ID4gV2VsbCB0aGlzIHNlZW1zIHRvIGJlIGEgaHVnZSBjaGFuZ2UsIGlvY3RsKDIp
IGRvZXNuJ3Qgc2F5IGl0IGNhbgo+ID4gPiA+ID4gcmV0dXJuIEVJTlRSIG5vdy4KPiA+ID4gPgo+
ID4gPiA+IHRoZSBvbmUgb24gZmVkb3JhIDM3IGRvZXMgbm90IGJ1dCBpdCBzYXlzOgo+ID4gPiA+
ICAgICAgICBObyBzaW5nbGUgc3RhbmRhcmQuICBBcmd1bWVudHMsIHJldHVybnMsIGFuZCBzZW1h
bnRpY3Mgb2YgaW9jdGwoKSB2YXJ5IGFjY29yZGluZyB0byB0aGUgZGV2aWNlIGRyaXZlciBpbiBx
dWVzdGlvbiAodGhlIGNhbGwgIGlzCj4gPiA+ID4gICAgICAgIHVzZWQgYXMgYSBjYXRjaC1hbGwg
Zm9yIG9wZXJhdGlvbnMgdGhhdCBkb24ndCBjbGVhbmx5IGZpdCB0aGUgVU5JWCBzdHJlYW0gSS9P
IG1vZGVsKS4KPiA+ID4gPgo+ID4gPiA+IHNvIGl0IGRlcGVuZHMgb24gdGhlIGRldmljZSBlLmcu
IGZvciBhIHN0cmVhbXMgZGV2aWNlIGl0IGRvZXM6Cj4gPiA+ID4gaHR0cHM6Ly9wdWJzLm9wZW5n
cm91cC5vcmcvb25saW5lcHVicy85Njk5OTE5Nzk5L2Z1bmN0aW9ucy9pb2N0bC5odG1sCj4gPiA+
ID4gaGFzIEVJTlRSLgo+ID4gPgo+ID4gPiBPaywgSSBzYXcgc2lnbmFsKDcpIGFsc28gbWVudGlv
biBhYm91dCBFSU5UUiBmb3IgaW9jdGwoMik6Cj4gPiA+Cj4gPiA+ICIiIgo+ID4gPiAgICAgICAg
SWYgIGEgIGJsb2NrZWQgY2FsbCB0byBvbmUgb2YgdGhlIGZvbGxvd2luZyBpbnRlcmZhY2VzIGlz
Cj4gPiA+IGludGVycnVwdGVkIGJ5IGEgc2lnbmFsIGhhbmRsZXIsIHRoZW4gdGhlIGNhbGwgaXMg
YXV0b21hdGljYWxseQo+ID4gPiByZXN0YXJ0ZWQgYWZ0ZXIgdGhlIHNpZ25hbCBoYW5kbGVyIHJl
4oCQCj4gPiA+ICAgICAgICB0dXJucyBpZiB0aGUgU0FfUkVTVEFSVCBmbGFnIHdhcyB1c2VkOyBv
dGhlcndpc2UgdGhlIGNhbGwgZmFpbHMKPiA+ID4gd2l0aCB0aGUgZXJyb3IgRUlOVFI6Cj4gPiA+
Cj4gPiA+ICAgICAgICAqIHJlYWQoMiksIHJlYWR2KDIpLCB3cml0ZSgyKSwgd3JpdGV2KDIpLCBh
bmQgaW9jdGwoMikgY2FsbHMgb24KPiA+ID4gInNsb3ciIGRldmljZXMuICBBICJzbG93IiBkZXZp
Y2UgaXMgb25lIHdoZXJlIHRoZSBJL08gY2FsbCBtYXkgYmxvY2sKPiA+ID4gZm9yIGFuIGluZGVm
aW5pdGUgdGltZSwgZm9yCj4gPiA+ICAgICAgICAgIGV4YW1wbGUsICBhICB0ZXJtaW5hbCwgIHBp
cGUsIG9yIHNvY2tldC4gIElmIGFuIEkvTyBjYWxsIG9uIGEKPiA+ID4gc2xvdyBkZXZpY2UgaGFz
IGFscmVhZHkgdHJhbnNmZXJyZWQgc29tZSBkYXRhIGJ5IHRoZSB0aW1lIGl0IGlzCj4gPiA+IGlu
dGVycnVwdGVkIGJ5IGEgc2lnbmFsIGhhbmRsZXIsCj4gPiA+ICAgICAgICAgIHRoZW4gdGhlIGNh
bGwgd2lsbCByZXR1cm4gYSBzdWNjZXNzIHN0YXR1cyAobm9ybWFsbHksIHRoZQo+ID4gPiBudW1i
ZXIgb2YgYnl0ZXMgdHJhbnNmZXJyZWQpLiAgTm90ZSB0aGF0IGEgKGxvY2FsKSBkaXNrIGlzIG5v
dCBhIHNsb3cKPiA+ID4gZGV2aWNlIGFjY29yZGluZyB0byB0aGlzIGRlZmnigJAKPiA+ID4gICAg
ICAgICAgbml0aW9uOyBJL08gb3BlcmF0aW9ucyBvbiBkaXNrIGRldmljZXMgYXJlIG5vdCBpbnRl
cnJ1cHRlZCBieSBzaWduYWxzLgo+ID4gPiAiIiIKPiA+Cj4gPgo+ID4gQW5kIG5vdGUgdGhhdCBp
ZiB5b3UgaW50ZXJydXB0IHRoZW4geW91IGRvbid0IGtub3cgd2hldGhlciBpb2N0bAo+ID4gY2hh
bmdlZCBkZXZpY2Ugc3RhdGUgb3Igbm90IGdlbmVyYWxseS4KPiAKPiBZZXMuCj4gCj4gPiA+ID4K
PiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBBY3R1YWxseSwgYSBkcml2ZXIgdGltZW91dCBpcyB1
c2VkIGJ5IG90aGVyIGRyaXZlcnMgd2hlbiB1c2luZwo+ID4gPiA+ID4gY29udHJvbHEvYWRtaW5x
IChlLmcgaTQwZSkuIFN0YXJ0aW5nIGZyb20gYSBzYW5lIHZhbHVlIChlLmcgMSBtaW51dGVzCj4g
PiA+ID4gPiB0byBhdm9pZCBmYWxzZSBuZWdhdGl2ZXMpIHNlZW1zIHRvIGJlIGEgZ29vZCBmaXJz
dCBzdGVwLgo+ID4gPiA+Cj4gPiA+ID4gV2VsbCBiZWNhdXNlIGl0J3Mgc3BlY2lmaWMgaGFyZHdh
cmUgc28gdGltZW91dCBtYXRjaGVzIHdoYXQgaXQgY2FuCj4gPiA+ID4gcHJvbWlzZS4gIHZpcnRp
byBzcGVjIGRvZXMgbm90IGdpdmUgZ3VhcmFudGVlcy4gIE9uZSBpc3N1ZSBpcyB3aXRoCj4gPiA+
ID4gc29mdHdhcmUgaW1wbGVtZW50YXRpb25zLiBBdCB0aGUgbW9tZW50IEkgY2FuIHNldCBhIGJy
ZWFrcG9pbnQgaW4gcWVtdQo+ID4gPiA+IG9yIHZob3N0IHVzZXIgYmFja2VuZCBhbmQgbm90aGlu
ZyBiYWQgaGFwcGVucyBpbiBqdXN0IGNvbnRpbnVlcy4KPiA+ID4KPiA+ID4gWWVzIGJ1dCBpdCBz
aG91bGQgYmUgbm8gZGlmZmVyZW5jZSBmcm9tIHVzaW5nIGEga2dkYiB0byBkZWJ1ZyBpNDBlIGRy
aXZlcnMuCj4gPgo+ID4gRXhjZXB0IG9uZSBvZiB0aGUgcmVhc29ucyBwZW9wbGUgcHJlZmVyIHBy
b2dyYW1taW5nIGluIHVzZXJzcGFjZSBpcwo+ID4gYmVjYXVzZSBkZWJ1Z2dpbmcgaXMgc28gbXVj
aCBsZXNzIHBhaW5mdWwuIFNvbWVvbmUgdXNpbmcga2dkYgo+ID4ga25vd3Mgd2hhdCBkcml2ZXIg
aXMgZG9pbmcgYW5kIGNhbiB3b3JrIGFyb3VuZCB0aGF0Lgo+IAo+IE9rLgo+IAo+ID4KPiA+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4gPiA+IFVzZXJzcGFjZSBjb250cm9scyB0aGUgdGltZW91dCBieQo+
ID4gPiA+ID4gPiB1c2luZyBlLmcuIGFsYXJtKDIpLgo+ID4gPiA+ID4KPiA+ID4gPiA+IE5vdCB1
c2VkIGluIGlwcm91dGUyIGFmdGVyIGEgZ2l0IGdyZXAuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhh
bmtzCj4gPiA+ID4KPiA+ID4gPiBObyBuZWVkIGZvciBpcHJvdXRlMiB0byBkbyBpdCB1c2VyIGNh
biBqdXN0IGRvIGl0IGZyb20gc2hlbGwuIE9yIHVzZXIgY2FuIGp1c3QgcHJlc3MgQ1RSTC1DLgo+
ID4gPgo+ID4gPiBZZXMsIGJ1dCBpcHJvdXRlMiBuZWVkcyB0byBkZWFsIHdpdGggRUlOVFIsIHRo
YXQgaXMgdGhlIGNoYWxsZW5nZQo+ID4gPiBwYXJ0LCBpZiB3ZSBzaW1wbHkgcmV0dXJuIGFuIGVy
cm9yLCB0aGUgbmV4dCBjdnEgY29tbWFuZCBtaWdodCBnZXQKPiA+ID4gY29uZnVzZWQuCj4gPiA+
Cj4gPiA+IFRoYW5rcwo+ID4KPiA+IFlvdSBtZWFuIHRoaXM6Cj4gPiAgICAgICAgIHN0YXJ0IGNv
bW1hbmQKPiA+ICAgICAgICAgaW50ZXJydXB0Cj4gPiAgICAgICAgIHN0YXJ0IG5leHQgY29tbWFu
ZAo+ID4KPiA+ID8KPiA+Cj4gPiBuZXh0IGNvbW1hbmQgaXMgY29uZnVzZWQ/Cj4gPiBJIHRoaW5r
IGlmIHlvdSB0cnkgYSBuZXcgY29tbWFuZCB1bnRpbCBwcmV2aW91cwo+ID4gb25lIGZpbmlzaGVk
IGl0J3Mgb2sgdG8ganVzdCByZXR1cm4gRUJVU1kuCj4gCj4gVGhhdCB3b3VsZCBiZSBmaW5lLgo+
IAo+IEFuZCB3ZSBnbyBiYWNrIHRvIHNvbWVob3cgdGhlIGlkZWEgaGVyZToKPiAKPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvQ0FDR2tNRXZRd2hPaGdHVzZGMjIrM3ZtUjRBVzkwcVlYRita
TzZCUVpndVVGMnh0MlNBQG1haWwuZ21haWwuY29tL1QvI20yZGE2MzkzMmVhZTc3NWQ3ZDA1ZDkz
ZDQ0YzJmMWQxMTVmZmJjZWZlCj4gCj4gV2lsbCB0cnkgdG8gZG8gdGhhdCBpbiB0aGUgbmV4dCB2
ZXJzaW9uLgo+IAo+IFRoYW5rcwoKV2hlcmUgeW91IHdyb3RlOgoJV2UgY2FuIHB1dCB0aGUgcHJv
Y2VzcyBpbnRvIGludGVycnVwdGlibGUgc2xlZXAsIHRoZW4gaXQgc2hvdWxkIGJlIGZpbmU/CgoJ
KEZZSSwgc29tZSB0cmFuc3BvcnQgc3BlY2lmaWMgbWV0aG9kcyBtYXkgc2xlZXAgZS5nIGNjdyku
CgppbmRlZWQuCgoKPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gQW5kIGJlZm9yZSB0aGUgcGF0Y2gsIHdlIGVuZCB1cCB3aXRoIGEgcmVh
bCBpbmZpbml0ZSBsb29wIHdoaWNoIGNvdWxkCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYmUg
Y2F1Z2h0IGJ5IFJDVSBzdGFsbCBkZXRlY3RvciB3aGljaCBpcyBub3QgdGhlIGNhc2Ugb2YgdGhl
IHNsZWVwLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdoYXQgd2UgY2FuIGRvIGlzIHByb2Jh
Ymx5IGRvIGEgcGVyaW9kaWMgbmV0ZGV2X2VycigpLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9ubHkgd2l0aCBhIGJhZCBkZXZpY2UuCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAyLSBv
dmVyaGVhZC4gSW4gYSB2ZXJ5IGNvbW1vbiBzY2VuYXJpbyB3aGVuIGRldmljZSBpcyBpbiBoeXBl
cnZpc29yLAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgcHJvZ3JhbW1pbmcg
dGltZXJzIGV0YyBoYXMgYSB2ZXJ5IGhpZ2ggb3ZlcmhlYWQsIGF0IGJvb3R1cAo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPj4+ICAgICAgbG90cyBvZiBDVlEgY29tbWFuZHMgYXJlIHJ1biBh
bmQgc2xvd2luZyBib290IGRvd24gaXMgbm90IG5pY2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+Pj4gICAgICBsZXQncyBwb2xsIGZvciBhIGJpdCBiZWZvcmUgd2FpdGluZz8KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiBU
aGVuIHdlIGdvIGJhY2sgdG8gdGhlIHF1ZXN0aW9uIG9mIGNob29zaW5nIGEgZ29vZCB0aW1lb3V0
IGZvciBwb2xsLiBBbmQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+IHBvbGwgc2VlbXMg
cHJvYmxlbWF0aWMgaW4gdGhlIGNhc2Ugb2YgVVAsIHNjaGVkdWxlciBtaWdodCBub3QgaGF2ZSB0
aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+IGNoYW5jZSB0byBydW4uCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IFBvbGwganVzdCBhIGJpdCA6KSBTZXJpb3VzbHkgSSBkb24n
dCBrbm93LCBidXQgYXQgbGVhc3QgY2hlY2sgb25jZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBhZnRlciBraWNrLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJIHRoaW5rIGl0IGlz
IHdoYXQgdGhlIGN1cnJlbnQgY29kZSBkaWQgd2hlcmUgdGhlIGNvbmRpdGlvbiB3aWxsIGJlCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjaGVjayBiZWZvcmUgdHJ5aW5nIHRvIHNsZWVwIGlu
IHRoZSB3YWl0X2V2ZW50KCkuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAzLSBzdXByaXNlIHJlbW92YWwuIG5lZWQgdG8gd2FrZSB1
cCB0aHJlYWQgaW4gc29tZSB3YXkuIHdoYXQgYWJvdXQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4+PiAgICAgIG90aGVyIGNhc2VzIG9mIGRldmljZSBicmVha2FnZSAtIGlzIHRoZXJlIGEg
Y2hhbmNlIHRoaXMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+PiAgICAgIGludHJvZHVj
ZXMgbmV3IGJ1Z3MgYXJvdW5kIHRoYXQ/IGF0IGxlYXN0IGVudW1lcmF0ZSB0aGVtIHBsZWFzZS4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+PiBUaGUgY3VycmVudCBjb2RlIGRpZDoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4+
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+PiAxKSBjaGVjayBmb3IgdnEtPmJyb2tlbgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4gMikgd2FrZXVwIGR1cmluZyBCQURfUklORygp
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPj4gU28gd2Ugd29uJ3QgZW5kIHVwIHdpdGggYSBuZXZlciB3b2tlIHVwIHByb2Nlc3Mgd2hp
Y2ggc2hvdWxkIGJlIGZpbmUuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPj4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEJUVyBCQURfUklORyBvbiByZW1vdmFs
IHdpbGwgdHJpZ2dlciBkZXZfZXJyLiBOb3Qgc3VyZSB0aGF0IGlzIGEgZ29vZAo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBpZGVhIC0gY2FuIGNhdXNlIGNyYXNoZXMgaWYga2VybmVsIHBh
bmljcyBvbiBlcnJvci4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gWWVzLCBpdCdzIGJldHRl
ciB0byB1c2UgX192aXJ0cXVldWVfYnJlYWsoKSBpbnN0ZWFkLgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEJ1dCBjb25zaWRlciB3ZSB3aWxs
IHN0YXJ0IGZyb20gYSB3YWl0IGZpcnN0LCBJIHdpbGwgbGltaXQgdGhlIGNoYW5nZXMKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IGluIHZpcnRpby1uZXQgd2l0aG91dCBib3RoZXJpbmcgdmly
dGlvIGNvcmUuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+Cj4gPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
