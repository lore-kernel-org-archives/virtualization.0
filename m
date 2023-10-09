Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B61E95A91
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 08:05:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 96A4640151;
	Mon,  9 Oct 2023 08:05:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 96A4640151
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UNulXyqP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ogCOqFdOMIf; Mon,  9 Oct 2023 08:05:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CF81140144;
	Mon,  9 Oct 2023 08:05:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF81140144
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A07B7C0039;
	Mon,  9 Oct 2023 08:05:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84100C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 08:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C9DA4049F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 08:05:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C9DA4049F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=UNulXyqP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 40r-o9BgfLit
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 08:05:16 +0000 (UTC)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1FEC2401E3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 08:05:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1FEC2401E3
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-45456121514so1859230137.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696838715; x=1697443515;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ti/HWPE0cWzwTmuERRmavIjosKwcUVbmnHFfLYzgBc=;
 b=UNulXyqPcOGx4hFP84s4NXOR/Y2Xbv5pqxKa6qw1ezQBdbG6tq1Q5sBJAiMED+EnJj
 +22YbdZv4D3/E5gZxuLam/dgoKf50dqDrfcvL1Sa/v3LjJ6hjf9oK99RcExDWdjQuufG
 briwW7SEG5es4DjS55S+5nEqW8/3l6+pnIsf1mX8vYTpqEfmdGWYZsdaGMY/1anVcteL
 Vlr9XuK0L3qF2GhTYE+oSbl8KbKp0EA80YRIi4cJUw2dBfgVkLG/PdMr4pR16oyXk8aB
 s+PN0Fj6PVPMjtAA1kilaZjinyFMCxY0UQ+zv8xTZNhEEp3XoWEe0aPkhkGFAyONfJHg
 ul4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696838715; x=1697443515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ti/HWPE0cWzwTmuERRmavIjosKwcUVbmnHFfLYzgBc=;
 b=Blt5e95ey66Zk+Dq4lTZTz7g6hhqSIaRwRX1fEUu0gggPAOobNsIKDbmyuEbIyuyiW
 r9p1ltqKdC0McaPLlhePbp8FQKEZxhurGjYhPdQJgOc4hIp8fQWbCjRp6A2fWpBZRLY3
 2a6f5oGEDY7quzh2eVdnigu+gHgypVhmjP+bnCgJPUABTWdxapGLb9+59z40XE0D0LgO
 Fu1AoaX4VG/M2lBdMLYWqjRTmwB2acaFZ2fmYl36L077qr9E1rKfbwF5S1lWfKOElDYL
 I9rfWcsOSWAY5g0iu6pGBdlwbOPlTz+12Jn1V5MDDCTNB/Cl8y+Jrsp75XyDGxVgyzFc
 csRQ==
X-Gm-Message-State: AOJu0YxfIW+KpsV3qtCcTyd7PjbkEhjZWMY64ISVrmJyaILDgOXW1+w+
 CaxAIb8BeHG46nMVMfFzaq17uHjfuGNc4JPqkWM=
X-Google-Smtp-Source: AGHT+IH9+0duN/DwJjTcz6PvfXQkVycNSPtz3xjugo2P/Xn5/hpapbonbt+oqUiI8Gfbij3OwxzuDU9Lm7C6lPyTWNg=
X-Received: by 2002:a67:bb06:0:b0:44e:9674:7781 with SMTP id
 m6-20020a67bb06000000b0044e96747781mr13044529vsn.15.1696838714812; Mon, 09
 Oct 2023 01:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com>
 <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com>
 <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
 <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com>
In-Reply-To: <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 9 Oct 2023 03:04:37 -0500
Message-ID: <CAF=yD-+syCSJz_wp25rEaHTXMFRHgLh1M-uTdNWPb4fnrKgpFw@mail.gmail.com>
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

T24gU3VuLCBPY3QgOCwgMjAyMyBhdCAzOjQ24oCvUE0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5v
ZGFraUBkYXluaXguY29tPiB3cm90ZToKPgo+IE9uIDIwMjMvMTAvMDkgNTowOCwgV2lsbGVtIGRl
IEJydWlqbiB3cm90ZToKPiA+IE9uIFN1biwgT2N0IDgsIDIwMjMgYXQgMTA6MDTigK9QTSBBa2lo
aWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gT24g
MjAyMy8xMC8wOSA0OjA3LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4+PiBPbiBTdW4sIE9j
dCA4LCAyMDIzIGF0IDc6MjLigK9BTSBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5p
eC5jb20+IHdyb3RlOgo+ID4+Pj4KPiA+Pj4+IHZpcnRpby1uZXQgaGF2ZSB0d28gdXNhZ2Ugb2Yg
aGFzaGVzOiBvbmUgaXMgUlNTIGFuZCBhbm90aGVyIGlzIGhhc2gKPiA+Pj4+IHJlcG9ydGluZy4g
Q29udmVudGlvbmFsbHkgdGhlIGhhc2ggY2FsY3VsYXRpb24gd2FzIGRvbmUgYnkgdGhlIFZNTS4K
PiA+Pj4+IEhvd2V2ZXIsIGNvbXB1dGluZyB0aGUgaGFzaCBhZnRlciB0aGUgcXVldWUgd2FzIGNo
b3NlbiBkZWZlYXRzIHRoZQo+ID4+Pj4gcHVycG9zZSBvZiBSU1MuCj4gPj4+Pgo+ID4+Pj4gQW5v
dGhlciBhcHByb2FjaCBpcyB0byB1c2UgZUJQRiBzdGVlcmluZyBwcm9ncmFtLiBUaGlzIGFwcHJv
YWNoIGhhcwo+ID4+Pj4gYW5vdGhlciBkb3duc2lkZTogaXQgY2Fubm90IHJlcG9ydCB0aGUgY2Fs
Y3VsYXRlZCBoYXNoIGR1ZSB0byB0aGUKPiA+Pj4+IHJlc3RyaWN0aXZlIG5hdHVyZSBvZiBlQlBG
Lgo+ID4+Pj4KPiA+Pj4+IEludHJvZHVjZSB0aGUgY29kZSB0byBjb21wdXRlIGhhc2hlcyB0byB0
aGUga2VybmVsIGluIG9yZGVyIHRvIG92ZXJjb21lCj4gPj4+PiB0aHNlIGNoYWxsZW5nZXMuIEFu
IGFsdGVybmF0aXZlIHNvbHV0aW9uIGlzIHRvIGV4dGVuZCB0aGUgZUJQRiBzdGVlcmluZwo+ID4+
Pj4gcHJvZ3JhbSBzbyB0aGF0IGl0IHdpbGwgYmUgYWJsZSB0byByZXBvcnQgdG8gdGhlIHVzZXJz
cGFjZSwgYnV0IGl0IG1ha2VzCj4gPj4+PiBsaXR0bGUgc2Vuc2UgdG8gYWxsb3cgdG8gaW1wbGVt
ZW50IGRpZmZlcmVudCBoYXNoaW5nIGFsZ29yaXRobXMgd2l0aAo+ID4+Pj4gZUJQRiBzaW5jZSB0
aGUgaGFzaCB2YWx1ZSByZXBvcnRlZCBieSB2aXJ0aW8tbmV0IGlzIHN0cmljdGx5IGRlZmluZWQg
YnkKPiA+Pj4+IHRoZSBzcGVjaWZpY2F0aW9uLgo+ID4+Pj4KPiA+Pj4+IFRoZSBoYXNoIHZhbHVl
IGFscmVhZHkgc3RvcmVkIGluIHNrX2J1ZmYgaXMgbm90IHVzZWQgYW5kIGNvbXB1dGVkCj4gPj4+
PiBpbmRlcGVuZGVudGx5IHNpbmNlIGl0IG1heSBoYXZlIGJlZW4gY29tcHV0ZWQgaW4gYSB3YXkg
bm90IGNvbmZvcm1hbnQKPiA+Pj4+IHdpdGggdGhlIHNwZWNpZmljYXRpb24uCj4gPj4+Pgo+ID4+
Pj4gU2lnbmVkLW9mZi1ieTogQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29t
Pgo+ID4+Pj4gLS0tCj4gPj4+Cj4gPj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCB0dW5fdm5ldF9o
YXNoX2NhcCB0dW5fdm5ldF9oYXNoX2NhcCA9IHsKPiA+Pj4+ICsgICAgICAgLm1heF9pbmRpcmVj
dGlvbl90YWJsZV9sZW5ndGggPQo+ID4+Pj4gKyAgICAgICAgICAgICAgIFRVTl9WTkVUX0hBU0hf
TUFYX0lORElSRUNUSU9OX1RBQkxFX0xFTkdUSCwKPiA+Pj4+ICsKPiA+Pj4+ICsgICAgICAgLnR5
cGVzID0gVklSVElPX05FVF9TVVBQT1JURURfSEFTSF9UWVBFUwo+ID4+Pj4gK307Cj4gPj4+Cj4g
Pj4+IE5vIG5lZWQgdG8gaGF2ZSBleHBsaWNpdCBjYXBhYmlsaXRpZXMgZXhjaGFuZ2UgbGlrZSB0
aGlzPyBUdW4gZWl0aGVyCj4gPj4+IHN1cHBvcnRzIGFsbCBvciBub25lLgo+ID4+Cj4gPj4gdHVu
IGRvZXMgbm90IHN1cHBvcnQgVklSVElPX05FVF9SU1NfSEFTSF9UWVBFX0lQX0VYLAo+ID4+IFZJ
UlRJT19ORVRfUlNTX0hBU0hfVFlQRV9UQ1BfRVgsIGFuZCBWSVJUSU9fTkVUX1JTU19IQVNIX1RZ
UEVfVURQX0VYLgo+ID4+Cj4gPj4gSXQgaXMgYmVjYXVzZSB0aGUgZmxvdyBkaXNzZWN0b3IgZG9l
cyBub3Qgc3VwcG9ydCBJUHY2IGV4dGVuc2lvbnMuIFRoZQo+ID4+IHNwZWNpZmljYXRpb24gaXMg
YWxzbyB2YWd1ZSwgYW5kIGRvZXMgbm90IHRlbGwgaG93IG1hbnkgVExWcyBzaG91bGQgYmUKPiA+
PiBjb25zdW1lZCBhdCBtb3N0IHdoZW4gaW50ZXJwcmV0aW5nIGRlc3RpbmF0aW9uIG9wdGlvbiBo
ZWFkZXIgc28gSSBjaG9zZQo+ID4+IHRvIGF2b2lkIGFkZGluZyBjb2RlIGZvciB0aGVzZSBoYXNo
IHR5cGVzIHRvIHRoZSBmbG93IGRpc3NlY3Rvci4gSSBkb3VidAo+ID4+IGFueW9uZSB3aWxsIGNv
bXBsYWluIGFib3V0IGl0IHNpbmNlIG5vYm9keSBjb21wbGFpbnMgZm9yIExpbnV4Lgo+ID4+Cj4g
Pj4gSSdtIGFsc28gYWRkaW5nIHRoaXMgc28gdGhhdCB3ZSBjYW4gZXh0ZW5kIGl0IGxhdGVyLgo+
ID4+IG1heF9pbmRpcmVjdGlvbl90YWJsZV9sZW5ndGggbWF5IGdyb3cgZm9yIHN5c3RlbXMgd2l0
aCAxMjgrIENQVXMsIG9yCj4gPj4gdHlwZXMgbWF5IGhhdmUgb3RoZXIgYml0cyBmb3IgbmV3IHBy
b3RvY29scyBpbiB0aGUgZnV0dXJlLgo+ID4+Cj4gPj4+Cj4gPj4+PiAgICAgICAgICAgY2FzZSBU
VU5TRVRTVEVFUklOR0VCUEY6Cj4gPj4+PiAtICAgICAgICAgICAgICAgcmV0ID0gdHVuX3NldF9l
YnBmKHR1biwgJnR1bi0+c3RlZXJpbmdfcHJvZywgYXJncCk7Cj4gPj4+PiArICAgICAgICAgICAg
ICAgYnBmX3JldCA9IHR1bl9zZXRfZWJwZih0dW4sICZ0dW4tPnN0ZWVyaW5nX3Byb2csIGFyZ3Ap
Owo+ID4+Pj4gKyAgICAgICAgICAgICAgIGlmIChJU19FUlIoYnBmX3JldCkpCj4gPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKGJwZl9yZXQpOwo+ID4+Pj4gKyAgICAg
ICAgICAgICAgIGVsc2UgaWYgKGJwZl9yZXQpCj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICB0dW4tPnZuZXRfaGFzaC5mbGFncyAmPSB+VFVOX1ZORVRfSEFTSF9SU1M7Cj4gPj4+Cj4gPj4+
IERvbid0IG1ha2Ugb25lIGZlYXR1cmUgZGlzYWJsZSBhbm90aGVyLgo+ID4+Pgo+ID4+PiBUVU5T
RVRTVEVFUklOR0VCUEYgYW5kIFRVTlNFVFZORVRIQVNIIGFyZSBtdXR1YWxseSBleGNsdXNpdmUK
PiA+Pj4gZnVuY3Rpb25zLiBJZiBvbmUgaXMgZW5hYmxlZCB0aGUgb3RoZXIgY2FsbCBzaG91bGQg
ZmFpbCwgd2l0aCBFQlVTWQo+ID4+PiBmb3IgaW5zdGFuY2UuCj4gPj4+Cj4gPj4+PiArICAgICAg
IGNhc2UgVFVOU0VUVk5FVEhBU0g6Cj4gPj4+PiArICAgICAgICAgICAgICAgbGVuID0gc2l6ZW9m
KHZuZXRfaGFzaCk7Cj4gPj4+PiArICAgICAgICAgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKCZ2
bmV0X2hhc2gsIGFyZ3AsIGxlbikpIHsKPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJl
dCA9IC1FRkFVTFQ7Cj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+Pj4+
ICsgICAgICAgICAgICAgICB9Cj4gPj4+PiArCj4gPj4+PiArICAgICAgICAgICAgICAgaWYgKCgo
dm5ldF9oYXNoLmZsYWdzICYgVFVOX1ZORVRfSEFTSF9SRVBPUlQpICYmCj4gPj4+PiArICAgICAg
ICAgICAgICAgICAgICAodHVuLT52bmV0X2hkcl9zeiA8IHNpemVvZihzdHJ1Y3QgdmlydGlvX25l
dF9oZHJfdjFfaGFzaCkgfHwKPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAhdHVuX2lzX2xp
dHRsZV9lbmRpYW4odHVuKSkpIHx8Cj4gPj4+PiArICAgICAgICAgICAgICAgICAgICB2bmV0X2hh
c2guaW5kaXJlY3Rpb25fdGFibGVfbWFzayA+PQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAg
VFVOX1ZORVRfSEFTSF9NQVhfSU5ESVJFQ1RJT05fVEFCTEVfTEVOR1RIKSB7Cj4gPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOwo+ID4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7Cj4gPj4+PiArICAgICAgICAgICAgICAgfQo+ID4+Pj4gKwo+ID4+Pj4g
KyAgICAgICAgICAgICAgIGFyZ3AgPSAodTggX191c2VyICopYXJncCArIGxlbjsKPiA+Pj4+ICsg
ICAgICAgICAgICAgICBsZW4gPSAodm5ldF9oYXNoLmluZGlyZWN0aW9uX3RhYmxlX21hc2sgKyAx
KSAqIDI7Cj4gPj4+PiArICAgICAgICAgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKHZuZXRfaGFz
aF9pbmRpcmVjdGlvbl90YWJsZSwgYXJncCwgbGVuKSkgewo+ID4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0ID0gLUVGQVVMVDsKPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJy
ZWFrOwo+ID4+Pj4gKyAgICAgICAgICAgICAgIH0KPiA+Pj4+ICsKPiA+Pj4+ICsgICAgICAgICAg
ICAgICBhcmdwID0gKHU4IF9fdXNlciAqKWFyZ3AgKyBsZW47Cj4gPj4+PiArICAgICAgICAgICAg
ICAgbGVuID0gdmlydGlvX25ldF9oYXNoX2tleV9sZW5ndGgodm5ldF9oYXNoLnR5cGVzKTsKPiA+
Pj4+ICsKPiA+Pj4+ICsgICAgICAgICAgICAgICBpZiAoY29weV9mcm9tX3VzZXIodm5ldF9oYXNo
X2tleSwgYXJncCwgbGVuKSkgewo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0g
LUVGQVVMVDsKPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4+Pj4gKyAg
ICAgICAgICAgICAgIH0KPiA+Pj4KPiA+Pj4gUHJvYmFibHkgZWFzaWVyIGFuZCBsZXNzIGVycm9y
LXByb25lIHRvIGRlZmluZSBhIGZpeGVkIHNpemUgY29udHJvbAo+ID4+PiBzdHJ1Y3Qgd2l0aCB0
aGUgbWF4IGluZGlyZWN0aW9uIHRhYmxlIHNpemUuCj4gPj4KPiA+PiBJIG1hZGUgaXRzIHNpemUg
dmFyaWFibGUgYmVjYXVzZSB0aGUgaW5kaXJlY3Rpb24gdGFibGUgYW5kIGtleSBtYXkgZ3Jvdwo+
ID4+IGluIHRoZSBmdXR1cmUgYXMgSSB3cm90ZSBhYm92ZS4KPiA+Pgo+ID4+Pgo+ID4+PiBCdHc6
IHBsZWFzZSB0cmltIHRoZSBDQzogbGlzdCBjb25zaWRlcmFibHkgb24gZnV0dXJlIHBhdGNoZXMu
Cj4gPj4KPiA+PiBJJ2xsIGRvIHNvIGluIHRoZSBuZXh0IHZlcnNpb24gd2l0aCB0aGUgVFVOU0VU
U1RFRVJJTkdFQlBGIGNoYW5nZSB5b3UKPiA+PiBwcm9wb3NlZC4KPiA+Cj4gPiBUbyBiZSBjbGVh
cjogcGxlYXNlIGRvbid0IGp1c3QgcmVzdWJtaXQgd2l0aCB0aGF0IG9uZSBjaGFuZ2UuCj4gPgo+
ID4gVGhlIHNrYiBhbmQgY2IgaXNzdWVzIGFyZSBxdWl0ZSBmdW5kYW1lbnRhbCBpc3N1ZXMgdGhh
dCBuZWVkIHRvIGJlIHJlc29sdmVkLgo+ID4KPiA+IEknZCBsaWtlIHRvIHVuZGVyc3RhbmQgd2h5
IGFkanVzdGluZyB0aGUgZXhpc3RpbmcgQlBGIGZlYXR1cmUgZm9yIHRoaXMKPiA+IGV4YWN0IHB1
cnBvc2UgY2Fubm90IGJlIGFtZW5kZWQgdG8gcmV0dXJuIHRoZSBrZXkgaXQgcHJvZHVjZWQuCj4K
PiBlQlBGIHN0ZWVyaW5nIHByb2dyYW0gaXMgbm90IGRlc2lnbmVkIGZvciB0aGlzIHBhcnRpY3Vs
YXIgcHJvYmxlbSBpbiBteQo+IHVuZGVyc3RhbmRpbmcuIEl0IHdhcyBpbnRyb2R1Y2VkIHRvIGRl
cml2ZSBoYXNoIHZhbHVlcyB3aXRoIGFuCj4gdW5kZXJzdGFuZGluZyBvZiBhcHBsaWNhdGlvbi1z
cGVjaWZpYyBzZW1hbnRpY3Mgb2YgcGFja2V0cyBpbnN0ZWFkIG9mCj4gZ2VuZXJpYyBJUC9UQ1Av
VURQIHNlbWFudGljcy4KPgo+IFRoaXMgcHJvYmxlbSBpcyByYXRoZXIgZGlmZmVyZW50IGluIHRl
cm1zIHRoYXQgdGhlIGhhc2ggZGVyaXZhdGlvbiBpcwo+IHN0cmljdGx5IGRlZmluZWQgYnkgdmly
dGlvLW5ldC4gSSBkb24ndCB0aGluayBpdCBtYWtlcyBzZW5zZSB0bwo+IGludHJvZHVjZSB0aGUg
Y29tcGxleGl0eSBvZiBCUEYgd2hlbiB5b3UgYWx3YXlzIHJ1biB0aGUgc2FtZSBjb2RlLgo+Cj4g
SXQgY2FuIHV0aWxpemUgdGhlIGV4aXN0aW5nIGZsb3cgZGlzc2VjdG9yIGFuZCBhbHNvIG1ha2Ug
aXQgZWFzaWVyIHRvCj4gdXNlIGZvciB0aGUgdXNlcnNwYWNlIGJ5IGltcGxlbWVudGluZyB0aGlz
IGluIHRoZSBrZXJuZWwuCgpPay4gVGhlcmUgZG9lcyBhcHBlYXIgdG8gYmUgb3ZlcmxhcCBpbiBm
dW5jdGlvbmFsaXR5LiBCdXQgaXQgbWlnaHQgYmUKZWFzaWVyIHRvIGRlcGxveSB0byBqdXN0IGhh
dmUgc3RhbmRhcmQgVG9lcGxpdHogYXZhaWxhYmxlIHdpdGhvdXQKaGF2aW5nIHRvIGNvbXBpbGUg
YW5kIGxvYWQgYW4gZUJQRiBwcm9ncmFtLgoKQXMgZm9yIHRoZSBza19idWZmIGFuZCBjYltdIGNo
YW5nZXMuIFRoZSBmaXJzdCBpcyByZWFsbHkgbm90IG5lZWRlZC4Kc2tfYnVmZiBzaW1wbHkgd291
bGQgbm90IHNjYWxlIGlmIGV2ZXJ5IGVkZ2UgY2FzZSBuZWVkcyBhIGZldyBiaXRzLgoKRm9yIHRo
ZSBjb250cm9sIGJsb2NrLCBnZW5lcmFsbHkgaXQgaXMgbm90IHNhZmUgdG8gdXNlIHRoYXQgYWNy
b3NzCmxheWVycy4gSW4gdGhpcyBjYXNlLCBiZXR3ZWVuIHFkaXNjIGVucXVldWUgb2YgYSBnaXZl
biBkZXZpY2UgYW5kCm5kb19zdGFydF94bWl0IG9mIHRoYXQgZGV2aWNlLCBJIHN1cHBvc2UgaXQg
aXMuIFRob3VnaCB1bmNvbW1vbi4gSQp3b25kZXIgaWYgdGhlcmUgaXMgYW55IHByZWNlZGVudC4K
ClRoZSBkYXRhIHdpbGwgaGF2ZSB0byBiZSBzdG9yZWQgaW4gdGhlIHNrYiBzb21ld2hlcmUuIEEg
c2ltcGxlciBvcHRpb24KaXMganVzdCBza2ItPmhhc2g/IFRoaXMgY29kZSB3b3VsZCB1c2Ugc2ti
X2dldF9oYXNoLCBpZiBpdCB3b3VsZAphbHdheXMgcHJvZHVjZSBhIFRvZXBsaXR6IGhhc2gsIGFu
eXdheS4KCj4gPgo+ID4gQXMgeW91IHBvaW50IG91dCwgdGhlIEMgZmxvdyBkaXNzZWN0b3IgaXMg
aW5zdWZmaWNpZW50LiBUaGUgQlBGIGZsb3cKPiA+IGRpc3NlY3RvciBkb2VzIG5vdCBoYXZlIHRo
aXMgcHJvYmxlbS4gVGhlIHNhbWUgYXJndW1lbnQgd291bGQgZ28gZm9yCj4gPiB0aGUgcHJlLWV4
aXN0aW5nIEJQRiBzdGVlcmluZyBwcm9ncmFtLgo+IEl0IGlzIHBvc3NpYmxlIHRvIGV4dGVuZCB0
aGUgQyBmbG93IGRpc3NlY3RvciBqdXN0IGFzIGl0IGlzIHBvc3NpYmxlIHRvCj4gaW1wbGVtZW50
IGEgQlBGIGZsb3cgZGlzc2VjdG9yLiBUaGUgbW9yZSBzZXJpb3VzIHByb2JsZW0gaXMgdGhhdAo+
IHZpcnRpby1uZXQgc3BlY2lmaWNhdGlvbiAoYW5kIE1pY3Jvc29mdCBSU1MgaXQgZm9sbG93cykg
ZG9lcyBub3QgdGVsbAo+IGhvdyB0byBpbXBsZW1lbnQgSVB2NiBleHRlbnNpb24gc3VwcG9ydC4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
