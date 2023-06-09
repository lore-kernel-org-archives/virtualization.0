Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3641C7EE2E
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 07:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39C0F42032;
	Fri,  9 Jun 2023 07:17:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39C0F42032
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QzPLPBXg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WxYxT5C8kdiG; Fri,  9 Jun 2023 07:17:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 04DB64242F;
	Fri,  9 Jun 2023 07:17:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04DB64242F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C89ECC0037;
	Fri,  9 Jun 2023 07:17:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A39DC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 07:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E12A64242F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 07:17:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E12A64242F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VnTsiHtMEGwb
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 07:17:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 502B442032
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 502B442032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 07:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686295047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=15kZRnaZwPiIUtkudYdawd69yNtpyzsjo2sikqV4oqc=;
 b=QzPLPBXgRgryd1xGQuNIjJXhnFbLjaPVr8/Pge65yJ6h/33uTZpyb11Y670tIAbRlD6RDL
 HX6jzgKgGy5lnbLcSuzz26rjo6NcMET7Sq/3IBAT2uTEKIyFcrWLV1eVscWuPFJ/N1OGl1
 KBkdzZKDpsPWA3kexsLO07uJGF2WG6I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-Khtwp6gWPnCuLqAOE3_aiA-1; Fri, 09 Jun 2023 03:17:26 -0400
X-MC-Unique: Khtwp6gWPnCuLqAOE3_aiA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f7f264c485so7083145e9.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jun 2023 00:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686295045; x=1688887045;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=15kZRnaZwPiIUtkudYdawd69yNtpyzsjo2sikqV4oqc=;
 b=JzSGq3a5k/w+nHpMgtwa0LwEn/M5z3kGHz6O3z1DiUhYvrWlyFhY+RxBK6W6wH1M+a
 jlou9Vqrn9DdUQZUBpVHwF2tRFf4zmJJcNDl8UtCfbZOLTu9047VjGOjGqsNJwKRKG/5
 ju6soJWcDA/FdL4cFJ73vFYHyR8rUdyKbd2LU8z6SxEidAsyob/f9N5TUYV4VNq2gF3i
 WvhoalU7buTXt5b/YRNrSn3PGZ/D6bloGHclC96acWDamVUtdyujLwcutWNJBCMZmT7r
 2Lns88NM5veCmoAXo6Rax8X8gW0okzsl/L/EitWpUFCRL2XqlGU10lCjE+Az9whGPiW0
 Q5Fw==
X-Gm-Message-State: AC+VfDwrMZIOUTHLIaF4BLo/b7s3Wr3TXDDZJ3+dOGrITQFsHDCFWYi7
 nMv3FzbboIqwFqaui+kwxZ4Giwdv9fcEn7G1JYPkLTgvEOQe6non2HmC+YZQEJEvq86qNZ9OHmZ
 g+0YgDwAVgNI8luPSvtuNkbdOMLwtSqfzlQDyDdYdPQ==
X-Received: by 2002:a05:600c:c2:b0:3f7:30c0:c6a with SMTP id
 u2-20020a05600c00c200b003f730c00c6amr433281wmm.25.1686295045440; 
 Fri, 09 Jun 2023 00:17:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7waRKCvgqgJoAjOYyIenyGhdYJn4/2vpRsAbVkjBZW18/rDXsC3rXgUmARtFQATJ5s/wzvLA==
X-Received: by 2002:a05:600c:c2:b0:3f7:30c0:c6a with SMTP id
 u2-20020a05600c00c200b003f730c00c6amr433267wmm.25.1686295045075; 
 Fri, 09 Jun 2023 00:17:25 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 k15-20020a7bc40f000000b003f7f1b3aff1sm1711774wmi.26.2023.06.09.00.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 00:17:24 -0700 (PDT)
Date: Fri, 9 Jun 2023 03:17:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230609031610-mutt-send-email-mst@kernel.org>
References: <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
 <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
 <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
 <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
 <lw3nmkdszqo6jjtneyp4kjlmutooozz7xj2fqyxgh4v2ralptc@vkimgnbfafvi>
 <CACGkMEt1yRV9qOLBqtQQmJA_UoRLCpznT=Gvd5D51Uaz2jakHA@mail.gmail.com>
 <20230608102259-mutt-send-email-mst@kernel.org>
 <CACGkMEvirfb8g0ev=b0CjpL5_SPJabqiQKxdwuRNqG2E=N7iGA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvirfb8g0ev=b0CjpL5_SPJabqiQKxdwuRNqG2E=N7iGA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
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

T24gRnJpLCBKdW4gMDksIDIwMjMgYXQgMTA6MTY6NTBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUaHUsIEp1biA4LCAyMDIzIGF0IDEwOjIz4oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gVGh1LCBKdW4gMDgsIDIwMjMgYXQg
MDU6Mjk6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gVGh1LCBKdW4gOCwg
MjAyMyBhdCA1OjIx4oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29t
PiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIFRodSwgSnVuIDA4LCAyMDIzIGF0IDA1OjAwOjAw
UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPk9uIFRodSwgSnVuIDgsIDIwMjMg
YXQgNDowMOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPiA+ID4gPj4KPiA+ID4gPiA+PiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAwMzo0Njow
MFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4+Cj4gPiA+ID4gPj4gWy4uLl0K
PiA+ID4gPiA+Pgo+ID4gPiA+ID4+ID4+ID4gPiA+ID4gSSBoYXZlIGEgcXVlc3Rpb24gdGhvdWdo
LCB3aGF0IGlmIGRvd24gdGhlIHJvYWQgdGhlcmUKPiA+ID4gPiA+PiA+PiA+ID4gPiA+IGlzIGEg
bmV3IGZlYXR1cmUgdGhhdCBuZWVkcyBtb3JlIGNoYW5nZXM/IEl0IHdpbGwgYmUKPiA+ID4gPiA+
PiA+PiA+ID4gPiA+IGJyb2tlbiB0b28ganVzdCBsaWtlIFBBQ0tFRCBubz8KPiA+ID4gPiA+PiA+
PiA+ID4gPiA+IFNob3VsZG4ndCB2ZHBhIGhhdmUgYW4gYWxsb3dsaXN0IG9mIGZlYXR1cmVzIGl0
IGtub3dzIGhvdwo+ID4gPiA+ID4+ID4+ID4gPiA+ID4gdG8gc3VwcG9ydD8KPiA+ID4gPiA+PiA+
PiA+ID4gPgo+ID4gPiA+ID4+ID4+ID4gPiA+IEl0IGxvb2tzIGxpa2Ugd2UgaGFkIGl0LCBidXQg
d2UgdG9vayBpdCBvdXQgKGJ5IHRoZSB3YXksIHdlIHdlcmUKPiA+ID4gPiA+PiA+PiA+ID4gPiBl
bmFibGluZyBwYWNrZWQgZXZlbiB0aG91Z2ggd2UgZGlkbid0IHN1cHBvcnQgaXQpOgo+ID4gPiA+
ID4+ID4+ID4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTYyMzRmODA1NzRkNzU2OTQ0NGQ4NzE4
MzU1ZmEyODM4ZTkyYjE1OGIKPiA+ID4gPiA+PiA+PiA+ID4gPgo+ID4gPiA+ID4+ID4+ID4gPiA+
IFRoZSBvbmx5IHByb2JsZW0gSSBzZWUgaXMgdGhhdCBmb3IgZWFjaCBuZXcgZmVhdHVyZSB3ZSBo
YXZlIHRvIG1vZGlmeQo+ID4gPiA+ID4+ID4+ID4gPiA+IHRoZSBrZXJuZWwuCj4gPiA+ID4gPj4g
Pj4gPiA+ID4gQ291bGQgd2UgaGF2ZSBuZXcgZmVhdHVyZXMgdGhhdCBkb24ndCByZXF1aXJlIGhh
bmRsaW5nIGJ5IHZob3N0LXZkcGE/Cj4gPiA+ID4gPj4gPj4gPiA+ID4KPiA+ID4gPiA+PiA+PiA+
ID4gPiBUaGFua3MsCj4gPiA+ID4gPj4gPj4gPiA+ID4gU3RlZmFubwo+ID4gPiA+ID4+ID4+ID4g
Pgo+ID4gPiA+ID4+ID4+ID4gPiBKYXNvbiB3aGF0IGRvIHlvdSBzYXkgdG8gcmV2ZXJ0aW5nIHRo
aXM/Cj4gPiA+ID4gPj4gPj4gPgo+ID4gPiA+ID4+ID4+ID4gSSBtYXkgbWlzcyBzb21ldGhpbmcg
YnV0IEkgZG9uJ3Qgc2VlIGFueSBwcm9ibGVtIHdpdGggdkRQQSBjb3JlLgo+ID4gPiA+ID4+ID4+
ID4KPiA+ID4gPiA+PiA+PiA+IEl0J3MgdGhlIGR1dHkgb2YgdGhlIHBhcmVudHMgdG8gYWR2ZXJ0
aXNlIHRoZSBmZWF0dXJlcyBpdCBoYXMuIEZvciBleGFtcGxlLAo+ID4gPiA+ID4+ID4+ID4KPiA+
ID4gPiA+PiA+PiA+IDEpIElmIHNvbWUga2VybmVsIHZlcnNpb24gdGhhdCBpcyBwYWNrZWQgaXMg
bm90IHN1cHBvcnRlZCB2aWEKPiA+ID4gPiA+PiA+PiA+IHNldF92cV9zdGF0ZSwgcGFyZW50cyBz
aG91bGQgbm90IGFkdmVydGlzZSBQQUNLRUQgZmVhdHVyZXMgaW4gdGhpcwo+ID4gPiA+ID4+ID4+
ID4gY2FzZS4KPiA+ID4gPiA+PiA+PiA+IDIpIElmIHRoZSBrZXJuZWwgaGFzIHN1cHBvcnQgcGFj
a2VkIHNldF92cV9zdGF0ZSgpLCBidXQgaXQncyBlbXVsYXRlZAo+ID4gPiA+ID4+ID4+ID4gY3Zx
IGRvZXNuJ3Qgc3VwcG9ydCwgcGFyZW50cyBzaG91bGQgbm90IGFkdmVydGlzZSBQQUNLRUQgYXMg
d2VsbAo+ID4gPiA+ID4+ID4+ID4KPiA+ID4gPiA+PiA+PiA+IElmIGEgcGFyZW50IHZpb2xhdGVz
IHRoZSBhYm92ZSAyLCBpdCBsb29rcyBsaWtlIGEgYnVnIG9mIHRoZSBwYXJlbnRzLgo+ID4gPiA+
ID4+ID4+ID4KPiA+ID4gPiA+PiA+PiA+IFRoYW5rcwo+ID4gPiA+ID4+ID4+Cj4gPiA+ID4gPj4g
Pj4gWWVzIGJ1dCB3aGF0IGFib3V0IHZob3N0X3ZkcGE/IFRhbGtpbmcgYWJvdXQgdGhhdCBub3Qg
dGhlIGNvcmUuCj4gPiA+ID4gPj4gPgo+ID4gPiA+ID4+ID5Ob3Qgc3VyZSBpdCdzIGEgZ29vZCBp
ZGVhIHRvIHdvcmthcm91bmQgcGFyZW50IGJ1Z3MgdmlhIHZob3N0LXZEUEEuCj4gPiA+ID4gPj4K
PiA+ID4gPiA+PiBTb3JyeSwgSSdtIGdldHRpbmcgbG9zdC4uLgo+ID4gPiA+ID4+IFdlIHdlcmUg
dGFsa2luZyBhYm91dCB0aGUgZmFjdCB0aGF0IHZob3N0LXZkcGEgZG9lc24ndCBoYW5kbGUKPiA+
ID4gPiA+PiBTRVRfVlJJTkdfQkFTRS9HRVRfVlJJTkdfQkFTRSBpb2N0bHMgd2VsbCBmb3IgcGFj
a2VkIHZpcnRxdWV1ZSBiZWZvcmUKPiA+ID4gPiA+PiB0aGF0IHNlcmllcyBbMV0sIG5vPwo+ID4g
PiA+ID4+Cj4gPiA+ID4gPj4gVGhlIHBhcmVudHMgc2VlbSBva2F5LCBidXQgbWF5YmUgSSBtaXNz
ZWQgYSBmZXcgdGhpbmdzLgo+ID4gPiA+ID4+Cj4gPiA+ID4gPj4gWzFdIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzIwMjMwNDI0MjI1MDMxLjE4OTQ3LTEtc2hhbm5vbi5u
ZWxzb25AYW1kLmNvbS8KPiA+ID4gPiA+Cj4gPiA+ID4gPlllcywgbW9yZSBiZWxvdy4KPiA+ID4g
PiA+Cj4gPiA+ID4gPj4KPiA+ID4gPiA+PiA+Cj4gPiA+ID4gPj4gPj4gU2hvdWxkIHRoYXQgbm90
IGhhdmUgYSB3aGl0ZWxpc3Qgb2YgZmVhdHVyZXMKPiA+ID4gPiA+PiA+PiBzaW5jZSBpdCBpbnRl
cnByZXRzIGlvY3RscyBkaWZmZXJlbnRseSBkZXBlbmRpbmcgb24gdGhpcz8KPiA+ID4gPiA+PiA+
Cj4gPiA+ID4gPj4gPklmIHRoZXJlJ3MgYSBidWcsIGl0IG1pZ2h0IG9ubHkgbWF0dGVyIHRoZSBm
b2xsb3dpbmcgc2V0dXA6Cj4gPiA+ID4gPj4gPgo+ID4gPiA+ID4+ID5TRVRfVlJJTkdfQkFTRS9H
RVRfVlJJTkdfQkFTRSArIFZEVVNFLgo+ID4gPiA+ID4+ID4KPiA+ID4gPiA+PiA+VGhpcyBzZWVt
cyB0byBiZSBicm9rZW4gc2luY2UgVkRVU0Ugd2FzIGludHJvZHVjZWQuIElmIHdlIHJlYWxseSB3
YW50Cj4gPiA+ID4gPj4gPnRvIGJhY2twb3J0IHNvbWV0aGluZywgaXQgY291bGQgYmUgYSBmaXgg
dG8gZmlsdGVyIG91dCBQQUNLRUQgaW4KPiA+ID4gPiA+PiA+VkRVU0U/Cj4gPiA+ID4gPj4KPiA+
ID4gPiA+PiBtbW0gaXQgZG9lc24ndCBzZWVtIHRvIGJlIGEgcHJvYmxlbSBpbiBWRFVTRSwgYnV0
IGluIHZob3N0LXZkcGEuCj4gPiA+ID4gPj4gSSB0aGluayBWRFVTRSB3b3JrcyBmaW5lIHdpdGgg
cGFja2VkIHZpcnRxdWV1ZSB1c2luZyB2aXJ0aW8tdmRwYQo+ID4gPiA+ID4+IChJIGhhdmVuJ3Qg
dHJpZWQpLCBzbyB3aHkgc2hvdWxkIHdlIGZpbHRlciBQQUNLRUQgaW4gVkRVU0U/Cj4gPiA+ID4g
Pgo+ID4gPiA+ID5JIGRvbid0IHRoaW5rIHdlIG5lZWQgYW55IGZpbHRlcmluZyBzaW5jZToKPiA+
ID4gPiA+Cj4gPiA+ID4gPlBBQ0tFRCBmZWF0dXJlcyBoYXMgYmVlbiBhZHZlcnRpc2VkIHRvIHVz
ZXJzcGFjZSB2aWEgdUFQSSBzaW5jZQo+ID4gPiA+ID42MjM0ZjgwNTc0ZDc1Njk0NDRkODcxODM1
NWZhMjgzOGU5MmIxNThiLiBPbmNlIHdlIHJlbGF4IGluIHVBUEksIGl0Cj4gPiA+ID4gPndvdWxk
IGJlIHZlcnkgaGFyZCB0byByZXN0cmljdCBpdCBhZ2Fpbi4gRm9yIHRoZSB1c2Vyc3BhY2UgdGhh
dCB0cmllcwo+ID4gPiA+ID50byBuZWdvdGlhdGUgUEFDS0VEOgo+ID4gPiA+ID4KPiA+ID4gPiA+
MSkgaWYgaXQgZG9lc24ndCB1c2UgU0VUX1ZSSU5HX0JBU0UvR0VUX1ZSSU5HX0JBU0UsIGV2ZXJ5
dGhpbmcgd29ya3Mgd2VsbAo+ID4gPiA+ID4yKSBpZiBpdCB1c2VzIFNFVF9WUklOR19CQVNFL0dF
VF9WUklOR19CQVNFLiBpdCBtaWdodCBmYWlsIG9yIGJyZWFrIHNpbGVudGx5Cj4gPiA+ID4gPgo+
ID4gPiA+ID5JZiB3ZSBiYWNrcG9ydCB0aGUgZml4ZXMgdG8gLXN0YWJsZSwgd2UgbWF5IGJyZWFr
IHRoZSBhcHBsaWNhdGlvbiBhdAo+ID4gPiA+ID5sZWFzdCBpbiB0aGUgY2FzZSAxKS4KPiA+ID4g
Pgo+ID4gPiA+IE9rYXksIEkgc2VlIG5vdywgdGhhbmtzIGZvciB0aGUgZGV0YWlscyEKPiA+ID4g
Pgo+ID4gPiA+IE1heWJlIGluc3RlYWQgb2YgImJyZWFrIHNpbGVudGx5Iiwgd2UgY2FuIHJldHVy
biBhbiBleHBsaWNpdCBlcnJvciBmb3IKPiA+ID4gPiBTRVRfVlJJTkdfQkFTRS9HRVRfVlJJTkdf
QkFTRSBpbiBzdGFibGUgYnJhbmNoZXMuCj4gPiA+ID4gQnV0IGlmIHRoZXJlIGFyZSBub3QgbWFu
eSBjYXNlcywgd2UgY2FuIGxlYXZlIGl0IGxpa2UgdGhhdC4KPiA+ID4KPiA+ID4gQSBzZWNvbmQg
dGhvdWdodCwgaWYgd2UgbmVlZCB0byBkbyBzb21ldGhpbmcgZm9yIHN0YWJsZS4gaXMgaXQgYmV0
dGVyCj4gPiA+IGlmIHdlIGp1c3QgYmFja3BvcnQgU2hhbm5vbidzIHNlcmllcyB0byBzdGFibGU/
Cj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBJIHdhcyBqdXN0IGNvbmNlcm5lZCBhYm91dCBob3cgZG9l
cyB0aGUgdXNlciBzcGFjZSB1bmRlcnN0YW5kIHRoYXQgaXQKPiA+ID4gPiBjYW4gdXNlIFNFVF9W
UklOR19CQVNFL0dFVF9WUklOR19CQVNFIGZvciBQQUNLRUQgdmlydHF1ZXVlcyBpbiBhIGdpdmVu
Cj4gPiA+ID4ga2VybmVsIG9yIG5vdC4KPiA+ID4KPiA+ID4gTXkgdW5kZXJzdGFuZGluZyBpcyB0
aGF0IGlmIHBhY2tlZCBpcyBhZHZlcnRpc2VkLCB0aGUgYXBwbGljYXRpb24KPiA+ID4gc2hvdWxk
IGFzc3VtZSBTRVQvR0VUX1ZSSU5HX0JBU0Ugd29yay4KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPgo+
ID4KPiA+IExldCBtZSBhc2sgeW91IHRoaXMuIFRoaXMgaXMgYSBidWdmaXggeWVzPwo+IAo+IE5v
dCBzdXJlIHNpbmNlIGl0IG1heSBicmVhayBleGlzdGluZyB1c2VyIHNwYWNlIGFwcGxpY2F0aW9u
cyB3aGljaAo+IG1ha2UgaXQgaGFyZCB0byBiZSBiYWNrcG9ydGVkIHRvIC1zdGFibGUuCgpTb3Jy
eSwgSSB3YXMgYWN0dWFsbHkgcmVmZXJyaW5nIHRvIAogICAgdmhvc3RfdmRwYTogc3VwcG9ydCBQ
QUNLRUQgd2hlbiBzZXR0aW5nLWdldHRpbmcgdnJpbmdfYmFzZQphbmQgZnJpZW5kcy4KClRoZXNl
IGFyZSBidWdmaXhlcyB5ZXM/ICBXaGF0IGlzIHRoZSBhcHByb3ByaWF0ZSBGaXhlcyB0YWc/CgoK
PiBCZWZvcmUgdGhlIGZpeCwgUEFDS0VEIG1pZ2h0IHdvcmsgaWYgU0VUL0dFVF9WUklOR19CQVNF
IGlzIG5vdCB1c2VkLgo+IEFmdGVyIHRoZSBmaXgsIFBBQ0tFRCB3b24ndCB3b3JrIGF0IGFsbC4K
PiAKPiBUaGFua3MKPiAKPiBXaGF0IGlzIHRoZSBhcHByb3ByaWF0ZSBGaXhlcwo+ID4gdGFnPwo+
ID4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcywKPiA+ID4gPiBTdGVmYW5vCj4gPiA+ID4KPiA+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
