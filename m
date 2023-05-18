Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E395AC7EE22
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 08:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B3F960F67;
	Thu, 18 May 2023 08:59:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B3F960F67
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LmZ/nYy3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PshiUgbml16R; Thu, 18 May 2023 08:59:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 96EE660D89;
	Thu, 18 May 2023 08:59:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96EE660D89
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B894C0036;
	Thu, 18 May 2023 08:59:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3840CC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 08:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12C9F81ADE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 08:59:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12C9F81ADE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LmZ/nYy3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0chKESkxsbKx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 08:59:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E905281A6F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E905281A6F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 08:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684400372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sylAFlhHYXJQoZMbNZQar4J1+l62LkKgUUxgm+1SQxo=;
 b=LmZ/nYy3Cp75BQVbcl+IobUS+HAXSVz8ZIl+9C9CdIGNUhbdZtnZT5FBUVthRogCRsp3sK
 SkrUNszMUfgT7lkugQelDTC1VCoznuTzYd2+yJmBP3foLXAiypfXEKBJ9CtzBZK8la5Ndg
 gzVwe1b32tA2uoawyX4xg2PacjZ7SmA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Y4BkTn1FPc-eUw1rQkVoRQ-1; Thu, 18 May 2023 04:59:30 -0400
X-MC-Unique: Y4BkTn1FPc-eUw1rQkVoRQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ac844e65e6so8986991fa.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 01:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684400369; x=1686992369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sylAFlhHYXJQoZMbNZQar4J1+l62LkKgUUxgm+1SQxo=;
 b=ACucQwwk4/hsspQ4Rpsad3ssyIzoUnERsx093goxRHE4wJrPpjCZtCq/mWr9GLoovh
 6kU9CfR/M5Utcw8MgaB+JYM/53xeJO6f/AbZQOk7L4hO+XCFYsh6VeDVLo4yFlMMzXTj
 Z6wAqb052un6uYu43dSdQocRUBtK/hzEFmBjiC0DwDLUDfWjClcVZRkLeQQqoa5QcPTk
 fwSE8n5SS1UliFuRo3HxMgkRP9zcRSqzZOoxbbPGjqgT8YyKemvjx4QPONGZciG59dJn
 0ameK18PMhgxD5pf7CsbO/6zjCe1RD6NBhN23q0+vVGanfU82nFUoVrjCwvuOSR6bBkc
 1J2w==
X-Gm-Message-State: AC+VfDyQkLYtvW14lkCCgiMmf71JThSD9uPWyFiPNSWR2nn5SzmrbIQE
 oDiVjdlfsObgPKT8q0wppPdAYWibABfWZIWDDc+2PThkRbHdf8tSd8a8T2p7f+xf7kP6lF5Y1w3
 5TdlasQSD1jMI2dRakBNir891qrOwnFjFiCkCfQH6jYvdqxiSBjFMPg647A==
X-Received: by 2002:a05:651c:212:b0:2a8:c75c:96cb with SMTP id
 y18-20020a05651c021200b002a8c75c96cbmr10550014ljn.1.1684400369146; 
 Thu, 18 May 2023 01:59:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7IrjHDiU8Wl6iwzde3Suv3iPYO3eNY2swqptTLGwD7xD8nl5OtkiL5QH8liEJGRgv3sy6IkxaKe33S6qnvDe8=
X-Received: by 2002:a05:651c:212:b0:2a8:c75c:96cb with SMTP id
 y18-20020a05651c021200b002a8c75c96cbmr10550001ljn.1.1684400368831; Thu, 18
 May 2023 01:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230424225031.18947-3-shannon.nelson@amd.com>
 <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
 <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
 <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
 <dcfb15e6-a4c9-cb91-becd-a1e56e14d340@amd.com>
 <CACGkMEsNo4O0uAdO5koXgYbgQLoOWp81KNjsaZYSuQ7YzjvPbA@mail.gmail.com>
 <CAGxU2F4kwnGq41q99nx879Y4Br=0aeZsf2bjx2ZqpOc93G_gDQ@mail.gmail.com>
 <CACGkMEsi0Vu21ZX2WZuEWNKQ4KTGA1iNb6+8SHeCb+Penqxr8g@mail.gmail.com>
 <CAGxU2F63yQuc-eefSkEKZKZUxpnS4myGhNP2Bkj+QQk01Pi_yg@mail.gmail.com>
 <CACGkMEudGC8jbCyD6A4mCpeBomatZ88t+5WahLGAxe9vaYH6fw@mail.gmail.com>
 <20230518043114-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230518043114-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 May 2023 16:59:17 +0800
Message-ID: <CACGkMEvcM=M9XdFN2=tFGi-rNgfwS7SWhRagMkpLzqtS46Yn_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 drivers@pensando.io
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

T24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgNDozOOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgMDM6NTI6MTBQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIFRodSwgTWF5IDE4LCAyMDIzIGF0IDM6
MzTigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+
ID4gPgo+ID4gPiBPbiBUaHUsIE1heSAxOCwgMjAyMyBhdCA3OjI04oCvQU0gSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBXZWQsIE1heSAx
NywgMjAyMyBhdCAzOjAw4oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBXZWQsIE1heSAxNywgMjAyMyBhdCA3
OjI24oCvQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IE9uIFdlZCwgTWF5IDE3LCAyMDIzIGF0IDI6MjbigK9BTSBTaGFubm9u
IE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiBPbiA1LzE2LzIzIDEyOjQ5IEFNLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIE1heSAxNSwgMjAyMyBhdCAwMTo0MToxMlBNIC0wNzAw
LCBTaGFubm9uIE5lbHNvbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+PiBPbiA1LzkvMjMgMTo0NiBB
TSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4+PiBPbiBNb24sIEFw
ciAyNCwgMjAyMyBhdCAwMzo1MDozMFBNIC0wNzAwLCBTaGFubm9uIE5lbHNvbiB2aWEKPiA+ID4g
PiA+ID4gPiA+Pj4gVmlydHVhbGl6YXRpb24gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPj4+PiBVc2Ug
dGhlIHJpZ2h0IHN0cnVjdHMgZm9yIFBBQ0tFRCBvciBzcGxpdCB2cXMgd2hlbiBzZXR0aW5nIGFu
ZAo+ID4gPiA+ID4gPiA+ID4+Pj4gZ2V0dGluZyB0aGUgdnJpbmcgYmFzZS4KPiA+ID4gPiA+ID4g
PiA+Pj4+Cj4gPiA+ID4gPiA+ID4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8
c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4KPiA+ID4gPiA+ID4gPiA+Pj4+IC0tLQo+ID4gPiA+ID4g
PiA+ID4+Pj4gZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMTggKysrKysrKysrKysrKy0tLS0tCj4g
PiA+ID4gPiA+ID4gPj4+PiBkcml2ZXJzL3Zob3N0L3Zob3N0LmggfCAgOCArKysrKystLQo+ID4g
PiA+ID4gPiA+ID4+Pj4gMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0
aW9ucygtKQo+ID4gPiA+ID4gPiA+ID4+Pj4KPiA+ID4gPiA+ID4gPiA+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+ID4gPiA+
ID4gPiA+Pj4+IGluZGV4IGYxMWJkYmU0YzJjNS4uZjY0ZWZkYTQ4ZjIxIDEwMDY0NAo+ID4gPiA+
ID4gPiA+ID4+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gPiA+ID4gPiA+ID4gPj4+
PiArKysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+ID4gPiA+ID4gPiA+Pj4+IEBAIC0xNjMz
LDE3ICsxNjMzLDI1IEBAIGxvbmcgdmhvc3RfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0X2Rldgo+
ID4gPiA+ID4gPiA+ID4+Pj4gKmQsIHVuc2lnbmVkIGludCBpb2N0bCwgdm9pZCBfX3VzZXIgKmFy
Zwo+ID4gPiA+ID4gPiA+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgIHIgPSAtRUZBVUxUOwo+
ID4gPiA+ID4gPiA+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiA+ID4g
PiA+ID4+Pj4gICAgICAgICAgICAgICB9Cj4gPiA+ID4gPiA+ID4gPj4+PiAtICAgICAgICAgICAg
ICBpZiAocy5udW0gPiAweGZmZmYpIHsKPiA+ID4gPiA+ID4gPiA+Pj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgciA9IC1FSU5WQUw7Cj4gPiA+ID4gPiA+ID4gPj4+PiAtICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOwo+ID4gPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgaWYgKHZob3N0
X2hhc19mZWF0dXJlKHZxLCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCkpIHsKPiA+ID4gPiA+ID4gPiA+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgdnEtPmxhc3RfYXZhaWxfaWR4ID0gcy5udW0gJiAw
eGZmZmY7Cj4gPiA+ID4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgIHZxLT5sYXN0
X3VzZWRfaWR4ID0gKHMubnVtID4+IDE2KSAmIDB4ZmZmZjsKPiA+ID4gPiA+ID4gPiA+Pj4+ICsg
ICAgICAgICAgICAgIH0gZWxzZSB7Cj4gPiA+ID4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgIGlmIChzLm51bSA+IDB4ZmZmZikgewo+ID4gPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHIgPSAtRUlOVkFMOwo+ID4gPiA+ID4gPiA+ID4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiA+ID4gPiA+ID4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICB9Cj4gPiA+ID4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgIHZxLT5sYXN0X2F2YWlsX2lkeCA9IHMubnVtOwo+ID4gPiA+ID4gPiA+ID4+Pj4gICAg
ICAgICAgICAgICB9Cj4gPiA+ID4gPiA+ID4gPj4+PiAtICAgICAgICAgICAgICB2cS0+bGFzdF9h
dmFpbF9pZHggPSBzLm51bTsKPiA+ID4gPiA+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgLyogRm9y
Z2V0IHRoZSBjYWNoZWQgaW5kZXggdmFsdWUuICovCj4gPiA+ID4gPiA+ID4gPj4+PiAgICAgICAg
ICAgICAgIHZxLT5hdmFpbF9pZHggPSB2cS0+bGFzdF9hdmFpbF9pZHg7Cj4gPiA+ID4gPiA+ID4g
Pj4+PiAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiA+ID4gPiA+ID4+Pj4gICAgICAgY2FzZSBW
SE9TVF9HRVRfVlJJTkdfQkFTRToKPiA+ID4gPiA+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgcy5p
bmRleCA9IGlkeDsKPiA+ID4gPiA+ID4gPiA+Pj4+IC0gICAgICAgICAgICAgIHMubnVtID0gdnEt
Pmxhc3RfYXZhaWxfaWR4Owo+ID4gPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgaWYgKHZo
b3N0X2hhc19mZWF0dXJlKHZxLCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCkpCj4gPiA+ID4gPiA+ID4g
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgIHMubnVtID0gKHUzMil2cS0+bGFzdF9hdmFpbF9p
ZHggfAo+ID4gPiA+ID4gPiA+ID4+Pj4gKCh1MzIpdnEtPmxhc3RfdXNlZF9pZHggPDwgMTYpOwo+
ID4gPiA+ID4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgZWxzZQo+ID4gPiA+ID4gPiA+ID4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICBzLm51bSA9IHZxLT5sYXN0X2F2YWlsX2lkeDsKPiA+ID4g
PiA+ID4gPiA+Pj4KPiA+ID4gPiA+ID4gPiA+Pj4gVGhlIGNoYW5nZXMgTEdUTSwgYnV0IHNpbmNl
IHdlIGFyZSBjaGFuZ2luZyB0aGUgVUFQSSwgc2hvdWxkIHdlCj4gPiA+ID4gPiA+ID4gPj4+IHVw
ZGF0ZSB0aGUgZG9jdW1lbnRhdGlvbiBvZiBWSE9TVF9TRVRfVlJJTkdfQkFTRSBhbmQKPiA+ID4g
PiA+ID4gPiA+Pj4gVkhPU1RfR0VUX1ZSSU5HX0JBU0UgaW4gaW5jbHVkZS91YXBpL2xpbnV4L3Zo
b3N0Lmg/Cj4gPiA+ID4gPiA+ID4gPj4KPiA+ID4gPiA+ID4gPiA+PiBDb3JyZWN0IG1lIGlmIEkn
bSB3cm9uZywgYnV0IEkgZG9uJ3QgdGhpbmsgd2UncmUgY2hhbmdpbmcgYW55dGhpbmcgaW4KPiA+
ID4gPiA+ID4gPiA+PiB0aGUgVUFQSSBoZXJlLCBqdXN0IGZpeGluZyBjb2RlIHRvIHdvcmsgY29y
cmVjdGx5IHdpdGggd2hhdCBpcyBhbHJlYWR5Cj4gPiA+ID4gPiA+ID4gPj4gaGFwcGVuaW5nLgo+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IElJVUMgYmVmb3JlIHRoaXMgcGF0Y2ggVkhP
U1RfR0VUX1ZSSU5HX0JBU0UgYW5kIFZIT1NUX1NFVF9WUklOR19CQVNFCj4gPiA+ID4gPiA+ID4g
PiBuZXZlciB3b3JrZWQgd2l0aCBwYWNrZWQgdmlydHF1ZXVlLCBzaW5jZSB3ZSB3ZXJlIG9ubHkg
aGFuZGxpbmcKPiA+ID4gPiA+ID4gPiA+IGxhc3RfYXZhaWxfaWR4LiBOb3cgd2UgYXJlIHN1cHBv
cnRpbmcgcGFja2VkIHZpcnRxdWV1ZSwgaGFuZGxpbmcKPiA+ID4gPiA+ID4gPiA+IGluIHZob3N0
X3ZyaW5nX3N0YXRlLm51bSBib3RoIGxhc3RfYXZhaWxfaWR4IGFuZCBsYXN0X3VzZWRfaWR4ICh3
aXRoCj4gPiA+ID4gPiA+ID4gPiB3cmFwIGNvdW50ZXJzKS4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiBGb3IgZXhhbXBsZSBmb3IgVkhPU1RfR0VUX1ZSSU5HX0JBU0Ugd2hlcmUgaXMg
ZG9jdW1lbnRlZCB0aGF0IHRoZSBmaXJzdAo+ID4gPiA+ID4gPiA+ID4gMTUgYml0cyBhcmUgbGFz
dF9hdmFpbF9pZHgsIHRoZSAxNnRoIHRoZSBhdmFpbF93cmFwX2NvdW50ZXIsIGFuZCB0aGUKPiA+
ID4gPiA+ID4gPiA+IG90aGVycyBhcmUgbGFzdF91c2VkX2lkeCBhbmQgdXNlZF93cmFwX2NvdW50
ZXI/Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gTWF5YmUgSSBtaXNzZWQgc29tZXRo
aW5nLCBidXQgc2luY2UgdGhpcyBpcyBVQVBJLCBJTUhPIHdlIHNob3VsZAo+ID4gPiA+ID4gPiA+
ID4gZG9jdW1lbnQgdGhlIHBhcmFtZXRlcnMgb2YgaW9jdGxzIGF0IGxlYXN0IGluCj4gPiA+ID4g
PiA+ID4gPiBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaC4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+IFBlcmhhcHMgSmFzb24gYWxyZWFkeSBoYXMgc29tZXRoaW5nIHdyaXR0ZW4gdXAgdGhh
dCBjb3VsZCBiZSBwdXQgaW4gaGVyZQo+ID4gPiA+ID4gPiA+IGZyb20gd2hlbiBoZSBmaXJzdCBh
ZGRlZCB0aGUgd3JhcF9jb3VudGVyIGEgY291cGxlIG9mIHllYXJzIGFnbz8KPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gSWYgeW91IG1lYW50IHRoZSB2aXJ0aW8gZHJpdmVyIHN1cHBvcnQgZm9yIHBh
Y2tlZCwgSSB0aGluayBpdCdzCj4gPiA+ID4gPiA+IGRpZmZlcmVudCBmcm9tIHRoZSBjb250ZXh0
IHdoaWNoIGlzIHZob3N0IGhlcmUuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEkgYWdyZWUgd2l0
aCBTdGVmYW5vIHRoYXQgd2UgbmVlZCB0byB1cGRhdGUgdGhlIGNvbW1lbnRzIGFyb3VuZAo+ID4g
PiA+ID4gPiBHRVRfVlJJTkdfQkFTRSBhbmQgU0VUX1ZSSU5HX0JBU0UsIHRoZW4gd2UgYXJlIGZp
bmUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gSSdtIHRoaW5raW5nIGlmIHdlIHNob3VsZCBhbHNvIGFk
ZCBhIG5ldyBWSE9TVF9CQUNLRU5EX0ZfUklOR19QQUNLRUQKPiA+ID4gPiA+IGZlYXR1cmUgKG9y
IHNvbWV0aGluZyBzaW1pbGFyKSB0byBpbmZvcm0gdGhlIHVzZXIgc3BhY2UgdGhhdCBub3cgd2UK
PiA+ID4gPiA+IGFyZSBhYmxlIHRvIGhhbmRsZSBwYWNrZWQgdmlydHF1ZXVlIHRocm91Z2ggdmhv
c3QgSU9DVExzLCBvdGhlcndpc2UKPiA+ID4gPiA+IGhvdyBjYW4gdGhlIHVzZXJzcGFjZSBrbm93
IGlmIGl0IGlzIHN1cHBvcnRlZCBvciBub3Q/Cj4gPiA+ID4KPiA+ID4gPiBJIHByb2JhYmx5IHVu
ZGVyc3RhbmQgdGhpcyBidXQgSSB0aGluayBpdCBzaG91bGQgYmUgZG9uZSB2aWEKPiA+ID4gPiBW
SE9TVF9HRVRfRkVBRVRVUkVTLiBJdCB3b3VsZCBiZSBhIGJ1cmRlbiBpZiB3ZSBtYXRpYW5pbmcg
ZHVwbGljYXRlZAo+ID4gPiA+IGZlYXR1cmVzLgo+ID4gPgo+ID4gPiBHb29kIHBvaW50LCBJIHNl
ZS4KPiA+ID4KPiA+ID4gSSB0aGluayB3ZSBzaG91bGQgZG8gb25lIG9mIHRoZXNlIHRoaW5ncywg
dGhvdWdoOgo+ID4gPiAtIG1hc2sgVklSVElPX0ZfUklOR19QQUNLRUQgaW4gdGhlIHN0YWJsZSBr
ZXJuZWxzIHdoZW4KPiA+ID4gVkhPU1RfR0VUX0ZFQUVUVVJFUyBpcyBjYWxsZWQKPiA+ID4gLSBi
YWNrcG9ydCB0aGlzIHBhdGNoIG9uIGFsbCBzdGFibGUga2VybmVscyB0aGF0IHN1cHBvcnQgdmhv
c3QtdmRwYQo+ID4gPgo+ID4gPiBNYXliZSB0aGUgbGFzdCBvbmUgbWFrZXMgbW9yZSBzZW5zZS4K
PiA+Cj4gPiBOb3Qgc3VyZSwgaXQgbG9va3MgdG8gbWUgdGhlIHBhY2tlZCBzdXBwb3J0IGZvciB2
RFBBIHdhcyBmaXJzdCBhZGRlZAo+ID4gYnkgR2F1dGFtLiBTbyBpdCBwcm9iYWJseSBtZWFucyB0
aGF0IGV4Y2VwdCBmb3IgdnBfdmRwYSwgd2UgZG9uJ3QgaGF2ZQo+ID4gYSB2RFBBIHBhcmVudCB0
aGF0IGNhbiBkbyB0aGUgcGFja2VkIHZpcnR1cXVlIG5vdy4gQWRkaW5nIHRoZSByZWxldmFudAo+
ID4gcGVvcGxlIGhlcmUgZm9yIG1vcmUgY29tbWVudAo+ID4KPiA+IFRoYW5rcwo+Cj4gQlRXIHNo
b3VsZCB3ZSBmaXggdXAgdmhvc3QuYyB0byBzdXBwb3J0IHBhY2tlZCByaW5ncyB0b28/Cj4gRS5n
LiBzbyB3ZSBjYW4gbWlncmF0ZSB0byB2aG9zdD8KCkJldHRlciB0byBoYXZlLgoKPiBUaGVyZSdz
IGFuIG9sZCBwYXRjaHNldCBvZiBtaW5lIHRoYXQgc3RhcnRlZCB3b3JrIG9uIHRoaXM6Cj4KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMDA0MDcwMTE2MTIuNDc4MjI2LTEtbXN0JTQw
cmVkaGF0LmNvbQo+Cj4gSXMgdGhlcmUgbmVlZCBmb3IgdGhpcyBub3c/CgpJcyB0aGVyZSBhbnkg
YmVuY2htYXJrIGZvciB0aGF0PwoKVGhhbmtzCgo+Cj4gPiA+Cj4gPiA+IFRoYW5rcywKPiA+ID4g
U3RlZmFubwo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
