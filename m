Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D81CC001B0
	for <virtualization@archiver.kernel.org>; Fri, 11 Aug 2023 09:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACD2541BBD;
	Fri, 11 Aug 2023 09:54:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACD2541BBD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CICKo8HA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sHzR-slAjO-R; Fri, 11 Aug 2023 09:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9213141B6F;
	Fri, 11 Aug 2023 09:54:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9213141B6F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 680D1C0072;
	Fri, 11 Aug 2023 09:54:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2648C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9AF1403E7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:54:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9AF1403E7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CICKo8HA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3kzCMdu0yekd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:54:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE2C2400D1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:54:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE2C2400D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691747671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrU6q2m7M8Ni8WudMbRDpduRGd5bq6RhdiQ8dq+W5Bo=;
 b=CICKo8HAmtsHP+Zz5bOXdXhGFwSfJkdIb9sFr35BDYF5H5qTQeDs7QJuQUdLvu5/OctxHc
 BrbQGlz9QoV5X1ZDxfTR+E/i9ZDowEUpQIL+/NNJIqjVbC6q2RCsSfEAB0/HRKY/uYNb4j
 zQ22emfXX+wc5XfLB2mc9pH4m3H56Wk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-glPwaR5VPC6rnolWR7gJjQ-1; Fri, 11 Aug 2023 05:54:28 -0400
X-MC-Unique: glPwaR5VPC6rnolWR7gJjQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9e8abe539so19523621fa.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 02:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691747666; x=1692352466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrU6q2m7M8Ni8WudMbRDpduRGd5bq6RhdiQ8dq+W5Bo=;
 b=R18lkgUhzrdevt6CVsnpWcK4eyJjheeHTRypTTGy4ZyaWPNsZbMzYriC8dmfVPPvYF
 EZXLcNOtfgF8AD0gX5K91EDa7LUSP/uXnsdvXrkjZh7O/AgUMaziV/SR/191m0T9QPA8
 yVDtgArxOYRw9RHHo40JmWRbKA2KKgeuobTnZ582OmEjTk8tK+lBXSPcjTQo6v4GTxGR
 LaeN7TtV7DyguAoOk6qCBD5ke6rXQGXj/Ya6UneTg2Okt1OJFtu3JHsw8zjRbRXPdzSk
 4p+HDxdjcO76VbjDaXcPSxKZI9rK+JxV4MQ5ilbl6DMgzshj/3HljhYwH6uzR4VbOxhs
 Lgbg==
X-Gm-Message-State: AOJu0YyLaV/cuwNzIifSXnfubDmcO8vPqqeVJqYkAKoSg1WUIotwilVu
 zxVSelCnKSv1HdlfiHsrtjW8Q58NMlp//uBws2H60ZIgfli5hKXpQAUQus6V925ojbOPS/qTI8e
 J8G3fZ1wqbfnDOLr1ujqk5S8SEg5kiH7xPg9Mr7LpoUHJSx0kvzpVFvl4jg==
X-Received: by 2002:a05:651c:217:b0:2b6:e78e:1e58 with SMTP id
 y23-20020a05651c021700b002b6e78e1e58mr1164994ljn.5.1691747666647; 
 Fri, 11 Aug 2023 02:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjdZTRgA2OuYmx8WS1qjnOKHo0CILn0M72Oslqf2+KkQ3lMITxyLd7YvspS8O9O9Y3Qz95GrW6zqohqICYsnY=
X-Received: by 2002:a05:651c:217:b0:2b6:e78e:1e58 with SMTP id
 y23-20020a05651c021700b002b6e78e1e58mr1164977ljn.5.1691747666248; Fri, 11 Aug
 2023 02:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
 <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
 <20230811012147-mutt-send-email-mst@kernel.org>
 <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
 <20230811052102-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGQqipR-XT-JWDt8T8KRXVpvDZsrQ6fEcaE4AfOyfwg@mail.gmail.com>
 <20230811054859-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230811054859-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 11 Aug 2023 17:54:15 +0800
Message-ID: <CACGkMEujbuQRuBBzSdVYah2ZcfRgxLbEKjZjPBeFhLxj5quFhw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgNTo1MeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMDU6NDM6MjVQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIEZyaSwgQXVnIDExLCAyMDIzIGF0IDU6
MjHigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMDU6MTg6NTFQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiBPbiBGcmksIEF1ZyAxMSwgMjAyMyBhdCAxOjQy4oCvUE0gTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMTA6MjM6MTVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiA+ID4gPiA+ID4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMzo0MeKAr0FNIE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gT24gVHVlLCBBdWcgMDgsIDIwMjMgYXQgMTA6MzA6NTZBTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgSnVsIDMxLCAyMDIzIGF0IDI6MzDigK9Q
TSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgNTo0NuKAr1BNIE1p
Y2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgMDQ6NTk6MzNQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhleSBy
ZWFsbHkgc2hvdWxkbid0IC0gYW55IE5JQyB0aGF0IHRha2VzIGZvcmV2ZXIgdG8KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gcHJvZ3JhbSB3aWxsIGNyZWF0ZSBpc3N1ZXMgaW4gdGhlIG5ldHdvcmtp
bmcgc3RhY2suCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVW5m
b3J0dW5hdGVseSwgaXQncyBub3QgcmFyZSBhcyB0aGUgZGV2aWNlL2N2cSBjb3VsZCBiZSBpbXBs
ZW1lbnRlZAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdmlhIGZpcm13YXJlIG9yIHNvZnR3YXJlLgo+
ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gQ3VycmVudGx5IHRoYXQgbWVh
biBvbmUgZWl0aGVyIGhhcyBzYW5lIGZpcm13YXJlIHdpdGggYSBzY2hlZHVsZXIgdGhhdAo+ID4g
PiA+ID4gPiA+ID4gPiA+IGNhbiBtZWV0IGRlYWRsaW5lcywgb3IgbG9zZXMgYWJpbGl0eSB0byBy
ZXBvcnQgZXJyb3JzIGJhY2suCj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gQnV0IGlmIHRoZXkgZG8gdGhleSBjYW4gYWx3YXlzIHNldCB0aGlzIGZsYWcgdG9vLgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRoaXMgbWF5IGhhdmUg
ZmFsc2UgbmVnYXRpdmVzIGFuZCBtYXkgY29uZnVzZSB0aGUgbWFuYWdlbWVudC4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBNYXliZSB3ZSBjYW4gZXh0ZW5kIHRo
ZSBuZXR3b3JraW5nIGNvcmUgdG8gYWxsb3cgc29tZSBkZXZpY2Ugc3BlY2lmaWMKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IGNvbmZpZ3VyYXRpb25zIHRvIGJlIGRvbmUgd2l0aCBkZXZpY2Ugc3BlY2lm
aWMgbG9jayB3aXRob3V0IHJ0bmwuIEZvcgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZXhhbXBsZSwg
c3BsaXQgdGhlIHNldF9jaGFubmVscyB0bwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IHByZV9zZXRfY2hhbm5lbHMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHNldF9j
aGFubmVscwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gcG9zdF9zZXRfY2hhbm5lbHMKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGUgZGV2aWNlIHNwZWNpZmljIHBh
cnQgY291bGQgYmUgZG9uZSBpbiBwcmUgYW5kIHBvc3Qgd2l0aG91dCBhIHJ0bmwgbG9jaz8KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gV291bGQg
dGhlIGJlbmVmaXQgYmUgdGhhdCBlcnJvcnMgY2FuIGJlIHJlcG9ydGVkIHRvIHVzZXJzcGFjZSB0
aGVuPwo+ID4gPiA+ID4gPiA+ID4gPiA+IFRoZW4gbWF5YmUuICBJIHRoaW5rIHlvdSB3aWxsIGhh
dmUgdG8gc2hvdyBob3cgdGhpcyB3b3JrcyBmb3IgYXQgbGVhc3QKPiA+ID4gPiA+ID4gPiA+ID4g
PiBvbmUgY2FyZCBiZXNpZGVzIHZpcnRpby4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gRXZlbiBmb3IgdmlydGlvLCB0aGlzIHNlZW1zIG5vdCBlYXN5LCBhcyBlLmcgdGhlCj4g
PiA+ID4gPiA+ID4gPiA+IHZpcnRuZXRfc2VuZF9jb21tYW5kKCkgYW5kIG5ldGlmX3NldF9yZWFs
X251bV90eF9xdWV1ZXMoKSBuZWVkIHRvCj4gPiA+ID4gPiA+ID4gPiA+IGFwcGVhciB0byBiZSBh
dG9taWMgdG8gdGhlIG5ldHdvcmtpbmcgY29yZS4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gSSB3b25kZXIgaWYgd2UgY2FuIHJlLWNvbnNpZGVyIHRoZSB3YXkgb2YgYSB0aW1l
b3V0IGhlcmUgYW5kIGNob29zZSBhCj4gPiA+ID4gPiA+ID4gPiA+IHNhbmUgdmFsdWUgYXMgYSBz
dGFydC4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBNaWNoYWVsLCBhbnkgbW9yZSBp
bnB1dCBvbiB0aGlzPwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSSB0aGluayB0aGlzIGlzIGp1c3QgbWlzc2lvbiBjcmVl
cC4gV2UgYXJlIHRyeWluZyB0byBmaXgKPiA+ID4gPiA+ID4gPiB2ZHVzZSAtIGxldCdzIGRvIHRo
YXQgZm9yIHN0YXJ0ZXJzLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gUmVjb3ZlcmluZyBm
cm9tIGZpcm13YXJlIHRpbWVvdXRzIGlzIGZhciBmcm9tIHRyaXZpYWwgYW5kCj4gPiA+ID4gPiA+
ID4ganVzdCBhc3N1bWluZyB0aGF0IGp1c3QgYmVjYXVzZSBpdCB0aW1lZCBvdXQgaXQgd2lsbCBu
b3QKPiA+ID4gPiA+ID4gPiBhY2Nlc3MgbWVtb3J5IGlzIGp1c3QgYXMgbGlrZWx5IHRvIGNhdXNl
IG1lbW9yeSBjb3JydXB0aW9uCj4gPiA+ID4gPiA+ID4gd2l0aCB3b3JzZSByZXN1bHRzIHRoYW4g
YW4gaW5maW5pdGUgc3Bpbi4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gWWVzLCB0aGlzIG1pZ2h0
IHJlcXVpcmUgc3VwcG9ydCBub3Qgb25seSBpbiB0aGUgZHJpdmVyCj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJIHByb3Bvc2Ugd2UgZml4IHRoaXMgZm9yIHZkdXNlIGFu
ZCBhc3N1bWUgaGFyZHdhcmUvZmlybXdhcmUKPiA+ID4gPiA+ID4gPiBpcyB3ZWxsIGJlaGF2ZWQu
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uZSBtYWpvciBjYXNlIGlzIHRoZSByZS1jb25uZWN0
aW9uLCBpbiB0aGF0IGNhc2UgaXQgbWlnaHQgdGFrZQo+ID4gPiA+ID4gPiB3aGF0ZXZlciBsb25n
ZXIgdGhhdCB0aGUga2VybmVsIHZpcml0by1uZXQgZHJpdmVyIGV4cGVjdHMuCj4gPiA+ID4gPiA+
IFNvIHdlIGNhbiBoYXZlIGEgdGltZW91dCBpbiBWRFVTRSBhbmQgdHJhcCBDVlEgdGhlbiBWRFVT
RSBjYW4gcmV0dXJuCj4gPiA+ID4gPiA+IGFuZCBmYWlsIGVhcmx5Pwo+ID4gPiA+ID4KPiA+ID4g
PiA+IFVnaCBtb3JlIG1pc3Npb24gY3JlZXAuIG5vdCBhdCBhbGwgbXkgcG9pbnQuIHZkdXNlIHNo
b3VsZCBjYWNoZQo+ID4gPiA+ID4gdmFsdWVzIGluIHRoZSBkcml2ZXIsCj4gPiA+ID4KPiA+ID4g
PiBXaGF0IGRvIHlvdSBtZWFuIGJ5IHZhbHVlcyBoZXJlPyBUaGUgY3ZxIGNvbW1hbmQ/Cj4gPiA+
ID4KPiA+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4gVGhlIGNhcmQgc3RhdHVzIGdlbmVyYWxseS4K
PiA+Cj4gPiBKdXN0IHRvIG1ha2Ugc3VyZSBJIHVuZGVyc3RhbmQgaGVyZS4gVGhlIENWUSBuZWVk
cyB0byBiZSBwcm9jZXNzZWQgYnkKPiA+IHRoZSB1c2Vyc3BhY2Ugbm93LiBIb3cgY291bGQgd2Ug
Y2FjaGUgdGhlIHN0YXR1cz8KPiA+Cj4gPiBUaGFua3MKPgo+IHZkdXNlIHdpbGwgaGF2ZSB0byBw
cm9jZXNzIGl0IGluIGtlcm5lbC4KClJpZ2h0LCB0aGF0J3MgbXkgdW5kZXJzdGFuZGluZyAodHJh
cCBDVlEpLgoKVGhhbmtzCgo+Cj4gPiA+Cj4gPiA+ID4gPiB1bnRpbCBzb21lb25lIG1hbmFnZXMg
dG8gY2hhbmdlCj4gPiA+ID4gPiBuZXQgY29yZSB0byBiZSBtb3JlIGZyaWVuZGx5IHRvIHVzZXJz
cGFjZSBkZXZpY2VzLgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBPciBtYXli
ZSBub3Qgd2VsbCBiZWhhdmVkIGZpcm13YXJlIHdpbGwKPiA+ID4gPiA+ID4gPiBzZXQgdGhlIGZs
YWcgbG9zaW5nIGVycm9yIHJlcG9ydGluZyBhYmlsaXR5Lgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiBUaGlzIG1pZ2h0IGJlIGhhcmQgc2luY2UgaXQgbWVhbnMgbm90IG9ubHkgdGhlIHNldCBidXQg
YWxzbyB0aGUgZ2V0IGlzCj4gPiA+ID4gPiA+IHVucmVsaWFibGUuCj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4KPiA+ID4gPiA+IC9tZSBzaHJ1Z3MKPiA+ID4gPiA+Cj4g
PiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+IC0tCj4gPiA+ID4gPiA+ID4gPiA+ID4gTVNUCj4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
