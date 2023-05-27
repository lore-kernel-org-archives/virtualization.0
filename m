Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC77CC77B7C
	for <virtualization@archiver.kernel.org>; Sat, 27 May 2023 12:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60AAB41EB0;
	Sat, 27 May 2023 12:33:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60AAB41EB0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=B36wSsFQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vzWVP-YjY-59; Sat, 27 May 2023 12:33:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9AD3D41DF8;
	Sat, 27 May 2023 12:33:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AD3D41DF8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B720C0035;
	Sat, 27 May 2023 12:33:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE132C002A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 12:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C7C081FA9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 12:33:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C7C081FA9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=B36wSsFQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1A-19xHXjYE9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 12:33:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C891581F8A
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C891581F8A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 12:33:44 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2af1c884b08so21649141fa.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685190822; x=1687782822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luEVOxwc+hf1I6vnh0OMg4uHH06RianYGAZT40fbv6Q=;
 b=B36wSsFQrmHI133lMAzYbT/95M8XFCG5dcna7rLtoQT7qTWUkLxMO9uDXQfa0JpkFz
 faXPMxbI+2Uq5rE3ruOQKeEI200212EZZlFde2tAf5QjLGFO1UeVLw0S2NdhHu6MIDDf
 yKZgePb7HQxDP0XudTRIylVRhogwCRfW12v8BUAP0c4FGRZjnuXCYf6cddQcmbEejMiP
 BGNs8G2CeK5h4CehPTvq5KNkwcpubHCJlDU3ZZ4BsrvVCSEWmNZNcYDDTLVYWKhhJi2Z
 EUBkj+jfKLkkg9G4ktk+rfkZgm9QhLL5xhQv+N9t3guIB4lqB7b8+fRe2zKg0Kb7YEcQ
 lBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685190822; x=1687782822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=luEVOxwc+hf1I6vnh0OMg4uHH06RianYGAZT40fbv6Q=;
 b=UpHSBFnz/4DnWqOH+aH0gEH1ba/yZxW9W24fhjqRQ1lqAWvSmacDT8mTCw3NIUWuNd
 cfm3vV/5c7MoqspCRW8Pwmpn9gFBkM6+eEBQP4zLZwBJ67ddVX5LL0mzYC56qmvUaaB+
 UvZ96n5QN5KM2qX2htoO5RlTL44ZCZUN1uERGy1y7YfQF2FfaAj7LQZiHin0m1mhBT1m
 2B9Hb5PY96Xt5Fc4VqnQknRZYSe5wjxxLgC165W87xcmQqzvBfOVSw2NoF7OFQOSi8OE
 luUcXhd8gyh7XJtWoXIwBCtMibabvvb6LxpHAt/tvOx2GROJPaBFHmqGR/iC3jzM74zP
 oNYQ==
X-Gm-Message-State: AC+VfDy/H4MW5rtpvFtIsemRoQPlORea4HYnKTkvrP14qO3BKjkvHfsS
 +eeydtoe/omHKWEecttXLB1V6ezBd4TNxCtCaks=
X-Google-Smtp-Source: ACHHUZ687E19sFwfiVTq1KucDmWlzuq9ui7gdIxsrM7EyejJ5muKnlmEMqvbDs1wA7jDUKIkelHwH8HSxz4eb/Sp06w=
X-Received: by 2002:a2e:b94a:0:b0:2a7:b0b2:29 with SMTP id
 10-20020a2eb94a000000b002a7b0b20029mr723614ljs.22.1685190822334; 
 Sat, 27 May 2023 05:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <CACGkMEuUTNfHXQPg29eUZFnVBRJEmjjKN4Jmr3=Qnkgjj0B9PQ@mail.gmail.com>
In-Reply-To: <CACGkMEuUTNfHXQPg29eUZFnVBRJEmjjKN4Jmr3=Qnkgjj0B9PQ@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Sat, 27 May 2023 20:33:30 +0800
Message-ID: <CAKhg4tKGnXh32a8M1V-r7sP8uCSnyMYhoFXZTv3ixJOcJ1mWOg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] virtio_net: Fix an unsafe reference to the
 page chain
To: Jason Wang <jasowang@redhat.com>
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

T24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMjozOeKAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMTo0NuKAr1BNIExp
YW5nIENoZW4gPGxpYW5nY2hlbi5saW51eEBnbWFpbC5jb20+IHdyb3RlOgo+ID4KPiA+ICJwcml2
YXRlIiBvZiBidWZmZXIgcGFnZSBpcyBjdXJyZW50bHkgdXNlZCBmb3IgYmlnIG1vZGUgdG8gY2hh
aW4gcGFnZXMuCj4gPiBCdXQgaW4gbWVyZ2VhYmxlIG1vZGUsIHRoYXQgb2Zmc2V0IG9mIHBhZ2Ug
Y291bGQgbWVhbiBzb21ldGhpbmcgZWxzZSwKPiA+IGUuZy4gd2hlbiBwYWdlX3Bvb2wgcGFnZSBp
cyB1c2VkIGluc3RlYWQuIFNvIGV4Y2x1ZGluZyBtZXJnZWFibGUgbW9kZSB0bwo+ID4gYXZvaWQg
c3VjaCBhIHByb2JsZW0uCj4KPiBJZiB0aGlzIGlzc3VlIGhhcHBlbnMgb25seSBpbiB0aGUgY2Fz
ZSBvZiBwYWdlX3Bvb2wsIGl0IHdvdWxkIGJlCj4gYmV0dGVyIHRvIHNxdWFzaCBpdCB0aGVyZS4K
Pgo+IFRoYW5rcwoKU3VyZSwgdGhhbmtzIQoKCj4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBMaWFu
ZyBDaGVuIDxsaWFuZ2NoZW4ubGludXhAZ21haWwuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIHwgMiArLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IGluZGV4IDVhN2Y3YTc2YjkyMC4u
YzVkY2EwZDkyZTY0IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4g
PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IEBAIC00OTcsNyArNDk3LDcgQEAg
c3RhdGljIHN0cnVjdCBza19idWZmICpwYWdlX3RvX3NrYihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2
aSwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+ID4KPiA+ICAgICAg
ICAgICAgICAgICBwYWdlID0gKHN0cnVjdCBwYWdlICopcGFnZS0+cHJpdmF0ZTsKPiA+IC0gICAg
ICAgICAgICAgICBpZiAocGFnZSkKPiA+ICsgICAgICAgICAgICAgICBpZiAoIXZpLT5tZXJnZWFi
bGVfcnhfYnVmcyAmJiBwYWdlKQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZ2l2ZV9wYWdl
cyhycSwgcGFnZSk7Cj4gPiAgICAgICAgICAgICAgICAgZ290byBvazsKPiA+ICAgICAgICAgfQo+
ID4gLS0KPiA+IDIuMzEuMQo+ID4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
