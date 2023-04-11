Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BADFC7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 08:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 96AB540BA0;
	Tue, 11 Apr 2023 08:55:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 96AB540BA0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O7o85sp+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gxf6Zs3K9pK7; Tue, 11 Apr 2023 08:55:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 07029400E2;
	Tue, 11 Apr 2023 08:55:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07029400E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCA14C0037;
	Tue, 11 Apr 2023 08:55:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2342DC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB003408CA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:55:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB003408CA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3tgXr4MMg9HM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:55:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1991A400E2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1991A400E2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681203343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MC+/gcdhUMIs78nNO2XhaBRkLlQWuG05+8jq06wdSU=;
 b=O7o85sp+Q1qhOo7ru0akQ4hGi2B9o93vDpQzu+5+v2/7lzrvDojSiTaNeHLScmDWJBZ/6t
 071ehOhybSEuQud9Su3gkSKmwVaYvu1OojFVX+10URWgy/NuQtWLHPGFiNztczZX7lH0Ts
 HctnmY6/MNsrhI1XaXUh6dPRCKjuxv8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-MLayiWp3OY-J-5MLPb2uDg-1; Tue, 11 Apr 2023 04:55:39 -0400
X-MC-Unique: MLayiWp3OY-J-5MLPb2uDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7571C885620;
 Tue, 11 Apr 2023 08:55:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FFD018EC6;
 Tue, 11 Apr 2023 08:55:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 378BA1802393; Tue, 11 Apr 2023 10:55:36 +0200 (CEST)
Date: Tue, 11 Apr 2023 10:55:36 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <tnj4yvrjjlwkmecb6dkvc25na4t7bmzb2jlrdfzvjsfkih32ka@7bvxpyy4ghc4>
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
MIME-Version: 1.0
In-Reply-To: <CACGkMEuZss7m+qC2V+QjMJD3W1JdYAoQs6Amn1WXHYZBrJRUjg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Christoph Hellwig <hch@infradead.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMTI6NTQ6NDZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEFwciAxMSwgMjAyMyBhdCAxMjoxMOKAr1BNIENocmlzdG9waCBIZWxsd2ln
IDxoY2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4gPgo+ID4gT24gVHVlLCBBcHIgMTEsIDIwMjMg
YXQgMTE6NTY6NDdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiBUaGUgRE1BIGRl
dmljZSBmb3IgdmlydGlvX3BjaSBpcyB0aGUgdW5kZXJseWluZyBQQ0kgZGV2aWNlLCBhbHdheXMu
Cj4gPiA+ID4gIVZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBtZWFucyB0aGVyZSBpcyBubyBkbWEg
ZGV2aWNlIGF0IGFsbC4gIEJlY2F1c2UKPiA+ID4gPiBvZiBhbGwgdGhlc2UgdGhpbmdzIHlvdSBj
YW4ndCBqdXN0IGV4cG9zZSBhIHBvaW50ZXIgdG8gdGhlIGRtYV9kZXZpY2UKPiA+ID4gPiBhcyB0
aGF0IGlzIGp1c3QgYSBjb21wbGV0ZWx5IHdyb25nIHdheSBvZiB0aGlua2luZyBhYm91dCB0aGUg
cHJvYmxlbS4KPiA+ID4KPiA+ID4gT2ssIHNvIGlmIHRoZXJlJ3Mgbm8gRE1BIGF0IGFsbCB3ZSBz
aG91bGQgYXZvaWQgdXNpbmcgdGhlIERNQSBBUEkKPiA+ID4gY29tcGxldGVseS4gVGhpcyBtZWFu
cyB3ZSBzaG91bGQgY2hlY2sgZG1hX2RldiBhZ2FpbnN0IE5VTEwgaW4KPiA+ID4gdmlydGlvX2hh
c19kbWFfcXVpcmsoKS4KPiA+Cj4gPiBObyBuZWUgdG8gYWRkIGEgY2hlY2sgdG8gdmlydGlvX2hh
c19kbWFfcXVpcmsuCj4gCj4gT2ssIGp1c3QgdG8gY2xhcmlmeSwgSSBtZWFudCB0aGVyZSBjb3Vs
ZCBiZSBhIGNhc2Ugd2hlcmUgdGhlIHZpcnRxdWV1ZQo+IGlzIGVtdWxhdGVkIGJ5IHNvZnR3YXJl
LCBpbiB0aGlzIGNhc2Ugd2UgbmVlZCBjaGVjayB3aGV0aGVyIHRoZQo+IHZpcnRxdWV1ZSBoYXMg
YSBkbWEgZGV2aWNlIG9yIG5vdCBpbiB2cmluZ191c2VfZG1hX2FwaSgpLiBJZiBub3Qgd2UKPiBu
ZWVkIHJldHVybiBmYWxzZS4KPiAKPiA+IEJ1dCBsb29raW5nIGF0IHZpcnRpb19oYXNfZG1hX3F1
aXJrIHNob3dzIHRoYXQgdmlydGlvLWdwdSBpcwo+ID4gcHJldHR5IG1lc3NlZCB1cCBhbHJlYWR5
IGFzIHdlbGwuCgpZZXMuICBGb3IgZ2VtIG9iamVjdHMgYWxsb2NhdGVkIGluIGd1ZXN0IHJhbSB2
aXJ0aW8tZ3B1IGVmZmVjdGl2ZWx5CnBhc3NlcyBhIHNjYXR0ZXIgbGlzdCB0byB0aGUgaG9zdC4g
IEl0IGRvZXNuJ3QgdXNlIHZyaW5ncyBmb3IgdGhhdAp0aG91Z2gsIHNvIGl0IGhhcyB0byByZS1p
bXBsZW1lbnQgc29tZSBvZiB0aGUgbG9naWMgdGhlIHZpcnRpbyBjb3JlCmFscmVhZHkgaGFzIGZv
ciB0aGUgdnJpbmdzLgoKPiA+IEl0IGNhbid0IHJlYWxseSBwb2tlIGludG8gdGhlIERNQSBkZXRh
aWxzLiAgV2UnbGwgbmVlZCBjb3JlIHZpcnRpbwo+ID4gaGVscGVycyBmb3IgYWxsb2NhdGluZyBh
bmQgc3luY2luZyBhIHNnX3RhYmxlIGluc3RlYWQgYW5kIG1ha2UKPiA+IHZpcnRpb19oYXNfZG1h
X3F1aXJrIHByaXZhdGUgdG8gdGhlIGNvcmUuCgpUaGF0IHNob3VsZCB3b3JrLgoKdGFrZSBjYXJl
LAogIEdlcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
