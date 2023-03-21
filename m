Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147BAC6FD1C
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 02:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF83161097;
	Tue, 21 Mar 2023 02:29:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF83161097
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h7VZG4pI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mvs7sqjDRsHB; Tue, 21 Mar 2023 02:29:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED4E360FE3;
	Tue, 21 Mar 2023 02:29:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED4E360FE3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A41CCC0071;
	Tue, 21 Mar 2023 02:29:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F146EC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7FF881E43
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:29:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7FF881E43
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=h7VZG4pI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 956mBIQ59EOA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:29:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36CA081E31
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36CA081E31
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679365765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yc3yltBy2/7l60SsAiXXcTmVvUT1/yTscKCbTOemK2Y=;
 b=h7VZG4pIxgg3Jdjw4FV4FqGqLj2tEEX8SOGHaiQKjKEOik/zr3mq55D3F3lQVJ/TmxkWeD
 SmvYMeGMWUn2N5ihG52odwgHNZSNcxM1pnMMX2qviYENMHsSTV9Fcpiej2ijBtxvrMR2Vs
 lSkHyI+lvT3xwQ5gV5R8LmUCzAHXICk=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-SPawvvytOCm3jYqvgNdOEQ-1; Mon, 20 Mar 2023 22:29:23 -0400
X-MC-Unique: SPawvvytOCm3jYqvgNdOEQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-177bf70751bso7966846fac.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 19:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679365763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yc3yltBy2/7l60SsAiXXcTmVvUT1/yTscKCbTOemK2Y=;
 b=f0z7YtqJIvgltiwPOyLngRn6R6BFWkSPobqavHxUk5rsqu0LeyJHzbuSdcgWffrrcQ
 YaCG3gu6ZmdyTHQVsBWuar4FtcwFp+3XZRsW4u8UqywqWh/znIr1tOzZxymeuxHzJGHJ
 JIW+evGpeCi9U4Y5w89yqFtMU8zucpl9P3q42gH/eDgtGyxWJYe4hQw7gd2Lgc6jQ8d0
 LiOYptPiqPa6ghHXE75vh6EcTETKz6rEuFqOy6obFmJTbwLuUfEuxcJwCr/bXn1vqhpE
 KAMw7+rjicejG4L0zqGv0fTXMNkW3j2WywHVomMEiuds/2yHjKC1FI89S87vw4dw1DNj
 kEAQ==
X-Gm-Message-State: AO0yUKUH67E+ZZSzQ4vKYzMaRkjuNrUF+BkSsvvcCYc/WLkl4zhhF07X
 0GBvPBpn99dmlbQYFHgaAQtxIXFu8nC6YVgL3Bt+/K+PR5mvcc4TX4+RA3ilIC+t3iVSaGiuuBZ
 0R40JWlU/pn004moQqqUP7NKlZJnfzfL2iXHqhlf3QYtuBX3v6k8oXwnN/Q==
X-Received: by 2002:a9d:7e8e:0:b0:69b:1bd:7f9e with SMTP id
 m14-20020a9d7e8e000000b0069b01bd7f9emr286842otp.2.1679365762892; 
 Mon, 20 Mar 2023 19:29:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Il4/4FmteuZUKRVe4PVeRfV79koHDupfEDjFaaWhYBG5Ym845M15YX1cZWogrHAqfr33+4r1eTZKw5gCfwoQ=
X-Received: by 2002:a9d:7e8e:0:b0:69b:1bd:7f9e with SMTP id
 m14-20020a9d7e8e000000b0069b01bd7f9emr286836otp.2.1679365762635; Mon, 20 Mar
 2023 19:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230320232115.1940587-1-viktor@daynix.com>
In-Reply-To: <20230320232115.1940587-1-viktor@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Mar 2023 10:29:11 +0800
Message-ID: <CACGkMEu5qa2KUHti3w59DcXNxBdh8_ogZ9oW9bo1_PHwbNiCBg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
To: Viktor Prutyanov <viktor@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 mst@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, yan@daynix.com
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

T24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgNzoyMeKAr0FNIFZpa3RvciBQcnV0eWFub3YgPHZpa3Rv
ckBkYXluaXguY29tPiB3cm90ZToKPgo+IEFjY29yZGluZyB0byBWaXJ0SU8gc3BlYyB2MS4yLCBW
SVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSBmZWF0dXJlCj4gaW5kaWNhdGVzIHRoYXQgdGhlIGRy
aXZlciBwYXNzZXMgZXh0cmEgZGF0YSBhbG9uZyB3aXRoIHRoZSBxdWV1ZQo+IG5vdGlmaWNhdGlv
bnMuCj4KPiBJbiBhIHNwbGl0IHF1ZXVlIGNhc2UsIHRoZSBleHRyYSBkYXRhIGlzIDE2LWJpdCBh
dmFpbGFibGUgaW5kZXguIEluIGEKPiBwYWNrZWQgcXVldWUgY2FzZSwgdGhlIGV4dHJhIGRhdGEg
aXMgMS1iaXQgd3JhcCBjb3VudGVyIGFuZCAxNS1iaXQKPiBhdmFpbGFibGUgaW5kZXguCj4KPiBB
ZGQgc3VwcG9ydCBmb3IgdGhpcyBmZWF0dXJlIGZvciBNTUlPIGFuZCBQQ0kgdHJhbnNwb3J0cy4g
Q2hhbm5lbCBJL08KPiB0cmFuc3BvcnQgd2lsbCBub3QgYWNjZXB0IHRoaXMgZmVhdHVyZS4KPgo+
IFNpZ25lZC1vZmYtYnk6IFZpa3RvciBQcnV0eWFub3YgPHZpa3RvckBkYXluaXguY29tPgo+IC0t
LQo+Cj4gIHYyOiByZWplY3QgdGhlIGZlYXR1cmUgaW4gdmlydGlvX2NjdywgcmVwbGFjZSBfX2xl
MzIgd2l0aCB1MzIKPgo+ICBkcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRpb19jY3cuYyAgIHwgIDQg
Ky0tLQo+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jICAgICAgIHwgMTUgKysrKysrKysr
KysrKystCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgfCAxMCArKysrKysr
KysrCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmggfCAgNCArKysrCj4gIGRy
aXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgfCAgMiArLQo+ICBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX21vZGVybi5jIHwgIDIgKy0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYyAgICAgICB8IDE3ICsrKysrKysrKysrKysrKysrCj4gIGluY2x1ZGUvbGludXgvdmlydGlv
X3JpbmcuaCAgICAgICAgfCAgMiArKwo+ICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2NvbmZp
Zy5oIHwgIDYgKysrKysrCj4gIDkgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRpb19j
Y3cuYyBiL2RyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5jCj4gaW5kZXggYTEwZGJlNjMy
ZWY5Li5kNzJhNTk0MTU1MjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9zMzkwL3ZpcnRpby92aXJ0
aW9fY2N3LmMKPiArKysgYi9kcml2ZXJzL3MzOTAvdmlydGlvL3ZpcnRpb19jY3cuYwo+IEBAIC03
ODksOSArNzg5LDcgQEAgc3RhdGljIHU2NCB2aXJ0aW9fY2N3X2dldF9mZWF0dXJlcyhzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqdmRldikKPgo+ICBzdGF0aWMgdm9pZCBjY3dfdHJhbnNwb3J0X2ZlYXR1
cmVzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICB7Cj4gLSAgICAgICAvKgo+IC0gICAg
ICAgICogQ3VycmVudGx5IG5vdGhpbmcgdG8gZG8gaGVyZS4KPiAtICAgICAgICAqLwo+ICsgICAg
ICAgX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBKTsK
CklzIHRoZXJlIGFueSByZXN0cmljdGlvbiB0aGF0IHByZXZlbnRzIHVzIGZyb20gaW1wbGVtZW50
aW5nClZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBPyAoU3BlYyBzZWVtcyBkb2Vzbid0IGxpbWl0
IHVzIGZyb20gdGhpcykKCj4gIH0KPgo+ICBzdGF0aWMgaW50IHZpcnRpb19jY3dfZmluYWxpemVf
ZmVhdHVyZXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19tbWlvLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4g
aW5kZXggM2ZmNzQ2ZTNmMjRhLi4wZTEzZGExN2ZlMGEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX21taW8uYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMK
PiBAQCAtMjg1LDYgKzI4NSwxOSBAQCBzdGF0aWMgYm9vbCB2bV9ub3RpZnkoc3RydWN0IHZpcnRx
dWV1ZSAqdnEpCj4gICAgICAgICByZXR1cm4gdHJ1ZTsKPiAgfQo+Cj4gK3N0YXRpYyBib29sIHZt
X25vdGlmeV93aXRoX2RhdGEoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArICAgICAgIHN0
cnVjdCB2aXJ0aW9fbW1pb19kZXZpY2UgKnZtX2RldiA9IHRvX3ZpcnRpb19tbWlvX2RldmljZSh2
cS0+dmRldik7Cj4gKyAgICAgICB1MzIgZGF0YSA9IHZyaW5nX2ZpbGxfbm90aWZpY2F0aW9uX2Rh
dGEodnEpOwoKQ2FuIHdlIG1vdmUgdGhpcyB0byB0aGUgaW5pdGlhbGl6YXRpb24/CgpUaGFua3MK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
