Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68373C678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 05:21:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B16760FAA;
	Wed,  8 Mar 2023 05:21:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B16760FAA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q1FajQGg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZyrGAlNYmooH; Wed,  8 Mar 2023 05:21:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6A6E760FC8;
	Wed,  8 Mar 2023 05:21:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A6E760FC8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 533CCC0035;
	Wed,  8 Mar 2023 05:21:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F4132C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:21:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB9E481446
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:21:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB9E481446
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q1FajQGg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V9QXKrSJl8zw
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:21:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E9C08143A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E9C08143A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678252863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+mi5gjnaOx380nBD5pAWR2mHshCrXnFR/oJxmDZn5Y=;
 b=Q1FajQGgcE/N4hLYjuJfK/VsFxGfK721at157Cb5FnIZxuzM9JaUlJc/+ERfk5Ki3SCJHZ
 J0cRyx9KreuToPy5p7iGpJk7rUPVJE+ATryalLYhNwOV7W4CGqT5o18We1S415ztJ70rWg
 hwIwKT99YKIKphKtoO2rGWuwcbN4Qw0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-FQETnOj7OHSgvcnZf5MNsw-1; Wed, 08 Mar 2023 00:21:01 -0500
X-MC-Unique: FQETnOj7OHSgvcnZf5MNsw-1
Received: by mail-oo1-f70.google.com with SMTP id
 l6-20020a4ad9c6000000b005254392994fso4762000oou.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 21:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678252861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+mi5gjnaOx380nBD5pAWR2mHshCrXnFR/oJxmDZn5Y=;
 b=sSGlBkdUJH74/h/4Ax14JQz++KBbxmg/BKYv77B2XMWQFvPAvN+RiTcyfb+T70iI7U
 VhgfJqifWqo6h4zf+x1/WzkEOf8fu+PABP4HT0dJOnxDZUlQChO/TjbLUcRf2SroM+Mr
 6TzdSBo2BFj4V4uqETJIzV8uimKba/wPnNJs+ITijAu66F4jpnSV9djYqXz7/yA8Gld/
 hOJBjcnPDOWsfdV9xzQ1xkAYogWNlxLrbkCas4eXnwhBk3/BWdW54OM1hFoZAwNeWcJ7
 vFx6BbGpABxE7hHniigkNZNHCKduJTFPZR5a0X75+UrfDHeBNohJ0aOsmyXxQcHFnI03
 X3zA==
X-Gm-Message-State: AO0yUKVLm9SxJYE6wBY/THmPCc/Xzzmn9FXa/46l7q4lp2rCfdouAce3
 1GrXBXTp+U4ykSrwlVxYD51guTPHDbBBD1UC5/EPYZ8ea9eRYS8TaSXiUvljzK1qQzGQ4nIxlNS
 MBE2OWG8BJ10AarqmAua/Jz36HzRhAoi2+E7XG7I7JUN2AikFjNHjXi7yhA==
X-Received: by 2002:a9d:5a90:0:b0:688:cf52:6e18 with SMTP id
 w16-20020a9d5a90000000b00688cf526e18mr5498254oth.4.1678252861169; 
 Tue, 07 Mar 2023 21:21:01 -0800 (PST)
X-Google-Smtp-Source: AK7set8+m4PTMmjIE+rf6dEvf0HBVhV7J24buqH/dteNerinfhfp5VGK8zWTLp7xrUsFRbU+ugPmNGh8B3pZ5QN97uo=
X-Received: by 2002:a9d:5a90:0:b0:688:cf52:6e18 with SMTP id
 w16-20020a9d5a90000000b00688cf526e18mr5498248oth.4.1678252860960; Tue, 07 Mar
 2023 21:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20230308024935.91686-1-xuanzhuo@linux.alibaba.com>
 <20230308024935.91686-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230308024935.91686-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Mar 2023 13:20:50 +0800
Message-ID: <CACGkMEv9u5mnO8y5-q6etLecODfwfbr=-MoA5VVNc4CyvnUiuQ@mail.gmail.com>
Subject: Re: [PATCH net, stable v1 3/3] virtio_net: add checking sq is full
 inside xdp xmit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Yichun Zhang <yichun@openresty.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCBNYXIgOCwgMjAyMyBhdCAxMDo0OeKAr0FNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gSWYgdGhlIHF1ZXVlIG9mIHhkcCB4bWl0IGlzIG5v
dCBhbiBpbmRlcGVuZGVudCBxdWV1ZSwgdGhlbiB3aGVuIHRoZSB4ZHAKPiB4bWl0IHVzZWQgYWxs
IHRoZSBkZXNjLCB0aGUgeG1pdCBmcm9tIHRoZSBfX2Rldl9xdWV1ZV94bWl0KCkgbWF5IGVuY291
bnRlcgo+IHRoZSBmb2xsb3dpbmcgZXJyb3IuCj4KPiBuZXQgZW5zNDogVW5leHBlY3RlZCBUWFEg
KDApIHF1ZXVlIGZhaWx1cmU6IC0yOAo+Cj4gVGhpcyBwYXRjaCBhZGRzIGEgY2hlY2sgd2hldGhl
ciBzcSBpcyBmdWxsIGluIHhkcCB4bWl0Lgo+Cj4gRml4ZXM6IDU2NDM0YTAxYjEyZSAoInZpcnRp
b19uZXQ6IGFkZCBYRFBfVFggc3VwcG9ydCIpCj4gUmVwb3J0ZWQtYnk6IFlpY2h1biBaaGFuZyA8
eWljaHVuQG9wZW5yZXN0eS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1
b0BsaW51eC5hbGliYWJhLmNvbT4KPiBSZXZpZXdlZC1ieTogQWxleGFuZGVyIER1eWNrIDxhbGV4
YW5kZXJkdXlja0BmYi5jb20+Cj4gQWNrZWQtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRo
YW5rcwoKPiAtLS0KPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMyArKysKPiAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IDQ2YmJkZGFhZGIw
ZC4uMWEzMDljZmI0OTc2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+
ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC03NjcsNiArNzY3LDkgQEAgc3Rh
dGljIGludCB2aXJ0bmV0X3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAg
ICB9Cj4gICAgICAgICByZXQgPSBueG1pdDsKPgo+ICsgICAgICAgaWYgKCFpc194ZHBfcmF3X2J1
ZmZlcl9xdWV1ZSh2aSwgc3EgLSB2aS0+c3EpKQo+ICsgICAgICAgICAgICAgICBjaGVja19zcV9m
dWxsX2FuZF9kaXNhYmxlKHZpLCBkZXYsIHNxKTsKPiArCj4gICAgICAgICBpZiAoZmxhZ3MgJiBY
RFBfWE1JVF9GTFVTSCkgewo+ICAgICAgICAgICAgICAgICBpZiAodmlydHF1ZXVlX2tpY2tfcHJl
cGFyZShzcS0+dnEpICYmIHZpcnRxdWV1ZV9ub3RpZnkoc3EtPnZxKSkKPiAgICAgICAgICAgICAg
ICAgICAgICAgICBraWNrcyA9IDE7Cj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
