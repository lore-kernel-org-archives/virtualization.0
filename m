Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F5ACDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 15:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E8E941829;
	Wed, 18 Oct 2023 15:07:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E8E941829
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GDTC8v0z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I635WRm7ehZ9; Wed, 18 Oct 2023 15:07:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF9D5403C4;
	Wed, 18 Oct 2023 15:07:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF9D5403C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C49CC0071;
	Wed, 18 Oct 2023 15:07:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58D91C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 15:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3406281768
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 15:07:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3406281768
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GDTC8v0z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IOkAij3GHdly
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 15:07:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C0DAC8175A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 15:07:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0DAC8175A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697641665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b4k32Qll7xmolYIKH5+vDPZG05ddmo4Sz7Cnu5kKN0s=;
 b=GDTC8v0zpkmtlv6mBerpdDqmgnGLtu4MF/fVKd5YokxLZecF8jY5XzrOawrpxllNs7DSU9
 pkYkomtaNXIStZQhZ1B2k4vyqlQnUYEfjcB6not7+xsIfMciMvCzWqyU50ynnjuilt9kg/
 9xXRUdXfdYu3dkxJzd6LHkeT4Y/vd0o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-J7xXSO51PVGDUeGWtH3dzg-1; Wed, 18 Oct 2023 11:07:43 -0400
X-MC-Unique: J7xXSO51PVGDUeGWtH3dzg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c50dcd377eso46854981fa.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 08:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697641662; x=1698246462;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b4k32Qll7xmolYIKH5+vDPZG05ddmo4Sz7Cnu5kKN0s=;
 b=dS9TD7ZTmz6Xa/wsb4F+mKhrj3SODB5rz/f/MCjQG3OYPl50W1ZRT8pi2IR88pBdRR
 hSg88n8J1GaSROGyhDPNAeeHBCZnST2Py+pOKBZQdpu2+tUaFIvHySec1rj1uLAS/l4M
 qLv7kWGqoDtfpkaffCtUUa+ZnPhlmHOmjsTQm+3diNeEvs0NmDZeHsBdQZ3vGa9ZBoFW
 xy9fwclmW/yVN7ijlsr7cQTiNrQ4ab/TTfStj/PUwRJS7AJClHM6nCNfOno0r/Sq0p/h
 GTknyvu+BYqmr5PvxKwMtkMGVh90pD/F4W54wC1CLxgrH4HsSAOeZZzlh2PiCAe9a7e2
 ONZA==
X-Gm-Message-State: AOJu0Yz4buG6htrrmsyCfECFq8aqyES0YZqq/Aw7+WyjFgx7GfEQzqN6
 7D3/cHHfZKn8Yk7Ep8i/OkKRkAgIs1PrFUNdljB4dul0rkbHgGrSHMsC8vADLqIwJNq+QgL2dQ1
 b8FUeYPfp74usUeoiVUOa/7hVDIn0hmt02ixaNtkNig==
X-Received: by 2002:a19:740e:0:b0:507:a1dd:5a86 with SMTP id
 v14-20020a19740e000000b00507a1dd5a86mr4098728lfe.13.1697641662353; 
 Wed, 18 Oct 2023 08:07:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy/4zb+S5NM6sEmS0XLktdnB9E2DgK42NBe1FM60xzp+eEpX+jYGqKyBED2FMOWx4ESBVAZQ==
X-Received: by 2002:a19:740e:0:b0:507:a1dd:5a86 with SMTP id
 v14-20020a19740e000000b00507a1dd5a86mr4098704lfe.13.1697641662008; 
 Wed, 18 Oct 2023 08:07:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a05600c355200b00407752bd834sm1932821wmq.1.2023.10.18.08.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:07:41 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:07:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/2] vdpa: Add logging operatins
Message-ID: <20231018110719-mutt-send-email-mst@kernel.org>
References: <cover.1693012755.git.jiangdongxu1@huawei.com>
 <CACGkMEsP+3nTjG8gj0PoYg0DvyqqOpJKoAxG=m27t+iv-6GVbQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsP+3nTjG8gj0PoYg0DvyqqOpJKoAxG=m27t+iv-6GVbQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eric.fangyi@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Jiang Dongxu <jiangdongxu1@huawei.com>, eperezma <eperezma@redhat.com>,
 longpeng2@huawei.com, Siwei Liu <loseweigh@gmail.com>
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

T24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgMDI6NTY6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBBZGRpbmcgRXVnZW5pbyBhbmQgU2kgV2VpLgo+IAo+IE9uIFNhdCwgQXVnIDI2LCAyMDIz
IGF0IDk6MjTigK9BTSBKaWFuZyBEb25neHUgPGppYW5nZG9uZ3h1MUBodWF3ZWkuY29tPiB3cm90
ZToKPiA+Cj4gPiBGcm9tOiBqaWFuZ2Rvbmd4dSA8amlhbmdkb25neHUxQGh1YXdlaS5jb20+Cj4g
Pgo+ID4gQ3VycmVudGx5LCB0aGUgdmRwYSBkZXZpY2Ugc3VwcG9ydHMgc3VzcGVuZCBhbmQgcmVz
dW1lIG9wZXJhdGlvbnMuCj4gPiBUbyBzdXBwb3J0IHZkcGEgZGV2aWNlIGxpdmUgbWlncmF0aW9u
LCB3ZSBuZWVkIHRvIHN1cHBvcnQgbG9nZ2luZwo+ID4gb3BlcmF0aW9ucyBhbmQgZGV2aWNlIHN0
YXRlIHNhdmUvbG9hZCBvcGVydGlvbnMuCj4gPgo+ID4gVGhlc2Ugc2VyaWVzIGludHJvZHVjZXMg
c29tZSBuZXcgb3BlcmF0aW9ucyBmb3IgdmRwYSBkZXZpY2VzLgo+ID4gVGhleSBhbGxvdyB2ZHBh
IHRvIGVuYWJsZSBsb2dnaW5nIHdoaWxlIHZtIHN0YXJ0IGxpdmUgbWlncmF0aW9uLgo+ID4KPiA+
IEFuZCBJIHdpbGwgc3VibWl0IGFub3RoZXIgcGF0Y2hlcyBhYm91dCBzYXZpbmcgYW5kIGxvYWRp
bmcKPiA+IHZkcGEgZGV2aWNlIHN0YXRlIGxhdGVyLgo+IAo+IFRoYW5rcyBmb3Igd29ya2luZyBv
biB0aGlzLCBJIGhhdmUgc2V2ZXJhbCBxdWVzdGlvbnM6Cj4gCj4gMSkgSXMgdGhlcmUgYW4gZXhh
bXBsZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgbG9nZ2luZyBpbiB0aGUgZHJpdmVycz8KPiBXZSBu
ZWVkIGEgcmVhbCB1c2VyIGluIG9yZGVyIHRvIG1lcmdlIHRoaXMuCj4gMikgSXMgdGhlIGxvZ2dp
bmcgYmFzZWQgb24gSU9WQSBvciBWQT8gSG93IHRoZSBETUEgaXNvbGF0aW9uIGlzIGJlaW5nCj4g
ZG9uZSB3aXRoIHRoaXM/IERvIHdlIG5lZWQgYSBTRVRfTE9HR0lOR19BU0lEIHVBUEkgZm9yIHRo
aXM/IChXZSBoYWQKPiBzb21lIGRpc2N1c3Npb24gb24gdGhpcyBpbiB0aGUgcGFzdCkuCj4gCj4g
VGhhbmtzCgoKU2VlbXMgdG8gYmUgc3R1Y2suIERyb3BwZWQgdGhpcyBmb3Igbm93LgoKPiA+Cj4g
PiBqaWFuZ2Rvbmd4dSAoMik6Cj4gPiAgIHZkcGE6IGFkZCBsb2cgb3BlcmF0aW9ucwo+ID4gICB2
aG9zdC12ZHBhOiBhZGQgdUFQSSBmb3IgbG9nZ2luZwo+ID4KPiA+ICBkcml2ZXJzL3Zob3N0L3Zk
cGEuYyAgICAgICB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4g
PiAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICAgfCAxNCArKysrKysrKysrKwo+ID4gIGluY2x1
ZGUvdWFwaS9saW51eC92aG9zdC5oIHwgIDQgKysrKwo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNjcg
aW5zZXJ0aW9ucygrKQo+ID4KPiA+IC0tCj4gPiAyLjI3LjAKPiA+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
