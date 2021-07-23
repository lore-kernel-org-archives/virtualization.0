Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5094BC4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 12:10:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D767660EBD
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 12:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D767660EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 90D8B40177;
	Fri, 23 Jul 2021 12:10:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RdU2aVDLtJoU; Fri, 23 Jul 2021 12:10:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 320F7400A4;
	Fri, 23 Jul 2021 12:10:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE6A0C001A;
	Fri, 23 Jul 2021 12:10:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4042CC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 22115400FE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:10:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IRLI1Ah8wAkG
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:10:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61AA5400A4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627042236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jrUq+tDYS1o0ADpuP+GAtrKfXpud7C8xQk9ZtM+66hY=;
 b=iUgbCAFzNcG6tj1174HV8/3A4U0uMoCYqPvMR4YZfmrcObpqfTweI+zL4iJhz8z7CSSh5w
 iaDIQBNARx3eQwGwxke55xbNcW6Qy9iBCP1zq2w/nY7ElLpJ5JHDIwKcEH2Q/NFqyOoGE0
 LJUNi5IL/AeNquuZ6b9s6rZ+nLRkgew=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-IyhE94QROa6g4EGdKmSL7w-1; Fri, 23 Jul 2021 08:10:35 -0400
X-MC-Unique: IyhE94QROa6g4EGdKmSL7w-1
Received: by mail-wr1-f72.google.com with SMTP id
 v16-20020adfa1d00000b02901401e436a18so885667wrv.21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 05:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=jrUq+tDYS1o0ADpuP+GAtrKfXpud7C8xQk9ZtM+66hY=;
 b=Wyt969kLDUgyavzBQpzwY4Y7MPuX/tZkcpGLpWHFMPDomBQ/6SEbx0IsYexcGmV3BL
 9If257np0B+WB6jljuT/v4bBiVkNTtsnDDFluutu4yQT1QEjaeqrQrtByDmVrP76F6HT
 6vPjUbv4Qg2wwClq7yL05BOpEbOnAERYq6jXm6SCDeDlM+Fb4T3tF/tVEbD3qFXVr4gg
 md85PYb9cDYYf4OtOFZGnou9XY8MRQJ1hW/1eHp1NJdetqzHwhglIe/a3h/g45TnO3VC
 1AxLQFTPGjbTLmBT1B2QYmxqof4oRz+60sh7dnDCzvA2j07uWfTbXErhbHu7tN56gtVF
 nYhg==
X-Gm-Message-State: AOAM532IpK1UIa4sZ1AttXGMlrr+kJArWZhCG7O8F0v2G/rfpwSIZHDN
 TCz5YnvlGsZpRqdUuQKRju0SVWfju6iy0EGgrUe3gtbBf+74j5V4V+0Wt9ye1jcw+AFgcBWQa3d
 bP9RE83I6BGwEhkjjRMxZAFlXA472tlUuD2Qgizom6Q==
X-Received: by 2002:a05:600c:8a9:: with SMTP id
 l41mr4237786wmp.161.1627042234271; 
 Fri, 23 Jul 2021 05:10:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8PRGzPRMIfyybE39283VZoQoe/7AqATcpzwY0Co/jb2Zhmeq8xgiIND4qCwJQSsKJI0Jzsg==
X-Received: by 2002:a05:600c:8a9:: with SMTP id
 l41mr4237753wmp.161.1627042233990; 
 Fri, 23 Jul 2021 05:10:33 -0700 (PDT)
Received: from redhat.com ([2.55.16.196])
 by smtp.gmail.com with ESMTPSA id x18sm32079653wrw.19.2021.07.23.05.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 05:10:33 -0700 (PDT)
Date: Fri, 23 Jul 2021 08:10:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ivan <ivan@prestigetransportation.com>
Subject: Re: PROBLEM: virtio_net LRO kernel panics
Message-ID: <20210723080924-mutt-send-email-mst@kernel.org>
References: <CACFia2dwacaVVYD+1uG=CDGaJqdCOSBvZ5FcXp04caecaWAY3w@mail.gmail.com>
 <CAMDZJNXthLpAPHn62gA1qSmfLOoDFcFGdgnNwW6yA+wjn0FjgQ@mail.gmail.com>
 <CACFia2fDZHUZB5wJ7LK8M2sv_+W58rHw0NzzrwPPoX9=s7yPdQ@mail.gmail.com>
 <9547a9e5-738c-2009-a2af-66173d305c2d@redhat.com>
 <CACFia2eLCJuy=w1r20691s_cSYkBkPaY-Dbd-9CkrcpSAe7z6g@mail.gmail.com>
 <5fd9c67f-d900-7694-f0a8-62682c8a14c8@redhat.com>
 <CACFia2eH3eCZxtt70LB5zoPbhLXRv=crPh5oOhR=6mY3auDdQA@mail.gmail.com>
 <20210723035713-mutt-send-email-mst@kernel.org>
 <CACFia2fWhWKMGF3g8SfU++2-jQ1rCKtCJo3h08KmhGfMTuZaQQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACFia2fWhWKMGF3g8SfU++2-jQ1rCKtCJo3h08KmhGfMTuZaQQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "David S. Miller" <davem@davemloft.net>,
 virtualization@lists.linux-foundation.org,
 Willem de Bruijn <willemb@google.com>
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

T24gRnJpLCBKdWwgMjMsIDIwMjEgYXQgMDM6MDY6MDRBTSAtMDUwMCwgSXZhbiB3cm90ZToKPiBP
biBGcmksIEp1bCAyMywgMjAyMSBhdCAyOjU5IEFNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRodSwgSnVsIDIyLCAyMDIxIGF0IDExOjUwOjEx
UE0gLTA1MDAsIEl2YW4gd3JvdGU6Cj4gPiA+IE9uIFRodSwgSnVsIDIyLCAyMDIxIGF0IDExOjI1
IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+IOWcqCAy
MDIxLzcvMjMg5LiK5Y2IMTA6NTQsIEl2YW4g5YaZ6YGTOgo+ID4gPiA+ID4gT24gVGh1LCBKdWwg
MjIsIDIwMjEgYXQgOTozNyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPiA+ID4gPiA+PiBEb2VzIGl0IHdvcmsgaWYgeW91IHR1cm4gb2ZmIGxybyBiZWZvcmUgZW5h
YmxpbmcgdGhlIGZvcndhcmRpbmc/Cj4gPiA+ID4gPiAwIHJvb3RATnVSYWlkOn4jIGV0aHRvb2wg
LUsgZXRoMCBscm8gb2ZmCj4gPiA+ID4gPiBBY3R1YWwgY2hhbmdlczoKPiA+ID4gPiA+IHJ4LWxy
bzogb24gW3JlcXVlc3RlZCBvZmZdCj4gPiA+ID4gPiBDb3VsZCBub3QgY2hhbmdlIGFueSBkZXZp
Y2UgZmVhdHVyZXMKPiA+ID4gPgo+ID4gPiA+IE9rLCBpdCBsb29rcyBsaWtlIHRoZSBkZXZpY2Ug
bWlzc2VzIHRoZSBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUwo+ID4gPiA+IHdoaWNo
IG1ha2VzIGl0IGltcG9zc2libGUgdG8gY2hhbmdlIHRoZSBMUk8gc2V0dGluZy4KPiA+ID4gPgo+
ID4gPiA+IERpZCB5b3UgdXNlIHFlbXU/IElmIHllcywgd2hhdCdzIHRoZSBxZW11IHZlcnNpb24g
eW91J3ZlIHVzZWQ/Cj4gPiA+Cj4gPiA+IFRoZXNlIGFyZSBWaXJ0dWFsQm94IG1hY2hpbmVzLCB3
aGljaCBJJ3ZlIGJlZW4gdXNpbmcgZm9yIHllYXJzIHdpdGgKPiA+ID4gbG9uZ3Rlcm0ga2VybmVs
cyA0LjE5LCBhbmQgSSBuZXZlciBoYWQgc3VjaCBhIHByb2JsZW0uICBCdXQgbm93IHRoYXQgSQo+
ID4gPiB0cmllZCB1cGdyYWRpbmcgdG8ga2VybmVscyA1LjEwIG9yIDUuMTMgLS0gdGhlIHBhbmlj
cyBzdGFydGVkLiAgVGhlc2UKPiA+ID4gYXJlIGp1c3QgZ2VuZXJpYyBrZXJuZWwgYnVpbGRzLCBh
bmQgYSBtaW5pbWFsaXN0aWMgdXNlcnNwYWNlLgo+ID4KPiA+IEkgd291bGQgYmUgdXNlZnVsIHRv
IHNlZSB0aGUgZmVhdHVyZXMgeW91ciB2aXJ0dWFsYm94IGluc3RhbmNlIHByb3ZpZGVzCj4gPgo+
ID4gY2F0IC9zeXMvY2xhc3MvbmV0L2V0aDAvZGV2aWNlL2ZlYXR1cmVzCj4gCj4gIyBjYXQgL3N5
cy9jbGFzcy9uZXQvZXRoMC9kZXZpY2UvZmVhdHVyZXMKPiAxMTAwMDEwMTEwMTExMDExMTExMTAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwCgpJIHdhcyBhYmxlIHRv
IHJlcHJvZHVjZSB0aGUgd2FybmluZyBidXQgbm90IHRoZSBwYW5pYy4KT1RPSCBpZiBMUk8gc3Rh
eXMgb24gd2hlbiBlbmFibGluZyBmb3J3YXJkaW5nIHRoYXQKaXMgYWxyZWFkeSBhIHByb2JsZW0u
IEFueSBjaGFuY2UgeW91IGNhbiBiaXNlY3QgdG8KZmluZCBvdXQgd2hpY2ggY2hhbmdlIGludHJv
ZHVjZWQgdGhlIHBhbmljPwoKLS0gCk1TVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
