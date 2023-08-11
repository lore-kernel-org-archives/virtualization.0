Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D44C001DB
	for <virtualization@archiver.kernel.org>; Fri, 11 Aug 2023 09:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDB89835E9;
	Fri, 11 Aug 2023 09:51:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDB89835E9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ex8yGd2C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1vTJWZZVDrG; Fri, 11 Aug 2023 09:51:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 23BD883595;
	Fri, 11 Aug 2023 09:51:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23BD883595
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E87A4C0072;
	Fri, 11 Aug 2023 09:51:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C480C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1652260BCB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:51:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1652260BCB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ex8yGd2C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OYcmt-zew7Do
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:51:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1BA5860A93
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:51:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1BA5860A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691747507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75rSna6DzYfcTF9jaKfqJtBw3nqCSolFXF00msNxr1E=;
 b=Ex8yGd2CymWVHOB4gdOyfKMljM20fnMsbSRcaJFIrJgqkgZLRA/g9TbaeuqwuRn6cnwQPm
 lchyzQ8D6LdEAFbFcrkldiEk2pLxJ0J6NR81D2oLdL3TNlE5BQNp2TiIgHS4rTCl2xLfy4
 eELJvMubtQebmNwVvZqC2Ool/+B7kS4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-vixdfCZSO1SLH0i2UHq_TA-1; Fri, 11 Aug 2023 05:51:45 -0400
X-MC-Unique: vixdfCZSO1SLH0i2UHq_TA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe5c898715so11565915e9.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 02:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691747504; x=1692352304;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=75rSna6DzYfcTF9jaKfqJtBw3nqCSolFXF00msNxr1E=;
 b=O2VL7lHNRuB9TpqqRSmwtHeUu/jiqdR/7325r4H83GuYjckfvGUTv3kDj9whH6l3F9
 Vzs+DgPxghIZ8r6PuIHiiULXoDN0P3EEPHhqSdu92l8tsP2yCJ+GoS3JmO+f9qfizrrn
 HbD2Y4CRTydwAs+7kAZY4GSUS60dpS2N+50YpaykQmxS4w4VVWAF1VI93Itcqx/9lLM0
 7U6+NM2u05EjyjZSNv3VIH81mQi72Bh/Z4cE/Db/POcgIdVbW/6EMEsQzbeEIyZCotpv
 0mQocTjQBttFsbhz7iacBJhiKk9fhmMWPmWDJcTGHErxFhNTbB9oKwbotbLcYu0VJUlD
 lkaw==
X-Gm-Message-State: AOJu0Yx36ZngnqIC5gUKd8xOmkDRX8kNBxMCpBsMYLuhrewu6dw39Sfw
 u/OtMDOLPkZjmWhyD9Qo4f7j2lRqhjJqSyv2qEO+XuD6yklwLdVku6/6bHTQqLf8JzpWITG28XZ
 Qexb4ZkzfULJJm4OIsdaqS1pvh479mKgARN9pwzqwNA==
X-Received: by 2002:a7b:c3d6:0:b0:3fe:29e0:5dad with SMTP id
 t22-20020a7bc3d6000000b003fe29e05dadmr1140835wmj.34.1691747504439; 
 Fri, 11 Aug 2023 02:51:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA198YY0xgEGy8+3z1yxBa6f19jkcuo/4if9Wj0f4OcPhAZIbk5Q0G/vSZurrQnPJwZNM5zQ==
X-Received: by 2002:a7b:c3d6:0:b0:3fe:29e0:5dad with SMTP id
 t22-20020a7bc3d6000000b003fe29e05dadmr1140821wmj.34.1691747504059; 
 Fri, 11 Aug 2023 02:51:44 -0700 (PDT)
Received: from redhat.com ([2.55.27.97]) by smtp.gmail.com with ESMTPSA id
 y24-20020a05600c365800b003fe2b081661sm7520672wmq.30.2023.08.11.02.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 02:51:43 -0700 (PDT)
Date: Fri, 11 Aug 2023 05:51:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230811054859-mutt-send-email-mst@kernel.org>
References: <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
 <20230810153744-mutt-send-email-mst@kernel.org>
 <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
 <20230811012147-mutt-send-email-mst@kernel.org>
 <CACGkMEu8gCJGa4aLTrrNdCRYrZXohF0Pdx3a9kBhrhcHyt05-Q@mail.gmail.com>
 <20230811052102-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGQqipR-XT-JWDt8T8KRXVpvDZsrQ6fEcaE4AfOyfwg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuSGQqipR-XT-JWDt8T8KRXVpvDZsrQ6fEcaE4AfOyfwg@mail.gmail.com>
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

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMDU6NDM6MjVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIEF1ZyAxMSwgMjAyMyBhdCA1OjIx4oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQg
MDU6MTg6NTFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gRnJpLCBBdWcgMTEs
IDIwMjMgYXQgMTo0MuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+Cj4gPiA+ID4gT24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgMTA6MjM6MTVBTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+IE9uIEZyaSwgQXVnIDExLCAyMDIzIGF0
IDM6NDHigK9BTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gT24gVHVlLCBBdWcgMDgsIDIwMjMgYXQgMTA6MzA6NTZBTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBNb24sIEp1bCAzMSwgMjAy
MyBhdCAyOjMw4oCvUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgNTo0
NuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIEp1bCAyNywgMjAyMyBhdCAwNDo1
OTozM1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhl
eSByZWFsbHkgc2hvdWxkbid0IC0gYW55IE5JQyB0aGF0IHRha2VzIGZvcmV2ZXIgdG8KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IHByb2dyYW0gd2lsbCBjcmVhdGUgaXNzdWVzIGluIHRoZSBuZXR3b3Jr
aW5nIHN0YWNrLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gVW5mb3J0
dW5hdGVseSwgaXQncyBub3QgcmFyZSBhcyB0aGUgZGV2aWNlL2N2cSBjb3VsZCBiZSBpbXBsZW1l
bnRlZAo+ID4gPiA+ID4gPiA+ID4gPiA+IHZpYSBmaXJtd2FyZSBvciBzb2Z0d2FyZS4KPiA+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gQ3VycmVudGx5IHRoYXQgbWVhbiBvbmUgZWl0
aGVyIGhhcyBzYW5lIGZpcm13YXJlIHdpdGggYSBzY2hlZHVsZXIgdGhhdAo+ID4gPiA+ID4gPiA+
ID4gPiBjYW4gbWVldCBkZWFkbGluZXMsIG9yIGxvc2VzIGFiaWxpdHkgdG8gcmVwb3J0IGVycm9y
cyBiYWNrLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQnV0IGlmIHRo
ZXkgZG8gdGhleSBjYW4gYWx3YXlzIHNldCB0aGlzIGZsYWcgdG9vLgo+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBtYXkgaGF2ZSBmYWxzZSBuZWdhdGl2ZXMgYW5k
IG1heSBjb25mdXNlIHRoZSBtYW5hZ2VtZW50Lgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gTWF5YmUgd2UgY2FuIGV4dGVuZCB0aGUgbmV0d29ya2luZyBjb3JlIHRvIGFs
bG93IHNvbWUgZGV2aWNlIHNwZWNpZmljCj4gPiA+ID4gPiA+ID4gPiA+ID4gY29uZmlndXJhdGlv
bnMgdG8gYmUgZG9uZSB3aXRoIGRldmljZSBzcGVjaWZpYyBsb2NrIHdpdGhvdXQgcnRubC4gRm9y
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gZXhhbXBsZSwgc3BsaXQgdGhlIHNldF9jaGFubmVscyB0bwo+
ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gcHJlX3NldF9jaGFubmVscwo+
ID4gPiA+ID4gPiA+ID4gPiA+IHNldF9jaGFubmVscwo+ID4gPiA+ID4gPiA+ID4gPiA+IHBvc3Rf
c2V0X2NoYW5uZWxzCj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGUg
ZGV2aWNlIHNwZWNpZmljIHBhcnQgY291bGQgYmUgZG9uZSBpbiBwcmUgYW5kIHBvc3Qgd2l0aG91
dCBhIHJ0bmwgbG9jaz8KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IFRo
YW5rcwo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiBXb3VsZCB0aGUgYmVuZWZpdCBiZSB0aGF0IGVycm9ycyBjYW4gYmUgcmVwb3J0ZWQgdG8gdXNl
cnNwYWNlIHRoZW4/Cj4gPiA+ID4gPiA+ID4gPiA+IFRoZW4gbWF5YmUuICBJIHRoaW5rIHlvdSB3
aWxsIGhhdmUgdG8gc2hvdyBob3cgdGhpcyB3b3JrcyBmb3IgYXQgbGVhc3QKPiA+ID4gPiA+ID4g
PiA+ID4gb25lIGNhcmQgYmVzaWRlcyB2aXJ0aW8uCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gRXZlbiBmb3IgdmlydGlvLCB0aGlzIHNlZW1zIG5vdCBlYXN5LCBhcyBlLmcgdGhlCj4g
PiA+ID4gPiA+ID4gPiB2aXJ0bmV0X3NlbmRfY29tbWFuZCgpIGFuZCBuZXRpZl9zZXRfcmVhbF9u
dW1fdHhfcXVldWVzKCkgbmVlZCB0bwo+ID4gPiA+ID4gPiA+ID4gYXBwZWFyIHRvIGJlIGF0b21p
YyB0byB0aGUgbmV0d29ya2luZyBjb3JlLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
IEkgd29uZGVyIGlmIHdlIGNhbiByZS1jb25zaWRlciB0aGUgd2F5IG9mIGEgdGltZW91dCBoZXJl
IGFuZCBjaG9vc2UgYQo+ID4gPiA+ID4gPiA+ID4gc2FuZSB2YWx1ZSBhcyBhIHN0YXJ0Lgo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gTWljaGFlbCwgYW55IG1vcmUgaW5wdXQgb24gdGhpcz8K
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiBJIHRoaW5rIHRoaXMgaXMganVzdCBtaXNzaW9uIGNyZWVwLiBXZSBhcmUgdHJ5aW5nIHRvIGZp
eAo+ID4gPiA+ID4gPiB2ZHVzZSAtIGxldCdzIGRvIHRoYXQgZm9yIHN0YXJ0ZXJzLgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBSZWNvdmVyaW5nIGZyb20gZmlybXdhcmUgdGltZW91dHMgaXMgZmFy
IGZyb20gdHJpdmlhbCBhbmQKPiA+ID4gPiA+ID4ganVzdCBhc3N1bWluZyB0aGF0IGp1c3QgYmVj
YXVzZSBpdCB0aW1lZCBvdXQgaXQgd2lsbCBub3QKPiA+ID4gPiA+ID4gYWNjZXNzIG1lbW9yeSBp
cyBqdXN0IGFzIGxpa2VseSB0byBjYXVzZSBtZW1vcnkgY29ycnVwdGlvbgo+ID4gPiA+ID4gPiB3
aXRoIHdvcnNlIHJlc3VsdHMgdGhhbiBhbiBpbmZpbml0ZSBzcGluLgo+ID4gPiA+ID4KPiA+ID4g
PiA+IFllcywgdGhpcyBtaWdodCByZXF1aXJlIHN1cHBvcnQgbm90IG9ubHkgaW4gdGhlIGRyaXZl
cgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSSBwcm9wb3NlIHdlIGZpeCB0aGlz
IGZvciB2ZHVzZSBhbmQgYXNzdW1lIGhhcmR3YXJlL2Zpcm13YXJlCj4gPiA+ID4gPiA+IGlzIHdl
bGwgYmVoYXZlZC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbmUgbWFqb3IgY2FzZSBpcyB0aGUgcmUt
Y29ubmVjdGlvbiwgaW4gdGhhdCBjYXNlIGl0IG1pZ2h0IHRha2UKPiA+ID4gPiA+IHdoYXRldmVy
IGxvbmdlciB0aGF0IHRoZSBrZXJuZWwgdmlyaXRvLW5ldCBkcml2ZXIgZXhwZWN0cy4KPiA+ID4g
PiA+IFNvIHdlIGNhbiBoYXZlIGEgdGltZW91dCBpbiBWRFVTRSBhbmQgdHJhcCBDVlEgdGhlbiBW
RFVTRSBjYW4gcmV0dXJuCj4gPiA+ID4gPiBhbmQgZmFpbCBlYXJseT8KPiA+ID4gPgo+ID4gPiA+
IFVnaCBtb3JlIG1pc3Npb24gY3JlZXAuIG5vdCBhdCBhbGwgbXkgcG9pbnQuIHZkdXNlIHNob3Vs
ZCBjYWNoZQo+ID4gPiA+IHZhbHVlcyBpbiB0aGUgZHJpdmVyLAo+ID4gPgo+ID4gPiBXaGF0IGRv
IHlvdSBtZWFuIGJ5IHZhbHVlcyBoZXJlPyBUaGUgY3ZxIGNvbW1hbmQ/Cj4gPiA+Cj4gPiA+IFRo
YW5rcwo+ID4KPiA+IFRoZSBjYXJkIHN0YXR1cyBnZW5lcmFsbHkuCj4gCj4gSnVzdCB0byBtYWtl
IHN1cmUgSSB1bmRlcnN0YW5kIGhlcmUuIFRoZSBDVlEgbmVlZHMgdG8gYmUgcHJvY2Vzc2VkIGJ5
Cj4gdGhlIHVzZXJzcGFjZSBub3cuIEhvdyBjb3VsZCB3ZSBjYWNoZSB0aGUgc3RhdHVzPwo+IAo+
IFRoYW5rcwoKdmR1c2Ugd2lsbCBoYXZlIHRvIHByb2Nlc3MgaXQgaW4ga2VybmVsLgoKPiA+Cj4g
PiA+ID4gdW50aWwgc29tZW9uZSBtYW5hZ2VzIHRvIGNoYW5nZQo+ID4gPiA+IG5ldCBjb3JlIHRv
IGJlIG1vcmUgZnJpZW5kbHkgdG8gdXNlcnNwYWNlIGRldmljZXMuCj4gPiA+ID4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+IE9yIG1heWJlIG5vdCB3ZWxsIGJlaGF2ZWQgZmlybXdhcmUgd2lsbAo+ID4g
PiA+ID4gPiBzZXQgdGhlIGZsYWcgbG9zaW5nIGVycm9yIHJlcG9ydGluZyBhYmlsaXR5Lgo+ID4g
PiA+ID4KPiA+ID4gPiA+IFRoaXMgbWlnaHQgYmUgaGFyZCBzaW5jZSBpdCBtZWFucyBub3Qgb25s
eSB0aGUgc2V0IGJ1dCBhbHNvIHRoZSBnZXQgaXMKPiA+ID4gPiA+IHVucmVsaWFibGUuCj4gPiA+
ID4gPgo+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4gPiAvbWUgc2hydWdzCj4gPiA+ID4K
PiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiAtLQo+ID4gPiA+
ID4gPiA+ID4gPiBNU1QKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPgo+ID4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
