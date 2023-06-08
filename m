Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962D4C7EE29
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 18:04:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E6734206D;
	Thu,  8 Jun 2023 18:04:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E6734206D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c/Xx1Pb4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ecwgsoyU9rBG; Thu,  8 Jun 2023 18:04:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D079D41FE1;
	Thu,  8 Jun 2023 18:04:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D079D41FE1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEE5CC007A;
	Thu,  8 Jun 2023 18:04:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08299C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 18:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D55D64206D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 18:04:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D55D64206D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5DB2nTHxYCmv
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 18:04:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B55B041FE1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B55B041FE1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686247481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2V4P6kTkBUFeZZcuUFI0t5gfsCSMHu4aVkHeopJwkoA=;
 b=c/Xx1Pb45+xqeqDTn8IgXNDHu40XzKOnHDSeyCjl7q2u8cz4g/r1IG+hMQCYwBHTJRftFq
 a0LNuCGUiq0uX6wo8o70l3InymY7PlEcnjmuTcE9hqDGg68R85e2ZmZA2ZU1L8Kgg9US/l
 Ww8gpswy+2ok/w+JpnKj+GSRTUxrUa4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-y2tt5MqQPligf2y45EFGpw-1; Thu, 08 Jun 2023 14:04:40 -0400
X-MC-Unique: y2tt5MqQPligf2y45EFGpw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f7ef2456dfso4047295e9.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 11:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686247477; x=1688839477;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2V4P6kTkBUFeZZcuUFI0t5gfsCSMHu4aVkHeopJwkoA=;
 b=EVc9dz0reTfmoAif1Bh1nAPGtG8yZ5Tp4sn50ScPiAE3z9j+SeEwrSFjhvF93VLNj4
 jaXKNQ1/9KKQaTi1XyNvKVLwZeYtEAc+jNK7aGVRDRtrZkhneH1s1UBY8YUzdiIZaAqb
 DZCHyKAZ2V7Z5YGuWkxnbFIb25wCzwntlpIROx/06X9oRZONZt6RYVGPPfQq4XZYITMB
 MTX2Co1rezeem7X70V5JDrb5oMei7Ays6j9IYIcoOgWvdfDt3qnoZdPnpLgTUwzQQvKh
 DSgr1HPbA7mDCUAZDQugItXShiCH+tq4r5HrrFfCnCNsjJENkSfuGDJ8sOVf64X4TqYK
 luTw==
X-Gm-Message-State: AC+VfDwdHF1mV2RxwRb9N6N4P3sB6btDuBzZEmjYfpYmrKj6MZ1icv8V
 8B5v+fqCCFiVFO2TMXgOzSYUoCxs7BybqkpXcTz8TeSuQt4bkSr2n3IcVYvXLRdqqgP3DmIO/nP
 xWGbXEtWQSFgtvzEiOljok0Y8cmUNnD+/ts9w6D0ZbQ==
X-Received: by 2002:adf:dc52:0:b0:30a:e5da:272d with SMTP id
 m18-20020adfdc52000000b0030ae5da272dmr6453801wrj.0.1686247477696; 
 Thu, 08 Jun 2023 11:04:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52cXpF8MAZAe4gFdhkA2EPvUBra7Hh9ccT9UVfyClq15kQ6yJheJv5yMU+SgarVISLR0kucg==
X-Received: by 2002:adf:dc52:0:b0:30a:e5da:272d with SMTP id
 m18-20020adfdc52000000b0030ae5da272dmr6453790wrj.0.1686247477342; 
 Thu, 08 Jun 2023 11:04:37 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 x15-20020a5d650f000000b0030adfa48e1esm2219957wru.29.2023.06.08.11.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 11:04:36 -0700 (PDT)
Date: Thu, 8 Jun 2023 14:04:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: virtio-blk: support completion batching for the IRQ path - failure
Message-ID: <20230608140341-mutt-send-email-mst@kernel.org>
References: <BN9PR11MB53545DD1516BFA0FB23F95458353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <CAFNWusa7goyDs1HaMVYDvvXT7ePfB7cAQt3EewT+t=-kKNf5eg@mail.gmail.com>
 <BN9PR11MB535433DFB3A1CFAD097C13278353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <BN9PR11MB53545EDF64FC43EF8854D0628350A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <CAFNWusbOKhZtVBRu88Ebo3=Cv9rdsX2aAf6_5hfnge=iryR3DQ@mail.gmail.com>
 <20230608104537-mutt-send-email-mst@kernel.org>
 <CAFNWusZZbFD+RLeJdno3vT6BAguq3jDB2EX8H8z5vPBE5sp54g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFNWusZZbFD+RLeJdno3vT6BAguq3jDB2EX8H8z5vPBE5sp54g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, "Roberts, Martin" <martin.roberts@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gRnJpLCBKdW4gMDksIDIwMjMgYXQgMTI6MTI6MTZBTSArMDkwMCwgU3V3YW4gS2ltIHdyb3Rl
Ogo+IE9uIFRodSwgSnVuIDgsIDIwMjMgYXQgMTE6NDbigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAx
MTowNzoyMVBNICswOTAwLCBTdXdhbiBLaW0gd3JvdGU6Cj4gPiA+IE9uIFRodSwgSnVuIDgsIDIw
MjMgYXQgNzoxNuKAr1BNIFJvYmVydHMsIE1hcnRpbiA8bWFydGluLnJvYmVydHNAaW50ZWwuY29t
PiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IFRoZSBycV9hZmZpbml0eSBjaGFuZ2UgZG9lcyBub3Qg
cmVzb2x2ZSB0aGUgaXNzdWU7IGp1c3QgcmVkdWNlcyBpdHMgb2NjdXJyZW5jZSByYXRlOyBJIGFt
IHN0aWxsIHNlZWluZyBoYW5ncyB3aXRoIGl0IHNldCB0byAyLgo+ID4gPiA+Cj4gPiA+ID4gTWFy
dGluCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gRnJvbTogUm9iZXJ0cywgTWFydGlu
Cj4gPiA+ID4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDcsIDIwMjMgMzo0NiBQTQo+ID4gPiA+IFRv
OiBTdXdhbiBLaW0gPHN1d2FuLmtpbTAyN0BnbWFpbC5jb20+Cj4gPiA+ID4gQ2M6IG1zdEByZWRo
YXQuY29tOyB2aXJ0dWFsaXphdGlvbiA8dmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmc+OyBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmcKPiA+ID4gPiBTdWJqZWN0OiBS
RTogdmlydGlvLWJsazogc3VwcG9ydCBjb21wbGV0aW9uIGJhdGNoaW5nIGZvciB0aGUgSVJRIHBh
dGggLSBmYWlsdXJlCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gSXQgaXMgdGhlIGNo
YW5nZSBpbmRpY2F0ZWQgdGhhdCBicmVha3MgaXQgLSBjaGFuZ2luZyB0aGUgSVJRIGhhbmRsaW5n
IHRvIGJhdGNoaW5nLgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4KPiA+
ID4gPgo+ID4gPiA+Cj4gPiA+ID4gRnJvbSByZXBvcnRzIHN1Y2ggYXMsCj4gPiA+ID4KPiA+ID4g
PiBbUEFUQ0ggMS8xXSBibGstbXE6IGFkZGVkIGNhc2UgZm9yIGNwdSBvZmZsaW5lIGR1cmluZyBz
ZW5kX2lwaSBpbiBycV9jb21wbGV0ZSAoa2VybmVsLm9yZykKPiA+ID4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8yMDIyMDkyOTAzMzQyOC4yNTk0OC0xLW1qMDEyMy5sZWVAc2Ftc3VuZy5j
b20vVC8KPiA+ID4gPgo+ID4gPiA+IFtSRkNdIGJsay1tcTogRG9uJ3QgSVBJIHJlcXVlc3RzIG9u
IFBSRUVNUFRfUlQgLSBQYXRjaHdvcmsgKGxpbmFyby5vcmcpCj4gPiA+IGh0dHBzOi8vcGF0Y2hl
cy5saW5hcm8ub3JnL3Byb2plY3QvbGludXgtcnQtdXNlcnMvcGF0Y2gvMjAyMDEwMjMxMTA0MDAu
YngzdXpzYjd4eTVqdHNlYUBsaW51dHJvbml4LmRlLwo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+
ID4gPiA+IEnigJltIHRoaW5raW5nIHRoZSBpc3N1ZSBoYXMgc29tZXRoaW5nIHRvIGRvIHdpdGgg
d2hpY2ggQ1BVIHRoZSBJUlEgaXMgcnVubmluZyBvbi4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiBTbywgSSBzZXQsCj4gPiA+ID4KPiA+ID4gPiAjIGVjaG8gMiA+IC9zeXMvYmxvY2sv
dmRhL3F1ZXVlL3JxX2FmZmluaXR5Cj4gPiA+ID4KPiA+ID4gPiAjIGVjaG8gMiA+IC9zeXMvYmxv
Y2svdmRiL3F1ZXVlL3JxX2FmZmluaXR5Cj4gPiA+ID4KPiA+ID4gPiDigKYKPiA+ID4gPgo+ID4g
PiA+ICMgZWNobyAyID4gL3N5cy9ibG9jay92ZHAvcXVldWUvcnFfYWZmaW5pdHkKPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gYW5kIHRoZSBzeXN0ZW0gKHJ1
bm5pbmcgMTYgZGlza3MsIDQgcXVldWVzL2Rpc2spIGhhcyBub3QgeWV0IGh1bmcgKHJ1bm5pbmcg
T0sgZm9yIHNldmVyYWwgaG91cnMp4oCmCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
TWFydGluCj4gPiA+ID4KPiA+ID4KPiA+ID4gSGkgTWFydGluLAo+ID4gPgo+ID4gPiBCb3RoIGNv
ZGVzIChvcmlnaW5hbCBjb2RlIGFuZCB5b3VyIHNpbXBsZSBwYXRoKSBleGVjdXRlCj4gPiA+IGJs
a19tcV9jb21wbGV0ZV9zZW5kX2lwaSgpCj4gPiA+IGF0IGJsa19tcV9jb21wbGV0ZV9yZXF1ZXN0
X3JlbW90ZSgpLiBTbyBtYXliZSBtaXNzaW5nIHJlcXVlc3QgY29tcGxldGlvbgo+ID4gPiBvbiBv
dGhlciB2Q1BVIGlzIG5vdCB0aGUgY2F1c2UuLi4KPiA+ID4KPiA+ID4gVGhlIGRpZmZlcmVuY2Ug
YmV0d2VlbiB0aGUgb3JpZ2luYWwgY29kZSBhbmQgeW91ciBzaW1wbGUgcGF0aCBpcyB0aGF0Cj4g
PiA+IHRoZSBvcmlnaW5hbCBjb2RlIGNhbGxzIGJsa19tcV9lbmRfcmVxdWVzdF9iYXRjaCgpIGF0
IHZpcnRibGtfZG9uZSgpCj4gPiA+IHRvIHByb2Nlc3MgcmVxdWVzdCBhdCBibG9jayBsYXllcgo+
ID4gPiBhbmQgeW91ciBjb2RlIGNhbGxzIGJsa19tcV9lbmRfcmVxdWVzdCgpIGF0IHZpcnRibGtf
ZG9uZSgpIHRvIGRvIHNhbWUgdGhpbmcuCj4gPiA+Cj4gPiA+IFRoZSBvcmlnaW5hbCBjb2RlIDoK
PiA+ID4gdmlydGJsa19oYW5kbGVfcmVxKCkgZmlyc3QgY29sbGVjdHMgYWxsIHJlcXVlc3RzIGZy
b20gdmlydHF1ZXVlIGluIHdoaWxlIGxvb3AKPiA+ID4gYW5kIHBhc3MgaXQgdG8gYmxrX21xX2Vu
ZF9yZXF1ZXN0X2JhdGNoKCkgYXQgb25jZQo+ID4gPgo+ID4gPiBZb3VyIHNpbXBsZSBwYXRoOgo+
ID4gPiB2aXJ0YmxrX2hhbmRsZV9yZXEoKSBnZXQgc2luZ2xlIHJlcXVlc3QgZnJvbSB2aXJ0cXVl
dWUgYW5kIHBhc3MgaXQgdG8KPiA+ID4gYmxrX21xX2VuZF9yZXF1ZXN0KCkgYW5kIGRvIGl0IGFn
YWluIGluIHdoaWxlIGxvb3AgdW50aWwgdGhlcmUgaW4gbm8gcmVxdWVzdAo+ID4gPiBpbiB2aXJ0
cXVldWUKPiA+ID4KPiA+ID4KPiA+ID4gSSB0aGluayB3ZSBuZWVkIHRvIGZvY3VzIG9uIHRoZSBk
aWZmZXJlbmNlIGJldHdlZW4gYmxrX21xX2VuZF9yZXF1ZXN0KCkKPiA+ID4gYW5kIGJsa19tcV9l
bmRfcmVxdWVzdF9iYXRjaCgpCj4gPiA+Cj4gPiA+IFJlZ2FyZHMsCj4gPiA+IFN1d2FuIEtpbQo+
ID4gPgo+ID4KPiA+IFllcyBidXQgbGludXggcmVsZWFzZSBpcyBpbW1pbmVudCBhbmQgcmVncmVz
c2lvbnMgYXJlIGJhZC4KPiA+IFdoYXQgZG8geW91IHN1Z2dlc3QgZm9yIG5vdz8gSWYgdGhlcmUn
cyBubyBiZXR0ZXIgaWRlYQo+ID4gSSdsbCBzZW5kIGEgcmV2ZXJ0IHBhdGNoIGFuZCB3ZSdsbCBz
ZWUgaW4gdGhlIG5leHQgbGludXggdmVyc2lvbi4KPiA+Cj4gPgo+IAo+IEl0IGlzIGJldHRlciB0
byByZXZlcnQgdGhpcyBjb21taXQuIEkgaGF2ZSBubyBnb29kIGlkZWEgdG8gZGVidWcgaXQgZm9y
IG5vdy4KPiBJIHdpbGwgdHJ5IHRvIHJlcHJvZHVjZSBpdCBpbiBteSBtYWNoaW5lLgo+IAo+IFJl
Z2FyZHMsCj4gU3V3YW4gS2ltCgoKQ2FuIHlvdSBwb3N0IGEgcmV2ZXJ0IHBsZWFzZT8gQW5kIE1h
cnRpbiBjYW4gdGVzdCBhbmQgY29uZmlybQp0aGF0IHJlc29sdmVzIHRoZSBpc3N1ZSBmb3IgaGlt
LgoKPiA+ID4KPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0KPiA+ID4gPiBGcm9tOiBTdXdhbiBLaW0gPHN1d2FuLmtpbTAyN0BnbWFpbC5jb20+
Cj4gPiA+ID4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDcsIDIwMjMgMzoyMSBQTQo+ID4gPiA+IFRv
OiBSb2JlcnRzLCBNYXJ0aW4gPG1hcnRpbi5yb2JlcnRzQGludGVsLmNvbT4KPiA+ID4gPiBDYzog
bXN0QHJlZGhhdC5jb207IHZpcnR1YWxpemF0aW9uIDx2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZz47IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZwo+ID4gPiA+IFN1
YmplY3Q6IFJlOiB2aXJ0aW8tYmxrOiBzdXBwb3J0IGNvbXBsZXRpb24gYmF0Y2hpbmcgZm9yIHRo
ZSBJUlEgcGF0aCAtIGZhaWx1cmUKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBPbiBX
ZWQsIEp1biA3LCAyMDIzIGF0IDY6MTTigK9QTSBSb2JlcnRzLCBNYXJ0aW4gPG1hcnRpbi5yb2Jl
cnRzQGludGVsLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+
IFJlOiB2aXJ0aW8tYmxrOiBzdXBwb3J0IGNvbXBsZXRpb24gYmF0Y2hpbmcgZm9yIHRoZSBJUlEg
cGF0aCDCtyB0b3J2YWxkcy9saW51eEAwN2I2NzlmIMK3IEdpdEh1Ygo+ID4gPiA+Cj4gPiA+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdXdhbiBLaW0gc3V3YW4ua2ltMDI3
QGdtYWlsLmNvbQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gbXN0QHJlZGhhdC5jb20KPiA+ID4gPgo+ID4gPiA+ID4K
PiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+
ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gVGhpcyBjaGFuZ2UgYXBwZWFycyB0byBo
YXZlIGJyb2tlbiB0aGluZ3PigKYKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4g
V2Ugbm93IHNlZSBhcHBsaWNhdGlvbnMgaGFuZ2luZyBkdXJpbmcgZGlzayBhY2Nlc3Nlcy4KPiA+
ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gZS5nLgo+ID4gPiA+Cj4gPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gPiBtdWx0aS1wb3J0IHZpcnRpby1ibGsgZGV2aWNlIHJ1bm5pbmcgaW4g
aC93IChGUEdBKQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBIb3N0IHJ1bm5p
bmcgYSBzaW1wbGUg4oCYZmlv4oCYIHRlc3QuCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+
ID4gPiA+IFtnbG9iYWxdCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IHRocmVh
ZD0xCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IGRpcmVjdD0xCj4gPiA+ID4K
PiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IGlvZW5naW5lPWxpYmFpbwo+ID4gPiA+Cj4gPiA+
ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBub3JhbmRvbW1hcD0xCj4gPiA+ID4KPiA+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4gPiA+IGdyb3VwX3JlcG9ydGluZz0xCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+
ID4KPiA+ID4gPiA+IGJzPTRLCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IHJ3
PXJlYWQKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gaW9kZXB0aD0xMjgKPiA+
ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gcnVudGltZT0xCj4gPiA+ID4KPiA+ID4g
PiA+Cj4gPiA+ID4KPiA+ID4gPiA+IG51bWpvYnM9NAo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+
Cj4gPiA+ID4gPiB0aW1lX2Jhc2VkCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+
IFtqb2IwXQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBmaWxlbmFtZT0vZGV2
L3ZkYQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBbam9iMV0KPiA+ID4gPgo+
ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gZmlsZW5hbWU9L2Rldi92ZGIKPiA+ID4gPgo+ID4g
PiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gW2pvYjJdCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiA+IGZpbGVuYW1lPS9kZXYvdmRjCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+
ID4gPiA+IC4uLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBbam9iMTVdCj4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IGZpbGVuYW1lPS9kZXYvdmRwCj4gPiA+
ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiA+IGkuZS4gMTYgZGlza3M7IDQgcXVldWVzIHBlciBkaXNrOyBzaW1wbGUgYnVyc3Qg
b2YgNEtCIHJlYWRzCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IFRoaXMgaXMg
cmVwZWF0ZWRseSBydW4gaW4gYSBsb29wLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+
ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBBZnRlciBhIGZldywgbm9y
bWFsbHkgPDEwIHNlY29uZHMsIGZpbyBoYW5ncy4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+
ID4gPiA+ID4gV2l0aCA2NCBxdWV1ZXMgKDE2IGRpc2tzKSwgZmFpbHVyZSBvY2N1cnMgd2l0aGlu
IGEgZmV3IHNlY29uZHM7IHdpdGggOCBxdWV1ZXMgKDIgZGlza3MpIGl0IG1heSB0YWtlIH5ob3Vy
IGJlZm9yZSBoYW5naW5nLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBMYXN0
IG1lc3NhZ2U6Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IGZpby0zLjE5Cj4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IFN0YXJ0aW5nIDggdGhyZWFkcwo+ID4g
PiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBKb2JzOiAxIChmPTEpOiBbXyg3KSxSKDEp
XVs2OC4zJV1bZXRhIDAzaDoxMW06MDZzXQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+
ID4gPiBJIHRoaW5rIHRoaXMgbWVhbnMgYXQgdGhlIGVuZCBvZiB0aGUgcnVuIDEgcXVldWUgd2Fz
IGxlZnQgaW5jb21wbGV0ZS4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+
ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4g4oCYZGlza3N0YXRz4oCZIChydW4gd2hp
bGUgZmlvIGlzIGh1bmcpIHNob3dzIG5vIG91dHN0YW5kaW5nIHRyYW5zYWN0aW9ucy4KPiA+ID4g
Pgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gZS5nLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4g
PiA+Cj4gPiA+ID4gPiAkIGNhdCAvcHJvYy9kaXNrc3RhdHMKPiA+ID4gPgo+ID4gPiA+ID4KPiA+
ID4gPgo+ID4gPiA+ID4gLi4uCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IDI1
MiAgICAgICAwIHZkYSAxODQzMTQwMDcxIDAgMTQ3NDUxMjA1NjggNzEyNTY4NjQ1IDAgMCAwIDAg
MCAzMTE3OTQ3IDcxMjU2ODY0NSAwIDAgMCAwIDAgMAo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+
Cj4gPiA+ID4gPiAyNTIgICAgICAxNiB2ZGIgMTgxNjI5MTUxMSAwIDE0NTMwMzMyMDg4IDcwNDkw
NTYyMyAwIDAgMCAwIDAgMzExNzcxMSA3MDQ5MDU2MjMgMCAwIDAgMCAwIDAKPiA+ID4gPgo+ID4g
PiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gLi4uCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IE90aGVyIHN0YXRzIChp
biB0aGUgaC93LCBhbmQgYWRkZWQgdG8gdGhlIHZpcnRpby1ibGsgZHJpdmVyIChbYV12aXJ0aW9f
cXVldWVfcnEoKSwgW2JddmlydGJsa19oYW5kbGVfcmVxKCksIFtjXXZpcnRibGtfcmVxdWVzdF9k
b25lKCkpIGFsbCBhZ3JlZSwgYW5kIHNob3cgZXZlcnkgcmVxdWVzdCBoYWQgYSBjb21wbGV0aW9u
LCBhbmQgdGhhdCB2aXJ0YmxrX3JlcXVlc3RfZG9uZSgpIG5ldmVyIGdldHMgY2FsbGVkLgo+ID4g
PiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBlLmcuCj4gPiA+ID4KPiA+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4gPiA+IFBGPSAwICAgICAgICAgICAgICAgICAgICAgICAgIHZxPTAgICAgICAg
ICAgIDEgICAgICAgICAgIDIgICAgICAgICAgIDMKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+
ID4gPiA+ID4gW2FdcmVxdWVzdF9jb3VudCAgICAgLSAgIDgzOTQxNjU5MCAgIDgxMzE0ODkxNiAg
IDEwNTU4NjE3OSAgICA4NDk4ODEyMwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
PiBbYl1jb21wbGV0aW9uMV9jb3VudCAtICAgODM5NDE2NTkwICAgODEzMTQ4OTE2ICAgMTA1NTg2
MTc5ICAgIDg0OTg4MTIzCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IFtjXWNv
bXBsZXRpb24yX2NvdW50IC0gICAgICAgICAgIDAgICAgICAgICAgIDAgICAgICAgICAgIDAgICAg
ICAgICAgIDAKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4g
PiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gUEY9IDEgICAgICAgICAgICAgICAgICAgICAgICAgdnE9
MCAgICAgICAgICAgMSAgICAgICAgICAgMiAgICAgICAgICAgMwo+ID4gPiA+Cj4gPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gPiBbYV1yZXF1ZXN0X2NvdW50ICAgICAtICAgODIzMzM1ODg3ICAgODEy
NTE2MTQwICAgMTA0NTgyNjcyICAgIDc1ODU2NTQ5Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiA+IFtiXWNvbXBsZXRpb24xX2NvdW50IC0gICA4MjMzMzU4ODcgICA4MTI1MTYxNDAg
ICAxMDQ1ODI2NzIgICAgNzU4NTY1NDkKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+
ID4gW2NdY29tcGxldGlvbjJfY291bnQgLSAgICAgICAgICAgMCAgICAgICAgICAgMCAgICAgICAg
ICAgMCAgICAgICAgICAgMAo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4g
PiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBpLmUuIHRoZSBpc3N1ZSBpcyBhZnRlciB0
aGUgdmlydGlvLWJsayBkcml2ZXIuCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+
Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4gPiA+IFRoaXMgY2hhbmdlIHdhcyBpbnRyb2R1Y2VkIGluIGtlcm5lbCA2LjMu
MC4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gSSBhbSBzZWVpbmcgdGhpcyB1
c2luZyA2LjMuMy4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gSWYgSSBydW4g
d2l0aCBhbiBlYXJsaWVyIGtlcm5lbCAoNS4xNSksIGl0IGRvZXMgbm90IG9jY3VyLgo+ID4gPiA+
Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBJZiBJIG1ha2UgYSBzaW1wbGUgcGF0Y2ggdG8g
dGhlIDYuMy4zIHZpcnRpby1ibGsgZHJpdmVyLCB0byBza2lwIHRoZSBibGtfbXFfYWRkX3RvX2Jh
dGNoKCljYWxsLCBpdCBkb2VzIG5vdCBmYWlsLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4g
PiA+ID4gPiBlLmcuCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IGtlcm5lbCA1
LjE1IOKAkyB0aGlzIGlzIE9LCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IHZp
cnRpb19ibGsuYyx2aXJ0YmxrX2RvbmUoKSBbaXJxIGhhbmRsZXJdCj4gPiA+ID4KPiA+ID4gPiA+
Cj4gPiA+ID4KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgaWYgKGxpa2VseSghYmxrX3Nob3Vs
ZF9mYWtlX3RpbWVvdXQocmVxLT5xKSkpIHsKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICBibGtfbXFfY29tcGxldGVfcmVxdWVzdChy
ZXEpOwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAg
IH0KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4K
PiA+ID4gPgo+ID4gPiA+ID4ga2VybmVsIDYuMy4zIOKAkyB0aGlzIGZhaWxzCj4gPiA+ID4KPiA+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IHZpcnRpb19ibGsuYyx2aXJ0YmxrX2hhbmRsZV9yZXEo
KSBbaXJxIGhhbmRsZXJdCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgaWYgKGxpa2VseSghYmxrX3Nob3VsZF9mYWtlX3RpbWVvdXQocmVxLT5xKSkp
IHsKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICBpZiAoIWJsa19tcV9jb21wbGV0ZV9yZXF1ZXN0X3JlbW90ZShyZXEpKSB7Cj4gPiA+
ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpZiAoIWJsa19tcV9hZGRfdG9fYmF0Y2gocmVxLCBpb2IsIHZpcnRibGtfdmJyX3N0
YXR1cyh2YnIpLCB2aXJ0YmxrX2NvbXBsZXRlX2JhdGNoKSkgewo+ID4gPiA+Cj4gPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdmlydGJsa19yZXF1ZXN0X2RvbmUocmVxKTsgICAgLy90aGlzIG5ldmVyIGdldHMgY2FsbGVk
Li4uIHNvIGJsa19tcV9hZGRfdG9fYmF0Y2goKSBtdXN0IGFsd2F5cyBzdWNjZWVkCj4gPiA+ID4K
PiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIH0KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICB9Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IElmIEkgZG8sIGtlcm5lbCA2LjMuMyDigJMgdGhp
cyBpcyBPSwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiB2aXJ0aW9fYmxrLmMs
dmlydGJsa19oYW5kbGVfcmVxKCkgW2lycSBoYW5kbGVyXQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4g
PiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgIGlmIChsaWtlbHkoIWJsa19zaG91bGRfZmFr
ZV90aW1lb3V0KHJlcS0+cSkpKSB7Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFibGtfbXFfY29tcGxldGVfcmVxdWVzdF9y
ZW1vdGUocmVxKSkgewo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRibGtfcmVxdWVzdF9kb25lKHJlcSk7IC8v
Zm9yY2UgdGhpcyBoZXJlLi4uCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWJsa19tcV9hZGRfdG9fYmF0Y2go
cmVxLCBpb2IsIHZpcnRibGtfdmJyX3N0YXR1cyh2YnIpLCB2aXJ0YmxrX2NvbXBsZXRlX2JhdGNo
KSkgewo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydGJsa19yZXF1ZXN0X2RvbmUocmVxKTsgICAg
Ly90aGlzIG5ldmVyIGdldHMgY2FsbGVkLi4uIHNvIGJsa19tcV9hZGRfdG9fYmF0Y2goKSBtdXN0
IGFsd2F5cyBzdWNjZWVkCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+
Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiA+ID4gPgo+ID4gPiA+ID4K
PiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICB9Cj4gPiA+ID4KPiA+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+
ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IFBlcmhhcHMgeW91IG1pZ2h0IGxpa2UgdG8g
Zml4L3Rlc3QvcmV2ZXJ0IHRoaXMgY2hhbmdl4oCmCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiA+IE1hcnRpbgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4g
PiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IEhpIE1hcnRpbiwKPiA+ID4gPgo+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4gPiBUaGVyZSBhcmUgbWFueSBjaGFuZ2VzIGJldHdlZW4gNi4zLjAgYW5kIDYu
My4zLgo+ID4gPiA+Cj4gPiA+ID4gQ291bGQgeW91IHRyeSB0byBmaW5kIGEgY29tbWl0IHdoaWNo
IHRyaWdnZXJzIHRoZSBpbyBoYW5nPwo+ID4gPiA+Cj4gPiA+ID4gSXMgaXQgb2sgd2l0aCA2LjMu
MCBrZXJuZWwgb3Igd2l0aCByZXZlcnRpbmcKPiA+ID4gPgo+ID4gPiA+ICJ2aXJ0aW8tYmxrOiBz
dXBwb3J0IGNvbXBsZXRpb24gYmF0Y2hpbmcgZm9yIHRoZSBJUlEgcGF0aCIgY29tbWl0Pwo+ID4g
PiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFdlIG5lZWQgdG8gY29uZmlybSB3aGljaCBjb21t
aXQgaXMgY2F1c2luZyB0aGUgZXJyb3IuCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
UmVnYXJkcywKPiA+ID4gPgo+ID4gPiA+IFN1d2FuIEtpbQo+ID4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
