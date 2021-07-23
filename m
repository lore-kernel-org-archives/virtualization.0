Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748ABC4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 08:59:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2965760EBD
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 08:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2965760EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E743F60651;
	Fri, 23 Jul 2021 08:59:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i28a_gscZw4G; Fri, 23 Jul 2021 08:59:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 80ECF60644;
	Fri, 23 Jul 2021 08:59:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53896C001A;
	Fri, 23 Jul 2021 08:59:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CD2EC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 08:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9B68405E9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 08:59:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id txQyMmUz8WC2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 08:59:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D075B405E0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627030755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPpbmegWd4hW8oGoCH0zxiYH3Ihofs3j3hvG+YRAI1Q=;
 b=QDcmmCHouPQOYfxUMTiE09qul3EesIgLDtZx9Htmzd27IEoUCWssCMRVNO9kEs1mFGIe1z
 PQ+BpLGeMvVsM/Fq9hV6HxoL50OtYjXEDLRDgK5QhYPN/HXDl3zgV4Fi8VuhsVjwxxu9tT
 NbFQwEatiMXUBg/Tz0r3cJdJWVwULXY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-c3_CnIa-PCCZhBmtEec2lQ-1; Fri, 23 Jul 2021 04:59:13 -0400
X-MC-Unique: c3_CnIa-PCCZhBmtEec2lQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 d12-20020a50fe8c0000b02903a4b519b413so394741edt.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 01:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GPpbmegWd4hW8oGoCH0zxiYH3Ihofs3j3hvG+YRAI1Q=;
 b=mv9Ozg6JeAmr92oKnL4PFV8pfXYqwJ0G54bBnLdeahW5PoPT1P+IE7VdD7oPOdNCmU
 0hIZbnLn3XlUuwKQ4Gz/gzTV+MRFz0o9tFx8br2qiCO7V6Zwkn0hKAhlfbHcSHxaQF3p
 nc5h7hH0b19Wg59I8s8PwewXrcVovNYssY4jNyswzRVZhn+ryZE2W/ka5z6qfP/VvQm9
 UIz8XIA9S/2ruqehmguUmWcFUFBdWEebPdZrrPMlNMQUUZUOdOHdd4wrpUgr7Alsgp9G
 4X8354iWv/uBvPoiUqIh/wjagGVefj9hWsH86VeMh67fsKPql7UzsNIfGJfVjVc5HEXj
 WpIA==
X-Gm-Message-State: AOAM531xkQoq8Pp07F6aFwijrjeERUYyypTTPOXLvspB1nj7iJlcfs/v
 WKQ9svoUOiEz2pNtlJEg1Iybv9in4HoOcJxzEBSNGt13vCqqTVKJ5HTnpsbMFiqFL4LqMJc/7rN
 jEoa61Z3SoEVZrJjIBxWti77yyrk7fEOUpczQNODIlg==
X-Received: by 2002:a17:906:6d0e:: with SMTP id
 m14mr3773465ejr.551.1627030752547; 
 Fri, 23 Jul 2021 01:59:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7Jvgy4RoyJMck8Rd65u2LLhs0XrpvvGfMazrCIaiIt+jH4h/YIcg30BekZ4Eve1uw48tZ8Q==
X-Received: by 2002:a17:906:6d0e:: with SMTP id
 m14mr3773453ejr.551.1627030752419; 
 Fri, 23 Jul 2021 01:59:12 -0700 (PDT)
Received: from redhat.com ([2.55.16.196])
 by smtp.gmail.com with ESMTPSA id e17sm10444720ejz.83.2021.07.23.01.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 01:59:11 -0700 (PDT)
Date: Fri, 23 Jul 2021 04:59:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ivan <ivan@prestigetransportation.com>
Subject: Re: PROBLEM: virtio_net LRO kernel panics
Message-ID: <20210723045838-mutt-send-email-mst@kernel.org>
References: <CACFia2dwacaVVYD+1uG=CDGaJqdCOSBvZ5FcXp04caecaWAY3w@mail.gmail.com>
 <CAMDZJNXthLpAPHn62gA1qSmfLOoDFcFGdgnNwW6yA+wjn0FjgQ@mail.gmail.com>
 <CACFia2fDZHUZB5wJ7LK8M2sv_+W58rHw0NzzrwPPoX9=s7yPdQ@mail.gmail.com>
 <9547a9e5-738c-2009-a2af-66173d305c2d@redhat.com>
 <CACFia2eLCJuy=w1r20691s_cSYkBkPaY-Dbd-9CkrcpSAe7z6g@mail.gmail.com>
 <5fd9c67f-d900-7694-f0a8-62682c8a14c8@redhat.com>
 <CACFia2eH3eCZxtt70LB5zoPbhLXRv=crPh5oOhR=6mY3auDdQA@mail.gmail.com>
 <20210723035713-mutt-send-email-mst@kernel.org>
 <CACFia2fYQG4Y3_ffym06C1HGrOiOS38YWxuoUu4HYorwS9qOjA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACFia2fYQG4Y3_ffym06C1HGrOiOS38YWxuoUu4HYorwS9qOjA@mail.gmail.com>
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

T24gRnJpLCBKdWwgMjMsIDIwMjEgYXQgMDM6MzE6MDJBTSAtMDUwMCwgSXZhbiB3cm90ZToKPiBP
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
cyA0LjE5LCBhbmQgSSBuZXZlciBoYWQgc3VjaCBhIHByb2JsZW0uwqAgQnV0IG5vdyB0aGF0IEkK
PiA+ID4gdHJpZWQgdXBncmFkaW5nIHRvIGtlcm5lbHMgNS4xMCBvciA1LjEzIC0tIHRoZSBwYW5p
Y3Mgc3RhcnRlZC7CoCBUaGVzZQo+ID4gPiBhcmUganVzdCBnZW5lcmljIGtlcm5lbCBidWlsZHMs
IGFuZCBhIG1pbmltYWxpc3RpYyB1c2Vyc3BhY2UuCj4gPgo+ID4gSSB3b3VsZCBiZSB1c2VmdWwg
dG8gc2VlIHRoZSBmZWF0dXJlcyB5b3VyIHZpcnR1YWxib3ggaW5zdGFuY2UgcHJvdmlkZXMKPiA+
Cj4gPiBjYXQgL3N5cy9jbGFzcy9uZXQvZXRoMC9kZXZpY2UvZmVhdHVyZXMKPiA+Cj4gPiByZXBs
YWNpbmcgZXRoMCB3aXRoIGRldmljZSBuYW1lIGFzIGFwcHJvcHJpYXRlCj4gCj4gIyBncmVwIC4g
L3N5cy9jbGFzcy9uZXQvZXRoMC9kZXZpY2UvKiAyPi9kZXYvbnVsbAo+IC9zeXMvY2xhc3MvbmV0
L2V0aDAvZGV2aWNlL2RldmljZToweDAwMDEKPiAvc3lzL2NsYXNzL25ldC9ldGgwL2RldmljZS8K
PiBmZWF0dXJlczoxMTAwMDEwMTEwMTExMDExMTExMTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwCj4gL3N5cy9jbGFzcy9uZXQvZXRoMC9kZXZpY2UvbW9kYWxpYXM6
dmlydGlvOmQwMDAwMDAwMXYwMDAwMUFGNAo+IC9zeXMvY2xhc3MvbmV0L2V0aDAvZGV2aWNlL3N0
YXR1czoweDAwMDAwMDA3Cj4gL3N5cy9jbGFzcy9uZXQvZXRoMC9kZXZpY2UvdWV2ZW50OkRSSVZF
Uj12aXJ0aW9fbmV0Cj4gL3N5cy9jbGFzcy9uZXQvZXRoMC9kZXZpY2UvdWV2ZW50Ok1PREFMSUFT
PXZpcnRpbzpkMDAwMDAwMDF2MDAwMDFBRjQKPiAvc3lzL2NsYXNzL25ldC9ldGgwL2RldmljZS92
ZW5kb3I6MHgxYWY0Cj4gCj4gIyBsc3BjaSAtdnYgLW5uCj4gMDA6MDMuMCBFdGhlcm5ldCBjb250
cm9sbGVyIFswMjAwXTogUmVkIEhhdCwgSW5jLiBWaXJ0aW8gbmV0d29yayBkZXZpY2UKPiBbMWFm
NDoxMDAwXQo+IMKgIMKgIMKgIMKgIFN1YnN5c3RlbTogUmVkIEhhdCwgSW5jLiBWaXJ0aW8gbmV0
d29yayBkZXZpY2UgWzFhZjQ6MDAwMV0KPiDCoCDCoCDCoCDCoCBDb250cm9sOiBJL08rIE1lbS0g
QnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItCj4gU3RlcHBp
bmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCj4gwqAgwqAgwqAgwqAgU3RhdHVzOiBDYXArIDY2
TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0K
PiA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCj4gwqAgwqAgwqAgwqAgTGF0ZW5jeTogNjQK
PiDCoCDCoCDCoCDCoCBJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTkKPiDCoCDCoCDC
oCDCoCBSZWdpb24gMDogSS9PIHBvcnRzIGF0IGQwMDAgW3NpemU9MzJdCj4gwqAgwqAgwqAgwqAg
Q2FwYWJpbGl0aWVzOiBbODBdIE51bGwKPiDCoCDCoCDCoCDCoCBLZXJuZWwgZHJpdmVyIGluIHVz
ZTogdmlydGlvLXBjaQo+IMKgIMKgIMKgIMKgIEtlcm5lbCBtb2R1bGVzOiB2aXJ0aW9fcGNpCj4g
CgoKRGlzYWJsaW5nIGd1ZXN0IG9mZmxvYWRzIHJlcHJvZHVjZXMgdGhlIHdhcm5pbmcsIGJ1dCBu
b3QgdGhlIGNyYXNoCmZvciBtZS4KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
