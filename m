Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515ECE95A82
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 20:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBBCA60EF6;
	Sun,  8 Oct 2023 20:09:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBBCA60EF6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Nxxua2jz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hInVXHnqdy8z; Sun,  8 Oct 2023 20:09:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 265B360C15;
	Sun,  8 Oct 2023 20:09:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 265B360C15
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AAB3C0039;
	Sun,  8 Oct 2023 20:09:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDFF6C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 20:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0EED60DCB
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 20:09:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C0EED60DCB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u96fRMr1W4X4
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 20:09:20 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1E7760C15
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 20:09:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1E7760C15
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7abcef80a82so1465042241.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Oct 2023 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696795758; x=1697400558;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKzbBuqUCPwy23ymUT8eWLppkGLME/yOaopQNwUxG30=;
 b=Nxxua2jzhT/eeyMReH3gD3fLesGNYPfuO8lao9jL+eXuriaHy9GXQICBrpJQeBU4OG
 Ykuhtu1vXwe99pI3mEb6m0FplNaYOqGWfRiZqvbVN1mtMLljoTUpHONbhmfdi0BEooVC
 BIcB7YsN5PSkBsO9FZtXeGD3R9bXm9iMxktS8K5+GaNK3/9NPQAsLA/yZAS05Ixb5EJX
 fNbSX1Ykxqz2do6yv4m0lIlcJWJO59FNU1xketxlaRROtNKIm/hBQ7iZH7VnICc0oh07
 HTwv0vNApUoHfQ4+boOVBCAY9LqhvDye3JkZDFTFBSJn/l6siyVM0D6tEtBOA4hx2hUM
 id1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696795758; x=1697400558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKzbBuqUCPwy23ymUT8eWLppkGLME/yOaopQNwUxG30=;
 b=iO8zaKqeOJUd7I2u9M8OcoUhMtZzqS79SZcjY3jmve7VYvcQNLhtvXpvO6E1gswXPL
 9S+dhorOUo+uNoM+S3WLqxpDzEYTfXjV1z3MfC6KTrPzBWqvmcy2wut4W6CCZ6kiwuZY
 oOyj9AIFmkwhqhGN1iwHUaWpIoQJQUOGbls2dTZR9xpbLWCjsuXwiwpNwWuDNQJM919x
 7dD3fmbvsFmxIeMT6QZJmzRo3k7lSteHwQYvxdhzEBdrB+c8eF8jqxI1PqP1TOz2C9gJ
 YeBnBqE0Vlq6iHmfHP1/MnfQdAcDSqgtGRWmMvLQUMywyNFD+F7i7idKyQZx0Tpi2IXG
 93jg==
X-Gm-Message-State: AOJu0YxKH+DtUzvcqKh3BRtyX4butdsMNcPMughVI23PfktiLLm015e5
 X0VBBqJJT0O6CoNGViKlFsxnYOvgG/cFNGvyl/Q=
X-Google-Smtp-Source: AGHT+IGrYlgQ6F5EY0bVUrDd7waD3CZx2805a119uOAlNTL7Tqx04UAkUDYuRhHdWSoQ7JP98oJjlRy68sXaAxl/L7Y=
X-Received: by 2002:a1f:ed41:0:b0:495:dcd0:471 with SMTP id
 l62-20020a1fed41000000b00495dcd00471mr10732498vkh.5.1696795758506; Sun, 08
 Oct 2023 13:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com>
In-Reply-To: <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 8 Oct 2023 22:08:41 +0200
Message-ID: <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
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

T24gU3VuLCBPY3QgOCwgMjAyMyBhdCAxMDowNOKAr1BNIEFraWhpa28gT2Rha2kgPGFraWhpa28u
b2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4KPiBPbiAyMDIzLzEwLzA5IDQ6MDcsIFdpbGxlbSBk
ZSBCcnVpam4gd3JvdGU6Cj4gPiBPbiBTdW4sIE9jdCA4LCAyMDIzIGF0IDc6MjLigK9BTSBBa2lo
aWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gdmly
dGlvLW5ldCBoYXZlIHR3byB1c2FnZSBvZiBoYXNoZXM6IG9uZSBpcyBSU1MgYW5kIGFub3RoZXIg
aXMgaGFzaAo+ID4+IHJlcG9ydGluZy4gQ29udmVudGlvbmFsbHkgdGhlIGhhc2ggY2FsY3VsYXRp
b24gd2FzIGRvbmUgYnkgdGhlIFZNTS4KPiA+PiBIb3dldmVyLCBjb21wdXRpbmcgdGhlIGhhc2gg
YWZ0ZXIgdGhlIHF1ZXVlIHdhcyBjaG9zZW4gZGVmZWF0cyB0aGUKPiA+PiBwdXJwb3NlIG9mIFJT
Uy4KPiA+Pgo+ID4+IEFub3RoZXIgYXBwcm9hY2ggaXMgdG8gdXNlIGVCUEYgc3RlZXJpbmcgcHJv
Z3JhbS4gVGhpcyBhcHByb2FjaCBoYXMKPiA+PiBhbm90aGVyIGRvd25zaWRlOiBpdCBjYW5ub3Qg
cmVwb3J0IHRoZSBjYWxjdWxhdGVkIGhhc2ggZHVlIHRvIHRoZQo+ID4+IHJlc3RyaWN0aXZlIG5h
dHVyZSBvZiBlQlBGLgo+ID4+Cj4gPj4gSW50cm9kdWNlIHRoZSBjb2RlIHRvIGNvbXB1dGUgaGFz
aGVzIHRvIHRoZSBrZXJuZWwgaW4gb3JkZXIgdG8gb3ZlcmNvbWUKPiA+PiB0aHNlIGNoYWxsZW5n
ZXMuIEFuIGFsdGVybmF0aXZlIHNvbHV0aW9uIGlzIHRvIGV4dGVuZCB0aGUgZUJQRiBzdGVlcmlu
Zwo+ID4+IHByb2dyYW0gc28gdGhhdCBpdCB3aWxsIGJlIGFibGUgdG8gcmVwb3J0IHRvIHRoZSB1
c2Vyc3BhY2UsIGJ1dCBpdCBtYWtlcwo+ID4+IGxpdHRsZSBzZW5zZSB0byBhbGxvdyB0byBpbXBs
ZW1lbnQgZGlmZmVyZW50IGhhc2hpbmcgYWxnb3JpdGhtcyB3aXRoCj4gPj4gZUJQRiBzaW5jZSB0
aGUgaGFzaCB2YWx1ZSByZXBvcnRlZCBieSB2aXJ0aW8tbmV0IGlzIHN0cmljdGx5IGRlZmluZWQg
YnkKPiA+PiB0aGUgc3BlY2lmaWNhdGlvbi4KPiA+Pgo+ID4+IFRoZSBoYXNoIHZhbHVlIGFscmVh
ZHkgc3RvcmVkIGluIHNrX2J1ZmYgaXMgbm90IHVzZWQgYW5kIGNvbXB1dGVkCj4gPj4gaW5kZXBl
bmRlbnRseSBzaW5jZSBpdCBtYXkgaGF2ZSBiZWVuIGNvbXB1dGVkIGluIGEgd2F5IG5vdCBjb25m
b3JtYW50Cj4gPj4gd2l0aCB0aGUgc3BlY2lmaWNhdGlvbi4KPiA+Pgo+ID4+IFNpZ25lZC1vZmYt
Ynk6IEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4KPiA+PiAtLS0KPiA+
Cj4gPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgdHVuX3ZuZXRfaGFzaF9jYXAgdHVuX3ZuZXRfaGFz
aF9jYXAgPSB7Cj4gPj4gKyAgICAgICAubWF4X2luZGlyZWN0aW9uX3RhYmxlX2xlbmd0aCA9Cj4g
Pj4gKyAgICAgICAgICAgICAgIFRVTl9WTkVUX0hBU0hfTUFYX0lORElSRUNUSU9OX1RBQkxFX0xF
TkdUSCwKPiA+PiArCj4gPj4gKyAgICAgICAudHlwZXMgPSBWSVJUSU9fTkVUX1NVUFBPUlRFRF9I
QVNIX1RZUEVTCj4gPj4gK307Cj4gPgo+ID4gTm8gbmVlZCB0byBoYXZlIGV4cGxpY2l0IGNhcGFi
aWxpdGllcyBleGNoYW5nZSBsaWtlIHRoaXM/IFR1biBlaXRoZXIKPiA+IHN1cHBvcnRzIGFsbCBv
ciBub25lLgo+Cj4gdHVuIGRvZXMgbm90IHN1cHBvcnQgVklSVElPX05FVF9SU1NfSEFTSF9UWVBF
X0lQX0VYLAo+IFZJUlRJT19ORVRfUlNTX0hBU0hfVFlQRV9UQ1BfRVgsIGFuZCBWSVJUSU9fTkVU
X1JTU19IQVNIX1RZUEVfVURQX0VYLgo+Cj4gSXQgaXMgYmVjYXVzZSB0aGUgZmxvdyBkaXNzZWN0
b3IgZG9lcyBub3Qgc3VwcG9ydCBJUHY2IGV4dGVuc2lvbnMuIFRoZQo+IHNwZWNpZmljYXRpb24g
aXMgYWxzbyB2YWd1ZSwgYW5kIGRvZXMgbm90IHRlbGwgaG93IG1hbnkgVExWcyBzaG91bGQgYmUK
PiBjb25zdW1lZCBhdCBtb3N0IHdoZW4gaW50ZXJwcmV0aW5nIGRlc3RpbmF0aW9uIG9wdGlvbiBo
ZWFkZXIgc28gSSBjaG9zZQo+IHRvIGF2b2lkIGFkZGluZyBjb2RlIGZvciB0aGVzZSBoYXNoIHR5
cGVzIHRvIHRoZSBmbG93IGRpc3NlY3Rvci4gSSBkb3VidAo+IGFueW9uZSB3aWxsIGNvbXBsYWlu
IGFib3V0IGl0IHNpbmNlIG5vYm9keSBjb21wbGFpbnMgZm9yIExpbnV4Lgo+Cj4gSSdtIGFsc28g
YWRkaW5nIHRoaXMgc28gdGhhdCB3ZSBjYW4gZXh0ZW5kIGl0IGxhdGVyLgo+IG1heF9pbmRpcmVj
dGlvbl90YWJsZV9sZW5ndGggbWF5IGdyb3cgZm9yIHN5c3RlbXMgd2l0aCAxMjgrIENQVXMsIG9y
Cj4gdHlwZXMgbWF5IGhhdmUgb3RoZXIgYml0cyBmb3IgbmV3IHByb3RvY29scyBpbiB0aGUgZnV0
dXJlLgo+Cj4gPgo+ID4+ICAgICAgICAgIGNhc2UgVFVOU0VUU1RFRVJJTkdFQlBGOgo+ID4+IC0g
ICAgICAgICAgICAgICByZXQgPSB0dW5fc2V0X2VicGYodHVuLCAmdHVuLT5zdGVlcmluZ19wcm9n
LCBhcmdwKTsKPiA+PiArICAgICAgICAgICAgICAgYnBmX3JldCA9IHR1bl9zZXRfZWJwZih0dW4s
ICZ0dW4tPnN0ZWVyaW5nX3Byb2csIGFyZ3ApOwo+ID4+ICsgICAgICAgICAgICAgICBpZiAoSVNf
RVJSKGJwZl9yZXQpKQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIo
YnBmX3JldCk7Cj4gPj4gKyAgICAgICAgICAgICAgIGVsc2UgaWYgKGJwZl9yZXQpCj4gPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgdHVuLT52bmV0X2hhc2guZmxhZ3MgJj0gflRVTl9WTkVUX0hB
U0hfUlNTOwo+ID4KPiA+IERvbid0IG1ha2Ugb25lIGZlYXR1cmUgZGlzYWJsZSBhbm90aGVyLgo+
ID4KPiA+IFRVTlNFVFNURUVSSU5HRUJQRiBhbmQgVFVOU0VUVk5FVEhBU0ggYXJlIG11dHVhbGx5
IGV4Y2x1c2l2ZQo+ID4gZnVuY3Rpb25zLiBJZiBvbmUgaXMgZW5hYmxlZCB0aGUgb3RoZXIgY2Fs
bCBzaG91bGQgZmFpbCwgd2l0aCBFQlVTWQo+ID4gZm9yIGluc3RhbmNlLgo+ID4KPiA+PiArICAg
ICAgIGNhc2UgVFVOU0VUVk5FVEhBU0g6Cj4gPj4gKyAgICAgICAgICAgICAgIGxlbiA9IHNpemVv
Zih2bmV0X2hhc2gpOwo+ID4+ICsgICAgICAgICAgICAgICBpZiAoY29weV9mcm9tX3VzZXIoJnZu
ZXRfaGFzaCwgYXJncCwgbGVuKSkgewo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9
IC1FRkFVTFQ7Cj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4gKyAgICAg
ICAgICAgICAgIH0KPiA+PiArCj4gPj4gKyAgICAgICAgICAgICAgIGlmICgoKHZuZXRfaGFzaC5m
bGFncyAmIFRVTl9WTkVUX0hBU0hfUkVQT1JUKSAmJgo+ID4+ICsgICAgICAgICAgICAgICAgICAg
ICh0dW4tPnZuZXRfaGRyX3N6IDwgc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl92MV9oYXNo
KSB8fAo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAhdHVuX2lzX2xpdHRsZV9lbmRpYW4odHVu
KSkpIHx8Cj4gPj4gKyAgICAgICAgICAgICAgICAgICAgdm5ldF9oYXNoLmluZGlyZWN0aW9uX3Rh
YmxlX21hc2sgPj0KPiA+PiArICAgICAgICAgICAgICAgICAgICBUVU5fVk5FVF9IQVNIX01BWF9J
TkRJUkVDVElPTl9UQUJMRV9MRU5HVEgpIHsKPiA+PiArICAgICAgICAgICAgICAgICAgICAgICBy
ZXQgPSAtRUlOVkFMOwo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4+ICsg
ICAgICAgICAgICAgICB9Cj4gPj4gKwo+ID4+ICsgICAgICAgICAgICAgICBhcmdwID0gKHU4IF9f
dXNlciAqKWFyZ3AgKyBsZW47Cj4gPj4gKyAgICAgICAgICAgICAgIGxlbiA9ICh2bmV0X2hhc2gu
aW5kaXJlY3Rpb25fdGFibGVfbWFzayArIDEpICogMjsKPiA+PiArICAgICAgICAgICAgICAgaWYg
KGNvcHlfZnJvbV91c2VyKHZuZXRfaGFzaF9pbmRpcmVjdGlvbl90YWJsZSwgYXJncCwgbGVuKSkg
ewo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7Cj4gPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4gKyAgICAgICAgICAgICAgIH0KPiA+PiArCj4g
Pj4gKyAgICAgICAgICAgICAgIGFyZ3AgPSAodTggX191c2VyICopYXJncCArIGxlbjsKPiA+PiAr
ICAgICAgICAgICAgICAgbGVuID0gdmlydGlvX25ldF9oYXNoX2tleV9sZW5ndGgodm5ldF9oYXNo
LnR5cGVzKTsKPiA+PiArCj4gPj4gKyAgICAgICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcih2
bmV0X2hhc2hfa2V5LCBhcmdwLCBsZW4pKSB7Cj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0ID0gLUVGQVVMVDsKPiA+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+PiAr
ICAgICAgICAgICAgICAgfQo+ID4KPiA+IFByb2JhYmx5IGVhc2llciBhbmQgbGVzcyBlcnJvci1w
cm9uZSB0byBkZWZpbmUgYSBmaXhlZCBzaXplIGNvbnRyb2wKPiA+IHN0cnVjdCB3aXRoIHRoZSBt
YXggaW5kaXJlY3Rpb24gdGFibGUgc2l6ZS4KPgo+IEkgbWFkZSBpdHMgc2l6ZSB2YXJpYWJsZSBi
ZWNhdXNlIHRoZSBpbmRpcmVjdGlvbiB0YWJsZSBhbmQga2V5IG1heSBncm93Cj4gaW4gdGhlIGZ1
dHVyZSBhcyBJIHdyb3RlIGFib3ZlLgo+Cj4gPgo+ID4gQnR3OiBwbGVhc2UgdHJpbSB0aGUgQ0M6
IGxpc3QgY29uc2lkZXJhYmx5IG9uIGZ1dHVyZSBwYXRjaGVzLgo+Cj4gSSdsbCBkbyBzbyBpbiB0
aGUgbmV4dCB2ZXJzaW9uIHdpdGggdGhlIFRVTlNFVFNURUVSSU5HRUJQRiBjaGFuZ2UgeW91Cj4g
cHJvcG9zZWQuCgpUbyBiZSBjbGVhcjogcGxlYXNlIGRvbid0IGp1c3QgcmVzdWJtaXQgd2l0aCB0
aGF0IG9uZSBjaGFuZ2UuCgpUaGUgc2tiIGFuZCBjYiBpc3N1ZXMgYXJlIHF1aXRlIGZ1bmRhbWVu
dGFsIGlzc3VlcyB0aGF0IG5lZWQgdG8gYmUgcmVzb2x2ZWQuCgpJJ2QgbGlrZSB0byB1bmRlcnN0
YW5kIHdoeSBhZGp1c3RpbmcgdGhlIGV4aXN0aW5nIEJQRiBmZWF0dXJlIGZvciB0aGlzCmV4YWN0
IHB1cnBvc2UgY2Fubm90IGJlIGFtZW5kZWQgdG8gcmV0dXJuIHRoZSBrZXkgaXQgcHJvZHVjZWQu
CgpBcyB5b3UgcG9pbnQgb3V0LCB0aGUgQyBmbG93IGRpc3NlY3RvciBpcyBpbnN1ZmZpY2llbnQu
IFRoZSBCUEYgZmxvdwpkaXNzZWN0b3IgZG9lcyBub3QgaGF2ZSB0aGlzIHByb2JsZW0uIFRoZSBz
YW1lIGFyZ3VtZW50IHdvdWxkIGdvIGZvcgp0aGUgcHJlLWV4aXN0aW5nIEJQRiBzdGVlcmluZyBw
cm9ncmFtLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
