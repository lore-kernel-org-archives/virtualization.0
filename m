Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5EFCDB474
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 03:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5236440A7E;
	Mon, 23 Oct 2023 03:51:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5236440A7E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=THbfqjhn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i-zrhLaOdNxp; Mon, 23 Oct 2023 03:51:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8AC5B401AE;
	Mon, 23 Oct 2023 03:51:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8AC5B401AE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 610D8C0039;
	Mon, 23 Oct 2023 03:51:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDC70C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 03:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAB2C4038E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 03:51:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BAB2C4038E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IgCvvNOj_q20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 03:51:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 921B9401AE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 03:51:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 921B9401AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698033104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+V7BmlRiz3EwuPt7UOzQq7qzRqObgsoG0aaVO3Q641Q=;
 b=THbfqjhnTojalLUsIQ9X/larxNMJVXS7ZjhIvt1PKMbJlJFEtHQaOp10x/pkONLB2NFP4h
 Bg6EXQ8l5aW/JUm9NO6XptmgNP7zjEnGbpbtts4+ZoZwZ8IZxQru7u08a0CZYjaNu/7T8l
 +0nMM4Ibrw70+R7TYscB/znx4gxDuxg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-TkzHS_woPgC4FwcwbawhsA-1; Sun, 22 Oct 2023 23:51:32 -0400
X-MC-Unique: TkzHS_woPgC4FwcwbawhsA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507ceeff451so2869676e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Oct 2023 20:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698033091; x=1698637891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+V7BmlRiz3EwuPt7UOzQq7qzRqObgsoG0aaVO3Q641Q=;
 b=PpsKzwsvI3q8zU5fjL90t7QHlKArXyvSH7pPJCzJrFRBH8quyiXGOa4Nv8Ahv/95kQ
 M1st0YxpAGHhv8tpRy34zKLR38IYKGxjGIiyVLKJfQbnHtHSarcQBMtmiljPk7i8/wli
 EMYyIOyP501iwPoK4F8Aax1Tr0E9KExZYRM80JJhbltil+ztiIIVl/syYVIUjSavvycM
 Hr5Ff6susxN8GYB/j2o67NsTCvuL5t0neusDaWw+35iypHj0r7emvPTHXodRLqg+ceV1
 7ckxPxswKP/je7ys2Uvi9bgor3Su5ksRxMGZqGXezCk5UHYTodO6m0Ub7UqHUwE298w8
 uk6w==
X-Gm-Message-State: AOJu0Yx8lOoT3jkwRBB8/uiDlBZFpLWxtNl/PZUNz5B3AhcvQJsaOijM
 9LEXTKHYCYZlyKpgLjFaXpwJyIAXmzH/X+LKdrsZJ8849/EVHbXfHaZmxLhdjidSSZqC010sNYH
 pdZS8otMxXkEgOmQCEF3aGNhOhNqyyqExPvlSVK1+UugasmlBz+FiMos/HQ==
X-Received: by 2002:ac2:4911:0:b0:500:7a21:3e78 with SMTP id
 n17-20020ac24911000000b005007a213e78mr5226116lfi.55.1698033090733; 
 Sun, 22 Oct 2023 20:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBVz9KGtLqK/A0i1i8bVdzKIT/WKsiTXMWhplm2cV356QzdFFyLaRynHU7puQJ3xGZVp2LihGQnjFJ4J3CXRM=
X-Received: by 2002:ac2:4911:0:b0:500:7a21:3e78 with SMTP id
 n17-20020ac24911000000b005007a213e78mr5226109lfi.55.1698033090354; Sun, 22
 Oct 2023 20:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 Oct 2023 11:51:19 +0800
Message-ID: <CACGkMEvkSFcHXC0HFw-NoDtDNnaucJbpfPO0Yho2r1QP8F6zSw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] vdpa: decouple reset of iotlb mapping from device
 reset
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

SGkgU2ktV2VpOgoKT24gU2F0LCBPY3QgMjEsIDIwMjMgYXQgNToyOOKAr1BNIFNpLVdlaSBMaXUg
PHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBJbiBvcmRlciB0byByZWR1Y2UgbmVl
ZGxlc3NseSBoaWdoIHNldHVwIGFuZCB0ZWFyZG93biBjb3N0Cj4gb2YgaW90bGIgbWFwcGluZyBk
dXJpbmcgbGl2ZSBtaWdyYXRpb24sIGl0J3MgY3J1Y2lhbCB0bwo+IGRlY291cGxlIHRoZSB2aG9z
dC12ZHBhIGlvdGxiIGFic3RyYWN0aW9uIGZyb20gdGhlIHZpcnRpbwo+IGRldmljZSBsaWZlIGN5
Y2xlLCBpLmUuIGlvdGxiIG1hcHBpbmdzIHNob3VsZCBiZSBsZWZ0Cj4gaW50YWN0IGFjcm9zcyB2
aXJ0aW8gZGV2aWNlIHJlc2V0IFsxXS4gRm9yIGl0IHRvIHdvcmssIHRoZQo+IG9uLWNoaXAgSU9N
TVUgcGFyZW50IGRldmljZSBjb3VsZCBpbXBsZW1lbnQgYSBzZXBhcmF0ZQo+IC5yZXNldF9tYXAo
KSBvcGVyYXRpb24gY2FsbGJhY2sgdG8gcmVzdG9yZSAxOjEgRE1BIG1hcHBpbmcKPiB3aXRob3V0
IGhhdmluZyB0byByZXNvcnQgdG8gdGhlIC5yZXNldCgpIGNhbGxiYWNrLCB0aGUKPiBsYXR0ZXIg
b2Ygd2hpY2ggaXMgbWFpbmx5IHVzZWQgdG8gcmVzZXQgdmlydGlvIGRldmljZSBzdGF0ZS4KPiBU
aGlzIG5ldyAucmVzZXRfbWFwKCkgY2FsbGJhY2sgd2lsbCBiZSBpbnZva2VkIG9ubHkgYmVmb3Jl
Cj4gdGhlIHZob3N0LXZkcGEgZHJpdmVyIGlzIHRvIGJlIHJlbW92ZWQgYW5kIGRldGFjaGVkIGZy
b20KPiB0aGUgdmRwYSBidXMsIHN1Y2ggdGhhdCBvdGhlciB2ZHBhIGJ1cyBkcml2ZXJzLCBlLmcu
Cj4gdmlydGlvLXZkcGEsIGNhbiBzdGFydCB3aXRoIDE6MSBETUEgbWFwcGluZyB3aGVuIHRoZXkK
PiBhcmUgYXR0YWNoZWQuIEZvciB0aGUgY29udGV4dCwgdGhvc2Ugb24tY2hpcCBJT01NVSBwYXJl
bnQKPiBkZXZpY2VzLCBjcmVhdGUgdGhlIDE6MSBETUEgbWFwcGluZyBhdCB2ZHBhIGRldmljZSBj
cmVhdGlvbiwKPiBhbmQgdGhleSB3b3VsZCBpbXBsaWNpdGx5IGRlc3Ryb3kgdGhlIDE6MSBtYXBw
aW5nIHdoZW4KPiB0aGUgZmlyc3QgLnNldF9tYXAgb3IgLmRtYV9tYXAgY2FsbGJhY2sgaXMgaW52
b2tlZC4KPgo+IFRoaXMgcGF0Y2hzZXQgaXMgcmViYXNlZCBvbiB0b3Agb2YgdGhlIGxhdGVzdCB2
aG9zdCB0cmVlLgo+Cj4gWzFdIFJlZHVjaW5nIHZkcGEgbWlncmF0aW9uIGRvd250aW1lIGJlY2F1
c2Ugb2YgbWVtb3J5IHBpbiAvIG1hcHMKPiBodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL3Fl
bXUtZGV2ZWxAbm9uZ251Lm9yZy9tc2c5NTM3NTUuaHRtbAo+Cj4gLS0tCj4gdjQ6Cj4gLSBSZXdv
cmsgY29tcGF0aWJpbGl0eSB1c2luZyBuZXcgLmNvbXBhdF9yZXNldCBkcml2ZXIgb3AKCkkgc3Rp
bGwgdGhpbmsgaGF2aW5nIGEgc2V0X2JhY2tlbmRfZmVhdHVyZSgpIG9yIHJlc2V0X21hcChjbGVh
bj10cnVlKQptaWdodCBiZSBiZXR0ZXIuIEFzIGl0IHRyaWVzIGhhcmQgdG8gbm90IGludHJvZHVj
ZSBuZXcgc3R1ZmYgb24gdGhlCmJ1cy4KCkJ1dCB3ZSBjYW4gbGlzdGVuIHRvIG90aGVycyBmb3Ig
c3VyZS4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
