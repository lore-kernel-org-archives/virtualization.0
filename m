Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0666EC76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 03:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 827AA40C29;
	Tue, 28 Mar 2023 03:44:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 827AA40C29
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B/2dHuVS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M4IiGgF3QRCV; Tue, 28 Mar 2023 03:44:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CACB240129;
	Tue, 28 Mar 2023 03:44:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CACB240129
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94CD3C007C;
	Tue, 28 Mar 2023 03:44:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 324D5C007A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 03:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06B3B81BA8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 03:44:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06B3B81BA8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=B/2dHuVS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bp1hyLjyxu9q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 03:44:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 292CF81B72
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 292CF81B72
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 03:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679975066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3SpR+aNzpuiNbmMwcftC5yQe1ULNEzpRW5A6APnqEo=;
 b=B/2dHuVSrsVykPIpGfIp9UwUS0nN1waTuckWpwZqxbVtcAtbKBjswEm5Zijuh+zhbWPenS
 oUtKBNo8vjeotsPuHYORSJLagkC1qB6apgZ/8p0PVaGbLdFN4M79LjqRzScwSv1cl5Pu4D
 TmW/GynNs/I/F/2R+VCOj0o+kbhDqa4=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-aJ8axS0KPtiG6ZRACCGSeQ-1; Mon, 27 Mar 2023 23:44:24 -0400
X-MC-Unique: aJ8axS0KPtiG6ZRACCGSeQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-177c9cc7db5so6215998fac.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 20:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679975064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K3SpR+aNzpuiNbmMwcftC5yQe1ULNEzpRW5A6APnqEo=;
 b=1bkXlI6+MxR1jNdDnXHifGveCDj2bcr2HY8AySMJmuRdDkWjucH6FBhRSK5QRhFM1P
 3y5261PSEpa6pR6K+aUNuHvhEh2Oa3oDElQLEN21Mxil4dwqHp+m4FCDVW+t/NRSUToM
 vToOWNiRWhYHA7gBZYKTofnhp2koQtJIX7nHHtHJDB2lfkjMJszVLvexQFUOTKQp61JH
 A9+mQ+5TY6fGlZTuivBuf9uB1blLmueSOHEfKzMn789yjy1nPAqr9TWdlu2scIZTkRTt
 D4uasWocL7YaMOv0bBdYQB4EXc9cjdQ8qkhX8GprJqwu2sGnz/l6j3Sf2Zk4tr0YnznQ
 /jLg==
X-Gm-Message-State: AAQBX9fcH4A2Ik+pR1kF0OG0TI40GTzQgzi0zw3ccx8vSuSU69HYkO60
 UAOdZwmJdtUPuZQKMa0jjbpN22N6YcfJfmTrHQOIal86JX0fF5O0ZbsSsX2iLdHuqg3twZIK2np
 Ag+sCeDAwuyzskV/uI4mO8xHC9F4sqr5MulNB8M4rgjmIM/zF34wVjdPpgw==
X-Received: by 2002:a05:6871:e45:b0:17f:1723:fc82 with SMTP id
 vk5-20020a0568710e4500b0017f1723fc82mr2377668oab.9.1679975063869; 
 Mon, 27 Mar 2023 20:44:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350brujMRUUxkyu24A854U8qKZyIcDBnAYu48ahVC6qc1K9jGInh2B+qzbASymn1ZBNhTY1XcgR2pBmCW5imGtKY=
X-Received: by 2002:a05:6871:e45:b0:17f:1723:fc82 with SMTP id
 vk5-20020a0568710e4500b0017f1723fc82mr2377659oab.9.1679975063629; Mon, 27 Mar
 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
 <CACycT3sm1P2qDQTNKp+RLmyd84+v8xwErf_g1SXqiaJDQO8LNg@mail.gmail.com>
 <CACGkMEvhXQ9ve4DQnmVu4hRRbCWM3oesR-=KaLisuyJ4-tyQxg@mail.gmail.com>
 <CACycT3uYbnrQDDbFmwdww8ukMU1t9RsAuutHsFT-UzK9_Mc=Kg@mail.gmail.com>
In-Reply-To: <CACycT3uYbnrQDDbFmwdww8ukMU1t9RsAuutHsFT-UzK9_Mc=Kg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Mar 2023 11:44:12 +0800
Message-ID: <CACGkMEtRU3qeMazJ2j3u_RC1bUga75Oix0jRJeUJBUF=8QJMgQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
To: Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgMTE6MzPigK9BTSBZb25namkgWGllIDx4aWV5b25namlA
Ynl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIE1hciAyOCwgMjAyMyBhdCAxMToxNOKA
r0FNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1
ZSwgTWFyIDI4LCAyMDIzIGF0IDExOjAz4oCvQU0gWW9uZ2ppIFhpZSA8eGlleW9uZ2ppQGJ5dGVk
YW5jZS5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBGcmksIE1hciAyNCwgMjAyMyBhdCAyOjI4
4oCvUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+
ID4gPiBPbiBUaHUsIE1hciAyMywgMjAyMyBhdCAxOjMx4oCvUE0gWGllIFlvbmdqaSA8eGlleW9u
Z2ppQGJ5dGVkYW5jZS5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRvIHN1cHBvcnQg
aW50ZXJydXB0IGFmZmluaXR5IHNwcmVhZGluZyBtZWNoYW5pc20sCj4gPiA+ID4gPiB0aGlzIG1h
a2VzIHVzZSBvZiBncm91cF9jcHVzX2V2ZW5seSgpIHRvIGNyZWF0ZQo+ID4gPiA+ID4gYW4gaXJx
IGNhbGxiYWNrIGFmZmluaXR5IG1hc2sgZm9yIGVhY2ggdmlydHF1ZXVlCj4gPiA+ID4gPiBvZiB2
ZHBhIGRldmljZS4gVGhlbiB3ZSB3aWxsIHVuaWZ5IHNldF92cV9hZmZpbml0eQo+ID4gPiA+ID4g
Y2FsbGJhY2sgdG8gcGFzcyB0aGUgYWZmaW5pdHkgdG8gdGhlIHZkcGEgZGV2aWNlIGRyaXZlci4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlA
Ynl0ZWRhbmNlLmNvbT4KPiA+ID4gPgo+ID4gPiA+IFRoaW5raW5nIGhhcmQgb2YgYWxsIHRoZSBs
b2dpY3MsIEkgdGhpbmsgSSd2ZSBmb3VuZCBzb21ldGhpbmcgaW50ZXJlc3RpbmcuCj4gPiA+ID4K
PiA+ID4gPiBDb21taXQgYWQ3MTQ3M2Q5YzQzNyAoInZpcnRpb19ibGs6IHVzZSB2aXJ0aW8gSVJR
IGFmZmluaXR5IikgdHJpZXMgdG8KPiA+ID4gPiBwYXNzIGlycV9hZmZpbml0eSB0byB0cmFuc3Bv
cnQgc3BlY2lmaWMgZmluZF92cXMoKS4gIFRoaXMgc2VlbXMgYQo+ID4gPiA+IGxheWVyIHZpb2xh
dGlvbiBzaW5jZSBkcml2ZXIgaGFzIG5vIGtub3dsZWRnZSBvZgo+ID4gPiA+Cj4gPiA+ID4gMSkg
d2hldGhlciBvciBub3QgdGhlIGNhbGxiYWNrIGlzIGJhc2VkIG9uIGFuIElSUQo+ID4gPiA+IDIp
IHdoZXRoZXIgb3Igbm90IHRoZSBkZXZpY2UgaXMgYSBQQ0kgb3Igbm90ICh0aGUgZGV0YWlscyBh
cmUgaGlkZWQgYnkKPiA+ID4gPiB0aGUgdHJhbnNwb3J0IGRyaXZlcikKPiA+ID4gPiAzKSBob3cg
bWFueSB2ZWN0b3JzIGNvdWxkIGJlIHVzZWQgYnkgYSBkZXZpY2UKPiA+ID4gPgo+ID4gPiA+IFRo
aXMgbWVhbnMgdGhlIGRyaXZlciBjYW4ndCBhY3R1YWxseSBwYXNzIGEgcmVhbCBhZmZpbml0eSBt
YXNrcyBzbyB0aGUKPiA+ID4gPiBjb21taXQgcGFzc2VzIGEgemVybyBpcnEgYWZmaW5pdHkgc3Ry
dWN0dXJlIGFzIGEgaGludCBpbiBmYWN0LCBzbyB0aGUKPiA+ID4gPiBQQ0kgbGF5ZXIgY2FuIGJ1
aWxkIGEgZGVmYXVsdCBhZmZpbml0eSBiYXNlZCB0aGF0IGdyb3VwcyBjcHVzIGV2ZW5seQo+ID4g
PiA+IGJhc2VkIG9uIHRoZSBudW1iZXIgb2YgTVNJLVggdmVjdG9ycyAodGhlIGNvcmUgbG9naWMg
aXMgdGhlCj4gPiA+ID4gZ3JvdXBfY3B1c19ldmVubHkpLiBJIHRoaW5rIHdlIHNob3VsZCBmaXgg
dGhpcyBieSByZXBsYWNpbmcgdGhlCj4gPiA+ID4gaXJxX2FmZmluaXR5IHN0cnVjdHVyZSB3aXRo
Cj4gPiA+ID4KPiA+ID4gPiAxKSBhIGJvb2xlYW4gbGlrZSBhdXRvX2NiX3NwcmVhZGluZwo+ID4g
PiA+Cj4gPiA+ID4gb3IKPiA+ID4gPgo+ID4gPiA+IDIpIHF1ZXVlIHRvIGNwdSBtYXBwaW5nCj4g
PiA+ID4KPiA+ID4KPiA+ID4gQnV0IG9ubHkgdGhlIGRyaXZlciBrbm93cyB3aGljaCBxdWV1ZXMg
YXJlIHVzZWQgaW4gdGhlIGNvbnRyb2wgcGF0aAo+ID4gPiB3aGljaCBkb24ndCBuZWVkIHRoZSBh
dXRvbWF0aWMgaXJxIGFmZmluaXR5IGFzc2lnbm1lbnQuCj4gPgo+ID4gSXMgdGhpcyBrbm93bGVk
Z2UgYXdhcmRlZCBieSB0aGUgdHJhbnNwb3J0IGRyaXZlciBub3c/Cj4gPgo+Cj4gVGhpcyBrbm93
bGVkZ2UgaXMgYXdhcmRlZCBieSB0aGUgZGV2aWNlIGRyaXZlciByYXRoZXIgdGhhbiB0aGUgdHJh
bnNwb3J0IGRyaXZlci4KPgo+IEUuZy4gdmlydGlvLXNjc2kgdXNlczoKPgo+ICAgICBzdHJ1Y3Qg
aXJxX2FmZmluaXR5IGRlc2MgPSB7IC5wcmVfdmVjdG9ycyA9IDIgfTsgLy8gdnEwIGlzIGNvbnRy
b2wKPiBxdWV1ZSwgdnExIGlzIGV2ZW50IHF1ZXVlCgpPaywgYnV0IGl0IG9ubHkgd29ya3MgYXMg
YSBoaW50LCBpdCdzIG5vdCBhIHJlYWwgYWZmaW5pdHkuIEFzIHJlcGxpZWQsCndlIGNhbiBwYXNz
IGFuIGFycmF5IG9mIGJvb2xlYW4gaW4gdGhpcyBjYXNlIHRoZW4gdHJhbnNwb3J0IGRyaXZlcgpr
bm93cyBpdCBkb2Vzbid0IG5lZWQgdG8gdXNlIGF1dG9tYXRpYyBhZmZpbml0eSBmb3IgdGhlIGZp
cnN0IHR3bwpxdWV1ZXMuCgo+Cj4gPiBFLmcgdmlydGlvLWJsayB1c2VzOgo+ID4KPiA+ICAgICAg
ICAgc3RydWN0IGlycV9hZmZpbml0eSBkZXNjID0geyAwLCB9Owo+ID4KPiA+IEF0bGVhc3Qgd2Ug
Y2FuIHRlbGwgdGhlIHRyYW5zcG9ydCBkcml2ZXIgd2hpY2ggdnEgcmVxdWlyZXMgYXV0b21hdGlj
Cj4gPiBpcnEgYWZmaW5pdHkuCj4gPgo+Cj4gSSB0aGluayB0aGF0IGlzIHdoYXQgdGhlIGN1cnJl
bnQgaW1wbGVtZW50YXRpb24gZG9lcy4KPgo+ID4gPiBTbyBJIHRoaW5rIHRoZQo+ID4gPiBpcnFf
YWZmaW5pdHkgc3RydWN0dXJlIGNhbiBvbmx5IGJlIGNyZWF0ZWQgYnkgZGV2aWNlIGRyaXZlcnMg
YW5kCj4gPiA+IHBhc3NlZCB0byB0aGUgdmlydGlvLXBjaS92aXJ0aW8tdmRwYSBkcml2ZXIuCj4g
Pgo+ID4gVGhpcyBjb3VsZCBiZSBub3QgZWFzeSBzaW5jZSB0aGUgZHJpdmVyIGRvZXNuJ3QgZXZl
biBrbm93IGhvdyBtYW55Cj4gPiBpbnRlcnJ1cHRzIHdpbGwgYmUgdXNlZCBieSB0aGUgdHJhbnNw
b3J0IGRyaXZlciwgc28gaXQgY2FuJ3QgYnVpbHQgdGhlCj4gPiBhY3R1YWwgYWZmaW5pdHkgc3Ry
dWN0dXJlLgo+ID4KPgo+IFRoZSBhY3R1YWwgYWZmaW5pdHkgbWFzayBpcyBidWlsdCBieSB0aGUg
dHJhbnNwb3J0IGRyaXZlciwKCkZvciBQQ0kgeWVzLCBpdCB0YWxrcyBkaXJlY3RseSB0byB0aGUg
SVJRIHN1YnN5c3RlbXMuCgo+IGRldmljZQo+IGRyaXZlciBvbmx5IHBhc3NlcyBhIGhpbnQgb24g
d2hpY2ggcXVldWVzIGRvbid0IG5lZWQgdGhlIGF1dG9tYXRpYyBpcnEKPiBhZmZpbml0eSBhc3Np
Z25tZW50LgoKQnV0IG5vdCBmb3IgdmlydGlvLXZEUEEgc2luY2UgdGhlIElSUSBuZWVkcyB0byBi
ZSBkZWFsdCB3aXRoIGJ5IHRoZQpwYXJlbnQgZHJpdmVyLiBGb3Igb3VyIGNhc2UsIGl0J3MgdGhl
IFZEVVNFIHdoZXJlIGl0IGRvZXNuJ3QgbmVlZCBJUlEKYXQgYWxsLCBhIHF1ZXVlIHRvIGNwdSBt
YXBwaW5nIGlzIHN1ZmZpY2llbnQuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
