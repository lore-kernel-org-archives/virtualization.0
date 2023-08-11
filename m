Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F6DC0015E
	for <virtualization@archiver.kernel.org>; Fri, 11 Aug 2023 09:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEA7D41936;
	Fri, 11 Aug 2023 09:19:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DEA7D41936
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EguVPO5b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XB6D8kfrfEvm; Fri, 11 Aug 2023 09:19:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E3910418ED;
	Fri, 11 Aug 2023 09:19:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E3910418ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B40F9C0072;
	Fri, 11 Aug 2023 09:19:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D25EC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C885581E70
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:19:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C885581E70
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EguVPO5b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3areYqQSkEbZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:19:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B859C81E1B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:19:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B859C81E1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691745546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WGdSssISZdYkw7T85LRer1ntqt/JyX2ZF+++BCIHsA4=;
 b=EguVPO5byEjIfgSi45ErUW+lAdL+H91jLM+bAkW1eqoLgM25bQccDwlq2nG0Pc1CglTidu
 eMzyKE/FSvTFwz0T0NofiBWg6yvNV1f6KLCBypGFCSwW1GYuHx0Baik1l5HRbsG43HdLqm
 F8dDwAzmOfzes1hiy69OqfmPvSd5HWA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-Pz4MzycoMUiBLxbOArFOeQ-1; Fri, 11 Aug 2023 05:19:05 -0400
X-MC-Unique: Pz4MzycoMUiBLxbOArFOeQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9bf493456so19397641fa.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 02:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691745543; x=1692350343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGdSssISZdYkw7T85LRer1ntqt/JyX2ZF+++BCIHsA4=;
 b=IZDFq2K0vVKxYhyD4ddSd9eav7/tWJkR0bhDJ6BmKnj9D9uhpKT7XBb24S8rnshvqB
 4diPuh5bCEXJLsoJsYsa6clGVGYuhUCaTTIJXlYlpQ8eacazr5YD9oqvphdYO/dICkZw
 0snbG8/6jU5mbGS+EuD3dMd1pjFainB0GCVR0kCIscu42yfiRRRpOmnzMAZA+0WclLjK
 p+DfsnR6NuCSDK0Eqc+mAK7+N+RSBOLL9A91KI3qtUA+17ti23NV0g5zksdlSfqeldOD
 QDMqyPWbxwwZz2A41NyLzacPZirpEbUsalvrcOXjqKYiL+R7wLTwMo7VWmcKskQ+zMS9
 ezYg==
X-Gm-Message-State: AOJu0Yw9GKMhsNUn4pw3VIrDXxGMKTEa+2GA19hNLS9/hBtNPRWCGlOK
 cFaNY0cVWt2vHiGXLcTa17WEa/9+9zds21KC+2aB2yGDPlbYGKF/6E5Ve4L8dKPPCOJR28/Sl04
 g67lNvOW+aBAlQMzxzUCfiCJ6W5HnEs10XI0I5qwAnw6f+thv78U5sK3mAQ==
X-Received: by 2002:a2e:8188:0:b0:2b1:ad15:fe38 with SMTP id
 e8-20020a2e8188000000b002b1ad15fe38mr1124393ljg.3.1691745543666; 
 Fri, 11 Aug 2023 02:19:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRSv6LX+hSldz3htlZqeyiqLtB22I217onQne1fAzxKaGyV86gUpG4v24jBvRPBt+lPmGZPgcxmQqsdRHKiLQ=
X-Received: by 2002:a2e:8188:0:b0:2b1:ad15:fe38 with SMTP id
 e8-20020a2e8188000000b002b1ad15fe38mr1124379ljg.3.1691745543321; Fri, 11 Aug
 2023 02:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
 <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
 <20230811012147-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230811012147-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 11 Aug 2023 17:18:51 +0800
Message-ID: <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
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

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMTo0MuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMTA6MjM6MTVB
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIEZyaSwgQXVnIDExLCAyMDIzIGF0IDM6
NDHigK9BTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4gT24gVHVlLCBBdWcgMDgsIDIwMjMgYXQgMTA6MzA6NTZBTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiBPbiBNb24sIEp1bCAzMSwgMjAyMyBhdCAyOjMw4oCvUE0gSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24g
VGh1LCBKdWwgMjcsIDIwMjMgYXQgNTo0NuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPbiBUaHUsIEp1bCAyNywg
MjAyMyBhdCAwNDo1OTozM1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+
ID4gVGhleSByZWFsbHkgc2hvdWxkbid0IC0gYW55IE5JQyB0aGF0IHRha2VzIGZvcmV2ZXIgdG8K
PiA+ID4gPiA+ID4gPiA+IHByb2dyYW0gd2lsbCBjcmVhdGUgaXNzdWVzIGluIHRoZSBuZXR3b3Jr
aW5nIHN0YWNrLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVW5mb3J0dW5hdGVseSwgaXQn
cyBub3QgcmFyZSBhcyB0aGUgZGV2aWNlL2N2cSBjb3VsZCBiZSBpbXBsZW1lbnRlZAo+ID4gPiA+
ID4gPiA+IHZpYSBmaXJtd2FyZSBvciBzb2Z0d2FyZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
Q3VycmVudGx5IHRoYXQgbWVhbiBvbmUgZWl0aGVyIGhhcyBzYW5lIGZpcm13YXJlIHdpdGggYSBz
Y2hlZHVsZXIgdGhhdAo+ID4gPiA+ID4gPiBjYW4gbWVldCBkZWFkbGluZXMsIG9yIGxvc2VzIGFi
aWxpdHkgdG8gcmVwb3J0IGVycm9ycyBiYWNrLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
QnV0IGlmIHRoZXkgZG8gdGhleSBjYW4gYWx3YXlzIHNldCB0aGlzIGZsYWcgdG9vLgo+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhpcyBtYXkgaGF2ZSBmYWxzZSBuZWdhdGl2ZXMgYW5kIG1h
eSBjb25mdXNlIHRoZSBtYW5hZ2VtZW50Lgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gTWF5
YmUgd2UgY2FuIGV4dGVuZCB0aGUgbmV0d29ya2luZyBjb3JlIHRvIGFsbG93IHNvbWUgZGV2aWNl
IHNwZWNpZmljCj4gPiA+ID4gPiA+ID4gY29uZmlndXJhdGlvbnMgdG8gYmUgZG9uZSB3aXRoIGRl
dmljZSBzcGVjaWZpYyBsb2NrIHdpdGhvdXQgcnRubC4gRm9yCj4gPiA+ID4gPiA+ID4gZXhhbXBs
ZSwgc3BsaXQgdGhlIHNldF9jaGFubmVscyB0bwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
cHJlX3NldF9jaGFubmVscwo+ID4gPiA+ID4gPiA+IHNldF9jaGFubmVscwo+ID4gPiA+ID4gPiA+
IHBvc3Rfc2V0X2NoYW5uZWxzCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGUgZGV2aWNl
IHNwZWNpZmljIHBhcnQgY291bGQgYmUgZG9uZSBpbiBwcmUgYW5kIHBvc3Qgd2l0aG91dCBhIHJ0
bmwgbG9jaz8KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBXb3VsZCB0aGUgYmVuZWZpdCBiZSB0aGF0IGVycm9ycyBj
YW4gYmUgcmVwb3J0ZWQgdG8gdXNlcnNwYWNlIHRoZW4/Cj4gPiA+ID4gPiA+IFRoZW4gbWF5YmUu
ICBJIHRoaW5rIHlvdSB3aWxsIGhhdmUgdG8gc2hvdyBob3cgdGhpcyB3b3JrcyBmb3IgYXQgbGVh
c3QKPiA+ID4gPiA+ID4gb25lIGNhcmQgYmVzaWRlcyB2aXJ0aW8uCj4gPiA+ID4gPgo+ID4gPiA+
ID4gRXZlbiBmb3IgdmlydGlvLCB0aGlzIHNlZW1zIG5vdCBlYXN5LCBhcyBlLmcgdGhlCj4gPiA+
ID4gPiB2aXJ0bmV0X3NlbmRfY29tbWFuZCgpIGFuZCBuZXRpZl9zZXRfcmVhbF9udW1fdHhfcXVl
dWVzKCkgbmVlZCB0bwo+ID4gPiA+ID4gYXBwZWFyIHRvIGJlIGF0b21pYyB0byB0aGUgbmV0d29y
a2luZyBjb3JlLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEkgd29uZGVyIGlmIHdlIGNhbiByZS1jb25z
aWRlciB0aGUgd2F5IG9mIGEgdGltZW91dCBoZXJlIGFuZCBjaG9vc2UgYQo+ID4gPiA+ID4gc2Fu
ZSB2YWx1ZSBhcyBhIHN0YXJ0Lgo+ID4gPiA+Cj4gPiA+ID4gTWljaGFlbCwgYW55IG1vcmUgaW5w
dXQgb24gdGhpcz8KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPgo+ID4gPiBJIHRoaW5rIHRo
aXMgaXMganVzdCBtaXNzaW9uIGNyZWVwLiBXZSBhcmUgdHJ5aW5nIHRvIGZpeAo+ID4gPiB2ZHVz
ZSAtIGxldCdzIGRvIHRoYXQgZm9yIHN0YXJ0ZXJzLgo+ID4gPgo+ID4gPiBSZWNvdmVyaW5nIGZy
b20gZmlybXdhcmUgdGltZW91dHMgaXMgZmFyIGZyb20gdHJpdmlhbCBhbmQKPiA+ID4ganVzdCBh
c3N1bWluZyB0aGF0IGp1c3QgYmVjYXVzZSBpdCB0aW1lZCBvdXQgaXQgd2lsbCBub3QKPiA+ID4g
YWNjZXNzIG1lbW9yeSBpcyBqdXN0IGFzIGxpa2VseSB0byBjYXVzZSBtZW1vcnkgY29ycnVwdGlv
bgo+ID4gPiB3aXRoIHdvcnNlIHJlc3VsdHMgdGhhbiBhbiBpbmZpbml0ZSBzcGluLgo+ID4KPiA+
IFllcywgdGhpcyBtaWdodCByZXF1aXJlIHN1cHBvcnQgbm90IG9ubHkgaW4gdGhlIGRyaXZlcgo+
ID4KPiA+ID4KPiA+ID4gSSBwcm9wb3NlIHdlIGZpeCB0aGlzIGZvciB2ZHVzZSBhbmQgYXNzdW1l
IGhhcmR3YXJlL2Zpcm13YXJlCj4gPiA+IGlzIHdlbGwgYmVoYXZlZC4KPiA+Cj4gPiBPbmUgbWFq
b3IgY2FzZSBpcyB0aGUgcmUtY29ubmVjdGlvbiwgaW4gdGhhdCBjYXNlIGl0IG1pZ2h0IHRha2UK
PiA+IHdoYXRldmVyIGxvbmdlciB0aGF0IHRoZSBrZXJuZWwgdmlyaXRvLW5ldCBkcml2ZXIgZXhw
ZWN0cy4KPiA+IFNvIHdlIGNhbiBoYXZlIGEgdGltZW91dCBpbiBWRFVTRSBhbmQgdHJhcCBDVlEg
dGhlbiBWRFVTRSBjYW4gcmV0dXJuCj4gPiBhbmQgZmFpbCBlYXJseT8KPgo+IFVnaCBtb3JlIG1p
c3Npb24gY3JlZXAuIG5vdCBhdCBhbGwgbXkgcG9pbnQuIHZkdXNlIHNob3VsZCBjYWNoZQo+IHZh
bHVlcyBpbiB0aGUgZHJpdmVyLAoKV2hhdCBkbyB5b3UgbWVhbiBieSB2YWx1ZXMgaGVyZT8gVGhl
IGN2cSBjb21tYW5kPwoKVGhhbmtzCgo+IHVudGlsIHNvbWVvbmUgbWFuYWdlcyB0byBjaGFuZ2UK
PiBuZXQgY29yZSB0byBiZSBtb3JlIGZyaWVuZGx5IHRvIHVzZXJzcGFjZSBkZXZpY2VzLgo+Cj4g
Pgo+ID4gPiBPciBtYXliZSBub3Qgd2VsbCBiZWhhdmVkIGZpcm13YXJlIHdpbGwKPiA+ID4gc2V0
IHRoZSBmbGFnIGxvc2luZyBlcnJvciByZXBvcnRpbmcgYWJpbGl0eS4KPiA+Cj4gPiBUaGlzIG1p
Z2h0IGJlIGhhcmQgc2luY2UgaXQgbWVhbnMgbm90IG9ubHkgdGhlIHNldCBidXQgYWxzbyB0aGUg
Z2V0IGlzCj4gPiB1bnJlbGlhYmxlLgo+ID4KPiA+IFRoYW5rcwo+Cj4gL21lIHNocnVncwo+Cj4K
Pgo+ID4gPgo+ID4gPgo+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4K
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4gTVNUCj4g
PiA+ID4gPiA+Cj4gPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
