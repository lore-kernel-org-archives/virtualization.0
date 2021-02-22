Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3759FC433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 07:29:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D2F64EC3
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 07:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D2F64EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 308188348C;
	Mon, 22 Feb 2021 07:29:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V4A8RXUsy86Y; Mon, 22 Feb 2021 07:29:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7401383478;
	Mon, 22 Feb 2021 07:29:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F01D9C000A;
	Mon, 22 Feb 2021 07:29:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27A91C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 07:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 005B883478
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 07:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Z_e-lnmuKK1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 07:29:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A425983459
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613978957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0s4sMHD6GbS6u/vJyEHvXYgmlyz7YMmLRul3YJcd4zs=;
 b=hsOj/cE/sYm0IH7jM5R8pn4d1XCdgEqW002P371yi8dyLzEUdet/stRtleyxbRziI2Syhl
 UiMp1YR6Cprv8mdbexPgJdAGTGdZL53x2JEPyoIA7ywmsPMfpQibuynZXPJbBe204shztv
 NpkRduwURIH5SR3Ks5yW30TAhzeZMWQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-_SFCVKgDMLaTfhZ4wiQ6zw-1; Mon, 22 Feb 2021 02:29:15 -0500
X-MC-Unique: _SFCVKgDMLaTfhZ4wiQ6zw-1
Received: by mail-ej1-f69.google.com with SMTP id yh28so3699843ejb.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 23:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0s4sMHD6GbS6u/vJyEHvXYgmlyz7YMmLRul3YJcd4zs=;
 b=dMgLUWIVawPtfolrLrIZGd0LQIvXrUuZ6nlY2SQC+KxXhNh2g6+4TrPrbqJR4ljJNO
 SASb4SmUgRYhezCwaLjgy/jlMa4ykrEAvpIZPpMkzO/WM6QwXiD6O7zCvUQ90uD6Lh4y
 W/W+jTpT6vX6aNlAtKg4MpPleeo8cRrgfuJ7x77FhxqTNsAu3Gw2WViylzaNRE/Qnxsf
 xZoWyBRUCrS2S/rKKOIUf4sdqRaPDyhQTqdfwg4Telp+rRppVx1u8Rnya+SPzsxqamsI
 9lDwz0I/J8FDBjBmaUw8iIegrKGEVPfTzDf1STgbB/0EIDsmEbX83ip07cF9lG6Ty5X8
 WbHA==
X-Gm-Message-State: AOAM531MGsDtg82nmKLHjrvRq+nZjqVwfKb8SnMxweJiB2oZX4Ex/hSv
 ip/oQhMW67gTieXyhAXkvTTrQ+5L37Ney9Tj9UphJc5RwwpLEKUS/noiYsy7GfcHxP85LP1c5Iv
 PCRTJMdxpuwvd0agj4TtVRYVAxrgGOn4xBRucBMzTDg==
X-Received: by 2002:a17:906:1613:: with SMTP id
 m19mr19976798ejd.344.1613978954361; 
 Sun, 21 Feb 2021 23:29:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfM0dRzz9C2jb+fvVq1S2GC9IwCom3WEozaNsTcncE9JSQrHy/5uaT8Ak1rak1OAJuroVkag==
X-Received: by 2002:a17:906:1613:: with SMTP id
 m19mr19976790ejd.344.1613978954254; 
 Sun, 21 Feb 2021 23:29:14 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id r1sm10881273eds.70.2021.02.21.23.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Feb 2021 23:29:13 -0800 (PST)
Date: Mon, 22 Feb 2021 02:29:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
Message-ID: <20210222022550-mutt-send-email-mst@kernel.org>
References: <20210219084509.48269-1-jasowang@redhat.com>
 <4b2378d8-0061-c6ed-f377-492649869581@roeck-us.net>
 <2cf598ee-38cf-3c1c-33a9-1890e892a8e6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2cf598ee-38cf-3c1c-33a9-1890e892a8e6@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
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

T24gTW9uLCBGZWIgMjIsIDIwMjEgYXQgMTE6NDI6NDRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvMTkgMTE6Mzgg5LiL5Y2ILCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+
ID4gT24gMi8xOS8yMSAxMjo0NSBBTSwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gV2UgdXNlZCB0
byBwcm9tcHQgQ09ORklHX1ZJUlRJT19QQ0lfTU9ERVJOIHRvIHVzZXIgd2hpY2ggbWF5IGJyaW5n
IGEKPiA+ID4gbG90IG9mIGNvbmZ1c2lvbi4gRS5nIGl0IG1heSBicmVhayB2YXJpb3VzIGRlZmF1
bHQgY29uZmlncyB3aGljaCB3YW50Cj4gPiA+IHZpcnRpbyBkZXZpY2VzLgo+ID4gPiAKPiA+ID4g
U28gdGhpcyBwYXRjaCBmaXhlcyB0aGlzIGJ5IGhpZGUgdGhlIHByb21wb3QgYW5kIGRvY3VtZW50
IHRoZQo+ID4gLi4uIGJ5IGhpZGluZyB0aGUgcHJvbXB0IGFuZCBkb2N1bWVudGluZyAuLi4KPiAK
PiAKPiBIaSBNaWNoYWVsOgo+IAo+IFdvdWxkIHlvdSBsaWtlIG1lIHRvIHBvc3QgYSBuZXcgdmVy
c2lvbiBvciB5b3UgY2FuIGZpeCB0aG9zZSB0eXBvcyB3aGVuCj4gYXBwbHlpbmcgdGhlIHBhdGNo
Pwo+IAo+IFRoYW5rcwoKCkEgbmV3IHZlcnNpb24uIEhvd2V2ZXIgSSBoYXZlIGEgc3VnZ2VzdGlv
bi4KCkhvdyBhYm91dCB3ZSBjYWxsIHRoZSBuZXcgbGlicmFyeSBWSVJUSU9fUENJX0xJQj8gVGhh
dCB3b3VsZCBiZQphIG5ldyBhdXRvLXNlbGVjdGVkIHN5bWJvbC4KCldlIGNhbiB0aGVuIGtlZXAg
VklSVElPX1BDSSBhcyBhIHN5bWJvbCBlbmFibGluZyB0aGUgYWN0dWFsIGRyaXZlci4KCgoKPiAK
PiA+IAo+ID4gPiBkZXBlbmRlbmN5Lgo+ID4gPiAKPiA+ID4gQ2M6IEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+Cj4gPiA+IENjOiBBbmRlcnMgUm94ZWxsIDxhbmRlcnMucm94ZWxsQGxpbmFy
by5vcmc+Cj4gPiA+IENjOiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+Cj4gPiA+
IFJlcG9ydGVkLWJ5OiBOYXJlc2ggS2FtYm9qdSA8bmFyZXNoLmthbWJvanVAbGluYXJvLm9yZz4K
PiA+ID4gRml4ZXM6IDg2Yjg3YzlkODU4YjYgKCJ2aXJ0aW8tcGNpOiBpbnRyb2R1Y2UgbW9kZXJu
IGRldmljZSBtb2R1bGUiKQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgo+ID4gUmV2aWV3ZWQtYnk6IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNr
LXVzLm5ldD4KPiA+IAo+ID4gPiAtLS0KPiA+ID4gICBkcml2ZXJzL3ZpcnRpby9LY29uZmlnIHwg
OSArKysrKy0tLS0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQo+ID4gPiAKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL0tjb25m
aWcgYi9kcml2ZXJzL3ZpcnRpby9LY29uZmlnCj4gPiA+IGluZGV4IDZiOWI4MWY0YjhjMi4uYmU3
ZGYzNjliYzJiIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby9LY29uZmlnCj4gPiA+
ICsrKyBiL2RyaXZlcnMvdmlydGlvL0tjb25maWcKPiA+ID4gQEAgLTEzLDEyICsxMywxMiBAQCBj
b25maWcgQVJDSF9IQVNfUkVTVFJJQ1RFRF9WSVJUSU9fTUVNT1JZX0FDQ0VTUwo+ID4gPiAgIAkg
IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STQo+ID4gPiAgIGNvbmZpZyBWSVJUSU9fUENJX01PREVS
Tgo+ID4gPiAtCXRyaXN0YXRlICJNb2Rlcm4gVmlydGlvIFBDSSBEZXZpY2UiCj4gPiA+IC0JZGVw
ZW5kcyBvbiBQQ0kKPiA+ID4gKwl0cmlzdGF0ZQo+ID4gPiAgIAloZWxwCj4gPiA+ICAgCSAgTW9k
ZXJuIFBDSSBkZXZpY2UgaW1wbGVtZW50YXRpb24uIFRoaXMgbW9kdWxlIGltcGxlbWVudHMgdGhl
Cj4gPiA+ICAgCSAgYmFzaWMgcHJvYmUgYW5kIGNvbnRyb2wgZm9yIGRldmljZXMgd2hpY2ggYXJl
IGJhc2VkIG9uIG1vZGVybgo+ID4gPiAtCSAgUENJIGRldmljZSB3aXRoIHBvc3NpYmxlIHZlbmRv
ciBzcGVjaWZpYyBleHRlbnNpb25zLgo+ID4gPiArCSAgUENJIGRldmljZSB3aXRoIHBvc3NpYmxl
IHZlbmRvciBzcGVjaWZpYyBleHRlbnNpb25zLiBBbnkKPiA+ID4gKwkgIG1vZHVsZSB0aGF0IHNl
bGVjdHMgdGhpcyBtb2R1bGUgbXVzdCBkZXBlbmQgb24gUENJLgo+ID4gPiAgIG1lbnVjb25maWcg
VklSVElPX01FTlUKPiA+ID4gICAJYm9vbCAiVmlydGlvIGRyaXZlcnMiCj4gPiA+IEBAIC0yOCw3
ICsyOCw4IEBAIGlmIFZJUlRJT19NRU5VCj4gPiA+ICAgY29uZmlnIFZJUlRJT19QQ0kKPiA+ID4g
ICAJdHJpc3RhdGUgIlBDSSBkcml2ZXIgZm9yIHZpcnRpbyBkZXZpY2VzIgo+ID4gPiAtCWRlcGVu
ZHMgb24gVklSVElPX1BDSV9NT0RFUk4KPiA+ID4gKwlkZXBlbmRzIG9uIFBDSQo+ID4gPiArCXNl
bGVjdCBWSVJUSU9fUENJX01PREVSTgo+ID4gPiAgIAlzZWxlY3QgVklSVElPCj4gPiA+ICAgCWhl
bHAKPiA+ID4gICAJICBUaGlzIGRyaXZlciBwcm92aWRlcyBzdXBwb3J0IGZvciB2aXJ0aW8gYmFz
ZWQgcGFyYXZpcnR1YWwgZGV2aWNlCj4gPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
