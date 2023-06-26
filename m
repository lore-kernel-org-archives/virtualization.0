Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0174EB64DC
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 03:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5D79940BD1;
	Mon, 26 Jun 2023 03:08:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D79940BD1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NuHZ434n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BPSVD2hBTcf4; Mon, 26 Jun 2023 03:08:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C108D4012D;
	Mon, 26 Jun 2023 03:08:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C108D4012D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C1DEC0037;
	Mon, 26 Jun 2023 03:08:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 242B0C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 03:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2AAE40424
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 03:08:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F2AAE40424
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nZK4y1BsxN6U
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 03:08:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12A274012D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12A274012D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 03:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687748909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+pWG1D7e/A+cYywe5zVuMMMFISdk9+OXc1rsWGkOHM=;
 b=NuHZ434nY1dO5l7dHzW2jri5CCF1MylNL81u5BxVxEhYT/0sfo7UY060CbzuQ33+OHlrKZ
 t4XO77dMabOe//xdoz/WGPYMFTVDEHzWch9es9FrZnN/D1vA1Ga7VtK+qgW/hvF70JtVUF
 IUpkAM5gmnsTR1bQryvG/yege4iRxb0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-pgzLCAB-N_yE2dKdnlmNmA-1; Sun, 25 Jun 2023 23:08:28 -0400
X-MC-Unique: pgzLCAB-N_yE2dKdnlmNmA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb3f3a87d4so372414e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 20:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687748906; x=1690340906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+pWG1D7e/A+cYywe5zVuMMMFISdk9+OXc1rsWGkOHM=;
 b=TTEegnCf5uhLjj1pAHj7/XXy3PVoqe8Ydo/nHW/j+ODZQgkzi0yKTjBJASnC5z5zHa
 ++uD4XxWhUuD/Tj0Bbodf31kw9JEJWtjtqNNsK+aU5lsv4fZ5mrfxRwR7fiooKdy6EUf
 d1mdZZFFJn6ZIaH92bBJcy0VsjE2STEHtRIfHGFDd1ye3HMsXGJTU77BVrwEnh18ideW
 HCnPdBIjtiH358PQoUhrkrWXnPl2jw2yew3xWGr1U9ohyS4J7fvKcohmm+wpBJGKj+cx
 MCyzrxICWFy73Vd2g3t46KYBcLP+A/3YO/c9WclB/kkRhIe6sBqsrQshfg3tC4yZ2Kk5
 wPLw==
X-Gm-Message-State: AC+VfDxifyWkJcXgtmBh4OhUDUgeTALQ4ai+xBKzeX6jGIXKaFal5QNh
 WKkdrIOTVybvre6zead/1oH+Vd/elquZNQBYh3DrJF6WJavLUl4sjOTFmmiI6uD/g0a52CLum2T
 roOQQGG4Iw3Q2TH1t4QhUBX18FPEsTth2CxRPQ5pbQIj1VDtccPZ4mIQbNg==
X-Received: by 2002:a19:5f5d:0:b0:4f8:5e62:b94b with SMTP id
 a29-20020a195f5d000000b004f85e62b94bmr7989843lfj.9.1687748906741; 
 Sun, 25 Jun 2023 20:08:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gAcONiUlVNLeF7Qu1J/UqNC75pdvtjmEEQ5QFLm5RQJMRkgS7gOiIiu3IidnT3bJ9UC8bqWPi+QRSmCToDlY=
X-Received: by 2002:a19:5f5d:0:b0:4f8:5e62:b94b with SMTP id
 a29-20020a195f5d000000b004f85e62b94bmr7989838lfj.9.1687748906397; Sun, 25 Jun
 2023 20:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
 <CACGkMEtp6H1x301CynwDfsXCMOVt_mrVh9G7dUxVdDLdLBB8yg@mail.gmail.com>
 <TY2PR06MB34247A17ADD347D439EF84DA8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <CACGkMEuXfo3DRrAfrwFPfKaOTCkmJ7hxVw=JVP12mPBM8Ccp=A@mail.gmail.com>
 <TY2PR06MB3424EA4EADAE511ED3CB282C8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PR06MB3424EA4EADAE511ED3CB282C8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Jun 2023 11:08:15 +0800
Message-ID: <CACGkMEuDKivK69Fky3y9UqC3VCk=e1f98QmkxNqVZcW1-PF4tw@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
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

T24gTW9uLCBKdW4gMjYsIDIwMjMgYXQgMTE6MDLigK9BTSBBbmd1cyBDaGVuIDxhbmd1cy5jaGVu
QGphZ3Vhcm1pY3JvLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQo+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+IFNlbnQ6
IE1vbmRheSwgSnVuZSAyNiwgMjAyMyAxMDo1MSBBTQo+ID4gVG86IEFuZ3VzIENoZW4gPGFuZ3Vz
LmNoZW5AamFndWFybWljcm8uY29tPgo+ID4gQ2M6IG1zdEByZWRoYXQuY29tOyB2aXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsKPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcKPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHZkcGEvdnBfdmRwYTogQ2hlY2sg
cXVldWUgbnVtYmVyIG9mIHZkcGEgZGV2aWNlIGZyb20KPiA+IGFkZF9jb25maWcKPiA+Cj4gPiBP
biBNb24sIEp1biAyNiwgMjAyMyBhdCAxMDo0MuKAr0FNIEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5A
amFndWFybWljcm8uY29tPgo+ID4gd3JvdGU6Cj4gPiA+Cj4gPiA+Cj4gPiA+IEhp77yMamFzb24u
Cj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+ID4gPiBGcm9tOiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+IFNlbnQ6IE1vbmRheSwgSnVuZSAyNiwg
MjAyMyAxMDozMCBBTQo+ID4gPiA+IFRvOiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1p
Y3JvLmNvbT4KPiA+ID4gPiBDYzogbXN0QHJlZGhhdC5jb207IHZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnOwo+ID4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcKPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSB2ZHBhL3ZwX3ZkcGE6IENoZWNrIHF1
ZXVlIG51bWJlciBvZiB2ZHBhIGRldmljZQo+ID4gZnJvbQo+ID4gPiA+IGFkZF9jb25maWcKPiA+
ID4gPgo+ID4gPiA+IE9uIFRodSwgSnVuIDgsIDIwMjMgYXQgNTowMuKAr1BNIEFuZ3VzIENoZW4K
PiA+IDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4KPiA+ID4gPiB3cm90ZToKPiA+ID4gPiA+
Cj4gPiA+ID4gPiBXaGVuIGFkZCB2aXJ0aW9fcGNpIHZkcGEgZGV2aWNlLGNoZWNrIHRoZSB2cXMg
bnVtYmVyIG9mIGRldmljZSBjYXAKPiA+ID4gPiA+IGFuZCBtYXhfdnFfcGFpcnMgZnJvbSBhZGRf
Y29uZmlnLgo+ID4gPiA+ID4gU2ltcGx5IHN0YXJ0aW5nIGZyb20gZmFpbGluZyBpZiB0aGUgcHJv
dmlzaW9uZWQgI3FwIGlzIG5vdAo+ID4gPiA+ID4gZXF1YWwgdG8gdGhlIG9uZSB0aGF0IGhhcmR3
YXJlIGhhcy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBDaGVuIDxh
bmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4KPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gdjE6IFVz
ZSBtYXhfdnFzIGZyb20gYWRkX2NvbmZpZwo+ID4gPiA+ID4gdjI6IEp1c3QgcmV0dXJuIGZhaWwg
aWYgbWF4X3ZxcyBmcm9tIGFkZF9jb25maWcgaXMgbm90IHNhbWUgYXMgZGV2aWNlCj4gPiA+ID4g
PiAgICAgICAgIGNhcC4gU3VnZ2VzdGVkIGJ5IGphc29uLgo+ID4gPiA+ID4KPiA+ID4gPiA+ICBk
cml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMgfCAzNSArKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyks
IDE0IGRlbGV0aW9ucygtKQo+ID4gPiA+ID4KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPiA+ID4gPiBiL2RyaXZlcnMvdmRwYS92aXJ0aW9f
cGNpL3ZwX3ZkcGEuYwo+ID4gPiA+ID4gaW5kZXggMjgxMjg3ZmFlODlmLi5jMWZiNjk2M2RhMTIg
MTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMK
PiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+ID4gPiA+
ID4gQEAgLTQ4MCwzMiArNDgwLDM5IEBAIHN0YXRpYyBpbnQgdnBfdmRwYV9kZXZfYWRkKHN0cnVj
dAo+ID4gPiA+IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPiA+ID4g
PiA+ICAgICAgICAgdTY0IGRldmljZV9mZWF0dXJlczsKPiA+ID4gPiA+ICAgICAgICAgaW50IHJl
dCwgaTsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAtICAgICAgIHZwX3ZkcGEgPSB2ZHBhX2FsbG9jX2Rl
dmljZShzdHJ1Y3QgdnBfdmRwYSwgdmRwYSwKPiA+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRldiwgJnZwX3ZkcGFfb3BzLCAxLCAxLAo+ID4gbmFtZSwKPiA+ID4g
PiBmYWxzZSk7Cj4gPiA+ID4gPiAtCj4gPiA+ID4gPiAtICAgICAgIGlmIChJU19FUlIodnBfdmRw
YSkpIHsKPiA+ID4gPiA+IC0gICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgInZwX3ZkcGE6IEZh
aWxlZCB0byBhbGxvY2F0ZSB2RFBBCj4gPiA+ID4gc3RydWN0dXJlXG4iKTsKPiA+ID4gPiA+IC0g
ICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUih2cF92ZHBhKTsKPiA+ID4gPiA+ICsgICAgICAg
aWYgKGFkZF9jb25maWctPm1hc2sgJgo+ID4gPiA+IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRf
Q0ZHX01BWF9WUVApKSB7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgaWYgKGFkZF9jb25maWct
Pm5ldC5tYXhfdnFfcGFpcnMgIT0KPiA+ID4gPiAodl9tZGV2LT5tYXhfc3VwcG9ydGVkX3ZxcyAv
IDIpKSB7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5k
ZXYsICJtYXggdnFzIDB4JXggc2hvdWxkCj4gPiBiZQo+ID4gPiA+IGVxdWFsIHRvIDB4JXggd2hp
Y2ggZGV2aWNlIGhhc1xuIiwKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYWRkX2NvbmZpZy0+bmV0Lm1heF92cV9wYWlycyoyLAo+ID4gPiA+IHZfbWRldi0+bWF4X3N1
cHBvcnRlZF92cXMpOwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgfQo+ID4gPiA+ID4gICAgICAgICB9Cj4g
PiA+ID4gPgo+ID4gPiA+ID4gLSAgICAgICB2cF92ZHBhX21ndGRldi0+dnBfdmRwYSA9IHZwX3Zk
cGE7Cj4gPiA+ID4gPiAtCj4gPiA+ID4gPiAtICAgICAgIHZwX3ZkcGEtPnZkcGEuZG1hX2RldiA9
ICZwZGV2LT5kZXY7Cj4gPiA+ID4gPiAtICAgICAgIHZwX3ZkcGEtPnF1ZXVlcyA9IHZwX21vZGVy
bl9nZXRfbnVtX3F1ZXVlcyhtZGV2KTsKPiA+ID4gPiA+IC0gICAgICAgdnBfdmRwYS0+bWRldiA9
IG1kZXY7Cj4gPiA+ID4gPiAtCj4gPiA+ID4gPiAgICAgICAgIGRldmljZV9mZWF0dXJlcyA9IHZw
X21vZGVybl9nZXRfZmVhdHVyZXMobWRldik7Cj4gPiA+ID4gPiAgICAgICAgIGlmIChhZGRfY29u
ZmlnLT5tYXNrICYgQklUX1VMTChWRFBBX0FUVFJfREVWX0ZFQVRVUkVTKSkKPiA+IHsKPiA+ID4g
PiA+ICAgICAgICAgICAgICAgICBpZiAoYWRkX2NvbmZpZy0+ZGV2aWNlX2ZlYXR1cmVzICYgfmRl
dmljZV9mZWF0dXJlcykgewo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0g
LUVJTlZBTDsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYt
PmRldiwgIlRyeSB0byBwcm92aXNpb24KPiA+IGZlYXR1cmVzCj4gPiA+ID4gIgo+ID4gPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAidGhhdCBhcmUgbm90IHN1cHBvcnRlZCBi
eSB0aGUKPiA+IGRldmljZToKPiA+ID4gPiAiCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJkZXZpY2VfZmVhdHVyZXMgMHglbGx4Cj4gPiBwcm92aXNpb25lZAo+ID4g
PiA+IDB4JWxseFxuIiwKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZGV2aWNlX2ZlYXR1cmVzLAo+ID4gPiA+IGFkZF9jb25maWctPmRldmljZV9mZWF0dXJlcyk7Cj4g
PiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjsKPiA+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgIH0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBkZXZpY2VfZmVhdHVyZXMgPSBhZGRfY29u
ZmlnLT5kZXZpY2VfZmVhdHVyZXM7Cj4gPiA+ID4gPiAgICAgICAgIH0KPiA+ID4gPiA+ICsKPiA+
ID4gPiA+ICsgICAgICAgdnBfdmRwYSA9IHZkcGFfYWxsb2NfZGV2aWNlKHN0cnVjdCB2cF92ZHBh
LCB2ZHBhLAo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2
LCAmdnBfdmRwYV9vcHMsIDEsIDEsCj4gPiBuYW1lLAo+ID4gPiA+IGZhbHNlKTsKPiA+ID4gPiA+
ICsKPiA+ID4gPiA+ICsgICAgICAgaWYgKElTX0VSUih2cF92ZHBhKSkgewo+ID4gPiA+ID4gKyAg
ICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAidnBfdmRwYTogRmFpbGVkIHRvIGFsbG9jYXRlIHZE
UEEKPiA+ID4gPiBzdHJ1Y3R1cmVcbiIpOwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVy
biBQVFJfRVJSKHZwX3ZkcGEpOwo+ID4gPiA+ID4gKyAgICAgICB9Cj4gPiA+ID4gPiArCj4gPiA+
ID4gPiArICAgICAgIHZwX3ZkcGFfbWd0ZGV2LT52cF92ZHBhID0gdnBfdmRwYTsKPiA+ID4gPiA+
ICsKPiA+ID4gPiA+ICsgICAgICAgdnBfdmRwYS0+dmRwYS5kbWFfZGV2ID0gJnBkZXYtPmRldjsK
PiA+ID4gPiA+ICsgICAgICAgdnBfdmRwYS0+cXVldWVzID0gdl9tZGV2LT5tYXhfc3VwcG9ydGVk
X3ZxczsKPiA+ID4gPgo+ID4gPiA+IFdoeSBib3RoZXIgd2l0aCB0aG9zZSBjaGFuZ2VzPwo+ID4g
PiA+Cj4gPiA+ID4gICAgICAgICBtZ3RkZXYtPm1heF9zdXBwb3J0ZWRfdnFzID0KPiA+IHZwX21v
ZGVybl9nZXRfbnVtX3F1ZXVlcyhtZGV2KTsKPiA+ID4gbWF4X3N1cHBvcnRlZF92cXMgd2lsbCBu
b3QgYmUgY2hhbmdlZCwgc28gd2UgY2FuIGdldCBtYXhfc3VwcG9ydGVkX3Zxcwo+ID4gZnJvbSBt
Z3RkZXYtPm1heF9zdXBwb3J0ZWRfdnFzLgo+ID4gPiBJZiB3ZSB1c2UgdnBfbW9kZXJuX2dldF9u
dW1fcXVldWVzKG1kZXYpLGl0IHdpbGwgdXNlIHRscCB0byBjb21tdW5pY2F0ZQo+ID4gd2l0aCBk
ZXZpY2UuCj4gPiA+IEl0IGp1c3QgcmVkdWNlIHNvbWUgdGxwIC4KPiA+Cj4gPiBPaywgYnV0Cj4g
Pgo+ID4gMSkgSSB0aGluayB3ZSBkb24ndCBjYXJlIHRoZSBwZXJmb3JtYW5jZSBoZXJlCj4gPiAy
KSBJZiB3ZSBkaWQsIGxldCdzIHVzZSBhIHNlcGFyYXRlIHBhdGNoIHRvIGRvIHRoYXQgYXMgYW4g
b3B0aW1pemF0aW9uCj4gPgo+IFRoYW5rIHlvdS5BcyBtc3QgZGlkIG5vdCBzdXBwb3J0IHRoaXMg
cGF0Y2ggc29tZSBkYXlzIGFnbyxzbyB0aGlzIHBhdGNoIHdpbGwgYmUgZHJvcHBlZC4KPiBJIHBs
YW4gdG8gcHVzaCBhIGRlcGVuZGVudCBkcml2ZXIgb2Ygb3VyIHByb2R1Y3QgcmF0aGVyIHRoYW4g
cmV1c2UgdnBfdmRwYS4KClRoYXQgd291bGQgYmUgZmluZS4gQnV0IHBsZWFzZSB0cnkgYmVzdCB0
byByZXVzZSBtb2Rlcm4gdmlydGlvLXBjaSBsaWJyYXJ5LgoKPiBCeSB0aGUgd2F5ICxpZiBJIHdh
bnQgdG8gYWRkIHNyaW92IHN1cHBvcnQgaW4gb3VyIHZkcGEgcGNpIGRyaXZlcix3b3VsZCBpdCBi
ZSBhY2NlcHRlZCBvciBub3Q/CgpJIHRoaW5rIHRoZSBhbnN3ZXIgaXMgeWVzLgoKVGhhbmtzCgo+
ID4gVGhhbmtzCj4gPgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4gPgo+ID4g
PiA+ID4gKyAgICAgICB2cF92ZHBhLT5tZGV2ID0gbWRldjsKPiA+ID4gPiA+ICAgICAgICAgdnBf
dmRwYS0+ZGV2aWNlX2ZlYXR1cmVzID0gZGV2aWNlX2ZlYXR1cmVzOwo+ID4gPiA+ID4KPiA+ID4g
PiA+ICAgICAgICAgcmV0ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwKPiA+IHZwX3Zk
cGFfZnJlZV9pcnFfdmVjdG9ycywKPiA+ID4gPiBwZGV2KTsKPiA+ID4gPiA+IC0tCj4gPiA+ID4g
PiAyLjI1LjEKPiA+ID4gPiA+Cj4gPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
