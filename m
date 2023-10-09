Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0292E95A97
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 09:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45871610F8;
	Mon,  9 Oct 2023 09:58:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45871610F8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JiqTM0hN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZGzeICSC5f1q; Mon,  9 Oct 2023 09:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8A08F60BB7;
	Mon,  9 Oct 2023 09:58:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A08F60BB7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EC1FC0039;
	Mon,  9 Oct 2023 09:58:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93DEFC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 09:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61D4881FEB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 09:58:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61D4881FEB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=JiqTM0hN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 91IXVuZXfJsh
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 09:58:13 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F222781F80
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 09:58:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F222781F80
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7abe4fa15ceso2839466241.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 02:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696845491; x=1697450291;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UQu7ZxKt3SgEsSumjeMXtr6/TTeWg3eL1+yCIl9X3g=;
 b=JiqTM0hNUr8vI4rcGRrna5uhuR6ToA5wSRDYoVSUeLwlUSuMEvc1MfkIuvCxPLErXJ
 3RHRxRzME87yLtKMWpzblh6y8XH7nS9ZiE9AvmW+2j5SSOgjTUGQq8EEUvuZizaiqGHf
 2QvlGneo8S85GSCJA0ZPRUQ5msqvDkx8OvZdRLO6CPU9D5Hz1bLS/VB1e+S9OAxMwwet
 OylQXmrHhqxCh4zL0biwlS/JDAO2PYiYstzR4XFgM9JRaaBSmRADBLK5V97OA2w8Lo7j
 gVWrozuk8P82erLILmS/uOw0X3VPpgmokZsQpKSMoB7+ilJML7jISroaOVJTfS5PMPD1
 8BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845491; x=1697450291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UQu7ZxKt3SgEsSumjeMXtr6/TTeWg3eL1+yCIl9X3g=;
 b=BJo+gDzscaSjixVq2UXjQb8WIXBG7yU5DJ1pxGqh85w3S09wX6lz52Lrx9B2aSpyD9
 FxRk+xbZMD05gqig+uuycyvcKT7mWPDtnT+opZTthoIIwchS1fshh9fP31DXI5jhG4mu
 m7pC4ofmeUXKc7XOY3zTSsWgJ6fWkIYFrUESPNRe/pD9/njRvIaeifS9Z3U7pLZ5GLZI
 btmXfqRkl0OB82ModAwt0Gg+wBuWFw1cFvDn+3UXfnnF1e+pKbY92+1UibOlBjeOzsbF
 nhtqgXUelTZDVXJs28p/wdZh1LWUS2ZwmI6bDRfI7oE8SeUwCqyD85VzR5SRFGRGZp4O
 PX/A==
X-Gm-Message-State: AOJu0YyLYHkuR4b7ubFIXd7/5rRGrlSonZuoQvh5PcnAGjbkHiLc5jB5
 KTjfze7dx9Rdku/W373E3t0A0H4GufPlMmuuWWg=
X-Google-Smtp-Source: AGHT+IGDgdO9gO0/H9fjMssaFno+x01yJKkkf0DGlYvrctvF9jKh/A7zhIK+wq90Ni+Jk375I6OAzOI8eAurWQgYimE=
X-Received: by 2002:a05:6122:2026:b0:496:2d54:e6f0 with SMTP id
 l38-20020a056122202600b004962d54e6f0mr7503884vkd.6.1696845491642; Mon, 09 Oct
 2023 02:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com>
 <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
 <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com>
 <CAF=yD-+syCSJz_wp25rEaHTXMFRHgLh1M-uTdNWPb4fnrKgpFw@mail.gmail.com>
 <8711b549-094d-4be2-b7af-bd93b7516c05@daynix.com>
In-Reply-To: <8711b549-094d-4be2-b7af-bd93b7516c05@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 9 Oct 2023 02:57:35 -0700
Message-ID: <CAF=yD-+M75o2=yDy5d03fChuNTeeTRkUU7rPRG1i6O9aZGhLmQ@mail.gmail.com>
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

T24gTW9uLCBPY3QgOSwgMjAyMyBhdCAzOjU34oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5v
ZGFraUBkYXluaXguY29tPiB3cm90ZToKPgo+IE9uIDIwMjMvMTAvMDkgMTc6MDQsIFdpbGxlbSBk
ZSBCcnVpam4gd3JvdGU6Cj4gPiBPbiBTdW4sIE9jdCA4LCAyMDIzIGF0IDM6NDbigK9QTSBBa2lo
aWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gT24g
MjAyMy8xMC8wOSA1OjA4LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4+PiBPbiBTdW4sIE9j
dCA4LCAyMDIzIGF0IDEwOjA04oCvUE0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXlu
aXguY29tPiB3cm90ZToKPiA+Pj4+Cj4gPj4+PiBPbiAyMDIzLzEwLzA5IDQ6MDcsIFdpbGxlbSBk
ZSBCcnVpam4gd3JvdGU6Cj4gPj4+Pj4gT24gU3VuLCBPY3QgOCwgMjAyMyBhdCA3OjIy4oCvQU0g
QWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPiB3cm90ZToKPiA+Pj4+Pj4K
PiA+Pj4+Pj4gdmlydGlvLW5ldCBoYXZlIHR3byB1c2FnZSBvZiBoYXNoZXM6IG9uZSBpcyBSU1Mg
YW5kIGFub3RoZXIgaXMgaGFzaAo+ID4+Pj4+PiByZXBvcnRpbmcuIENvbnZlbnRpb25hbGx5IHRo
ZSBoYXNoIGNhbGN1bGF0aW9uIHdhcyBkb25lIGJ5IHRoZSBWTU0uCj4gPj4+Pj4+IEhvd2V2ZXIs
IGNvbXB1dGluZyB0aGUgaGFzaCBhZnRlciB0aGUgcXVldWUgd2FzIGNob3NlbiBkZWZlYXRzIHRo
ZQo+ID4+Pj4+PiBwdXJwb3NlIG9mIFJTUy4KPiA+Pj4+Pj4KPiA+Pj4+Pj4gQW5vdGhlciBhcHBy
b2FjaCBpcyB0byB1c2UgZUJQRiBzdGVlcmluZyBwcm9ncmFtLiBUaGlzIGFwcHJvYWNoIGhhcwo+
ID4+Pj4+PiBhbm90aGVyIGRvd25zaWRlOiBpdCBjYW5ub3QgcmVwb3J0IHRoZSBjYWxjdWxhdGVk
IGhhc2ggZHVlIHRvIHRoZQo+ID4+Pj4+PiByZXN0cmljdGl2ZSBuYXR1cmUgb2YgZUJQRi4KPiA+
Pj4+Pj4KPiA+Pj4+Pj4gSW50cm9kdWNlIHRoZSBjb2RlIHRvIGNvbXB1dGUgaGFzaGVzIHRvIHRo
ZSBrZXJuZWwgaW4gb3JkZXIgdG8gb3ZlcmNvbWUKPiA+Pj4+Pj4gdGhzZSBjaGFsbGVuZ2VzLiBB
biBhbHRlcm5hdGl2ZSBzb2x1dGlvbiBpcyB0byBleHRlbmQgdGhlIGVCUEYgc3RlZXJpbmcKPiA+
Pj4+Pj4gcHJvZ3JhbSBzbyB0aGF0IGl0IHdpbGwgYmUgYWJsZSB0byByZXBvcnQgdG8gdGhlIHVz
ZXJzcGFjZSwgYnV0IGl0IG1ha2VzCj4gPj4+Pj4+IGxpdHRsZSBzZW5zZSB0byBhbGxvdyB0byBp
bXBsZW1lbnQgZGlmZmVyZW50IGhhc2hpbmcgYWxnb3JpdGhtcyB3aXRoCj4gPj4+Pj4+IGVCUEYg
c2luY2UgdGhlIGhhc2ggdmFsdWUgcmVwb3J0ZWQgYnkgdmlydGlvLW5ldCBpcyBzdHJpY3RseSBk
ZWZpbmVkIGJ5Cj4gPj4+Pj4+IHRoZSBzcGVjaWZpY2F0aW9uLgo+ID4+Pj4+Pgo+ID4+Pj4+PiBU
aGUgaGFzaCB2YWx1ZSBhbHJlYWR5IHN0b3JlZCBpbiBza19idWZmIGlzIG5vdCB1c2VkIGFuZCBj
b21wdXRlZAo+ID4+Pj4+PiBpbmRlcGVuZGVudGx5IHNpbmNlIGl0IG1heSBoYXZlIGJlZW4gY29t
cHV0ZWQgaW4gYSB3YXkgbm90IGNvbmZvcm1hbnQKPiA+Pj4+Pj4gd2l0aCB0aGUgc3BlY2lmaWNh
dGlvbi4KPiA+Pj4+Pj4KPiA+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQWtpaGlrbyBPZGFraSA8YWtp
aGlrby5vZGFraUBkYXluaXguY29tPgo+ID4+Pj4+PiAtLS0KPiA+Pj4+Pgo+ID4+Pj4+PiArc3Rh
dGljIGNvbnN0IHN0cnVjdCB0dW5fdm5ldF9oYXNoX2NhcCB0dW5fdm5ldF9oYXNoX2NhcCA9IHsK
PiA+Pj4+Pj4gKyAgICAgICAubWF4X2luZGlyZWN0aW9uX3RhYmxlX2xlbmd0aCA9Cj4gPj4+Pj4+
ICsgICAgICAgICAgICAgICBUVU5fVk5FVF9IQVNIX01BWF9JTkRJUkVDVElPTl9UQUJMRV9MRU5H
VEgsCj4gPj4+Pj4+ICsKPiA+Pj4+Pj4gKyAgICAgICAudHlwZXMgPSBWSVJUSU9fTkVUX1NVUFBP
UlRFRF9IQVNIX1RZUEVTCj4gPj4+Pj4+ICt9Owo+ID4+Pj4+Cj4gPj4+Pj4gTm8gbmVlZCB0byBo
YXZlIGV4cGxpY2l0IGNhcGFiaWxpdGllcyBleGNoYW5nZSBsaWtlIHRoaXM/IFR1biBlaXRoZXIK
PiA+Pj4+PiBzdXBwb3J0cyBhbGwgb3Igbm9uZS4KPiA+Pj4+Cj4gPj4+PiB0dW4gZG9lcyBub3Qg
c3VwcG9ydCBWSVJUSU9fTkVUX1JTU19IQVNIX1RZUEVfSVBfRVgsCj4gPj4+PiBWSVJUSU9fTkVU
X1JTU19IQVNIX1RZUEVfVENQX0VYLCBhbmQgVklSVElPX05FVF9SU1NfSEFTSF9UWVBFX1VEUF9F
WC4KPiA+Pj4+Cj4gPj4+PiBJdCBpcyBiZWNhdXNlIHRoZSBmbG93IGRpc3NlY3RvciBkb2VzIG5v
dCBzdXBwb3J0IElQdjYgZXh0ZW5zaW9ucy4gVGhlCj4gPj4+PiBzcGVjaWZpY2F0aW9uIGlzIGFs
c28gdmFndWUsIGFuZCBkb2VzIG5vdCB0ZWxsIGhvdyBtYW55IFRMVnMgc2hvdWxkIGJlCj4gPj4+
PiBjb25zdW1lZCBhdCBtb3N0IHdoZW4gaW50ZXJwcmV0aW5nIGRlc3RpbmF0aW9uIG9wdGlvbiBo
ZWFkZXIgc28gSSBjaG9zZQo+ID4+Pj4gdG8gYXZvaWQgYWRkaW5nIGNvZGUgZm9yIHRoZXNlIGhh
c2ggdHlwZXMgdG8gdGhlIGZsb3cgZGlzc2VjdG9yLiBJIGRvdWJ0Cj4gPj4+PiBhbnlvbmUgd2ls
bCBjb21wbGFpbiBhYm91dCBpdCBzaW5jZSBub2JvZHkgY29tcGxhaW5zIGZvciBMaW51eC4KPiA+
Pj4+Cj4gPj4+PiBJJ20gYWxzbyBhZGRpbmcgdGhpcyBzbyB0aGF0IHdlIGNhbiBleHRlbmQgaXQg
bGF0ZXIuCj4gPj4+PiBtYXhfaW5kaXJlY3Rpb25fdGFibGVfbGVuZ3RoIG1heSBncm93IGZvciBz
eXN0ZW1zIHdpdGggMTI4KyBDUFVzLCBvcgo+ID4+Pj4gdHlwZXMgbWF5IGhhdmUgb3RoZXIgYml0
cyBmb3IgbmV3IHByb3RvY29scyBpbiB0aGUgZnV0dXJlLgo+ID4+Pj4KPiA+Pj4+Pgo+ID4+Pj4+
PiAgICAgICAgICAgIGNhc2UgVFVOU0VUU1RFRVJJTkdFQlBGOgo+ID4+Pj4+PiAtICAgICAgICAg
ICAgICAgcmV0ID0gdHVuX3NldF9lYnBmKHR1biwgJnR1bi0+c3RlZXJpbmdfcHJvZywgYXJncCk7
Cj4gPj4+Pj4+ICsgICAgICAgICAgICAgICBicGZfcmV0ID0gdHVuX3NldF9lYnBmKHR1biwgJnR1
bi0+c3RlZXJpbmdfcHJvZywgYXJncCk7Cj4gPj4+Pj4+ICsgICAgICAgICAgICAgICBpZiAoSVNf
RVJSKGJwZl9yZXQpKQo+ID4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBQVFJf
RVJSKGJwZl9yZXQpOwo+ID4+Pj4+PiArICAgICAgICAgICAgICAgZWxzZSBpZiAoYnBmX3JldCkK
PiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgdHVuLT52bmV0X2hhc2guZmxhZ3MgJj0g
flRVTl9WTkVUX0hBU0hfUlNTOwo+ID4+Pj4+Cj4gPj4+Pj4gRG9uJ3QgbWFrZSBvbmUgZmVhdHVy
ZSBkaXNhYmxlIGFub3RoZXIuCj4gPj4+Pj4KPiA+Pj4+PiBUVU5TRVRTVEVFUklOR0VCUEYgYW5k
IFRVTlNFVFZORVRIQVNIIGFyZSBtdXR1YWxseSBleGNsdXNpdmUKPiA+Pj4+PiBmdW5jdGlvbnMu
IElmIG9uZSBpcyBlbmFibGVkIHRoZSBvdGhlciBjYWxsIHNob3VsZCBmYWlsLCB3aXRoIEVCVVNZ
Cj4gPj4+Pj4gZm9yIGluc3RhbmNlLgo+ID4+Pj4+Cj4gPj4+Pj4+ICsgICAgICAgY2FzZSBUVU5T
RVRWTkVUSEFTSDoKPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgIGxlbiA9IHNpemVvZih2bmV0X2hh
c2gpOwo+ID4+Pj4+PiArICAgICAgICAgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKCZ2bmV0X2hh
c2gsIGFyZ3AsIGxlbikpIHsKPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0g
LUVGQVVMVDsKPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4+Pj4+
ICsgICAgICAgICAgICAgICB9Cj4gPj4+Pj4+ICsKPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgIGlm
ICgoKHZuZXRfaGFzaC5mbGFncyAmIFRVTl9WTkVUX0hBU0hfUkVQT1JUKSAmJgo+ID4+Pj4+PiAr
ICAgICAgICAgICAgICAgICAgICAodHVuLT52bmV0X2hkcl9zeiA8IHNpemVvZihzdHJ1Y3Qgdmly
dGlvX25ldF9oZHJfdjFfaGFzaCkgfHwKPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICF0
dW5faXNfbGl0dGxlX2VuZGlhbih0dW4pKSkgfHwKPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgdm5ldF9oYXNoLmluZGlyZWN0aW9uX3RhYmxlX21hc2sgPj0KPiA+Pj4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgVFVOX1ZORVRfSEFTSF9NQVhfSU5ESVJFQ1RJT05fVEFCTEVfTEVOR1RIKSB7
Cj4gPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7Cj4gPj4+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4+Pj4+PiArICAgICAgICAgICAgICAg
fQo+ID4+Pj4+PiArCj4gPj4+Pj4+ICsgICAgICAgICAgICAgICBhcmdwID0gKHU4IF9fdXNlciAq
KWFyZ3AgKyBsZW47Cj4gPj4+Pj4+ICsgICAgICAgICAgICAgICBsZW4gPSAodm5ldF9oYXNoLmlu
ZGlyZWN0aW9uX3RhYmxlX21hc2sgKyAxKSAqIDI7Cj4gPj4+Pj4+ICsgICAgICAgICAgICAgICBp
ZiAoY29weV9mcm9tX3VzZXIodm5ldF9oYXNoX2luZGlyZWN0aW9uX3RhYmxlLCBhcmdwLCBsZW4p
KSB7Cj4gPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7Cj4gPj4+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4+Pj4+PiArICAgICAgICAgICAg
ICAgfQo+ID4+Pj4+PiArCj4gPj4+Pj4+ICsgICAgICAgICAgICAgICBhcmdwID0gKHU4IF9fdXNl
ciAqKWFyZ3AgKyBsZW47Cj4gPj4+Pj4+ICsgICAgICAgICAgICAgICBsZW4gPSB2aXJ0aW9fbmV0
X2hhc2hfa2V5X2xlbmd0aCh2bmV0X2hhc2gudHlwZXMpOwo+ID4+Pj4+PiArCj4gPj4+Pj4+ICsg
ICAgICAgICAgICAgICBpZiAoY29weV9mcm9tX3VzZXIodm5ldF9oYXNoX2tleSwgYXJncCwgbGVu
KSkgewo+ID4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUZBVUxUOwo+ID4+
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+Pj4+Pj4gKyAgICAgICAgICAg
ICAgIH0KPiA+Pj4+Pgo+ID4+Pj4+IFByb2JhYmx5IGVhc2llciBhbmQgbGVzcyBlcnJvci1wcm9u
ZSB0byBkZWZpbmUgYSBmaXhlZCBzaXplIGNvbnRyb2wKPiA+Pj4+PiBzdHJ1Y3Qgd2l0aCB0aGUg
bWF4IGluZGlyZWN0aW9uIHRhYmxlIHNpemUuCj4gPj4+Pgo+ID4+Pj4gSSBtYWRlIGl0cyBzaXpl
IHZhcmlhYmxlIGJlY2F1c2UgdGhlIGluZGlyZWN0aW9uIHRhYmxlIGFuZCBrZXkgbWF5IGdyb3cK
PiA+Pj4+IGluIHRoZSBmdXR1cmUgYXMgSSB3cm90ZSBhYm92ZS4KPiA+Pj4+Cj4gPj4+Pj4KPiA+
Pj4+PiBCdHc6IHBsZWFzZSB0cmltIHRoZSBDQzogbGlzdCBjb25zaWRlcmFibHkgb24gZnV0dXJl
IHBhdGNoZXMuCj4gPj4+Pgo+ID4+Pj4gSSdsbCBkbyBzbyBpbiB0aGUgbmV4dCB2ZXJzaW9uIHdp
dGggdGhlIFRVTlNFVFNURUVSSU5HRUJQRiBjaGFuZ2UgeW91Cj4gPj4+PiBwcm9wb3NlZC4KPiA+
Pj4KPiA+Pj4gVG8gYmUgY2xlYXI6IHBsZWFzZSBkb24ndCBqdXN0IHJlc3VibWl0IHdpdGggdGhh
dCBvbmUgY2hhbmdlLgo+ID4+Pgo+ID4+PiBUaGUgc2tiIGFuZCBjYiBpc3N1ZXMgYXJlIHF1aXRl
IGZ1bmRhbWVudGFsIGlzc3VlcyB0aGF0IG5lZWQgdG8gYmUgcmVzb2x2ZWQuCj4gPj4+Cj4gPj4+
IEknZCBsaWtlIHRvIHVuZGVyc3RhbmQgd2h5IGFkanVzdGluZyB0aGUgZXhpc3RpbmcgQlBGIGZl
YXR1cmUgZm9yIHRoaXMKPiA+Pj4gZXhhY3QgcHVycG9zZSBjYW5ub3QgYmUgYW1lbmRlZCB0byBy
ZXR1cm4gdGhlIGtleSBpdCBwcm9kdWNlZC4KPiA+Pgo+ID4+IGVCUEYgc3RlZXJpbmcgcHJvZ3Jh
bSBpcyBub3QgZGVzaWduZWQgZm9yIHRoaXMgcGFydGljdWxhciBwcm9ibGVtIGluIG15Cj4gPj4g
dW5kZXJzdGFuZGluZy4gSXQgd2FzIGludHJvZHVjZWQgdG8gZGVyaXZlIGhhc2ggdmFsdWVzIHdp
dGggYW4KPiA+PiB1bmRlcnN0YW5kaW5nIG9mIGFwcGxpY2F0aW9uLXNwZWNpZmljIHNlbWFudGlj
cyBvZiBwYWNrZXRzIGluc3RlYWQgb2YKPiA+PiBnZW5lcmljIElQL1RDUC9VRFAgc2VtYW50aWNz
Lgo+ID4+Cj4gPj4gVGhpcyBwcm9ibGVtIGlzIHJhdGhlciBkaWZmZXJlbnQgaW4gdGVybXMgdGhh
dCB0aGUgaGFzaCBkZXJpdmF0aW9uIGlzCj4gPj4gc3RyaWN0bHkgZGVmaW5lZCBieSB2aXJ0aW8t
bmV0LiBJIGRvbid0IHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvCj4gPj4gaW50cm9kdWNlIHRoZSBj
b21wbGV4aXR5IG9mIEJQRiB3aGVuIHlvdSBhbHdheXMgcnVuIHRoZSBzYW1lIGNvZGUuCj4gPj4K
PiA+PiBJdCBjYW4gdXRpbGl6ZSB0aGUgZXhpc3RpbmcgZmxvdyBkaXNzZWN0b3IgYW5kIGFsc28g
bWFrZSBpdCBlYXNpZXIgdG8KPiA+PiB1c2UgZm9yIHRoZSB1c2Vyc3BhY2UgYnkgaW1wbGVtZW50
aW5nIHRoaXMgaW4gdGhlIGtlcm5lbC4KPiA+Cj4gPiBPay4gVGhlcmUgZG9lcyBhcHBlYXIgdG8g
YmUgb3ZlcmxhcCBpbiBmdW5jdGlvbmFsaXR5LiBCdXQgaXQgbWlnaHQgYmUKPiA+IGVhc2llciB0
byBkZXBsb3kgdG8ganVzdCBoYXZlIHN0YW5kYXJkIFRvZXBsaXR6IGF2YWlsYWJsZSB3aXRob3V0
Cj4gPiBoYXZpbmcgdG8gY29tcGlsZSBhbmQgbG9hZCBhbiBlQlBGIHByb2dyYW0uCj4gPgo+ID4g
QXMgZm9yIHRoZSBza19idWZmIGFuZCBjYltdIGNoYW5nZXMuIFRoZSBmaXJzdCBpcyByZWFsbHkg
bm90IG5lZWRlZC4KPiA+IHNrX2J1ZmYgc2ltcGx5IHdvdWxkIG5vdCBzY2FsZSBpZiBldmVyeSBl
ZGdlIGNhc2UgbmVlZHMgYSBmZXcgYml0cy4KPgo+IEFuIGFsdGVybmF0aXZlIGlzIHRvIG1vdmUg
dGhlIGJpdCB0byBjYltdIGFuZCBjbGVhciBpdCBmb3IgZXZlcnkgY29kZQo+IHBhdGhzIHRoYXQg
bGVhZCB0byBuZG9fc3RhcnRfeG1pdCgpLCBidXQgSSdtIHdvcnJpZWQgdGhhdCBpdCBpcyBlcnJv
ci1wcm9uZS4KPgo+IEkgdGhpbmsgd2UgY2FuIHB1dCB0aGUgYml0IGluIHNrX2J1ZmYgZm9yIG5v
dy4gV2UgY2FuIGltcGxlbWVudCB0aGUKPiBhbHRlcm5hdGl2ZSB3aGVuIHdlIGFyZSBzaG9ydCBv
ZiBiaXRzLgoKSSBkaXNhZ3JlZS4gc2tfYnVmZiBmaWVsZHMgYWRkIGEgY29zdCB0byBldmVyeSBj
b2RlIHBhdGguIFRoZXkgY2Fubm90CmJlIGFkZGVkIGZvciBldmVyeSBlZGdlIGNhc2UuCj4KPiA+
Cj4gPiBGb3IgdGhlIGNvbnRyb2wgYmxvY2ssIGdlbmVyYWxseSBpdCBpcyBub3Qgc2FmZSB0byB1
c2UgdGhhdCBhY3Jvc3MKPiA+IGxheWVycy4gSW4gdGhpcyBjYXNlLCBiZXR3ZWVuIHFkaXNjIGVu
cXVldWUgb2YgYSBnaXZlbiBkZXZpY2UgYW5kCj4gPiBuZG9fc3RhcnRfeG1pdCBvZiB0aGF0IGRl
dmljZSwgSSBzdXBwb3NlIGl0IGlzLiBUaG91Z2ggdW5jb21tb24uIEkKPiA+IHdvbmRlciBpZiB0
aGVyZSBpcyBhbnkgcHJlY2VkZW50Lgo+Cj4gVGhhdCdzIG9uZSBvZiB0aGUgcmVhc29ucyBtb2Rp
ZnlpbmcgcWRpc2Nfc2tiX2NiIGluc3RlYWQgb2YgY3JlYXRpbmcKPiBhbm90aGVyIHN0cnVjdCBl
bWJlZGRpbmcgaXQgYXMgYnBmX3NrYl9kYXRhX2VuZCBhbmQgdGNfc2tiX2NiIGRvLiBUaGlzCj4g
Y2xhcmlmaWVzIHRoYXQgaXQgaXMgcWRpc2MncyByZXNwb25zaWJpbGl0eSB0byBrZWVwIHRoZXNl
IGRhdGEgaW50YWN0Lgo+Cj4gPgo+ID4gVGhlIGRhdGEgd2lsbCBoYXZlIHRvIGJlIHN0b3JlZCBp
biB0aGUgc2tiIHNvbWV3aGVyZS4gQSBzaW1wbGVyIG9wdGlvbgo+ID4gaXMganVzdCBza2ItPmhh
c2g/IFRoaXMgY29kZSB3b3VsZCB1c2Ugc2tiX2dldF9oYXNoLCBpZiBpdCB3b3VsZAo+ID4gYWx3
YXlzIHByb2R1Y2UgYSBUb2VwbGl0eiBoYXNoLCBhbnl3YXkuCj4KPiBXZSBzdGlsbCBuZWVkIHR1
bl92bmV0X2hhc2hfcmVwb3J0IHRvIGlkZW50aWZ5IGhhc2ggdHlwZS4KPgo+IHNrYl9nZXRfaGFz
aCgpIHVzZXMgU2lwaGFzaCBpbnN0ZWFkIG9mIFRvZXBsaXR6LCBhbmQgdGhlIGNvbmZpZ3VyYXRp
b24KPiBvZiBUb2VwbGl0eiByZWxpZXMgb24gdHVuJ3MgaW50ZXJuYWwgc3RhdGUuIEl0IGlzIHN0
aWxsIHBvc3NpYmxlIHRvCj4gc3RvcmUgYSBoYXNoIGNhbGN1bGF0ZWQgd2l0aCB0dW4ncyBvd24g
bG9naWMgdG8gc2tiLT5oYXNoLCBidXQgc29tZW9uZQo+IG1heSBsYXRlciBvdmVyd3JpdGUgaXQg
d2l0aCBfX3NrYl9nZXRfaGFzaCgpIHRob3VnaCBpdCdzIHVubGlrZWx5LgoKVGhhdCB3b24ndCBo
YXBwZW4gaW4gdGhpcyBkYXRhIHBhdGguCgpGYWlyIHBvaW50IG9uIHRoZSBoYXNoIHR5cGUuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
