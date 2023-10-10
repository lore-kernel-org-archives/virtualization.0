Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DFECD68ED
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 06:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 016D781468;
	Tue, 10 Oct 2023 06:00:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 016D781468
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uq+eWCVI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Za5Eb8fq-ikk; Tue, 10 Oct 2023 06:00:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0021281464;
	Tue, 10 Oct 2023 06:00:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0021281464
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8B0BC0071;
	Tue, 10 Oct 2023 06:00:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EDEFC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32C574092F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:00:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32C574092F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uq+eWCVI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lfbfo2yi_Eul
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:00:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78E0D408F6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:00:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78E0D408F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696917642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Gk7tBGT8X8drXI+GYZgxJFy1e/35zrCp1p7LiznPLI=;
 b=Uq+eWCVIxY8ex0Y63gzaXgDZ3iJw1Vi4KTtE/8iI1WPkkv9rV4HGcogXvDfg+25f+L8N/4
 WraYVb1GDmGZtdBQHcpgp3vK4m1/EcQc3gv70xrMwesM1aoaulqyw+JmXogLEGiFXakatB
 jCHeH/M6GEgocAHj0FAmf0PnEH2mf7g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-mKFXTGByMPCgJ4xPZZJH3g-1; Tue, 10 Oct 2023 02:00:37 -0400
X-MC-Unique: mKFXTGByMPCgJ4xPZZJH3g-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5043353efbdso4609290e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 23:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696917636; x=1697522436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Gk7tBGT8X8drXI+GYZgxJFy1e/35zrCp1p7LiznPLI=;
 b=cYf2MSl49pAZ8Gl9/4JxEFjnwiBu3TVPBVJsoeDY14hhrEVUwcg/f1ERuYGtqwvEKx
 h6C5udVR92BDuiS6BkU/WvbwtBdVwtbTZ1b3RVlTSRCrVqyNjgm8eWzkRlErRCjMgMQ8
 ylOT4FaIFWFmNbiPdzOUMCps1fHtS43Rdo+oMMd8fzRFd9XnfdLaMZUzMHMHTJbIVozK
 KaBgJbEMvyYjM3wYGs0/WUXwqs8qCuCYVc/FMjP9WJU7cNpEixo4hY8zQAA85rZDLzJ/
 XgfIj+v6mf5tCecp3wTz1GzsqRofZL+i10O6YbLY82zPmDhWSjSuInCZvaSnjCPKhV06
 6EYg==
X-Gm-Message-State: AOJu0YyulIDlwpOH9aVn13P8H/gKJ8NSf0PyTtsQDJrm+0yzgjajLAH/
 N9SyddW5LJHZmJi7LOA1YfLV10pePQ9E7Go3Lwd8czvsOhfDhvKrZZund/At/FozUJBr4203HVp
 ujMSf1VJQFnB546FE/renrwLeVe9GgjgcvfuETBmQwCvIoPXN04Gvlk9fsQ==
X-Received: by 2002:a05:6512:3144:b0:502:d5b0:436e with SMTP id
 s4-20020a056512314400b00502d5b0436emr12983930lfi.62.1696917636369; 
 Mon, 09 Oct 2023 23:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEEZZRDdD8H90JRjWbRmrO+8BUOAcxUDaxkN1ma9xdSIGkn8J0hIp7OgmdPKLwyJxgBGzltTqTsEITR8au8JA=
X-Received: by 2002:a05:6512:3144:b0:502:d5b0:436e with SMTP id
 s4-20020a056512314400b00502d5b0436emr12983894lfi.62.1696917635900; Mon, 09
 Oct 2023 23:00:35 -0700 (PDT)
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
 <CAF=yD-KjvycgFrfKu5CgGGWU-3HbyXt_APQy4tqZgNtJwAUKzg@mail.gmail.com>
 <8f3ed081-134c-45a0-9208-c1cab29cdf37@daynix.com>
 <CACGkMEv0tpn4YsJhXXnoispYx2-VBimFAtFmf85Uo=5=6taVuw@mail.gmail.com>
 <8a44e14c-03c4-44e2-8c72-9d751c63dffe@daynix.com>
In-Reply-To: <8a44e14c-03c4-44e2-8c72-9d751c63dffe@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Oct 2023 14:00:24 +0800
Message-ID: <CACGkMEu8m4SRvuMKrJv9_A_Wh_a1OzWkAr_9-+5CyC1zqK=R3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: songliubraving@fb.com, gustavoars@kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, decui@microsoft.com, ast@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 herbert@gondor.apana.org.au, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, yhs@fb.com, pabeni@redhat.com, pablo@netfilter.org,
 elver@google.com, kpsingh@kernel.org,
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

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMTo1MeKAr1BNIEFraWhpa28gT2Rha2kgPGFraWhpa28u
b2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4KPiBPbiAyMDIzLzEwLzEwIDE0OjQ1LCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gT24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgOTo1MuKAr0FNIEFraWhpa28g
T2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiBPbiAyMDIz
LzEwLzA5IDE5OjQ0LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4+PiBPbiBNb24sIE9jdCA5
LCAyMDIzIGF0IDM6MTLigK9BTSBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5j
b20+IHdyb3RlOgo+ID4+Pj4KPiA+Pj4+IE9uIDIwMjMvMTAvMDkgMTk6MDYsIFdpbGxlbSBkZSBC
cnVpam4gd3JvdGU6Cj4gPj4+Pj4gT24gTW9uLCBPY3QgOSwgMjAyMyBhdCAzOjAy4oCvQU0gQWtp
aGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPiB3cm90ZToKPiA+Pj4+Pj4KPiA+
Pj4+Pj4gT24gMjAyMy8xMC8wOSAxODo1NywgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiA+Pj4+
Pj4+IE9uIE1vbiwgT2N0IDksIDIwMjMgYXQgMzo1N+KAr0FNIEFraWhpa28gT2Rha2kgPGFraWhp
a28ub2Rha2lAZGF5bml4LmNvbT4gd3JvdGU6Cj4gPj4+Pj4+Pj4KPiA+Pj4+Pj4+PiBPbiAyMDIz
LzEwLzA5IDE3OjA0LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4+Pj4+Pj4+PiBPbiBTdW4s
IE9jdCA4LCAyMDIzIGF0IDM6NDbigK9QTSBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRh
eW5peC5jb20+IHdyb3RlOgo+ID4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+IE9uIDIwMjMvMTAvMDkg
NTowOCwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiA+Pj4+Pj4+Pj4+PiBPbiBTdW4sIE9jdCA4
LCAyMDIzIGF0IDEwOjA04oCvUE0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXgu
Y29tPiB3cm90ZToKPiA+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4gT24gMjAyMy8xMC8wOSA0
OjA3LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4+Pj4+Pj4+Pj4+Pj4gT24gU3VuLCBPY3Qg
OCwgMjAyMyBhdCA3OjIy4oCvQU0gQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXgu
Y29tPiB3cm90ZToKPiA+Pj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4+IHZpcnRpby1uZXQg
aGF2ZSB0d28gdXNhZ2Ugb2YgaGFzaGVzOiBvbmUgaXMgUlNTIGFuZCBhbm90aGVyIGlzIGhhc2gK
PiA+Pj4+Pj4+Pj4+Pj4+PiByZXBvcnRpbmcuIENvbnZlbnRpb25hbGx5IHRoZSBoYXNoIGNhbGN1
bGF0aW9uIHdhcyBkb25lIGJ5IHRoZSBWTU0uCj4gPj4+Pj4+Pj4+Pj4+Pj4gSG93ZXZlciwgY29t
cHV0aW5nIHRoZSBoYXNoIGFmdGVyIHRoZSBxdWV1ZSB3YXMgY2hvc2VuIGRlZmVhdHMgdGhlCj4g
Pj4+Pj4+Pj4+Pj4+Pj4gcHVycG9zZSBvZiBSU1MuCj4gPj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+
Pj4+Pj4+PiBBbm90aGVyIGFwcHJvYWNoIGlzIHRvIHVzZSBlQlBGIHN0ZWVyaW5nIHByb2dyYW0u
IFRoaXMgYXBwcm9hY2ggaGFzCj4gPj4+Pj4+Pj4+Pj4+Pj4gYW5vdGhlciBkb3duc2lkZTogaXQg
Y2Fubm90IHJlcG9ydCB0aGUgY2FsY3VsYXRlZCBoYXNoIGR1ZSB0byB0aGUKPiA+Pj4+Pj4+Pj4+
Pj4+PiByZXN0cmljdGl2ZSBuYXR1cmUgb2YgZUJQRi4KPiA+Pj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+
Pj4+Pj4+Pj4+IEludHJvZHVjZSB0aGUgY29kZSB0byBjb21wdXRlIGhhc2hlcyB0byB0aGUga2Vy
bmVsIGluIG9yZGVyIHRvIG92ZXJjb21lCj4gPj4+Pj4+Pj4+Pj4+Pj4gdGhzZSBjaGFsbGVuZ2Vz
LiBBbiBhbHRlcm5hdGl2ZSBzb2x1dGlvbiBpcyB0byBleHRlbmQgdGhlIGVCUEYgc3RlZXJpbmcK
PiA+Pj4+Pj4+Pj4+Pj4+PiBwcm9ncmFtIHNvIHRoYXQgaXQgd2lsbCBiZSBhYmxlIHRvIHJlcG9y
dCB0byB0aGUgdXNlcnNwYWNlLCBidXQgaXQgbWFrZXMKPiA+Pj4+Pj4+Pj4+Pj4+PiBsaXR0bGUg
c2Vuc2UgdG8gYWxsb3cgdG8gaW1wbGVtZW50IGRpZmZlcmVudCBoYXNoaW5nIGFsZ29yaXRobXMg
d2l0aAo+ID4+Pj4+Pj4+Pj4+Pj4+IGVCUEYgc2luY2UgdGhlIGhhc2ggdmFsdWUgcmVwb3J0ZWQg
YnkgdmlydGlvLW5ldCBpcyBzdHJpY3RseSBkZWZpbmVkIGJ5Cj4gPj4+Pj4+Pj4+Pj4+Pj4gdGhl
IHNwZWNpZmljYXRpb24uCj4gPj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+PiBUaGUgaGFz
aCB2YWx1ZSBhbHJlYWR5IHN0b3JlZCBpbiBza19idWZmIGlzIG5vdCB1c2VkIGFuZCBjb21wdXRl
ZAo+ID4+Pj4+Pj4+Pj4+Pj4+IGluZGVwZW5kZW50bHkgc2luY2UgaXQgbWF5IGhhdmUgYmVlbiBj
b21wdXRlZCBpbiBhIHdheSBub3QgY29uZm9ybWFudAo+ID4+Pj4+Pj4+Pj4+Pj4+IHdpdGggdGhl
IHNwZWNpZmljYXRpb24uCj4gPj4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+Cj4gPj4+Pj4+
Pj4+Pj4+Pj4gLS0tCj4gPj4+Pj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IHR1bl92bmV0X2hhc2hfY2FwIHR1bl92bmV0X2hhc2hfY2FwID0gewo+ID4+Pj4+
Pj4+Pj4+Pj4+ICsgICAgICAgLm1heF9pbmRpcmVjdGlvbl90YWJsZV9sZW5ndGggPQo+ID4+Pj4+
Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICBUVU5fVk5FVF9IQVNIX01BWF9JTkRJUkVDVElPTl9U
QUJMRV9MRU5HVEgsCj4gPj4+Pj4+Pj4+Pj4+Pj4gKwo+ID4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAg
LnR5cGVzID0gVklSVElPX05FVF9TVVBQT1JURURfSEFTSF9UWVBFUwo+ID4+Pj4+Pj4+Pj4+Pj4+
ICt9Owo+ID4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+IE5vIG5lZWQgdG8gaGF2ZSBleHBs
aWNpdCBjYXBhYmlsaXRpZXMgZXhjaGFuZ2UgbGlrZSB0aGlzPyBUdW4gZWl0aGVyCj4gPj4+Pj4+
Pj4+Pj4+PiBzdXBwb3J0cyBhbGwgb3Igbm9uZS4KPiA+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+
Pj4gdHVuIGRvZXMgbm90IHN1cHBvcnQgVklSVElPX05FVF9SU1NfSEFTSF9UWVBFX0lQX0VYLAo+
ID4+Pj4+Pj4+Pj4+PiBWSVJUSU9fTkVUX1JTU19IQVNIX1RZUEVfVENQX0VYLCBhbmQgVklSVElP
X05FVF9SU1NfSEFTSF9UWVBFX1VEUF9FWC4KPiA+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4g
SXQgaXMgYmVjYXVzZSB0aGUgZmxvdyBkaXNzZWN0b3IgZG9lcyBub3Qgc3VwcG9ydCBJUHY2IGV4
dGVuc2lvbnMuIFRoZQo+ID4+Pj4+Pj4+Pj4+PiBzcGVjaWZpY2F0aW9uIGlzIGFsc28gdmFndWUs
IGFuZCBkb2VzIG5vdCB0ZWxsIGhvdyBtYW55IFRMVnMgc2hvdWxkIGJlCj4gPj4+Pj4+Pj4+Pj4+
IGNvbnN1bWVkIGF0IG1vc3Qgd2hlbiBpbnRlcnByZXRpbmcgZGVzdGluYXRpb24gb3B0aW9uIGhl
YWRlciBzbyBJIGNob3NlCj4gPj4+Pj4+Pj4+Pj4+IHRvIGF2b2lkIGFkZGluZyBjb2RlIGZvciB0
aGVzZSBoYXNoIHR5cGVzIHRvIHRoZSBmbG93IGRpc3NlY3Rvci4gSSBkb3VidAo+ID4+Pj4+Pj4+
Pj4+PiBhbnlvbmUgd2lsbCBjb21wbGFpbiBhYm91dCBpdCBzaW5jZSBub2JvZHkgY29tcGxhaW5z
IGZvciBMaW51eC4KPiA+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4gSSdtIGFsc28gYWRkaW5n
IHRoaXMgc28gdGhhdCB3ZSBjYW4gZXh0ZW5kIGl0IGxhdGVyLgo+ID4+Pj4+Pj4+Pj4+PiBtYXhf
aW5kaXJlY3Rpb25fdGFibGVfbGVuZ3RoIG1heSBncm93IGZvciBzeXN0ZW1zIHdpdGggMTI4KyBD
UFVzLCBvcgo+ID4+Pj4+Pj4+Pj4+PiB0eXBlcyBtYXkgaGF2ZSBvdGhlciBiaXRzIGZvciBuZXcg
cHJvdG9jb2xzIGluIHRoZSBmdXR1cmUuCj4gPj4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4+Pgo+
ID4+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgIGNhc2UgVFVOU0VUU1RFRVJJTkdFQlBGOgo+
ID4+Pj4+Pj4+Pj4+Pj4+IC0gICAgICAgICAgICAgICByZXQgPSB0dW5fc2V0X2VicGYodHVuLCAm
dHVuLT5zdGVlcmluZ19wcm9nLCBhcmdwKTsKPiA+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAg
ICAgYnBmX3JldCA9IHR1bl9zZXRfZWJwZih0dW4sICZ0dW4tPnN0ZWVyaW5nX3Byb2csIGFyZ3Ap
Owo+ID4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICBpZiAoSVNfRVJSKGJwZl9yZXQpKQo+
ID4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoYnBm
X3JldCk7Cj4gPj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIGVsc2UgaWYgKGJwZl9yZXQp
Cj4gPj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgdHVuLT52bmV0X2hhc2gu
ZmxhZ3MgJj0gflRVTl9WTkVUX0hBU0hfUlNTOwo+ID4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+
Pj4+IERvbid0IG1ha2Ugb25lIGZlYXR1cmUgZGlzYWJsZSBhbm90aGVyLgo+ID4+Pj4+Pj4+Pj4+
Pj4KPiA+Pj4+Pj4+Pj4+Pj4+IFRVTlNFVFNURUVSSU5HRUJQRiBhbmQgVFVOU0VUVk5FVEhBU0gg
YXJlIG11dHVhbGx5IGV4Y2x1c2l2ZQo+ID4+Pj4+Pj4+Pj4+Pj4gZnVuY3Rpb25zLiBJZiBvbmUg
aXMgZW5hYmxlZCB0aGUgb3RoZXIgY2FsbCBzaG91bGQgZmFpbCwgd2l0aCBFQlVTWQo+ID4+Pj4+
Pj4+Pj4+Pj4gZm9yIGluc3RhbmNlLgo+ID4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+PiAr
ICAgICAgIGNhc2UgVFVOU0VUVk5FVEhBU0g6Cj4gPj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAg
ICAgIGxlbiA9IHNpemVvZih2bmV0X2hhc2gpOwo+ID4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAg
ICAgICBpZiAoY29weV9mcm9tX3VzZXIoJnZuZXRfaGFzaCwgYXJncCwgbGVuKSkgewo+ID4+Pj4+
Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7Cj4gPj4+Pj4+
Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4+Pj4+Pj4+Pj4+Pj4g
KyAgICAgICAgICAgICAgIH0KPiA+Pj4+Pj4+Pj4+Pj4+PiArCj4gPj4+Pj4+Pj4+Pj4+Pj4gKyAg
ICAgICAgICAgICAgIGlmICgoKHZuZXRfaGFzaC5mbGFncyAmIFRVTl9WTkVUX0hBU0hfUkVQT1JU
KSAmJgo+ID4+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICh0dW4tPnZuZXRfaGRy
X3N6IDwgc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl92MV9oYXNoKSB8fAo+ID4+Pj4+Pj4+
Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAhdHVuX2lzX2xpdHRsZV9lbmRpYW4odHVuKSkp
IHx8Cj4gPj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgdm5ldF9oYXNoLmluZGly
ZWN0aW9uX3RhYmxlX21hc2sgPj0KPiA+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAg
ICBUVU5fVk5FVF9IQVNIX01BWF9JTkRJUkVDVElPTl9UQUJMRV9MRU5HVEgpIHsKPiA+Pj4+Pj4+
Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOwo+ID4+Pj4+Pj4+
Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4+Pj4+Pj4+Pj4+Pj4+ICsg
ICAgICAgICAgICAgICB9Cj4gPj4+Pj4+Pj4+Pj4+Pj4gKwo+ID4+Pj4+Pj4+Pj4+Pj4+ICsgICAg
ICAgICAgICAgICBhcmdwID0gKHU4IF9fdXNlciAqKWFyZ3AgKyBsZW47Cj4gPj4+Pj4+Pj4+Pj4+
Pj4gKyAgICAgICAgICAgICAgIGxlbiA9ICh2bmV0X2hhc2guaW5kaXJlY3Rpb25fdGFibGVfbWFz
ayArIDEpICogMjsKPiA+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgaWYgKGNvcHlfZnJv
bV91c2VyKHZuZXRfaGFzaF9pbmRpcmVjdGlvbl90YWJsZSwgYXJncCwgbGVuKSkgewo+ID4+Pj4+
Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7Cj4gPj4+Pj4+
Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4+Pj4+Pj4+Pj4+Pj4g
KyAgICAgICAgICAgICAgIH0KPiA+Pj4+Pj4+Pj4+Pj4+PiArCj4gPj4+Pj4+Pj4+Pj4+Pj4gKyAg
ICAgICAgICAgICAgIGFyZ3AgPSAodTggX191c2VyICopYXJncCArIGxlbjsKPiA+Pj4+Pj4+Pj4+
Pj4+PiArICAgICAgICAgICAgICAgbGVuID0gdmlydGlvX25ldF9oYXNoX2tleV9sZW5ndGgodm5l
dF9oYXNoLnR5cGVzKTsKPiA+Pj4+Pj4+Pj4+Pj4+PiArCj4gPj4+Pj4+Pj4+Pj4+Pj4gKyAgICAg
ICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcih2bmV0X2hhc2hfa2V5LCBhcmdwLCBsZW4pKSB7
Cj4gPj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVGQVVMVDsK
PiA+Pj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+Pj4+Pj4+
Pj4+Pj4+PiArICAgICAgICAgICAgICAgfQo+ID4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+
IFByb2JhYmx5IGVhc2llciBhbmQgbGVzcyBlcnJvci1wcm9uZSB0byBkZWZpbmUgYSBmaXhlZCBz
aXplIGNvbnRyb2wKPiA+Pj4+Pj4+Pj4+Pj4+IHN0cnVjdCB3aXRoIHRoZSBtYXggaW5kaXJlY3Rp
b24gdGFibGUgc2l6ZS4KPiA+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4gSSBtYWRlIGl0cyBz
aXplIHZhcmlhYmxlIGJlY2F1c2UgdGhlIGluZGlyZWN0aW9uIHRhYmxlIGFuZCBrZXkgbWF5IGdy
b3cKPiA+Pj4+Pj4+Pj4+Pj4gaW4gdGhlIGZ1dHVyZSBhcyBJIHdyb3RlIGFib3ZlLgo+ID4+Pj4+
Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+Pj4+IEJ0dzogcGxlYXNlIHRyaW0g
dGhlIENDOiBsaXN0IGNvbnNpZGVyYWJseSBvbiBmdXR1cmUgcGF0Y2hlcy4KPiA+Pj4+Pj4+Pj4+
Pj4KPiA+Pj4+Pj4+Pj4+Pj4gSSdsbCBkbyBzbyBpbiB0aGUgbmV4dCB2ZXJzaW9uIHdpdGggdGhl
IFRVTlNFVFNURUVSSU5HRUJQRiBjaGFuZ2UgeW91Cj4gPj4+Pj4+Pj4+Pj4+IHByb3Bvc2VkLgo+
ID4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4gVG8gYmUgY2xlYXI6IHBsZWFzZSBkb24ndCBqdXN0
IHJlc3VibWl0IHdpdGggdGhhdCBvbmUgY2hhbmdlLgo+ID4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+
Pj4gVGhlIHNrYiBhbmQgY2IgaXNzdWVzIGFyZSBxdWl0ZSBmdW5kYW1lbnRhbCBpc3N1ZXMgdGhh
dCBuZWVkIHRvIGJlIHJlc29sdmVkLgo+ID4+Pj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+Pj4gSSdkIGxp
a2UgdG8gdW5kZXJzdGFuZCB3aHkgYWRqdXN0aW5nIHRoZSBleGlzdGluZyBCUEYgZmVhdHVyZSBm
b3IgdGhpcwo+ID4+Pj4+Pj4+Pj4+IGV4YWN0IHB1cnBvc2UgY2Fubm90IGJlIGFtZW5kZWQgdG8g
cmV0dXJuIHRoZSBrZXkgaXQgcHJvZHVjZWQuCj4gPj4+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+Pj4gZUJQ
RiBzdGVlcmluZyBwcm9ncmFtIGlzIG5vdCBkZXNpZ25lZCBmb3IgdGhpcyBwYXJ0aWN1bGFyIHBy
b2JsZW0gaW4gbXkKPiA+Pj4+Pj4+Pj4+IHVuZGVyc3RhbmRpbmcuIEl0IHdhcyBpbnRyb2R1Y2Vk
IHRvIGRlcml2ZSBoYXNoIHZhbHVlcyB3aXRoIGFuCj4gPj4+Pj4+Pj4+PiB1bmRlcnN0YW5kaW5n
IG9mIGFwcGxpY2F0aW9uLXNwZWNpZmljIHNlbWFudGljcyBvZiBwYWNrZXRzIGluc3RlYWQgb2YK
PiA+Pj4+Pj4+Pj4+IGdlbmVyaWMgSVAvVENQL1VEUCBzZW1hbnRpY3MuCj4gPj4+Pj4+Pj4+Pgo+
ID4+Pj4+Pj4+Pj4gVGhpcyBwcm9ibGVtIGlzIHJhdGhlciBkaWZmZXJlbnQgaW4gdGVybXMgdGhh
dCB0aGUgaGFzaCBkZXJpdmF0aW9uIGlzCj4gPj4+Pj4+Pj4+PiBzdHJpY3RseSBkZWZpbmVkIGJ5
IHZpcnRpby1uZXQuIEkgZG9uJ3QgdGhpbmsgaXQgbWFrZXMgc2Vuc2UgdG8KPiA+Pj4+Pj4+Pj4+
IGludHJvZHVjZSB0aGUgY29tcGxleGl0eSBvZiBCUEYgd2hlbiB5b3UgYWx3YXlzIHJ1biB0aGUg
c2FtZSBjb2RlLgo+ID4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+IEl0IGNhbiB1dGlsaXplIHRoZSBl
eGlzdGluZyBmbG93IGRpc3NlY3RvciBhbmQgYWxzbyBtYWtlIGl0IGVhc2llciB0bwo+ID4+Pj4+
Pj4+Pj4gdXNlIGZvciB0aGUgdXNlcnNwYWNlIGJ5IGltcGxlbWVudGluZyB0aGlzIGluIHRoZSBr
ZXJuZWwuCj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+IE9rLiBUaGVyZSBkb2VzIGFwcGVhciB0byBi
ZSBvdmVybGFwIGluIGZ1bmN0aW9uYWxpdHkuIEJ1dCBpdCBtaWdodCBiZQo+ID4+Pj4+Pj4+PiBl
YXNpZXIgdG8gZGVwbG95IHRvIGp1c3QgaGF2ZSBzdGFuZGFyZCBUb2VwbGl0eiBhdmFpbGFibGUg
d2l0aG91dAo+ID4+Pj4+Pj4+PiBoYXZpbmcgdG8gY29tcGlsZSBhbmQgbG9hZCBhbiBlQlBGIHBy
b2dyYW0uCj4gPj4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4+IEFzIGZvciB0aGUgc2tfYnVmZiBhbmQgY2Jb
XSBjaGFuZ2VzLiBUaGUgZmlyc3QgaXMgcmVhbGx5IG5vdCBuZWVkZWQuCj4gPj4+Pj4+Pj4+IHNr
X2J1ZmYgc2ltcGx5IHdvdWxkIG5vdCBzY2FsZSBpZiBldmVyeSBlZGdlIGNhc2UgbmVlZHMgYSBm
ZXcgYml0cy4KPiA+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+IEFuIGFsdGVybmF0aXZlIGlzIHRvIG1vdmUg
dGhlIGJpdCB0byBjYltdIGFuZCBjbGVhciBpdCBmb3IgZXZlcnkgY29kZQo+ID4+Pj4+Pj4+IHBh
dGhzIHRoYXQgbGVhZCB0byBuZG9fc3RhcnRfeG1pdCgpLCBidXQgSSdtIHdvcnJpZWQgdGhhdCBp
dCBpcyBlcnJvci1wcm9uZS4KPiA+Pj4+Pj4+Pgo+ID4+Pj4+Pj4+IEkgdGhpbmsgd2UgY2FuIHB1
dCB0aGUgYml0IGluIHNrX2J1ZmYgZm9yIG5vdy4gV2UgY2FuIGltcGxlbWVudCB0aGUKPiA+Pj4+
Pj4+PiBhbHRlcm5hdGl2ZSB3aGVuIHdlIGFyZSBzaG9ydCBvZiBiaXRzLgo+ID4+Pj4+Pj4KPiA+
Pj4+Pj4+IEkgZGlzYWdyZWUuIHNrX2J1ZmYgZmllbGRzIGFkZCBhIGNvc3QgdG8gZXZlcnkgY29k
ZSBwYXRoLiBUaGV5IGNhbm5vdAo+ID4+Pj4+Pj4gYmUgYWRkZWQgZm9yIGV2ZXJ5IGVkZ2UgY2Fz
ZS4KPiA+Pj4+Pj4KPiA+Pj4+Pj4gSXQgb25seSB0YWtlcyBhbiB1bnVzZWQgYml0IGFuZCBkb2Vz
IG5vdCBncm93IHRoZSBza19idWZmIHNpemUgc28gSQo+ID4+Pj4+PiB0aGluayBpdCBoYXMgcHJh
Y3RpY2FsbHkgbm8gY29zdCBmb3Igbm93Lgo+ID4+Pj4+Cj4gPj4+Pj4gVGhlIHByb2JsZW0gaXMg
dGhhdCB0aGF0IHRoaW5raW5nIGxlYWRzIHRvIGRlYXRoIGJ5IGEgdGhvdXNhbmQgY3V0cy4KPiA+
Pj4+Pgo+ID4+Pj4+ICJmb3Igbm93IiBmb3JjZXMgdGhlIGNvc3Qgb2YgaGF2aW5nIHRvIHRoaW5r
IGhhcmQgaG93IHRvIGF2b2lkIGdyb3dpbmcKPiA+Pj4+PiBza19idWZmIG9udG8gdGhlIG5leHQg
cGVyc29uLiBMZXQncyBkbyBpdCByaWdodCBmcm9tIHRoZSBzdGFydC4KPiA+Pj4+Cj4gPj4+PiBJ
IHNlZS4gSSBkZXNjcmliZWQgYW4gYWx0ZXJuYXRpdmUgdG8gbW92ZSB0aGUgYml0IHRvIGNiW10g
YW5kIGNsZWFyIGl0Cj4gPj4+PiBpbiBhbGwgY29kZSBwYXRocyB0aGF0IGxlYWRzIHRvIG5kb19z
dGFydF94bWl0KCkgZWFybGllci4gRG9lcyB0aGF0Cj4gPj4+PiBzb3VuZCBnb29kIHRvIHlvdT8K
PiA+Pj4KPiA+Pj4gSWYgeW91IHVzZSB0aGUgY29udHJvbCBibG9jayB0byBwYXNzIGluZm9ybWF0
aW9uIGJldHdlZW4KPiA+Pj4gX19kZXZfcXVldWVfeG1pdCBvbiB0aGUgdHVuIGRldmljZSBhbmQg
dHVuX25ldF94bWl0LCB1c2luZyBnc29fc2tiX2NiLAo+ID4+PiB0aGUgZmllbGQgY2FuIGJlIGxl
ZnQgdW5kZWZpbmVkIGluIGFsbCBub24tdHVuIHBhdGhzLiB0dW5fc2VsZWN0X3F1ZXVlCj4gPj4+
IGNhbiBpbml0aWFsaXplLgo+ID4+Cj4gPj4gVGhlIHByb2JsZW0gaXMgdGhhdCB0dW5fc2VsZWN0
X3F1ZXVlKCkgaXMgbm90IGFsd2F5cyBjYWxsZWQuCj4gPj4gbmV0ZGV2X2NvcmVfcGlja190eCgp
IGVuc3VyZXMgZGV2LT5yZWFsX251bV90eF9xdWV1ZXMgIT0gMSBiZWZvcmUKPiA+PiBjYWxsaW5n
IGl0LCBidXQgdGhpcyB2YXJpYWJsZSBtYXkgY2hhbmdlIGxhdGVyIGFuZCByZXN1bHQgaW4gYSBy
YWNlCj4gPj4gY29uZGl0aW9uLiBBbm90aGVyIGNhc2UgaXMgdGhhdCBYRFAgd2l0aCBwcmVkZWZp
bmVkIHF1ZXVlLgo+ID4+Cj4gPj4+Cj4gPj4+IEkgd291bGQgc3RpbGwgdXNlIHNrYi0+aGFzaCB0
byBlbmNvZGUgdGhlIGhhc2guIFRoYXQgaGFzaCB0eXBlIG9mIHRoYXQKPiA+Pj4gZmllbGQgaXMg
bm90IHN0cmljdGx5IGRlZmluZWQuIEl0IGNhbiBiZSBzaXBoYXNoIGZyb20gX19fc2tiX2dldF9o
YXNoCj4gPj4+IG9yIGEgZGV2aWNlIGhhc2gsIHdoaWNoIG1vc3QgbGlrZWx5IGFsc28gdXNlcyBU
b2VwbGl0ei4gVGhlbiB5b3UgYWxzbwo+ID4+PiBkb24ndCBydW4gaW50byB0aGUgcHJvYmxlbSBv
ZiBncm93aW5nIHRoZSBzdHJ1Y3Qgc2l6ZS4KPiA+Pgo+ID4+IEknbSBjb25jZXJuZWQgZXhhY3Rs
eSBiZWNhdXNlIGl0J3Mgbm90IHN0cmljdGx5IGRlZmluZWQuIFNvbWVvbmUgbWF5Cj4gPj4gZGVj
aWRlIHRvIG92ZXJ3cml0ZSBpdCBsYXRlciBpZiB3ZSBhcmUgbm90IGNhdXRpb3VzIGVub3VnaC4g
cWRpc2Nfc2tiX2NiCj4gPj4gYWxzbyBoYXMgc3VmZmljaWVudCBzcGFjZSB0byBjb250YWluIGJv
dGggb2YgdGhlIGhhc2ggdmFsdWUgYW5kIHR5cGUuCj4gPgo+ID4gSG93IGFib3V0IHVzaW5nIHNr
YiBleHRlbnNpb25zPwo+Cj4gSSB0aGluayBpdCB3aWxsIHdvcmsuIEknbGwgdHJ5IGl0IGluIHRo
ZSBuZXh0IHZlcnNpb24uCgpCdHcsIEkgc3RpbGwgdGhpbmsgdXNpbmcgZUJQRiBmb3IgaGFzaCBt
aWdodCBiZSBiZXR0ZXIuCgpUaG91Z2ggdGhlIGhhc2hpbmcgcnVsZSBpcyBkZWZpbmVkIGluIHRo
ZSBzcGVjLCBpdCBtYXkgYmUgZXh0ZW5kZWQgaW4KdGhlIGZ1dHVyZS4gRm9yIGV4YW1wbGUsIHNl
dmVyYWwgZXh0ZW5zaW9ucyBoYXMgYmVlbiBwcm9wb3NlZDoKCjEpIFJTUyBjb250ZXh0CjIpIGVu
Y2Fwc3VsYXRlZCBwYWNrZXQgaGFzaGluZwoKVGhhbmtzCgo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
