Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9230ACE7A8B
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 02:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 072CD60F48;
	Mon, 25 Sep 2023 02:29:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 072CD60F48
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cxOOz86b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4ZiBogTcU6Nw; Mon, 25 Sep 2023 02:29:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E78260F3D;
	Mon, 25 Sep 2023 02:29:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E78260F3D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EE88C0039;
	Mon, 25 Sep 2023 02:29:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C705C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08D8D403F9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 08D8D403F9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cxOOz86b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tcxTEjFUyO1g
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:29:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 07E8F400B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:29:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07E8F400B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695608973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQji8DpwSIIsw+eDXmlvEKwYU33m0WIJJqnq5qT3Suc=;
 b=cxOOz86bQPW3u6ZWZJoGBAVFgg0KouP+52sb9+Rtl5BKKDqUP6l9C2wRuZODmhrPN2c5uH
 ErO91Y6MpY9r5JZ7uhu1urDlSa9Ta5hfJBhuf++jInmZUJn+hnRX+o3oziZFCK/jPMPeBp
 xTV++Hy6WlZgG0boIi5CynvVimt/zaU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-YtiiTj48OkavPOA-nYfZyw-1; Sun, 24 Sep 2023 22:29:29 -0400
X-MC-Unique: YtiiTj48OkavPOA-nYfZyw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2be51691dd5so72494271fa.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 19:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695608968; x=1696213768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQji8DpwSIIsw+eDXmlvEKwYU33m0WIJJqnq5qT3Suc=;
 b=styA+POPIZIlnJdhi7vKKQXyGcj5+HOCY/JUWbZOB2bjiQPZru/mbQ80f8BygPDMuc
 DihIBX+HQ50V0nlg56VAvZE8/BXF7FLIO4Qqn6jMy2oNm6WmqQpKsCS8V7pjzoCIZjZn
 nRu+h8Rn7coT/hMTzGY8Kzo8F+o/5KZ3TzHCD4ytMJFyLEhCj3hBZ4nYtM2KHaDH2Q9L
 nChUl8atKAEAbhsIJF9roAovA/i571U9FHIRiNJ9OUdiK37BNSObTOWLyTxvERfrphpY
 AkpGJmTIAVATWCWrlKZ3stXyl9XRBCKYgucUN2bRU9ukuneX8UH5r+VQnnntX3zwTzSF
 EnbA==
X-Gm-Message-State: AOJu0YxovjlGrgh8H2SuNw99HlnylXPiHOWIJv99g/b9T0rFNWcaoSH3
 o8wzXI8jpy+1qL1JegDyFyJ02fS8b8NbuCtRt7NAq8SY3E+OfXXmv7ksQzOSNeL69NoJ5OMAT1/
 S3nXrwjVFmuPiqA8i3bUAZli4QDlXxwS0kC0e3e+POdpNcPmOLil9yU0/Tg==
X-Received: by 2002:a05:6512:2343:b0:503:38fe:4590 with SMTP id
 p3-20020a056512234300b0050338fe4590mr5336851lfu.60.1695608968393; 
 Sun, 24 Sep 2023 19:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMMV42sNZlyWoIXBLG6Ym2vUy9Ev7e/8KiM0YW/RYCoVUR2vamIuZj3LPvNqLgK5FfVXmLps3t7aECzG5gmCQ=
X-Received: by 2002:a05:6512:2343:b0:503:38fe:4590 with SMTP id
 p3-20020a056512234300b0050338fe4590mr5336832lfu.60.1695608967966; Sun, 24 Sep
 2023 19:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-6-hengqi@linux.alibaba.com>
 <CACGkMEuJjxAmr6WC9ETYAw2K9dp0AUoD6LSZCduQyUQ9y7oM3Q@mail.gmail.com>
 <c95274cd-d119-402b-baf1-0c500472c9fb@linux.alibaba.com>
 <CACGkMEv4me_mjRJ8wEd-w_b9tjo370d6idioCTmFwJo-3TH3-A@mail.gmail.com>
 <2ffd0e15-107e-4c46-8d98-caf47ff6a0c6@linux.alibaba.com>
In-Reply-To: <2ffd0e15-107e-4c46-8d98-caf47ff6a0c6@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Sep 2023 10:29:17 +0800
Message-ID: <CACGkMEtbCSxOQDmrEySgdEWG49SOi3UFYkLMjmjF6=5m8F93xg@mail.gmail.com>
Subject: Re: [PATCH net 5/6] virtio-net: fix the vq coalescing setting for vq
 resize
To: Heng Qi <hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMzo1OOKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPgo+Cj4g5ZyoIDIwMjMvOS8yMiDkuIvljYgzOjMyLCBKYXNv
biBXYW5nIOWGmemBkzoKPiA+IE9uIEZyaSwgU2VwIDIyLCAyMDIzIGF0IDE6MDLigK9QTSBIZW5n
IFFpIDxoZW5ncWlAbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4+Cj4gPj4KPiA+PiDlnKgg
MjAyMy85LzIyIOS4i+WNiDEyOjI5LCBKYXNvbiBXYW5nIOWGmemBkzoKPiA+Pj4gT24gVHVlLCBT
ZXAgMTksIDIwMjMgYXQgMzo0OeKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5hbGliYWJhLmNv
bT4gd3JvdGU6Cj4gPj4+PiBBY2NvcmRpbmcgdG8gdGhlIGRlZmluaXRpb24gb2YgdmlydHF1ZXVl
IGNvYWxlc2Npbmcgc3BlY1sxXToKPiA+Pj4+Cj4gPj4+PiAgICAgVXBvbiBkaXNhYmxpbmcgYW5k
IHJlLWVuYWJsaW5nIGEgdHJhbnNtaXQgdmlydHF1ZXVlLCB0aGUgZGV2aWNlIE1VU1Qgc2V0Cj4g
Pj4+PiAgICAgdGhlIGNvYWxlc2NpbmcgcGFyYW1ldGVycyBvZiB0aGUgdmlydHF1ZXVlIHRvIHRo
b3NlIGNvbmZpZ3VyZWQgdGhyb3VnaCB0aGUKPiA+Pj4+ICAgICBWSVJUSU9fTkVUX0NUUkxfTk9U
Rl9DT0FMX1RYX1NFVCBjb21tYW5kLCBvciwgaWYgdGhlIGRyaXZlciBkaWQgbm90IHNldAo+ID4+
Pj4gICAgIGFueSBUWCBjb2FsZXNjaW5nIHBhcmFtZXRlcnMsIHRvIDAuCj4gPj4+Pgo+ID4+Pj4g
ICAgIFVwb24gZGlzYWJsaW5nIGFuZCByZS1lbmFibGluZyBhIHJlY2VpdmUgdmlydHF1ZXVlLCB0
aGUgZGV2aWNlIE1VU1Qgc2V0Cj4gPj4+PiAgICAgdGhlIGNvYWxlc2NpbmcgcGFyYW1ldGVycyBv
ZiB0aGUgdmlydHF1ZXVlIHRvIHRob3NlIGNvbmZpZ3VyZWQgdGhyb3VnaCB0aGUKPiA+Pj4+ICAg
ICBWSVJUSU9fTkVUX0NUUkxfTk9URl9DT0FMX1JYX1NFVCBjb21tYW5kLCBvciwgaWYgdGhlIGRy
aXZlciBkaWQgbm90IHNldAo+ID4+Pj4gICAgIGFueSBSWCBjb2FsZXNjaW5nIHBhcmFtZXRlcnMs
IHRvIDAuCj4gPj4+Pgo+ID4+Pj4gV2UgbmVlZCB0byBhZGQgdGhpcyBzZXR0aW5nIGZvciB2cSBy
ZXNpemUgKGV0aHRvb2wgLUcpIHdoZXJlIHZxX3Jlc2V0IGhhcHBlbnMuCj4gPj4+Pgo+ID4+Pj4g
WzFdIGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWRldi8yMDIz
MDMvbXNnMDA0MTUuaHRtbAo+ID4+Pj4KPiA+Pj4+IEZpeGVzOiAzOTRiZDg3NzY0YjYgKCJ2aXJ0
aW9fbmV0OiBzdXBwb3J0IHBlciBxdWV1ZSBpbnRlcnJ1cHQgY29hbGVzY2UgY29tbWFuZCIpCj4g
Pj4+IEknbSBub3Qgc3VyZSB0aGlzIGlzIGEgcmVhbCBmaXggYXMgc3BlYyBhbGxvd3MgaXQgdG8g
Z28gemVybz8KPiA+PiBUaGUgc3BlYyBzYXlzIHRoYXQgaWYgdGhlIHVzZXIgaGFzIGNvbmZpZ3Vy
ZWQgaW50ZXJydXB0IGNvYWxlc2NpbmcKPiA+PiBwYXJhbWV0ZXJzLAo+ID4+IHBhcmFtZXRlcnMg
bmVlZCB0byBiZSByZXN0b3JlZCBhZnRlciB2cV9yZXNldCwgb3RoZXJ3aXNlIHNldCB0byAwLgo+
ID4+IHZpLT5pbnRyX2NvYWxfdHggYW5kIHZpLT5pbnRyX2NvYWxfcnggYWx3YXlzIHNhdmUgdGhl
IG5ld2VzdCBnbG9iYWwKPiA+PiBwYXJhbWV0ZXJzLAo+ID4+IHJlZ2FyZGxlc3Mgb2Ygd2hldGhl
ciB0aGUgY29tbWFuZCBpcyBzZW50IG9yIG5vdC4gU28gSSB0aGluayB3ZSBuZWVkCj4gPj4gdGhp
cyBwYXRjaAo+ID4+IGl0IGNvbXBsaWVzIHdpdGggdGhlIHNwZWNpZmljYXRpb24gcmVxdWlyZW1l
bnRzLgo+ID4gSG93IGNhbiB3ZSBtYWtlIHN1cmUgdGhlIG9sZCBjb2FsZXNjaW5nIHBhcmFtZXRl
cnMgc3RpbGwgbWFrZSBzZW5zZQo+ID4gZm9yIHRoZSBuZXcgcmluZyBzaXplPwo+Cj4gSSdtIG5v
dCBzdXJlLCByaW5nc2l6ZSBoYXMgYSB3aWRlciByYW5nZSBvZiBjaGFuZ2VzLiBNYXliZSB3ZSBz
aG91bGQKPiBvbmx5IGtlZXAgY29hbGVzY2luZwo+IHBhcmFtZXRlcnMgaW4gY2FzZXMgd2hlcmUg
b25seSB2cV9yZXNldCBvY2N1cnMgKG5vIHJpbmcgc2l6ZSBjaGFuZ2UKPiBpbnZvbHZlZCk/CgpQ
cm9iYWJseSBidXQgZG8gd2UgYWN0dWFsbHkgaGF2ZSBhIHVzZXIgb3RoZXIgdGhhbiByZXNpemUg
bm93PwoKVGhhbmtzCgo+Cj4gVGhhbmtzIQo+Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4+IFRoYW5r
cyEKPiA+Pgo+ID4+PiBUaGFua3MKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
