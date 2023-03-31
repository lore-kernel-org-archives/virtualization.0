Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06FDC76196
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 09:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62A2442075;
	Fri, 31 Mar 2023 09:15:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62A2442075
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cKBL36li
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dTrnCkYgFKYa; Fri, 31 Mar 2023 09:15:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3188D41BFF;
	Fri, 31 Mar 2023 09:15:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3188D41BFF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18CB3C0036;
	Fri, 31 Mar 2023 09:15:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D967C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C2B4844A7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:15:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C2B4844A7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cKBL36li
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DQV7R4dYUiHt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:15:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A339384495
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A339384495
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680254150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpBwJNhntZe6FD93wLKDtIdc8Lkqkr2A8dw0SyVmm8A=;
 b=cKBL36liGchPHqomUFxLYtGIP/nybcP7cP2iF1GSC9prCPzKzHdQ2pn06QtlCWIYk6+ENh
 q8SqGYXw3ooqvR/Y2KEBCY4xb2seiWGzqOMz8zN48bHxzBiCMOLJ3+I2cyy9X1ax7p7yaz
 YNBoCvf3tLygKVsaVvU0cUtSm361114=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-f5-8vxwSPx6AQvzA0Sjhcw-1; Fri, 31 Mar 2023 05:15:49 -0400
X-MC-Unique: f5-8vxwSPx6AQvzA0Sjhcw-1
Received: by mail-oi1-f197.google.com with SMTP id
 b7-20020aca3407000000b00386d0eeb190so5173283oia.18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 02:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680254148; x=1682846148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpBwJNhntZe6FD93wLKDtIdc8Lkqkr2A8dw0SyVmm8A=;
 b=2d8DYk3nYrDnV2BxhKk+OwDpp/8WjV4UmzEe5ygRBDYB3PiaWKQ/oUiW24EV9644PE
 DbpEAG8v6KKjTi4lbMKxIAxZnTCmimMF8CNNJ989RZqflAr68ugQalT6s6LgxLzxFkiA
 eQ/foFSOcoYhpqBXODG1R6YmQBjrMGk/6PztkZC1Wm9cJzTby/StIjXLP+XCpMX/V8SN
 YswmRTZBuRJACeTL5QCBOc2wWhRN9rSdlyhrHtFNtlAA/kcqavdUNuVm2eUqxmYXtNkM
 50uTrWnBxo0RsOIMJEJ9nAuNKPpPmz7LJpZmETFjhtUtyic7quzZVAg0OB/XmLksLEhW
 FYOg==
X-Gm-Message-State: AAQBX9czvfl7fxoF0uGbs50AY+8pEVc6waL0eJIqkbLOFqO3hJoh+ii4
 VhmzSHjpgx7jH6C2OWbFqubQmv7LvF7+QlUVOuxeex/4AGxltA6310ahhq6Hycg41b3eaQLIvGo
 XCwT2l+czo9zY9QeenvDJl5gF54rwDac2h85e865f1MUhPUeERhXS3zwZNQ==
X-Received: by 2002:a05:6830:119:b0:69f:15f4:aa8 with SMTP id
 i25-20020a056830011900b0069f15f40aa8mr2912056otp.0.1680254148655; 
 Fri, 31 Mar 2023 02:15:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350au0t5wmkRH4+94dmbo4lZGEFFNChh74aKhB9ea6YK9dFKBXZt8OcEd3YmdzM4pRCxTfdprrA7hujgUD9BK6aI=
X-Received: by 2002:a05:6830:119:b0:69f:15f4:aa8 with SMTP id
 i25-20020a056830011900b0069f15f40aa8mr2912054otp.0.1680254148451; Fri, 31 Mar
 2023 02:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230331080208.17002-1-sgarzare@redhat.com>
In-Reply-To: <20230331080208.17002-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 31 Mar 2023 17:15:37 +0800
Message-ID: <CACGkMEvjLWY39jb4LR_nMaB9cBoPYOKmtpuuN8XwB6pA+zBL7w@mail.gmail.com>
Subject: Re: [PATCH] vringh: fix typos in the vringh_init_* documentation
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Simon Horman <simon.horman@corigine.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
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

T24gRnJpLCBNYXIgMzEsIDIwMjMgYXQgNDowMuKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dh
cnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBSZXBsYWNlIGB1c2VycGFjZWAgd2l0aCBgdXNl
cnNwYWNlYC4KPgo+IENjOiBTaW1vbiBIb3JtYW4gPHNpbW9uLmhvcm1hbkBjb3JpZ2luZS5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29t
PgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4g
LS0tCj4gIGRyaXZlcnMvdmhvc3QvdnJpbmdoLmMgfCAxOCArKysrKysrKystLS0tLS0tLS0KPiAg
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+
IGluZGV4IGExZTI3ZGE1NDQ4MS4uNjk0NDYyYmEzMjQyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmhvc3QvdnJpbmdoLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gQEAgLTYzNiw5
ICs2MzYsOSBAQCBzdGF0aWMgaW5saW5lIGludCB4ZmVyX3RvX3VzZXIoY29uc3Qgc3RydWN0IHZy
aW5naCAqdnJoLAo+ICAgKiBAZmVhdHVyZXM6IHRoZSBmZWF0dXJlIGJpdHMgZm9yIHRoaXMgcmlu
Zy4KPiAgICogQG51bTogdGhlIG51bWJlciBvZiBlbGVtZW50cy4KPiAgICogQHdlYWtfYmFycmll
cnM6IHRydWUgaWYgd2Ugb25seSBuZWVkIG1lbW9yeSBiYXJyaWVycywgbm90IEkvTy4KPiAtICog
QGRlc2M6IHRoZSB1c2VycGFjZSBkZXNjcmlwdG9yIHBvaW50ZXIuCj4gLSAqIEBhdmFpbDogdGhl
IHVzZXJwYWNlIGF2YWlsIHBvaW50ZXIuCj4gLSAqIEB1c2VkOiB0aGUgdXNlcnBhY2UgdXNlZCBw
b2ludGVyLgo+ICsgKiBAZGVzYzogdGhlIHVzZXJzcGFjZSBkZXNjcmlwdG9yIHBvaW50ZXIuCj4g
KyAqIEBhdmFpbDogdGhlIHVzZXJzcGFjZSBhdmFpbCBwb2ludGVyLgo+ICsgKiBAdXNlZDogdGhl
IHVzZXJzcGFjZSB1c2VkIHBvaW50ZXIuCj4gICAqCj4gICAqIFJldHVybnMgYW4gZXJyb3IgaWYg
bnVtIGlzIGludmFsaWQ6IHlvdSBzaG91bGQgY2hlY2sgcG9pbnRlcnMKPiAgICogeW91cnNlbGYh
Cj4gQEAgLTkxMSw5ICs5MTEsOSBAQCBzdGF0aWMgaW5saW5lIGludCBrZXJuX3hmZXIoY29uc3Qg
c3RydWN0IHZyaW5naCAqdnJoLCB2b2lkICpkc3QsCj4gICAqIEBmZWF0dXJlczogdGhlIGZlYXR1
cmUgYml0cyBmb3IgdGhpcyByaW5nLgo+ICAgKiBAbnVtOiB0aGUgbnVtYmVyIG9mIGVsZW1lbnRz
Lgo+ICAgKiBAd2Vha19iYXJyaWVyczogdHJ1ZSBpZiB3ZSBvbmx5IG5lZWQgbWVtb3J5IGJhcnJp
ZXJzLCBub3QgSS9PLgo+IC0gKiBAZGVzYzogdGhlIHVzZXJwYWNlIGRlc2NyaXB0b3IgcG9pbnRl
ci4KPiAtICogQGF2YWlsOiB0aGUgdXNlcnBhY2UgYXZhaWwgcG9pbnRlci4KPiAtICogQHVzZWQ6
IHRoZSB1c2VycGFjZSB1c2VkIHBvaW50ZXIuCj4gKyAqIEBkZXNjOiB0aGUgdXNlcnNwYWNlIGRl
c2NyaXB0b3IgcG9pbnRlci4KPiArICogQGF2YWlsOiB0aGUgdXNlcnNwYWNlIGF2YWlsIHBvaW50
ZXIuCj4gKyAqIEB1c2VkOiB0aGUgdXNlcnNwYWNlIHVzZWQgcG9pbnRlci4KPiAgICoKPiAgICog
UmV0dXJucyBhbiBlcnJvciBpZiBudW0gaXMgaW52YWxpZC4KPiAgICovCj4gQEAgLTEzMDYsOSAr
MTMwNiw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IHB1dHVzZWRfaW90bGIoY29uc3Qgc3RydWN0IHZy
aW5naCAqdnJoLAo+ICAgKiBAZmVhdHVyZXM6IHRoZSBmZWF0dXJlIGJpdHMgZm9yIHRoaXMgcmlu
Zy4KPiAgICogQG51bTogdGhlIG51bWJlciBvZiBlbGVtZW50cy4KPiAgICogQHdlYWtfYmFycmll
cnM6IHRydWUgaWYgd2Ugb25seSBuZWVkIG1lbW9yeSBiYXJyaWVycywgbm90IEkvTy4KPiAtICog
QGRlc2M6IHRoZSB1c2VycGFjZSBkZXNjcmlwdG9yIHBvaW50ZXIuCj4gLSAqIEBhdmFpbDogdGhl
IHVzZXJwYWNlIGF2YWlsIHBvaW50ZXIuCj4gLSAqIEB1c2VkOiB0aGUgdXNlcnBhY2UgdXNlZCBw
b2ludGVyLgo+ICsgKiBAZGVzYzogdGhlIHVzZXJzcGFjZSBkZXNjcmlwdG9yIHBvaW50ZXIuCj4g
KyAqIEBhdmFpbDogdGhlIHVzZXJzcGFjZSBhdmFpbCBwb2ludGVyLgo+ICsgKiBAdXNlZDogdGhl
IHVzZXJzcGFjZSB1c2VkIHBvaW50ZXIuCj4gICAqCj4gICAqIFJldHVybnMgYW4gZXJyb3IgaWYg
bnVtIGlzIGludmFsaWQuCj4gICAqLwo+IC0tCj4gMi4zOS4yCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
