Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC0BC7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 05:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28C5481F18;
	Tue, 11 Apr 2023 05:19:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28C5481F18
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cje4qdti
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VG_axUPLtomT; Tue, 11 Apr 2023 05:19:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B625481E9D;
	Tue, 11 Apr 2023 05:19:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B625481E9D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99E29C0036;
	Tue, 11 Apr 2023 05:19:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FE73C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAF5C81F10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:19:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAF5C81F10
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y8NPUNCNH_26
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:19:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E21B81E9D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E21B81E9D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681190379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dSijIkUkalOZnEUVMEKCTxtPjk2m0YZLLc3srEqYfBw=;
 b=Cje4qdti9qYRbwvoFcTu6IpIXo2JNhcf1j2eT3LDJRakunX6fA/q6tG4od6J5gFI5XZNX8
 MLaPom3tePwNO5WlLBSDVwfBIMXILet8VCspe6WXXPjwoaKC1UlFOYHaGOhuW55hynxS9T
 3+7o14TN2IEOeuQaUBqdLjLxaMBTzGs=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-7a_O6pisMISuVm3_aThPhQ-1; Tue, 11 Apr 2023 01:19:37 -0400
X-MC-Unique: 7a_O6pisMISuVm3_aThPhQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1842ab38ebcso4329833fac.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 22:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681190377; x=1683782377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSijIkUkalOZnEUVMEKCTxtPjk2m0YZLLc3srEqYfBw=;
 b=0EPzdd4SzdRkKAWdoqPlYZssXK2Dzsw3iMwcbfOvtq/pG61qs8rV1M+t4WdOe9qu6W
 rRlk1j5qngdpRU29fY8cY96J64bKnVYB/uPb//2w273FFUuru3x/N4LlHy+fs40kvV2a
 o5JmO9WLzTJU8JkfrdXgyCoBGxG2GNlgcg7Mq2Y0Dn1DubfCRnM/vmnboYLf/Pq1g1kG
 ZNWjphNjQXEv88IYw16IWCfiOeA34BWs1WwhWrWFswpT+D5Ml3IF+sfhJ6GZpK5SDACt
 0A1CLc6L+Wfu+Nn00hvbOrfgZj6WTuksX8vnhUoHEmx/Sc74FAO+moTmjne4TxSNzXlf
 4rZw==
X-Gm-Message-State: AAQBX9e/Px5PgxUw6scfaufSbDRWA0xnIkNqfwjYu6nTtxdPwy7ATydQ
 2P1Amu3EPFGXLFtCxuD+vuR+ypldO6evEJEFPgUQNCgQNOBs/6jWIo6UpT3KMyGw4mw38Ei6J7L
 WcmcJ7tn3IQBBbaKK2ElVyQ1qQTWnMcLl8yBCI2X72VQHP8i6wcbnGosvIQ==
X-Received: by 2002:a05:6870:5611:b0:184:33c8:2033 with SMTP id
 m17-20020a056870561100b0018433c82033mr3744508oao.9.1681190376880; 
 Mon, 10 Apr 2023 22:19:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350bGECSW2Pl4TdQ0pYekm5tmSz0DtfqVxBXOnbb4W2PXiovlzLPyNJslCug1uS61mtgh17yIl59gPrb8lveiqOM=
X-Received: by 2002:a05:6870:5611:b0:184:33c8:2033 with SMTP id
 m17-20020a056870561100b0018433c82033mr3744507oao.9.1681190376668; Mon, 10 Apr
 2023 22:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230407064634-mutt-send-email-mst@kernel.org>
 <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <ZDQq0pDVkr8TvoTM@infradead.org>
 <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskNEwD0_AZgoDLS2RBv9cpbH5u1q01=cDuawV0NbhK_w@mail.gmail.com>
 <ZDTUn6TUqzrF06mr@infradead.org>
 <CACGkMEtD0BLBXv7S-TLY-Y483_Lx4UskLyPmEC2wyGa8VE_R6w@mail.gmail.com>
 <ZDTdk0K6LO5+0OLA@infradead.org>
 <CACGkMEuZss7m+qC2V+QjMJD3W1JdYAoQs6Amn1WXHYZBrJRUjg@mail.gmail.com>
 <ZDTsmC1XL9x3X7t5@infradead.org>
In-Reply-To: <ZDTsmC1XL9x3X7t5@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 13:19:25 +0800
Message-ID: <CACGkMEsBj1bqt-47MJwEaDrybamHHu__YXfwd0kb+B21PFk-6g@mail.gmail.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
To: Christoph Hellwig <hch@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMToxNOKAr1BNIENocmlzdG9waCBIZWxsd2lnIDxoY2hA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4KPiBPbiBUdWUsIEFwciAxMSwgMjAyMyBhdCAxMjo1NDo0
NlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gT2ssIGp1c3QgdG8gY2xhcmlmeSwgSSBt
ZWFudCB0aGVyZSBjb3VsZCBiZSBhIGNhc2Ugd2hlcmUgdGhlIHZpcnRxdWV1ZQo+ID4gaXMgZW11
bGF0ZWQgYnkgc29mdHdhcmUsIGluIHRoaXMgY2FzZSB3ZSBuZWVkIGNoZWNrIHdoZXRoZXIgdGhl
Cj4gPiB2aXJ0cXVldWUgaGFzIGEgZG1hIGRldmljZSBvciBub3QgaW4gdnJpbmdfdXNlX2RtYV9h
cGkoKS4gSWYgbm90IHdlCj4gPiBuZWVkIHJldHVybiBmYWxzZS4KPgo+IFdlbGwsIHRoYXQncyB3
aGF0IHZyaW5nX3VzZV9kbWFfYXBpIGJhc2ljYWxseSBkb2VzLiAgU3VjaCBkZXZpY3MKPiBqdXN0
IHNob3VsZCBuZXZlciBoYXZlIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBzZXQuICBJZiB0aGVy
ZSBpcwo+IGEgcmVhbGx5IGdvb2QgcmVhc29uIGZvciBzdWNoIGEgZGV2aWNlIHRvIGhhdmUgVklS
VElPX0ZfQUNDRVNTX1BMQVRGT1JNCj4gc2V0IHdlJ2QgbmVlZCBhbiBleHRyYSBxdWlyayBpbiB2
cmluZ191c2VfZG1hX2FwaSBpbmRlZWQuCj4KClRoaXMgaXMgdXNlZnVsIGZvciBzb21lIHZEUEEg
ZGV2aWNlcyB3aGVyZSB0aGUgY29udHJvbCB2aXJ0cXVldWUgaXMKZW11bGF0ZWQgYnkgdGhlIHZE
UEEgcGFyZW50ICh3aG8gd2lsbCBkZWNvZGUgdGhlIGNvbnRyb2wgdmlydHF1ZXVlCmNvbW1hbmRz
IHRvIHZlbmRvciBzcGVjaWZpYyBjb250cm9sIGNvbW1hbmRzKS4KClRoYW5rcwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
