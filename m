Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD1FC7EE23
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 15:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1180A4213B;
	Thu,  8 Jun 2023 15:15:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1180A4213B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6PzWy/r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrhyU08uxxFG; Thu,  8 Jun 2023 15:15:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8A7F1423DC;
	Thu,  8 Jun 2023 15:15:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A7F1423DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 561B6C007A;
	Thu,  8 Jun 2023 15:15:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA00AC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 15:15:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E1E741963
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 15:15:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E1E741963
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6PzWy/r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MaAZhAr9iFik
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 15:15:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17CAC4195F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17CAC4195F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686237338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SEf73cD85E+g04wNzEVF3ahCKEdMFTjq+zIvFZg2GUU=;
 b=i6PzWy/rXgE3oRWqJeTZ9uoXY46UF/wtOpoUR3nBuTNznEmJ2c6TLA04LtWHR0Ts/9nYu8
 s5ZKyELpbFaiakZY+ImOXajXC/mWTE1LEr9JFCSoRAzH5efYAGtVru8sdOVEFZKuvjEgSg
 b7qi4KiItHhATTANPxBokrkIHgRfKxU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-qn4xS4vPPaGxwVaf77mTXg-1; Thu, 08 Jun 2023 11:15:36 -0400
X-MC-Unique: qn4xS4vPPaGxwVaf77mTXg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f7e7cfcae4so4247245e9.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 08:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686237334; x=1688829334;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SEf73cD85E+g04wNzEVF3ahCKEdMFTjq+zIvFZg2GUU=;
 b=EBn0RrqDqrsr0cQQisAzH92gGgYPMH/OCVcMMTLXDg8g5yp4aWqW7tV/9JZtxLTn8g
 mIVo2WY0bwL1G+xGe7Vfv+pHdHpykyVRTThH8JR/oacVRiySj+YiV61EtUieRlSXDIOX
 9Q4WbJeiGoXl7/MBkTsEuUvxQlRv/Ci656ADUAPjXzAg9OW1ROoCLMbgZLDrZ7M8hRhg
 224p92Mv8679WVXhAou0rnvO6HpNyqDR5G0koI+zENR4mLWPHE6YZ4KhaLkcYVyNwZ5r
 9vev4Rka4ZGmKA2bYHhKfAA4oh0GLiWdKZtWVGgvYYgMAVugtJKZFZToTCKYrbFaGHUH
 jVdA==
X-Gm-Message-State: AC+VfDyDyQPo5qgYhxDwjH0mWXYpHaQdci0QF6AgJ3IKUOilNlY3qjOH
 L79hjPRClE3w0GAF8pmUT9Uro6PL7Vr0r4tl52oJXkcwpFgKI906AoCVnAxwLk7YDV2UJdgzOX0
 MQHjoUkIC17zcEszgwiIMQUlIioXRXHDfeW5SNzspXZJyheegng==
X-Received: by 2002:a7b:cb8c:0:b0:3f6:455:de09 with SMTP id
 m12-20020a7bcb8c000000b003f60455de09mr1610365wmi.39.1686237334518; 
 Thu, 08 Jun 2023 08:15:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Y/iGnEgF8gKZIvgP/wtwMSE4Hp3FRZ6qnwf4YtDHo32D2KOSmtvEjJ137mMmgNDr1EkTsOQ==
X-Received: by 2002:a7b:cb8c:0:b0:3f6:455:de09 with SMTP id
 m12-20020a7bcb8c000000b003f60455de09mr1610345wmi.39.1686237334135; 
 Thu, 08 Jun 2023 08:15:34 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 h4-20020a1ccc04000000b003f7ec896cefsm5556492wmb.8.2023.06.08.08.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:15:33 -0700 (PDT)
Date: Thu, 8 Jun 2023 11:15:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: virtio-blk: support completion batching for the IRQ path - failure
Message-ID: <20230608111505-mutt-send-email-mst@kernel.org>
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
Z2FyZHMsCj4gU3V3YW4gS2ltCgoKb2sgc28gcmV2ZXJ0aW5nCltQQVRDSCB2MyAyLzJdIHZpcnRp
by1ibGs6IHN1cHBvcnQgY29tcGxldGlvbiBiYXRjaGluZyBmb3IgdGhlIElSUSBwYXRoCmZvciBu
b3cKCj4gPiA+Cj4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tCj4gPiA+ID4gRnJvbTogU3V3YW4gS2ltIDxzdXdhbi5raW0wMjdAZ21haWwuY29t
Pgo+ID4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSA3LCAyMDIzIDM6MjEgUE0KPiA+ID4gPiBU
bzogUm9iZXJ0cywgTWFydGluIDxtYXJ0aW4ucm9iZXJ0c0BpbnRlbC5jb20+Cj4gPiA+ID4gQ2M6
IG1zdEByZWRoYXQuY29tOyB2aXJ0dWFsaXphdGlvbiA8dmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmc+OyBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmcKPiA+ID4gPiBT
dWJqZWN0OiBSZTogdmlydGlvLWJsazogc3VwcG9ydCBjb21wbGV0aW9uIGJhdGNoaW5nIGZvciB0
aGUgSVJRIHBhdGggLSBmYWlsdXJlCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gT24g
V2VkLCBKdW4gNywgMjAyMyBhdCA2OjE04oCvUE0gUm9iZXJ0cywgTWFydGluIDxtYXJ0aW4ucm9i
ZXJ0c0BpbnRlbC5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
PiBSZTogdmlydGlvLWJsazogc3VwcG9ydCBjb21wbGV0aW9uIGJhdGNoaW5nIGZvciB0aGUgSVJR
IHBhdGggwrcgdG9ydmFsZHMvbGludXhAMDdiNjc5ZiDCtyBHaXRIdWIKPiA+ID4gPgo+ID4gPiA+
ID4KPiA+ID4gPgo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3V3YW4gS2ltIHN1d2FuLmtpbTAy
N0BnbWFpbC5jb20KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogTWljaGFlbCBTLiBUc2lya2luIG1zdEByZWRoYXQuY29tCj4gPiA+ID4KPiA+ID4gPiA+
Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IFRoaXMgY2hhbmdlIGFwcGVhcnMgdG8g
aGF2ZSBicm9rZW4gdGhpbmdz4oCmCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+
IFdlIG5vdyBzZWUgYXBwbGljYXRpb25zIGhhbmdpbmcgZHVyaW5nIGRpc2sgYWNjZXNzZXMuCj4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IGUuZy4KPiA+ID4gPgo+ID4gPiA+ID4K
PiA+ID4gPgo+ID4gPiA+ID4gbXVsdGktcG9ydCB2aXJ0aW8tYmxrIGRldmljZSBydW5uaW5nIGlu
IGgvdyAoRlBHQSkKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gSG9zdCBydW5u
aW5nIGEgc2ltcGxlIOKAmGZpb+KAmCB0ZXN0Lgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4g
PiA+ID4gPiBbZ2xvYmFsXQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiB0aHJl
YWQ9MQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBkaXJlY3Q9MQo+ID4gPiA+
Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBpb2VuZ2luZT1saWJhaW8KPiA+ID4gPgo+ID4g
PiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gbm9yYW5kb21tYXA9MQo+ID4gPiA+Cj4gPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gPiBncm91cF9yZXBvcnRpbmc9MQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4g
PiA+Cj4gPiA+ID4gPiBicz00Swo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBy
dz1yZWFkCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IGlvZGVwdGg9MTI4Cj4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IHJ1bnRpbWU9MQo+ID4gPiA+Cj4gPiA+
ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBudW1qb2JzPTQKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4g
Pgo+ID4gPiA+ID4gdGltZV9iYXNlZAo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
PiBbam9iMF0KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gZmlsZW5hbWU9L2Rl
di92ZGEKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gW2pvYjFdCj4gPiA+ID4K
PiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IGZpbGVuYW1lPS9kZXYvdmRiCj4gPiA+ID4KPiA+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IFtqb2IyXQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+
Cj4gPiA+ID4gPiBmaWxlbmFtZT0vZGV2L3ZkYwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4g
PiA+ID4gPiAuLi4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gW2pvYjE1XQo+
ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBmaWxlbmFtZT0vZGV2L3ZkcAo+ID4g
PiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+
Cj4gPiA+ID4gPiBpLmUuIDE2IGRpc2tzOyA0IHF1ZXVlcyBwZXIgZGlzazsgc2ltcGxlIGJ1cnN0
IG9mIDRLQiByZWFkcwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBUaGlzIGlz
IHJlcGVhdGVkbHkgcnVuIGluIGEgbG9vcC4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4g
PiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gQWZ0ZXIgYSBmZXcsIG5v
cm1hbGx5IDwxMCBzZWNvbmRzLCBmaW8gaGFuZ3MuCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiA+IFdpdGggNjQgcXVldWVzICgxNiBkaXNrcyksIGZhaWx1cmUgb2NjdXJzIHdpdGhp
biBhIGZldyBzZWNvbmRzOyB3aXRoIDggcXVldWVzICgyIGRpc2tzKSBpdCBtYXkgdGFrZSB+aG91
ciBiZWZvcmUgaGFuZ2luZy4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gTGFz
dCBtZXNzYWdlOgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBmaW8tMy4xOQo+
ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBTdGFydGluZyA4IHRocmVhZHMKPiA+
ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gSm9iczogMSAoZj0xKTogW18oNyksUigx
KV1bNjguMyVdW2V0YSAwM2g6MTFtOjA2c10KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4g
PiA+ID4gSSB0aGluayB0aGlzIG1lYW5zIGF0IHRoZSBlbmQgb2YgdGhlIHJ1biAxIHF1ZXVlIHdh
cyBsZWZ0IGluY29tcGxldGUuCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IOKAmGRpc2tzdGF0c+KAmSAocnVuIHdo
aWxlIGZpbyBpcyBodW5nKSBzaG93cyBubyBvdXRzdGFuZGluZyB0cmFuc2FjdGlvbnMuCj4gPiA+
ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IGUuZy4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+
ID4gPgo+ID4gPiA+ID4gJCBjYXQgL3Byb2MvZGlza3N0YXRzCj4gPiA+ID4KPiA+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4gPiA+IC4uLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAy
NTIgICAgICAgMCB2ZGEgMTg0MzE0MDA3MSAwIDE0NzQ1MTIwNTY4IDcxMjU2ODY0NSAwIDAgMCAw
IDAgMzExNzk0NyA3MTI1Njg2NDUgMCAwIDAgMCAwIDAKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4g
Pgo+ID4gPiA+ID4gMjUyICAgICAgMTYgdmRiIDE4MTYyOTE1MTEgMCAxNDUzMDMzMjA4OCA3MDQ5
MDU2MjMgMCAwIDAgMCAwIDMxMTc3MTEgNzA0OTA1NjIzIDAgMCAwIDAgMCAwCj4gPiA+ID4KPiA+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IC4uLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4g
PiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBPdGhlciBzdGF0cyAo
aW4gdGhlIGgvdywgYW5kIGFkZGVkIHRvIHRoZSB2aXJ0aW8tYmxrIGRyaXZlciAoW2FddmlydGlv
X3F1ZXVlX3JxKCksIFtiXXZpcnRibGtfaGFuZGxlX3JlcSgpLCBbY112aXJ0YmxrX3JlcXVlc3Rf
ZG9uZSgpKSBhbGwgYWdyZWUsIGFuZCBzaG93IGV2ZXJ5IHJlcXVlc3QgaGFkIGEgY29tcGxldGlv
biwgYW5kIHRoYXQgdmlydGJsa19yZXF1ZXN0X2RvbmUoKSBuZXZlciBnZXRzIGNhbGxlZC4KPiA+
ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gZS5nLgo+ID4gPiA+Cj4gPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gPiBQRj0gMCAgICAgICAgICAgICAgICAgICAgICAgICB2cT0wICAgICAg
ICAgICAxICAgICAgICAgICAyICAgICAgICAgICAzCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4K
PiA+ID4gPiA+IFthXXJlcXVlc3RfY291bnQgICAgIC0gICA4Mzk0MTY1OTAgICA4MTMxNDg5MTYg
ICAxMDU1ODYxNzkgICAgODQ5ODgxMjMKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+
ID4gW2JdY29tcGxldGlvbjFfY291bnQgLSAgIDgzOTQxNjU5MCAgIDgxMzE0ODkxNiAgIDEwNTU4
NjE3OSAgICA4NDk4ODEyMwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBbY11j
b21wbGV0aW9uMl9jb3VudCAtICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwICAg
ICAgICAgICAwCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IFBGPSAxICAgICAgICAgICAgICAgICAgICAgICAgIHZx
PTAgICAgICAgICAgIDEgICAgICAgICAgIDIgICAgICAgICAgIDMKPiA+ID4gPgo+ID4gPiA+ID4K
PiA+ID4gPgo+ID4gPiA+ID4gW2FdcmVxdWVzdF9jb3VudCAgICAgLSAgIDgyMzMzNTg4NyAgIDgx
MjUxNjE0MCAgIDEwNDU4MjY3MiAgICA3NTg1NjU0OQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+
Cj4gPiA+ID4gPiBbYl1jb21wbGV0aW9uMV9jb3VudCAtICAgODIzMzM1ODg3ICAgODEyNTE2MTQw
ICAgMTA0NTgyNjcyICAgIDc1ODU2NTQ5Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4g
PiA+IFtjXWNvbXBsZXRpb24yX2NvdW50IC0gICAgICAgICAgIDAgICAgICAgICAgIDAgICAgICAg
ICAgIDAgICAgICAgICAgIDAKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+
ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gaS5lLiB0aGUgaXNzdWUgaXMgYWZ0ZXIg
dGhlIHZpcnRpby1ibGsgZHJpdmVyLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gPiBUaGlzIGNoYW5nZSB3YXMgaW50cm9kdWNlZCBpbiBrZXJuZWwgNi4z
LjAuCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IEkgYW0gc2VlaW5nIHRoaXMg
dXNpbmcgNi4zLjMuCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IElmIEkgcnVu
IHdpdGggYW4gZWFybGllciBrZXJuZWwgKDUuMTUpLCBpdCBkb2VzIG5vdCBvY2N1ci4KPiA+ID4g
Pgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gSWYgSSBtYWtlIGEgc2ltcGxlIHBhdGNoIHRv
IHRoZSA2LjMuMyB2aXJ0aW8tYmxrIGRyaXZlciwgdG8gc2tpcCB0aGUgYmxrX21xX2FkZF90b19i
YXRjaCgpY2FsbCwgaXQgZG9lcyBub3QgZmFpbC4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+
ID4gPiA+ID4gZS5nLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBrZXJuZWwg
NS4xNSDigJMgdGhpcyBpcyBPSwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiB2
aXJ0aW9fYmxrLmMsdmlydGJsa19kb25lKCkgW2lycSBoYW5kbGVyXQo+ID4gPiA+Cj4gPiA+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgIGlmIChsaWtlbHkoIWJsa19zaG91
bGRfZmFrZV90aW1lb3V0KHJlcS0+cSkpKSB7Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgYmxrX21xX2NvbXBsZXRlX3JlcXVlc3Qo
cmVxKTsKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAgICAgICAg
ICB9Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+
Cj4gPiA+ID4KPiA+ID4gPiA+IGtlcm5lbCA2LjMuMyDigJMgdGhpcyBmYWlscwo+ID4gPiA+Cj4g
PiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiB2aXJ0aW9fYmxrLmMsdmlydGJsa19oYW5kbGVfcmVx
KCkgW2lycSBoYW5kbGVyXQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgIGlmIChsaWtlbHkoIWJsa19zaG91bGRfZmFrZV90aW1lb3V0KHJlcS0+cSkp
KSB7Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKCFibGtfbXFfY29tcGxldGVfcmVxdWVzdF9yZW1vdGUocmVxKSkgewo+ID4g
PiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKCFibGtfbXFfYWRkX3RvX2JhdGNoKHJlcSwgaW9iLCB2aXJ0YmxrX3Zicl9z
dGF0dXModmJyKSwgdmlydGJsa19jb21wbGV0ZV9iYXRjaCkpIHsKPiA+ID4gPgo+ID4gPiA+ID4K
PiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHZpcnRibGtfcmVxdWVzdF9kb25lKHJlcSk7ICAgIC8vdGhpcyBuZXZlciBnZXRzIGNhbGxl
ZC4uLiBzbyBibGtfbXFfYWRkX3RvX2JhdGNoKCkgbXVzdCBhbHdheXMgc3VjY2VlZAo+ID4gPiA+
Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIH0KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICB9Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgfQo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+
Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBJZiBJIGRvLCBrZXJuZWwgNi4zLjMg4oCTIHRo
aXMgaXMgT0sKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gdmlydGlvX2Jsay5j
LHZpcnRibGtfaGFuZGxlX3JlcSgpIFtpcnEgaGFuZGxlcl0KPiA+ID4gPgo+ID4gPiA+ID4KPiA+
ID4gPgo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICBpZiAobGlrZWx5KCFibGtfc2hvdWxkX2Zh
a2VfdGltZW91dChyZXEtPnEpKSkgewo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghYmxrX21xX2NvbXBsZXRlX3JlcXVlc3Rf
cmVtb3RlKHJlcSkpIHsKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0YmxrX3JlcXVlc3RfZG9uZShyZXEpOyAv
L2ZvcmNlIHRoaXMgaGVyZS4uLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFibGtfbXFfYWRkX3RvX2JhdGNo
KHJlcSwgaW9iLCB2aXJ0YmxrX3Zicl9zdGF0dXModmJyKSwgdmlydGJsa19jb21wbGV0ZV9iYXRj
aCkpIHsKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRibGtfcmVxdWVzdF9kb25lKHJlcSk7ICAg
IC8vdGhpcyBuZXZlciBnZXRzIGNhbGxlZC4uLiBzbyBibGtfbXFfYWRkX3RvX2JhdGNoKCkgbXVz
dCBhbHdheXMgc3VjY2VlZAo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4g
Pgo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICB9Cj4gPiA+ID4KPiA+ID4gPiA+
Cj4gPiA+ID4KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgfQo+ID4gPiA+Cj4gPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4g
PiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBQZXJoYXBzIHlvdSBtaWdodCBsaWtlIHRv
IGZpeC90ZXN0L3JldmVydCB0aGlzIGNoYW5nZeKApgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+
Cj4gPiA+ID4gPiBNYXJ0aW4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+
ID4gPgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBIaSBNYXJ0aW4sCj4gPiA+ID4KPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gVGhlcmUgYXJlIG1hbnkgY2hhbmdlcyBiZXR3ZWVuIDYuMy4wIGFuZCA2
LjMuMy4KPiA+ID4gPgo+ID4gPiA+IENvdWxkIHlvdSB0cnkgdG8gZmluZCBhIGNvbW1pdCB3aGlj
aCB0cmlnZ2VycyB0aGUgaW8gaGFuZz8KPiA+ID4gPgo+ID4gPiA+IElzIGl0IG9rIHdpdGggNi4z
LjAga2VybmVsIG9yIHdpdGggcmV2ZXJ0aW5nCj4gPiA+ID4KPiA+ID4gPiAidmlydGlvLWJsazog
c3VwcG9ydCBjb21wbGV0aW9uIGJhdGNoaW5nIGZvciB0aGUgSVJRIHBhdGgiIGNvbW1pdD8KPiA+
ID4gPgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBXZSBuZWVkIHRvIGNvbmZpcm0gd2hpY2ggY29t
bWl0IGlzIGNhdXNpbmcgdGhlIGVycm9yLgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+
IFJlZ2FyZHMsCj4gPiA+ID4KPiA+ID4gPiBTdXdhbiBLaW0KPiA+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
