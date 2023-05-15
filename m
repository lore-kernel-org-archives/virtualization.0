Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E6AC77B75
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 10:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1815F83F02;
	Mon, 15 May 2023 10:17:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1815F83F02
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CWh5CC+V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id riPHwKi9aYIr; Mon, 15 May 2023 10:17:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 71EEE83EFC;
	Mon, 15 May 2023 10:17:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71EEE83EFC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52A4CC0037;
	Mon, 15 May 2023 10:17:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE085C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 10:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9092E41DF4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 10:17:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9092E41DF4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CWh5CC+V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HEVNduUzJgar
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 10:17:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 540AA41DED
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 540AA41DED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684145845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2F2MmPR6uvyF/S479nyiadAjTsmEszXcVeYTAPUBtGg=;
 b=CWh5CC+Vf1gPzx/i12ZKDR+BErB7C6MFXlQkRsU4A4CB97BynHajYvT4I+CWqVRg0QA0Zz
 9AjGzUfQFRo2fLN2i0n9Swhg8zUd/Ui/x4wXObYXENhfF7BPSC9LpyFFvL4rwUONpmXM+1
 MJoX1SbRCVeXRzXMHSBLkxEBt3twmy8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-NyTVCWtOPZqhuVywfNLOvg-1; Mon, 15 May 2023 06:17:23 -0400
X-MC-Unique: NyTVCWtOPZqhuVywfNLOvg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f509037a45so18865935e9.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 03:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684145842; x=1686737842;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2F2MmPR6uvyF/S479nyiadAjTsmEszXcVeYTAPUBtGg=;
 b=lkaiNS7INiGY0Plu7nw3uE0BUoKaKm76ij8SWuez/hVPI7HfQGMg42wDzrk+7t+jqB
 dHw2Ur93uGJGoteEDxyLE14bBzvuS8CEIPvJNf9adGLr7KATcwn3wXfpZ04KruQyHJ/K
 D8oX9sRqHTxW4JngKcDDnTxV98hGyYtrZVXmEvV4gyi/W2I9nvv7732Licxm5mwUdGMe
 gWQRnBaOFLa0SdlRuPYM18RBtWrRrF+7Ilc7spX7RI9Pb85zH5IuAJFOx1HB3xrTa4fC
 ml4s/Tw08L4r1TOZtTj4vrATLjXljQJgpoqXi7KC8E23pHXsJPl1561K/9i/mwNhcz+D
 4J+Q==
X-Gm-Message-State: AC+VfDxyGEaDLObhu5RXEhy58qKu3Mw714RwO7LZHZoOzSucyolio8Jt
 qOO0K8CmNpAgcHTTbf9xAnVOvA8LdheGBbbW19eQS4WDn/dNWeo+aCBBwHk61gLcLkkOSDV80Zj
 ZX8R0PtkJaykTjNZixjKxnYbouJ+OjTze/I1mATq7PQ==
X-Received: by 2002:a7b:cd8c:0:b0:3f4:2775:b45c with SMTP id
 y12-20020a7bcd8c000000b003f42775b45cmr16135074wmj.3.1684145842254; 
 Mon, 15 May 2023 03:17:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cjHf8wpirqMKODDcwtxNOIU7NCNEa+K+k2xQTKz5Pl8QX6uaHXd7dJ3fMMgRsMfUs2i6A+g==
X-Received: by 2002:a7b:cd8c:0:b0:3f4:2775:b45c with SMTP id
 y12-20020a7bcd8c000000b003f42775b45cmr16135056wmj.3.1684145841868; 
 Mon, 15 May 2023 03:17:21 -0700 (PDT)
Received: from redhat.com ([2.52.26.5]) by smtp.gmail.com with ESMTPSA id
 a6-20020a1cf006000000b003f0aefcc457sm36542703wmb.45.2023.05.15.03.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 03:17:21 -0700 (PDT)
Date: Mon, 15 May 2023 06:17:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230515061455-mutt-send-email-mst@kernel.org>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org>
 <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org>
 <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
 <20230510012951-mutt-send-email-mst@kernel.org>
 <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
 <20230515004422-mutt-send-email-mst@kernel.org>
 <CACGkMEv+Q2UoBarNOzKSrc3O=Wb2_73O2j9cZXFdAiLBm1qY-Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv+Q2UoBarNOzKSrc3O=Wb2_73O2j9cZXFdAiLBm1qY-Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, edumazet@google.com, maxime.coquelin@redhat.com,
 kuba@kernel.org, pabeni@redhat.com, david.marchand@redhat.com,
 davem@davemloft.net
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

T24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgMDE6MTM6MzNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIE1heSAxNSwgMjAyMyBhdCAxMjo0NeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0
IDA5OjA1OjU0QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIFdlZCwgTWF5IDEw
LCAyMDIzIGF0IDE6MzPigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3
cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIE1vbiwgQXByIDE3LCAyMDIzIGF0IDExOjQwOjU4QU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiBPbiBGcmksIEFwciAxNCwgMjAyMyBh
dCAzOjIx4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIEZyaSwgQXByIDE0LCAyMDIzIGF0IDAxOjA0OjE1UE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gRm9yZ2V0IHRvIGNjIG5ldGRl
diwgYWRkaW5nLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gT24gRnJpLCBBcHIgMTQsIDIw
MjMgYXQgMTI6MjXigK9BTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90
ZToKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIEFwciAxMywgMjAyMyBh
dCAwMjo0MDoyNlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiBU
aGlzIHBhdGNoIGNvbnZlcnQgcnggbW9kZSBzZXR0aW5nIHRvIGJlIGRvbmUgaW4gYSB3b3JrcXVl
dWUsIHRoaXMgaXMKPiA+ID4gPiA+ID4gPiA+ID4gYSBtdXN0IGZvciBhbGxvdyB0byBzbGVlcCB3
aGVuIHdhaXRpbmcgZm9yIHRoZSBjdnEgY29tbWFuZCB0bwo+ID4gPiA+ID4gPiA+ID4gPiByZXNw
b25zZSBzaW5jZSBjdXJyZW50IGNvZGUgaXMgZXhlY3V0ZWQgdW5kZXIgYWRkciBzcGluIGxvY2su
Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gSSBkb24ndCBsaWtlIHRoaXMgZnJhbmtseS4gVGhpcyBtZWFucyB0aGF0IHNldHRpbmcgUlgg
bW9kZSB3aGljaCB3b3VsZAo+ID4gPiA+ID4gPiA+ID4gcHJldmlvdXNseSBiZSByZWxpYWJsZSwg
bm93IGJlY29tZXMgdW5yZWxpYWJsZS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEl0IGlz
ICJ1bnJlbGlhYmxlIiBieSBkZXNpZ246Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAgICAg
ICB2b2lkICAgICAgICAgICAgICAgICAgICAoKm5kb19zZXRfcnhfbW9kZSkoc3RydWN0IG5ldF9k
ZXZpY2UgKmRldik7Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IC0gZmlyc3Qgb2YgYWxs
IGNvbmZpZ3VyYXRpb24gaXMgbm8gbG9uZ2VyIGltbWVkaWF0ZQo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gSXMgaW1tZWRpYXRlIGEgaGFyZCByZXF1aXJlbWVudD8gSSBjYW4gc2VlIGEgd29y
a3F1ZXVlIGlzIHVzZWQgYXQgbGVhc3Q6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBtbHg1
ZSwgaXBvaWIsIGVmeCwgLi4uCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICAgYW5kIHRo
ZXJlIGlzIG5vIHdheSBmb3IgZHJpdmVyIHRvIGZpbmQgb3V0IHdoZW4KPiA+ID4gPiA+ID4gPiA+
ICAgaXQgYWN0dWFsbHkgdG9vayBlZmZlY3QKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEJ1
dCB3ZSBrbm93IHJ4IG1vZGUgaXMgYmVzdCBlZmZvcnQgZS5nIGl0IGRvZXNuJ3Qgc3VwcG9ydCB2
aG9zdCBhbmQgd2UKPiA+ID4gPiA+ID4gPiBzdXJ2aXZlIGZyb20gdGhpcyBmb3IgeWVhcnMuCj4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IC0gc2Vjb25kLCBpZiBkZXZpY2UgZmFpbHMgY29t
bWFuZCwgdGhpcyBpcyBhbHNvIG5vdAo+ID4gPiA+ID4gPiA+ID4gICBwcm9wYWdhdGVkIHRvIGRy
aXZlciwgYWdhaW4gbm8gd2F5IGZvciBkcml2ZXIgdG8gZmluZCBvdXQKPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiBWRFVTRSBuZWVkcyB0byBiZSBmaXhlZCB0byBkbyB0cmlja3MgdG8g
Zml4IHRoaXMKPiA+ID4gPiA+ID4gPiA+IHdpdGhvdXQgYnJlYWtpbmcgbm9ybWFsIGRyaXZlcnMu
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJdCdzIG5vdCBzcGVjaWZpYyB0byBWRFVTRS4g
Rm9yIGV4YW1wbGUsIHdoZW4gdXNpbmcgdmlydGlvLW5ldCBpbiB0aGUKPiA+ID4gPiA+ID4gPiBV
UCBlbnZpcm9ubWVudCB3aXRoIGFueSBzb2Z0d2FyZSBjdnEgKGxpa2UgbWx4NSB2aWEgdkRQQSBv
ciBjbWEKPiA+ID4gPiA+ID4gPiB0cmFuc3BvcnQpLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gVGhhbmtzCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEhtbS4gQ2FuIHdlIGRpZmZlcmVudGlh
dGUgYmV0d2VlbiB0aGVzZSB1c2UtY2FzZXM/Cj4gPiA+ID4gPgo+ID4gPiA+ID4gSXQgZG9lc24n
dCBsb29rIGVhc3kgc2luY2Ugd2UgYXJlIGRyaXZlcnMgZm9yIHZpcnRpbyBidXMuIFVuZGVybGF5
ZXIKPiA+ID4gPiA+IGRldGFpbHMgd2VyZSBoaWRkZW4gZnJvbSB2aXJ0aW8tbmV0Lgo+ID4gPiA+
ID4KPiA+ID4gPiA+IE9yIGRvIHlvdSBoYXZlIGFueSBpZGVhcyBvbiB0aGlzPwo+ID4gPiA+ID4K
PiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4gSSBkb24ndCBrbm93LCBwYXNzIHNvbWUg
a2luZCBvZiBmbGFnIGluIHN0cnVjdCB2aXJ0cXVldWU/Cj4gPiA+ID4gICAgICAgICAiYm9vbCBz
bG93OyAvKiBUaGlzIHZxIGNhbiBiZSB2ZXJ5IHNsb3cgc29tZXRpbWVzLiBEb24ndCB3YWl0IGZv
ciBpdCEgKi8iCj4gPiA+ID4KPiA+ID4gPiA/Cj4gPiA+ID4KPiA+ID4KPiA+ID4gU28gaWYgaXQn
cyBzbG93LCBzbGVlcCwgb3RoZXJ3aXNlIHBvbGw/Cj4gPiA+Cj4gPiA+IEkgZmVlbCBzZXR0aW5n
IHRoaXMgZmxhZyBtaWdodCBiZSB0cmlja3ksIHNpbmNlIHRoZSBkcml2ZXIgZG9lc24ndAo+ID4g
PiBrbm93IHdoZXRoZXIgb3Igbm90IGl0J3MgcmVhbGx5IHNsb3cuIEUuZyBzbWFydE5JQyB2ZW5k
b3IgbWF5IGFsbG93Cj4gPiA+IHZpcnRpby1uZXQgZW11bGF0aW9uIG92ZXIgUENJLgo+ID4gPgo+
ID4gPiBUaGFua3MKPiA+Cj4gPiBkcml2ZXIgd2lsbCBoYXZlIHRoZSBjaG9pY2UsIGRlcGVuZGlu
ZyBvbiB3aGV0aGVyCj4gPiB2cSBpcyBkZXRlcm1pbmlzdGljIG9yIG5vdC4KPiAKPiBPaywgYnV0
IHRoZSBwcm9ibGVtIGlzLCBzdWNoIGJvb2xlYW5zIGFyZSBvbmx5IHVzZWZ1bCBmb3IgdmlydGlv
IHJpbmcKPiBjb2Rlcy4gQnV0IGluIHRoaXMgY2FzZSwgdmlydGlvLW5ldCBrbm93cyB3aGF0IHRv
IGRvIGZvciBjdnEuIFNvIEknbQo+IG5vdCBzdXJlIHdobyB0aGUgdXNlciBpcy4KPiAKPiBUaGFu
a3MKCkNpcmNsaW5nIGJhY2ssIHdoYXQgZXhhY3RseSBkb2VzIHRoZSBhcmNoaXRlY3R1cmUgeW91
IGFyZSB0cnlpbmcKdG8gZml4IGxvb2sgbGlrZT8gV2hvIGlzIGdvaW5nIHRvIGludHJvZHVjZSB1
bmJvdW5kZWQgbGF0ZW5jeT8KVGhlIGh5cGVydmlzb3I/IElmIHNvIGRvIHdlIG5vdCBtYXliZSB3
YW50IGEgbmV3IGZlYXR1cmUgYml0CnRoYXQgZG9jdW1lbnRzIHRoaXM/IEh5cGVydmlzb3IgdGhl
biBjYW4gZGV0ZWN0IG9sZCBndWVzdHMKdGhhdCBzcGluIGFuZCBkZWNpZGUgd2hhdCB0byBkbywg
ZS5nLiBwcmlvcml0aXNlIGN2cSBtb3JlLApvciBmYWlsIEZFQVRVUkVTX09LLgoKPiA+Cj4gPgo+
ID4gPiA+IC0tCj4gPiA+ID4gTVNUCj4gPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
