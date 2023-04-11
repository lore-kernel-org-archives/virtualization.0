Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE18AC76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 06:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 977AB417B1;
	Tue, 11 Apr 2023 06:47:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 977AB417B1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YJcp005S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Uu3wdQ0c5gB; Tue, 11 Apr 2023 06:47:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A3A414168D;
	Tue, 11 Apr 2023 06:47:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3A414168D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B5DCC0037;
	Tue, 11 Apr 2023 06:47:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1755DC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:47:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D933C6143B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:47:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D933C6143B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YJcp005S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dWwSDVx29SzE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:47:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 946FF6143A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 946FF6143A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681195640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9gO+bpW3AHSE73I26Y97+msrTI4VFvHhSOvSR3sXWM=;
 b=YJcp005SIMb5iQaX9yO4lbaZhr57TZvIfF+6rfuPafnixp1FIwcWfW9qFG+iR54fTdofPH
 Yd4fbOrmgX0AXrcLxnzdNh3DVJrJl1qdtBVt65Qaug/3QwxbqlP6J+c9cZLho29fQF/5vB
 j97vs3d5cOnyR3XwxGoCQJ17THbWokU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-3fzkNcNFMPePjVYElxkhBw-1; Tue, 11 Apr 2023 02:47:18 -0400
X-MC-Unique: 3fzkNcNFMPePjVYElxkhBw-1
Received: by mail-wm1-f72.google.com with SMTP id
 h8-20020a05600c314800b003ef649aa8c7so993102wmo.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 23:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681195637;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V9gO+bpW3AHSE73I26Y97+msrTI4VFvHhSOvSR3sXWM=;
 b=BO3EJ5KJbTm8syIsJdQrAnmTrrJnr2oNhdHyT1jXNHiQTMITTZR7U+I4LYRMFavSL1
 x5rJHUFMDumBZBc6FKPg3Ahjy9PSpTf+KHqzXM75S+68Sj2OGJgWaH3rqmJZU3AfKiVW
 ue3nkDtFRDx2H0NC8HaIaQ8PEKPJDlBTNa1B+sPUxNfzns+WLNl8u8RwScLJOEAmbquW
 yFtbcvfG8w5CN8BYaKDSyrq9Va7PibsNzAQtGaNyXRhQattaeZYhC/EfqfmRtebOILVW
 oJvd9qgicjYcUBCw3zdSt8vqEU5yFGT3ipAq4jO85G8DCsONriebNJB8Pjxqv0bsbD2R
 B8lg==
X-Gm-Message-State: AAQBX9f4OEFa8e+dHNWUVMHD/3WNo0yL/NBw+t51cDZCZ2M7Y0s1xXFc
 kfjvX16FbwdfdDuzZZTQrARdF08mMvXfHlN1tSQ0hnpn6iSE9Z4BNDLX9SD2FTo6YiYdUioUCen
 VZ+52tdC6L+9H9v3WyME59PL7spcqOAZ/kxMdrLmssw==
X-Received: by 2002:a5d:58eb:0:b0:2ce:a898:a896 with SMTP id
 f11-20020a5d58eb000000b002cea898a896mr1099893wrd.30.1681195636288; 
 Mon, 10 Apr 2023 23:47:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350Ydu2pmoQjR4kMU5a3KxFUS4XFNjSgufHz+X/MSysKL1tN1PNaTANuqPfv+5+xg+KFjjM9mHg==
X-Received: by 2002:a5d:58eb:0:b0:2ce:a898:a896 with SMTP id
 f11-20020a5d58eb000000b002cea898a896mr1099885wrd.30.1681195636004; 
 Mon, 10 Apr 2023 23:47:16 -0700 (PDT)
Received: from redhat.com ([2.52.10.80]) by smtp.gmail.com with ESMTPSA id
 m5-20020adfe945000000b002f006acacc1sm6337227wrn.97.2023.04.10.23.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 23:47:15 -0700 (PDT)
Date: Tue, 11 Apr 2023 02:47:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411024459-mutt-send-email-mst@kernel.org>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDY6MzY6MzlBTSArMDAwMCwgQW5ndXMgQ2hlbiB3cm90
ZToKPiBIaS4KPiAKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gU2VudDogVHVlc2RheSwgQXByaWwgMTEs
IDIwMjMgMToyNCBQTQo+ID4gVG86IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8u
Y29tPgo+ID4gQ2M6IG1zdEByZWRoYXQuY29tOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZzsKPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIHZpcnRpb19wY2k6IFdhaXQgZm9yIGxlZ2FjeSBkZXZpY2UgdG8gYmUg
cmVzZXQKPiA+IAo+ID4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgOTozOeKAr0FNIEFuZ3VzIENo
ZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPgo+ID4gd3JvdGU6Cj4gPiA+Cj4gPiA+IFdl
IHJlYWQgdGhlIHN0YXR1cyBvZiBkZXZpY2UgYWZ0ZXIgcmVzZXQsCj4gPiA+IEl0IGlzIG5vdCBn
dWFyYW50ZWVkIHRoYXQgdGhlIGRldmljZSBiZSByZXNldGVkIHN1Y2Nlc3NmdWxseS4KPiA+ID4g
V2UgY2FuIHVzZSBhIHdoaWxlIGxvb3AgdG8gbWFrZSBzdXJlIHRoYXQsbGlrZSB0aGUgbW9kZXJu
IGRldmljZSBkaWQuCj4gPiA+IFRoZSBzcGVjIGlzIG5vdCByZXF1ZXN0IGl0ICxidXQgaXQgd29y
ay4KPiA+IAo+ID4gVGhlIG9ubHkgY29uY2VybiBpcyBpZiBpdCdzIHRvbyBsYXRlIHRvIGRvIHRo
aXMuCj4gPiAKPiA+IEJ0dywgYW55IHJlYXNvbiB5b3Ugd2FudCB0byBoYXZlIGEgbGVnYWN5IGhh
cmR3YXJlIGltcGxlbWVudGF0aW9uLiBJdAo+ID4gd2lsbCBiZSB2ZXJ5IHRyaWNreSB0byB3b3Jr
IGNvcnJlY3RseS4KPiAgIEVuLEkgZm91bmQgdGhpcyBpbiB0aGUgcmVhbCBwcm9kdWN0aW9uIGVu
dmlyb25tZW50IHNvbWUgdGltZXMgYWJvdXQgb25lIHllYXIgYWdvLgo+IGFuZCBJIGZpeCB0aGlz
IG91dCBvZiB0cmVlLm91ciB2aXJ0aW8gY2FyZCBoYWQgYmVlbiBzb2xkIGFib3V0IHRob3VzYW5k
cyAuCj4gCj4gICBOb3csd2UgY3JlYXRlZCBhIG5ldyBjYXJkLCBpdCBzdXBwb3J0IHZpcnRpbyAw
Ljk1LDEuMCwxLjEgZXRjLgoKSSBhbSBub3QgMTAwJSBzdXJlIHdoYXQgZG9lcyB0aGlzIG1lYW4u
ClNvIGl0J3MgYSB0cmFuc2l0aW9uYWwgZGV2aWNlIHRoZW4/CgoKPiAgIEFuZCB3ZSB1c2UgdGhp
cyBob3N0IHZkcGErIGxlZ2FjeSB2aXJ0aW8gaW4gdm0gdG8gaG90IG1pZ3JhdGlvbix3ZSBmb3Vu
ZCB0aGF0IHRoZQo+ICAgTGVnYWN5IG1vZGVsIG9mdGVuIGdldCB0aGUgbWlkZGxlIHN0YXRlIHZh
bHVlIGFmdGVyIHJlc2V0IGFuZCBwcm9iZSBhZ2Fpbi4KPiAgIFRoZSBTb2MgaXMgU2ltdWxhdGVk
IGJ5IGZwZ2Egd2hpY2ggaXMgcnVuIHNsb3dlciB0aGFuIHRoZSBob3N0LHNvIHRoZSBzYW1lIGJ1
ZyAKPiAgIElzIGZvdW5kIG1vcmUgZnJlcXVlbnRseSB3aGVuIHRoZSBob3N0IHVzZSB0aGUgb3Ro
ZXIga2VybmVsIGxpa2UgdWJ1bnR1IG9yIGNlbnRvczguCj4gCj4gICBTbyB3ZSBob3BlIHdlIGNh
biBmaXggdGhpcyBieSB1cHN0cmVhbSAuCj4gPiAKPiA+IFRoYW5rcwo+ID4gCj4gPiA+Cj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPgo+
ID4gPiAtLS0KPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgfCA0ICsr
Ky0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
PiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5
LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gPiA+IGluZGV4IDIyNTdm
MWIzZDhhZS4uZjJkMjQxNTYzZTRmIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
bGVnYWN5LmMKPiA+ID4gQEAgLTE0LDYgKzE0LDcgQEAKPiA+ID4gICAqICBNaWNoYWVsIFMuIFRz
aXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4gPiAgICovCj4gPiA+Cj4gPiA+ICsjaW5jbHVkZSA8
bGludXgvZGVsYXkuaD4KPiA+ID4gICNpbmNsdWRlICJsaW51eC92aXJ0aW9fcGNpX2xlZ2FjeS5o
Igo+ID4gPiAgI2luY2x1ZGUgInZpcnRpb19wY2lfY29tbW9uLmgiCj4gPiA+Cj4gPiA+IEBAIC05
Nyw3ICs5OCw4IEBAIHN0YXRpYyB2b2lkIHZwX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2
ZGV2KQo+ID4gPiAgICAgICAgIHZwX2xlZ2FjeV9zZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYsIDAp
Owo+ID4gPiAgICAgICAgIC8qIEZsdXNoIG91dCB0aGUgc3RhdHVzIHdyaXRlLCBhbmQgZmx1c2gg
aW4gZGV2aWNlIHdyaXRlcywKPiA+ID4gICAgICAgICAgKiBpbmNsdWRpbmcgTVNpLVggaW50ZXJy
dXB0cywgaWYgYW55LiAqLwo+ID4gPiAtICAgICAgIHZwX2xlZ2FjeV9nZXRfc3RhdHVzKCZ2cF9k
ZXYtPmxkZXYpOwo+ID4gPiArICAgICAgIHdoaWxlICh2cF9sZWdhY3lfZ2V0X3N0YXR1cygmdnBf
ZGV2LT5sZGV2KSkKPiA+ID4gKyAgICAgICAgICAgICAgIG1zbGVlcCgxKTsKPiA+ID4gICAgICAg
ICAvKiBGbHVzaCBwZW5kaW5nIFZRL2NvbmZpZ3VyYXRpb24gY2FsbGJhY2tzLiAqLwo+ID4gPiAg
ICAgICAgIHZwX3N5bmNocm9uaXplX3ZlY3RvcnModmRldik7Cj4gPiA+ICB9Cj4gPiA+IC0tCj4g
PiA+IDIuMjUuMQo+ID4gPgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
