Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B23C77B61
	for <virtualization@archiver.kernel.org>; Fri,  7 Apr 2023 18:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0728405F2;
	Fri,  7 Apr 2023 18:21:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0728405F2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=o3WtKycK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s9-Mm7-Mgqtp; Fri,  7 Apr 2023 18:21:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 312A34011F;
	Fri,  7 Apr 2023 18:21:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 312A34011F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 088C9C0037;
	Fri,  7 Apr 2023 18:21:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88ADEC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 18:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 635CF6113E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 18:21:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 635CF6113E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=o3WtKycK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vel7t06e9a9a
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 18:21:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAD6E60FC0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAD6E60FC0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 18:21:43 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 d22-20020a17090a111600b0023d1b009f52so2015972pja.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Apr 2023 11:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1680891703; x=1683483703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZdRaKow9MiJw77AIs6HNE5L6Bt+Axun0Z6165dll/w=;
 b=o3WtKycKtV542XSaicFZz0CZ/dev938aAn+qeeNOY8WRyHVIze4YnJcFgiiCsWaJxV
 Ajd71OA0ng3Iisqa/ZJw1jna4z9PJi5fh7kAxvyGHi1kAoeLTxecd7HJsNnkjtM/ct+x
 emcM3MoywW3r3eCx1wcYy4wWI2bv+DS9v1sL47O7H1elmMk597W7oAgHNauc5/iOBFpH
 6Wnov6/4+cfjUr6gNj+wyBLCt4+2Xk9D7yEQQESblpkSTIwBCJElhNz6OS5Rj33wpnKO
 cnOUzmdDfEz++ahqDKTY62TN4cPZL+eaoeUJJFSxTblMU2G2LmxcljBt5McsPw1BoSWu
 m72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680891703; x=1683483703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ZdRaKow9MiJw77AIs6HNE5L6Bt+Axun0Z6165dll/w=;
 b=MfDrsT8s2boI8BuxUV13X0NahY7lIocE6VgTmlZVIuJJeNo1VgQNOMVzVfZK8n/xxt
 +2IAbyxRLGbdise9DpoU6A844iegC4cuHEE7sS0DymPPykRlYnHTrNQWnB0fO7Y7n0nU
 e4vp8K14mkRumJahuagIcOVS+6ONRCn/LMRU7XOUjB7yhVl5izzNNyAPI/bKPUbn5/4s
 p4/c7OenONhAVuJhbFwWfts7OZmOOfPY9UorgijnBm0Ut5REId8zxP27ADku1mj6xUGl
 VwlnQ1CpG6SpDI0beg0MZW01EzoAhtu67ZcUzhdsMsNUMtPtIc4/422fJjrtvsm3nMtW
 3S1w==
X-Gm-Message-State: AAQBX9er1XpmnDCknRq5qgUW06Rkg0hq3uoDFud1NW7K/iDes1NyKwpM
 6IURGse0EWdEnMiqSUsqUSatQlHAJ6rnPAm1niFejw==
X-Google-Smtp-Source: AKy350bi6/Eqyz2r683FnPvRwH6NTPyo8wV2nEG2rf8+C/NqkAczhLhuqlNMO7AwVBgrZzZVxiS/kkIt6VR0vqaeXZs=
X-Received: by 2002:a17:902:da85:b0:19f:2aa4:b1e5 with SMTP id
 j5-20020a170902da8500b0019f2aa4b1e5mr1212280plx.2.1680891702918; Fri, 07 Apr
 2023 11:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230331172423.1860083-1-trix@redhat.com>
In-Reply-To: <20230331172423.1860083-1-trix@redhat.com>
Date: Fri, 7 Apr 2023 11:21:31 -0700
Message-ID: <CAKwvOdkoYTVYeN9G-YB5ADq1Lt35d265pJHCOcy-Ro-22PFM4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: remove unused num_relocs variable
To: Tom Rix <trix@redhat.com>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 nathan@kernel.org, daniel@ffwll.ch, spice-devel@lists.freedesktop.org,
 airlied@redhat.com, airlied@gmail.com, fziglio@redhat.com
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

T24gRnJpLCBNYXIgMzEsIDIwMjMgYXQgMTA6MjTigK9BTSBUb20gUml4IDx0cml4QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gY2xhbmcgd2l0aCBXPTEgcmVwb3J0cwo+IGRyaXZlcnMvZ3B1L2RybS9x
eGwvcXhsX2lvY3RsLmM6MTQ5OjE0OiBlcnJvcjogdmFyaWFibGUKPiAgICdudW1fcmVsb2NzJyBz
ZXQgYnV0IG5vdCB1c2VkIFstV2Vycm9yLC1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCj4gICAg
ICAgICBpbnQgaSwgcmV0LCBudW1fcmVsb2NzOwo+ICAgICAgICAgICAgICAgICAgICAgXgo+IFRo
aXMgdmFyaWFibGUgaXMgbm90IHVzZWQgc28gcmVtb3ZlIGl0Lgo+Cj4gU2lnbmVkLW9mZi1ieTog
VG9tIFJpeCA8dHJpeEByZWRoYXQuY29tPgoKVGhhbmtzIGZvciB0aGUgcGF0Y2ghCkZpeGVzOiA3
NGQ5YTYzMzVkY2UgKCJkcm0vcXhsOiBTaW1wbGlmeSBjbGVhbmluZyBxeGwgcHJvY2Vzc2luZyBj
b21tYW5kIikKUmV2aWV3ZWQtYnk6IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29n
bGUuY29tPgoKVGhhdCBjb21taXQgc2hvdWxkIGFsc28gaGF2ZSByZW1vdmVkIHRoZSBsYWJlbCBv
dXRfZnJlZV9ib3MgSU1PIHNpbmNlCmhhdmluZyB0d28gbGFiZWxzIGZvciB0aGUgc2FtZSBzdGF0
ZW1lbnQgaXMgYSBjb2RlIHNtZWxsLiAgVG9tLCBkbyB5b3UKbWluZCBzZW5kaW5nIGEgdjIgd2l0
aCB0aGF0IGZvbGRlZCBpbj8KCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2lvY3Rs
LmMgfCA0ICstLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2lvY3RsLmMgYi9k
cml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9pb2N0bC5jCj4gaW5kZXggMzBmNThiMjEzNzJhLi4zNDIy
MjA2ZDU5ZDQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfaW9jdGwuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2lvY3RsLmMKPiBAQCAtMTQ2LDcgKzE0Niw3
IEBAIHN0YXRpYyBpbnQgcXhsX3Byb2Nlc3Nfc2luZ2xlX2NvbW1hbmQoc3RydWN0IHF4bF9kZXZp
Y2UgKnFkZXYsCj4gICAgICAgICBzdHJ1Y3QgcXhsX3JlbGVhc2UgKnJlbGVhc2U7Cj4gICAgICAg
ICBzdHJ1Y3QgcXhsX2JvICpjbWRfYm87Cj4gICAgICAgICB2b2lkICpmYl9jbWQ7Cj4gLSAgICAg
ICBpbnQgaSwgcmV0LCBudW1fcmVsb2NzOwo+ICsgICAgICAgaW50IGksIHJldDsKPiAgICAgICAg
IGludCB1bndyaXR0ZW47Cj4KPiAgICAgICAgIHN3aXRjaCAoY21kLT50eXBlKSB7Cj4gQEAgLTIw
MSw3ICsyMDEsNiBAQCBzdGF0aWMgaW50IHF4bF9wcm9jZXNzX3NpbmdsZV9jb21tYW5kKHN0cnVj
dCBxeGxfZGV2aWNlICpxZGV2LAo+ICAgICAgICAgfQo+Cj4gICAgICAgICAvKiBmaWxsIG91dCBy
ZWxvYyBpbmZvIHN0cnVjdHMgKi8KPiAtICAgICAgIG51bV9yZWxvY3MgPSAwOwo+ICAgICAgICAg
Zm9yIChpID0gMDsgaSA8IGNtZC0+cmVsb2NzX251bTsgKytpKSB7Cj4gICAgICAgICAgICAgICAg
IHN0cnVjdCBkcm1fcXhsX3JlbG9jIHJlbG9jOwo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZHJt
X3F4bF9yZWxvYyBfX3VzZXIgKnUgPSB1NjRfdG9fdXNlcl9wdHIoY21kLT5yZWxvY3MpOwo+IEBA
IC0yMzEsNyArMjMwLDYgQEAgc3RhdGljIGludCBxeGxfcHJvY2Vzc19zaW5nbGVfY29tbWFuZChz
dHJ1Y3QgcXhsX2RldmljZSAqcWRldiwKPiAgICAgICAgICAgICAgICAgICAgICAgICByZWxvY19p
bmZvW2ldLmRzdF9ibyA9IGNtZF9ibzsKPiAgICAgICAgICAgICAgICAgICAgICAgICByZWxvY19p
bmZvW2ldLmRzdF9vZmZzZXQgPSByZWxvYy5kc3Rfb2Zmc2V0ICsgcmVsZWFzZS0+cmVsZWFzZV9v
ZmZzZXQ7Cj4gICAgICAgICAgICAgICAgIH0KPiAtICAgICAgICAgICAgICAgbnVtX3JlbG9jcysr
Owo+Cj4gICAgICAgICAgICAgICAgIC8qIHJlc2VydmUgYW5kIHZhbGlkYXRlIHRoZSByZWxvYyBk
c3QgYm8gKi8KPiAgICAgICAgICAgICAgICAgaWYgKHJlbG9jLnJlbG9jX3R5cGUgPT0gUVhMX1JF
TE9DX1RZUEVfQk8gfHwgcmVsb2Muc3JjX2hhbmRsZSkgewo+IC0tCj4gMi4yNy4wCj4KCgotLSAK
VGhhbmtzLAp+TmljayBEZXNhdWxuaWVycwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
