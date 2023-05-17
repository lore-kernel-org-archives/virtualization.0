Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8A9C77B7A
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 05:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FFB76FE76;
	Wed, 17 May 2023 05:27:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FFB76FE76
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AvRpNbRP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4iKrBKmzLmFt; Wed, 17 May 2023 05:26:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1E25B610F4;
	Wed, 17 May 2023 05:26:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E25B610F4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9270C0037;
	Wed, 17 May 2023 05:26:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18BD4C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E2D268425D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:26:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2D268425D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AvRpNbRP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sjR81_CF53JO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:26:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD25A84257
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD25A84257
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 05:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684301214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9CNE5/xhe/ZcCSjw10IszlffQwRB9z0u+JdH8jfmFGI=;
 b=AvRpNbRPbkUXVk6ifG3IIxfQenFUZPDZZt/X/XANIqgbXEAZcxk11YFspramYV2gLewHvy
 AvkGNBr047S1AeH4qhPrIXIEI8V1WX2ewwcdF2NPwOktzWP/cadhRkWy+F5nQm2mXdrzfv
 cUJ4gWBL5HKXTIvaB1WND9JXuRX0xMk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-TQqIGpBgMxK7Ngg5BzskQw-1; Wed, 17 May 2023 01:26:53 -0400
X-MC-Unique: TQqIGpBgMxK7Ngg5BzskQw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f14f266ac3so4369338e87.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 22:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684301211; x=1686893211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9CNE5/xhe/ZcCSjw10IszlffQwRB9z0u+JdH8jfmFGI=;
 b=N+o8gQ5jD7E/72ZEOz3Gb4pNV8LyEllybmfGpAH29XIR31B+iIRzP54QmWTcUUZASd
 7E0oIEPiQ2E2ukAWSWNWm2imSVI04GT/DZkHFTKQ+oHCE6vnHlJzCcZeiH4h9OANV3ge
 0ESm89mKvn4XdILkjcqzGdt1BKuu1Yyn2xKxaSeVQbGsAs8xBxdS6wI/bAWYb11WYFbT
 eic2fRQh5epYqJq56sRTINf+xQ0U4AgZnejYoOuoC2MTdpHFIFhZOZYVYWmJHHZUueUI
 hfg395Ra9ugpVmAOHJ3HYBcZATalLKsJc32rikmTV8ilGijxd/6M07tZU2npqIYpu+dd
 MHPg==
X-Gm-Message-State: AC+VfDxqlWDoHtUSFulAVqxErFXyemIfG/lbOPMd9/pNZ+PIexS6qfRA
 AzKfeTn2C7BH2kJEMoD9Vd5t/opX8EsfCjeVENSojGiGfXzWEguY7IpSrSwOMLzajuqGVV+P9xI
 9JyrPaKaLNGsc847qDrPvt3LGMMUTGesRphVuSLC0Q9DrLSnMOfk3Qa9J2g==
X-Received: by 2002:a05:6512:1189:b0:4f3:822d:bcf7 with SMTP id
 g9-20020a056512118900b004f3822dbcf7mr347636lfr.21.1684301211735; 
 Tue, 16 May 2023 22:26:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7srKHpO36fA4AzSj8//FEk9ztO+eS3hIOKMF2+0blCSMas3fuqOvHnEE90P8lI/QZMB6nUcpuLvwVCeQi1Xag=
X-Received: by 2002:a05:6512:1189:b0:4f3:822d:bcf7 with SMTP id
 g9-20020a056512118900b004f3822dbcf7mr347626lfr.21.1684301211422; Tue, 16 May
 2023 22:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230424225031.18947-3-shannon.nelson@amd.com>
 <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
 <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
 <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
 <dcfb15e6-a4c9-cb91-becd-a1e56e14d340@amd.com>
In-Reply-To: <dcfb15e6-a4c9-cb91-becd-a1e56e14d340@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 May 2023 13:26:40 +0800
Message-ID: <CACGkMEsNo4O0uAdO5koXgYbgQLoOWp81KNjsaZYSuQ7YzjvPbA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: drivers@pensando.io, mst@redhat.com,
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

T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMjoyNuKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IE9uIDUvMTYvMjMgMTI6NDkgQU0sIFN0ZWZhbm8g
R2FyemFyZWxsYSB3cm90ZToKPiA+IE9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0IDAxOjQxOjEyUE0g
LTA3MDAsIFNoYW5ub24gTmVsc29uIHdyb3RlOgo+ID4+IE9uIDUvOS8yMyAxOjQ2IEFNLCBTdGVm
YW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gPj4+IE9uIE1vbiwgQXByIDI0LCAyMDIzIGF0IDAzOjUw
OjMwUE0gLTA3MDAsIFNoYW5ub24gTmVsc29uIHZpYQo+ID4+PiBWaXJ0dWFsaXphdGlvbiB3cm90
ZToKPiA+Pj4+IFVzZSB0aGUgcmlnaHQgc3RydWN0cyBmb3IgUEFDS0VEIG9yIHNwbGl0IHZxcyB3
aGVuIHNldHRpbmcgYW5kCj4gPj4+PiBnZXR0aW5nIHRoZSB2cmluZyBiYXNlLgo+ID4+Pj4KPiA+
Pj4+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29t
Pgo+ID4+Pj4gLS0tCj4gPj4+PiBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAxOCArKysrKysrKysr
KysrLS0tLS0KPiA+Pj4+IGRyaXZlcnMvdmhvc3Qvdmhvc3QuaCB8ICA4ICsrKysrKy0tCj4gPj4+
PiAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4gPj4+
Pgo+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhv
c3Qvdmhvc3QuYwo+ID4+Pj4gaW5kZXggZjExYmRiZTRjMmM1Li5mNjRlZmRhNDhmMjEgMTAwNjQ0
Cj4gPj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+Pj4+ICsrKyBiL2RyaXZlcnMv
dmhvc3Qvdmhvc3QuYwo+ID4+Pj4gQEAgLTE2MzMsMTcgKzE2MzMsMjUgQEAgbG9uZyB2aG9zdF92
cmluZ19pb2N0bChzdHJ1Y3Qgdmhvc3RfZGV2Cj4gPj4+PiAqZCwgdW5zaWduZWQgaW50IGlvY3Rs
LCB2b2lkIF9fdXNlciAqYXJnCj4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAgciA9IC1FRkFV
TFQ7Cj4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4+PiAgICAgICAgICAg
ICAgIH0KPiA+Pj4+IC0gICAgICAgICAgICAgIGlmIChzLm51bSA+IDB4ZmZmZikgewo+ID4+Pj4g
LSAgICAgICAgICAgICAgICAgICAgICByID0gLUVJTlZBTDsKPiA+Pj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7Cj4gPj4+PiArICAgICAgICAgICAgICBpZiAodmhvc3RfaGFzX2ZlYXR1
cmUodnEsIFZJUlRJT19GX1JJTkdfUEFDS0VEKSkgewo+ID4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICB2cS0+bGFzdF9hdmFpbF9pZHggPSBzLm51bSAmIDB4ZmZmZjsKPiA+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgdnEtPmxhc3RfdXNlZF9pZHggPSAocy5udW0gPj4gMTYpICYgMHhmZmZm
Owo+ID4+Pj4gKyAgICAgICAgICAgICAgfSBlbHNlIHsKPiA+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgaWYgKHMubnVtID4gMHhmZmZmKSB7Cj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgciA9IC1FSU5WQUw7Cj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYnJlYWs7Cj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgIH0KPiA+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgdnEtPmxhc3RfYXZhaWxfaWR4ID0gcy5udW07Cj4gPj4+PiAgICAgICAg
ICAgICAgIH0KPiA+Pj4+IC0gICAgICAgICAgICAgIHZxLT5sYXN0X2F2YWlsX2lkeCA9IHMubnVt
Owo+ID4+Pj4gICAgICAgICAgICAgICAvKiBGb3JnZXQgdGhlIGNhY2hlZCBpbmRleCB2YWx1ZS4g
Ki8KPiA+Pj4+ICAgICAgICAgICAgICAgdnEtPmF2YWlsX2lkeCA9IHZxLT5sYXN0X2F2YWlsX2lk
eDsKPiA+Pj4+ICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4+PiAgICAgICBjYXNlIFZIT1NUX0dF
VF9WUklOR19CQVNFOgo+ID4+Pj4gICAgICAgICAgICAgICBzLmluZGV4ID0gaWR4Owo+ID4+Pj4g
LSAgICAgICAgICAgICAgcy5udW0gPSB2cS0+bGFzdF9hdmFpbF9pZHg7Cj4gPj4+PiArICAgICAg
ICAgICAgICBpZiAodmhvc3RfaGFzX2ZlYXR1cmUodnEsIFZJUlRJT19GX1JJTkdfUEFDS0VEKSkK
PiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgcy5udW0gPSAodTMyKXZxLT5sYXN0X2F2YWls
X2lkeCB8Cj4gPj4+PiAoKHUzMil2cS0+bGFzdF91c2VkX2lkeCA8PCAxNik7Cj4gPj4+PiArICAg
ICAgICAgICAgICBlbHNlCj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgIHMubnVtID0gdnEt
Pmxhc3RfYXZhaWxfaWR4Owo+ID4+Pgo+ID4+PiBUaGUgY2hhbmdlcyBMR1RNLCBidXQgc2luY2Ug
d2UgYXJlIGNoYW5naW5nIHRoZSBVQVBJLCBzaG91bGQgd2UKPiA+Pj4gdXBkYXRlIHRoZSBkb2N1
bWVudGF0aW9uIG9mIFZIT1NUX1NFVF9WUklOR19CQVNFIGFuZAo+ID4+PiBWSE9TVF9HRVRfVlJJ
TkdfQkFTRSBpbiBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaD8KPiA+Pgo+ID4+IENvcnJlY3Qg
bWUgaWYgSSdtIHdyb25nLCBidXQgSSBkb24ndCB0aGluayB3ZSdyZSBjaGFuZ2luZyBhbnl0aGlu
ZyBpbgo+ID4+IHRoZSBVQVBJIGhlcmUsIGp1c3QgZml4aW5nIGNvZGUgdG8gd29yayBjb3JyZWN0
bHkgd2l0aCB3aGF0IGlzIGFscmVhZHkKPiA+PiBoYXBwZW5pbmcuCj4gPgo+ID4gSUlVQyBiZWZv
cmUgdGhpcyBwYXRjaCBWSE9TVF9HRVRfVlJJTkdfQkFTRSBhbmQgVkhPU1RfU0VUX1ZSSU5HX0JB
U0UKPiA+IG5ldmVyIHdvcmtlZCB3aXRoIHBhY2tlZCB2aXJ0cXVldWUsIHNpbmNlIHdlIHdlcmUg
b25seSBoYW5kbGluZwo+ID4gbGFzdF9hdmFpbF9pZHguIE5vdyB3ZSBhcmUgc3VwcG9ydGluZyBw
YWNrZWQgdmlydHF1ZXVlLCBoYW5kbGluZwo+ID4gaW4gdmhvc3RfdnJpbmdfc3RhdGUubnVtIGJv
dGggbGFzdF9hdmFpbF9pZHggYW5kIGxhc3RfdXNlZF9pZHggKHdpdGgKPiA+IHdyYXAgY291bnRl
cnMpLgo+ID4KPiA+IEZvciBleGFtcGxlIGZvciBWSE9TVF9HRVRfVlJJTkdfQkFTRSB3aGVyZSBp
cyBkb2N1bWVudGVkIHRoYXQgdGhlIGZpcnN0Cj4gPiAxNSBiaXRzIGFyZSBsYXN0X2F2YWlsX2lk
eCwgdGhlIDE2dGggdGhlIGF2YWlsX3dyYXBfY291bnRlciwgYW5kIHRoZQo+ID4gb3RoZXJzIGFy
ZSBsYXN0X3VzZWRfaWR4IGFuZCB1c2VkX3dyYXBfY291bnRlcj8KPiA+Cj4gPiBNYXliZSBJIG1p
c3NlZCBzb21ldGhpbmcsIGJ1dCBzaW5jZSB0aGlzIGlzIFVBUEksIElNSE8gd2Ugc2hvdWxkCj4g
PiBkb2N1bWVudCB0aGUgcGFyYW1ldGVycyBvZiBpb2N0bHMgYXQgbGVhc3QgaW4KPiA+IGluY2x1
ZGUvdWFwaS9saW51eC92aG9zdC5oLgo+Cj4gUGVyaGFwcyBKYXNvbiBhbHJlYWR5IGhhcyBzb21l
dGhpbmcgd3JpdHRlbiB1cCB0aGF0IGNvdWxkIGJlIHB1dCBpbiBoZXJlCj4gZnJvbSB3aGVuIGhl
IGZpcnN0IGFkZGVkIHRoZSB3cmFwX2NvdW50ZXIgYSBjb3VwbGUgb2YgeWVhcnMgYWdvPwoKSWYg
eW91IG1lYW50IHRoZSB2aXJ0aW8gZHJpdmVyIHN1cHBvcnQgZm9yIHBhY2tlZCwgSSB0aGluayBp
dCdzCmRpZmZlcmVudCBmcm9tIHRoZSBjb250ZXh0IHdoaWNoIGlzIHZob3N0IGhlcmUuCgpJIGFn
cmVlIHdpdGggU3RlZmFubyB0aGF0IHdlIG5lZWQgdG8gdXBkYXRlIHRoZSBjb21tZW50cyBhcm91
bmQKR0VUX1ZSSU5HX0JBU0UgYW5kIFNFVF9WUklOR19CQVNFLCB0aGVuIHdlIGFyZSBmaW5lLgoK
VGhhbmtzCgo+Cj4gc2xuCj4KPiA+Cj4gPiBUaGFua3MsCj4gPiBTdGVmYW5vCj4gPgo+ID4gLS0K
PiA+IFlvdSByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgYmVjYXVzZSB5b3UgYXJlIHN1YnNjcmliZWQg
dG8gdGhlIEdvb2dsZQo+ID4gR3JvdXBzICJQZW5zYW5kbyBEcml2ZXJzIiBncm91cC4KPiA+IFRv
IHVuc3Vic2NyaWJlIGZyb20gdGhpcyBncm91cCBhbmQgc3RvcCByZWNlaXZpbmcgZW1haWxzIGZy
b20gaXQsIHNlbmQKPiA+IGFuIGVtYWlsIHRvIGRyaXZlcnMrdW5zdWJzY3JpYmVAcGVuc2FuZG8u
aW8uCj4gPiBUbyB2aWV3IHRoaXMgZGlzY3Vzc2lvbiBvbiB0aGUgd2ViIHZpc2l0Cj4gPiBodHRw
czovL2dyb3Vwcy5nb29nbGUuY29tL2EvcGVuc2FuZG8uaW8vZC9tc2dpZC9kcml2ZXJzL3E2Y21m
aGEzNnNka2dmbHd3ZDNwcjRzdzdyZ2FqYWc0YWhnamJwZmpycjc2dzRvMmI2JTQwM3ljN3pzNXU2
NXM0Lgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
