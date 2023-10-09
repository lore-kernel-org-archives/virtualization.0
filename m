Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0FBE95A91
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 09:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 732F060EC1;
	Mon,  9 Oct 2023 09:55:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 732F060EC1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kpaM/b+e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YDg7yPX-N21v; Mon,  9 Oct 2023 09:55:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 311BD60BB7;
	Mon,  9 Oct 2023 09:55:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 311BD60BB7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A47BC0039;
	Mon,  9 Oct 2023 09:55:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68E1FC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 09:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36C1B409A5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 09:55:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36C1B409A5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=kpaM/b+e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v5bGQ3g_Jdt7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 09:55:35 +0000 (UTC)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDCD4405F1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 09:55:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDCD4405F1
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-49352207f33so1667087e0c.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696845333; x=1697450133;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJUF31J0PbZtxav7G88aAg0axEBg2ZH8ruSnLMC/BFU=;
 b=kpaM/b+eckq5gbbLKdsLQT/ujaK21UjJdoaFh+Fs1+SegWBVKJqbRgoqgwhszMjhTE
 KAw9DeQCoTXqDR6Y73UubmxBgAGOxNEecAn0tT4YoOG0VXOJ8aAMYT2BEtWwWnjmTWKA
 UnWWf3K5TqSBHzk80O0moJcyvpjpXN+S5vlRHS0HTDqtG0wywYNIG7f+oLU8+qYb6woR
 tsZfWdnoyd2giiu/Dkxlh4wRJ2MFK4rgC3EcOtkEJueUnn2F/kQVOfv4wlva+tz+HM/7
 CKMcrjLY5yTjCMaPF5fJRHZy1c9fBrcNDYCWwz8hVlMncjGCw3euXbRTQBxGKrVF2VhT
 VKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845333; x=1697450133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJUF31J0PbZtxav7G88aAg0axEBg2ZH8ruSnLMC/BFU=;
 b=SMSK4u2H98gb0ssWnX0vxtUhYkRaXQyGIX8ytZ4tA09J88hjNN7BTp70Kda1Zl18j/
 Shqc55s0F7mwuJt34yEjvkTRIATXSy+KT9srAR+6Q0nYCbUWo7bf6Pp4gW9aIV+anyy3
 XGKFSm6bzxyg4qu51rDpLBolhh/Q9c1p3Eg+7xdI4IYgHHMzhJOhqWh71pD4P9s9EsZC
 n4ZBC7QZCQU/QpyoQ2ULXz/cNViFmQmGL/4mUouLJA/BtoBbqpaN/+u55xAGS7O2cz+f
 Lc/yJu4gmZp6cMiQEycXd//IoC9eL13GtG+A0yKOeM3M8sqPfiBBVCBG9LAJG0vO27B4
 gyhQ==
X-Gm-Message-State: AOJu0YxcnMMKpooO8q2iCZYoEBy+7PC7BeabecnlKykjB7oU3xDBl0Fm
 TeBoErJuNpnmf+oHnDS84P0wboGFI11CZpf28CI=
X-Google-Smtp-Source: AGHT+IEreKMizCCNFcpEhH5iXSdei2Vqfm7cxxdu5FLzU7oTPyhiYyKY1JIs9eh8s4CbyXRR0j34a2PGChoyRSIntTA=
X-Received: by 2002:a1f:4f86:0:b0:495:c10c:ec39 with SMTP id
 d128-20020a1f4f86000000b00495c10cec39mr10736648vkb.2.1696845333308; Mon, 09
 Oct 2023 02:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
 <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
In-Reply-To: <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 9 Oct 2023 04:54:56 -0500
Message-ID: <CAF=yD-K4bCBpUVtDR_cv=bagRL+vM4Rusez+uHFTb4_kR8XkpA@mail.gmail.com>
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

T24gTW9uLCBPY3QgOSwgMjAyMyBhdCAzOjQ04oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5v
ZGFraUBkYXluaXguY29tPiB3cm90ZToKPgo+IE9uIDIwMjMvMTAvMDkgMTc6MTMsIFdpbGxlbSBk
ZSBCcnVpam4gd3JvdGU6Cj4gPiBPbiBTdW4sIE9jdCA4LCAyMDIzIGF0IDEyOjIy4oCvQU0gQWtp
aGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPiB3cm90ZToKPiA+Pgo+ID4+IHZp
cnRpby1uZXQgaGF2ZSB0d28gdXNhZ2Ugb2YgaGFzaGVzOiBvbmUgaXMgUlNTIGFuZCBhbm90aGVy
IGlzIGhhc2gKPiA+PiByZXBvcnRpbmcuIENvbnZlbnRpb25hbGx5IHRoZSBoYXNoIGNhbGN1bGF0
aW9uIHdhcyBkb25lIGJ5IHRoZSBWTU0uCj4gPj4gSG93ZXZlciwgY29tcHV0aW5nIHRoZSBoYXNo
IGFmdGVyIHRoZSBxdWV1ZSB3YXMgY2hvc2VuIGRlZmVhdHMgdGhlCj4gPj4gcHVycG9zZSBvZiBS
U1MuCj4gPj4KPiA+PiBBbm90aGVyIGFwcHJvYWNoIGlzIHRvIHVzZSBlQlBGIHN0ZWVyaW5nIHBy
b2dyYW0uIFRoaXMgYXBwcm9hY2ggaGFzCj4gPj4gYW5vdGhlciBkb3duc2lkZTogaXQgY2Fubm90
IHJlcG9ydCB0aGUgY2FsY3VsYXRlZCBoYXNoIGR1ZSB0byB0aGUKPiA+PiByZXN0cmljdGl2ZSBu
YXR1cmUgb2YgZUJQRi4KPiA+Pgo+ID4+IEludHJvZHVjZSB0aGUgY29kZSB0byBjb21wdXRlIGhh
c2hlcyB0byB0aGUga2VybmVsIGluIG9yZGVyIHRvIG92ZXJjb21lCj4gPj4gdGhzZSBjaGFsbGVu
Z2VzLiBBbiBhbHRlcm5hdGl2ZSBzb2x1dGlvbiBpcyB0byBleHRlbmQgdGhlIGVCUEYgc3RlZXJp
bmcKPiA+PiBwcm9ncmFtIHNvIHRoYXQgaXQgd2lsbCBiZSBhYmxlIHRvIHJlcG9ydCB0byB0aGUg
dXNlcnNwYWNlLCBidXQgaXQgbWFrZXMKPiA+PiBsaXR0bGUgc2Vuc2UgdG8gYWxsb3cgdG8gaW1w
bGVtZW50IGRpZmZlcmVudCBoYXNoaW5nIGFsZ29yaXRobXMgd2l0aAo+ID4+IGVCUEYgc2luY2Ug
dGhlIGhhc2ggdmFsdWUgcmVwb3J0ZWQgYnkgdmlydGlvLW5ldCBpcyBzdHJpY3RseSBkZWZpbmVk
IGJ5Cj4gPj4gdGhlIHNwZWNpZmljYXRpb24uCj4gPj4KPiA+PiBUaGUgaGFzaCB2YWx1ZSBhbHJl
YWR5IHN0b3JlZCBpbiBza19idWZmIGlzIG5vdCB1c2VkIGFuZCBjb21wdXRlZAo+ID4+IGluZGVw
ZW5kZW50bHkgc2luY2UgaXQgbWF5IGhhdmUgYmVlbiBjb21wdXRlZCBpbiBhIHdheSBub3QgY29u
Zm9ybWFudAo+ID4+IHdpdGggdGhlIHNwZWNpZmljYXRpb24uCj4gPj4KPiA+PiBTaWduZWQtb2Zm
LWJ5OiBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+Cj4gPgo+ID4+IEBA
IC0yMTE2LDMxICsyMTcyLDQ5IEBAIHN0YXRpYyBzc2l6ZV90IHR1bl9wdXRfdXNlcihzdHJ1Y3Qg
dHVuX3N0cnVjdCAqdHVuLAo+ID4+ICAgICAgICAgIH0KPiA+Pgo+ID4+ICAgICAgICAgIGlmICh2
bmV0X2hkcl9zeikgewo+ID4+IC0gICAgICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9oZHIg
Z3NvOwo+ID4+ICsgICAgICAgICAgICAgICB1bmlvbiB7Cj4gPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHZpcnRpb19uZXRfaGRyIGhkcjsKPiA+PiArICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgdmlydGlvX25ldF9oZHJfdjFfaGFzaCB2MV9oYXNoX2hkcjsKPiA+PiArICAg
ICAgICAgICAgICAgfSBoZHI7Cj4gPj4gKyAgICAgICAgICAgICAgIGludCByZXQ7Cj4gPj4KPiA+
PiAgICAgICAgICAgICAgICAgIGlmIChpb3ZfaXRlcl9jb3VudChpdGVyKSA8IHZuZXRfaGRyX3N6
KQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+Pgo+ID4+
IC0gICAgICAgICAgICAgICBpZiAodmlydGlvX25ldF9oZHJfZnJvbV9za2Ioc2tiLCAmZ3NvLAo+
ID4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHVuX2lzX2xp
dHRsZV9lbmRpYW4odHVuKSwgdHJ1ZSwKPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHZsYW5faGxlbikpIHsKPiA+PiArICAgICAgICAgICAgICAgaWYgKChS
RUFEX09OQ0UodHVuLT52bmV0X2hhc2guZmxhZ3MpICYgVFVOX1ZORVRfSEFTSF9SRVBPUlQpICYm
Cj4gPj4gKyAgICAgICAgICAgICAgICAgICB2bmV0X2hkcl9zeiA+PSBzaXplb2YoaGRyLnYxX2hh
c2hfaGRyKSAmJgo+ID4+ICsgICAgICAgICAgICAgICAgICAgc2tiLT50dW5fdm5ldF9oYXNoKSB7
Cj4gPgo+ID4gSXNuJ3Qgdm5ldF9oZHJfc3ogZ3VhcmFudGVlZCB0byBiZSA+PSBoZHIudjFfaGFz
aF9oZHIsIGJ5IHZpcnR1ZSBvZgo+ID4gdGhlIHNldCBoYXNoIGlvY3RsIGZhaWxpbmcgb3RoZXJ3
aXNlPwo+ID4KPiA+IFN1Y2ggY2hlY2tzIHNob3VsZCBiZSBsaW1pdGVkIHRvIGNvbnRyb2wgcGF0
aCB3aGVyZSBwb3NzaWJsZQo+Cj4gVGhlcmUgaXMgYSBwb3RlbnRpYWwgcmFjZSBzaW5jZSB0dW4t
PnZuZXRfaGFzaC5mbGFncyBhbmQgdm5ldF9oZHJfc3ogYXJlCj4gbm90IHJlYWQgYXQgb25jZS4K
Ckl0IHNob3VsZCBub3QgYmUgcG9zc2libGUgdG8gZG93bmdyYWRlIHRoZSBoZHJfc3ogb25jZSB2
MSBpcyBzZWxlY3RlZC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
