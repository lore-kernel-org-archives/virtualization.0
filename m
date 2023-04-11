Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C588C77B71
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 06:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A8A4410DE;
	Tue, 11 Apr 2023 06:44:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A8A4410DE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VsPzJcQA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7klDMSty02nC; Tue, 11 Apr 2023 06:44:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BA66F4168D;
	Tue, 11 Apr 2023 06:44:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA66F4168D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91750C0037;
	Tue, 11 Apr 2023 06:44:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51DC2C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2933F405AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:44:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2933F405AE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VsPzJcQA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eUE6FJ4g4hht
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:44:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C9FC403F9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C9FC403F9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681195470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ce3o9m8QJKudhAZFM4SLAGCXqk/LwfHWpmmOCipSLBY=;
 b=VsPzJcQAa5lIk3gJk0+0nPJlCsntqWnClj5eW9bYaGaasL87/K99fWGD0Lsh+Qpev13URy
 fIUF+i+P2QQnXJZv2ZSGubpUisxThgAhOxGvtpGmO25xcjNG+xh62M1qWhuZEVIDqkR6PT
 /lBGq2bjRX5IZHw7EA6j4Y/f0ZJite8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-I_7pxqmsNRaY82ZlxWJGZg-1; Tue, 11 Apr 2023 02:44:27 -0400
X-MC-Unique: I_7pxqmsNRaY82ZlxWJGZg-1
Received: by mail-wr1-f70.google.com with SMTP id
 l9-20020adfa389000000b002d557ec6d15so914805wrb.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 23:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681195466;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ce3o9m8QJKudhAZFM4SLAGCXqk/LwfHWpmmOCipSLBY=;
 b=Fb75Swd+e6MalhF29icQ5LVIor7ideIUQHicUN8u7V8fiRIL+yALFJj8J1fmaROWz7
 fUNZUX6+jQqq3LivlhwJLe1kuYiPbAQueRz82sEF6kNmbAJ3tQFveiIKNBRF+iO5p4Ec
 DxMxE7/dDfFDRU9ql3/TFia9+mzhex0U7Nqskqqo1S5E20+7HdIL1jnCi1+9LFJSDlI2
 qZf4RQTOpLFj5VnnUzvG5m3m0m2QJVeezcDMKHWL718YuAh6GZURuBL9WYnMVNfO1B2a
 a5gTuLu6KQgqzRrSs9rR9MG12pHYNh/9CRqWa6ArVKbfB+J2WhZ+wFTwBbtQ9evTaahh
 r+xg==
X-Gm-Message-State: AAQBX9euWLnFTym984GxpX+KFSJrnY23E5vLitkORzsoNJWINcKH1k1a
 YKHiaAc7URJojZ45KVDfWec8T2gVX4igFw3cK7pz0BrNy6WgP1ed0mL8yL9OTsR9xjIBPitRota
 LIx+/5u1gerkts+Nai1UPSziSxqSkvIYYZJo4WkUlog==
X-Received: by 2002:a5d:544b:0:b0:2ef:5d73:f6b7 with SMTP id
 w11-20020a5d544b000000b002ef5d73f6b7mr5727287wrv.13.1681195466636; 
 Mon, 10 Apr 2023 23:44:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZRDGqjLP0vISyJctE2RVlecshmpp3ic4ZGNdzUIANxMkFafXjwaw0b2tY98SsLDju/2XSNiw==
X-Received: by 2002:a5d:544b:0:b0:2ef:5d73:f6b7 with SMTP id
 w11-20020a5d544b000000b002ef5d73f6b7mr5727281wrv.13.1681195466347; 
 Mon, 10 Apr 2023 23:44:26 -0700 (PDT)
Received: from redhat.com ([2.52.10.80]) by smtp.gmail.com with ESMTPSA id
 i2-20020a05600011c200b002d7a75a2c20sm13712803wrx.80.2023.04.10.23.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 23:44:25 -0700 (PDT)
Date: Tue, 11 Apr 2023 02:44:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411024155-mutt-send-email-mst@kernel.org>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <CACGkMEuOK+XqSa93a7+ki25yjVWSzfSzd5nsqMUo8sH1=B9hRg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuOK+XqSa93a7+ki25yjVWSzfSzd5nsqMUo8sH1=B9hRg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Angus Chen <angus.chen@jaguarmicro.com>
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDI6Mzk6MzRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEFwciAxMSwgMjAyMyBhdCAyOjM24oCvUE0gQW5ndXMgQ2hlbiA8YW5ndXMu
Y2hlbkBqYWd1YXJtaWNyby5jb20+IHdyb3RlOgo+ID4KPiA+IEhpLgo+ID4KPiA+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KPiA+ID4gU2VudDogVHVlc2RheSwgQXByaWwgMTEsIDIwMjMgMToyNCBQTQo+ID4g
PiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+Cj4gPiA+IENjOiBt
c3RAcmVkaGF0LmNvbTsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7
Cj4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiA+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gdmlydGlvX3BjaTogV2FpdCBmb3IgbGVnYWN5IGRldmljZSB0byBiZSByZXNldAo+ID4g
Pgo+ID4gPiBPbiBUdWUsIEFwciAxMSwgMjAyMyBhdCA5OjM54oCvQU0gQW5ndXMgQ2hlbiA8YW5n
dXMuY2hlbkBqYWd1YXJtaWNyby5jb20+Cj4gPiA+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gV2Ug
cmVhZCB0aGUgc3RhdHVzIG9mIGRldmljZSBhZnRlciByZXNldCwKPiA+ID4gPiBJdCBpcyBub3Qg
Z3VhcmFudGVlZCB0aGF0IHRoZSBkZXZpY2UgYmUgcmVzZXRlZCBzdWNjZXNzZnVsbHkuCj4gPiA+
ID4gV2UgY2FuIHVzZSBhIHdoaWxlIGxvb3AgdG8gbWFrZSBzdXJlIHRoYXQsbGlrZSB0aGUgbW9k
ZXJuIGRldmljZSBkaWQuCj4gPiA+ID4gVGhlIHNwZWMgaXMgbm90IHJlcXVlc3QgaXQgLGJ1dCBp
dCB3b3JrLgo+ID4gPgo+ID4gPiBUaGUgb25seSBjb25jZXJuIGlzIGlmIGl0J3MgdG9vIGxhdGUg
dG8gZG8gdGhpcy4KPiA+ID4KPiA+ID4gQnR3LCBhbnkgcmVhc29uIHlvdSB3YW50IHRvIGhhdmUg
YSBsZWdhY3kgaGFyZHdhcmUgaW1wbGVtZW50YXRpb24uIEl0Cj4gPiA+IHdpbGwgYmUgdmVyeSB0
cmlja3kgdG8gd29yayBjb3JyZWN0bHkuCj4gPiAgIEVuLEkgZm91bmQgdGhpcyBpbiB0aGUgcmVh
bCBwcm9kdWN0aW9uIGVudmlyb25tZW50IHNvbWUgdGltZXMgYWJvdXQgb25lIHllYXIgYWdvLgo+
ID4gYW5kIEkgZml4IHRoaXMgb3V0IG9mIHRyZWUub3VyIHZpcnRpbyBjYXJkIGhhZCBiZWVuIHNv
bGQgYWJvdXQgdGhvdXNhbmRzIC4KPiA+Cj4gPiAgIE5vdyx3ZSBjcmVhdGVkIGEgbmV3IGNhcmQs
IGl0IHN1cHBvcnQgdmlydGlvIDAuOTUsMS4wLDEuMSBldGMuCj4gPiAgIEFuZCB3ZSB1c2UgdGhp
cyBob3N0IHZkcGErIGxlZ2FjeSB2aXJ0aW8gaW4gdm0gdG8gaG90IG1pZ3JhdGlvbix3ZSBmb3Vu
ZCB0aGF0IHRoZQo+ID4gICBMZWdhY3kgbW9kZWwgb2Z0ZW4gZ2V0IHRoZSBtaWRkbGUgc3RhdGUg
dmFsdWUgYWZ0ZXIgcmVzZXQgYW5kIHByb2JlIGFnYWluLgo+ID4gICBUaGUgU29jIGlzIFNpbXVs
YXRlZCBieSBmcGdhIHdoaWNoIGlzIHJ1biBzbG93ZXIgdGhhbiB0aGUgaG9zdCxzbyB0aGUgc2Ft
ZSBidWcKPiA+ICAgSXMgZm91bmQgbW9yZSBmcmVxdWVudGx5IHdoZW4gdGhlIGhvc3QgdXNlIHRo
ZSBvdGhlciBrZXJuZWwgbGlrZSB1YnVudHUgb3IgY2VudG9zOC4KPiA+Cj4gPiAgIFNvIHdlIGhv
cGUgd2UgY2FuIGZpeCB0aGlzIGJ5IHVwc3RyZWFtIC4KPiAKPiBJIHRoaW5rIHlvdSBjYW4gZG8g
bWVkaWF0aW9uIGluIHlvdXIgaHlwZXJ2aXNvci4KPiAKPiBXaGVuIHRyYXBwaW5nIHNldF9zdGF0
dXMoKSwgdGhlIGh5cGVydmlzb3Igd2lsbCBub3QgcmV0dXJuIHVudGlsIGl0Cj4gcmVhZHMgMCBm
cm9tIHRoZSBoYXJkd2FyZT8KPiAKPiBUaGFua3MKCk5vdGUgdGhhdCBmb3IgbGVnYWN5IGd1ZXN0
cywgMCBzdGF0dXMgd3JpdGUgaXMgbm90IHRoZSBvbmx5IHdheQp0byByZXNldCB0aGUgZGV2aWNl
LCB3cml0aW5nIDAgaW50byBwYSBpcyBhbm90aGVyLgoKCgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+
ID4KPiA+ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5A
amFndWFybWljcm8uY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX2xlZ2FjeS5jIHwgNCArKystCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9sZWdhY3kuYwo+ID4gPiA+IGluZGV4IDIyNTdmMWIzZDhhZS4uZjJkMjQxNTYzZTRmIDEwMDY0
NAo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiA+ID4g
PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gPiA+ID4gQEAgLTE0
LDYgKzE0LDcgQEAKPiA+ID4gPiAgICogIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5j
b20+Cj4gPiA+ID4gICAqLwo+ID4gPiA+Cj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5o
Pgo+ID4gPiA+ICAjaW5jbHVkZSAibGludXgvdmlydGlvX3BjaV9sZWdhY3kuaCIKPiA+ID4gPiAg
I2luY2x1ZGUgInZpcnRpb19wY2lfY29tbW9uLmgiCj4gPiA+ID4KPiA+ID4gPiBAQCAtOTcsNyAr
OTgsOCBAQCBzdGF0aWMgdm9pZCB2cF9yZXNldChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikK
PiA+ID4gPiAgICAgICAgIHZwX2xlZ2FjeV9zZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYsIDApOwo+
ID4gPiA+ICAgICAgICAgLyogRmx1c2ggb3V0IHRoZSBzdGF0dXMgd3JpdGUsIGFuZCBmbHVzaCBp
biBkZXZpY2Ugd3JpdGVzLAo+ID4gPiA+ICAgICAgICAgICogaW5jbHVkaW5nIE1TaS1YIGludGVy
cnVwdHMsIGlmIGFueS4gKi8KPiA+ID4gPiAtICAgICAgIHZwX2xlZ2FjeV9nZXRfc3RhdHVzKCZ2
cF9kZXYtPmxkZXYpOwo+ID4gPiA+ICsgICAgICAgd2hpbGUgKHZwX2xlZ2FjeV9nZXRfc3RhdHVz
KCZ2cF9kZXYtPmxkZXYpKQo+ID4gPiA+ICsgICAgICAgICAgICAgICBtc2xlZXAoMSk7Cj4gPiA+
ID4gICAgICAgICAvKiBGbHVzaCBwZW5kaW5nIFZRL2NvbmZpZ3VyYXRpb24gY2FsbGJhY2tzLiAq
Lwo+ID4gPiA+ICAgICAgICAgdnBfc3luY2hyb25pemVfdmVjdG9ycyh2ZGV2KTsKPiA+ID4gPiAg
fQo+ID4gPiA+IC0tCj4gPiA+ID4gMi4yNS4xCj4gPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
