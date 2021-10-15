Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D482DC433F5
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 07:37:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AA261090
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 07:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72AA261090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3103A60780;
	Fri, 15 Oct 2021 07:37:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cGNAFLID6JH6; Fri, 15 Oct 2021 07:37:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C4E81606EF;
	Fri, 15 Oct 2021 07:37:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83FB7C0011;
	Fri, 15 Oct 2021 07:37:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7C0CC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 07:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A08640184
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 07:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gAKLnURQMNMh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 07:37:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 641A940012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 07:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634283434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKVYcpWNLfYlE4N/wYkX2U6vSmT4ml200IvOC1ImgZo=;
 b=LnaLBJE9aA6PT+JCjW9ZW2BsUXRXItBP+edE1WA1zCkB3NimTqCcopYkBRaHmzAnLmmK6I
 JO12obDL4O9/6FmnSEp37B6VBt9458JypZSqkEpDusvZVMsvjPeggyWToKPYWPJd6tBYL1
 BTLRKJvDo0LPudije+F02NvSPD2izYg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-ioWi7AntPOC40gxYkw3DOA-1; Fri, 15 Oct 2021 03:37:12 -0400
X-MC-Unique: ioWi7AntPOC40gxYkw3DOA-1
Received: by mail-lf1-f72.google.com with SMTP id
 g10-20020a05651222ca00b003fda3f05c17so6060955lfu.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 00:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aKVYcpWNLfYlE4N/wYkX2U6vSmT4ml200IvOC1ImgZo=;
 b=fnQxP5bw54CR6M80+PNOtWHdYZSaTNyo/sL1cGvs8NEUX0wLwPfOybm6QHN+6GNTR9
 g5E73PdAm/ZSUAebl6PgkKxYlJXV4jVJSjcuJ9V2eD0N44nIKkgP3elwvGCZlAwXKI6g
 ea2oSOkjOROsuWAW6X1cxgIBHp6ibhs2VP3ta4+zbxWMv5JxBznepTnSi9ot6aeyJ1LT
 QavyzN3TBTFloeDsVJuiqmcHXCjPRbLavl7XSxQlHVxiDXRYvkyhRdwB1ndcubdZZq6S
 6T7pxBvSssnf7rhDM0ohvUfI2LAxFa7eGedOJk6f3YBaJM2wtoFVESveUS3kEu60WHLu
 pkQQ==
X-Gm-Message-State: AOAM532MmODBXyYj9v8CP1hdJ14+bWm1PnC7uAcOpg3lmHqoiTfkQEjO
 BhLKdiGBu14oNlryK6zAv3wGsinBJm9nBDhdApQLYul0kOOPzepTNzElA4EtLq2CkA1OlrKLzxU
 ZRFHPK+QHM7yzfv4Rsp7pSdoyhH0hALN4WtvLN5tY3kNy21ckZz4eXGWRzw==
X-Received: by 2002:a2e:5c8:: with SMTP id 191mr11304295ljf.107.1634283431403; 
 Fri, 15 Oct 2021 00:37:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRr5OnjJzlB+o8annLgLZ1C5FahrRgyhxwHfEY8N/1HIClVxzwP6BAKZlwJmOWAWko0nqNLDz20imepHwXb6k=
X-Received: by 2002:a2e:5c8:: with SMTP id 191mr11304268ljf.107.1634283431195; 
 Fri, 15 Oct 2021 00:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211001070603.307037-1-eperezma@redhat.com>
 <20211001070603.307037-21-eperezma@redhat.com>
 <d5f837ec-7b89-2e47-fcfb-680ee808f6ad@redhat.com>
 <CAJaqyWdEGWFNrxqKxRya=ybRiP0wTZ0aPksBBeOe9KOjOmUnqA@mail.gmail.com>
In-Reply-To: <CAJaqyWdEGWFNrxqKxRya=ybRiP0wTZ0aPksBBeOe9KOjOmUnqA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Oct 2021 15:37:00 +0800
Message-ID: <CACGkMEuhseBMckdzeGf-bCtyXKEKNNyCaR0LEeELTXhKWxxmwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 20/20] vdpa: Add custom IOTLB translations to SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>
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

T24gRnJpLCBPY3QgMTUsIDIwMjEgYXQgMzoyOCBQTSBFdWdlbmlvIFBlcmV6IE1hcnRpbgo8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIE9jdCAxMywgMjAyMSBhdCA3OjM0
IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+Cj4gPiDl
nKggMjAyMS8xMC8xIOS4i+WNiDM6MDYsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPiA+ID4gVXNl
IHRyYW5zbGF0aW9ucyBhZGRlZCBpbiBWaG9zdElPVkFUcmVlIGluIFNWUS4KPiA+ID4KPiA+ID4g
Tm93IGV2ZXJ5IGVsZW1lbnQgbmVlZHMgdG8gc3RvcmUgdGhlIHByZXZpb3VzIGFkZHJlc3MgYWxz
bywgc28gVmlydFF1ZXVlCj4gPiA+IGNhbiBjb25zdW1lIHRoZSBlbGVtZW50cyBwcm9wZXJseS4g
VGhpcyBhZGRzIGEgbGl0dGxlIG92ZXJoZWFkIHBlciBWUQo+ID4gPiBlbGVtZW50LCBoYXZpbmcg
dG8gYWxsb2NhdGUgbW9yZSBtZW1vcnkgdG8gc3Rhc2ggdGhlbS4gQXMgYSBwb3NzaWJsZQo+ID4g
PiBvcHRpbWl6YXRpb24sIHRoaXMgYWxsb2NhdGlvbiBjb3VsZCBiZSBhdm9pZGVkIGlmIHRoZSBk
ZXNjcmlwdG9yIGlzIG5vdAo+ID4gPiBhIGNoYWluIGJ1dCBhIHNpbmdsZSBvbmUsIGJ1dCB0aGlz
IGlzIGxlZnQgdW5kb25lLgo+ID4gPgo+ID4gPiBUT0RPOiBpb3ZhIHJhbmdlIHNob3VsZCBiZSBx
dWVyaWVkIGJlZm9yZSwgYW5kIGFkZCBsb2dpYyB0byBmYWlsIHdoZW4KPiA+ID4gR1BBIGlzIG91
dHNpZGUgb2YgaXRzIHJhbmdlIGFuZCBtZW1vcnkgbGlzdGVuZXIgb3Igc3ZxIGFkZCBpdC4KPiA+
ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXo8ZXBlcmV6bWFAcmVkaGF0LmNv
bT4KPiA+ID4gLS0tCj4gPiA+ICAgaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaCB8
ICAgNCArLQo+ID4gPiAgIGh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMgfCAxMzAg
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KPiA+ID4gICBody92aXJ0aW8vdmhvc3QtdmRw
YS5jICAgICAgICAgICAgIHwgIDQwICsrKysrKysrLQo+ID4gPiAgIGh3L3ZpcnRpby90cmFjZS1l
dmVudHMgICAgICAgICAgICAgfCAgIDEgKwo+ID4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTUyIGlu
c2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQo+ID4KPiA+Cj4gPiBUaGluayBoYXJkIGFib3V0
IHRoZSB3aG9sZSBsb2dpYy4gVGhpcyBpcyBzYWZlIHNpbmNlIHFlbXUgbWVtb3J5IG1hcAo+ID4g
d2lsbCBmYWlsIGlmIGd1ZXN0IHN1Ym1pdHMgYSBpbnZhbGlkYXRlIElPVkEuCj4gPgo+Cj4gQ2Fu
IHlvdSBleHBhbmQgb24gdGhpcz8gV2hhdCB5b3UgbWVhbiBpcyB0aGF0IFZpcnRRdWV1ZSBhbHJl
YWR5Cj4gcHJvdGVjdHMgU1ZRIGNvZGUgaWYgdGhlIGd1ZXN0IHNldHMgYW4gaW52YWxpZCBidWZm
ZXIgYWRkcmVzcyAoR1BBKSwKPiBpc24ndCBpdD8KClllcy4KCj4KPiA+IFRoZW4gSSB3b25kZXIg
aWYgd2UgZG8gc29tZXRoaW5nIG11Y2ggbW9yZSBzaW1wbGVyOgo+ID4KPiA+IDEpIFVzaW5nIHFl
bXUgVkEgYXMgSU9WQSBidXQgb25seSBtYXBzIHRoZSBWQSB0aGF0IGJlbG9uZ3MgdG8gZ3Vlc3QK
PiA+IDIpIFRoZW4gd2UgZG9uJ3QgbmVlZCBhbnkgSU9WQSB0cmVlIGhlcmUsIHdoYXQgd2UgbmVl
ZCBpcyB0byBqdXN0IG1hcAo+ID4gdnJpbmcgYW5kIHVzZSBxZW11IFZBIHdpdGhvdXQgYW55IHRy
YW5zbGF0aW9uCj4gPgo+Cj4gVGhhdCB3b3VsZCBiZSBncmVhdCwgYnV0IGVpdGhlciBxZW11J3Mg
U1ZRIHZyaW5nIG9yIGd1ZXN0IHRyYW5zbGF0ZWQKPiBidWZmZXJzIGFkZHJlc3MgKGluIHFlbXUg
VkEgZm9ybSkgd2VyZSBhbHJlYWR5IGluIGhpZ2ggYWRkcmVzc2VzLAo+IG91dHNpZGUgb2YgdGhl
IGRldmljZSdzIGlvdmEgcmFuZ2UgKGluIG15IHRlc3QpLgoKWW91J3JlIHJpZ2h0LiBJIG1pc3Mg
dGhhdCBhbmQgdGhhdCdzIHdoeSB3ZSBuZWVkIGUuZyBpb3ZhIHRyZWUgYW5kIGFsbG9jYXRvci4K
CldoYXQgSSBwcm9wb3NlZCBvbmx5IG1ha2VzIHNlbnNlIHdoZW4gc2hhcmVkIHZpcnR1YWwgbWVt
b3J5IChTVkEpIGlzCmltcGxlbWVudGVkLiBJbiB0aGUgY2FzZSBvZiBTVkEsIHRoZSB2YWxpZCBp
b3ZhIHJhbmdlIHNob3VsZCBiZSB0aGUKZnVsbCBWQSByYW5nZS4KCj4KPiBJIGRpZG4ndCB0cnkg
cmVtYXBwaW5nIHRyaWNrcyB0byBtYWtlIHRoZW0gZml0IGluIHRoZSByYW5nZSwgYnV0IEkKPiB0
aGluayBpdCBkb2VzIGNvbXBsaWNhdGUgdGhlIHNvbHV0aW9uIHJlbGF0aXZlbHkgZmFzdCBpZiB0
aGVyZSB3YXMKPiBhbHJlYWR5IG1lbW9yeSBpbiB0aGF0IHJhbmdlIG93bmVkIGJ5IHFlbXUgYmVm
b3JlIGVuYWJsaW5nIFNWUToKPgo+ICogR3Vlc3QgbWVtb3J5IG11c3QgYmUgY29udGlndW91cyBp
biBWQSBhZGRyZXNzIHNwYWNlLCBidXQgaXQgIm11c3QiCj4gc3VwcG9ydCBob3RwbHVnL3VucGx1
ZyAoYWx0aG91Z2ggdkRQQSBjdXJyZW50bHkgcGlucyBpdCkuIEhvdHBsdWcKPiBtZW1vcnkgY291
bGQgYWx3YXlzIG92ZXJsYXAgd2l0aCBTVlEgdnJpbmcsIHNvIHdlIHdvdWxkIG5lZWQgdG8gbW92
ZQo+IGl0Lgo+ICogRHVwbGljYXRpbmcgbWFwcGVkIG1lbW9yeSBmb3Igd3JpdGluZz8gKE5vdCBz
dXJlIGlmIGd1ZXN0IG1lbW9yeSBpcwo+IGFjdHVhbGx5IG1vdmFibGUgaW4gcWVtdSkuCj4gKiBJ
bmRpcmVjdCBkZXNjcmlwdG9ycyB3aWxsIG5lZWQgdG8gYWxsb2NhdGUgYW5kIGZyZWUgbWVtb3J5
IG1vcmUgb3IKPiBsZXNzIGZyZXF1ZW50bHksIGluY3JlYXNpbmcgdGhlIHBvc3NpYmlsaXR5IG9m
IG92ZXJsYXBwaW5nLgoKSSdtIG5vdCBzdXJlIEkgZ2V0IHRoZSBwcm9ibGVtLCBidXQgb3Zlcmxh
cHBpbmcgaXMgbm90IGFuIGlzc3VlIHNpbmNlCndlJ3JlIHVzaW5nIFZBLgoKPgo+IElmIHdlIGNh
biBtb3ZlIGd1ZXN0IG1lbW9yeSwKCkknbSBub3Qgc3VyZSB3ZSBjYW4gZG8gdGhpcyBvciBpdCBs
b29rcyB2ZXJ5IHRyaWNreS4KCj4gaG93ZXZlciwgSSBjYW4gc2VlIGhvdyB3ZSBjYW4gdHJhY2sg
aXQgaW4KPiBhIHRyZWUgKmJ1dCogbWFyayB3aGVuIHRoZSB0cmVlIGlzIDE6MSB3aXRoIHFlbXUn
cyBWQSwgc28gYnVmZmVycwo+IGZvcndhcmRpbmcgZG9lcyBub3QgdGFrZSB0aGUgdHJhbnNsYXRp
b24gcGVuYWx0eS4gV2hlbiBndWVzdCBtZW1vcnkKPiBjYW5ub3QgYmUgbWFwIDE6MSwgd2UgY2Fu
IHJlc29ydCB0byB0cmVlLCBhbmQgY29tZSBiYWNrIHRvIDE6MQo+IHRyYW5zbGF0aW9uIGlmIHRo
ZSBvZmZlbmRpbmcgdHJlZSBub2RlKHMpIGdldCBkZWxldGVkLgo+Cj4gSG93ZXZlciBJIHRoaW5r
IHRoaXMgcHV0cyB0aGUgc29sdXRpb24gYSBsaXR0bGUgYml0IGZhcnRoZXIgdGhhbgo+ICJzdGFy
dGluZyBzaW1wbGUiIDopLgo+Cj4gRG9lcyBpdCBtYWtlIHNlbnNlPwoKWWVzLiBTbyBJIHRoaW5r
IEkgd2lsbCByZXZpZXcgdGhlIElPVkEgdHJlZSBjb2RlcyBhbmQgZ2V0IGJhY2sgdG8geW91LgoK
VEhhbmtzCgo+Cj4gVGhhbmtzIQo+Cj4gPiBUaGFua3MKPiA+Cj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
