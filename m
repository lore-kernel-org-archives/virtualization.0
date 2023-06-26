Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F0FEB64DC
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 02:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47C868200B;
	Mon, 26 Jun 2023 02:51:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47C868200B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVEE5Ewp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id glft2iNo8bOK; Mon, 26 Jun 2023 02:51:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B596381FF9;
	Mon, 26 Jun 2023 02:51:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B596381FF9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D530C0037;
	Mon, 26 Jun 2023 02:51:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 562FAC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30BCE40424
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:51:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30BCE40424
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVEE5Ewp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JFDsveDfqMYe
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:51:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 478504012D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 478504012D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687747885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0vYrUDyV/6RMq5CSF7DYnD/d7A80ahqpZ8xKzvwRDs=;
 b=AVEE5EwpUrXj5dBZ3eWEZ2ysvKud0SjBpSplf8cAhPvVuHyKXT8WZKBQ6MAIK8EGo8kXwy
 dpjq1u9V2KuHSB3bUy/xEIrtV9QnwdY43Ea3S4UcLuMTGylMxSZnm5FPtRXFZh5sITkZwt
 SZ6ZLfBL+zZ+a80rQgHVQFVUttU/aIE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-FC9xwwAaOP6qu6pKKIoSMg-1; Sun, 25 Jun 2023 22:51:24 -0400
X-MC-Unique: FC9xwwAaOP6qu6pKKIoSMg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4edbdd8268bso1756548e87.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 19:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687747882; x=1690339882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0vYrUDyV/6RMq5CSF7DYnD/d7A80ahqpZ8xKzvwRDs=;
 b=PJfQ/OIvRty0KbN2+9VD69Ejw1f/V25Fsdq3bSNgjw7m6O8vx/OPVr/COzoKd3CGeP
 2h9cx67Vo+jxQsw87N8GWoCJegnFwIpbqV9ZvZS7pT5DRSh/+uNt2feKCxvhOa3g8Zxd
 0LUV3mqTpxa/zSsRzEPXEvfxbO9YdeykwVnCEGkBbeu6RdQffp81T6tgqYyrdjv2Wbar
 hCnk/coUcIaZtEaHcTMcYmndZ66lr+FG3jeiesQqUbXX9LyceYwtFNi+qi1TaVG4MCcq
 JE1sepXnl0ms9lmK888RxJMGYnGzrkMjvCK50aZNoO9CtusHOArbzuujW4Vbqc5yCtT3
 qmtw==
X-Gm-Message-State: AC+VfDxwBoFa1RV4AOy4BraqKy9ULeRxabjYirzVdnyoVQdvF4oU973n
 OG2ugdenU94UDdtuJblCJ1z5FTCl297Zq1r2nZA8dJcZlXGCkMUKtiIneTiJQPuLEqVEwm5ClTg
 FOMRsOiSATORfL5j0mwf8qBNCS7L9/3Yo48shnhp4dlisINfAcVqluKcEYw==
X-Received: by 2002:a19:e34a:0:b0:4f8:4263:42f with SMTP id
 c10-20020a19e34a000000b004f84263042fmr15449492lfk.17.1687747882744; 
 Sun, 25 Jun 2023 19:51:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4u/Cj2EZgmu8RH/cDDxOTUvw6aWO+J3zOZLz0Q8XLq33+9vmn8d4xns+raM0RyE3hqVH1pfKjQpvbICCgQbmM=
X-Received: by 2002:a19:e34a:0:b0:4f8:4263:42f with SMTP id
 c10-20020a19e34a000000b004f84263042fmr15449488lfk.17.1687747882465; Sun, 25
 Jun 2023 19:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
 <CACGkMEtp6H1x301CynwDfsXCMOVt_mrVh9G7dUxVdDLdLBB8yg@mail.gmail.com>
 <TY2PR06MB34247A17ADD347D439EF84DA8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PR06MB34247A17ADD347D439EF84DA8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Jun 2023 10:51:11 +0800
Message-ID: <CACGkMEuXfo3DRrAfrwFPfKaOTCkmJ7hxVw=JVP12mPBM8Ccp=A@mail.gmail.com>
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

T24gTW9uLCBKdW4gMjYsIDIwMjMgYXQgMTA6NDLigK9BTSBBbmd1cyBDaGVuIDxhbmd1cy5jaGVu
QGphZ3Vhcm1pY3JvLmNvbT4gd3JvdGU6Cj4KPgo+IEhp77yMamFzb24uCj4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQo+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KPiA+IFNlbnQ6IE1vbmRheSwgSnVuZSAyNiwgMjAyMyAxMDozMCBBTQo+ID4gVG86IEFuZ3Vz
IENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPgo+ID4gQ2M6IG1zdEByZWRoYXQuY29t
OyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsKPiA+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHZkcGEvdnBf
dmRwYTogQ2hlY2sgcXVldWUgbnVtYmVyIG9mIHZkcGEgZGV2aWNlIGZyb20KPiA+IGFkZF9jb25m
aWcKPiA+Cj4gPiBPbiBUaHUsIEp1biA4LCAyMDIzIGF0IDU6MDLigK9QTSBBbmd1cyBDaGVuIDxh
bmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4KPiA+IHdyb3RlOgo+ID4gPgo+ID4gPiBXaGVuIGFk
ZCB2aXJ0aW9fcGNpIHZkcGEgZGV2aWNlLGNoZWNrIHRoZSB2cXMgbnVtYmVyIG9mIGRldmljZSBj
YXAKPiA+ID4gYW5kIG1heF92cV9wYWlycyBmcm9tIGFkZF9jb25maWcuCj4gPiA+IFNpbXBseSBz
dGFydGluZyBmcm9tIGZhaWxpbmcgaWYgdGhlIHByb3Zpc2lvbmVkICNxcCBpcyBub3QKPiA+ID4g
ZXF1YWwgdG8gdGhlIG9uZSB0aGF0IGhhcmR3YXJlIGhhcy4KPiA+ID4KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+Cj4gPiA+IC0tLQo+
ID4gPiB2MTogVXNlIG1heF92cXMgZnJvbSBhZGRfY29uZmlnCj4gPiA+IHYyOiBKdXN0IHJldHVy
biBmYWlsIGlmIG1heF92cXMgZnJvbSBhZGRfY29uZmlnIGlzIG5vdCBzYW1lIGFzIGRldmljZQo+
ID4gPiAgICAgICAgIGNhcC4gU3VnZ2VzdGVkIGJ5IGphc29uLgo+ID4gPgo+ID4gPiAgZHJpdmVy
cy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jIHwgMzUgKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDE0IGRlbGV0
aW9ucygtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kv
dnBfdmRwYS5jCj4gPiBiL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+ID4gPiBp
bmRleCAyODEyODdmYWU4OWYuLmMxZmI2OTYzZGExMiAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVy
cy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS92aXJ0
aW9fcGNpL3ZwX3ZkcGEuYwo+ID4gPiBAQCAtNDgwLDMyICs0ODAsMzkgQEAgc3RhdGljIGludCB2
cF92ZHBhX2Rldl9hZGQoc3RydWN0Cj4gPiB2ZHBhX21nbXRfZGV2ICp2X21kZXYsIGNvbnN0IGNo
YXIgKm5hbWUsCj4gPiA+ICAgICAgICAgdTY0IGRldmljZV9mZWF0dXJlczsKPiA+ID4gICAgICAg
ICBpbnQgcmV0LCBpOwo+ID4gPgo+ID4gPiAtICAgICAgIHZwX3ZkcGEgPSB2ZHBhX2FsbG9jX2Rl
dmljZShzdHJ1Y3QgdnBfdmRwYSwgdmRwYSwKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZGV2LCAmdnBfdmRwYV9vcHMsIDEsIDEsIG5hbWUsCj4gPiBmYWxzZSk7Cj4g
PiA+IC0KPiA+ID4gLSAgICAgICBpZiAoSVNfRVJSKHZwX3ZkcGEpKSB7Cj4gPiA+IC0gICAgICAg
ICAgICAgICBkZXZfZXJyKGRldiwgInZwX3ZkcGE6IEZhaWxlZCB0byBhbGxvY2F0ZSB2RFBBCj4g
PiBzdHJ1Y3R1cmVcbiIpOwo+ID4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIodnBf
dmRwYSk7Cj4gPiA+ICsgICAgICAgaWYgKGFkZF9jb25maWctPm1hc2sgJgo+ID4gQklUX1VMTChW
RFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZRUCkpIHsKPiA+ID4gKyAgICAgICAgICAgICAgIGlm
IChhZGRfY29uZmlnLT5uZXQubWF4X3ZxX3BhaXJzICE9Cj4gPiAodl9tZGV2LT5tYXhfc3VwcG9y
dGVkX3ZxcyAvIDIpKSB7Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBk
ZXYtPmRldiwgIm1heCB2cXMgMHgleCBzaG91bGQgYmUKPiA+IGVxdWFsIHRvIDB4JXggd2hpY2gg
ZGV2aWNlIGhhc1xuIiwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRf
Y29uZmlnLT5uZXQubWF4X3ZxX3BhaXJzKjIsCj4gPiB2X21kZXYtPm1heF9zdXBwb3J0ZWRfdnFz
KTsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gPiA+ICsg
ICAgICAgICAgICAgICB9Cj4gPiA+ICAgICAgICAgfQo+ID4gPgo+ID4gPiAtICAgICAgIHZwX3Zk
cGFfbWd0ZGV2LT52cF92ZHBhID0gdnBfdmRwYTsKPiA+ID4gLQo+ID4gPiAtICAgICAgIHZwX3Zk
cGEtPnZkcGEuZG1hX2RldiA9ICZwZGV2LT5kZXY7Cj4gPiA+IC0gICAgICAgdnBfdmRwYS0+cXVl
dWVzID0gdnBfbW9kZXJuX2dldF9udW1fcXVldWVzKG1kZXYpOwo+ID4gPiAtICAgICAgIHZwX3Zk
cGEtPm1kZXYgPSBtZGV2Owo+ID4gPiAtCj4gPiA+ICAgICAgICAgZGV2aWNlX2ZlYXR1cmVzID0g
dnBfbW9kZXJuX2dldF9mZWF0dXJlcyhtZGV2KTsKPiA+ID4gICAgICAgICBpZiAoYWRkX2NvbmZp
Zy0+bWFzayAmIEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9GRUFUVVJFUykpIHsKPiA+ID4gICAgICAg
ICAgICAgICAgIGlmIChhZGRfY29uZmlnLT5kZXZpY2VfZmVhdHVyZXMgJiB+ZGV2aWNlX2ZlYXR1
cmVzKSB7Cj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7Cj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgIlRyeSB0byBwcm92
aXNpb24gZmVhdHVyZXMKPiA+ICIKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAidGhhdCBhcmUgbm90IHN1cHBvcnRlZCBieSB0aGUgZGV2aWNlOgo+ID4gIgo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJkZXZpY2VfZmVhdHVyZXMgMHglbGx4IHByb3Zp
c2lvbmVkCj4gPiAweCVsbHhcbiIsCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZGV2aWNlX2ZlYXR1cmVzLAo+ID4gYWRkX2NvbmZpZy0+ZGV2aWNlX2ZlYXR1cmVzKTsKPiA+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnI7Cj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4gPiAgICAgICAgICAgICAgICAgfQo+ID4gPiAg
ICAgICAgICAgICAgICAgZGV2aWNlX2ZlYXR1cmVzID0gYWRkX2NvbmZpZy0+ZGV2aWNlX2ZlYXR1
cmVzOwo+ID4gPiAgICAgICAgIH0KPiA+ID4gKwo+ID4gPiArICAgICAgIHZwX3ZkcGEgPSB2ZHBh
X2FsbG9jX2RldmljZShzdHJ1Y3QgdnBfdmRwYSwgdmRwYSwKPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZGV2LCAmdnBfdmRwYV9vcHMsIDEsIDEsIG5hbWUsCj4gPiBm
YWxzZSk7Cj4gPiA+ICsKPiA+ID4gKyAgICAgICBpZiAoSVNfRVJSKHZwX3ZkcGEpKSB7Cj4gPiA+
ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgInZwX3ZkcGE6IEZhaWxlZCB0byBhbGxvY2F0
ZSB2RFBBCj4gPiBzdHJ1Y3R1cmVcbiIpOwo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIFBU
Ul9FUlIodnBfdmRwYSk7Cj4gPiA+ICsgICAgICAgfQo+ID4gPiArCj4gPiA+ICsgICAgICAgdnBf
dmRwYV9tZ3RkZXYtPnZwX3ZkcGEgPSB2cF92ZHBhOwo+ID4gPiArCj4gPiA+ICsgICAgICAgdnBf
dmRwYS0+dmRwYS5kbWFfZGV2ID0gJnBkZXYtPmRldjsKPiA+ID4gKyAgICAgICB2cF92ZHBhLT5x
dWV1ZXMgPSB2X21kZXYtPm1heF9zdXBwb3J0ZWRfdnFzOwo+ID4KPiA+IFdoeSBib3RoZXIgd2l0
aCB0aG9zZSBjaGFuZ2VzPwo+ID4KPiA+ICAgICAgICAgbWd0ZGV2LT5tYXhfc3VwcG9ydGVkX3Zx
cyA9IHZwX21vZGVybl9nZXRfbnVtX3F1ZXVlcyhtZGV2KTsKPiBtYXhfc3VwcG9ydGVkX3ZxcyB3
aWxsIG5vdCBiZSBjaGFuZ2VkLCBzbyB3ZSBjYW4gZ2V0IG1heF9zdXBwb3J0ZWRfdnFzIGZyb20g
bWd0ZGV2LT5tYXhfc3VwcG9ydGVkX3Zxcy4KPiBJZiB3ZSB1c2UgdnBfbW9kZXJuX2dldF9udW1f
cXVldWVzKG1kZXYpLGl0IHdpbGwgdXNlIHRscCB0byBjb21tdW5pY2F0ZSB3aXRoIGRldmljZS4K
PiBJdCBqdXN0IHJlZHVjZSBzb21lIHRscCAuCgpPaywgYnV0CgoxKSBJIHRoaW5rIHdlIGRvbid0
IGNhcmUgdGhlIHBlcmZvcm1hbmNlIGhlcmUKMikgSWYgd2UgZGlkLCBsZXQncyB1c2UgYSBzZXBh
cmF0ZSBwYXRjaCB0byBkbyB0aGF0IGFzIGFuIG9wdGltaXphdGlvbgoKVGhhbmtzCgo+ID4KPiA+
IFRoYW5rcwo+ID4KPiA+Cj4gPiA+ICsgICAgICAgdnBfdmRwYS0+bWRldiA9IG1kZXY7Cj4gPiA+
ICAgICAgICAgdnBfdmRwYS0+ZGV2aWNlX2ZlYXR1cmVzID0gZGV2aWNlX2ZlYXR1cmVzOwo+ID4g
Pgo+ID4gPiAgICAgICAgIHJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkZXYsIHZwX3Zk
cGFfZnJlZV9pcnFfdmVjdG9ycywKPiA+IHBkZXYpOwo+ID4gPiAtLQo+ID4gPiAyLjI1LjEKPiA+
ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
