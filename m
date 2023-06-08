Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE367C7EE25
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 09:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 738DB83A8E;
	Thu,  8 Jun 2023 09:30:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 738DB83A8E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IIyHCN7H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1BqTITbvbvQ; Thu,  8 Jun 2023 09:30:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E246181E47;
	Thu,  8 Jun 2023 09:30:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E246181E47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADF11C007A;
	Thu,  8 Jun 2023 09:30:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0079EC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB8AB60AD6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:30:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB8AB60AD6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IIyHCN7H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EX7RIDGLJLDI
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:30:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F26560A9B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F26560A9B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686216614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7hoCCHwyZ78t8MhfigepGi6we5dYHokO9yNVTkJZRY=;
 b=IIyHCN7Hp3MkiDqNMsels6d+UOIeqnMsS36BchYgUcD9D7Q0nvnd17xBvQvQxTVuPrnLjf
 H7RIxte18IXRUNRsJxVF7GiPSrz109kybUXKGAQ7rMos2m+DAb56YehKVNZiZMpolOjdu5
 2sCU66kFCTnHnMQPxF4v5wHSBVn4o2s=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-UT4MylUXOmGozEboIFrsWw-1; Thu, 08 Jun 2023 05:30:11 -0400
X-MC-Unique: UT4MylUXOmGozEboIFrsWw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b1ec111688so1949981fa.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 02:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686216609; x=1688808609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C7hoCCHwyZ78t8MhfigepGi6we5dYHokO9yNVTkJZRY=;
 b=KHPNZ46aUr4b+Menbuojrko6bRiIoq3a3s1zxzxuUjk5aS9Ef8BhnNvyFuNmMJixhw
 256JgGeAgoWbO6rKc8b+xQwBPzMxNojT6g4/L0cteQqKfX2Q60e37QWDSZ00J0Zeeh7S
 VMpCD6Nnaa964YO7P0+A+Cp/7c/2Z1pr8p62mIy3N0yFXy8uV/yabVkH9lOaRGroeHa0
 NNnIxTXFYDkAsUMVDNN7Zr5Q+QWoZuzB2Umbvhu9PjTb0EDq2z3x/t/AUu8NWlgRSDzM
 My3awpEwi1JyHz/CrN8rIRTLkNjUdzmhqdyw83MFYIWe4mpylfGaZuoYk6duCMETNpjQ
 gY5Q==
X-Gm-Message-State: AC+VfDxu38PVdHTVQkoKH9ZAqEyeJ3s6rxwfz7pHuj6uikPNxsf3VQ/r
 O3yHPoP1AHO0fh8C2lfkQ4M7ObMWqIYws5MIObWIZ2ZLG4GxZmY33GfYc9UfaophLh4tIx9SVKr
 UWvGt/bxwwzn2cfZsSAqHF1ATV3c2sIMhXgKEw9ui8pmOGD1M/nJcPcyi1Q==
X-Received: by 2002:a2e:7c01:0:b0:2b0:45ff:7952 with SMTP id
 x1-20020a2e7c01000000b002b045ff7952mr2937345ljc.46.1686216609604; 
 Thu, 08 Jun 2023 02:30:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UZCodSXe8QJG9qyQ8hxilMfqcB032BMizZjc3X/xA2bZal/+MGVVGoUXxdh3KL+1mGFUZIjOMQh01hn/DswI=
X-Received: by 2002:a2e:7c01:0:b0:2b0:45ff:7952 with SMTP id
 x1-20020a2e7c01000000b002b045ff7952mr2937333ljc.46.1686216609317; Thu, 08 Jun
 2023 02:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
 <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
 <20230606085643-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fkgL-HpZdj=5ZEGNWcESCHQpgRAYQA3W2sPZaoEpNyQ@mail.gmail.com>
 <20230607054246-mutt-send-email-mst@kernel.org>
 <CACGkMEuUapKvUYiJiLwtsN+x941jafDKS9tuSkiNrvkrrSmQkg@mail.gmail.com>
 <20230608020111-mutt-send-email-mst@kernel.org>
 <CACGkMEt4=3BRVNX38AD+mJU8v3bmqO-CdNj5NkFP-SSvsuy2Hg@mail.gmail.com>
 <5giudxjp6siucr4l3i4tggrh2dpqiqhhihmdd34w3mq2pm5dlo@mrqpbwckpxai>
 <CACGkMEtqn1dbrQZn3i-W_7sVikY4sQjwLRC5xAhMnyqkc3jwOw@mail.gmail.com>
 <lw3nmkdszqo6jjtneyp4kjlmutooozz7xj2fqyxgh4v2ralptc@vkimgnbfafvi>
In-Reply-To: <lw3nmkdszqo6jjtneyp4kjlmutooozz7xj2fqyxgh4v2ralptc@vkimgnbfafvi>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jun 2023 17:29:58 +0800
Message-ID: <CACGkMEt1yRV9qOLBqtQQmJA_UoRLCpznT=Gvd5D51Uaz2jakHA@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

T24gVGh1LCBKdW4gOCwgMjAyMyBhdCA1OjIx4oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgSnVuIDA4LCAyMDIzIGF0IDA1OjAw
OjAwUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPk9uIFRodSwgSnVuIDgsIDIwMjMgYXQg
NDowMOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPj4KPiA+PiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAwMzo0NjowMFBNICswODAwLCBKYXNv
biBXYW5nIHdyb3RlOgo+ID4+Cj4gPj4gWy4uLl0KPiA+Pgo+ID4+ID4+ID4gPiA+ID4gSSBoYXZl
IGEgcXVlc3Rpb24gdGhvdWdoLCB3aGF0IGlmIGRvd24gdGhlIHJvYWQgdGhlcmUKPiA+PiA+PiA+
ID4gPiA+IGlzIGEgbmV3IGZlYXR1cmUgdGhhdCBuZWVkcyBtb3JlIGNoYW5nZXM/IEl0IHdpbGwg
YmUKPiA+PiA+PiA+ID4gPiA+IGJyb2tlbiB0b28ganVzdCBsaWtlIFBBQ0tFRCBubz8KPiA+PiA+
PiA+ID4gPiA+IFNob3VsZG4ndCB2ZHBhIGhhdmUgYW4gYWxsb3dsaXN0IG9mIGZlYXR1cmVzIGl0
IGtub3dzIGhvdwo+ID4+ID4+ID4gPiA+ID4gdG8gc3VwcG9ydD8KPiA+PiA+PiA+ID4gPgo+ID4+
ID4+ID4gPiA+IEl0IGxvb2tzIGxpa2Ugd2UgaGFkIGl0LCBidXQgd2UgdG9vayBpdCBvdXQgKGJ5
IHRoZSB3YXksIHdlIHdlcmUKPiA+PiA+PiA+ID4gPiBlbmFibGluZyBwYWNrZWQgZXZlbiB0aG91
Z2ggd2UgZGlkbid0IHN1cHBvcnQgaXQpOgo+ID4+ID4+ID4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQv
P2lkPTYyMzRmODA1NzRkNzU2OTQ0NGQ4NzE4MzU1ZmEyODM4ZTkyYjE1OGIKPiA+PiA+PiA+ID4g
Pgo+ID4+ID4+ID4gPiA+IFRoZSBvbmx5IHByb2JsZW0gSSBzZWUgaXMgdGhhdCBmb3IgZWFjaCBu
ZXcgZmVhdHVyZSB3ZSBoYXZlIHRvIG1vZGlmeQo+ID4+ID4+ID4gPiA+IHRoZSBrZXJuZWwuCj4g
Pj4gPj4gPiA+ID4gQ291bGQgd2UgaGF2ZSBuZXcgZmVhdHVyZXMgdGhhdCBkb24ndCByZXF1aXJl
IGhhbmRsaW5nIGJ5IHZob3N0LXZkcGE/Cj4gPj4gPj4gPiA+ID4KPiA+PiA+PiA+ID4gPiBUaGFu
a3MsCj4gPj4gPj4gPiA+ID4gU3RlZmFubwo+ID4+ID4+ID4gPgo+ID4+ID4+ID4gPiBKYXNvbiB3
aGF0IGRvIHlvdSBzYXkgdG8gcmV2ZXJ0aW5nIHRoaXM/Cj4gPj4gPj4gPgo+ID4+ID4+ID4gSSBt
YXkgbWlzcyBzb21ldGhpbmcgYnV0IEkgZG9uJ3Qgc2VlIGFueSBwcm9ibGVtIHdpdGggdkRQQSBj
b3JlLgo+ID4+ID4+ID4KPiA+PiA+PiA+IEl0J3MgdGhlIGR1dHkgb2YgdGhlIHBhcmVudHMgdG8g
YWR2ZXJ0aXNlIHRoZSBmZWF0dXJlcyBpdCBoYXMuIEZvciBleGFtcGxlLAo+ID4+ID4+ID4KPiA+
PiA+PiA+IDEpIElmIHNvbWUga2VybmVsIHZlcnNpb24gdGhhdCBpcyBwYWNrZWQgaXMgbm90IHN1
cHBvcnRlZCB2aWEKPiA+PiA+PiA+IHNldF92cV9zdGF0ZSwgcGFyZW50cyBzaG91bGQgbm90IGFk
dmVydGlzZSBQQUNLRUQgZmVhdHVyZXMgaW4gdGhpcwo+ID4+ID4+ID4gY2FzZS4KPiA+PiA+PiA+
IDIpIElmIHRoZSBrZXJuZWwgaGFzIHN1cHBvcnQgcGFja2VkIHNldF92cV9zdGF0ZSgpLCBidXQg
aXQncyBlbXVsYXRlZAo+ID4+ID4+ID4gY3ZxIGRvZXNuJ3Qgc3VwcG9ydCwgcGFyZW50cyBzaG91
bGQgbm90IGFkdmVydGlzZSBQQUNLRUQgYXMgd2VsbAo+ID4+ID4+ID4KPiA+PiA+PiA+IElmIGEg
cGFyZW50IHZpb2xhdGVzIHRoZSBhYm92ZSAyLCBpdCBsb29rcyBsaWtlIGEgYnVnIG9mIHRoZSBw
YXJlbnRzLgo+ID4+ID4+ID4KPiA+PiA+PiA+IFRoYW5rcwo+ID4+ID4+Cj4gPj4gPj4gWWVzIGJ1
dCB3aGF0IGFib3V0IHZob3N0X3ZkcGE/IFRhbGtpbmcgYWJvdXQgdGhhdCBub3QgdGhlIGNvcmUu
Cj4gPj4gPgo+ID4+ID5Ob3Qgc3VyZSBpdCdzIGEgZ29vZCBpZGVhIHRvIHdvcmthcm91bmQgcGFy
ZW50IGJ1Z3MgdmlhIHZob3N0LXZEUEEuCj4gPj4KPiA+PiBTb3JyeSwgSSdtIGdldHRpbmcgbG9z
dC4uLgo+ID4+IFdlIHdlcmUgdGFsa2luZyBhYm91dCB0aGUgZmFjdCB0aGF0IHZob3N0LXZkcGEg
ZG9lc24ndCBoYW5kbGUKPiA+PiBTRVRfVlJJTkdfQkFTRS9HRVRfVlJJTkdfQkFTRSBpb2N0bHMg
d2VsbCBmb3IgcGFja2VkIHZpcnRxdWV1ZSBiZWZvcmUKPiA+PiB0aGF0IHNlcmllcyBbMV0sIG5v
Pwo+ID4+Cj4gPj4gVGhlIHBhcmVudHMgc2VlbSBva2F5LCBidXQgbWF5YmUgSSBtaXNzZWQgYSBm
ZXcgdGhpbmdzLgo+ID4+Cj4gPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxp
emF0aW9uLzIwMjMwNDI0MjI1MDMxLjE4OTQ3LTEtc2hhbm5vbi5uZWxzb25AYW1kLmNvbS8KPiA+
Cj4gPlllcywgbW9yZSBiZWxvdy4KPiA+Cj4gPj4KPiA+PiA+Cj4gPj4gPj4gU2hvdWxkIHRoYXQg
bm90IGhhdmUgYSB3aGl0ZWxpc3Qgb2YgZmVhdHVyZXMKPiA+PiA+PiBzaW5jZSBpdCBpbnRlcnBy
ZXRzIGlvY3RscyBkaWZmZXJlbnRseSBkZXBlbmRpbmcgb24gdGhpcz8KPiA+PiA+Cj4gPj4gPklm
IHRoZXJlJ3MgYSBidWcsIGl0IG1pZ2h0IG9ubHkgbWF0dGVyIHRoZSBmb2xsb3dpbmcgc2V0dXA6
Cj4gPj4gPgo+ID4+ID5TRVRfVlJJTkdfQkFTRS9HRVRfVlJJTkdfQkFTRSArIFZEVVNFLgo+ID4+
ID4KPiA+PiA+VGhpcyBzZWVtcyB0byBiZSBicm9rZW4gc2luY2UgVkRVU0Ugd2FzIGludHJvZHVj
ZWQuIElmIHdlIHJlYWxseSB3YW50Cj4gPj4gPnRvIGJhY2twb3J0IHNvbWV0aGluZywgaXQgY291
bGQgYmUgYSBmaXggdG8gZmlsdGVyIG91dCBQQUNLRUQgaW4KPiA+PiA+VkRVU0U/Cj4gPj4KPiA+
PiBtbW0gaXQgZG9lc24ndCBzZWVtIHRvIGJlIGEgcHJvYmxlbSBpbiBWRFVTRSwgYnV0IGluIHZo
b3N0LXZkcGEuCj4gPj4gSSB0aGluayBWRFVTRSB3b3JrcyBmaW5lIHdpdGggcGFja2VkIHZpcnRx
dWV1ZSB1c2luZyB2aXJ0aW8tdmRwYQo+ID4+IChJIGhhdmVuJ3QgdHJpZWQpLCBzbyB3aHkgc2hv
dWxkIHdlIGZpbHRlciBQQUNLRUQgaW4gVkRVU0U/Cj4gPgo+ID5JIGRvbid0IHRoaW5rIHdlIG5l
ZWQgYW55IGZpbHRlcmluZyBzaW5jZToKPiA+Cj4gPlBBQ0tFRCBmZWF0dXJlcyBoYXMgYmVlbiBh
ZHZlcnRpc2VkIHRvIHVzZXJzcGFjZSB2aWEgdUFQSSBzaW5jZQo+ID42MjM0ZjgwNTc0ZDc1Njk0
NDRkODcxODM1NWZhMjgzOGU5MmIxNThiLiBPbmNlIHdlIHJlbGF4IGluIHVBUEksIGl0Cj4gPndv
dWxkIGJlIHZlcnkgaGFyZCB0byByZXN0cmljdCBpdCBhZ2Fpbi4gRm9yIHRoZSB1c2Vyc3BhY2Ug
dGhhdCB0cmllcwo+ID50byBuZWdvdGlhdGUgUEFDS0VEOgo+ID4KPiA+MSkgaWYgaXQgZG9lc24n
dCB1c2UgU0VUX1ZSSU5HX0JBU0UvR0VUX1ZSSU5HX0JBU0UsIGV2ZXJ5dGhpbmcgd29ya3Mgd2Vs
bAo+ID4yKSBpZiBpdCB1c2VzIFNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFLiBpdCBtaWdo
dCBmYWlsIG9yIGJyZWFrIHNpbGVudGx5Cj4gPgo+ID5JZiB3ZSBiYWNrcG9ydCB0aGUgZml4ZXMg
dG8gLXN0YWJsZSwgd2UgbWF5IGJyZWFrIHRoZSBhcHBsaWNhdGlvbiBhdAo+ID5sZWFzdCBpbiB0
aGUgY2FzZSAxKS4KPgo+IE9rYXksIEkgc2VlIG5vdywgdGhhbmtzIGZvciB0aGUgZGV0YWlscyEK
Pgo+IE1heWJlIGluc3RlYWQgb2YgImJyZWFrIHNpbGVudGx5Iiwgd2UgY2FuIHJldHVybiBhbiBl
eHBsaWNpdCBlcnJvciBmb3IKPiBTRVRfVlJJTkdfQkFTRS9HRVRfVlJJTkdfQkFTRSBpbiBzdGFi
bGUgYnJhbmNoZXMuCj4gQnV0IGlmIHRoZXJlIGFyZSBub3QgbWFueSBjYXNlcywgd2UgY2FuIGxl
YXZlIGl0IGxpa2UgdGhhdC4KCkEgc2Vjb25kIHRob3VnaHQsIGlmIHdlIG5lZWQgdG8gZG8gc29t
ZXRoaW5nIGZvciBzdGFibGUuIGlzIGl0IGJldHRlcgppZiB3ZSBqdXN0IGJhY2twb3J0IFNoYW5u
b24ncyBzZXJpZXMgdG8gc3RhYmxlPwoKPgo+IEkgd2FzIGp1c3QgY29uY2VybmVkIGFib3V0IGhv
dyBkb2VzIHRoZSB1c2VyIHNwYWNlIHVuZGVyc3RhbmQgdGhhdCBpdAo+IGNhbiB1c2UgU0VUX1ZS
SU5HX0JBU0UvR0VUX1ZSSU5HX0JBU0UgZm9yIFBBQ0tFRCB2aXJ0cXVldWVzIGluIGEgZ2l2ZW4K
PiBrZXJuZWwgb3Igbm90LgoKTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGlmIHBhY2tlZCBpcyBh
ZHZlcnRpc2VkLCB0aGUgYXBwbGljYXRpb24Kc2hvdWxkIGFzc3VtZSBTRVQvR0VUX1ZSSU5HX0JB
U0Ugd29yay4KClRoYW5rcwoKPgo+IFRoYW5rcywKPiBTdGVmYW5vCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
