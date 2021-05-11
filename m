Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F64C43460
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 08:31:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5335611C9
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 08:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5335611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68DC24065C;
	Tue, 11 May 2021 08:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OcF8hh-CHZyQ; Tue, 11 May 2021 08:31:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBAA240E73;
	Tue, 11 May 2021 08:31:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D428C000D;
	Tue, 11 May 2021 08:31:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DD92C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8BE3684467
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:31:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ij6g8r50jfeE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:31:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9711084418
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620721890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L03rSJtnAgFGyBancVHdJ/m6c98PSwpvaqqILqNedlU=;
 b=AOT/s5sGx44ID7+HBigkPDpbmdqz7uBmUh0SJr1B+OUube/p9QUkJD+gfnwG38TZgK+XEr
 OHJ+5FGvlUn38pBOVymjs18kN1l9VrjkSsZBoukXhSn+oO2h05wS2JAOrc34x3+CeUWrxJ
 m06pkTKAV0L+4yqrKnDV2MW4kWgceVE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-z6lB5VfROZSPtaumL-s2ow-1; Tue, 11 May 2021 04:31:27 -0400
X-MC-Unique: z6lB5VfROZSPtaumL-s2ow-1
Received: by mail-lf1-f72.google.com with SMTP id
 p20-20020a0565123134b02901d2ab33b9bcso4026625lfd.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 01:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L03rSJtnAgFGyBancVHdJ/m6c98PSwpvaqqILqNedlU=;
 b=eAXcztth62rQy2yVrANVHdSDaSKL//gdkFUIF20iyRKut1maJVltaqmnSxPt5vpkWV
 MyEzcwKtudHmoSqtpBTYg7+TJ3dmics6UUNUAkBr6KpsqXcVQI0/wsX30SpJVw8tz/4j
 N/KmQWH06+fKeBjNqmhsouptlIgPT0nkc70KqW9FgJVs37R0PuhTZYWYJmGfp9RhiAAw
 lj1MyJg0uVmZut9msy0Ytp9taklt/MJZCqCBKXyCzHG7Oph9jTKMFNiYnIkGviUG5BQz
 wNWRZFYyot5zk6FomRtIqVVW4JCaA6Wrls6AxSMUEG47pWfqHJ0pD2BYhMyuos0Nv3Di
 qtjg==
X-Gm-Message-State: AOAM531df07vBPKnzTF7ts/csTjs6mjDQrQDEbbHr57BG1YOvjFBWiGv
 221dh666WI7fNAxGB62YgAlGNiHEJyUpL51buXJ7UJflUMqUM4crzpqwBpvKncHLDMroUtIdch4
 qCHW80nNcXT5UKKJQPRkNCf5QF/8BNn9VsZfzD9nLVkxCv9ZKqMnIRzXqFA==
X-Received: by 2002:a05:651c:3cf:: with SMTP id
 f15mr6277317ljp.404.1620721885568; 
 Tue, 11 May 2021 01:31:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHLZ1YD9/2pHaEcCCi78y5495opccD/EC/LlPQBQi+2b5oR/fD3/SoV4oxtDLQhEshzmLVnKu039vKj+S2Isw=
X-Received: by 2002:a05:651c:3cf:: with SMTP id
 f15mr6277299ljp.404.1620721885330; 
 Tue, 11 May 2021 01:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-3-yuri.benditovich@daynix.com>
 <0e31ea70-f12a-070e-c72b-6e1d337a89bc@redhat.com>
 <CAOEp5Ofi52eCV1R261afkC2Oqgn5v8V6w3QQP8tHWcEiLmsUSQ@mail.gmail.com>
In-Reply-To: <CAOEp5Ofi52eCV1R261afkC2Oqgn5v8V6w3QQP8tHWcEiLmsUSQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 May 2021 16:31:10 +0800
Message-ID: <CACGkMEsKXWN9jQ23ix26DzKv-nUfUPHPEP9Trz0saCAZkMbdRA@mail.gmail.com>
Subject: Re: [PATCH 2/4] virtio-net: add support of UDP segmentation (USO) on
 the host
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBNYXkgMTEsIDIwMjEgYXQgNDoyNCBQTSBZdXJpIEJlbmRpdG92aWNoCjx5dXJpLmJl
bmRpdG92aWNoQGRheW5peC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBNYXkgMTEsIDIwMjEgYXQg
OTo0NyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPgo+
ID4g5ZyoIDIwMjEvNS8xMSDkuIvljYgxMjo0MiwgWXVyaSBCZW5kaXRvdmljaCDlhpnpgZM6Cj4g
PiA+IExhcmdlIFVEUCBwYWNrZXQgcHJvdmlkZWQgYnkgdGhlIGd1ZXN0IHdpdGggR1NPIHR5cGUg
c2V0IHRvCj4gPiA+IFZJUlRJT19ORVRfSERSX0dTT19VRFBfTDQgd2lsbCBiZSBkaXZpZGVkIHRv
IHNldmVyYWwgVURQCj4gPiA+IHBhY2tldHMgYWNjb3JkaW5nIHRvIHRoZSBnc29fc2l6ZSBmaWVs
ZC4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogWXVyaSBCZW5kaXRvdmljaCA8eXVyaS5iZW5k
aXRvdmljaEBkYXluaXguY29tPgo+ID4gPiAtLS0KPiA+ID4gICBpbmNsdWRlL2xpbnV4L3ZpcnRp
b19uZXQuaCB8IDUgKysrKysKPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
Cj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQuaCBiL2lu
Y2x1ZGUvbGludXgvdmlydGlvX25ldC5oCj4gPiA+IGluZGV4IGI0NjVmOGYzZTU1NC4uNGVjZjlh
MWNhOTEyIDEwMDY0NAo+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQuaAo+ID4g
PiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQuaAo+ID4gPiBAQCAtNTEsNiArNTEsMTEg
QEAgc3RhdGljIGlubGluZSBpbnQgdmlydGlvX25ldF9oZHJfdG9fc2tiKHN0cnVjdCBza19idWZm
ICpza2IsCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBpcF9wcm90byA9IElQUFJPVE9fVURQ
Owo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgdGhsZW4gPSBzaXplb2Yoc3RydWN0IHVkcGhk
cik7Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ID4gKyAgICAgICAgICAg
ICBjYXNlIFZJUlRJT19ORVRfSERSX0dTT19VRFBfTDQ6Cj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBnc29fdHlwZSA9IFNLQl9HU09fVURQX0w0Owo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgaXBfcHJvdG8gPSBJUFBST1RPX1VEUDsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHRo
bGVuID0gc2l6ZW9mKHN0cnVjdCB1ZHBoZHIpOwo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7Cj4gPgo+ID4KPiA+IFRoaXMgaXMgb25seSBmb3IgcngsIGhvdyBhYm91dCB0eD8KPgo+
IEluIHRlcm1zIG9mIHRoZSBndWVzdCB0aGlzIGlzIG9ubHkgZm9yIFRYLgoKU28gdmlydGlvX25l
dF9oZHJfdG9fc2tiKCkgY2FuIGJlIGNhbGxlZCBieSBhbGwgdGhlIGZvbGxvd2luZ3M6CgoxKSBy
ZWNlaXZlX2J1ZigpIHdoaWNoIGlzIGd1ZXN0IFJYLgoyKSB0dW5fZ2V0X3VzZXIoKSB3aGljaCBp
cyBndWVzdCBUWAozKSB0YXBfZ2V0X3VzZXIoKSB3aGljaCBpcyBndWVzdCBUWAo0KSB7dH1wYWNr
ZXRfc2VuZCgpIHdoaWNoIGlzIHVzZXJzcGFjZSBUWAoKU28gaXQgdG91Y2hlcyBmb3IgYm90aCBS
WCBhbmQgVFguCgo+IEd1ZXN0IFJYIGlzIGEgZGlmZmVyZW50IHRoaW5nLCB0aGlzIGlzIGFjdHVh
bGx5IGNvYWxlc2Npbmcgb2YKPiBzZWdtZW50ZWQgVURQIHBhY2tldHMgaW50byBhIGxhcmdlIG9u
ZS4KCkFub3RoZXIgY2FzZSwgdGhlIHBhY2tldCBjb3VsZCBiZSBzZW50IGZyb20gYW5vdGhlciBW
TSAobGlrZSB0aGUgVUZPIGNhc2UpLgoKU3VwcG9ydGluZyB0aGF0IGZvciBib3RoIFRYIGFuZCBS
WCBhbmQgZ3JlYXRseSBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZQpvZiBWTTJWTSB0cmFmZmljLgoK
VGhhbmtzCgo+IFRoaXMgZmVhdHVyZSBpcyBub3QgZGVmaW5lZCBpbiB0aGUgdmlydGlvIHNwZWMg
eWV0IGFuZCB0aGUgc3VwcG9ydCBvZgo+IGl0IGZpcnN0IG9mIGFsbCBkZXBlbmRzIG9uIHRoZSBP
Uy4KPiBGb3IgZXhhbXBsZTogVENQIExTTyAoZ3Vlc3QgVFgpIGlzIHN1cHBvcnRlZCBhbG1vc3Qg
YnkgYWxsIHRoZQo+IHZlcnNpb25zIG9mIFdpbmRvd3MuCj4gVENQIFJTQyAoY29hbGVzY2luZyBv
ZiBUQ1Agc2VnbWVudHMpIGlzIHN1cHBvcnRlZCBieSBXaW4gOCAvIFNlcnZlciAyMDEyIGFuZCB1
cC4KPiBVRFAgc2VnbWVudGF0aW9uIGlzIHN1cHBvcnRlZCBieSBXaW5kb3dzIGtlcm5lbHMgMTkw
MysKPiBVRFAgY29hbGVzY2luZyBpcyBkZWZpbmVkIGJ5IFdpbmRvd3Mga2VybmVscyAyMDA0KyBh
bmQgbm90IHN1cHBvcnRlZAo+IGJ5IHRoZSBkcml2ZXIgeWV0Lgo+Cj4gPgo+ID4gVGhhbmtzCj4g
Pgo+ID4KPiA+Cj4gPiA+ICAgICAgICAgICAgICAgZGVmYXVsdDoKPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4gPiAgICAgICAgICAgICAgIH0KPiA+Cj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
