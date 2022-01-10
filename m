Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FD2C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 08:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CFA0408EA;
	Mon, 10 Jan 2022 08:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wzIoJGBXNVC8; Mon, 10 Jan 2022 08:55:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DF880408E9;
	Mon, 10 Jan 2022 08:55:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5C2AC0030;
	Mon, 10 Jan 2022 08:55:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15457C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 08:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1170B408EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 08:55:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kFziIhuhj0r9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 08:55:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4ADCC408E9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 08:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641804912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWBo0rYwv79ih7UsVrWR7qP6jd2P85KgK6cQllUvYx4=;
 b=JyW6QG75DEimAHZqgjFOcG1dHHzQTaH3Pu3OE1lqdTK2hFdaerKjSd4J3z5feZygsa79r1
 roCPLDjjQ/+ePzBrlhk6QDnyLS30xHX2VZO2/r0tLI57cAHZGQkuQVM8U9YXjyoJHxFGMQ
 rPjQn85xMkjKy5BJoezsdqZZ0CNd964=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-eY5EwwkHMjeEWZDBhmwR-g-1; Mon, 10 Jan 2022 03:55:11 -0500
X-MC-Unique: eY5EwwkHMjeEWZDBhmwR-g-1
Received: by mail-lf1-f69.google.com with SMTP id
 v12-20020ac2558c000000b0042c81cc06afso1655117lfg.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 00:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LWBo0rYwv79ih7UsVrWR7qP6jd2P85KgK6cQllUvYx4=;
 b=pEsgCH37hpWBpGnxuUwE3HNcWTRjL4ZeXTv4wINMVkuh7slfYxyskiAQxIFTLY/hy8
 N5D8H4k48NO9AOBJbS6uCSI79EIOx3z6TXMkK0oK06kjdIBSX5HPkMIvehc0uLaOI4Sg
 ESAQQ0XoHCv6hImEAXYsoZd9fu/Tu6N2kQnzcNKo34uxx/chXMWtx8oE+krhTkCo+5Ng
 a6NJ0bpQleS8IPvriHqXS4NUkjtdSQm9Cs1nifr8jQGfr6TYr9HlmAbeZsOnVYLMCKFl
 GEymgLga2v3t8NK8Ib8HZCHqqXRYijqY1hlELzbAsPygAE63y52Rh+9+/i+HSs05BqPt
 FXiw==
X-Gm-Message-State: AOAM531PfD6wPRW+yWlCq/45DMYg8/0Wo0FZFnxspH3PxscH8tLyVcSR
 YnU0FapigP8QsOWbM2e+K9KHjagL61cO5+DYgwAkpEYxtd6vp1g2O67h0DbQ5VXyBY1vW79TewV
 sgnPSAdHb8ZNgfmXu57VlWhLzPp1h/tfC8ALYyujQMgG5di2FV7+VgP1f6g==
X-Received: by 2002:a2e:9183:: with SMTP id f3mr58460178ljg.277.1641804910208; 
 Mon, 10 Jan 2022 00:55:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbsiwse2KIvE/UL20PRuI8ttWoOH+5qgNr8f75s9aOqBHKJ3J0Rfv4c0Vgb9hvRTcdT5K5ydJCYJdkwZlOaVI=
X-Received: by 2002:a2e:9183:: with SMTP id f3mr58460168ljg.277.1641804910012; 
 Mon, 10 Jan 2022 00:55:10 -0800 (PST)
MIME-Version: 1.0
References: <CACGkMEsV-GLLUmTnBHBUou_2+urkpaV4A54cD8wwoH-6eoer=w@mail.gmail.com>
 <1641801140.4307308-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1641801140.4307308-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Jan 2022 16:54:58 +0800
Message-ID: <CACGkMEu4MPe9DQbaphMrd3T16V9FF+Pu9uhpBue8-Pz9Q6Jk1A@mail.gmail.com>
Subject: Re: [PATCH 2/6] virtio: split: alloc indirect desc with extra
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMzo1OSBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgMTAgSmFuIDIwMjIgMTU6NDE6MjcgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gTW9uLCBK
YW4gMTAsIDIwMjIgYXQgMzoyNCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gTW9uLCAxMCBKYW4gMjAyMiAxNDo0MzozOSArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4g
PiDlnKggMjAyMi8xLzcg5LiL5Y2IMjozMywgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gPiA+IElu
IHRoZSBzY2VuYXJpbyB3aGVyZSBpbmRpcmVjdCBpcyBub3QgdXNlZCwgZWFjaCBkZXNjIGNvcnJl
c3BvbmRzIHRvIGFuCj4gPiA+ID4gPiBleHRyYSwgd2hpY2ggaXMgdXNlZCB0byByZWNvcmQgaW5m
b3JtYXRpb24gc3VjaCBhcyBkbWEsIGZsYWdzLCBhbmQKPiA+ID4gPiA+IG5leHQuCj4gPiA+ID4g
Pgo+ID4gPiA+ID4gSW4gdGhlIHNjZW5hcmlvIG9mIHVzaW5nIGluZGlyZWN0LCB0aGUgYXNzaWdu
ZWQgZGVzYyBkb2VzIG5vdCBoYXZlIHRoZQo+ID4gPiA+ID4gY29ycmVzcG9uZGluZyBleHRyYSBy
ZWNvcmQgZG1hIGluZm9ybWF0aW9uLCBhbmQgdGhlIGRtYSBpbmZvcm1hdGlvbiBtdXN0Cj4gPiA+
ID4gPiBiZSBvYnRhaW5lZCBmcm9tIHRoZSBkZXNjIHdoZW4gdW5tYXAuCj4gPiA+ID4gPgo+ID4g
PiA+ID4gVGhpcyBwYXRjaCBhbGxvY2F0ZXMgdGhlIGNvcnJlc3BvbmRpbmcgZXh0cmEgYXJyYXkg
d2hlbiBpbmRpcmVjdCBkZXNjIGlzCj4gPiA+ID4gPiBhbGxvY2F0ZWQuIFRoaXMgaGFzIHRoZXNl
IGFkdmFudGFnZXM6Cj4gPiA+ID4gPiAxLiBSZWNvcmQgdGhlIGRtYSBpbmZvcm1hdGlvbiBvZiBk
ZXNjLCBubyBuZWVkIHRvIHJlYWQgZGVzYyB3aGVuIHVubWFwCj4gPiA+ID4gPiAyLiBJdCB3aWxs
IGJlIG1vcmUgY29udmVuaWVudCBhbmQgdW5pZmllZCBpbiBwcm9jZXNzaW5nCj4gPiA+ID4gPiAz
LiBTb21lIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gY2FuIGJlIHJlY29yZGVkIGluIGV4dHJhLCB3
aGljaCB3aWxsIGJlCj4gPiA+ID4gPiAgICAgdXNlZCBpbiBzdWJzZXF1ZW50IHBhdGNoZXMuCj4g
PiA+ID4KPiA+ID4gPgo+ID4gPiA+IFR3byBxdWVzdGlvbnM6Cj4gPiA+ID4KPiA+ID4gPiAxKSBJ
cyB0aGVyZSBhbnkgcGVyZm9ybWFuY2UgbnVtYmVyIGZvciB0aGlzIGNoYW5nZT8gSSBndWVzcyBp
dCBnaXZlcwo+ID4gPiA+IG1vcmUgc3RyZXNzIG9uIHRoZSBjYWNoZS4KPiA+ID4KPiA+ID4gSSB3
aWxsIGFkZCBwZXJmb3JtYW5jZSB0ZXN0IGRhdGEgaW4gdGhlIG5leHQgdmVyc2lvbi4KPiA+ID4K
PiA+ID4gPiAyKSBJcyB0aGVyZSBhIHJlcXVpcmVtZW50IHRvIG1peCB0aGUgcHJlIG1hcHBlZCBz
ZyB3aXRoIHVubWFwcGVkIHNnPyBJZgo+ID4gPiA+IG5vdCwgYSBwZXIgdmlydHF1ZXVlIGZsYWcg
bG9va3Mgc3VmZmljaWVudAo+ID4gPgo+ID4gPiBUaGVyZSBpcyB0aGlzIHJlcXVpcmVtZW50LiBG
b3IgZXhhbXBsZSwgaW4gdGhlIGNhc2Ugb2YgQUZfWERQLCBhIHBhdGNrZXQKPiA+ID4gY29udGFp
bnMgdHdvIHBhcnRzLCBvbmUgaXMgdmlydGlvX25ldF9oZHIsIGFuZCB0aGUgb3RoZXIgaXMgdGhl
IGFjdHVhbCBkYXRhCj4gPiA+IHBhY2tldCBmcm9tIEFGX1hEUC4gVGhlIGZvcm1lciBpcyB1bm1h
cHBlZCBzZywgYW5kIHRoZSBsYXR0ZXIgaXMgcHJlIG1hcHBlZCBzZy4KPiA+Cj4gPiBBbnkgY2hh
bmNlIHRvIG1hcCB2aXJ0aW9fbmV0X2hkcigpIG1hbnVhbGx5IGJ5IEFGX1hEUCByb3V0aW5lIGlu
IHRoaXMgY2FzZT8KPgo+IFdlbGwsIGl0IGlzIGluZGVlZCBwb3NzaWJsZSB0byBkbyBzby4gSW4g
dGhlIGluZGlyZWN0IHNjZW5hcmlvLCB3ZSBjYW4gcmVjb3JkIGl0Cj4gaW4gdnJpbmctPnNwbGl0
LmRlc2NfZXh0cmFbaGVhZF0uZmxhZ3MKPgo+IFRoZW4gd2UgaGF2ZSB0byBhZ3JlZSB0aGF0IHRo
ZXJlIGNhbiBiZSBubyBtaXhlZCBzaXR1YXRpb24uCgpJIHRoaW5rIGl0IHdvdWxkIGJlIGVhc2ll
ciBhbmQgbGVzcyBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIGlmIHdlIGRvbid0CmRvIGh1Z2UgY2hh
bmdlcyBpbiB0aGUgY29yZSB1bmxlc3MgaXQncyBhIG11c3QuCgpCdHcsIEkgZm9yZ290IHRoZSBj
b25jbHVzaW9uIG9mIHRoZSBsYXN0IEFGX1hEUCBzZXJpZXMuIFdoeSBpcyBpdApiZXR0ZXIgdG8g
Y2hhbmdlIHZpcnRpb19yaW5nIGluc3RlYWQgb2YgQUZfWERQICh3aGljaCBzZWVtcyBlYXNpZXIp
LgoKVGhhbmtzCgo+Cj4gVGhhbmtzLgo+Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4gPgo+ID4gPiBU
aGFua3MuCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+
Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
