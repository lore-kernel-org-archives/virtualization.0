Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AC1C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 08:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E50A761311;
	Wed, 20 Apr 2022 08:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jfxJckoofg7b; Wed, 20 Apr 2022 08:05:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 55ED261307;
	Wed, 20 Apr 2022 08:05:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CDD2C0033;
	Wed, 20 Apr 2022 08:05:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21575C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 08:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1A9B418A2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 08:05:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jXtf3sw5GEWA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 08:05:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E63541520
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 08:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650441923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTILT1wa3kY70WQDLShgtGUkCqSzqPWqZgkYcoIOl+A=;
 b=YdyRzXCcMNqUfqHY+t0SjBj3qcQI3QBRlitkQ6mbTLtimb+d5tYh/tAI479rEqrQ3eNTYz
 EO4znUQnhb+0mu7bUvvL8AY+zyqqe9QJvrBnaYaKXlkSzQa2oBl6D0qn1HS0fo5vJaHBc5
 KZKfyMg96Ju4oerj19cc2atBjqKKPK4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-3DYJQ6f4Na-BP9gfeKGHqg-1; Wed, 20 Apr 2022 04:05:22 -0400
X-MC-Unique: 3DYJQ6f4Na-BP9gfeKGHqg-1
Received: by mail-pf1-f199.google.com with SMTP id
 m8-20020a62a208000000b0050593296139so839232pff.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 01:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=zTILT1wa3kY70WQDLShgtGUkCqSzqPWqZgkYcoIOl+A=;
 b=y2USwaZdMp9AVzZ3nwZuQigGjdrDfDA1PjFGaHDuKotsDkP+Adn4+A/Lnr/YrNCmgC
 XqPNWDhO/aHZfCKwnldQWeyTs6G/7kZuro7oapfk/L23k2tOIbxeq2GjUwPr1h5SRy8A
 qx5jiP5hVSUB5j/EeevTS2QPLUEJo9jotX2aeDpyQDKQssedFgazwn60EdpVjSSi3OI3
 NxhBdRT9s4TQd8lGUNJRgETQgTUsGlClOvpTuQQO+wDVObNFNT0vTzth2GuJXqxAUR4w
 FXon9hLIMhc2BSSFVvrh9PIS6mlkdySCgwL2t/BL8VO7MUJ6KsOy8Tu+3EX0aTXpYSJ4
 KLcg==
X-Gm-Message-State: AOAM5334P9nr5noxpCZ8Vvg4apah9x7VnLyf1VDplzeD+Xr5yJZwLZDh
 yPLSqhJdebAeDN6w5AeZ4uivdNasMP1SfwhC6qkdC/4+cdW9xOnGNGfU8ZwPfPPWny5K15q7gyq
 FsF67/qHpa5J6JFFIMHDEOo2wb4scKsNrWIRrJsVd4g==
X-Received: by 2002:a65:6093:0:b0:373:9c75:19ec with SMTP id
 t19-20020a656093000000b003739c7519ecmr18955824pgu.539.1650441921074; 
 Wed, 20 Apr 2022 01:05:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWzIRO05tVZzWPi2+/7DnK6i8lYTwk7AdvlP0J5UPMIcyCkPiCjx7GVIBIlXScFa5rA6aGcg==
X-Received: by 2002:a65:6093:0:b0:373:9c75:19ec with SMTP id
 t19-20020a656093000000b003739c7519ecmr18955804pgu.539.1650441920782; 
 Wed, 20 Apr 2022 01:05:20 -0700 (PDT)
Received: from [10.72.14.13] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 s50-20020a056a001c7200b0050acf7cadc5sm341263pfw.112.2022.04.20.01.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Apr 2022 01:05:20 -0700 (PDT)
Message-ID: <e09c228d-c89b-fc55-474f-ed9f980aecf4@redhat.com>
Date: Wed, 20 Apr 2022 16:05:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: virtio-net: Unpermitted usage of virtqueue before virtio driver
 initialization
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <c0c17b91-747e-ab58-83e5-b6f7dfa55e75@opensynergy.com>
 <20220419103826-mutt-send-email-mst@kernel.org>
 <CACGkMEvJu8ADk=+QJryDfuh9y8pXzfYQ3KRg0Lq0POH3Z-SHuQ@mail.gmail.com>
 <20220420023511-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220420023511-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Willem de Bruijn <willemb@google.com>,
 =?UTF-8?Q?Maciej_Szyma=c5=84ski?= <maciej.szymanski@opensynergy.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzQvMjAgMTQ6MzUsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gT24gV2Vk
LCBBcHIgMjAsIDIwMjIgYXQgMTE6MDc6MDBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g
T24gVHVlLCBBcHIgMTksIDIwMjIgYXQgMTE6MDMgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4+PiBPbiBUdWUsIEFwciAxOSwgMjAyMiBhdCAwNDoxMjozMVBN
ICswMjAwLCBNYWNpZWogU3p5bWHFhHNraSB3cm90ZToKPj4+PiBIZWxsbywKPj4+Pgo+Pj4+IEkn
dmUgZm91bmQgYSBwcm9ibGVtIGluIHZpcnRpby1uZXQgZHJpdmVyLgo+Pj4+IElmIHZpcnRpby1u
ZXQgYmFja2VuZCBkZXZpY2UgYWR2ZXJ0aXNlcyBndWVzdCBvZmZsb2FkIGZlYXR1cmVzLCB0aGVy
ZSBpcwo+Pj4+IGFuIHVucGVybWl0dGVkIHVzYWdlIG9mIGNvbnRyb2wgdmlydHF1ZXVlIGJlZm9y
ZSBkcml2ZXIgaXMgaW5pdGlhbGl6ZWQuCj4+Pj4gQWNjb3JkaW5nIHRvIFZJUlRJTyBzcGVjaWZp
Y2F0aW9uIDIuMS4yIDoKPj4+PiAiVGhlIGRldmljZSBNVVNUIE5PVCBjb25zdW1lIGJ1ZmZlcnMg
b3Igc2VuZCBhbnkgdXNlZCBidWZmZXIKPj4+PiBub3RpZmljYXRpb25zIHRvIHRoZSBkcml2ZXIg
YmVmb3JlIERSSVZFUl9PSy4iCj4+PiBSaWdodC4KPj4+Cj4+Pj4gRHVyaW5nIGFuIGluaXRpYWxp
emF0aW9uLCBkcml2ZXIgY2FsbHMgcmVnaXN0ZXJfbmV0ZGV2aWNlIHdoaWNoIGludm9rZXMKPj4+
PiBjYWxsYmFjayBmdW5jdGlvbiB2aXJ0bmV0X3NldF9mZWF0dXJlcyBmcm9tIF9fbmV0ZGV2X3Vw
ZGF0ZV9mZWF0dXJlcy4KPj4+PiBJZiBndWVzdCBvZmZsb2FkIGZlYXR1cmVzIGFyZSBhZHZlcnRp
c2VkIGJ5IHRoZSBkZXZpY2UsCj4+Pj4gdmlydG5ldF9zZXRfZ3Vlc3Rfb2ZmbG9hZHMgaXMgdXNp
bmcgdmlydG5ldF9zZW5kX2NvbW1hbmQgdG8gd3JpdGUgYW5kCj4+Pj4gcmVhZCBmcm9tIFZRLgo+
Pj4+IFRoYXQgbGVhZHMgdG8gaW5pdGlhbGl6YXRpb24gc3R1Y2sgYXMgZGV2aWNlIGlzIG5vdCBw
ZXJtaXR0ZWQgeWV0IHRvIHVzZSBWUS4KPj4+Cj4+Pgo+Pj4gSG1tIHNvIHdlIGhhdmUgdGhpczoK
Pj4+Cj4+Pgo+Pj4gICAgICAgICAgaWYgKChkZXYtPmZlYXR1cmVzIF4gZmVhdHVyZXMpICYgTkVU
SUZfRl9HUk9fSFcpIHsKPj4+ICAgICAgICAgICAgICAgICAgaWYgKHZpLT54ZHBfZW5hYmxlZCkK
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOwo+Pj4KPj4+ICAgICAg
ICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9HUk9fSFcpCj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgb2ZmbG9hZHMgPSB2aS0+Z3Vlc3Rfb2ZmbG9hZHNfY2FwYWJsZTsKPj4+
ICAgICAgICAgICAgICAgICAgZWxzZQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIG9mZmxv
YWRzID0gdmktPmd1ZXN0X29mZmxvYWRzX2NhcGFibGUgJgo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfkdVRVNUX09GRkxPQURfR1JPX0hXX01BU0s7Cj4+Pgo+Pj4gICAg
ICAgICAgICAgICAgICBlcnIgPSB2aXJ0bmV0X3NldF9ndWVzdF9vZmZsb2Fkcyh2aSwgb2ZmbG9h
ZHMpOwo+Pj4gICAgICAgICAgICAgICAgICBpZiAoZXJyKQo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBlcnI7Cj4+PiAgICAgICAgICAgICAgICAgIHZpLT5ndWVzdF9vZmZsb2Fk
cyA9IG9mZmxvYWRzOwo+Pj4gICAgICAgICAgfQo+Pj4KPj4+IHdoaWNoIEkgZ3Vlc3Mgc2hvdWxk
IGhhdmUgcHJldmVudGVkIHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzIGZyb20gZXZlciBydW5u
aW5nLgo+Pj4KPj4+ICBGcm9tIHlvdXIgZGVzY3JpcHRpb24gaXQgc291bmRzIGxpa2UgeW91IGhh
dmUgb2JzZXJ2ZWQgdGhpcwo+Pj4gaW4gcHJhY3RpY2UsIHJpZ2h0Pwo+Pj4KPj4+Cj4+Pgo+Pj4+
IEkgaGF2ZSBhdHRhY2hlZCBhIHBhdGNoIGZvciBrZXJuZWwgNS4xOC1yYzMgd2hpY2ggZml4ZXMg
dGhlIHByb2JsZW0gYnkKPj4+PiBkZWZlcnJpbmcgZmVhdHVyZSBzZXQgYWZ0ZXIgdmlydGlvIGRy
aXZlciBpbml0aWFsaXphdGlvbi4KPj4+Pgo+Pj4+IEJlc3QgUmVnYXJkcywKPj4+Pgo+Pj4+IC0t
Cj4+Pj4gTWFjaWVqIFN6eW1hxYRza2kKPj4+PiBTZW5pb3IgU3RhZmYgRW5naW5lZXIKPj4+Pgo+
Pj4+IE9wZW5TeW5lcmd5IEdtYkgKPj4+PiBSb3RoZXJzdHIuIDIwLCAxMDI0NSBCZXJsaW4KPj4+
Pgo+Pj4+IFBob25lOiAgICArNDkgMzAgNjAgOTggNTQgMCAtODYKPj4+PiBGYXg6ICAgICAgKzQ5
IDMwIDYwIDk4IDU0IDAgLTk5Cj4+Pj4gRS1NYWlsOiAgIG1hY2llai5zenltYW5za2lAb3BlbnN5
bmVyZ3kuY29tCj4+Pj4KPj4+PiB3d3cub3BlbnN5bmVyZ3kuY29tCj4+Pj4KPj4+PiBIYW5kZWxz
cmVnaXN0ZXIvQ29tbWVyY2lhbCBSZWdpc3RyeTogQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcs
IEhSQiAxMDg2MTZCCj4+Pj4gR2VzY2jDpGZ0c2bDvGhyZXIvTWFuYWdpbmcgRGlyZWN0b3I6IFJl
Z2lzIEFkamFtYWgKPj4+Pgo+Pj4+IFBsZWFzZSBtaW5kIG91ciBwcml2YWN5IG5vdGljZTxodHRw
czovL3d3dy5vcGVuc3luZXJneS5jb20vZGF0ZW5zY2h1dHplcmtsYWVydW5nL3ByaXZhY3ktbm90
aWNlLWZvci1idXNpbmVzcy1wYXJ0bmVycy1wdXJzdWFudC10by1hcnRpY2xlLTEzLW9mLXRoZS1n
ZW5lcmFsLWRhdGEtcHJvdGVjdGlvbi1yZWd1bGF0aW9uLWdkcHIvPiBwdXJzdWFudCB0byBBcnQu
IDEzIEdEUFIuIC8vIFVuc2VyZSBIaW53ZWlzZSB6dW0gRGF0ZW5zY2h1dHogZ2VtLiBBcnQuIDEz
IERTR1ZPIGZpbmRlbiBTaWUgaGllci48aHR0cHM6Ly93d3cub3BlbnN5bmVyZ3kuY29tL2RlL2Rh
dGVuc2NodXR6ZXJrbGFlcnVuZy9kYXRlbnNjaHV0emhpbndlaXNlLWZ1ZXItZ2VzY2hhZWZ0c3Bh
cnRuZXItZ2VtLWFydC0xMy1kc2d2by8+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+IGluZGV4IDg3ODM4Y2Iu
LmE0NDQ2MmQgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+Pj4g
KysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+Pj4gQEAgLTI2NCw2ICsyNjQsOCBAQCBz
dHJ1Y3QgdmlydG5ldF9pbmZvIHsKPj4+PiAgICAgICAgICB1bnNpZ25lZCBsb25nIGd1ZXN0X29m
ZmxvYWRzOwo+Pj4+ICAgICAgICAgIHVuc2lnbmVkIGxvbmcgZ3Vlc3Rfb2ZmbG9hZHNfY2FwYWJs
ZTsKPj4+Pgo+Pj4+ICsgICAgICAgbmV0ZGV2X2ZlYXR1cmVzX3QgZmVhdHVyZXM7Cj4+Pj4gKwo+
Pj4gSSBkb24ndCBtdWNoIGxpa2UgaG93IHdlIGFyZSBmb3JjZWQgdG8ga2VlcCBhIGNvcHkgb2Yg
ZmVhdHVyZXMKPj4+IGhlcmUgOiggQXQgbGVhc3QgcGxzIGFkZCBhIGNvbW1lbnQgZXhwbGFpbmlu
ZyB3aGF0J3MgZ29pbmcgb24sCj4+PiB3aG8gb3ducyB0aGlzIGV0Yy4KPj4+Cj4+Pj4gICAgICAg
ICAgLyogZmFpbG92ZXIgd2hlbiBTVEFOREJZIGZlYXR1cmUgZW5hYmxlZCAqLwo+Pj4+ICAgICAg
ICAgIHN0cnVjdCBmYWlsb3ZlciAqZmFpbG92ZXI7Cj4+Pj4gICB9Owo+Pj4+IEBAIC0yOTc2LDYg
KzI5NzgsMTUgQEAgc3RhdGljIGludCB2aXJ0bmV0X2dldF9waHlzX3BvcnRfbmFtZShzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2LCBjaGFyICpidWYsCj4+Pj4KPj4+PiAgIHN0YXRpYyBpbnQgdmlydG5l
dF9zZXRfZmVhdHVyZXMoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBuZXRkZXZfZmVhdHVyZXNfdCBmZWF0dXJlcykKPj4+PiArewo+
Pj4+ICsgICAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYpOwo+
Pj4+ICsgICAgICAgdmktPmZlYXR1cmVzID0gZmVhdHVyZXM7Cj4+Pj4gKwo+Pj4+ICsgICAgICAg
cmV0dXJuIDA7Cj4+Pj4gK30KPj4+Cj4+PiBMb29rcyBsaWtlIHRoaXMgYnJlYWtzIGNoYW5naW5n
IGZlYXR1cmVzIGFmdGVyIGluaXRpYWxpemF0aW9uIC0KPj4+IHRoZXNlIHdpbGwgbmV2ZXIgYmUg
cHJvcGFnYXRlZCB0byBoYXJkd2FyZSBub3cuCj4+IFllcywgSSB0aGluayB3ZSBuZWVkIHRvIGhh
dmUgYSBjaGVjayBhbmQgb25seSBkZWZlciB0aGUgc2V0dGluZyB3aGVuCj4+IHZpcnRpbyBkZXZp
Y2UgaXMgbm90IHJlYWR5Lgo+Pgo+PiBUaGFua3MKPiBJIHRoaW5rIHdlIHNob3VsZCBmaXJzdCB1
bmRlcnN0YW5kIGhvdyBkb2VzIHRoZSBpc3N1ZSB0cmlnZ2VyLAo+IGlzIHRoaXMgYSB0aGVvcmV0
aWNhbCBvciBhIHByYWN0aWNhbCBpc3N1ZS4KCgpJdCBsb29rcyBsaWtlIGEgcHJhY3RpY2FsIGlz
c3VlLiBXZSBkb24ndCBtZWV0IGl0IGluIFFlbXUgcHJvYmFibHkgCmJlY2F1c2UgUWVtdSBkb2Vz
bid0IGNoZWNrIERSSVZFUl9PSyB3aGVuIHByb2Nlc3NpbmcgY3RybCB2cS4KClRoYW5rcwoKCj4K
Pj4+PiArCj4+Pj4gK3N0YXRpYyBpbnQgdmlydG5ldF9zZXRfZmVhdHVyZXNfZGVmZXJyZWQoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwKPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG5ldGRldl9mZWF0dXJlc190IGZlYXR1cmVzKQo+Pj4+ICAgewo+Pj4+ICAgICAgICAgIHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpID0gbmV0ZGV2X3ByaXYoZGV2KTsKPj4+PiAgICAgICAgICB1NjQg
b2ZmbG9hZHM7Cj4+Pj4gQEAgLTM2NDQsNiArMzY1NSwxMyBAQCBzdGF0aWMgaW50IHZpcnRuZXRf
cHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+Pj4KPj4+PiAgICAgICAgICB2aXJ0
aW9fZGV2aWNlX3JlYWR5KHZkZXYpOwo+Pj4+Cj4+Pj4gKyAgICAgICAvKiBEZWZlcnJlZCBmZWF0
dXJlIHNldCBhZnRlciBkZXZpY2UgcmVhZHkgKi8KPj4+PiArICAgICAgIGVyciA9IHZpcnRuZXRf
c2V0X2ZlYXR1cmVzX2RlZmVycmVkKGRldiwgdmktPmZlYXR1cmVzKTsKPj4+Cj4+PiBJdCBzZWVt
cyB0aGF0IGlmIHRoaXMgaXMgY2FsbGVkIGUuZy4gZm9yIGEgZGV2aWNlIHdpdGhvdXQgYSBDVlEg
YW5kCj4+PiB0aGVyZSBhcmUgdGhpbmdzIHRoYXQgYWN0dWFsbHkgbmVlZCB0byBjaGFuZ2UgdGhl
biBpdCB3aWxsIEJVR19PTi4KPj4+Cj4+Pgo+Pj4+ICsgICAgICAgaWYgKGVycikgewo+Pj4+ICsg
ICAgICAgICAgICAgICBwcl9kZWJ1ZygidmlydGlvX25ldDogc2V0IGZlYXR1cmVzIGZhaWxlZFxu
Iik7Cj4+Pj4gKyAgICAgICAgICAgICAgIGdvdG8gZnJlZV91bnJlZ2lzdGVyX25ldGRldjsKPj4+
PiArICAgICAgIH0KPj4+PiArCj4+Pj4gICAgICAgICAgZXJyID0gdmlydG5ldF9jcHVfbm90aWZf
YWRkKHZpKTsKPj4+PiAgICAgICAgICBpZiAoZXJyKSB7Cj4+Pj4gICAgICAgICAgICAgICAgICBw
cl9kZWJ1ZygidmlydGlvX25ldDogcmVnaXN0ZXJpbmcgY3B1IG5vdGlmaWVyIGZhaWxlZFxuIik7
Cj4+Pj4KPj4+IC0tCj4+PiBNU1QKPj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
