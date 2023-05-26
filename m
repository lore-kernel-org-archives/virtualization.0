Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF914C7EE2F
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 06:39:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5792C427CF;
	Fri, 26 May 2023 06:39:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5792C427CF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WLMbS94x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SmiUE0wT6CyR; Fri, 26 May 2023 06:39:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 991E2427CE;
	Fri, 26 May 2023 06:39:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 991E2427CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74544C0036;
	Fri, 26 May 2023 06:39:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5CECC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A30F0841E2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:39:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A30F0841E2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WLMbS94x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4DH4KWFUrt49
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:39:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7897983EBE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7897983EBE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685083149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+bs/EeksfHI43M3AGFfTiuW/uRtRdXfogNY4shc8y0=;
 b=WLMbS94xPsz+u7Wie7Ayi82I70i2vj2Rr7bz452sX4SdjFMpS9nufnsXPcxZhrLqRlZLEJ
 ZFThEwWBZXOJS7Rmki9rZ/YeBxDsUXoGLzbLeA23YBK00NcXIaFJX0/bVTHAz1Doj5w4UZ
 cZjUta8gbKrja2bJj8tnJrOL5kcTkXY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-551FdzeNOdS0JEDaaKMEcQ-1; Fri, 26 May 2023 02:39:07 -0400
X-MC-Unique: 551FdzeNOdS0JEDaaKMEcQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f4b2a2040bso186013e87.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 23:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685083146; x=1687675146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+bs/EeksfHI43M3AGFfTiuW/uRtRdXfogNY4shc8y0=;
 b=ZV+vjFmY4TkTKuOPp1FC+raw4vMg93D4iOXfW0Or3uVnY4X8KUIfUry7Bn3Gdx0TpU
 3nLNLlvyYKtyGDKn52by4MMyZU8VKKD2bdPJTRvlYYm6oopKszQFDHqUDKR+ivrR73Sr
 Vinb/Kl79ZYSMDsttyaYXrJCsAKz5D0zJU2a28aiU588yQD5cinQHU0+KN8t0POk16F2
 IYo2v/R/Nf0nMxTa8QF/yX/5fbmeEefLMYHOKcduwdoToQywlZqYrU8waCFQU4m5T9jq
 jktOVmGTZjrItZyLUm94AHtu7P0M2lbZ+y7pDm7Y+VgOVTbc2Rt+8ae4unqivuxUcFIt
 62eg==
X-Gm-Message-State: AC+VfDyfsPsg4Uxr/ZOxDvx59GeHO5gr3L7c0mF4SBtNgzrgnsX4Thy+
 IKqZ7A+CMLaYWocj/9KI9usiEM35UQg+TsAsM8qY+Idr8X+wohdsndgbkheNtFkh6ZWC1MNBGLD
 DFg5vq3+7d+YI8430ngnHPuptYV3Pq/yfnrvEQ1jxmlq8/59abKAKXxQshQ==
X-Received: by 2002:ac2:5584:0:b0:4f3:ba53:35f2 with SMTP id
 v4-20020ac25584000000b004f3ba5335f2mr348207lfg.49.1685083145941; 
 Thu, 25 May 2023 23:39:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ZGMBvmDOnk6A1M9x8uXTgZpQopDuFIrCe6DF0zYSEQVhyP15JnRWL7SWoXzSYalkqHdBnvbODVvBx4F4Izbo=
X-Received: by 2002:ac2:5584:0:b0:4f3:ba53:35f2 with SMTP id
 v4-20020ac25584000000b004f3ba5335f2mr348187lfg.49.1685083145623; Thu, 25 May
 2023 23:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
In-Reply-To: <20230526054621.18371-1-liangchen.linux@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 May 2023 14:38:54 +0800
Message-ID: <CACGkMEuUTNfHXQPg29eUZFnVBRJEmjjKN4Jmr3=Qnkgjj0B9PQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] virtio_net: Fix an unsafe reference to the
 page chain
To: Liang Chen <liangchen.linux@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
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

T24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMTo0NuKAr1BNIExpYW5nIENoZW4gPGxpYW5nY2hlbi5s
aW51eEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gInByaXZhdGUiIG9mIGJ1ZmZlciBwYWdlIGlzIGN1
cnJlbnRseSB1c2VkIGZvciBiaWcgbW9kZSB0byBjaGFpbiBwYWdlcy4KPiBCdXQgaW4gbWVyZ2Vh
YmxlIG1vZGUsIHRoYXQgb2Zmc2V0IG9mIHBhZ2UgY291bGQgbWVhbiBzb21ldGhpbmcgZWxzZSwK
PiBlLmcuIHdoZW4gcGFnZV9wb29sIHBhZ2UgaXMgdXNlZCBpbnN0ZWFkLiBTbyBleGNsdWRpbmcg
bWVyZ2VhYmxlIG1vZGUgdG8KPiBhdm9pZCBzdWNoIGEgcHJvYmxlbS4KCklmIHRoaXMgaXNzdWUg
aGFwcGVucyBvbmx5IGluIHRoZSBjYXNlIG9mIHBhZ2VfcG9vbCwgaXQgd291bGQgYmUKYmV0dGVy
IHRvIHNxdWFzaCBpdCB0aGVyZS4KClRoYW5rcwoKPgo+IFNpZ25lZC1vZmYtYnk6IExpYW5nIENo
ZW4gPGxpYW5nY2hlbi5saW51eEBnbWFpbC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRp
b19uZXQuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggNWE3ZjdhNzZiOTIwLi5jNWRjYTBkOTJlNjQgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gQEAgLTQ5Nyw3ICs0OTcsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYg
KnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBOVUxMOwo+Cj4gICAgICAgICAgICAgICAgIHBhZ2UgPSAoc3RydWN0IHBh
Z2UgKilwYWdlLT5wcml2YXRlOwo+IC0gICAgICAgICAgICAgICBpZiAocGFnZSkKPiArICAgICAg
ICAgICAgICAgaWYgKCF2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMgJiYgcGFnZSkKPiAgICAgICAgICAg
ICAgICAgICAgICAgICBnaXZlX3BhZ2VzKHJxLCBwYWdlKTsKPiAgICAgICAgICAgICAgICAgZ290
byBvazsKPiAgICAgICAgIH0KPiAtLQo+IDIuMzEuMQo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
