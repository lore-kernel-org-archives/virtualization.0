Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51220C7619A
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 02:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C29A41553;
	Mon,  3 Apr 2023 02:46:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C29A41553
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ejqQaAOy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v_39SA7SsXUI; Mon,  3 Apr 2023 02:46:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9B4BD410C6;
	Mon,  3 Apr 2023 02:46:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B4BD410C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69691C0037;
	Mon,  3 Apr 2023 02:46:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3DCBC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 02:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E955403F8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 02:46:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E955403F8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ejqQaAOy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hOP-sTjAtZNr
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 02:46:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C27444013D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C27444013D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 02:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680490012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXT/6aJaAFqn+Kdcq/fX5XU9hNNDC+uvyYrVFSSigv8=;
 b=ejqQaAOyxYvDzRvK3ygiMVkS8gC24LkpKnjamHckIc+pYKttPJfBIUIZSYEu7wtN+md+Fg
 zxDu13Cy5RnJI1ZJXjghr3WgC+MrXFkBPJZQBKEmDYLZZ0rbCsbGfj7x3BLMZ7RQTYyJP2
 nZ9iZNNHSxYwAdBiQpY9Sqnzx60FGaw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-jw1f4p7VMsuAbr5K9DNxqg-1; Sun, 02 Apr 2023 22:46:51 -0400
X-MC-Unique: jw1f4p7VMsuAbr5K9DNxqg-1
Received: by mail-oi1-f200.google.com with SMTP id
 bl28-20020a056808309c00b00387498386a8so6554856oib.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 02 Apr 2023 19:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680490011; x=1683082011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXT/6aJaAFqn+Kdcq/fX5XU9hNNDC+uvyYrVFSSigv8=;
 b=VDJ81eM9OxcePNg53lM14zypxLXGkAkGJ89x38QoHwUB79vGE4TjFKcRqF8WwVPYE0
 k5AFQh9Stq+H+XGRdy5sjXh5PtJFIJOo/adXx9pYH5klmRPaEHxWNEya6/Jdbg4aps8B
 FbqFrsWPbTR2OWrxiX9TW9XI+5S/v6cunPxtHevioW9oLebZeb8UZ3HQMEn7mSgIxKN9
 vGHlEWy1NCEQBroqOCyWZHf+218+PvbwDr6Xyom035yauE9RoOCGrE9J4pBIRA3vjJHs
 AckxV+VxB25ESiVDSAqTLzZJg8kEYb70dK3/qWKF4k6m41agcm7qwvqviXWnx8aW/pdw
 B+iw==
X-Gm-Message-State: AO0yUKUiTXlCrJBqKHvTZEc5jQRp+Ukpd3AAnR7rnAYekoHLnYbOSEpt
 DTfAuhCiZGgYhIIv1PDqfBolWEkm6TRax1Hi+XU4RJsp1ZpRgoYdutFClm4PvjzSTd34B3993Ju
 TUBHYp9NA6seDdrF9alQGTB1RW0CDVbBUXzy7W8yqWd9x8gY4oAd2MDdOZw==
X-Received: by 2002:a4a:a28a:0:b0:525:2b3b:7453 with SMTP id
 h10-20020a4aa28a000000b005252b3b7453mr10890510ool.0.1680490010932; 
 Sun, 02 Apr 2023 19:46:50 -0700 (PDT)
X-Google-Smtp-Source: AK7set9dweL2R/ZOkTjHu4vsan6RXJ8ez4+ot09bhRJuDhHtHDmXSGAsQ+yY1sL/XLcZP8/opt6udhmUV8gRh09VAYo=
X-Received: by 2002:a4a:a28a:0:b0:525:2b3b:7453 with SMTP id
 h10-20020a4aa28a000000b005252b3b7453mr10890503ool.0.1680490010690; Sun, 02
 Apr 2023 19:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230328120412.110114-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Apr 2023 10:46:39 +0800
Message-ID: <CACGkMEurBLHds7Am=pBm9vTWvWczVfQoOJ_wCJWVBxuyHXzsfA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] virtio_net: separate the logic of freeing
 the rest mergeable buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgODowNOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2UgYSBuZXcgZnVu
Y3Rpb24gdGhhdCBmcmVlcyB0aGUgcmVzdCBtZXJnZWFibGUgYnVmLgo+IFRoZSBzdWJzZXF1ZW50
IHBhdGNoIHdpbGwgcmV1c2UgdGhpcyBmdW5jdGlvbi4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiBpbmRleCAwOWFlZDYwZTJmNTEuLmEzZjJiY2IzZGIyNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAt
MTA3Niw2ICsxMDc2LDI4IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9iaWcoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgICAgICAgIHJldHVybiBOVUxMOwo+ICB9Cj4KPiArc3Rh
dGljIHZvaWQgbWVyZ2VhYmxlX2J1Zl9mcmVlKHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwgaW50
IG51bV9idWYsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0bmV0
X3JxX3N0YXRzICpzdGF0cykKPiArewo+ICsgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2U7Cj4gKyAg
ICAgICB2b2lkICpidWY7Cj4gKyAgICAgICBpbnQgbGVuOwo+ICsKPiArICAgICAgIHdoaWxlIChu
dW1fYnVmLS0gPiAxKSB7Cj4gKyAgICAgICAgICAgICAgIGJ1ZiA9IHZpcnRxdWV1ZV9nZXRfYnVm
KHJxLT52cSwgJmxlbik7Cj4gKyAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSghYnVmKSkgewo+
ICsgICAgICAgICAgICAgICAgICAgICAgIHByX2RlYnVnKCIlczogcnggZXJyb3I6ICVkIGJ1ZmZl
cnMgbWlzc2luZ1xuIiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXYtPm5h
bWUsIG51bV9idWYpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldi0+c3RhdHMucnhfbGVu
Z3RoX2Vycm9ycysrOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAg
ICAgICAgICB9Cj4gKyAgICAgICAgICAgICAgIHN0YXRzLT5ieXRlcyArPSBsZW47Cj4gKyAgICAg
ICAgICAgICAgIHBhZ2UgPSB2aXJ0X3RvX2hlYWRfcGFnZShidWYpOwo+ICsgICAgICAgICAgICAg
ICBwdXRfcGFnZShwYWdlKTsKPiArICAgICAgIH0KPiArfQo+ICsKPiAgLyogV2h5IG5vdCB1c2Ug
eGRwX2J1aWxkX3NrYl9mcm9tX2ZyYW1lKCkgPwo+ICAgKiBYRFAgY29yZSBhc3N1bWVzIHRoYXQg
eGRwIGZyYWdzIGFyZSBQQUdFX1NJWkUgaW4gbGVuZ3RoLCB3aGlsZSBpbgo+ICAgKiB2aXJ0aW8t
bmV0IHRoZXJlIGFyZSAyIHBvaW50cyB0aGF0IGRvIG5vdCBtYXRjaCBpdHMgcmVxdWlyZW1lbnRz
Ogo+IEBAIC0xNDM2LDE4ICsxNDU4LDggQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZl
X21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgICAgICAgc3RhdHMtPnhkcF9k
cm9wcysrOwo+ICBlcnJfc2tiOgo+ICAgICAgICAgcHV0X3BhZ2UocGFnZSk7Cj4gLSAgICAgICB3
aGlsZSAobnVtX2J1Zi0tID4gMSkgewo+IC0gICAgICAgICAgICAgICBidWYgPSB2aXJ0cXVldWVf
Z2V0X2J1ZihycS0+dnEsICZsZW4pOwo+IC0gICAgICAgICAgICAgICBpZiAodW5saWtlbHkoIWJ1
ZikpIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICBwcl9kZWJ1ZygiJXM6IHJ4IGVycm9yOiAl
ZCBidWZmZXJzIG1pc3NpbmdcbiIsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZGV2LT5uYW1lLCBudW1fYnVmKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICBkZXYtPnN0YXRz
LnJ4X2xlbmd0aF9lcnJvcnMrKzsKPiAtICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAt
ICAgICAgICAgICAgICAgfQo+IC0gICAgICAgICAgICAgICBzdGF0cy0+Ynl0ZXMgKz0gbGVuOwo+
IC0gICAgICAgICAgICAgICBwYWdlID0gdmlydF90b19oZWFkX3BhZ2UoYnVmKTsKPiAtICAgICAg
ICAgICAgICAgcHV0X3BhZ2UocGFnZSk7Cj4gLSAgICAgICB9Cj4gKyAgICAgICBtZXJnZWFibGVf
YnVmX2ZyZWUocnEsIG51bV9idWYsIGRldiwgc3RhdHMpOwo+ICsKPiAgZXJyX2J1ZjoKPiAgICAg
ICAgIHN0YXRzLT5kcm9wcysrOwo+ICAgICAgICAgZGV2X2tmcmVlX3NrYihoZWFkX3NrYik7Cj4g
LS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
