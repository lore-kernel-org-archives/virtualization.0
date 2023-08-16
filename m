Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6F8C0015E
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 01:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D795A40105;
	Wed, 16 Aug 2023 01:14:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D795A40105
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ATGxW/sO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gtI4-W_RB2Jn; Wed, 16 Aug 2023 01:14:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8108840C11;
	Wed, 16 Aug 2023 01:14:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8108840C11
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30772C0072;
	Wed, 16 Aug 2023 01:14:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48E8FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22F3F81FDC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:14:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22F3F81FDC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ATGxW/sO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n8H3LoDEv6xq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:14:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31DAA81FD5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:14:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31DAA81FD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692148443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+pHbckL50YFELz4jhUnoR5ZB+UHNI6fuSKER4VhZC0=;
 b=ATGxW/sON+L7DrwNLx7dBZ5RTbtMbv920ECI+/7hnIwSr5n7Q1+Vqa0knu40tWVD9thYMO
 Q1DZS0yqU5Ms60UhZYr2Lq7tjT0A5zDx4AXEDDnCNy3Gey4y//Re9XLC5HEYOsdcosW1YS
 loKO+U80tf9nB6bOmjJYOWdPkecCa6o=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-H9kW7MN5OQeKHUdgya8U6w-1; Tue, 15 Aug 2023 21:14:01 -0400
X-MC-Unique: H9kW7MN5OQeKHUdgya8U6w-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9bb2d0b47so57420021fa.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 18:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692148440; x=1692753240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+pHbckL50YFELz4jhUnoR5ZB+UHNI6fuSKER4VhZC0=;
 b=aDtiPJkoFrU/UpRrUCRjuvQ/8wjIoX9ZCQzsK0l0vUBJuzGEWc/MtZLwXahrYOWvQW
 DjhPKdp5foy1Pd5AeovAdv1Yki+qvszjblk9IWfScSoDtPR2pI5ZmkQZPP6dulp/HHkg
 MepNz4IRmwnYFNKfX7ISVyF3aWCgDzmXT8DiCJ2nOOCTNgUETULDeWAMScgyiKWyhT5+
 9nYqy77D061NGi+55G8WHJC8bfGKQFYpz0Ny9qm2XI/4FamQJ2PdaE8H2X6nECGgEGZe
 qY1bE/ddv4LT+03HLSlYWRdLrmWe2yI9IonS5VUHebbqAgb/+54PVBfHcYFbXsSpygFr
 4wyA==
X-Gm-Message-State: AOJu0Yzk/8khdHBzrDFwItGWIngiHWdlwzovSSPkYHvaY61EaVRwAIZG
 IOwq0oTkJavVlJh+iz+lpND8Q9OQ2OwkMg0tssfXSyTZQ69NFF1TYl5voh3PDz9N9SlhJc2LTCF
 MnGwzvbmkbrW/Pns1hWloexcci87JQ7FkmNWh+2FqED6hHtigSq5b7koBuw==
X-Received: by 2002:a2e:8788:0:b0:2b9:c864:9e3f with SMTP id
 n8-20020a2e8788000000b002b9c8649e3fmr287454lji.39.1692148440468; 
 Tue, 15 Aug 2023 18:14:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8LwPFW2G1dTIhy1em/nftkzDGRx99RiUxeBvkJMjQqcgWmMl74ojJLdmCbQo2Vibix0tfmCqogWSZmq0o5rY=
X-Received: by 2002:a2e:8788:0:b0:2b9:c864:9e3f with SMTP id
 n8-20020a2e8788000000b002b9c8649e3fmr287450lji.39.1692148440172; Tue, 15 Aug
 2023 18:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
 <1692091669.428807-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692091669.428807-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 09:13:48 +0800
Message-ID: <CACGkMEsnW-+fqcxu6E-cbAtMduE_n82fu+RA162fX5gr=Ckf5A@mail.gmail.com>
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

T24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgNTo0MOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCAxNSBBdWcgMjAyMyAxNTo1MDoyMyAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUs
IEF1ZyAxNSwgMjAyMyBhdCAyOjMy4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGli
YWJhLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+Cj4gPiA+IEhpLCBKYXNvbgo+ID4gPgo+ID4gPiBD
b3VsZCB5b3Ugc2tpcCB0aGlzIHBhdGNoPwo+ID4KPiA+IEknbSBmaW5lIHdpdGggZWl0aGVyIG1l
cmdpbmcgb3IgZHJvcHBpbmcgdGhpcy4KPiA+Cj4gPiA+Cj4gPiA+IExldCB3ZSByZXZpZXcgb3Ro
ZXIgcGF0Y2hlcyBmaXJzdGx5Pwo+ID4KPiA+IEkgd2lsbCBiZSBvbiB2YWNhdGlvbiBzb29uLCBh
bmQgd29uJ3QgaGF2ZSB0aW1lIHRvIGRvIHRoaXMgdW50aWwgbmV4dCB3ZWVrLgo+Cj4gSGF2ZSBh
IGhhcHBseSB2YWNhdGlvbi4KPgo+ID4KPiA+IEJ1dCBJIHNwb3QgdHdvIHBvc3NpYmxlICJpc3N1
ZXMiOgo+ID4KPiA+IDEpIHRoZSBETUEgbWV0YWRhdGEgd2VyZSBzdG9yZWQgaW4gdGhlIGhlYWRy
b29tIG9mIHRoZSBwYWdlLCB0aGlzCj4gPiBicmVha3MgZnJhZ3MgY29hbGVzY2luZywgd2UgbmVl
ZCB0byBiZW5jaG1hcmsgaXQncyBpbXBhY3QKPgo+IE5vdCBldmVyeSBwYWdlLCBqdXN0IHRoZSBm
aXJzdCBwYWdlIG9mIHRoZSBDT01QIHBhZ2VzLgo+Cj4gU28gSSB0aGluayB0aGVyZSBpcyBubyBp
bXBhY3QuCgpOb3BlLCBzZWUgdGhpczoKCiAgICAgICAgaWYgKFNLQl9GUkFHX1BBR0VfT1JERVIg
JiYKICAgICAgICAgICAgIXN0YXRpY19icmFuY2hfdW5saWtlbHkoJm5ldF9oaWdoX29yZGVyX2Fs
bG9jX2Rpc2FibGVfa2V5KSkgewogICAgICAgICAgICAgICAgLyogQXZvaWQgZGlyZWN0IHJlY2xh
aW0gYnV0IGFsbG93IGtzd2FwZCB0byB3YWtlICovCiAgICAgICAgICAgICAgICBwZnJhZy0+cGFn
ZSA9IGFsbG9jX3BhZ2VzKChnZnAgJiB+X19HRlBfRElSRUNUX1JFQ0xBSU0pIHwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19HRlBfQ09NUCB8IF9fR0ZQX05PV0FS
TiB8CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fR0ZQX05PUkVU
UlksCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNLQl9GUkFHX1BB
R0VfT1JERVIpOwogICAgICAgICAgICAgICAgaWYgKGxpa2VseShwZnJhZy0+cGFnZSkpIHsKICAg
ICAgICAgICAgICAgICAgICAgICAgcGZyYWctPnNpemUgPSBQQUdFX1NJWkUgPDwgU0tCX0ZSQUdf
UEFHRV9PUkRFUjsKICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CiAgICAgICAg
ICAgICAgICB9CiAgICAgICAgfQoKVGhlIGNvbXAgcGFnZSBtaWdodCBiZSBkaXNhYmxlZCBkdWUg
dG8gdGhlIFNLQl9GUkFHX1BBR0VfT1JERVIgYW5kCm5ldF9oaWdoX29yZGVyX2FsbG9jX2Rpc2Fi
bGVfa2V5LgoKPgo+Cj4gPiAyKSBwcmUgbWFwcGVkIERNQSBhZGRyZXNzZXMgd2VyZSBub3QgcmV1
c2VkIGluIHRoZSBjYXNlIG9mIFhEUF9UWC9YRFBfUkVESVJFQ1QKPgo+IEJlY2F1c2UgdGhhdCB0
aGUgdHggaXMgbm90IHRoZSBwcmVtYXBwZWQgbW9kZS4KClllcywgd2UgY2FuIG9wdGltaXplIHRo
aXMgb24gdG9wLgoKVGhhbmtzCgo+Cj4gVGhhbmtzLgo+Cj4gPgo+ID4gSSBzZWUgTWljaGFlbCBo
YXMgbWVyZ2UgdGhpcyBzZXJpZXMgc28gSSdtIGZpbmUgdG8gbGV0IGl0IGdvIGZpcnN0Lgo+ID4K
PiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4gVGhhbmtzLgo+ID4gPgo+ID4KPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
