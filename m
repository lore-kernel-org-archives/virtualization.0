Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C15C6FD18
	for <virtualization@archiver.kernel.org>; Tue, 18 Apr 2023 20:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BF9741E15;
	Tue, 18 Apr 2023 20:09:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BF9741E15
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=RxI8ccMn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RQuK5L_-kllI; Tue, 18 Apr 2023 20:09:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F5B541E30;
	Tue, 18 Apr 2023 20:09:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F5B541E30
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29E1CC0037;
	Tue, 18 Apr 2023 20:09:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E593EC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 20:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B764441E30
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 20:09:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B764441E30
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C3RtC7YWmShM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 20:09:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E47DB41E15
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E47DB41E15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 20:09:51 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2478485fd76so985621a91.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1681848591; x=1684440591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJjRijV5blbjzZLZll3N1JO9eikZc6Mlip365pggL9w=;
 b=RxI8ccMnJU34C26Ht6af/Th3w247gQIO0uQnzRfH2qt11y5bG/KVu1JIv98zlpx4D1
 6+T+7fm9LFj2LYaDIo2LT8T1Xo9ePq7ThXSPvAlSvNHct8dmTKu+ixGW2MxKCmKPEic5
 0NMP5HW32YUXzNX6ZAvMzUZ+r7/o+fZqhWAmOZNWEtuGQr2uKAwqdsnDPOcnCQXkusAL
 lEJpFgOxxgNb/wSBQGjXS2rZ5x92nLQ4+hV53yJlZyN8pSO9LtwYDE3KxhzcV0myrIXX
 ZNsRtuRyCHtRAnfOYgVIMLVSDSYy3KfNTnfDpnhlSRuUbePgyG4vh2nQsd84Uc0WGgIG
 AqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681848591; x=1684440591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJjRijV5blbjzZLZll3N1JO9eikZc6Mlip365pggL9w=;
 b=L8kw2gxXyOHIKEre+boOz188NjgHgKy03RGszB6iDes0nThHAr3DoQIHSJ2t0Y7acX
 pn+z1Lt26WbsGNFl8HQnZHr7WM/BmoHofhVyM0zM6M+9yWbwBbpY4w0qPgd0BgFkkHEp
 g1UKK30UUiHr/p4plci44DhXuhx5HbOVREpQGmFGkvROd4QcdqhD8WAD2AnKP4qY8zX6
 eDgMSpiGtAROBCx2fkLTvgkynHk7AnVtvWwd6Q25BPSYmgj7dbGYGSv1qmoI/Pbxu0sQ
 F5qQ6UuQ2gIcw2+NQ9iXRS9QstFNAuXPAUcq9O319tKUokvTdzOeynoqAUahX8UCjU9l
 6Drw==
X-Gm-Message-State: AAQBX9cf0h/BSc57D5FCvCKaX4VGvQs2gMtqfB94S2O4eDh3HWdeQpX/
 QvwPY48LxUt4XFUlcgv9K+eEg+iv/Hgw0SfWZjRACQ==
X-Google-Smtp-Source: AKy350baeGq9wa+UpgsWuLoH1elNcvdt1oOkfqqmaCQpAHbi6Eath+2E2j22ABbywJdPOlHgLe3u3xkeQP5kmoW7nv0=
X-Received: by 2002:a17:90a:fe8c:b0:246:f73c:3aba with SMTP id
 co12-20020a17090afe8c00b00246f73c3abamr618143pjb.39.1681848590753; Tue, 18
 Apr 2023 13:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230408165023.2706235-1-trix@redhat.com>
In-Reply-To: <20230408165023.2706235-1-trix@redhat.com>
Date: Tue, 18 Apr 2023 13:09:39 -0700
Message-ID: <CAKwvOdmFtc0shP45t7S9aoh1+UGXyaX_aodvJd97d-nH5J0HQg@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: remove variable count
To: Tom Rix <trix@redhat.com>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 nathan@kernel.org, daniel@ffwll.ch, spice-devel@lists.freedesktop.org,
 airlied@redhat.com, airlied@gmail.com
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
From: Nick Desaulniers via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gU2F0LCBBcHIgOCwgMjAyMyBhdCA5OjUw4oCvQU0gVG9tIFJpeCA8dHJpeEByZWRoYXQuY29t
PiB3cm90ZToKPgo+IGNsYW5nIHdpdGggVz0xIHJlcG9ydHMKPiBkcml2ZXJzL2dwdS9kcm0vcXhs
L3F4bF9jbWQuYzo0MjQ6NjogZXJyb3I6IHZhcmlhYmxlCj4gICAnY291bnQnIHNldCBidXQgbm90
IHVzZWQgWy1XZXJyb3IsLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KPiAgICAgICAgIGludCBj
b3VudCA9IDA7Cj4gICAgICAgICAgICAgXgo+IFRoaXMgdmFyaWFibGUgaXMgbm90IHVzZWQgc28g
cmVtb3ZlIGl0LgoKVGhhbmtzIGZvciB0aGUgcGF0Y2ghCgpGaXhlczogNjQxMjJjMWY2YWQgKCJk
cm06IGFkZCBuZXcgUVhMIGRyaXZlci4gKHYxLjQpIikKUmV2aWV3ZWQtYnk6IE5pY2sgRGVzYXVs
bmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPgoKPgo+IFNpZ25lZC1vZmYtYnk6IFRvbSBS
aXggPHRyaXhAcmVkaGF0LmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfY21k
LmMgfCAyIC0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2NtZC5jIGIvZHJpdmVycy9ncHUvZHJtL3F4bC9x
eGxfY21kLmMKPiBpbmRleCAyODFlZGFiNTE4Y2QuLmQ2ZWEwMWYzNzk3YiAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9jbWQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9x
eGwvcXhsX2NtZC5jCj4gQEAgLTQyMSw3ICs0MjEsNiBAQCBpbnQgcXhsX3N1cmZhY2VfaWRfYWxs
b2Moc3RydWN0IHF4bF9kZXZpY2UgKnFkZXYsCj4gIHsKPiAgICAgICAgIHVpbnQzMl90IGhhbmRs
ZTsKPiAgICAgICAgIGludCBpZHJfcmV0Owo+IC0gICAgICAgaW50IGNvdW50ID0gMDsKPiAgYWdh
aW46Cj4gICAgICAgICBpZHJfcHJlbG9hZChHRlBfQVRPTUlDKTsKPiAgICAgICAgIHNwaW5fbG9j
aygmcWRldi0+c3VyZl9pZF9pZHJfbG9jayk7Cj4gQEAgLTQzMyw3ICs0MzIsNiBAQCBpbnQgcXhs
X3N1cmZhY2VfaWRfYWxsb2Moc3RydWN0IHF4bF9kZXZpY2UgKnFkZXYsCj4gICAgICAgICBoYW5k
bGUgPSBpZHJfcmV0Owo+Cj4gICAgICAgICBpZiAoaGFuZGxlID49IHFkZXYtPnJvbS0+bl9zdXJm
YWNlcykgewo+IC0gICAgICAgICAgICAgICBjb3VudCsrOwo+ICAgICAgICAgICAgICAgICBzcGlu
X2xvY2soJnFkZXYtPnN1cmZfaWRfaWRyX2xvY2spOwo+ICAgICAgICAgICAgICAgICBpZHJfcmVt
b3ZlKCZxZGV2LT5zdXJmX2lkX2lkciwgaGFuZGxlKTsKPiAgICAgICAgICAgICAgICAgc3Bpbl91
bmxvY2soJnFkZXYtPnN1cmZfaWRfaWRyX2xvY2spOwo+IC0tCj4gMi4yNy4wCj4KCgotLSAKVGhh
bmtzLAp+TmljayBEZXNhdWxuaWVycwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
