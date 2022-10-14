Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3DFC4332F
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 05:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7121142224;
	Fri, 14 Oct 2022 05:32:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7121142224
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hxWgxf3+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FvtJPGV2rtYc; Fri, 14 Oct 2022 05:32:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C2AA42225;
	Fri, 14 Oct 2022 05:32:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C2AA42225
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E942C0033;
	Fri, 14 Oct 2022 05:32:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED818C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 05:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAA6542225
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 05:32:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAA6542225
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id umCon7NHi1xP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 05:32:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0F6642224
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F0F6642224
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 05:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665725568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWNFgRVlGjYNydd5Fi8o/nyAidzrHzoVF78WNHdTm7o=;
 b=hxWgxf3+mZAniUfoNH/fUYRtpT+eYdGbMt2wXESwppKF9H6fXpkONWNacbo8paDwnXqxkT
 rX1PR3TLmBTzUoqoX0GlMt/pFVogBN4IU5/mzXOiiS86C4T2rSnVpJGx+JhEB9g1kr4VM2
 RJ720gVS1uhn+jCMALmVnH7WcISYgQg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-277-Wdr9x5_vO2qWjNvRif_MZQ-1; Fri, 14 Oct 2022 01:32:47 -0400
X-MC-Unique: Wdr9x5_vO2qWjNvRif_MZQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 v23-20020a1cf717000000b003bff630f31aso1645241wmh.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 22:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BWNFgRVlGjYNydd5Fi8o/nyAidzrHzoVF78WNHdTm7o=;
 b=peHTI5FX4lJxY+mOGD6GjmpDqYGCbL59lG8iw9JrpJtJsYCCvURofJD8NXXzN5ywdZ
 XUJTcq+udoQzTuuKOcW5AvxEN3sOuCrKJfEuIHxNIDvbUyTDUNjdFST716XirNuN3SGg
 p7joZDDO5so5VtduE/157FIrCHzm0IxBynz37czE0ZI9ugYSZxxJ+Dw9i/1ZduPDwR/A
 pVhgHqI/1GteWy6uuIJXDsUmoOlb8DEydqSAY9jPyti27vWwVRn8K1t8svRueuf/YCVp
 rOqzyphP45wa/moaISdC2NJbelmyWO755N0BVX2rFd+k78ATNyawBRUT2/mDI+mgfrds
 3oOQ==
X-Gm-Message-State: ACrzQf1DcFHb4ArUr8v0mfYnGCM+M5gzv28PD2/EjnvW3l5tkXjdHUWU
 KW1iZti+xwkgtdREEyi1HCacLxNcUWqxdQ010+BFuNtT/QRaAi8hgBgh1yA6e80bS0CeBTmM1sq
 npaZnQXaEl+GbH9kRaqa3syQtO/+9XHWfxBacEwR35A==
X-Received: by 2002:a05:600c:6885:b0:3c4:de24:638 with SMTP id
 fn5-20020a05600c688500b003c4de240638mr8799781wmb.183.1665725566136; 
 Thu, 13 Oct 2022 22:32:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4R1CQSNUlZz9bqJOSmz/KQyXR4UqWpCPLl4Qqk64SVMiSobCwwLzb2VOcQZa8mbMypnWERfA==
X-Received: by 2002:a05:600c:6885:b0:3c4:de24:638 with SMTP id
 fn5-20020a05600c688500b003c4de240638mr8799770wmb.183.1665725565818; 
 Thu, 13 Oct 2022 22:32:45 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 u7-20020a05600c19c700b003bf6da9d2cesm6022807wmq.28.2022.10.13.22.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Oct 2022 22:32:45 -0700 (PDT)
Date: Fri, 14 Oct 2022 01:32:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] virtio_pci: use irq to detect interrupt support
Message-ID: <20221014013156-mutt-send-email-mst@kernel.org>
References: <20221012220312.308522-1-mst@redhat.com>
 <TY2PR06MB3424171328BEE476FCB9942785249@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR06MB3424171328BEE476FCB9942785249@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gRnJpLCBPY3QgMTQsIDIwMjIgYXQgMTI6MDk6MjBBTSArMDAwMCwgQW5ndXMgQ2hlbiB3cm90
ZToKPiBIaSBNc3QKPiAKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBN
aWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4gU2VudDogVGh1cnNkYXksIE9j
dG9iZXIgMTMsIDIwMjIgNjowNCBBTQo+ID4gVG86IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcKPiA+IENjOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+
OyBNaWNoYWVsIEVsbGVybWFuCj4gPiA8bXBlQGVsbGVybWFuLmlkLmF1PjsgQW5ndXMgQ2hlbiA8
YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+OyBKYXNvbgo+ID4gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT47IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gPiBT
dWJqZWN0OiBbUEFUQ0hdIHZpcnRpb19wY2k6IHVzZSBpcnEgdG8gZGV0ZWN0IGludGVycnVwdCBz
dXBwb3J0Cj4gPiAKPiA+IGNvbW1pdCA3MTQ5MWM1NGVhZmEgKCJ2aXJ0aW9fcGNpOiBkb24ndCB0
cnkgdG8gdXNlIGludHhpZiBwaW4gaXMgemVybyIpCj4gPiBicmVha3MgdmlydGlvX3BjaSBvbiBw
b3dlcnBjLCB3aGVuIHJ1bm5pbmcgYXMgYSBxZW11IGd1ZXN0Lgo+ID4gCj4gPiB2cF9maW5kX3Zx
cygpIGJhaWxzIG91dCBiZWNhdXNlIHBjaV9kZXYtPnBpbiA9PSAwLgo+ID4gCj4gPiBCdXQgcGNp
X2Rldi0+aXJxIGlzIHBvcHVsYXRlZCBjb3JyZWN0bHksIHNvIHZwX2ZpbmRfdnFzX2ludHgoKSB3
b3VsZAo+ID4gc3VjY2VlZCBpZiB3ZSBjYWxsZWQgaXQgLSB3aGljaCBpcyB3aGF0IHRoZSBjb2Rl
IHVzZWQgdG8gZG8uCj4gPiAKPiA+IFRoaXMgc2VlbXMgdG8gaGFwcGVuIGJlY2F1c2UgcGNpX2Rl
di0+cGluIGlzIG5vdCBwb3B1bGF0ZWQgaW4KPiA+IHBjaV9hc3NpZ25faXJxKCkuCj4gPiAKPiA+
IFdoaWNoIGlzIGFic29sdXRlbHkgYSBidWcgaW4gdGhlIHJlbGV2YW50IFBDSSBjb2RlLCBidXQg
aXQKPiA+IG1heSBhbHNvIGFmZmVjdCBvdGhlciBwbGF0Zm9ybXMgdGhhdCB1c2Ugb2ZfaXJxX3Bh
cnNlX2FuZF9tYXBfcGNpKCkuCj4gPiAKPiA+IEhvd2V2ZXIgTGludXMgc2FpZDoKPiA+IAlUaGUg
Y29ycmVjdCB3YXkgdG8gY2hlY2sgZm9yICJubyBpcnEiIGRvZXNuJ3QgdXNlIE5PX0lSUSBhdCBh
bGwsIGl0IGp1c3QgZG9lcwo+ID4gCQlpZiAoZGV2LT5pcnEpIC4uLgo+ID4gc28gbGV0J3MganVz
dCBjaGVjayBpcnEgYW5kIGJlIGRvbmUgd2l0aCBpdC4KPiA+IAo+ID4gU3VnZ2VzdGVkLWJ5OiBM
aW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+Cj4gPiBSZXBvcnRl
ZC1ieTogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1Pgo+ID4gRml4ZXM6IDcx
NDkxYzU0ZWFmYSAoInZpcnRpb19wY2k6IGRvbid0IHRyeSB0byB1c2UgaW50eGlmIHBpbiBpcyB6
ZXJvIikKPiA+IENjOiAiQW5ndXMgQ2hlbiIgPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPgo+
ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiA+
IC0tLQo+ID4gCj4gPiBCdWlsZCB0ZXN0ZWQgb25seSAtIHZlcnkgbGF0ZSBoZXJlLiBBbmd1cyBh
bnkgY2hhbmNlIHlvdSBjb3VsZAo+ID4gaGVscCB0ZXN0IHRoaXM/IFRoYW5rcyEKPiBJIHRlc3Rl
ZCB0aGUgcGF0Y2gg77yMaXQgd29yayB3ZWxsIG9uIHg4NuOAgklubGN1ZGUgbGVnYWN5IGFuZCBt
b2Rlcm4gZHJpdmVyLgo+IEFuZCBJIHRlc3RlZCBpdCBvbiBhcm0gc2VydmVyIGFsc2/vvIxhbmQg
ZmluZCBzb21lIHByb2JsZW0gYmVjYXVzZSBvZiAwLjkuNSBsaW1pdGF0aW9uLgo+ICAicGxhdGZv
cm0gYnVnOiBsZWdhY3kgdmlydGlvLXBjaSBtdXN0IG5vdCBiZSB1c2VkIHdpdGggUkFNIGFib3Zl
IDB4JWxseEdCXG4iLAo+ICBCdXQgdGhlIGVycm9yIGlzIG5vdCBlZmZlY3RlZCBieSBvdXIgcGF0
Y2gud2l0aCBvciB3aXRob3V0IG91ciBwYXRjaCAsaXQgcHJpbnQgdGhlIHNhbWUuCgpZZXMgdGhh
dCdzIGEgbGltaXRhdGlvbiBvZiAwLjkuNSAtIGp1c3QgbWFrZSBhIHNtYWxsZXIgVk0gdG8gdGVz
dApsZWdhY3kuCgo+IEFuZCBJIHRlc3QgbW9kZXJuIGRpcnZlcixpdCB3b3JrIHdlbGwgYWxzby4K
PiBTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuCgoKR3JlYXQsIHRoYW5rcyBhIGxvdCEKCj4gPiAK
PiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIHwgNCArKy0tCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiA+IGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYwo+ID4gaW5kZXggNGRmNzdlZWI0ZDE2Li5hNmM4
NmY5MTZkYmQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1v
bi5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4gPiBAQCAt
NDA5LDggKzQwOSw4IEBAIGludCB2cF9maW5kX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
diwgdW5zaWduZWQgaW50Cj4gPiBudnFzLAo+ID4gIAllcnIgPSB2cF9maW5kX3Zxc19tc2l4KHZk
ZXYsIG52cXMsIHZxcywgY2FsbGJhY2tzLCBuYW1lcywgZmFsc2UsIGN0eCwgZGVzYyk7Cj4gPiAg
CWlmICghZXJyKQo+ID4gIAkJcmV0dXJuIDA7Cj4gPiAtCS8qIElzIHRoZXJlIGFuIGludGVycnVw
dCBwaW4/IElmIG5vdCBnaXZlIHVwLiAqLwo+ID4gLQlpZiAoISh0b192cF9kZXZpY2UodmRldikt
PnBjaV9kZXYtPnBpbikpCj4gPiArCS8qIElzIHRoZXJlIGFuIGludGVycnVwdD8gSWYgbm90IGdp
dmUgdXAuICovCj4gPiArCWlmICghKHRvX3ZwX2RldmljZSh2ZGV2KS0+cGNpX2Rldi0+aXJxKSkK
PiA+ICAJCXJldHVybiBlcnI7Cj4gPiAgCS8qIEZpbmFsbHkgZmFsbCBiYWNrIHRvIHJlZ3VsYXIg
aW50ZXJydXB0cy4gKi8KPiA+ICAJcmV0dXJuIHZwX2ZpbmRfdnFzX2ludHgodmRldiwgbnZxcywg
dnFzLCBjYWxsYmFja3MsIG5hbWVzLCBjdHgpOwo+ID4gLS0KPiA+IE1TVAo+IAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
