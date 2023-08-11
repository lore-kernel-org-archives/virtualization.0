Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A170C0015E
	for <virtualization@archiver.kernel.org>; Fri, 11 Aug 2023 09:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2437D60B45;
	Fri, 11 Aug 2023 09:22:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2437D60B45
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HEciJhxf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FGpNlhGHgYOI; Fri, 11 Aug 2023 09:22:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 75AD760B06;
	Fri, 11 Aug 2023 09:22:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75AD760B06
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E228C0072;
	Fri, 11 Aug 2023 09:22:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CEC5C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48BA160B45
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:22:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 48BA160B45
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12F20Szfu3sw
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:21:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D63E960B06
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:21:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D63E960B06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691745714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qc/WOX45CsZJBV93Err2MVMANsAd+cCgENPpEN+I0vA=;
 b=HEciJhxfSG6QfDR+0fTTmk072F/Cp/OeWz6kwc9AHMmvuMe8lD00keVrAQzLHP3bYIF006
 oEKY7E5o0aAFmNLQcxGD4NgdlPVF1RTHOfc+t7fjmjm00VUFukbgi819hij0BNTYfV3hC0
 Frcw83xHtiiQqQc6osRphclIPS1edPw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-4UJn4nhkOvWFUyosZ3alZg-1; Fri, 11 Aug 2023 05:21:53 -0400
X-MC-Unique: 4UJn4nhkOvWFUyosZ3alZg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe44619c97so13581575e9.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 02:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691745712; x=1692350512;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qc/WOX45CsZJBV93Err2MVMANsAd+cCgENPpEN+I0vA=;
 b=EKx+BZ0sO91DdnUbtysTG2fOlNsA9FveSxerl56HByReFDQJ5uHQYa5dZ1UgdPb/IM
 1vcPNJgtBPis09nCR12fbwy1DRk91NoVPUXMraN+krxrh187kraGRCqeQIuKkuxbq0//
 qqKvDYkc0wiF7bzxmJnh9w/2O+b70Rrq8dHXkHtkfqkIGkd0VlQ+JgGjhDAUI+hd4xyN
 g4AW6YR+XZ3EMzRUF0h7MZBLv1pSIBOXOyBVQ6zV3P5uZo9500DSFC56pXvlC7w5Hd+1
 iBem5I0QjbWWgfQTM2VDolhvSYW5RFEv3BkzvkA+FK+qFkUz1dc99hA0dtt/FUbCrg5I
 TfJg==
X-Gm-Message-State: AOJu0YwArq5rjLt5tQv61wHu6BUEZ22GSMWMoiBaTssjXd0diOkt14Yf
 cRkJRDq2lZSLxJJ1OVe1gyzdTXZbnOsYOUqIQqtMiB/3YGzHDvzxF92wdxLRjGAE1kj4Nu9htn4
 ovGPwNgPHJB3c6Wir1UIBqXGtDOoNCJHLGqorq0P8vA==
X-Received: by 2002:a7b:cd0d:0:b0:3fb:e1d0:6417 with SMTP id
 f13-20020a7bcd0d000000b003fbe1d06417mr3662332wmj.19.1691745712235; 
 Fri, 11 Aug 2023 02:21:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER/WnnKn4hVj56w4Zkki7TDfm7jIFT+xEdAc/BAFLPHbIKDezcMwpxxeM0f+d3cm1CIvnNuA==
X-Received: by 2002:a7b:cd0d:0:b0:3fb:e1d0:6417 with SMTP id
 f13-20020a7bcd0d000000b003fbe1d06417mr3662316wmj.19.1691745711863; 
 Fri, 11 Aug 2023 02:21:51 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 u16-20020a5d4690000000b00313de682eb3sm4764736wrq.65.2023.08.11.02.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 02:21:51 -0700 (PDT)
Date: Fri, 11 Aug 2023 05:21:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230811052102-mutt-send-email-mst@kernel.org>
References: <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
 <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
 <20230811012147-mutt-send-email-mst@kernel.org>
 <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMDU6MTg6NTFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIEF1ZyAxMSwgMjAyMyBhdCAxOjQy4oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQg
MTA6MjM6MTVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gRnJpLCBBdWcgMTEs
IDIwMjMgYXQgMzo0MeKAr0FNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gVHVlLCBBdWcgMDgsIDIwMjMgYXQgMTA6MzA6NTZBTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgSnVsIDMxLCAyMDIzIGF0
IDI6MzDigK9QTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgNTo0NuKAr1BNIE1pY2hh
ZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgMDQ6NTk6MzNQTSArMDgwMCwgSmFzb24g
V2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gVGhleSByZWFsbHkgc2hvdWxkbid0IC0gYW55
IE5JQyB0aGF0IHRha2VzIGZvcmV2ZXIgdG8KPiA+ID4gPiA+ID4gPiA+ID4gcHJvZ3JhbSB3aWxs
IGNyZWF0ZSBpc3N1ZXMgaW4gdGhlIG5ldHdvcmtpbmcgc3RhY2suCj4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gVW5mb3J0dW5hdGVseSwgaXQncyBub3QgcmFyZSBhcyB0aGUgZGV2aWNl
L2N2cSBjb3VsZCBiZSBpbXBsZW1lbnRlZAo+ID4gPiA+ID4gPiA+ID4gdmlhIGZpcm13YXJlIG9y
IHNvZnR3YXJlLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gQ3VycmVudGx5IHRoYXQgbWVh
biBvbmUgZWl0aGVyIGhhcyBzYW5lIGZpcm13YXJlIHdpdGggYSBzY2hlZHVsZXIgdGhhdAo+ID4g
PiA+ID4gPiA+IGNhbiBtZWV0IGRlYWRsaW5lcywgb3IgbG9zZXMgYWJpbGl0eSB0byByZXBvcnQg
ZXJyb3JzIGJhY2suCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gQnV0IGlmIHRoZXkg
ZG8gdGhleSBjYW4gYWx3YXlzIHNldCB0aGlzIGZsYWcgdG9vLgo+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+IFRoaXMgbWF5IGhhdmUgZmFsc2UgbmVnYXRpdmVzIGFuZCBtYXkgY29uZnVz
ZSB0aGUgbWFuYWdlbWVudC4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBNYXliZSB3
ZSBjYW4gZXh0ZW5kIHRoZSBuZXR3b3JraW5nIGNvcmUgdG8gYWxsb3cgc29tZSBkZXZpY2Ugc3Bl
Y2lmaWMKPiA+ID4gPiA+ID4gPiA+IGNvbmZpZ3VyYXRpb25zIHRvIGJlIGRvbmUgd2l0aCBkZXZp
Y2Ugc3BlY2lmaWMgbG9jayB3aXRob3V0IHJ0bmwuIEZvcgo+ID4gPiA+ID4gPiA+ID4gZXhhbXBs
ZSwgc3BsaXQgdGhlIHNldF9jaGFubmVscyB0bwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+IHByZV9zZXRfY2hhbm5lbHMKPiA+ID4gPiA+ID4gPiA+IHNldF9jaGFubmVscwo+ID4gPiA+
ID4gPiA+ID4gcG9zdF9zZXRfY2hhbm5lbHMKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiBUaGUgZGV2aWNlIHNwZWNpZmljIHBhcnQgY291bGQgYmUgZG9uZSBpbiBwcmUgYW5kIHBvc3Qg
d2l0aG91dCBhIHJ0bmwgbG9jaz8KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBUaGFu
a3MKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gV291bGQgdGhlIGJl
bmVmaXQgYmUgdGhhdCBlcnJvcnMgY2FuIGJlIHJlcG9ydGVkIHRvIHVzZXJzcGFjZSB0aGVuPwo+
ID4gPiA+ID4gPiA+IFRoZW4gbWF5YmUuICBJIHRoaW5rIHlvdSB3aWxsIGhhdmUgdG8gc2hvdyBo
b3cgdGhpcyB3b3JrcyBmb3IgYXQgbGVhc3QKPiA+ID4gPiA+ID4gPiBvbmUgY2FyZCBiZXNpZGVz
IHZpcnRpby4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gRXZlbiBmb3IgdmlydGlvLCB0aGlzIHNl
ZW1zIG5vdCBlYXN5LCBhcyBlLmcgdGhlCj4gPiA+ID4gPiA+IHZpcnRuZXRfc2VuZF9jb21tYW5k
KCkgYW5kIG5ldGlmX3NldF9yZWFsX251bV90eF9xdWV1ZXMoKSBuZWVkIHRvCj4gPiA+ID4gPiA+
IGFwcGVhciB0byBiZSBhdG9taWMgdG8gdGhlIG5ldHdvcmtpbmcgY29yZS4KPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gSSB3b25kZXIgaWYgd2UgY2FuIHJlLWNvbnNpZGVyIHRoZSB3YXkgb2YgYSB0
aW1lb3V0IGhlcmUgYW5kIGNob29zZSBhCj4gPiA+ID4gPiA+IHNhbmUgdmFsdWUgYXMgYSBzdGFy
dC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBNaWNoYWVsLCBhbnkgbW9yZSBpbnB1dCBvbiB0aGlzPwo+
ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4gSSB0aGluayB0aGlzIGlz
IGp1c3QgbWlzc2lvbiBjcmVlcC4gV2UgYXJlIHRyeWluZyB0byBmaXgKPiA+ID4gPiB2ZHVzZSAt
IGxldCdzIGRvIHRoYXQgZm9yIHN0YXJ0ZXJzLgo+ID4gPiA+Cj4gPiA+ID4gUmVjb3ZlcmluZyBm
cm9tIGZpcm13YXJlIHRpbWVvdXRzIGlzIGZhciBmcm9tIHRyaXZpYWwgYW5kCj4gPiA+ID4ganVz
dCBhc3N1bWluZyB0aGF0IGp1c3QgYmVjYXVzZSBpdCB0aW1lZCBvdXQgaXQgd2lsbCBub3QKPiA+
ID4gPiBhY2Nlc3MgbWVtb3J5IGlzIGp1c3QgYXMgbGlrZWx5IHRvIGNhdXNlIG1lbW9yeSBjb3Jy
dXB0aW9uCj4gPiA+ID4gd2l0aCB3b3JzZSByZXN1bHRzIHRoYW4gYW4gaW5maW5pdGUgc3Bpbi4K
PiA+ID4KPiA+ID4gWWVzLCB0aGlzIG1pZ2h0IHJlcXVpcmUgc3VwcG9ydCBub3Qgb25seSBpbiB0
aGUgZHJpdmVyCj4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBJIHByb3Bvc2Ugd2UgZml4IHRoaXMgZm9y
IHZkdXNlIGFuZCBhc3N1bWUgaGFyZHdhcmUvZmlybXdhcmUKPiA+ID4gPiBpcyB3ZWxsIGJlaGF2
ZWQuCj4gPiA+Cj4gPiA+IE9uZSBtYWpvciBjYXNlIGlzIHRoZSByZS1jb25uZWN0aW9uLCBpbiB0
aGF0IGNhc2UgaXQgbWlnaHQgdGFrZQo+ID4gPiB3aGF0ZXZlciBsb25nZXIgdGhhdCB0aGUga2Vy
bmVsIHZpcml0by1uZXQgZHJpdmVyIGV4cGVjdHMuCj4gPiA+IFNvIHdlIGNhbiBoYXZlIGEgdGlt
ZW91dCBpbiBWRFVTRSBhbmQgdHJhcCBDVlEgdGhlbiBWRFVTRSBjYW4gcmV0dXJuCj4gPiA+IGFu
ZCBmYWlsIGVhcmx5Pwo+ID4KPiA+IFVnaCBtb3JlIG1pc3Npb24gY3JlZXAuIG5vdCBhdCBhbGwg
bXkgcG9pbnQuIHZkdXNlIHNob3VsZCBjYWNoZQo+ID4gdmFsdWVzIGluIHRoZSBkcml2ZXIsCj4g
Cj4gV2hhdCBkbyB5b3UgbWVhbiBieSB2YWx1ZXMgaGVyZT8gVGhlIGN2cSBjb21tYW5kPwo+IAo+
IFRoYW5rcwoKVGhlIGNhcmQgc3RhdHVzIGdlbmVyYWxseS4KCj4gPiB1bnRpbCBzb21lb25lIG1h
bmFnZXMgdG8gY2hhbmdlCj4gPiBuZXQgY29yZSB0byBiZSBtb3JlIGZyaWVuZGx5IHRvIHVzZXJz
cGFjZSBkZXZpY2VzLgo+ID4KPiA+ID4KPiA+ID4gPiBPciBtYXliZSBub3Qgd2VsbCBiZWhhdmVk
IGZpcm13YXJlIHdpbGwKPiA+ID4gPiBzZXQgdGhlIGZsYWcgbG9zaW5nIGVycm9yIHJlcG9ydGlu
ZyBhYmlsaXR5Lgo+ID4gPgo+ID4gPiBUaGlzIG1pZ2h0IGJlIGhhcmQgc2luY2UgaXQgbWVhbnMg
bm90IG9ubHkgdGhlIHNldCBidXQgYWxzbyB0aGUgZ2V0IGlzCj4gPiA+IHVucmVsaWFibGUuCj4g
PiA+Cj4gPiA+IFRoYW5rcwo+ID4KPiA+IC9tZSBzaHJ1Z3MKPiA+Cj4gPgo+ID4KPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+
ID4gTVNUCj4gPiA+ID4gPiA+ID4KPiA+ID4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
