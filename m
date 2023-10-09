Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B244E95A91
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 10:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7BA661132;
	Mon,  9 Oct 2023 10:06:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7BA661132
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZsE+fFKk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3DWP_jm6-ZFa; Mon,  9 Oct 2023 10:06:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA09861066;
	Mon,  9 Oct 2023 10:06:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA09861066
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDEFFC0071;
	Mon,  9 Oct 2023 10:06:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97FA7C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6495B417C4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:06:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6495B417C4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=ZsE+fFKk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OzCEDkV_kaIS
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:06:52 +0000 (UTC)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3E32417C1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:06:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E3E32417C1
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7b07719089aso2854613241.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696846010; x=1697450810;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUulTN1h38HfKtLoczTxDqQh9DCfOrCmaxardUNW3tA=;
 b=ZsE+fFKkA+LfMhpVC6Ak/9XEAg0MXHpBNEY8FxGD7t61Xtnvj6WJnHjxOBUC3HtX9F
 w1N138sLrp0QxnaEhSLFleCIIoxIqIKALezrLXtdRUES9860zYxI4XOQqQCPbK6M6q2C
 nOx4etfswuvPWS0yvdAljJepYXFRa3XSx+MDwE+Z3J/FNpoGyVsMEnpkCabrF1xrnYHI
 9ux+5vP2K5QoBRElfr2rCNmixDMQKC3A9qn+J+A/EZ4+sLUmi42p0fWhhfozk5o4Z3iu
 WkxvvUUTQ8/w6mUW7I66aFcnD6RNnRtJAFu51o9uAOo1JmiujqTmUtk2x2T9lKgNuUlc
 H3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696846010; x=1697450810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUulTN1h38HfKtLoczTxDqQh9DCfOrCmaxardUNW3tA=;
 b=FOgQMhEej6oL8bvWTQVqw90jkvdIqVzMp/nvgZ7Yr8PTzaK9RVe0oW+wnuDwVX4u1c
 mjpKUwyggcCxFfbATcSN2/yCq6KFgOxOFOGsFO8hxz5fRn9EzH8apl9gMah7rlb5XQJR
 5gYuI/E9YeUcFZ2plSXC+I5eeLXc6q0i04rxBh38da9kSMuXqw4sby41BNBr9w2Kdcs9
 AUhz4W+k6zy6cGW706jbfPROV+GBbVMd3PPon14df4+H8zmAXDgR+/weze7OZaGkCMX1
 EpFnGw7MqIB6+WBbUvH4GKWOTX94JUhaIIcoZbeguqyL/ayUFIVJvUR/6yoBkKFgyeOS
 y9rA==
X-Gm-Message-State: AOJu0YzNbk/Icyt8Rpi/Znv5FXWk2PU/yrABXm1jvaf6G1XWC12cSq4q
 o52mhYldw9xRVBbM3gGMGzE2JxD4EhVWdJnAEGQ=
X-Google-Smtp-Source: AGHT+IGeiHftpvohpaihVWI8j4pdDM3FdFbyTLW7xo376tPGFfTL1jLnkf6qSqJR0XyB8zSyHHRzZVF0eAddRpMqimY=
X-Received: by 2002:a67:ee49:0:b0:452:d5cb:a211 with SMTP id
 g9-20020a67ee49000000b00452d5cba211mr6160893vsp.15.1696846010494; Mon, 09 Oct
 2023 03:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com>
 <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
 <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com>
 <CAF=yD-+syCSJz_wp25rEaHTXMFRHgLh1M-uTdNWPb4fnrKgpFw@mail.gmail.com>
 <8711b549-094d-4be2-b7af-bd93b7516c05@daynix.com>
 <CAF=yD-+M75o2=yDy5d03fChuNTeeTRkUU7rPRG1i6O9aZGhLmQ@mail.gmail.com>
 <695a0611-2b19-49f9-8d32-cfea3b7df0b2@daynix.com>
In-Reply-To: <695a0611-2b19-49f9-8d32-cfea3b7df0b2@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 9 Oct 2023 03:06:13 -0700
Message-ID: <CAF=yD-+_PLPt9qfXy1Ljr=Lou0W8hCJLi6HwPcZYCjJy+SKtbA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: songliubraving@fb.com, gustavoars@kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, decui@microsoft.com, ast@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, yhs@fb.com,
 pabeni@redhat.com, pablo@netfilter.org, elver@google.com, kpsingh@kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, kuba@kernel.org,
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

T24gTW9uLCBPY3QgOSwgMjAyMyBhdCAzOjAy4oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5v
ZGFraUBkYXluaXguY29tPiB3cm90ZToKPgo+IE9uIDIwMjMvMTAvMDkgMTg6NTcsIFdpbGxlbSBk
ZSBCcnVpam4gd3JvdGU6Cj4gPiBPbiBNb24sIE9jdCA5LCAyMDIzIGF0IDM6NTfigK9BTSBBa2lo
aWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gT24g
MjAyMy8xMC8wOSAxNzowNCwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiA+Pj4gT24gU3VuLCBP
Y3QgOCwgMjAyMyBhdCAzOjQ24oCvUE0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXlu
aXguY29tPiB3cm90ZToKPiA+Pj4+Cj4gPj4+PiBPbiAyMDIzLzEwLzA5IDU6MDgsIFdpbGxlbSBk
ZSBCcnVpam4gd3JvdGU6Cj4gPj4+Pj4gT24gU3VuLCBPY3QgOCwgMjAyMyBhdCAxMDowNOKAr1BN
IEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPj4+Pj4+
Cj4gPj4+Pj4+IE9uIDIwMjMvMTAvMDkgNDowNywgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiA+
Pj4+Pj4+IE9uIFN1biwgT2N0IDgsIDIwMjMgYXQgNzoyMuKAr0FNIEFraWhpa28gT2Rha2kgPGFr
aWhpa28ub2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPj4+Pj4+Pj4KPiA+Pj4+Pj4+PiB2aXJ0
aW8tbmV0IGhhdmUgdHdvIHVzYWdlIG9mIGhhc2hlczogb25lIGlzIFJTUyBhbmQgYW5vdGhlciBp
cyBoYXNoCj4gPj4+Pj4+Pj4gcmVwb3J0aW5nLiBDb252ZW50aW9uYWxseSB0aGUgaGFzaCBjYWxj
dWxhdGlvbiB3YXMgZG9uZSBieSB0aGUgVk1NLgo+ID4+Pj4+Pj4+IEhvd2V2ZXIsIGNvbXB1dGlu
ZyB0aGUgaGFzaCBhZnRlciB0aGUgcXVldWUgd2FzIGNob3NlbiBkZWZlYXRzIHRoZQo+ID4+Pj4+
Pj4+IHB1cnBvc2Ugb2YgUlNTLgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gQW5vdGhlciBhcHByb2Fj
aCBpcyB0byB1c2UgZUJQRiBzdGVlcmluZyBwcm9ncmFtLiBUaGlzIGFwcHJvYWNoIGhhcwo+ID4+
Pj4+Pj4+IGFub3RoZXIgZG93bnNpZGU6IGl0IGNhbm5vdCByZXBvcnQgdGhlIGNhbGN1bGF0ZWQg
aGFzaCBkdWUgdG8gdGhlCj4gPj4+Pj4+Pj4gcmVzdHJpY3RpdmUgbmF0dXJlIG9mIGVCUEYuCj4g
Pj4+Pj4+Pj4KPiA+Pj4+Pj4+PiBJbnRyb2R1Y2UgdGhlIGNvZGUgdG8gY29tcHV0ZSBoYXNoZXMg
dG8gdGhlIGtlcm5lbCBpbiBvcmRlciB0byBvdmVyY29tZQo+ID4+Pj4+Pj4+IHRoc2UgY2hhbGxl
bmdlcy4gQW4gYWx0ZXJuYXRpdmUgc29sdXRpb24gaXMgdG8gZXh0ZW5kIHRoZSBlQlBGIHN0ZWVy
aW5nCj4gPj4+Pj4+Pj4gcHJvZ3JhbSBzbyB0aGF0IGl0IHdpbGwgYmUgYWJsZSB0byByZXBvcnQg
dG8gdGhlIHVzZXJzcGFjZSwgYnV0IGl0IG1ha2VzCj4gPj4+Pj4+Pj4gbGl0dGxlIHNlbnNlIHRv
IGFsbG93IHRvIGltcGxlbWVudCBkaWZmZXJlbnQgaGFzaGluZyBhbGdvcml0aG1zIHdpdGgKPiA+
Pj4+Pj4+PiBlQlBGIHNpbmNlIHRoZSBoYXNoIHZhbHVlIHJlcG9ydGVkIGJ5IHZpcnRpby1uZXQg
aXMgc3RyaWN0bHkgZGVmaW5lZCBieQo+ID4+Pj4+Pj4+IHRoZSBzcGVjaWZpY2F0aW9uLgo+ID4+
Pj4+Pj4+Cj4gPj4+Pj4+Pj4gVGhlIGhhc2ggdmFsdWUgYWxyZWFkeSBzdG9yZWQgaW4gc2tfYnVm
ZiBpcyBub3QgdXNlZCBhbmQgY29tcHV0ZWQKPiA+Pj4+Pj4+PiBpbmRlcGVuZGVudGx5IHNpbmNl
IGl0IG1heSBoYXZlIGJlZW4gY29tcHV0ZWQgaW4gYSB3YXkgbm90IGNvbmZvcm1hbnQKPiA+Pj4+
Pj4+PiB3aXRoIHRoZSBzcGVjaWZpY2F0aW9uLgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gU2lnbmVk
LW9mZi1ieTogQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPgo+ID4+Pj4+
Pj4+IC0tLQo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCB0dW5fdm5l
dF9oYXNoX2NhcCB0dW5fdm5ldF9oYXNoX2NhcCA9IHsKPiA+Pj4+Pj4+PiArICAgICAgIC5tYXhf
aW5kaXJlY3Rpb25fdGFibGVfbGVuZ3RoID0KPiA+Pj4+Pj4+PiArICAgICAgICAgICAgICAgVFVO
X1ZORVRfSEFTSF9NQVhfSU5ESVJFQ1RJT05fVEFCTEVfTEVOR1RILAo+ID4+Pj4+Pj4+ICsKPiA+
Pj4+Pj4+PiArICAgICAgIC50eXBlcyA9IFZJUlRJT19ORVRfU1VQUE9SVEVEX0hBU0hfVFlQRVMK
PiA+Pj4+Pj4+PiArfTsKPiA+Pj4+Pj4+Cj4gPj4+Pj4+PiBObyBuZWVkIHRvIGhhdmUgZXhwbGlj
aXQgY2FwYWJpbGl0aWVzIGV4Y2hhbmdlIGxpa2UgdGhpcz8gVHVuIGVpdGhlcgo+ID4+Pj4+Pj4g
c3VwcG9ydHMgYWxsIG9yIG5vbmUuCj4gPj4+Pj4+Cj4gPj4+Pj4+IHR1biBkb2VzIG5vdCBzdXBw
b3J0IFZJUlRJT19ORVRfUlNTX0hBU0hfVFlQRV9JUF9FWCwKPiA+Pj4+Pj4gVklSVElPX05FVF9S
U1NfSEFTSF9UWVBFX1RDUF9FWCwgYW5kIFZJUlRJT19ORVRfUlNTX0hBU0hfVFlQRV9VRFBfRVgu
Cj4gPj4+Pj4+Cj4gPj4+Pj4+IEl0IGlzIGJlY2F1c2UgdGhlIGZsb3cgZGlzc2VjdG9yIGRvZXMg
bm90IHN1cHBvcnQgSVB2NiBleHRlbnNpb25zLiBUaGUKPiA+Pj4+Pj4gc3BlY2lmaWNhdGlvbiBp
cyBhbHNvIHZhZ3VlLCBhbmQgZG9lcyBub3QgdGVsbCBob3cgbWFueSBUTFZzIHNob3VsZCBiZQo+
ID4+Pj4+PiBjb25zdW1lZCBhdCBtb3N0IHdoZW4gaW50ZXJwcmV0aW5nIGRlc3RpbmF0aW9uIG9w
dGlvbiBoZWFkZXIgc28gSSBjaG9zZQo+ID4+Pj4+PiB0byBhdm9pZCBhZGRpbmcgY29kZSBmb3Ig
dGhlc2UgaGFzaCB0eXBlcyB0byB0aGUgZmxvdyBkaXNzZWN0b3IuIEkgZG91YnQKPiA+Pj4+Pj4g
YW55b25lIHdpbGwgY29tcGxhaW4gYWJvdXQgaXQgc2luY2Ugbm9ib2R5IGNvbXBsYWlucyBmb3Ig
TGludXguCj4gPj4+Pj4+Cj4gPj4+Pj4+IEknbSBhbHNvIGFkZGluZyB0aGlzIHNvIHRoYXQgd2Ug
Y2FuIGV4dGVuZCBpdCBsYXRlci4KPiA+Pj4+Pj4gbWF4X2luZGlyZWN0aW9uX3RhYmxlX2xlbmd0
aCBtYXkgZ3JvdyBmb3Igc3lzdGVtcyB3aXRoIDEyOCsgQ1BVcywgb3IKPiA+Pj4+Pj4gdHlwZXMg
bWF5IGhhdmUgb3RoZXIgYml0cyBmb3IgbmV3IHByb3RvY29scyBpbiB0aGUgZnV0dXJlLgo+ID4+
Pj4+Pgo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+PiAgICAgICAgICAgICBjYXNlIFRVTlNFVFNURUVSSU5H
RUJQRjoKPiA+Pj4+Pj4+PiAtICAgICAgICAgICAgICAgcmV0ID0gdHVuX3NldF9lYnBmKHR1biwg
JnR1bi0+c3RlZXJpbmdfcHJvZywgYXJncCk7Cj4gPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIGJw
Zl9yZXQgPSB0dW5fc2V0X2VicGYodHVuLCAmdHVuLT5zdGVlcmluZ19wcm9nLCBhcmdwKTsKPiA+
Pj4+Pj4+PiArICAgICAgICAgICAgICAgaWYgKElTX0VSUihicGZfcmV0KSkKPiA+Pj4+Pj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKGJwZl9yZXQpOwo+ID4+Pj4+Pj4+
ICsgICAgICAgICAgICAgICBlbHNlIGlmIChicGZfcmV0KQo+ID4+Pj4+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHR1bi0+dm5ldF9oYXNoLmZsYWdzICY9IH5UVU5fVk5FVF9IQVNIX1JTUzsK
PiA+Pj4+Pj4+Cj4gPj4+Pj4+PiBEb24ndCBtYWtlIG9uZSBmZWF0dXJlIGRpc2FibGUgYW5vdGhl
ci4KPiA+Pj4+Pj4+Cj4gPj4+Pj4+PiBUVU5TRVRTVEVFUklOR0VCUEYgYW5kIFRVTlNFVFZORVRI
QVNIIGFyZSBtdXR1YWxseSBleGNsdXNpdmUKPiA+Pj4+Pj4+IGZ1bmN0aW9ucy4gSWYgb25lIGlz
IGVuYWJsZWQgdGhlIG90aGVyIGNhbGwgc2hvdWxkIGZhaWwsIHdpdGggRUJVU1kKPiA+Pj4+Pj4+
IGZvciBpbnN0YW5jZS4KPiA+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gKyAgICAgICBjYXNlIFRVTlNFVFZO
RVRIQVNIOgo+ID4+Pj4+Pj4+ICsgICAgICAgICAgICAgICBsZW4gPSBzaXplb2Yodm5ldF9oYXNo
KTsKPiA+Pj4+Pj4+PiArICAgICAgICAgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKCZ2bmV0X2hh
c2gsIGFyZ3AsIGxlbikpIHsKPiA+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICByZXQg
PSAtRUZBVUxUOwo+ID4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4+
Pj4+Pj4+ICsgICAgICAgICAgICAgICB9Cj4gPj4+Pj4+Pj4gKwo+ID4+Pj4+Pj4+ICsgICAgICAg
ICAgICAgICBpZiAoKCh2bmV0X2hhc2guZmxhZ3MgJiBUVU5fVk5FVF9IQVNIX1JFUE9SVCkgJiYK
PiA+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAodHVuLT52bmV0X2hkcl9zeiA8IHNpemVv
ZihzdHJ1Y3QgdmlydGlvX25ldF9oZHJfdjFfaGFzaCkgfHwKPiA+Pj4+Pj4+PiArICAgICAgICAg
ICAgICAgICAgICAgIXR1bl9pc19saXR0bGVfZW5kaWFuKHR1bikpKSB8fAo+ID4+Pj4+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgIHZuZXRfaGFzaC5pbmRpcmVjdGlvbl90YWJsZV9tYXNrID49Cj4g
Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgVFVOX1ZORVRfSEFTSF9NQVhfSU5ESVJFQ1RJ
T05fVEFCTEVfTEVOR1RIKSB7Cj4gPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gLUVJTlZBTDsKPiA+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+
Pj4+Pj4+PiArICAgICAgICAgICAgICAgfQo+ID4+Pj4+Pj4+ICsKPiA+Pj4+Pj4+PiArICAgICAg
ICAgICAgICAgYXJncCA9ICh1OCBfX3VzZXIgKilhcmdwICsgbGVuOwo+ID4+Pj4+Pj4+ICsgICAg
ICAgICAgICAgICBsZW4gPSAodm5ldF9oYXNoLmluZGlyZWN0aW9uX3RhYmxlX21hc2sgKyAxKSAq
IDI7Cj4gPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcih2bmV0X2hh
c2hfaW5kaXJlY3Rpb25fdGFibGUsIGFyZ3AsIGxlbikpIHsKPiA+Pj4+Pj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICByZXQgPSAtRUZBVUxUOwo+ID4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOwo+ID4+Pj4+Pj4+ICsgICAgICAgICAgICAgICB9Cj4gPj4+Pj4+Pj4gKwo+
ID4+Pj4+Pj4+ICsgICAgICAgICAgICAgICBhcmdwID0gKHU4IF9fdXNlciAqKWFyZ3AgKyBsZW47
Cj4gPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIGxlbiA9IHZpcnRpb19uZXRfaGFzaF9rZXlfbGVu
Z3RoKHZuZXRfaGFzaC50eXBlcyk7Cj4gPj4+Pj4+Pj4gKwo+ID4+Pj4+Pj4+ICsgICAgICAgICAg
ICAgICBpZiAoY29weV9mcm9tX3VzZXIodm5ldF9oYXNoX2tleSwgYXJncCwgbGVuKSkgewo+ID4+
Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7Cj4gPj4+Pj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4+Pj4+Pj4gKyAgICAgICAgICAgICAg
IH0KPiA+Pj4+Pj4+Cj4gPj4+Pj4+PiBQcm9iYWJseSBlYXNpZXIgYW5kIGxlc3MgZXJyb3ItcHJv
bmUgdG8gZGVmaW5lIGEgZml4ZWQgc2l6ZSBjb250cm9sCj4gPj4+Pj4+PiBzdHJ1Y3Qgd2l0aCB0
aGUgbWF4IGluZGlyZWN0aW9uIHRhYmxlIHNpemUuCj4gPj4+Pj4+Cj4gPj4+Pj4+IEkgbWFkZSBp
dHMgc2l6ZSB2YXJpYWJsZSBiZWNhdXNlIHRoZSBpbmRpcmVjdGlvbiB0YWJsZSBhbmQga2V5IG1h
eSBncm93Cj4gPj4+Pj4+IGluIHRoZSBmdXR1cmUgYXMgSSB3cm90ZSBhYm92ZS4KPiA+Pj4+Pj4K
PiA+Pj4+Pj4+Cj4gPj4+Pj4+PiBCdHc6IHBsZWFzZSB0cmltIHRoZSBDQzogbGlzdCBjb25zaWRl
cmFibHkgb24gZnV0dXJlIHBhdGNoZXMuCj4gPj4+Pj4+Cj4gPj4+Pj4+IEknbGwgZG8gc28gaW4g
dGhlIG5leHQgdmVyc2lvbiB3aXRoIHRoZSBUVU5TRVRTVEVFUklOR0VCUEYgY2hhbmdlIHlvdQo+
ID4+Pj4+PiBwcm9wb3NlZC4KPiA+Pj4+Pgo+ID4+Pj4+IFRvIGJlIGNsZWFyOiBwbGVhc2UgZG9u
J3QganVzdCByZXN1Ym1pdCB3aXRoIHRoYXQgb25lIGNoYW5nZS4KPiA+Pj4+Pgo+ID4+Pj4+IFRo
ZSBza2IgYW5kIGNiIGlzc3VlcyBhcmUgcXVpdGUgZnVuZGFtZW50YWwgaXNzdWVzIHRoYXQgbmVl
ZCB0byBiZSByZXNvbHZlZC4KPiA+Pj4+Pgo+ID4+Pj4+IEknZCBsaWtlIHRvIHVuZGVyc3RhbmQg
d2h5IGFkanVzdGluZyB0aGUgZXhpc3RpbmcgQlBGIGZlYXR1cmUgZm9yIHRoaXMKPiA+Pj4+PiBl
eGFjdCBwdXJwb3NlIGNhbm5vdCBiZSBhbWVuZGVkIHRvIHJldHVybiB0aGUga2V5IGl0IHByb2R1
Y2VkLgo+ID4+Pj4KPiA+Pj4+IGVCUEYgc3RlZXJpbmcgcHJvZ3JhbSBpcyBub3QgZGVzaWduZWQg
Zm9yIHRoaXMgcGFydGljdWxhciBwcm9ibGVtIGluIG15Cj4gPj4+PiB1bmRlcnN0YW5kaW5nLiBJ
dCB3YXMgaW50cm9kdWNlZCB0byBkZXJpdmUgaGFzaCB2YWx1ZXMgd2l0aCBhbgo+ID4+Pj4gdW5k
ZXJzdGFuZGluZyBvZiBhcHBsaWNhdGlvbi1zcGVjaWZpYyBzZW1hbnRpY3Mgb2YgcGFja2V0cyBp
bnN0ZWFkIG9mCj4gPj4+PiBnZW5lcmljIElQL1RDUC9VRFAgc2VtYW50aWNzLgo+ID4+Pj4KPiA+
Pj4+IFRoaXMgcHJvYmxlbSBpcyByYXRoZXIgZGlmZmVyZW50IGluIHRlcm1zIHRoYXQgdGhlIGhh
c2ggZGVyaXZhdGlvbiBpcwo+ID4+Pj4gc3RyaWN0bHkgZGVmaW5lZCBieSB2aXJ0aW8tbmV0LiBJ
IGRvbid0IHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvCj4gPj4+PiBpbnRyb2R1Y2UgdGhlIGNvbXBs
ZXhpdHkgb2YgQlBGIHdoZW4geW91IGFsd2F5cyBydW4gdGhlIHNhbWUgY29kZS4KPiA+Pj4+Cj4g
Pj4+PiBJdCBjYW4gdXRpbGl6ZSB0aGUgZXhpc3RpbmcgZmxvdyBkaXNzZWN0b3IgYW5kIGFsc28g
bWFrZSBpdCBlYXNpZXIgdG8KPiA+Pj4+IHVzZSBmb3IgdGhlIHVzZXJzcGFjZSBieSBpbXBsZW1l
bnRpbmcgdGhpcyBpbiB0aGUga2VybmVsLgo+ID4+Pgo+ID4+PiBPay4gVGhlcmUgZG9lcyBhcHBl
YXIgdG8gYmUgb3ZlcmxhcCBpbiBmdW5jdGlvbmFsaXR5LiBCdXQgaXQgbWlnaHQgYmUKPiA+Pj4g
ZWFzaWVyIHRvIGRlcGxveSB0byBqdXN0IGhhdmUgc3RhbmRhcmQgVG9lcGxpdHogYXZhaWxhYmxl
IHdpdGhvdXQKPiA+Pj4gaGF2aW5nIHRvIGNvbXBpbGUgYW5kIGxvYWQgYW4gZUJQRiBwcm9ncmFt
Lgo+ID4+Pgo+ID4+PiBBcyBmb3IgdGhlIHNrX2J1ZmYgYW5kIGNiW10gY2hhbmdlcy4gVGhlIGZp
cnN0IGlzIHJlYWxseSBub3QgbmVlZGVkLgo+ID4+PiBza19idWZmIHNpbXBseSB3b3VsZCBub3Qg
c2NhbGUgaWYgZXZlcnkgZWRnZSBjYXNlIG5lZWRzIGEgZmV3IGJpdHMuCj4gPj4KPiA+PiBBbiBh
bHRlcm5hdGl2ZSBpcyB0byBtb3ZlIHRoZSBiaXQgdG8gY2JbXSBhbmQgY2xlYXIgaXQgZm9yIGV2
ZXJ5IGNvZGUKPiA+PiBwYXRocyB0aGF0IGxlYWQgdG8gbmRvX3N0YXJ0X3htaXQoKSwgYnV0IEkn
bSB3b3JyaWVkIHRoYXQgaXQgaXMgZXJyb3ItcHJvbmUuCj4gPj4KPiA+PiBJIHRoaW5rIHdlIGNh
biBwdXQgdGhlIGJpdCBpbiBza19idWZmIGZvciBub3cuIFdlIGNhbiBpbXBsZW1lbnQgdGhlCj4g
Pj4gYWx0ZXJuYXRpdmUgd2hlbiB3ZSBhcmUgc2hvcnQgb2YgYml0cy4KPiA+Cj4gPiBJIGRpc2Fn
cmVlLiBza19idWZmIGZpZWxkcyBhZGQgYSBjb3N0IHRvIGV2ZXJ5IGNvZGUgcGF0aC4gVGhleSBj
YW5ub3QKPiA+IGJlIGFkZGVkIGZvciBldmVyeSBlZGdlIGNhc2UuCj4KPiBJdCBvbmx5IHRha2Vz
IGFuIHVudXNlZCBiaXQgYW5kIGRvZXMgbm90IGdyb3cgdGhlIHNrX2J1ZmYgc2l6ZSBzbyBJCj4g
dGhpbmsgaXQgaGFzIHByYWN0aWNhbGx5IG5vIGNvc3QgZm9yIG5vdy4KClRoZSBwcm9ibGVtIGlz
IHRoYXQgdGhhdCB0aGlua2luZyBsZWFkcyB0byBkZWF0aCBieSBhIHRob3VzYW5kIGN1dHMuCgoi
Zm9yIG5vdyIgZm9yY2VzIHRoZSBjb3N0IG9mIGhhdmluZyB0byB0aGluayBoYXJkIGhvdyB0byBh
dm9pZCBncm93aW5nCnNrX2J1ZmYgb250byB0aGUgbmV4dCBwZXJzb24uIExldCdzIGRvIGl0IHJp
Z2h0IGZyb20gdGhlIHN0YXJ0LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
