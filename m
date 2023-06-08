Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E872FC7EE29
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 09:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 769884058C;
	Thu,  8 Jun 2023 09:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 769884058C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AdloyzYU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GKLYhUs4vrMk; Thu,  8 Jun 2023 09:48:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 98C6241F12;
	Thu,  8 Jun 2023 09:48:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98C6241F12
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 742EDC007A;
	Thu,  8 Jun 2023 09:48:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B154BC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9951883AAA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:48:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9951883AAA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AdloyzYU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fvqh97cAhoGb
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:48:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E78983AA1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E78983AA1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686217682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJkqbDxJbGuLRNFoh+RhZZol0vchzC/C3TXtJPnBQMs=;
 b=AdloyzYUx0BsUo+9XtBjGdeFdBptXhk7e5MHmTIhGAQ7CW00AOf5QnNGZMLTdeRbYBuU4k
 k2JB5y/bKUMjE+ND5A+ATAYzhoJJ2KRKS44TvlI26eOusqo+E8jEiDdG/dG7icJ/08+E2T
 OYXVKiDBkqejV+RNyFay36/M4me1Z1w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-6YY7mC62Npub04Q_77k9LQ-1; Thu, 08 Jun 2023 05:48:01 -0400
X-MC-Unique: 6YY7mC62Npub04Q_77k9LQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9745c72d99cso60957566b.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 02:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686217680; x=1688809680;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qJkqbDxJbGuLRNFoh+RhZZol0vchzC/C3TXtJPnBQMs=;
 b=cWTgXyXLDBtgD4d5D8lSlg7QAMWO5IIjeTpBMwjbedZnpNKd65EYxFE3WXtdtqJF42
 s3FCsoy/wMeageKeaM4+PEB0aZxUmCq8eqnkBh9B3dQZL33OxXREDCnWMCfEXskrdHlR
 kWL7hZy3RwYyys/feNS82SJsC7GmnBjbZcgCkImQ118d5UD0A9lZl3AJmMxghA5GRNsX
 bQjLpNLeEYRM75ZYQ33iRUuQL0H9A9Y8UNFSeH0uqLDY4CSSJcnkroz0jnFQYl/t5sVd
 meGkUwrNPLUyeNFkPK2aDlImJDz5AblE6qaSHvJtOBefK/zGEznJkYy3bqu9E836R912
 OusQ==
X-Gm-Message-State: AC+VfDyy8upMBwgm5gZieIPcPt1J2SZOYpij04eDpGe9vAwsy5YeRVwv
 MTaQSVqP8xtl3VxHj27dXfiIE6sKXWtz3XtsFaM6KH+NGpSpMJ+DoZRg2SyWCdl14r+HUuzo+aN
 F2O7bHAstCNpM90YklYiz4mM+2iguHLahvjzxCyRthg==
X-Received: by 2002:a17:906:fe4d:b0:969:e9ec:9a0 with SMTP id
 wz13-20020a170906fe4d00b00969e9ec09a0mr8201384ejb.77.1686217679947; 
 Thu, 08 Jun 2023 02:47:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6NJp+wlr+w+M7l9N5lK1cvOGgUHySBO4evePM0JMqeGlWTtsRtzk3HhVko4gsZJNpXU4WPjA==
X-Received: by 2002:a17:906:fe4d:b0:969:e9ec:9a0 with SMTP id
 wz13-20020a170906fe4d00b00969e9ec09a0mr8201367ejb.77.1686217679599; 
 Thu, 08 Jun 2023 02:47:59 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-111.business.telecomitalia.it.
 [87.12.25.111]) by smtp.gmail.com with ESMTPSA id
 t7-20020a1c7707000000b003f6cf9afc25sm4641635wmi.40.2023.06.08.02.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 02:47:59 -0700 (PDT)
Date: Thu, 8 Jun 2023 11:47:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <t6ci7ek54zwss2w3kxaduirfi7vp5df5ydjxjlnr5fhv4ji3c5@aw26xy66pjc7>
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
MIME-Version: 1.0
In-Reply-To: <CACGkMEt1yRV9qOLBqtQQmJA_UoRLCpznT=Gvd5D51Uaz2jakHA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

T24gVGh1LCBKdW4gMDgsIDIwMjMgYXQgMDU6Mjk6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPk9uIFRodSwgSnVuIDgsIDIwMjMgYXQgNToyMeKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8
c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IE9uIFRodSwgSnVuIDA4LCAyMDIzIGF0
IDA1OjAwOjAwUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+ID5PbiBUaHUsIEp1biA4LCAy
MDIzIGF0IDQ6MDDigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+
IHdyb3RlOgo+PiA+Pgo+PiA+PiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAwMzo0NjowMFBNICsw
ODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiA+Pgo+PiA+PiBbLi4uXQo+PiA+Pgo+PiA+PiA+PiA+
ID4gPiA+IEkgaGF2ZSBhIHF1ZXN0aW9uIHRob3VnaCwgd2hhdCBpZiBkb3duIHRoZSByb2FkIHRo
ZXJlCj4+ID4+ID4+ID4gPiA+ID4gaXMgYSBuZXcgZmVhdHVyZSB0aGF0IG5lZWRzIG1vcmUgY2hh
bmdlcz8gSXQgd2lsbCBiZQo+PiA+PiA+PiA+ID4gPiA+IGJyb2tlbiB0b28ganVzdCBsaWtlIFBB
Q0tFRCBubz8KPj4gPj4gPj4gPiA+ID4gPiBTaG91bGRuJ3QgdmRwYSBoYXZlIGFuIGFsbG93bGlz
dCBvZiBmZWF0dXJlcyBpdCBrbm93cyBob3cKPj4gPj4gPj4gPiA+ID4gPiB0byBzdXBwb3J0Pwo+
PiA+PiA+PiA+ID4gPgo+PiA+PiA+PiA+ID4gPiBJdCBsb29rcyBsaWtlIHdlIGhhZCBpdCwgYnV0
IHdlIHRvb2sgaXQgb3V0IChieSB0aGUgd2F5LCB3ZSB3ZXJlCj4+ID4+ID4+ID4gPiA+IGVuYWJs
aW5nIHBhY2tlZCBldmVuIHRob3VnaCB3ZSBkaWRuJ3Qgc3VwcG9ydCBpdCk6Cj4+ID4+ID4+ID4g
PiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTYyMzRmODA1NzRkNzU2OTQ0NGQ4NzE4MzU1ZmEyODM4
ZTkyYjE1OGIKPj4gPj4gPj4gPiA+ID4KPj4gPj4gPj4gPiA+ID4gVGhlIG9ubHkgcHJvYmxlbSBJ
IHNlZSBpcyB0aGF0IGZvciBlYWNoIG5ldyBmZWF0dXJlIHdlIGhhdmUgdG8gbW9kaWZ5Cj4+ID4+
ID4+ID4gPiA+IHRoZSBrZXJuZWwuCj4+ID4+ID4+ID4gPiA+IENvdWxkIHdlIGhhdmUgbmV3IGZl
YXR1cmVzIHRoYXQgZG9uJ3QgcmVxdWlyZSBoYW5kbGluZyBieSB2aG9zdC12ZHBhPwo+PiA+PiA+
PiA+ID4gPgo+PiA+PiA+PiA+ID4gPiBUaGFua3MsCj4+ID4+ID4+ID4gPiA+IFN0ZWZhbm8KPj4g
Pj4gPj4gPiA+Cj4+ID4+ID4+ID4gPiBKYXNvbiB3aGF0IGRvIHlvdSBzYXkgdG8gcmV2ZXJ0aW5n
IHRoaXM/Cj4+ID4+ID4+ID4KPj4gPj4gPj4gPiBJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgSSBk
b24ndCBzZWUgYW55IHByb2JsZW0gd2l0aCB2RFBBIGNvcmUuCj4+ID4+ID4+ID4KPj4gPj4gPj4g
PiBJdCdzIHRoZSBkdXR5IG9mIHRoZSBwYXJlbnRzIHRvIGFkdmVydGlzZSB0aGUgZmVhdHVyZXMg
aXQgaGFzLiBGb3IgZXhhbXBsZSwKPj4gPj4gPj4gPgo+PiA+PiA+PiA+IDEpIElmIHNvbWUga2Vy
bmVsIHZlcnNpb24gdGhhdCBpcyBwYWNrZWQgaXMgbm90IHN1cHBvcnRlZCB2aWEKPj4gPj4gPj4g
PiBzZXRfdnFfc3RhdGUsIHBhcmVudHMgc2hvdWxkIG5vdCBhZHZlcnRpc2UgUEFDS0VEIGZlYXR1
cmVzIGluIHRoaXMKPj4gPj4gPj4gPiBjYXNlLgo+PiA+PiA+PiA+IDIpIElmIHRoZSBrZXJuZWwg
aGFzIHN1cHBvcnQgcGFja2VkIHNldF92cV9zdGF0ZSgpLCBidXQgaXQncyBlbXVsYXRlZAo+PiA+
PiA+PiA+IGN2cSBkb2Vzbid0IHN1cHBvcnQsIHBhcmVudHMgc2hvdWxkIG5vdCBhZHZlcnRpc2Ug
UEFDS0VEIGFzIHdlbGwKPj4gPj4gPj4gPgo+PiA+PiA+PiA+IElmIGEgcGFyZW50IHZpb2xhdGVz
IHRoZSBhYm92ZSAyLCBpdCBsb29rcyBsaWtlIGEgYnVnIG9mIHRoZSBwYXJlbnRzLgo+PiA+PiA+
PiA+Cj4+ID4+ID4+ID4gVGhhbmtzCj4+ID4+ID4+Cj4+ID4+ID4+IFllcyBidXQgd2hhdCBhYm91
dCB2aG9zdF92ZHBhPyBUYWxraW5nIGFib3V0IHRoYXQgbm90IHRoZSBjb3JlLgo+PiA+PiA+Cj4+
ID4+ID5Ob3Qgc3VyZSBpdCdzIGEgZ29vZCBpZGVhIHRvIHdvcmthcm91bmQgcGFyZW50IGJ1Z3Mg
dmlhIHZob3N0LXZEUEEuCj4+ID4+Cj4+ID4+IFNvcnJ5LCBJJ20gZ2V0dGluZyBsb3N0Li4uCj4+
ID4+IFdlIHdlcmUgdGFsa2luZyBhYm91dCB0aGUgZmFjdCB0aGF0IHZob3N0LXZkcGEgZG9lc24n
dCBoYW5kbGUKPj4gPj4gU0VUX1ZSSU5HX0JBU0UvR0VUX1ZSSU5HX0JBU0UgaW9jdGxzIHdlbGwg
Zm9yIHBhY2tlZCB2aXJ0cXVldWUgYmVmb3JlCj4+ID4+IHRoYXQgc2VyaWVzIFsxXSwgbm8/Cj4+
ID4+Cj4+ID4+IFRoZSBwYXJlbnRzIHNlZW0gb2theSwgYnV0IG1heWJlIEkgbWlzc2VkIGEgZmV3
IHRoaW5ncy4KPj4gPj4KPj4gPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxp
emF0aW9uLzIwMjMwNDI0MjI1MDMxLjE4OTQ3LTEtc2hhbm5vbi5uZWxzb25AYW1kLmNvbS8KPj4g
Pgo+PiA+WWVzLCBtb3JlIGJlbG93Lgo+PiA+Cj4+ID4+Cj4+ID4+ID4KPj4gPj4gPj4gU2hvdWxk
IHRoYXQgbm90IGhhdmUgYSB3aGl0ZWxpc3Qgb2YgZmVhdHVyZXMKPj4gPj4gPj4gc2luY2UgaXQg
aW50ZXJwcmV0cyBpb2N0bHMgZGlmZmVyZW50bHkgZGVwZW5kaW5nIG9uIHRoaXM/Cj4+ID4+ID4K
Pj4gPj4gPklmIHRoZXJlJ3MgYSBidWcsIGl0IG1pZ2h0IG9ubHkgbWF0dGVyIHRoZSBmb2xsb3dp
bmcgc2V0dXA6Cj4+ID4+ID4KPj4gPj4gPlNFVF9WUklOR19CQVNFL0dFVF9WUklOR19CQVNFICsg
VkRVU0UuCj4+ID4+ID4KPj4gPj4gPlRoaXMgc2VlbXMgdG8gYmUgYnJva2VuIHNpbmNlIFZEVVNF
IHdhcyBpbnRyb2R1Y2VkLiBJZiB3ZSByZWFsbHkgd2FudAo+PiA+PiA+dG8gYmFja3BvcnQgc29t
ZXRoaW5nLCBpdCBjb3VsZCBiZSBhIGZpeCB0byBmaWx0ZXIgb3V0IFBBQ0tFRCBpbgo+PiA+PiA+
VkRVU0U/Cj4+ID4+Cj4+ID4+IG1tbSBpdCBkb2Vzbid0IHNlZW0gdG8gYmUgYSBwcm9ibGVtIGlu
IFZEVVNFLCBidXQgaW4gdmhvc3QtdmRwYS4KPj4gPj4gSSB0aGluayBWRFVTRSB3b3JrcyBmaW5l
IHdpdGggcGFja2VkIHZpcnRxdWV1ZSB1c2luZyB2aXJ0aW8tdmRwYQo+PiA+PiAoSSBoYXZlbid0
IHRyaWVkKSwgc28gd2h5IHNob3VsZCB3ZSBmaWx0ZXIgUEFDS0VEIGluIFZEVVNFPwo+PiA+Cj4+
ID5JIGRvbid0IHRoaW5rIHdlIG5lZWQgYW55IGZpbHRlcmluZyBzaW5jZToKPj4gPgo+PiA+UEFD
S0VEIGZlYXR1cmVzIGhhcyBiZWVuIGFkdmVydGlzZWQgdG8gdXNlcnNwYWNlIHZpYSB1QVBJIHNp
bmNlCj4+ID42MjM0ZjgwNTc0ZDc1Njk0NDRkODcxODM1NWZhMjgzOGU5MmIxNThiLiBPbmNlIHdl
IHJlbGF4IGluIHVBUEksIGl0Cj4+ID53b3VsZCBiZSB2ZXJ5IGhhcmQgdG8gcmVzdHJpY3QgaXQg
YWdhaW4uIEZvciB0aGUgdXNlcnNwYWNlIHRoYXQgdHJpZXMKPj4gPnRvIG5lZ290aWF0ZSBQQUNL
RUQ6Cj4+ID4KPj4gPjEpIGlmIGl0IGRvZXNuJ3QgdXNlIFNFVF9WUklOR19CQVNFL0dFVF9WUklO
R19CQVNFLCBldmVyeXRoaW5nIHdvcmtzIHdlbGwKPj4gPjIpIGlmIGl0IHVzZXMgU0VUX1ZSSU5H
X0JBU0UvR0VUX1ZSSU5HX0JBU0UuIGl0IG1pZ2h0IGZhaWwgb3IgYnJlYWsgc2lsZW50bHkKPj4g
Pgo+PiA+SWYgd2UgYmFja3BvcnQgdGhlIGZpeGVzIHRvIC1zdGFibGUsIHdlIG1heSBicmVhayB0
aGUgYXBwbGljYXRpb24gYXQKPj4gPmxlYXN0IGluIHRoZSBjYXNlIDEpLgo+Pgo+PiBPa2F5LCBJ
IHNlZSBub3csIHRoYW5rcyBmb3IgdGhlIGRldGFpbHMhCj4+Cj4+IE1heWJlIGluc3RlYWQgb2Yg
ImJyZWFrIHNpbGVudGx5Iiwgd2UgY2FuIHJldHVybiBhbiBleHBsaWNpdCBlcnJvciBmb3IKPj4g
U0VUX1ZSSU5HX0JBU0UvR0VUX1ZSSU5HX0JBU0UgaW4gc3RhYmxlIGJyYW5jaGVzLgo+PiBCdXQg
aWYgdGhlcmUgYXJlIG5vdCBtYW55IGNhc2VzLCB3ZSBjYW4gbGVhdmUgaXQgbGlrZSB0aGF0Lgo+
Cj5BIHNlY29uZCB0aG91Z2h0LCBpZiB3ZSBuZWVkIHRvIGRvIHNvbWV0aGluZyBmb3Igc3RhYmxl
LiBpcyBpdCBiZXR0ZXIKPmlmIHdlIGp1c3QgYmFja3BvcnQgU2hhbm5vbidzIHNlcmllcyB0byBz
dGFibGU/CgpJIHRyaWVkIHRvIGxvb2sgYXQgaXQsIGJ1dCBpdCBsb29rcyBsaWtlIHdlIGhhdmUg
dG8gYmFja3BvcnQgcXVpdGUgYSBmZXcKcGF0Y2hlcywgSSB3cm90ZSBhIGZldyB0aGluZ3MgaGVy
ZToKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzMyZWpqdXZodmNpY3Y3
d2p1ZXRrdjM0cXRscGE2NTduNHpsb3c0ZXEzZnNpMnR3b3prQGlxbmQydDV0dzJhbi8KCkJ1dCBp
ZiB5b3UgdGhpbmsgaXQncyB0aGUgYmVzdCB3YXksIHRob3VnaCwgd2UgY2FuIHRha2UgYSBiZXR0
ZXIgbG9vawphdCBob3cgbWFueSBwYXRjaGVzIGFyZSB0byBiYWNrcG9ydCBhbmQgd2hldGhlciBp
dCdzIHJpc2t5IG9yIG5vdC4KCj4KPj4KPj4gSSB3YXMganVzdCBjb25jZXJuZWQgYWJvdXQgaG93
IGRvZXMgdGhlIHVzZXIgc3BhY2UgdW5kZXJzdGFuZCB0aGF0IGl0Cj4+IGNhbiB1c2UgU0VUX1ZS
SU5HX0JBU0UvR0VUX1ZSSU5HX0JBU0UgZm9yIFBBQ0tFRCB2aXJ0cXVldWVzIGluIGEgZ2l2ZW4K
Pj4ga2VybmVsIG9yIG5vdC4KPgo+TXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGlmIHBhY2tlZCBp
cyBhZHZlcnRpc2VkLCB0aGUgYXBwbGljYXRpb24KPnNob3VsZCBhc3N1bWUgU0VUL0dFVF9WUklO
R19CQVNFIHdvcmsuCj4KClNhbWUgaGVyZS4gU28gYXMgYW4gYWx0ZXJuYXRpdmUgdG8gYmFja3Bv
cnRpbmcgYSBsYXJnZSBzZXQgb2YgcGF0Y2hlcywKSSBwcm9wb3NlZCB0byBjb21wbGV0ZWx5IGRp
c2FibGUgcGFja2VkIGZvciBzdGFibGUgYnJhbmNoZXMgd2hlcmUKdmhvc3QtdmRwYSBJT0NUTHMg
ZG9lc24ndCBzdXBwb3J0IHRoZW0gdmVyeSB3ZWxsLgoKVGhhbmtzLApTdGVmYW5vCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
