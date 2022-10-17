Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C5AC4332F
	for <virtualization@archiver.kernel.org>; Mon, 17 Oct 2022 07:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A73E40A09;
	Mon, 17 Oct 2022 07:15:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A73E40A09
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d8H9yOWt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L_esGvky0gU4; Mon, 17 Oct 2022 07:15:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DA296409F3;
	Mon, 17 Oct 2022 07:15:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA296409F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B553EC0032;
	Mon, 17 Oct 2022 07:15:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77E18C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5208281D0B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:15:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5208281D0B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d8H9yOWt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XrbtrLa9d9x9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:15:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76A2081417
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76A2081417
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665990928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPJ0zMzH+/+WqE+Q9hXMqr+6tdiNkx5DCmG8+/nVPjA=;
 b=d8H9yOWtlyGhWv8g59KmJFxV1bfMxVyHGBcDZrxnavqPJ0YLQZ2RB+OPpE3UxZ+APJB7ky
 hnvqS0LSBf/K9/rw74UMhhx8iLn7PWQfuZapxqwdD2WAMyMt3ehQAxQRy0o9bOqwT9cGLS
 rU9m5SGE/vAkFEMVTV3laW46ao5u8gE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-198-XhVheRtFPma8I5vtg_6GZg-1; Mon, 17 Oct 2022 03:15:25 -0400
X-MC-Unique: XhVheRtFPma8I5vtg_6GZg-1
Received: by mail-oo1-f69.google.com with SMTP id
 n5-20020a4a3445000000b004728fe7a331so4419110oof.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 00:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPJ0zMzH+/+WqE+Q9hXMqr+6tdiNkx5DCmG8+/nVPjA=;
 b=pqzAQLkDuhw/ixty5VlxSkQxlMQlWxnfjxojSCAPf/BRlLcphFFhAChH0p85LtePM4
 +nJn/BL/z9KD+K0hwic9DnSF9endZGkvCsnglxWMpWH7A27xLTNyvtPFUHM2VrINcCdh
 FX/4QXmL9yhSS+Ngat66XImBaovSA77u7VqFJyPRtU+jIgllJ4oOh6iDt/CLsX9zr5WW
 BTbhsOE4OXOyu4hB8YaZgF86lQQgydBju/orZhKcZcr+ahvB3+ymnEcwIMA9uzF07M0A
 h/Ej0bg/7z665Fq46py2ACJ0Lz87tXigs/GGIrJ72+jhmYXTQwMElAzSicbBb8m8Vs+6
 Ln3w==
X-Gm-Message-State: ACrzQf2Fn7HL5V7QBD/wrBgsik/jkZyU4V/sGhKezeUdWJA5aii0QWSx
 JwURiiiWkoUsWDwDXaIG+i/N5CR9NIk5VAiGCZICv+whAA69Zwab+C0OnMnTDCz0xU4Oecqsmub
 O4Xt8NRlNl5sUtJhNbf4lGWkWomh9UWDPFbaby2lKqJ6VFM7dkzOEHg31qQ==
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr4363911otn.201.1665990924506; 
 Mon, 17 Oct 2022 00:15:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6PRVlb4SMRZS+7oWQMjNwL9+//CGJE+DrIL1IAik9PhPKTnJpbrhNsRHBWEsjTXVM1VPXKWZW9Hq3yWLjAgaI=
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr4363898otn.201.1665990924270; Mon, 17
 Oct 2022 00:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220905045341.66191-1-jasowang@redhat.com>
 <20220905031405-mutt-send-email-mst@kernel.org>
 <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
 <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
 <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
 <c9180ac41b00543e3531a343afae8f5bdca64d8d.camel@redhat.com>
 <20220907034407-mutt-send-email-mst@kernel.org>
 <d32101bb-783f-dbd1-545a-be291c27cb63@redhat.com>
 <20220908011858-mutt-send-email-mst@kernel.org>
 <c8cd9a2e-3480-6ca5-96fa-4b5bd2c1174a@redhat.com>
 <20221009160520-mutt-send-email-mst@kernel.org>
 <CACGkMEscu+mUBff1JUW4QxkyV33MwRP7VPSZ2-OXp5=pJaHC6Q@mail.gmail.com>
In-Reply-To: <CACGkMEscu+mUBff1JUW4QxkyV33MwRP7VPSZ2-OXp5=pJaHC6Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Oct 2022 15:15:12 +0800
Message-ID: <CACGkMEurGrbj6E5xzLN_uAe9bhFaYtrUu-4fqNP=aumiQi9bzQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command waiting
 loop
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Paolo Abeni <pabeni@redhat.com>,
 davem <davem@davemloft.net>
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

T24gV2VkLCBPY3QgMTIsIDIwMjIgYXQgMTE6MTkgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIE9jdCAxMSwgMjAyMiBhdCAxOjExIEFNIE1pY2hh
ZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFN1biwgT2N0
IDA5LCAyMDIyIGF0IDAxOjU4OjUzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+Cj4g
PiA+IOWcqCAyMDIyLzkvOCAxMzoxOSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4g
PiBPbiBUaHUsIFNlcCAwOCwgMjAyMiBhdCAxMDoyMTo0NUFNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+ID4g5ZyoIDIwMjIvOS83IDE1OjQ2LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ
6YGTOgo+ID4gPiA+ID4gPiBPbiBXZWQsIFNlcCAwNywgMjAyMiBhdCAwOTowNzoyMEFNICswMjAw
LCBQYW9sbyBBYmVuaSB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBXZWQsIDIwMjItMDktMDcgYXQg
MTA6MDkgKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIFNl
cCA2LCAyMDIyIGF0IDY6NTYgUE0gUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPiB3cm90
ZToKPiA+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCAyMDIyLTA5LTA1IGF0IDE1OjQ5ICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgU2VwIDUsIDIwMjIg
YXQgMzoxNSBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgU2VwIDA1LCAyMDIyIGF0IDEyOjUzOjQxUE0gKzA4
MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEFkZGluZyBjb25k
X3Jlc2NoZWQoKSB0byB0aGUgY29tbWFuZCB3YWl0aW5nIGxvb3AgZm9yIGEgYmV0dGVyCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IGNvLW9wZXJhdGlvbiB3aXRoIHRoZSBzY2hlZHVsZXIuIFRoaXMg
YWxsb3dzIHRvIGdpdmUgQ1BVIGEgYnJlYXRoIHRvCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHJ1
biBvdGhlciB0YXNrKHdvcmtxdWV1ZSkgaW5zdGVhZCBvZiBidXN5IGxvb3Bpbmcgd2hlbiBwcmVl
bXB0aW9uIGlzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG5vdCBhbGxvd2VkLgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXaGF0J3MgbW9yZSBpbXBvcnRh
bnQuIFRoaXMgaXMgYSBtdXN0IGZvciBzb21lIHZEUEEgcGFyZW50IHRvIHdvcmsKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gc2luY2UgY29udHJvbCB2aXJ0cXVldWUgaXMgZW11bGF0ZWQgdmlhIGEg
d29ya3F1ZXVlIGZvciB0aG9zZSBwYXJlbnRzLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBGaXhlczogYmRhMzI0ZmQwMzdhICgidmRwYXNpbTogY29udHJv
bCB2aXJ0cXVldWUgc3VwcG9ydCIpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGF0J3MgYSB3ZWly
ZCBjb21taXQgdG8gZml4LiBzbyBpdCBmaXhlcyB0aGUgc2ltdWxhdG9yPwo+ID4gPiA+ID4gPiA+
ID4gPiA+IFllcywgc2luY2UgdGhlIHNpbXVsYXRvciBpcyB1c2luZyBhIHdvcmtxdWV1ZSB0byBo
YW5kbGUgY29udHJvbCB2aXJ0dWV1ZS4KPiA+ID4gPiA+ID4gPiA+ID4gVWhtbS4uLiB0b3VjaGlu
ZyBhIGRyaXZlciBmb3IgYSBzaW11bGF0b3IncyBzYWtlIGxvb2tzIGEgbGl0dGxlIHdlaXJkLgo+
ID4gPiA+ID4gPiA+ID4gU2ltdWxhdG9yIGlzIG5vdCB0aGUgb25seSBvbmUgdGhhdCBpcyB1c2lu
ZyBhIHdvcmtxdWV1ZSAoYnV0IHNob3VsZCBiZQo+ID4gPiA+ID4gPiA+ID4gdGhlIGZpcnN0KS4K
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBJIGNhbiBzZWUgIHRoYXQgdGhlIG1seDUg
dkRQQSBkcml2ZXIgaXMgdXNpbmcgYSB3b3JrcXVldWUgYXMgd2VsbCAoc2VlCj4gPiA+ID4gPiA+
ID4gPiBtbHg1X3ZkcGFfa2lja192cSgpKS4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiBBbmQgaW4gdGhlIGNhc2Ugb2YgVkRVU0UsIGl0IG5lZWRzIHRvIHdhaXQgZm9yIHRoZSByZXNw
b25zZSBmcm9tIHRoZQo+ID4gPiA+ID4gPiA+ID4gdXNlcnNwYWNlLCB0aGlzIG1lYW5zIGNvbmRf
cmVzY2hlZCgpIGlzIHByb2JhYmx5IGEgbXVzdCBmb3IgdGhlIGNhc2UKPiA+ID4gPiA+ID4gPiA+
IGxpa2UgVVAuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBBZGRpdGlvbmFsbHks
IGlmIHRoZSBidWcgaXMgdmRwYXNpbSwgSSB0aGluayBpdCdzIGJldHRlciB0byB0cnkgdG8KPiA+
ID4gPiA+ID4gPiA+ID4gc29sdmUgaXQgdGhlcmUsIGlmIHBvc3NpYmxlLgo+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBMb29raW5nIGF0IHZkcGFzaW1fbmV0X3dvcmsoKSBhbmQg
dmRwYXNpbV9ibGtfd29yaygpIGl0IGxvb2tzIGxpa2UKPiA+ID4gPiA+ID4gPiA+ID4gbmVpdGhl
ciBuZWVkcyBhIHByb2Nlc3MgY29udGV4dCwgc28gcGVyaGFwcyB5b3UgY291bGQgcmV3b3JrIGl0
IHRvIHJ1bgo+ID4gPiA+ID4gPiA+ID4gPiB0aGUgd29ya19mbigpIGRpcmVjdGx5IGZyb20gdmRw
YXNpbV9raWNrX3ZxKCksIGF0IGxlYXN0IGZvciB0aGUgY29udHJvbAo+ID4gPiA+ID4gPiA+ID4g
PiB2aXJ0cXVldWU/Cj4gPiA+ID4gPiA+ID4gPiBJdCdzIHBvc3NpYmxlIChidXQgcmVxdWlyZSBz
b21lIHJld29yayBvbiB0aGUgc2ltdWxhdG9yIGNvcmUpLiBCdXQKPiA+ID4gPiA+ID4gPiA+IGNv
bnNpZGVyaW5nIHdlIGhhdmUgb3RoZXIgc2ltaWxhciB1c2UgY2FzZXMsIGl0IGxvb2tzIGJldHRl
ciB0byBzb2x2ZQo+ID4gPiA+ID4gPiA+ID4gaXQgaW4gdGhlIHZpcnRpby1uZXQgZHJpdmVyLgo+
ID4gPiA+ID4gPiA+IEkgc2VlLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBBZGRpdGlv
bmFsbHksIHRoaXMgbWF5IGhhdmUgYmV0dGVyIGJlaGF2aW91ciB3aGVuIHVzaW5nIGZvciB0aGUg
YnVnZ3kKPiA+ID4gPiA+ID4gPiA+IGhhcmR3YXJlIChlLmcgdGhlIGNvbnRyb2wgdmlydHF1ZXVl
IHRha2VzIHRvbyBsb25nIHRvIHJlc3BvbmQpLiBXZSBtYXkKPiA+ID4gPiA+ID4gPiA+IGNvbnNp
ZGVyIHN3aXRjaGluZyB0byB1c2UgaW50ZXJydXB0L3NsZWVwIGluIHRoZSBmdXR1cmUgKGJ1dCBu
b3QKPiA+ID4gPiA+ID4gPiA+IHN1aXRhYmxlIGZvciAtbmV0KS4KPiA+ID4gPiA+ID4gPiBBZ3Jl
ZWQuIFBvc3NpYmx5IGEgdGltZW91dCBjb3VsZCBiZSB1c2VmdWwsIHRvby4KPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+IENoZWVycywKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFBhb2xv
Cj4gPiA+ID4gPiA+IEhtbSB0aW1lb3V0cyBhcmUga2luZCBvZiBhcmJpdHJhcnkuCj4gPiA+ID4g
PiA+IHJlZ3VsYXIgZHJpdmVycyBiYXNpY2FsbHkgZGVyaXZlIHRoZW0gZnJvbSBoYXJkd2FyZQo+
ID4gPiA+ID4gPiBiZWhhdmlvdXIgYnV0IHdpdGggYSBnZW5lcmljIGRyaXZlciBsaWtlIHZpcnRp
byBpdCdzIGhhcmRlci4KPiA+ID4gPiA+ID4gSSBndWVzcyB3ZSBjb3VsZCBhZGQgdGltZW91dCBh
cyBhIGNvbmZpZyBmaWVsZCwgaGF2ZQo+ID4gPiA+ID4gPiBkZXZpY2UgbWFrZSBhIHByb21pc2Ug
dG8gdGhlIGRyaXZlci4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gTWFraW5nIHRoZSB3YWl0IGlu
dGVycnVwdGlibGUgc2VlbXMgbW9yZSByZWFzb25hYmxlLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFll
cywgYnV0IEkgdGhpbmsgd2Ugc3RpbGwgbmVlZCB0aGlzIHBhdGNoIGZvciAtbmV0IGFuZCAtc3Rh
YmxlLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+IEkgd2FzIHJlZmVycmluZyB0
byBQYW9sbydzIGlkZWEgb2YgaGF2aW5nIGEgdGltZW91dC4KPiA+ID4KPiA+ID4KPiA+ID4gT2ss
IEkgdGhpbmsgd2UncmUgZmluZSB3aXRoIHRoaXMgcGF0Y2guIEFueSBjaGFuY2UgdG8gbWVyZ2Ug
dGhpcyBvciBkbyBJCj4gPiA+IG5lZWQgdG8gcmVzZW5kPwo+ID4gPgo+ID4gPiBUaGFua3MKPiA+
Cj4gPiBMYXN0IHF1ZXN0aW9uOiBkbyB3ZSB3YW50IGNwdV9yZWxheCBoZXJlIG5vdz8gT3IgaXMg
Y29uZF9yZXNjaGVkCj4gPiBzdWZmaWNpZW50Pwo+Cj4gKEhhdmUgYW5zd2VyZWQgaW4gYW5vdGhl
ciB0aHJlYWQpCj4KPiBJIHRoaW5rIHdlIG5lZWQgY3B1X3JlbGF4KCkgc2luY2UgdGhlcmUgY291
bGQgYmUgbm8gaGlnaCBwcmlvcml0eSB0YXNrCj4gaW4gdGhlIGN1cnJlbnQgY3B1IHNvIHdlIHN0
aWxsIG5lZWQgdG8gcmVsYXguCj4KPiBUaGFua3MKCk1pY2hhZWwsIGRvZXMgdGhpcyBhbnN3ZXIg
bWFrZSBzZW5zZT8gSWYgeWVzLCB3b3VsZCB5b3UgbGlrZSB0byBhY2sgdGhlIHBhdGNoPwoKVGhh
bmtzCgo+Cj4gPgo+ID4gPgo+ID4gPiA+Cj4gPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
