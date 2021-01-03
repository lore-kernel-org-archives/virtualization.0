Return-Path: <SRS0=enOv=GG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86879C433E0
	for <virtualization@archiver.kernel.org>; Sun,  3 Jan 2021 12:37:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D9D208C7
	for <virtualization@archiver.kernel.org>; Sun,  3 Jan 2021 12:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D9D208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AC0EB86CD3;
	Sun,  3 Jan 2021 12:37:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DPUbfF4Aqmp3; Sun,  3 Jan 2021 12:37:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2AB1786229;
	Sun,  3 Jan 2021 12:37:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 076DAC088B;
	Sun,  3 Jan 2021 12:37:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42472C013A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Jan 2021 12:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 26A7D86378
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Jan 2021 12:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MQ7yNnNnmNfw
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Jan 2021 12:37:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5496A85D57
 for <virtualization@lists.linux-foundation.org>;
 Sun,  3 Jan 2021 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609677431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxdY5ocqcwDXMcWxyyfbMa+hKNGU2Zi10xyvQjqxw7U=;
 b=cyjjKgjFMtuyoq0z4wXIauAcGhBLIATOEAN2OxgAYyerJ+hv2rDXpqU4tLw6m2usSXi0Cb
 r9R3k/tvpvd+sm8ShvTSgEh6LsyDc7AwEGF1fW7X1XnvLZaUFtK7+Daax66OYk950QsJNj
 JIRfm0kynRjncmL3doTMed80ZmvwtvY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-AIr4g6SGPM-Yo7gqYrH4_Q-1; Sun, 03 Jan 2021 07:37:07 -0500
X-MC-Unique: AIr4g6SGPM-Yo7gqYrH4_Q-1
Received: by mail-wm1-f72.google.com with SMTP id f187so8563516wme.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jan 2021 04:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QxdY5ocqcwDXMcWxyyfbMa+hKNGU2Zi10xyvQjqxw7U=;
 b=JsF4okN6/00yvBNJ8KrNz7ZgmpIipe/jfOh/wjj5yki72p9jahiC1a0c/pFaElP/ae
 dBMSEWUml7JJV6n9G9d6lDYSH/v/topAhmbaOjWFQ6GpJp591ICvx3CPlm44wm5dTava
 zDuvp/IPRhxEET+/EnXMYvCr55RaSGlsapC5o1sgpu3J2y7m6CD8n6YmhtFJ0nWz0m+w
 ZCZum8aB7J35UbiDMFJZXklgHNiz6Ro5owuNKk3vbf7xOn4HIttY5Y4N0gXH1kz56INq
 KVCpvpgHfRl2KpRfqSYMqrVQN+vblXXNC9wupPK8+rLWD8Bby/vtoHfHL3aJrQnNa+6l
 gcHQ==
X-Gm-Message-State: AOAM531qIaw6Ms7n4sG+0gjKLaZe8Bvl4gYK2fZeDjwLb/PJS7bN+Q9j
 X6piGNWY0R6H+0PZ3c2WI6B3NmGMkSy+EbX9z8mRdUVb/DRm/n/w5FPtcyQ8k2TAUQfbAodmEr7
 v3jAjGbnff/M1s96hZAQWR99UC2KaLRkNa00hxevWmw==
X-Received: by 2002:a1c:6689:: with SMTP id a131mr22858987wmc.33.1609677426760; 
 Sun, 03 Jan 2021 04:37:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2rN+sNM5f2IdvomcUNGysJYX2pHs14Av12FmnC39k+PwITABTuPqJ7gBxvMFumZmxKXYMtg==
X-Received: by 2002:a1c:6689:: with SMTP id a131mr22858976wmc.33.1609677426627; 
 Sun, 03 Jan 2021 04:37:06 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id e16sm94661103wra.94.2021.01.03.04.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jan 2021 04:37:05 -0800 (PST)
Date: Sun, 3 Jan 2021 07:37:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 00/19] vDPA driver for virtio-pci device
Message-ID: <20210103073629-mutt-send-email-mst@kernel.org>
References: <20201204040353.21679-1-jasowang@redhat.com>
 <3a3fa2f5-d5d8-e8dd-71d1-cb81a3276658@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3a3fa2f5-d5d8-e8dd-71d1-cb81a3276658@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gVGh1LCBEZWMgMzEsIDIwMjAgYXQgMTE6NTI6MTRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEyLzQg5LiL5Y2IMTI6MDMsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBI
aSBhbGw6Cj4gPiAKPiA+IFRoaXMgc2VyaWVzIHRyaWVzIHRvIGltcGxlbWVudCBhIHZEUEEgZHJp
dmVyIGZvciB2aXJ0aW8tcGNpIGRldmljZQo+ID4gd2hpY2ggd2lsbCBicmlkZ2UgYmV0d2VlbiB2
RFBBIGJ1cyBhbmQgdmlydGlvLXBjaSBkZXZpY2UuCj4gPiAKPiA+IFRoaXMgY291bGQgYmUgdXNl
ZCBmb3IgZnV0dXJlIGZlYXR1cmUgcHJvdG90eXBpbmcgYW5kIHRlc3RpbmcuCj4gPiAKPiA+IFBs
ZWFzZSByZXZpZXcKPiA+IAo+ID4gQ2hhbmdlcyBmcm9tIFYyOgo+ID4gCj4gPiAtIGRvbid0IHRy
eSB0byB1c2UgZGV2cmVzIGZvciB2aXJ0aW8tcGNpIGNvcmUKPiA+IC0gdHdlYWsgdGhlIGNvbW1p
dCBsb2cKPiA+IC0gc3BsaXQgdGhlIHBhdGNoZXMgZnVydGhlcmx5IHRvIGVhc2UgdGhlIHJldmll
d2luZwo+ID4gCj4gPiBDaGFuZ2VzIGZyb20gVjE6Cj4gPiAKPiA+IC0gU3BsaXQgY29tbW9uIGNv
ZGVzIGZyb20gdmlyaXRvLXBjaSBhbmQgc2hhcmUgaXQgd2l0aCB2RFBBIGRyaXZlcgo+ID4gLSBV
c2UgZHluYW1pYyBpZCBpbiBvcmRlciB0byBiZSBsZXNzIGNvbmZ1c2luZyB3aXRoIHZpcnRpby1w
Y2kgZHJpdmVyCj4gPiAtIE5vIGZlYXR1cmUgd2hpdGVsaXN0LCBzdXBwb3J0aW5nIGFueSBmZWF0
dXJlcyAobXEsIGNvbmZpZyBldGMpCj4gPiAKPiA+IFRoYW5rcwo+IAo+IAo+IE1pY2hhZWwsIGFu
eSBjb21tZW50IGZvciB0aGlzIHNlcmllcz8KPiAKPiBJdCdzIG5lZWRlZCBmb3IgdGVzdGluZyBk
b29yYmVsbCBtYXBwaW5nIGFuZCBjb25maWcgaW50ZXJydXB0IHN1cHBvcnQuCj4gCj4gVGhhbmtz
CgpJIHNhdyB5b3UgZ290IHNvbWUgY29tbWVudHMgYmFjayBpbiBkZWNlbWJlciBzbyB3YXMgZXhw
ZWN0aW5nIGFub3RoZXIKdmVyc2lvbi4gSWYgeW91J2QgcmF0aGVyIEkgcmV2aWV3ZWQgdGhpcyBv
bmUsIGxldCBtZSBrbm93LgoKLS0gCk1TVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
