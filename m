Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1D6CDB474
	for <virtualization@archiver.kernel.org>; Fri, 13 Oct 2023 01:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C3418227E;
	Fri, 13 Oct 2023 01:54:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C3418227E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VhRFd2ND
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xO-XACRIHtkc; Fri, 13 Oct 2023 01:54:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 37A4A8227B;
	Fri, 13 Oct 2023 01:54:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37A4A8227B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E36BC0071;
	Fri, 13 Oct 2023 01:54:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBE65C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 01:54:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91146614ED
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 01:54:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91146614ED
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VhRFd2ND
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qg1v2KvkVwUQ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 01:54:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44C2C614EA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 01:54:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44C2C614EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697162050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gzCwnSkLK4z8nW8eRHDCWg2SmXFxgaZjbH2hutqa4/I=;
 b=VhRFd2NDqM0/scv20TvSdq4dO1G7xZH/RT32d1l2gjrZOV2uDed6E/xABkuXHTK5DJytAX
 13TCieIuYTQq+FkzBZvgN96+Z+aajheVYvlFikGUtTXK1pE5qytHGwA/fyLQXCdc4I5wk2
 Yj/SV81PLDcK94psjRxzHqQgpjki3aI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-zC1g1OI0OyWggaqhxj1T4A-1; Thu, 12 Oct 2023 21:54:06 -0400
X-MC-Unique: zC1g1OI0OyWggaqhxj1T4A-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-503c774fd61so1523067e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 18:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697162045; x=1697766845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzCwnSkLK4z8nW8eRHDCWg2SmXFxgaZjbH2hutqa4/I=;
 b=ojo7+ekOVFSha/nYBaJYt7VEjkCUBP6JSI2Z3Qek9qwyKmH3AIofhd42807NJ9/i4u
 Yg85MjChdKYOLK2mtF8T56BfMLqF8v9FEfhRoOEDbbIA1v6RDsmB8lT5YATaLGC+XXv6
 KggFnJ2wC7w/FRaX7jPkpkM14Fj+Dd7t9K5a9aDWyaUZ+J4UNyy3K7UIztgQ2lzf7D+o
 kTCSxIf9MrKNW7nifHX/PGVs2jj+mFndw0OuAyICTzVDvkgBq2Iu667UbHa1a+motK+K
 e4lOrd0XU5/kqddZvDfXhEuuMyAIsiiVk0dhtyVwCn9MMAFP7F5dKaUAUt9hg3FlYZnh
 ul6A==
X-Gm-Message-State: AOJu0YxLayVwz3EhNGbOfWpChawEbg/GqbczlIo/yfzXM+JDvlWJnUto
 UY8fCKMSA5t7wGr212BTzuyoMM/R7wUIB67bftpVYXNOhUwDORR8jQYYM+k4iid7vIvJAQFK4wD
 ieC97/5X7N2YONsCU6qfg3HEOsO0yETrjnAFlj+jWcdmnwIQ/atIdxN/yeQ==
X-Received: by 2002:a05:6512:398d:b0:507:8c55:39f9 with SMTP id
 j13-20020a056512398d00b005078c5539f9mr5344943lfu.49.1697162045070; 
 Thu, 12 Oct 2023 18:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYb4LeCe4Fje2tNzGbkvrJkssqt3nF37jxl4CADpfU3I/mxG0byPqvUsoUYvZGYy6fP0/Wg34Cz+06KTOgLTA=
X-Received: by 2002:a05:6512:398d:b0:507:8c55:39f9 with SMTP id
 j13-20020a056512398d00b005078c5539f9mr5344931lfu.49.1697162044757; Thu, 12
 Oct 2023 18:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
In-Reply-To: <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Oct 2023 09:53:53 +0800
Message-ID: <CACGkMEshFckmtY3RyNYiEATFkDkCvQSMWq1-3LwbM2gVgqPxVw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing
 moderation
To: Heng Qi <hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Liu, Yujie" <yujie.liu@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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

T24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgNDoyOeKAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMzo0NOKAr1BNIEhl
bmcgUWkgPGhlbmdxaUBsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gTm93LCB2aXJ0
aW8tbmV0IGFscmVhZHkgc3VwcG9ydHMgcGVyLXF1ZXVlIG1vZGVyYXRpb24gcGFyYW1ldGVyCj4g
PiBzZXR0aW5nLiBCYXNlZCBvbiB0aGlzLCB3ZSB1c2UgdGhlIG5ldGRpbSBsaWJyYXJ5IG9mIGxp
bnV4IHRvIHN1cHBvcnQKPiA+IGR5bmFtaWMgY29hbGVzY2luZyBtb2RlcmF0aW9uIGZvciB2aXJ0
aW8tbmV0Lgo+ID4KPiA+IER1ZSB0byBoYXJkd2FyZSBzY2hlZHVsaW5nIGlzc3Vlcywgd2Ugb25s
eSB0ZXN0ZWQgcnggZGltLgo+Cj4gRG8geW91IGhhdmUgUFBTIG51bWJlcnM/IEFuZCBUWCBudW1i
ZXJzIGFyZSBhbHNvIGltcG9ydGFudCBhcyB0aGUKPiB0aHJvdWdocHV0IGNvdWxkIGJlIG1pc2xl
YWRpbmcgZHVlIHRvIHZhcmlvdXMgcmVhc29ucy4KCkFub3RoZXIgY29uc2lkZXJhdGlvbjoKCldl
IGN1cnJlbnRseSBoYXZlIHR3byBUWCBtb2RlLCBOQVBJIGJ5IGRlZmF1bHQsIGFuZCBvcnBoYW4u
IFNpbXBsZQpwa3RnZW4gdGVzdCBzaG93cyBOQVBJIGNhbiBvbmx5IGFjaGlldmUgMzAlIG9mIG9y
cGhhbi4gU28gd2UgbmVlZCB0bwptYWtlIHN1cmU6CgoxKSBkaW0gaGVscHMgZm9yIE5BUEksIGFu
ZCBpZiBOQVBJIGNhbiBjb21wZXRlIHdpdGggb3JwaGFuLCB3ZSBjYW4KZHJvcCB0aGUgb3JwaGFu
IGNvZGUgY29tcGxldGVseSB3aGljaCBpcyBhIGdyZWF0IHJlbGVhc2UgYW5kCnNpbXBsaWZpY2F0
aW9uIG9mIHRoZSBjb2Rlcy4gQW5kIGl0IG1lYW5zIHdlIGNhbiBoYXZlIEJRTCwgYW5kIG90aGVy
Cmdvb2Qgc3R1ZmYgb24gdG9wIGVhc2lseS4KMikgZGltIGRvZXNuJ3QgY2F1c2UgcmVncmVzc2lv
biBmb3Igb3JwaGFuCgpUaGFua3MKCj4KPiBUaGFua3MKPgo+ID4KPiA+IEBUZXN0IGVudgo+ID4g
cnhxMCBoYXMgYWZmaW5pdHkgdG8gY3B1MC4KPiA+Cj4gPiBAVGVzdCBjbWQKPiA+IGNsaWVudDog
dGFza3NldCAtYyAwIHNvY2twZXJmIHRwIC1pICR7SVB9IC10IDMwIC0tdGNwIC1tICR7bXNnX3Np
emV9Cj4gPiBzZXJ2ZXI6IHRhc2tzZXQgLWMgMCBzb2NrcGVyZiBzciAtLXRjcAo+ID4KPiA+IEBU
ZXN0IHJlcwo+ID4gVGhlIHNlY29uZCBjb2x1bW4gaXMgdGhlIHJhdGlvIG9mIHRoZSByZXN1bHQg
cmV0dXJuZWQgYnkgY2xpZW50Cj4gPiB3aGVuIHJ4IGRpbSBpcyBlbmFibGVkIHRvIHRoZSByZXN1
bHQgcmV0dXJuZWQgYnkgY2xpZW50IHdoZW4KPiA+IHJ4IGRpbSBpcyBkaXNhYmxlZC4KPiA+ICAg
ICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ICAgICAgICAg
fCBtc2dfc2l6ZSB8ICByeF9kaW09b24gLyByeF9kaW09b2ZmIHwKPiA+ICAgICAgICAgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ICAgICAgICAgfCAgIDE0QiAgICB8
ICAgICAgICAgKyAzJSAgICAgICAgICAgIHwKPiA+ICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ICAgICAgICAgfCAgIDEwMEIgICB8ICAgICAgICAgKyAx
NiUgICAgICAgICAgIHwKPiA+ICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPiA+ICAgICAgICAgfCAgIDUwMEIgICB8ICAgICAgICAgKyAyNSUgICAgICAgICAg
IHwKPiA+ICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+
ICAgICAgICAgfCAgIDE0MDBCICB8ICAgICAgICAgKyAyOCUgICAgICAgICAgIHwKPiA+ICAgICAg
ICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ICAgICAgICAgfCAg
IDIwNDhCICB8ICAgICAgICAgKyAyMiUgICAgICAgICAgIHwKPiA+ICAgICAgICAgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ICAgICAgICAgfCAgIDQwOTZCICB8ICAg
ICAgICAgKyA1JSAgICAgICAgICAgIHwKPiA+ICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiA+Cj4gPiAtLS0KPiA+IFRoaXMgcGF0Y2ggc2V0IHdhcyBwYXJ0
IG9mIHRoZSBwcmV2aW91cyBuZXRkaW0gcGF0Y2ggc2V0WzFdLgo+ID4gWzFdIHdhcyBzcGxpdCBp
bnRvIGEgbWVyZ2VkIGJ1Z2ZpeCBzZXRbMl0gYW5kIHRoZSBjdXJyZW50IHNldC4KPiA+IFRoZSBw
cmV2aW91cyByZWxldmFudCBjb21tZW50YXRvcnMgaGF2ZSBiZWVuIENjZWQuCj4gPgo+ID4gWzFd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDgxMTA2NTUxMi4yMjE5MC0xLWhlbmdx
aUBsaW51eC5hbGliYWJhLmNvbS8KPiA+IFsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
Y292ZXIuMTY5Njc0NTQ1Mi5naXQuaGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tLwo+ID4KPiA+IEhl
bmcgUWkgKDUpOgo+ID4gICB2aXJ0aW8tbmV0OiByZXR1cm5zIHdoZXRoZXIgbmFwaSBpcyBjb21w
bGV0ZQo+ID4gICB2aXJ0aW8tbmV0OiBzZXBhcmF0ZSByeC90eCBjb2FsZXNjaW5nIG1vZGVyYXRp
b24gY21kcwo+ID4gICB2aXJ0aW8tbmV0OiBleHRyYWN0IHZpcnRxdWV1ZSBjb2FsZXNjaWcgY21k
IGZvciByZXVzZQo+ID4gICB2aXJ0aW8tbmV0OiBzdXBwb3J0IHJ4IG5ldGRpbQo+ID4gICB2aXJ0
aW8tbmV0OiBzdXBwb3J0IHR4IG5ldGRpbQo+ID4KPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMgfCAzOTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDMyMiBpbnNlcnRpb25zKCspLCA3MiBkZWxldGlvbnMoLSkKPiA+Cj4gPiAt
LQo+ID4gMi4xOS4xLjYuZ2I0ODU3MTBiCj4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
