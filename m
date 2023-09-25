Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AA2CD4853
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 18:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84CE441BB6;
	Mon, 25 Sep 2023 18:36:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84CE441BB6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gax4jKvx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lWN4NNadcZiZ; Mon, 25 Sep 2023 18:36:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A460141BAF;
	Mon, 25 Sep 2023 18:36:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A460141BAF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74F02C0071;
	Mon, 25 Sep 2023 18:36:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0711CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 18:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5488612AA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 18:36:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5488612AA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gax4jKvx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IYuQtSRMEGME
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 18:36:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9CF361240
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 18:36:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9CF361240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695666974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9QTtIYYHWfEcLyk0XfMvD4aeQXydfx9aR6gAzWJA9sc=;
 b=Gax4jKvxuyB5gJpkHztSeiQwosM74rzIyQqSm1Z8F65DhSojcXKeNBkAghxC+G13mCasZr
 BHMcs3XzQVLyvmgvmRKnIM0+cRpIOqaVRDuea3HXpfmQ2oUHD1WDbIl82G2LYILQSI2YW8
 VTpI2Cqq9q9JmXBCaoLR/zfGnYPbOtg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-1DQR5brJPZaGZjbEEL7k0w-1; Mon, 25 Sep 2023 14:36:13 -0400
X-MC-Unique: 1DQR5brJPZaGZjbEEL7k0w-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7742bab9c0cso543085685a.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 11:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666973; x=1696271773;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9QTtIYYHWfEcLyk0XfMvD4aeQXydfx9aR6gAzWJA9sc=;
 b=RuXh87ou9gKYiWmBPBHzfToQU/zX0BTeXQP4648Z0HC05gykN1hJJ7Sez2N5zy/ZdJ
 RFrhaatWjutAUGMkB7z+oXJO90OptDnscMIrN8AY4T7YflS1tpDzTbft9fEXfUDjlUNH
 Tx/bS8CY0KSDWVhQGQNW5QUhamWHTNMHQdVe16IUrOWk5Oah67Xi+Nt1faG3Bg+IrW1F
 iGDBIu6sTdDWC9qCxOOUYkZbaZgJYonaRTaRi4imG9U3ddcNMiom1gknloai5IkP8oUW
 92KEn6pMJSkrlw2PB88KbI8Gww6Kbw2PA58wFNHHw++H2DUYCEOo4oDXai39m0cNBAxN
 InEQ==
X-Gm-Message-State: AOJu0Yy4ySL7WXulUjF2YgkQEf9sqoeFO5RwTa8s++ptoPzRtbqbCyko
 nQ8WM4HAMUgHP30tdEhJM+ySLjhibNOJ757UaOVzstx3FE4HabyZXatW+VacjVfd7skJQQDQL1k
 ZfWcBN49HAFaUzm+ANyRfcb7aTNX0YUL944wzDujO8w==
X-Received: by 2002:a05:620a:a1e:b0:774:20bb:2473 with SMTP id
 i30-20020a05620a0a1e00b0077420bb2473mr6273049qka.25.1695666972779; 
 Mon, 25 Sep 2023 11:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENA1Z6IBxdDt1EQwITwUpLlUd61ItWx3IkukntUNf42RhNhR7OkvLvX5TddUXhiG8q1YL1sQ==
X-Received: by 2002:a05:620a:a1e:b0:774:20bb:2473 with SMTP id
 i30-20020a05620a0a1e00b0077420bb2473mr6273037qka.25.1695666972432; 
 Mon, 25 Sep 2023 11:36:12 -0700 (PDT)
Received: from redhat.com ([185.184.228.174]) by smtp.gmail.com with ESMTPSA id
 j30-20020a05620a001e00b0076d74da4481sm741437qki.23.2023.09.25.11.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:36:11 -0700 (PDT)
Date: Mon, 25 Sep 2023 14:36:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230925141713-mutt-send-email-mst@kernel.org>
References: <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuX5HJVBOw9E+skr=K=QzH3oyHK8gk-r0hAvi6Wm7OA7Q@mail.gmail.com>
 <PH0PR12MB5481ED78F7467EEB0740847EDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481ED78F7467EEB0740847EDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMDg6MjY6MzNBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+IAo+IAo+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+
IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDI1LCAyMDIzIDg6MDAgQU0KPiA+IAo+ID4gT24gRnJp
LCBTZXAgMjIsIDIwMjMgYXQgODoyNeKAr1BNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4gPiA+Cj4gPiA+Cj4gPiA+ID4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dA
bnZpZGlhLmNvbT4KPiA+ID4gPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAyMiwgMjAyMyA1OjUz
IFBNCj4gPiA+Cj4gPiA+Cj4gPiA+ID4gPiBBbmQgd2hhdCdzIG1vcmUsIHVzaW5nIE1NSU8gQkFS
MCB0aGVuIGl0IGNhbiB3b3JrIGZvciBsZWdhY3kuCj4gPiA+ID4KPiA+ID4gPiBPaD8gSG93PyBP
dXIgdGVhbSBkaWRuJ3QgdGhpbmsgc28uCj4gPiA+Cj4gPiA+IEl0IGRvZXMgbm90LiBJdCB3YXMg
YWxyZWFkeSBkaXNjdXNzZWQuCj4gPiA+IFRoZSBkZXZpY2UgcmVzZXQgaW4gbGVnYWN5IGlzIG5v
dCBzeW5jaHJvbm91cy4KPiA+IAo+ID4gSG93IGRvIHlvdSBrbm93IHRoaXM/Cj4gPgo+IE5vdCBz
dXJlIHRoZSBtb3RpdmF0aW9uIG9mIHNhbWUgZGlzY3Vzc2lvbiBkb25lIGluIHRoZSBPQVNJUyB3
aXRoIHlvdSBhbmQgb3RoZXJzIGluIHBhc3QuCj4gCj4gQW55d2F5cywgcGxlYXNlIGZpbmQgdGhl
IGFuc3dlciBiZWxvdy4KPiAKPiBBYm91dCByZXNldCwKPiBUaGUgbGVnYWN5IGRldmljZSBzcGVj
aWZpY2F0aW9uIGhhcyBub3QgZW5mb3JjZWQgYmVsb3cgY2l0ZWQgMS4wIGRyaXZlciByZXF1aXJl
bWVudCBvZiAxLjAuCj4gCj4gIlRoZSBkcml2ZXIgU0hPVUxEIGNvbnNpZGVyIGEgZHJpdmVyLWlu
aXRpYXRlZCByZXNldCBjb21wbGV0ZSB3aGVuIGl0IHJlYWRzIGRldmljZSBzdGF0dXMgYXMgMC4i
Cj4gIAo+IFsxXSBodHRwczovL296bGFicy5vcmcvfnJ1c3R5L3ZpcnRpby1zcGVjL3ZpcnRpby0w
LjkuNS5wZGYKCkJhc2ljYWxseSwgSSB0aGluayBhbnkgZHJpdmVycyB0aGF0IGRpZCBub3QgcmVh
ZCBzdGF0dXMgKGxpbnV4IHByZSAyMDExKQpiZWZvcmUgZnJlZWluZyBtZW1vcnkgdW5kZXIgRE1B
IGhhdmUgYSByZXNldCBwYXRoIHRoYXQgaXMgcmFjeSB3cnQgRE1BLCBzaW5jZSAKbWVtb3J5IHdy
aXRlcyBhcmUgcG9zdGVkIGFuZCBJTyB3cml0ZXMgd2hpbGUgbm90IHBvc3RlZCBoYXZlIGNvbXBs
ZXRpb24KdGhhdCBkb2VzIG5vdCBvcmRlciBwb3N0ZWQgdHJhbnNhY3Rpb25zLCBlLmcuIGZyb20g
cGNpIGV4cHJlc3Mgc3BlYzoKICAgICAgICBEMmIKICAgICAgICBBbiBJL08gb3IgQ29uZmlndXJh
dGlvbiBXcml0ZSBDb21wbGV0aW9uIDM3IGlzIHBlcm1pdHRlZCB0byBwYXNzIGEgUG9zdGVkIFJl
cXVlc3QuCmhhdmluZyBzYWlkIHRoYXQgdGhlcmUgd2VyZSBhIHRvbiBvZiBkcml2ZXIgcmFjZXMg
ZGlzY292ZXJlZCBvbiB0aGlzCnBhdGggaW4gdGhlIHllYXJzIHNpbmNlLCBJIHN1c3BlY3QgaWYg
b25lIGNhcmVzIGFib3V0IHRoaXMgdGhlbgpqdXN0IGF2b2lkaW5nIHN0cmVzcyBvbiByZXNldCBp
cyB3aXNlLgoKCgo+ID4gPiBUaGUgZHJpdmVycyBkbyBub3Qgd2FpdCBmb3IgcmVzZXQgdG8gY29t
cGxldGU7IGl0IHdhcyB3cml0dGVuIGZvciB0aGUgc3cKPiA+IGJhY2tlbmQuCj4gPiAKPiA+IERv
IHlvdSBzZWUgdGhlcmUncyBhIGZsdXNoIGFmdGVyIHJlc2V0IGluIHRoZSBsZWdhY3kgZHJpdmVy
Pwo+ID4gCj4gWWVzLiBpdCBvbmx5IGZsdXNoZXMgdGhlIHdyaXRlIGJ5IHJlYWRpbmcgaXQuIFRo
ZSBkcml2ZXIgZG9lcyBub3QgZ2V0IF93YWl0XyBmb3IgdGhlIHJlc2V0IHRvIGNvbXBsZXRlIHdp
dGhpbiB0aGUgZGV2aWNlIGxpa2UgYWJvdmUuCgpPbmUgY2FuIHRoaW5rYWJseSBkbyB0aGF0IHdh
aXQgaW4gaGFyZHdhcmUsIHRob3VnaC4gSnVzdCBkZWZlciBjb21wbGV0aW9uIHVudGlsCnJlYWQg
aXMgZG9uZS4KCj4gUGxlYXNlIHNlZSB0aGUgcmVzZXQgZmxvdyBvZiAxLnggZGV2aWNlIGFzIGJl
bG93Lgo+IEluIGZhY3QgdGhlIGNvbW1lbnQgb2YgdGhlIDEueCBkZXZpY2UgYWxzbyBuZWVkcyB0
byBiZSB1cGRhdGVkIHRvIGluZGljYXRlIHRoYXQgZHJpdmVyIG5lZWQgdG8gd2FpdCBmb3IgdGhl
IGRldmljZSB0byBmaW5pc2ggdGhlIHJlc2V0Lgo+IEkgd2lsbCBzZW5kIHNlcGFyYXRlIHBhdGNo
IGZvciBpbXByb3ZpbmcgdGhpcyBjb21tZW50IG9mIHZwX3Jlc2V0KCkgdG8gbWF0Y2ggdGhlIHNw
ZWMuCj4gCj4gc3RhdGljIHZvaWQgdnBfcmVzZXQoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYp
Cj4gewo+ICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYgPSB0b192cF9k
ZXZpY2UodmRldik7Cj4gICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICpt
ZGV2ID0gJnZwX2Rldi0+bWRldjsKPiAKPiAgICAgICAgIC8qIDAgc3RhdHVzIG1lYW5zIGEgcmVz
ZXQuICovCj4gICAgICAgICB2cF9tb2Rlcm5fc2V0X3N0YXR1cyhtZGV2LCAwKTsKPiAgICAgICAg
IC8qIEFmdGVyIHdyaXRpbmcgMCB0byBkZXZpY2Vfc3RhdHVzLCB0aGUgZHJpdmVyIE1VU1Qgd2Fp
dCBmb3IgYSByZWFkIG9mCj4gICAgICAgICAgKiBkZXZpY2Vfc3RhdHVzIHRvIHJldHVybiAwIGJl
Zm9yZSByZWluaXRpYWxpemluZyB0aGUgZGV2aWNlLgo+ICAgICAgICAgICogVGhpcyB3aWxsIGZs
dXNoIG91dCB0aGUgc3RhdHVzIHdyaXRlLCBhbmQgZmx1c2ggaW4gZGV2aWNlIHdyaXRlcywKPiAg
ICAgICAgICAqIGluY2x1ZGluZyBNU0ktWCBpbnRlcnJ1cHRzLCBpZiBhbnkuCj4gICAgICAgICAg
Ki8KPiAgICAgICAgIHdoaWxlICh2cF9tb2Rlcm5fZ2V0X3N0YXR1cyhtZGV2KSkKPiAgICAgICAg
ICAgICAgICAgbXNsZWVwKDEpOwo+ICAgICAgICAgLyogRmx1c2ggcGVuZGluZyBWUS9jb25maWd1
cmF0aW9uIGNhbGxiYWNrcy4gKi8KPiAgICAgICAgIHZwX3N5bmNocm9uaXplX3ZlY3RvcnModmRl
dik7Cj4gfQo+IAo+IAo+ID4gc3RhdGljIHZvaWQgdnBfcmVzZXQoc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYpIHsKPiA+ICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYg
PSB0b192cF9kZXZpY2UodmRldik7Cj4gPiAgICAgICAgIC8qIDAgc3RhdHVzIG1lYW5zIGEgcmVz
ZXQuICovCj4gPiAgICAgICAgIHZwX2xlZ2FjeV9zZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYsIDAp
Owo+ID4gICAgICAgICAvKiBGbHVzaCBvdXQgdGhlIHN0YXR1cyB3cml0ZSwgYW5kIGZsdXNoIGlu
IGRldmljZSB3cml0ZXMsCj4gPiAgICAgICAgICAqIGluY2x1ZGluZyBNU2ktWCBpbnRlcnJ1cHRz
LCBpZiBhbnkuICovCj4gPiAgICAgICAgIHZwX2xlZ2FjeV9nZXRfc3RhdHVzKCZ2cF9kZXYtPmxk
ZXYpOwo+ID4gICAgICAgICAvKiBGbHVzaCBwZW5kaW5nIFZRL2NvbmZpZ3VyYXRpb24gY2FsbGJh
Y2tzLiAqLwo+ID4gICAgICAgICB2cF9zeW5jaHJvbml6ZV92ZWN0b3JzKHZkZXYpOwo+ID4gfQo+
ID4gCj4gPiBUaGFua3MKPiA+IAo+ID4gCj4gPiAKPiA+ID4gSGVuY2UgTU1JTyBCQVIwIGlzIG5v
dCB0aGUgYmVzdCBvcHRpb24gaW4gcmVhbCBpbXBsZW1lbnRhdGlvbnMuCj4gPiA+Cj4gCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
