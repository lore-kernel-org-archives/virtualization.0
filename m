Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952BAC433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 07:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4362E40242;
	Mon, 21 Feb 2022 07:15:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zcilCwcHKss3; Mon, 21 Feb 2022 07:15:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1AECB404F0;
	Mon, 21 Feb 2022 07:15:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF7EEC0033;
	Mon, 21 Feb 2022 07:15:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 157BAC001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0161404D7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:15:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uxCJRPryInuf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:15:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3260140242
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645427719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jrN8XsW/BOgueqLR4Y6t/TA6fNns23B14ddLmdsBcG0=;
 b=RsHoMm9Z06XHCfOaugtYdKqR8Uc4FEoTzdScJh0YyrQMLAPOXX7g38bcjq/3XnxKM9+NUq
 D84YLvEO43yDbt6Ec2NQrRzyDWnpC+SuaE+BgYfMK24kS+8nJ8o2maY3PH0ItjcyO2ysS5
 0tvwCzQBgsmpX6UadLWqjBuQrL9oSWo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-9l4wXcU0MO2zOa9PNxHS4g-1; Mon, 21 Feb 2022 02:15:17 -0500
X-MC-Unique: 9l4wXcU0MO2zOa9PNxHS4g-1
Received: by mail-pg1-f200.google.com with SMTP id
 b9-20020a63e709000000b00362f44b02aeso9017189pgi.17
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 23:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jrN8XsW/BOgueqLR4Y6t/TA6fNns23B14ddLmdsBcG0=;
 b=n0wbAA48i4ba0/6yZ1VQ1v/N2VIM/MUj4dU539gAXAWKP897C3MR8rNCrwFUSThBqY
 UU/dimyQoYlSdw9ZErNFln4gQibDZqew4hWEn4rArJ/oAA+NZGyJ+ly0NuBDoQGBSKTA
 hxVGQqF4Va15Pen7PgmlWu3dDogwXu+mWMJ8fqHI4dS+A8PJXSqYP4oHpxbjzxvMe/ce
 sX4s7n16l4pkCeY/Vv7RVHuEPBi49jk8jENnTNd6ibrWl6Q1FlN3t8+GaAjgqFIRAinp
 COokKfiUiNd4t7W7HbeUuE2LUV2aywMUNqHfrETIsWmQA6JqFOQvoockjhYdS996EfaN
 EsGA==
X-Gm-Message-State: AOAM531xG+kIex2Od9H+HTqEe1TcrAiPkB8hgvnN0UCni7fWjTNvSXdk
 8mZzYO0FRQLgOHxGAPWpSXuirU+MgHavjKDkl1p7Ii13OuD21zQI18Ok1nvoJSDOu7gFwSVPzPT
 mi1nEv0I6ce4d8qMErFzFJdoPV+lyJpP2yH2OaxI83w==
X-Received: by 2002:a17:902:d642:b0:14c:e9a7:d542 with SMTP id
 y2-20020a170902d64200b0014ce9a7d542mr17838066plh.38.1645427716012; 
 Sun, 20 Feb 2022 23:15:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXEdYXXygo2Bn/aG8AOxUtXK0uqh288rJiPaDSm5yyd3B2kkBgqHyxfMkmGU8ykvmhchguIg==
X-Received: by 2002:a17:902:d642:b0:14c:e9a7:d542 with SMTP id
 y2-20020a170902d64200b0014ce9a7d542mr17838032plh.38.1645427715684; 
 Sun, 20 Feb 2022 23:15:15 -0800 (PST)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i22sm959549pjz.3.2022.02.20.23.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Feb 2022 23:15:15 -0800 (PST)
Message-ID: <02f29b62-6656-ba2f-1475-251b16e0e978@redhat.com>
Date: Mon, 21 Feb 2022 15:15:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH 17/31] vdpa: adapt vhost_ops callbacks to svq
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-18-eperezma@redhat.com>
 <82b8c3bf-1b11-86c7-4fad-294f5ccf1278@redhat.com>
 <CAJaqyWdRKZp6CwnE+HAr0JALhSRh-trJbZ01kddnLTuRX_tMKQ@mail.gmail.com>
 <3d0dfaaa-a67c-6f48-fd03-45d2661ba92a@redhat.com>
 <CAJaqyWfEEg2PKgxBAFwYhF9LD1oDtwVYXSjHHnCbstT3dvL2GA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWfEEg2PKgxBAFwYhF9LD1oDtwVYXSjHHnCbstT3dvL2GA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzIvMTgg5LiK5Y2IMToxMywgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
IE9uIFR1ZSwgRmViIDgsIDIwMjIgYXQgNDo1OCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjIvMi8xIOS4iuWNiDI6NTgsIEV1Z2VuaW8gUGVy
ZXogTWFydGluIOWGmemBkzoKPj4+IE9uIFN1biwgSmFuIDMwLCAyMDIyIGF0IDU6MDMgQU0gSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4g5ZyoIDIwMjIvMS8yMiDk
uIrljYg0OjI3LCBFdWdlbmlvIFDDqXJleiDlhpnpgZM6Cj4+Pj4+IEZpcnN0IGhhbGYgb2YgdGhl
IGJ1ZmZlcnMgZm9yd2FyZGluZyBwYXJ0LCBwcmVwYXJpbmcgdmhvc3QtdmRwYQo+Pj4+PiBjYWxs
YmFja3MgdG8gU1ZRIHRvIG9mZmVyIGl0LiBRRU1VIGNhbm5vdCBlbmFibGUgaXQgYXQgdGhpcyBt
b21lbnQsIHNvCj4+Pj4+IHRoaXMgaXMgZWZmZWN0aXZlbHkgZGVhZCBjb2RlIGF0IHRoZSBtb21l
bnQsIGJ1dCBpdCBoZWxwcyB0byByZWR1Y2UKPj4+Pj4gcGF0Y2ggc2l6ZS4KPj4+Pj4KPj4+Pj4g
U2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4+Pj4+
IC0tLQo+Pj4+PiAgICAgaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaCB8ICAgMiAr
LQo+Pj4+PiAgICAgaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyB8ICAyMSArKysr
LQo+Pj4+PiAgICAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyAgICAgICAgICAgICB8IDEzMyArKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLQo+Pj4+PiAgICAgMyBmaWxlcyBjaGFuZ2VkLCAxNDMg
aW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9o
dy92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRv
dy12aXJ0cXVldWUuaAo+Pj4+PiBpbmRleCAwMzUyMDdhNDY5Li4zOWFlZjVmZmRmIDEwMDY0NAo+
Pj4+PiAtLS0gYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oCj4+Pj4+ICsrKyBi
L2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmgKPj4+Pj4gQEAgLTM1LDcgKzM1LDcg
QEAgc2l6ZV90IHZob3N0X3N2cV9kZXZpY2VfYXJlYV9zaXplKGNvbnN0IFZob3N0U2hhZG93Vmly
dHF1ZXVlICpzdnEpOwo+Pj4+Pgo+Pj4+PiAgICAgdm9pZCB2aG9zdF9zdnFfc3RvcChWaG9zdFNo
YWRvd1ZpcnRxdWV1ZSAqc3ZxKTsKPj4+Pj4KPj4+Pj4gLVZob3N0U2hhZG93VmlydHF1ZXVlICp2
aG9zdF9zdnFfbmV3KHZvaWQpOwo+Pj4+PiArVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnZob3N0X3N2
cV9uZXcodWludDE2X3QgcXNpemUpOwo+Pj4+Pgo+Pj4+PiAgICAgdm9pZCB2aG9zdF9zdnFfZnJl
ZShWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdnEpOwo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvaHcv
dmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ct
dmlydHF1ZXVlLmMKPj4+Pj4gaW5kZXggZjEyOWVjODM5NS4uN2MxNjgwNzVkNyAxMDA2NDQKPj4+
Pj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+Pj4+PiArKysgYi9o
dy92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5jCj4+Pj4+IEBAIC0yNzcsOSArMjc3LDE3
IEBAIHZvaWQgdmhvc3Rfc3ZxX3N0b3AoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSkKPj4+Pj4g
ICAgIC8qKgo+Pj4+PiAgICAgICogQ3JlYXRlcyB2aG9zdCBzaGFkb3cgdmlydHF1ZXVlLCBhbmQg
aW5zdHJ1Y3Qgdmhvc3QgZGV2aWNlIHRvIHVzZSB0aGUgc2hhZG93Cj4+Pj4+ICAgICAgKiBtZXRo
b2RzIGFuZCBmaWxlIGRlc2NyaXB0b3JzLgo+Pj4+PiArICoKPj4+Pj4gKyAqIEBxc2l6ZSBTaGFk
b3cgVmlydFF1ZXVlIHNpemUKPj4+Pj4gKyAqCj4+Pj4+ICsgKiBSZXR1cm5zIHRoZSBuZXcgdmly
dHF1ZXVlIG9yIE5VTEwuCj4+Pj4+ICsgKgo+Pj4+PiArICogSW4gY2FzZSBvZiBlcnJvciwgcmVh
c29uIGlzIHJlcG9ydGVkIHRocm91Z2ggZXJyb3JfcmVwb3J0Lgo+Pj4+PiAgICAgICovCj4+Pj4+
IC1WaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdmhvc3Rfc3ZxX25ldyh2b2lkKQo+Pj4+PiArVmhvc3RT
aGFkb3dWaXJ0cXVldWUgKnZob3N0X3N2cV9uZXcodWludDE2X3QgcXNpemUpCj4+Pj4+ICAgICB7
Cj4+Pj4+ICsgICAgc2l6ZV90IGRlc2Nfc2l6ZSA9IHNpemVvZih2cmluZ19kZXNjX3QpICogcXNp
emU7Cj4+Pj4+ICsgICAgc2l6ZV90IGRldmljZV9zaXplLCBkcml2ZXJfc2l6ZTsKPj4+Pj4gICAg
ICAgICBnX2F1dG9mcmVlIFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEgPSBnX25ldzAoVmhvc3RT
aGFkb3dWaXJ0cXVldWUsIDEpOwo+Pj4+PiAgICAgICAgIGludCByOwo+Pj4+Pgo+Pj4+PiBAQCAt
MzAwLDYgKzMwOCwxNSBAQCBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdmhvc3Rfc3ZxX25ldyh2b2lk
KQo+Pj4+PiAgICAgICAgIC8qIFBsYWNlaG9sZGVyIGRlc2NyaXB0b3IsIGl0IHNob3VsZCBiZSBk
ZWxldGVkIGF0IHNldF9raWNrX2ZkICovCj4+Pj4+ICAgICAgICAgZXZlbnRfbm90aWZpZXJfaW5p
dF9mZCgmc3ZxLT5zdnFfa2ljaywgSU5WQUxJRF9TVlFfS0lDS19GRCk7Cj4+Pj4+Cj4+Pj4+ICsg
ICAgc3ZxLT52cmluZy5udW0gPSBxc2l6ZTsKPj4+PiBJIHdvbmRlciBpZiB0aGlzIGlzIHRoZSBi
ZXN0LiBFLmcgc29tZSBoYXJkd2FyZSBjYW4gc3VwcG9ydCB1cCB0byAzMksKPj4+PiBxdWV1ZSBz
aXplLiBTbyB0aGlzIHdpbGwgcHJvYmFibHkgZW5kIHVwIHdpdGg6Cj4+Pj4KPj4+PiAxKSBTVlEg
dXNlIDMySyBxdWV1ZSBzaXplCj4+Pj4gMikgaGFyZHdhcmUgcXVldWUgdXNlcyAyNTYKPj4+Pgo+
Pj4gSW4gdGhhdCBjYXNlIFNWUSB2cmluZyBxdWV1ZSBzaXplIHdpbGwgYmUgMzJLIGFuZCBndWVz
dCdzIHZyaW5nIGNhbgo+Pj4gbmVnb3RpYXRlIGFueSBudW1iZXIgd2l0aCBTVlEgZXF1YWwgb3Ig
bGVzcyB0aGFuIDMySywKPj4KPj4gU29ycnkgZm9yIGJlaW5nIHVuY2xlYXIgd2hhdCBJIG1lYW50
IGlzIGFjdHVhbGx5Cj4+Cj4+IDEpIFNWUSB1c2VzIDMySyBxdWV1ZSBzaXplCj4+Cj4+IDIpIGd1
ZXN0IHZxIHVzZXMgMjU2Cj4+Cj4+IFRoaXMgbG9va3MgbGlrZSBhIGJ1cmRlbiB0aGF0IG5lZWRz
IGV4dHJhIGxvZ2ljIGFuZCBtYXkgZGFtYWdlIHRoZQo+PiBwZXJmb3JtYW5jZS4KPj4KPiBTdGls
bCBub3QgZ2V0dGluZyB0aGlzIHBvaW50Lgo+Cj4gQW4gYXZhaWxhYmxlIGd1ZXN0IGJ1ZmZlciwg
YWx0aG91Z2ggY29udGlndW91cyBpbiBHUEEvR1ZBLCBjYW4gZXhwYW5kCj4gaW4gbXVsdGlwbGUg
YnVmZmVycyBpZiBpdCdzIG5vdCBjb250aWd1b3VzIGluIHFlbXUncyBWQSAoYnkgdGhlIHdoaWxl
Cj4gbG9vcCBpbiB2aXJ0cXVldWVfbWFwX2Rlc2MgWzFdKS4gSW4gdGhhdCBzY2VuYXJpbyBpdCBp
cyBiZXR0ZXIgdG8gaGF2ZQo+ICJwbGVudHkiIG9mIFNWUSBidWZmZXJzLgoKClllcywgYnV0IHRo
aXMgY2FzZSBzaG91bGQgYmUgcmFyZS4gU28gaW4gdGhpcyBjYXNlIHdlIHNob3VsZCBkZWFsIHdp
dGggCm92ZXJydW4gb24gU1ZRLCB0aGF0IGlzCgoxKSBTVlEgaXMgZnVsbAoyKSBndWVzdCBWUSBp
c24ndAoKV2UgbmVlZCB0bwoKMSkgY2hlY2sgdGhlIGF2YWlsYWJsZSBidWZmZXIgc2xvdHMKMikg
ZGlzYWJsZSBndWVzdCBraWNrIGFuZCB3YWl0IGZvciB0aGUgdXNlZCBidWZmZXJzCgpCdXQgaXQg
bG9va3MgdG8gbWUgdGhlIGN1cnJlbnQgY29kZSBpcyBub3QgcmVhZHkgZm9yIGRlYWxpbmcgd2l0
aCB0aGlzIGNhc2U/CgoKPgo+IEknbSBvayBpZiB3ZSBkZWNpZGUgdG8gcHV0IGFuIHVwcGVyIGxp
bWl0IHRob3VnaCwgb3IgaWYgd2UgZGVjaWRlIG5vdAo+IHRvIGhhbmRsZSB0aGlzIHNpdHVhdGlv
bi4gQnV0IHdlIHdvdWxkIGxlYXZlIG91dCB2YWxpZCB2aXJ0aW8gZHJpdmVycy4KPiBNYXliZSB0
byBzZXQgYSBmaXhlZCB1cHBlciBsaW1pdCAoMTAyND8pPyBUbyBhZGQgYW5vdGhlciBwYXJhbWV0
ZXIKPiAoeC1zdnEtc2l6ZS1uPU4pPwo+Cj4gSWYgeW91IG1lYW4gd2UgbG9zZSBwZXJmb3JtYW5j
ZSBiZWNhdXNlIG1lbW9yeSBnZXRzIG1vcmUgc3BhcnNlIEkKPiB0aGluayB0aGUgb25seSBwb3Nz
aWJpbGl0eSBpcyB0byBsaW1pdCB0aGF0IHdheS4KCgpJZiBndWVzdCBpcyBub3QgdXNpbmcgMzJL
LCBoYXZpbmcgYSAzMksgZm9yIHN2cSBtYXkgZ2l2ZXMgZXh0cmEgc3RyZXNzIApvbiB0aGUgY2Fj
aGUgc2luY2Ugd2Ugd2lsbCBlbmQgdXAgd2l0aCBhIHByZXR0eSBsYXJnZSB3b3JraW5nIHNldC4K
Cgo+Cj4+IEFuZCB0aGlzIGNhbiBsZWFkIG90aGVyIGludGVyZXN0aW5nIHNpdHVhdGlvbjoKPj4K
Pj4gMSkgU1ZRIHVzZXMgMjU2Cj4+Cj4+IDIpIGd1ZXN0IHZxIHVzZXMgMTAyNAo+Pgo+PiBXaGVy
ZSBhIGxvdCBvZiBtb3JlIFNWUSBsb2dpYyBpcyBuZWVkZWQuCj4+Cj4gSWYgd2UgYWdyZWUgdGhh
dCBhIGd1ZXN0IGRlc2NyaXB0b3IgY2FuIGV4cGFuZCBpbiBtdWx0aXBsZSBTVlEKPiBkZXNjcmlw
dG9ycywgdGhpcyBzaG91bGQgYmUgYWxyZWFkeSBoYW5kbGVkIGJ5IHRoZSBwcmV2aW91cyBsb2dp
YyB0b28uCj4KPiBCdXQgdGhpcyBzaG91bGQgb25seSBoYXBwZW4gaW4gY2FzZSB0aGF0IHFlbXUg
aXMgbGF1bmNoZWQgd2l0aCBhICJiYWQiCj4gY21kbGluZSwgaXNuJ3QgaXQ/CgoKVGhpcyBzZWVt
cyBjYW4gaGFwcGVuIHdoZW4gd2UgdXNlIC1kZXZpY2UgCnZpcnRpby1uZXQtcGNpLHR4X3F1ZXVl
X3NpemU9MTAyNCB3aXRoIGEgMjU2IHNpemUgdnBfdmRwYSBkZXZpY2UgYXQgbGVhc3Q/CgoKPgo+
IElmIEkgcnVuIHRoYXQgZXhhbXBsZSB3aXRoIHZwX3ZkcGEsIEwwIHFlbXUgd2lsbCBoYXBwaWx5
IGFjY2VwdCAxMDI0Cj4gYXMgYSBxdWV1ZSBzaXplIFsyXS4gQnV0IGlmIHRoZSB2ZHBhIGRldmlj
ZSBtYXhpbXVtIHF1ZXVlIHNpemUgaXMKPiBlZmZlY3RpdmVseSAyNTYsIHRoaXMgd2lsbCByZXN1
bHQgaW4gYW4gZXJyb3I6IFdlJ3JlIG5vdCBleHBvc2luZyBpdAo+IHRvIHRoZSBndWVzdCBhdCBh
bnkgbW9tZW50IGJ1dCB3aXRoIHFlbXUncyBjbWRsaW5lLgo+Cj4+PiBpbmNsdWRpbmcgMjU2Lgo+
Pj4gSXMgdGhhdCB3aGF0IHlvdSBtZWFuPwo+Pgo+PiBJIG1lYW4sIGl0IGxvb2tzIHRvIG1lIHRo
ZSBsb2dpYyB3aWxsIGJlIG11Y2ggbW9yZSBzaW1wbGlmaWVkIGlmIHdlIGp1c3QKPj4gYWxsb2Nh
dGUgdGhlIHNoYWRvdyB2aXJ0cXVldWUgd2l0aCB0aGUgc2l6ZSB3aGF0IGd1ZXN0IGNhbiBzZWUg
KGd1ZXN0Cj4+IHZyaW5nKS4KPj4KPj4gVGhlbiB3ZSBkb24ndCBuZWVkIHRvIHRoaW5rIGlmIHRo
ZSBkaWZmZXJlbmNlIG9mIHRoZSBxdWV1ZSBzaXplIGNhbiBoYXZlCj4+IGFueSBzaWRlIGVmZmVj
dHMuCj4+Cj4gSSB0aGluayB0aGF0IHdlIGNhbm5vdCBhdm9pZCB0aGF0IGV4dHJhIGxvZ2ljIHVu
bGVzcyB3ZSBmb3JjZSBHUEEgdG8KPiBiZSBjb250aWd1b3VzIGluIElPVkEuIElmIHdlIGFyZSBz
dXJlIHRoZSBndWVzdCdzIGJ1ZmZlcnMgY2Fubm90IGJlIGF0Cj4gbW9yZSB0aGFuIG9uZSBkZXNj
cmlwdG9yIGluIFNWUSwgdGhlbiB5ZXMsIHdlIGNhbiBzaW1wbGlmeSB0aGluZ3MuIElmCj4gbm90
LCBJIHRoaW5rIHdlIGFyZSBmb3JjZWQgdG8gY2FycnkgYWxsIG9mIGl0LgoKClllcywgSSBhZ3Jl
ZSwgdGhlIGNvZGUgc2hvdWxkIGJlIHJvYnVzdCB0byBoYW5kbGUgYW55IGNhc2UuCgpUaGFua3MK
Cgo+Cj4gQnV0IGlmIHdlIHByb3ZlIGl0IEknbSBub3Qgb3Bwb3NlZCB0byBzaW1wbGlmeWluZyB0
aGluZ3MgYW5kIG1ha2luZwo+IGhlYWQgYXQgU1ZRID09IGhlYWQgYXQgZ3Vlc3QuCj4KPiBUaGFu
a3MhCj4KPiBbMV0gaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vYmxvYi8x
N2UzMTM0MC9ody92aXJ0aW8vdmlydGlvLmMjTDEyOTcKPiBbMl0gQnV0IHRoYXQncyBub3QgdGhl
IHdob2xlIHN0b3J5OiBJJ3ZlIGJlZW4gcnVubmluZyBsaW1pdGVkIGluIHR4Cj4gZGVzY3JpcHRv
cnMgYmVjYXVzZSBvZiB2aXJ0aW9fbmV0X21heF90eF9xdWV1ZV9zaXplLCB3aGljaCBwcmVkYXRl
cwo+IHZkcGEuIEknbGwgc2VuZCBhIHBhdGNoIHRvIGFsc28gdW4tbGltaXQgaXQuCj4KPj4+IElm
IHdpdGggaGFyZHdhcmUgcXVldWVzIHlvdSBtZWFuIGd1ZXN0J3MgdnJpbmcsIG5vdCBzdXJlIHdo
eSBpdCBpcwo+Pj4gInByb2JhYmx5IDI1NiIuIEknZCBzYXkgdGhhdCBpbiB0aGF0IGNhc2Ugd2l0
aCB0aGUgdmlydGlvLW5ldCBrZXJuZWwKPj4+IGRyaXZlciB0aGUgcmluZyBzaXplIHdpbGwgYmUg
dGhlIHNhbWUgYXMgdGhlIGRldmljZSBleHBvcnQsIGZvcgo+Pj4gZXhhbXBsZSwgaXNuJ3QgaXQ/
Cj4+Pgo+Pj4gVGhlIGltcGxlbWVudGF0aW9uIHNob3VsZCBzdXBwb3J0IGFueSBjb21iaW5hdGlv
biBvZiBzaXplcywgYnV0IHRoZQo+Pj4gcmluZyBzaXplIGV4cG9zZWQgdG8gdGhlIGd1ZXN0IGlz
IG5ldmVyIGJpZ2dlciB0aGFuIGhhcmR3YXJlIG9uZS4KPj4+Cj4+Pj4gPyBPciB3ZSBTVlEgY2Fu
IHN0aWNrIHRvIDI1NiBidXQgdGhpcyB3aWxsIHRoaXMgY2F1c2UgdHJvdWJsZSBpZiB3ZSB3YW50
Cj4+Pj4gdG8gYWRkIGV2ZW50IGluZGV4IHN1cHBvcnQ/Cj4+Pj4KPj4+IEkgdGhpbmsgd2Ugc2hv
dWxkIG5vdCBoYXZlIGFueSBwcm9ibGVtIHdpdGggZXZlbnQgaWR4LiBJZiB5b3UgbWVhbgo+Pj4g
dGhhdCB0aGUgZ3Vlc3QgY291bGQgbWFyayBtb3JlIGJ1ZmZlcnMgYXZhaWxhYmxlIHRoYW4gU1ZR
IHZyaW5nJ3MKPj4+IHNpemUsIHRoYXQgc2hvdWxkIG5vdCBoYXBwZW4gYmVjYXVzZSB0aGVyZSBt
dXN0IGJlIGxlc3MgZW50cmllcyBpbiB0aGUKPj4+IGd1ZXN0IHRoYW4gU1ZRLgo+Pj4KPj4+IEJ1
dCBpZiBJIHVuZGVyc3Rvb2QgeW91IGNvcnJlY3RseSwgYSBzaW1pbGFyIHNpdHVhdGlvbiBjb3Vs
ZCBoYXBwZW4gaWYKPj4+IGEgZ3Vlc3QncyBjb250aWd1b3VzIGJ1ZmZlciBpcyBzY2F0dGVyZWQg
YWNyb3NzIG1hbnkgcWVtdSdzIFZBIGNodW5rcy4KPj4+IEV2ZW4gaWYgdGhhdCB3b3VsZCBoYXBw
ZW4sIHRoZSBzaXR1YXRpb24gc2hvdWxkIGJlIG9rIHRvbzogU1ZRIGtub3dzCj4+PiB0aGUgZ3Vl
c3QncyBhdmFpbCBpZHggYW5kLCBpZiBTVlEgaXMgZnVsbCwgaXQgd2lsbCBjb250aW51ZSBmb3J3
YXJkaW5nCj4+PiBhdmFpbCBidWZmZXJzIHdoZW4gdGhlIGRldmljZSB1c2VzIG1vcmUgYnVmZmVy
cy4KPj4+Cj4+PiBEb2VzIHRoYXQgbWFrZSBzZW5zZSB0byB5b3U/Cj4+Cj4+IFllcy4KPj4KPj4g
VGhhbmtzCj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
