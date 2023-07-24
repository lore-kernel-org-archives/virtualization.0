Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE7EC0015E
	for <virtualization@archiver.kernel.org>; Mon, 24 Jul 2023 06:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80DFB4086A;
	Mon, 24 Jul 2023 06:52:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80DFB4086A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aHydBLBk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pD66Z6Iucp8H; Mon, 24 Jul 2023 06:52:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 77D81407D7;
	Mon, 24 Jul 2023 06:52:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77D81407D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48C4EC0072;
	Mon, 24 Jul 2023 06:52:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2830BC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 06:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E250D60B97
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 06:52:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E250D60B97
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aHydBLBk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y2zQ07pqxciJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 06:52:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A806860B65
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 06:52:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A806860B65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690181539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Eib/snGZK+J1TMIQVgytcC6Q8KrElag1cRiuwxI9z0=;
 b=aHydBLBk3vybP6fJfHosAJC7B2W0UZjBsHEJIXmplT0jn4j5hf5zqW8e953Y5CUeKof8Fg
 526AtRXn/EGUT+XoBx+HH6F7dwK5m7VD4ydXHH8tMan/R5Rom8oEh8gZpP1zXMwG6h5uvr
 96o7H6W5ftfuJKPUPlWni25v2IzNc9Y=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-iSHU6Pf5OpytxYKG4BCCeA-1; Mon, 24 Jul 2023 02:52:18 -0400
X-MC-Unique: iSHU6Pf5OpytxYKG4BCCeA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fbcdca8ff2so2384163e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 23:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690181536; x=1690786336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Eib/snGZK+J1TMIQVgytcC6Q8KrElag1cRiuwxI9z0=;
 b=TIqV8aFOWGE3/N1/+9zZ2cqg2+EPaxPY7MeL2XElf9QTzAnAaQWOQ+g11xVtYgVXiF
 pDmeCiYJNyhTXB6rVjJotKPdnOgpitpmdRi36G2Qxtla5OYPm80jcpbiJOk6I1frhra+
 dXDXi388lHpWA8cRh9wKQfQTrwi7l7WMGimOWHUTg2SaTkT5tB6DZmqPjhVHvQQuCCFJ
 ZLs8uYKPaAv31WIvfvg+2i0VTsBmhVydtHMzneu53RJMnC4QY2P41suRVXwUp7SQQ6v0
 8VxW7QR1ELu76P+9m1+d62SETOhcucZPG7vro7l9Ek0GUhpCcbHySKTNpDwsKZxcW4MG
 fh6Q==
X-Gm-Message-State: ABy/qLZi7gonNJf0R0yM+0JF1zf0ZQ6MK9mVZv9tQY410+yyRAnug8XH
 dVBdrQZTZ1DNuAaVcM4asjPVKVZHlAAC+4lqQ0V3pa2Y1dDmyLTU6muF9zU//SHVDn5uoj8ep+x
 FVZjaAthk7IQXkDs20wri0o23rrgqy7Yr8QdOsJTvwZaCeCOmx2d/myGGig==
X-Received: by 2002:a05:6512:31d5:b0:4f8:75d5:e14f with SMTP id
 j21-20020a05651231d500b004f875d5e14fmr4458710lfe.28.1690181536590; 
 Sun, 23 Jul 2023 23:52:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHDHx3flX3L5UV3ZIswai/MSqeClmvnFN71NppKSREFI3wWmLRUTGY01mBOLnmYfijXmI8rLbTx4htqybF7Zqw=
X-Received: by 2002:a05:6512:31d5:b0:4f8:75d5:e14f with SMTP id
 j21-20020a05651231d500b004f875d5e14fmr4458700lfe.28.1690181536270; Sun, 23
 Jul 2023 23:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
In-Reply-To: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Jul 2023 14:52:05 +0800
Message-ID: <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gU2F0LCBKdWwgMjIsIDIwMjMgYXQgNDoxOOKAr0FNIE1heGltZSBDb3F1ZWxpbgo8bWF4aW1l
LmNvcXVlbGluQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDcvMjEvMjMgMTc6MTAsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+IE9uIEZyaSwgSnVsIDIxLCAyMDIzIGF0IDA0OjU4
OjA0UE0gKzAyMDAsIE1heGltZSBDb3F1ZWxpbiB3cm90ZToKPiA+Pgo+ID4+Cj4gPj4gT24gNy8y
MS8yMyAxNjo0NSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4+PiBPbiBGcmksIEp1bCAy
MSwgMjAyMyBhdCAwNDozNzowMFBNICswMjAwLCBNYXhpbWUgQ29xdWVsaW4gd3JvdGU6Cj4gPj4+
Pgo+ID4+Pj4KPiA+Pj4+IE9uIDcvMjAvMjMgMjM6MDIsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+Pj4+PiBPbiBUaHUsIEp1bCAyMCwgMjAyMyBhdCAwMToyNjoyMFBNIC0wNzAwLCBTaGFu
bm9uIE5lbHNvbiB3cm90ZToKPiA+Pj4+Pj4gT24gNy8yMC8yMyAxOjM4IEFNLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+IEFkZGluZyBjb25kX3Jlc2NoZWQoKSB0byB0aGUg
Y29tbWFuZCB3YWl0aW5nIGxvb3AgZm9yIGEgYmV0dGVyCj4gPj4+Pj4+PiBjby1vcGVyYXRpb24g
d2l0aCB0aGUgc2NoZWR1bGVyLiBUaGlzIGFsbG93cyB0byBnaXZlIENQVSBhIGJyZWF0aCB0bwo+
ID4+Pj4+Pj4gcnVuIG90aGVyIHRhc2sod29ya3F1ZXVlKSBpbnN0ZWFkIG9mIGJ1c3kgbG9vcGlu
ZyB3aGVuIHByZWVtcHRpb24gaXMKPiA+Pj4+Pj4+IG5vdCBhbGxvd2VkIG9uIGEgZGV2aWNlIHdo
b3NlIENWUSBtaWdodCBiZSBzbG93Lgo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPj4+Pj4+Cj4gPj4+Pj4+IFRoaXMg
c3RpbGwgbGVhdmVzIGh1bmcgcHJvY2Vzc2VzLCBidXQgYXQgbGVhc3QgaXQgZG9lc24ndCBwaW4g
dGhlIENQVSBhbnkKPiA+Pj4+Pj4gbW9yZS4gIFRoYW5rcy4KPiA+Pj4+Pj4gUmV2aWV3ZWQtYnk6
IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+ID4+Pj4+Pgo+ID4+Pj4+
Cj4gPj4+Pj4gSSdkIGxpa2UgdG8gc2VlIGEgZnVsbCBzb2x1dGlvbgo+ID4+Pj4+IDEtIGJsb2Nr
IHVudGlsIGludGVycnVwdAoKSSByZW1lbWJlciBpbiBwcmV2aW91cyB2ZXJzaW9ucywgeW91IHdv
cnJpZWQgYWJvdXQgdGhlIGV4dHJhIE1TSQp2ZWN0b3IuIChNYXliZSBJIHdhcyB3cm9uZykuCgo+
ID4+Pj4KPiA+Pj4+IFdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gYWxzbyBoYXZlIGEgdGltZW91dD8K
PiA+Pj4+IEFuZCB3aGVuIHRpbWVvdXQgZXhwaXJlcywgc2V0IEZBSUxFRCBiaXQgaW4gZGV2aWNl
IHN0YXR1cz8KPiA+Pj4KPiA+Pj4gdmlydGlvIHNwZWMgZG9lcyBub3Qgc2V0IGFueSBsaW1pdHMg
b24gdGhlIHRpbWluZyBvZiB2cQo+ID4+PiBwcm9jZXNzaW5nLgo+ID4+Cj4gPj4gSW5kZWVkLCBi
dXQgSSB0aG91Z2h0IHRoZSBkcml2ZXIgY291bGQgZGVjaWRlIGl0IGlzIHRvbyBsb25nIGZvciBp
dC4KPiA+Pgo+ID4+IFRoZSBpc3N1ZSBpcyB3ZSBrZWVwIHdhaXRpbmcgd2l0aCBydG5sIGxvY2tl
ZCwgaXQgY2FuIHF1aWNrbHkgbWFrZSB0aGUKPiA+PiBzeXN0ZW0gdW51c2FibGUuCj4gPgo+ID4g
aWYgdGhpcyBpcyBhIHByb2JsZW0gd2Ugc2hvdWxkIGZpbmQgYSB3YXkgbm90IHRvIGtlZXAgcnRu
bAo+ID4gbG9ja2VkIGluZGVmaW5pdGVseS4KCkFueSBpZGVhcyBvbiB0aGlzIGRpcmVjdGlvbj8g
U2ltcGx5IGRyb3BwaW5nIHJ0bmwgZHVyaW5nIHRoZSBidXN5IGxvb3AKd2lsbCByZXN1bHQgaW4g
YSBsb3Qgb2YgcmFjZXMuIFRoaXMgc2VlbXMgdG8gcmVxdWlyZSBub24tdHJpdmlhbApjaGFuZ2Vz
IGluIHRoZSBuZXR3b3JraW5nIGNvcmUuCgo+Cj4gIEZyb20gdGhlIHRlc3RzIEkgaGF2ZSBkb25l
LCBJIHRoaW5rIGl0IGlzLiBXaXRoIE9WUywgYSByZWNvbmZpZ3VyYXRpb24KPiBpcyBwZXJmb3Jt
ZWQgd2hlbiB0aGUgVkRVU0UgZGV2aWNlIGlzIGFkZGVkLCBhbmQgd2hlbiBhIE1MWDUgZGV2aWNl
IGlzCj4gaW4gdGhlIHNhbWUgYnJpZGdlLCBpdCBlbmRzIHVwIGRvaW5nIGFuIGlvY3RsKCkgdGhh
dCB0cmllcyB0byB0YWtlIHRoZQo+IHJ0bmwgbG9jay4gSW4gdGhpcyBjb25maWd1cmF0aW9uLCBp
dCBpcyBub3QgcG9zc2libGUgdG8ga2lsbCBPVlMgYmVjYXVzZQo+IGl0IGlzIHN0dWNrIHRyeWlu
ZyB0byBhY3F1aXJlIHJ0bmwgbG9jayBmb3IgbWx4NSB0aGF0IGlzIGhlbGQgYnkgdmlydGlvLQo+
IG5ldC4KClllYWgsIGJhc2ljYWxseSwgYW55IFJUTkwgdXNlcnMgd291bGQgYmUgYmxvY2tlZCBm
b3JldmVyLgoKQW5kIHRoZSBpbmZpbml0ZSBsb29wIGhhcyBvdGhlciBzaWRlIGVmZmVjdHMgbGlr
ZSBpdCBibG9ja3MgdGhlIGZyZWV6ZXIgdG8gd29yay4KClRvIHN1bW1hcml6ZSwgdGhlcmUgYXJl
IHRocmVlIGlzc3VlcwoKMSkgYnVzeSBwb2xsaW5nCjIpIGJyZWFrcyBmcmVlemVyCjMpIGhvbGQg
UlROTCBkdXJpbmcgdGhlIGxvb3AKClNvbHZpbmcgMyBtYXkgaGVscCBzb21laG93IGZvciAyIGUu
ZyBzb21lIHBtIHJvdXRpbmUgZS5nIHdpcmVndWFyZCBvcgpldmVuIHZpcnRuZXRfcmVzdG9yZSgp
IGl0c2VsZiBtYXkgdHJ5IHRvIGhvbGQgdGhlIGxvY2suCgo+Cj4gPgo+ID4+Pj4+IDItIHN0aWxs
IGhhbmRsZSBzdXJwcmlzZSByZW1vdmFsIGNvcnJlY3RseSBieSB3YWtpbmcgaW4gdGhhdCBjYXNl
CgpUaGlzIGlzIGJhc2ljYWxseSB3aGF0IHZlcnNpb24gMSBkaWQ/CgpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzYwMjZlODAxLTZmZGEtZmVlOS1hNjliLWQwNmE4MDM2ODYyMUByZWRoYXQu
Y29tL3QvCgpUaGFua3MKCj4gPj4+Pj4KPiA+Pj4+Pgo+ID4+Pj4+Cj4gPj4+Pj4+PiAtLS0KPiA+
Pj4+Pj4+ICAgICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNCArKystCj4gPj4+Pj4+PiAg
ICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+Pj4+
Pj4+Cj4gPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gPj4+Pj4+PiBpbmRleCA5ZjNiMWQ2YWMzM2QuLmU3NTMz
ZjI5YjIxOSAxMDA2NDQKPiA+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+
ID4+Pj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPj4+Pj4+PiBAQCAtMjMx
NCw4ICsyMzE0LDEwIEBAIHN0YXRpYyBib29sIHZpcnRuZXRfc2VuZF9jb21tYW5kKHN0cnVjdCB2
aXJ0bmV0X2luZm8gKnZpLCB1OCBjbGFzcywgdTggY21kLAo+ID4+Pj4+Pj4gICAgICAgICAgICAg
ICogaW50byB0aGUgaHlwZXJ2aXNvciwgc28gdGhlIHJlcXVlc3Qgc2hvdWxkIGJlIGhhbmRsZWQg
aW1tZWRpYXRlbHkuCj4gPj4+Pj4+PiAgICAgICAgICAgICAgKi8KPiA+Pj4+Pj4+ICAgICAgICAg
ICAgIHdoaWxlICghdmlydHF1ZXVlX2dldF9idWYodmktPmN2cSwgJnRtcCkgJiYKPiA+Pj4+Pj4+
IC0gICAgICAgICAgICAgICF2aXJ0cXVldWVfaXNfYnJva2VuKHZpLT5jdnEpKQo+ID4+Pj4+Pj4g
KyAgICAgICAgICAgICAgIXZpcnRxdWV1ZV9pc19icm9rZW4odmktPmN2cSkpIHsKPiA+Pj4+Pj4+
ICsgICAgICAgICAgICAgICBjb25kX3Jlc2NoZWQoKTsKPiA+Pj4+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgY3B1X3JlbGF4KCk7Cj4gPj4+Pj4+PiArICAgICAgIH0KPiA+Pj4+Pj4+Cj4gPj4+Pj4+
PiAgICAgICAgICAgICByZXR1cm4gdmktPmN0cmwtPnN0YXR1cyA9PSBWSVJUSU9fTkVUX09LOwo+
ID4+Pj4+Pj4gICAgICB9Cj4gPj4+Pj4+PiAtLQo+ID4+Pj4+Pj4gMi4zOS4zCj4gPj4+Pj4+Pgo+
ID4+Pj4+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiA+Pj4+Pj4+IFZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdAo+ID4+Pj4+Pj4gVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiA+Pj4+Pj4+IGh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9uCj4gPj4+
Pj4KPiA+Pj4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
