Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F404E95A96
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 10:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE9D260C13;
	Mon,  9 Oct 2023 10:44:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE9D260C13
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V4H4EbQ5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XSbWMoSo9FEC; Mon,  9 Oct 2023 10:44:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BAD0A60BC5;
	Mon,  9 Oct 2023 10:44:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BAD0A60BC5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83F01C0071;
	Mon,  9 Oct 2023 10:44:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5F05C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E0B740A5F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:44:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E0B740A5F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=V4H4EbQ5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rZ2aesn3A3br
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:44:41 +0000 (UTC)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 160C140A44
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 10:44:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 160C140A44
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4527d7f7305so1643020137.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 03:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696848280; x=1697453080;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZfDDDyR3J4c0sRpvZrHdEKwScc/uj3otb8uW8DACqc=;
 b=V4H4EbQ5PixDrPY5cCNx6R/LRpc3DcjQYAxBOSPn4i4wOfpwOqOs1DwX8gOKRAjjxa
 oopu14HtrQpPoIQPZxFXUixqYIDivMwORyJAPzZEe9ekExX9OYDgplDgTi4EW6+HZ/RN
 0i4+BvtfqDM5iPv8vEG2qKgP8KbJOQWxcoeYEleGFkzxSQF8khaGJaYi2YAs4bccBAN+
 BZ6+KeQKD7CHbwB0j7qgaEcGmBweF11NAYXi/wTL0hthNZMFgPIceuqdYWSLdlVCCZTi
 sWRLcinZ8I4niIm7F7zqI9aEP/FmESemHMUouquoFlA5O5rg2eMkiIBNd0sO2mJ9q1a3
 wGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696848280; x=1697453080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZfDDDyR3J4c0sRpvZrHdEKwScc/uj3otb8uW8DACqc=;
 b=NY5/PTcwRx1lKHKE4kLCx8ZXxGGB3ECBEkIwEprMje6ytzciE5ZJnokSHxaQ9qLFlE
 tEyvH+8ArhLDvWmiTFqYTh3w6wLGC0NVIxvLlVZ5wuzwE0tsYsLv+Ci4/EKVwnNc+R9y
 cIIn42hn7c+0gmJr7dI9qCwUvpsDKUAYYXNx6cxg71Y3XQ6DzO3WtHnoOpNT181mZ7m6
 PhlDMPRf+XoN/8tiyMWlQCOaS0+ACYiqsJZrXcSdIH/AqcPuRrJqVfs2Y6EM/tcw/kaD
 pq9xA9T8MgtzTyT8o+ZCfLwVrtJuOmrU1TI4htcjuvHZkVttk2kOnJa5/WjtAcAmwMx5
 pjcA==
X-Gm-Message-State: AOJu0YwPErM64CSf8KJa1twYDGXf0zsGjSxGmMoYafmnEGIdLKULv7Sy
 fqffBrWEa0nTsocEKwlwSeQT9J1GEDCJqgQWGD4=
X-Google-Smtp-Source: AGHT+IHdVSLqpm5a7q+FPq0bViPBRQxnxSBBt7yXnKtf0gbG7NjRdo6eAfOzEB6RN85TxmaRlRS5dgKuQuNOEQCU+XA=
X-Received: by 2002:a67:f141:0:b0:44d:4d5f:79a4 with SMTP id
 t1-20020a67f141000000b0044d4d5f79a4mr11681355vsm.20.1696848279804; Mon, 09
 Oct 2023 03:44:39 -0700 (PDT)
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
 <CAF=yD-+_PLPt9qfXy1Ljr=Lou0W8hCJLi6HwPcZYCjJy+SKtbA@mail.gmail.com>
 <5baab0cf-7adf-475d-8968-d46ddd179f9a@daynix.com>
In-Reply-To: <5baab0cf-7adf-475d-8968-d46ddd179f9a@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 9 Oct 2023 03:44:01 -0700
Message-ID: <CAF=yD-KjvycgFrfKu5CgGGWU-3HbyXt_APQy4tqZgNtJwAUKzg@mail.gmail.com>
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

T24gTW9uLCBPY3QgOSwgMjAyMyBhdCAzOjEy4oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5v
ZGFraUBkYXluaXguY29tPiB3cm90ZToKPgo+IE9uIDIwMjMvMTAvMDkgMTk6MDYsIFdpbGxlbSBk
ZSBCcnVpam4gd3JvdGU6Cj4gPiBPbiBNb24sIE9jdCA5LCAyMDIzIGF0IDM6MDLigK9BTSBBa2lo
aWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gT24g
MjAyMy8xMC8wOSAxODo1NywgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiA+Pj4gT24gTW9uLCBP
Y3QgOSwgMjAyMyBhdCAzOjU34oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXlu
aXguY29tPiB3cm90ZToKPiA+Pj4+Cj4gPj4+PiBPbiAyMDIzLzEwLzA5IDE3OjA0LCBXaWxsZW0g
ZGUgQnJ1aWpuIHdyb3RlOgo+ID4+Pj4+IE9uIFN1biwgT2N0IDgsIDIwMjMgYXQgMzo0NuKAr1BN
IEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPj4+Pj4+
Cj4gPj4+Pj4+IE9uIDIwMjMvMTAvMDkgNTowOCwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiA+
Pj4+Pj4+IE9uIFN1biwgT2N0IDgsIDIwMjMgYXQgMTA6MDTigK9QTSBBa2loaWtvIE9kYWtpIDxh
a2loaWtvLm9kYWtpQGRheW5peC5jb20+IHdyb3RlOgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gT24g
MjAyMy8xMC8wOSA0OjA3LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4+Pj4+Pj4+PiBPbiBT
dW4sIE9jdCA4LCAyMDIzIGF0IDc6MjLigK9BTSBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9kYWtp
QGRheW5peC5jb20+IHdyb3RlOgo+ID4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+IHZpcnRpby1uZXQg
aGF2ZSB0d28gdXNhZ2Ugb2YgaGFzaGVzOiBvbmUgaXMgUlNTIGFuZCBhbm90aGVyIGlzIGhhc2gK
PiA+Pj4+Pj4+Pj4+IHJlcG9ydGluZy4gQ29udmVudGlvbmFsbHkgdGhlIGhhc2ggY2FsY3VsYXRp
b24gd2FzIGRvbmUgYnkgdGhlIFZNTS4KPiA+Pj4+Pj4+Pj4+IEhvd2V2ZXIsIGNvbXB1dGluZyB0
aGUgaGFzaCBhZnRlciB0aGUgcXVldWUgd2FzIGNob3NlbiBkZWZlYXRzIHRoZQo+ID4+Pj4+Pj4+
Pj4gcHVycG9zZSBvZiBSU1MuCj4gPj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4gQW5vdGhlciBhcHBy
b2FjaCBpcyB0byB1c2UgZUJQRiBzdGVlcmluZyBwcm9ncmFtLiBUaGlzIGFwcHJvYWNoIGhhcwo+
ID4+Pj4+Pj4+Pj4gYW5vdGhlciBkb3duc2lkZTogaXQgY2Fubm90IHJlcG9ydCB0aGUgY2FsY3Vs
YXRlZCBoYXNoIGR1ZSB0byB0aGUKPiA+Pj4+Pj4+Pj4+IHJlc3RyaWN0aXZlIG5hdHVyZSBvZiBl
QlBGLgo+ID4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+IEludHJvZHVjZSB0aGUgY29kZSB0byBjb21w
dXRlIGhhc2hlcyB0byB0aGUga2VybmVsIGluIG9yZGVyIHRvIG92ZXJjb21lCj4gPj4+Pj4+Pj4+
PiB0aHNlIGNoYWxsZW5nZXMuIEFuIGFsdGVybmF0aXZlIHNvbHV0aW9uIGlzIHRvIGV4dGVuZCB0
aGUgZUJQRiBzdGVlcmluZwo+ID4+Pj4+Pj4+Pj4gcHJvZ3JhbSBzbyB0aGF0IGl0IHdpbGwgYmUg
YWJsZSB0byByZXBvcnQgdG8gdGhlIHVzZXJzcGFjZSwgYnV0IGl0IG1ha2VzCj4gPj4+Pj4+Pj4+
PiBsaXR0bGUgc2Vuc2UgdG8gYWxsb3cgdG8gaW1wbGVtZW50IGRpZmZlcmVudCBoYXNoaW5nIGFs
Z29yaXRobXMgd2l0aAo+ID4+Pj4+Pj4+Pj4gZUJQRiBzaW5jZSB0aGUgaGFzaCB2YWx1ZSByZXBv
cnRlZCBieSB2aXJ0aW8tbmV0IGlzIHN0cmljdGx5IGRlZmluZWQgYnkKPiA+Pj4+Pj4+Pj4+IHRo
ZSBzcGVjaWZpY2F0aW9uLgo+ID4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+IFRoZSBoYXNoIHZhbHVl
IGFscmVhZHkgc3RvcmVkIGluIHNrX2J1ZmYgaXMgbm90IHVzZWQgYW5kIGNvbXB1dGVkCj4gPj4+
Pj4+Pj4+PiBpbmRlcGVuZGVudGx5IHNpbmNlIGl0IG1heSBoYXZlIGJlZW4gY29tcHV0ZWQgaW4g
YSB3YXkgbm90IGNvbmZvcm1hbnQKPiA+Pj4+Pj4+Pj4+IHdpdGggdGhlIHNwZWNpZmljYXRpb24u
Cj4gPj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQWtpaGlrbyBPZGFraSA8
YWtpaGlrby5vZGFraUBkYXluaXguY29tPgo+ID4+Pj4+Pj4+Pj4gLS0tCj4gPj4+Pj4+Pj4+Cj4g
Pj4+Pj4+Pj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCB0dW5fdm5ldF9oYXNoX2NhcCB0dW5fdm5l
dF9oYXNoX2NhcCA9IHsKPiA+Pj4+Pj4+Pj4+ICsgICAgICAgLm1heF9pbmRpcmVjdGlvbl90YWJs
ZV9sZW5ndGggPQo+ID4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIFRVTl9WTkVUX0hBU0hfTUFY
X0lORElSRUNUSU9OX1RBQkxFX0xFTkdUSCwKPiA+Pj4+Pj4+Pj4+ICsKPiA+Pj4+Pj4+Pj4+ICsg
ICAgICAgLnR5cGVzID0gVklSVElPX05FVF9TVVBQT1JURURfSEFTSF9UWVBFUwo+ID4+Pj4+Pj4+
Pj4gK307Cj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+IE5vIG5lZWQgdG8gaGF2ZSBleHBsaWNpdCBj
YXBhYmlsaXRpZXMgZXhjaGFuZ2UgbGlrZSB0aGlzPyBUdW4gZWl0aGVyCj4gPj4+Pj4+Pj4+IHN1
cHBvcnRzIGFsbCBvciBub25lLgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gdHVuIGRvZXMgbm90IHN1
cHBvcnQgVklSVElPX05FVF9SU1NfSEFTSF9UWVBFX0lQX0VYLAo+ID4+Pj4+Pj4+IFZJUlRJT19O
RVRfUlNTX0hBU0hfVFlQRV9UQ1BfRVgsIGFuZCBWSVJUSU9fTkVUX1JTU19IQVNIX1RZUEVfVURQ
X0VYLgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gSXQgaXMgYmVjYXVzZSB0aGUgZmxvdyBkaXNzZWN0
b3IgZG9lcyBub3Qgc3VwcG9ydCBJUHY2IGV4dGVuc2lvbnMuIFRoZQo+ID4+Pj4+Pj4+IHNwZWNp
ZmljYXRpb24gaXMgYWxzbyB2YWd1ZSwgYW5kIGRvZXMgbm90IHRlbGwgaG93IG1hbnkgVExWcyBz
aG91bGQgYmUKPiA+Pj4+Pj4+PiBjb25zdW1lZCBhdCBtb3N0IHdoZW4gaW50ZXJwcmV0aW5nIGRl
c3RpbmF0aW9uIG9wdGlvbiBoZWFkZXIgc28gSSBjaG9zZQo+ID4+Pj4+Pj4+IHRvIGF2b2lkIGFk
ZGluZyBjb2RlIGZvciB0aGVzZSBoYXNoIHR5cGVzIHRvIHRoZSBmbG93IGRpc3NlY3Rvci4gSSBk
b3VidAo+ID4+Pj4+Pj4+IGFueW9uZSB3aWxsIGNvbXBsYWluIGFib3V0IGl0IHNpbmNlIG5vYm9k
eSBjb21wbGFpbnMgZm9yIExpbnV4Lgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gSSdtIGFsc28gYWRk
aW5nIHRoaXMgc28gdGhhdCB3ZSBjYW4gZXh0ZW5kIGl0IGxhdGVyLgo+ID4+Pj4+Pj4+IG1heF9p
bmRpcmVjdGlvbl90YWJsZV9sZW5ndGggbWF5IGdyb3cgZm9yIHN5c3RlbXMgd2l0aCAxMjgrIENQ
VXMsIG9yCj4gPj4+Pj4+Pj4gdHlwZXMgbWF5IGhhdmUgb3RoZXIgYml0cyBmb3IgbmV3IHByb3Rv
Y29scyBpbiB0aGUgZnV0dXJlLgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+PiAg
ICAgICAgICAgICAgY2FzZSBUVU5TRVRTVEVFUklOR0VCUEY6Cj4gPj4+Pj4+Pj4+PiAtICAgICAg
ICAgICAgICAgcmV0ID0gdHVuX3NldF9lYnBmKHR1biwgJnR1bi0+c3RlZXJpbmdfcHJvZywgYXJn
cCk7Cj4gPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgYnBmX3JldCA9IHR1bl9zZXRfZWJwZih0
dW4sICZ0dW4tPnN0ZWVyaW5nX3Byb2csIGFyZ3ApOwo+ID4+Pj4+Pj4+Pj4gKyAgICAgICAgICAg
ICAgIGlmIChJU19FUlIoYnBmX3JldCkpCj4gPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICByZXQgPSBQVFJfRVJSKGJwZl9yZXQpOwo+ID4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAg
IGVsc2UgaWYgKGJwZl9yZXQpCj4gPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICB0
dW4tPnZuZXRfaGFzaC5mbGFncyAmPSB+VFVOX1ZORVRfSEFTSF9SU1M7Cj4gPj4+Pj4+Pj4+Cj4g
Pj4+Pj4+Pj4+IERvbid0IG1ha2Ugb25lIGZlYXR1cmUgZGlzYWJsZSBhbm90aGVyLgo+ID4+Pj4+
Pj4+Pgo+ID4+Pj4+Pj4+PiBUVU5TRVRTVEVFUklOR0VCUEYgYW5kIFRVTlNFVFZORVRIQVNIIGFy
ZSBtdXR1YWxseSBleGNsdXNpdmUKPiA+Pj4+Pj4+Pj4gZnVuY3Rpb25zLiBJZiBvbmUgaXMgZW5h
YmxlZCB0aGUgb3RoZXIgY2FsbCBzaG91bGQgZmFpbCwgd2l0aCBFQlVTWQo+ID4+Pj4+Pj4+PiBm
b3IgaW5zdGFuY2UuCj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+PiArICAgICAgIGNhc2UgVFVOU0VU
Vk5FVEhBU0g6Cj4gPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgbGVuID0gc2l6ZW9mKHZuZXRf
aGFzaCk7Cj4gPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKCZ2
bmV0X2hhc2gsIGFyZ3AsIGxlbikpIHsKPiA+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHJldCA9IC1FRkFVTFQ7Cj4gPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICBi
cmVhazsKPiA+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICB9Cj4gPj4+Pj4+Pj4+PiArCj4gPj4+
Pj4+Pj4+PiArICAgICAgICAgICAgICAgaWYgKCgodm5ldF9oYXNoLmZsYWdzICYgVFVOX1ZORVRf
SEFTSF9SRVBPUlQpICYmCj4gPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAodHVuLT52
bmV0X2hkcl9zeiA8IHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9oZHJfdjFfaGFzaCkgfHwKPiA+
Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAhdHVuX2lzX2xpdHRsZV9lbmRpYW4odHVu
KSkpIHx8Cj4gPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICB2bmV0X2hhc2guaW5kaXJl
Y3Rpb25fdGFibGVfbWFzayA+PQo+ID4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgVFVO
X1ZORVRfSEFTSF9NQVhfSU5ESVJFQ1RJT05fVEFCTEVfTEVOR1RIKSB7Cj4gPj4+Pj4+Pj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOwo+ID4+Pj4+Pj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgfQo+
ID4+Pj4+Pj4+Pj4gKwo+ID4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIGFyZ3AgPSAodTggX191
c2VyICopYXJncCArIGxlbjsKPiA+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICBsZW4gPSAodm5l
dF9oYXNoLmluZGlyZWN0aW9uX3RhYmxlX21hc2sgKyAxKSAqIDI7Cj4gPj4+Pj4+Pj4+PiArICAg
ICAgICAgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKHZuZXRfaGFzaF9pbmRpcmVjdGlvbl90YWJs
ZSwgYXJncCwgbGVuKSkgewo+ID4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gLUVGQVVMVDsKPiA+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+
ID4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIH0KPiA+Pj4+Pj4+Pj4+ICsKPiA+Pj4+Pj4+Pj4+
ICsgICAgICAgICAgICAgICBhcmdwID0gKHU4IF9fdXNlciAqKWFyZ3AgKyBsZW47Cj4gPj4+Pj4+
Pj4+PiArICAgICAgICAgICAgICAgbGVuID0gdmlydGlvX25ldF9oYXNoX2tleV9sZW5ndGgodm5l
dF9oYXNoLnR5cGVzKTsKPiA+Pj4+Pj4+Pj4+ICsKPiA+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAg
ICBpZiAoY29weV9mcm9tX3VzZXIodm5ldF9oYXNoX2tleSwgYXJncCwgbGVuKSkgewo+ID4+Pj4+
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVGQVVMVDsKPiA+Pj4+Pj4+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4+Pj4+Pj4+Pj4gKyAgICAgICAgICAg
ICAgIH0KPiA+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4gUHJvYmFibHkgZWFzaWVyIGFuZCBsZXNzIGVy
cm9yLXByb25lIHRvIGRlZmluZSBhIGZpeGVkIHNpemUgY29udHJvbAo+ID4+Pj4+Pj4+PiBzdHJ1
Y3Qgd2l0aCB0aGUgbWF4IGluZGlyZWN0aW9uIHRhYmxlIHNpemUuCj4gPj4+Pj4+Pj4KPiA+Pj4+
Pj4+PiBJIG1hZGUgaXRzIHNpemUgdmFyaWFibGUgYmVjYXVzZSB0aGUgaW5kaXJlY3Rpb24gdGFi
bGUgYW5kIGtleSBtYXkgZ3Jvdwo+ID4+Pj4+Pj4+IGluIHRoZSBmdXR1cmUgYXMgSSB3cm90ZSBh
Ym92ZS4KPiA+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+PiBCdHc6IHBsZWFzZSB0cmlt
IHRoZSBDQzogbGlzdCBjb25zaWRlcmFibHkgb24gZnV0dXJlIHBhdGNoZXMuCj4gPj4+Pj4+Pj4K
PiA+Pj4+Pj4+PiBJJ2xsIGRvIHNvIGluIHRoZSBuZXh0IHZlcnNpb24gd2l0aCB0aGUgVFVOU0VU
U1RFRVJJTkdFQlBGIGNoYW5nZSB5b3UKPiA+Pj4+Pj4+PiBwcm9wb3NlZC4KPiA+Pj4+Pj4+Cj4g
Pj4+Pj4+PiBUbyBiZSBjbGVhcjogcGxlYXNlIGRvbid0IGp1c3QgcmVzdWJtaXQgd2l0aCB0aGF0
IG9uZSBjaGFuZ2UuCj4gPj4+Pj4+Pgo+ID4+Pj4+Pj4gVGhlIHNrYiBhbmQgY2IgaXNzdWVzIGFy
ZSBxdWl0ZSBmdW5kYW1lbnRhbCBpc3N1ZXMgdGhhdCBuZWVkIHRvIGJlIHJlc29sdmVkLgo+ID4+
Pj4+Pj4KPiA+Pj4+Pj4+IEknZCBsaWtlIHRvIHVuZGVyc3RhbmQgd2h5IGFkanVzdGluZyB0aGUg
ZXhpc3RpbmcgQlBGIGZlYXR1cmUgZm9yIHRoaXMKPiA+Pj4+Pj4+IGV4YWN0IHB1cnBvc2UgY2Fu
bm90IGJlIGFtZW5kZWQgdG8gcmV0dXJuIHRoZSBrZXkgaXQgcHJvZHVjZWQuCj4gPj4+Pj4+Cj4g
Pj4+Pj4+IGVCUEYgc3RlZXJpbmcgcHJvZ3JhbSBpcyBub3QgZGVzaWduZWQgZm9yIHRoaXMgcGFy
dGljdWxhciBwcm9ibGVtIGluIG15Cj4gPj4+Pj4+IHVuZGVyc3RhbmRpbmcuIEl0IHdhcyBpbnRy
b2R1Y2VkIHRvIGRlcml2ZSBoYXNoIHZhbHVlcyB3aXRoIGFuCj4gPj4+Pj4+IHVuZGVyc3RhbmRp
bmcgb2YgYXBwbGljYXRpb24tc3BlY2lmaWMgc2VtYW50aWNzIG9mIHBhY2tldHMgaW5zdGVhZCBv
Zgo+ID4+Pj4+PiBnZW5lcmljIElQL1RDUC9VRFAgc2VtYW50aWNzLgo+ID4+Pj4+Pgo+ID4+Pj4+
PiBUaGlzIHByb2JsZW0gaXMgcmF0aGVyIGRpZmZlcmVudCBpbiB0ZXJtcyB0aGF0IHRoZSBoYXNo
IGRlcml2YXRpb24gaXMKPiA+Pj4+Pj4gc3RyaWN0bHkgZGVmaW5lZCBieSB2aXJ0aW8tbmV0LiBJ
IGRvbid0IHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvCj4gPj4+Pj4+IGludHJvZHVjZSB0aGUgY29t
cGxleGl0eSBvZiBCUEYgd2hlbiB5b3UgYWx3YXlzIHJ1biB0aGUgc2FtZSBjb2RlLgo+ID4+Pj4+
Pgo+ID4+Pj4+PiBJdCBjYW4gdXRpbGl6ZSB0aGUgZXhpc3RpbmcgZmxvdyBkaXNzZWN0b3IgYW5k
IGFsc28gbWFrZSBpdCBlYXNpZXIgdG8KPiA+Pj4+Pj4gdXNlIGZvciB0aGUgdXNlcnNwYWNlIGJ5
IGltcGxlbWVudGluZyB0aGlzIGluIHRoZSBrZXJuZWwuCj4gPj4+Pj4KPiA+Pj4+PiBPay4gVGhl
cmUgZG9lcyBhcHBlYXIgdG8gYmUgb3ZlcmxhcCBpbiBmdW5jdGlvbmFsaXR5LiBCdXQgaXQgbWln
aHQgYmUKPiA+Pj4+PiBlYXNpZXIgdG8gZGVwbG95IHRvIGp1c3QgaGF2ZSBzdGFuZGFyZCBUb2Vw
bGl0eiBhdmFpbGFibGUgd2l0aG91dAo+ID4+Pj4+IGhhdmluZyB0byBjb21waWxlIGFuZCBsb2Fk
IGFuIGVCUEYgcHJvZ3JhbS4KPiA+Pj4+Pgo+ID4+Pj4+IEFzIGZvciB0aGUgc2tfYnVmZiBhbmQg
Y2JbXSBjaGFuZ2VzLiBUaGUgZmlyc3QgaXMgcmVhbGx5IG5vdCBuZWVkZWQuCj4gPj4+Pj4gc2tf
YnVmZiBzaW1wbHkgd291bGQgbm90IHNjYWxlIGlmIGV2ZXJ5IGVkZ2UgY2FzZSBuZWVkcyBhIGZl
dyBiaXRzLgo+ID4+Pj4KPiA+Pj4+IEFuIGFsdGVybmF0aXZlIGlzIHRvIG1vdmUgdGhlIGJpdCB0
byBjYltdIGFuZCBjbGVhciBpdCBmb3IgZXZlcnkgY29kZQo+ID4+Pj4gcGF0aHMgdGhhdCBsZWFk
IHRvIG5kb19zdGFydF94bWl0KCksIGJ1dCBJJ20gd29ycmllZCB0aGF0IGl0IGlzIGVycm9yLXBy
b25lLgo+ID4+Pj4KPiA+Pj4+IEkgdGhpbmsgd2UgY2FuIHB1dCB0aGUgYml0IGluIHNrX2J1ZmYg
Zm9yIG5vdy4gV2UgY2FuIGltcGxlbWVudCB0aGUKPiA+Pj4+IGFsdGVybmF0aXZlIHdoZW4gd2Ug
YXJlIHNob3J0IG9mIGJpdHMuCj4gPj4+Cj4gPj4+IEkgZGlzYWdyZWUuIHNrX2J1ZmYgZmllbGRz
IGFkZCBhIGNvc3QgdG8gZXZlcnkgY29kZSBwYXRoLiBUaGV5IGNhbm5vdAo+ID4+PiBiZSBhZGRl
ZCBmb3IgZXZlcnkgZWRnZSBjYXNlLgo+ID4+Cj4gPj4gSXQgb25seSB0YWtlcyBhbiB1bnVzZWQg
Yml0IGFuZCBkb2VzIG5vdCBncm93IHRoZSBza19idWZmIHNpemUgc28gSQo+ID4+IHRoaW5rIGl0
IGhhcyBwcmFjdGljYWxseSBubyBjb3N0IGZvciBub3cuCj4gPgo+ID4gVGhlIHByb2JsZW0gaXMg
dGhhdCB0aGF0IHRoaW5raW5nIGxlYWRzIHRvIGRlYXRoIGJ5IGEgdGhvdXNhbmQgY3V0cy4KPiA+
Cj4gPiAiZm9yIG5vdyIgZm9yY2VzIHRoZSBjb3N0IG9mIGhhdmluZyB0byB0aGluayBoYXJkIGhv
dyB0byBhdm9pZCBncm93aW5nCj4gPiBza19idWZmIG9udG8gdGhlIG5leHQgcGVyc29uLiBMZXQn
cyBkbyBpdCByaWdodCBmcm9tIHRoZSBzdGFydC4KPgo+IEkgc2VlLiBJIGRlc2NyaWJlZCBhbiBh
bHRlcm5hdGl2ZSB0byBtb3ZlIHRoZSBiaXQgdG8gY2JbXSBhbmQgY2xlYXIgaXQKPiBpbiBhbGwg
Y29kZSBwYXRocyB0aGF0IGxlYWRzIHRvIG5kb19zdGFydF94bWl0KCkgZWFybGllci4gRG9lcyB0
aGF0Cj4gc291bmQgZ29vZCB0byB5b3U/CgpJZiB5b3UgdXNlIHRoZSBjb250cm9sIGJsb2NrIHRv
IHBhc3MgaW5mb3JtYXRpb24gYmV0d2VlbgpfX2Rldl9xdWV1ZV94bWl0IG9uIHRoZSB0dW4gZGV2
aWNlIGFuZCB0dW5fbmV0X3htaXQsIHVzaW5nIGdzb19za2JfY2IsCnRoZSBmaWVsZCBjYW4gYmUg
bGVmdCB1bmRlZmluZWQgaW4gYWxsIG5vbi10dW4gcGF0aHMuIHR1bl9zZWxlY3RfcXVldWUKY2Fu
IGluaXRpYWxpemUuCgpJIHdvdWxkIHN0aWxsIHVzZSBza2ItPmhhc2ggdG8gZW5jb2RlIHRoZSBo
YXNoLiBUaGF0IGhhc2ggdHlwZSBvZiB0aGF0CmZpZWxkIGlzIG5vdCBzdHJpY3RseSBkZWZpbmVk
LiBJdCBjYW4gYmUgc2lwaGFzaCBmcm9tIF9fX3NrYl9nZXRfaGFzaApvciBhIGRldmljZSBoYXNo
LCB3aGljaCBtb3N0IGxpa2VseSBhbHNvIHVzZXMgVG9lcGxpdHouIFRoZW4geW91IGFsc28KZG9u
J3QgcnVuIGludG8gdGhlIHByb2JsZW0gb2YgZ3Jvd2luZyB0aGUgc3RydWN0IHNpemUuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
