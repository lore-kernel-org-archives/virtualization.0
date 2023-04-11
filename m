Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7079FC7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 06:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E9E64014B;
	Tue, 11 Apr 2023 06:39:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E9E64014B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=flgEFjPd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AFil77q2nTsz; Tue, 11 Apr 2023 06:39:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 955054017A;
	Tue, 11 Apr 2023 06:39:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 955054017A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BEBDC0037;
	Tue, 11 Apr 2023 06:39:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3ED2C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF67160EA6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:39:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF67160EA6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=flgEFjPd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id no10GhDU972M
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:39:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC3D160B0E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC3D160B0E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681195189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmgGEYzkVZaUbgzmMbzoh5F6gwzYR6Zn8qNHV7angps=;
 b=flgEFjPdue/bw4yFAYuuZ5kdCzVMB4x4oxZcm67IE83aZ5+Y4TkDNUPh28wy5Y87Qppd52
 R5Z59zLcTs4QkKj55dxIOwhVC2j/77Mo+I9SajoBZcLwFU/Ft20UwKF2FIgyCIRvNjgo/U
 4ffKPWhwHsYhR5BbKq3vTqgF/KR6G68=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-r8nwP4QRPHCmO0Lb3zbPpw-1; Tue, 11 Apr 2023 02:39:46 -0400
X-MC-Unique: r8nwP4QRPHCmO0Lb3zbPpw-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1840d4e9758so5702054fac.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 23:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681195186; x=1683787186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmgGEYzkVZaUbgzmMbzoh5F6gwzYR6Zn8qNHV7angps=;
 b=oQifej28JC/9XWOVylR8ja935okFI5VX7OZ0NGe5EHYVSfMNSEAZa/HHAy3fU9bPZs
 hscOJEYo8EOeouf70lxM7XoAqOiBZk26tcwhDVFaKqZPV5XcMX8Hua7UT+n1lbxQUjZ7
 3Ba+l9BpZhhuhc/YxSa5+Z/pT5UTrIWx5NGkP2a1pNnTISiLpSPNcfHe5VWS1Bz2+oy7
 P6ATfYwidkjT8GclOIuVWJi383Eo6BgSWvcThINJDcSs127pV26dPcx9vMIDF09Y3TgW
 iwSDfqy9luCcqnK7BBTKFPZ1fKkbd48pJzneazmyrU5X8QtCjeyiWTgggCe49JcceRAC
 ZRgw==
X-Gm-Message-State: AAQBX9f3nrG+wWSMJgMdKl8P522FtQimBlmrmxoa7lF6MGWvVo7OeLop
 jOOjC2W3D564vlsCcUNl2ldvfhEdQlyz7QjDYvdKzcsAAmZS8ld4Yb7K6Eo/HJVTz8H36GlmunJ
 PO2G2z1ewV+k8ChiVqFGEE4HtYHrwnTs55+DJSl4d1dFGTtKaRJu6fmjstA==
X-Received: by 2002:a54:4108:0:b0:389:86c3:b1fb with SMTP id
 l8-20020a544108000000b0038986c3b1fbmr1861477oic.9.1681195185870; 
 Mon, 10 Apr 2023 23:39:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZEuZdp/C/o7wvVXcAKKH0TG5seFsikb2lfTlxMLNcl5IJsjXU5OmKoZpXD/zEuzPQwxMhpCJdcfqdotgxeon8=
X-Received: by 2002:a54:4108:0:b0:389:86c3:b1fb with SMTP id
 l8-20020a544108000000b0038986c3b1fbmr1861473oic.9.1681195185664; Mon, 10 Apr
 2023 23:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 14:39:34 +0800
Message-ID: <CACGkMEuOK+XqSa93a7+ki25yjVWSzfSzd5nsqMUo8sH1=B9hRg@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
To: Angus Chen <angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMjozNuKAr1BNIEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5A
amFndWFybWljcm8uY29tPiB3cm90ZToKPgo+IEhpLgo+Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQo+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+IFNl
bnQ6IFR1ZXNkYXksIEFwcmlsIDExLCAyMDIzIDE6MjQgUE0KPiA+IFRvOiBBbmd1cyBDaGVuIDxh
bmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4KPiA+IENjOiBtc3RAcmVkaGF0LmNvbTsgdmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7Cj4gPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSB2aXJ0aW9fcGNpOiBXYWl0IGZv
ciBsZWdhY3kgZGV2aWNlIHRvIGJlIHJlc2V0Cj4gPgo+ID4gT24gVHVlLCBBcHIgMTEsIDIwMjMg
YXQgOTozOeKAr0FNIEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPgo+ID4g
d3JvdGU6Cj4gPiA+Cj4gPiA+IFdlIHJlYWQgdGhlIHN0YXR1cyBvZiBkZXZpY2UgYWZ0ZXIgcmVz
ZXQsCj4gPiA+IEl0IGlzIG5vdCBndWFyYW50ZWVkIHRoYXQgdGhlIGRldmljZSBiZSByZXNldGVk
IHN1Y2Nlc3NmdWxseS4KPiA+ID4gV2UgY2FuIHVzZSBhIHdoaWxlIGxvb3AgdG8gbWFrZSBzdXJl
IHRoYXQsbGlrZSB0aGUgbW9kZXJuIGRldmljZSBkaWQuCj4gPiA+IFRoZSBzcGVjIGlzIG5vdCBy
ZXF1ZXN0IGl0ICxidXQgaXQgd29yay4KPiA+Cj4gPiBUaGUgb25seSBjb25jZXJuIGlzIGlmIGl0
J3MgdG9vIGxhdGUgdG8gZG8gdGhpcy4KPiA+Cj4gPiBCdHcsIGFueSByZWFzb24geW91IHdhbnQg
dG8gaGF2ZSBhIGxlZ2FjeSBoYXJkd2FyZSBpbXBsZW1lbnRhdGlvbi4gSXQKPiA+IHdpbGwgYmUg
dmVyeSB0cmlja3kgdG8gd29yayBjb3JyZWN0bHkuCj4gICBFbixJIGZvdW5kIHRoaXMgaW4gdGhl
IHJlYWwgcHJvZHVjdGlvbiBlbnZpcm9ubWVudCBzb21lIHRpbWVzIGFib3V0IG9uZSB5ZWFyIGFn
by4KPiBhbmQgSSBmaXggdGhpcyBvdXQgb2YgdHJlZS5vdXIgdmlydGlvIGNhcmQgaGFkIGJlZW4g
c29sZCBhYm91dCB0aG91c2FuZHMgLgo+Cj4gICBOb3csd2UgY3JlYXRlZCBhIG5ldyBjYXJkLCBp
dCBzdXBwb3J0IHZpcnRpbyAwLjk1LDEuMCwxLjEgZXRjLgo+ICAgQW5kIHdlIHVzZSB0aGlzIGhv
c3QgdmRwYSsgbGVnYWN5IHZpcnRpbyBpbiB2bSB0byBob3QgbWlncmF0aW9uLHdlIGZvdW5kIHRo
YXQgdGhlCj4gICBMZWdhY3kgbW9kZWwgb2Z0ZW4gZ2V0IHRoZSBtaWRkbGUgc3RhdGUgdmFsdWUg
YWZ0ZXIgcmVzZXQgYW5kIHByb2JlIGFnYWluLgo+ICAgVGhlIFNvYyBpcyBTaW11bGF0ZWQgYnkg
ZnBnYSB3aGljaCBpcyBydW4gc2xvd2VyIHRoYW4gdGhlIGhvc3Qsc28gdGhlIHNhbWUgYnVnCj4g
ICBJcyBmb3VuZCBtb3JlIGZyZXF1ZW50bHkgd2hlbiB0aGUgaG9zdCB1c2UgdGhlIG90aGVyIGtl
cm5lbCBsaWtlIHVidW50dSBvciBjZW50b3M4Lgo+Cj4gICBTbyB3ZSBob3BlIHdlIGNhbiBmaXgg
dGhpcyBieSB1cHN0cmVhbSAuCgpJIHRoaW5rIHlvdSBjYW4gZG8gbWVkaWF0aW9uIGluIHlvdXIg
aHlwZXJ2aXNvci4KCldoZW4gdHJhcHBpbmcgc2V0X3N0YXR1cygpLCB0aGUgaHlwZXJ2aXNvciB3
aWxsIG5vdCByZXR1cm4gdW50aWwgaXQKcmVhZHMgMCBmcm9tIHRoZSBoYXJkd2FyZT8KClRoYW5r
cwoKPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIENo
ZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPgo+ID4gPiAtLS0KPiA+ID4gIGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgfCA0ICsrKy0KPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX2xlZ2FjeS5jCj4gPiA+IGluZGV4IDIyNTdmMWIzZDhhZS4uZjJkMjQxNTYzZTRmIDEw
MDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gPiA+
ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiA+ID4gQEAgLTE0LDYg
KzE0LDcgQEAKPiA+ID4gICAqICBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+
ID4gPiAgICovCj4gPiA+Cj4gPiA+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KPiA+ID4gICNp
bmNsdWRlICJsaW51eC92aXJ0aW9fcGNpX2xlZ2FjeS5oIgo+ID4gPiAgI2luY2x1ZGUgInZpcnRp
b19wY2lfY29tbW9uLmgiCj4gPiA+Cj4gPiA+IEBAIC05Nyw3ICs5OCw4IEBAIHN0YXRpYyB2b2lk
IHZwX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiAgICAgICAgIHZwX2xl
Z2FjeV9zZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYsIDApOwo+ID4gPiAgICAgICAgIC8qIEZsdXNo
IG91dCB0aGUgc3RhdHVzIHdyaXRlLCBhbmQgZmx1c2ggaW4gZGV2aWNlIHdyaXRlcywKPiA+ID4g
ICAgICAgICAgKiBpbmNsdWRpbmcgTVNpLVggaW50ZXJydXB0cywgaWYgYW55LiAqLwo+ID4gPiAt
ICAgICAgIHZwX2xlZ2FjeV9nZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYpOwo+ID4gPiArICAgICAg
IHdoaWxlICh2cF9sZWdhY3lfZ2V0X3N0YXR1cygmdnBfZGV2LT5sZGV2KSkKPiA+ID4gKyAgICAg
ICAgICAgICAgIG1zbGVlcCgxKTsKPiA+ID4gICAgICAgICAvKiBGbHVzaCBwZW5kaW5nIFZRL2Nv
bmZpZ3VyYXRpb24gY2FsbGJhY2tzLiAqLwo+ID4gPiAgICAgICAgIHZwX3N5bmNocm9uaXplX3Zl
Y3RvcnModmRldik7Cj4gPiA+ICB9Cj4gPiA+IC0tCj4gPiA+IDIuMjUuMQo+ID4gPgo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
