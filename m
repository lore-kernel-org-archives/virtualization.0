Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84912E81813
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 02:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F73B41B9E;
	Tue, 26 Sep 2023 02:57:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F73B41B9E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pf7E7FZn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HhGoT6zwSNP3; Tue, 26 Sep 2023 02:57:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 51B5941B79;
	Tue, 26 Sep 2023 02:57:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51B5941B79
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 275D5C0071;
	Tue, 26 Sep 2023 02:57:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6F6DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 80CD9613AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:57:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80CD9613AF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pf7E7FZn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YhxE1-YwlHzy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:57:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8AB961395
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:57:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8AB961395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695697063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8rCoPOuaYDCIDe0rlK/tHfmdP2Iqj9+uLvJ1lMY8pc=;
 b=Pf7E7FZn2JfcDosl1+6xhlzVOHZjTIMcotJVMtAyqLSdGCF2r1se7Ip8rxSFiDHFxDrglT
 tVdctKMDRLK8Ut5SohELb3MbHJDQ5aweJWHhPEmfZ6l5345kE/O/IjtMOsXaetCzaASTVZ
 0ojo8Nomoj83rNMMyKNyqcFwYf1V0ME=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-VS_xJF-BOriheIFuWFjYLQ-1; Mon, 25 Sep 2023 22:57:41 -0400
X-MC-Unique: VS_xJF-BOriheIFuWFjYLQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c129cb765bso111905161fa.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695697060; x=1696301860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8rCoPOuaYDCIDe0rlK/tHfmdP2Iqj9+uLvJ1lMY8pc=;
 b=omo1ndDOcp8vS0re0OyoSkso3zjMLtrbKpg5MWP0ME4dVeItD7enaOYCzGUF/rfJwL
 Rz1sUhO2fuDaiM0KZfE/YH8y+qmt/iWY2u5+6P38f53Jyo0KNr68NJBnKnxqAvQ+WwTw
 HQ631D1xabS5lRHXoeZP3ZErigXGm8ZxnFXPhribAqiWvuy8avAiew+4QGSR+FsCtKLR
 GB6i4Mp3BTYSKT5RBGWSUKSUIbrb6yPtPv3+gRB4QjQFzeQ/VSK5VToREWzk/yAt3KSy
 EZYGdQnZcbQHHYNcxigtHKm121k3+NuPnOHIRN5o3vO89jx1YwQHrmb5QgzAQP+9ECRV
 wX7w==
X-Gm-Message-State: AOJu0YyAarsMBfys0AJJnk6rtZfM1UXzPfmKzODGYpmg5NnhJNNNmTFE
 cgIfUs2Ukg4hPOxJ+5nFoZNYKUpd8mqWLtFkIFt03EQk3Zk/v1OEU95NkgSQ/1dKruF702ZKG10
 eVmGEc2aJVF4JlHRkRfa14iYj/RNzZiBqoSIfv3dviIpOzFzmDleAIuRm2A==
X-Received: by 2002:ac2:48ac:0:b0:503:a76:4eeb with SMTP id
 u12-20020ac248ac000000b005030a764eebmr5830374lfg.16.1695697060328; 
 Mon, 25 Sep 2023 19:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3RwYqaYdD2D197Rxxx50AyfpQufQFfgo1/JwgJGy62/rNkyDXHkQuYdQhZ6f74/Yi67MydQBhjJAzFfg+eVI=
X-Received: by 2002:ac2:48ac:0:b0:503:a76:4eeb with SMTP id
 u12-20020ac248ac000000b005030a764eebmr5830366lfg.16.1695697060053; Mon, 25
 Sep 2023 19:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230925103057.104541-1-sgarzare@redhat.com>
In-Reply-To: <20230925103057.104541-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 10:57:29 +0800
Message-ID: <CACGkMEvWKCoB+u2GO2mRroZDmmxcvd8+ytUjpu6wNcBOAu5RYQ@mail.gmail.com>
Subject: Re: [PATCH] vringh: don't use vringh_kiov_advance() in
 vringh_iov_xfer()
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgNjozMeKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dh
cnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBJbiB0aGUgd2hpbGUgbG9vcCBvZiB2cmluZ2hf
aW92X3hmZXIoKSwgYHBhcnRsZW5gIGNvdWxkIGJlIDAgaWYgb25lIG9mCj4gdGhlIGBpb3ZgIGhh
cyAwIGxlbmdodC4KPiBJbiB0aGlzIGNhc2UsIHdlIHNob3VsZCBza2lwIHRoZSBpb3YgYW5kIGdv
IHRvIHRoZSBuZXh0IG9uZS4KPiBCdXQgY2FsbGluZyB2cmluZ2hfa2lvdl9hZHZhbmNlKCkgd2l0
aCAwIGxlbmdodCBkb2VzIG5vdCBjYXVzZSB0aGUKPiBhZHZhbmNlbWVudCwgc2luY2UgaXQgcmV0
dXJucyBpbW1lZGlhdGVseSBpZiBhc2tlZCB0byBhZHZhbmNlIGJ5IDAgYnl0ZXMuCj4KPiBMZXQn
cyByZXN0b3JlIHRoZSBjb2RlIHRoYXQgd2FzIHRoZXJlIGJlZm9yZSBjb21taXQgYjhjMDZhZDRk
NjdkCj4gKCJ2cmluZ2g6IGltcGxlbWVudCB2cmluZ2hfa2lvdl9hZHZhbmNlKCkiKSwgYXZvaWRp
bmcgdXNpbmcKPiB2cmluZ2hfa2lvdl9hZHZhbmNlKCkuCj4KPiBGaXhlczogYjhjMDZhZDRkNjdk
ICgidnJpbmdoOiBpbXBsZW1lbnQgdnJpbmdoX2tpb3ZfYWR2YW5jZSgpIikKPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZwo+IFJlcG9ydGVkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVk
aGF0LmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhh
bmtzCgo+IC0tLQo+ICBkcml2ZXJzL3Zob3N0L3ZyaW5naC5jIHwgMTIgKysrKysrKysrKystCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aG9zdC92cmluZ2guYyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMK
PiBpbmRleCA5NTVkOTM4ZWI2NjMuLjdiOGZkOTc3ZjcxYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3Zob3N0L3ZyaW5naC5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+IEBAIC0xMjMs
OCArMTIzLDE4IEBAIHN0YXRpYyBpbmxpbmUgc3NpemVfdCB2cmluZ2hfaW92X3hmZXIoc3RydWN0
IHZyaW5naCAqdnJoLAo+ICAgICAgICAgICAgICAgICBkb25lICs9IHBhcnRsZW47Cj4gICAgICAg
ICAgICAgICAgIGxlbiAtPSBwYXJ0bGVuOwo+ICAgICAgICAgICAgICAgICBwdHIgKz0gcGFydGxl
bjsKPiArICAgICAgICAgICAgICAgaW92LT5jb25zdW1lZCArPSBwYXJ0bGVuOwo+ICsgICAgICAg
ICAgICAgICBpb3YtPmlvdltpb3YtPmldLmlvdl9sZW4gLT0gcGFydGxlbjsKPiArICAgICAgICAg
ICAgICAgaW92LT5pb3ZbaW92LT5pXS5pb3ZfYmFzZSArPSBwYXJ0bGVuOwo+Cj4gLSAgICAgICAg
ICAgICAgIHZyaW5naF9raW92X2FkdmFuY2UoaW92LCBwYXJ0bGVuKTsKPiArICAgICAgICAgICAg
ICAgaWYgKCFpb3YtPmlvdltpb3YtPmldLmlvdl9sZW4pIHsKPiArICAgICAgICAgICAgICAgICAg
ICAgICAvKiBGaXggdXAgb2xkIGlvdiBlbGVtZW50IHRoZW4gaW5jcmVtZW50LiAqLwo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGlvdi0+aW92W2lvdi0+aV0uaW92X2xlbiA9IGlvdi0+Y29uc3Vt
ZWQ7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgaW92LT5pb3ZbaW92LT5pXS5pb3ZfYmFzZSAt
PSBpb3YtPmNvbnN1bWVkOwo+ICsKPiArICAgICAgICAgICAgICAgICAgICAgICBpb3YtPmNvbnN1
bWVkID0gMDsKPiArICAgICAgICAgICAgICAgICAgICAgICBpb3YtPmkrKzsKPiArICAgICAgICAg
ICAgICAgfQo+ICAgICAgICAgfQo+ICAgICAgICAgcmV0dXJuIGRvbmU7Cj4gIH0KPiAtLQo+IDIu
NDEuMAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
