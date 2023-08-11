Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3FFC001DB
	for <virtualization@archiver.kernel.org>; Fri, 11 Aug 2023 10:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93E5B83BBE;
	Fri, 11 Aug 2023 10:12:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93E5B83BBE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cEwSui+z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C4ReVQNW1VmQ; Fri, 11 Aug 2023 10:12:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 07F36836A5;
	Fri, 11 Aug 2023 10:12:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07F36836A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABB0BC0072;
	Fri, 11 Aug 2023 10:12:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8163C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 10:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91D1060BE2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 10:12:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91D1060BE2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cEwSui+z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HiXCExBuRmIx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 10:12:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 80FE260A82
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 10:12:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80FE260A82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691748737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CddEPgIRt1Ku7GcBFRFd157gUsqIuqtTKrEsPcsv/hA=;
 b=cEwSui+z5IL1rEjQuxASRbf1Bm9ReKzPVCl2TFsX6Bbgff3CE6N1lhWyoXXNh0nCK3wqkT
 IE5zXqTt1DMYBb74ikuEaClfeU5LY1aOznuFu3yTDa678jTjubcApa8niBXSqvHNWmn/hB
 c2Sec4793hmb0eukhpGbbwkbTAposhY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-rHT41KGpO3a6gBxTGBfakw-1; Fri, 11 Aug 2023 06:12:15 -0400
X-MC-Unique: rHT41KGpO3a6gBxTGBfakw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso11183755e9.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 03:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691748734; x=1692353534;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CddEPgIRt1Ku7GcBFRFd157gUsqIuqtTKrEsPcsv/hA=;
 b=kK9Ic3Tq0Pg0n4plUIlRHplZvGQ5tPo9KWOfoMrQXnASz1DBaSwY8udk4ktsByc8JV
 AN7lFc6O8EZzO4zhPZBUER1D4/F1D6SD/zmt2TAAWqp2vhzQDwxTUWmO+ku33QyYCSDK
 SVeg49WYe3KWVU0KK7UY7lPJ5Hh8bBtWFZBGfRRNAHw6GF0eJqI6sfubs7hbpxKzwA3N
 GGPDkbPXY6RDSvDsdj9YTptms+Oad2jsZQVQx3sEf9lHVqGxzkc40PbKlJPUeqRAZS5D
 MW2Cot9FVnDWvDYVYjGErogIom/eGOBRWqYaDTk4Wa8Ckr+9AFUR6kv8Lq/hMYmc4jTk
 u39A==
X-Gm-Message-State: AOJu0Yzh2NJpIWw2t4e6Ky7Y6i2Zz2XLqSgwepspwIr1EzUNyubBA0I5
 NYcmMHLHAbep7EURdAlvj4PsTnpdRbJvOyJyfMO9ZyQjkp32uxHimolYNvioHKcDNaSMAQnS1ys
 StKBc/YNS7KoUjaP5g04jD6JrGuxph527LhcYlm98Bg==
X-Received: by 2002:a05:600c:260d:b0:3f9:c0f2:e1a4 with SMTP id
 h13-20020a05600c260d00b003f9c0f2e1a4mr1193029wma.34.1691748734704; 
 Fri, 11 Aug 2023 03:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM5FGYsQHTTB71fOI6oOQ2krq+vNUiUvYyUmMCppHrD4n8O065CZj4UeV7oBaakw1EYZmQmA==
X-Received: by 2002:a05:600c:260d:b0:3f9:c0f2:e1a4 with SMTP id
 h13-20020a05600c260d00b003f9c0f2e1a4mr1193010wma.34.1691748734372; 
 Fri, 11 Aug 2023 03:12:14 -0700 (PDT)
Received: from redhat.com ([2.55.27.97]) by smtp.gmail.com with ESMTPSA id
 q5-20020a7bce85000000b003fe17e04269sm4717370wmj.40.2023.08.11.03.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 03:12:13 -0700 (PDT)
Date: Fri, 11 Aug 2023 06:12:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230811060909-mutt-send-email-mst@kernel.org>
References: <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
 <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
 <20230811012147-mutt-send-email-mst@kernel.org>
 <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
 <20230811052102-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGQqipR-XT-JWDt8T8KRXVpvDZsrQ6fEcaE4AfOyfwg@mail.gmail.com>
 <20230811054859-mutt-send-email-mst@kernel.org>
 <CACGkMEujbuQRuBBzSdVYah2ZcfRgxLbEKjZjPBeFhLxj5quFhw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEujbuQRuBBzSdVYah2ZcfRgxLbEKjZjPBeFhLxj5quFhw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMDU6NTQ6MTVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIEF1ZyAxMSwgMjAyMyBhdCA1OjUx4oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQg
MDU6NDM6MjVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gRnJpLCBBdWcgMTEs
IDIwMjMgYXQgNToyMeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMDU6MTg6NTFQTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+IE9uIEZyaSwgQXVnIDExLCAyMDIzIGF0
IDE6NDLigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMTA6MjM6MTVBTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBGcmksIEF1ZyAxMSwgMjAy
MyBhdCAzOjQx4oCvQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCBBdWcgMDgsIDIwMjMgYXQg
MTA6MzA6NTZBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gT24g
TW9uLCBKdWwgMzEsIDIwMjMgYXQgMjozMOKAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gT24g
VGh1LCBKdWwgMjcsIDIwMjMgYXQgNTo0NuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IE9uIFRodSwgSnVsIDI3LCAyMDIzIGF0IDA0OjU5OjMzUE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhleSByZWFsbHkgc2hvdWxkbid0IC0g
YW55IE5JQyB0aGF0IHRha2VzIGZvcmV2ZXIgdG8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBw
cm9ncmFtIHdpbGwgY3JlYXRlIGlzc3VlcyBpbiB0aGUgbmV0d29ya2luZyBzdGFjay4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVW5mb3J0dW5hdGVseSwg
aXQncyBub3QgcmFyZSBhcyB0aGUgZGV2aWNlL2N2cSBjb3VsZCBiZSBpbXBsZW1lbnRlZAo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiB2aWEgZmlybXdhcmUgb3Igc29mdHdhcmUuCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ3VycmVudGx5IHRoYXQgbWVhbiBvbmUg
ZWl0aGVyIGhhcyBzYW5lIGZpcm13YXJlIHdpdGggYSBzY2hlZHVsZXIgdGhhdAo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gY2FuIG1lZXQgZGVhZGxpbmVzLCBvciBsb3NlcyBhYmlsaXR5IHRvIHJlcG9y
dCBlcnJvcnMgYmFjay4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gQnV0IGlmIHRoZXkgZG8gdGhleSBjYW4gYWx3YXlzIHNldCB0aGlzIGZsYWcgdG9vLgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIG1heSBo
YXZlIGZhbHNlIG5lZ2F0aXZlcyBhbmQgbWF5IGNvbmZ1c2UgdGhlIG1hbmFnZW1lbnQuCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE1heWJlIHdlIGNhbiBl
eHRlbmQgdGhlIG5ldHdvcmtpbmcgY29yZSB0byBhbGxvdyBzb21lIGRldmljZSBzcGVjaWZpYwo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjb25maWd1cmF0aW9ucyB0byBiZSBkb25lIHdpdGggZGV2
aWNlIHNwZWNpZmljIGxvY2sgd2l0aG91dCBydG5sLiBGb3IKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gZXhhbXBsZSwgc3BsaXQgdGhlIHNldF9jaGFubmVscyB0bwo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBwcmVfc2V0X2NoYW5uZWxzCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IHNldF9jaGFubmVscwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBwb3N0X3Nl
dF9jaGFubmVscwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBUaGUgZGV2aWNlIHNwZWNpZmljIHBhcnQgY291bGQgYmUgZG9uZSBpbiBwcmUgYW5kIHBvc3Qg
d2l0aG91dCBhIHJ0bmwgbG9jaz8KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdvdWxkIHRoZSBiZW5lZml0IGJlIHRoYXQgZXJy
b3JzIGNhbiBiZSByZXBvcnRlZCB0byB1c2Vyc3BhY2UgdGhlbj8KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IFRoZW4gbWF5YmUuICBJIHRoaW5rIHlvdSB3aWxsIGhhdmUgdG8gc2hvdyBob3cgdGhpcyB3
b3JrcyBmb3IgYXQgbGVhc3QKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG9uZSBjYXJkIGJlc2lkZXMg
dmlydGlvLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gRXZlbiBmb3Ig
dmlydGlvLCB0aGlzIHNlZW1zIG5vdCBlYXN5LCBhcyBlLmcgdGhlCj4gPiA+ID4gPiA+ID4gPiA+
ID4gdmlydG5ldF9zZW5kX2NvbW1hbmQoKSBhbmQgbmV0aWZfc2V0X3JlYWxfbnVtX3R4X3F1ZXVl
cygpIG5lZWQgdG8KPiA+ID4gPiA+ID4gPiA+ID4gPiBhcHBlYXIgdG8gYmUgYXRvbWljIHRvIHRo
ZSBuZXR3b3JraW5nIGNvcmUuCj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiBJIHdvbmRlciBpZiB3ZSBjYW4gcmUtY29uc2lkZXIgdGhlIHdheSBvZiBhIHRpbWVvdXQgaGVy
ZSBhbmQgY2hvb3NlIGEKPiA+ID4gPiA+ID4gPiA+ID4gPiBzYW5lIHZhbHVlIGFzIGEgc3RhcnQu
Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IE1pY2hhZWwsIGFueSBtb3JlIGlu
cHV0IG9uIHRoaXM/Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rcwo+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEkgdGhpbmsgdGhpcyBpcyBqdXN0IG1pc3Np
b24gY3JlZXAuIFdlIGFyZSB0cnlpbmcgdG8gZml4Cj4gPiA+ID4gPiA+ID4gPiB2ZHVzZSAtIGxl
dCdzIGRvIHRoYXQgZm9yIHN0YXJ0ZXJzLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
IFJlY292ZXJpbmcgZnJvbSBmaXJtd2FyZSB0aW1lb3V0cyBpcyBmYXIgZnJvbSB0cml2aWFsIGFu
ZAo+ID4gPiA+ID4gPiA+ID4ganVzdCBhc3N1bWluZyB0aGF0IGp1c3QgYmVjYXVzZSBpdCB0aW1l
ZCBvdXQgaXQgd2lsbCBub3QKPiA+ID4gPiA+ID4gPiA+IGFjY2VzcyBtZW1vcnkgaXMganVzdCBh
cyBsaWtlbHkgdG8gY2F1c2UgbWVtb3J5IGNvcnJ1cHRpb24KPiA+ID4gPiA+ID4gPiA+IHdpdGgg
d29yc2UgcmVzdWx0cyB0aGFuIGFuIGluZmluaXRlIHNwaW4uCj4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiBZZXMsIHRoaXMgbWlnaHQgcmVxdWlyZSBzdXBwb3J0IG5vdCBvbmx5IGluIHRoZSBk
cml2ZXIKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEkgcHJv
cG9zZSB3ZSBmaXggdGhpcyBmb3IgdmR1c2UgYW5kIGFzc3VtZSBoYXJkd2FyZS9maXJtd2FyZQo+
ID4gPiA+ID4gPiA+ID4gaXMgd2VsbCBiZWhhdmVkLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gT25lIG1ham9yIGNhc2UgaXMgdGhlIHJlLWNvbm5lY3Rpb24sIGluIHRoYXQgY2FzZSBpdCBt
aWdodCB0YWtlCj4gPiA+ID4gPiA+ID4gd2hhdGV2ZXIgbG9uZ2VyIHRoYXQgdGhlIGtlcm5lbCB2
aXJpdG8tbmV0IGRyaXZlciBleHBlY3RzLgo+ID4gPiA+ID4gPiA+IFNvIHdlIGNhbiBoYXZlIGEg
dGltZW91dCBpbiBWRFVTRSBhbmQgdHJhcCBDVlEgdGhlbiBWRFVTRSBjYW4gcmV0dXJuCj4gPiA+
ID4gPiA+ID4gYW5kIGZhaWwgZWFybHk/Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFVnaCBtb3Jl
IG1pc3Npb24gY3JlZXAuIG5vdCBhdCBhbGwgbXkgcG9pbnQuIHZkdXNlIHNob3VsZCBjYWNoZQo+
ID4gPiA+ID4gPiB2YWx1ZXMgaW4gdGhlIGRyaXZlciwKPiA+ID4gPiA+Cj4gPiA+ID4gPiBXaGF0
IGRvIHlvdSBtZWFuIGJ5IHZhbHVlcyBoZXJlPyBUaGUgY3ZxIGNvbW1hbmQ/Cj4gPiA+ID4gPgo+
ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4gPiBUaGUgY2FyZCBzdGF0dXMgZ2VuZXJhbGx5
Lgo+ID4gPgo+ID4gPiBKdXN0IHRvIG1ha2Ugc3VyZSBJIHVuZGVyc3RhbmQgaGVyZS4gVGhlIENW
USBuZWVkcyB0byBiZSBwcm9jZXNzZWQgYnkKPiA+ID4gdGhlIHVzZXJzcGFjZSBub3cuIEhvdyBj
b3VsZCB3ZSBjYWNoZSB0aGUgc3RhdHVzPwo+ID4gPgo+ID4gPiBUaGFua3MKPiA+Cj4gPiB2ZHVz
ZSB3aWxsIGhhdmUgdG8gcHJvY2VzcyBpdCBpbiBrZXJuZWwuCj4gCj4gUmlnaHQsIHRoYXQncyBt
eSB1bmRlcnN0YW5kaW5nICh0cmFwIENWUSkuCj4gCj4gVGhhbmtzCgpvaCB0aGlzIHdoYXQgeW91
IG1lYW4gYnkgdHJhcC4gb2suIEkgZG9uJ3Qgc2VlIGEgbmV3CmZvciBhIHRpbWVvdXQgdGhlbiB0
aG91Z2guCgoKPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ID4gdW50aWwgc29tZW9uZSBtYW5hZ2VzIHRv
IGNoYW5nZQo+ID4gPiA+ID4gPiBuZXQgY29yZSB0byBiZSBtb3JlIGZyaWVuZGx5IHRvIHVzZXJz
cGFjZSBkZXZpY2VzLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBP
ciBtYXliZSBub3Qgd2VsbCBiZWhhdmVkIGZpcm13YXJlIHdpbGwKPiA+ID4gPiA+ID4gPiA+IHNl
dCB0aGUgZmxhZyBsb3NpbmcgZXJyb3IgcmVwb3J0aW5nIGFiaWxpdHkuCj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiBUaGlzIG1pZ2h0IGJlIGhhcmQgc2luY2UgaXQgbWVhbnMgbm90IG9ubHkg
dGhlIHNldCBidXQgYWxzbyB0aGUgZ2V0IGlzCj4gPiA+ID4gPiA+ID4gdW5yZWxpYWJsZS4KPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAv
bWUgc2hydWdzCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAt
LQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gTVNUCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
