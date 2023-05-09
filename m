Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C43C77B75
	for <virtualization@archiver.kernel.org>; Tue,  9 May 2023 03:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F19342A91;
	Tue,  9 May 2023 03:14:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F19342A91
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cMFDnp88
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AxU6wEvaJQrs; Tue,  9 May 2023 03:14:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 52D6641DB5;
	Tue,  9 May 2023 03:14:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 52D6641DB5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3741DC0037;
	Tue,  9 May 2023 03:14:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1CE9C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 03:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A648E61638
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 03:14:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A648E61638
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cMFDnp88
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K19OjWX60Nbm
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 03:14:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A58561485
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A58561485
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 03:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683602087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ld87/slb6DhEyhzdo2ZLKHyFwRbfschMCykFI8qBdcQ=;
 b=cMFDnp88//rdXvR///7ig47EbRCG08A5bhVje0vv5AuEax8GPsOBtjYdw92u4dc6wos67+
 yXoz4JqrZ61pj8mLVT8FrcvCju9zj+3Wktt6m/sH0sBxvzGxx5ElXJKCjNm0Jvb6Hn/7Im
 SVvXzTBvvvdtKGNU5vUycgAIWQ5UAu4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-hWgjZ6mYPIicVBTI0Lv3jw-1; Mon, 08 May 2023 23:14:43 -0400
X-MC-Unique: hWgjZ6mYPIicVBTI0Lv3jw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4edb90ccaadso2902732e87.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 May 2023 20:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683602082; x=1686194082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ld87/slb6DhEyhzdo2ZLKHyFwRbfschMCykFI8qBdcQ=;
 b=ONC/8qG9b0exsMuM+5/JcHLxZ8YTuZ4yEV4Wl6mDqlDy8OPpKmFvP3h8mSAGlnoBCM
 XWmAsSQYVtNsDZ/GgXV0BZElKUyLzpvEDKa+Gzofw9bmRCkVeyQWB6VYHlEfbPd0jrTs
 ljp9pOlkU1q8DzRKU+wTx2Z/OYbiarHssk3oYwCsmmPwJUvSK+dGlcH/ds6ynipyGHuX
 hhRM26w5ZXgxBCik4Lgf+ydBGLXjzajgDcjOZA16wFHW852JrkVIhxoXvBB+7QV7dET2
 GJRxSt/352l8hjoZjZP8pDlc2ZY33bTyFzIEQdgkGsLgaPXcXMTc6Fzh6q2TSqKOOlFD
 y/HQ==
X-Gm-Message-State: AC+VfDwZnAOEEjtYRhLUrqXH1DCzSOJ1CIGfg3xYTwglVFymu5+7qPzk
 Ziz9Zq6+e/NjWAV04RyFUWXaPA0AP2MiSfW2iTvHI3tqJsMS3U44Chiz56o43W4J/p9yrPBfQrQ
 H6/8+ItF72aUeaweXleHdxt8GgZLhI1xDY+G/B4BrSHxcQSY84kKcV340Yw==
X-Received: by 2002:a2e:b709:0:b0:2a7:b0b4:4fa with SMTP id
 j9-20020a2eb709000000b002a7b0b404famr347556ljo.12.1683602082260; 
 Mon, 08 May 2023 20:14:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79eiCfzLyk9Oyqt17OGFinhWOXT+nm7R+MDoGAfwhOe5u+yBG9Ddqg3s68GG6hamkZC0LkhQFQeQghV6pd5tQ=
X-Received: by 2002:a2e:b709:0:b0:2a7:b0b4:4fa with SMTP id
 j9-20020a2eb709000000b002a7b0b404famr347548ljo.12.1683602081962; Mon, 08 May
 2023 20:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
 <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
 <20230507093328-mutt-send-email-mst@kernel.org>
 <2b5cf90a-efa8-52a7-9277-77722622c128@redhat.com>
 <20230508020717-mutt-send-email-mst@kernel.org>
 <CACGkMEuQdy8xi=eD4v7-UNQ12xOUdnuyQ73vvC6vdGXUfeasug@mail.gmail.com>
 <20230508024433-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230508024433-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 May 2023 11:14:30 +0800
Message-ID: <CACGkMEuYcR21_k0hyisWzTVHG4+a3Y=ym101Z5P8TSWyNkHWxA@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, willemdebruijn.kernel@gmail.com,
 Wenliang Wang <wangwenliang.1995@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gTW9uLCBNYXkgOCwgMjAyMyBhdCAyOjQ34oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIE1heSAwOCwgMjAyMyBhdCAwMjoxMzo0MlBN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gTW9uLCBNYXkgOCwgMjAyMyBhdCAyOjA4
4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+Cj4g
PiA+IE9uIE1vbiwgTWF5IDA4LCAyMDIzIGF0IDExOjEyOjAzQU0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiDlnKggMjAyMy81LzcgMjE6MzQsIE1pY2hhZWwgUy4gVHNp
cmtpbiDlhpnpgZM6Cj4gPiA+ID4gPiBPbiBGcmksIE1heSAwNSwgMjAyMyBhdCAxMToyODoyNUFN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBUaHUsIE1heSA0LCAyMDIz
IGF0IDEwOjI34oCvQU0gV2VubGlhbmcgV2FuZwo+ID4gPiA+ID4gPiA8d2FuZ3dlbmxpYW5nLjE5
OTVAYnl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gRm9yIG11bHRpLXF1ZXVlIGFu
ZCBsYXJnZSByaW5nLXNpemUgdXNlIGNhc2UsIHRoZSBmb2xsb3dpbmcgZXJyb3IKPiA+ID4gPiA+
ID4gPiBvY2N1cnJlZCB3aGVuIGZyZWVfdW51c2VkX2J1ZnM6Cj4gPiA+ID4gPiA+ID4gcmN1OiBJ
TkZPOiByY3Vfc2NoZWQgc2VsZi1kZXRlY3RlZCBzdGFsbCBvbiBDUFUuCj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiBGaXhlczogOTg2YTRmNGQ0NTJkICgidmlydGlvX25ldDogbXVsdGlxdWV1
ZSBzdXBwb3J0IikKPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBXZW5saWFuZyBXYW5nIDx3
YW5nd2VubGlhbmcuMTk5NUBieXRlZGFuY2UuY29tPgo+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+
ID4gPiA+IHYyOgo+ID4gPiA+ID4gPiA+IC1hZGQgbmVlZF9yZXNjaGVkIGNoZWNrLgo+ID4gPiA+
ID4gPiA+IC1hcHBseSBzYW1lIGxvZ2ljIHRvIHNxLgo+ID4gPiA+ID4gPiA+IHYzOgo+ID4gPiA+
ID4gPiA+IC11c2UgY29uZF9yZXNjaGVkIGluc3RlYWQuCj4gPiA+ID4gPiA+ID4gdjQ6Cj4gPiA+
ID4gPiA+ID4gLWFkZCBmaXhlcyB0YWcKPiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiAg
IGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIgKysKPiA+ID4gPiA+ID4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiA+ID4gPiA+ID4gPiBpbmRleCA4ZDgwMzg1MzhmYzQuLmExMmFlMjZkYjBlMiAxMDA2NDQK
PiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4g
PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4gPiBAQCAtMzU2MCwx
MiArMzU2MCwxNCBAQCBzdGF0aWMgdm9pZCBmcmVlX3VudXNlZF9idWZzKHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpKQo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRxdWV1
ZSAqdnEgPSB2aS0+c3FbaV0udnE7Cj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICB3aGls
ZSAoKGJ1ZiA9IHZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1Zih2cSkpICE9IE5VTEwpCj4gPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRuZXRfc3FfZnJlZV91bnVzZWRf
YnVmKHZxLCBidWYpOwo+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBjb25kX3Jlc2NoZWQo
KTsKPiA+ID4gPiA+ID4gRG9lcyB0aGlzIHJlYWxseSBhZGRyZXNzIHRoZSBjYXNlIHdoZW4gdGhl
IHZpcnRxdWV1ZSBpcyB2ZXJ5IGxhcmdlPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFua3MK
PiA+ID4gPiA+Cj4gPiA+ID4gPiBpdCBkb2VzIGluIHRoYXQgYSB2ZXJ5IGxhcmdlIHF1ZXVlIGlz
IHN0aWxsIGp1c3QgNjRrIGluIHNpemUuCj4gPiA+ID4gPiB3ZSBtaWdodCBob3dldmVyIGhhdmUg
NjRrIG9mIHRoZXNlIHF1ZXVlcy4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gT2ssIGJ1dCB3ZSBo
YXZlIG90aGVyIHNpbWlsYXIgbG9vcHMgZXNwZWNpYWxseSB0aGUgcmVmaWxsLCBJIHRoaW5rIHdl
IG1heQo+ID4gPiA+IG5lZWQgY29uZF9yZXNjaGVkKCkgdGhlcmUgYXMgd2VsbC4KPiA+ID4gPgo+
ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+Cj4gPiA+IFJlZmlsbCBpcyBhbHJlYWR5IHBlciB2
cSBpc24ndCBpdD8KPiA+Cj4gPiBOb3QgZm9yIHRoZSByZWZpbGxfd29yaygpLgo+ID4KPiA+IFRo
YW5rcwo+Cj4gR29vZCBwb2ludCwgcmVmaWxsX3dvcmsgcHJvYmFibHkgbmVlZHMgY29uZF9yZXNj
aGVkLCB0b28uCj4gQW5kIEkgZ3Vlc3MgdmlydG5ldF9vcGVuPwoKWWVzLCBsZXQgbWUgZHJhZnQg
YSBwYXRjaC4KClRoYW5rcwoKPgo+Cj4gPiA+Cj4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ICAgICAgICAgIH0KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICAgICAgICAgIGZvciAoaSA9
IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPiA+ID4gPiA+ID4gPiAgICAgICAg
ICAgICAgICAgIHN0cnVjdCB2aXJ0cXVldWUgKnZxID0gdmktPnJxW2ldLnZxOwo+ID4gPiA+ID4g
PiA+ICAgICAgICAgICAgICAgICAgd2hpbGUgKChidWYgPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNl
ZF9idWYodnEpKSAhPSBOVUxMKQo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1Zih2cSwgYnVmKTsKPiA+ID4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgY29uZF9yZXNjaGVkKCk7Cj4gPiA+ID4gPiA+ID4gICAgICAgICAgfQo+ID4g
PiA+ID4gPiA+ICAgfQo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4g
PiAyLjIwLjEKPiA+ID4gPiA+ID4gPgo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
