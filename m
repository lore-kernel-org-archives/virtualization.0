Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2DEC77B76
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 08:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EA9E613C7;
	Mon, 17 Apr 2023 08:08:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5EA9E613C7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MH6L1RrH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R5qYfSEk1LaE; Mon, 17 Apr 2023 08:08:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EAF5E613AF;
	Mon, 17 Apr 2023 08:08:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EAF5E613AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C63D0C0036;
	Mon, 17 Apr 2023 08:08:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 116BBC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 08:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E00D940B86
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 08:08:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E00D940B86
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MH6L1RrH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ILe_uQLoN0Kk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 08:08:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DC21441790
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC21441790
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 08:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681718879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRf4wiEpjyBNL3LfceHykmiNHxaYsED7tcpgJBRitFA=;
 b=MH6L1RrH2PsHmezZMbWvzDapORjz7GBfvHcHFLjsy7SP3l7V7tkPzjniVhY0ly9LTswXlZ
 aaxeI575i5J6xQodI8JlhWo+4obl2UIFR7gDohfnN+Oq3kdcSrwDEY908YKTxRQzfOsmvG
 MkTsb28CBmnI4/v4UIRjqu1PNBvQZSs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-EBJI7Hr6Pw6PPqfVjajCoQ-1; Mon, 17 Apr 2023 04:07:58 -0400
X-MC-Unique: EBJI7Hr6Pw6PPqfVjajCoQ-1
Received: by mail-oo1-f69.google.com with SMTP id
 k3-20020a4a9483000000b00541aa021802so7535894ooi.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 01:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681718877; x=1684310877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRf4wiEpjyBNL3LfceHykmiNHxaYsED7tcpgJBRitFA=;
 b=Q0tOigWKqvo6MjRgR4Ye6LjqBr+TdOGabrx+FeEhdJFeaI5wBOCZ09qFkWaiO78jJj
 gvn8D84tZmzEFw+ZP2P6COoQhvZiCLkRAVI1+luv/YRgVV7fyZTrHEO4IFK3rW8Ay2vC
 0No8+c0JZKV08Yh/EFJWzMo6VX+oCy6JfYeL/XcP9mweY5IfiTAfpiZ4CaeRSvA4Mirz
 VxMkdFa44fPU+Xh89nzghN/YXzdde/fypsdzPbLj4jok52J1+5i7DjYkREgmCeoL1S9C
 pXZbh+avbIWOv66w+o1j3/toxNzQbYmlaq7SZQHT08OrwjJJyNDd1R/+tBYNSPHptGar
 jyrA==
X-Gm-Message-State: AAQBX9ctuvoonbXaRjMIF1bZdfuwv53pR/xhV3KW9/H48b5fsosafC63
 lVv0t+Casgf8IlyjUtRQlOQK1CBaLVG7lu+SEKH4eoZUxO/D25/rFflOv//DvFQp9yTNYW9ER3y
 gXM6f6kIWyH2OC2Dvw9td9Eh/GcBj/tof0laM8A2ZJMFpY80QTeXYgyfyUQ==
X-Received: by 2002:a05:6870:73cf:b0:187:e1d0:ea18 with SMTP id
 a15-20020a05687073cf00b00187e1d0ea18mr1584167oan.9.1681718877369; 
 Mon, 17 Apr 2023 01:07:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350aErbSXqo8sOLku1NGjBt3RhqThCkQWIFbvOgHpRQHWQqi0IHEiNntyujnmySlXscWd8e8tHi3H+rvf2KzGy7I=
X-Received: by 2002:a05:6870:73cf:b0:187:e1d0:ea18 with SMTP id
 a15-20020a05687073cf00b00187e1d0ea18mr1584140oan.9.1681718877142; Mon, 17 Apr
 2023 01:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230413073337.31367-1-alvaro.karsz@solid-run.com>
 <20230413073337.31367-3-alvaro.karsz@solid-run.com>
In-Reply-To: <20230413073337.31367-3-alvaro.karsz@solid-run.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Apr 2023 16:07:46 +0800
Message-ID: <CACGkMEtXTZLpmH=hY-6chLiQNEG9diEu0W4VOHze--S6Jsa2HQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vdpa/snet: support the suspend vDPA callback
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

T24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgMzozM+KAr1BNIEFsdmFybyBLYXJzeiA8YWx2YXJvLmth
cnN6QHNvbGlkLXJ1bi5jb20+IHdyb3RlOgo+Cj4gV2hlbiBzdXNwZW5kIGlzIGNhbGxlZCwgdGhl
IGRyaXZlciBzZW5kcyBhIHN1c3BlbmQgY29tbWFuZCB0byB0aGUgRFBVCj4gdGhyb3VnaCB0aGUg
Y29udHJvbCBtZWNoYW5pc20uCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbHZhcm8gS2Fyc3ogPGFsdmFy
by5rYXJzekBzb2xpZC1ydW4uY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0X2N0
cmwuYyB8ICA2ICsrKysrKwo+ICBkcml2ZXJzL3ZkcGEvc29saWRydW4vc25ldF9tYWluLmMgfCAx
NSArKysrKysrKysrKysrKysKPiAgZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfdmRwYS5oIHwg
IDEgKwo+ICAzIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZkcGEvc29saWRydW4vc25ldF9jdHJsLmMgYi9kcml2ZXJzL3ZkcGEvc29saWRy
dW4vc25ldF9jdHJsLmMKPiBpbmRleCAxMGNkZTUwMmYxYS4uMzg1ODczODY0M2IgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfY3RybC5jCj4gKysrIGIvZHJpdmVycy92
ZHBhL3NvbGlkcnVuL3NuZXRfY3RybC5jCj4gQEAgLTE1LDYgKzE1LDcgQEAKPiAgZW51bSBzbmV0
X2N0cmxfb3Bjb2RlcyB7Cj4gICAgICAgICBTTkVUX0NUUkxfT1BfREVTVFJPWSA9IDEsCj4gICAg
ICAgICBTTkVUX0NUUkxfT1BfUkVBRF9WUV9TVEFURSwKPiArICAgICAgIFNORVRfQ1RSTF9PUF9T
VVNQRU5ELAo+ICB9Owo+Cj4gICNkZWZpbmUgU05FVF9DVFJMX1RJTUVPVVQgICAgICAgICAgICAg
IDIwMDAwMDAKPiBAQCAtMzIyLDMgKzMyMyw4IEBAIGludCBzbmV0X3JlYWRfdnFfc3RhdGUoc3Ry
dWN0IHNuZXQgKnNuZXQsIHUxNiBpZHgsIHN0cnVjdCB2ZHBhX3ZxX3N0YXRlICpzdGF0ZSkKPiAg
ICAgICAgIHJldHVybiBzbmV0X2N0cmxfcmVhZF9mcm9tX2RwdShzbmV0LCBTTkVUX0NUUkxfT1Bf
UkVBRF9WUV9TVEFURSwgaWR4LCBzdGF0ZSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzaXplb2YoKnN0YXRlKSk7Cj4gIH0KPiArCj4gK2ludCBzbmV0X3N1c3BlbmRf
ZGV2KHN0cnVjdCBzbmV0ICpzbmV0KQo+ICt7Cj4gKyAgICAgICByZXR1cm4gc25ldF9zZW5kX2N0
cmxfbXNnKHNuZXQsIFNORVRfQ1RSTF9PUF9TVVNQRU5ELCAwKTsKPiArfQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZkcGEvc29saWRydW4vc25ldF9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvc29saWRy
dW4vc25ldF9tYWluLmMKPiBpbmRleCA4Njc2OWY0MzZiNC4uNzM1OTU5OWUwOWUgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfbWFpbi5jCj4gKysrIGIvZHJpdmVycy92
ZHBhL3NvbGlkcnVuL3NuZXRfbWFpbi5jCj4gQEAgLTQ4Myw2ICs0ODMsMjAgQEAgc3RhdGljIHZv
aWQgc25ldF9zZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50
IG9mZnNldCwKPiAgICAgICAgICAgICAgICAgaW93cml0ZTgoKmJ1Zl9wdHIrKywgY2ZnX3B0ciAr
IGkpOwo+ICB9Cj4KPiArc3RhdGljIGludCBzbmV0X3N1c3BlbmQoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2KQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3Qgc25ldCAqc25ldCA9IHZkcGFfdG9fc25ldCh2
ZGV2KTsKPiArICAgICAgIGludCByZXQ7Cj4gKwo+ICsgICAgICAgcmV0ID0gc25ldF9zdXNwZW5k
X2RldihzbmV0KTsKPiArICAgICAgIGlmIChyZXQpCj4gKyAgICAgICAgICAgICAgIFNORVRfRVJS
KHNuZXQtPnBkZXYsICJTTkVUWyV1XSBzdXNwZW5kIGZhaWxlZCwgZXJyOiAlZFxuIiwgc25ldC0+
c2lkLCByZXQpOwo+ICsgICAgICAgZWxzZQo+ICsgICAgICAgICAgICAgICBTTkVUX0RCRyhzbmV0
LT5wZGV2LCAiU3VzcGVuZCBTTkVUWyV1XSBkZXZpY2VcbiIsIHNuZXQtPnNpZCk7Cj4gKwo+ICsg
ICAgICAgcmV0dXJuIHJldDsKPiArfQo+ICsKPiAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2Nv
bmZpZ19vcHMgc25ldF9jb25maWdfb3BzID0gewo+ICAgICAgICAgLnNldF92cV9hZGRyZXNzICAg
ICAgICAgPSBzbmV0X3NldF92cV9hZGRyZXNzLAo+ICAgICAgICAgLnNldF92cV9udW0gICAgICAg
ICAgICAgPSBzbmV0X3NldF92cV9udW0sCj4gQEAgLTUwOCw2ICs1MjIsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyBzbmV0X2NvbmZpZ19vcHMgPSB7Cj4gICAgICAgICAu
c2V0X3N0YXR1cyAgICAgICAgICAgICA9IHNuZXRfc2V0X3N0YXR1cywKPiAgICAgICAgIC5nZXRf
Y29uZmlnICAgICAgICAgICAgID0gc25ldF9nZXRfY29uZmlnLAo+ICAgICAgICAgLnNldF9jb25m
aWcgICAgICAgICAgICAgPSBzbmV0X3NldF9jb25maWcsCj4gKyAgICAgICAuc3VzcGVuZCAgICAg
ICAgICAgICAgICA9IHNuZXRfc3VzcGVuZCwKPiAgfTsKPgo+ICBzdGF0aWMgaW50IHBzbmV0X29w
ZW5fcGZfYmFyKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBzdHJ1Y3QgcHNuZXQgKnBzbmV0KQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvc29saWRydW4vc25ldF92ZHBhLmggYi9kcml2ZXJzL3Zk
cGEvc29saWRydW4vc25ldF92ZHBhLmgKPiBpbmRleCAwOWZmNjc2ZTdhMi4uM2M3OGQ0ZTdkNDgg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfdmRwYS5oCj4gKysrIGIv
ZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfdmRwYS5oCj4gQEAgLTIwMyw1ICsyMDMsNiBAQCB2
b2lkIHBzbmV0X2NyZWF0ZV9od21vbihzdHJ1Y3QgcGNpX2RldiAqcGRldik7Cj4gIHZvaWQgc25l
dF9jdHJsX2NsZWFyKHN0cnVjdCBzbmV0ICpzbmV0KTsKPiAgaW50IHNuZXRfZGVzdHJveV9kZXYo
c3RydWN0IHNuZXQgKnNuZXQpOwo+ICBpbnQgc25ldF9yZWFkX3ZxX3N0YXRlKHN0cnVjdCBzbmV0
ICpzbmV0LCB1MTYgaWR4LCBzdHJ1Y3QgdmRwYV92cV9zdGF0ZSAqc3RhdGUpOwo+ICtpbnQgc25l
dF9zdXNwZW5kX2RldihzdHJ1Y3Qgc25ldCAqc25ldCk7Cj4KPiAgI2VuZGlmIC8vX1NORVRfVkRQ
QV9IXwo+IC0tCj4gMi4zNC4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
