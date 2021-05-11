Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D6FC433B4
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 08:25:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2DB6193F
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 08:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2DB6193F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F82B60D61;
	Tue, 11 May 2021 08:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6gRYjMXK3SEM; Tue, 11 May 2021 08:24:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE34C60D5A;
	Tue, 11 May 2021 08:24:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9651C000D;
	Tue, 11 May 2021 08:24:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90675C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A19B40E5C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bBZ9jhSam2-N
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:24:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F95540E48
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620721493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1PL+lorPPHbLKN+6gUnXZ4XWrHXUKTzm1uegMqUoa0=;
 b=FrgGOWmOZrXkGPANql7Iq+2FrnNuDKg1bgyUg+Icy2Ct3j1c9RwN6HUEW+L1i88cej30A8
 WxNBRte9thw+4om9BCMKjoQw/1QG8a50907V7fCxN0Nusi/JBGXJwKVhAnhcVkXGqWvnSa
 XXtXFw8uKvnhzn+ITeh4bdVY7A/QLSQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-xmlLDjGvPae7AdDFEXX4BQ-1; Tue, 11 May 2021 04:24:51 -0400
X-MC-Unique: xmlLDjGvPae7AdDFEXX4BQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 c15-20020a25a28f0000b02904f8c4864c90so8475610ybi.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 01:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q1PL+lorPPHbLKN+6gUnXZ4XWrHXUKTzm1uegMqUoa0=;
 b=FIVBgww5VhoUYfGbouxMcThDPEfqdexOfhCb/Da4bsC7ks6XhWOlpwkfYTiRSRZXTS
 aeHz+pNPO5TZp1paqGkDVDQmROuA0LeUgGG+6E82f4MkNHnbnudScF+yn84jTNfnBCEn
 lvTdihZVu4WTVfdqAF5Dv4w8xQZsnoJkTeqoD3iNqF9d2cEfJ8cVVTFtNxqFwep+XZnc
 TMRbd5FpSEvtekrkU1HJ7NsgpZM764vt/cuEQj2RBnZREg5mSUHycGSnpcWQBBXMLy9S
 iPOO5ky489BYOI/IOCf8q38erbR3kK9bT9PFqTR3ErcWYpCy+4UZTWFOge3CVTEaEodo
 W4hQ==
X-Gm-Message-State: AOAM53363ectHlZP4iBdraQanzQVy+nDPRSMjU4Lhe+vzlrMl5QstLBh
 8rOS5Un6yIKDSSqtG/6AEKYnw6jXezD5iqwJFc17UED8fSFSCIPviWrkiVmQ6Js57Ek+lyymtAp
 QYJMl6i5ZqXgooQV+mSJRiJjrzxs9SvugfnZekb6IHtsGo0JsheIhJZeK1A==
X-Received: by 2002:a25:c78f:: with SMTP id
 w137mr19008466ybe.354.1620721491069; 
 Tue, 11 May 2021 01:24:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP1CYB9/Ie/6JUGhJvDJy95jOm7OYpDyVxrsT8AMUzUiJq1OEabHM75gpRYqxsrqQr952qKfYXS1PrN1xJVgE=
X-Received: by 2002:a25:c78f:: with SMTP id
 w137mr19008450ybe.354.1620721490896; 
 Tue, 11 May 2021 01:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-2-yuri.benditovich@daynix.com>
 <40938c20-5851-089b-c3c0-074bbd636970@redhat.com>
 <CAOEp5OdgYtP+W1thGsTGnvEPWrJ02s1HemskQpnMTUyYbsX4jQ@mail.gmail.com>
In-Reply-To: <CAOEp5OdgYtP+W1thGsTGnvEPWrJ02s1HemskQpnMTUyYbsX4jQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 May 2021 16:24:39 +0800
Message-ID: <CACGkMEuk3-iP+AxsvhT16t+5dXXtVMGoWPovM=Msm0kvo3LR2Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio-net: add definitions for host USO feature
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBNYXkgMTEsIDIwMjEgYXQgNDoxMiBQTSBZdXJpIEJlbmRpdG92aWNoCjx5dXJpLmJl
bmRpdG92aWNoQGRheW5peC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBNYXkgMTEsIDIwMjEgYXQg
OTo0NyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPgo+
ID4g5ZyoIDIwMjEvNS8xMSDkuIvljYgxMjo0MiwgWXVyaSBCZW5kaXRvdmljaCDlhpnpgZM6Cj4g
PiA+IERlZmluZSBmZWF0dXJlIGJpdCBhbmQgR1NPIHR5cGUgYWNjb3JkaW5nIHRvIHRoZSBWSVJU
SU8KPiA+ID4gc3BlY2lmaWNhdGlvbi4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogWXVyaSBC
ZW5kaXRvdmljaCA8eXVyaS5iZW5kaXRvdmljaEBkYXluaXguY29tPgo+ID4gPiAtLS0KPiA+ID4g
ICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oIHwgMiArKwo+ID4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dWFwaS9saW51eC92aXJ0aW9fbmV0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5o
Cj4gPiA+IGluZGV4IDNmNTVhNDIxNWYxMS4uYTU1NmFjNzM1ZDdmIDEwMDY0NAo+ID4gPiAtLS0g
YS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oCj4gPiA+ICsrKyBiL2luY2x1ZGUvdWFw
aS9saW51eC92aXJ0aW9fbmV0LmgKPiA+ID4gQEAgLTU3LDYgKzU3LDcgQEAKPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBTdGVlcmluZyAqLwo+ID4gPiAgICNk
ZWZpbmUgVklSVElPX05FVF9GX0NUUkxfTUFDX0FERFIgMjMgICAgICAgLyogU2V0IE1BQyBhZGRy
ZXNzICovCj4gPiA+Cj4gPiA+ICsjZGVmaW5lIFZJUlRJT19ORVRfRl9IT1NUX1VTTyAgICAgNTYg
LyogSG9zdCBjYW4gaGFuZGxlIFVTTyBwYWNrZXRzICovCj4KPiBUaGlzIGlzIHRoZSB2aXJ0aW8t
bmV0IGZlYXR1cmUKClJpZ2h0LCBJIG1pc3MgdGhpcyBwYXJ0LgoKPgo+ID4gPiAgICNkZWZpbmUg
VklSVElPX05FVF9GX0hBU0hfUkVQT1JUICA1NyAgICAgICAgLyogU3VwcG9ydHMgaGFzaCByZXBv
cnQgKi8KPiA+ID4gICAjZGVmaW5lIFZJUlRJT19ORVRfRl9SU1MgICAgICA2MCAgICAvKiBTdXBw
b3J0cyBSU1MgUlggc3RlZXJpbmcgKi8KPiA+ID4gICAjZGVmaW5lIFZJUlRJT19ORVRfRl9SU0Nf
RVhUICAgICAgICAgIDYxICAgIC8qIGV4dGVuZGVkIGNvYWxlc2NpbmcgaW5mbyAqLwo+ID4gPiBA
QCAtMTMwLDYgKzEzMSw3IEBAIHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl92MSB7Cj4gPiA+ICAgI2Rl
ZmluZSBWSVJUSU9fTkVUX0hEUl9HU09fVENQVjQgICAgMSAgICAgICAvKiBHU08gZnJhbWUsIElQ
djQgVENQIChUU08pICovCj4gPiA+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0hEUl9HU09fVURQICAg
ICAgICAgICAgICAzICAgICAgIC8qIEdTTyBmcmFtZSwgSVB2NCBVRFAgKFVGTykgKi8KPiA+ID4g
ICAjZGVmaW5lIFZJUlRJT19ORVRfSERSX0dTT19UQ1BWNiAgICA0ICAgICAgIC8qIEdTTyBmcmFt
ZSwgSVB2NiBUQ1AgKi8KPiA+ID4gKyNkZWZpbmUgVklSVElPX05FVF9IRFJfR1NPX1VEUF9MNCAg
ICA1ICAgICAgIC8qIEdTTyBmcmFtZSwgSVB2NCBVRFAgKFVTTykgKi8KPgo+IFRoaXMgaXMgcmVz
cGVjdGl2ZSBHU08gdHlwZQo+Cj4gPgo+ID4KPiA+IFRoaXMgaXMgdGhlIGdzb190eXBlIG5vdCB0
aGUgZmVhdHVyZSBhY3R1YWxseS4KPiA+Cj4gPiBJIHdvbmRlciB3aGF0J3MgdGhlIHJlYXNvbiBm
b3Igbm90Cj4gPgo+ID4gMSkgaW50cm9kdWNpbmcgYSBkZWRpY2F0ZWQgdmlydGlvLW5ldCBmZWF0
dXJlIGJpdCBmb3IgdGhpcwo+ID4gKFZJUlRJT19ORVRfRl9HVUVTVF9HU09fVURQX0w0Lgo+Cj4g
VGhpcyBzZXJpZXMgaXMgbm90IGZvciBHVUVTVCdzIGZlYXR1cmUsIGl0IGlzIG9ubHkgZm9yIGhv
c3QgZmVhdHVyZS4KPgo+ID4gMikgdG9nZ2xlIHRoZSBORVRJRl9GX0dTT19VRFBfTDQgIGZlYXR1
cmUgZm9yIHR1bnRhcCBiYXNlZCBvbiB0aGUKPiA+IG5lZ290aWF0ZWQgZmVhdHVyZS4KPgo+IFRo
ZSBORVRJRl9GX0dTT19VRFBfTDQgd291bGQgYmUgcmVxdWlyZWQgZm9yIHRoZSBndWVzdCBSWCBw
YXRoLgo+IFRoZSBndWVzdCBUWCBwYXRoIGRvZXMgbm90IHJlcXVpcmUgYW55IGZsYWdzIHRvIGJl
IHByb3BhZ2F0ZWQsIGl0IG9ubHkKPiBhbGxvd3MgdGhlIGd1ZXN0IHRvIHRyYW5zbWl0IGxhcmdl
IFVEUCBwYWNrZXRzIGFuZCBoYXZlIHRoZW0KPiBhdXRvbWF0aWNhbGx5IHNwbGl0dGVkLgo+IChU
aGlzIGlzIHNpbWlsYXIgdG8gSE9TVF9VRk8gYnV0IGRvZXMgcGFja2V0IHNlZ21lbnRhdGlvbiBp
bnN0ZWFkIG9mCj4gZnJhZ21lbnRhdGlvbi4gR1VFU1RfVUZPIGluZGVlZCByZXF1aXJlcyBhIHJl
c3BlY3RpdmUgTkVUSUYgZmxhZywgYXMKPiBpdCBpcyB1bmNsZWFyIHdoZXRoZXIgdGhlIGd1ZXN0
IGlzIGNhcGFibGUgb2YgcmVjZWl2aW5nIHN1Y2ggcGFja2V0cykuCgpTbyBJIHRoaW5rIGl0J3Mg
YmV0dGVyIHRvIGltcGxlbWVudCBUWC9SWCBpbiB0aGUgc2FtZSBzZXJpZXMgdW5sZXNzCnRoZXJl
J3Mgc29tZXRoaW5nIG1pc3NlZDoKCkZvciBHdWVzdCBUWCwgTkVUSUZfRl9HU09fVURQX0w0IG5l
ZWRzIHRvIGJlIGVuYWJsZWQgaW4gdGhlIGd1ZXN0CnZpcnRpby1uZXQgb25seSB3aGVuIFZJUlRJ
T19ORVRfRl9IT1NUX1VTTyBpcyBuZWdvdGlhdGVkLgpGb3IgZ3Vlc3QgUlgsIE5FVElGX0ZfR1NP
X1VEUF9MNCBuZWVkcyB0byBiZSBlbmFibGVkIG9uIHRoZSBob3N0CnR1bnRhcCBvbmx5IHdoZW4g
VklSVElPX05FVF9GX0dVRVNUX1VTTyBpcyBuZW9naWF0ZWQuCgpUaGFua3MKCj4KPiA+Cj4gPiBU
aGFua3MKPiA+Cj4gPgo+ID4gPiAgICNkZWZpbmUgVklSVElPX05FVF9IRFJfR1NPX0VDTiAgICAg
ICAgICAgICAgMHg4MCAgICAvKiBUQ1AgaGFzIEVDTiBzZXQgKi8KPiA+ID4gICAgICAgX191OCBn
c29fdHlwZTsKPiA+ID4gICAgICAgX192aXJ0aW8xNiBoZHJfbGVuOyAgICAgLyogRXRoZXJuZXQg
KyBJUCArIHRjcC91ZHAgaGRycyAqLwo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
