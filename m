Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1118C433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 02:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BD794061E;
	Wed, 23 Feb 2022 02:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZTuymQpCWPEo; Wed, 23 Feb 2022 02:58:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E60F40105;
	Wed, 23 Feb 2022 02:58:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17A8CC001A;
	Wed, 23 Feb 2022 02:58:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 427E4C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22DD6400FB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:58:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FtQpN5hb3n8y
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:58:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55ED9400F4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 02:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645585100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jht9UKbO0xqePI6To/SPYaSxIacMfgQHs+AwVRub3AU=;
 b=UUqPpKNPgUYwxmZrEh7ep2l8Fe6n5JsxHTD90jv44+BA6mF/FzET21Oa80mmMsamKkDsUu
 ewWCAm6koYxVp+zPllSpB9EGacELiiafAf9ZZN8AvJ5LlLI/RAENTHNEjvBD8JrRBNwXba
 s55nDcsgU77mwst7NetYtzLkuVoC9UM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-n-M45MNbOlCQTOHMTti13w-1; Tue, 22 Feb 2022 21:58:19 -0500
X-MC-Unique: n-M45MNbOlCQTOHMTti13w-1
Received: by mail-lj1-f198.google.com with SMTP id
 k33-20020a05651c062100b002460b0e948dso6750923lje.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 18:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Jht9UKbO0xqePI6To/SPYaSxIacMfgQHs+AwVRub3AU=;
 b=MHyG7oIDa7iTOhs3wBT+zYh2Z/ma8qE6L7bHnMGyT7CpqSQ8jMo4mZj3GhEnvXA1Hx
 UcGw72jj8y7vKDggNh1UtPPP+vxuLfir848foqJmfj7XYIsEhF07Bp68z4k6oLOBCCPx
 EVnOezoccrlGg8WqYsSvmJeaTpwdp+L6PAbeRPFhGQl5hax+mOu1O3vYiUFkAUeWUFrN
 eKETgGpPrQbFT4YuIgVQ0IH8tBJ0MRANj24oHtuirfdMV+HipCAnY2agsKcIv2OvfSFJ
 RppC5mQRBOpm3bvSgyYgAJNXZDRbki3OeXu3BIHaeGk2XFJegEybtIFjHjsfehOpacsM
 uEJw==
X-Gm-Message-State: AOAM532QbMiAp9bm7475IO4hLPB97UxvMDEaIiXlGhixlS+/y324YahA
 8chkYmo9xMJXPgoeum58iU30my/Ckx5rb4q9GNlcG5El/oiu1GDu5r9n21bVrvysm2N7Vp6fU+p
 Je0G+V+pymPUmJvwUs9YM1JqySZ6dt/ArNV2qHePx+Sb16seKRJKKB/F7Jg==
X-Received: by 2002:a05:651c:1787:b0:244:3308:eb71 with SMTP id
 bn7-20020a05651c178700b002443308eb71mr19490751ljb.492.1645585097572; 
 Tue, 22 Feb 2022 18:58:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziXyO65N2LWzvDZGWIAMItzdmaaTEL1mWMW2ZuPGjZWa5LBx/StsjjWVh+dNNqXHfXmvTVunjp/UDxOIbCoPs=
X-Received: by 2002:a05:651c:1787:b0:244:3308:eb71 with SMTP id
 bn7-20020a05651c178700b002443308eb71mr19490736ljb.492.1645585097309; Tue, 22
 Feb 2022 18:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
 <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-rhha5WFg+ef181RR5xZmyHkNyfDdcPA=HoDFZ_-Oxg@mail.gmail.com>
 <1645442604.5901623-1-xuanzhuo@linux.alibaba.com>
 <c98a4fd4-af0e-f97f-55a7-a8804eb1fb40@redhat.com>
 <1645516096.2526364-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1645516096.2526364-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Feb 2022 10:58:06 +0800
Message-ID: <CACGkMEvU-tVX5WznH_vm1P=LK_zNUqmB7Hz2HRG=bsA0ibp1kg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] virtio: support advance DMA
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBGZWIgMjIsIDIwMjIgYXQgNDowMCBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgMjIgRmViIDIwMjIgMTI6MDI6MTQgKzA4
MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IOWcqCAy
MDIyLzIvMjEg5LiL5Y2INzoyMywgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gT24gTW9uLCAyMSBG
ZWIgMjAyMiAxMTozMjo1MiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4gPiA+PiBPbiBGcmksIEZlYiAxOCwgMjAyMiBhdCA1OjAwIFBNIFh1YW4gWmh1byA8
eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPj4+IE9uIFRodSwgMTcgRmVi
IDIwMjIgMTU6MTk6NDQgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPj4+PiBPbiBUaHUsIEZlYiAxMCwgMjAyMiBhdCA0OjUxIFBNIFh1YW4gWmh1byA8
eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPj4+Pj4gdmlydHF1ZXVlX2Fk
ZCgpIG9ubHkgc3VwcG9ydHMgdmlydHVhbCBhZGRyZXNzZXMsIGRtYSBpcyBjb21wbGV0ZWQgaW4K
PiA+ID4+Pj4+IHZpcnRxdWV1ZV9hZGQoKS4KPiA+ID4+Pj4+Cj4gPiA+Pj4+PiBJbiBzb21lIHNj
ZW5hcmlvcyAoc3VjaCBhcyB0aGUgQUZfWERQIHNjZW5hcmlvKSwgRE1BIGlzIGNvbXBsZXRlZCBp
biBhZHZhbmNlLCBzbwo+ID4gPj4+Pj4gaXQgaXMgbmVjZXNzYXJ5IGZvciB1cyB0byBzdXBwb3J0
IHBhc3NpbmcgdGhlIERNQSBhZGRyZXNzIHRvIHZpcnRxdWV1ZV9hZGQoKS4KPiA+ID4+Pj4gSSdk
IHN1Z2dlc3QgcmVuYW1lIHRoaXMgZmVhdHVyZSBhcyAidW5tYW5hZ2VkIERNQSIuCj4gPiA+Pj4g
T0sKPiA+ID4+Pgo+ID4gPj4+Pj4gUmVjb3JkIHRoaXMgcHJlZG1hIGluZm9ybWF0aW9uIGluIGV4
dHJhLT5mbGFncywgd2hpY2ggY2FuIGJlIHNraXBwZWQgd2hlbgo+ID4gPj4+Pj4gZXhlY3V0aW5n
IGRtYSB1bm1hcC4KPiA+ID4+Pj4gUXVlc3Rpb24gc3RpbGwsIGNhbiB3ZSB1c2UgcGVyLXZpcnRx
dWV1ZSBmbGFnIGluc3RlYWQgb2YgcGVyCj4gPiA+Pj4+IGRlc2NyaXB0b3IgZmxhZz8gSWYgbXkg
bWVtb3J5IGlzIGNvcnJlY3QsIHRoZSBhbnN3ZXIgaXMgeWVzIGluIHRoZQo+ID4gPj4+PiBkaXNj
dXNzaW9uIGZvciB0aGUgcHJldmlvdXMgdmVyc2lvbi4KPiA+ID4+Pj4KPiA+ID4+PiBZZXMuCj4g
PiA+Pj4KPiA+ID4+PiBwZXItdmlydHF1ZXVlPyBJIGd1ZXNzIGl0IHNob3VsZCBiZSBwZXItc3Vi
bWl0Lgo+ID4gPj4+Cj4gPiA+Pj4gVGhpcyBwYXRjaCBzZXQgb25seSBhZGRzIGEgZmxhZyB0byBk
ZXNjX2V4dHJhW2hlYWRdLmZsYWdzLCBzbyB0aGF0IHdlIGNhbiBrbm93Cj4gPiA+Pj4gaWYgd2Ug
bmVlZCB0byB1bm1hcCBkbWEgd2hlbiB3ZSBkZXRhY2guCj4gPiA+PiBJIG1lYW50IGlmIHdlIGNh
biBtYW5hZ2UgdG8gbWFrZSBpdCBwZXIgdmlydHF1ZXVlLCB0aGVyZSdzIG5vIG5lZWQgdG8KPiA+
ID4+IG1haW50YWluIHBlciBidWZmZXIgZmxhZy4KPiA+ID4+Cj4gPiA+IFJldGhpbmtpbmcgdGhp
cyBxdWVzdGlvbiwgSSBmZWVsIHRoZXJlIGlzIG5vIGVzc2VudGlhbCBkaWZmZXJlbmNlIGJldHdl
ZW4gcGVyCj4gPiA+IHZpcnRxdWV1ZSBhbmQgcGVyIHNncy4KPiA+ID4KPiA+ID4gcGVyIHZpcnRx
dWV1ZToKPiA+ID4gICAgIDEuIGFkZCBidWY6Cj4gPiA+ICAgICAgICAgICAgIGEuIGNoZWNrIHZx
LT5wcmVtYXBwZWQgZm9yIG1hcCBldmVyeSBzZwo+ID4gPiAgICAgMi4gZGV0YWNoOgo+ID4gPiAg
ICAgICAgICAgICBhLiBjaGVjayB2cS0+cHJlbWFwZWQgZm9yIHVubWFwCj4gPiA+Cj4gPiA+IHBl
ciBzZ3M6Cj4gPiA+ICAgICAxLiBhZGQgYnVmOgo+ID4gPiAgICAgICAgICAgICBhLiBjaGVjayBm
dW5jdGlvbiBwYXJhbWV0ZXIgInByZW1hcHBlZCIgZm9yIG1hcCBldmVyeSBzZwo+ID4gPiAgICAg
ICAgICAgICBiLiBhZGQgZmxhZyB0byBleHRyYVtoZWFkXS5mbGFnCj4gPiA+Cj4gPiA+ICAgICAy
LiBkZXRhY2g6Cj4gPiA+ICAgICAgICAgICAgIGE6IGNoZWNrIGV4dHJhW2hlYWRdLmZsYWcgZm9y
IHVubWFwCj4gPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcy4KPiA+Cj4gPgo+ID4gUGVyLXZpcnRxdWV1
ZSBpcyBzdGlsbCBhIGxpdHRsZSBiaXQgZWFzaWVyIGF0IHRoZSBmaXJzdCBnbGFuY2UuCj4gPgo+
ID4gQWN0dWFsbHksIHBlci1zZyBoYXZlIG9uZSBhZHZhbnRhZ2U6IGl0IGNhbiBiZSB1c2VkIHdp
dGhvdXQgdmlydHF1ZXVlCj4gPiByZXNldCAodG8gYWxsb3cgc3dpdGNoaW5nIGJldHdlZW4gdGhl
IHR3byBtb2RlcykuIEJ1dCBJJ20gbm90IHN1cmUKPiA+IHdoZXRoZXIgd2UgaGFkIHN1Y2ggcmVx
dWlyZW1lbnRzLgo+ID4KPiA+IEkgdGhpbmsgdG8gYW5zd2VyIHRoaXMgcXVlc3Rpb24sIHdlIHBy
b2JhYmx5IG5lZWQgYSByZWFsIHVzZSBjYXNlIChpZiB3ZQo+ID4gY2FuIGNvbWUgdXAgd2l0aCBh
IGNhc2UgdGhhdCBpcyBtb3JlIGxpZ2h0d2VpZ2h0IHRoYW4gQUZfWERQLCB0aGF0IHdvdWxkCj4g
PiBiZSBldmVuIGJldHRlcikuCj4KPiBTYWRseSwgSSBkaWRuJ3QgdGhpbmsgb2Ygb3RoZXIgc2Nl
bmFyaW9zLiBIb3BlIHNvbWVvbmUgY2FuIGdpdmUgYSBzY2VuYXJpby4KPgo+IEZvciBwZXIgdmly
dHF1ZXVlLCB2aXJ0aW8tbmV0IHdpbGwgYWxzbyBzd2l0Y2ggdG8gcHJlbWFwcGVkLiBCZWNhdXNl
IHRoZSB0eAo+IHF1ZXVlIGlzIHNoYXJlZC4KPgo+IEJ1dCBpbiB0aGUgcHJvY2VzcyBvZiBpbXBs
ZW1lbnRpbmcgdGhpcywgSSBlbmNvdW50ZXJlZCBhIHRyb3VibGVzb21lIHByb2JsZW0uIFdlCj4g
bmVlZCB0byByZWNvcmQgdGhlIGRtYSBhZGRyZXNzIGluIHZpcnRuZXQuIEZvciB0eCwgc2luY2Ug
c2tiIGNvbnRhaW5zIG11bHRpcGxlCj4gZnJhZ3MsIHRoZXJlIHdpbGwgYmUgbWFueSBkbWEgYWRk
cmVzc2VzLiBXaGVuIHVubWFwIGluIHZpcnRuZXQgSXQgd2lsbCBiZSBtb3JlCj4gdHJvdWJsZXNv
bWUuIEJlY2F1c2Ugd2UgaGF2ZSB0byByZWdhaW4gdGhlc2UgZG1hIGFkZHJlc3Nlcy4KClJpZ2h0
LCBhY3R1YWxseSwgd2Ugc3RvcmUgdGhlIGRtYSBhZGRyZXNzIGluIGRlc2NfZXh0cmEsIGJ1dCBl
eHBvc2luZwppdCB0byB0aGUgZHJpdmVyIHNlZW1zIGxpa2UgYW4gb3ZlcmtpbGwuCgo+Cj4gSSB0
aGluayBvZiB0d28gd2F5czoKPgo+IDEuIExldCB2aXJ0aW8gcmV0dXJuIHRoZSBhZGRyIG9mIGVh
Y2ggZGVzYyB3aGVuIGRldGFjaGVkLgo+IDIuIEFsbG9jYXRlIGEgYmxvY2sgb2YgbWVtb3J5IGZv
ciBlYWNoIHNxL3JxIHRvIGhvbGQgdGhlIGRtYSBhZGRyZXNzLgo+Cj4gVGhhbmtzLgoKU28gaXQg
bG9va3MgdG8gbWUgaGF2aW5nIGEgcGVyIGJ1ZmZlciBmbGFnIHNlZW1zIG9rLiBMZXQgbWUgZ28g
dGhyb3VnaAp0aGlzIHNlcmllcy4KClRoYW5rcwoKPgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+Cj4g
PiA+Cj4gPiA+Cj4gPiA+PiBTbyB3ZSBrbm93IHNvbWV0aGluZyB0aGF0IG5lZWRzIHRvIGJlIG1h
cHBlZCBieSB2aXJ0aW8gY29yZSBpdHNlbGYsCj4gPiA+PiBlLmcgdGhlIGluZGlyZWN0IHBhZ2Uu
IE90aGVyIHRoYW4gdGhpcywgYWxsIHRoZSByZXN0IGNvdWxkIGJlCj4gPiA+PiBwcmUtbWFwcGVk
Lgo+ID4gPj4KPiA+ID4+IEZvciB2bmV0IGhlYWRlciwgaXQgY291bGQgYmUgbWFwcGVkIGJ5IHZp
cnRpby1uZXQgd2hpY2ggY291bGQgYmUgc3RpbGwKPiA+ID4+IHRyZWF0ZWQgYXMgcHJlIG1hcHBl
ZCBETUEgc2luY2UgaXQncyBub3QgdGhlIHZpcnRpbyByaW5nIGNvZGUuCj4gPiA+Pgo+ID4gPj4g
QW55dGhpbmcgSSBtaXNzIGhlcmU/Cj4gPiA+Pgo+ID4gPj4gVGhhbmtzCj4gPiA+Pgo+ID4gPj4K
PiA+ID4+PiBUaGFua3MuCj4gPiA+Pj4KPiA+ID4+Pj4gVGhhbmtzCj4gPiA+Pj4+Cj4gPiA+Pj4+
PiB2MToKPiA+ID4+Pj4+ICAgICAxLiBBbGwgc2dzIHJlcXVlc3RlZCBhdCBvbmUgdGltZSBhcmUg
cmVxdWlyZWQgdG8gYmUgdW5pZmllZCBQUkVETUEsIGFuZCBzZXZlcmFsCj4gPiA+Pj4+PiAgICAg
ICAgb2YgdGhlbSBhcmUgbm90IHN1cHBvcnRlZCB0byBiZSBQUkVETUEKPiA+ID4+Pj4+ICAgICAy
LiB2aXJ0aW9fZG1hX21hcCgpIGlzIHJlbW92ZWQgZnJvbSB0aGlzIHBhdGNoIHNldCBhbmQgd2ls
bCBiZSBzdWJtaXR0ZWQKPiA+ID4+Pj4+ICAgICAgICB0b2dldGhlciB3aXRoIHRoZSBuZXh0IHRp
bWUgQUZfWERQIHN1cHBvcnRzIHZpcnRpbyBkbWEKPiA+ID4+Pj4+ICAgICAzLiBBZGRlZCBwYXRj
aCAjMiAjMyB0byByZW1vdmUgdGhlIGNoZWNrIGZvciBmbGFncyB3aGVuIHBlcmZvcm1pbmcgdW5t
YXAKPiA+ID4+Pj4+ICAgICAgICBpbmRpcmVjdCBkZXNjCj4gPiA+Pj4+Pgo+ID4gPj4+Pj4gWHVh
biBaaHVvICg2KToKPiA+ID4+Pj4+ICAgIHZpcnRpbzogcmVuYW1lIHZyaW5nX3VubWFwX3N0YXRl
X3BhY2tlZCgpIHRvCj4gPiA+Pj4+PiAgICAgIHZyaW5nX3VubWFwX2V4dHJhX3BhY2tlZCgpCj4g
PiA+Pj4+PiAgICB2aXJ0aW86IHJlbW92ZSBmbGFncyBjaGVjayBmb3IgdW5tYXAgc3BsaXQgaW5k
aXJlY3QgZGVzYwo+ID4gPj4+Pj4gICAgdmlydGlvOiByZW1vdmUgZmxhZ3MgY2hlY2sgZm9yIHVu
bWFwIHBhY2tlZCBpbmRpcmVjdCBkZXNjCj4gPiA+Pj4+PiAgICB2aXJ0aW86IHZpcnRxdWV1ZV9h
ZGQoKSBzdXBwb3J0IHByZWRtYQo+ID4gPj4+Pj4gICAgdmlydGlvOiBzcGxpdDogdmlydHF1ZXVl
X2FkZF9zcGxpdCgpIHN1cHBvcnQgZG1hIGFkZHJlc3MKPiA+ID4+Pj4+ICAgIHZpcnRpbzogcGFj
a2VkOiB2aXJ0cXVldWVfYWRkX3BhY2tlZCgpIHN1cHBvcnQgZG1hIGFkZHJlc3MKPiA+ID4+Pj4+
Cj4gPiA+Pj4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxOTkgKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KPiA+ID4+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEy
NiBpbnNlcnRpb25zKCspLCA3MyBkZWxldGlvbnMoLSkKPiA+ID4+Pj4+Cj4gPiA+Pj4+PiAtLQo+
ID4gPj4+Pj4gMi4zMS4wCj4gPiA+Pj4+Pgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
