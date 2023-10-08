Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579FBE95A82
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 18:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 831954188E;
	Sun,  8 Oct 2023 18:37:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 831954188E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=T5nGe/WU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e1GJojBDPR8L; Sun,  8 Oct 2023 18:37:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 97E0F41825;
	Sun,  8 Oct 2023 18:37:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 97E0F41825
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F4DEC0039;
	Sun,  8 Oct 2023 18:37:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0D16C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 18:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6968820C3
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 18:37:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6968820C3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=T5nGe/WU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FqdBUz-uyO-A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 18:37:34 +0000 (UTC)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EBD3D82088
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 18:37:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBD3D82088
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-493542a25dfso1262192e0c.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Oct 2023 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696790253; x=1697395053;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeJ1AX0Emm0B1MNXW9ufDQ+zSWl6WDvAagaRLQUTatk=;
 b=T5nGe/WU4u0sI0D41eIYZ823GlMMmwK5uFKXggP+IC/h8kjljoxIXSZzDCuFoHqFqi
 taY4s8mHHOJuwUovPcAm5PRtgRQJhfP9sofbsk3NqACj1WSfiR7lJhfeF/30I3jd+L7q
 QUgkrHownv69bHM3sPeYmD8t2JlvB8ULFmhweXGRIvYZ0vnBoz+cgXdjLbvkSArPFuvq
 dC2oiEqYi8qRVKk82rLyFPsEAq3iA0dRFxAzFV/NYoANROBbJ7lA+Qwc9cdVT1XrMAm5
 5gNh+nb8JK0flNtBebp8+nN955luyQ+PekBf2HQAD5dnJziJmnZCRRfcqGxu4hOVzgVa
 Bulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696790253; x=1697395053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeJ1AX0Emm0B1MNXW9ufDQ+zSWl6WDvAagaRLQUTatk=;
 b=e6NzkvZs1/FLeYKIZL4iP0pGVXJ5vhd8AvfQRZJS2BrARWbOeZl8GP/VUz4xo8KNJG
 KXVUZ2t8vWemM3Uh/hPec4FytlzrrA7NaJl9VYtjIods3xvWMsvopUelGIHe7/Xcb0fj
 BZT6zZCT7LHGekP3QUlw1BYm76XnPUwiJGWs0iOkrtKepSYLpBgDdRTLyUcFthDbsSDc
 +rbNF7MBHmNhyQR9zu1EthmlCZ+eg6RR8AarRjEshjtyPlDxliha4SDtIBa8pjBdtAaQ
 XOnBOfGopy6/iz7Kl0aYD/MpYl+6bp/0tO90dJM4bKLzdYwVGKqe04PgmxtB7KXQqf7C
 dqXw==
X-Gm-Message-State: AOJu0YwOk2QXJ1FfbVJDU6CG/gMNvcLmRV1ydUqeW2CtcVBf7XDTcic6
 Z3Mc8AQhy2mD2fB5neojayEQqq4ZQvuQAoDT9Zs=
X-Google-Smtp-Source: AGHT+IHSB43dF0pLQwl5fSHzzvgSOaQuNELTv/vnarvg9JxIB3dWUKmxutdHnh4vUjKSphH5Pexh5TnlfPVFyCr7FY4=
X-Received: by 2002:a1f:e641:0:b0:48f:8891:29d9 with SMTP id
 d62-20020a1fe641000000b0048f889129d9mr10186430vkh.13.1696790252736; Sun, 08
 Oct 2023 11:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
In-Reply-To: <20231008052101.144422-1-akihiko.odaki@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 8 Oct 2023 20:36:56 +0200
Message-ID: <CAF=yD-LnqYQ2qdiV+oygfHq5ZQb7QaSZ81XikzKjY8unfCTGRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] tun: Introduce virtio-net hashing feature
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

T24gU3VuLCBPY3QgOCwgMjAyMyBhdCA3OjIx4oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5v
ZGFraUBkYXluaXguY29tPiB3cm90ZToKPgo+IHZpcnRpby1uZXQgaGF2ZSB0d28gdXNhZ2Ugb2Yg
aGFzaGVzOiBvbmUgaXMgUlNTIGFuZCBhbm90aGVyIGlzIGhhc2gKPiByZXBvcnRpbmcuIENvbnZl
bnRpb25hbGx5IHRoZSBoYXNoIGNhbGN1bGF0aW9uIHdhcyBkb25lIGJ5IHRoZSBWTU0uCj4gSG93
ZXZlciwgY29tcHV0aW5nIHRoZSBoYXNoIGFmdGVyIHRoZSBxdWV1ZSB3YXMgY2hvc2VuIGRlZmVh
dHMgdGhlCj4gcHVycG9zZSBvZiBSU1MuCj4KPiBBbm90aGVyIGFwcHJvYWNoIGlzIHRvIHVzZSBl
QlBGIHN0ZWVyaW5nIHByb2dyYW0uIFRoaXMgYXBwcm9hY2ggaGFzCj4gYW5vdGhlciBkb3duc2lk
ZTogaXQgY2Fubm90IHJlcG9ydCB0aGUgY2FsY3VsYXRlZCBoYXNoIGR1ZSB0byB0aGUKPiByZXN0
cmljdGl2ZSBuYXR1cmUgb2YgZUJQRi4KPgo+IEludHJvZHVjZSB0aGUgY29kZSB0byBjb21wdXRl
IGhhc2hlcyB0byB0aGUga2VybmVsIGluIG9yZGVyIHRvIG92ZXJjb21lCj4gdGhzZSBjaGFsbGVu
Z2VzLgo+Cj4gQW4gYWx0ZXJuYXRpdmUgc29sdXRpb24gaXMgdG8gZXh0ZW5kIHRoZSBlQlBGIHN0
ZWVyaW5nIHByb2dyYW0gc28gdGhhdCBpdAo+IHdpbGwgYmUgYWJsZSB0byByZXBvcnQgdG8gdGhl
IHVzZXJzcGFjZSwgYnV0IGl0IG1ha2VzIGxpdHRsZSBzZW5zZSB0bwo+IGFsbG93IHRvIGltcGxl
bWVudCBkaWZmZXJlbnQgaGFzaGluZyBhbGdvcml0aG1zIHdpdGggZUJQRiBzaW5jZSB0aGUgaGFz
aAo+IHZhbHVlIHJlcG9ydGVkIGJ5IHZpcnRpby1uZXQgaXMgc3RyaWN0bHkgZGVmaW5lZCBieSB0
aGUgc3BlY2lmaWNhdGlvbi4KCkJ1dCB1c2luZyB0aGUgZXhpc3RpbmcgQlBGIHN0ZWVyaW5nIG1h
eSBoYXZlIHRoZSBiZW5lZml0IG9mIHJlcXVpcmluZwphIGxvdCBsZXNzIG5ldyBjb2RlLgoKVGhl
cmUgaXMgYW1wbGUgcHJlY2VkZW5jZSBmb3IgQlBGIHByb2dyYW1zIHRoYXQgd29yayB0aGlzIHdh
eS4gVGhlCmZsb3cgZGlzc2VjdG9yIGNvbWVzIHRvIG1pbmQuCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
