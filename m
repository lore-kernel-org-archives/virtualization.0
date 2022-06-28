Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2A3C43334
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 04:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 962A841496;
	Tue, 28 Jun 2022 04:59:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 962A841496
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xc6Ilp/r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kbomDJv0ICmM; Tue, 28 Jun 2022 04:59:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC8B04090F;
	Tue, 28 Jun 2022 04:59:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC8B04090F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9133EC0032;
	Tue, 28 Jun 2022 04:59:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6704C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 04:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71EC44148F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 04:59:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 71EC44148F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9axMxIr9M-HQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 04:59:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 189FE4090F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 189FE4090F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 04:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656392357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZNQqZ1BHUSITCdYmtKN1bf6mH2E51IBmEGFR1jGCIs=;
 b=Xc6Ilp/rasJ1r48Ddjjh3GKHk5fzkqgWAMI05TGQBAsYpI2hS3fcrP857uax21u93BOAQQ
 ZxZblTSAQ7E+7lzzk4FGGyq+mThJOpNi5kuv7zJZ/r88KZZyqk4fLOXu/532sAUvFTMT27
 hi7NJf9qO+y6mGJizp5y64xCowrPksk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-yWXFdF1qNQO80fYIvQNieQ-1; Tue, 28 Jun 2022 00:59:15 -0400
X-MC-Unique: yWXFdF1qNQO80fYIvQNieQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 k16-20020a7bc310000000b0038e6cf00439so6679536wmj.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 21:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rZNQqZ1BHUSITCdYmtKN1bf6mH2E51IBmEGFR1jGCIs=;
 b=lvxzEw1YqcC5iBTFtwObm3lEXZgaA4eWwkkC9Erz9O8hieqpUZg8ZfI7QBM3xh3DLU
 wDI/VLxdVHOasb5Yz64TdIJp+cjWArGUxB8lzGiZOXS0Nyvf/rlGoVOV6WWG14Q39Oud
 Ot5fN/ER++wUhnIIpa+7vsJ9guaJ4Jr6yz+B2+UHa6GS1Z63kLZOnI+aQ/vGmKORbt25
 wMsexlrTG/nzV5dlgbVY5MwX2pDyCjxHAl9ly/vdVTp+EfTTNsi28ErtbLLCYJGqNDVP
 CMhIGELST5hkJ8l6eXGk3An5C5mRO0MzIFyM4KNHLaOiCi97J74O129+zZY3yppkhLd9
 VXkw==
X-Gm-Message-State: AJIora+ZSL4yrDzB/AqeiNXYZhyMj9Mu8boEVC2EyKcGeOSjBo1yOX/y
 FWWBwnDnYnTF1M3TJfC2qBvasNtsoi5RJYkGHYC1TMziDUDbPRcpsYoX/mf4IzjzY8Kd3DRH9O2
 qTA7Nf26YuF6GpQzMZJYXPcMGez6ChnjR2rZWYhlFBQ==
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id
 k6-20020a5d6d46000000b0021b933d7950mr15613689wri.679.1656392354559; 
 Mon, 27 Jun 2022 21:59:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tyGGHEzmhFr36J5MuQpBJ//xCFRhKGBlqfoxm4YRVwOh1Ip5cEC8bLfCjZ0wmo1x6Rb/zEWA==
X-Received: by 2002:a5d:6d46:0:b0:21b:933d:7950 with SMTP id
 k6-20020a5d6d46000000b0021b933d7950mr15613676wri.679.1656392354311; 
 Mon, 27 Jun 2022 21:59:14 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 m20-20020a05600c4f5400b0039747cf8354sm16024450wmq.39.2022.06.27.21.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 21:59:13 -0700 (PDT)
Date: Tue, 28 Jun 2022 00:59:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220628005837-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211209162149-mutt-send-email-mst@kernel.org>
 <20211213054357-mutt-send-email-mst@kernel.org>
 <20211213185620-mutt-send-email-mst@kernel.org>
 <FF8BA713-6DD2-485B-9ADC-02006126BC60@holtmann.org>
 <20220114151142-mutt-send-email-mst@kernel.org>
 <20220613025539-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220613025539-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
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

T24gTW9uLCBKdW4gMTMsIDIwMjIgYXQgMDI6NTg6NTlBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+IE9uIEZyaSwgSmFuIDE0LCAyMDIyIGF0IDAzOjEyOjQ3UE0gLTA1MDAsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+IE9uIFRodSwgRGVjIDE2LCAyMDIxIGF0IDA4OjU4
OjMxUE0gKzAxMDAsIE1hcmNlbCBIb2x0bWFubiB3cm90ZToKPiA+ID4gSGkgTWljaGFlbCwKPiA+
ID4gCj4gPiA+ID4+Pj4+IERldmljZSByZW1vdmFsIGlzIGNsZWFybHkgb3V0IG9mIHZpcnRpbyBz
cGVjOiBpdCBhdHRlbXB0cyB0byByZW1vdmUKPiA+ID4gPj4+Pj4gdW51c2VkIGJ1ZmZlcnMgZnJv
bSBhIFZRIGJlZm9yZSBpbnZva2luZyBkZXZpY2UgcmVzZXQuIFRvIGZpeCwgbWFrZQo+ID4gPiA+
Pj4+PiBvcGVuL2Nsb3NlIE5PUHMgYW5kIGRvIGFsbCBjbGVhbnVwL3NldHVwIGluIHByb2JlL3Jl
bW92ZS4KPiA+ID4gPj4+PiAKPiA+ID4gPj4+PiBzbyB0aGUgdmlydGJ0X3tvcGVuLGNsb3NlfSBh
cyBOT1AgaXMgbm90IHJlYWxseSB3aGF0IGEgZHJpdmVyIGlzIHN1cHBvc2UKPiA+ID4gPj4+PiB0
byBiZSBkb2luZy4gVGhlc2UgYXJlIHRyYW5zcG9ydCBlbmFibGUvZGlzYWJsZSBjYWxsYmFja3Mg
ZnJvbSB0aGUgQlQKPiA+ID4gPj4+PiBDb3JlIHRvd2FyZHMgdGhlIGRyaXZlci4gSXQgbWFwcyB0
byBhIGRldmljZSBiZWluZyBlbmFibGVkL2Rpc2FibGVkIGJ5Cj4gPiA+ID4+Pj4gc29tZXRoaW5n
IGxpa2UgYmx1ZXRvb3RoZCBmb3IgZXhhbXBsZS4gU28gaWYgZGlzYWJsZWQsIEkgZXhwZWN0IHRo
YXQgbm8KPiA+ID4gPj4+PiByZXNvdXJjZXMvcXVldWVzIGFyZSBpbiB1c2UuCj4gPiA+ID4+Pj4g
Cj4gPiA+ID4+Pj4gTWF5YmUgSSBtaXN1bmRlcnN0YW5kIHRoZSB2aXJ0aW8gc3BlYyBpbiB0aGF0
IHJlZ2FyZCwgYnV0IEkgd291bGQgbGlrZQo+ID4gPiA+Pj4+IHRvIGtlZXAgdGhpcyBmdW5kYW1l
bnRhbCBjb25jZXB0IG9mIGEgQmx1ZXRvb3RoIGRyaXZlci4gSXQgZG9lcyB3b3JrCj4gPiA+ID4+
Pj4gd2l0aCBhbGwgb3RoZXIgdHJhbnNwb3J0cyBsaWtlIFVTQiwgU0RJTywgVUFSVCBldGMuCj4g
PiA+ID4+Pj4gCj4gPiA+ID4+Pj4+IFRoZSBjb3N0IGhlcmUgaXMgYSBzaW5nbGUgc2tiIHdhc3Rl
ZCBvbiBhbiB1bnVzZWQgYnQgZGV2aWNlIC0gd2hpY2gKPiA+ID4gPj4+Pj4gc2VlbXMgbW9kZXN0
Lgo+ID4gPiA+Pj4+IAo+ID4gPiA+Pj4+IFRoZXJlIHNob3VsZCBiZSBubyBidWZmZXIgdXNlZCBp
ZiB0aGUgZGV2aWNlIGlzIHBvd2VyZWQgb2ZmLiBXZSBhbHNvIGRvbuKAmXQKPiA+ID4gPj4+PiBo
YXZlIGFueSBVU0IgVVJCcyBpbi1mbGlnaHQgaWYgdGhlIHRyYW5zcG9ydCBpcyBub3QgYWN0aXZl
Lgo+ID4gPiA+Pj4+IAo+ID4gPiA+Pj4+PiBOQjogd2l0aCB0aGlzIGZpeCBpbiBwbGFjZSBkcml2
ZXIgc3RpbGwgc3VmZmVycyBmcm9tIGEgcmFjZSBjb25kaXRpb24gaWYKPiA+ID4gPj4+Pj4gYW4g
aW50ZXJydXB0IHRyaWdnZXJzIHdoaWxlIGRldmljZSBpcyBiZWluZyByZXNldC4gV29yayBvbiBh
IGZpeCBmb3IKPiA+ID4gPj4+Pj4gdGhhdCBpc3N1ZSBpcyBpbiBwcm9ncmVzcy4KPiA+ID4gPj4+
PiAKPiA+ID4gPj4+PiBJbiB0aGUgdmlydGJ0X2Nsb3NlKCkgY2FsbGJhY2sgd2Ugc2hvdWxkIGRl
YWN0aXZhdGUgYWxsIGludGVycnVwdHMuCj4gPiA+ID4+Pj4gCj4gPiA+ID4+Pj4gUmVnYXJkcwo+
ID4gPiA+Pj4+IAo+ID4gPiA+Pj4+IE1hcmNlbAo+ID4gPiA+Pj4gCj4gPiA+ID4+PiBTbyBNYXJj
ZWwsIGRvIEkgcmVhZCBpdCByaWdodCB0aGF0IHlvdSBhcmUgd29ya2luZyBvbiBhIGZpeAo+ID4g
PiA+Pj4gYW5kIEkgY2FuIGRyb3AgdGhpcyBwYXRjaCBmb3Igbm93Pwo+ID4gPiA+PiAKPiA+ID4g
Pj4gcGluZwo+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+IElmIEkgZG9uJ3QgaGVhciBvdGhlcndp
c2UgSSdsbCBxdWV1ZSBteSB2ZXJzaW9uIC0gaXQgbWlnaHQgbm90Cj4gPiA+ID4gYmUgaWRlYWwg
YnV0IGl0IGF0IGxlYXN0IGRvZXMgbm90IHZpb2xhdGUgdGhlIHNwZWMuCj4gPiA+ID4gV2UgY2Fu
IHdvcmsgb24gbm90IGFsbG9jYXRpbmcvZnJlZWluZyBidWZmZXJzIGxhdGVyCj4gPiA+ID4gYXMg
YXBwcm9wcmlhdGUuCj4gPiA+IAo+ID4gPiBJIGhhdmUgYSBwYXRjaCwgYnV0IGl0IGlzIG5vdCBm
dWxseSB0ZXN0ZWQgeWV0Lgo+ID4gPiAKPiA+ID4gUmVnYXJkcwo+ID4gPiAKPiA+ID4gTWFyY2Vs
Cj4gPiAKPiA+IHBpbmcKPiA+IAo+ID4gaXQncyBiZWVuIGEgbW9udGggLi4uCj4gPiAKPiA+IEkn
bSB3b3JraW5nIG9uIGNsZWFuaW5nIHVwIG1vZHVsZS9kZXZpY2UgcmVtb3ZhbCBpbiB2aXJ0aW8g
YW5kIGJ0Cj4gPiBpcyBraW5kIG9mIHN0aWNraW5nIG91dC4KPiAKPiBJIGFtIGluY2xpbmVkIHRv
IG1ha2UgdGhpcyBkcml2ZXIgZGVwZW5kIG9uIEJST0tFTiBmb3Igbm93Lgo+IEFueSBvYmplY3Rp
b25zPwoKT0sgcGF0Y2ggaW5jb21pbmcuCgo+IAo+ID4gLS0gCj4gPiBNU1QKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
