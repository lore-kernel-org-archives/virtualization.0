Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB77DE95A96
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 10:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 804E182043;
	Mon,  9 Oct 2023 10:08:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 804E182043
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fBt8zLTI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qkICJ5A9Fq61; Mon,  9 Oct 2023 10:08:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D0EA682061;
	Mon,  9 Oct 2023 10:08:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0EA682061
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD642C0071;
	Mon,  9 Oct 2023 10:08:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DF03C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C48760BD5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:08:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C48760BD5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=fBt8zLTI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9h9NY39mTMgS
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:08:06 +0000 (UTC)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89D7060BB7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:08:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89D7060BB7
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7ab8696d047so1686301241.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696846085; x=1697450885;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbHOermRMrKRk+X0HGNdbhFKu1xqDfORpCgcvsbzg3U=;
 b=fBt8zLTIPjbOq/ZzfLWA/pjycrPt+G1Tb18Uaag0N9fUUoZgeLy68biOvfERRDe2iF
 1uwKL3Ns/Akp+DlXh9BoZ8IM0M649E4WoWpqiURSX2he1WTa9EWZOGbhjnNy+34X/V9V
 Pa3CJzOz06age/fEGveZ7zHv9NZgtFnPMmMrJPXAGAbdoiBzqwyVYgV3kdqAmtjX7b6N
 bBh3BTj01Y4OlgY43EK+PNRtzXmAO67dVenvWZHnBlyVX7LSW5xe00TzJFqLUU3JbMPN
 /dZEhylhcSihU6cb0isud8fPJ5CDwSF+HyUDJNMvdXV16HkTKlvRjCjpQSm6xjWEIFTy
 Th4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696846085; x=1697450885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vbHOermRMrKRk+X0HGNdbhFKu1xqDfORpCgcvsbzg3U=;
 b=QbYTPXOrdsuRQMvtgXIGOOuwd82mMz06CVuFo1hE2n54oQoZtT0l+Gcp1jG0zjLIhV
 CO+QHQhxlfKdUAw6QUFJf7PSgKje5sfD6uf/F/+ysHdUOkDq4R/jjmiS9cWqYXsYwh9X
 rzx7hKmGrfaF1iyNk8CoNdFV1rrPppanTXJmpk/uFF8obk3zv2+jIblD2Wtuoymd1Pvq
 bQ5wvY7bRx6uXKMTT304pLjq2tdaPIpRXP1lSWIyIrbttXimco1cCSMvpClRQfLIrCFm
 xIavaKE4fhkOCnPNxa0ye9WXVaU/qggVF0FPfX6URWzCLLIeIuRudyvrAP8Fu4Zj39lx
 GJJA==
X-Gm-Message-State: AOJu0Yxiv8mH5HoJv0jk3R6BLllXkWQKyuG6tLw/MZPq9mJaoJB68YH/
 mPo5GcFYONQD852CFpt+8nvYqGn9BoNLcfK1twc=
X-Google-Smtp-Source: AGHT+IG82LZdEm7dgg1DL81gRs2joX/UTWwc13ELsnkSS/9qkVDl7Yrdteu4VB0eB/VoXi+UEInbHeRPlZZV7wmkSdg=
X-Received: by 2002:a67:f6c1:0:b0:452:635e:2710 with SMTP id
 v1-20020a67f6c1000000b00452635e2710mr13995568vso.0.1696846085188; Mon, 09 Oct
 2023 03:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
 <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
 <CAF=yD-K4bCBpUVtDR_cv=bagRL+vM4Rusez+uHFTb4_kR8XkpA@mail.gmail.com>
 <6a698c99-6f02-4cfb-a709-ba02296a05f7@daynix.com>
In-Reply-To: <6a698c99-6f02-4cfb-a709-ba02296a05f7@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 9 Oct 2023 03:07:27 -0700
Message-ID: <CAF=yD-+WFy8us0wUWo-0KpZUKHx2Q82cJ8teO0qRkK-_R1e0cA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: songliubraving@fb.com, gustavoars@kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, decui@microsoft.com, ast@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, yhs@fb.com,
 pabeni@redhat.com, pablo@netfilter.org, elver@google.com, kpsingh@kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, cai@lca.pw, kuba@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, nogikh@google.com,
 bpf@vger.kernel.org, kafai@fb.com
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

T24gTW9uLCBPY3QgOSwgMjAyMyBhdCAzOjA14oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5v
ZGFraUBkYXluaXguY29tPiB3cm90ZToKPgo+Cj4KPiBPbiAyMDIzLzEwLzA5IDE4OjU0LCBXaWxs
ZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4gT24gTW9uLCBPY3QgOSwgMjAyMyBhdCAzOjQ04oCvQU0g
QWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPiB3cm90ZToKPiA+Pgo+ID4+
IE9uIDIwMjMvMTAvMDkgMTc6MTMsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gPj4+IE9uIFN1
biwgT2N0IDgsIDIwMjMgYXQgMTI6MjLigK9BTSBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9kYWtp
QGRheW5peC5jb20+IHdyb3RlOgo+ID4+Pj4KPiA+Pj4+IHZpcnRpby1uZXQgaGF2ZSB0d28gdXNh
Z2Ugb2YgaGFzaGVzOiBvbmUgaXMgUlNTIGFuZCBhbm90aGVyIGlzIGhhc2gKPiA+Pj4+IHJlcG9y
dGluZy4gQ29udmVudGlvbmFsbHkgdGhlIGhhc2ggY2FsY3VsYXRpb24gd2FzIGRvbmUgYnkgdGhl
IFZNTS4KPiA+Pj4+IEhvd2V2ZXIsIGNvbXB1dGluZyB0aGUgaGFzaCBhZnRlciB0aGUgcXVldWUg
d2FzIGNob3NlbiBkZWZlYXRzIHRoZQo+ID4+Pj4gcHVycG9zZSBvZiBSU1MuCj4gPj4+Pgo+ID4+
Pj4gQW5vdGhlciBhcHByb2FjaCBpcyB0byB1c2UgZUJQRiBzdGVlcmluZyBwcm9ncmFtLiBUaGlz
IGFwcHJvYWNoIGhhcwo+ID4+Pj4gYW5vdGhlciBkb3duc2lkZTogaXQgY2Fubm90IHJlcG9ydCB0
aGUgY2FsY3VsYXRlZCBoYXNoIGR1ZSB0byB0aGUKPiA+Pj4+IHJlc3RyaWN0aXZlIG5hdHVyZSBv
ZiBlQlBGLgo+ID4+Pj4KPiA+Pj4+IEludHJvZHVjZSB0aGUgY29kZSB0byBjb21wdXRlIGhhc2hl
cyB0byB0aGUga2VybmVsIGluIG9yZGVyIHRvIG92ZXJjb21lCj4gPj4+PiB0aHNlIGNoYWxsZW5n
ZXMuIEFuIGFsdGVybmF0aXZlIHNvbHV0aW9uIGlzIHRvIGV4dGVuZCB0aGUgZUJQRiBzdGVlcmlu
Zwo+ID4+Pj4gcHJvZ3JhbSBzbyB0aGF0IGl0IHdpbGwgYmUgYWJsZSB0byByZXBvcnQgdG8gdGhl
IHVzZXJzcGFjZSwgYnV0IGl0IG1ha2VzCj4gPj4+PiBsaXR0bGUgc2Vuc2UgdG8gYWxsb3cgdG8g
aW1wbGVtZW50IGRpZmZlcmVudCBoYXNoaW5nIGFsZ29yaXRobXMgd2l0aAo+ID4+Pj4gZUJQRiBz
aW5jZSB0aGUgaGFzaCB2YWx1ZSByZXBvcnRlZCBieSB2aXJ0aW8tbmV0IGlzIHN0cmljdGx5IGRl
ZmluZWQgYnkKPiA+Pj4+IHRoZSBzcGVjaWZpY2F0aW9uLgo+ID4+Pj4KPiA+Pj4+IFRoZSBoYXNo
IHZhbHVlIGFscmVhZHkgc3RvcmVkIGluIHNrX2J1ZmYgaXMgbm90IHVzZWQgYW5kIGNvbXB1dGVk
Cj4gPj4+PiBpbmRlcGVuZGVudGx5IHNpbmNlIGl0IG1heSBoYXZlIGJlZW4gY29tcHV0ZWQgaW4g
YSB3YXkgbm90IGNvbmZvcm1hbnQKPiA+Pj4+IHdpdGggdGhlIHNwZWNpZmljYXRpb24uCj4gPj4+
Pgo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXlu
aXguY29tPgo+ID4+Pgo+ID4+Pj4gQEAgLTIxMTYsMzEgKzIxNzIsNDkgQEAgc3RhdGljIHNzaXpl
X3QgdHVuX3B1dF91c2VyKHN0cnVjdCB0dW5fc3RydWN0ICp0dW4sCj4gPj4+PiAgICAgICAgICAg
fQo+ID4+Pj4KPiA+Pj4+ICAgICAgICAgICBpZiAodm5ldF9oZHJfc3opIHsKPiA+Pj4+IC0gICAg
ICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9oZHIgZ3NvOwo+ID4+Pj4gKyAgICAgICAgICAg
ICAgIHVuaW9uIHsKPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9f
bmV0X2hkciBoZHI7Cj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydGlv
X25ldF9oZHJfdjFfaGFzaCB2MV9oYXNoX2hkcjsKPiA+Pj4+ICsgICAgICAgICAgICAgICB9IGhk
cjsKPiA+Pj4+ICsgICAgICAgICAgICAgICBpbnQgcmV0Owo+ID4+Pj4KPiA+Pj4+ICAgICAgICAg
ICAgICAgICAgIGlmIChpb3ZfaXRlcl9jb3VudChpdGVyKSA8IHZuZXRfaGRyX3N6KQo+ID4+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+Pj4+Cj4gPj4+PiAt
ICAgICAgICAgICAgICAgaWYgKHZpcnRpb19uZXRfaGRyX2Zyb21fc2tiKHNrYiwgJmdzbywKPiA+
Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHVuX2lzX2xp
dHRsZV9lbmRpYW4odHVuKSwgdHJ1ZSwKPiA+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdmxhbl9obGVuKSkgewo+ID4+Pj4gKyAgICAgICAgICAgICAgIGlm
ICgoUkVBRF9PTkNFKHR1bi0+dm5ldF9oYXNoLmZsYWdzKSAmIFRVTl9WTkVUX0hBU0hfUkVQT1JU
KSAmJgo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICB2bmV0X2hkcl9zeiA+PSBzaXplb2YoaGRy
LnYxX2hhc2hfaGRyKSAmJgo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICBza2ItPnR1bl92bmV0
X2hhc2gpIHsKPiA+Pj4KPiA+Pj4gSXNuJ3Qgdm5ldF9oZHJfc3ogZ3VhcmFudGVlZCB0byBiZSA+
PSBoZHIudjFfaGFzaF9oZHIsIGJ5IHZpcnR1ZSBvZgo+ID4+PiB0aGUgc2V0IGhhc2ggaW9jdGwg
ZmFpbGluZyBvdGhlcndpc2U/Cj4gPj4+Cj4gPj4+IFN1Y2ggY2hlY2tzIHNob3VsZCBiZSBsaW1p
dGVkIHRvIGNvbnRyb2wgcGF0aCB3aGVyZSBwb3NzaWJsZQo+ID4+Cj4gPj4gVGhlcmUgaXMgYSBw
b3RlbnRpYWwgcmFjZSBzaW5jZSB0dW4tPnZuZXRfaGFzaC5mbGFncyBhbmQgdm5ldF9oZHJfc3og
YXJlCj4gPj4gbm90IHJlYWQgYXQgb25jZS4KPiA+Cj4gPiBJdCBzaG91bGQgbm90IGJlIHBvc3Np
YmxlIHRvIGRvd25ncmFkZSB0aGUgaGRyX3N6IG9uY2UgdjEgaXMgc2VsZWN0ZWQuCj4KPiBJIHNl
ZSBub3RoaW5nIHRoYXQgcHJldmVudHMgc2hyaW5raW5nIHRoZSBoZWFkZXIgc2l6ZS4KPgo+IHR1
bi0+dm5ldF9oYXNoLmZsYWdzIGlzIHJlYWQgYWZ0ZXIgdm5ldF9oZHJfc3ogc28gdGhlIHJhY2Ug
Y2FuIGhhcHBlbgo+IGV2ZW4gZm9yIHRoZSBjYXNlIHRoZSBoZWFkZXIgc2l6ZSBncm93cyB0aG91
Z2ggdGhpcyBjYW4gYmUgZml4ZWQgYnkKPiByZW9yZGVyaW5nIHRoZSB0d28gcmVhZHMuCgpPbmUg
b3B0aW9uIGlzIHRvIGZhaWwgYW55IGNvbnRyb2wgcGF0aCB0aGF0IHRyaWVzIHRvIHJlLW5lZ290
aWF0ZQpoZWFkZXIgc2l6ZSBvbmNlIHRoaXMgaGFzaCBvcHRpb24gaXMgZW5hYmxlZD8KClRoZXJl
IGlzIG5vIHByYWN0aWNhbCByZWFzb24gdG8gYWxsb3cgZmVhdHVyZSByZS1uZWdvdGlhdGlvbiBh
dCBhbnkKYXJiaXRyYXJ5IHRpbWUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
