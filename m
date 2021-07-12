Return-Path: <SRS0=5hAK=ME=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB834C11F67
	for <virtualization@archiver.kernel.org>; Mon, 12 Jul 2021 12:58:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F6C61106
	for <virtualization@archiver.kernel.org>; Mon, 12 Jul 2021 12:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F6C61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EA9783183;
	Mon, 12 Jul 2021 12:58:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ul9a8eH3Rr2q; Mon, 12 Jul 2021 12:58:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AF3EA83104;
	Mon, 12 Jul 2021 12:58:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90895C0010;
	Mon, 12 Jul 2021 12:58:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91509C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 12:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 735E240150
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 12:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ihXipzEOYyua
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 12:58:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E40D40132
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 12:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626094709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Wzq1eRU3t7sOn0FtJiiIKj07Ib+WKzw1VGxsqeZYHE=;
 b=cadgVkliYI8YIyIgEYroUifEoG7fveXjyTlI6wPc4wsBmIJMTL3s9pVhO8jYYAv0JeuAC1
 ak7Jr1xNWtN+6LYebrYTjfNd/Qo5i7255MAWneNs78uWj4RoRGGekFvO44V6craMwciGIi
 WYqllpFxD77+lPT+lrAlORrboCmWzb0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-93NtGY1tO_yrKgd-vCGCQA-1; Mon, 12 Jul 2021 08:58:26 -0400
X-MC-Unique: 93NtGY1tO_yrKgd-vCGCQA-1
Received: by mail-ej1-f70.google.com with SMTP id
 r10-20020a170906350ab02904f12f4a8c69so4815131eja.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 05:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=1Wzq1eRU3t7sOn0FtJiiIKj07Ib+WKzw1VGxsqeZYHE=;
 b=GNU77UzsmuZINFf1/kivAnnbCW1hF1Tm4cLpFALZcbMrA2Q3tVTCW1q7Iv/6O/d1sn
 amzsTxRsm3m1EjR7sjOXxJsx5EwPA+n7qU/exFttrlnI0U5rBcgxYdbWQO5MSGUDwRGC
 ZsiBnBFqhasKEw+P6Xsncl8ThpyHeu4SWD4elVNIbvu9Nk6ZLr/J0l3oW/rNJO0RGb4D
 BOHdqEXe/L3O+DAVTnLXddl1VEAHKet0VZY304gxHlQUywOZGdlwdjppqIX2mqxLYmPa
 2o/jk9MJxqqMuWwUpcidmp2dxsOFEDDKUQPCSU8TSTiSOQ5koAR+SKQj+t03BLNNxbHV
 Bjhg==
X-Gm-Message-State: AOAM533FAcAPE2+NrDollm3upxhCTB3/RQBIxmm0J1d8jIzd91ymGwuX
 gAcVLi8Cgo51KUJz2jMRhWRfQesTiOBPHlhz+FnRNYwveMFQXyAuRonf7EvwleCChVfV+s00uCh
 +0EN6x2ipLan6tHLH+NjG4D5w2uwGBxH30YKlxdZ9lw==
X-Received: by 2002:a50:9f8e:: with SMTP id c14mr28543868edf.283.1626094705166; 
 Mon, 12 Jul 2021 05:58:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqbwu+mcRnHI1uQvTVajxs03j+bkhUKjClyryAOcRQ1J3v5nPBRJxWtSdmvlffTNXy/QcPlw==
X-Received: by 2002:a50:9f8e:: with SMTP id c14mr28543858edf.283.1626094704948; 
 Mon, 12 Jul 2021 05:58:24 -0700 (PDT)
Received: from redhat.com ([2.55.156.48])
 by smtp.gmail.com with ESMTPSA id bm1sm6438284ejb.38.2021.07.12.05.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jul 2021 05:58:24 -0700 (PDT)
Date: Mon, 12 Jul 2021 08:58:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
Message-ID: <20210712085734-mutt-send-email-mst@kernel.org>
References: <20210423080942.2997-1-jasowang@redhat.com>
 <0e9d70b7-6c8a-4ff5-1fa9-3c4f04885bb8@redhat.com>
 <20210506041057-mutt-send-email-mst@kernel.org>
 <20210506123829.GA403858@infradead.org>
 <20210514063516-mutt-send-email-mst@kernel.org>
 <8bf22db2-97d4-9f88-8b6b-d685fd63ac8b@redhat.com>
 <20210711120627-mutt-send-email-mst@kernel.org>
 <e2b4c614-746f-e81b-bb0b-d84f0efd381f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e2b4c614-746f-e81b-bb0b-d84f0efd381f@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, xieyongji@bytedance.com,
 stefanha@redhat.com
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

T24gTW9uLCBKdWwgMTIsIDIwMjEgYXQgMTE6MDc6NDRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS83LzEyIOS4iuWNiDEyOjA4LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ
6YGTOgo+ID4gT24gRnJpLCBKdW4gMDQsIDIwMjEgYXQgMDE6Mzg6MDFQTSArMDgwMCwgSmFzb24g
V2FuZyB3cm90ZToKPiA+ID4g5ZyoIDIwMjEvNS8xNCDkuIvljYg3OjEzLCBNaWNoYWVsIFMuIFRz
aXJraW4g5YaZ6YGTOgo+ID4gPiA+IE9uIFRodSwgTWF5IDA2LCAyMDIxIGF0IDAxOjM4OjI5UE0g
KzAxMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+ID4gPiA+ID4gT24gVGh1LCBNYXkgMDYs
IDIwMjEgYXQgMDQ6MTI6MTdBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4g
PiA+ID4gPiBMZXQncyB0cnkgZm9yIGp1c3QgYSBiaXQsIHdvbid0IG1ha2UgdGhpcyB3aW5kb3cg
YW55d2F5Ogo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gSSBoYXZlIGFuIG9sZCBpZGVhLiBBZGQg
YSB3YXkgdG8gZmluZCBvdXQgdGhhdCB1bm1hcCBpcyBhIG5vcAo+ID4gPiA+ID4gPiAob3IgbW9y
ZSBleGFjdGx5IGRvZXMgbm90IHVzZSB0aGUgYWRkcmVzcy9sZW5ndGgpLgo+ID4gPiA+ID4gPiBU
aGVuIGluIHRoYXQgY2FzZSBldmVuIHdpdGggRE1BIEFQSSB3ZSBkbyBub3QgbmVlZAo+ID4gPiA+
ID4gPiB0aGUgZXh0cmEgZGF0YS4gSG1tPwo+ID4gPiA+ID4gU28gd2UgYWN0dWFsbHkgZG8gaGF2
ZSBhIGNoZWNrIGZvciB0aGF0IGZyb20gdGhlIGVhcmx5IGRheXMgb2YgdGhlIERNQQo+ID4gPiA+
ID4gQVBJLCBidXQgaXQgb25seSB3b3JrcyBhdCBjb21waWxlIHRpbWU6IENPTkZJR19ORUVEX0RN
QV9NQVBfU1RBVEUuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEJ1dCBnaXZlbiBob3cgcmFyZSBjb25m
aWdzIHdpdGhvdXQgYW4gaW9tbXUgb3Igc3dpb3RsYiBhcmUgdGhlc2UgZGF5cwo+ID4gPiA+ID4g
aXQgaGFzIHN0b3BwZWQgdG8gYmUgdmVyeSB1c2VmdWwuICBVbmZvcnR1bmF0ZWx5IGEgcnVudGlt
ZS12ZXJzaW9uIGlzCj4gPiA+ID4gPiBub3QgZW50aXJlbHkgdHJpdmlhbCwgYnV0IG1heWJlIGlm
IHdlIGFsbG93IGZvciBmYWxzZSBwb3NpdGl2ZXMgd2UKPiA+ID4gPiA+IGNvdWxkIGRvIHNvbWV0
aGluZyBsaWtlIHRoaXMKPiA+ID4gPiA+IAo+ID4gPiA+ID4gYm9vbCBkbWFfZGlyZWN0X25lZWRf
c3RhdGUoc3RydWN0IGRldmljZSAqZGV2KQo+ID4gPiA+ID4gewo+ID4gPiA+ID4gCS8qIHNvbWUg
YXJlYXMgY291bGQgbm90IGJlIGNvdmVyZWQgYnkgYW55IG1hcCBhdCBhbGwgKi8KPiA+ID4gPiA+
IAlpZiAoZGV2LT5kbWFfcmFuZ2VfbWFwKQo+ID4gPiA+ID4gCQlyZXR1cm4gZmFsc2U7Cj4gPiA+
ID4gPiAJaWYgKGZvcmNlX2RtYV91bmVuY3J5cHRlZChkZXYpKQo+ID4gPiA+ID4gCQlyZXR1cm4g
ZmFsc2U7Cj4gPiA+ID4gPiAJaWYgKGRtYV9kaXJlY3RfbmVlZF9zeW5jKGRldikpCj4gPiA+ID4g
PiAJCXJldHVybiBmYWxzZTsKPiA+ID4gPiA+IAlyZXR1cm4gKmRldi0+ZG1hX21hc2sgPT0gRE1B
X0JJVF9NQVNLKDY0KTsKPiA+ID4gPiA+IH0KPiA+ID4gPiA+IAo+ID4gPiA+ID4gYm9vbCBkbWFf
bmVlZF9zdGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gPiA+ID4gPiB7Cj4gPiA+ID4gPiAJY29u
c3Qgc3RydWN0IGRtYV9tYXBfb3BzICpvcHMgPSBnZXRfZG1hX29wcyhkZXYpOwo+ID4gPiA+ID4g
Cj4gPiA+ID4gPiAJaWYgKGRtYV9tYXBfZGlyZWN0KGRldiwgb3BzKSkKPiA+ID4gPiA+IAkJcmV0
dXJuIGRtYV9kaXJlY3RfbmVlZF9zdGF0ZShkZXYpOwo+ID4gPiA+ID4gCXJldHVybiBvcHMtPnVu
bWFwX3BhZ2UgfHwKPiA+ID4gPiA+IAkJb3BzLT5zeW5jX3NpbmdsZV9mb3JfY3B1IHx8IG9wcy0+
c3luY19zaW5nbGVfZm9yX2RldmljZTsKPiA+ID4gPiA+IH0KPiA+ID4gPiBZZWEgdGhhdCBzb3Vu
ZHMgbGlrZSBhIGdvb2QgaWRlYS4gV2Ugd2lsbCBuZWVkIHRvIGRvY3VtZW50IHRoYXQuCj4gPiA+
ID4gCj4gPiA+ID4gCj4gPiA+ID4gU29tZXRoaW5nIGxpa2U6Cj4gPiA+ID4gCj4gPiA+ID4gLyoK
PiA+ID4gPiAgICAqIGRtYV9uZWVkX3N0YXRlIC0gcmVwb3J0IHdoZXRoZXIgdW5tYXAgY2FsbHMg
dXNlIHRoZSBhZGRyZXNzIGFuZCBsZW5ndGgKPiA+ID4gPiAgICAqIEBkZXY6IGRldmljZSB0byBn
dWVyeQo+ID4gPiA+ICAgICoKPiA+ID4gPiAgICAqIFRoaXMgaXMgYSBydW50aW1lIHZlcnNpb24g
b2YgQ09ORklHX05FRURfRE1BX01BUF9TVEFURS4KPiA+ID4gPiAgICAqCj4gPiA+ID4gICAgKiBS
ZXR1cm4gdGhlIHZhbHVlIGluZGljYXRpbmcgd2hldGhlciBkbWFfdW5tYXBfKiBhbmQgZG1hX3N5
bmNfKiBjYWxscyBmb3IgdGhlIGRldmljZQo+ID4gPiA+ICAgICogdXNlIHRoZSBETUEgc3RhdGUg
cGFyYW1ldGVycyBwYXNzZWQgdG8gdGhlbS4KPiA+ID4gPiAgICAqIFRoZSBETUEgc3RhdGUgcGFy
YW1ldGVycyBhcmU6IHNjYXR0ZXIvZ2F0aGVyIGxpc3QvdGFibGUsIGFkZHJlc3MgYW5kCj4gPiA+
ID4gICAgKiBsZW5ndGguCj4gPiA+ID4gICAgKgo+ID4gPiA+ICAgICogSWYgZG1hX25lZWRfc3Rh
dGUgcmV0dXJucyBmYWxzZSB0aGVuIERNQSBzdGF0ZSBwYXJhbWV0ZXJzIGFyZQo+ID4gPiA+ICAg
ICogaWdub3JlZCBieSBhbGwgZG1hX3VubWFwXyogYW5kIGRtYV9zeW5jXyogY2FsbHMsIHNvIGl0
IGlzIHNhZmUgdG8gcGFzcyAwIGZvcgo+ID4gPiA+ICAgICogYWRkcmVzcyBhbmQgbGVuZ3RoLCBh
bmQgRE1BX1VOTUFQX1NHX1RBQkxFX0lOVkFMSUQgYW5kCj4gPiA+ID4gICAgKiBETUFfVU5NQVBf
U0dfTElTVF9JTlZBTElEIGZvciBzL2cgdGFibGUgYW5kIGxlbmd0aCByZXNwZWN0aXZlbHkuCj4g
PiA+ID4gICAgKiBJZiBkbWFfbmVlZF9zdGF0ZSByZXR1cm5zIHRydWUgdGhlbiBETUEgc3RhdGUg
bWlnaHQKPiA+ID4gPiAgICAqIGJlIHVzZWQgYW5kIHNvIHRoZSBhY3R1YWwgdmFsdWVzIGFyZSBy
ZXF1aXJlZC4KPiA+ID4gPiAgICAqLwo+ID4gPiA+IAo+ID4gPiA+IEFuZCB3ZSB3aWxsIG5lZWQg
RE1BX1VOTUFQX1NHX1RBQkxFX0lOVkFMSUQgYW5kCj4gPiA+ID4gRE1BX1VOTUFQX1NHX0xJU1Rf
SU5WQUxJRCBhcyBwb2ludGVycyB0byBhbiBlbXB0eSBnbG9iYWwgdGFibGUgYW5kIGxpc3QKPiA+
ID4gPiBmb3IgY2FsbHMgc3VjaCBhcyBkbWFfdW5tYXBfc2d0YWJsZSB0aGF0IGRlcmVmZXJlbmNl
IHBvaW50ZXJzIGJlZm9yZSBjaGVja2luZwo+ID4gPiA+IHRoZXkgYXJlIHVzZWQuCj4gPiA+ID4g
Cj4gPiA+ID4gCj4gPiA+ID4gRG9lcyB0aGlzIGxvb2sgZ29vZD8KPiA+ID4gPiAKPiA+ID4gPiBU
aGUgdGFibGUvbGVuZ3RoIHZhcmlhbnRzIGFyZSBmb3IgY29uc2lzdGVuY3ksIHZpcnRpbyBzcGVj
aWZpY2FsbHkgZG9lcwo+ID4gPiA+IG5vdCB1c2Ugcy9nIGF0IHRoZSBtb21lbnQsIGJ1dCBpdCBz
ZWVtcyBuaWNlciB0aGFuIGxlYXZpbmcKPiA+ID4gPiB1c2VycyB3b25kZXIgd2hhdCB0byBkbyBh
Ym91dCB0aGVzZS4KPiA+ID4gPiAKPiA+ID4gPiBUaG91Z2h0cz8gSmFzb24gd2FudCB0byB0cnkg
aW1wbGVtZW50aW5nPwo+ID4gPiAKPiA+ID4gSSBjYW4gYWRkIGl0IGluIG15IHRvZG8gbGlzdCBv
dGhlciBpZiBvdGhlciBwZW9wbGUgYXJlIGludGVyZXN0ZWQgaW4gdGhpcywKPiA+ID4gcGxlYXNl
IGxldCB1cyBrbm93Lgo+ID4gPiAKPiA+ID4gQnV0IHRoaXMgaXMganVzdCBhYm91dCBzYXZpbmcg
dGhlIGVmZm9ydHMgb2YgdW5tYXAgYW5kIGl0IGRvZXNuJ3QgZWxpbWluYXRlCj4gPiA+IHRoZSBu
ZWNlc3Nhcnkgb2YgdXNpbmcgcHJpdmF0ZSBtZW1vcnkgKGFkZHIsIGxlbmd0aCkgZm9yIHRoZSBt
ZXRhZGF0YSBmb3IKPiA+ID4gdmFsaWRhdGluZyB0aGUgZGV2aWNlIGlucHV0cy4KPiA+IAo+ID4g
QmVzaWRlcyB1bm1hcCwgd2h5IGRvIHdlIG5lZWQgdG8gdmFsaWRhdGUgYWRkcmVzcz8KPiAKPiAK
PiBTb3JyeSwgaXQncyBub3QgdmFsaWRhdGluZyBhY3R1YWxseSwgdGhlIGRyaXZlciBkb2Vzbid0
IGRvIGFueSB2YWxpZGF0aW9uLgo+IEFzIHRoZSBzdWJqZWN0LCB0aGUgZHJpdmVyIHdpbGwganVz
dCB1c2UgdGhlIG1ldGFkYXRhIHN0b3JlZCBpbiB0aGUKPiBkZXNjX3N0YXRlIGluc3RlYWQgb2Yg
dGhlIG9uZSBzdG9yZWQgaW4gdGhlIGRlc2NyaXB0b3IgcmluZy4KPiAKPiAKPiA+ICAgbGVuZ3Ro
IGNhbiBiZQo+ID4gdHlwaWNhbGx5IHZhbGlkYXRlZCBieSBzcGVjaWZpYyBkcml2ZXJzIC0gbm90
IGFsbCBvZiB0aGVtIGV2ZW4gdXNlIGl0IC4uCj4gPiAKPiA+ID4gQW5kIGp1c3QgdG8gY2xhcmlm
eSwgdGhlIHNsaWdodCByZWdyZXNzaW9uIHdlIHNlZSBpcyB0ZXN0aW5nIHdpdGhvdXQKPiA+ID4g
VklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIHdoaWNoIG1lYW5zIERNQSBBUEkgaXMgbm90IHVzZWQu
Cj4gPiBJIGd1ZXNzIHRoaXMgaXMgZHVlIHRvIGV4dHJhIGNhY2hlIHByZXNzdXJlPwo+IAo+IAo+
IFllcy4KPiAKPiAKPiA+IE1heWJlIGNyZWF0ZSB5ZXQgYW5vdGhlcgo+ID4gYXJyYXkganVzdCBm
b3IgRE1BIHN0YXRlIC4uLgo+IAo+IAo+IEknbSBub3Qgc3VyZSBJIGdldCB0aGlzLCB3ZSB1c2Ug
dGhpcyBiYXNpY2FsbHk6Cj4gCj4gc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgewo+IMKgwqDCoMKg
wqDCoMKgIGRtYV9hZGRyX3QgYWRkcjvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyog
QnVmZmVyIERNQSBhZGRyLiAqLwo+IMKgwqDCoMKgwqDCoMKgIHUzMiBsZW47wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBCdWZmZXIgbGVuZ3RoLiAqLwo+
IMKgwqDCoMKgwqDCoMKgIHUxNiBmbGFnczvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLyogRGVzY3JpcHRvciBmbGFncy4gKi8KPiDCoMKgwqDCoMKgwqDCoCB1MTYg
bmV4dDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBUaGUg
bmV4dCBkZXNjIHN0YXRlIGluIGEgbGlzdC4gKi8KPiB9Owo+IAo+IEV4Y2VwdCBmb3IgdGhlICJu
ZXh0IiB0aGUgcmVzdCBhcmUgYWxsIERNQSBzdGF0ZS4KPiAKPiBUaGFua3MKCgpJIGFtIHRhbGtp
bmcgYWJvdXQgdGhlIGRtYSBuZWVkIHN0YXRlIGlkZWEgd2hlcmUgd2UgaW50ZXJyb2dhdGUgdGhl
IERNQQpBUEkgdG8gZmlndXJlIG91dCB3aGV0aGVyIHVubWFwIGlzIGFjdHVhbGx5IGEgbm9wLgoK
PiAKPiA+IAo+ID4gPiBTbyBJIHdpbGwgZ28gdG8gcG9zdCBhIGZvcm1hbCB2ZXJzaW9uIG9mIHRo
aXMgc2VyaWVzIGFuZCB3ZSBjYW4gc3RhcnQgZnJvbQo+ID4gPiB0aGVyZS4KPiA+ID4gCj4gPiA+
IFRoYW5rcwo+ID4gPiAKPiA+ID4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
