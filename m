Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBB4C7618E
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 03:42:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19F4081E38;
	Mon, 24 Apr 2023 03:42:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19F4081E38
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gj07a3U3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EDWy-5EKSLhA; Mon, 24 Apr 2023 03:42:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7AD7C81E39;
	Mon, 24 Apr 2023 03:42:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7AD7C81E39
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FDB5C0037;
	Mon, 24 Apr 2023 03:42:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1371C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 03:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB5DA40568
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 03:42:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB5DA40568
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gj07a3U3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r_9KAk7QT0wM
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 03:42:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6EBA740133
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EBA740133
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 03:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682307756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNCBa7OjCC7JqsI3cEfxVx1YPRoGVy6yo4FMo1YynBA=;
 b=gj07a3U36kNhwnrxXWS0qvylxk8H7nS6eWlRv6rovG/HnNjd2lhBh2hk5VCpWmG22HYi4H
 vwN1TB75wJqGIUA78OGyzb52x2IKFX7la8k4aPPfwklYwzAgkr7elm2w6/L8u5DJfk2xS2
 pxPEnYaxtlVC0TfsFew+olY5Kx/cJ0Q=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-AH5qhbOOOBudlukyWJ_-rg-1; Sun, 23 Apr 2023 23:42:34 -0400
X-MC-Unique: AH5qhbOOOBudlukyWJ_-rg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-38dfa5cb943so2618210b6e.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 20:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682307753; x=1684899753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNCBa7OjCC7JqsI3cEfxVx1YPRoGVy6yo4FMo1YynBA=;
 b=jqs/ggJRECB/Yjvs7SxdGudMx5HrCZ4lX2UOjgVdPQRfEbYHWesD8U6kH6RjGHX6QO
 v68f269VcZJcX4FuwQS4g/9ct7N9A2f2dvn83wo3Wvy7It6+DsuvWkuxEq9Mm0alQYxy
 kHoCV/yTUMeUAx27Ck3zf9RRZkyVM6bxsKFcJMzcKP5IF1vKMF4q0Q4dkGgjjb6Q5q03
 tXWURFnuIl4ehN7l5zhVvrsrdhnGCWLAOJ0Gy539ldXOPn+pVnmLXuVsfOoS8WPJGt72
 n5m1TF01Cw+GuYgjdzlTewr2Fb+x0yN86YpjTzSvy8mBhIneLDOM3NrxPp5UwjJGXevo
 CgYQ==
X-Gm-Message-State: AAQBX9eMpkOrAJJ3Z7/33pAzk0Pt/kt1frkmuKLTRhj2/A+V6r3HS5f8
 eJunqoh5GgzQToswPPHkA435hTTQOi6GezT2JQQHSq3Kb0amE7Wimz7gT+8IkSRr3TwwwZxQpm5
 21FHzUGRjKliVA6n8EB4b+8kRMmIYGNR2/WP3fL6q0aW53/EEsj7Wjn3DQQ==
X-Received: by 2002:a05:6808:196:b0:38e:67c5:50f9 with SMTP id
 w22-20020a056808019600b0038e67c550f9mr6166230oic.43.1682307753566; 
 Sun, 23 Apr 2023 20:42:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350bhb4SNjD4VqfNK9W6sYOBQTejlD7JIRYQvUf3qF3wdOgposi7pfPM+x9HFPX2SdLWK6pAXYrgljD8e2NvxZbs=
X-Received: by 2002:a05:6808:196:b0:38e:67c5:50f9 with SMTP id
 w22-20020a056808019600b0038e67c550f9mr6166217oic.43.1682307753329; Sun, 23
 Apr 2023 20:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
 <CACGkMEuiHqPkqYk1ZG3RZXLjm+EM3bmR0v1T1yH-ADEazOwTMA@mail.gmail.com>
 <d7530c13-f1a1-311e-7d5e-8e65f3bc2e50@redhat.com>
 <CACGkMEuWpHokhwvJ5cF41_C=ezqFhoOyUOposdZ5+==A642OmQ@mail.gmail.com>
 <88a24206-b576-efc6-1bce-7f5075024c63@redhat.com>
 <CACGkMEuZpk8QcrUQSOxqt6j3F9Ge-HdSs5-18FayMMQmH3Tcmg@mail.gmail.com>
 <CACycT3sbn=DSf0qW5RchV=FauDdn2eoMLEkRGAU3wXZZJwDsrw@mail.gmail.com>
In-Reply-To: <CACycT3sbn=DSf0qW5RchV=FauDdn2eoMLEkRGAU3wXZZJwDsrw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Apr 2023 11:42:22 +0800
Message-ID: <CACGkMEsUdRZEOsJX2H9b7E0uHYktm4BGkhD55Oqpwjna+Xi=vw@mail.gmail.com>
Subject: Re: [RFC 0/2] vduse: add support for networking devices
To: Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 David Marchand <david.marchand@redhat.com>
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

T24gU3VuLCBBcHIgMjMsIDIwMjMgYXQgNDoyMuKAr1BNIFlvbmdqaSBYaWUgPHhpZXlvbmdqaUBi
eXRlZGFuY2UuY29tPiB3cm90ZToKPgo+IE9uIFN1biwgQXByIDIzLCAyMDIzIGF0IDI6MzHigK9Q
TSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBGcmks
IEFwciAyMSwgMjAyMyBhdCAxMDoyOOKAr1BNIE1heGltZSBDb3F1ZWxpbgo+ID4gPG1heGltZS5j
b3F1ZWxpbkByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4KPiA+ID4KPiA+ID4gT24gNC8y
MS8yMyAwNzo1MSwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiBPbiBUaHUsIEFwciAyMCwgMjAy
MyBhdCAxMDoxNuKAr1BNIE1heGltZSBDb3F1ZWxpbgo+ID4gPiA+IDxtYXhpbWUuY29xdWVsaW5A
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4+Cj4gPiA+ID4+Cj4gPiA+ID4+Cj4gPiA+ID4+IE9u
IDQvMjAvMjMgMDY6MzQsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4+PiBPbiBXZWQsIEFwciAx
OSwgMjAyMyBhdCA5OjQz4oCvUE0gTWF4aW1lIENvcXVlbGluCj4gPiA+ID4+PiA8bWF4aW1lLmNv
cXVlbGluQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+Pj4+Cj4gPiA+ID4+Pj4gVGhpcyBzbWFs
bCBzZXJpZXMgZW5hYmxlcyB2aXJ0aW8tbmV0IGRldmljZSB0eXBlIGluIFZEVVNFLgo+ID4gPiA+
Pj4+IFdpdGggaXQsIGJhc2ljIG9wZXJhdGlvbiBoYXZlIGJlZW4gdGVzdGVkLCBib3RoIHdpdGgK
PiA+ID4gPj4+PiB2aXJ0aW8tdmRwYSBhbmQgdmhvc3QtdmRwYSB1c2luZyBEUERLIFZob3N0IGxp
YnJhcnkgc2VyaWVzCj4gPiA+ID4+Pj4gYWRkaW5nIFZEVVNFIHN1cHBvcnQgWzBdIHVzaW5nIHNw
bGl0IHJpbmdzIGxheW91dC4KPiA+ID4gPj4+Pgo+ID4gPiA+Pj4+IENvbnRyb2wgcXVldWUgc3Vw
cG9ydCAoYW5kIHNvIG11bHRpcXVldWUpIGhhcyBhbHNvIGJlZW4KPiA+ID4gPj4+PiB0ZXN0ZWQs
IGJ1dCByZXF1aXJlIGEgS2VybmVsIHNlcmllcyBmcm9tIEphc29uIFdhbmcKPiA+ID4gPj4+PiBy
ZWxheGluZyBjb250cm9sIHF1ZXVlIHBvbGxpbmcgWzFdIHRvIGZ1bmN0aW9uIHJlbGlhYmx5Lgo+
ID4gPiA+Pj4+Cj4gPiA+ID4+Pj4gT3RoZXIgdGhhbiB0aGF0LCB3ZSBoYXZlIGlkZW50aWZpZWQg
YSBmZXcgZ2FwczoKPiA+ID4gPj4+Pgo+ID4gPiA+Pj4+IDEuIFJlY29ubmVjdGlvbjoKPiA+ID4g
Pj4+PiAgICBhLiBWRFVTRV9WUV9HRVRfSU5GTyBpb2N0bCgpIHJldHVybnMgYWx3YXlzIDAgZm9y
IGF2YWlsCj4gPiA+ID4+Pj4gICAgICAgaW5kZXgsIGV2ZW4gYWZ0ZXIgdGhlIHZpcnRxdWV1ZSBo
YXMgYWxyZWFkeSBiZWVuCj4gPiA+ID4+Pj4gICAgICAgcHJvY2Vzc2VkLiBJcyB0aGF0IGV4cGVj
dGVkPyBJIGhhdmUgdHJpZWQgaW5zdGVhZCB0bwo+ID4gPiA+Pj4+ICAgICAgIGdldCB0aGUgZHJp
dmVyJ3MgYXZhaWwgaW5kZXggZGlyZWN0bHkgZnJvbSB0aGUgYXZhaWwKPiA+ID4gPj4+PiAgICAg
ICByaW5nLCBidXQgaXQgZG9lcyBub3Qgc2VlbSByZWxpYWJsZSBhcyBJIHNvbWV0aW1lcyBnZXQK
PiA+ID4gPj4+PiAgICAgICAiaWQgJXUgaXMgbm90IGEgaGVhZCFcbiIgd2FybmluZ3MuIEFsc28g
c3VjaCBzb2x1dGlvbgo+ID4gPiA+Pj4+ICAgICAgIHdvdWxkIG5vdCBiZSBwb3NzaWJsZSB3aXRo
IHBhY2tlZCByaW5nLCBhcyB3ZSBuZWVkIHRvCj4gPiA+ID4+Pj4gICAgICAga25vdyB0aGUgd3Jh
cCBjb3VudGVycyB2YWx1ZXMuCj4gPiA+ID4+Pgo+ID4gPiA+Pj4gTG9va2luZyBhdCB0aGUgY29k
ZXMsIGl0IG9ubHkgcmV0dXJucyB0aGUgdmFsdWUgdGhhdCBpcyBzZXQgdmlhCj4gPiA+ID4+PiBz
ZXRfdnFfc3RhdGUoKS4gSSB0aGluayBpdCBpcyBleHBlY3RlZCB0byBiZSBjYWxsZWQgYmVmb3Jl
IHRoZQo+ID4gPiA+Pj4gZGF0YXBhdGggcnVucy4KPiA+ID4gPj4+Cj4gPiA+ID4+PiBTbyB3aGVu
IGJvdW5kIHRvIHZpcnRpby12ZHBhLCBpdCBpcyBleHBlY3RlZCB0byByZXR1cm4gMC4gQnV0IHdl
IG5lZWQKPiA+ID4gPj4+IHRvIGZpeCB0aGUgcGFja2VkIHZpcnRxdWV1ZSBjYXNlLCBJIHdvbmRl
ciBpZiB3ZSBuZWVkIHRvIGNhbGwKPiA+ID4gPj4+IHNldF92cV9zdGF0ZSgpIGV4cGxpY2l0bHkg
aW4gdmlydGlvLXZkcGEgYmVmb3JlIHN0YXJ0aW5nIHRoZSBkZXZpY2UuCj4gPiA+ID4+Pgo+ID4g
PiA+Pj4gV2hlbiBib3VuZCB0byB2aG9zdC12ZHBhLCBRZW11IHdpbGwgY2FsbCBWSE9TVF9TRVRf
VlJJTkdfQkFTRSB3aGljaAo+ID4gPiA+Pj4gd2lsbCBlbmQgdXAgYSBjYWxsIHRvIHNldF92cV9z
dGF0ZSgpLiBVbmZvcnR1bmF0ZWx5LCBpdCBkb2Vzbid0Cj4gPiA+ID4+PiBzdXBwb3J0IHBhY2tl
ZCByaW5nIHdoaWNoIG5lZWRzIHNvbWUgZXh0ZW5zaW9uLgo+ID4gPiA+Pj4KPiA+ID4gPj4+Pgo+
ID4gPiA+Pj4+ICAgIGIuIE1pc3NpbmcgSU9DVExzOiBpdCB3b3VsZCBiZSBoYW5keSB0byBoYXZl
IG5ldyBJT0NUTHMgdG8KPiA+ID4gPj4+PiAgICAgICBxdWVyeSBWaXJ0aW8gZGV2aWNlIHN0YXR1
cywKPiA+ID4gPj4+Cj4gPiA+ID4+PiBXaGF0J3MgdGhlIHVzZSBjYXNlIG9mIHRoaXMgaW9jdGw/
IEl0IGxvb2tzIHRvIG1lIHVzZXJzcGFjZSBpcwo+ID4gPiA+Pj4gbm90aWZpZWQgb24gZWFjaCBz
dGF0dXMgY2hhbmdlIG5vdzoKPiA+ID4gPj4+Cj4gPiA+ID4+PiBzdGF0aWMgaW50IHZkdXNlX2Rl
dl9zZXRfc3RhdHVzKHN0cnVjdCB2ZHVzZV9kZXYgKmRldiwgdTggc3RhdHVzKQo+ID4gPiA+Pj4g
ewo+ID4gPiA+Pj4gICAgICAgICAgIHN0cnVjdCB2ZHVzZV9kZXZfbXNnIG1zZyA9IHsgMCB9Owo+
ID4gPiA+Pj4KPiA+ID4gPj4+ICAgICAgICAgICBtc2cucmVxLnR5cGUgPSBWRFVTRV9TRVRfU1RB
VFVTOwo+ID4gPiA+Pj4gICAgICAgICAgIG1zZy5yZXEucy5zdGF0dXMgPSBzdGF0dXM7Cj4gPiA+
ID4+Pgo+ID4gPiA+Pj4gICAgICAgICAgIHJldHVybiB2ZHVzZV9kZXZfbXNnX3N5bmMoZGV2LCAm
bXNnKTsKPiA+ID4gPj4+IH0KPiA+ID4gPj4KPiA+ID4gPj4gVGhlIGlkZWEgd2FzIHRvIGJlIGFi
bGUgdG8gcXVlcnkgdGhlIHN0YXR1cyBhdCByZWNvbm5lY3QgdGltZSwgYW5kCj4gPiA+ID4+IG5l
aXRoZXIgaGF2aW5nIHRvIGFzc3VtZSBpdHMgdmFsdWUgbm9yIGhhdmluZyB0byBzdG9yZSBpdHMg
dmFsdWUgaW4gYQo+ID4gPiA+PiBmaWxlICh0aGUgc3RhdHVzIGNvdWxkIGNoYW5nZSB3aGlsZSB0
aGUgVkRVU0UgYXBwbGljYXRpb24gaXMgc3RvcHBlZCwKPiA+ID4gPj4gYnV0IG1heWJlIGl0IHdv
dWxkIHJlY2VpdmUgdGhlIG5vdGlmaWNhdGlvbiBhdCByZWNvbm5lY3QpLgo+ID4gPiA+Cj4gPiA+
ID4gSSBzZWUuCj4gPiA+ID4KPiA+ID4gPj4KPiA+ID4gPj4gSSB3aWxsIHByb3RvdHlwZSB1c2lu
ZyBhIHRtcGZzIGZpbGUgdG8gc2F2ZSBuZWVkZWQgaW5mb3JtYXRpb24sIGFuZCBzZWUKPiA+ID4g
Pj4gaWYgaXQgd29ya3MuCj4gPiA+ID4KPiA+ID4gPiBJdCBtaWdodCB3b3JrIGJ1dCB0aGVuIHRo
ZSBBUEkgaXMgbm90IHNlbGYgY29udGFpbmVkLiBNYXliZSBpdCdzCj4gPiA+ID4gYmV0dGVyIHRv
IGhhdmUgYSBkZWRpY2F0ZWQgaW9jdGwuCj4gPiA+ID4KPiA+ID4gPj4KPiA+ID4gPj4+PiBhbmQg
cmV0cmlldmUgdGhlIGNvbmZpZwo+ID4gPiA+Pj4+ICAgICAgIHNwYWNlIHNldCBhdCBWRFVTRV9D
UkVBVEVfREVWIHRpbWUuCj4gPiA+ID4+Pgo+ID4gPiA+Pj4gSW4gb3JkZXIgdG8gYmUgc2FmZSwg
VkRVU0UgYXZvaWRzIHdyaXRhYmxlIGNvbmZpZyBzcGFjZS4gT3RoZXJ3aXNlCj4gPiA+ID4+PiBk
cml2ZXJzIGNvdWxkIGJsb2NrIG9uIGNvbmZpZyB3cml0aW5nIGZvcmV2ZXIuIFRoYXQncyB3aHkg
d2UgZG9uJ3QgZG8KPiA+ID4gPj4+IGl0IG5vdy4KPiA+ID4gPj4KPiA+ID4gPj4gVGhlIGlkZWEg
d2FzIG5vdCB0byBtYWtlIHRoZSBjb25maWcgc3BhY2Ugd3JpdGFibGUsIGJ1dCBqdXN0IHRvIGJl
IGFibGUKPiA+ID4gPj4gdG8gZmV0Y2ggd2hhdCB3YXMgZmlsbGVkIGF0IFZEVVNFX0NSRUFURV9E
RVYgdGltZS4KPiA+ID4gPj4KPiA+ID4gPj4gV2l0aCB0aGUgdG1wZnMgZmlsZSwgd2UgY2FuIGF2
b2lkIGRvaW5nIHRoYXQgYW5kIGp1c3Qgc2F2ZSB0aGUgY29uZmlnCj4gPiA+ID4+IHNwYWNlIHRo
ZXJlLgo+ID4gPiA+Cj4gPiA+ID4gU2FtZSBhcyB0aGUgY2FzZSBmb3Igc3RhdHVzLgo+ID4gPgo+
ID4gPiBJIGhhdmUgY29va2VkIGEgRFBESyBwYXRjaCB0byBzdXBwb3J0IHJlY29ubmVjdCB3aXRo
IGEgdG1wZnMgZmlsZSBhcwo+ID4gPiBzdWdnZXN0ZWQgYnkgWW9uZ2ppOgo+ID4gPgo+ID4gPiBo
dHRwczovL2dpdGxhYi5jb20vbWNvcXVlbGluL2RwZGstbmV4dC12aXJ0aW8vLS9jb21taXQvNTM5
MTNmMmIxMTU1YjAyYzQ0ZDVkM2QyOThhYWZkMzU3ZTdhOGM0OAo+ID4KPiA+IFRoaXMgc2VlbXMg
dHJpY2t5LCBmb3IgZXhhbXBsZSBmb3Igc3RhdHVzOgo+ID4KPiA+IGRldi0+bG9nLT5zdGF0dXMg
PSBkZXYtPnN0YXR1czsKPiA+Cj4gPiBXaGF0IGlmIHdlIGNyYXNoIGhlcmU/Cj4gPgo+Cj4gVGhl
IG1lc3NhZ2Ugd2lsbCBiZSByZS1zZW50IGJ5IHRoZSBrZXJuZWwgaWYgaXQncyBub3QgcmVwbGll
ZC4gQnV0IEkKPiB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgaWYgd2UgY2FuIHJlc3RvcmUgaXQg
dmlhIHNvbWUgaW9jdGwuCgpZZXMsIHRoZSBwb2ludCBpcywgd2l0aG91dCBhIGdldCBpb2N0bCwg
aXQncyB2ZXJ5IGhhcmQgdG8gYXVkaXQgdGhlIGNvZGUuCgpUaGFua3MKCj4KPiBUaGFua3MsCj4g
WW9uZ2ppCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
