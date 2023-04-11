Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA52EC77B6F
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 10:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4604641714;
	Tue, 11 Apr 2023 10:16:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4604641714
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=be4PBgOO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GtMSrcxRvSru; Tue, 11 Apr 2023 10:15:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BA7E415D3;
	Tue, 11 Apr 2023 10:15:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BA7E415D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0960BC0037;
	Tue, 11 Apr 2023 10:15:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27763C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 10:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E221F81F00
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 10:15:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E221F81F00
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=be4PBgOO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 24et0UNhiAps
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 10:15:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62F1881EA8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62F1881EA8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 10:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681208154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KP9DSVci9yH230xXuxpWDJ94bVH6AIL4+Sc2quvSh70=;
 b=be4PBgOO7hktru7BOEwl+XLc2nKfaE+6c+NJ+9M3BaEFrJYOShAS4qiCq/IXkxZFjUyPIe
 XdSY0bNIvIv1a5ZhGmABmMMK+L0lCTzrAh+3q//2xWN60xTKuMdOR/9zw8axB0NsdP83Pk
 H//DlUip+TjQV+PWIsQs5zY2wivAiV4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-ZYo13je-N464eUSlakeoag-1; Tue, 11 Apr 2023 06:15:53 -0400
X-MC-Unique: ZYo13je-N464eUSlakeoag-1
Received: by mail-wm1-f71.google.com with SMTP id
 bg22-20020a05600c3c9600b003ef6ee937b8so1059217wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681208152;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KP9DSVci9yH230xXuxpWDJ94bVH6AIL4+Sc2quvSh70=;
 b=X7W9fHufMsIcJGp/5cjcC03wBk4nzhL3UJUQfFVf1tdw+dnolhwCty3aL13z8b8zz8
 qchYcWRy0uwwzjodywGpsb3S9TJ2xMVEKf4lqCYT/s4dYfOt6fH26Ran/aEh7/FArZkp
 UUDRBP07djQZfN8VKbfay17iK7WroD8ilzHNqtzUHOa2n57al6pS4letCAt/udUzj7pT
 4LgjCy8DiAFPaI7uxis3seryvra8nNdHmbdLvcy0yIQNtx2D7691Y6NTrWzOdKmvvDCx
 dO1L8+XRRWOWKBT+tUxoVrXYr7xGHvBfli+1b7kyUAegnzQ4QvtWNkHJ7H2hEFK3Xzop
 niVA==
X-Gm-Message-State: AAQBX9fOmRHoZv/kFeQMzXVbeYOgVoJMhOUjfjFIkqxOsY7TDs3xc2Rk
 yIBHVMgChB+2SsF4jzSc0IL6BlQRGVdvXAWOqvWBK1rnaOA3JpCNnKQOEJPFOKKfwj/LoNc2Y5E
 D/z0Z9R0okF8ka27nw7uUGhUXQnKz9aJJELg7cCe91g==
X-Received: by 2002:a7b:c302:0:b0:3ea:d620:570a with SMTP id
 k2-20020a7bc302000000b003ead620570amr9708227wmj.38.1681208151997; 
 Tue, 11 Apr 2023 03:15:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350aIbeIZ4zRV6oCMvsm9DWkSvCFRZY3spZD+mDd/98Z+uAnxOFIXRG8cPQF5X5dbgQVMaCyfCw==
X-Received: by 2002:a7b:c302:0:b0:3ea:d620:570a with SMTP id
 k2-20020a7bc302000000b003ead620570amr9708214wmj.38.1681208151687; 
 Tue, 11 Apr 2023 03:15:51 -0700 (PDT)
Received: from redhat.com ([2.52.10.80]) by smtp.gmail.com with ESMTPSA id
 u11-20020a05600c19cb00b003ede3f5c81fsm20746541wmq.41.2023.04.11.03.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Apr 2023 03:15:51 -0700 (PDT)
Date: Tue, 11 Apr 2023 06:15:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411061409-mutt-send-email-mst@kernel.org>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411024459-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411025335-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424DB10784CA5504A10099E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411032014-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424DE523E669A3B1910D7F0859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR06MB3424DE523E669A3B1910D7F0859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDc6MzA6NDhBTSArMDAwMCwgQW5ndXMgQ2hlbiB3cm90
ZToKPiAKPiAKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBNaWNoYWVs
IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4gU2VudDogVHVlc2RheSwgQXByaWwgMTEs
IDIwMjMgMzoyMSBQTQo+ID4gVG86IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8u
Y29tPgo+ID4gQ2M6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Owo+ID4gdmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcKPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZpcnRpb19wY2k6IFdhaXQgZm9yIGxl
Z2FjeSBkZXZpY2UgdG8gYmUgcmVzZXQKPiA+IAo+ID4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQg
MDc6MTc6MTRBTSArMDAwMCwgQW5ndXMgQ2hlbiB3cm90ZToKPiA+ID4KPiA+ID4KPiA+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+ID4gPiA+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+Cj4gPiA+ID4gU2VudDogVHVlc2RheSwgQXByaWwgMTEsIDIwMjMg
Mjo1NiBQTQo+ID4gPiA+IFRvOiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNv
bT4KPiA+ID4gPiBDYzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47Cj4gPiA+ID4g
dmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcKPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSB2aXJ0aW9fcGNpOiBX
YWl0IGZvciBsZWdhY3kgZGV2aWNlIHRvIGJlIHJlc2V0Cj4gPiA+ID4KPiA+ID4gPiBPbiBUdWUs
IEFwciAxMSwgMjAyMyBhdCAwNjo0OTowM0FNICswMDAwLCBBbmd1cyBDaGVuIHdyb3RlOgo+ID4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4g
PiA+ID4gPiA+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gPiA+
ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDExLCAyMDIzIDI6NDcgUE0KPiA+ID4gPiA+ID4g
VG86IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPgo+ID4gPiA+ID4gPiBD
YzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47Cj4gPiA+ID4gPiA+IHZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnCj4gPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZpcnRpb19wY2k6IFdhaXQg
Zm9yIGxlZ2FjeSBkZXZpY2UgdG8gYmUgcmVzZXQKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gT24g
VHVlLCBBcHIgMTEsIDIwMjMgYXQgMDY6MzY6MzlBTSArMDAwMCwgQW5ndXMgQ2hlbiB3cm90ZToK
PiA+ID4gPiA+ID4gPiBIaS4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KPiA+ID4gPiA+ID4gPiA+IEZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxMSwg
MjAyMyAxOjI0IFBNCj4gPiA+ID4gPiA+ID4gPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBq
YWd1YXJtaWNyby5jb20+Cj4gPiA+ID4gPiA+ID4gPiBDYzogbXN0QHJlZGhhdC5jb207IHZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOwo+ID4gPiA+ID4gPiA+ID4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+ID4gPiA+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gdmlydGlvX3BjaTogV2FpdCBmb3IgbGVnYWN5IGRldmljZSB0byBiZSByZXNldAo+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgQXByIDExLCAyMDIzIGF0IDk6Mzni
gK9BTSBBbmd1cyBDaGVuCj4gPiA+ID4gPiA+IDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4K
PiA+ID4gPiA+ID4gPiA+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiBXZSByZWFkIHRoZSBzdGF0dXMgb2YgZGV2aWNlIGFmdGVyIHJlc2V0LAo+ID4gPiA+ID4gPiA+
ID4gPiBJdCBpcyBub3QgZ3VhcmFudGVlZCB0aGF0IHRoZSBkZXZpY2UgYmUgcmVzZXRlZCBzdWNj
ZXNzZnVsbHkuCj4gPiA+ID4gPiA+ID4gPiA+IFdlIGNhbiB1c2UgYSB3aGlsZSBsb29wIHRvIG1h
a2Ugc3VyZSB0aGF0LGxpa2UgdGhlIG1vZGVybiBkZXZpY2UKPiA+IGRpZC4KPiA+ID4gPiA+ID4g
PiA+ID4gVGhlIHNwZWMgaXMgbm90IHJlcXVlc3QgaXQgLGJ1dCBpdCB3b3JrLgo+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+IFRoZSBvbmx5IGNvbmNlcm4gaXMgaWYgaXQncyB0b28gbGF0
ZSB0byBkbyB0aGlzLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEJ0dywgYW55IHJl
YXNvbiB5b3Ugd2FudCB0byBoYXZlIGEgbGVnYWN5IGhhcmR3YXJlIGltcGxlbWVudGF0aW9uLgo+
ID4gSXQKPiA+ID4gPiA+ID4gPiA+IHdpbGwgYmUgdmVyeSB0cmlja3kgdG8gd29yayBjb3JyZWN0
bHkuCj4gPiA+ID4gPiA+ID4gICBFbixJIGZvdW5kIHRoaXMgaW4gdGhlIHJlYWwgcHJvZHVjdGlv
biBlbnZpcm9ubWVudCBzb21lIHRpbWVzIGFib3V0Cj4gPiA+ID4gb25lCj4gPiA+ID4gPiA+IHll
YXIgYWdvLgo+ID4gPiA+ID4gPiA+IGFuZCBJIGZpeCB0aGlzIG91dCBvZiB0cmVlLm91ciB2aXJ0
aW8gY2FyZCBoYWQgYmVlbiBzb2xkIGFib3V0IHRob3VzYW5kcyAuCj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiAgIE5vdyx3ZSBjcmVhdGVkIGEgbmV3IGNhcmQsIGl0IHN1cHBvcnQgdmlydGlv
IDAuOTUsMS4wLDEuMSBldGMuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEkgYW0gbm90IDEwMCUg
c3VyZSB3aGF0IGRvZXMgdGhpcyBtZWFuLgo+ID4gPiA+ID4gPiBTbyBpdCdzIGEgdHJhbnNpdGlv
bmFsIGRldmljZSB0aGVuPwo+ID4gPiA+ID4gSGkgbXN0LGl0IGlzIGEgcmVhbCBjYXJkIGluIHRo
ZSBJbiBjbG91ZCBjb21wdXRpbmcgLG5vdCB0cmFuc2l0aW9uYWwgZGV2aWNlLgo+ID4gPiA+Cj4g
PiA+ID4geWVzLCBhIHJlYWwgY2FyZC4gQnV0IHlvdSBzYWlkIGl0IHN1cHBvcnRzIDAuOTUsIDEu
MCBhbmQgMS4xIGd1ZXN0cywKPiA+ID4gPiBzbyB0aGlzIGlzIHdoYXQgdGhlIHZpcnRpbyBzcGVj
IGNhbGxzIGEgdHJhbnNpdGlvbmFsIGRldmljZSwgcmlnaHQ/Cj4gPiA+ID4KPiA+ID4gPiAJVG8g
c2ltcGxpZnkgdHJhbnNpdGlvbiBmcm9tIHRoZXNlIGVhcmxpZXIgZHJhZnQgaW50ZXJmYWNlcywK
PiA+ID4gPiAJYSBkZXZpY2UgTUFZIGltcGxlbWVudDoKPiA+ID4gPgo+ID4gPiA+IAlcYmVnaW57
ZGVzY3JpcHRpb259Cj4gPiA+ID4gCVxpdGVtW1RyYW5zaXRpb25hbCBEZXZpY2VdCj4gPiA+ID4g
CQlhIGRldmljZSBzdXBwb3J0aW5nIGJvdGggZHJpdmVycyBjb25mb3JtaW5nIHRvIHRoaXMKPiA+
ID4gPiAJCXNwZWNpZmljYXRpb24sIGFuZCBhbGxvd2luZyBsZWdhY3kgZHJpdmVycy4KPiA+ID4g
PiAJXGVuZHtkZXNjcmlwdGlvbn0KPiA+ID4gPgo+ID4gPiA+IG9yIGRpZCBJIG1pc3VuZGVyc3Rh
bmQ/Cj4gPiA+ID4KPiA+ID4gWWVzLCBJJ20gbm90IHN1cmUgd2hldGhlciBJIG1ha2UgbXlzZWxm
IGNsZWFyLgo+ID4gPiBXZSBzdXBwb3J0IHRoZSB2cml0aW8gc3BlYyAgMC45NSwgMS4wIGFuZCAx
LjEgaW4gdGhlIHNhbWUgY2FyZC4KPiA+ID4gQW5kIHRoZSBudW1lciBvZiBkZXZpY2VzIGlzIDFr
IHBlciBvbmUgY2FyZC4KPiA+ID4KPiA+ID4gQnR3LCB0aGFua3MgYSBsb3QgZm9yIHRoZSB3b3Jr
IG9mIHJlZGhhdCwgd2UganVzdCBJbXBsZW1lbnQgdGhlIHZpcnRpbyBwcm90b2NvbAo+ID4gYnkg
aGFyZHdhcmUuCj4gPiAKPiA+IFllcywgbm90IHZlcnkgY2xlYXIgc3RpbGwuIFdoYXQgYXJlIHRo
ZSBkZXZpY2UgYW5kIHZlbmRvciBJRCBvZiB0aGUKPiA+IGNhcmQ/IERvZXMgaXQgaGF2ZSB0aGUg
dmlydGlvIGNhcGFiaWxpdGllcz8KPiA+IFRoYW5rcwo+IEl0J3MgaGF2ZSB0aGUgdmlydGlvIGNh
cGFiaWxpdGllcy4gCj4gV2hlbiBpdCBpcyB1c2VkIGluIGJhcmUgbWV0YWwg77yMCj4gICAgaXQg
anVzdCB1c2UgUENJX1ZFTkRPUl9JRF9SRURIQVRfUVVNUkFORVQuCj4gV2hlbiBpdCB1c2UgaW4g
dm0sCj4gIEl0IGlzIGp1c3QgbGlrZSA6Cj4geyBQQ0lfREVWSUNFX1NVQihQQ0lfVkVORE9SX0lE
X1JFREhBVF9RVU1SQU5FVCwKPiAgICAgICAgICAgICAgVklSVElPX1RSQU5TX0lEX05FVCwKPiAg
ICAgICAgICAgICAgUENJX1ZFTkRPUl9JRF9KQUdVQVJNSUNSTywKPiAgICAgICAgICAgICAgVklS
VElPX0lEX05FVCkgfSwKPiAgICAgeyBQQ0lfREVWSUNFX1NVQihQQ0lfVkVORE9SX0lEX1JFREhB
VF9RVU1SQU5FVCwKPiAgICAgICAgICAgICAgVklSVElPX1RSQU5TX0lEX0JMT0NLLAo+ICAgICAg
ICAgICAgICBQQ0lfVkVORE9SX0lEX0pBR1VBUk1JQ1JPLAo+ICAgICAgICAgICAgICBWSVJUSU9f
SURfQkxPQ0spIH0sCj4gCgpPa2F5LiBTbyBpdCdzIGEgdHJhbnNpdGlvbmFsIGRldmljZS4gVGhl
IHF1ZXN0aW9uLCB0aGVuLAppcyBob3cgY29tZSB5b3UgZW5kIHVwIHdpdGggZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9sZWdhY3kuYwp3aXRoIGEgbW9kZXJuIGxpbnV4IGF0IGFsbD8KRGlkIHlv
dSBieSBjaGFuY2Ugc2V0IGZvcmNlX2xlZ2FjeSA9IHRydWUgPwoKCj4gPiAKPiA+ID4gPgo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICAgQW5kIHdlIHVzZSB0aGlzIGhvc3Qg
dmRwYSsgbGVnYWN5IHZpcnRpbyBpbiB2bSB0byBob3QgbWlncmF0aW9uLHdlCj4gPiA+ID4gZm91
bmQKPiA+ID4gPiA+ID4gdGhhdCB0aGUKPiA+ID4gPiA+ID4gPiAgIExlZ2FjeSBtb2RlbCBvZnRl
biBnZXQgdGhlIG1pZGRsZSBzdGF0ZSB2YWx1ZSBhZnRlciByZXNldCBhbmQgcHJvYmUKPiA+ID4g
PiBhZ2Fpbi4KPiA+ID4gPiA+ID4gPiAgIFRoZSBTb2MgaXMgU2ltdWxhdGVkIGJ5IGZwZ2Egd2hp
Y2ggaXMgcnVuIHNsb3dlciB0aGFuIHRoZSBob3N0LHNvIHRoZQo+ID4gPiA+IHNhbWUKPiA+ID4g
PiA+ID4gYnVnCj4gPiA+ID4gPiA+ID4gICBJcyBmb3VuZCBtb3JlIGZyZXF1ZW50bHkgd2hlbiB0
aGUgaG9zdCB1c2UgdGhlIG90aGVyIGtlcm5lbCBsaWtlCj4gPiA+ID4gdWJ1bnR1IG9yCj4gPiA+
ID4gPiA+IGNlbnRvczguCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAgIFNvIHdlIGhvcGUg
d2UgY2FuIGZpeCB0aGlzIGJ5IHVwc3RyZWFtIC4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8u
Y29tPgo+ID4gPiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgfCA0ICsrKy0KPiA+ID4gPiA+ID4gPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19w
Y2lfbGVnYWN5LmMKPiA+ID4gPiA+ID4gYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2Fj
eS5jCj4gPiA+ID4gPiA+ID4gPiA+IGluZGV4IDIyNTdmMWIzZDhhZS4uZjJkMjQxNTYzZTRmIDEw
MDY0NAo+ID4gPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xl
Z2FjeS5jCj4gPiA+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
bGVnYWN5LmMKPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTE0LDYgKzE0LDcgQEAKPiA+ID4gPiA+ID4g
PiA+ID4gICAqICBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4gPiA+ID4g
PiA+ID4gPiAgICovCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ICsjaW5jbHVk
ZSA8bGludXgvZGVsYXkuaD4KPiA+ID4gPiA+ID4gPiA+ID4gICNpbmNsdWRlICJsaW51eC92aXJ0
aW9fcGNpX2xlZ2FjeS5oIgo+ID4gPiA+ID4gPiA+ID4gPiAgI2luY2x1ZGUgInZpcnRpb19wY2lf
Y29tbW9uLmgiCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IEBAIC05Nyw3ICs5
OCw4IEBAIHN0YXRpYyB2b2lkIHZwX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fZGV2aWNlCj4gPiAqdmRl
dikKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICB2cF9sZWdhY3lfc2V0X3N0YXR1cygmdnBfZGV2
LT5sZGV2LCAwKTsKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAvKiBGbHVzaCBvdXQgdGhlIHN0
YXR1cyB3cml0ZSwgYW5kIGZsdXNoIGluIGRldmljZSB3cml0ZXMsCj4gPiA+ID4gPiA+ID4gPiA+
ICAgICAgICAgICogaW5jbHVkaW5nIE1TaS1YIGludGVycnVwdHMsIGlmIGFueS4gKi8KPiA+ID4g
PiA+ID4gPiA+ID4gLSAgICAgICB2cF9sZWdhY3lfZ2V0X3N0YXR1cygmdnBfZGV2LT5sZGV2KTsK
PiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICB3aGlsZSAodnBfbGVnYWN5X2dldF9zdGF0dXMoJnZw
X2Rldi0+bGRldikpCj4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBtc2xlZXAoMSk7
Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgLyogRmx1c2ggcGVuZGluZyBWUS9jb25maWd1cmF0
aW9uIGNhbGxiYWNrcy4gKi8KPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICB2cF9zeW5jaHJvbml6
ZV92ZWN0b3JzKHZkZXYpOwo+ID4gPiA+ID4gPiA+ID4gPiAgfQo+ID4gPiA+ID4gPiA+ID4gPiAt
LQo+ID4gPiA+ID4gPiA+ID4gPiAyLjI1LjEKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4KPiA+ID4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
