Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC39C6FD1C
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 06:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD3A2405FD;
	Fri, 24 Mar 2023 06:28:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD3A2405FD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BXrWQLHq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vEG66fDRzM7Y; Fri, 24 Mar 2023 06:28:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5BF32401AD;
	Fri, 24 Mar 2023 06:28:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BF32401AD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 158A1C0035;
	Fri, 24 Mar 2023 06:28:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBA42C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A847B401E5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:28:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A847B401E5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BXrWQLHq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ium1kXL4s9vt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:28:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3C0404019F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C0404019F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679639285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeXjSRfLwdb188nYRp/OaR/THnDSMW2kUowSqcUnpsU=;
 b=BXrWQLHqNVEp5AZBUMAvLv7Slm8zRyUG54Y7N3W94++8VbAif8EgWmjZPspIjkwQ2xEiSo
 hjqsvfTbGwuwAL3w+31vGMMHIkT59lx5KT8j7d3i/WRYVgKQM2Ah6nZTpMEbwcgZlo+lra
 sP4e6bIRPDuJuHRYVECVQvFGsR683Ng=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-kOaGvAnNNS-tTNKAncAK9A-1; Fri, 24 Mar 2023 02:28:04 -0400
X-MC-Unique: kOaGvAnNNS-tTNKAncAK9A-1
Received: by mail-ot1-f72.google.com with SMTP id
 r9-20020a056830134900b0069fa9f6f77fso359523otq.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 23:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679639283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qeXjSRfLwdb188nYRp/OaR/THnDSMW2kUowSqcUnpsU=;
 b=xa6izYsRFbp1nWxqpOTLLhSnIove2knS+ZmwO5IUrcuOQkfYQzpDnETlYfSyG6aUpY
 bLWpaC684syQY9tfNthqLVLeIhdG3S0yc5eidgAWU0/2nMgDRklOb6SqxcLUNtYS8jxg
 7yyRGazp76jcVnbA2lsbSyykZbQo+HO8bw4I9psYtBGgugl/iOyKBEqzWRPCezSMLOs9
 uNHdHtJ9qhimYrsBmYqZWP+kijY4PAgi9EKNu7PSBs7dTBSSfLggHHxGcJecv6SL7a8c
 t+2XcEWgNx+t01rh4Uk8Ugf7aQTaEQp0lN4YZKS0w5TXOXgebWnuYSBWd2pRpHPiMvnt
 LrOA==
X-Gm-Message-State: AO0yUKXWKFazeqhacEyno5vMbM9ZtRXTPaUMISJ9GviUVICAF/HMyP64
 lyRgEScnfy7XpVc74P/naThakIfD3saZ2Bpf5Beznc55RFqFiaVMesQEG62nom2bShEjqW6tM5f
 YAwmjnVGWDJzsqJEoOnujDmmH2Oxnrr0WU4VZG/T+Kg4idXG6q2FVVCUT/A==
X-Received: by 2002:a9d:67d8:0:b0:69f:229:ce72 with SMTP id
 c24-20020a9d67d8000000b0069f0229ce72mr730087otn.2.1679639283479; 
 Thu, 23 Mar 2023 23:28:03 -0700 (PDT)
X-Google-Smtp-Source: AK7set/zNwGCo/4/80XEpIM9DnWdRGQX0nNE6byaeqSilTsY7EeCq2IfuWvaX/hDv/JoJjxxWKANx/x9oE3B2Q4WmeI=
X-Received: by 2002:a9d:67d8:0:b0:69f:229:ce72 with SMTP id
 c24-20020a9d67d8000000b0069f0229ce72mr730078otn.2.1679639283227; Thu, 23 Mar
 2023 23:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-4-xieyongji@bytedance.com>
In-Reply-To: <20230323053043.35-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Mar 2023 14:27:52 +0800
Message-ID: <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, hch@lst.de, mst@redhat.com
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

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgMTozMeKAr1BNIFhpZSBZb25namkgPHhpZXlvbmdqaUBi
eXRlZGFuY2UuY29tPiB3cm90ZToKPgo+IFRvIHN1cHBvcnQgaW50ZXJydXB0IGFmZmluaXR5IHNw
cmVhZGluZyBtZWNoYW5pc20sCj4gdGhpcyBtYWtlcyB1c2Ugb2YgZ3JvdXBfY3B1c19ldmVubHko
KSB0byBjcmVhdGUKPiBhbiBpcnEgY2FsbGJhY2sgYWZmaW5pdHkgbWFzayBmb3IgZWFjaCB2aXJ0
cXVldWUKPiBvZiB2ZHBhIGRldmljZS4gVGhlbiB3ZSB3aWxsIHVuaWZ5IHNldF92cV9hZmZpbml0
eQo+IGNhbGxiYWNrIHRvIHBhc3MgdGhlIGFmZmluaXR5IHRvIHRoZSB2ZHBhIGRldmljZSBkcml2
ZXIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNv
bT4KClRoaW5raW5nIGhhcmQgb2YgYWxsIHRoZSBsb2dpY3MsIEkgdGhpbmsgSSd2ZSBmb3VuZCBz
b21ldGhpbmcgaW50ZXJlc3RpbmcuCgpDb21taXQgYWQ3MTQ3M2Q5YzQzNyAoInZpcnRpb19ibGs6
IHVzZSB2aXJ0aW8gSVJRIGFmZmluaXR5IikgdHJpZXMgdG8KcGFzcyBpcnFfYWZmaW5pdHkgdG8g
dHJhbnNwb3J0IHNwZWNpZmljIGZpbmRfdnFzKCkuICBUaGlzIHNlZW1zIGEKbGF5ZXIgdmlvbGF0
aW9uIHNpbmNlIGRyaXZlciBoYXMgbm8ga25vd2xlZGdlIG9mCgoxKSB3aGV0aGVyIG9yIG5vdCB0
aGUgY2FsbGJhY2sgaXMgYmFzZWQgb24gYW4gSVJRCjIpIHdoZXRoZXIgb3Igbm90IHRoZSBkZXZp
Y2UgaXMgYSBQQ0kgb3Igbm90ICh0aGUgZGV0YWlscyBhcmUgaGlkZWQgYnkKdGhlIHRyYW5zcG9y
dCBkcml2ZXIpCjMpIGhvdyBtYW55IHZlY3RvcnMgY291bGQgYmUgdXNlZCBieSBhIGRldmljZQoK
VGhpcyBtZWFucyB0aGUgZHJpdmVyIGNhbid0IGFjdHVhbGx5IHBhc3MgYSByZWFsIGFmZmluaXR5
IG1hc2tzIHNvIHRoZQpjb21taXQgcGFzc2VzIGEgemVybyBpcnEgYWZmaW5pdHkgc3RydWN0dXJl
IGFzIGEgaGludCBpbiBmYWN0LCBzbyB0aGUKUENJIGxheWVyIGNhbiBidWlsZCBhIGRlZmF1bHQg
YWZmaW5pdHkgYmFzZWQgdGhhdCBncm91cHMgY3B1cyBldmVubHkKYmFzZWQgb24gdGhlIG51bWJl
ciBvZiBNU0ktWCB2ZWN0b3JzICh0aGUgY29yZSBsb2dpYyBpcyB0aGUKZ3JvdXBfY3B1c19ldmVu
bHkpLiBJIHRoaW5rIHdlIHNob3VsZCBmaXggdGhpcyBieSByZXBsYWNpbmcgdGhlCmlycV9hZmZp
bml0eSBzdHJ1Y3R1cmUgd2l0aAoKMSkgYSBib29sZWFuIGxpa2UgYXV0b19jYl9zcHJlYWRpbmcK
Cm9yCgoyKSBxdWV1ZSB0byBjcHUgbWFwcGluZwoKU28gZWFjaCB0cmFuc3BvcnQgY2FuIGRvIGl0
cyBvd24gbG9naWMgYmFzZWQgb24gdGhhdC4gVGhlbiB2aXJ0aW8tdkRQQQpjYW4gcGFzcyB0aGF0
IHBvbGljeSB0byBWRFVTRSB3aGVyZSB3ZSBvbmx5IG5lZWQgYSBncm91cF9jcHVzX2V2ZW5seSgp
CmFuZCBhdm9pZCBkdXBsaWNhdGluZyBpcnFfY3JlYXRlX2FmZmluaXR5X21hc2tzKCk/CgpUaGFu
a3MKCj4gLS0tCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCA2OCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDY4IGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+IGluZGV4IGY3MjY5NmI0YzFjMi4uZjM4MjZmNDJi
NzA0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gQEAgLTEzLDYgKzEzLDcgQEAKPiAgI2luY2x1
ZGUgPGxpbnV4L2tlcm5lbC5oPgo+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgo+ICAjaW5jbHVk
ZSA8bGludXgvdXVpZC5oPgo+ICsjaW5jbHVkZSA8bGludXgvZ3JvdXBfY3B1cy5oPgo+ICAjaW5j
bHVkZSA8bGludXgvdmlydGlvLmg+Cj4gICNpbmNsdWRlIDxsaW51eC92ZHBhLmg+Cj4gICNpbmNs
dWRlIDxsaW51eC92aXJ0aW9fY29uZmlnLmg+Cj4gQEAgLTI3Miw2ICsyNzMsNjYgQEAgc3RhdGlj
IHZvaWQgdmlydGlvX3ZkcGFfZGVsX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAg
ICAgICAgICAgICAgICAgdmlydGlvX3ZkcGFfZGVsX3ZxKHZxKTsKPiAgfQo+Cj4gK3N0YXRpYyB2
b2lkIGRlZmF1bHRfY2FsY19zZXRzKHN0cnVjdCBpcnFfYWZmaW5pdHkgKmFmZmQsIHVuc2lnbmVk
IGludCBhZmZ2ZWNzKQo+ICt7Cj4gKyAgICAgICBhZmZkLT5ucl9zZXRzID0gMTsKPiArICAgICAg
IGFmZmQtPnNldF9zaXplWzBdID0gYWZmdmVjczsKPiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCBj
cHVtYXNrICoKPiArY3JlYXRlX2FmZmluaXR5X21hc2tzKHVuc2lnbmVkIGludCBudmVjcywgc3Ry
dWN0IGlycV9hZmZpbml0eSAqYWZmZCkKPiArewo+ICsgICAgICAgdW5zaWduZWQgaW50IGFmZnZl
Y3MgPSAwLCBjdXJ2ZWMsIHVzZWR2ZWNzLCBpOwo+ICsgICAgICAgc3RydWN0IGNwdW1hc2sgKm1h
c2tzID0gTlVMTDsKPiArCj4gKyAgICAgICBpZiAobnZlY3MgPiBhZmZkLT5wcmVfdmVjdG9ycyAr
IGFmZmQtPnBvc3RfdmVjdG9ycykKPiArICAgICAgICAgICAgICAgYWZmdmVjcyA9IG52ZWNzIC0g
YWZmZC0+cHJlX3ZlY3RvcnMgLSBhZmZkLT5wb3N0X3ZlY3RvcnM7Cj4gKwo+ICsgICAgICAgaWYg
KCFhZmZkLT5jYWxjX3NldHMpCj4gKyAgICAgICAgICAgICAgIGFmZmQtPmNhbGNfc2V0cyA9IGRl
ZmF1bHRfY2FsY19zZXRzOwo+ICsKPiArICAgICAgIGFmZmQtPmNhbGNfc2V0cyhhZmZkLCBhZmZ2
ZWNzKTsKPiArCj4gKyAgICAgICBpZiAoIWFmZnZlY3MpCj4gKyAgICAgICAgICAgICAgIHJldHVy
biBOVUxMOwo+ICsKPiArICAgICAgIG1hc2tzID0ga2NhbGxvYyhudmVjcywgc2l6ZW9mKCptYXNr
cyksIEdGUF9LRVJORUwpOwo+ICsgICAgICAgaWYgKCFtYXNrcykKPiArICAgICAgICAgICAgICAg
cmV0dXJuIE5VTEw7Cj4gKwo+ICsgICAgICAgLyogRmlsbCBvdXQgdmVjdG9ycyBhdCB0aGUgYmVn
aW5uaW5nIHRoYXQgZG9uJ3QgbmVlZCBhZmZpbml0eSAqLwo+ICsgICAgICAgZm9yIChjdXJ2ZWMg
PSAwOyBjdXJ2ZWMgPCBhZmZkLT5wcmVfdmVjdG9yczsgY3VydmVjKyspCj4gKyAgICAgICAgICAg
ICAgIGNwdW1hc2tfc2V0YWxsKCZtYXNrc1tjdXJ2ZWNdKTsKPiArCj4gKyAgICAgICBmb3IgKGkg
PSAwLCB1c2VkdmVjcyA9IDA7IGkgPCBhZmZkLT5ucl9zZXRzOyBpKyspIHsKPiArICAgICAgICAg
ICAgICAgdW5zaWduZWQgaW50IHRoaXNfdmVjcyA9IGFmZmQtPnNldF9zaXplW2ldOwo+ICsgICAg
ICAgICAgICAgICBpbnQgajsKPiArICAgICAgICAgICAgICAgc3RydWN0IGNwdW1hc2sgKnJlc3Vs
dCA9IGdyb3VwX2NwdXNfZXZlbmx5KHRoaXNfdmVjcyk7Cj4gKwo+ICsgICAgICAgICAgICAgICBp
ZiAoIXJlc3VsdCkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIGtmcmVlKG1hc2tzKTsKPiAr
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKPiArICAgICAgICAgICAgICAgfQo+
ICsKPiArICAgICAgICAgICAgICAgZm9yIChqID0gMDsgaiA8IHRoaXNfdmVjczsgaisrKQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGNwdW1hc2tfY29weSgmbWFza3NbY3VydmVjICsgal0sICZy
ZXN1bHRbal0pOwo+ICsgICAgICAgICAgICAgICBrZnJlZShyZXN1bHQpOwo+ICsKPiArICAgICAg
ICAgICAgICAgY3VydmVjICs9IHRoaXNfdmVjczsKPiArICAgICAgICAgICAgICAgdXNlZHZlY3Mg
Kz0gdGhpc192ZWNzOwo+ICsgICAgICAgfQo+ICsKPiArICAgICAgIC8qIEZpbGwgb3V0IHZlY3Rv
cnMgYXQgdGhlIGVuZCB0aGF0IGRvbid0IG5lZWQgYWZmaW5pdHkgKi8KPiArICAgICAgIGlmICh1
c2VkdmVjcyA+PSBhZmZ2ZWNzKQo+ICsgICAgICAgICAgICAgICBjdXJ2ZWMgPSBhZmZkLT5wcmVf
dmVjdG9ycyArIGFmZnZlY3M7Cj4gKyAgICAgICBlbHNlCj4gKyAgICAgICAgICAgICAgIGN1cnZl
YyA9IGFmZmQtPnByZV92ZWN0b3JzICsgdXNlZHZlY3M7Cj4gKyAgICAgICBmb3IgKDsgY3VydmVj
IDwgbnZlY3M7IGN1cnZlYysrKQo+ICsgICAgICAgICAgICAgICBjcHVtYXNrX3NldGFsbCgmbWFz
a3NbY3VydmVjXSk7Cj4gKwo+ICsgICAgICAgcmV0dXJuIG1hc2tzOwo+ICt9Cj4gKwo+ICBzdGF0
aWMgaW50IHZpcnRpb192ZHBhX2ZpbmRfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1
bnNpZ25lZCBpbnQgbnZxcywKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCB2aXJ0cXVldWUgKnZxc1tdLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnFf
Y2FsbGJhY2tfdCAqY2FsbGJhY2tzW10sCj4gQEAgLTI4Miw5ICszNDMsMTUgQEAgc3RhdGljIGlu
dCB2aXJ0aW9fdmRwYV9maW5kX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWdu
ZWQgaW50IG52cXMsCj4gICAgICAgICBzdHJ1Y3QgdmlydGlvX3ZkcGFfZGV2aWNlICp2ZF9kZXYg
PSB0b192aXJ0aW9fdmRwYV9kZXZpY2UodmRldik7Cj4gICAgICAgICBzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkcGEgPSB2ZF9nZXRfdmRwYSh2ZGV2KTsKPiAgICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBh
X2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPiArICAgICAgIHN0cnVjdCBpcnFfYWZm
aW5pdHkgZGVmYXVsdF9hZmZkID0geyAwIH07Cj4gKyAgICAgICBzdHJ1Y3QgY3B1bWFzayAqbWFz
a3M7Cj4gICAgICAgICBzdHJ1Y3QgdmRwYV9jYWxsYmFjayBjYjsKPiAgICAgICAgIGludCBpLCBl
cnIsIHF1ZXVlX2lkeCA9IDA7Cj4KPiArICAgICAgIG1hc2tzID0gY3JlYXRlX2FmZmluaXR5X21h
c2tzKG52cXMsIGRlc2MgPyBkZXNjIDogJmRlZmF1bHRfYWZmZCk7Cj4gKyAgICAgICBpZiAoIW1h
c2tzKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPiArCj4gICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgbnZxczsgKytpKSB7Cj4gICAgICAgICAgICAgICAgIGlmICghbmFtZXNbaV0p
IHsKPiAgICAgICAgICAgICAgICAgICAgICAgICB2cXNbaV0gPSBOVUxMOwo+IEBAIC0yOTgsNiAr
MzY1LDcgQEAgc3RhdGljIGludCB2aXJ0aW9fdmRwYV9maW5kX3ZxcyhzdHJ1Y3QgdmlydGlvX2Rl
dmljZSAqdmRldiwgdW5zaWduZWQgaW50IG52cXMsCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ZXJyID0gUFRSX0VSUih2cXNbaV0pOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJy
X3NldHVwX3ZxOwo+ICAgICAgICAgICAgICAgICB9Cj4gKyAgICAgICAgICAgICAgIG9wcy0+c2V0
X3ZxX2FmZmluaXR5KHZkcGEsIGksICZtYXNrc1tpXSk7Cj4gICAgICAgICB9Cj4KPiAgICAgICAg
IGNiLmNhbGxiYWNrID0gdmlydGlvX3ZkcGFfY29uZmlnX2NiOwo+IC0tCj4gMi4yMC4xCj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
