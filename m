Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B35C77B6E
	for <virtualization@archiver.kernel.org>; Wed, 12 Apr 2023 06:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C7B9240022;
	Wed, 12 Apr 2023 06:37:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7B9240022
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EOdg3LC4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qA0faPZyU-wO; Wed, 12 Apr 2023 06:37:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 47494403B8;
	Wed, 12 Apr 2023 06:37:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47494403B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCBB7C0037;
	Wed, 12 Apr 2023 06:37:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABCB2C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 06:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A3B660E11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 06:37:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A3B660E11
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EOdg3LC4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id asfDniuDmZap
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 06:37:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C2E560A87
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C2E560A87
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 06:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681281448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwCbzAAjwbVI6L1+WlkLHSTqF7zMVDO5V+z4G1Cyt20=;
 b=EOdg3LC4yG3EwL3GNcd+kmZ7+neQ0Gzpx8eZmw/eX6uqwWptU+v9OYojOadME2BDypbEvk
 C55uZIz8j9OiggKweYPRkho/LdjNRI5b9XnCEvbG55ihps07NT4rcF8SSzSNHTGqyxMfb7
 PjEf40LnWxON1m+pmxnjh763Nl4CoFY=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-iy8OXEFmNa2vK8YmKxhSWA-1; Wed, 12 Apr 2023 02:37:26 -0400
X-MC-Unique: iy8OXEFmNa2vK8YmKxhSWA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-180baff12ccso13322352fac.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 23:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681281446; x=1683873446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VwCbzAAjwbVI6L1+WlkLHSTqF7zMVDO5V+z4G1Cyt20=;
 b=m+IW1YPTe4rHCPAPaOM/439PFcG2TQ1xZeO9nFjAVIu8i1iwDhJ+b2qi911IE7uYKr
 SEoIeFz+S7eN8GgGJwQ89u0rH2w2PBnALHJYDeSzEArW+fHbTT+XVqQhiRVB7HHfP3oR
 +93WXa7Lge4NSt1ooMLpxaRPOQU+bzhp0B+c5N/jXpzBzlCRg7C2gKSkcf4uUaJrlt7n
 dfcDh8EiEMnub7DEclqYCF8OMrzwFuKVb3y9TQb78YRWKoevKleUm8MFVAIQtwaGdLYp
 rfuNKsT4SnHWHiB33nZJ9FT6GVLA8HnQI5lBEPg3Ljq4pMZOkDr9MQa2vgr/7uoyfNUW
 RDHQ==
X-Gm-Message-State: AAQBX9eFw2Kb8abVsEW2dLjrduMSf/Uc0RYz+tUiUyHJYAFIuNusTavC
 hE9OfGV73DA2+eMj8Zs0/mpUGCl9lyqmzzCsOa6t2oUy9nvWOoSM+rRwcSs3X9VR1na4aXXjTDw
 AQ/37QNedLChDyh8N9ed/GipZ4C0bSWxHo01WDTePLt79JE1QgXQGiDcFxg==
X-Received: by 2002:a05:6870:96a3:b0:184:4c39:fe30 with SMTP id
 o35-20020a05687096a300b001844c39fe30mr4140725oaq.9.1681281446156; 
 Tue, 11 Apr 2023 23:37:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZPI/ee2C3stnJNNuh0m3DxO1fUoT+0+j0FBOVNZyRv0Dqeao5UDr6cePplhgphOC+r4L2fQnDCBJAhIEVRckY=
X-Received: by 2002:a05:6870:96a3:b0:184:4c39:fe30 with SMTP id
 o35-20020a05687096a300b001844c39fe30mr4140719oaq.9.1681281445936; Tue, 11 Apr
 2023 23:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230410150130.837691-1-lulu@redhat.com>
 <CACGkMEvTdgvqacFmMJZD4u++YJwESgSmLF6CMdAJBBqkxpZKgg@mail.gmail.com>
 <CACLfguWKw68=wZNa7Ga+Jm8xTE93A_5za3Dc=S_z7ds9FCkRKg@mail.gmail.com>
 <CACGkMEv3aca0Thx+X3WZxbV2HK7514G3RzR+A0PqRu7k6Deztg@mail.gmail.com>
 <CACLfguXBeodQ=b-RAQ4JsaSnjS_ZNutr2nbunmdv1S8Gxz8gfg@mail.gmail.com>
In-Reply-To: <CACLfguXBeodQ=b-RAQ4JsaSnjS_ZNutr2nbunmdv1S8Gxz8gfg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Apr 2023 14:37:14 +0800
Message-ID: <CACGkMEtwx7jMc2j=rhe8S1+uYVfs7UX9TCwRZsnW9tWR29uo5w@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: fix unmap process in no-batch mode
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
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

T24gV2VkLCBBcHIgMTIsIDIwMjMgYXQgMjozMuKAr1BNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgNToxNOKAr1BNIEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwgQXByIDExLCAy
MDIzIGF0IDM6MjnigK9QTSBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMTE6MTDigK9BTSBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIE1vbiwgQXByIDEwLCAy
MDIzIGF0IDExOjAx4oCvUE0gQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
ID4gPgo+ID4gPiA+ID4gV2hpbGUgdXNpbmcgdGhlIG5vLWJhdGNoIG1vZGUsIHRoZSBwcm9jZXNz
IHdpbGwgbm90IGJlZ2luIHdpdGgKPiA+ID4gPiA+IFZIT1NUX0lPVExCX0JBVENIX0JFR0lOLCBz
byB3ZSBuZWVkIHRvIGFkZCB0aGUKPiA+ID4gPiA+IFZIT1NUX0lPVExCX0lOVkFMSURBVEUgdG8g
Z2V0IHZob3N0X3ZkcGFfYXMsIHRoZSBwcm9jZXNzIGlzIHRoZQo+ID4gPiA+ID4gc2FtZSBhcyBW
SE9TVF9JT1RMQl9VUERBVEUKPiA+ID4gPiA+Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaW5k
eSBMdSA8bHVsdUByZWRoYXQuY29tPgo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiAgZHJpdmVycy92
aG9zdC92ZHBhLmMgfCAxICsKPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykKPiA+ID4gPiA+Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMg
Yi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+ID4gaW5kZXggN2JlOWQ5ZDhmMDFjLi4zMjYz
NmEwMmEwYWIgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4g
PiA+ID4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gPiA+IEBAIC0xMDc0LDYgKzEw
NzQsNyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl9tc2coc3RydWN0IHZo
b3N0X2RldiAqZGV2LCB1MzIgYXNpZCwKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBnb3RvIHVu
bG9jazsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgIGlmIChtc2ctPnR5cGUgPT0gVkhPU1Rf
SU9UTEJfVVBEQVRFIHx8Cj4gPiA+ID4gPiArICAgICAgICAgICBtc2ctPnR5cGUgPT0gVkhPU1Rf
SU9UTEJfSU5WQUxJREFURSB8fAo+ID4gPiA+Cj4gPiA+ID4gSSdtIG5vdCBzdXJlIEkgZ2V0IGhl
cmUsIGludmFsaWRhdGlvbiBkb2Vzbid0IG5lZWQgdG8gY3JlYXRlIGEgbmV3IEFTLgo+ID4gPiA+
Cj4gPiA+ID4gT3IgbWF5YmUgeW91IGNhbiBwb3N0IHRoZSB1c2Vyc3BhY2UgY29kZSB0aGF0IGNh
biB0cmlnZ2VyIHRoaXMgaXNzdWU/Cj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4g
PiBzb3JyeSBJIGRpZG4ndCB3cml0ZSBpdCBjbGVhcmx5Cj4gPiA+IEZvciB0aGlzIGlzc3VlIGNh
biByZXByb2R1Y2UgaW4gdklPTU1VIG5vLWJhdGNoIG1vZGUgc3VwcG9ydCBiZWNhdXNlCj4gPiA+
IHdoaWxlIHRoZSB2SU9NTVUgZW5hYmxlZCwgaXQgd2lsbAo+ID4gPiBmbGFzaCBhIGxhcmdlIG1l
bW9yeSB0byB1bm1hcCwgYW5kIHRoaXMgbWVtb3J5IGFyZSBoYXZlbid0IGJlZW4gbWFwcGVkCj4g
PiA+IGJlZm9yZSwgc28gdGhpcyB1bm1hcHBpbmcgd2lsbCBmYWlsCj4gPiA+Cj4gPiA+IHFlbXUt
c3lzdGVtLXg4Nl82NDogZmFpbGVkIHRvIHdyaXRlLCBmZD0xMiwgZXJybm89MTQgKEJhZCBhZGRy
ZXNzKQo+ID4gPiBxZW11LXN5c3RlbS14ODZfNjQ6IHZob3N0X3ZkcGFfZG1hX3VubWFwKDB4N2Zh
MjZkMWRkMTkwLCAweDAsCj4gPiA+IDB4ODAwMDAwMDApID0gLTUgKEJhZCBhZGRyZXNzKQo+ID4K
PiA+IFNvIGlmIHRoaXMgaXMgYSBzaW1wbGUgdW5tYXAsIHdoaWNoIGVycm9yIGNvbmRpdGlvbiBo
YWQgeW91IG1ldCBpbgo+ID4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX21zZygpPwo+ID4KPiA+
IEkgdGhpbmsgeW91IG5lZWQgdG8gdHJhY2UgdG8gc2VlIHdoYXQgaGFwcGVucy4gRm9yIGV4YW1w
bGU6Cj4gPgo+IHRoaXMgaGFwcGVucyB3aGVuIHZJT01NVSBlbmFibGUgYW5kIHZkcGEgYmluZHMg
dG8gdmZpby1wY2kgcnVuIHRlc3RwbWQKPiB0aGUgcWVtdSB3aWxsIHVubWFwcGVkIHdob2xlIG1l
bW9yeSB0aGF0IHdhcyB1c2VkIGFuZCB0aGVuIG1hcHBlZCB0aGUKPiBpb21tdSBNUiBzZWN0aW9u
CgpTbyBpdCdzIGEgbWFwIGFmdGVyIGFuIHVubWFwLCBub3QgYW4gaW52YWxpZGF0aW9uPwoKPiBU
aGlzIG1lbW9yeSBtdWNoIGxhcmdlciB0aGFuIHRoZSBtZW1vcnkgbWFwcGVkIHRvIHZkcGEodGhp
cyBpcyB3aGF0Cj4gYWN0dWFsbHkgbWFwcGVkIHRvCj4gdmRwYSBkZXZpY2UgaW4gbm8taW9tbXUg
TVIpCj4KPiA+IDEpIGNhbiB0aGUgY29kZSBwYXNzIGFzaWRfdG9faW90bGIoKQo+ID4gMikgaWYg
bm90LCBBU0lEIDAgaGFzIGJlZW4gZGVsZXRlZCBzaW5jZSBhbGwgdGhlIG1hcHBpbmdzIGhhdmUg
YmVlbiB1bm1hcHBlZAo+ID4KPiA+IGlmIEFTSUQgMCBoYXMgYmVlbiBjb21wbGV0ZWx5IHVubWFw
LCBhbnkgcmVhc29uIHdlIG5lZWQgdG8gdW5tYXAgaXQKPiA+IGFnYWluPyBBbmQgZG8gd2UgbmVl
ZCB0byBkcm9wIHRoZSB2aG9zdF92ZHBhX3JlbW92ZV9hcygpIGZyb20gYm90aAo+ID4KPgo+ID4g
MSkgdmhvc3RfdmRwYV91bm1hcCgpCj4gPiBhbmQKPiA+IDIpIHZob3N0X3ZkcGFfcHJvY2Vzc19p
b3RsYl9tc2coKQo+ID4gPwo+ID4KPiA+IFRoYW5rcwo+ID4KPiB0aGUgY29kZSBwYXNzZWQgdGhl
IGFzaWRfdG9faW90bGIoKSwgVGhlIGlvdGxiIGlzIE5VTEwgYXQgdGhpcyBzaXR1YXRpb24KPiBh
bmQgdGhlIHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl9tc2cgd2lsbCByZXR1cm4gZmFpbC4gdGhp
cyB3aWxsIGNhdXNlCj4gdGhlIG1hcHBpbmcKPiAgaW4gcWVtdSBmYWlsCgpZZXMsIHNvIHdoYXQg
SSBtZWFudDoKCkluc3RlYWQgb2YgZnJlZSB0aGUgQVMgaW4gdmhvc3RfdmRwYV91bm1hcCgpIG9y
CnZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl9tc2coKSBhbmQgYWxsb2NhdGUgaXQgYWdhaW4gaGVy
ZS4KCklzIGl0IGJldHRlciB0byBub3QgcmVtb3ZlIHRoZSBBUyBpbiB0aG9zZSB0d28gZnVuY3Rp
b25zIGV2ZW4gaWYKdGhlcmUncyBubyBtYXBzPwoKVGhhbmtzCgo+Cj4gdGhhbmtzCj4gY2luZHkK
Pgo+ID4gPiBxZW11LXN5c3RlbS14ODZfNjQ6IGZhaWxlZCB0byB3cml0ZSwgZmQ9MTIsIGVycm5v
PTE0IChCYWQgYWRkcmVzcykKPiA+ID4gLi4uLgo+ID4gPiBpbiBiYXRjaCBtb2RlIHRoaXMgb3Bl
cmF0aW9uIHdpbGwgYmVnaW4gd2l0aCBWSE9TVF9JT1RMQl9CQVRDSF9CRUdJTiwKPiA+ID4gc28g
ZG9uJ3QgaGF2ZSB0aGlzIGlzc3VlCj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4gPiBjaW5keQo+ID4g
PiA+ID4gICAgICAgICAgICAgbXNnLT50eXBlID09IFZIT1NUX0lPVExCX0JBVENIX0JFR0lOKSB7
Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgYXMgPSB2aG9zdF92ZHBhX2ZpbmRfYWxsb2NfYXMo
diwgYXNpZCk7Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgaWYgKCFhcykgewo+ID4gPiA+ID4g
LS0KPiA+ID4gPiA+IDIuMzQuMwo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPgo+ID4KPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
