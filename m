Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3916FC433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 07:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B9CF240140;
	Tue, 22 Feb 2022 07:12:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kSVpqMfIPPlr; Tue, 22 Feb 2022 07:12:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1387740145;
	Tue, 22 Feb 2022 07:12:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBF6AC001A;
	Tue, 22 Feb 2022 07:12:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78D98C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 594A060E95
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:11:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZFiUrLjTU5Pn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:11:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 508D1608D8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645513916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbPGUVXzkvzc74DLqJm1c8Hj2nJEWVdZ0kupOLHUBdM=;
 b=ajhQzB7AEfdj6BuFHD2ZcWTPNknHqWJtoHUq45/lMMclZM/eAN4hlyXiKYhe7ComOo29rH
 lbWhVsoSESNgAMuqHN7fmZmXPOD1jDzdcEuYRNZ+myX9w/7bZyy+uVsFORTgOTNymltfmF
 s8ACeF+/NmXXpQb7DV4PWoIpD72+C/E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-PRF1GUTAObW7SkDz8MdpHg-1; Tue, 22 Feb 2022 02:11:53 -0500
X-MC-Unique: PRF1GUTAObW7SkDz8MdpHg-1
Received: by mail-lj1-f200.google.com with SMTP id
 r27-20020a2e575b000000b002463f43ca0aso2599467ljd.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 23:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WbPGUVXzkvzc74DLqJm1c8Hj2nJEWVdZ0kupOLHUBdM=;
 b=g7Tiwn6+8+RnIHySAx2o85We4qkUDc22QIRPNCc7lET3uOyp5Zu62v2Dd4VcuroFtE
 uEn1e/Bm96v5Ph0z5nElP4lLbumPPbqrmUU+iw9PIYQS6v31NxHKmN1pVYq2a8Jgu198
 yWd5yTLneOWro4RCM+PlAZfgq9BGbBYxQGUkKYd4ewe7GSi7eLzyaW3R3qZdhoXZ3TMb
 iueGt9BeRKDumPywA/wGsw4Iav3B7Q3MKy4ShNRy2diMQ8oXMA2KQA1hD6TXoTKv/0qS
 7Hpj9ZO4SkzG2ZH274sq7g4MqjX8HUhLO+9FyzMoB4mb/rquIUZnkTCNZEOsYfMoyzKf
 roBA==
X-Gm-Message-State: AOAM532R5LHQWjO9raVUC4fRNDDa6zYAai4gZNhWqDqFlZhBcaLHaxW8
 QnvT4X7Q+K9mY57QcIkMeSdK0+pmoDUQV68VGwJ0snPT/mdUHEsJTbiKiG3bdB2S3XLjnlI76Kf
 syeMmB1746husb5ceQ+kJTNySyNW76LzwRsbWoMI5DdpeTUZoA+ABA6Xvzg==
X-Received: by 2002:a05:6512:911:b0:443:c1cf:6c25 with SMTP id
 e17-20020a056512091100b00443c1cf6c25mr12307404lft.580.1645513911125; 
 Mon, 21 Feb 2022 23:11:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW6UAMPm47Tz5cbuauTAEeQktrEWQ6LmnTTPJkdHWFb0wVqDi7KW3aEJeNdCxEt/wHRJeQ7QBp6RIXZIcLXLU=
X-Received: by 2002:a05:6512:911:b0:443:c1cf:6c25 with SMTP id
 e17-20020a056512091100b00443c1cf6c25mr12307391lft.580.1645513910925; Mon, 21
 Feb 2022 23:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20220221132020.198171-1-elic@nvidia.com>
 <CAJaqyWeOCs=QJkTU-GNYftgkbAk1XB=aLnJTxhJNMDh6_VaXsA@mail.gmail.com>
 <CACGkMEtZTFrw9Gp-YuvhuTDF5Taeum7zDRa_52NmCkvqSajkFA@mail.gmail.com>
 <20220222063247.GA95625@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20220222063247.GA95625@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Feb 2022 15:11:39 +0800
Message-ID: <CACGkMEtKt_1F6W900Ez8o0zvN3XW0oYAkWf+Sy5A_1w3WpnYQw@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Enlarge queue size to 512 entries
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eugenio Perez Martin <eperezma@redhat.com>
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

T24gVHVlLCBGZWIgMjIsIDIwMjIgYXQgMjozMyBQTSBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4KPiBPbiBUdWUsIEZlYiAyMiwgMjAyMiBhdCAxMToxODoxNEFNICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gVHVlLCBGZWIgMjIsIDIwMjIgYXQgMzowMCBBTSBFdWdl
bmlvIFBlcmV6IE1hcnRpbgo+ID4gPGVwZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+
ID4gPiBPbiBNb24sIEZlYiAyMSwgMjAyMiBhdCAyOjIwIFBNIEVsaSBDb2hlbiA8ZWxpY0Budmlk
aWEuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IEN1cnJlbnRseSB3ZSBjYW4gd29yayB3aXRo
IDUxMiBlbnRyaWVzIHdpdGggYW55IE1UVSBzaXplLiBDaGFuZ2UKPiA+ID4gPiBNTFg1X1ZEUEFf
TUFYX1ZRX0VOVFJJRVMgYWNjb3JkaW5nbHkuCj4gPiA+ID4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4gPiAgZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMiArLQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiBpbmRleCBiZTA5NWRjMTEzNGUuLmRlMTE1ZTNmZTc2
MSAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
PiA+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiBA
QCAtMjA2Miw3ICsyMDYyLDcgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF9jb25maWdfY2Io
c3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCBzdHJ1Y3QgdmRwYV9jYWxsYmEKPiA+ID4gPiAgICAg
ICAgIG5kZXYtPmNvbmZpZ19jYiA9ICpjYjsKPiA+ID4gPiAgfQo+ID4gPiA+Cj4gPiA+ID4gLSNk
ZWZpbmUgTUxYNV9WRFBBX01BWF9WUV9FTlRSSUVTIDI1Ngo+ID4gPiA+ICsjZGVmaW5lIE1MWDVf
VkRQQV9NQVhfVlFfRU5UUklFUyA1MTIKPiA+Cj4gPiBJJ2QgZXhwZWN0IHRoaXMgc2hvdWxkIGJl
IHNvbWV0aGluZyB0aGF0IGNhbiBiZSByZWFkIGZyb20gdGhlIGZ3IG9yCj4gPiBodz8gT3RoZXJ3
aXNlIHdlIGNhbid0IGluY3JlYXNlIGl0IGluIHRoZSBmdXR1cmUuCj4gPgo+Cj4gV2UgZG8gcmVh
ZCBhbGwgdGhlIHJlcXVpcmVkIHBhcmFtZXRlcnMgZnJvbSBmaXJtd2FyZSBpbiBvcmRlciB0byBm
dWxmaWxsCj4gYW55IHZhbGlkIHZhbHVlIHVwIHRvIHRoZSBzcGVjIGRlZmluZWQgbGltaXQgb2Yg
MzJLIGVudHJpZXMuIEJ1dCwgdGhlcmUKPiBhcmUgRlcgcmVsYXRlZCBpc3N1ZXMgdGhhdCB3aXRo
IDlLIE1UVSB3ZSB3aWxsIHN0YXJ0IHNlZWluZyBmaXJtd2FyZQo+IGVycm9ycyBpZiB3ZSBnbyBi
ZXlvbmQgNTEyLiBTbyBJIHRob3VnaHQgaXQgd291bGQgYmUgYmV0dGVyIHRvIGluY3JlYXNlCj4g
bnVtYmVyIG9mIGVudHJpZXMgdG8gYSBzYWZlIHZhbHVlIHRpbGwgd2UgaGF2ZSBvdGhlciBpc3N1
ZXMgcmVzb2x2ZWQuCgpJIHNlZS4KClNvCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KCj4KPiA+IFRoYW5rcwo+ID4KPiA+ID4gPiAgc3RhdGljIHUxNiBtbHg1X3Zk
cGFfZ2V0X3ZxX251bV9tYXgoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+ID4gPiA+ICB7Cj4g
PiA+ID4gICAgICAgICByZXR1cm4gTUxYNV9WRFBBX01BWF9WUV9FTlRSSUVTOwo+ID4gPiA+IC0t
Cj4gPiA+ID4gMi4zNS4xCj4gPiA+ID4KPiA+ID4KPiA+ID4gQWNrZWQtYnk6IEV1Z2VuaW8gUMOp
cmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+ID4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
