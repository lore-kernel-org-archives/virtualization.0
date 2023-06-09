Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DABC7EE29
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 02:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C729F61144;
	Fri,  9 Jun 2023 02:17:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C729F61144
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IsmGcg6v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fUikDCXyqjRJ; Fri,  9 Jun 2023 02:17:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0B6E0610C5;
	Fri,  9 Jun 2023 02:17:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B6E0610C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD1C6C0037;
	Fri,  9 Jun 2023 02:17:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B50CC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 02:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CC8142405
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 02:17:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CC8142405
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IsmGcg6v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7jGdLhoBf1f6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 02:17:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C524A420F2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C524A420F2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 02:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686277027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgOrLEw+CGqbzexB3hSoqE0ZkI0YLrxw+EejRuKoWQE=;
 b=IsmGcg6vkYv5UL1k0/shSxVwrLmoqd+1MjOE9S5CeR1KcAX7SPN04+xdghMCDRYSeMe9/o
 3QdJILRH2TIl9sdz1QCFR2Yd1ffMUH93r0iJERq06a1SeSoQyJ+06HFLWxjSBv9rM7uaEQ
 RWVKM9PQInydK3SboFSa+zEEc+I23dc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-jiCHGQzUOVCw8wZ1PhEiug-1; Thu, 08 Jun 2023 22:17:06 -0400
X-MC-Unique: jiCHGQzUOVCw8wZ1PhEiug-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b1b44bec2bso8975291fa.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 19:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686277024; x=1688869024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kgOrLEw+CGqbzexB3hSoqE0ZkI0YLrxw+EejRuKoWQE=;
 b=hJgz0qwk+7YT04utUF7qJkOfysWVLVXvBH+H4PHb9gpjpDB5evCxoMqBE9CsKA69bG
 v6VxoYTEbqMkzHX7nRCUNwRP+wh3ZTR5U8p0qbja5JyxUIV0ZEMMYtdvyGAQ8l5ve49t
 /uHyoeV9Up/Bd00PhXSf5oeUbmBEY2Jpw9M41kBThQoROYwPI0TJbBjBGi8YFLy9/YbP
 sNultLUFYovufZkL7v3tgAsxYnjfM6GFTapd4TbxE/yhZpnU+kpS5b2B1Cd4Y3gbKNG2
 abOaBK9iSBkMQ/PORFVj1iewvYwqYzY65excNKg+5RDYAljmKongm6LmlMmVOLG/8wia
 okRA==
X-Gm-Message-State: AC+VfDxupJ+T9YpKrqofqfuDrJi3MEvdyor+HD6GUppBLLv8csaqo3Qt
 ifpL/CUlueGoZrYG1par+RDHBYYkAJT609vQFLQFyUen5gQtTZDcoMxDV0Z7ViGDtRBjqUSLS+e
 4/pUciQZVcsKRvHpyIwQmU0l+wf+y7RVB973Dlz3enMwTYARSn9EBs8KIxQ==
X-Received: by 2002:a2e:b163:0:b0:2b0:a4b1:df6 with SMTP id
 a3-20020a2eb163000000b002b0a4b10df6mr123933ljm.49.1686277024722; 
 Thu, 08 Jun 2023 19:17:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/8wdm9HnZ2Nlq0u+xmMq+q13VRX7hsdmKW7Maw8V8eVTx/FWCzW2thzAyQ/MvYC6Xa3LumlbBLVc0Z0sDrGE=
X-Received: by 2002:a2e:b163:0:b0:2b0:a4b1:df6 with SMTP id
 a3-20020a2eb163000000b002b0a4b10df6mr123915ljm.49.1686277023521; Thu, 08 Jun
 2023 19:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
 <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
 <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
 <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
 <lw3nmkdszqo6jjtneyp4kjlmutooozz7xj2fqyxgh4v2ralptc@vkimgnbfafvi>
 <CACGkMEt1yRV9qOLBqtQQmJA_UoRLCpznT=Gvd5D51Uaz2jakHA@mail.gmail.com>
 <20230608102259-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608102259-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jun 2023 10:16:50 +0800
Message-ID: <CACGkMEvirfb8g0ev=b0CjpL5_SPJabqiQKxdwuRNqG2E=N7iGA@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
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

T24gVGh1LCBKdW4gOCwgMjAyMyBhdCAxMDoyM+KAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBKdW4gMDgsIDIwMjMgYXQgMDU6Mjk6NThQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIFRodSwgSnVuIDgsIDIwMjMgYXQgNToy
MeKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
PiA+Cj4gPiA+IE9uIFRodSwgSnVuIDA4LCAyMDIzIGF0IDA1OjAwOjAwUE0gKzA4MDAsIEphc29u
IFdhbmcgd3JvdGU6Cj4gPiA+ID5PbiBUaHUsIEp1biA4LCAyMDIzIGF0IDQ6MDDigK9QTSBTdGVm
YW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Pgo+ID4g
PiA+PiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAwMzo0NjowMFBNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiA+Pgo+ID4gPiA+PiBbLi4uXQo+ID4gPiA+Pgo+ID4gPiA+PiA+PiA+ID4g
PiA+IEkgaGF2ZSBhIHF1ZXN0aW9uIHRob3VnaCwgd2hhdCBpZiBkb3duIHRoZSByb2FkIHRoZXJl
Cj4gPiA+ID4+ID4+ID4gPiA+ID4gaXMgYSBuZXcgZmVhdHVyZSB0aGF0IG5lZWRzIG1vcmUgY2hh
bmdlcz8gSXQgd2lsbCBiZQo+ID4gPiA+PiA+PiA+ID4gPiA+IGJyb2tlbiB0b28ganVzdCBsaWtl
IFBBQ0tFRCBubz8KPiA+ID4gPj4gPj4gPiA+ID4gPiBTaG91bGRuJ3QgdmRwYSBoYXZlIGFuIGFs
bG93bGlzdCBvZiBmZWF0dXJlcyBpdCBrbm93cyBob3cKPiA+ID4gPj4gPj4gPiA+ID4gPiB0byBz
dXBwb3J0Pwo+ID4gPiA+PiA+PiA+ID4gPgo+ID4gPiA+PiA+PiA+ID4gPiBJdCBsb29rcyBsaWtl
IHdlIGhhZCBpdCwgYnV0IHdlIHRvb2sgaXQgb3V0IChieSB0aGUgd2F5LCB3ZSB3ZXJlCj4gPiA+
ID4+ID4+ID4gPiA+IGVuYWJsaW5nIHBhY2tlZCBldmVuIHRob3VnaCB3ZSBkaWRuJ3Qgc3VwcG9y
dCBpdCk6Cj4gPiA+ID4+ID4+ID4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTYyMzRmODA1NzRk
NzU2OTQ0NGQ4NzE4MzU1ZmEyODM4ZTkyYjE1OGIKPiA+ID4gPj4gPj4gPiA+ID4KPiA+ID4gPj4g
Pj4gPiA+ID4gVGhlIG9ubHkgcHJvYmxlbSBJIHNlZSBpcyB0aGF0IGZvciBlYWNoIG5ldyBmZWF0
dXJlIHdlIGhhdmUgdG8gbW9kaWZ5Cj4gPiA+ID4+ID4+ID4gPiA+IHRoZSBrZXJuZWwuCj4gPiA+
ID4+ID4+ID4gPiA+IENvdWxkIHdlIGhhdmUgbmV3IGZlYXR1cmVzIHRoYXQgZG9uJ3QgcmVxdWly
ZSBoYW5kbGluZyBieSB2aG9zdC12ZHBhPwo+ID4gPiA+PiA+PiA+ID4gPgo+ID4gPiA+PiA+PiA+
ID4gPiBUaGFua3MsCj4gPiA+ID4+ID4+ID4gPiA+IFN0ZWZhbm8KPiA+ID4gPj4gPj4gPiA+Cj4g
PiA+ID4+ID4+ID4gPiBKYXNvbiB3aGF0IGRvIHlvdSBzYXkgdG8gcmV2ZXJ0aW5nIHRoaXM/Cj4g
PiA+ID4+ID4+ID4KPiA+ID4gPj4gPj4gPiBJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgSSBkb24n
dCBzZWUgYW55IHByb2JsZW0gd2l0aCB2RFBBIGNvcmUuCj4gPiA+ID4+ID4+ID4KPiA+ID4gPj4g
Pj4gPiBJdCdzIHRoZSBkdXR5IG9mIHRoZSBwYXJlbnRzIHRvIGFkdmVydGlzZSB0aGUgZmVhdHVy
ZXMgaXQgaGFzLiBGb3IgZXhhbXBsZSwKPiA+ID4gPj4gPj4gPgo+ID4gPiA+PiA+PiA+IDEpIElm
IHNvbWUga2VybmVsIHZlcnNpb24gdGhhdCBpcyBwYWNrZWQgaXMgbm90IHN1cHBvcnRlZCB2aWEK
PiA+ID4gPj4gPj4gPiBzZXRfdnFfc3RhdGUsIHBhcmVudHMgc2hvdWxkIG5vdCBhZHZlcnRpc2Ug
UEFDS0VEIGZlYXR1cmVzIGluIHRoaXMKPiA+ID4gPj4gPj4gPiBjYXNlLgo+ID4gPiA+PiA+PiA+
IDIpIElmIHRoZSBrZXJuZWwgaGFzIHN1cHBvcnQgcGFja2VkIHNldF92cV9zdGF0ZSgpLCBidXQg
aXQncyBlbXVsYXRlZAo+ID4gPiA+PiA+PiA+IGN2cSBkb2Vzbid0IHN1cHBvcnQsIHBhcmVudHMg
c2hvdWxkIG5vdCBhZHZlcnRpc2UgUEFDS0VEIGFzIHdlbGwKPiA+ID4gPj4gPj4gPgo+ID4gPiA+
PiA+PiA+IElmIGEgcGFyZW50IHZpb2xhdGVzIHRoZSBhYm92ZSAyLCBpdCBsb29rcyBsaWtlIGEg
YnVnIG9mIHRoZSBwYXJlbnRzLgo+ID4gPiA+PiA+PiA+Cj4gPiA+ID4+ID4+ID4gVGhhbmtzCj4g
PiA+ID4+ID4+Cj4gPiA+ID4+ID4+IFllcyBidXQgd2hhdCBhYm91dCB2aG9zdF92ZHBhPyBUYWxr
aW5nIGFib3V0IHRoYXQgbm90IHRoZSBjb3JlLgo+ID4gPiA+PiA+Cj4gPiA+ID4+ID5Ob3Qgc3Vy
ZSBpdCdzIGEgZ29vZCBpZGVhIHRvIHdvcmthcm91bmQgcGFyZW50IGJ1Z3MgdmlhIHZob3N0LXZE
UEEuCj4gPiA+ID4+Cj4gPiA+ID4+IFNvcnJ5LCBJJ20gZ2V0dGluZyBsb3N0Li4uCj4gPiA+ID4+
IFdlIHdlcmUgdGFsa2luZyBhYm91dCB0aGUgZmFjdCB0aGF0IHZob3N0LXZkcGEgZG9lc24ndCBo
YW5kbGUKPiA+ID4gPj4gU0VUX1ZSSU5HX0JBU0UvR0VUX1ZSSU5HX0JBU0UgaW9jdGxzIHdlbGwg
Zm9yIHBhY2tlZCB2aXJ0cXVldWUgYmVmb3JlCj4gPiA+ID4+IHRoYXQgc2VyaWVzIFsxXSwgbm8/
Cj4gPiA+ID4+Cj4gPiA+ID4+IFRoZSBwYXJlbnRzIHNlZW0gb2theSwgYnV0IG1heWJlIEkgbWlz
c2VkIGEgZmV3IHRoaW5ncy4KPiA+ID4gPj4KPiA+ID4gPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3ZpcnR1YWxpemF0aW9uLzIwMjMwNDI0MjI1MDMxLjE4OTQ3LTEtc2hhbm5vbi5uZWxz
b25AYW1kLmNvbS8KPiA+ID4gPgo+ID4gPiA+WWVzLCBtb3JlIGJlbG93Lgo+ID4gPiA+Cj4gPiA+
ID4+Cj4gPiA+ID4+ID4KPiA+ID4gPj4gPj4gU2hvdWxkIHRoYXQgbm90IGhhdmUgYSB3aGl0ZWxp
c3Qgb2YgZmVhdHVyZXMKPiA+ID4gPj4gPj4gc2luY2UgaXQgaW50ZXJwcmV0cyBpb2N0bHMgZGlm
ZmVyZW50bHkgZGVwZW5kaW5nIG9uIHRoaXM/Cj4gPiA+ID4+ID4KPiA+ID4gPj4gPklmIHRoZXJl
J3MgYSBidWcsIGl0IG1pZ2h0IG9ubHkgbWF0dGVyIHRoZSBmb2xsb3dpbmcgc2V0dXA6Cj4gPiA+
ID4+ID4KPiA+ID4gPj4gPlNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFICsgVkRVU0UuCj4g
PiA+ID4+ID4KPiA+ID4gPj4gPlRoaXMgc2VlbXMgdG8gYmUgYnJva2VuIHNpbmNlIFZEVVNFIHdh
cyBpbnRyb2R1Y2VkLiBJZiB3ZSByZWFsbHkgd2FudAo+ID4gPiA+PiA+dG8gYmFja3BvcnQgc29t
ZXRoaW5nLCBpdCBjb3VsZCBiZSBhIGZpeCB0byBmaWx0ZXIgb3V0IFBBQ0tFRCBpbgo+ID4gPiA+
PiA+VkRVU0U/Cj4gPiA+ID4+Cj4gPiA+ID4+IG1tbSBpdCBkb2Vzbid0IHNlZW0gdG8gYmUgYSBw
cm9ibGVtIGluIFZEVVNFLCBidXQgaW4gdmhvc3QtdmRwYS4KPiA+ID4gPj4gSSB0aGluayBWRFVT
RSB3b3JrcyBmaW5lIHdpdGggcGFja2VkIHZpcnRxdWV1ZSB1c2luZyB2aXJ0aW8tdmRwYQo+ID4g
PiA+PiAoSSBoYXZlbid0IHRyaWVkKSwgc28gd2h5IHNob3VsZCB3ZSBmaWx0ZXIgUEFDS0VEIGlu
IFZEVVNFPwo+ID4gPiA+Cj4gPiA+ID5JIGRvbid0IHRoaW5rIHdlIG5lZWQgYW55IGZpbHRlcmlu
ZyBzaW5jZToKPiA+ID4gPgo+ID4gPiA+UEFDS0VEIGZlYXR1cmVzIGhhcyBiZWVuIGFkdmVydGlz
ZWQgdG8gdXNlcnNwYWNlIHZpYSB1QVBJIHNpbmNlCj4gPiA+ID42MjM0ZjgwNTc0ZDc1Njk0NDRk
ODcxODM1NWZhMjgzOGU5MmIxNThiLiBPbmNlIHdlIHJlbGF4IGluIHVBUEksIGl0Cj4gPiA+ID53
b3VsZCBiZSB2ZXJ5IGhhcmQgdG8gcmVzdHJpY3QgaXQgYWdhaW4uIEZvciB0aGUgdXNlcnNwYWNl
IHRoYXQgdHJpZXMKPiA+ID4gPnRvIG5lZ290aWF0ZSBQQUNLRUQ6Cj4gPiA+ID4KPiA+ID4gPjEp
IGlmIGl0IGRvZXNuJ3QgdXNlIFNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFLCBldmVyeXRo
aW5nIHdvcmtzIHdlbGwKPiA+ID4gPjIpIGlmIGl0IHVzZXMgU0VUX1ZSSU5HX0JBU0UvR0VUX1ZS
SU5HX0JBU0UuIGl0IG1pZ2h0IGZhaWwgb3IgYnJlYWsgc2lsZW50bHkKPiA+ID4gPgo+ID4gPiA+
SWYgd2UgYmFja3BvcnQgdGhlIGZpeGVzIHRvIC1zdGFibGUsIHdlIG1heSBicmVhayB0aGUgYXBw
bGljYXRpb24gYXQKPiA+ID4gPmxlYXN0IGluIHRoZSBjYXNlIDEpLgo+ID4gPgo+ID4gPiBPa2F5
LCBJIHNlZSBub3csIHRoYW5rcyBmb3IgdGhlIGRldGFpbHMhCj4gPiA+Cj4gPiA+IE1heWJlIGlu
c3RlYWQgb2YgImJyZWFrIHNpbGVudGx5Iiwgd2UgY2FuIHJldHVybiBhbiBleHBsaWNpdCBlcnJv
ciBmb3IKPiA+ID4gU0VUX1ZSSU5HX0JBU0UvR0VUX1ZSSU5HX0JBU0UgaW4gc3RhYmxlIGJyYW5j
aGVzLgo+ID4gPiBCdXQgaWYgdGhlcmUgYXJlIG5vdCBtYW55IGNhc2VzLCB3ZSBjYW4gbGVhdmUg
aXQgbGlrZSB0aGF0Lgo+ID4KPiA+IEEgc2Vjb25kIHRob3VnaHQsIGlmIHdlIG5lZWQgdG8gZG8g
c29tZXRoaW5nIGZvciBzdGFibGUuIGlzIGl0IGJldHRlcgo+ID4gaWYgd2UganVzdCBiYWNrcG9y
dCBTaGFubm9uJ3Mgc2VyaWVzIHRvIHN0YWJsZT8KPiA+Cj4gPiA+Cj4gPiA+IEkgd2FzIGp1c3Qg
Y29uY2VybmVkIGFib3V0IGhvdyBkb2VzIHRoZSB1c2VyIHNwYWNlIHVuZGVyc3RhbmQgdGhhdCBp
dAo+ID4gPiBjYW4gdXNlIFNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFIGZvciBQQUNLRUQg
dmlydHF1ZXVlcyBpbiBhIGdpdmVuCj4gPiA+IGtlcm5lbCBvciBub3QuCj4gPgo+ID4gTXkgdW5k
ZXJzdGFuZGluZyBpcyB0aGF0IGlmIHBhY2tlZCBpcyBhZHZlcnRpc2VkLCB0aGUgYXBwbGljYXRp
b24KPiA+IHNob3VsZCBhc3N1bWUgU0VUL0dFVF9WUklOR19CQVNFIHdvcmsuCj4gPgo+ID4gVGhh
bmtzCj4KPgo+IExldCBtZSBhc2sgeW91IHRoaXMuIFRoaXMgaXMgYSBidWdmaXggeWVzPwoKTm90
IHN1cmUgc2luY2UgaXQgbWF5IGJyZWFrIGV4aXN0aW5nIHVzZXIgc3BhY2UgYXBwbGljYXRpb25z
IHdoaWNoCm1ha2UgaXQgaGFyZCB0byBiZSBiYWNrcG9ydGVkIHRvIC1zdGFibGUuCgpCZWZvcmUg
dGhlIGZpeCwgUEFDS0VEIG1pZ2h0IHdvcmsgaWYgU0VUL0dFVF9WUklOR19CQVNFIGlzIG5vdCB1
c2VkLgpBZnRlciB0aGUgZml4LCBQQUNLRUQgd29uJ3Qgd29yayBhdCBhbGwuCgpUaGFua3MKCldo
YXQgaXMgdGhlIGFwcHJvcHJpYXRlIEZpeGVzCj4gdGFnPwo+Cj4gPiA+Cj4gPiA+IFRoYW5rcywK
PiA+ID4gU3RlZmFubwo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
