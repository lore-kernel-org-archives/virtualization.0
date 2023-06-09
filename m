Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39863C7EE25
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 07:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA58040189;
	Fri,  9 Jun 2023 07:37:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA58040189
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OnhqCBym
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iprxFqRv976A; Fri,  9 Jun 2023 07:37:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C242402DC;
	Fri,  9 Jun 2023 07:37:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C242402DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5ED7C0037;
	Fri,  9 Jun 2023 07:37:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43747C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 07:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17F0761566
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 07:37:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17F0761566
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OnhqCBym
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pWqcyERVnHli
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 07:37:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D939361564
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D939361564
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 07:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686296238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYfLgsVFNCZ8nRyAtdqv5Pzu6gYjvla7lXAg7Aj2Y+s=;
 b=OnhqCBymOShT6mrRhsbBNdUscX6jlm0WjT882anBdBNRFMjQaG46L+MLd+2hjnfR8yOvq7
 Up+XgvJRuh/zitui8eTOVIlp1PohX7DWtJPv/Y5ZvAIMEAFUrvQmvXFsSVX/hT2BTM8Id9
 l0AKCTmgZTmctbS/zhQAHC3q3fhlMow=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-_eRjnb0MN9aACwOkmvJ9Pw-1; Fri, 09 Jun 2023 03:37:17 -0400
X-MC-Unique: _eRjnb0MN9aACwOkmvJ9Pw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51664cca8dcso1706832a12.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jun 2023 00:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686296236; x=1688888236;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bYfLgsVFNCZ8nRyAtdqv5Pzu6gYjvla7lXAg7Aj2Y+s=;
 b=EFYvdmefoyhIZ7X4jltz7IdiJOxbnko8+YvdC4epFQo5IkJqXWsKaWkchq2vRawzI+
 CYRjoktNYyBgSzEK8FdzfHoOhBuwOAQQCh1HNqg3FzNJ0wTk7Zd8tZBzEEaoSqgaKVAp
 W2PwBm60lJOh57qc3kgVJ0TBvf5rFu3l/Yiyr+FbuPz3RcCVGzt4Cu+z8ll9MAq3x3WN
 kwGz0T5a5uIK/c1gklX351E2RC9jYb4Irc/DAlKVlRPLlMqQjpZnF1wjcorOv7HC+PxQ
 H9GoVKfrIckGPtvsTs7K2AwnKttjKH+QpalX8zhTRs/ix32orpgVPVXiWXrLOWF3Q2zI
 P33Q==
X-Gm-Message-State: AC+VfDyR26/Ee8J/ndJwthmtVrLbqIE+MVv16fAcM34fZnImTl2yMJcv
 o5cUrX0Zst1yHZxAYLRTie8OIlsvmBKi9AgTfP4meHARRb2JmtQGDuVQOB7nAO7X2dBDNMPLyC7
 fqTO/68n7h4uAfG4qdexWjK773rYgUavTC0Os+0Na9w==
X-Received: by 2002:a17:907:7ba9:b0:978:62c1:6b4b with SMTP id
 ne41-20020a1709077ba900b0097862c16b4bmr1270366ejc.61.1686296236528; 
 Fri, 09 Jun 2023 00:37:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78zAqU5nBkhqiiGWgfNgN+8MZicyBWov8iB0bm42uQl0fbHbGsJwIj+9uJE05ls1/Y70zGGw==
X-Received: by 2002:a17:907:7ba9:b0:978:62c1:6b4b with SMTP id
 ne41-20020a1709077ba900b0097862c16b4bmr1270345ejc.61.1686296236130; 
 Fri, 09 Jun 2023 00:37:16 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-111.business.telecomitalia.it.
 [87.12.25.111]) by smtp.gmail.com with ESMTPSA id
 v7-20020a1709063bc700b00965b5540ad7sm967116ejf.17.2023.06.09.00.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 00:37:15 -0700 (PDT)
Date: Fri, 9 Jun 2023 09:37:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <of6exzv2q6eculovjesz3mf4jxjxqfy27gz3jmihsnu6ummdux@k2zdfafgawla>
References: <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
 <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
 <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
 <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
 <lw3nmkdszqo6jjtneyp4kjlmutooozz7xj2fqyxgh4v2ralptc@vkimgnbfafvi>
 <CACGkMEt1yRV9qOLBqtQQmJA_UoRLCpznT=Gvd5D51Uaz2jakHA@mail.gmail.com>
 <20230608102259-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230608102259-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBKdW4gMDgsIDIwMjMgYXQgMTA6MjM6MjFBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+T24gVGh1LCBKdW4gMDgsIDIwMjMgYXQgMDU6Mjk6NThQTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPj4gT24gVGh1LCBKdW4gOCwgMjAyMyBhdCA1OjIx4oCvUE0gU3RlZmFu
byBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToKPj4gPgo+PiA+IE9uIFRo
dSwgSnVuIDA4LCAyMDIzIGF0IDA1OjAwOjAwUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
ID4gPk9uIFRodSwgSnVuIDgsIDIwMjMgYXQgNDowMOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8
c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+ID4gPj4KPj4gPiA+PiBPbiBUaHUsIEp1biAw
OCwgMjAyMyBhdCAwMzo0NjowMFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiA+ID4+Cj4+
ID4gPj4gWy4uLl0KPj4gPiA+Pgo+PiA+ID4+ID4+ID4gPiA+ID4gSSBoYXZlIGEgcXVlc3Rpb24g
dGhvdWdoLCB3aGF0IGlmIGRvd24gdGhlIHJvYWQgdGhlcmUKPj4gPiA+PiA+PiA+ID4gPiA+IGlz
IGEgbmV3IGZlYXR1cmUgdGhhdCBuZWVkcyBtb3JlIGNoYW5nZXM/IEl0IHdpbGwgYmUKPj4gPiA+
PiA+PiA+ID4gPiA+IGJyb2tlbiB0b28ganVzdCBsaWtlIFBBQ0tFRCBubz8KPj4gPiA+PiA+PiA+
ID4gPiA+IFNob3VsZG4ndCB2ZHBhIGhhdmUgYW4gYWxsb3dsaXN0IG9mIGZlYXR1cmVzIGl0IGtu
b3dzIGhvdwo+PiA+ID4+ID4+ID4gPiA+ID4gdG8gc3VwcG9ydD8KPj4gPiA+PiA+PiA+ID4gPgo+
PiA+ID4+ID4+ID4gPiA+IEl0IGxvb2tzIGxpa2Ugd2UgaGFkIGl0LCBidXQgd2UgdG9vayBpdCBv
dXQgKGJ5IHRoZSB3YXksIHdlIHdlcmUKPj4gPiA+PiA+PiA+ID4gPiBlbmFibGluZyBwYWNrZWQg
ZXZlbiB0aG91Z2ggd2UgZGlkbid0IHN1cHBvcnQgaXQpOgo+PiA+ID4+ID4+ID4gPiA+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC9jb21taXQvP2lkPTYyMzRmODA1NzRkNzU2OTQ0NGQ4NzE4MzU1ZmEyODM4ZTkyYjE1OGIK
Pj4gPiA+PiA+PiA+ID4gPgo+PiA+ID4+ID4+ID4gPiA+IFRoZSBvbmx5IHByb2JsZW0gSSBzZWUg
aXMgdGhhdCBmb3IgZWFjaCBuZXcgZmVhdHVyZSB3ZSBoYXZlIHRvIG1vZGlmeQo+PiA+ID4+ID4+
ID4gPiA+IHRoZSBrZXJuZWwuCj4+ID4gPj4gPj4gPiA+ID4gQ291bGQgd2UgaGF2ZSBuZXcgZmVh
dHVyZXMgdGhhdCBkb24ndCByZXF1aXJlIGhhbmRsaW5nIGJ5IHZob3N0LXZkcGE/Cj4+ID4gPj4g
Pj4gPiA+ID4KPj4gPiA+PiA+PiA+ID4gPiBUaGFua3MsCj4+ID4gPj4gPj4gPiA+ID4gU3RlZmFu
bwo+PiA+ID4+ID4+ID4gPgo+PiA+ID4+ID4+ID4gPiBKYXNvbiB3aGF0IGRvIHlvdSBzYXkgdG8g
cmV2ZXJ0aW5nIHRoaXM/Cj4+ID4gPj4gPj4gPgo+PiA+ID4+ID4+ID4gSSBtYXkgbWlzcyBzb21l
dGhpbmcgYnV0IEkgZG9uJ3Qgc2VlIGFueSBwcm9ibGVtIHdpdGggdkRQQSBjb3JlLgo+PiA+ID4+
ID4+ID4KPj4gPiA+PiA+PiA+IEl0J3MgdGhlIGR1dHkgb2YgdGhlIHBhcmVudHMgdG8gYWR2ZXJ0
aXNlIHRoZSBmZWF0dXJlcyBpdCBoYXMuIEZvciBleGFtcGxlLAo+PiA+ID4+ID4+ID4KPj4gPiA+
PiA+PiA+IDEpIElmIHNvbWUga2VybmVsIHZlcnNpb24gdGhhdCBpcyBwYWNrZWQgaXMgbm90IHN1
cHBvcnRlZCB2aWEKPj4gPiA+PiA+PiA+IHNldF92cV9zdGF0ZSwgcGFyZW50cyBzaG91bGQgbm90
IGFkdmVydGlzZSBQQUNLRUQgZmVhdHVyZXMgaW4gdGhpcwo+PiA+ID4+ID4+ID4gY2FzZS4KPj4g
PiA+PiA+PiA+IDIpIElmIHRoZSBrZXJuZWwgaGFzIHN1cHBvcnQgcGFja2VkIHNldF92cV9zdGF0
ZSgpLCBidXQgaXQncyBlbXVsYXRlZAo+PiA+ID4+ID4+ID4gY3ZxIGRvZXNuJ3Qgc3VwcG9ydCwg
cGFyZW50cyBzaG91bGQgbm90IGFkdmVydGlzZSBQQUNLRUQgYXMgd2VsbAo+PiA+ID4+ID4+ID4K
Pj4gPiA+PiA+PiA+IElmIGEgcGFyZW50IHZpb2xhdGVzIHRoZSBhYm92ZSAyLCBpdCBsb29rcyBs
aWtlIGEgYnVnIG9mIHRoZSBwYXJlbnRzLgo+PiA+ID4+ID4+ID4KPj4gPiA+PiA+PiA+IFRoYW5r
cwo+PiA+ID4+ID4+Cj4+ID4gPj4gPj4gWWVzIGJ1dCB3aGF0IGFib3V0IHZob3N0X3ZkcGE/IFRh
bGtpbmcgYWJvdXQgdGhhdCBub3QgdGhlIGNvcmUuCj4+ID4gPj4gPgo+PiA+ID4+ID5Ob3Qgc3Vy
ZSBpdCdzIGEgZ29vZCBpZGVhIHRvIHdvcmthcm91bmQgcGFyZW50IGJ1Z3MgdmlhIHZob3N0LXZE
UEEuCj4+ID4gPj4KPj4gPiA+PiBTb3JyeSwgSSdtIGdldHRpbmcgbG9zdC4uLgo+PiA+ID4+IFdl
IHdlcmUgdGFsa2luZyBhYm91dCB0aGUgZmFjdCB0aGF0IHZob3N0LXZkcGEgZG9lc24ndCBoYW5k
bGUKPj4gPiA+PiBTRVRfVlJJTkdfQkFTRS9HRVRfVlJJTkdfQkFTRSBpb2N0bHMgd2VsbCBmb3Ig
cGFja2VkIHZpcnRxdWV1ZSBiZWZvcmUKPj4gPiA+PiB0aGF0IHNlcmllcyBbMV0sIG5vPwo+PiA+
ID4+Cj4+ID4gPj4gVGhlIHBhcmVudHMgc2VlbSBva2F5LCBidXQgbWF5YmUgSSBtaXNzZWQgYSBm
ZXcgdGhpbmdzLgo+PiA+ID4+Cj4+ID4gPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Zp
cnR1YWxpemF0aW9uLzIwMjMwNDI0MjI1MDMxLjE4OTQ3LTEtc2hhbm5vbi5uZWxzb25AYW1kLmNv
bS8KPj4gPiA+Cj4+ID4gPlllcywgbW9yZSBiZWxvdy4KPj4gPiA+Cj4+ID4gPj4KPj4gPiA+PiA+
Cj4+ID4gPj4gPj4gU2hvdWxkIHRoYXQgbm90IGhhdmUgYSB3aGl0ZWxpc3Qgb2YgZmVhdHVyZXMK
Pj4gPiA+PiA+PiBzaW5jZSBpdCBpbnRlcnByZXRzIGlvY3RscyBkaWZmZXJlbnRseSBkZXBlbmRp
bmcgb24gdGhpcz8KPj4gPiA+PiA+Cj4+ID4gPj4gPklmIHRoZXJlJ3MgYSBidWcsIGl0IG1pZ2h0
IG9ubHkgbWF0dGVyIHRoZSBmb2xsb3dpbmcgc2V0dXA6Cj4+ID4gPj4gPgo+PiA+ID4+ID5TRVRf
VlJJTkdfQkFTRS9HRVRfVlJJTkdfQkFTRSArIFZEVVNFLgo+PiA+ID4+ID4KPj4gPiA+PiA+VGhp
cyBzZWVtcyB0byBiZSBicm9rZW4gc2luY2UgVkRVU0Ugd2FzIGludHJvZHVjZWQuIElmIHdlIHJl
YWxseSB3YW50Cj4+ID4gPj4gPnRvIGJhY2twb3J0IHNvbWV0aGluZywgaXQgY291bGQgYmUgYSBm
aXggdG8gZmlsdGVyIG91dCBQQUNLRUQgaW4KPj4gPiA+PiA+VkRVU0U/Cj4+ID4gPj4KPj4gPiA+
PiBtbW0gaXQgZG9lc24ndCBzZWVtIHRvIGJlIGEgcHJvYmxlbSBpbiBWRFVTRSwgYnV0IGluIHZo
b3N0LXZkcGEuCj4+ID4gPj4gSSB0aGluayBWRFVTRSB3b3JrcyBmaW5lIHdpdGggcGFja2VkIHZp
cnRxdWV1ZSB1c2luZyB2aXJ0aW8tdmRwYQo+PiA+ID4+IChJIGhhdmVuJ3QgdHJpZWQpLCBzbyB3
aHkgc2hvdWxkIHdlIGZpbHRlciBQQUNLRUQgaW4gVkRVU0U/Cj4+ID4gPgo+PiA+ID5JIGRvbid0
IHRoaW5rIHdlIG5lZWQgYW55IGZpbHRlcmluZyBzaW5jZToKPj4gPiA+Cj4+ID4gPlBBQ0tFRCBm
ZWF0dXJlcyBoYXMgYmVlbiBhZHZlcnRpc2VkIHRvIHVzZXJzcGFjZSB2aWEgdUFQSSBzaW5jZQo+
PiA+ID42MjM0ZjgwNTc0ZDc1Njk0NDRkODcxODM1NWZhMjgzOGU5MmIxNThiLiBPbmNlIHdlIHJl
bGF4IGluIHVBUEksIGl0Cj4+ID4gPndvdWxkIGJlIHZlcnkgaGFyZCB0byByZXN0cmljdCBpdCBh
Z2Fpbi4gRm9yIHRoZSB1c2Vyc3BhY2UgdGhhdCB0cmllcwo+PiA+ID50byBuZWdvdGlhdGUgUEFD
S0VEOgo+PiA+ID4KPj4gPiA+MSkgaWYgaXQgZG9lc24ndCB1c2UgU0VUX1ZSSU5HX0JBU0UvR0VU
X1ZSSU5HX0JBU0UsIGV2ZXJ5dGhpbmcgd29ya3Mgd2VsbAo+PiA+ID4yKSBpZiBpdCB1c2VzIFNF
VF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFLiBpdCBtaWdodCBmYWlsIG9yIGJyZWFrIHNpbGVu
dGx5Cj4+ID4gPgo+PiA+ID5JZiB3ZSBiYWNrcG9ydCB0aGUgZml4ZXMgdG8gLXN0YWJsZSwgd2Ug
bWF5IGJyZWFrIHRoZSBhcHBsaWNhdGlvbiBhdAo+PiA+ID5sZWFzdCBpbiB0aGUgY2FzZSAxKS4K
Pj4gPgo+PiA+IE9rYXksIEkgc2VlIG5vdywgdGhhbmtzIGZvciB0aGUgZGV0YWlscyEKPj4gPgo+
PiA+IE1heWJlIGluc3RlYWQgb2YgImJyZWFrIHNpbGVudGx5Iiwgd2UgY2FuIHJldHVybiBhbiBl
eHBsaWNpdCBlcnJvciBmb3IKPj4gPiBTRVRfVlJJTkdfQkFTRS9HRVRfVlJJTkdfQkFTRSBpbiBz
dGFibGUgYnJhbmNoZXMuCj4+ID4gQnV0IGlmIHRoZXJlIGFyZSBub3QgbWFueSBjYXNlcywgd2Ug
Y2FuIGxlYXZlIGl0IGxpa2UgdGhhdC4KPj4KPj4gQSBzZWNvbmQgdGhvdWdodCwgaWYgd2UgbmVl
ZCB0byBkbyBzb21ldGhpbmcgZm9yIHN0YWJsZS4gaXMgaXQgYmV0dGVyCj4+IGlmIHdlIGp1c3Qg
YmFja3BvcnQgU2hhbm5vbidzIHNlcmllcyB0byBzdGFibGU/Cj4+Cj4+ID4KPj4gPiBJIHdhcyBq
dXN0IGNvbmNlcm5lZCBhYm91dCBob3cgZG9lcyB0aGUgdXNlciBzcGFjZSB1bmRlcnN0YW5kIHRo
YXQgaXQKPj4gPiBjYW4gdXNlIFNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFIGZvciBQQUNL
RUQgdmlydHF1ZXVlcyBpbiBhIGdpdmVuCj4+ID4ga2VybmVsIG9yIG5vdC4KPj4KPj4gTXkgdW5k
ZXJzdGFuZGluZyBpcyB0aGF0IGlmIHBhY2tlZCBpcyBhZHZlcnRpc2VkLCB0aGUgYXBwbGljYXRp
b24KPj4gc2hvdWxkIGFzc3VtZSBTRVQvR0VUX1ZSSU5HX0JBU0Ugd29yay4KPj4KPj4gVGhhbmtz
Cj4KPgo+TGV0IG1lIGFzayB5b3UgdGhpcy4gVGhpcyBpcyBhIGJ1Z2ZpeCB5ZXM/IFdoYXQgaXMg
dGhlIGFwcHJvcHJpYXRlIEZpeGVzCj50YWc/CgpJIHdvdWxkIHNheToKCkZpeGVzOiA0YzhjZjMx
ODg1ZjYgKCJ2aG9zdDogaW50cm9kdWNlIHZEUEEtYmFzZWQgYmFja2VuZCIpCgpiZWNhdXNlIHdl
IGhhZCBhbiBhbGxvdyBsaXN0IGFuZCBlbmFibGVkIFBBQ0tFRCBleHBsaWNpdGx5LgoKSSdtIG5v
dCBzdXJlIGlmIHRoZSBwYXJlbnRzIGF0IHRoYXQgdGltZSBzdXBwb3J0ZWQgUEFDS0VELCBidXQK
bWF5YmUgaXQgZG9lc24ndCBtYXR0ZXIgc2luY2Ugd2UgYXJlIHRhbGtpbmcgYWJvdXQgdGhlIGNv
ZGUgaW4Kdmhvc3QtdmRwYS4KClRoYW5rcywKU3RlZmFubwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
