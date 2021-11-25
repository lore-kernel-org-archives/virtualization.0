Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713D5C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 21:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07AED408F5;
	Thu, 25 Nov 2021 21:23:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yD1dWSeWo-Ll; Thu, 25 Nov 2021 21:23:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9AAF440418;
	Thu, 25 Nov 2021 21:23:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70A88C0012;
	Thu, 25 Nov 2021 21:23:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EF8FC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 21:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6737360764
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 21:23:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l0SwnnoRNMfU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 21:23:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 35FA660633
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 21:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637875399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pimlV2lH4TvXP6k8O9RhFaNOCPNxxUOqrc3BdluZm0g=;
 b=ISOL8fWgEnQMv3do/Gjor2buD8wRXbnngusFtHkhrCqOVtUlkc1fXkXCj4AoX4Y6JdDD7t
 Mhk60Y+/s0zhYfF1yaoG7KDODsLRo41FrvQOPbPF2hxs1G2dWNqFy6BX3T8LIHGqJ6HpQ3
 oaVlCz4EPZWi3vr8UN5z3DKbmMdb/fw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-KG51z5ZtOWOUSvxYQA4odQ-1; Thu, 25 Nov 2021 16:23:18 -0500
X-MC-Unique: KG51z5ZtOWOUSvxYQA4odQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 m17-20020aa7d351000000b003e7c0bc8523so6308394edr.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 13:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pimlV2lH4TvXP6k8O9RhFaNOCPNxxUOqrc3BdluZm0g=;
 b=NQId+RTHrWsFK3ShZ3YsVyJzrM0KjXdXDjfa5W2JA8o3LexRZsnrrpwJFLGNR4m8bd
 Yg2w82z50UgtPonfwfISsjGE057gqd0nL6gq8mGmUxDO/H/tGUu++EOp/EswJ9bxE09e
 qvweoJfq9799f/ZbMyarR1j0jIsh2TWqwV2wGkQW+BZy7R9BOAoQpzIx3p6wkJQ6wMNH
 aW+KmiEZ5YHxXKtofUBnFPVwvzJoLUQ7Z+so6lKiJ2BMe3IcTS/32UwMQoujDKfqsgC0
 6Z6K6JHPnQaHaE4nB2HEXDzWx+qYck78p/Bt47XKWOuTsKN5JLh90xwcy6jT9n3Syxl2
 6VJA==
X-Gm-Message-State: AOAM532F2TXX8pHtBpBbXHQR+ZjARmJtxUFJHR9TMo0EomXcWDc+NNTK
 NoLZctNMayOQmPR2GvN3gipwlpr1fyZU7pfoOS4ZqGB4ij7Zi0nn3Q8kVdQ2KSgbGDh5P4XfIbf
 fzZ+Uuuo/bXxDtkyAoztY4+2YMrmMmkY1NJTfjO7BGA==
X-Received: by 2002:a05:6402:185:: with SMTP id
 r5mr41305561edv.259.1637875397444; 
 Thu, 25 Nov 2021 13:23:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRnkN9tLkP2cFib+nh4KuSKdGhb+rdlBs95rCLkSJayE9xRjQxSLcWiis9cvGEhBgCQuB7ig==
X-Received: by 2002:a05:6402:185:: with SMTP id
 r5mr41305537edv.259.1637875397263; 
 Thu, 25 Nov 2021 13:23:17 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:e87:2d40:4ed4:5676:5c1a])
 by smtp.gmail.com with ESMTPSA id lv19sm2367409ejb.54.2021.11.25.13.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Nov 2021 13:23:16 -0800 (PST)
Date: Thu, 25 Nov 2021 16:23:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211125161434-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211125154314-mutt-send-email-mst@kernel.org>
 <C8D84EA4-E9A8-44CC-918F-57640A05C81D@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C8D84EA4-E9A8-44CC-918F-57640A05C81D@holtmann.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>
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

T24gVGh1LCBOb3YgMjUsIDIwMjEgYXQgMTA6MDE6MjVQTSArMDEwMCwgTWFyY2VsIEhvbHRtYW5u
IHdyb3RlOgo+IEhpIE1pY2hhZWwsCj4gCj4gPj4+IERldmljZSByZW1vdmFsIGlzIGNsZWFybHkg
b3V0IG9mIHZpcnRpbyBzcGVjOiBpdCBhdHRlbXB0cyB0byByZW1vdmUKPiA+Pj4gdW51c2VkIGJ1
ZmZlcnMgZnJvbSBhIFZRIGJlZm9yZSBpbnZva2luZyBkZXZpY2UgcmVzZXQuIFRvIGZpeCwgbWFr
ZQo+ID4+PiBvcGVuL2Nsb3NlIE5PUHMgYW5kIGRvIGFsbCBjbGVhbnVwL3NldHVwIGluIHByb2Jl
L3JlbW92ZS4KPiA+PiAKPiA+PiBzbyB0aGUgdmlydGJ0X3tvcGVuLGNsb3NlfSBhcyBOT1AgaXMg
bm90IHJlYWxseSB3aGF0IGEgZHJpdmVyIGlzIHN1cHBvc2UKPiA+PiB0byBiZSBkb2luZy4gVGhl
c2UgYXJlIHRyYW5zcG9ydCBlbmFibGUvZGlzYWJsZSBjYWxsYmFja3MgZnJvbSB0aGUgQlQKPiA+
PiBDb3JlIHRvd2FyZHMgdGhlIGRyaXZlci4gSXQgbWFwcyB0byBhIGRldmljZSBiZWluZyBlbmFi
bGVkL2Rpc2FibGVkIGJ5Cj4gPj4gc29tZXRoaW5nIGxpa2UgYmx1ZXRvb3RoZCBmb3IgZXhhbXBs
ZS4gU28gaWYgZGlzYWJsZWQsIEkgZXhwZWN0IHRoYXQgbm8KPiA+PiByZXNvdXJjZXMvcXVldWVz
IGFyZSBpbiB1c2UuCj4gPj4gCj4gPj4gTWF5YmUgSSBtaXN1bmRlcnN0YW5kIHRoZSB2aXJ0aW8g
c3BlYyBpbiB0aGF0IHJlZ2FyZCwgYnV0IEkgd291bGQgbGlrZQo+ID4+IHRvIGtlZXAgdGhpcyBm
dW5kYW1lbnRhbCBjb25jZXB0IG9mIGEgQmx1ZXRvb3RoIGRyaXZlci4gSXQgZG9lcyB3b3JrCj4g
Pj4gd2l0aCBhbGwgb3RoZXIgdHJhbnNwb3J0cyBsaWtlIFVTQiwgU0RJTywgVUFSVCBldGMuCj4g
Pj4gCj4gPj4+IFRoZSBjb3N0IGhlcmUgaXMgYSBzaW5nbGUgc2tiIHdhc3RlZCBvbiBhbiB1bnVz
ZWQgYnQgZGV2aWNlIC0gd2hpY2gKPiA+Pj4gc2VlbXMgbW9kZXN0Lgo+ID4+IAo+ID4+IFRoZXJl
IHNob3VsZCBiZSBubyBidWZmZXIgdXNlZCBpZiB0aGUgZGV2aWNlIGlzIHBvd2VyZWQgb2ZmLiBX
ZSBhbHNvIGRvbuKAmXQKPiA+PiBoYXZlIGFueSBVU0IgVVJCcyBpbi1mbGlnaHQgaWYgdGhlIHRy
YW5zcG9ydCBpcyBub3QgYWN0aXZlLgo+ID4+IAo+ID4+PiBOQjogd2l0aCB0aGlzIGZpeCBpbiBw
bGFjZSBkcml2ZXIgc3RpbGwgc3VmZmVycyBmcm9tIGEgcmFjZSBjb25kaXRpb24gaWYKPiA+Pj4g
YW4gaW50ZXJydXB0IHRyaWdnZXJzIHdoaWxlIGRldmljZSBpcyBiZWluZyByZXNldC4gV29yayBv
biBhIGZpeCBmb3IKPiA+Pj4gdGhhdCBpc3N1ZSBpcyBpbiBwcm9ncmVzcy4KPiA+PiAKPiA+PiBJ
biB0aGUgdmlydGJ0X2Nsb3NlKCkgY2FsbGJhY2sgd2Ugc2hvdWxkIGRlYWN0aXZhdGUgYWxsIGlu
dGVycnVwdHMuCj4gPj4gCj4gPiAKPiA+IElmIHlvdSB3YW50IHRvIGRvIHRoYXQgdGhlbiBkZXZp
Y2UgaGFzIHRvIGJlIHJlc2V0IG9uIGNsb3NlLAo+ID4gYW5kIGZ1bGx5IHJlaW5pdGlhbGl6ZWQg
b24gb3Blbi4KPiA+IENhbiB5b3Ugd29yayBvbiBhIHBhdGNoIGxpa2UgdGhhdD8KPiA+IEdpdmVu
IEkgZG9uJ3QgaGF2ZSB0aGUgZGV2aWNlIHN1Y2ggYSByZXdvcmsgaXMgcHJvYmFibHkgbW9yZQo+
ID4gdGhhbiBJIGNhbiB1bmRlcnRha2UuCj4gCj4gc28geW91IG1lYW4gbW92ZSB2aXJ0aW9fZmlu
ZF92cXMoKSBpbnRvIHZpcnRidF9vcGVuKCkgYW5kIGRlbF92cXMoKSBpbnRvCj4gdmlydGJ0X2Ns
b3NlKCk/CgpBbmQgcmVzZXQgYmVmb3JlIGRlbF92cXMuCgo+IE9yIGlzIHRoZXJlIGFyZSB3YXkg
dG8gc2V0IHVwIHRoZSBxdWV1ZXMgd2l0aG91dCBzdGFydGluZyB0aGVtPwo+IAo+IEhvd2V2ZXIg
SSBhbSBmYWlsaW5nIHRvIHVuZGVyc3RhbmQgeW91ciBpbml0aWFsIGNvbmNlcm4sIHdlIGRvIHJl
c2V0KCkKPiBiZWZvcmUgZGVsX3ZxcygpIGluIHZpcnRidF9yZW1vdmUoKS4gU2hvdWxkIHdlIGJl
IGRvaW5nIHNvbWV0aGluZyBkaWZmZXJlbnQKPiBpbiB2aXJ0YnRfY2xvc2UoKSBvdGhlciB0aGFu
IHZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1ZigpLiBXaHkgd291bGQgSQo+IGtlZXAgYnVmZmVy
cyBhdHRhY2hlZCBpZiB0aGV5IGFyZSBub3QgdXNlZC4KPiAKPiBSZWdhcmRzCj4gCj4gTWFyY2Vs
CgpUaGV5IGFyZSBub3QgdXNlZCBhdCB0aGF0IHBvaW50IGJ1dCB1bnRpbCBkZXZpY2UgaXMgcmVz
ZXQgY2FuIHVzZSB0aGVtLgpBbHNvLCBpZiB5b3UgdGhlbiBwcm9jZWVkIHRvIG9wZW4gd2l0aG91
dCBhIHJlc2V0LCBhbmQga2ljaywKZGV2aWNlIHdpbGwgc3RhcnQgYnkgcHJvY2Vzc2luZyB0aGUg
b3JpZ2luYWwgYnVmZmVycywgY3Jhc2hpbmcKb3IgY29ycnVwdGluZyBtZW1vcnkuCgotLSAKTVNU
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
