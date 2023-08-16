Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F61FC0015E
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 02:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B24F82162;
	Wed, 16 Aug 2023 02:19:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B24F82162
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DiACvxh9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EnMWr0Au-7Xc; Wed, 16 Aug 2023 02:19:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 692C28211A;
	Wed, 16 Aug 2023 02:19:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 692C28211A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45BCCC0072;
	Wed, 16 Aug 2023 02:19:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07FD8C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8B2E60AB1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:19:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8B2E60AB1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DiACvxh9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JdKISB-0PWut
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:19:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE29D600B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 02:19:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE29D600B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692152388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3YzYelNfjBE8YH9cr/VxGSoSgFNzkLgVjgq/U7+7Otg=;
 b=DiACvxh9iajslc+2Dbo5bPAzsx8mgKSQGvkPfNLIf9wzSwn9eeu6HqJwUFpeS/dX/5nByT
 sZRVGRklUhwCzYtQ0yaCbyN1CXGYbednnHvKvlloTJYJZk5fDznWEO6wRqM8hiWwmk2UF5
 WYIv7lOShcleD2YBw90xi05kE3BpdSI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-AynNaNKoOumwQKKa87y01Q-1; Tue, 15 Aug 2023 22:19:47 -0400
X-MC-Unique: AynNaNKoOumwQKKa87y01Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9ce397ef1so58650611fa.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 19:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692152386; x=1692757186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YzYelNfjBE8YH9cr/VxGSoSgFNzkLgVjgq/U7+7Otg=;
 b=IrEbMW/n3TeufWlcJrXY6i7ubH8m9hyeJmjt2tzpo5SBUMmSdpGpV8kxU9ytBv94uj
 pZwmmwu8HoqQFX5YVeIDkvGWdGX3iDdQ6Upq8qlIXzA9dXTS47Tenzkgqs7q/zEP5Fjj
 QL+nWyEU08XGYdnVPkkMZtIar28IFhqDNI18aT56liGGgweQCOYcYZyebf8CCFvD14da
 hTJMOPJxkyh63ALaqktn/X9kukZ5OXXbuzvPRUT12nVensCPYQtFMop5IfSsyqlgBXpJ
 zISny3PJWSfEiWmg6onfpG6yTzMvDSwMlnBvCeTwT2xZ3k6XG9w4Hg+WTXmjauSQKY+P
 7REw==
X-Gm-Message-State: AOJu0Yy0TA3JjtbfpJreimGqrUPeRoSL1rYqi1sb09eXMwN/W0a960Nm
 QvW9g6CLFS1ga11ZR8gS440p/+yx2EGye3GRvaiADHCDOsJS4SQW5uuy8yJ8Os7nGtc3Sv2q7Aj
 6v6nHGvdU8s82pYrXQwKJlV7S43DW4er1yClHIGVUclF0NBZevVCWTAagsg==
X-Received: by 2002:a2e:86c2:0:b0:2b6:c528:4940 with SMTP id
 n2-20020a2e86c2000000b002b6c5284940mr379250ljj.3.1692152386083; 
 Tue, 15 Aug 2023 19:19:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUFlswGIG0rXG62guJXpW6W6jM74cCQMGY5o4vJww/gMKRd4ahB13DeTfzWaJPrkXmvtZiMlxOBn44VTS8tII=
X-Received: by 2002:a2e:86c2:0:b0:2b6:c528:4940 with SMTP id
 n2-20020a2e86c2000000b002b6c5284940mr379239ljj.3.1692152385803; Tue, 15 Aug
 2023 19:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
 <1692091669.428807-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsnW-+fqcxu6E-cbAtMduE_n82fu+RA162fX5gr=Ckf5A@mail.gmail.com>
 <1692151724.9150448-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692151724.9150448-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 10:19:34 +0800
Message-ID: <CACGkMEt7LSTY-TRcSD75vYcv0AkH2a5otVXga7VGRLu7JQT_dA@mail.gmail.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
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

T24gV2VkLCBBdWcgMTYsIDIwMjMgYXQgMTA6MTbigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgMTYgQXVnIDIwMjMgMDk6MTM6NDgg
KzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gVHVl
LCBBdWcgMTUsIDIwMjMgYXQgNTo0MOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBUdWUsIDE1IEF1ZyAyMDIzIDE1OjUwOjIz
ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiBP
biBUdWUsIEF1ZyAxNSwgMjAyMyBhdCAyOjMy4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IEhpLCBK
YXNvbgo+ID4gPiA+ID4KPiA+ID4gPiA+IENvdWxkIHlvdSBza2lwIHRoaXMgcGF0Y2g/Cj4gPiA+
ID4KPiA+ID4gPiBJJ20gZmluZSB3aXRoIGVpdGhlciBtZXJnaW5nIG9yIGRyb3BwaW5nIHRoaXMu
Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBMZXQgd2UgcmV2aWV3IG90aGVyIHBhdGNoZXMg
Zmlyc3RseT8KPiA+ID4gPgo+ID4gPiA+IEkgd2lsbCBiZSBvbiB2YWNhdGlvbiBzb29uLCBhbmQg
d29uJ3QgaGF2ZSB0aW1lIHRvIGRvIHRoaXMgdW50aWwgbmV4dCB3ZWVrLgo+ID4gPgo+ID4gPiBI
YXZlIGEgaGFwcGx5IHZhY2F0aW9uLgo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gQnV0IEkgc3BvdCB0
d28gcG9zc2libGUgImlzc3VlcyI6Cj4gPiA+ID4KPiA+ID4gPiAxKSB0aGUgRE1BIG1ldGFkYXRh
IHdlcmUgc3RvcmVkIGluIHRoZSBoZWFkcm9vbSBvZiB0aGUgcGFnZSwgdGhpcwo+ID4gPiA+IGJy
ZWFrcyBmcmFncyBjb2FsZXNjaW5nLCB3ZSBuZWVkIHRvIGJlbmNobWFyayBpdCdzIGltcGFjdAo+
ID4gPgo+ID4gPiBOb3QgZXZlcnkgcGFnZSwganVzdCB0aGUgZmlyc3QgcGFnZSBvZiB0aGUgQ09N
UCBwYWdlcy4KPiA+ID4KPiA+ID4gU28gSSB0aGluayB0aGVyZSBpcyBubyBpbXBhY3QuCj4gPgo+
ID4gTm9wZSwgc2VlIHRoaXM6Cj4gPgo+ID4gICAgICAgICBpZiAoU0tCX0ZSQUdfUEFHRV9PUkRF
UiAmJgo+ID4gICAgICAgICAgICAgIXN0YXRpY19icmFuY2hfdW5saWtlbHkoJm5ldF9oaWdoX29y
ZGVyX2FsbG9jX2Rpc2FibGVfa2V5KSkgewo+ID4gICAgICAgICAgICAgICAgIC8qIEF2b2lkIGRp
cmVjdCByZWNsYWltIGJ1dCBhbGxvdyBrc3dhcGQgdG8gd2FrZSAqLwo+ID4gICAgICAgICAgICAg
ICAgIHBmcmFnLT5wYWdlID0gYWxsb2NfcGFnZXMoKGdmcCAmIH5fX0dGUF9ESVJFQ1RfUkVDTEFJ
TSkgfAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19HRlBf
Q09NUCB8IF9fR0ZQX05PV0FSTiB8Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBfX0dGUF9OT1JFVFJZLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgU0tCX0ZSQUdfUEFHRV9PUkRFUik7Cj4gPiAgICAgICAgICAgICAgICAg
aWYgKGxpa2VseShwZnJhZy0+cGFnZSkpIHsKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHBm
cmFnLT5zaXplID0gUEFHRV9TSVpFIDw8IFNLQl9GUkFHX1BBR0VfT1JERVI7Cj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKPiA+ICAgICAgICAgICAgICAgICB9Cj4gPiAg
ICAgICAgIH0KPiA+Cj4gPiBUaGUgY29tcCBwYWdlIG1pZ2h0IGJlIGRpc2FibGVkIGR1ZSB0byB0
aGUgU0tCX0ZSQUdfUEFHRV9PUkRFUiBhbmQKPiA+IG5ldF9oaWdoX29yZGVyX2FsbG9jX2Rpc2Fi
bGVfa2V5Lgo+Cj4KPiBZRVMuCj4KPiBCdXQgaWYgY29tcCBwYWdlIGlzIGRpc2FibGVkLiBUaGVu
IHdlIG9ubHkgZ2V0IG9uZSBwYWdlIGVhY2ggdGltZS4gVGhlIHBhZ2VzIGFyZQo+IG5vdCBjb250
aWd1b3VzLCBzbyB3ZSBkb24ndCBoYXZlIGZyYWdzIGNvYWxlc2NpbmcuCj4KPiBJZiB5b3UgbWVh
biB0aGUgdHdvIHBhZ2VzIGdvdCBmcm9tIGFsbG9jX3BhZ2UgbWF5IGJlIGNvbnRpZ3VvdXMuIFRo
ZSBjb2FsZXNjaW5nCj4gbWF5IHRoZW4gYmUgYnJva2VuLiBJdCdzIGEgcG9zc2liaWxpdHksIGJ1
dCBJIHRoaW5rIHRoZSBpbXBhY3Qgd2lsbCBiZSBzbWFsbC4KCkxldCdzIGhhdmUgYSBzaW1wbGUg
YmVuY2htYXJrIGFuZCBzZWU/CgpUaGFua3MKCj4KPiBUaGFua3MuCj4KPgo+ID4KPiA+ID4KPiA+
ID4KPiA+ID4gPiAyKSBwcmUgbWFwcGVkIERNQSBhZGRyZXNzZXMgd2VyZSBub3QgcmV1c2VkIGlu
IHRoZSBjYXNlIG9mIFhEUF9UWC9YRFBfUkVESVJFQ1QKPiA+ID4KPiA+ID4gQmVjYXVzZSB0aGF0
IHRoZSB0eCBpcyBub3QgdGhlIHByZW1hcHBlZCBtb2RlLgo+ID4KPiA+IFllcywgd2UgY2FuIG9w
dGltaXplIHRoaXMgb24gdG9wLgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4gVGhhbmtz
Lgo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gSSBzZWUgTWljaGFlbCBoYXMgbWVyZ2UgdGhpcyBzZXJp
ZXMgc28gSSdtIGZpbmUgdG8gbGV0IGl0IGdvIGZpcnN0Lgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtz
Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGFua3MuCj4gPiA+ID4gPgo+ID4gPiA+Cj4g
PiA+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
