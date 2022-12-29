Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62265C4332F
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 07:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC88560C0C;
	Thu, 29 Dec 2022 07:07:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC88560C0C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OJ6pv0og
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RaBYi8XYHdTv; Thu, 29 Dec 2022 07:07:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2DC3060AF6;
	Thu, 29 Dec 2022 07:07:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2DC3060AF6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E67E0C0032;
	Thu, 29 Dec 2022 07:07:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21483C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 07:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0101B403CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 07:07:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0101B403CC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OJ6pv0og
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qMqgQhFliP95
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 07:07:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C22E403CA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C22E403CA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 07:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672297664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPu20pS/DdT91F8IydmlqqU8a82kyRMHKQeQqC1iCsQ=;
 b=OJ6pv0ogIB7Nb+/yKoZBRJYRJR23QtqtMlgChiDZ+22dzrivOfj8ibERC9lDOBzeLUiyLs
 o6LYJxxNKV3r66kPTSm58xhqQRos6KkTymObgaRWJzfsU5C7YFQmsszw64E+LiCr86TFRd
 9IowozBdcJqhtbN7J19zEbX+ceLr+bY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-ckBAcTKQM6-tEx_2PPSbWQ-1; Thu, 29 Dec 2022 02:07:42 -0500
X-MC-Unique: ckBAcTKQM6-tEx_2PPSbWQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 sc9-20020a1709078a0900b0084c4e8dc14eso6404387ejc.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 23:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bPu20pS/DdT91F8IydmlqqU8a82kyRMHKQeQqC1iCsQ=;
 b=u68AdGnV7n4mMf8iGMniSYhIFNbgsRSERsWgpc8YBZBUYGQZEmdhK3/l9m/ynt5dNP
 sg0BQwr5bLU3UIFOXKLSQ0SPfs+qga+fEi7ugYgwddv41Yktx0drWHlPhon5ESD6DCn4
 aQEhxfH7EVyUSd2hGOZSMmcZ9NJG3onwou6EtRwCJ/YZLPgLFsLdXasdmCVZpNUHYPsz
 vc6VmH7hbmv2jU1NAW920PdOHBnOLWUooNbVO8XS21nS6Asog99HcTzbozUCfseWeRt/
 MMQ9pdN2wFMjCqCdi6qjo7PO6mZfnatsXKDJ0rITdXf+8VAjro9YGLVtEUNM/heHgGTn
 l6pA==
X-Gm-Message-State: AFqh2kprjeuwj3TZeQTV7BnP7d0voaV5KCmPXT/3UIk2JWZCejCnH42a
 ptcfwHxRyu05yxGzvGoWi31LV9qg4345ykqaXaRhs2y8veE75Tw73SLUBSj3ZI+j5lCEeo6cBRa
 OZZscssgYeGG5aTaGJoT2FkiZpVthb1zNNG+Dxhh5mw==
X-Received: by 2002:a17:906:298f:b0:7c0:fa2c:fc9b with SMTP id
 x15-20020a170906298f00b007c0fa2cfc9bmr25411317eje.55.1672297661225; 
 Wed, 28 Dec 2022 23:07:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuRUDqAyosWJYpOIWrOSpWIbCvCqFmJmOZzZEXMSAjeKwf2iMUA7V6PSBUnHR31Ghwj8Gddrg==
X-Received: by 2002:a17:906:298f:b0:7c0:fa2c:fc9b with SMTP id
 x15-20020a170906298f00b007c0fa2cfc9bmr25411307eje.55.1672297660951; 
 Wed, 28 Dec 2022 23:07:40 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 b11-20020a17090630cb00b007c0f5d6f754sm8249151ejb.79.2022.12.28.23.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Dec 2022 23:07:40 -0800 (PST)
Date: Thu, 29 Dec 2022 02:07:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20221229020553-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
 <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org>
 <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
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

T24gV2VkLCBEZWMgMjgsIDIwMjIgYXQgMDc6NTM6MDhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIERlYyAyOCwgMjAyMiBhdCAyOjM0IFBNIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiDlnKggMjAyMi8xMi8yNyAxNzozOCwgTWlj
aGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgMDU6
MTI6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4+IOWcqCAyMDIyLzEyLzI3IDE1
OjMzLCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4gPj4+IE9uIFR1ZSwgRGVjIDI3LCAy
MDIyIGF0IDEyOjMwOjM1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+Pj4+PiBCdXQg
ZGV2aWNlIGlzIHN0aWxsIGdvaW5nIGFuZCB3aWxsIGxhdGVyIHVzZSB0aGUgYnVmZmVycy4KPiA+
ID4+Pj4+Cj4gPiA+Pj4+PiBTYW1lIGZvciB0aW1lb3V0IHJlYWxseS4KPiA+ID4+Pj4gQXZvaWRp
bmcgaW5maW5pdGUgd2FpdC9wb2xsIGlzIG9uZSBvZiB0aGUgZ29hbHMsIGFub3RoZXIgaXMgdG8g
c2xlZXAuCj4gPiA+Pj4+IElmIHdlIHRoaW5rIHRoZSB0aW1lb3V0IGlzIGhhcmQsIHdlIGNhbiBz
dGFydCBmcm9tIHRoZSB3YWl0Lgo+ID4gPj4+Pgo+ID4gPj4+PiBUaGFua3MKPiA+ID4+PiBJZiB0
aGUgZ29hbCBpcyB0byBhdm9pZCBkaXNydXB0aW5nIHRyYWZmaWMgd2hpbGUgQ1ZRIGlzIGluIHVz
ZSwKPiA+ID4+PiB0aGF0IHNvdW5kcyBtb3JlIHJlYXNvbmFibGUuIEUuZy4gc29tZW9uZSBpcyB0
dXJuaW5nIG9uIHByb21pc2MsCj4gPiA+Pj4gYSBzcGlrZSBpbiBDUFUgdXNhZ2UgbWlnaHQgYmUg
dW53ZWxjb21lLgo+ID4gPj4KPiA+ID4+IFllcywgdGhpcyB3b3VsZCBiZSBtb3JlIG9idmlvdXMg
aXMgVVAgaXMgdXNlZC4KPiA+ID4+Cj4gPiA+Pgo+ID4gPj4+IHRoaW5ncyB3ZSBzaG91bGQgYmUg
Y2FyZWZ1bCB0byBhZGRyZXNzIHRoZW46Cj4gPiA+Pj4gMS0gZGVidWdnaW5nLiBDdXJyZW50bHkg
aXQncyBlYXN5IHRvIHNlZSBhIHdhcm5pbmcgaWYgQ1BVIGlzIHN0dWNrCj4gPiA+Pj4gICAgICBp
biBhIGxvb3AgZm9yIGEgd2hpbGUsIGFuZCB3ZSBhbHNvIGdldCBhIGJhY2t0cmFjZS4KPiA+ID4+
PiAgICAgIEUuZy4gd2l0aCB0aGlzIC0gaG93IGRvIHdlIGtub3cgd2hvIGhhcyB0aGUgUlROTD8K
PiA+ID4+PiAgICAgIFdlIG5lZWQgdG8gaW50ZWdyYXRlIHdpdGgga2VybmVsL3dhdGNoZG9nLmMg
Zm9yIGdvb2QgcmVzdWx0cwo+ID4gPj4+ICAgICAgYW5kIHRvIG1ha2Ugc3VyZSBwb2xpY3kgaXMg
Y29uc2lzdGVudC4KPiA+ID4+Cj4gPiA+PiBUaGF0J3MgZmluZSwgd2lsbCBjb25zaWRlciB0aGlz
Lgo+IAo+IFNvIGFmdGVyIHNvbWUgaW52ZXN0aWdhdGlvbiwgaXQgc2VlbXMgdGhlIHdhdGNoZG9n
LmMgZG9lc24ndCBoZWxwLiBUaGUKPiBvbmx5IGV4cG9ydCBoZWxwZXIgaXMgdG91Y2hfc29mdGxv
Y2t1cF93YXRjaGRvZygpIHdoaWNoIHRyaWVzIHRvIGF2b2lkCj4gdHJpZ2dlcmluZyB0aGUgbG9j
a3VwcyB3YXJuaW5nIGZvciB0aGUga25vd24gc2xvdyBwYXRoLgoKSSBuZXZlciBzYWlkIHlvdSBj
YW4ganVzdCB1c2UgZXhpc3RpbmcgZXhwb3J0aW5nIEFQSXMuIFlvdSdsbCBoYXZlIHRvCndyaXRl
IG5ldyBvbmVzIDopCgo+IEFuZCBiZWZvcmUgdGhlIHBhdGNoLCB3ZSBlbmQgdXAgd2l0aCBhIHJl
YWwgaW5maW5pdGUgbG9vcCB3aGljaCBjb3VsZAo+IGJlIGNhdWdodCBieSBSQ1Ugc3RhbGwgZGV0
ZWN0b3Igd2hpY2ggaXMgbm90IHRoZSBjYXNlIG9mIHRoZSBzbGVlcC4KPiBXaGF0IHdlIGNhbiBk
byBpcyBwcm9iYWJseSBkbyBhIHBlcmlvZGljIG5ldGRldl9lcnIoKS4KPiAKPiBUaGFua3MKCk9u
bHkgd2l0aCBhIGJhZCBkZXZpY2UuCgo+ID4gPj4KPiA+ID4+Cj4gPiA+Pj4gMi0gb3ZlcmhlYWQu
IEluIGEgdmVyeSBjb21tb24gc2NlbmFyaW8gd2hlbiBkZXZpY2UgaXMgaW4gaHlwZXJ2aXNvciwK
PiA+ID4+PiAgICAgIHByb2dyYW1taW5nIHRpbWVycyBldGMgaGFzIGEgdmVyeSBoaWdoIG92ZXJo
ZWFkLCBhdCBib290dXAKPiA+ID4+PiAgICAgIGxvdHMgb2YgQ1ZRIGNvbW1hbmRzIGFyZSBydW4g
YW5kIHNsb3dpbmcgYm9vdCBkb3duIGlzIG5vdCBuaWNlLgo+ID4gPj4+ICAgICAgbGV0J3MgcG9s
bCBmb3IgYSBiaXQgYmVmb3JlIHdhaXRpbmc/Cj4gPiA+Pgo+ID4gPj4gVGhlbiB3ZSBnbyBiYWNr
IHRvIHRoZSBxdWVzdGlvbiBvZiBjaG9vc2luZyBhIGdvb2QgdGltZW91dCBmb3IgcG9sbC4gQW5k
Cj4gPiA+PiBwb2xsIHNlZW1zIHByb2JsZW1hdGljIGluIHRoZSBjYXNlIG9mIFVQLCBzY2hlZHVs
ZXIgbWlnaHQgbm90IGhhdmUgdGhlCj4gPiA+PiBjaGFuY2UgdG8gcnVuLgo+ID4gPiBQb2xsIGp1
c3QgYSBiaXQgOikgU2VyaW91c2x5IEkgZG9uJ3Qga25vdywgYnV0IGF0IGxlYXN0IGNoZWNrIG9u
Y2UKPiA+ID4gYWZ0ZXIga2ljay4KPiA+Cj4gPgo+ID4gSSB0aGluayBpdCBpcyB3aGF0IHRoZSBj
dXJyZW50IGNvZGUgZGlkIHdoZXJlIHRoZSBjb25kaXRpb24gd2lsbCBiZQo+ID4gY2hlY2sgYmVm
b3JlIHRyeWluZyB0byBzbGVlcCBpbiB0aGUgd2FpdF9ldmVudCgpLgo+ID4KPiA+Cj4gPiA+Cj4g
PiA+Pj4gMy0gc3VwcmlzZSByZW1vdmFsLiBuZWVkIHRvIHdha2UgdXAgdGhyZWFkIGluIHNvbWUg
d2F5LiB3aGF0IGFib3V0Cj4gPiA+Pj4gICAgICBvdGhlciBjYXNlcyBvZiBkZXZpY2UgYnJlYWth
Z2UgLSBpcyB0aGVyZSBhIGNoYW5jZSB0aGlzCj4gPiA+Pj4gICAgICBpbnRyb2R1Y2VzIG5ldyBi
dWdzIGFyb3VuZCB0aGF0PyBhdCBsZWFzdCBlbnVtZXJhdGUgdGhlbSBwbGVhc2UuCj4gPiA+Pgo+
ID4gPj4gVGhlIGN1cnJlbnQgY29kZSBkaWQ6Cj4gPiA+Pgo+ID4gPj4gMSkgY2hlY2sgZm9yIHZx
LT5icm9rZW4KPiA+ID4+IDIpIHdha2V1cCBkdXJpbmcgQkFEX1JJTkcoKQo+ID4gPj4KPiA+ID4+
IFNvIHdlIHdvbid0IGVuZCB1cCB3aXRoIGEgbmV2ZXIgd29rZSB1cCBwcm9jZXNzIHdoaWNoIHNo
b3VsZCBiZSBmaW5lLgo+ID4gPj4KPiA+ID4+IFRoYW5rcwo+ID4gPgo+ID4gPiBCVFcgQkFEX1JJ
Tkcgb24gcmVtb3ZhbCB3aWxsIHRyaWdnZXIgZGV2X2Vyci4gTm90IHN1cmUgdGhhdCBpcyBhIGdv
b2QKPiA+ID4gaWRlYSAtIGNhbiBjYXVzZSBjcmFzaGVzIGlmIGtlcm5lbCBwYW5pY3Mgb24gZXJy
b3IuCj4gPgo+ID4KPiA+IFllcywgaXQncyBiZXR0ZXIgdG8gdXNlIF9fdmlydHF1ZXVlX2JyZWFr
KCkgaW5zdGVhZC4KPiA+Cj4gPiBCdXQgY29uc2lkZXIgd2Ugd2lsbCBzdGFydCBmcm9tIGEgd2Fp
dCBmaXJzdCwgSSB3aWxsIGxpbWl0IHRoZSBjaGFuZ2VzCj4gPiBpbiB2aXJ0aW8tbmV0IHdpdGhv
dXQgYm90aGVyaW5nIHZpcnRpbyBjb3JlLgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+Cj4gPiA+Cj4g
PiA+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
